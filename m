Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821F2C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 15:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2720910E0E6;
	Fri,  7 Feb 2025 15:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YCQXbMu+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B7610EA93
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 10:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gZobp7uhETtRM3Vdn4n1bW7PPmFPaMh89jzntS6643g=; b=YCQXbMu+JJlqci52v8gYJgKupu
 kOaMNgztibqxpyHn8UGCLWCDAaSAVb7fGuDKdHOdHt7mstC5zq17ZKs7B3V9VZKF9p5X0oqJUqSmP
 VNt+6eyTNMXbp9GUQ0wHxwVwi7Ltnj/KpFYyLUfIwdw3+Db+qkfLfeo8z9IIHDcZEgd/nOBnHS7ZK
 qjPC2LPrkQY6Jnd/T+DRCNwoTMB6ZrXXBuZBMNePWOtsdJnbyenfO6IR3qJWpnOCmwKZZaX+E5lcF
 dNbjTKQHUV/8Gvt4ywkizw99m0YbqiEOoyJSfd/5qyOof0Oul0l2OgfDmrL5zaicce7oGII2E9qf9
 XcrLfbJA==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tgLMF-005kR1-Kn; Fri, 07 Feb 2025 11:13:17 +0100
Message-ID: <ec5c1b82-f87a-476b-9e9f-aae6deb63524@igalia.com>
Date: Fri, 7 Feb 2025 10:13:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] drm/sched: Job queue peek/pop helpers and struct
 job re-order
To: Danilo Krummrich <dakr@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
 <0da4a9f6-ecd9-4ff3-b397-d8da817da912@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <0da4a9f6-ecd9-4ff3-b397-d8da817da912@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:29:43 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 06/02/2025 16:58, Danilo Krummrich wrote:
> On 2/6/25 5:40 PM, Tvrtko Ursulin wrote:
>> Lets add some helpers for peeking and popping from the job queue which 
>> allows us
>> to re-order the fields in struct drm_sched_job and remove one hole.
> 
> I think you forgot to add the dri-devel list.
> 
> Can't fetch patches with b4. :(

Hmm I probably blundered with git send-email --identity. Will re-send 
after we close on opens from 1/3.

Regards,

Tvrtko

>> v2:
>>   * Add header file for internal scheduler API.
>>   * Add helper for peeking too. (Danilo)
>>   * Add (temporary?) drm_sched_cancel_all_jobs() helper to replace amdgpu
>>     amdgpu_job_stop_all_jobs_on_sched().
>>
>> v3:
>>   * Settle for a copy of __drm_sched_entity_queue_pop in amdgpu for now.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>>
>> Tvrtko Ursulin (3):
>>    drm/sched: Add internal job peek/pop API
>>    drm/amdgpu: Pop jobs from the queue more robustly
>>    drm/sched: Remove a hole from struct drm_sched_job
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 22 +++++++++--
>>   drivers/gpu/drm/scheduler/sched_entity.c   | 11 +++---
>>   drivers/gpu/drm/scheduler/sched_internal.h | 43 ++++++++++++++++++++++
>>   drivers/gpu/drm/scheduler/sched_main.c     |  7 ++--
>>   include/drm/gpu_scheduler.h                | 38 ++++++++++---------
>>   5 files changed, 90 insertions(+), 31 deletions(-)
>>   create mode 100644 drivers/gpu/drm/scheduler/sched_internal.h
>>
> 
