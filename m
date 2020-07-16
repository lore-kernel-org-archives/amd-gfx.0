Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9DAC433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F1D20787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbD5qOhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F1D20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F3289F89;
	Thu, 16 Jul 2020 21:23:13 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D976E069
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:10 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id k6so8660699wrn.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kDU2SIuj9KM7vmkmujYyUYfqYA5pkzJfZw797Jzv3wA=;
 b=pbD5qOhNBa5E3bKdbTjrnnObaZpleDrYpUzh0ulYMlo5s/gdFL/4GN8Ehvv4u3qWPU
 3zCAZRIeWIgD+UKfRbr5nWXpJq4snTNaSucNmGs4NI/qwu4a9gme+/9ujodfzkR7uzun
 uDnytKRXgAEgL/maOoP1pFUb8feWd/AOmbAfP+Rc5iDjrkdVI9zIDgmgPA8Wrqelp4WA
 TglykFUbPDwJZyQyHIfanVBjs9baEpn+xaD0aDkOlxuur0L7B1DzgEYnPxWZParu9HOg
 eHlbDzYinvkqVwZM8y+QhK1pvGwrq1APMk61rNKnQ+RKGJHzU4cm1zb6EHb0Q5X7Hc/m
 zoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kDU2SIuj9KM7vmkmujYyUYfqYA5pkzJfZw797Jzv3wA=;
 b=HKjxFkLhTo+D5BfaIzsFzb9tsSU6/DFnSsBa0Yl8TW/QHgsM3PXCVteXMtXl4ad/vb
 zCoMNLmJBeZVlaAcx00Nsv25IALZnMClXdv4Oa7fSMwlNApEVdrFTE/5tiF45kPo0eH3
 tz81Usd2Hp1c+KxLvceWhMTZ7oFsb5Iyr6HSaTL6jkCbuL/oS8nViiUDnAWP32pNEqOf
 vW9aKfwR3RexCXfS/5FVtqEe7UQjfRzDYe1/dwBl53eJ07ZDN7MnU3trGnSZ+p3Wh8ov
 1oK0vU31CpANcm5ZsYHUzzZbLN01QGQIxHa8O23XmAHXykVPcrHng/BU7v5z5ANUZxme
 q/FQ==
X-Gm-Message-State: AOAM533aMGQKZlmdj4Kl8z8WSte49BqdkK/V0LHDOqOm1np8QPBbW/4q
 bI7AWhJ/KPbdVS4btW3SyeOittzPFko=
X-Google-Smtp-Source: ABdhPJzhij2jC2L9OYcFALtloXIqpxPPMKIXMYkc8rxuuDP0Tx2AFBN1vxzmjRZlgOhg5H8Gqtjm6Q==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr7388594wrw.213.1594934588895; 
 Thu, 16 Jul 2020 14:23:08 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:08 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 02/27] drm/amd/display: add asics info for SI parts
Date: Thu, 16 Jul 2020 23:22:26 +0200
Message-Id: <20200716212251.1539094-3-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Asic info for SI parts need to be preliminarly added

[How]
Asics info retrieved from si_id.h in https://github.com/GPUOpen-Tools/CodeXL

Tree path:
./CodeXL/Components/ShaderAnalyzer/AMDTBackEnd/Include/Common/asic_reg/si_id.h

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../gpu/drm/amd/display/include/dal_asic_id.h | 40 +++++++++++++++++++
 .../gpu/drm/amd/display/include/dal_types.h   |  3 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index abeb58d544b1..b267987aed06 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -30,6 +30,34 @@
  * ASIC internal revision ID
  */
 
+/* DCE60 (based on si_id.h in GPUOpen-Tools CodeXL) */
+#define SI_TAHITI_P_A0    0x01
+#define SI_TAHITI_P_B0    0x05
+#define SI_TAHITI_P_B1    0x06
+#define SI_PITCAIRN_PM_A0 0x14
+#define SI_PITCAIRN_PM_A1 0x15
+#define SI_CAPEVERDE_M_A0 0x28
+#define SI_CAPEVERDE_M_A1 0x29
+#define SI_OLAND_M_A0     0x3C
+#define SI_HAINAN_V_A0    0x46
+
+#define SI_UNKNOWN        0xFF
+
+#define ASIC_REV_IS_TAHITI_P(rev) \
+	((rev >= SI_TAHITI_P_A0) && (rev < SI_PITCAIRN_PM_A0))
+
+#define ASIC_REV_IS_PITCAIRN_PM(rev) \
+	((rev >= SI_PITCAIRN_PM_A0) && (rev < SI_CAPEVERDE_M_A0))
+
+#define ASIC_REV_IS_CAPEVERDE_M(rev) \
+	((rev >= SI_CAPEVERDE_M_A0) && (rev < SI_OLAND_M_A0))
+
+#define ASIC_REV_IS_OLAND_M(rev) \
+	((rev >= SI_OLAND_M_A0) && (rev < SI_HAINAN_V_A0))
+
+#define ASIC_REV_IS_HAINAN_V(rev) \
+	((rev >= SI_HAINAN_V_A0) && (rev < SI_UNKNOWN))
+
 /* DCE80 (based on ci_id.h in Perforce) */
 #define	CI_BONAIRE_M_A0 0x14
 #define	CI_BONAIRE_M_A1	0x15
@@ -181,6 +209,17 @@ enum {
 /*
  * ASIC chip ID
  */
+
+/* DCE60 */
+#define DEVICE_ID_SI_TAHITI_P_6780 0x6780
+#define DEVICE_ID_SI_PITCAIRN_PM_6800 0x6800
+#define DEVICE_ID_SI_PITCAIRN_PM_6808 0x6808
+#define DEVICE_ID_SI_CAPEVERDE_M_6820 0x6820
+#define DEVICE_ID_SI_CAPEVERDE_M_6828 0x6828
+#define DEVICE_ID_SI_OLAND_M_6600 0x6600
+#define DEVICE_ID_SI_OLAND_M_6608 0x6608
+#define DEVICE_ID_SI_HAINAN_V_6660 0x6660
+
 /* DCE80 */
 #define DEVICE_ID_KALINDI_9834 0x9834
 #define DEVICE_ID_TEMASH_9839 0x9839
@@ -190,6 +229,7 @@ enum {
 #define DEVICE_ID_RENOIR_1636 0x1636
 
 /* Asic Family IDs for different asic family. */
+#define FAMILY_SI 110 /* Southern Islands: Tahiti (P), Pitcairn (PM), Cape Verde (M), Oland (M), Hainan (V) */
 #define FAMILY_CI 120 /* Sea Islands: Hawaii (P), Bonaire (M) */
 #define FAMILY_KV 125 /* Fusion => Kaveri: Spectre, Spooky; Kabini: Kalindi */
 #define FAMILY_VI 130 /* Volcanic Islands: Iceland (V), Tonga (M) */
diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index b67c9fa6b9cd..8aaa3af69202 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -34,6 +34,9 @@ struct dc_bios;
 
 enum dce_version {
 	DCE_VERSION_UNKNOWN = (-1),
+	DCE_VERSION_6_0,
+	DCE_VERSION_6_1,
+	DCE_VERSION_6_4,
 	DCE_VERSION_8_0,
 	DCE_VERSION_8_1,
 	DCE_VERSION_8_3,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
