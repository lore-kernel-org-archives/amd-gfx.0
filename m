Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D653BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD552065C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKTLzF9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD552065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BCE96E0D3;
	Mon,  1 Jun 2020 18:02:57 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370B16E0CD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:02:56 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id q8so9920253qkm.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kd/mO+MjcG8ghlEfdPD6bQPuhl8S4ZAKnaPEUKaRyg4=;
 b=QKTLzF9sv3nVdXL5NfDQe0f3iBjG5AZtjkt1c58FdNMRsIIuHitTe23qL7qysjjy/5
 2CeqcGrtfhe354eyPKXw2HaTtYeV2gl9HsjjzUZgG0xaAqcskA0/40EeSOzbBpVWP1rY
 vPLMgKo9D8Yl3VBi66qTLEMFMUKORZxLlqZjX4AIv2J8Yw5u89q2xiI+RT2g5yP2DOSD
 vAVFZLPNli6yVvPFIuz28io7rV8Ids1rFxZv4mff0HDlln5ruaDqE3jd8WrxdBOwDl9t
 i8kO8VY9O0ZTBFFs+uJeCx4VSEZOPpHR+/deMQfak5lhwnBEYyhp01TZHnXTQ8KzBz/+
 34Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kd/mO+MjcG8ghlEfdPD6bQPuhl8S4ZAKnaPEUKaRyg4=;
 b=H1k178tdWOJlnGbn6r5V2BUIrNmNCs1iZgoHTC1PZ+sihPQMx1EEKOZr0f9Le7K9m2
 QkqQzQX3kFvtu5llxU+zcSfwSrTxF2IHGqbprO2nCwsTGxLXutjR/KOrnLrWg8dc+jPl
 eE8EFTD67lcajeGCeAhitLbzwYK8+TlaJvNrcrk52ZaAdmQ0yEFhb/dqReUIuf68dh69
 pSzZxJSs1CH+q2iG4BK5OLpwMEXNXtvvWzmxXDfGB6glo4GIqdqpmpoFlfd0HniDn3hq
 vT4Zv/t8KmGZlkCr+sAVu4NwOWS1wr6Hc6aXTZyleFz0WAp3hsfonzUfEmrP29kYGs/k
 PwKw==
X-Gm-Message-State: AOAM530IHONJei3rDZsSTCch7rbkIV59lM/KHYgAs8jo+VHZIc3e7MqL
 hLxieumR3KrqlC5z9rQ/NR6l2x0K
X-Google-Smtp-Source: ABdhPJyVmk9OS8NiiEagbrpJqqnsRxwJ4U8I81ymEFINhE4fk7k45x36RuZKXdOmWFDpj5YKCSH/Uw==
X-Received: by 2002:ae9:e703:: with SMTP id m3mr21170037qka.114.1591034575149; 
 Mon, 01 Jun 2020 11:02:55 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:02:54 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 009/207] drm/amdgpu/gfx10: add support for sienna_cichlid
 firmware
Date: Mon,  1 Jun 2020 13:59:21 -0400
Message-Id: <20200601180239.1267430-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index df2d2f609d0b..c2fbf037defc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -89,6 +89,13 @@ MODULE_FIRMWARE("amdgpu/navi12_mec.bin");
 MODULE_FIRMWARE("amdgpu/navi12_mec2.bin");
 MODULE_FIRMWARE("amdgpu/navi12_rlc.bin");
 
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_ce.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_pfp.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_me.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_mec.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_mec2.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_rlc.bin");
+
 static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
@@ -3463,6 +3470,9 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 		chip_name = "navi12";
 		break;
+	case CHIP_SIENNA_CICHLID:
+		chip_name = "sienna_cichlid";
+		break;
 	default:
 		BUG();
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
