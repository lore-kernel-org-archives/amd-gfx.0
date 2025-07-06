Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360A1C83F03
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jul 2025 15:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABAC010E3A4;
	Sun,  6 Jul 2025 15:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rrhtRJvl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6969F10E3A4
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jul 2025 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nna9mds0/21QBTB4J4E6quIbcifR4OpiJizsc6b6QnY=; b=rrhtRJvlkRONDPyH+eEd5qO6Iz
 B7pMTCDx5liQzYA4UQimeXyRMuE1OWD8Rt0W8qIMZTcVNfecET73CeLxjO9TfaJj3UK8LOFLPzagh
 ROZvQM2esbgnU3653kxONcPQW3oJRbFlNJRpT5o4xeYKipRIwhtSHa3FfIQRc5WjnaQpgSWgFoWe6
 HOBCxYTcs232MM28HJF5UWcfK2vkFxdD/pUn53mOSu1FIVWOdRkkfad2suu1zfUlBnM+MfQ2p9DWm
 zspp8BWyO3zjLeLNr8CdwNHO4k9Y9RlbH5VCaLuBEP/6bYpO4+4CTwJdmk2EDbFhUplfeGW/F4k4L
 ozqbmTeQ==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uYQvv-00DAKS-9E; Sun, 06 Jul 2025 17:05:35 +0200
Date: Sun, 6 Jul 2025 09:05:31 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, sasundar@amd.com
Subject: Re: [PATCH V13 00/28] Reset improvements
Message-ID: <bcmfbiiod2gyn3u2fyimfbglvqt2ui2ouozklsoyskn3n6txmi@bvavettvg4lw>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
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

On 07/01, Alex Deucher wrote:
> This set improves per queue reset support for a number of IPs.
> When we reset the queue, the queue is lost so we need
> to re-emit the unprocessed state from subsequent submissions.
> This is handled in gfx/compute queues via switch buffer and
> pipeline sync packets.  However, you can still end up with
> parallel execution across queues.  For correctness in that
> cause, enforce isolation needs to be enabled.  That can
> impact certain use cases however and in most cases, the
> guilty job is correctly identified even without enforce isolation.
> 
> Tested on GC 10 and 11 chips with a game running and
> then running hang tests.  The game pauses when the

Hi Alex,

Which hang test did you run?

Thanks

> hang happens, then continues after the queue reset.
> 
> The same approach is extended to SDMA and VCN.
> They don't need enforce isolation because those engines
> are single threaded so they always operate serially.
> 
> Rework re-emit to signal the seq number of the bad job and
> verify that to verify that the reset worked, then re-emit the
> rest of the non-guilty state.  This way we are not waiting on
> the rest of the state to complete, and if the subsequent state
> also contains a bad job, we'll end up in queue reset again rather
> than adapter reset.
> 
> Patches apply to the amd-staging-drm-next or drm-next branches in my
> git tree.
> 
> Git tree:
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/kq_resets?ref_type=heads
> 
> The IGT deadlock tests need the following fixes to properly handle -ETIME fences:
> https://patchwork.freedesktop.org/series/150724/
> 
> v4: Drop explicit padding patches
>     Drop new timeout macro
>     Rework re-emit sequence
> v5: Add a helper for reemit
>     Convert VCN, JPEG, SDMA to use new helpers
> v6: Update SDMA 4.4.2 to use new helpers
>     Move ptr tracking to amdgpu_fence
>     Skip all jobs from the bad context on the ring
> v7: Rework the backup logic
>     Move and clean up the guilty logic for engine resets
>     Integrate suggestions from Christian
>     Add JPEG 4.0.5 support
> v8: Add non-guilty ring backup handling
>     Clean up new function signatures
>     Reorder some bug fixes to the start of the series
> v9: Clean up fence_emit
>     SDMA 5.x fixes
>     Add new reset helpers
>     sched wqueue stop/start cleanup
>     Add support for VCNs without unified queues
> v10: Drop enforce isolation default change
>      Add more documentation
>      Clean up ring backup logic
> v11: SDMA6/7 fixes
> v12: Ring backup and reemit fixes
>      SDMA cleanups
>      SDMA5.x reemit support
>      GFX10 KGQ reset fix
> v13: drop SDMA cleaups, they caused regressions in some IGT tests
> 
> Alex Deucher (28):
>   drm/amdgpu/sdma: consolidate engine reset handling
>   drm/amdgpu/sdma: allow caller to handle kernel rings in engine reset
>   drm/amdgpu: track ring state associated with a fence
>   drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
>   drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq reset
>   drm/amdgpu/gfx10: re-emit unprocessed state on ring reset
>   drm/amdgpu/gfx11: re-emit unprocessed state on ring reset
>   drm/amdgpu/gfx12: re-emit unprocessed state on ring reset
>   drm/amdgpu/sdma5: re-emit unprocessed state on ring reset
>   drm/amdgpu/sdma5.2: re-emit unprocessed state on ring reset
>   drm/amdgpu/sdma6: re-emit unprocessed state on ring reset
>   drm/amdgpu/sdma7: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg2: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg3: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg4: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg4.0.5: add queue reset
>   drm/amdgpu/jpeg5: add queue reset
>   drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring reset
>   drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
>   drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring reset
>   drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring reset
>   drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
>   drm/amdgpu/vcn: add a helper framework for engine resets
>   drm/amdgpu/vcn2: implement ring reset
>   drm/amdgpu/vcn2.5: implement ring reset
>   drm/amdgpu/vcn3: implement ring reset
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     | 90 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        | 15 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      | 67 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      | 18 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 43 +++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 76 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  4 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 41 ++-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 35 +-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 35 +-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 12 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 12 +--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        | 11 +--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        | 11 +--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        | 11 +--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        | 11 +--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      | 11 +--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      | 11 +++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      | 14 +++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      | 11 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 19 +---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 23 +++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 23 +++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 18 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 18 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         | 12 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 11 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 13 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 11 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 10 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 11 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 11 +--
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
>  36 files changed, 454 insertions(+), 280 deletions(-)
> 
> -- 
> 2.50.0
> 

-- 
Rodrigo Siqueira
