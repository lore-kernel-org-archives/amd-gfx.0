Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F263CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8160D10E62B;
	Wed,  7 Oct 2026 17:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RxVcRGau";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A00C10F704
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:24:06 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso16041305e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791393845; x=1791998645; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ooAmi0R+loAWw/ni753yYMIdDk3msuvLSCZ/JxYPbxk=;
 b=RxVcRGauqSr5ceik2OgFgVGqdAgrgO63iB0MBAvT6VunT+IlsQTw7CxnDGGM+Z2Cne
 4oLca5C4OdWHM/uOwg6lhCrpXSwRt5HHvL7Abkq7w6wXLPWGaRqw3UCYlrMfxPQjN36Q
 bEppD1zFNNyrjJt+QlIBFT3mtMT8uENt9lSh/enXGg3pfDsvGQFYnMX8FBdBS5SYtS8j
 kKPAXkPNvyk0eaMqtbFn394TJIC3WFCG71ebQC32qIUkgt3xbEVtXOeNLjianEcHUL2Z
 hNyLAxHMSFoGanPzNwXGh+jpZw05WAj3U/6kVk+TpwPQ4o0YtfHCXjbr3rABBtqlAuqq
 jd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791393845; x=1791998645;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ooAmi0R+loAWw/ni753yYMIdDk3msuvLSCZ/JxYPbxk=;
 b=gXrXInZlR/GJKjgy1el7yRakeXAzzIWWHh1S9OetNKdpShD+iiI1TnVHbgribxj1ag
 HtuE9MzoDtfvWR9PYGw2/V2MxqGHcrBD/Xqe2u2v8cWafukZVdQRkCvP1/futG+ZPYu3
 XgvRwW8ydA4fmNcmUR4Bm3T7nQVH8WZPfV3kYcdiWRMe4BxTDyDwAR2pkZL791qngGlC
 k6041cM5RG2rAYe0ze8wWsXmLCMrEOBHFBGxr4LsuzpBAB/uNzV7WYweWfY6tv7F0Syn
 Cv9T2KxiAmiXXZiAjVSyDbds4HyLAG4dtJSPzi60uTYA2uUmD/FDELoLpP2wwYVUOKeT
 JFpQ==
X-Gm-Message-State: AFuF++nH9ZBHoAAMd4eDgycY3p6wt4mV0sw+6RNKWcVAdXgIv1HhsBq6
 zcVnCAgM1DFUK0n5HphsUZTVgOQsRdbip/AlsOfsOoNEQCCOIZmRDa1PTAsg5rmM9C0=
X-Gm-Gg: AYBFou0wl8ncj37L1zuSEK91u8UTvf6G2AeCOunSDSPzpMBH51IEeAeuUL4MuwwoCdo
 2OON4d36GT18teSGa8Ob6PPjFD1SPCS52xLduQh9sM1zmlN6kBdl39g36LfyXPDVPNMy/Zof94v
 DR1v9GQbeOqx4DluRBhhqWVKmdnUQ4O6CLYM2LzWQprcJj1zr/t8q/r6h5YEM2mr+UwfDbRFEmx
 1Gl7dXO5BFtp7mAS4S1Fh9uO1lvlOEuKS3dGiJmwhe0iS1vhj13eUJ4Uf3p6rSLWdh5YY1npVRM
 QEXMWS3fPA2Ezn/cxbiqryaQh0x4Mq2PFgfsjHalwEo08NZcsX7NkcYruaRRYz9CjOz5Xtepor9
 lAb1xtUDZptv11SRi52P/7UkX4T2EomUdTmZYVhp2DV/8V23pEkzcRFwPLjSl0Bt6Hb2Ro+X3WR
 hgAor919yxNVGPcYKVnOMdBwxT2u1GOwOIUEi1yjnxpInpFG+s2NdTL/hwaqYvbffxVtdb/DD33
 GIbRd7VhVC2i//o9FlFF3xp7RT38OE4/q1dPoh4rv9Y0JpVSXrOo+98cfCr/XDcoW/2EFFq7EoI
 ELuMgEFYWxIq9szAigNCZ7ytcyyMOEuSS1hTvmM7IU6o1BJWn4wpg/0Eh5yfeC+6Tf7J1cdkBCD
 XfNd9aarcADJPbr5W3YjJKGN4LrfPmMHBTNYfMnnJ6iWdWKXbesYiz7/j8dnCaRDKdDqfe/tMqK
 t5x3sedcl3OhLse1CI
X-Received: by 2002:a05:600c:3e16:b0:49d:2536:402e with SMTP id
 5b1f17b1804b1-4a1806649afmr52281025e9.30.1791393844544; 
 Wed, 07 Oct 2026 10:24:04 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:413e:676b:9d85:c07d:dc5e:c7c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71c0b860sm5828413f8f.11.2026.10.07.10.24.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 10:24:04 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: stop userptr restore retries on device
 unplug
Date: Wed,  7 Oct 2026 19:24:02 +0200
Message-ID: <20261007172402.11248-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <5f3ab1e0-0ff3-4a68-94cd-7b66f1b53b1f@amd.com>
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

> Shouldn't cancel_delayed_work_sync wait for the worker function to
> exit? I don't see how that can race with the re-scheduling in the
> worker function itself.

You're right, my UAF framing was wrong on current kernels. I checked
the workqueue code: __cancel_work_sync() marks the work disabled in
its off-queue data while it flushes, and queue_delayed_work_on() drops
the requeue via clear_pending_if_disabled(). Self-reschedule from a
running handler, delayed or not, can't survive the cancel.

The argument that does stand: the cancel only runs at last-VM destroy
during process exit (gpuvm_destroy_cb, when n_vms hits 0). On surprise
removal that path itself can stall — the SIGBUS'd task deadlocks in
its own exit path (SVM migrate -> fence that never signals, patch
3/3), so process_info teardown never runs and nobody ever calls the
cancel. That whole window is where the ~11k-cycle spin at 1ms delay
happened, holding process_info->lock and notifier_lock each round
until soft-lockup.

So the -ENODEV check isn't about racing the cancel — it's the stop
condition for the window where the device's lifetime has ended but
process_info's hasn't. Transient errors still retry as before.

Olivier
