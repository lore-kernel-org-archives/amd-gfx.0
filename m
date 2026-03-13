Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35FE107BCCD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511AC10ECCA;
	Fri, 13 Mar 2026 16:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="KiTGQShY";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862C910EC43
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 14:47:34 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so7026475e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773413253; x=1774018053; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hwuj/ezVd8q3XBeXipLijWROjE/A37RRQZ4CHLHIBcs=;
 b=KiTGQShYKqUMJrojmk8HfU80euBocJMBAPhJId1hR2Mr21RtZn4+GU4TKNDFs8bM3Y
 DoYzWHzImHHp7OPACFGB7WM200GdUhskXsBGunD0PvJ97HRfsNAA/8+Mu8pCPBg4JonR
 wvi294NPEDskBgU8Fy2Yt/VACC3afMiw1wxuKSCm6lqF8PZnJCg1quO4Yemi6ekvgmiK
 uBfRPwFpzpZo1lhZjKNo7tGqmkINE0Nc+2Kt2juRaPtkStaljQvKzAtjTjnY3DgJbmQp
 X0T1RC1SGnbmXcB7a6zleijsknBY+Fqy1EtW4e039eTcB4R8O4JvOnKr7L1VzHFFdsTW
 xsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773413253; x=1774018053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hwuj/ezVd8q3XBeXipLijWROjE/A37RRQZ4CHLHIBcs=;
 b=CJky4pjgG9zh3lEoevn8yqipuyOXUvkcD8+YeATAkWdM7/72agCPSLCZk8ErYcWuOe
 /H3gwExccoYXgxW4fdCa+2c1MC+8IvwVQqI/q3gYm1uElmaiOvFq6ianXjcBTwNlOs4c
 GI+DXBDl/dZ1KrHH+VmBuKdGGP6V2BKh/A3X8MQifdw+j3Mko4OX4O/acDtcrjvKC97b
 zvIJ76NG6puak8xtpYYEXdCfKNPG77IxltejN5ez7O47bPH9SjRvPC2BJPFZgHs9a11n
 Jb+/9eadbS7wksO/5rpndjnPuB/qjCqyqcMrnyiG/DKlv9H00gZh8YIF8g1HKp7C5ALy
 7UCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcLasXt2j8+ZVVXxEhyS4dukmMb2abZryRPxQ5jY6HTREFOZ1UW9inOrvBKYj9w0ylvQGEJ/H2@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/qVeQoKnDSPya3cSkqkVOrdbzbnVAVetRF8J7VH+2WdCTiZmr
 r+fy21HRBwdBvFy7ccmrNR6RS5vYRgkD4FMAGM8Wj/IzMN4DMezwd9eXRCbjDX/DIYU=
X-Gm-Gg: ATEYQzyNjeFZ27+v+s9kfoHerYSd+ES7ZK2nxmz9HiL519SMO0YJxF5jWAIfD+kP4uZ
 2Dd831/7ZmEw0H1DuR0ESJTud7aPdrpu7ahIpYlOGrtDzcIdkgDS0e4Aex4oQlvbDYxnXMRE73p
 5EvmsFl/yHXZZIcg9bV0HOtaO+b9rmTeB9uCVPno+0xdBION77Gq/mfvh4LP+Q0u3RcoBryyHZS
 058UE40E3TlBE9/GbaoJSyRob8VpMd/Xy5FW1a/De2krM2aOt59XqZZyhO6GwYrNzA63vlPdWaB
 JD6yijJJWSH0DCWHx7fLHbvbJJMk48B0hmEeS0WJvITqzpEvuWGialpAyNP1AseXRQ1c7Yp/MTy
 Hp7S0w+kEbCdj++pKRLbBgywDufqnjPZLdAz5MsRgNvCSNXMSqp4+IEPclLuRpa7RiB/tsy8uMu
 RInDIocz6De018nYOQ5bFAXP5pz3g8zRqEtfIKjVjumNfBHvmrKQ==
X-Received: by 2002:a05:600c:3590:b0:485:3b34:2f61 with SMTP id
 5b1f17b1804b1-485566c9464mr61968075e9.7.1773413252920; 
 Fri, 13 Mar 2026 07:47:32 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe22f3a4sm18375071f8f.38.2026.03.13.07.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:47:32 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/amd/display: Replace use of system_wq with
 system_percpu_wq
Date: Fri, 13 Mar 2026 15:47:15 +0100
Message-ID: <20260313144715.252069-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:51:10 +0000
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

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3d6f2cd8ab6..04f09eb30e41 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -568,7 +568,7 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
 	offload_work->stream = stream;
 	offload_work->adjust = adjust_copy;
 
-	queue_work(system_wq, &offload_work->work);
+	queue_work(system_percpu_wq, &offload_work->work);
 }
 
 static void dm_vupdate_high_irq(void *interrupt_params)
@@ -4117,7 +4117,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 			dc_sink_retain(aconnector->hdmi_prev_sink);
 
 		/* Schedule delayed detection. */
-		if (mod_delayed_work(system_wq,
+		if (mod_delayed_work(system_percpu_wq,
 				 &aconnector->hdmi_hpd_debounce_work,
 				 msecs_to_jiffies(aconnector->hdmi_hpd_debounce_delay_ms)))
 			drm_dbg_kms(dev, "HDMI HPD: Re-scheduled debounce work\n");
-- 
2.53.0

