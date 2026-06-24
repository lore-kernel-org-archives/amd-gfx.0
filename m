Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE6DCDB47C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 11:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C46010E637;
	Wed, 24 Jun 2026 11:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="enkBLeea";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0875C10E637
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 11:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iMqsYI7AWNT5Cvq/7zUV1A70eaQM5TXoVfLRveCNpwI=; b=enkBLeea229k94S64FNdUfQqu0
 JE5PEisur4WLSVLNTHKQjLvbSfzFWJbKMVUaO0TQNi8iyaxoZ42sdy4jKgG6eZOMn7MRHHhY1kfn4
 um4dF0YA8SEhi1bYVWvY+JIdp3+wBUp8/dqaeTYsWbZBkedmrNJywNHm4Wogc6Yztxc8bc2qyOpyb
 ouhDgtwRAfgAMe15E1N4qu0imWMOfemq9GRsE/w3OAZzHzB21rE2V+b1YkJKZqknW0RoOMT7ferjq
 adaVqgohuywADUPzYxMs7QAu2mPiSfTOGCIhl/tlVLsTIhXU9Sb2rL2LfhMVPGmowK97qid8FEA1j
 mxply9Pw==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wcLMX-004ZPz-WF; Wed, 24 Jun 2026 13:01:46 +0200
Message-ID: <83fb4528-326f-4c32-a4e1-2cba75c257bb@igalia.com>
Date: Wed, 24 Jun 2026 12:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix typos in comments for IP block soft
 reset
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOh?=
 =?UTF-8?Q?k?= <maraeo@gmail.com>, Lazar Lijo <lijo.lazar@amd.com>,
 Martin Roukala <martin.roukala@mupuf.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20260624073829.40835-1-timur.kristof@gmail.com>
 <20260624073829.40835-2-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260624073829.40835-2-timur.kristof@gmail.com>
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


On 24/06/2026 08:38, Timur Kristóf wrote:
> These typos were accidentally overlooked. Let's fix them now.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index ab5df854c1d20..dad04a88179cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -942,7 +942,7 @@ void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
>   	 * Give some time for non-guilty rings to finish their
>   	 * current submission, to try to minimize collateral damage.
>   	 *
> -	 * Note that this just a best effort, but really there
> +	 * Note that this is just a best effort, but really there
>   	 * is no way to really know which ring is actually responsible
>   	 * because different rings may share resources, eg. a compute
>   	 * ring may hog shader engines, causing a graphics ring to hang.
> @@ -1003,12 +1003,12 @@ void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
>    * @guilty_ring: The ring which is guilty of causing a reset.
>    * @ret: Return code from the reset function.
>    *
> - * After calling amdgpu_multi_ring_reset_helper_end()
> + * After calling amdgpu_multi_ring_reset_helper_begin()
>    * and executing the actual reset method, call this
>    * function to restore normal operation.
>    *
>    * In case the reset failed, this function should still
> - * be called to restore some state, but it won't attempt to
> + * be called to restore preemption state, but it won't attempt to
>    * fully restore the ring contents.
>    */
>   int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
> @@ -1032,7 +1032,7 @@ int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
>   	/* Flush HDP cache so the GPU can see the updated COND_EXEC values */
>   	amdgpu_device_flush_hdp(adev, NULL);
>   
> -	/* If the reset was unsuccessful, return without restoring anything. */
> +	/* If the reset was unsuccessful, return without restoring anything else. */
>   	if (ret)
>   		return ret;
>   

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

