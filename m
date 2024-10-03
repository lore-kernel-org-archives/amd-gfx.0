Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CD2CFA756
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 07:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13E710E8AE;
	Fri,  4 Oct 2024 07:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="W2BcBRvY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83B3B10E35C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 08:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wP1JycnOb11Eam3t9qyAt4OWDNYGwMHR56M0aRSc7NU=; b=W2BcBRvYXismH897lM9JmH7Jm0
 tSfg/LCSQgJ6rHSn0d07ZN7aOWDLjdFWfsg3nzz1LY0//6yAp9yfokP4P6vnVlIU5L1dJeF/mwaCx
 Qw7u/+mkjjuhgFCXn2BFvuYpt8ZxJBGPuQFwMb6vpUO7T1yQQaYk+olq8nNYz+GDLojRWBU3DO6W2
 f2uJyVmdBniF+mlFdf0/qx+Gb+M5pHjwmFTwCaZdXUyJFo1KXxaEB5IjJUqTyMO4dJYTaC1qGWRFC
 /T6hzG5jkGTbaV1tee5Jwpow8ycPAEv+pfaLiqtYEjI0mbawsyryRCdduvomPlnBvEapYlfdNFdly
 AsEh8/1Q==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1swH5S-004Eq3-Ps; Thu, 03 Oct 2024 10:21:26 +0200
Message-ID: <3e1ad979-a11e-43bd-8488-52712b58cec1@igalia.com>
Date: Thu, 3 Oct 2024 09:21:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Remove the while loop from
 amdgpu_job_prepare_job
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20240924095145.2281-1-tursulin@igalia.com>
 <20240924095145.2281-3-tursulin@igalia.com>
 <6a7005b4-6af3-48e3-be65-353ffb5961f5@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <6a7005b4-6af3-48e3-be65-353ffb5961f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 07:28:27 +0000
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


On 24/09/2024 13:06, Christian König wrote:
> Am 24.09.24 um 11:51 schrieb Tvrtko Ursulin:
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> While loop makes it sound like amdgpu_vmid_grab() potentially needs to be
>> called multiple times to produce a fence, while in reality all code paths
>> either return an error, assign a valid job->vmid or assign a vmid which
>> will be valid once the returned fence signals.
>>
>> Therefore we can remove the loop to make it clear the call does not need
>> to be repeated.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
> 
> Oh yeah that's a leftover from when we still had the dependency handling 
> inside all this.
> 
> Reviewed-by: Christian König <christian.koenig@amd.com> for the whole 
> series.

Thanks - CC Alex if you could merge the trivial series please?

Regards,

Tvrtko

>> ---
>> I stared for a good while, going back and forth, and couldn't see that 
>> the
>> while loop is needed. But maybe I missed something?
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index d11cb0ad8c49..85f10b59d09c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -356,7 +356,7 @@ amdgpu_job_prepare_job(struct drm_sched_job 
>> *sched_job,
>>       if (job->gang_submit)
>>           fence = amdgpu_device_switch_gang(ring->adev, 
>> job->gang_submit);
>> -    while (!fence && job->vm && !job->vmid) {
>> +    if (!fence && job->vm && !job->vmid) {
>>           r = amdgpu_vmid_grab(job->vm, ring, job, &fence);
>>           if (r) {
>>               dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);
> 
