From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PART1 PATCH v3 7/8] drm/amdgpu: add get clockgating_state method
 for uvd v5&v6
Date: Fri, 6 Jan 2017 14:45:45 +0100
Message-ID: <1e6d1ea8-00b4-2af2-bedd-c1abaa5d24a6@amd.com>
References: <1483699875-27734-1-git-send-email-ray.huang@amd.com>
 <e2d8d323-1ee0-6f76-74c4-18a19fb2b0da@amd.com>
 <CY4PR12MB1768DCF4453B731FDD726447F7630@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1837774609=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768DCF4453B731FDD726447F7630-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Fu,
 Ping" <Ping.Fu-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1837774609==
Content-Type: multipart/alternative;
	boundary="------------B4969AFE975741A4424325C7"

--------------B4969AFE975741A4424325C7
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit

Good point, I wasn't ware that the pm mutex still existed and is taken 
under all code flows.

Christian.

Am 06.01.2017 um 14:42 schrieb StDenis, Tom:
>
> There's already the adev->pm.mutex which is held while gating/ungating 
> blocks.  There's no need for a second mutex right?
>
>
> Tom
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Friday, January 6, 2017 07:52
> *To:* Huang, Ray; Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Kuehling, Felix; Zhang, Hawking; Zhu, Rex; Fu, Ping; Mao, David
> *Subject:* Re: [PART1 PATCH v3 7/8] drm/amdgpu: add get 
> clockgating_state method for uvd v5&v6
> Am 06.01.2017 um 11:51 schrieb Huang Rui:
> > Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> > ---
> >
> > Changes from V2 -> V3:
> > - add mutex to protect the is_powergated flag.
> >
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 37 
> +++++++++++++++++++++++++++++++++--
> >   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 37 
> +++++++++++++++++++++++++++++++++--
> >   3 files changed, 72 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 530549b..afb3ded 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1183,6 +1183,8 @@ struct amdgpu_uvd {
> >        bool                    use_ctx_buf;
> >        struct amd_sched_entity entity;
> >        uint32_t                srbm_soft_reset;
> > +     bool                    is_powergated;
> > +     struct mutex            pg_mutex;
>
> You are missing a mutex_init for pg_mutex, probably best to put this
> into amdgpu_uvd_sw_init().
>
> Apart from that the patch looks good to me now.
>
> Regards,
> Christian.
>
> >   };
> >
> >   /*
> > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c 
> b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> > index 03a35d9..bf797b8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> > @@ -781,16 +781,48 @@ static int uvd_v5_0_set_powergating_state(void 
> *handle,
> >         * the smc and the hw blocks
> >         */
> >        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +     int ret = 0;
> >
> >        if (!(adev->pg_flags & AMD_PG_SUPPORT_UVD))
> >                return 0;
> >
> > +     mutex_lock(&adev->uvd.pg_mutex);
> > +
> >        if (state == AMD_PG_STATE_GATE) {
> > +             adev->uvd.is_powergated = true;
> >                uvd_v5_0_stop(adev);
> > -             return 0;
> >        } else {
> > -             return uvd_v5_0_start(adev);
> > +             ret = uvd_v5_0_start(adev);
> > +             if (ret)
> > +                     goto out;
> > +             adev->uvd.is_powergated = false;
> > +     }
> > +
> > +out:
> > +     mutex_unlock(&adev->uvd.pg_mutex);
> > +
> > +     return ret;
> > +}
> > +
> > +static void uvd_v5_0_get_clockgating_state(void *handle, u32 *flags)
> > +{
> > +     struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +     int data;
> > +
> > +     mutex_lock(&adev->uvd.pg_mutex);
> > +
> > +     if (adev->uvd.is_powergated) {
> > +             DRM_INFO("Cannot get clockgating state when UVD is 
> powergated.\n");
> > +             goto out;
> >        }
> > +
> > +     /* AMD_CG_SUPPORT_UVD_MGCG */
> > +     data = RREG32(mmUVD_CGC_CTRL);
> > +     if (data & UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK)
> > +             *flags |= AMD_CG_SUPPORT_UVD_MGCG;
> > +
> > +out:
> > +     mutex_unlock(&adev->uvd.pg_mutex);
> >   }
> >
> >   static const struct amd_ip_funcs uvd_v5_0_ip_funcs = {
> > @@ -808,6 +840,7 @@ static const struct amd_ip_funcs 
> uvd_v5_0_ip_funcs = {
> >        .soft_reset = uvd_v5_0_soft_reset,
> >        .set_clockgating_state = uvd_v5_0_set_clockgating_state,
> >        .set_powergating_state = uvd_v5_0_set_powergating_state,
> > +     .get_clockgating_state = uvd_v5_0_get_clockgating_state,
> >   };
> >
> >   static const struct amdgpu_ring_funcs uvd_v5_0_ring_funcs = {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c 
> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > index 8779d4b..0ec692d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > @@ -987,18 +987,50 @@ static int uvd_v6_0_set_powergating_state(void 
> *handle,
> >         * the smc and the hw blocks
> >         */
> >        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +     int ret = 0;
> >
> >        if (!(adev->pg_flags & AMD_PG_SUPPORT_UVD))
> >                return 0;
> >
> >        WREG32(mmUVD_POWER_STATUS, UVD_POWER_STATUS__UVD_PG_EN_MASK);
> >
> > +     mutex_lock(&adev->uvd.pg_mutex);
> > +
> >        if (state == AMD_PG_STATE_GATE) {
> > +             adev->uvd.is_powergated = true;
> >                uvd_v6_0_stop(adev);
> > -             return 0;
> >        } else {
> > -             return uvd_v6_0_start(adev);
> > +             ret = uvd_v6_0_start(adev);
> > +             if (ret)
> > +                     goto out;
> > +             adev->uvd.is_powergated = false;
> > +     }
> > +
> > +out:
> > +     mutex_unlock(&adev->uvd.pg_mutex);
> > +
> > +     return ret;
> > +}
> > +
> > +static void uvd_v6_0_get_clockgating_state(void *handle, u32 *flags)
> > +{
> > +     struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +     int data;
> > +
> > +     mutex_lock(&adev->uvd.pg_mutex);
> > +
> > +     if (adev->uvd.is_powergated) {
> > +             DRM_INFO("Cannot get clockgating state when UVD is 
> powergated.\n");
> > +             goto out;
> >        }
> > +
> > +     /* AMD_CG_SUPPORT_UVD_MGCG */
> > +     data = RREG32(mmUVD_CGC_CTRL);
> > +     if (data & UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK)
> > +             *flags |= AMD_CG_SUPPORT_UVD_MGCG;
> > +
> > +out:
> > +     mutex_unlock(&adev->uvd.pg_mutex);
> >   }
> >
> >   static const struct amd_ip_funcs uvd_v6_0_ip_funcs = {
> > @@ -1019,6 +1051,7 @@ static const struct amd_ip_funcs 
> uvd_v6_0_ip_funcs = {
> >        .post_soft_reset = uvd_v6_0_post_soft_reset,
> >        .set_clockgating_state = uvd_v6_0_set_clockgating_state,
> >        .set_powergating_state = uvd_v6_0_set_powergating_state,
> > +     .get_clockgating_state = uvd_v6_0_get_clockgating_state,
> >   };
> >
> >   static const struct amdgpu_ring_funcs uvd_v6_0_ring_phys_funcs = {
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - lists.freedesktop.org 
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> To see the collection of prior postings to the list, visit the amd-gfx 
> Archives. Using amd-gfx: To post a message to all the list members, 
> send email ...
>
>
>


--------------B4969AFE975741A4424325C7
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Good point, I wasn't ware that the pm
      mutex still existed and is taken under all code flows.<br>
      <br>
      Christian.<br>
      <br>
      Am 06.01.2017 um 14:42 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB1768DCF4453B731FDD726447F7630-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p>There's already the adev-&gt;pm.mutex which is held while
          gating/ungating blocks.  There's no need for a second mutex
          right?</p>
        <p><br>
        </p>
        <p>Tom</p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" color="#000000" face="Calibri,
                sans-serif"><b>From:</b> amd-gfx
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf
                of Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Friday, January 6, 2017 07:52<br>
                <b>To:</b> Huang, Ray; Deucher, Alexander;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Cc:</b> Kuehling, Felix; Zhang, Hawking; Zhu, Rex;
                Fu, Ping; Mao, David<br>
                <b>Subject:</b> Re: [PART1 PATCH v3 7/8] drm/amdgpu: add
                get clockgating_state method for uvd v5&amp;v6</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">Am 06.01.2017 um 11:51 schrieb
                Huang Rui:<br>
                &gt; Signed-off-by: Huang Rui <a class="moz-txt-link-rfc2396E" href="mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">&lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt; ---<br>
                &gt;<br>
                &gt; Changes from V2 -&gt; V3:<br>
                &gt; - add mutex to protect the is_powergated flag.<br>
                &gt;<br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  2 ++<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 37
                +++++++++++++++++++++++++++++++++--<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 37
                +++++++++++++++++++++++++++++++++--<br>
                &gt;   3 files changed, 72 insertions(+), 4 deletions(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; index 530549b..afb3ded 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; @@ -1183,6 +1183,8 @@ struct amdgpu_uvd {<br>
                &gt;        bool                    use_ctx_buf;<br>
                &gt;        struct amd_sched_entity entity;<br>
                &gt;        uint32_t                srbm_soft_reset;<br>
                &gt; +     bool                    is_powergated;<br>
                &gt; +     struct mutex            pg_mutex;<br>
                <br>
                You are missing a mutex_init for pg_mutex, probably best
                to put this <br>
                into amdgpu_uvd_sw_init().<br>
                <br>
                Apart from that the patch looks good to me now.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                &gt;   };<br>
                &gt;   <br>
                &gt;   /*<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
                b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
                &gt; index 03a35d9..bf797b8 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
                &gt; @@ -781,16 +781,48 @@ static int
                uvd_v5_0_set_powergating_state(void *handle,<br>
                &gt;         * the smc and the hw blocks<br>
                &gt;         */<br>
                &gt;        struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt; +     int ret = 0;<br>
                &gt;   <br>
                &gt;        if (!(adev-&gt;pg_flags &amp;
                AMD_PG_SUPPORT_UVD))<br>
                &gt;                return 0;<br>
                &gt;   <br>
                &gt; +     mutex_lock(&amp;adev-&gt;uvd.pg_mutex);<br>
                &gt; +<br>
                &gt;        if (state == AMD_PG_STATE_GATE) {<br>
                &gt; +             adev-&gt;uvd.is_powergated = true;<br>
                &gt;                uvd_v5_0_stop(adev);<br>
                &gt; -             return 0;<br>
                &gt;        } else {<br>
                &gt; -             return uvd_v5_0_start(adev);<br>
                &gt; +             ret = uvd_v5_0_start(adev);<br>
                &gt; +             if (ret)<br>
                &gt; +                     goto out;<br>
                &gt; +             adev-&gt;uvd.is_powergated = false;<br>
                &gt; +     }<br>
                &gt; +<br>
                &gt; +out:<br>
                &gt; +     mutex_unlock(&amp;adev-&gt;uvd.pg_mutex);<br>
                &gt; +<br>
                &gt; +     return ret;<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +static void uvd_v5_0_get_clockgating_state(void
                *handle, u32 *flags)<br>
                &gt; +{<br>
                &gt; +     struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt; +     int data;<br>
                &gt; +<br>
                &gt; +     mutex_lock(&amp;adev-&gt;uvd.pg_mutex);<br>
                &gt; +<br>
                &gt; +     if (adev-&gt;uvd.is_powergated) {<br>
                &gt; +             DRM_INFO("Cannot get clockgating
                state when UVD is powergated.\n");<br>
                &gt; +             goto out;<br>
                &gt;        }<br>
                &gt; +<br>
                &gt; +     /* AMD_CG_SUPPORT_UVD_MGCG */<br>
                &gt; +     data = RREG32(mmUVD_CGC_CTRL);<br>
                &gt; +     if (data &amp;
                UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK)<br>
                &gt; +             *flags |= AMD_CG_SUPPORT_UVD_MGCG;<br>
                &gt; +<br>
                &gt; +out:<br>
                &gt; +     mutex_unlock(&amp;adev-&gt;uvd.pg_mutex);<br>
                &gt;   }<br>
                &gt;   <br>
                &gt;   static const struct amd_ip_funcs
                uvd_v5_0_ip_funcs = {<br>
                &gt; @@ -808,6 +840,7 @@ static const struct
                amd_ip_funcs uvd_v5_0_ip_funcs = {<br>
                &gt;        .soft_reset = uvd_v5_0_soft_reset,<br>
                &gt;        .set_clockgating_state =
                uvd_v5_0_set_clockgating_state,<br>
                &gt;        .set_powergating_state =
                uvd_v5_0_set_powergating_state,<br>
                &gt; +     .get_clockgating_state =
                uvd_v5_0_get_clockgating_state,<br>
                &gt;   };<br>
                &gt;   <br>
                &gt;   static const struct amdgpu_ring_funcs
                uvd_v5_0_ring_funcs = {<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
                b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                &gt; index 8779d4b..0ec692d 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                &gt; @@ -987,18 +987,50 @@ static int
                uvd_v6_0_set_powergating_state(void *handle,<br>
                &gt;         * the smc and the hw blocks<br>
                &gt;         */<br>
                &gt;        struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt; +     int ret = 0;<br>
                &gt;   <br>
                &gt;        if (!(adev-&gt;pg_flags &amp;
                AMD_PG_SUPPORT_UVD))<br>
                &gt;                return 0;<br>
                &gt;   <br>
                &gt;        WREG32(mmUVD_POWER_STATUS,
                UVD_POWER_STATUS__UVD_PG_EN_MASK);<br>
                &gt;   <br>
                &gt; +     mutex_lock(&amp;adev-&gt;uvd.pg_mutex);<br>
                &gt; +<br>
                &gt;        if (state == AMD_PG_STATE_GATE) {<br>
                &gt; +             adev-&gt;uvd.is_powergated = true;<br>
                &gt;                uvd_v6_0_stop(adev);<br>
                &gt; -             return 0;<br>
                &gt;        } else {<br>
                &gt; -             return uvd_v6_0_start(adev);<br>
                &gt; +             ret = uvd_v6_0_start(adev);<br>
                &gt; +             if (ret)<br>
                &gt; +                     goto out;<br>
                &gt; +             adev-&gt;uvd.is_powergated = false;<br>
                &gt; +     }<br>
                &gt; +<br>
                &gt; +out:<br>
                &gt; +     mutex_unlock(&amp;adev-&gt;uvd.pg_mutex);<br>
                &gt; +<br>
                &gt; +     return ret;<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +static void uvd_v6_0_get_clockgating_state(void
                *handle, u32 *flags)<br>
                &gt; +{<br>
                &gt; +     struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt; +     int data;<br>
                &gt; +<br>
                &gt; +     mutex_lock(&amp;adev-&gt;uvd.pg_mutex);<br>
                &gt; +<br>
                &gt; +     if (adev-&gt;uvd.is_powergated) {<br>
                &gt; +             DRM_INFO("Cannot get clockgating
                state when UVD is powergated.\n");<br>
                &gt; +             goto out;<br>
                &gt;        }<br>
                &gt; +<br>
                &gt; +     /* AMD_CG_SUPPORT_UVD_MGCG */<br>
                &gt; +     data = RREG32(mmUVD_CGC_CTRL);<br>
                &gt; +     if (data &amp;
                UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK)<br>
                &gt; +             *flags |= AMD_CG_SUPPORT_UVD_MGCG;<br>
                &gt; +<br>
                &gt; +out:<br>
                &gt; +     mutex_unlock(&amp;adev-&gt;uvd.pg_mutex);<br>
                &gt;   }<br>
                &gt;   <br>
                &gt;   static const struct amd_ip_funcs
                uvd_v6_0_ip_funcs = {<br>
                &gt; @@ -1019,6 +1051,7 @@ static const struct
                amd_ip_funcs uvd_v6_0_ip_funcs = {<br>
                &gt;        .post_soft_reset = uvd_v6_0_post_soft_reset,<br>
                &gt;        .set_clockgating_state =
                uvd_v6_0_set_clockgating_state,<br>
                &gt;        .set_powergating_state =
                uvd_v6_0_set_powergating_state,<br>
                &gt; +     .get_clockgating_state =
                uvd_v6_0_get_clockgating_state,<br>
                &gt;   };<br>
                &gt;   <br>
                &gt;   static const struct amdgpu_ring_funcs
                uvd_v6_0_ring_phys_funcs = {<br>
                <br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a moz-do-not-send="true"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  id="LPlnk851602" previewremoved="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                <div id="LPBorder_GT_14837099174670.7732004508767665"
                  style="margin-bottom: 20px; overflow: auto; width:
                  100%; text-indent: 0px;">
                  <table
                    id="LPContainer_14837099174620.9257069430170277"
                    style="width: 90%; background-color: rgb(255, 255,
                    255); position: relative; overflow: auto;
                    padding-top: 20px; padding-bottom: 20px; margin-top:
                    20px; border-top: 1px dotted rgb(200, 200, 200);
                    border-bottom: 1px dotted rgb(200, 200, 200);"
                    cellspacing="0">
                    <tbody>
                      <tr style="border-spacing: 0px;" valign="top">
                        <td
                          id="TextCell_14837099174640.8034805271988259"
                          colspan="2" style="vertical-align: top;
                          position: relative; padding: 0px; display:
                          table-cell;">
                          <div
                            id="LPTitle_14837099174640.500860546474154"
                            style="top: 0px; color: rgb(59, 87, 119);
                            font-weight: normal; font-size: 21px;
                            font-family: wf_segoe-ui_light, &quot;Segoe
                            UI Light&quot;, &quot;Segoe WP Light&quot;,
                            &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
                            Tahoma, Arial, sans-serif; line-height:
                            21px;">
                            <a moz-do-not-send="true"
                              id="LPUrlAnchor_14837099174650.4952875786439821"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                              target="_blank" style="text-decoration:
                              none;">amd-gfx Info Page -
                              lists.freedesktop.org</a></div>
                          <div
                            id="LPMetadata_14837099174650.6970539461685066"
                            style="margin: 10px 0px 16px; color:
                            rgb(102, 102, 102); font-weight: normal;
                            font-family: wf_segoe-ui_normal, &quot;Segoe
                            UI&quot;, &quot;Segoe WP&quot;, Tahoma,
                            Arial, sans-serif; font-size: 14px;
                            line-height: 14px;">
                            lists.freedesktop.org</div>
                          <div
                            id="LPDescription_14837099174660.9659595296758496"
                            style="display: block; color: rgb(102, 102,
                            102); font-weight: normal; font-family:
                            wf_segoe-ui_normal, &quot;Segoe UI&quot;,
                            &quot;Segoe WP&quot;, Tahoma, Arial,
                            sans-serif; font-size: 14px; line-height:
                            20px; max-height: 100px; overflow: hidden;">
                            To see the collection of prior postings to
                            the list, visit the amd-gfx Archives. Using
                            amd-gfx: To post a message to all the list
                            members, send email ...</div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------B4969AFE975741A4424325C7--

--===============1837774609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1837774609==--
