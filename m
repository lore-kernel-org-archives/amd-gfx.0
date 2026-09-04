Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3D6C79FAA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 07:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8BC10E685;
	Mon,  7 Sep 2026 07:01:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XZmbvy9G";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6BE10E0DE
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 12:01:38 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7f3f52143cdso773898a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523297; x=1789128097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z1XyZzGqo8qtOw6QCVse2xuLQ0fYOXbEWeooM5I1+Fw=;
 b=XZmbvy9GA6c0VmzclTzNEcA0sGSzkbIprilNBysQM2YZDmTkGQEyWwmlJ4cL4ynymI
 5IXtIXhS31MuBVUhwPtS8UEPnxdP0F8v2m8k1Jpx5wPO9a97lB6t0Ff9Q2gKcbgFIHQC
 L2QQhJIBPl0TNsUjsetRni/zq1TrySpIdR8j5giEFvh1J6sl6eLVBE51+EAwvVq8mqSP
 8XPsNfJFfdDi0/z904DB43oW5+oJojYIq3OdJf87wx4pW52hz4G7nvlachs1IffP3mtG
 qEtgR2a+gPV2cXynEFd7+FSJm6ZYdblSHBwU2qhTUktIy6rA0+adz9jX4PeRwX8NLbgh
 GHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523297; x=1789128097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z1XyZzGqo8qtOw6QCVse2xuLQ0fYOXbEWeooM5I1+Fw=;
 b=DJU3VYf/tftWtN1nxNQ9R05sxwed0v+KVIMEW3JnUn4ENorLjMEtsJNnJ/Fp8hBhxG
 xAfuvYeHCtzgmp7VwsJcysgtg0rigiuLL/WWki34AfngSGLf7k0Orxo+/imMYgFT/vXr
 L5p+96bpppGLQ2eUdL/xE6j11VVlvLWs6vVtTLysFt0yyK64H7ZaVr8dTGzGRfM3Kran
 pFazekClupwVNuWGyTK3sENQ/AL6nIIu0r9IJZag6cSa7Fz4v5Zpp8rAG4LZj8pK08/A
 PKh9pRSM/OaTeeBd94odHvaXJjqDhJBvY/4W+lU+nggINqtXzJ8VSkD7MhMcHkgZsFd0
 F6AA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZAnjg5FYQ4wwSN72eqtF2KGanVo9n5lCd4TYZGMzcd03YvF5WC/t2CwtP+WwFwkd3JRG2jvSe@lists.freedesktop.org
X-Gm-Message-State: AFuF++n9CfZWks/HbeROuk0/xAwY+nZjBHmh1259LzD1P6gv4okUeAob
 eq/kAih4rM1QTJA+iXElSqdmQ2RvAqJ+hACOV/FlQdnRhvN7ne4AE6+T
X-Gm-Gg: AYBFou1RBX/xESnDPEWPB2/Qnfy9/ZQqhh4i3jm/Yc9pem+IODd2oH5aRn068hWYC5l
 JquMeT2MtVMgAETqPY2+Gu3Jun1CvcEaQgF3/2/ZNBOZLVftpoFNd3cq5YyJFTD/vgzG1q3qRru
 wjTX1Tf/a707hUfLZE+ubNJZ32zmF9eFf/J0NCM6heL8oL7CynLerIvwRKS/1NkOi2tniMhqkpV
 asboLyL9DIhTXXu9zjr5LGzcMEsxZLLyZuMQS441XvtIXewSuMZNphRehLRc48AuQiq+gfxM/jg
 XqsBomJAhQkqWNuQR3U3MBPyH5cYHOQDny819nVWNMbaMkSG3qMGTa+dcTv7uL/dkI9e3BcV6mu
 M72PHoohz1NVuAgLWe7RjBdNct8vBO2BByrNFUB26ZKvoxPbMeNSwbigTGUnrk4hB99pkj9fYg4
 SeVpEJ/3dRtcu0zWXP2ghwrJ5q2R3i7za2kdZHoEcxq9c4Z8GxdYZQ8hsEZz6OYkL0dCDtZwF3P
 muFAPYfHEEZvnY=
X-Received: by 2002:a05:6820:1c87:b0:6b3:6920:4ca0 with SMTP id
 006d021491bc7-6b6fabe1ff3mr3531638eaf.9.1788523295847; 
 Fri, 04 Sep 2026 05:01:35 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14324356931sm10164241c88.4.2026.09.04.05.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:01:35 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: fix typo in log message
Date: Fri,  4 Sep 2026 17:30:09 +0530
Message-ID: <20260904120044.14303-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904120044.14303-1-hemanth.selam@gmail.com>
References: <20260904120044.14303-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:01:06 +0000
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

Correct the misspelling in a message the user sees, reported by
scripts/checkpatch.pl using the list in scripts/spelling.txt.

Only the message text changes, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
index 33c23532e29c..c0507d9193e2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
@@ -1759,7 +1759,7 @@ static int tonga_populate_vr_config(struct pp_hwmgr *hwmgr,
 			table->VRConfig |= config;
 		} else {
 			pr_err("VDDC and VDDGFX should "
-				"be both on SVI2 control in splitted mode !\n");
+				"be both on SVI2 control in split mode !\n");
 		}
 	} else {
 		/* Merged mode  */
-- 
2.48.1

