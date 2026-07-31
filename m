Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B3FC55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E3610F403;
	Fri, 31 Jul 2026 21:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wMzNJD/A";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C2110F40C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYZT0BvmjGbpUB/41Nq3qAv+Yn+kQrpScydLJqiR772rGetnO99eKoy9TniriErCl5n5xwwFIOzf3d/StkSEDrKG1OvlLxS/9G5R7q72PWA56cRXFhq2dUdJUXPFj7ix/iDiGK61w2OC/7ax+Xgj86G1cmO6cEZGrowTMuC2QwFElXeya/6nhA6NiXtetTeNteJa691ZWPx+FKwiF21hTRNclO27NXVEUGtK15X84fJqhwNMRrvsb60RW92XoOTkMmxGyCjXDT0RKDBxqdr+e2jj8gP/DoVGBuhCOllwVPFuNBriUVI26CNfbzuUrL8Iqp7SSz14d+GVzcjB/YqQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVJJqBDw+cnmZzG1Q9PYLGG4+TXT9EiJ4uMy2ou+77Y=;
 b=yTFjYnXJSGRpk0/f3jAHj7GIFpPAaEDs8n7WLW4VP7aJ5/PZ3tGmWrAfGnLug1eUbW3/XQTxX+gNnC/1t9MlTVxF0JW3Cds0mgCB+78jhp7wy6Lo7gt4Jd3IAEPKIJUNHOcVSES9Ot8c5lGskrbpnNY8OMkgFG/st02TnbRQGoSxmAb3oyNbXFzFYv+57pbstPvrGb+fD8rLYI3EaoN4flV5As7FrYsf9I4tp47StvUywpYBEY42aNr5BW31oUmQViD8BoJOfHL6qJuYEpGP5ZJgreB1KTHuozVgYy1hVDmfBMlrU+0wDUQq8SdebGuOBmoS96JW2EepclMiH+cU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVJJqBDw+cnmZzG1Q9PYLGG4+TXT9EiJ4uMy2ou+77Y=;
 b=wMzNJD/ASKx6WNd24v5rCAjHiN8M58fjlGQAO5QfM7Bb/aBI0/xOUKt/QLtVv1W5lJBRoyfKELwIu0RdLnSkeK5XwA6y/9iNc7qlAIT63avYIMeWnKQRX0MI198XoJ/7fbmsV11k8ftugIcPHIGbX5xTKjGE7FyzhwjhY3M3dkM=
Received: from BLAPR03CA0160.namprd03.prod.outlook.com (2603:10b6:208:32f::25)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:16:11 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::11) by BLAPR03CA0160.outlook.office365.com
 (2603:10b6:208:32f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:16:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:06 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:16:00 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 33/41] drm/amd/display: Add missing OTG_CRC1_SELECT mask for
 DCN3.2
Date: Fri, 31 Jul 2026 17:12:54 -0400
Message-ID: <20260731211302.3040343-34-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: e6578597-ee17-418e-39eb-08deef48f296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Hw2Dy5runcfODz1TsbyRWEkHM69dMJP2h0PKcWnJElex0t1MnO7zoh8Jm2ywXgOnlXrRTb4LtutxpIGhQyBlV+VcXjoLBuBQUiwGvs8P3kta7Aj7yo+mdvZttYxZgrklpiN2JrJcCFZRxT+HabIY63Doinzvq6kwbvT1Poz6AvkSSwYep5lS0YvveSAZ0EeRmJAkcLhOZU0OPljSfjOVYXIImM0RokXxZs1/qLxqstXQRFmz/lXvD/TRE2TOmIt6FbfOrxKc4Gvm6cAQLtxwfffgzz/UDHlc+EPEXhkmvVNw8E3N1EhT8TjBZzblAWiggILyB/QrdwnUzltTWQtOEugW7yJF1VclvPIwAPhZossOZvqK93nXWVheS0IFV67ywck4g7/FPmCveGfM6P3VYDk/xYjITA5w0vqOcGAowX/trDnlYCRNO2A1dV/r/T/OL+0+Hbi6Poq4qbyruo2OvyOoo7cSrdlldGtJ40tWfnLNIXiRwnuPklaJUuS1tXwn33WuOHvR+raGpK2UA24JvFxElNO1kVkoJktaL1qDmAiLXI4j0/2KKB77J54nCTyCiT1GYiHVkyZK+N5lKApfjYZIF/P5r+U2gaOitDn67PkDUexbnTDvxnThneTSAWdSvLVdTzVTy9JBTsc0gCxmCHDL8Z/G1sonnbLxoLQqYVrCr8rhDL97Dc7H0c8GhBUT57r+zWODUynIwM1PzBeHQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BnUpHx4PIkRvU0kdJ2qGEIJ3QmgfN1EJWu7LpTrh+4bHxLRLPa4A3zxsDL3cD8YX1oKp8G0eT8DFHcQAiHZxwiOBa45s3JI6hnLj2hwZi4+xa/3dgyF48Ss10iI2Mt2OtoWb/et/gjVLiwPL3jI/U1mkzxBmeDvstGG4nLgSnFo6eOYiI29XO5nA9D00mordXGS0hPmjRWM+xZ/eVsHhOFNQZgTRvoHvvtNpGeyM2OCE1dM6u4pb7fIH79viJqXd9fgMvnm87pe70meC99ylTDLwwbOhaFhpfLsVXCQRcmkbiAY2b7uJ2IFtzJR/MclT1D7AphW0Ar21v7oED+Qc1ZtPc/V/Xp5W+88AagoPylCvwn2pSUiXeZUG1zgMuKX0jLN3YgA4Koi111M59sypjp0LbknVskIe9zuLEEQvOVOhcoJp7oe053wlbG2KwDrO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:16:11.9372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6578597-ee17-418e-39eb-08deef48f296
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Configuring CRC engine 1 via optc35_configure_crc() triggers
ASSERT(mask != 0) in dc_helper.c when programming OTG_CRC1_SELECT.
The DCN3.2 OPTC mask list inherited from dcn32 is missing this field,
so ROI[1] CRC cannot be enabled in DisplayCRC mode on DCN3.5/3.51.

[How]
Add OTG_CRC1_SELECT to OPTC_COMMON_MASK_SH_LIST_DCN3_2, matching the
existing dcn10 definition so REG_UPDATE can program CRC engine 1.

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index ead92ad78a23..7df1ed1102d6 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -132,6 +132,7 @@
 	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_G_Y, mask_sh),\
-- 
2.34.1

