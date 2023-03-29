Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9B9C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AFB10EC5E;
	Wed, 29 Mar 2023 20:26:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D6410EC59
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRy6RjMPflt2qwgiVI9SfYlsaVbssE2+pNtmAt5Q22l0f/k5oTuu8X4iASlhup0CZWGbg2r6belIf65QMVdQ6rnvVUo9HqkeCTnaj/vq1gtuxXy26qxIq82eebXJW2Oi31kgOkir1+moUF+nhQvJ0P7qtn4TJEXwiREoiSOE3PU5tYTCpDbZ8+zVxFiRh7nURhgxPzcO0QY0iKaXrisa6a44qqYFlU66VgeIN5XhgSee2tzWtx316QiJGO+kSNz/Zoj+t6+yp+tvw65IJZLHQdBMmsobRAX16VvaKiNif9jwvUjR2rp4OWuIBbU/e/TtDMjGLRJ0YTC4pBbBEounjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKPFQBrUiGuWxL4FQHcBCyNagkqioR6BjnaPCLF0/Fc=;
 b=GgnUuXI9O4Pv8q6+2Wp+tnN5lbYLG/zGKJ3M5kJ3xbMFi0/TNy0UqRysOyXvy/fWgUnktKN0zhQlETGwffDNDsh1tlh8jf/BVI0LeQ+WB2N6o0rlJyVBnkHJ79UinqqBFmdjYH5HhHPFNaJtZe8z7Rv8csp6cjNQ5wtb1Ng+Vy7Y1GsNYph7uIe6ZN8w2MpUrn92TZAQDjyQA4WMxhCv2eIPX82JNEasFUSbpyWUxRqo3GhDct292Kiq2usko2CisVEgkl/EfdUtrfde7QW8GPJvu+WOmFll8NM0c5/sE2PxJUqAFrR4RvFighd3A/dbSiUoBHl1OGUJmi6otIRpgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKPFQBrUiGuWxL4FQHcBCyNagkqioR6BjnaPCLF0/Fc=;
 b=e/KbA0HxReUVjl6dfKASZK+/5fjEFKDW/PvA5Yd7s5UTwtQGra6I82DCr/od6uvjsdHaNyx/vCohMzzJZHhl2mxmQTp6At2lXdW7/NmQx3/I1M8NR8p9ONM/nW0ez+PKrY9TeCKz4S0l8qzdknM2EPj9oFCUJ2q93jdRV8eXZcc=
Received: from DS7PR03CA0143.namprd03.prod.outlook.com (2603:10b6:5:3b4::28)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:26:03 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::ee) by DS7PR03CA0143.outlook.office365.com
 (2603:10b6:5:3b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amdgpu: extend max instances
Date: Wed, 29 Mar 2023 16:25:38 -0400
Message-ID: <20230329202548.1983334-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329202548.1983334-1-alexander.deucher@amd.com>
References: <20230329202548.1983334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: c9263bac-c56f-4c49-ce55-08db3093d178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYQ/eAxX2m81gI4hnS2yrUi8pHbZpA8wpDZgGoepPnOmcZp32mGxND+x3JDlMSDT4id5lZMriJSK0udeEXRra5z3ef2v6vgovckrP/gS2pHL/K+J3lomce8w6cHBvc3k2ExhoQBhyg458ZTwTyI+BnQN+r8HFUIJ4xsJtxk8WEa+myrBwQJ2MKHj8SbBTdArZFDOs+mMzV3Pd4BERTjSNI3Qjjh0OVAsXMjDz8wUfO8b///CsnhmyelNt7rIq8ilx2VPuq1ueSYVA0sW3Q0KXPYTkrd4G4BzepEzurxsH8qwRr08bN4QcQ+I2zwqGn94ToGKoKZ7r4wFKsu/wLabp4g4sAK+DpdmsKTOjeHeppETyaOt7nwGA/R0q15c9JXUwh4ok7+3gdVH0syTFqFMgYB0WWUTLEAswlljgtI7LYoaH+56qmwJJtkf7J8uXzUt6toM5rRVNGVn5lVeTzoyLsq6g18Ip8BRVPZ8YKU7S2t0NhoVTblwEMo1ar213hUIPDTOuoxdHcqiNJe3ugVo4gGxV2Qmvej2jVUW6bOoEC0suvpdcsT/g1Gf5+gE7fvFaJYIWQtvfofZ/Lr78oDnmrEt4SZjzmgGqzMgu7A6jcYa8DxSTvDuQcftKzejLBUP5brLAvgw8DOJUVI4r8Io095xC0ecWSigiNYmZPi+UlT+OLcEyVgG15I6uk2nDPBCB5VRDdDImXI2E6lgjGogyQb7govT3RkNI+0KElvRU/Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(83380400001)(2906002)(36860700001)(7696005)(426003)(336012)(1076003)(356005)(2616005)(8936002)(82310400005)(5660300002)(81166007)(54906003)(6666004)(316002)(82740400003)(86362001)(40460700003)(186003)(26005)(40480700001)(16526019)(6916009)(41300700001)(47076005)(8676002)(70206006)(4326008)(70586007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:03.4957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9263bac-c56f-4c49-ce55-08db3093d178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Number of instances is extended.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 888652d5eb9e..4ee79bddd0f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -682,7 +682,7 @@ enum amd_hw_ip_block_type {
 	MAX_HWIP
 };
 
-#define HWIP_MAX_INSTANCE	28
+#define HWIP_MAX_INSTANCE	44
 
 #define HW_ID_MAX		300
 #define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 1024a06359ca..6ea3f076257e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -32,7 +32,7 @@
 #define AMDGPU_VCN_FIRMWARE_OFFSET	256
 #define AMDGPU_VCN_MAX_ENC_RINGS	3
 
-#define AMDGPU_MAX_VCN_INSTANCES	2
+#define AMDGPU_MAX_VCN_INSTANCES	4
 #define AMDGPU_MAX_VCN_ENC_RINGS  AMDGPU_VCN_MAX_ENC_RINGS * AMDGPU_MAX_VCN_INSTANCES
 
 #define AMDGPU_VCN_HARVEST_VCN0 (1 << 0)
-- 
2.39.2

