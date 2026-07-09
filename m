Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D533C44514
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80CF10F6FE;
	Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SFDnp1Pe";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB5E10F6E8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7sweHyvoFw/hZ5UR30KmNAi1erMz1ys4VY/imDH233nsWdx4ZR1iiYG3gRgJ1aY4h6JPHRiKVfHZrCtGbFREVx9a7jUW/gd3nO6q6IAltVLrykHoFAdIld4UTIbYHqfPRHZBF5TGUVhNI7kM3wW+3TgjvQFlIR0FBTEW8BvxHU6VXiAxtd+wJZfhfqU3E1PiSYOvxrl6RL91uxGzo1IzkHwYpe1S6fDCThHYWps+T7y/XDJFUzWQt74c7G338WtM+kWpFtZFSO6DGb7bXT/9V6o7vg+vZkCWLRq0k4gHLxtsEuOk8Ciha2iFAXAIv1hySZzd4NHE1kT9Nz0UPFhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBSr2whzK8b5ids+mwzBGwUBLhbi94Sw1FxWJciw/W0=;
 b=iFj+ogaG8ASijFMrad2HHED+LWnFfy4tNz24g2xWgHEwSaAsfnIvtL9oFblXob1hUpxqhPIdPEcCJGJwWV/FxqN4WmZbblVTFVeSYbYe9GikvPzHQMGcdKY5wu7VEoDm3ZCXdMbkmeEdTVROvRoikjBJ823WNWGn7RANLlRxGdC478TrKMTnrBAbt5KIwGShHxeKu4QGEFtSMHb4+/3ew+f/V7bQCm4G7+HnyAP40Yd6MIWFh+cs18MZiUl5TFPaKTRsLx3GDXaWv1i7Ba/oqWNZdy84c+z0XOQNOicHqR0CjwwcRZkns9/EePQBdjVyXbBL4wQ6TBKkGYi/kegaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBSr2whzK8b5ids+mwzBGwUBLhbi94Sw1FxWJciw/W0=;
 b=SFDnp1PeDoz2Ju3rssDZGEkga3hp1KBABBVwQJv5CaHRvsouSCgzXM6XWbAxbox9blIIAxhTNBbogD2d2vxggoYdmR9yMTY1wnYTpRWV03KfigulM77xqgtt7Ea6aQjDqZPk/U/53NdsXcIsPeVsbnpgBmWL3+RicuO/M76lypk=
Received: from MN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:52d::19)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:36 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::49) by MN0PR04CA0020.outlook.office365.com
 (2603:10b6:208:52d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:36 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:28 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 68/80] drm/amd/display: Exit LS for ISHARP before coefficient
 write
Date: Thu, 9 Jul 2026 16:48:36 -0400
Message-ID: <20260709205936.5719-69-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0767c330-3b4a-4087-0e75-08deddfd678b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: E3M9nrgpj/KscFe6TbzURGE9EMsTmCbT5r0feobTUxprI1qFu3HdWZ3vttx65iplv3FSrNdkowzBVZYgLK6euUBtvAwdKYSKx9kmB5985lzmHlgiQvqzPXp+c26yu/B2ZAN3coh8Op9SeBcpViNZRblXfqoDpzE7ItygbmiBK/3bxXaE9YguVsDJ4AHX1MmDfZDXPD8h7vEjjkMqLrvQKkPWg0FexSzTNr/2qEynt0jOeGa81HXon28wq3OYRcjDwHomCJsxzPvRrkAs+rV+lUHIJXcsDZ8x/09eNsxdASYiEozSuS/rpfMBsSzlKFjpMf2YgJrh5Q73Obs1tWesR1Es2T92OUupcVZc1rAcTLmdgW5oS8e2D5+zFu1AGu847xSR+9rpr6lgGv6dq++NFg7ie4W8FpcSl60+2qKw7bv+MT+jxeP1MJF205zBIjaPoz3YflbCA1L5ZGaUn5r9pPW7bWfEVkKAsG+rR4bkKF637kKdgt1d4pK7vM+3jgzCE58I3dboEoWJglVj0ggCLyUtAFeUvsnxQDgRfv1Ji/dltx8f8jw3znqAHhAa7Di22KAUybKPR+iFcq90p+HPr2qn6BUbbZ9yCiYfWgWcV9568zq2BuVc4YSEm1wyP2FwCbtSHv0KKPsQ9VHiBgpcgpKrhjHUqITgtQbPzSCcoU+G3Ze+7TPAlV7P/zrwgLb8rM8xfTNzqBsYnZAw9bz1Kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /2RgGsl4PaeuupOO8SRKgeFlM43zRPnI4G91ktyX1gpuSG1fjoJDq1YABdlIA3jAWGtzsrFcTn6GSjQHz7BDavW0jjHr7DYFyYt1RPmaNXLdUJ3Q24qdYkAgf5/MsomRGtX48aQaW1r5AOqPoGTT+RXDW3iI0j7Rqs9abMAZg9jdSB/Huk2evn3IuSqtE1/YUV2leYyKZLt6atOnuWdLPvemeelgKIAniD1iJFud0PKOm2IgHPKc84FAREmXD4RXEPHLOUsJ0dL7tGAUwIhwASkC0FLxomDygmKXry/MNkuiPG4Wcnh1J9IEFl4CzGbI1bG7JbdDfUg6suwI51fCg+1a+U+kB7wAKMeZmJFNKRRyf6jrIXbyrCwM4VtN12mf1GqzUHb+gZyG8SdtlCR85yyVbN5nzc70SdDx7ubOawo7LCVvQtqc5MDwhiQbAu63
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:36.6477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0767c330-3b4a-4087-0e75-08deddfd678b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The hardware programming guide indicates that we must exit LS before
any coefficient writes.

This is true across all ASIC for this block.

[How]
Drop the ips_v2 checks and unconditionall perform the update.
It is not based on IPS V2 support, which is set for DCN42, but rather
the presence of the block itself.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 62994aecf499..e0ee00c955bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -963,14 +963,13 @@ static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 
 	PERF_TRACE();
 	/*power on isharp_delta_mem first*/
-	if (dpp_base->ctx->dc->caps.ips_v2_support) {
-		/*HW default is LS, need to wake up*/
-		REG_UPDATE_2(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
-					ISHARP_DELTA_LUT_MEM_PWR_FORCE, 0,
-					ISHARP_DELTA_LUT_MEM_PWR_DIS, 1);
-		REG_WAIT(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
-			ISHARP_DELTA_LUT_MEM_PWR_STATE, 0, 1, 100);
-	}
+	REG_UPDATE_2(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
+		     ISHARP_DELTA_LUT_MEM_PWR_FORCE, 0,
+		     ISHARP_DELTA_LUT_MEM_PWR_DIS, 1);
+
+	REG_WAIT(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
+		ISHARP_DELTA_LUT_MEM_PWR_STATE, 0, 1, 100);
+
 	/* ISHARP_MODE */
 	REG_SET_6(ISHARP_MODE, 0,
 		ISHARP_EN, scl_data->dscl_prog_data.isharp_en,
@@ -1049,12 +1048,10 @@ static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 	}
 
 	/*power on isharp_delta_mem first*/
-	if (dpp_base->ctx->dc->caps.ips_v2_support) {
-		/*HW default is LS, need to wake up*/
-		REG_UPDATE_SEQ_2(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
-					ISHARP_DELTA_LUT_MEM_PWR_FORCE, 0,
-					ISHARP_DELTA_LUT_MEM_PWR_DIS, 0);
-	}
+	REG_UPDATE_SEQ_2(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
+			 ISHARP_DELTA_LUT_MEM_PWR_FORCE, 0,
+			 ISHARP_DELTA_LUT_MEM_PWR_DIS, 0);
+
 	PERF_TRACE();
 } // dpp401_dscl_program_isharp
 /**
-- 
2.55.0

