Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A46AECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 17:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D46A10E049;
	Mon, 19 Sep 2022 17:58:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73772892CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 17:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663608449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7NsGFKg7Zzx4zTkQ2pzi2k9DjtPnYYJNY5qhCGrS9X4=;
 b=Pv9WfjiOBEmwMJSUOge5IqNiLgYwkWxS0NygtRivs1ohtHO+5BmBNSwkQlx0T/hgPb6Y+I
 WnssDdsOvrWkbtgZUFnslubeAlzYze5rNoZBGTKOSkNfQ2KdUwGFdPBtVhj9hhWyo2pW+8
 R1KYFoqkezWHS6v+HD79+5cu5sPfVR8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-68-1gVnfQobMmWFwncbOJHEWw-1; Mon, 19 Sep 2022 13:27:28 -0400
X-MC-Unique: 1gVnfQobMmWFwncbOJHEWw-1
Received: by mail-qv1-f72.google.com with SMTP id
 oj15-20020a056214440f00b004ac6db57cacso158072qvb.17
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 10:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=7NsGFKg7Zzx4zTkQ2pzi2k9DjtPnYYJNY5qhCGrS9X4=;
 b=mV1OK2DCZyxus1CLF1QO2sG8ezfmhvJlzVWBxAW5N3akGHAC1Iz1WiBQtrEPVm1dp7
 xSqNaYd2uWhpEw07COQao6vwiiDbvul18eKgXsJVAxOxT04Ew4SLx9b85DhE3gRJ/ly9
 ATr3x11rTvyF9wVtDpHux3dzI6jyCZmo/lPZFHPMQxq2V8BTH8K9apkIiqVYWefV0NBk
 t8PqVMKGhrPzAv4FWyOJskHGqFVz1SUrOYFsQxm2YH5W1JgJGTUC51zR3+BPPQrQT1SN
 apjygnthPDUCNPxXgK0kiUkr9FqOzCywn6f4VDmJCimlim25lGqgf7eBrQcD5GOZwWba
 F8SA==
X-Gm-Message-State: ACrzQf0ttfuzK9pkxBICdx/Eawa3jDLwwGS6E54HWrfWu5aHrEkZ/EUC
 IE/FGHyN/T44+tp6R/8flGNFufwIy0EhlRyYVoHWd16N+sZDubutIlteSPqjd7TQu49lCEe38Ug
 S/hMD3y2935I4Vt4YdYqpiB6zHQ==
X-Received: by 2002:ac8:7d55:0:b0:35c:d884:449b with SMTP id
 h21-20020ac87d55000000b0035cd884449bmr11878620qtb.446.1663608447764; 
 Mon, 19 Sep 2022 10:27:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4i0rlAyGMYCTEgKC4McJT8796QdIatMpbatt/bB5p0sKvwg1QXcySq88dwTcJrMAFNtAKCAQ==
X-Received: by 2002:ac8:7d55:0:b0:35c:d884:449b with SMTP id
 h21-20020ac87d55000000b0035cd884449bmr11878594qtb.446.1663608447532; 
 Mon, 19 Sep 2022 10:27:27 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 w14-20020ac84d0e000000b003436103df40sm10674862qtv.8.2022.09.19.10.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Sep 2022 10:27:27 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, Nevenko.Stupar@amd.com,
 Pavle.Kotarac@amd.com, aric.cyr@amd.com
Subject: [PATCH] drm/amd/display: remove redundant
 CalculateRemoteSurfaceFlipDelay's
Date: Mon, 19 Sep 2022 13:27:20 -0400
Message-Id: <20220919172720.3496405-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Mon, 19 Sep 2022 17:58:31 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are several copies of CalculateRemoteSurfaceFlipDelay.
Reduce to one instance.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../dc/dml/dcn20/display_mode_vba_20.c        |  4 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 40 +------------------
 .../dc/dml/dcn21/display_mode_vba_21.c        | 40 +------------------
 3 files changed, 4 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 4ca080950924..8e5d58336bc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -158,7 +158,7 @@ double CalculateTWait(
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
 		double SREnterPlusExitTime);
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
@@ -2909,7 +2909,7 @@ double CalculateTWait(
 	}
 }
 
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 2b4dcae4e432..e9ebc81adc71 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -182,7 +182,7 @@ double CalculateTWait(
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
 		double SREnterPlusExitTime);
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
@@ -2967,44 +2967,6 @@ static void dml20v2_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateRemoteSurfaceFlipDelay(
-		struct display_mode_lib *mode_lib,
-		double VRatio,
-		double SwathWidth,
-		double Bpp,
-		double LineTime,
-		double XFCTSlvVupdateOffset,
-		double XFCTSlvVupdateWidth,
-		double XFCTSlvVreadyOffset,
-		double XFCXBUFLatencyTolerance,
-		double XFCFillBWOverhead,
-		double XFCSlvChunkSize,
-		double XFCBusTransportTime,
-		double TCalc,
-		double TWait,
-		double *SrcActiveDrainRate,
-		double *TInitXFill,
-		double *TslvChk)
-{
-	double TSlvSetup, AvgfillRate, result;
-
-	*SrcActiveDrainRate = VRatio * SwathWidth * Bpp / LineTime;
-	TSlvSetup = XFCTSlvVupdateOffset + XFCTSlvVupdateWidth + XFCTSlvVreadyOffset;
-	*TInitXFill = XFCXBUFLatencyTolerance / (1 + XFCFillBWOverhead / 100);
-	AvgfillRate = *SrcActiveDrainRate * (1 + XFCFillBWOverhead / 100);
-	*TslvChk = XFCSlvChunkSize / AvgfillRate;
-	dml_print(
-			"DML::CalculateRemoteSurfaceFlipDelay: SrcActiveDrainRate: %f\n",
-			*SrcActiveDrainRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TSlvSetup: %f\n", TSlvSetup);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TInitXFill: %f\n", *TInitXFill);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: AvgfillRate: %f\n", AvgfillRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TslvChk: %f\n", *TslvChk);
-	result = 2 * XFCBusTransportTime + TSlvSetup + TCalc + TWait + *TslvChk + *TInitXFill; // TODO: This doesn't seem to match programming guide
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: RemoteSurfaceFlipDelay: %f\n", result);
-	return result;
-}
-
 static void CalculateActiveRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index a3ef3638d979..d94aaf899f9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -210,7 +210,7 @@ double CalculateTWait(
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
 		double SREnterPlusExitTime);
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
@@ -2980,44 +2980,6 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateRemoteSurfaceFlipDelay(
-		struct display_mode_lib *mode_lib,
-		double VRatio,
-		double SwathWidth,
-		double Bpp,
-		double LineTime,
-		double XFCTSlvVupdateOffset,
-		double XFCTSlvVupdateWidth,
-		double XFCTSlvVreadyOffset,
-		double XFCXBUFLatencyTolerance,
-		double XFCFillBWOverhead,
-		double XFCSlvChunkSize,
-		double XFCBusTransportTime,
-		double TCalc,
-		double TWait,
-		double *SrcActiveDrainRate,
-		double *TInitXFill,
-		double *TslvChk)
-{
-	double TSlvSetup, AvgfillRate, result;
-
-	*SrcActiveDrainRate = VRatio * SwathWidth * Bpp / LineTime;
-	TSlvSetup = XFCTSlvVupdateOffset + XFCTSlvVupdateWidth + XFCTSlvVreadyOffset;
-	*TInitXFill = XFCXBUFLatencyTolerance / (1 + XFCFillBWOverhead / 100);
-	AvgfillRate = *SrcActiveDrainRate * (1 + XFCFillBWOverhead / 100);
-	*TslvChk = XFCSlvChunkSize / AvgfillRate;
-	dml_print(
-			"DML::CalculateRemoteSurfaceFlipDelay: SrcActiveDrainRate: %f\n",
-			*SrcActiveDrainRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TSlvSetup: %f\n", TSlvSetup);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TInitXFill: %f\n", *TInitXFill);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: AvgfillRate: %f\n", AvgfillRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TslvChk: %f\n", *TslvChk);
-	result = 2 * XFCBusTransportTime + TSlvSetup + TCalc + TWait + *TslvChk + *TInitXFill; // TODO: This doesn't seem to match programming guide
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: RemoteSurfaceFlipDelay: %f\n", result);
-	return result;
-}
-
 static void CalculateActiveRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
-- 
2.27.0

