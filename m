Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3708C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78CAD10F0B2;
	Wed, 15 Jul 2026 13:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BCTTO3Cy";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6174810F0B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJtPo76PmvMku1QX3zD50+QvaUeWhDCPjYDNp44w9/UvmQV4rule3lbKFt9wsbSGJ0WUEs04tMx/7QJ8CSVnj2OEnO9LjUfBsrh8lIXXMaou7pl0KXsz+V2BdaBNBBSXrs0+RMYuPFc7bpkQYdaw+XLY1IzwfZ1tqn7e4LN6Sd/XMrv7iMKGE6hiGPRmVUUeGF2eIYP0SEgvUor+Rs9a9tU9tyNh5fFTUCIibDB1A3jN6ek90hpK6Lkph7hrLVId6bQaqjjoMZ7d07Qyz5uuVK8a8aULf3ZXRn+Uvk4Lq3mWv3+R/THK47KJvOyqAFAhuE+8GsN8GPKcKPbch4oS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km+POQXVKXb5b4KPtBaTExdSmH/16jhCgFkDqwAcW/0=;
 b=Q8qevgR1JZgp2YFyqdPye7YaSuYXCVwOw9/E27PVgnYZXrQu42401ZcC8Pd3z39QXVUYzvVPA13VlpfT5jZAdeuYgYu6JR8ReEAC1MfqyUqhLnuV/9UMvg0npiwpDLDNd0kPfbZJyS4yb/AdvJ5B3WzZUgXYhBNbFxJrS3i9nal1afFiYmFJBYuYsLFwX7F/KZ3//n3bPQ1wR30CSMDTjgXIcQTnPK3Ldmh+T2KbF2u+7zvUtIPb8CmapB9Vnbt/6tDrHT0xtyr2Mtty/OBQAcoH1pOgdss391zhTwjReIOEOA34061D7dY5CRYP8K8lA9usz50/OZ3h29EjGDCIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km+POQXVKXb5b4KPtBaTExdSmH/16jhCgFkDqwAcW/0=;
 b=BCTTO3Cygn59TT80Pnp8gEtDZOp5dwI67+/JqZaDCn/krc3ZlDWUfVU2gqeqT+iN7dsFA6smsTSdjBx/4ccsuYL7UwfVPBf+N+Fts8K67wBjz7Kva6r///YEZey+o74CwZKNsMZ80DJrKZyTmN8srRoTL2CYzaWLAd80iobEoZE=
Received: from SJ2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:a03:505::29)
 by DS3PR12MB999216.namprd12.prod.outlook.com (2603:10b6:8:38d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:49:15 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::91) by SJ2PR07CA0005.outlook.office365.com
 (2603:10b6:a03:505::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:49:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:49:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:49:04 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:49:01 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Ovidiu
 Bunea" <ovidiu.bunea@amd.com>
Subject: [PATCH 66/70] drm/amd/display: Add DCHUBBUB_HW_DEBUG offset/mask
Date: Wed, 15 Jul 2026 21:38:16 +0800
Message-ID: <20260715134432.1975118-67-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DS3PR12MB999216:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb6a18f-5d35-4dba-3d26-08dee277dbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IYdrNx2yTqUkFEEv8s3kHlx/I1ehgPyeW7qtdKjDewMiI3E4XY90vSwBeITfMN0bGaB0j0NoDjb60hdsk6UtjwsUrdQhBMo4E9XhqV4g+V83yfJQEGzRUnAyGk4rZCn6LS/EHi7IfVoHypLDZ/nQK/EA4ya8NBeqhMDeAdERfbcZ2piM202oMc7hexSl6/MW0mbRZYcJzlxrQXXbLuRP6I4jHMik5kAS6D8q7dVD1qExmQRq23zy52m9bkjGes3snsOS2C5aHYwsvgHoAsSRKtDjN3shMNKnZb8hFY6oWmrq7c2K5WA8sdxh2XkRTaD3k4P9SZaQkQTvMZS0WMXkKYjVDETAZ5etftG9aABs7dRCEasdQ1ULOdCRztEWWqw9Vh94A/lynv0m4cFIyyzY5C89EZdFkrEYTJ144ZwbcWBeap2UYhxL1qUrQz4xYtNse9Kl/6X2vCBon77VvcK2IZlF4kcqTAUPUrPg5YcQ4Gn+y//N1SigO8BC0f3/fRYmVh+g5VX3cV2SYeiPPE1Dr4SUYnrUew6Iyx/EBWsrWHT2P6kOwyeSvG1tcWmctFYqC85eF8Ix03NiDgk3HIyjhMtk0lF+yZu/bHi/g3d8spiHEabVq/jr/uWSlg4j5FtxAIC/w/8TgYyEiz+RDuT+LrsFRYK2FS8pCuuhPaXFPIWwR/5IQIT8VdaC3lNAWV8I3OP6i9hEpHb9CntBzFNr5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RAGkUplWTtrKibWwUinABERAQGVZjqNItF9ebjTWpOn3GMMDDpw+2PqRbFGtGPgt9JUfZ3A/n0AT39NEkY5Y1kyDkLsPFNtiVOcSzMzDJxjho2h2j9v4Bynz6jPA/5T+ljFkYIBKaEX4XoYnHVvC8nMfPBqxOFSYb5Nib3ccnEewrPxqd8TNH/M5gn0W2n4JW8IwtzoNWuV2uPa3Y3p1zbZLhtIJvJcxF4qxosTygWFhGIDKcSALyn7atyEx+1r4BRErQqBUZew5mkopKqV+9j6JUfOBwb3rZzS7ubDsNcYLtvz3QulksBp0iYkwPn5Xjn3z+9pWN7fhC3FerxyU4Cdr2PxCIqFCOxQ16cwKfF23+6zVPG2O8TDIivWE68196e1rH8WB8k27/n8vCIPJNg/JnyhUG/6bbGVzQfqlBKVVryKaWNsFIzkFhn7uzObx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:49:15.1424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb6a18f-5d35-4dba-3d26-08dee277dbef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999216
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

Add missing register defines for DCN42B.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
index 5ae9fb76c675..ddc614c98234 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
@@ -340,7 +340,12 @@
 	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_DRAM_STATE_CNTL, DCHUBBUB_ARB_ALLOW_CSTATE_DEEPSLEEP_LEGACY_MODE, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_HOSTVM_CNTL, DCHUBBUB_ARB_MAX_QOS_COMMIT_THRESHOLD, mask_sh),\
-	HUBBUB_SF(DCHUBBUB_ARB_DF_REQ_OUTSTAND, DCHUBBUB_ARB_MIN_REQ_OUTSTAND_COMMIT_THRESHOLD, mask_sh)
+	HUBBUB_SF(DCHUBBUB_ARB_DF_REQ_OUTSTAND, DCHUBBUB_ARB_MIN_REQ_OUTSTAND_COMMIT_THRESHOLD, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, mask_sh)
+
+#define DCHUBBUB_CTRL_STATUS__DCHUBBUB_HW_DEBUG__SHIFT                                                        0x4
+
+#define DCHUBBUB_CTRL_STATUS__DCHUBBUB_HW_DEBUG_MASK                                                          0x3FFFFFF0L
 
 void hubbub35_construct(struct dcn20_hubbub *hubbub2,
 	struct dc_context *ctx,
-- 
2.43.0

