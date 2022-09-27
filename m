Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C57C07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 16:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2ACC10E231;
	Tue, 27 Sep 2022 16:33:10 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DAA10E231
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 16:33:07 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4McQCh01Qjz9sjH;
 Tue, 27 Sep 2022 18:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1664296384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcZkQmG2FwcF8Z4+AwVi4NlHF6otN4mV3LWchtPIRz0=;
 b=GjWoqQt1SP7v7ZvA4Iyn5f4HPo7d232mnLKUloTnPRqRXmEZ6JcYmWyMhDruXszx2IfHiJ
 yPMol+swRR7RRSVEMjiRbTVay5MtTMl44QIhNNRTgpq6w8lgWHcARV5LeIJDhPsqUkX4iZ
 dW3MOyY9CaPYY512DFVJcaS9PxvPhgHcOK3Hvovxv8V6EXParJQ9xoKBIcTKWw6t7nXeRl
 jjS57yav2eN3h4uNZq3EKdZCD8WDg/UR4orp3juASE/hV3qdAbsoqZ5I5th5Lw2aEfmpMZ
 7GIoUqe6nPPSYtbrNXZ57agTmbWmDbG+5sR/c0xUMVwlw+r3J2clqEZtkLlmFg==
Message-ID: <6ae60041-6db3-450f-2ac7-2f4415779818@mailbox.org>
Date: Tue, 27 Sep 2022 18:33:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/5] drm/amdgpu: switch GPU workload profile
Content-Language: en-CA
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-5-shashank.sharma@amd.com>
 <538ae193-37e6-40b2-cff7-bcbeab6e4fe6@amd.com>
 <824ff17b-16f5-e68e-736c-11e2c7027241@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <824ff17b-16f5-e68e-736c-11e2c7027241@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5fbc7f7a1358698f7be
X-MBO-RS-META: zdzgd499axrwq9eu7n7qjxd5eyzn8jwq
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

On 2022-09-27 13:47, Sharma, Shashank wrote:
> On 9/27/2022 12:03 PM, Lazar, Lijo wrote:
>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>> This patch and switches the GPU workload based profile based
>>> on the workload hint information saved in the workload context.
>>> The workload profile is reset to NONE when the job is done.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c |  4 ----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          | 15 +++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h          |  3 +++
>>>   4 files changed, 20 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index b7bae833c804..de906a42144f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -237,6 +237,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>>>           goto free_all_kdata;
>>>       }
>>> +    p->job->workload_mode = p->ctx->workload_mode;
>>> +
>>>       if (p->uf_entry.tv.bo)
>>>           p->job->uf_addr = uf_offset;
>>>       kvfree(chunk_array);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>> index a11cf29bc388..625114804121 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>> @@ -55,15 +55,11 @@ int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>       mutex_lock(&adev->pm.smu_workload_lock);
>>> -    if (adev->pm.workload_mode == hint)
>>> -        goto unlock;
>>> -
>>
>> What is the expectation when a GFX job + VCN job together (or in general two jobs running in separate schedulers) and each prefers a different workload type? FW will switch as requested.
> 
> Well, I guess the last switched mode will take over. Do note that like most of the PM features, the real benefit of power profiles can be seen with consistant and similar workloads running for some time (Like gaming, video playback etc).

Not sure how that's supposed to work on a general purpose system, where there are always expected to be multiple processes (one of which being the display server) using the GPU for different workloads.

Even in special cases there may be multiple different kinds of workloads constantly being used at the same time, e.g. a fullscreen game with live streaming / recording using VCN.


Have you guys considered letting the display server (DRM master) choose the profile instead?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

