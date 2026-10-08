Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5ECCA6011
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 17:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D717510FABD;
	Thu,  8 Oct 2026 17:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NqJK5H2p";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A89B810FABD
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 17:34:28 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48c6955a7c3so1006866f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791480867; x=1792085667; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o4si7vB6R2S1QM0Q1+DWPf/7eMgBNdOz1m0wuoQ24nQ=;
 b=NqJK5H2pjb3GS/SXacWYi3gBVqtVOYsH8qkl/ZQE/nAurORakYMcoCSag2OBH6KFl1
 +kujhRUA3B7UuwJxS7GGaeaLae71z5e57BlutTgqGQnjxiQDecxyWQXYh0xXE19dVdrg
 YNVtkBhDP1GSaXO+kMifM+JU3ryhvOtTP3HeDXHgcY/xXu5CwAy4JkKfx2XlZ6CkDvOK
 KVTjl1XV3nA6D7QPkz+5peSZEQnyciGP2crWGZ+tYBADazSNpciYslokKGbqlJ3SKX1o
 tm5TGYjZf5oiD1D4U+BFzI0rxyw0ogbAqrNN5XbNuUGcT7CbrZy29WpSvMcGcFwScJxu
 alGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480867; x=1792085667;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o4si7vB6R2S1QM0Q1+DWPf/7eMgBNdOz1m0wuoQ24nQ=;
 b=vwvl1AElUaN7+igCwf+JvoXhSjU5taAqFfxFiwM54TrZOIH4obuQzMOPmHxz3m0vs9
 S4SUUzabVaIXo+chr8bJr4chnOW6nScbhj6DQrixkwtL+jTSU0iMWGDW1tvjszrb5BEw
 ZHpeXDcbelBtkasTTk9Sil+jAqquY7w2Z0oAdmESDde/mGPH3/Zeybg3XYwQRhc+3Q02
 wonFj//6BrvBM6YoBb40N20ChMiG03gzYbfTtk6Or3U4zkfFtMG2IYgQ6U4YtjjFO4Ud
 Am8T5Hfx60kx5yX0p3lkX8v8k0hsT12+li85lUbqjAw1waeFBu4ibD1mLyPXKiavs1Ww
 0sVQ==
X-Gm-Message-State: AFq9FYLBcKngpomkMxAiVURU14tH13ZzP64yPb0Joj+Qa4xosfk3pO6Y
 lfa5htTUU/cC4r8k9UlZNFnxHQskzdKAVKPr/+0vAopwQ0Gb8kcJWj01
X-Gm-Gg: AYBFou1k9aqtL8mkqNWVIto5t1gbIp+8vF/tMo+/cOWz1R8KSh0vlajMKUyf06kDH1X
 gNZgL+Rw8ln2vmpgq9tRhkyyamhvHQxjXQrVkh0a1UY6w764eUqa79Lc1yt/bwXPCIlwwFWxU5M
 eN2gluOGcJXzBlt/Iga0k/C+IY9sLOtZzQdpbqeGQkGgwKvMOFHCN237MMc9PfSPS3Jd3VMNBD4
 k4G3g1lQAiD/07a9Fk7S0/Ydg0Rcm3mOvPYkHWJbH/GQqJ+2K13QgKdRn6ChIZ3PjizfS4C2GM5
 n7INzSOC8re8qwsw+FO64t6vtn1CRL1vQhsS8gTb4ovaBXUrsyjPjh1FVXX+6hzAf/rsFrQI4dv
 Z1k2uDPpmhzUVwdHert+rwBxGS/Nhhm+LLw0VGqhEmRtvGknkahgxqqRUtoFMiFYbDbiOhpLKtL
 +yUAnmxEXJmlHOmCgAT/MKZdqeqId3kofLXQIyYPgFnV9rlDGmXluVHKKMEcQIe7pm/qBB+YDgh
 OtIF3FnyIL9kHRfESkJLfSF8QnsSyBKewhpr1f4iT89msHHwVPQL2Lpf3heuEePkBExU/2KJvIO
 I+yQBOsbjtXhGEWxsUB81X1Eg4VVIz7whbZCGzWntHaDYggq2ymJSjRUzmvcyqhtdREvos9A3ez
 1QIk7K0OMYqu8WV0h2/4EVP5Aim8MiQZnZj1lQQ8v7f1DiKFyKyQBHLivJCkJRkznf2bZcut/mg
 v/ZopTWJkx/F+Imno=
X-Received: by 2002:a5d:64c8:0:b0:48c:43a3:6a74 with SMTP id
 ffacd0b85a97d-48c7277152bmr12651323f8f.12.1791480866864; 
 Thu, 08 Oct 2026 10:34:26 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:415e:bf71:e574:69b7:f11e:4204])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db6540138sm714571f8f.55.2026.10.08.10.34.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 10:34:26 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>
Subject: Re: [PATCH v4 2/2] drm/amdgpu: fail fast on unplugged device in VM
 and userptr restore paths
Date: Thu,  8 Oct 2026 19:34:25 +0200
Message-ID: <20261008173425.40761-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <7e0e576a-f3e1-4f30-94c2-c5d34b01b41b@amd.com>
References: <7e0e576a-f3e1-4f30-94c2-c5d34b01b41b@amd.com>
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

> the extra checks for pci_dev_is_disconnected are unnecessary. IMO the
> cleanest solution is the one with the least special case handling
> deep in the KFD code. I.e. just guarding the critical sections that
> need HW access between drm_dev_enter/exit, and not having any
> unbounded fence-wait inside those critical sections, should be
> sufficient.

Agreed — that's cleaner. v5 drops all the unplugged/disconnected
checks; drm_dev_enter() fails fast once unplug starts, and the
AMDGPU_FENCE_JIFFIES_TIMEOUT bound covers the window where the link
is dead but drm_dev_unplug() hasn't run yet.

One observation for the record: in that dead-but-not-yet-unplugged
window dev_enter still succeeds, so each migration attempt submits
to hardware that can't complete and pays one ~500ms timeout instead
of failing instantly. In practice the window is short and the total
removal completed in ~7s on my repro, so the simpler code wins.

Re-verified the minimal version on the MI50/Thunderbolt repro: SIGBUS
delivered, coredump completes, kfd_processes_count drains in ~7s,
pciehp removal finishes, device re-enumerates on re-power.

Olivier
