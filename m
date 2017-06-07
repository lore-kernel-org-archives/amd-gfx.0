From: axie <axie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix mec queue policy on single MEC asics
Date: Wed, 7 Jun 2017 13:23:36 -0400
Message-ID: <0c79a29e-4a87-617a-e5b2-469d0a48bfc3@amd.com>
References: <1496848229-12761-1-git-send-email-alexander.deucher@amd.com>
 <d1b73074-136d-ccb0-a026-c795362d797b@amd.com>
 <BN6PR12MB1652FFCD2FC9C923271C1475F7C80@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0535204402=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652FFCD2FC9C923271C1475F7C80-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0535204402==
Content-Type: multipart/alternative;
 boundary="------------C42AD35D3BA5B2EC7E103A16"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C42AD35D3BA5B2EC7E103A16
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

In Catalyst driver source code, Stoney is listed as supported, I don't 
know how well it is supported though. I think at least people have run 
some graphic operations.

What kind of hangs happens in Stoney? Is it a graphic operation hang? Or 
OpenCL? Or something else? How easily it is reproduced?

Stoney is similar to Carizzo. People has tried computes on Carrizo till 
Fiji in fglrx.

At least, we need to limit this change for Stoney only unless it is 
reported in other ASICs too.

This change can affect compute performance a lot. People are evaluating 
even the AMDGPU PRO OpenCL on FIJI, as far as I know.

Thanks,

Alex Bin


On 2017-06-07 12:32 PM, Deucher, Alexander wrote:
> > -----Original Message-----
> > From: Xie, AlexBin
> > Sent: Wednesday, June 07, 2017 12:31 PM
> > To: Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Cc: Deucher, Alexander
> > Subject: Re: [PATCH 1/3] drm/amdgpu: fix mec queue policy on single MEC
> > asics
> >
> > Hi Alex,
> >
> > In closed source driver, we assign compute queues to all 4 pipes always.
> > There is no hangs.
> >
> > May I know which ASIC?
>
> It was reported on Stoney.
>
> Alex
>
> >
> > Assign all queues in first pipe first mec can slow things down.
> >
> > Thanks,
> >
> > Alex Bin Xie
> >
> >
> >
> > On 2017-06-07 11:10 AM, Alex Deucher wrote:
> > > Fixes hangs on single MEC asics.
> > >
> > > Fixes: 2ed286fb434 (drm/amdgpu: new queue policy, take first 2 
> queues of
> > each pipe v2)
> > > Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 12 +++++++++---
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 +++++++++---
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 +++++++++---
> > >   3 files changed, 27 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > index 4c04e9d..862bc72 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > @@ -2825,9 +2825,15 @@ static void
> > gfx_v7_0_compute_queue_acquire(struct amdgpu_device *adev)
> > >              if (mec >= adev->gfx.mec.num_mec)
> > >                      break;
> > >
> > > -           /* policy: amdgpu owns the first two queues of the 
> first MEC
> > */
> > > -           if (mec == 0 && queue < 2)
> > > -                   set_bit(i, adev->gfx.mec.queue_bitmap);
> > > +           if (adev->gfx.mec.num_mec > 1) {
> > > +                   /* policy: amdgpu owns the first two queues of the
> > first MEC */
> > > +                   if (mec == 0 && queue < 2)
> > > +                           set_bit(i, adev->gfx.mec.queue_bitmap);
> > > +           } else {
> > > +                   /* policy: amdgpu owns all queues in the first 
> pipe */
> > > +                   if (mec == 0 && pipe == 0)
> > > +                           set_bit(i, adev->gfx.mec.queue_bitmap);
> > > +           }
> > >      }
> > >
> > >      /* update the number of active compute rings */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > index ad2e0bb..1370b39 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > @@ -1464,9 +1464,15 @@ static void
> > gfx_v8_0_compute_queue_acquire(struct amdgpu_device *adev)
> > >              if (mec >= adev->gfx.mec.num_mec)
> > >                      break;
> > >
> > > -           /* policy: amdgpu owns the first two queues of the 
> first MEC
> > */
> > > -           if (mec == 0 && queue < 2)
> > > -                   set_bit(i, adev->gfx.mec.queue_bitmap);
> > > +           if (adev->gfx.mec.num_mec > 1) {
> > > +                   /* policy: amdgpu owns the first two queues of the
> > first MEC */
> > > +                   if (mec == 0 && queue < 2)
> > > +                           set_bit(i, adev->gfx.mec.queue_bitmap);
> > > +           } else {
> > > +                   /* policy: amdgpu owns all queues in the first 
> pipe */
> > > +                   if (mec == 0 && pipe == 0)
> > > +                           set_bit(i, adev->gfx.mec.queue_bitmap);
> > > +           }
> > >      }
> > >
> > >      /* update the number of active compute rings */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > index cf15a350..9d675b3 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > @@ -873,9 +873,15 @@ static void
> > gfx_v9_0_compute_queue_acquire(struct amdgpu_device *adev)
> > >              if (mec >= adev->gfx.mec.num_mec)
> > >                      break;
> > >
> > > -           /* policy: amdgpu owns the first two queues of the 
> first MEC
> > */
> > > -           if (mec == 0 && queue < 2)
> > > -                   set_bit(i, adev->gfx.mec.queue_bitmap);
> > > +           if (adev->gfx.mec.num_mec > 1) {
> > > +                   /* policy: amdgpu owns the first two queues of the
> > first MEC */
> > > +                   if (mec == 0 && queue < 2)
> > > +                           set_bit(i, adev->gfx.mec.queue_bitmap);
> > > +           } else {
> > > +                   /* policy: amdgpu owns all queues in the first 
> pipe */
> > > +                   if (mec == 0 && pipe == 0)
> > > +                           set_bit(i, adev->gfx.mec.queue_bitmap);
> > > +           }
> > >      }
> > >
> > >      /* update the number of active compute rings */
>


--------------C42AD35D3BA5B2EC7E103A16
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Alex,</p>
    <p>In Catalyst driver source code, Stoney is listed as supported, I
      don't know how well it is supported though. I think at least
      people have run some graphic operations.</p>
    <p>What kind of hangs happens in Stoney? Is it a graphic operation
      hang? Or OpenCL? Or something else? How easily it is reproduced?</p>
    <p>Stoney is similar to Carizzo. People has tried computes on
      Carrizo till Fiji in fglrx.<br>
    </p>
    <p>At least, we need to limit this change for Stoney only unless it
      is reported in other ASICs too.</p>
    <p> This change can affect compute performance a lot. People are
      evaluating even the AMDGPU PRO OpenCL on FIJI, as far as I know.<br>
    </p>
    <p>Thanks,</p>
    <p>Alex Bin<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2017-06-07 12:32 PM, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1652FFCD2FC9C923271C1475F7C80-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">&gt; -----Original Message-----<br>
            &gt; From: Xie, AlexBin<br>
            &gt; Sent: Wednesday, June 07, 2017 12:31 PM<br>
            &gt; To: Alex Deucher; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; Cc: Deucher, Alexander<br>
            &gt; Subject: Re: [PATCH 1/3] drm/amdgpu: fix mec queue
            policy on single MEC<br>
            &gt; asics<br>
            &gt; <br>
            &gt; Hi Alex,<br>
            &gt; <br>
            &gt; In closed source driver, we assign compute queues to
            all 4 pipes always.<br>
            &gt; There is no hangs.<br>
            &gt; <br>
            &gt; May I know which ASIC?<br>
            <br>
            It was reported on Stoney.<br>
            <br>
            Alex<br>
            <br>
            &gt; <br>
            &gt; Assign all queues in first pipe first mec can slow
            things down.<br>
            &gt; <br>
            &gt; Thanks,<br>
            &gt; <br>
            &gt; Alex Bin Xie<br>
            &gt; <br>
            &gt; <br>
            &gt; <br>
            &gt; On 2017-06-07 11:10 AM, Alex Deucher wrote:<br>
            &gt; &gt; Fixes hangs on single MEC asics.<br>
            &gt; &gt;<br>
            &gt; &gt; Fixes: 2ed286fb434 (drm/amdgpu: new queue policy,
            take first 2 queues of<br>
            &gt; each pipe v2)<br>
            &gt; &gt; Signed-off-by: Alex Deucher
            <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; &gt; ---<br>
            &gt; &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 12
            +++++++++---<br>
            &gt; &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12
            +++++++++---<br>
            &gt; &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12
            +++++++++---<br>
            &gt; &gt;   3 files changed, 27 insertions(+), 9
            deletions(-)<br>
            &gt; &gt;<br>
            &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
            &gt; &gt; index 4c04e9d..862bc72 100644<br>
            &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
            &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
            &gt; &gt; @@ -2825,9 +2825,15 @@ static void<br>
            &gt; gfx_v7_0_compute_queue_acquire(struct amdgpu_device
            *adev)<br>
            &gt; &gt;              if (mec &gt;=
            adev-&gt;gfx.mec.num_mec)<br>
            &gt; &gt;                      break;<br>
            &gt; &gt;<br>
            &gt; &gt; -           /* policy: amdgpu owns the first two
            queues of the first MEC<br>
            &gt; */<br>
            &gt; &gt; -           if (mec == 0 &amp;&amp; queue &lt; 2)<br>
            &gt; &gt; -                   set_bit(i,
            adev-&gt;gfx.mec.queue_bitmap);<br>
            &gt; &gt; +           if (adev-&gt;gfx.mec.num_mec &gt; 1) {<br>
            &gt; &gt; +                   /* policy: amdgpu owns the
            first two queues of the<br>
            &gt; first MEC */<br>
            &gt; &gt; +                   if (mec == 0 &amp;&amp; queue
            &lt; 2)<br>
            &gt; &gt; +                           set_bit(i,
            adev-&gt;gfx.mec.queue_bitmap);<br>
            &gt; &gt; +           } else {<br>
            &gt; &gt; +                   /* policy: amdgpu owns all
            queues in the first pipe */<br>
            &gt; &gt; +                   if (mec == 0 &amp;&amp; pipe
            == 0)<br>
            &gt; &gt; +                           set_bit(i,
            adev-&gt;gfx.mec.queue_bitmap);<br>
            &gt; &gt; +           }<br>
            &gt; &gt;      }<br>
            &gt; &gt;<br>
            &gt; &gt;      /* update the number of active compute rings
            */<br>
            &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
            &gt; &gt; index ad2e0bb..1370b39 100644<br>
            &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
            &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
            &gt; &gt; @@ -1464,9 +1464,15 @@ static void<br>
            &gt; gfx_v8_0_compute_queue_acquire(struct amdgpu_device
            *adev)<br>
            &gt; &gt;              if (mec &gt;=
            adev-&gt;gfx.mec.num_mec)<br>
            &gt; &gt;                      break;<br>
            &gt; &gt;<br>
            &gt; &gt; -           /* policy: amdgpu owns the first two
            queues of the first MEC<br>
            &gt; */<br>
            &gt; &gt; -           if (mec == 0 &amp;&amp; queue &lt; 2)<br>
            &gt; &gt; -                   set_bit(i,
            adev-&gt;gfx.mec.queue_bitmap);<br>
            &gt; &gt; +           if (adev-&gt;gfx.mec.num_mec &gt; 1) {<br>
            &gt; &gt; +                   /* policy: amdgpu owns the
            first two queues of the<br>
            &gt; first MEC */<br>
            &gt; &gt; +                   if (mec == 0 &amp;&amp; queue
            &lt; 2)<br>
            &gt; &gt; +                           set_bit(i,
            adev-&gt;gfx.mec.queue_bitmap);<br>
            &gt; &gt; +           } else {<br>
            &gt; &gt; +                   /* policy: amdgpu owns all
            queues in the first pipe */<br>
            &gt; &gt; +                   if (mec == 0 &amp;&amp; pipe
            == 0)<br>
            &gt; &gt; +                           set_bit(i,
            adev-&gt;gfx.mec.queue_bitmap);<br>
            &gt; &gt; +           }<br>
            &gt; &gt;      }<br>
            &gt; &gt;<br>
            &gt; &gt;      /* update the number of active compute rings
            */<br>
            &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
            &gt; &gt; index cf15a350..9d675b3 100644<br>
            &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
            &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
            &gt; &gt; @@ -873,9 +873,15 @@ static void<br>
            &gt; gfx_v9_0_compute_queue_acquire(struct amdgpu_device
            *adev)<br>
            &gt; &gt;              if (mec &gt;=
            adev-&gt;gfx.mec.num_mec)<br>
            &gt; &gt;                      break;<br>
            &gt; &gt;<br>
            &gt; &gt; -           /* policy: amdgpu owns the first two
            queues of the first MEC<br>
            &gt; */<br>
            &gt; &gt; -           if (mec == 0 &amp;&amp; queue &lt; 2)<br>
            &gt; &gt; -                   set_bit(i,
            adev-&gt;gfx.mec.queue_bitmap);<br>
            &gt; &gt; +           if (adev-&gt;gfx.mec.num_mec &gt; 1) {<br>
            &gt; &gt; +                   /* policy: amdgpu owns the
            first two queues of the<br>
            &gt; first MEC */<br>
            &gt; &gt; +                   if (mec == 0 &amp;&amp; queue
            &lt; 2)<br>
            &gt; &gt; +                           set_bit(i,
            adev-&gt;gfx.mec.queue_bitmap);<br>
            &gt; &gt; +           } else {<br>
            &gt; &gt; +                   /* policy: amdgpu owns all
            queues in the first pipe */<br>
            &gt; &gt; +                   if (mec == 0 &amp;&amp; pipe
            == 0)<br>
            &gt; &gt; +                           set_bit(i,
            adev-&gt;gfx.mec.queue_bitmap);<br>
            &gt; &gt; +           }<br>
            &gt; &gt;      }<br>
            &gt; &gt;<br>
            &gt; &gt;      /* update the number of active compute rings
            */<br>
            <br>
          </div>
        </span></font>
    </blockquote>
    <br>
  </body>
</html>

--------------C42AD35D3BA5B2EC7E103A16--

--===============0535204402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0535204402==--
