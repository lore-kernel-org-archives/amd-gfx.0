From: Drew Davenport <ddavenport-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: atomic debugfs files not created
Date: Tue, 23 Jan 2018 11:05:29 -0700
Message-ID: <CAMmTTa3zYckeZO6O+=E8-d2jCZ7LN_bVaVv4bfAQWhij9vo42g@mail.gmail.com>
References: <CAMmTTa0C=7amOzgJ=QLheQVB0nX_L123UGBP4yR+AqgRErBk+Q@mail.gmail.com>
 <CADnq5_OtqdxmyJaGY3MRaAbD3phAU28xrUsCw7KWPg4u2TkHxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0447146251=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OtqdxmyJaGY3MRaAbD3phAU28xrUsCw7KWPg4u2TkHxw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0447146251==
Content-Type: multipart/alternative; boundary="94eb2c116a7a69792c0563756455"

--94eb2c116a7a69792c0563756455
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2018 at 1:45 PM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Mon, Jan 22, 2018 at 3:20 PM, Drew Davenport <ddavenport-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> wrote:
> > I was doing some debugging and found that /sys/kernel/debug/dri/0/state
> > doesn't get created for amdgpu. After a bit of digging around I found
> that
> > the DRIVER_ATOMIC feature flag gets set in dm_early_init in amdgpu_dm.c,
> > which is run after drm_debugfs_init where the atomic debugfs files would
> > have been created.
> >
> > I tried moving DRIVER_ATOMIC to the rest of the kms_driver.driver_feature
> > flags in amdgpu_drv.c, and this allowed the debugfs to get created as
> > expected. Nothing seemed terribly broken, but I didn't test thoroughly.
> >
> > Is there any reason not to move DRIVER_ATOMIC to the rest of the feature
> > flags? Thanks.
>
> It's only available with the new dc modsetting code which doesn't
> support all asics so you'd need to selectively enable it depending on
> the asic.  You'll only want to enable it if
> amdgpu_device_asic_has_dc_support() returns true.  I think I had a
> patch to do that at one point, but I don't know what I did with it.
>
> Alex
>

Right, that makes sense. It looks like this flag could be set according to
amdgpu_device_asic_has_dc_support right after the drm_device has been
allocated in amdgpu_pci_probe. Would that be a good place to set it?

Although, from looking at vi_set_ip_blocks and similar functions,
dm_ip_block currently won't get added (and thus DRIVER_ATOMIC won't be set)
if virtual display is enabled for some asics. Would it be a problem if
DRIVER_ATOMIC is set for those asics even if virtual display is enabled?

--94eb2c116a7a69792c0563756455
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div class=3D"gmail_quote"><div dir=3D"ltr">On M=
on, Jan 22, 2018 at 1:45 PM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@=
gmail.com" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Mon, Jan 22, 2018 at 3:20 PM, Drew Davenp=
ort &lt;<a href=3D"mailto:ddavenport-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" target=3D"_blank">ddavenpo=
rt-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt; I was doing some debugging and found that /sys/kernel/debug/dri/0/stat=
e<br>
&gt; doesn&#39;t get created for amdgpu. After a bit of digging around I fo=
und that<br>
&gt; the DRIVER_ATOMIC feature flag gets set in dm_early_init in amdgpu_dm.=
c,<br>
&gt; which is run after drm_debugfs_init where the atomic debugfs files wou=
ld<br>
&gt; have been created.<br>
&gt;<br>
&gt; I tried moving DRIVER_ATOMIC to the rest of the kms_driver.driver_feat=
ure<br>
&gt; flags in amdgpu_drv.c, and this allowed the debugfs to get created as<=
br>
&gt; expected. Nothing seemed terribly broken, but I didn&#39;t test thorou=
ghly.<br>
&gt;<br>
&gt; Is there any reason not to move DRIVER_ATOMIC to the rest of the featu=
re<br>
&gt; flags? Thanks.<br>
<br>
It&#39;s only available with the new dc modsetting code which doesn&#39;t<b=
r>
support all asics so you&#39;d need to selectively enable it depending on<b=
r>
the asic.=C2=A0 You&#39;ll only want to enable it if<br>
amdgpu_device_asic_has_dc_<wbr>support() returns true.=C2=A0 I think I had =
a<br>
patch to do that at one point, but I don&#39;t know what I did with it.<br>
<br>
Alex<br></blockquote><div>=C2=A0</div><div><span style=3D"color:rgb(34,34,3=
4);font-family:arial,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial;float:none;display:inline">Right,=
 that makes sense. It looks like this flag could be set according to amdgpu=
_device_asic_has_dc_</span><wbr style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;text-decoration-style:initial;text-decoration-color:initial"><span st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial;float:non=
e;display:inline">support=C2=A0right after the drm_device has been allocate=
d in=C2=A0amdgpu_pci_probe. Would that be a good place to set it?</span><di=
v style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;text-decoration-style:in=
itial;text-decoration-color:initial"><br></div><div style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-v=
ariant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;text-decoration-style:initial;text-decoration-col=
or:initial">Although, from looking at vi_set_ip_blocks and similar function=
s, dm_ip_block currently won&#39;t get added (and thus DRIVER_ATOMIC won&#3=
9;t be set) if virtual display is enabled for some asics. Would it be a pro=
blem if DRIVER_ATOMIC is set for those asics even if virtual display is ena=
bled?</div></div></div></div></div></div>

--94eb2c116a7a69792c0563756455--

--===============0447146251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0447146251==--
