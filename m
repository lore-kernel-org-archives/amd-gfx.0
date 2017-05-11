From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: export test ring debugfs interface
Date: Thu, 11 May 2017 10:50:17 +0800
Message-ID: <5913D169.6000304@amd.com>
References: <1494469757-25784-1-git-send-email-ray.huang@amd.com>
 <1494469757-25784-2-git-send-email-ray.huang@amd.com>
 <BN6PR12MB16521EA7A33D9718734FD83EF7ED0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <BN6PR12MB1652A074AABF32DDD7F559F7F7ED0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1457810368=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652A074AABF32DDD7F559F7F7ED0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "'amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org'" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

--===============1457810368==
Content-Type: multipart/alternative;
	boundary="------------080203060206020701010705"

--------------080203060206020701010705
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2017年05月11日 10:41, Deucher, Alexander wrote:
> > -----Original Message-----
> > From: Deucher, Alexander
> > Sent: Wednesday, May 10, 2017 10:38 PM
> > To: Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig, Christian
> > Cc: Zhou, David(ChunMing); Wang, Ken; Huan, Alvin; Huang, Ray
> > Subject: RE: [PATCH 2/2] drm/amdgpu: export test ring debugfs interface
> >
> > > -----Original Message-----
> > > From: Huang Rui [mailto:ray.huang-5C7GfCeVMHo@public.gmane.org]
> > > Sent: Wednesday, May 10, 2017 10:29 PM
> > > To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Koenig, 
> Christian
> > > Cc: Zhou, David(ChunMing); Wang, Ken; Huan, Alvin; Huang, Ray
> > > Subject: [PATCH 2/2] drm/amdgpu: export test ring debugfs interface
> > >
> > > Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> Not sure if it's important for this since it's debugfs, but we don't 
> have any sort of ring locks anymore (since everything should go 
> through the scheduler once it's started) so we could theoretically get 
> collisions if there are active apps using the GPU and you run these tests.
Yes, agree. So patch#1 for ib test should use scheduler, but which could 
be a big change and Christian doesn't like to use scheduler for ib test 
case, consider this is only for test case, the problem isn't big:).

btw: I think patch#2 isn't need if patch#1 is landed, since when you use 
this sys interface, the amdgpu driver must be loaded successfully, ring 
test is meaningless.

Regards,
David Zhou
>
> Alex
>
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44
> > > ++++++++++++++++++++++++++++--
> > >  1 file changed, 42 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index 7becf11..3637396 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -3625,14 +3625,54 @@ static int amdgpu_debugfs_test_ib(struct
> > > seq_file *m, void *data)
> > >      return 0;
> > >  }
> > >
> > > +static int amdgpu_ring_tests(struct amdgpu_device *adev)
> > > +{
> > > +   unsigned i;
> > > +   int r = 0;
> > > +
> > > +   for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> > > +           struct amdgpu_ring *ring = adev->rings[i];
> > > +
> > > +           if (!ring || !ring->ready)
> > > +                   continue;
> > > +
> > > +           r = amdgpu_ring_test_ring(ring);
> > > +           if (r) {
> > > +                   ring->ready = false;
> > > +                   DRM_ERROR("amdgpu: failed to test ring %d
> > > (%d).\n",
> > > +                             i, r);
> > > +           }
> > > +   }
> > > +
> > > +   return r;
> > > +}
> > > +
> > > +static int amdgpu_debugfs_test_ring(struct seq_file *m, void *data)
> > > +{
> > > +   struct drm_info_node *node = (struct drm_info_node *) m-
> > > >private;
> > > +   struct drm_device *dev = node->minor->dev;
> > > +   struct amdgpu_device *adev = dev->dev_private;
> > > +   int r = 0;
> > > +
> > > +   seq_printf(m, "run ring test:\n");
> > > +   r = amdgpu_ring_tests(adev);
> > > +   if (r)
> > > +           seq_printf(m, "ring tests failed (%d).\n", r);
> > > +   else
> > > +           seq_printf(m, "ring tests passed.\n");
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >  static const struct drm_info_list 
> amdgpu_debugfs_test_ib_ring_list[] = {
> > > -   {"amdgpu_test_ib", &amdgpu_debugfs_test_ib}
> > > +   {"amdgpu_test_ib", &amdgpu_debugfs_test_ib},
> > > +   {"amdgpu_test_ring", &amdgpu_debugfs_test_ring}
> > >  };
> > >
> > >  static int amdgpu_debugfs_test_ib_ring_init(struct amdgpu_device
> > *adev)
> > >  {
> > >      return amdgpu_debugfs_add_files(adev,
> > > - amdgpu_debugfs_test_ib_ring_list,
> > > 1);
> > > + amdgpu_debugfs_test_ib_ring_list,
> > > 2);
> > >  }
> > >
> > >  int amdgpu_debugfs_init(struct drm_minor *minor)
> > > --
> > > 2.7.4
>


--------------080203060206020701010705
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2017年05月11日 10:41, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote
cite="mid:BN6PR12MB1652A074AABF32DDD7F559F7F7ED0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">&gt; -----Original Message-----<br>
            &gt; From: Deucher, Alexander<br>
            &gt; Sent: Wednesday, May 10, 2017 10:38 PM<br>
            &gt; To: Huang, Ray; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Koenig,
            Christian<br>
            &gt; Cc: Zhou, David(ChunMing); Wang, Ken; Huan, Alvin;
            Huang, Ray<br>
            &gt; Subject: RE: [PATCH 2/2] drm/amdgpu: export test ring
            debugfs interface<br>
            &gt; <br>
            &gt; &gt; -----Original Message-----<br>
            &gt; &gt; From: Huang Rui [<a moz-do-not-send="true"
              href="mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">mailto:ray.huang-5C7GfCeVMHo@public.gmane.org</a>]<br>
            &gt; &gt; Sent: Wednesday, May 10, 2017 10:29 PM<br>
            &gt; &gt; To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Deucher,
            Alexander; Koenig, Christian<br>
            &gt; &gt; Cc: Zhou, David(ChunMing); Wang, Ken; Huan, Alvin;
            Huang, Ray<br>
            &gt; &gt; Subject: [PATCH 2/2] drm/amdgpu: export test ring
            debugfs interface<br>
            &gt; &gt;<br>
            &gt; &gt; Signed-off-by: Huang Rui <a class="moz-txt-link-rfc2396E" href="mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">&lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; <br>
            &gt; Reviewed-by: Alex Deucher
            <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <br>
            Not sure if it's important for this since it's debugfs, but
            we don't have any sort of ring locks anymore (since
            everything should go through the scheduler once it's
            started) so we could theoretically get collisions if there
            are active apps using the GPU and you run these tests.<br>
          </div>
        </span></font></blockquote>
    <font size="2">Yes, agree. So patch#1 for ib test should use
      scheduler, but which could be a big change and Christian doesn't
      like to use scheduler for ib test case, consider this is only for
      test case, the problem isn't big:).<br>
      <br>
      btw: I think patch#2 isn't need if patch#1 is landed, since when
      you use this sys interface, the amdgpu driver must be loaded
      successfully, ring test is meaningless.<br>
      <br>
      Regards,<br>
      David Zhou<br>
    </font>
    <blockquote
cite="mid:BN6PR12MB1652A074AABF32DDD7F559F7F7ED0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite"><font size="2"><span style="font-size:10pt;">
          <div class="PlainText">
            <br>
            Alex<br>
            <br>
            &gt; <br>
            &gt; &gt; ---<br>
            &gt; &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44<br>
            &gt; &gt; ++++++++++++++++++++++++++++--<br>
            &gt; &gt;  1 file changed, 42 insertions(+), 2 deletions(-)<br>
            &gt; &gt;<br>
            &gt; &gt; diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; &gt; index 7becf11..3637396 100644<br>
            &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; &gt; @@ -3625,14 +3625,54 @@ static int
            amdgpu_debugfs_test_ib(struct<br>
            &gt; &gt; seq_file *m, void *data)<br>
            &gt; &gt;      return 0;<br>
            &gt; &gt;  }<br>
            &gt; &gt;<br>
            &gt; &gt; +static int amdgpu_ring_tests(struct amdgpu_device
            *adev)<br>
            &gt; &gt; +{<br>
            &gt; &gt; +   unsigned i;<br>
            &gt; &gt; +   int r = 0;<br>
            &gt; &gt; +<br>
            &gt; &gt; +   for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
            &gt; &gt; +           struct amdgpu_ring *ring =
            adev-&gt;rings[i];<br>
            &gt; &gt; +<br>
            &gt; &gt; +           if (!ring || !ring-&gt;ready)<br>
            &gt; &gt; +                   continue;<br>
            &gt; &gt; +<br>
            &gt; &gt; +           r = amdgpu_ring_test_ring(ring);<br>
            &gt; &gt; +           if (r) {<br>
            &gt; &gt; +                   ring-&gt;ready = false;<br>
            &gt; &gt; +                   DRM_ERROR("amdgpu: failed to
            test ring %d<br>
            &gt; &gt; (%d).\n",<br>
            &gt; &gt; +                             i, r);<br>
            &gt; &gt; +           }<br>
            &gt; &gt; +   }<br>
            &gt; &gt; +<br>
            &gt; &gt; +   return r;<br>
            &gt; &gt; +}<br>
            &gt; &gt; +<br>
            &gt; &gt; +static int amdgpu_debugfs_test_ring(struct
            seq_file *m, void *data)<br>
            &gt; &gt; +{<br>
            &gt; &gt; +   struct drm_info_node *node = (struct
            drm_info_node *) m-<br>
            &gt; &gt; &gt;private;<br>
            &gt; &gt; +   struct drm_device *dev =
            node-&gt;minor-&gt;dev;<br>
            &gt; &gt; +   struct amdgpu_device *adev =
            dev-&gt;dev_private;<br>
            &gt; &gt; +   int r = 0;<br>
            &gt; &gt; +<br>
            &gt; &gt; +   seq_printf(m, "run ring test:\n");<br>
            &gt; &gt; +   r = amdgpu_ring_tests(adev);<br>
            &gt; &gt; +   if (r)<br>
            &gt; &gt; +           seq_printf(m, "ring tests failed
            (%d).\n", r);<br>
            &gt; &gt; +   else<br>
            &gt; &gt; +           seq_printf(m, "ring tests passed.\n");<br>
            &gt; &gt; +<br>
            &gt; &gt; +   return 0;<br>
            &gt; &gt; +}<br>
            &gt; &gt; +<br>
            &gt; &gt;  static const struct drm_info_list
            amdgpu_debugfs_test_ib_ring_list[] = {<br>
            &gt; &gt; -   {"amdgpu_test_ib",
            &amp;amdgpu_debugfs_test_ib}<br>
            &gt; &gt; +   {"amdgpu_test_ib",
            &amp;amdgpu_debugfs_test_ib},<br>
            &gt; &gt; +   {"amdgpu_test_ring",
            &amp;amdgpu_debugfs_test_ring}<br>
            &gt; &gt;  };<br>
            &gt; &gt;<br>
            &gt; &gt;  static int
            amdgpu_debugfs_test_ib_ring_init(struct amdgpu_device<br>
            &gt; *adev)<br>
            &gt; &gt;  {<br>
            &gt; &gt;      return amdgpu_debugfs_add_files(adev,<br>
            &gt; &gt; -                                  
            amdgpu_debugfs_test_ib_ring_list,<br>
            &gt; &gt; 1);<br>
            &gt; &gt; +                                  
            amdgpu_debugfs_test_ib_ring_list,<br>
            &gt; &gt; 2);<br>
            &gt; &gt;  }<br>
            &gt; &gt;<br>
            &gt; &gt;  int amdgpu_debugfs_init(struct drm_minor *minor)<br>
            &gt; &gt; --<br>
            &gt; &gt; 2.7.4<br>
            <br>
          </div>
        </span></font>
    </blockquote>
    <br>
  </body>
</html>

--------------080203060206020701010705--

--===============1457810368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1457810368==--
