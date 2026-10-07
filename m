Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404BBCA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40A010F706;
	Wed,  7 Oct 2026 17:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p0D0grdw";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F05F10F727
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:24:09 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so13846065e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 10:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791393848; x=1791998648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+YQ9VJwdmBqPuhxs52/Rq+3eKZ9EUV3KDaxAaKvkK0U=;
 b=p0D0grdw7m1TKjGOiTocWBmBmgZzAG97i9lcoYs2SYk8YAiwBvlJWJK8+KSB66MN3O
 Nhzj0rZCU2sa85paPGIdV8V4qO2h5biMuNPAXtxO+RcEpImupSE8ziUHqhbyMa0v+F7m
 SFdTOgs1bjYQg6zOYSrFHW2Z9p+EaPZSN4ye/bGv0X5bUb6endbi3NTLUkMKyEStji5V
 Cl0M2B2qbGurE7oexO01TbIzQpvxjBKrq20y3GnnwlthT6VRmpjG8zulLMTlI6r7Lr+C
 8kJJAlOxKmlufTQu7t+bwpgfkAtKC9WeUp3/8wR540L9ASLpZD7SDe8lGezfleK0sinf
 GRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791393848; x=1791998648;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+YQ9VJwdmBqPuhxs52/Rq+3eKZ9EUV3KDaxAaKvkK0U=;
 b=aSEgp0NvSVPnmUCGrcHi0ZEBSrCcDSthW2fA8+LMy4y3W7EGC3o0amKqGgcaIPtlyd
 OLpDDdQwWwBi46HVnGZfsRYH0xaKbGmmB+TGAH25dTLxR7hU/RoeD31MSkLbGWRkYItK
 RXgeyKZKzdvmfrhG7X4pMGmKJyRZGSDVcWVvZvZ5QRylPe/Zq5/OgUTVyN9btP2o0O/k
 Sp8hKKAY1in1eNOW3C6VYBay8n7xVxutmoXmkQ3rVCAnDghHzCOv+wmXoL5pWsxfmmDM
 gUOrW07PEtKlFpUQBCO0TJplQSuYDlUZOOPGxIAhrkLwu+dCcL0nsilGf53jrJbu5EJd
 9Z+A==
X-Gm-Message-State: AFuF++kLpRYB1UNuQnsfEIRCsMJZRjCzd71wQbjGMLPSpGeuXnYNpmiM
 7ar2irJn7CsSrtVroqR+Z1NTqVUTA1ge/4TS9a8xynSL/OQoXiVG1BLK0edYE2IrhKA=
X-Gm-Gg: AYBFou0nCojsqFBU4NtTRN7PtZfqJh5bOdXdl52GTZ9Pm31ot2z0Xo9d87ta74XisDS
 MirfaKNkNn9m/zmW8RjLQPNTyIgk76tlAtLPduV4qbhrUqyB565HkA8kIXxu5QBSmjz/1m9GT/M
 RTLEgSIndjxkPdIz4+xbdhgD80t3+K7AfbrAA6f5H5xij1kV2/u8P9zGG784GK0ZtzYPcJcyzqf
 XzBrDHn7CHJUilnpcnDKCtdi3edQ+SMfzXo5t9SDhbvxJODuklKeDaI95TqgJb1yn8tzksvKwiO
 bhI3kbMldN7hAzJtmj1fBlrUlVmfEZCBY/6+GbeaIyqkhX9V9n8mnjztt+2TXv0IS2Bf5SRwfq/
 9s6tuufi8FMdhHoiQ4soZErOkgz9hgiHub8dQ55jjE7yrc2kLo9QvC/plHdJ4OiB2tQ1XIWT57D
 nJu6Jf0CsrtRF6ybbmpkToVP/iW7TsMm4igsnBRw0S4Rfc+Krr5ynSGcL8fZQVBFrhCJSoXbTO+
 w3f2Q6P/W0YD+MpPVo7mL9EVCunCglal1oN0TONZjSy092s2sV/0Ua5xZ+rFOXFlG5JuoKghrRW
 JSyD7sUp79nRLkpziRiCX/W1UPb6c5wURZmp5RQtYVm+aDrsY4QHYr9F0ZGGla3otrlMChe3qd3
 Q9mIIbMIfYCbie6g9qbWVCWJTqaw+7jyngHdQxJ0rsmxb/Ztsm46n6MhEsHFpasDOMi32WhciXU
 MCoHRqBxP3SBbcpbU=
X-Received: by 2002:a05:600c:3b8d:b0:49f:fbad:29c1 with SMTP id
 5b1f17b1804b1-4a1806611acmr58312405e9.33.1791393847542; 
 Wed, 07 Oct 2026 10:24:07 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:413e:676b:9d85:c07d:dc5e:c7c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1842a16b2sm6610665e9.3.2026.10.07.10.24.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 10:24:06 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v3 3/3] drm/amdkfd: fail fast on unplugged device in SVM
 migration paths
Date: Wed,  7 Oct 2026 19:24:04 +0200
Message-ID: <20261007172404.11271-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <73a76f1e-48ce-4e4f-9812-2fb79a1991c1@amd.com>
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

Hi Felix,

> I'd avoid arbitrary open-coded timeout values. Would
> AMDGPU_FENCE_JIFFIES_TIMEOUT work? It's currently half a second.

Yes, that's better — will switch to AMDGPU_FENCE_JIFFIES_TIMEOUT.

> This seems racy. Should we use drm_dev_enter/exit instead?

Agreed — that matches the drm_dev_is_unplugged() doc recommendation.
New shape: drm_dev_enter() -> svm_migrate_copy_memory() submit ->
drm_dev_exit() before the fence wait in svm_migrate_copy_done() (can't
hold it across the wait — drm_dev_unplug() waits for exits, and a
fence on a dying device may never signal). The bounded wait in
copy_done then covers the submit->wait window. I'd keep
pci_dev_is_disconnected() as an additional early-out since the PCI
flag can be set well before drm_dev_unplug() runs.

> I'm not convinced this is needed. cancel_delayed_work_sync in
> svm_range_list_fini should take care of terminating the worker, even
> if it rescheduled itself. It's more of an optimization to avoid
> rescheduling the worker unnecessarily when it's known to be useless.
> Either way, this would make more sense in patch 2, since it's
> similar to the restore_userptr_worker change.

Same situation as the userptr worker: svm_range_list_fini only runs at
process teardown, which on unplug can be delayed indefinitely (the
deadlocked exit path above). But yes, it's an optimization rather than
a correctness fix — happy to fold it into patch 2 with the userptr
worker change.

Will respin as v4 with these changes.

Olivier
