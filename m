Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F255FFEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BAB610E7B2;
	Wed, 25 Mar 2026 07:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="thXTxn8N";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2820E10E7B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:11:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+8hlK513ZEdSXo2I5EpfXbzqXN3eOu/Au1OgymtiYVi96jHnwBH8TMHK+nxVb41sWclWAzxio6XeXXpymvhPQR9p+IHrqzKAe96xWnuMcAdA2AP3uS6wRVe6ONk645lEYGPCxefScTQAgq2dEfeEX2sJcOWF27GjFA+LCq4VZhSG5zTuM5XO3lSXc5ykhR/WX8AnRABMn9LsquXmkgZDv/f64NJ6N3RRoAbCY7JmVFjewleXJ6bS9Px/Oxa95NclIYY2D/7G733gBgxT2514bkbJ7zir0EspIw4pNaxsE0jGB7QnMVZA5tHsOX6ixv+eIv+C0PWbcfsr4FeZY30GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZF+WRRrP4WOs5AY3dPAONNW9PM5H+pJNVvplbUrhg1M=;
 b=H6pbQG2HCovX71b8/h5OXIXgUWaW1AfmHBZtNU82eMOwgYStAOGGQAgzo6+URpCb6xFWOGOnDrEaPrBiYQ4+VXp0UMP5+17O6deOeTDqJ7OoRJLR2QY4Oa9M3fULAjOBACqa72nCoLkXzIC4+Orgc9DEGxPRHgFpVtusrwGaQyVPSpEBvD4H/lbaBAPImThb5HWB9oIaTwmGh7POMVjkTOw3j03s9/zxX2qeTjXNzME51kSheYgbG37Lbyser1cWza0B5Cezxhboy3Z/1RVqvFMqUjvyWbWKyYugr2KWVB9LVsOr2tTY7j6/N1de2PCu/2uOh/dIxzSRqKuxFhx7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF+WRRrP4WOs5AY3dPAONNW9PM5H+pJNVvplbUrhg1M=;
 b=thXTxn8NlKDUtGiJjSgzYRYwk/mxs2zEpKSM7+6cNfb2Vd8QqyQRtJlNGmxvWn7yRdxuhdjSSqs+su6LLl9S1UPCAQVX1KFkh6S8ihsNbM3asKjp0bu/6a7aBdbHeC8UzweaBrhlgdnM5Cyr0ahrXt9SaOSp+TQ6q1SEntLzq8w=
Received: from MN2PR15CA0044.namprd15.prod.outlook.com (2603:10b6:208:237::13)
 by DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:11:01 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::3d) by MN2PR15CA0044.outlook.office365.com
 (2603:10b6:208:237::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:11:00 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:10:55 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 29/29] drm/amd/display: Promote DC to 3.2.376
Date: Wed, 25 Mar 2026 15:06:35 +0800
Message-ID: <20260325071003.4022594-30-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DS4PR12MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: 188f0865-8d97-408a-6a5a-08de8a3dab96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Lp/5j5yogL6uVl+H3EM9QJ5Rt0XvCtitWl3ViB56P/eW87iR700kRM5rCsV4XJQkxY2IzSrWYFvL2Sd6xQoSdOeq4cY+6bVCWUpwSVJ1Rapd9s+WaUnlODy+EN9jUYNpxgvxzYADcw0E9wUIE/kXvsXcg8ARnX2cWO2fu9pbQsB1ku8HLfwqTz/eU/2u/xzBe5HZJ/RZJPHLnn7qX17VcJBtUSTPM+7qSVJmB1DBet6KIlbxkNWPFIHbklA4wDwYABSKOOVNcvTjINajzchWExp2VlEgYg6lUNvyvdVe6exF4MEZqdgrGOKO55rleUl6WSDSmfbVf/O64BwP0V1Fvv9duVAXpLoi2tYHHrYnKg4twyQoc6yViEimTk2b6cYePNkl45Hhom/ljrcn90Kz+FeQm63w3mWw5Ui97OEa18kzC3a3vYF5brdwxblZ8M45bscVpGrH6Cp+yk+V9Hl1vdwYI8IwGVbkBoa+ddDjedzSSzdZ9dWDS6E4YAlYZQFOniwZWUkzPNTFiNCPaS+yJcCmdXRE7es11ouAoK95FQXsDKdhd8k/7TZtqatd3mnn2ZwlF8vz/2Uo/opObf4iC+64pCCfPa49Uq1JWea6mX7RmhvsE6FifgJpBfPo2MifB0KjBaXRSMZ9JQviU4bQCTz+LndFXmVLwxMhKAGYsMIjNs7MyoEclQTVdyY+vddT4fIApESf0oh/hTvGad+Am+R75c4AQw959rkIShr8mXTke3xcbXNz823NHDSghP5WRAOGlgc5vTkYvjTpl3xIlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tD7vtrROQeNaBXSnpGUyOa0erzQk5LE3nIxCv6lNx+pVqiJbZRWToUUxQgHRLN3VedhK/AVTMIRgC+u/AtwWvmPOSlNg6fygEKs/w5Z2JI3im7BceOI1d8h4FgERptIaAzmySJLn7OD599W5ib6wuen0CTf4TcXjaYJjeEVBTyUKOgi8Ya5iSqjddWZHpOY19iLqrePoOHdm/oTlJT5q8vx2udAlINQxM5LZEy3cJotoRgJDz0ozDkWNrRX4IAZX35wDTllfdswZZnRrynYJlYy/jKgdD4UcHsnNQgnWSPh/LYkYQbY71bySUe2XHZriJN+oIeOw0a7rjLuAXzZ7xEbNZr2ZKaN+C/1NtFju7jcVIysYbifSbY7SWysu0ZKYpy3DEAFz50nIlIN4TG7+sp9TtP6gfG+IOnv8e/ydVF3omETRG4biGNfyYQ+L/xzP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:11:00.9223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188f0865-8d97-408a-6a5a-08de8a3dab96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9612
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following fixes:

- correct unknown plane state patch
- Revert "Refactor DC update checks"
- Revert "Add 3DLUT DMA broadcast support"
- Remove invalid DPSTREAMCLK mask usage
- enable eDP DSC seamless boot support
- Revert "Rework HDMI link training and YCbCr422 with DSC policy"
- Disable PSR & Replay CRTC disable by default
- Fix Silence Compiler Warnings
- Add link output control for DPIA
- eliminate clock manager code duplication
- Don't set 4to1MPC config dynamically
- Merge pipes for validate
- Fix bounds checking in dml2_0 clock table array
- Avoid turning off the PHY when OTG is running for DVI
- Should support p-state under dcn21
- Enable Replay support for dcn42
- Remove check for DC_DMCUB_ENABLE on DCN42

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index afc06dfc161f..55ec281db3b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.375"
+#define DC_VER "3.2.376"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

