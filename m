Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D5606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEFgxfjR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354C5112C2B;
	Fri, 20 Nov 2026 17:38:17 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB832112BE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 17:24:27 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so9051265e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 09:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795195466; x=1795800266; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sZw6zaPGPCV57vfhxVnZC52S1ln1mU0qdp5cwGtejBM=;
 b=SEFgxfjRToFzo2AKhfqh9Lmg3zSOi9kkJEB+25/S1DGAdvSOJ5CSrEq5j3iVdRKaXO
 OREk4GSadfJlQWqsCkJr02SGTPSUYWhYjI61erVOOhI3wrONr37pMM+wtwCPGdFkzGcH
 7aLlef3OlclZrM595+tzEtcGf4fNP6HQts4XFI4rpRFVqH49WSLUvqVCiAexdQcpmO6V
 lT7lxgD2QJ8TCJ9R3O0zYLVV6+iVxSTyVRMUVnXHVbzp41vuyq0xkBvfx6zJCdbklu2k
 R8VrthiIHqwwfKIuK1QPhUk9OKoLhNNffwbHUf0QuWWTcJb3I3OInetFT+rpxBy/4DXJ
 wtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795195466; x=1795800266;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sZw6zaPGPCV57vfhxVnZC52S1ln1mU0qdp5cwGtejBM=;
 b=LSDhguIxlpAbVGDvt4PYu9cDIK3KYBzg4Zd1YBNiuESbTxbp4aHF/xt9X61m9vp0nO
 7dZoVMGQOph1ZSK6N5hCQRfaou2oHmICsiCSZY5DrSVIeroKiNces6EEge+WqpBidoDg
 LMaU5C0GgCL64jiOTk2tXLyBke7D//a9XE+ng7yoVJ6nD99FoXvT9B7YWTbYUtHz3ZJ2
 aS0zq1Q07ChNYsfuaEGfMT9u1vZBNQQhA9/WtL7npcV4AvCXzF9cYLJmI6zL0ljd/wEb
 3dGXGIuqZQMn08t1e2ORdZpCKINE8lffg7EOQIA/V/tV8UNnbqCAyysQ95BhpetofFkq
 bDIg==
X-Gm-Message-State: APuU4Z+XIIS8yIR0fGv8quAEVuflRdryZMlG3ZZAq5kHanWHPjLdUDQD
 q9EV/mI4SotcGcZmiRZU3s8bLUK2K/ox7Ga9+LC5Tg9kUTfmvL3rnnVIMqJDv739
X-Gm-Gg: AYBFou3WNQ/n7VzDQQJ1B7zFJFkdhz2yxB9sKKoahs2CRVtsh/9drMX4hjsDgtmZXy+
 qnJIFu+vB5ULv1TnJVPspp/rVdiYzgWwzGMBEFVdQsFl+xK6nTg7waqUXDDpZA38jhbt4IiLmLp
 NbjmTzP0F6Eyokg0jB8aWT+/Ec3MRlaDoI6/0JsrJP8cFLw370QsGC7sugtIdysFKFa5ySgp5T9
 Z7CP1jivRj7ZwwVuE8sX2ejLsTffNIjSIFXr/OS2WLXVBs3QofeBLRa5JO5o0stKGyoIaCUGMAb
 MPaJxrjmLWu40MGA371QQZj1gEyWTN19w7FTRN/hfg16X2ssJYrKLTRUluSSmylC3P4Kk1CMf2z
 3jkf5CZ+ZivkIBUKKDltp2XfZEuhbXKktjyEY3faxGtZ8qYkzB7uk5GgllBIJbAEpjKExwzoiMO
 4J12yipQiubx3/oEWOUFGYAwoaX3IhqXwB5yqZKkJ1uMGjfsgcaMRoXl49jopuP8gGK29gTL2d7
 0mUFwxchH+7OfWesQW04StR0QLFe1gqWJWXYr/vPjtuvwD3rMSDvdTFEJTOg7MFU8xbkOc51b5H
 WkiLd57ulP0E7TggYzqDeT6J6UmML7DoP83YJ0i7d2Njm+3YBCkdcHVHOq1/FzSPQ7J+OCbvJbx
 npy0oWVnKh0mh6PMPHwbERr5srpYGbQMI/Z6GHVzKibyQAGcg+pKv7Ms=
X-Received: by 2002:a05:600c:4515:b0:4bb:6f67:ca0b with SMTP id
 5b1f17b1804b1-4bb888267f4mr88903895e9.29.1795195465874; 
 Fri, 20 Nov 2026 09:24:25 -0800 (PST)
Received: from Arbeitszimmer.fritz.box
 ([2001:9e8:db29:4c00:a7d0:374b:43f1:90ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c3csm6924137f8f.36.2026.11.20.09.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 09:24:25 -0800 (PST)
From: Christoph Berliner <caberliner@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Jiqian.Chen@amd.com,
 Christoph Berliner <caberliner@gmail.com>
Subject: [PATCH 0/2] drm/amdgpu/gfx9: make KFD usable again after MODE2 on
 Renoir
Date: Fri, 20 Nov 2026 18:24:05 +0100
Message-ID: <20261120172407.64651-1-caberliner@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 17:38:15 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Renoir/Cezanne (GC 9.3.0) a MODE2 reset reports success, graphics and
the kernel compute queues come back, but KFD stays dead until reboot:
every new KFD queue runs into "qcm fence wait loop timeout expired"
and triggers the next reset. Reported in
https://gitlab.freedesktop.org/drm/amd/-/issues/6177, sent here as
asked there.

Commit c3988a7ad479 ("drm/amdgpu/gfx9: Fix Ring and IB test fail after
mode2") already found that MODE2 does not reset the HQD registers on
gfx9 APUs and deactivates the KCQ HQDs before the reset. The HIQ used by
KFD survives as well, though: kq_uninitialize() skips destroy_mqd()
during a reset because it cannot take the reset domain semaphore. After
MODE2 the MEC restarts with the stale HIQ and the HWS no longer answers.
The same trylock pattern on the MES side is discussed in
https://gitlab.freedesktop.org/drm/amd/-/issues/6053.

Patch 1 is a small cleanup plus a fix for the timeout check of the
existing dequeue loop. Patch 2 deactivates all active compute HQDs
(except the KIQ) before MODE2, restricted to GC 9.3.0 because that is
the only gfx9 APU I could test. Raven/Picasso likely need the same, but
I don't know this code well enough to widen the condition without
hardware to test on.

Tested on a Ryzen 5 5600G (gfx90c), MEC firmware 0x1e3, HWS,
amdgpu.noretry=1. An instrumented build used the old path for the first
MODE2 and the new path for later ones, so both were compared in the
same boot:

  old path: HIQ still ACTIVE with the old MQD/PQ after MODE2; next HIP
            program -> "qcm fence wait loop timeout", GPU hang, reset
  new path: only the KIQ active at resume, HIP/rocBLAS tests pass

Since then the patches run as the boot-time amdgpu module on the
Proxmox 7.0.14 kernels (-29 and now -30): requested reset with 9 HQDs
deactivated and the KIQ skipped, HIP/rocBLAS work before and after.
On amd-staging-drm-next (8dd68a795) the series applies with offsets
and builds without warnings (W=1).

The analysis and the patches were prepared with an AI coding assistant
(see the Assisted-by tags); I tested them on the hardware described
above.

Christoph Berliner (2):
  drm/amdgpu/gfx9: factor out HQD deactivation and fix its timeout check
  drm/amdgpu/gfx9: deactivate all compute HQDs before MODE2 on Renoir

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 105 ++++++++++++++++++++------
 1 file changed, 82 insertions(+), 23 deletions(-)

-- 
2.56.1

