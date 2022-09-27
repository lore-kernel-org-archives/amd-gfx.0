Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA85C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 17:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B5A10E064;
	Tue, 27 Sep 2022 17:29:43 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3968B10E064
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 17:29:40 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4McRSw42Vtz9sdD;
 Tue, 27 Sep 2022 19:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1664299776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1rXTUd40F0PAItDn2JEqd0I0IjV4atulJ/pkgQJkU4=;
 b=P4kHo9mgDxzQ/bnmIrNp22fDmmQBuT/oZ8tpikeTRIH+5D2yvFY0vJrxv5rixFzHYWUS/0
 NhhMMiDZc2yBP2NVpJ7Mrl2G/AabaFnec1rXqzeZjz7GRzrfXeDGESjMgPZxvio7gSe0ck
 ub/tOe1sL08i6P5HMo8XfvdESxkVeiGXMLVhSn8VgdWEri/r4HvgYCd9LWw0QFNLa0awA/
 sYc2rqjvIgjpsccyW5VqPOASOR38q5XtVOPxv8ICeMg1BcXn2vXXRdAbHhOv8GvOVciNEo
 0yiOCOQM5ec571KAnUsXBncP4IKX7h2JEDdTLwvaYmPtwXViydSK3sXvUcJqLQ==
Message-ID: <a84c4b97-b50b-2a70-a9a5-cb6420339b77@mailbox.org>
Date: Tue, 27 Sep 2022 19:29:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/5] drm/amdgpu: switch GPU workload profile
Content-Language: en-CA
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-5-shashank.sharma@amd.com>
 <538ae193-37e6-40b2-cff7-bcbeab6e4fe6@amd.com>
 <824ff17b-16f5-e68e-736c-11e2c7027241@amd.com>
 <6ae60041-6db3-450f-2ac7-2f4415779818@mailbox.org>
 <525fc540-bec4-339b-6b77-4dd938c502a2@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <525fc540-bec4-339b-6b77-4dd938c502a2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 24a0c2be4fa1e84e8a1
X-MBO-RS-META: j3q8bouj9eq8dz1716qh8dyxyjwspb9w
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-27 19:06, Sharma, Shashank wrote:
> On 9/27/2022 6:33 PM, Michel Dänzer wrote:
>> On 2022-09-27 13:47, Sharma, Shashank wrote:
>>> On 9/27/2022 12:03 PM, Lazar, Lijo wrote:
>>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>>> This patch and switches the GPU workload based profile based
>>>>> on the workload hint information saved in the workload context.
>>>>> The workload profile is reset to NONE when the job is done.
>>>>>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 ++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c |  4 ----
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          | 15 +++++++++++++++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h          |  3 +++
>>>>>    4 files changed, 20 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> index b7bae833c804..de906a42144f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> @@ -237,6 +237,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>>>>>            goto free_all_kdata;
>>>>>        }
>>>>> +    p->job->workload_mode = p->ctx->workload_mode;
>>>>> +
>>>>>        if (p->uf_entry.tv.bo)
>>>>>            p->job->uf_addr = uf_offset;
>>>>>        kvfree(chunk_array);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>> index a11cf29bc388..625114804121 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>> @@ -55,15 +55,11 @@ int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>        mutex_lock(&adev->pm.smu_workload_lock);
>>>>> -    if (adev->pm.workload_mode == hint)
>>>>> -        goto unlock;
>>>>> -
>>>>
>>>> What is the expectation when a GFX job + VCN job together (or in general two jobs running in separate schedulers) and each prefers a different workload type? FW will switch as requested.
>>>
>>> Well, I guess the last switched mode will take over. Do note that like most of the PM features, the real benefit of power profiles can be seen with consistant and similar workloads running for some time (Like gaming, video playback etc).
>>
>> Not sure how that's supposed to work on a general purpose system, where there are always expected to be multiple processes (one of which being the display server) using the GPU for different workloads.
>>
>> Even in special cases there may be multiple different kinds of workloads constantly being used at the same time, e.g. a fullscreen game with live streaming / recording using VCN.
>>
> It looks like we can accommodate that now, see the recent discussion with Felix in the patch 5, where we see that "amdgpu_dpm_switch_power_profile enables and disables individual profiles,  Disabling the 3D profile doesn't disable the compute profile at the same time"
> 
> So I think we won't be overwriting but would be enabling/disabling individual profiles for compute/3D/MM etc. Of course I will have to update the patch series accordingly.
> 
>>
>> Have you guys considered letting the display server (DRM master) choose the profile instead?
>>
> This seems to be very good input, in case of a further conflict in decision making, we might
> 
> as well add this intelligence in DRM master. Would you mind explaining this a bit more on how do you think it should be done ?

I don't have any specific ideas offhand; it was just an idea that happened to come to my mind, not sure it's a good one at all.


Anyway, I think one important thing is that the same circumstances consistently result in the same profile being chosen. If it depends on luck / timing, that's a troubleshooting nightmare.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

