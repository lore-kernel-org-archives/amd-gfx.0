Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F38CC55179
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0555910E6D7;
	Mon,  3 Aug 2026 13:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GEYDKLHd";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A53310E5FA
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:23:20 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so500613666b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763398; x=1786368198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2J8gTzQfzaHzx/KRNbb55BdO52HJnh4D+2REiV4ZGgs=;
 b=GEYDKLHd8PFSTZMMc2iWmgr8bCokASCR25FGlkUsiZ9udSu/eAGsBCmc834OzwovBX
 mQkZw/RQlyQ0NMohdHpi/3ck3JWWSbgBYILgfAYgSg+SYMRMGmmTROLnuEKNw1KFeKkX
 Gl/xhjLytjVdwmqTQxngFjhptpcNfg6jWD0MMDzSaAq2AfEMvAB1SS5Z+oGNyvzcleCL
 8xVYjqOzN37caUoE08AE/+MFqtYlke0AZ7o5r/eUASrGd7U/iRaqQQ2zrnw7RGWFeJUT
 fzUKRuCo8NOCmviw0wdagK/BWrmH2Jb7SAN9HDmELwa/9KL0C8XYbjQdK8vNqmHpE07d
 TULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763398; x=1786368198;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2J8gTzQfzaHzx/KRNbb55BdO52HJnh4D+2REiV4ZGgs=;
 b=qMKKbq2YK292WVDHrI0mgHB8UjZKvowrpDWVMrJ2x3yIZOZeLBzs3hsDuNnEiOhPyr
 EVaeUqWRvg9/5kjCpnIbg3TPOM7UZtICsRA3cadN8r9B/IhVhZFaL2RxEsKFf/CItKz1
 QyqJlBmRyrIVgiuVF8G8f5yp+XGdrrXgJu7n4agrI6rVVVEMTXXnQueTsVMmASJ40LLG
 GENJQw+H0cJnRPHm9l1USmDMkOVCcoU2Ht/z+OidUCnLm2Aq25WFl9rZtR8JCzfjKK5G
 8mjzJ3FjamLTzc8hPkm6mFg1DWnzhE6SNzgwbpcMuw0QRLIU3hlhW17/lDTN7sd5Qxqt
 RkIQ==
X-Gm-Message-State: AOJu0YwtgraTM2yK5G5PWnhqSNX5wFHJVj5faRl73RIP6+GlpbYEqn8W
 IHFZvC660YCWLfZU1NY3nsAwYxrvXUHz14DkmZSJbk7JJK6//0jcJv6L7cthNR7h
X-Gm-Gg: AR+sD10h7MOkQscsB75V7QAvPh5IeGrNuChmxcVN+oYBmIXW6Jxzqc6/ZNWRB/n7Qn/
 ++vfZK7o0xvU3BGj8tRnT7JihmHXWBSWvqjfxuiomwXCiVNUyDm7dNhZli1dzW2M5c2qDuZn18D
 ++RhpB+Aj2ftTSoU9ciGjwU+7dQpEI4CWl90ix3f/Zv1rRCphamqTqgyzMyVKzWvE0YmQfniHuC
 nOgSBqrqxAiSix025+WAoh87FFJofiD8cnGrzi3OasqGrY4GWACqlVC6LojVACzP9sla33xVDct
 mrygs0I6YpLal9IwRuQEP6sIWzKB3pYIEmLwkMTseLUihgRiKpfB35cSkTux8j48DfYAzEs7jZI
 Jn4K3fITcUCQ5bFpYOz84Ni9rvrx70Om6PXKw/jYXvRbKOfvAfFmMiGVue6857ROo9TpXAh1iKY
 +f/FXXYwDSeCvB+RDt629AfsKs4BGcMJLQ0Xy4y2ax2zPRc42k0JMEwiUzHk8k+j4+fxS4c1WS0
 MZsGJjbgxLLJI143reXv2TBwQpNQYBOQO+9vbIyQQ==
X-Received: by 2002:a17:906:99ca:b0:c12:525b:4e7d with SMTP id
 a640c23a62f3a-c1fe7bdb35fmr861170866b.15.1785763398376; 
 Mon, 03 Aug 2026 06:23:18 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm549201266b.41.2026.08.03.06.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:18 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/10] drm/amdgpu/gfx6: Execute CLEAR_STATE when initializing
 compute rings
Date: Mon,  3 Aug 2026 15:23:05 +0200
Message-ID: <20260803132309.36326-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803132309.36326-1-timur.kristof@gmail.com>
References: <20260803132309.36326-1-timur.kristof@gmail.com>
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

Emit a compute CLEAR_STATE packet on the compute rings after
the GFX ring already finished executing ME_INITIALIZE and
before the ring test, so that gfx_v6_0_cp_gfx_resume() can
wait until the CLEAR_STATE is complete.

For reference, see si_cp_start() in the old radeon driver.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index ce63417ae17e..b1dfcbe9640c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2258,6 +2258,14 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
 
+		r = amdgpu_ring_alloc(ring, 2);
+		if (r)
+			return r;
+
+		amdgpu_ring_write(ring, PACKET3_COMPUTE(PACKET3_CLEAR_STATE, 0));
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_commit(ring);
+
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-- 
2.55.0

