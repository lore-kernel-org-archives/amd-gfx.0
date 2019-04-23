From: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re:[PATCH v5 6/6] drm/amdgpu: Avoid HW reset if guilty job already
 signaled.
Date: Tue, 23 Apr 2019 15:19:01 +0000
Message-ID: <-hyv5g0n8ru25qelb0v-8u6jdi1vp2c7z1m3f5-uygwc1o5ji6s-9zli9v-srreuk-3pvse1en6kx0-6se95l-6jsafd-a6sboi-j814xf-ijgwfc-qewgmm-vnafjgrn2fq0-jgir949hx4yo-i772hz-tn7ial.1556032736536@email.android.com>
References: <1555599624-12285-1-git-send-email-andrey.grodzovsky@amd.com>
 <1555599624-12285-6-git-send-email-andrey.grodzovsky@amd.com>
 <2f8cf80c-3c53-0ee2-968c-08338b9f154e@amd.com>,
 <1b41c4f1-b406-8710-2a7a-e5c54a116fe9@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1690833229=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1b41c4f1-b406-8710-2a7a-e5c54a116fe9-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org" <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "Liu,
 Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

--===============1690833229==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_hyv5g0n8ru25qelb0v8u6jdi1vp2c7z1m3f5uygwc1o5ji6s9zli9vs_"

--_000_hyv5g0n8ru25qelb0v8u6jdi1vp2c7z1m3f5uygwc1o5ji6s9zli9vs_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

do you mean fence timer? why not stop it as well when stopping sched for th=
e reason of hw reset?

-------- Original Message --------
Subject: Re: [PATCH v5 6/6] drm/amdgpu: Avoid HW reset if guilty job alread=
y signaled.
From: "Grodzovsky, Andrey"
To: "Zhou, David(ChunMing)" ,dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,amd-gfx@lists.=
freedesktop.org,eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org,etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,ckoenig.leich=
tzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
CC: "Kazlauskas, Nicholas" ,"Liu, Monk"


On 4/22/19 9:09 AM, Zhou, David(ChunMing) wrote:
> +Monk.
>
> GPU reset is used widely in SRIOV, so need virtulizatino guy take a look.
>
> But out of curious, why guilty job can signal more if the job is already
> set to guilty? set it wrongly?
>
>
> -David


It's possible that the job does completes at a later time then it's
timeout handler started processing so in this patch we try to protect
against this by rechecking the HW fence after stopping all SW
schedulers. We do it BEFORE marking guilty on the job's sched_entity so
at the point we check the guilty flag is not set yet.

Andrey


>
> =1B$B:_=1B(B 2019/4/18 23:00, Andrey Grodzovsky =1B$B<LF;=1B(B:
>> Also reject TDRs if another one already running.
>>
>> v2:
>> Stop all schedulers across device and entire XGMI hive before
>> force signaling HW fences.
>> Avoid passing job_signaled to helper fnctions to keep all the decision
>> making about skipping HW reset in one place.
>>
>> v3:
>> Fix SW sched. hang after non HW reset. sched.hw_rq_count has to be balan=
ced
>> against it's decrement in drm_sched_stop in non HW reset case.
>> v4: rebase
>> v5: Revert v3 as we do it now in sceduler code.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 143 +++++++++++++++++++-=
---------
>>    1 file changed, 95 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_device.c
>> index a0e165c..85f8792 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3334,8 +3334,6 @@ static int amdgpu_device_pre_asic_reset(struct amd=
gpu_device *adev,
>>               if (!ring || !ring->sched.thread)
>>                       continue;
>>
>> -            drm_sched_stop(&ring->sched, &job->base);
>> -
>>               /* after all hw jobs are reset, hw fence is meaningless, s=
o force_completion */
>>               amdgpu_fence_driver_force_completion(ring);
>>       }
>> @@ -3343,6 +3341,7 @@ static int amdgpu_device_pre_asic_reset(struct amd=
gpu_device *adev,
>>       if(job)
>>               drm_sched_increase_karma(&job->base);
>>
>> +    /* Don't suspend on bare metal if we are not going to HW reset the =
ASIC */
>>       if (!amdgpu_sriov_vf(adev)) {
>>
>>               if (!need_full_reset)
>> @@ -3480,37 +3479,21 @@ static int amdgpu_do_asic_reset(struct amdgpu_hi=
ve_info *hive,
>>       return r;
>>    }
>>
>> -static void amdgpu_device_post_asic_reset(struct amdgpu_device *adev)
>> +static bool amdgpu_device_lock_adev(struct amdgpu_device *adev, bool tr=
ylock)
>>    {
>> -    int i;
>> -
>> -    for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>> -            struct amdgpu_ring *ring =3D adev->rings[i];
>> -
>> -            if (!ring || !ring->sched.thread)
>> -                    continue;
>> -
>> -            if (!adev->asic_reset_res)
>> -                    drm_sched_resubmit_jobs(&ring->sched);
>> +    if (trylock) {
>> +            if (!mutex_trylock(&adev->lock_reset))
>> +                    return false;
>> +    } else
>> +            mutex_lock(&adev->lock_reset);
>>
>> -            drm_sched_start(&ring->sched, !adev->asic_reset_res);
>> -    }
>> -
>> -    if (!amdgpu_device_has_dc_support(adev)) {
>> -            drm_helper_resume_force_mode(adev->ddev);
>> -    }
>> -
>> -    adev->asic_reset_res =3D 0;
>> -}
>> -
>> -static void amdgpu_device_lock_adev(struct amdgpu_device *adev)
>> -{
>> -    mutex_lock(&adev->lock_reset);
>>       atomic_inc(&adev->gpu_reset_counter);
>>       adev->in_gpu_reset =3D 1;
>>       /* Block kfd: SRIOV would do it separately */
>>       if (!amdgpu_sriov_vf(adev))
>>                    amdgpu_amdkfd_pre_reset(adev);
>> +
>> +    return true;
>>    }
>>
>>    static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
>> @@ -3538,40 +3521,42 @@ static void amdgpu_device_unlock_adev(struct amd=
gpu_device *adev)
>>    int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>                             struct amdgpu_job *job)
>>    {
>> -    int r;
>> +    struct list_head device_list, *device_list_handle =3D  NULL;
>> +    bool need_full_reset, job_signaled;
>>       struct amdgpu_hive_info *hive =3D NULL;
>> -    bool need_full_reset =3D false;
>>       struct amdgpu_device *tmp_adev =3D NULL;
>> -    struct list_head device_list, *device_list_handle =3D  NULL;
>> +    int i, r =3D 0;
>>
>> +    need_full_reset =3D job_signaled =3D false;
>>       INIT_LIST_HEAD(&device_list);
>>
>>       dev_info(adev->dev, "GPU reset begin!\n");
>>
>> +    hive =3D amdgpu_get_xgmi_hive(adev, false);
>> +
>>       /*
>> -     * In case of XGMI hive disallow concurrent resets to be triggered
>> -     * by different nodes. No point also since the one node already exe=
cuting
>> -     * reset will also reset all the other nodes in the hive.
>> +     * Here we trylock to avoid chain of resets executing from
>> +     * either trigger by jobs on different adevs in XGMI hive or jobs o=
n
>> +     * different schedulers for same device while this TO handler is ru=
nning.
>> +     * We always reset all schedulers for device and all devices for XG=
MI
>> +     * hive so that should take care of them too.
>>        */
>> -    hive =3D amdgpu_get_xgmi_hive(adev, 0);
>> -    if (hive && adev->gmc.xgmi.num_physical_nodes > 1 &&
>> -        !mutex_trylock(&hive->reset_lock))
>> +
>> +    if (hive && !mutex_trylock(&hive->reset_lock)) {
>> +            DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as anot=
her already in progress",
>> +                     job->base.id, hive->hive_id);
>>               return 0;
>> +    }
>>
>>       /* Start with adev pre asic reset first for soft reset check.*/
>> -    amdgpu_device_lock_adev(adev);
>> -    r =3D amdgpu_device_pre_asic_reset(adev,
>> -                                     job,
>> -                                     &need_full_reset);
>> -    if (r) {
>> -            /*TODO Should we stop ?*/
>> -            DRM_ERROR("GPU pre asic reset failed with err, %d for drm d=
ev, %s ",
>> -                      r, adev->ddev->unique);
>> -            adev->asic_reset_res =3D r;
>> +    if (!amdgpu_device_lock_adev(adev, !hive)) {
>> +            DRM_INFO("Bailing on TDR for s_job:%llx, as another already=
 in progress",
>> +                                     job->base.id);
>> +            return 0;
>>       }
>>
>>       /* Build list of devices to reset */
>> -    if  (need_full_reset && adev->gmc.xgmi.num_physical_nodes > 1) {
>> +    if  (adev->gmc.xgmi.num_physical_nodes > 1) {
>>               if (!hive) {
>>                       amdgpu_device_unlock_adev(adev);
>>                       return -ENODEV;
>> @@ -3588,13 +3573,56 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,
>>               device_list_handle =3D &device_list;
>>       }
>>
>> +    /* block all schedulers and reset given job's ring */
>> +    list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>> +            for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>> +                    struct amdgpu_ring *ring =3D tmp_adev->rings[i];
>> +
>> +                    if (!ring || !ring->sched.thread)
>> +                            continue;
>> +
>> +                    drm_sched_stop(&ring->sched, &job->base);
>> +            }
>> +    }
>> +
>> +
>> +    /*
>> +     * Must check guilty signal here since after this point all old
>> +     * HW fences are force signaled.
>> +     *
>> +     * job->base holds a reference to parent fence
>> +     */
>> +    if (job && job->base.s_fence->parent &&
>> +        dma_fence_is_signaled(job->base.s_fence->parent))
>> +            job_signaled =3D true;
>> +
>> +    if (!amdgpu_device_ip_need_full_reset(adev))
>> +            device_list_handle =3D &device_list;
>> +
>> +    if (job_signaled) {
>> +            dev_info(adev->dev, "Guilty job already signaled, skipping =
HW reset");
>> +            goto skip_hw_reset;
>> +    }
>> +
>> +
>> +    /* Guilty job will be freed after this*/
>> +    r =3D amdgpu_device_pre_asic_reset(adev,
>> +                                     job,
>> +                                     &need_full_reset);
>> +    if (r) {
>> +            /*TODO Should we stop ?*/
>> +            DRM_ERROR("GPU pre asic reset failed with err, %d for drm d=
ev, %s ",
>> +                      r, adev->ddev->unique);
>> +            adev->asic_reset_res =3D r;
>> +    }
>> +
>>    retry:    /* Rest of adevs pre asic reset from XGMI hive. */
>>       list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>>
>>               if (tmp_adev =3D=3D adev)
>>                       continue;
>>
>> -            amdgpu_device_lock_adev(tmp_adev);
>> +            amdgpu_device_lock_adev(tmp_adev, false);
>>               r =3D amdgpu_device_pre_asic_reset(tmp_adev,
>>                                                NULL,
>>                                                &need_full_reset);
>> @@ -3618,9 +3646,28 @@ int amdgpu_device_gpu_recover(struct amdgpu_devic=
e *adev,
>>                       goto retry;
>>       }
>>
>> +skip_hw_reset:
>> +
>>       /* Post ASIC reset for all devs .*/
>>       list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>> -            amdgpu_device_post_asic_reset(tmp_adev);
>> +            for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>> +                    struct amdgpu_ring *ring =3D tmp_adev->rings[i];
>> +
>> +                    if (!ring || !ring->sched.thread)
>> +                            continue;
>> +
>> +                    /* No point to resubmit jobs if we didn't HW reset*=
/
>> +                    if (!tmp_adev->asic_reset_res && !job_signaled)
>> +                            drm_sched_resubmit_jobs(&ring->sched);
>> +
>> +                    drm_sched_start(&ring->sched, !tmp_adev->asic_reset=
_res);
>> +            }
>> +
>> +            if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signale=
d) {
>> +                    drm_helper_resume_force_mode(tmp_adev->ddev);
>> +            }
>> +
>> +            tmp_adev->asic_reset_res =3D 0;
>>
>>               if (r) {
>>                       /* bad news, how to tell it to userspace ? */
>> @@ -3633,7 +3680,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device=
 *adev,
>>               amdgpu_device_unlock_adev(tmp_adev);
>>       }
>>
>> -    if (hive && adev->gmc.xgmi.num_physical_nodes > 1)
>> +    if (hive)
>>               mutex_unlock(&hive->reset_lock);
>>
>>       if (r)
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_hyv5g0n8ru25qelb0v8u6jdi1vp2c7z1m3f5uygwc1o5ji6s9zli9vs_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>do you mean fence timer? why not stop it as well when stopping sched f=
or the reason of hw reset?<br>
<br>
-------- Original Message --------<br>
Subject: Re: [PATCH v5 6/6] drm/amdgpu: Avoid HW reset if guilty job alread=
y signaled.<br>
From: &quot;Grodzovsky, Andrey&quot; <br>
To: &quot;Zhou, David(ChunMing)&quot; ,dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,amd-=
gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org,etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,cko=
enig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<br>
CC: &quot;Kazlauskas, Nicholas&quot; ,&quot;Liu, Monk&quot; <br>
<br>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText"><br>
On 4/22/19 9:09 AM, Zhou, David(ChunMing) wrote:<br>
&gt; &#43;Monk.<br>
&gt;<br>
&gt; GPU reset is used widely in SRIOV, so need virtulizatino guy take a lo=
ok.<br>
&gt;<br>
&gt; But out of curious, why guilty job can signal more if the job is alrea=
dy<br>
&gt; set to guilty? set it wrongly?<br>
&gt;<br>
&gt;<br>
&gt; -David<br>
<br>
<br>
It's possible that the job does completes at a later time then it's <br>
timeout handler started processing so in this patch we try to protect <br>
against this by rechecking the HW fence after stopping all SW <br>
schedulers. We do it BEFORE marking guilty on the job's sched_entity so <br=
>
at the point we check the guilty flag is not set yet.<br>
<br>
Andrey<br>
<br>
<br>
&gt;<br>
&gt; =1B$B:_=1B(B 2019/4/18 23:00, Andrey Grodzovsky =1B$B<LF;=1B(B:<br>
&gt;&gt; Also reject TDRs if another one already running.<br>
&gt;&gt;<br>
&gt;&gt; v2:<br>
&gt;&gt; Stop all schedulers across device and entire XGMI hive before<br>
&gt;&gt; force signaling HW fences.<br>
&gt;&gt; Avoid passing job_signaled to helper fnctions to keep all the deci=
sion<br>
&gt;&gt; making about skipping HW reset in one place.<br>
&gt;&gt;<br>
&gt;&gt; v3:<br>
&gt;&gt; Fix SW sched. hang after non HW reset. sched.hw_rq_count has to be=
 balanced<br>
&gt;&gt; against it's decrement in drm_sched_stop in non HW reset case.<br>
&gt;&gt; v4: rebase<br>
&gt;&gt; v5: Revert v3 as we do it now in sceduler code.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 143=
 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;----------<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 95 insertions(&#43;), 48 deletio=
ns(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; index a0e165c..85f8792 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; @@ -3334,8 &#43;3334,6 @@ static int amdgpu_device_pre_asic_reset(=
struct amdgpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!ring || !ring-&gt;sched.thread)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; drm_sched_stop(&amp;ring-&gt;sched, &amp;job-&gt;base);<br>
&gt;&gt; -<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* after all hw jobs are reset, hw fence is meaningless, =
so force_completion */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_fence_driver_force_completion(ring);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; @@ -3343,6 &#43;3341,7 @@ static int amdgpu_device_pre_asic_reset(=
struct amdgpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(job)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; drm_sched_increase_karma(&amp;job-&gt;base);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; /* Don't suspend on bare metal if we are n=
ot going to HW reset the ASIC */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<=
br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!need_full_reset)<br>
&gt;&gt; @@ -3480,37 &#43;3479,21 @@ static int amdgpu_do_asic_reset(struct=
 amdgpu_hive_info *hive,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; -static void amdgpu_device_post_asic_reset(struct amdgpu_device *a=
dev)<br>
&gt;&gt; &#43;static bool amdgpu_device_lock_adev(struct amdgpu_device *ade=
v, bool trylock)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; &#43;&#=
43;i) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (!ring || !ring-&gt;sched.thread)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (!adev-&gt;asic_reset_res)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_resubmit_jobs(&=
amp;ring-&gt;sched);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (trylock) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (!mutex_trylock(&amp;adev-&gt;lock_reset))<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; } else<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; mutex_lock(&amp;adev-&gt;lock_reset);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; drm_sched_start(&amp;ring-&gt;sched, !adev-&gt;asic_reset_res);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (!amdgpu_device_has_dc_support(adev)) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; drm_helper_resume_force_mode(adev-&gt;ddev);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; adev-&gt;asic_reset_res =3D 0;<br>
&gt;&gt; -}<br>
&gt;&gt; -<br>
&gt;&gt; -static void amdgpu_device_lock_adev(struct amdgpu_device *adev)<b=
r>
&gt;&gt; -{<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;lock_reset);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;adev-&gt;gpu_r=
eset_counter);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_gpu_reset =3D 1;<b=
r>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Block kfd: SRIOV would do i=
t separately */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br=
>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_pre_reset(ade=
v);<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp; static void amdgpu_device_unlock_adev(struct amd=
gpu_device *adev)<br>
&gt;&gt; @@ -3538,40 &#43;3521,42 @@ static void amdgpu_device_unlock_adev(=
struct amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct list_head device_list, *device_list=
_handle =3D&nbsp; NULL;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; bool need_full_reset, job_signaled;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive =
=3D NULL;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; bool need_full_reset =3D false;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_adev=
 =3D NULL;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct list_head device_list, *device_list_han=
dle =3D&nbsp; NULL;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; need_full_reset =3D job_signaled =3D false=
;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device_lis=
t);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;G=
PU reset begin!\n&quot;);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; hive =3D amdgpu_get_xgmi_hive(adev, false)=
;<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; * In case of XGMI hive disallow concurre=
nt resets to be triggered<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; * by different nodes. No point also sinc=
e the one node already executing<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; * reset will also reset all the other no=
des in the hive.<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; * Here we trylock to avoid chain of =
resets executing from<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; * either trigger by jobs on differen=
t adevs in XGMI hive or jobs on<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; * different schedulers for same devi=
ce while this TO handler is running.<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; * We always reset all schedulers for=
 device and all devices for XGMI<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; * hive so that should take care of t=
hem too.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; hive =3D amdgpu_get_xgmi_hive(adev, 0);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (hive &amp;&amp; adev-&gt;gmc.xgmi.num_phys=
ical_nodes &gt; 1 &amp;&amp;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !mutex_trylock(&amp;hi=
ve-&gt;reset_lock))<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (hive &amp;&amp; !mutex_trylock(&amp;hi=
ve-&gt;reset_lock)) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; DRM_INFO(&quot;Bailing on TDR for s_job:%llx, hive: %llx as another a=
lready in progress&quot;,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;base.id=
, hive-&gt;hive_id);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Start with adev pre asic re=
set first for soft reset check.*/<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; amdgpu_device_lock_adev(adev);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_pre_asic_reset(adev,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; job,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &amp;need_full_reset);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /*TODO Should we stop ?*/<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; DRM_ERROR(&quot;GPU pre asic reset failed with err, %d for drm dev, %s &q=
uot;,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, adev-&gt;d=
dev-&gt;unique);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;asic_reset_res =3D r;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_lock_adev(adev, !hive))=
 {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; DRM_INFO(&quot;Bailing on TDR for s_job:%llx, as another already in p=
rogress&quot;,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; job-&gt;base.id);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Build list of devices to re=
set */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if&nbsp; (need_full_reset &amp;&amp; adev-&gt;=
gmc.xgmi.num_physical_nodes &gt; 1) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if&nbsp; (adev-&gt;gmc.xgmi.num_physical_n=
odes &gt; 1) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!hive) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_de=
vice_unlock_adev(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -E=
NODEV;<br>
&gt;&gt; @@ -3588,13 &#43;3573,56 @@ int amdgpu_device_gpu_recover(struct a=
mdgpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; device_list_handle =3D &amp;device_list;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; /* block all schedulers and reset given jo=
b's ring */<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, device_list_=
handle, gmc.xgmi.head) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; &#43;&#43;i) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *r=
ing =3D tmp_adev-&gt;rings[i];<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring || !ring-&g=
t;sched.thread)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_stop(&amp;r=
ing-&gt;sched, &amp;job-&gt;base);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; * Must check guilty signal here sinc=
e after this point all old<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; * HW fences are force signaled.<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; * job-&gt;base holds a reference to =
parent fence<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (job &amp;&amp; job-&gt;base.s_fence-&g=
t;parent &amp;&amp;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_is_signa=
led(job-&gt;base.s_fence-&gt;parent))<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; job_signaled =3D true;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_ip_need_full_reset(adev=
))<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; device_list_handle =3D &amp;device_list;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (job_signaled) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; dev_info(adev-&gt;dev, &quot;Guilty job already signaled, skipping HW=
 reset&quot;);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; goto skip_hw_reset;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; /* Guilty job will be freed after this*/<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_pre_asic_reset(adev,<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; job,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &amp;need_full_reset);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /*TODO Should we stop ?*/<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; DRM_ERROR(&quot;GPU pre asic reset failed with err, %d for drm dev, %=
s &quot;,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, adev-&=
gt;ddev-&gt;unique);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; adev-&gt;asic_reset_res =3D r;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; retry:&nbsp;&nbsp;&nbsp; /* Rest of adevs pre as=
ic reset from XGMI hive. */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, =
device_list_handle, gmc.xgmi.head) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (tmp_adev =3D=3D adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; amdgpu_device_lock_adev(tmp_adev);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; amdgpu_device_lock_adev(tmp_adev, false);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; r =3D amdgpu_device_pre_asic_reset(tmp_adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;need=
_full_reset);<br>
&gt;&gt; @@ -3618,9 &#43;3646,28 @@ int amdgpu_device_gpu_recover(struct am=
dgpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto retr=
y;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; &#43;skip_hw_reset:<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Post ASIC reset for all dev=
s .*/<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, =
device_list_handle, gmc.xgmi.head) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; amdgpu_device_post_asic_reset(tmp_adev);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; &#43;&#43;i) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *r=
ing =3D tmp_adev-&gt;rings[i];<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring || !ring-&g=
t;sched.thread)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No point to resubm=
it jobs if we didn't HW reset*/<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!tmp_adev-&gt;asi=
c_reset_res &amp;&amp; !job_signaled)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_resubmit_jobs(&amp;ring-&gt;sched);<br=
>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_start(&amp;=
ring-&gt;sched, !tmp_adev-&gt;asic_reset_res);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (!amdgpu_device_has_dc_support(tmp_adev) &amp;&amp; !job_signaled)=
 {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_helper_resume_for=
ce_mode(tmp_adev-&gt;ddev);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tmp_adev-&gt;asic_reset_res =3D 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bad ne=
ws, how to tell it to userspace ? */<br>
&gt;&gt; @@ -3633,7 &#43;3680,7 @@ int amdgpu_device_gpu_recover(struct amd=
gpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_device_unlock_adev(tmp_adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (hive &amp;&amp; adev-&gt;gmc.xgmi.num_phys=
ical_nodes &gt; 1)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (hive)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hive-&gt;reset_lock);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font>
</body>
</html>

--_000_hyv5g0n8ru25qelb0v8u6jdi1vp2c7z1m3f5uygwc1o5ji6s9zli9vs_--

--===============1690833229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1690833229==--
