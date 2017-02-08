From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogU1BBTSAvL+etlOWkjTogW1BBVENIIDA5LzIwXSBk?=
 =?UTF-8?Q?rm/amdgpu:implement_SRIOV_gpu=5freset?=
Date: Wed, 8 Feb 2017 16:13:46 +0100
Message-ID: <afe8b046-c0ba-586e-99c3-adef380cfd3f@vodafone.de>
References: <1486447878-20521-1-git-send-email-Monk.Liu@amd.com>
 <1486447878-20521-9-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB16109EC5F03088C1CFB58FE484430@DM5PR12MB1610.namprd12.prod.outlook.com>
 <5dfe222d-9564-0835-f749-3ea5ef78c701@vodafone.de>
 <DM5PR12MB1610E1ADF3A9172B1A418C7184420@DM5PR12MB1610.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0613811628=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1610E1ADF3A9172B1A418C7184420-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0613811628==
Content-Type: multipart/alternative;
 boundary="------------4B4A49CE22BAB4DC01678E12"

This is a multi-part message in MIME format.
--------------4B4A49CE22BAB4DC01678E12
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> and like I said, this approach is correct and verified by hang test
Completely irrelevant.

Please try the following:
1. Trigger a hang
2. Reset the GPU
3. Suspend the VM with glxgears running
4. Resume the VM

I'm pretty sure that with your approach that either suspending or 
resuming the VM with an application running will just hang.

Anyway even if all the code path you break here (UVD/VCE at minimum) are 
disabled in the SRIOV case it's still not a good idea completely 
breaking the design just to satisfy the SRIOV feature.

So that is still a clear NAK on that. Please do as I told you and use 
the hw_init() callback instead, it is especially made for this use case.

Regards,
Christian.

Am 08.02.2017 um 15:57 schrieb Liu, Monk:
>
> 》As I wrote in the other thread as well calling amdgpu_resume() 
> without proper suspend will just mess up a whole bunch of internal 
> structures.
>
>
> please name at least one, I'll check and see how to improve
>
> and like I said, this approach is correct and verified by hang test, 
> if internal structures messed up I don't think the test will easy 
> pass. hw_init() just call resume per engine.
>
> you can take a deep look into sriov_gpu_reset and judge later
>
>
> ------------------------------------------------------------------------
> *发件人:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *发送时间:* 2017年2月8日 18:49:57
> *收件人:* Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* Re: SPAM //答复: [PATCH 09/20] drm/amdgpu:implement SRIOV 
> gpu_reset
>> +       /* now we are okay to resume SMC/CP/SDMA */
>> +       amdgpu_resume_late(adev);
> As I wrote in the other thread as well calling amdgpu_resume() without 
> proper suspend will just mess up a whole bunch of internal structures.
>
> So a clear NAK on that approach. If you don't need the hw stop which 
> amdgpu_suspend() does for SRIOV then please try to just use the 
> hw_init() callback and not the resume() callback.
>
> Regards,
> Christian.
>
> Am 07.02.2017 um 07:26 schrieb Liu, Monk:
>>
>> patch 1-8 are some fixes for sriov gpu reset feature
>>
>> patch 9 -20 are for sriov gpu reset
>>
>>
>> BR Monk
>>
>> ------------------------------------------------------------------------
>> *发件人:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> 代表 Monk Liu 
>> <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>> *发送时间:* 2017年2月7日 14:11:07
>> *收件人:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> *抄送:* Liu, Monk
>> *主题:* [PATCH 09/20] drm/amdgpu:implement SRIOV gpu_reset
>> Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 158 
>> ++++++++++++++++++++++++++++-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |   1 +
>>  2 files changed, 158 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e926f84..2b404ca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1604,6 +1604,53 @@ int amdgpu_suspend(struct amdgpu_device *adev)
>>          return 0;
>>  }
>>
>> +static int amdgpu_resume_early(struct amdgpu_device *adev)
>> +{
>> +       int i, r;
>> +
>> +       for (i = 0; i < adev->num_ip_blocks; i++) {
>> +               if (!adev->ip_blocks[i].status.valid)
>> +                       continue;
>> +
>> +               if (adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_COMMON ||
>> + adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>> + adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)
>> +                       r = 
>> adev->ip_blocks[i].version->funcs->resume(adev);
>> +
>> +               if (r) {
>> +                       DRM_ERROR("resume of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                       return r;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int amdgpu_resume_late(struct amdgpu_device *adev)
>> +{
>> +       int i, r;
>> +
>> +       for (i = 0; i < adev->num_ip_blocks; i++) {
>> +               if (!adev->ip_blocks[i].status.valid)
>> +                       continue;
>> +
>> +               if (adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_COMMON ||
>> + adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>> + adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH )
>> +                       continue;
>> +
>> +               r = adev->ip_blocks[i].version->funcs->resume(adev);
>> +               if (r) {
>> +                       DRM_ERROR("resume of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                       return r;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static int amdgpu_resume(struct amdgpu_device *adev)
>>  {
>>          int i, r;
>> @@ -2343,6 +2390,115 @@ static int 
>> amdgpu_recover_vram_from_shadow(struct amdgpu_device *adev,
>>  }
>>
>>  /**
>> + * amdgpu_sriov_gpu_reset - reset the asic
>> + *
>> + * @adev: amdgpu device pointer
>> + * @voluntary: if this reset is requested by guest.
>> + *             (true means by guest and false means by HYPERVISOR )
>> + *
>> + * Attempt the reset the GPU if it has hung (all asics).
>> + * for SRIOV case.
>> + * Returns 0 for success or an error on failure.
>> + */
>> +int amdgpu_sriov_gpu_reset(struct amdgpu_device *adev, bool voluntary)
>> +{
>> +       int i, r = 0;
>> +       int resched;
>> +       struct amdgpu_bo *bo, *tmp;
>> +       struct amdgpu_ring *ring;
>> +       struct fence *fence = NULL, *next = NULL;
>> +
>> +       mutex_lock(&adev->virt.lock_reset);
>> +       atomic_inc(&adev->gpu_reset_counter);
>> +
>> +       /* block TTM */
>> +       resched = ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
>> +
>> +       /* block scheduler */
>> +       for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>> +               ring = adev->rings[i];
>> +
>> +               if (!ring || !ring->sched.thread)
>> +                       continue;
>> +
>> +               kthread_park(ring->sched.thread);
>> + amd_sched_hw_job_reset(&ring->sched);
>> +       }
>> +
>> +       /* after all hw jobs are reset, hw fence is meaningless, so 
>> force_completion */
>> +       amdgpu_fence_driver_force_completion(adev);
>> +
>> +       /* request to take full control of GPU before 
>> re-initialization  */
>> +       if (voluntary)
>> +               amdgpu_virt_reset_gpu(adev);
>> +       else
>> +               amdgpu_virt_request_full_gpu(adev, true);
>> +
>> +
>> +       /* Resume IP prior to SMC */
>> +       amdgpu_resume_early(adev);
>> +
>> +       /* we need recover gart prior to run SMC/CP/SDMA resume */
>> +       amdgpu_ttm_recover_gart(adev);
>> +
>> +       /* now we are okay to resume SMC/CP/SDMA */
>> +       amdgpu_resume_late(adev);
>
>
>> +
>> +       amdgpu_irq_gpu_reset_resume_helper(adev);
>> +
>> +       if (amdgpu_ib_ring_tests(adev))
>> +               dev_err(adev->dev, "[GPU_RESET] ib ring test failed 
>> (%d).\n", r);
>> +
>> +       /* rellease full control of GPU after ib test */
>> +       amdgpu_virt_release_full_gpu(adev, true);
>> +
>> +       DRM_INFO("recover vram bo from shadow\n");
>> +
>> +       ring = adev->mman.buffer_funcs_ring;
>> +       mutex_lock(&adev->shadow_list_lock);
>> +       list_for_each_entry_safe(bo, tmp, &adev->shadow_list, 
>> shadow_list) {
>> +               amdgpu_recover_vram_from_shadow(adev, ring, bo, &next);
>> +               if (fence) {
>> +                       r = fence_wait(fence, false);
>> +                       if (r) {
>> +                               WARN(r, "recovery from shadow isn't 
>> completed\n");
>> +                               break;
>> +                       }
>> +               }
>> +
>> +               fence_put(fence);
>> +               fence = next;
>> +       }
>> +       mutex_unlock(&adev->shadow_list_lock);
>> +
>> +       if (fence) {
>> +               r = fence_wait(fence, false);
>> +               if (r)
>> +                       WARN(r, "recovery from shadow isn't 
>> completed\n");
>> +       }
>> +       fence_put(fence);
>> +
>> +       for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>> +               struct amdgpu_ring *ring = adev->rings[i];
>> +               if (!ring || !ring->sched.thread)
>> +                       continue;
>> +
>> + amd_sched_job_recovery(&ring->sched);
>> +               kthread_unpark(ring->sched.thread);
>> +       }
>> +
>> +       drm_helper_resume_force_mode(adev->ddev);
>> + ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
>> +       if (r) {
>> +               /* bad news, how to tell it to userspace ? */
>> +               dev_info(adev->dev, "GPU reset failed\n");
>> +       }
>> +
>> +       mutex_unlock(&adev->virt.lock_reset);
>> +       return r;
>> +}
>> +
>> +/**
>>   * amdgpu_gpu_reset - reset the asic
>>   *
>>   * @adev: amdgpu device pointer
>> @@ -2358,7 +2514,7 @@ int amdgpu_gpu_reset(struct amdgpu_device *adev)
>>          bool need_full_reset;
>>
>>          if (amdgpu_sriov_vf(adev))
>> -               return 0;
>> +               return amdgpu_sriov_gpu_reset(adev, true);
>>
>>          if (!amdgpu_check_soft_reset(adev)) {
>>                  DRM_INFO("No hardware hang detected. Did some blocks 
>> stall?\n");
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> index 675e12c..73d24df 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> @@ -89,5 +89,6 @@ void amdgpu_virt_kiq_wreg(struct amdgpu_device 
>> *adev, uint32_t reg, uint32_t v);
>>  int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
>>  int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
>>  int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
>> +int amdgpu_sriov_gpu_reset(struct amdgpu_device *adev, bool voluntary);
>>
>>  #endif
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>


--------------4B4A49CE22BAB4DC01678E12
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite"><span>and like I said, this approach is
          correct and verified by hang test</span></blockquote>
      Completely irrelevant.<br>
      <br>
      Please try the following:<br>
      1. Trigger a hang<br>
      2. Reset the GPU<br>
      3. Suspend the VM with glxgears running<br>
      4. Resume the VM<br>
      <br>
      I'm pretty sure that with your approach that either suspending or
      resuming the VM with an application running will just hang.<br>
      <br>
      Anyway even if all the code path you break here (UVD/VCE at
      minimum) are disabled in the SRIOV case it's still not a good idea
      completely breaking the design just to satisfy the SRIOV feature.<br>
      <br>
      So that is still a clear NAK on that. Please do as I told you and
      use the hw_init() callback instead, it is especially made for this
      use case.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 08.02.2017 um 15:57 schrieb Liu, Monk:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB1610E1ADF3A9172B1A418C7184420-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p><span>》As I wrote in the other thread as well calling
            amdgpu_resume() without proper suspend will just mess up a
            whole bunch of internal structures.</span></p>
        <div><span><br>
          </span></div>
        <div><span>please name at least one, I'll check and see how to
            improve</span></div>
        <div><span><br>
          </span></div>
        <div><span>and like I said, this approach is correct and
            verified by hang test, if internal structures messed up I
            don't think the test will easy pass.
          </span><span>hw_init() just call resume per engine.</span></div>
        <div><span><br>
          </span></div>
        <div><span>you can take a deep look into sriov_gpu_reset and
            judge later </span></div>
        <div><span><br>
          </span></div>
        <p><br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          color="#000000" face="Calibri, sans-serif"><b>发件人:</b>
          Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
          <b>发送时间:</b> 2017年2月8日 18:49:57<br>
          <b>收件人:</b> Liu, Monk; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>主题:</b> Re: SPAM //答复: [PATCH 09/20] drm/amdgpu:implement
          SRIOV gpu_reset</font>
        <div> </div>
      </div>
      <div>
        <div class="moz-cite-prefix">
          <blockquote type="cite"><font size="2"><span
                style="font-size:10pt;">
                <div class="PlainText">+       /* now we are okay to
                  resume SMC/CP/SDMA */<br>
                  +       amdgpu_resume_late(adev);<br>
                </div>
              </span></font></blockquote>
          As I wrote in the other thread as well calling amdgpu_resume()
          without proper suspend will just mess up a whole bunch of
          internal structures.<br>
          <br>
          So a clear NAK on that approach. If you don't need the hw stop
          which amdgpu_suspend() does for SRIOV then please try to just
          use the hw_init() callback and not the resume() callback.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          Am 07.02.2017 um 07:26 schrieb Liu, Monk:<br>
        </div>
        <blockquote
cite="mid:DM5PR12MB16109EC5F03088C1CFB58FE484430-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
          type="cite">
          <meta name="Generator" content="Microsoft Exchange Server">
          <!-- converted from text -->
          <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
          <meta content="text/html; charset=UTF-8">
          <style type="text/css" style="">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
          <div dir="ltr">
            <div id="x_divtagdefaultwrapper" dir="ltr"
              style="font-size:12pt; color:#000000;
              font-family:Calibri,Arial,Helvetica,sans-serif">
              <p>patch 1-8 are some fixes for sriov gpu reset feature</p>
              <p>patch 9 -20 are for sriov gpu reset</p>
              <p><br>
              </p>
              <p>BR Monk<br>
              </p>
            </div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" color="#000000" face="Calibri,
                sans-serif"><b>发件人:</b> amd-gfx
                <a moz-do-not-send="true" class="moz-txt-link-rfc2396E"
                  href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                  &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> 代表
                Monk Liu <a moz-do-not-send="true"
                  class="moz-txt-link-rfc2396E"
                  href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">
                  &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>发送时间:</b> 2017年2月7日 14:11:07<br>
                <b>收件人:</b> <a moz-do-not-send="true"
                  class="moz-txt-link-abbreviated"
                  href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                  amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>抄送:</b> Liu, Monk<br>
                <b>主题:</b> [PATCH 09/20] drm/amdgpu:implement SRIOV
                gpu_reset</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">Signed-off-by: Monk Liu <a
                  moz-do-not-send="true" class="moz-txt-link-rfc2396E"
                  href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">
                  &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                ---<br>
                 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 158
                ++++++++++++++++++++++++++++-<br>
                 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |   1 +<br>
                 2 files changed, 158 insertions(+), 1 deletion(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                index e926f84..2b404ca 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                @@ -1604,6 +1604,53 @@ int amdgpu_suspend(struct
                amdgpu_device *adev)<br>
                         return 0;<br>
                 }<br>
                 <br>
                +static int amdgpu_resume_early(struct amdgpu_device
                *adev)<br>
                +{<br>
                +       int i, r;<br>
                +<br>
                +       for (i = 0; i &lt; adev-&gt;num_ip_blocks; i++)
                {<br>
                +               if (!adev-&gt;ip_blocks[i].status.valid)<br>
                +                       continue;<br>
                +<br>
                +               if
                (adev-&gt;ip_blocks[i].version-&gt;type ==
                AMD_IP_BLOCK_TYPE_COMMON ||<br>
                +                              
                adev-&gt;ip_blocks[i].version-&gt;type ==
                AMD_IP_BLOCK_TYPE_GMC ||<br>
                +                              
                adev-&gt;ip_blocks[i].version-&gt;type ==
                AMD_IP_BLOCK_TYPE_IH)<br>
                +                       r =
                adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;resume(adev);<br>
                +<br>
                +               if (r) {<br>
                +                       DRM_ERROR("resume of IP block
                &lt;%s&gt; failed %d\n",<br>
                +                                
                adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name, r);<br>
                +                       return r;<br>
                +               }<br>
                +       }<br>
                +<br>
                +       return 0;<br>
                +}<br>
                +<br>
                +static int amdgpu_resume_late(struct amdgpu_device
                *adev)<br>
                +{<br>
                +       int i, r;<br>
                +<br>
                +       for (i = 0; i &lt; adev-&gt;num_ip_blocks; i++)
                {<br>
                +               if (!adev-&gt;ip_blocks[i].status.valid)<br>
                +                       continue;<br>
                +<br>
                +               if
                (adev-&gt;ip_blocks[i].version-&gt;type ==
                AMD_IP_BLOCK_TYPE_COMMON ||<br>
                +                              
                adev-&gt;ip_blocks[i].version-&gt;type ==
                AMD_IP_BLOCK_TYPE_GMC ||<br>
                +                              
                adev-&gt;ip_blocks[i].version-&gt;type ==
                AMD_IP_BLOCK_TYPE_IH )<br>
                +                       continue;<br>
                +<br>
                +               r =
                adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;resume(adev);<br>
                +               if (r) {<br>
                +                       DRM_ERROR("resume of IP block
                &lt;%s&gt; failed %d\n",<br>
                +                                
                adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name, r);<br>
                +                       return r;<br>
                +               }<br>
                +       }<br>
                +<br>
                +       return 0;<br>
                +}<br>
                +<br>
                 static int amdgpu_resume(struct amdgpu_device *adev)<br>
                 {<br>
                         int i, r;<br>
                @@ -2343,6 +2390,115 @@ static int
                amdgpu_recover_vram_from_shadow(struct amdgpu_device
                *adev,<br>
                 }<br>
                 <br>
                 /**<br>
                + * amdgpu_sriov_gpu_reset - reset the asic<br>
                + *<br>
                + * @adev: amdgpu device pointer<br>
                + * @voluntary: if this reset is requested by guest.<br>
                + *             (true means by guest and false means by
                HYPERVISOR )<br>
                + *<br>
                + * Attempt the reset the GPU if it has hung (all
                asics).<br>
                + * for SRIOV case.<br>
                + * Returns 0 for success or an error on failure.<br>
                + */<br>
                +int amdgpu_sriov_gpu_reset(struct amdgpu_device *adev,
                bool voluntary)<br>
                +{<br>
                +       int i, r = 0;<br>
                +       int resched;<br>
                +       struct amdgpu_bo *bo, *tmp;<br>
                +       struct amdgpu_ring *ring;<br>
                +       struct fence *fence = NULL, *next = NULL;<br>
                +<br>
                +       mutex_lock(&amp;adev-&gt;virt.lock_reset);<br>
                +       atomic_inc(&amp;adev-&gt;gpu_reset_counter);<br>
                +<br>
                +       /* block TTM */<br>
                +       resched =
                ttm_bo_lock_delayed_workqueue(&amp;adev-&gt;mman.bdev);<br>
                +<br>
                +       /* block scheduler */<br>
                +       for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
                +               ring = adev-&gt;rings[i];<br>
                +<br>
                +               if (!ring || !ring-&gt;sched.thread)<br>
                +                       continue;<br>
                +<br>
                +               kthread_park(ring-&gt;sched.thread);<br>
                +              
                amd_sched_hw_job_reset(&amp;ring-&gt;sched);<br>
                +       }<br>
                +<br>
                +       /* after all hw jobs are reset, hw fence is
                meaningless, so force_completion */<br>
                +       amdgpu_fence_driver_force_completion(adev);<br>
                +<br>
                +       /* request to take full control of GPU before
                re-initialization  */<br>
                +       if (voluntary)<br>
                +               amdgpu_virt_reset_gpu(adev);<br>
                +       else<br>
                +               amdgpu_virt_request_full_gpu(adev,
                true);<br>
                +<br>
                +<br>
                +       /* Resume IP prior to SMC */<br>
                +       amdgpu_resume_early(adev);<br>
                +<br>
                +       /* we need recover gart prior to run SMC/CP/SDMA
                resume */<br>
                +       amdgpu_ttm_recover_gart(adev);<br>
                +<br>
                +       /* now we are okay to resume SMC/CP/SDMA */<br>
                +       amdgpu_resume_late(adev);<br>
              </div>
            </span></font></blockquote>
        <br>
        <br>
        <blockquote
cite="mid:DM5PR12MB16109EC5F03088C1CFB58FE484430-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
          type="cite">
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">+<br>
                +       amdgpu_irq_gpu_reset_resume_helper(adev);<br>
                +<br>
                +       if (amdgpu_ib_ring_tests(adev))<br>
                +               dev_err(adev-&gt;dev, "[GPU_RESET] ib
                ring test failed (%d).\n", r);<br>
                +<br>
                +       /* rellease full control of GPU after ib test */<br>
                +       amdgpu_virt_release_full_gpu(adev, true);<br>
                +<br>
                +       DRM_INFO("recover vram bo from shadow\n");<br>
                +<br>
                +       ring = adev-&gt;mman.buffer_funcs_ring;<br>
                +       mutex_lock(&amp;adev-&gt;shadow_list_lock);<br>
                +       list_for_each_entry_safe(bo, tmp,
                &amp;adev-&gt;shadow_list, shadow_list) {<br>
                +               amdgpu_recover_vram_from_shadow(adev,
                ring, bo, &amp;next);<br>
                +               if (fence) {<br>
                +                       r = fence_wait(fence, false);<br>
                +                       if (r) {<br>
                +                               WARN(r, "recovery from
                shadow isn't completed\n");<br>
                +                               break;<br>
                +                       }<br>
                +               }<br>
                +<br>
                +               fence_put(fence);<br>
                +               fence = next;<br>
                +       }<br>
                +       mutex_unlock(&amp;adev-&gt;shadow_list_lock);<br>
                +<br>
                +       if (fence) {<br>
                +               r = fence_wait(fence, false);<br>
                +               if (r)<br>
                +                       WARN(r, "recovery from shadow
                isn't completed\n");<br>
                +       }<br>
                +       fence_put(fence);<br>
                +<br>
                +       for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
                +               struct amdgpu_ring *ring =
                adev-&gt;rings[i];<br>
                +               if (!ring || !ring-&gt;sched.thread)<br>
                +                       continue;<br>
                +<br>
                +              
                amd_sched_job_recovery(&amp;ring-&gt;sched);<br>
                +               kthread_unpark(ring-&gt;sched.thread);<br>
                +       }<br>
                +<br>
                +       drm_helper_resume_force_mode(adev-&gt;ddev);<br>
                +      
                ttm_bo_unlock_delayed_workqueue(&amp;adev-&gt;mman.bdev,
                resched);<br>
                +       if (r) {<br>
                +               /* bad news, how to tell it to userspace
                ? */<br>
                +               dev_info(adev-&gt;dev, "GPU reset
                failed\n");<br>
                +       }<br>
                +<br>
                +       mutex_unlock(&amp;adev-&gt;virt.lock_reset);<br>
                +       return r;<br>
                +}<br>
                +<br>
                +/**<br>
                  * amdgpu_gpu_reset - reset the asic<br>
                  *<br>
                  * @adev: amdgpu device pointer<br>
                @@ -2358,7 +2514,7 @@ int amdgpu_gpu_reset(struct
                amdgpu_device *adev)<br>
                         bool need_full_reset;<br>
                 <br>
                         if (amdgpu_sriov_vf(adev))<br>
                -               return 0;<br>
                +               return amdgpu_sriov_gpu_reset(adev,
                true);<br>
                 <br>
                         if (!amdgpu_check_soft_reset(adev)) {<br>
                                 DRM_INFO("No hardware hang detected.
                Did some blocks stall?\n");<br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
                index 675e12c..73d24df 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
                @@ -89,5 +89,6 @@ void amdgpu_virt_kiq_wreg(struct
                amdgpu_device *adev, uint32_t reg, uint32_t v);<br>
                 int amdgpu_virt_request_full_gpu(struct amdgpu_device
                *adev, bool init);<br>
                 int amdgpu_virt_release_full_gpu(struct amdgpu_device
                *adev, bool init);<br>
                 int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);<br>
                +int amdgpu_sriov_gpu_reset(struct amdgpu_device *adev,
                bool voluntary);<br>
                 <br>
                 #endif<br>
                -- <br>
                2.7.4<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a moz-do-not-send="true"
                  class="moz-txt-link-abbreviated"
                  href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a moz-do-not-send="true"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
              </div>
            </span></font><br>
          <fieldset class="mimeAttachmentHeader"></fieldset>
          <br>
          <pre wrap="">_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <p><br>
        </p>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------4B4A49CE22BAB4DC01678E12--

--===============0613811628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0613811628==--
