Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3502EC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A192B10E47D;
	Wed, 20 Mar 2024 06:37:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kJu4oTxF";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 070BB10EE94
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzM4hyBcysc7IEXeWm2Ixy+IYA9LOcVYzDCzq91ZiYt+Y3klO8to5FwbAr/pJdrl1I0Qq/b5nQJ/sphITXj+lCMRCo3n6rfqcXFPUTTg0EF8UBfGr3zThajwIpzZ1Q7zoCM2GKfuUvsxfXvYWBXdgOAD4kdpBmnSWyQ+31LJ3MK9fiM+lB4+fMOPLVMsjY2eoqM4Xfz3dT2YrzW/29If+h1C4gujIWdC45edtwQEYAhfXkUPVKm8gVsFyTRT0IVxAwlqeIDm/h238o6Ya24fw9/scLS6LCVA080bHBmaCbKYvJyjLTpFsRJnZE2snnXtqSO666OVamTXww7m7efeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYboNZkozLMIhj5pPUI0PXQKNUT7xSdnpOnnw4jNPCc=;
 b=E9HyZi9TfvVtCtHUpCb1WgSdBgXd57vyRM14fIz2O99FPWGHvcS4FMH0iEbPdNrfREE22Wun2jcL+3zew4KsB+bbLOEOS2S2E1CFlLWNsrwJK9uieQBdjcB4yEtJSWQLs/Gki74w2BuQDpLHSDhgDYgIF4eb+nSA3fNXCoM0XU+Pwje9n6R2EXMEKyzb25LoF0k2/OzBAprjqIzLLK36AxlpTvvseA37qFUVbe1hsW3sas8xDzOBD1ZfY+iXxD5gqJgiOBd2gOoU8zvhCT67ju8jW688X7OTHfSO+V7NllBjKN0kOv1hjHI9H0sw6egtOfNKq7pb7Q5XAdC1ZPqM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYboNZkozLMIhj5pPUI0PXQKNUT7xSdnpOnnw4jNPCc=;
 b=kJu4oTxFJxLJrkGdyUbCDnxPKRih6pJYK/Cghn1FmSnpBasirJcKVidO2tbbVV5wl2X+O1BAOP5wQeXrN421wC1l7Isa7r1R8Dz0GD3FOQPdohGmLOKm+x+7YLWkNxQt/phfWaMzbE33C1B3swOBWKB1ZZJ/BHAcYrI9s2mWtnU=
Received: from BLAPR03CA0076.namprd03.prod.outlook.com (2603:10b6:208:329::21)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 06:37:14 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::d) by BLAPR03CA0076.outlook.office365.com
 (2603:10b6:208:329::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 06:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:37:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:12 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:37:10 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sridevi Arvindekar
 <sridevi.arvindekar@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 17/22] drm/amd/display: Increase number of hpo dp link encoders
Date: Wed, 20 Mar 2024 14:35:51 +0800
Message-ID: <20240320063556.1326615-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 08175ac5-642c-4b3a-513a-08dc48a82df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAzTi392LYi8YPjRKaUvydLS2MIThXxnGFLDvmGzuCEfhmMLDngs6bd8bhNpIlqXcIuCoALz/+G8wPHS+FqwYAscazB7ypvHbLWPYYOXdowNXRtwwHKBUyaiIuwOuEsxvr71FVaf23pZ9K6nFL0jOcU3fUvKyhAJwBa6/tiNv1fAIm+glh00OWpHsuT9hB8+MHjmIWLnsfaIQYEG4zwV9cAoVCE8stgHkvLSHLIVMhWIXZeLB2gm/kSbHmmnEKG2KHwzvUSPA+sUcoVfEe8RBr1xYN6IneREP3nLDYwUE+36cZWZ1SO1fV6eGGsKwkqMR9/FqPJIHUhiS++siodvRkzx/dI1wnEbnZ9sXrqXFw26LG/bV9V1M7Hy97aCavvMP48rUzu7PfOzU7MrQ/FY20zDfo3hYGkHXjv13rI0uusVVv/exdNgd/crPLzOf6rS17B2o3emDtkIPqZT8yFR1cSXGbQ1xa0oScVkQiTK/UOLMC/+yvByfzwldyqcfPEBw8S7vt9/rYApPPcFaV7OgGF7JRoR5ilQgnpeY8AxEHqgEdpfmF+Bk1VrihHs1bOsw0UWqck1P1Pb/rjyepuDmIvlbGLnTBt1Yk/gJowoGpOdNfGZ4vxH3t28IeDceKwSuDk/siM8q0LZNdG78sc3/F7bTWPf5r78PrmNl6w98VHV9Ilv/U6UvzmMq48IcAuQCcyqqq0Qi5b0Ip8hNDfD5G5X4LUpST3qRadoJKZWsbZm9EgkEiV260MyYCxAUrKX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:37:14.2056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08175ac5-642c-4b3a-513a-08dc48a82df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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

From: Sridevi Arvindekar <sridevi.arvindekar@amd.com>

[Why]
Number of hpo dp2 link encoders is increased.
Instances are changed.

[How]
Increased size in resource pool, init for each instance

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index dcae23faeee3..c1835ad6550f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -47,7 +47,7 @@
 #define MAX_DIG_LINK_ENCODERS 7
 #define MAX_DWB_PIPES	1
 #define MAX_HPO_DP2_ENCODERS	4
-#define MAX_HPO_DP2_LINK_ENCODERS	2
+#define MAX_HPO_DP2_LINK_ENCODERS	4
 
 struct gamma_curve {
 	uint32_t offset;
-- 
2.34.1

