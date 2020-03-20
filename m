Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D911C4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69CFE20767
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIYpczME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CFE20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 224026EB5D;
	Fri, 20 Mar 2020 18:28:03 +0000 (UTC)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6D96EB58
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 18:28:01 +0000 (UTC)
Received: by mail-pl1-x642.google.com with SMTP id g6so2874323plt.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9hcDrrvElZeuqsqFKuLu/YBXfd7bxU6CI88wJ211B28=;
 b=KIYpczMEvvp4jCK4RpuBBB4cz4rpdMK6w2Kft2o2WpSiLMIc/pOrZaHZznc8MLsZvE
 VoDEVOLluFMCJPjTJdlcrvUzvYvc755tJrrdm8w6YEmDY582wwi2xiNf9vfC7Q16P4/k
 LdSkxtJUnO+lryVc7bRpViNGKPY5qfME3Kr4Os2ycsB9NWVjANcDz1vEsaZ6DXCGXpfT
 IdSgyOzkJ3U1P7zn/koh1j3H1c6d0B8S3S+QYKwx9CSEWCmN0iat6gAwp8GPV4/3WUmD
 lyLbHv98s46RNKfVxLxtmg8rHZLKJ2b62h76KB7PMyvG/z3CCDHHViRRdSld3tsUmqQj
 FsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9hcDrrvElZeuqsqFKuLu/YBXfd7bxU6CI88wJ211B28=;
 b=AitvMsziwkqc+DmzYbRw9P5do8ahoFuy4H/ewkiVXBK7BG6y+XxNrs/fsLRiQUoNJe
 FCa7Q8m2nNFobv+YEymv4K0gRHpthmZfXyFjuU/n4l+lchADOK+s6DJaj9GGKoYGgw4c
 e49jp3vIlKx9uRiFfvGdCXTnewwvQNCG+5iEoAH/D8Ob7S5qYgD+XJIEz9RewcLcOLUH
 dcbzkJvTTOkVwLnDswPQRxVVBAJVHjBZ85Q4rr1gnQrxnTpzxuPW+3vb9fsCxuR0VSZk
 qFnC+tp9YkhTOHj3gPOTtDV6mgW9xS8WScu7fjKszO32adA80/duiYvsHja012pfEeo7
 nysg==
X-Gm-Message-State: ANhLgQ1Mdt3FKD0XdMgZrO0hOZK+wwnjjjSXLeOPFOsHr+DC6U0V6Qgj
 KLQhEWpt/OagLU76AFxM7JP/Veh6
X-Google-Smtp-Source: ADFU+vvhAxqyk0ifBRVxwK6NOxYntBzPL/fyBnr/3S4j1XSZOCIKtoLCaOaqf5da3wR5nN3lbwFymw==
X-Received: by 2002:a17:902:bccb:: with SMTP id
 o11mr9942677pls.281.1584728880424; 
 Fri, 20 Mar 2020 11:28:00 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id v185sm6233850pfv.32.2020.03.20.11.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 11:27:59 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] drm/amdgpu/smu11: add support for SMU AC/DC interrupts
Date: Fri, 20 Mar 2020 14:27:27 -0400
Message-Id: <20200320182727.3805-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320182727.3805-1-alexander.deucher@amd.com>
References: <20200320182727.3805-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mcoffin13@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver needs to send the ack message when it receives the
AC/DC interrupt from the SMU.

TODO: verify the client and src ids.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 20174bed11ce..d19e1d0d56c0 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1525,6 +1525,13 @@ int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu)
+{
+	return smu_send_smc_msg(smu,
+				SMU_MSG_ReenableAcDcInterrupt,
+				NULL);
+}
+
 #define THM_11_0__SRCID__THM_DIG_THERM_L2H		0		/* ASIC_TEMP > CG_THERMAL_INT.DIG_THERM_INTH  */
 #define THM_11_0__SRCID__THM_DIG_THERM_H2L		1		/* ASIC_TEMP < CG_THERMAL_INT.DIG_THERM_INTL  */
 
@@ -1558,6 +1565,9 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 		break;
 
 		}
+	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
+		if (src_id == 0xfe)
+			smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
 	}
 
 	return 0;
@@ -1597,6 +1607,12 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
+				0xfe,
+				irq_src);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
