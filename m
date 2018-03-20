From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: disable job timeout on GPU reset disabled
Date: Tue, 20 Mar 2018 15:21:59 +0100
Message-ID: <50d6c9f3-4652-d733-586e-c0a80724a4e6@amd.com>
References: <1521439692-14823-1-git-send-email-evan.quan@amd.com>
 <d7a88e66-6533-9c12-c36c-9b3ea569e354@gmail.com>
 <DM5PR1201MB248999A09FAAC36F90204EF9E4AB0@DM5PR1201MB2489.namprd12.prod.outlook.com>
 <fffd20df-cbcb-51ae-7de2-915804fce17f@amd.com>
 <DM5PR12MB1820FEE50DE4EBD1E44B676BF7AB0@DM5PR12MB1820.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0822990624=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1820FEE50DE4EBD1E44B676BF7AB0-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0822990624==
Content-Type: multipart/alternative;
 boundary="------------BC0523B78852FE3714AFC743"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BC0523B78852FE3714AFC743
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

That's a good point as well, maybe we should have separate timeouts for 
gfx and compute?

Something like 5 seconds for gfx and 1 minute (or even longer) for compute?

Anyway I agree that we can worry about that later on, patch is 
Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org> for now.

Regards,
Christian.

Am 20.03.2018 um 15:16 schrieb Deucher, Alexander:
>
> My concern was that compute will always have the timeout disabled with 
> no way to override it even if you enable GPU reset.  I guess we can 
> address that down the road.
>
>
> Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> ------------------------------------------------------------------------
> *From:* Koenig, Christian
> *Sent:* Tuesday, March 20, 2018 6:14:29 AM
> *To:* Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Deucher, Alexander
> *Subject:* Re: [PATCH] drm/amdgpu: disable job timeout on GPU reset 
> disabled
> Hi Evan,
>
> that one is perfect if you ask me. Just reading up on the history of
> that patch, Alex what was your concern with that?
>
> Regarding printing this as error, that's a really good point as well. We
> should probably reduce it to a warning or even info severity.
>
> Regards,
> Christian.
>
> Am 20.03.2018 um 03:11 schrieb Quan, Evan:
> > Hi Christian,
> >
> > The messages prompted on timeout are Errors not just Warnings 
> although we did not see any real problem(for the dgemm special case). 
> That's why we say it confusing.
> > And i suppose you want a fix like my previous patch(see attachment).
> >
> > Regards,
> > Evan
> >> -----Original Message-----
> >> From: Christian König [mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> >> Sent: Monday, March 19, 2018 5:42 PM
> >> To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> >> Subject: Re: [PATCH] drm/amdgpu: disable job timeout on GPU reset
> >> disabled
> >>
> >> Am 19.03.2018 um 07:08 schrieb Evan Quan:
> >>> Since under some heavy computing environment(dgemm test), it takes the
> >>> asic over 10+ seconds to finish the dispatched single job which will
> >>> trigger the timeout. It's quite confusing although it does not seem to
> >>> bring any real problems.
> >>> As a quick workround, we choose to disable timeout when GPU reset is
> >>> disabled.
> >> NAK, I enabled those warning intentionally even when the GPU 
> recovery is
> >> disabled to have a hint in the logs what goes wrong.
> >>
> >> Please only increase the timeout for the compute queue and/or add a
> >> separate timeout for them.
> >>
> >> Regards,
> >> Christian.
> >>
> >>
> >>> Change-Id: I3a95d856ba4993094dc7b6269649e470c5b053d2
> >>> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
> >>>    1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> index 8bd9c3f..9d6a775 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -861,6 +861,13 @@ static void
> >> amdgpu_device_check_arguments(struct amdgpu_device *adev)
> >>>              amdgpu_lockup_timeout = 10000;
> >>>      }
> >>>
> >>> +   /*
> >>> +    * Disable timeout when GPU reset is disabled to avoid confusing
> >>> +    * timeout messages in the kernel log.
> >>> +    */
> >>> +   if (amdgpu_gpu_recovery == 0 || amdgpu_gpu_recovery == -1)
> >>> +           amdgpu_lockup_timeout = INT_MAX;
> >>> +
> >>>      adev->firmware.load_type = amdgpu_ucode_get_load_type(adev,
> >> amdgpu_fw_load_type);
> >>>    }
> >>>
>


--------------BC0523B78852FE3714AFC743
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">That's a good point as well, maybe we
      should have separate timeouts for gfx and compute?<br>
      <br>
      Something like 5 seconds for gfx and 1 minute (or even longer) for
      compute?<br>
      <br>
      Anyway I agree that we can worry about that later on, patch is
      Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> for
      now.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 20.03.2018 um 15:16 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB1820FEE50DE4EBD1E44B676BF7AB0-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">My concern was that
          compute will always have the timeout disabled with no way to
          override it even if you enable GPU reset.  I guess we can
          address that down the road.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Acked-by: Alex Deucher
          <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Koenig, Christian<br>
          <b>Sent:</b> Tuesday, March 20, 2018 6:14:29 AM<br>
          <b>To:</b> Quan, Evan; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Cc:</b> Deucher, Alexander<br>
          <b>Subject:</b> Re: [PATCH] drm/amdgpu: disable job timeout on
          GPU reset disabled</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">Hi Evan,<br>
              <br>
              that one is perfect if you ask me. Just reading up on the
              history of <br>
              that patch, Alex what was your concern with that?<br>
              <br>
              Regarding printing this as error, that's a really good
              point as well. We <br>
              should probably reduce it to a warning or even info
              severity.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              Am 20.03.2018 um 03:11 schrieb Quan, Evan:<br>
              &gt; Hi Christian,<br>
              &gt;<br>
              &gt; The messages prompted on timeout are Errors not just
              Warnings although we did not see any real problem(for the
              dgemm special case). That's why we say it confusing.<br>
              &gt; And i suppose you want a fix like my previous
              patch(see attachment).<br>
              &gt;<br>
              &gt; Regards,<br>
              &gt; Evan<br>
              &gt;&gt; -----Original Message-----<br>
              &gt;&gt; From: Christian König [<a
                href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                moz-do-not-send="true">mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]<br>
              &gt;&gt; Sent: Monday, March 19, 2018 5:42 PM<br>
              &gt;&gt; To: Quan, Evan <a class="moz-txt-link-rfc2396E" href="mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">&lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              &gt;&gt; Cc: Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt;&gt; Subject: Re: [PATCH] drm/amdgpu: disable job
              timeout on GPU reset<br>
              &gt;&gt; disabled<br>
              &gt;&gt;<br>
              &gt;&gt; Am 19.03.2018 um 07:08 schrieb Evan Quan:<br>
              &gt;&gt;&gt; Since under some heavy computing
              environment(dgemm test), it takes the<br>
              &gt;&gt;&gt; asic over 10+ seconds to finish the
              dispatched single job which will<br>
              &gt;&gt;&gt; trigger the timeout. It's quite confusing
              although it does not seem to<br>
              &gt;&gt;&gt; bring any real problems.<br>
              &gt;&gt;&gt; As a quick workround, we choose to disable
              timeout when GPU reset is<br>
              &gt;&gt;&gt; disabled.<br>
              &gt;&gt; NAK, I enabled those warning intentionally even
              when the GPU recovery is<br>
              &gt;&gt; disabled to have a hint in the logs what goes
              wrong.<br>
              &gt;&gt;<br>
              &gt;&gt; Please only increase the timeout for the compute
              queue and/or add a<br>
              &gt;&gt; separate timeout for them.<br>
              &gt;&gt;<br>
              &gt;&gt; Regards,<br>
              &gt;&gt; Christian.<br>
              &gt;&gt;<br>
              &gt;&gt;<br>
              &gt;&gt;&gt; Change-Id:
              I3a95d856ba4993094dc7b6269649e470c5b053d2<br>
              &gt;&gt;&gt; Signed-off-by: Evan Quan
              <a class="moz-txt-link-rfc2396E" href="mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">&lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt;&gt;&gt; ---<br>
              &gt;&gt;&gt;    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
              | 7 +++++++<br>
              &gt;&gt;&gt;    1 file changed, 7 insertions(+)<br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt;&gt;&gt; index 8bd9c3f..9d6a775 100644<br>
              &gt;&gt;&gt; ---
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt;&gt;&gt; +++
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt;&gt;&gt; @@ -861,6 +861,13 @@ static void<br>
              &gt;&gt; amdgpu_device_check_arguments(struct
              amdgpu_device *adev)<br>
              &gt;&gt;&gt;              amdgpu_lockup_timeout = 10000;<br>
              &gt;&gt;&gt;      }<br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt; +   /*<br>
              &gt;&gt;&gt; +    * Disable timeout when GPU reset is
              disabled to avoid confusing<br>
              &gt;&gt;&gt; +    * timeout messages in the kernel log.<br>
              &gt;&gt;&gt; +    */<br>
              &gt;&gt;&gt; +   if (amdgpu_gpu_recovery == 0 ||
              amdgpu_gpu_recovery == -1)<br>
              &gt;&gt;&gt; +           amdgpu_lockup_timeout = INT_MAX;<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt;      adev-&gt;firmware.load_type =
              amdgpu_ucode_get_load_type(adev,<br>
              &gt;&gt; amdgpu_fw_load_type);<br>
              &gt;&gt;&gt;    }<br>
              &gt;&gt;&gt;<br>
              <br>
            </div>
          </span></font></div>
    </blockquote>
    <br>
  </body>
</html>

--------------BC0523B78852FE3714AFC743--

--===============0822990624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0822990624==--
