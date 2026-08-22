Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2922CC61CE2
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Aug 2026 09:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8800010E4D2;
	Sun, 23 Aug 2026 09:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EAoA7Sxp";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3285310E108
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Aug 2026 15:11:02 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-81f3b227a4aso32626017b3.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Aug 2026 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787411461; x=1788016261; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tl+ydfXGpsApHyYdqtis4MbvgFxpMIFRVTomZ0enFKw=;
 b=EAoA7SxpSSGkKhYYdbhCn6Lh77naqJxmAPkMYxO8H4QdWPCFTzZbeMkS/fD/t1FSKi
 GYyrgNOMBgiEvKW8HLBlAxTptzFqw0jotJ2cLgFlONfwqUjg0F2rJp30r27Hr1Y4aw6g
 N1XyW6tuAUFwDJFyzvgLpocW7OdGXQLQmZ/3W9R6EVYnbDUKtTAcJ8nM9OpY3TnnKP3j
 IPZHi/Z9NiPdpwDGyYBPIWzekB4IqNA5Y5Rd7zX6PyKlR9TyHqES69KAHvFg9CVuXTwq
 rMk+cbAkL2hBu4CeVVL/NtBeRFr7i/QP73MoJXxevmJRh2dqfrsjF9/urEdq5SSyUQMM
 2dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787411461; x=1788016261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tl+ydfXGpsApHyYdqtis4MbvgFxpMIFRVTomZ0enFKw=;
 b=Rt/jtB054pM2GjSJAExsAbbOadSHFwaizzkyViku+1GzX3tgdBl1GE29UtL4gmH3Nb
 B1ITTnp4qO7L5jgPUlDfQKvGctiKKczxUJPfYUTHaNBUfg68TwUawC9XTzz//Jk0JjZl
 bhowFNmzqB0yROkiZ6c3lN9KHXikGzH8xNuSXFlXnYE56y+PZuLRX8pEpKC1BB+D4JaF
 6NvXJ6DNtBocYCb3Y9WSf7IA0WjOP8Egaj1UEZFIzvsIWS+PB/QlTvtMSNfu0NAIxVsZ
 In5OazX5fXTtwm0VWsk+q2UL8vov/6akYM0M3NqwiHmJ85DjviTCBpau0fsf6H15uZGW
 Bm5w==
X-Gm-Message-State: AFuF++lTae3+toOnn6cdu6XU6uOwyBDzUUz1cgvHM2GVqL8/xGgu+Tik
 dRxylasau96GaDAzSApHt3b4bqMK2CMGwc94EAn0ykosmmIbehe2omybme4poruHBrQ=
X-Gm-Gg: AR+sD10GPGzH4CT7BxTvheAM9k7E2dTub8f1KuhgpJUbALO4CSk/GQb0JFolLY0KtfI
 S7+uqY/JnnAVqyXCWSyfccSWHqtNFf9AzRlfFieponm2u96Bbmb5/0DyMiRm8dezb4T3hHvULcU
 PWdS92x9owepT2pmnfFJnrEa+8bL0qd+6x26GD/cehW3cYGJAzgeTZsLafsoQraaKiSTpK9M+78
 e5w1OdU1MBPb9DZSUbNoGqZLrekgUZObV+qbH4ZZZcdEC3QhhhEjlKIelTIS3mfPhIx7oPBzGDD
 bL0SWLjwcD3Z9tr6zlGBna4ThuenLgh3FuTadJtbCf2BmTxQP2z4WZRZB6kqmPJbBZNs1MjDajl
 WLbewSLsYx+OLoL6k+c+7lL2e2axoTPJaiX+IPNQnfSlvwUbLfJgL+yNKDU8+lXeh4AOWnfHCKQ
 5Kh9lFn+3AfKOAXAIAtW59YCCyQqUwuVE33zA/XQbYx66To8vsvbN0u2Z01LvE+fI82Llo+VuGS
 dt5V8BCBUg94/x5O77xZEgSv9OSPzrATpcbEXTAMY+aVDXwgu/CSliM9UNXIYSh1Lu0EYzaaxL0
 8WU=
X-Received: by 2002:a05:690c:7001:b0:82e:3aea:fa5d with SMTP id
 00721157ae682-849f245444cmr61904547b3.15.1787411460944; 
 Sat, 22 Aug 2026 08:11:00 -0700 (PDT)
Received: from DigitalOasis.tail29fcbc.ts.net
 (104-182-93-176.lightspeed.brhmal.sbcglobal.net. [104.182.93.176])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-84cac01026csm11076757b3.39.2026.08.22.08.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 08:11:00 -0700 (PDT)
From: Bocaj Gnuoy <bocajgnuoy@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 oded.gabbay@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bocaj Gnuoy <bocajgnuoy@gmail.com>
Subject: Re: [PATCH v2] drm/amdkfd: don't leak BOs when process teardown can't
 unmap them
Date: Sat, 22 Aug 2026 10:10:46 -0500
Message-ID: <20260822151046.966976-1-bocajgnuoy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822144402.929677-1-bocajgnuoy@gmail.com>
References: <20260822144402.929677-1-bocajgnuoy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:28:04 +0000
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

Correcting a factual error in my own changelog before anyone spends
review time on it.

The changelog states:

  "Note the free path itself does not allocate - it reserves the BO,
   detaches the attachments and drops the references - so it can
   complete even when the unmap could not."

The first clause is wrong. Immediately after the -EBUSY bypass,
amdgpu_amdkfd_gpuvm_free_memory_of_gpu() calls:

	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
	if (unlikely(ret))
		return ret;

reserve_bo_and_cond_vms() uses drm_exec_prepare_obj(), and drm_exec
allocates its object array with kvmalloc_array()/kvrealloc(GFP_KERNEL)
and returns -ENOMEM on failure; drm_exec_prepare_obj() also calls
dma_resv_reserve_fences(). So the free path can allocate, and can fail
with -ENOMEM.

Bounded consequence
-------------------

The forced free can therefore still fail, after which
kfd_process_device_free_bos() drops the idr handle regardless - the
same ownership violation the patch addresses, one level deeper.

This is not detectable through the teardown WARNs. The BO is removed
from process_info's lists before the reservation is attempted:

	/* Make sure restore workers don't access the BO any more */
	mutex_lock(&process_info->lock);
	if (!list_empty(&mem->validate_list))
		list_del_init(&mem->validate_list);
	mutex_unlock(&process_info->lock);

	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
	if (unlikely(ret))
		return ret;

That ordering is deliberate, so reordering it is not a fix. The
consequence is that if the reservation fails, the attachments are
never detached and the free does not complete, but the lists that
amdgpu_amdkfd_gpuvm_destroy_cb() checks are already empty. The stale
lifetime condition implicated in the deadlock can therefore survive
without the WARNs firing. I have not driven that particular residual
failure through the eviction path and observed the deadlock, so I am
describing a reachable state, not a reproduced one.

Scope of the change
-------------------

The underlying violation is not introduced by this patch. Upstream
today can already reach it:

  mapped_to_gpu_memory == 0
    -> delist
    -> reservation fails
    -> free returns error
    -> teardown discards the handle

This patch additionally permits:

  mapped_to_gpu_memory > 0 after a failed unmap
    -> bypass -EBUSY
    -> delist
    -> reservation fails
    -> free returns error
    -> teardown discards the handle

So it widens the set of states that can reach the violation rather
than creating it. That is not offered as a justification, only as
scope.

What the testing does and does not show
---------------------------------------

The pr_err() this patch adds to kfd_process_device_free_bos() is the
only instrumentation in the patch that directly observes a
post-delisting free failure. It did not fire in any run, including
one with 1904 "failed to validate PT BOs" and 35 forced frees.

That is consistent with the drm_exec allocations being far smaller
than the page-table validation that failed, and therefore satisfiable
under the same pressure. It is a probability argument, not an
invariant.

The accurate evidentiary statement is: the fix reliably completed in
the tested pressure regime, but the implementation does not provide an
invariant guaranteeing teardown completion under arbitrary allocation
failure.

What this does and does not change
----------------------------------

The reproduced failure is unaffected: the unmap fails in
vm_validate_pt_pd_bos(), mapped_to_gpu_memory stays non-zero, the free
returns -EBUSY before list_del_init(&mem->validate_list), and the BO
is stranded. This patch removes that, and in every observed forced
teardown the cleanup completed and the machine-killing relaunch
stopped happening.

What the error invalidates is the completeness claim, not the safety
argument for forcing. Bypassing -EBUSY on irreversible teardown and
detaching the bo_vas when the reservation succeeds is still supported
by the evidence. What I can no longer claim is that the cleanup is
guaranteed to succeed merely because the failing page-table operation
was skipped.

v3 will correct the changelog and state this as an explicit
limitation. If the residual allocation failure should be repaired
rather than documented, there appear to be several possible
directions with different locking and lifetime implications - a
retry, a reservation path that does not allocate, or deferring
ownership so a later pass can free the BO, among others. I would
rather have maintainer guidance on which is wanted than guess at a
lifetime-ownership decision.

Thanks,
Bocaj
