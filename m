Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC33C4345D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049DB223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icucfblm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049DB223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCFC36E858;
	Tue, 14 Jul 2020 18:24:48 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280D96E856
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:48 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id w27so13551246qtb.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dDF5Kh+ne23+bfDvOS3ImvgMSsBgnnsRtb3StLUsLNM=;
 b=IcucfblmlGI/j9mkZI94my+rbJRiyLUvORyR7sqSJrnG78s6ThchhJkjjZUDcAWV8P
 Bw8ICv7sxbl856j+u/vAx0g/guG+ihOwoGzaCoUQSBF3E2DXcThYtg10Rboqc2tYWBDW
 r+wIxUOGtG9Cd0BbpZZe6U0aza4WRcRpo8nipZu+87vMR+TYa25zNaTw4xxO96DgP7tM
 eqoxLWuSMvBpRPVcI6vhb/pHP3WepF2BKezIEewcWs24ztsLcrlyqtQPUR805WCmaoHZ
 473b1wHpRd/6NsLJHvadk4F9mPQmsd1Sa9eHub72rMmvn9fgcFhY5eu4+OqpWKZ9VaeP
 24uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dDF5Kh+ne23+bfDvOS3ImvgMSsBgnnsRtb3StLUsLNM=;
 b=KBGFhvI8XnE3N0N5BuuqnXsD1G2i2Iu/xn6hHenahl64XJP87gt5MtfeYPo9CjTEc0
 PrDogDmwAPeF2YG3kWAQtpI+IuZpD/ZPv61ZXikEcoaLYguk7A4spreQd+nn5nJr2C37
 yPlnwCr06aD30QCCsVzIBPNw2wTsnsg72mZA4rCcr2AXUQMfd4uoDoxO1EJy2m5Vm8E0
 4ItVJrIoCBw4wBZa9YYbZXaEXapIzcYDMbgaqVVqu0MFJrJsQBc49RpjZYaOad5cEoKs
 gaxqU9TT9do6bAb6dAj/Sv8TkI3gy57Ni6rUcCqbowQqPaa141PqKscLP/IKnNCD3RE1
 LwGA==
X-Gm-Message-State: AOAM530lObnUmVxHWPl38CgN7/0/OkNu+IcxWYeT2M0HFWfQswOTOf7M
 9Lxq9ONLGEKNAp96YQdhR5yGDRyK
X-Google-Smtp-Source: ABdhPJy3SWZ6YygyOW/erq8d6a+aEy7aeOXkTKsravRBmfTkbwga5wOTtzqxPQArxmkxbuJgta3fag==
X-Received: by 2002:ac8:305d:: with SMTP id g29mr6202307qte.115.1594751087151; 
 Tue, 14 Jul 2020 11:24:47 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/42] drm/amdgpu: add navy_flounder vcn firmware support
Date: Tue, 14 Jul 2020 14:23:40 -0400
Message-Id: <20200714182353.2164930-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add navy_flounder to vcn family

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 15ff30c53e24..dff3d3640c42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -43,6 +43,7 @@
 #define FIRMWARE_NAVI14 	"amdgpu/navi14_vcn.bin"
 #define FIRMWARE_NAVI12 	"amdgpu/navi12_vcn.bin"
 #define FIRMWARE_SIENNA_CICHLID 	"amdgpu/sienna_cichlid_vcn.bin"
+#define FIRMWARE_NAVY_FLOUNDER 	"amdgpu/navy_flounder_vcn.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -53,6 +54,7 @@ MODULE_FIRMWARE(FIRMWARE_NAVI10);
 MODULE_FIRMWARE(FIRMWARE_NAVI14);
 MODULE_FIRMWARE(FIRMWARE_NAVI12);
 MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID);
+MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
@@ -115,6 +117,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		fw_name = FIRMWARE_NAVY_FLOUNDER;
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = true;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
