Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199D1CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC8C10E648;
	Wed,  7 Oct 2026 17:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S3vMfuOR";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21F510E634
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpjXPIAFn5hoEmA31IooEBoQUbtT0mzStVSroCluf4zAlsZyLEiqg3QNw2TsEM0gIIIkYVshVTrFw1l4ixZ8iDUqW9p69tu3lcwt2NxErjcSfRum0kn5X77ntNBG/VYl497uA10XSSiYXabMaYRVpM6N+6DCA/OonlGP11f3gh3nFC2MfW8EexpgFD220zouuhxoX4gpkqBlQ2rrn2m/GbpY2iul0XOTG+9Y3o2MaK0RSn24FZ2L6dnX/QhEMDApfyJil+Y3puTpwNLfbosIhUAwyj1OF9uALmJMPjCKoIXCSfjJ34vEzU8yNlUpIrYYSbxwZuMhgXX9TSOI5jhfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMPJwPGffL3mWa5AVyreqbRX7Fs1+E75q8gPC/gmjPk=;
 b=M1bnteGU2BSoRDwlessgKqiRBgetEKwDFl5n7XY96KMGzZ82uIGXHGIp7eH+2hzjcA8rP2TuOOsnkI5043R4pXyVQbulCiuOmrrLq82WDhE/osQxhB6s+qbTlunsCBMykbxLu1Kx6bhxPDM7JPJiedJ1tKuBOF6c1/B0ozKKNld6tQVEoNK0s0EQC7mpFGAfHyu0jod63hj/KdX3+LPASYgx2B9U1whzPDxxjij4eBsF55DjhBTTril/KTr3oO82NGuqlbT1aFWqyHG+899h/qtuyGc21KZOeszZy8Q/rld6F+oMjy8uf/TCYvWbCtnhQvP7AWaQTUT+DxupxG4jQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMPJwPGffL3mWa5AVyreqbRX7Fs1+E75q8gPC/gmjPk=;
 b=S3vMfuORTL4W4rziH5ZcX5yKo+8spVClwy1FnQBS95FeAoKgPbIs6yk1LCvaPUwE0ZaW0ihEbB5H2hXdpe1nM95dcM/UgOoqFziXFtiQVK9fi6aC5RyJc2JvmSLcjdPtx6hyH6/3oe4o0sULReP1XC6Yz+Inpa8hmtk+DlHls0g=
Received: from BL1PR13CA0111.namprd13.prod.outlook.com (2603:10b6:208:2b9::26)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 17:04:25 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::7b) by BL1PR13CA0111.outlook.office365.com
 (2603:10b6:208:2b9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 7
 Oct 2026 17:04:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:18 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:17 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 02/19] drm/amd/display: Fix rotate 90 degrees surface
 corruption issue
Date: Wed, 7 Oct 2026 12:59:35 -0400
Message-ID: <20261007170412.1898315-3-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 66643244-9f6f-4f8a-c9a7-08df24950979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: oPYECBXcXnw1Lyujfq6iGrNexbDS2FbbPrF3uXrM12o8HeoXKwF2lgzp/eRxmrlBJKQiIbWEWAnUaOny9Z9CyF8WmM/v5xYbsFN7Byl67n+nFz3glH1f7HAb09X8/0hM4j0yoDeKwfF0XcePTHgaEajoO/U2TdY2lU0e8ay3xIxvno5YIENlrf9DbKaTLNXUlS+z0r7RASxQepBgxpS/MDi5Xi8wyfFxlcxX4tOipucMwdiCECeuf2QmkrZ2BpIlFMSB8VXfy4rMfTHCYp/Vzbsozdm52kwsetaIXAkakOtaNjtmOzYwECT8T2dIN+d5a8XtuI+61nvsA0abCqySzihYDnIUMVpl5EA+exy1iKJfLbxMBFzqFpH2cpX5WirctZryq76QhYKIFzM8aFjFD8ZhwAo3TzwOSyjYzo08Ebny+M1FCVfnCmHXoszqLpUw5K4x3uFevt9NAAXwSdbL2uHj1v8iBfGplHAjVZ3W2GSL/iXF2NKbQ/oE+3wge7aOP/l7VkNM+/ybtTfdoqxX9MeccmTgH40VZHgFMVLwLw/3ocNtPh1Qr/9ARhjMFm0eiQJ5NaTL9x4eCNuFurFIfipXNoN0m9JAZKZaVqMZsMqCjhWXzWrraovbLcnwEPAp7GdOcpuGzS9eYggoV+tnVbQX5ZWuXn+F8Vmofq1g5EO5fDRn5GskuTgpRr0BoVPrmGjiBToKFCEAoU6hJpExZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4GwUm4PkXZZgFqKGUfs5e6I1kF7YyHzL5Wn0itP1DwB0zFw1jW05+HVsbTzmrpGwS8TvRLtMoCtx6ibO3mkOL5uj2V6xntuVaEwi9EhpB788+co+TrGep1EGEtXrxW27lnpRrI/Q291t/742c0ndaLT2pLSXqKgmLTlatpF03JnwdKAk3Z/E6d3SHbGjrdFf5R+C1j43xyXNcAwWAaOZlntcpjnL6s9RlWnS5OeYpii4/yhBn5U09WrJSWB8KeDjCHpEsFyPpfucKEy0Dc8DYWAh7K8yKIG7aiTXnk50SewmIfPEuzxHcxUGB/rR8dcq1BswLFr8UJ/qj1HohxKIi2/GxBRenwUQX4VjL6dSqbQRwUgL6IQRc+OflGj0sxuW8Xgl7YpHnkTX4yHC/3JihUxFCaOcNNvuQVbGLeSrLsx9RvURk8Sp0x733OL77aTI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:23.7150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66643244-9f6f-4f8a-c9a7-08df24950979
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why&How]
Incorrect dcc_control mode causes visual corruption in vertical mode.

For vertical scan with req128_vert_wc clear, use dcc_control__256_64_64
when the vertical segment order is non-contiguous and
dcc_control__256_256_xxx otherwise.

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c   | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index 8dd4b7b9ba36..786843362061 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -838,9 +838,12 @@ static bool hubbub31_get_dcc_compression_cap(struct hubbub *hubbub,
 		else
 			dcc_control = dcc_control__256_64_64;
 	} else if (input->scan == SCAN_DIRECTION_VERTICAL) {
-		if (!req128_vert_wc)
-			dcc_control = dcc_control__256_256_xxx;
-		else if (segment_order_vert == segment_order__contiguous)
+		if (!req128_vert_wc) {
+			if (segment_order_vert == segment_order__non_contiguous)
+				dcc_control = dcc_control__256_64_64;
+			else
+				dcc_control = dcc_control__256_256_xxx;
+		} else if (segment_order_vert == segment_order__contiguous)
 			dcc_control = dcc_control__128_128_xxx;
 		else
 			dcc_control = dcc_control__256_64_64;
-- 
2.43.0

