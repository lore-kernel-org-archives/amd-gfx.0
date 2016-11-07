From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 1/2] dma-buf: return index of the first signaled fence (v2)
Date: Tue, 8 Nov 2016 04:12:30 +0530
Message-ID: <CAO_48GH5Xzc-+wWxpAqcE7t7yjQz7XS=U4M+E-PR_X+RFfvRew@mail.gmail.com>
References: <1478290570-30982-1-git-send-email-alexander.deucher@amd.com>
 <CAO_48GGiBXFFqxWg1fUKMVUR13QvwaH5a8eiGrOgeCbUyY0WnA@mail.gmail.com>
 <CADnq5_Nv+wgCorQ88wQ1Kc-f+nJPFzLoBMBV591zFiw-NMy3Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1012795919=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_Nv+wgCorQ88wQ1Kc-f+nJPFzLoBMBV591zFiw-NMy3Sg@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, DRI mailing list <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "monk.liu" <monk.liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============1012795919==
Content-Type: multipart/alternative; boundary=001a114ba8543ffd2f0540bdbdce

--001a114ba8543ffd2f0540bdbdce
Content-Type: text/plain; charset=UTF-8

Hi Alex,

On 07-Nov-2016 11:14 PM, "Alex Deucher" <alexdeucher@gmail.com> wrote:
>
> On Fri, Nov 4, 2016 at 6:03 PM, Sumit Semwal <sumit.semwal@linaro.org>
wrote:
> > Hi Alex,
> >
> > Thanks for the patches.
> >
> > On 4 November 2016 at 14:16, Alex Deucher <alexdeucher@gmail.com> wrote:
> >> From: "monk.liu" <monk.liu@amd.com>
> >>
> >> Return the index of the first signaled fence.  This information
> >> is useful in some APIs like Vulkan.
> >>
> >> v2: rebase on drm-next (fence -> dma_fence)
> >>
> >> Signed-off-by: monk.liu <monk.liu@amd.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> >> ---
> >>
> >> This is the same patch set I send out yesterday, I just
> >> squashed the amdgpu patches together and rebased everything on
> >> the fence -> dma_fence renaming.  This is used by our VK driver
> >> and we are planning to use it in mesa as well.
> >>
> >
> > Would you be ok if I apply this and the amdgpu patch both together via
> > drm-misc, or would you like me to notify you once I merge this for you
> > to take the amdgpu patch via your tree? I'm fine either ways, but
> > perhaps drm-misc would be a bit neater.
> >
>
> Either way works for me.  Whatever is easier for you.
>
Thanks, will take these and Christian's patches through the  drm-misc tree,
hopefully today. (returning from LPC and just landed at my home city, 4am
here, but will hope to push these today! )
> Alex

Best,
Sumit.

--001a114ba8543ffd2f0540bdbdce
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi Alex, </p>
<p dir=3D"ltr">On 07-Nov-2016 11:14 PM, &quot;Alex Deucher&quot; &lt;<a hre=
f=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Nov 4, 2016 at 6:03 PM, Sumit Semwal &lt;<a href=3D"mailto:sum=
it.semwal@linaro.org">sumit.semwal@linaro.org</a>&gt; wrote:<br>
&gt; &gt; Hi Alex,<br>
&gt; &gt;<br>
&gt; &gt; Thanks for the patches.<br>
&gt; &gt;<br>
&gt; &gt; On 4 November 2016 at 14:16, Alex Deucher &lt;<a href=3D"mailto:a=
lexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt; From: &quot;monk.liu&quot; &lt;<a href=3D"mailto:monk.liu@amd=
.com">monk.liu@amd.com</a>&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Return the index of the first signaled fence.=C2=A0 This info=
rmation<br>
&gt; &gt;&gt; is useful in some APIs like Vulkan.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; v2: rebase on drm-next (fence -&gt; dma_fence)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: monk.liu &lt;<a href=3D"mailto:monk.liu@amd.co=
m">monk.liu@amd.com</a>&gt;<br>
&gt; &gt;&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.d=
eucher@amd.com">alexander.deucher@amd.com</a>&gt;<br>
&gt; &gt;&gt; Cc: Sumit Semwal &lt;<a href=3D"mailto:sumit.semwal@linaro.or=
g">sumit.semwal@linaro.org</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This is the same patch set I send out yesterday, I just<br>
&gt; &gt;&gt; squashed the amdgpu patches together and rebased everything o=
n<br>
&gt; &gt;&gt; the fence -&gt; dma_fence renaming.=C2=A0 This is used by our=
 VK driver<br>
&gt; &gt;&gt; and we are planning to use it in mesa as well.<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Would you be ok if I apply this and the amdgpu patch both togethe=
r via<br>
&gt; &gt; drm-misc, or would you like me to notify you once I merge this fo=
r you<br>
&gt; &gt; to take the amdgpu patch via your tree? I&#39;m fine either ways,=
 but<br>
&gt; &gt; perhaps drm-misc would be a bit neater.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Either way works for me.=C2=A0 Whatever is easier for you.<br>
&gt;<br>
Thanks, will take these and Christian&#39;s patches through the=C2=A0 drm-m=
isc tree, hopefully today. (returning from LPC and just landed at my home c=
ity, 4am here, but will hope to push these today! ) <br>
&gt; Alex</p>
<p dir=3D"ltr">Best, <br>
Sumit. <br>
</p>

--001a114ba8543ffd2f0540bdbdce--

--===============1012795919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1012795919==--
