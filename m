From: Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Thu, 23 Mar 2017 09:26:24 +0000
Message-ID: <CAGCDoEGuMVnv6rA-y5XDbc6hiNWiTg6nt4e4u2dZObeY8roKXA@mail.gmail.com>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0209570627=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c56f4a6a-a17d-b9b0-311e-7100df8c7cee-otUistvHUpPR7s880joybQ@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Zachary Michaels <zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0209570627==
Content-Type: multipart/alternative; boundary=001a114102d6877cf2054b627841

--001a114102d6877cf2054b627841
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michel,

When it happens, the main thread of our gl based app is stuck on a
ioctl(RADEON_CS). I set RADEON_THREAD=3Dfalse to ease the debugging but sam=
e
thing happens if true. Other threads are only si_shader:0,1,2,3 and are
doing nothing, just waiting for jobs. I can also do sudo gdb -p $(pidof
Xorg) to block the X11 server, to make sure there is no ping pong between 2
processes. All other processes are not loading dri/radeonsi_dri.so . And
adding a few traces shows that the above ioctl call is looping for ever on
https://github.com/torvalds/linux/blob/master/drivers/gpu/
drm/ttm/ttm_bo.c#L819 and comes from mesa
https://cgit.freedesktop.org/mesa/mesa/tree/src/gallium/winsys/radeon/drm/r=
adeon_drm_cs.c#n454
.

After adding even more traces I can see that the bo, which is being
indefinitely evicted, has the flag RADEON_GEM_NO_CPU_ACCESS.
And it gets 3 potential placements after calling "radeon_evict_flags".
 1: VRAM cpu inaccessible, fpfn is 65536
 2: VRAM cpu accessible, fpfn is 0
 3: GTT, fpfn is 0

And it looks like it continuously succeeds to move on the second placement.
So I might be wrong but it looks it is not even a ping pong between VRAM
accessible / not accessible, it just keeps being blited in the CPU
accessible part of the VRAM.

Maybe radeon_evict_flags should just not add the second placement if its
current placement is already VRAM cpu accessible.
Or could be a bug in the get_node that should not succeed in that case.

Note that this happens when the VRAM is nearly full.

FWIW I noticed that amdgpu is doing something different:
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/am=
dgpu_ttm.c#L205
vs
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/radeon/radeon=
_ttm.c#L198


Finally the NMI watchdog and the kernel soft lockup and hard lockup
detectors do not detect this looping in that ioctl(RADEON_CS). Maybe
because it estimates it is doing real work. Same for radeon_lockup_timeout,
it does not detect it.

The gpu is a FirePro W600 Cape Verde 2048M.

Thx
Julien

On Thu, Mar 23, 2017 at 8:10 AM, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wr=
ote:

> On 23/03/17 03:19 AM, Zachary Michaels wrote:
> > We were experiencing an infinite loop due to VRAM bos getting added bac=
k
> > to the VRAM lru on eviction via ttm_bo_mem_force_space,
>
> Can you share more details about what happened? I can imagine that
> moving a BO from CPU visible to CPU invisible VRAM would put it back on
> the LRU, but next time around it shouldn't hit this code anymore but get
> evicted to GTT directly.
>
> Was userspace maybe performing concurrent CPU access to the BOs in
> question?
>
>
> > and reverting this commit solves the problem.
>
> I hope we can find a better solution.
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
>
>

--001a114102d6877cf2054b627841
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Michel,<div><br></div><div>When it happens, the main th=
read of our gl based app is stuck on a ioctl(RADEON_CS). I set RADEON_THREA=
D=3Dfalse to ease the debugging but same thing happens if true. Other threa=
ds are only si_shader:0,1,2,3 and are doing nothing, just waiting for jobs.=
 I can also do sudo gdb -p $(pidof Xorg) to block the X11 server, to make s=
ure there is no ping pong between 2 processes. All other processes are not =
loading dri/radeonsi_dri.so . And adding a few traces shows that the above =
ioctl call is looping for ever on <a href=3D"https://github.com/torvalds/li=
nux/blob/master/drivers/gpu/drm/ttm/ttm_bo.c#L819" target=3D"_blank">https:=
//github.com/torvalds/<wbr>linux/blob/master/drivers/gpu/<wbr>drm/ttm/ttm_b=
o.c#L819</a>=C2=A0and comes from mesa=C2=A0<a href=3D"https://cgit.freedesk=
top.org/mesa/mesa/tree/src/gallium/winsys/radeon/drm/radeon_drm_cs.c#n454">=
https://cgit.freedesktop.org/mesa/mesa/tree/src/gallium/winsys/radeon/drm/r=
adeon_drm_cs.c#n454</a> .=C2=A0</div><div><br></div><div><div style=3D"font=
-size:12.8px">After adding even more traces I can see that the bo, which is=
 being indefinitely evicted, has the flag RADEON_GEM_NO_CPU_ACCESS.</div><d=
iv style=3D"font-size:12.8px">And it gets 3 potential placements after call=
ing &quot;radeon_evict_flags&quot;.=C2=A0</div><div style=3D"font-size:12.8=
px">=C2=A01: VRAM cpu inaccessible, fpfn is=C2=A065536</div><div style=3D"f=
ont-size:12.8px">=C2=A02: VRAM cpu accessible, fpfn is 0</div><div style=3D=
"font-size:12.8px">=C2=A03: GTT, fpfn is 0</div><div style=3D"font-size:12.=
8px"><br></div><div style=3D"font-size:12.8px">And it looks like it continu=
ously succeeds to move on the second placement. So I might be wrong but it =
looks it is not even a ping pong between VRAM accessible / not accessible, =
it just keeps being blited in the CPU accessible part of the VRAM.</div><di=
v style=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8px">Mayb=
e radeon_evict_flags should just not add the second placement if its curren=
t placement is already VRAM cpu accessible.</div><div style=3D"font-size:12=
.8px">Or could be a bug in the get_node that should not succeed in that cas=
e.</div><div style=3D"font-size:12.8px"><br></div><div style=3D"font-size:1=
2.8px">Note that this happens when the VRAM is nearly full.</div><div style=
=3D"font-size:12.8px"><br></div><div><span style=3D"font-size:12.8px">FWIW =
I noticed that amdgpu is doing something different: <a href=3D"https://gith=
ub.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c#L=
205">https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ttm.c#L205</a></span></div><div><span style=3D"font-size:12.8px">=
vs</span></div><div><span style=3D"font-size:12.8px"><a href=3D"https://git=
hub.com/torvalds/linux/blob/master/drivers/gpu/drm/radeon/radeon_ttm.c#L198=
">https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/radeon/rade=
on_ttm.c#L198</a>=C2=A0</span></div><div style=3D"font-size:12.8px"><br></d=
iv><div style=3D"font-size:12.8px">Finally the NMI watchdog and the kernel =
soft lockup and hard lockup detectors do not detect this looping in that io=
ctl(RADEON_CS). Maybe because it estimates it is doing real work. Same for=
=C2=A0radeon_lockup_timeout, it does not detect it.</div></div><div><br></d=
iv><div>The gpu is a FirePro W600 Cape Verde 2048M.</div><div><br></div><di=
v>Thx</div><div>Julien</div>







<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Mar 23, 2=
017 at 8:10 AM, Michel D=C3=A4nzer <span dir=3D"ltr">&lt;<a href=3D"mailto:=
michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gma=
il-m_2929675273229796860gmail-">On 23/03/17 03:19 AM, Zachary Michaels wrot=
e:<br>
&gt; We were experiencing an infinite loop due to VRAM bos getting added ba=
ck<br>
&gt; to the VRAM lru on eviction via ttm_bo_mem_force_space,<br>
<br>
</span>Can you share more details about what happened? I can imagine that<b=
r>
moving a BO from CPU visible to CPU invisible VRAM would put it back on<br>
the LRU, but next time around it shouldn&#39;t hit this code anymore but ge=
t<br>
evicted to GTT directly.<br>
<br>
Was userspace maybe performing concurrent CPU access to the BOs in question=
?<br>
<span class=3D"gmail-m_2929675273229796860gmail-"><br>
<br>
&gt; and reverting this commit solves the problem.<br>
<br>
</span>I hope we can find a better solution.<br>
<span class=3D"gmail-m_2929675273229796860gmail-HOEnZb"><font color=3D"#888=
888"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
<br>
</font></span></blockquote></div><div><br></div><div class=3D"gmail-m_29296=
75273229796860gmail_signature"><div dir=3D"ltr"><div style=3D"color:rgb(51,=
51,51);font-family:helvetica,arial,sans-serif;font-size:12px"><div style=3D=
"color:rgb(171,171,171)"></div></div></div></div>
</div></div>

--001a114102d6877cf2054b627841--

--===============0209570627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0209570627==--
