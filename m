Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269FCC5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D6F10F38C;
	Fri, 21 Aug 2026 16:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JtiZqEWb";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57E310F38C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pny4FDAUXDNoss5rK5YLpfYodu3Tn5CR3iuwmMBBG0wDYihsWWWzQAUF0G+ysS+31QLwcopMzLa3CB6c75/IWP6fSttg+7L0sre77T6esZmifh7NrW1Vw02bHovG12fISrULbK/8ad4ostMX9DCyOXgdtCVUjZtrFbz4fGshR4ETyP/u7zeJGpdATEdmr18KtGfqUclTNU48T73W6S4p5VTkXf6sEoh+S+xRztCGod68GgDIQEzAKXlxp0lV1WzGh4fD8p8mJ9yOu+8uZUFwIVHFy99zRfkca4yzAfFYTXD/leq9ZZg5YPjdwLYgH+Lz7FZiS/BALA1jOE/cAM8k4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGHy1DB7lC8VQgASw+gBpe+SvNmUttZjftqUVL9PkIo=;
 b=OGopZe8O8l60jC2Q8+BugzQknpdTfvFEI5jabVbsMizOG9zF4kwfwSNnclvSsJU/msA1GSD2XaMG6nkeECoQESZJRc9mQyaefW8lY6xFDtzTr8Yqzbn0hlTcJeLldabnYoVHZasLxnVmnqmicqB+LKIQVJqoDQQcabIKTc8fgt5zCAxow8g5MlgweAnKCvAAWHK8nkgAKyVZtFbfzyqhXZWvOR7Gne11w5kuW8nBEVE6yeRg0MHehhKwCgoCIREWOpjXn94xTjOuUPH06+PrqlNPgWZc1ja/tNdwlptxP6F/N/Btzpy1qwgmi57bPCqt9jmB20HXNcxRz+JhCpteHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGHy1DB7lC8VQgASw+gBpe+SvNmUttZjftqUVL9PkIo=;
 b=JtiZqEWbmfQ+XgtBklsToExeltqTRlCY4hAuQTLunqZ6yljgKvFcCtUULITbc9s5yGsIutg26tQkD2bYbJxr7Ttykga4BT9eW1aPOFW+22bWoJRZDbbUi81BVI9HSODqfeZU7Llhe6HJfx2Gl7to5fTx8XfMM/asv/fgeZE8HRk=
Received: from MN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:52f::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:16:02 +0000
Received: from BN5PEPF0004698E.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::d) by MN0PR03CA0004.outlook.office365.com
 (2603:10b6:208:52f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698E.mail.protection.outlook.com (10.167.245.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:16:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:54 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:15:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: add NPS2 memory cap for soc v1.0 DPX mode
Date: Fri, 21 Aug 2026 12:15:43 -0400
Message-ID: <20260821161546.754333-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161546.754333-1-alexander.deucher@amd.com>
References: <20260821161546.754333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698E:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ad1654-be5c-4c94-5808-08deff9f7e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wB7lW+Eu9EJYx2XvKUXaddNDqU7CQoFjMG59hFX8j1vbZLAKch48YzpJkyJJ8E5/0vx3tO1esSoFxJ4PkyW9/dju+dotthpyCoHF5XjvvmRsnWwc2aJMLpGEsaEvKzaEf91exA9Rb4Cmc4mVCsLviuDCk+4+3ykRXAkkkdta2QjrNlOJKHu4/2x9tZGG+Q/PbkhUH0hesfBaNmr8nQGfQ51Y8SM4m+6AZ6+QLNoFHoW5599Lio/zuhXyvhg9dlez/uc84oMWSn9AgZN4hBEo2Dr+Et6kgE5OkI61p9oex7PzTtHNFGHgLG7bXq3Xi/j0H8Yf/QKoVXOXzQob/o21BNHYd9cbYR/sjnApLJfrRTeSN33XKh+iz+7ETjwYdKaFyjWKRCfvxz3gowWQgW1h5TUKPaCFyNecvNWA6wTtM1cikCjLWIeHf8WQ9aHIy5gqjDRCT4KElP/IaUMe0e4lgUSLtr3IaHpyyMDwqUhOftgudDy2SZ6IRYA1sNAC3m/AO9tROyGXMBHRKyVNHdnou5TaDfFUD0qyX/aEMHhMQAEBys5E45+5838oEvypwTFwAIeuHuDXF3FZyrqwlFfTWGbK3+GWU7jfFZQ8aKhWidHH0KTsViGS+UICiojX8LaBWDY3fFyUzmbhR73e8XnuHjDGhIPJGQw+P4aI/VEhlXLc6/ZVQFyG0ikg2umC7Pgb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cKzYB0CqB0a2iG7RpTGJZlV+LmeBQRVuLuslkdcAmrcPKY4vO//5ia90F1XIesLakjdU1bFLXDl4DCs7+zr+9R5qsrHNIzcBWHQqlFV8yygJBJUOJZ6zfaOmQncO6dLGNIYBxbzSWteO0CMZkwo0D0U7aOyq0lIC6Bmm0PSH3h9ZOr/kSrwFAmaUbqeMv2SwqzTIE2ce2GiKtXscnY94xh51wefzJT8rHKjb2WSIv3io2DlJIIdc2gD9rN5FE7rfHCJQ8Ka7RvAXllm68UM7uM9PwDDOoZxGtPILzrF6kc0kCJzn6IY5rxUvhyT6IToHHYwdrT8xBLkAdToPwcioASODHicHAYxtPD+Qps5APwAUPyZ65RV5YoKAQh75MbMihIwgOpoaHYGyfUeN2yJleqCAVFAGrTTpf/0S2iAxgOYPt1bDsDxlzEIftuxbKvky
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:16:01.3343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ad1654-be5c-4c94-5808-08deff9f7e67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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

From: Le Ma <le.ma@amd.com>

DPX currently advertises only NPS1 as a compatible memory partition
mode in soc_v1_0_get_xcp_res_info(). As a result, supported_nps_configs
and amd-smi partition --accelerator report NPS1 for the DPX profile even
when the device supports both NPS1 and NPS2.

Include NPS2 in the DPX compatible NPS mask so the reported profile
capabilities match the supported memory partition modes.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index fb3c7cb350995..ada99210479f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -963,7 +963,8 @@ static int soc_v1_0_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
 		break;
 	case AMDGPU_DPX_PARTITION_MODE:
 		num_xcp = 2;
-		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE);
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			    BIT(AMDGPU_NPS2_PARTITION_MODE);
 		break;
 	case AMDGPU_TPX_PARTITION_MODE:
 		num_xcp = 3;
-- 
2.55.0

