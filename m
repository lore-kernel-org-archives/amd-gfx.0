Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933B6C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 05:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED75210FA97;
	Thu, 18 Apr 2024 05:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eNDIoPck";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1CD10FA97
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 05:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2NWeVvplsNVLatHJ+S/t75OFZGk5rNjbylT/vu6GSaUKzo4x7jprzwF9EFJyH3dO76MXWedic/CNjI8CrWgls59HNEuyRWaNa57bEf8IZYd5PYhqA7zxBPx3sZKmSeS9WLFCrIVIqZo2GslFKqdGKgAkGttDtQrmSifIAxDITG0OyDaCrzXDmduXk+VtfneXjsmvOMaDsyvJAUTwjAed0/+/rMpuebhvZbIq4xEGb1dBi/NYmFemEcjApm5Lz8gXGew/RitfsBApwLtG3ZeKUkVPN2jvTtlJ5LredYUwT47xkt/AWsufMQhXR6nVXTdubMteo/eDN90vyU6aeWflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByzQ+ItYgcqqzbZVYfWqHFHSgTK7z1XJ3KZuR7A+t+E=;
 b=E1BqQ0tkDZ650d9guQ9/+AAV4HjCmg/a3S++9zarCaqcSVPN40wJ5bTkd82afizatr2ppbc1dC0KK/XaCVVZaSeaL4vSjCcI08B3PhMuZXAqk6Fi2Wem6MqMNK4VXVzPR5ti0pVZ+ylGpRJZRN5fTnS8GuJLSVV5yQLTpsHpuKykHFBAbfL8YHodgbIv9oTXe7LLntuiuidPoow32MKidoIaBDBt2ZQqmZoK1flnuwmWxKnGnpqK1uUAOVmkMZYEH1G8iGNhzHhWmv2wV9f1N03ZAZPrNkRBIVQNdiI1gtFtCK3LSmWYsgHsEltIw/VF0K3frPoZaRWygjS9s/cHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByzQ+ItYgcqqzbZVYfWqHFHSgTK7z1XJ3KZuR7A+t+E=;
 b=eNDIoPckuXl1XMNk1BSqHshlj3FQL5KqpNy8nds/bfPtoa43KqIyVbvYbII0QDZCfpBtvGZbS7ldLNvecJ63HXAfHXrqqmF4REPi3iproAa0zbCGrZM6xUlmHQMgXnMbwuhGXvgkw7AAyjLtzG+46/ZF38L9XiCmrEGVo/l0icQ=
Received: from SJ0PR13CA0220.namprd13.prod.outlook.com (2603:10b6:a03:2c1::15)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 05:08:57 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::f9) by SJ0PR13CA0220.outlook.office365.com
 (2603:10b6:a03:2c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Thu, 18 Apr 2024 05:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 05:08:56 +0000
Received: from Peytolee-HPDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 00:08:53 -0500
From: Peyton Lee <peytolee@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alan Liu <haoping.liu@amd.com>, 
 Lang Yu <lang.yu@amd.com>, Peyton Lee <peytolee@amd.com>
Subject: [PATCH] drm/amdgpu/vpe: fix vpe dpm setup failed
Date: Thu, 18 Apr 2024 13:12:44 +0800
Message-ID: <20240418051244.2329177-1-peytolee@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 79016f8c-370e-430c-3cbf-08dc5f65a6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJAd3v8GxDHN9B2D84Tksdwr1cIXx7Yj4xc0lCRt08LLPB2sS4Binz1oiplEcIrFhULxVCp/5MNnUF8b0IMfybkwBPLXJMc3YtQdUWKGmsAmfdGN8mNnPcy7CJO5c4fJp//slpnyyESF9E9aET4V7bl2Of4O0ON/8r2bmOqqUAuY3nuQJ5iwMEACmRgMVrWzj4IEQHw4j+ivmhS9FTdwNjCRA64pcHVQZGpRHLZTTr75PKrzZYAEJ9/l4GffgHO1BdMwy8Cp+XE9lxzJKtMKpOw+2lck6dbB25jkL5h58WyL8FSiMj7f55dCR+QZ6gAH7HKPO9PbgzR7YCA+LXi3AIj9vDVEZp+nP/U8OIhgOezReSl3Jk+/8dtGlGza0CD/UqXsS24P8JZEgEeFLTo9S2gBinPYJccHb0yMTTyrxObJhwntDri3kQSWTSzmjGEUy2qtJPrVA6hlDrNVSCNJHB62BOYzsrVbaSawLxqgwsnQDlQox8Vjman5QjMEGFxOT4NIdf/ZDRBjitgvKlWVErWB6rlR5SPHhvx8KqgbBp5khl4L3JIWqwPszU+ua/boP2ltRLidHCKTaSjhfbXjePlIjEcHcWtKyteVvYOpM6j+PmVFWilx+V7Mw5l1JAekPvkeI9TYZeoU9HP/WHiHBZ3RCPOiJHvLX0rQ6bYFEs7mVAQAJkY/DSotshqBbQAx1CQhCFxMMgBlmZVpMWT671CGpwZMoIaVQqYGJB8TaRiovnX6g3DTz1XxKoOtPOwy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 05:08:56.8966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79016f8c-370e-430c-3cbf-08dc5f65a6a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
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

The vpe dpm settings should be done before firmware is loaded.
Otherwise, the frequency cannot be successfully raised.

Signed-off-by: Peyton Lee <peytolee@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c   | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 6695481f870f..c23d97d34b7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -205,7 +205,7 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
 	dpm_ctl &= 0xfffffffe; /* Disable DPM */
 	WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_enable), dpm_ctl);
 	dev_dbg(adev->dev, "%s: disable vpe dpm\n", __func__);
-	return 0;
+	return -EINVAL;
 }
 
 int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
index 769eb8f7bb3c..09315dd5a1ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -144,6 +144,12 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
 			WREG32(vpe_get_reg_offset(vpe, j, regVPEC_CNTL), ret);
 	}
 
+	/* setup collaborate mode */
+	vpe_v6_1_set_collaborate_mode(vpe, true);
+	/* setup DPM */
+	if (amdgpu_vpe_configure_dpm(vpe))
+		dev_warn(adev->dev, "VPE failed to enable DPM\n");
+
 	/*
 	 * For VPE 6.1.1, still only need to add master's offset, and psp will apply it to slave as well.
 	 * Here use instance 0 as master.
@@ -159,11 +165,7 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
 		adev->vpe.cmdbuf_cpu_addr[0] = f32_offset;
 		adev->vpe.cmdbuf_cpu_addr[1] = f32_cntl;
 
-		amdgpu_vpe_psp_update_sram(adev);
-		vpe_v6_1_set_collaborate_mode(vpe, true);
-		amdgpu_vpe_configure_dpm(vpe);
-
-		return 0;
+		return amdgpu_vpe_psp_update_sram(adev);
 	}
 
 	vpe_hdr = (const struct vpe_firmware_header_v1_0 *)adev->vpe.fw->data;
@@ -196,8 +198,6 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
 	}
 
 	vpe_v6_1_halt(vpe, false);
-	vpe_v6_1_set_collaborate_mode(vpe, true);
-	amdgpu_vpe_configure_dpm(vpe);
 
 	return 0;
 }
-- 
2.34.1

