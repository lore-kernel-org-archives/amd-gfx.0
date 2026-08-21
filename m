Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DC1C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 851DA10F436;
	Fri, 21 Aug 2026 19:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T/rY+nM5";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DED310F436
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfMzdfETih4aatAsBySu2V1BzBk7V3yhaDxCA6quOyxTgKdMkoLIRLLmVNBehdKOcVQATXLCyYyHyFDQBiUfrKLjaum3wl5C9BmWqDLAtopDHaWT15avCGE4RFEazOVhjrpbfPQMy2NeHqxINfX4UEh+xJj/GSXhyKjVMOwv2ZZ90mB5gB2U2cCAQKAQGj731mKG+UYFKAOMLsMwm9iisUQtu5F7sGBl0Vd49CoDfx3E6K98hvBEe2Ow2UTx+vsSqZPigSw07RsBzVh2UCiglAOz4RA5l7Z0Xem/7IX9e3o9IjS6Nyg50ovbPPxO1MjCJtUiIoSjzyqal1orUQ9ZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+75UYTskqV/5MUUphgopyj8YdXYcq3oWR7KPt4xppRM=;
 b=xrhukXsDQTARtLYmLoXT4Of5F1nwpdLPqXd2Ie9Ar3kRISetxPXAfR3NQgrt5kV9ag//AgI76rLIjOUWbIhKtEv5ODZ483UKPVqsNkKj2r0EOyCpDbe3nFC8HI7hzATSIEsOX8rVnrZBfWGiCqtVZlTT58FJYw0gUEhZQGZl7/VdvoRSoAvYRzrmdLIQhPiJe4OH/VN7gmqvWcI89uBpwVZhgC8lsCDKODHKeU6Fm538cCkCmiNtywHW0T2YJuXZ7K7gA68O5UvIA9OkRny0NTuI+9/DM75bqZmCqzBDAsGsSxOIPpcCs0/irIruGHzFHtW3Eg/L0pk0qMxEdHvCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+75UYTskqV/5MUUphgopyj8YdXYcq3oWR7KPt4xppRM=;
 b=T/rY+nM51ol/5/8x3XSA3vgbbgEPmKPjKlivD3XwMk1EUl+3D3Iltim0wJR/btdgBE/ppWMwfpnJclhrZcn/RQvhcHknCn0ILYwbBWTcjRG0OWYjSaeXMm34T2V8uQIYVx0/NtA3GX4LgdYR+gyrrdlEc/dk/SriD1RdqCbe+is=
Received: from CH0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:76::18)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.11; Fri, 21 Aug 2026 19:35:57 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::36) by CH0PR04CA0013.outlook.office365.com
 (2603:10b6:610:76::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 62/95] drm/amdgpu: log remote memory MTYPE for GC 12.1.0
Date: Fri, 21 Aug 2026 15:34:25 -0400
Message-ID: <20260821193458.808626-63-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5f4c93-208c-4ed0-c10b-08deffbb6c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6uldQQWeAxBpuycGksw6thn+fx0W79hdRDZWXp8yJYOGZHHURNQd5sf6aEAQaK2PVrLANNG6TAq2rfHqG4myRW3c5+E+xptMG7WK40lbATq5/GqPb9xwyyvWTHbWAdemDp8xs8YtpLXS9nfP/9MEVwoOS2120Qto+czIvweWSif+mmG5jxX9otJSL8cwOCPF14PewguUQDPTiNPPeFhuPVEpI5edneFbCLaWwhs0EdIJqgZtIw5Jkec2fp8CWWyDAEIgWe6SVj5jvnOwNALZhI4p1vPdzcWKQppZttkK8ycpM2/wdxOGQXQQIQY/Z19PUdXM/EoBWF2b1k1ucszmBqySPcpbA4nZidKkXANxg3OT/M+4gozXaFrAOJcQD5LpIIZDhnCbMXVt0M8wCSwZQ387rxh3m7eBkpHfWqnEgJz6sdWXCMX99bHN1yztarq4papcNTjwfR+tt6q+SYlL++X/VKUsMYM02G2nSTPdgMV379nT0yzLHgQKH3ASN5uACQOJzRrav70s1I9Ta3KdD9T7G5D8ahBbku1BJNgI1RiE53UMmA1JPlnYR1uOicg3GATKNSRIf9RxW54Gs67EcpaWFRZv6d8H6cxxT4FMevqmb9ZV+QvGXEezfj2ESMOPkQ6TsE0zFt3JiRiPilsQ8eBvgp5vz75ORRoJ/7Ui9QoN3nrJLQp5gjyrk1PFd/RUJebc6Vig1sqanR/MGBJz3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7T86+PuOEy5MtxoceCCKrOo6OOBdbiDOguGIulbfnmuj0Ic2z4XxGbzUBFlucAn54TVaGEgt+Jg8T6Qn60iGouye1GHqQgnmZqmjPci6X0BYDHqW147z4Mo91a/9khL9GNtAfAdJBcClkqcTt85jYyLYtObzJvhOWrZY8G9b3Bo/ajWyGhelbZzGJN+szwWIhzlCgDCpuLPxqYep9e1UMcjskSjUxbx9iTU3KiepvUW+k5p8AamczKPMJ318J7oOTlKyBAa0BFYoqXQhInDQ0vrQo7b8vqY98Jl2RMfADv2q650ipN7YtomHrqAi4FBJ6Myljcrt3UowQZgGMyjldZCN2fmpC3JzthFqse1W521k90X+PjtdnmWUDRfE9dkaciIT353FIKxJ8imK2lFD/uFPRg2RZbXtj/Yy6GRzpF0iqTKsYgDHcvQV0QnF480Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:57.4424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5f4c93-208c-4ed0-c10b-08deffbb6c59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
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

From: Alex Sierra <alex.sierra@amd.com>

MTYPE UC in A0 and MTYPE NC in A1 for remote memory

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 34d5767287d78..302ebf2f3ccd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -649,7 +649,9 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 		} else if (amdgpu_mtype_local == 2) {
 			DRM_INFO_ONCE("MTYPE_CC not supported, using %s for local memory\n", is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
 		} else {
-			DRM_INFO_ONCE("Using %s for local memory\n", is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
+			DRM_INFO_ONCE("Using %s for local memory and %s for remote memory\n",
+					is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC",
+					is_aid_a1 ? "MTYPE_NC" : "MTYPE_UC");
 		}
 
 		is_local = (is_vram && adev == bo_adev);
-- 
2.55.0

