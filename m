Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8371E7718F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160B410F088;
	Fri, 20 Dec 2024 21:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IjGTVMZh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989BE10F07C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ug59umO7DueGyd8i7O5yv9CBgn1Kg27XQ8m6ITDFIObZvgfb+agLEQWJ0II7WXzjIClOEDTCNRMSG1zz9qWs2JcC6JtAoBNd9WoLEEmk7Hfk0vRIJ5dktLOzrmgeu5+n6ClW11z+4xn+FcyS0PrcHQz+FiHgA4B87K5oW/knRtte9sf5xcBVescDgJcNrE++8AGCZEMoDIoqgvR7gmw5cd4uiNZ/j5lL02DWxh2KNVulFAnwb4G8II3UPq4myM+Dk1V/5PQ/+6asLTdDyoyHk5Cb9rKBCz+FyCmtxnvZhzwTWz6VLwf6FVzee4IFg1AGKCP2UTptZ8ucIx5IQt0jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DYqMxl5LoSJcEuGrKqdODRxblGAVIkW0OHOLS5lsDI=;
 b=NXHctkKfCpYc/+n4DOGncwJYjJk5+L+qXNkUO/974NsNfe3pm4RUhT8BG4qcUindGYqY+/1CCcCNHKN4GCVJthmZ80iwhUINaoKtTv22j01qIYAnC3OGuIAcfNBN9G+ob4GrncuFrrZFt7+gharHNM8EMraxQ7eNDrHe/ObuBSUig2NijiqO7ySH9yMjWRA67QiFad1qfsv0v7SWKoyYrWNhwyPkt3+eQRG1yH6FcF7vpoTYy3OfcJWJHxA3cXMIp41HvuUGbGTe3f7fNHOOF2leFnshH4vXcpcyaGCQNB3pS4aorSMDGwnHE4QoeGQSZeBW/7uGmCsX5/ZE74j1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DYqMxl5LoSJcEuGrKqdODRxblGAVIkW0OHOLS5lsDI=;
 b=IjGTVMZhUroVG+v4ozhABUpy9+MQmSdEPXwkgn0HId2Mm76Wi0XulIYPXCnHrJ01MqoH6ohvleTIqM71Z87l199hA4fU2PwOHUPcd8s6iWejCmKpfSR0a6od1Y61iVBmNb6c0FuFI3pw5a2FbbnsoUZiwgRPnFidErAZj1n2U+c=
Received: from MW4PR03CA0165.namprd03.prod.outlook.com (2603:10b6:303:8d::20)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:51:22 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::87) by MW4PR03CA0165.outlook.office365.com
 (2603:10b6:303:8d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Fri,
 20 Dec 2024 21:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:20 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:20 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:20 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 21/28] drm/amd/display: Fix PSR-SU not support but still call
 the amdgpu_dm_psr_enable
Date: Fri, 20 Dec 2024 16:48:48 -0500
Message-ID: <20241220214855.2608618-22-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8ce252-8163-4ffd-7d2f-08dd21407169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BTkoGOuwYTV+Wh6Oxx3CkUH6WpB2NvToeNUtfIpIaDZirjQJFaGloeqeqlzZ?=
 =?us-ascii?Q?ZihW1/zmKB4Z4uKgE/tuirKw82wkthi5Z3wF2B0m1ApfOpUHDcjW33bx2okr?=
 =?us-ascii?Q?8B7Nbx3a4hi4ZENr5EzxcJBippVrCyW9V8Al62UZLuYx2m+gVr5SIlfVJNFG?=
 =?us-ascii?Q?VwZU5NYCOeo+l5A43oV1Urji9dYo1d0ZqeWPsJ31RBKVSA5jtAnzlenRWcBZ?=
 =?us-ascii?Q?qrUzbUT6/C9/4dTy2i3HxotYdXtbeKHsm8WHz/JXIzmldZqYfHWpE25c3/t+?=
 =?us-ascii?Q?oUaHr3G6hC7ViQsg8pUEyQcFmk6s7bG9TDcxp7XdnM8Hqrx7eRrSBGaM86NB?=
 =?us-ascii?Q?0jOhDZDsnPKJhcOXtGZ3dttrTyDYfA/U/M/zD+OtMO18S1rrhW6Wa8fLpfFy?=
 =?us-ascii?Q?3OzeBCBbJVdOEPvmDsPgKY4KwWX3R2jQByU7Bbt8/PBklbsYjV0e0hrH48NC?=
 =?us-ascii?Q?tPdb03kKg3pA+17dzBs+EAQ1xj3hUh2scu1kp2ZglmkDET5eWc3Nz+51KnE/?=
 =?us-ascii?Q?jQMOzNUKKINPrz1ZGmsoQ+A4jgmtlghF9Fc5hnFTxFoZ2P3s7d0fhKaiHxhM?=
 =?us-ascii?Q?Xf06bcX/puVEq0zZgMzVf/pFLYVolpFeYWrGNWzOadXbHvLj07qgdLukAaeU?=
 =?us-ascii?Q?xBepPuWZGGGsgS+iznsFL+ew3k3GeKWzW1/NzkkeloCcBtq9bZbXxuxM0vQV?=
 =?us-ascii?Q?Selgei6rzzDdDtBmqtkMOx9cuEbptVBSXyLSrrZrJJ4uRkYLYKoVJIq8C/kg?=
 =?us-ascii?Q?/BvgO0ERuFugubZfbD8quz4fi9NQ8uJmfCIlc37/SsxD6omu9BaO+2mzmimY?=
 =?us-ascii?Q?4tWSf7Xs8BjgHIiW+YscD89E8GWvcY0rTnuTJoGUBNPLt5LcvJfgx/evN81f?=
 =?us-ascii?Q?pliQctd4HMba4plukXE0Il6Kd2cg89jifFYnWTTBxoYj4cHBEgbSJQD+ZY/P?=
 =?us-ascii?Q?vl7UN+Vw+HydxS0B0T43D9vNGnJNKRoqhZKbLgJ28i6tGuUiD7g2VAsXblJj?=
 =?us-ascii?Q?0RrgYMLZYCpXDneNFsAdaN/AZ1e/2fOBIVrEz+WneETdNVT6f4NeY3Y2k4RX?=
 =?us-ascii?Q?fRGq7PBz0ywRkKIPmXCCvhxt6/HYcC1832ln1O+tAY8WMSLQ+wKBRH7BXb9f?=
 =?us-ascii?Q?qrdnGpM2YKcWt/QCrbvayyPeNnjq9DmP4KPdNbhEjvstXRoctTdEoOOzO2Eq?=
 =?us-ascii?Q?Qry3PALu1OlWqR+kbAu037qX/KNenC+H1iqIuZL5+dC0SzBb22DYmztUUI1Q?=
 =?us-ascii?Q?eMn8s8ZKEAw3dhz5zD+GdyfSOpiqSg+tjSLbLcCHsVT+YSR9YXWAkAVDsGMG?=
 =?us-ascii?Q?FqtYmFwL1s4el9UjgwcIpY4VOR9L5FZMuqhjsKwuvAB88yuYF2C4TjR344/J?=
 =?us-ascii?Q?/X0ggNhYztpAdpMcN631pWw4wX/X71r9oHc4SEXNGQiOCDZ5bRC1ytkuS5kB?=
 =?us-ascii?Q?dEQsyxAoxLjaLSG7Ykkjl0iVJmzdJAN5z1AldIE0D+4TR+AFKfZkV90iN0Zk?=
 =?us-ascii?Q?hUljGGjN70a/gl8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:21.9434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8ce252-8163-4ffd-7d2f-08dd21407169
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
The enum DC_PSR_VERSION_SU_1 of psr_version is 1 and
DC_PSR_VERSION_UNSUPPORTED is 0xFFFFFFFF.

The original code may has chance trigger the amdgpu_dm_psr_enable()
while psr version is set to DC_PSR_VERSION_UNSUPPORTED.

[How]
Modify the condition to psr->psr_version == DC_PSR_VERSION_SU_1

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a5fbbee955a2..a579c11b4324 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8962,7 +8962,7 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 		    (current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000) {
 			if (pr->replay_feature_enabled && !pr->replay_allow_active)
 				amdgpu_dm_replay_enable(acrtc_state->stream, true);
-			if (psr->psr_version >= DC_PSR_VERSION_SU_1 &&
+			if (psr->psr_version == DC_PSR_VERSION_SU_1 &&
 			    !psr->psr_allow_active && !aconn->disallow_edp_enter_psr)
 				amdgpu_dm_psr_enable(acrtc_state->stream);
 		}
-- 
2.34.1

