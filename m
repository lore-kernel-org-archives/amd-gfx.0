Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69333C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 16:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11AB510E3A1;
	Thu,  6 Feb 2025 16:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YRRTxZPI";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FD310E3A1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 16:58:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B46055C5822;
 Thu,  6 Feb 2025 16:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BE8C4CEDD;
 Thu,  6 Feb 2025 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738861089;
 bh=WHDRtiiSHqS7lY57tgECv5PdHTBXHL0eUwhbeRTBnMQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YRRTxZPI4xJXsjxjYlpOI48K9E8A/EbseBZj/g8QX01JDURwBUpPI6Z4FbgYwGz22
 oUasZTo60Z76pj5cqbqn1n39hczXNs6pAyHe5RlKjTfgZs4XhTKuggCtWNJ/EY7ajH
 e/kX6EqIWmV2XbgmbFjvDx1V4XwcTURxNFX9EmV4gzo2r1noA+Q5eVU1ZzBlvw830U
 rgdzzYyuVybNhYo0Fe3n5wvnwmMHafjEo016FnMLb7eTDKeD+cdOCgJr20PEtVuhzP
 3VTIrbfbrGSkHiPXPk3oYxOZJ0UPhPe+1FgtItJ+Dgh+oFRqWe85l/Vy6jZdo5cV8e
 DkiMTf1lS6O6g==
Message-ID: <0da4a9f6-ecd9-4ff3-b397-d8da817da912@kernel.org>
Date: Thu, 6 Feb 2025 17:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] drm/sched: Job queue peek/pop helpers and struct
 job re-order
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/6/25 5:40 PM, Tvrtko Ursulin wrote:
> Lets add some helpers for peeking and popping from the job queue which allows us
> to re-order the fields in struct drm_sched_job and remove one hole.

I think you forgot to add the dri-devel list.

Can't fetch patches with b4. :(

> 
> v2:
>   * Add header file for internal scheduler API.
>   * Add helper for peeking too. (Danilo)
>   * Add (temporary?) drm_sched_cancel_all_jobs() helper to replace amdgpu
>     amdgpu_job_stop_all_jobs_on_sched().
> 
> v3:
>   * Settle for a copy of __drm_sched_entity_queue_pop in amdgpu for now.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> 
> Tvrtko Ursulin (3):
>    drm/sched: Add internal job peek/pop API
>    drm/amdgpu: Pop jobs from the queue more robustly
>    drm/sched: Remove a hole from struct drm_sched_job
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 22 +++++++++--
>   drivers/gpu/drm/scheduler/sched_entity.c   | 11 +++---
>   drivers/gpu/drm/scheduler/sched_internal.h | 43 ++++++++++++++++++++++
>   drivers/gpu/drm/scheduler/sched_main.c     |  7 ++--
>   include/drm/gpu_scheduler.h                | 38 ++++++++++---------
>   5 files changed, 90 insertions(+), 31 deletions(-)
>   create mode 100644 drivers/gpu/drm/scheduler/sched_internal.h
> 

