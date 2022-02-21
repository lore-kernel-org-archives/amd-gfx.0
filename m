Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D36C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678A010F279;
	Mon, 21 Feb 2022 10:17:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5062F10F265
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrbDsM/a4QYhoUjiI537mGqeop7JEv6kmjuPFO+5gnatVKOhPZudKgMaN9tftd9csFsooA6eFQgyysOIrI3JZjUMdRq2D7RmgxxdczL59x/fn2Z2nu3baoJGRukvvNuN32j69rFZ/Cf/A4UA5bY1gJKxti4m491HdSudmErRJ7W60XciAlR1dUmstdcoysatris2gJJCgSM50iO0BrYIriYGRBzf81N25L+J3TpsqZOQ4NgsfOfLFZ/T8RFEIpaei/7CI8jiprpAc0fHJkj7hO/xIkKyvUrR/rgKMn6piSDrufGGN9cRWlE5T6ATnkzhcaDlPQLye9Ek30DRwAtF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsSgX63LMTUJBdtn7g1bv1+3oLm7pdwAR0Zue1mv8Eo=;
 b=LV5jN11hWHDK5my9njslKIjJ4/JwVdl9ryBOS8aiwVnC7njsEjVtKJvMQxa4BXyo2cuMk5CYBCkl1QflqFB2E6vjHCGJae8Q/ukWVFcZsrbuC4NKsfOwJIX08b1FK1FA33q3YnJg7pHF7CjkYeipbQxexx0FLCwoV6LrlNNDM1kl/glfGbg4zxFvFCY7VXqU5gx4HbBRak9UBMXmagr2DEtbBcLija+e6kyXnZneH+NFEFbdgqzskQ9GsbEahjGqIPxe6gFgw0/95ya04fVSIc7Yij3O+9lEWm+jFxlTXB4VnIgppU9LGANTubDCdeJep2ScN7KR9oudmocPhTDeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsSgX63LMTUJBdtn7g1bv1+3oLm7pdwAR0Zue1mv8Eo=;
 b=eDcw0LE9SnheSwkdyLmZH1mexPYr8gfO5cjGScjLp808ZQkV6w7H9qUTxznvaDj/6pfwloLRR/bGRttu+AqHyHWgeorbzp6UktDKGSEnEm7AlWdQmFRTCIaY1RG744BevipR+07wSiqDXUCkMvplvlQxd4vGgl+dnFNlWDkNgJE=
Received: from DM5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:3:93::12) by
 DM5PR12MB2344.namprd12.prod.outlook.com (2603:10b6:4:b2::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Mon, 21 Feb 2022 10:17:12 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::f5) by DM5PR20CA0002.outlook.office365.com
 (2603:10b6:3:93::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 21 Feb 2022 10:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:17:12 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:17:09 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amdgpu: Remove redundant calls of
 amdgpu_ras_block_late_fini in hdp ras block
Date: Mon, 21 Feb 2022 18:16:17 +0800
Message-ID: <20220221101620.3269611-9-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7387181b-209a-4ab2-3c6f-08d9f5235361
X-MS-TrafficTypeDiagnostic: DM5PR12MB2344:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB23449414FD5F4FE3529C3147FC3A9@DM5PR12MB2344.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIcuqLaSQ6eJn860lDrfVLfquDEPFTiSaiVcCNgABGDK7AuIFOTAksWUoXIJmHTZVM3B/5H+RREpXxFeLysXI/HU4EnwxahMB+hWVYor9isVmoBrK78mctUFQHpIjgCR4BcCLN1wWIKG1M8u7ZLSB+bcw9d3WZ/gL0w8kVHmi9lhAnP00aZOaM5zzoUhY84jNBBicGGvH2crSRgje69KvTM64kp8eZx45nXKCC6bPE2OtG0MaEhKpkmfihsNWkTx5HSCpV29+gMEA5fPs3soO5exr/+rCYs4kXboEDbYfOARTU9u09n8LJypaHaiIoGg+3zcj7broNfyZ3sO2SJVxddfYdXdE/W7PbJcAbYv/V5oyiEkP/2VMYxclsX3Tgn2/BNsIqrD6abLVk+gWi3rT8VLAP7F/LoRUpT8THrBavj1D3PkbSSKv9uIQfNn5Pmhn3BkKxGybgkg8DBwZk1iE4pM/rCsknNNZ0o4YMkfMYClgT4kB90RZRiS0E9x3OmBEbkgdpRmo2UOEKpKZJuBXf40cDoZbupW68/Fqj9OkoZG5GEsmSTtO8ykIB6Spfs+MS2ebxcw7Zcq1GpCwMm7CPyoE7ew8cBbx1oqff/dYdrVdu5PZcFIM2zaDTDayJ2HdCXMMlqewrxgS946YFkTbuiVpwWUmlhMNxCCC+9Xg68BJFDCls7jl+ehIgHdD1PVQ+5i6IdUZVUZAjuwLJTr6Mr+2+EqLW/tPFEouGn5B0M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(70206006)(2906002)(6666004)(8676002)(4326008)(7696005)(81166007)(8936002)(508600001)(356005)(82310400004)(36860700001)(86362001)(316002)(5660300002)(2616005)(16526019)(426003)(336012)(1076003)(36756003)(186003)(26005)(40460700003)(83380400001)(47076005)(54906003)(6916009)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:17:12.0084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7387181b-209a-4ab2-3c6f-08d9f5235361
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2344
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant calls of amdgpu_ras_block_late_fini in hdp ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h | 1 -
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 5595f903c17a..3f3d92e16c2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -26,7 +26,5 @@
 
 void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
-	    ras_block)
-		amdgpu_ras_block_late_fini(adev, ras_block);
+
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index c05cd992ef8a..9181c7bef7c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -44,5 +44,4 @@ struct amdgpu_hdp {
 };
 
 int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index d7811e0327cb..86c166ae794a 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -163,7 +163,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
 			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 		},
 		.hw_ops = &hdp_v4_0_ras_hw_ops,
-		.ras_fini = amdgpu_hdp_ras_fini,
+		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 };
 
-- 
2.25.1

