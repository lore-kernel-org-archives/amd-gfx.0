Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3824BC74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB74B10EC54;
	Wed, 29 Mar 2023 20:26:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B949410EC54
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPGFyEyqmHFT99aV8rvKKWug3EwBjHvhcsUh+oCP3Ifl5E0FqI6zlyo3VWiWlFiZdsjyPB51gc37tKmOrn5yJ0mCv3Tca2pfLpAYjflZ1gR7LQ4SM1eEeJDtUC6xW8DBoxg1ER4p8smI1WoLcXwLHWFRu8UedeMWdO3BY/Elvegg75ApwqMERrwJIaDwoTI5TgPOHL7bE6gn6Quakyz1t8ymuEWMnID7LUdfHIX2SGSkLzZSm96rX3Vl6WaX+iuFI1W7a43qosuPzsAX2WBZ/7BdEDAoLJfJKOr/bOemnZWwG3Jwy0CRFuwqzkdlMp+nMk+81RvFuccwVJmB36OXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke6BK+oShvegezUV8Bfh0LRCFM7dKFf0eiC0K3JxyQI=;
 b=CFRS3RA/5yqBWnrGDz3w/FXHCTh9qD/QKkRskG04RZX+s9kSQOliAyoUhFqBk3n3C8XjVCF2VWpOC5+1onHALPVSi9R2r6N1RUD8sYlLIcQEblSmvR0OBipLDkBLyXFZ+H1cVR4FOua31aZV9tyELbV81wx3OmAvAG8CpQnzovrqw1+YQFJWyTGYrtrRphVWgYurpEmaPA3uPkrRymkmdwLgD5k24t8XB/2rVSXWFa286T62eyCzt8b9DQpH8MbYAVjEQBgB7qn6nDPnM71AWaAN3Ob+6JFIHf7hhUJ4enylmlndkPdqvnPrNG2JQ6SAMholB9faYfKZMY8ckotz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke6BK+oShvegezUV8Bfh0LRCFM7dKFf0eiC0K3JxyQI=;
 b=gRpvwhVLJnMgDqVO1BnYwGglkXA+uvFcj5ohQojwJYFEjhGeGZGqKbvY01QekUqEwnuEzwIq3YKuxzBeu2gRk8ljPk0F0yRC6wUzmDfacJqJea5MK5VJRquMnTKNVLD0/WW2Gy0QLNmbQ7W2lAw27cs1AIwMA64PAAoxhjpqk0s=
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:26:10 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::12) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amdgpu: retire render backend setup from gfx_v9_4_3
Date: Wed, 29 Mar 2023 16:25:48 -0400
Message-ID: <20230329202548.1983334-14-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|CH0PR12MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c63d406-bf1e-41cb-2389-08db3093d53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFS+fymGQgj/mma/ZpmzezmavVliMMBtQ0TjNtxquCixSb83bnrgE/kFR+9k6kGwSjvRvEFtVmqYA1t2hAEpIsKA0ffyLuJcKMPxotMLRyq+ZIb1MBhrL7Y9FB9sTfeDJn+7XYaru0bY98q8OreKUa19w/RqlVF7yqERBcfC23VCxO15iTURLzIv6ATvemRyvIKnB00RYWfBe2qprGPysotEEi+eN3a2L50QrsacOJRVUR1lLWHvzQ4RDrEbK63SBAmt1mHfpTwT0zCnivjuAyDFVJho4mqUtaEpIsGZQ9pV9EA2BM3R+2BcaGkoCWjop4d/r9U5UeR+wX/U9H6qutcPqrqhgYqn+G4KvJCxOtUYl3wGCSWL7N2jDzM5zdnNsmstb8QPIx7Nd27DQNtHB+RgcrklPKCIPa6XHAic69us6jwEwUDGOoA7dYlLCYq5LDhqTbZghoUpdCuR96PvyuTQcxJPrNyN1+tWy+RQL7Bul4RtKJCPlNx4DflT1Y495Y3FA8wb4gzRmoBW7jNBnA5wG+3pRlpB7o0GYRkv59xFnphfOlGkw9lmpUjxC6Nx51PHwP9eThBZNNNkVxXri1SrZMUMMHQ9mW47+iTs/lAZAxvqDu8EhkL1GBDzefnmhI0ZdSm8NpjQOJwdKXiNxnirG8DrYYlVu52MiYX+cTJ/MGifIbvC71cfZdd+4RilddCjf9fxHCan3gd8MOhz97GPFDOt1AbsMfLIZX1yUsY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(26005)(1076003)(6666004)(356005)(82740400003)(81166007)(2616005)(478600001)(47076005)(36860700001)(426003)(186003)(336012)(16526019)(5660300002)(2906002)(8936002)(40460700003)(40480700001)(70206006)(36756003)(82310400005)(316002)(54906003)(6916009)(4326008)(41300700001)(86362001)(8676002)(70586007)(7696005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:09.8221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c63d406-bf1e-41cb-2389-08db3093d53e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

gfx v9_4_3 only support compute. render backend
doesn't need to be involved in any compute shader
execution.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 44 -------------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 40d4123de54e..3ea88a909380 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -893,46 +893,6 @@ static int gfx_v9_4_3_sw_fini(void *handle)
 	return 0;
 }
 
-static u32 gfx_v9_4_3_get_rb_active_bitmap(struct amdgpu_device *adev)
-{
-	u32 data, mask;
-
-	data = RREG32_SOC15(GC, GET_INST(GC, 0), regCC_RB_BACKEND_DISABLE);
-	data |= RREG32_SOC15(GC, GET_INST(GC, 0), regGC_USER_RB_BACKEND_DISABLE);
-
-	data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
-	data >>= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
-
-	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se /
-					 adev->gfx.config.max_sh_per_se);
-
-	return (~data) & mask;
-}
-
-static void gfx_v9_4_3_setup_rb(struct amdgpu_device *adev, int xcc_id)
-{
-	int i, j;
-	u32 data;
-	u32 active_rbs = 0;
-	u32 rb_bitmap_width_per_sh = adev->gfx.config.max_backends_per_se /
-					adev->gfx.config.max_sh_per_se;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
-		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v9_4_3_select_se_sh(adev, i, j, 0xffffffff, xcc_id);
-			data = gfx_v9_4_3_get_rb_active_bitmap(adev);
-			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
-					       rb_bitmap_width_per_sh);
-		}
-	}
-	gfx_v9_4_3_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, xcc_id);
-	mutex_unlock(&adev->grbm_idx_mutex);
-
-	adev->gfx.config.backend_enable_mask = active_rbs;
-	adev->gfx.config.num_rbs = hweight32(active_rbs);
-}
-
 #define DEFAULT_SH_MEM_BASES	(0x6000)
 static void gfx_v9_4_3_init_compute_vmid(struct amdgpu_device *adev, int xcc_id)
 {
@@ -996,10 +956,6 @@ static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 	int i, j, num_xcc;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
-		WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), GRBM_CNTL, READ_TIMEOUT, 0xff);
-		gfx_v9_4_3_setup_rb(adev, i);
-	}
 
 	gfx_v9_4_3_get_cu_info(adev, &adev->gfx.cu_info);
 	adev->gfx.config.db_debug2 = RREG32_SOC15(GC, GET_INST(GC, 0), regDB_DEBUG2);
-- 
2.39.2

