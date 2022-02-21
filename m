Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D07C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108A310F271;
	Mon, 21 Feb 2022 10:17:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F6510F266
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKr7Hiteh/N3Y0+JEUKNO8SPla4OfVrRJLKKnDEc31V2eyUAepy9vaSsi+t5hLTsMpePNbJfGQ9CXJ3XgfTJyPwDESZL6qzwRBn2y3lGPM9VpYjwHGlNxpzVe0hws6gt7NZiZClMPHaSTJ7GXU/1SL/YST7pzWI1+uTLBdWZnZj/cURtw+VyP1NbuebWvW4JL/007d0LfvEAAHyCQGKLVfLBjJ46+Et5hyShnGKoieEworCkNwfLaIoJ0mAIjYPBOv+OiYnDYTC7yOW79nv+6FobhCLMNA6aIwxtCrk3VtFCrNQ8jikqXkjn5kNLp/Bpk+xLcNcjNMch7VqDMv1QJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu/SMnKAWC0skwOTC7G7eJ3lRLt+tb7rxeIriF3c5wE=;
 b=B67e7+9ikUoQQXM8UsjuG10I0yM+et6Z5OQGc/kgLGydfLVH7acGRW8n5BaEBNgUbY2CHPUV/DfAzMtAW0/nI6Rzw79u7b7Zg+/fT/0Iq+sk0Y2kwFErfJ5wOYi+V8VRMZxp7CkDneQT0PnrfZaqyxa/sU6Y+nGou8w2VgvOxUS+mXQrMse4fMeF7oniRgz/Q4HgnOc1aMVT1iqbCvO3qQPoOB9FnRUpaH/fkE6XkGRpDriX61vsAa4/Pi8sFSCy+wlJK/z+gcxPr/AJaeHTx63KnwblqRKBIu6jPCm/Yc9LNAqidiQxVCAzzb6B62BCympzB8dc3m5ggG1GnSZrcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu/SMnKAWC0skwOTC7G7eJ3lRLt+tb7rxeIriF3c5wE=;
 b=H6XbGlISVAjONYoJueP3Uj2Gb6Z56izsy2QahKZTM8hfVaxG35Oz/+4hHucYkvenksn2JmY3VqcFJf/DPqhpC2foeuiufY2SNhkuGL6s2sXYQwesVnOGAWCOM4I4zFEVVznmsoM2TLgepn53G10EaPv8bpCERBS16sT9eaEEo8s=
Received: from DM5PR20CA0011.namprd20.prod.outlook.com (2603:10b6:3:93::21) by
 PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 10:17:14 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::58) by DM5PR20CA0011.outlook.office365.com
 (2603:10b6:3:93::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.22 via Frontend
 Transport; Mon, 21 Feb 2022 10:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:17:14 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:17:11 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amdgpu: Remove redundant calls of
 amdgpu_ras_block_late_fini in sdma ras block
Date: Mon, 21 Feb 2022 18:16:18 +0800
Message-ID: <20220221101620.3269611-10-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e13dda7c-35e9-4101-b12c-08d9f52354a0
X-MS-TrafficTypeDiagnostic: PH7PR12MB5880:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5880FBCBBE02071686ABE2ADFC3A9@PH7PR12MB5880.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGBinc6DJXfg7HrjMjmO6mVxlexw6CRxDzcrYbzYa6tD0D0n7c6i1W/htogRXEK132r3XCCNY3sYawrPyZcYu7RfNviIDfjR6KZPJGAnzATjpW+BiENgVlqSb69Fr0ZpbroiZT0FwvKIcKuLtWFImMo5k0hlqYSdYr2a35vUpJ+gDsKyh5KNVpG8hKC45GSxmHDJcffPRq9PF7fitNWUb+ZeUSYIBigJf7RtJGcNWXDpE3zuRcPJOH8ltqr1RF69W4U4brY7GQYdRFnFA7YqlZ0rLTO0nwzirnxYzwgceM6eVo91DJfZl/KKXIM6cc1YS+vJg7eGe6enxvCYR98S9rIVz3/iXqvwZrdIzt2KrhqUOhZImB9VtuX9EU2f2Y5MuyALuOIhixZWUr8ez4sKq2MMCBrLofmr9bN7yW7GJiKTX1kmgX7NEB2jDmjiSvyK7l8CLW1e98e/9Me0r28UdqOeCJOUYfBwiQU6/3ejRc9uH19eSPHkAUSoYtYY0LZBDlkrDMAvfK0cDnT94gD/zUypdRip1yC37OaoSZBrwPl5laCPU1OzAdNPhlS6MbVHVsh738RvXAFXnSh887IOZ66UzGQvEVfenfKnSIQejsx68O9neXX7D96ynKclN/wDpIRZiFABXJ/sXzYq1Q3g9z2EZlOHlKCEu1XYNfriZfdo5qmtY2VEE+/DTSq5YGEyz26otMmHslEN0D1xjUGaWAYeor64F/KAnTSgdJoL++c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(70206006)(336012)(426003)(86362001)(82310400004)(5660300002)(2906002)(4326008)(83380400001)(8676002)(508600001)(8936002)(2616005)(81166007)(356005)(1076003)(26005)(6916009)(54906003)(7696005)(40460700003)(186003)(47076005)(16526019)(36756003)(316002)(36860700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:17:14.1019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13dda7c-35e9-4101-b12c-08d9f52354a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
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

Remove redundant calls of amdgpu_ras_block_late_fini in sdma ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 1df8de84386d..e1835fd4b237 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -111,13 +111,6 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 	return r;
 }
 
-void amdgpu_sdma_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA) &&
-			ras_block)
-		amdgpu_ras_block_late_fini(adev, ras_block);
-}
-
 int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 34ec60dfe5e8..53ac3ebae8d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -118,7 +118,6 @@ int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring *ring, uint32_t *index);
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 			      struct ras_common_if *ras_block);
-void amdgpu_sdma_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index d1d40bbb2892..206acb6a5b20 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2824,7 +2824,7 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 
 		/* If don't define special ras_fini function, use default ras_fini */
 		if (!adev->sdma.ras->ras_block.ras_fini)
-			adev->sdma.ras->ras_block.ras_fini = amdgpu_sdma_ras_fini;
+			adev->sdma.ras->ras_block.ras_fini = amdgpu_ras_block_late_fini;
 
 		/* If not defined special ras_cb function, use default ras_cb */
 		if (!adev->sdma.ras->ras_block.ras_cb)
-- 
2.25.1

