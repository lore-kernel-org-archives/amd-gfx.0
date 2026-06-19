Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D905CD98F2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED90010F5D9;
	Fri, 19 Jun 2026 13:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BihlBI4a";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B83D10F5DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWmv0N/+GOjssKM1MKWO7FNgCVxnBSytMcJgGloYmuCNdyRMSjZUhDc0ZTjwXhWdX7OOAWhKZcHGCIUZSVdUXfAIo0m4AKbiKCuxO7D4tFty+AWnHqQtBreLOKrD3W/3k4I/8DFcX32NgOVZk6vmlJef8rPGZtPdzT00BoeykebSctFl372VKTqt7tqp7wcLYvYc41lyltAzFAemHAc6bYVPIAJxW7dbXGtL4poqLXsgmkABg6+YycAk1IJMnvZVuRakdRCFFCVRswjQBDOZd10U5AK+l9rxt8g9DucZUttfwOsYPOAbmTLE6iET56d0K7H7Y3lVUlokEStJS7+Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWDIl9oqGf9pETdaRf1RlkjBdewcFnoy3KUfyA2JRDY=;
 b=cK+3ppmISbQV/cPR66vFgE81MrhiDVMntqMIb20cLWK+bXIgNTottsrOD+6mMoYhs82k+p2eDwPxPJRp4FMu5mMVSAaLjYLoNcoMWQ+PlO5/ALkEYy65P0G3kTb8Fw7aiJRzkRkIZce8DUiktRejfnjVFWbDLYznh2CAefr3K/4dYlF96k/C6tPxTrd6RrG9g1z9gv8mBal3HwsyZfIrs62HE4Alo2MYebbYn/T0jbqs2ulp2u9kfDkSVCMMLpzWS6s0o+RaN8lwAg6HBkmeZRRuwbghQkCiS2P8yEgO2zzrObY0AmVebk02TBd3fh1L4iEpRwyBrlqU0ieJXL37Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWDIl9oqGf9pETdaRf1RlkjBdewcFnoy3KUfyA2JRDY=;
 b=BihlBI4aRhTUZPr2uSP0glo2fvPc7V5mD/hyOv200Lc7XvHxPGK3ItNBqdq2ZuRiftHYvgBscaBUT/3vNZzY656NgCWW2nMrmLhycpuLymstmnLAecGcqpkuLHz9BfEJpiBYFa8zbXg0/N6onJytnNVd/7r8L8cfrKs+jMiSRJE=
Received: from BN9PR03CA0346.namprd03.prod.outlook.com (2603:10b6:408:f6::21)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:32:25 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::6c) by BN9PR03CA0346.outlook.office365.com
 (2603:10b6:408:f6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 13:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:24 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:23 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Ovidiu
 (Ovi) Bunea" <ovidiu.bunea@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 07/24] drm/amd/display: Fix DCN42 null registers & register
 masks
Date: Fri, 19 Jun 2026 09:21:22 -0400
Message-ID: <20260619133154.116746-8-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dacb3ae-f248-420b-f2a5-08dece0732e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: j/4FkNlmrv+DAw7GBXNoM7w9TRcvu4SlY9PDgZlJFKrQ5YEwW5V+fkzSDSPVEK2C1LD6DkbBtTWOnvNDe/ylSJI1m6vsPV3G0mM812gIGofGxHE9WSO8liIlbbhJG0mBREIrUSaoD7hKXhya9b8x3l+ufnAbgSfBaM8M1FvFWFR4bMfxHiIkeqwkQ6rNf6e6LGc/zYHMU1RR/kP0/8u+cypNQLc1vv7PWEzaoIawfHEj8EuMfNCqswXYw8ldGhiJicDOJQlcvv1I7v6oUPJYMUAx1qv9+Ez2h96+t4p9Hy0av2QRoYSeI22bhLoO/RHnnuPyssd7Omw78C/v47imddHmHMZ9QVAFhV/6Z2YcPu87NOWqsaGtOb0JYe1gs+zzvPDxkOX5lEQfAM4G3K2OqZzqHD6ZsvxMVlzDNDJyKQBu4wBeq757+5QhpEUPvvyqP87ufteF7OeBtDwI6qyRWnWWfQTWS14zY7VbcFo/JIcOA4Qe4NKwCZ4l3/XPJkpkmoaxvkc1WTS6lHt1mno4wqtAkIAjxzYkuIEqwbbKe/z/WSUEM3IdSrM7iqjoRvzlPE4kE33gVSDfhcwgRUMk/PjfvqBDxnATDgAbNCxt5RUEEJkumFe+TSnCbLwY3sdqy4tAaXI3aaMpAeMDCgGcGyKvDVpRFKyPezpUxq/ycQdYpWSRj3dWZi3BVP7IlVaYLuk9iV2gDm/nTQ5NcZ9FwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YhPx4CALD8pM84Yf3LbsOkg2voR2VrhyJHfelIoYPCwqblHat9Lm+Y2hnzwnP8NrjGUHk6r7gLbl95KxoWprGMBCURk0nwBNoSDmJiSJzCbhT/fiWtqrIj+Hz/CNjimVTOpA4/CUNLJPAeDaFHt6+tWv7wb+Cwt6ibd5/ztJwgK2fbv7ip/n7312dX2qJ88iysy0dG6GZeybGNAZf0h6brX8Tt3tk+tt/58FV/MSoEv1RYqs9zXUjqLQSEMo18r5y/f7F2s2mClGYsR3U8kbFQYeC37WXt7l1B8MtcqiWX8mKpjkkFTvrZLODoDMvi8sfNvJ/Xb2j/JjQ3dJmsrKxVI6ltpLdX9ViMpazBKTOZQ2B31JCYqlhx18mVFiMxTAreneqMJqSL9dCjqHS33RH/PDK0nafzMFJ9IBV7u9iqblvysO9Oz+BVMsMvfdvql5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:24.6713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dacb3ae-f248-420b-f2a5-08dece0732e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[why]

The register lists used on DCN42 variants are different. Some reused
codepaths are trying to access registers not used.

[how]

Add DISPCLK_FREQ_CHANGECNTL, HUBPREQ_DEBUG, and HDMISTREAMCLK_CNTL to
the register lists.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
index 2076565b1caa..d45e3af77aad 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
@@ -46,6 +46,7 @@
 	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_STATE, mask_sh),\
 	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DCCG_FIFO_ERRDET_OVR_EN, mask_sh),\
 	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_CHG_FWD_CORR_DISABLE, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, RESYNC_FIFO_LEVEL_ADJUST_EN, mask_sh),\
 	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_PHASE, mask_sh),\
 	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_MODULO, mask_sh),\
 	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_EN, mask_sh),\
@@ -239,8 +240,7 @@
 	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_CLOCK_ENABLE, mask_sh),\
 	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_EN, mask_sh),\
-	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_SRC_SEL, mask_sh),\
-	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, RESYNC_FIFO_LEVEL_ADJUST_EN, mask_sh)
+	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_SRC_SEL, mask_sh)


 void dccg42_otg_add_pixel(struct dccg *dccg,
--
2.54.0

