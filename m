Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39ADC021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 16:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA5210E76C;
	Tue, 25 Feb 2025 16:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="adc+lQDq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FAD810E766
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Oqd0tj54dtTlt6SVh36CRdIwy/AZx8xD/BwGYNqS8c=; b=adc+lQDqAu4/Q/BguZeP6XjsHx
 bhfFhX7/BXKd66xGc/xjuxWm58Y/pxJQVPl/5V/Y6mhwlxEmFehe1eE5ug2geaVGstiirCkUs4699
 9d/EYAObsJLcUyEcYJrBCJCYRw+QJBNkP5sNtsFC9Nke/cALaZpmXar+04QPgR4LvtHXK665/xoDD
 XQoUO2DjqoWMdTKTltx/dYMw7v30DO326BrpL+IJyan9j7PAFl24xGMg7w0H3sgVaJ+NtR3mYrPPV
 wie62LieBg1NKYlBDf3q4Wb3dMPbYbBvJeoIi1twAssN57c5NLMRU+VQOchwW4SfiqT5Mflcn/DNk
 rkg8MVrQ==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tmyAo-000UKL-Uj; Tue, 25 Feb 2025 17:52:52 +0100
Message-ID: <40982b41-2e48-47ad-b1bd-bc604a84313d@igalia.com>
Date: Tue, 25 Feb 2025 16:52:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fit one IB struct amdgpu_job into a 512 byte slab
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20250224120644.40148-1-tvrtko.ursulin@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20250224120644.40148-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 24/02/2025 12:06, Tvrtko Ursulin wrote:
> A lot of the workloads create jobs with just one IB and if we re-order some
> struct members we can stop that allocation spilling into the 1k SLAB bucket.
> 
> Before:
> 
>    sizeof(struct amdgpu_job) + sizeof(struct amdgpu_ib) = 480 + 40 = 520
> 
> After:
> 
>    sizeof(struct amdgpu_job) + sizeof(struct amdgpu_ib) = 472 + 32 = 504
> 
> It is not a huge gain in the big picture but every little helps.

FWIW it is also quite* possible to make two IB jobs fit into 512 by 
converting booleans to flags and shrinking some fields:

             /* size: 448, cachelines: 7, members: 24 */
             /* forced alignments: 1 */

So 448 + 2 * 64 = 512 !

That avoids spilling _any_ submissions, for example from Cyberpunk 2077, 
into the 1k SLAB bucket.

*) I said quite because as after I converted booleans to flags, which 
required u16 for 9 flags, shrunk vmid and num_ibs to u8 and 
job_run_counter to u16 (all of which seems completely fine), I needed 
just a tiny bit extra. So I shrank gws_size to u16. Being a size in 
pages that could also easily be large enough.

Regards,

Tvrtko

> Tvrtko Ursulin (2):
>    drm/amdgpu: Remove hole from struct amdgpu_ib
>    drm/amdgpu: Reduce holes in struct amdgpu_job
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  | 19 ++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++--
>   2 files changed, 10 insertions(+), 13 deletions(-)
> 

