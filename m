Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAAE606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V9fCngnA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57CD10E5A2;
	Mon,  2 Nov 2026 08:06:53 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07BD210E24A
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Nov 2026 10:48:01 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1931ff67a29so3163363c88.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Nov 2026 02:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793530081; x=1794134881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+aTVbnkfZYsolInJM1P7mrXF8suFhh3kNR1fi3nP4Y4=;
 b=V9fCngnAc65y3frsLHzQNOv++hRbeksVJcw8cGUPdI00cgSBcBT1RUVvbPa4htqBhk
 QyulD/Dn+vSEp7TU4GrVeuO/PdKCfWWLarMFDRc8AKjp94bvSa13lvuBQ91wSSny3mMB
 IIMcucoR2uiXUs5joElraGMRVqn8AjQFo5stDRr1Wc0XUBcRVKbIbEqKTH70roZHCCoe
 +CL7X+yS4VolzaNUvljI2eIUbl11sosFOll3pUbHbcJrHpdF6H49gq4qSt9Ucytst4iq
 /jGMPu4NsGwyAMyIbSSG8s67U40jL2OMPj2IGHi9/JSJWahX//9uh8WL8EPjTOts5BfQ
 mOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793530081; x=1794134881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+aTVbnkfZYsolInJM1P7mrXF8suFhh3kNR1fi3nP4Y4=;
 b=gkbJpsNJMcL0i8LcjOns9Bz3tBQNqnRFEt2Eb5u4FvA4xxY8JqRB1fqkRZszfP8WHX
 VRIpKEoRrnxzI4o2o3LaY99XaUWp2YRoaFkJvPKnZ4qgo57Xpb3J5krkgZK5yBi4wbJ4
 bmf+FCIRr7STYZ1HnUM9AMfAHDkyHDIz4FeoDUuqgxDHOZ9dycEYceSD2bTlC4Z1CSha
 f7Sm2JB7Ix26zr9ZqRq4QX/85bzLvNjmr0AsPBYLnCH8qmywSFaPSqeI0XolaeKECh1T
 f1M+m0S6E5CqupwwD+HoaOsFJoZiEsDpN/rYu3Vpav7k/B2uSvfZyNOFEdomXKThIZiD
 djYw==
X-Forwarded-Encrypted: i=1;
 AKwUvByTDR+BTFah7V+a/BMNjM2ASjKT63f6xTe3P8qZKsmRebGkm62PjkI691UdQtuqOcW3kyd3COYa@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ9utQc38X0zcWoKUGV1h4mmqM+gFN9/RLniOo9I8ibtJxiG3Kv
 QbYRGhsxqRzoyCXuCY/OQpUcamI4qnS4cb5Y1MVou+rZVe5/HW3QwQ54
X-Gm-Gg: AYBFou2zDhJi4Wp75aYnzrwXQvhB42aOinNXql8x1sKzQq7qWgpYzvjEd4Sxkjes2d1
 5PNhIIvVQEFs3joSLS/rA2orLJSfOK1/64UBvqKL68tAnM8xzgCOQ45MJGersnopkiJ/LYtvMxU
 OTtBbd6nplW/9uaLmtIkKnD7yz3xlSjOR/NBQB+6tI72KngxTAEiumAlObydrSdPcijlWI3nbNa
 0H9yBWJjND4wsRp+N/IhA9Ig+D/T/ZWiVmyzD33dUB0PHHPpjYNTZqFxYFneC/f0SJkeL0Z5xSg
 0hJJyzi/+AvFpEEVRTA7bgPF9HRHAiEIWb4XoNvTtKuA1L+s3Ej0FrgSzWr8O1E2Dt5535OxL/7
 SUVxUg76QszUVwq0SiqZQj7Nxnb39Nx4/9G41tAw5D2YTbbmQJH97jowiLN/bNPDUTYbE262XYK
 pjWSjpwaXz4V3zw81sQ0Lr/JkeyV3L0QwWIPLwcXRAJJJ/sMxQzqiXnn5DxNs6fzsI/iAsBeKWn
 GyWEhd/LZAttoNw1eZdk/MoJCAYgj60wV+RgUPp7qiqcMuablITifL7C9KcvptqIS7IAfZ20AHO
 IaBsnHXvnowD8AlMR+0A91xvcmjm
X-Received: by 2002:a05:701b:2050:10b0:152:92c6:8b58 with SMTP id
 a92af1059eb24-1ac5c555078mr11436993c88.35.1793530080785; 
 Sun, 01 Nov 2026 02:48:00 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:e7f6:4b7d:197f:48c0])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac19c6b969sm23334554c88.14.2026.11.01.02.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:48:00 -0800 (PST)
From: mdshahid03@gmail.com
To: austin.zheng@amd.com,
	jun.lei@amd.com
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] drm/amd/display: fix USR retraining support check
Date: Sun,  1 Nov 2026 16:17:27 +0530
Message-ID: <20261101104727.141852-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohammad Shahid <mdshahid03@gmail.com>

The USR retraining support check tests the address of
USRRetrainingSupport[j] instead of its Boolean value.

Since the address of the array element is non-NULL,the
condition can always true, even when USR retraining is
required but not supported.

This issue is reported by script test_addr.cocci.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
index a8519f547dce..74cb65687a50 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
@@ -412,7 +412,7 @@ void dml_print_mode_support(struct display_mode_lib_st *mode_lib, dml_uint_t j)
 	dml_print("DML: MODE SUPPORT:     Host VM or Immediate Flip Supported        : %s\n", ((mode_lib->ms.cache_display_cfg.plane.HostVMEnable == false && !mode_lib->scratch.dml_core_mode_support_locals.ImmediateFlipRequiredFinal) || mode_lib->ms.support.ImmediateFlipSupportedForState[j]) ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT:     dram clock change support                  : %s\n", mode_lib->scratch.dml_core_mode_support_locals.dram_clock_change_support == true ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT:     f_clock change support                     : %s\n", mode_lib->scratch.dml_core_mode_support_locals.f_clock_change_support == true ? "Supported" : "NOT Supported");
-	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || &mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
+	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT: ===============================================\n");
 }
 
-- 
2.43.0

