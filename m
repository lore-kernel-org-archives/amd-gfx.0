Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A712ECA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 18:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4474E10E280;
	Tue,  6 Oct 2026 18:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CoaBr3zP";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8964E10E280
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 18:05:34 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48c4649b3aaso691307f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791309933; x=1791914733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iDP6o1Sogeqc2DCofeIiVaq9PcVk/McWEkTZoC+iyU4=;
 b=CoaBr3zPF4LHw6NU1laHpCPwDslQRfBicPFgDnubEr4g8LhyZMyMQ3yBG9XoN8Sezs
 HAFjptq8gZuFlHAASlY3eivrGfR7wDigGMpKj5UrYHPvQ9W38b9xadYTRhAGGRJon9ii
 qkw19oMkQdnA9zzc/2po6GrewlaOKC2S/xwFqAuaQAxEmw9LjhoQlktSuEy1RnYNNsoW
 DKbz+DZw8oJqJ3QdrvvcLlD9/1l69iK21EcYneqX0QzA3N/I5NcFlPyHuXs10Ykj+kDA
 7d5IQ4pV4JBMH63S7KG6XoxWUjo7jqeGMDb6kkTJOu2VkAwtQzYVykYkkUzdUoam/qzw
 YKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791309933; x=1791914733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iDP6o1Sogeqc2DCofeIiVaq9PcVk/McWEkTZoC+iyU4=;
 b=EPl7J+9lkLsOe2ohPnkyKlLVii9usGd4YKk5cjAK6W+o8XSYEHJeyGac4trdfaN1Ne
 z2+IaKYIX+yEv1Af2IQec2c0D2kUHIIdmQmOOOVUsRJghhOE/eQgY3CX+MtszgCcEjSm
 axXbnSE3ypLKRT2EUPYbrcX9mDEfAOZQj0CJYTK2hT4PzO/P+zVxnbPMa38kvwjCHvOJ
 bgC1Qlglp225divJxkYkqOEdxgi1PFmti6x/Ww46mQ7zJ6oD6DgLTBtUqqrhAo1E+DND
 OMPxlarTAd7GRSDbZF1Jl15Z6GfbV+B0LxxymnUuBqHIVxEAqVes+isf4DJ1redKPZeE
 sitg==
X-Gm-Message-State: AFq9FYK2/IoxyytsdpHNtw8n3+UAnCq5yJKi4WXXvS1xJCgejnwjf9zu
 3KvyY8BmPOMngFAVRaU+CsTWxXW4aR4sokxgim8Wpr2kErdWK+FN1RT1U7R/0g==
X-Gm-Gg: AYBFou3dXDNbIm1aHtMDR4eifVO8/JxwNC1Vpr4/9UcVeWJJj9nEKW/1IvQaJ2wDC4S
 gI3jlUzOa4SoUQhRXuwhkOPfv7DECLhMbSjkZyuEteuhblZTYQ20ExSM78LBzOWIbASiAqVfsdH
 SAg6WgeEjiieN6rgX0Yxq5VvMNnyBnUC6ov8vtKmK2ga+Q3Jj38qfNvekGkO+jKGxIw5TIi7cna
 8ZcWohlz1el2xbyBhe4BcHSo2WSjsDxdVzCFV8umGnugerjYApIdVmrY9nbFQrQkPI0Pby2db+E
 3J6i2VA4CbQIs+NhowwCIKkUZFgAG+Q+zNV6yoXN8ZmIAvwnboVTcuii/W2qYIGKhlFv9P74Xrh
 yL/nK5A/C92/iR2+PXzsjxnwipVFOuaz03zSGVY0pIotLbUnnj5x+gvq7eC8sKTHl5korqMGKL/
 c8oss9cnYXQF5lyBYkyzjE9zNGH89w0IKd5DGzo+wbpow9rGeMgdS75+XasCoTlIIg5ZUyNifGs
 6x4xnr/qcluUwJTXMTce19V8NroZ3PxsAtWG2OYy31TWxROKXjXPmioT7wOcclcdzHnz1FbCcUv
 5YNC8VXsdchOtiZ37TPogTBqo/e6uZAZB5m4mXVY9uvgJhseycEitHCTWwBnEqAGf2hrF7wvjDI
 MTTmz/dCzDZgFFItg5feN5QsQJkrFtnT0GtteN8zStamrwUmuWimBnXmMi4Kl/6I6aKHaDfxVG8
 9fRm5CQKnJLial6g==
X-Received: by 2002:a05:6000:470a:b0:48b:be3:456b with SMTP id
 ffacd0b85a97d-48c7278ef0bmr399687f8f.30.1791309932770; 
 Tue, 06 Oct 2026 11:05:32 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:41ef:ba36:bd76:1e3c:1e5:c273])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d04c0fsm948576f8f.10.2026.10.06.11.05.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Oct 2026 11:05:32 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amdkfd: fix NULL deref and unbounded wait in
 teardown_processes on surprise removal
Date: Tue,  6 Oct 2026 20:05:30 +0200
Message-ID: <20261006180530.54518-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <91edc04d-c635-41e9-8ce7-88bbbb2b5938@amd.com>
References: 
MIME-Version: 1.0
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

> That is clearly a really bad idea. Waiting for the termination *must*
> be unbounded. The real question is why those KFD processes doesn't
> terminate?

Ok, dropped timeout and chased the termination instead. Reproduced
it reliably (MI50 on Thunderbolt 3, ~2GB of SVM managed ranges +
queues, then pciehp Surprise+ slot power-off). The answer from the
hung-task dumps:

The process can't terminate because its own exit path needs the GPU.
SIGBUS -> elf_core_dump -> get_dump_page -> __get_user_pages ->
do_swap_page hits the SVM managed ranges and calls
svm_migrate_to_ram(). That submits an SDMA copy job to a killed
drm_sched entity (refcount_t warns + "push to a killed entity"), then
svm_migrate_copy_done() waits uninterruptibly on a job fence that can
never signal. The task wedges in D holding svms->lock, which wedges
svm_range_restore_work (rwsem writer) and the userptr restore worker
behind it -> kfd_processes_count never drains.

So the bounded wait was indeed masking the bug. v3 keeps the wait
unbounded and instead:

1/3 teardown ordering: on the disconnected path, fini_hw frees kfd.dev
before teardown_processes runs, so the drain wait can't even observe
the count (that's also where the NULL deref came from). Signal +
drain now happens while kfd.dev is still valid; the NULL guard covers
the second call.

2/3 unchanged from the v2 I posted (no ret pre-init, no warn).

3/3 new: SVM migration fails fast with -ENODEV on unplugged /
pci_dev_is_disconnected device (entry points + the copy-done fence
wait + stop rescheduling svm_range_restore_work on -ENODEV). The
coredump fault then just turns into VM_FAULT_SIGBUS and the task dies
normally.

Retested with the same workload + removal: process died by SIGBUS +
core in ~4s, count drained, removal completed in ~7s, zero hung tasks
or refcount warnings, and the eGPU re-enumerated cleanly when the slot
re-powered. Host survived; previously it wedged hard.

One thing worth flagging separately: the refcount_t saturation /
"push to a killed entity" warns show amdgpu_job_submit /
amdgpu_copy_buffer happily arm jobs on dead sched entities - worth a
gate there too, but that's beyond this series.

Related: the April "drm/amdkfd: Terminate queues on surprise unplug
with running processes" thread touches the same area (process
termination around kfd_cleanup_nodes) - 1/3 lands teardown earlier for
the same reason, and is compatible with that approach.

Series + repro details below.
