Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE58CA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 09:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DF310E91E;
	Wed, 30 Sep 2026 09:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AhV9q4Kl";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81ED10E91E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 09:03:28 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48aef5d66c1so1098946f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790759007; x=1791363807; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xw2/+ozrc4J9brQA48GMQ6vkyz9q9SCUPEFr5E0FVQw=;
 b=AhV9q4KlZgnI5bozYjFKdnSDUveyySQaOJbkNb7+EcVdguhCqLxLzeJ05SVdWfC07m
 shpDjBuNtcpTvNDRWxkDR4y/ANs/bpyLAlRoUrQS+so2STvPIjKbK0DaFwpTReLele6g
 VSatVw6ovfj2RvaNNp9RUvxX8qqt7S65lcUZdQiVq3/8ZOVntRHFuIvTLTL94hhpBqZJ
 50xcd+9pJRZ3kk4Y5/MrZ9aLVKy6JkkzwYX6/0b6Ucc4m8/aCGu0INitzCHesCRn4bwA
 At95ekiAbNN+0XlY3WBx7g0rCI2oG0izbdCxcVhqy8HVCEQioJ0Pu4zUY0bYBSA8Ev4R
 dFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790759007; x=1791363807;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xw2/+ozrc4J9brQA48GMQ6vkyz9q9SCUPEFr5E0FVQw=;
 b=JnLl2U0J2rWwlLNx7wFuVZdJnN/YySWsrrGmmMeYvB0tRMmXUSX1+vcmff/NM2/nnL
 X2TzBhgw3Zyrr3X1tTuwy6qUOT/hHFt8h6hitpXN10Z9WxbWyPJnrjyY228knkT3sPR+
 OGYNwVD41HqZHOdiuwtqAhkwfcdEc4wQqnUYUW4k4LZ3814vwcG89Jy9IuQeHYyKEzr0
 EKH4AF8hbgPV/UptRgOGbhtuY9xiwNKCllB9/g08ZiO1o1jQbaaS0sk5hb9AJNqU9Wxh
 b+M680Bxt5h+DN7YlDWVZZM5VDELAAHXhl/LliNH0hZ5QekAS5Yp0PLkVZwdC3nS/A8e
 6x7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/3NVN8tcGtryezc+h4mal7qH2XQbyV4yJG+DwcTfrDKJQfg5mNx3adu1mtiWINjheh/sSQTtt@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKfaUHYvaCxGkh2sn8c/6aMcnxT1w14D6/sA+GPdDjdN2u+04nn
 9Wm8R0g/iUB1/3PkvQaVH+vWUM96QEz2lvLsD3ZqxMJoi0oCBB+0yFM1
X-Gm-Gg: AYBFou3++tzxsr9eEoeHVQmve+xBaFTSJL26W/WZX40lAFyk/vJJdhwSwifZRqvh0pR
 JQsG8Ajkq+ExT+4F53t6g2MhTndKDpqnbX8iImUUJMkrQTX+yQyfJv0lvicBNsj9vk6tvVrF0Nh
 2b/cw25UP2oXlqebEPm6V6fv/Y6iLwV8ytt/yvQYwZeCZ3hm/FM2oqyUYIk4zTYiyyg0L1Ku4z9
 uBZANWkjnFH/A0TKCYXJgdGcA26lWPX2H+PDLaBdY11+SEyQXeGV5x2PzzhnFwtY2P8baokjuAM
 dv/X9ht9d6A8Y1Ly7gvG7IShSg/xTTCMhxpfF7t6LtqfPHWTDAZuoUNFyXsUr8GBWnqhy90PrKg
 7G9tIQ36Bkk85ZeBFco5RX2YJZ97g/Yl3gQQMQ0TOqM+gkS8ihBdIzmbrKVa1MdD+iDn4NKowty
 FZsOZQvDuYefsZKBERuEM6ZfQ04a8xgdiYAAu+kkvg8PY5A38sQReGVAYe90jK95hOjhbLuLw3K
 r/xxi4tRY4sEEVG/39Rfk6QHhZLg6vYmdKkb5Q8OE2pdrAdn6NHf3p9IQ/RLhbml7jxk+fQnAWR
 jrngy1q8MnDQ3Mpx9qDi9vsahh5EBcpmqArgUDZB1IFn7HemAi14aNEgXrHth7FdncBQ0dH7pF9
 c2QkOfW9ON1lJNlv6//K5dnF20TEUD53eWE+sVHegcfUE9EPJ+yRJdUdORmt0sjJOHTisR44bYq
 oppOaF8UwwGixU6EM=
X-Received: by 2002:a05:6000:4a07:b0:487:9a9:6d24 with SMTP id
 ffacd0b85a97d-48b024bd031mr1653013f8f.19.1790759006604; 
 Wed, 30 Sep 2026 02:03:26 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:415f:3423:d0fc:6384:3b6e:b871])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f5bcdsm1910233f8f.27.2026.09.30.02.03.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 02:03:26 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: olivier.kaloudoff@gmail.com,
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 06/13] drm/amdgpu: add amdgpu_vm_update_leaves()
Date: Wed, 30 Sep 2026 11:03:25 +0200
Message-ID: <20260930090325.46167-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529114031.3714-7-christian.koenig@amd.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Christian,

while testing this series (applied on top of 7.2.6) we hit a regression
in amdgpu_vm_update_leaves() that deterministically produces MMHUB
page faults under KFD SVM load on gfx906 (MI50 32GB, Vega 20, PCIe via
Thunderbolt 3 eGPU).

> +		pt = cursor.parent->bo;
> +		shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
> +		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level - 1);
> +
> +		/* Looks good so far, calculate parameters for the update */
> +		pe_start = ((cursor.pfn >> shift) & mask) * 8;
> +
> +		entry_end = ((uint64_t)mask + 1) << shift;
> +		entry_end += cursor.pfn & ~(entry_end - 1);
> +		entry_end = min(entry_end, end);
> +
> +		nptes = (entry_end - cursor.pfn) >> shift;
> +		/*
> +		 * This can happen when we set higher level PDEs to unmap and/or
> +		 * silent to stop fault floods.
> +		 */
> +		nptes = max(nptes, 1u);
> +
> +		trace_amdgpu_vm_update_ptes(params, cursor.pfn, entry_end,
> +					    min(nptes, 32u), dst, 0, flags,
> +					    tgid,
> +					    vm->immediate.fence_context);
> +		amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
> +					   cursor.level - 1, pe_start, dst,
> +					   nptes, 0, flags);

When amdgpu_vm_pt_descendant() cannot descend (a gap — the position has
no leaf table in the tree), the write targets the parent's slot at
level-1, i.e. a PDE slot. nptes as computed above covers *every*
remaining slot up to entry_end (the end of the parent-table span,
clamped to the op end) — not just the slot the cursor is at.

The old code had an explicit clamp for this exact case, in
amdgpu_vm_ptes_update() under params->unlocked:

	if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
		/* only clear one entry. Next entry search again for PDE or
		 * PTE leave.
		 */
		entry_end = 1ULL << shift;

That clamp was lost in the rewrite. Without it, an unlocked unmap
(PATCH 08/13 wires amdgpu_vm_unmap_range() to update_leaves()) that
hits a gap *before* still-linked sibling subtrees will clear their
parent slots too:

  - the gap's unmap write covers N parent slots (we observed runs like
    pe 0x58 n15, pe 0x60 n14, pe 0x68 n13 — each gap position
    re-clearing the whole remaining tail of the parent page),
  - sibling PDE slots inside that span still hold live child pointers,
  - the write overwrites them with the PDE_PTE-only marker
    (0x40000000000000 in RAM — bit 54 set, no address),
  - the in-memory PT tree still considers those subtrees linked, so
    their needs_update is never set and a later amdgpu_vm_update_pdes()
    pass does not re-link them,
  - the next GPU page walk through that slot reads a non-pointer and
    faults: "memory access fault ... reason: PTE not valid" (MMHUB
    no-retry).

Captured write ordering (instrumented amdgpu_vm_pte_update_flags /
amdgpu_vm_pde_update, job ids tagged):

  MAP_RANGE    PTEs pe 0x368..0x800        (big map)
  UPDATE_PDES  pde 0x0..0x1a8 links, incl. [0x80] -> child 0x5d4dd0000
  MAP_RANGE    PTEs pe 0x58..0x1e0         (re-map)
  UNMAP_RANGE  clear pe 0x58 n15  -> covers 0x58..0xc8, incl. 0x80
  UPDATE_PDES  relinks 0x58..0x78, 0xf0..0x1f0  -- but not 0x80..0xe8
  FAULT        slot 0x80 reads 0x40000000000000,
               tree still expects 0x5d4dd0001

The unmap's clear overshoots slot 0x80; the relink pass skips it
because the subtree was never dropped from the tree. This is fully
deterministic — our reproducer (vLLM/ROCm loading a 10-shard model,
i.e. heavy SVM map/unmap/re-add churn) faulted at the same stage on
every run.

Locally we fixed it by restoring the single-entry semantics for
non-leaf slot writes:

	/* only clear one entry, next entry search again for PDE/PTE leaf */
	if (cursor.level < AMDGPU_VM_PTB)
		nptes = 1;

(nptes = 1 rather than re-clamping entry_end, since entry_end is only
used for the tracepoint afterward; either form works.)

With the clamp restored the full workload completes cleanly — all
checkpoint shards load, engine serves inference, zero page faults
across repeated runs and reboots.

Two questions:

1. Is this already fixed in a later revision of the series? I tested
   the patches as posted on amd-gfx (2026-05-29), not a git branch.
2. If not — since 08/13 makes the unlocked unmap path use
   update_leaves(), everyone driving SVM eviction/restore traffic will
   hit this. Would you like a formal patch, or do you prefer to fold
   the clamp into a v2?

Full debugging trail (STALE PDE dumps, write histories, vanilla diff)
is available if useful.

Regards,
Olivier

== Environment ==
  GPU:       AMD Radeon Instinct MI50 32GB, gfx906, 0000:05:00.0
             (Vega 20, PCIe via Thunderbolt 3 eGPU enclosure)
  Host:      AMD Strix Halo (Ryzen AI Max+ 395), 28GB RAM, Proxmox VE 9
  Kernel:    7.2.6 + amd-gfx VM critical-section series (vmcrit 1-14)
             + TLB invalidation V3 series
  Workload:  vLLM 0.28.0 (rocm, gfx906 build) loading GLM-4-9B 1M
             via KFD SVM; deterministic fault during weight staging
