Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B939C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0BAD10EA9C;
	Mon, 21 Sep 2026 20:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ROdsfn5f";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC5010E63D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnJhwyDtJMKCS3r9718A7n6HoyZK0kD8LSt6xup8PLBCwbDsspm8v5KFvqYLzWkd6MdWzAIrBmbgaD9D/KyIFnGqpKmPbK/TOx2JUIqtBZ0iqCh2i1RE5SMTEIurvSc5VwwpcL89cDzlJY7bzCLGp9zaVtKRz3+JE5D6xvpI2njqXAWSlrZIqHzPVt2nSSLBKIJIf7HWnLlnzUDkYTy2UyjqkfZFXu8cPMEI3Xye2TrYlyYCNg28gwtQ3OL1I1f4I8CMhdk6kxpLYELPJtYfg18RDFo+S6WouLBMmOWLse99G3ZDQO+/KQBupfpmIRKTH6ss+pIUHtEj4y73rNfAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EHu/GP7GTcZxoskzwHqkjyPis1g9mR5FxRZ+avPPeE=;
 b=YiEC5lajM3dxIaFsged31vbngDt+p5OP0gFlWX+Hcx06jkU/LsLX7t2FvKEVZn7NUgeVCynNVGRcAy6shXHDzuk1vaRHIaLXu9ipfL5zPEKA6y5jqPrG0ThcdiTidRYoMKWBNXQ3PgtOwrnyOgpNxagx0NgQPKT31qjzSp2JNW49/VdYC1PSyW27tvD5Zax1vY7GJzlL1/yNnTLF2Ij9g4oDdL8592FfyQXOqscqoZ36lv2X2PfYbmHkKp7zYXjPnqzmaWQsjmuhqWvGKuCdM0eKcwn4+ZZJwVgTqtpu3mkSbQgsK3fwo5zPT58+sNiRMckoGBXnr6q8dfaEhDhPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EHu/GP7GTcZxoskzwHqkjyPis1g9mR5FxRZ+avPPeE=;
 b=ROdsfn5fR9qan6zvRNPQnclFnChh0LX32X+fwFbqmPL/NoCY6lYPJK6rV6bpIaDwBW1K9Dz2R4xoiKduSy6xNCm4WzVlYWKcWU427jPZkb6T5EMQTixjS5O0Ad+J5SfOqJsYve04/wmneZOequb55dF0EuIMCPqw7xKBz7TfKJ0=
Received: from BN9PR03CA0203.namprd03.prod.outlook.com (2603:10b6:408:f9::28)
 by SAVPR12MB999143.namprd12.prod.outlook.com (2603:10b6:806:4e5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:10:43 +0000
Received: from BN3PEPF00022BD8.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::e) by BN9PR03CA0203.outlook.office365.com
 (2603:10b6:408:f9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD8.mail.protection.outlook.com (10.167.248.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:10:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:10:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lin Cao <lincao12@amd.com>, Danijel Slivka <danijel.slivka@amd.com>,
 ZhenGuo Yin <zhenguo.yin@amd.com>, Frank Min <Frank.Min@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix ip discovery table validation
Date: Mon, 21 Sep 2026 16:10:25 -0400
Message-ID: <20260921201026.2019083-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201026.2019083-1-alexander.deucher@amd.com>
References: <20260921201026.2019083-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD8:EE_|SAVPR12MB999143:EE_
X-MS-Office365-Filtering-Correlation-Id: 799529f5-9eec-4b12-59e4-08df181c6a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kHmh2pFn4/WfhmLOwUpOK8wrbmZvCyi69SjzTTN7O+1AcONk0iqGY3NUkh62hnHa2dstN3ffz0482jVtbCuB4ypv5Au7WUaHpLzmMtwDHfBnANp4ybfCkWn986ShWfesQgZb47cVJwY9i5lFHEaTYOLyjrYIyANAV7R3SezT/5ZgCyMOln4U8MkOH1dAimjUE/lJoSm2viqTomqnQVvL7+Iii4dBBvFmepdqDjq+pVSJpXeh+qcPq3+9Z/n5pIWjS+RsGk1FmpG77pFUwp5RuxMaz4falGweEBXELKOhx2UscDcKsI5x6jCH99UbkwPQYfey24wBsN7NpMJC9zP8IxOuj8aapxoyTAtZ/JpSQTOUiyYOZ0hnv6mArBo6CdJ0WWNLneP6wOWTDzuHfyMcBlLVm50vs6pKzvJRRHeoune7rLKqRl6uiGvt1uA3FXz92zFj6X7bMPeiuS6LLrGBcIlR5AKWIqB64gpP+XHm+7EIaNvv9GTHp+BpCAhN5z+iAqPS35dajrVNFfzjoriaOT65xZeUquIxITO5DnnLRGth3TXsJ+9eIp6iBTHOsM0JC7+L214PAaWTyvEo5hqc20eyu52J8wLyqIvmd9SUH1/YLF8EZFBi46b44G0uDVd1Y342ehp7s7ERUjo6Wa1fOJHHq3FcFw8E08aIdVqS/RtSNS54JV1wkzxt8jPOWNtinfBQifwYU4momwSWbi6zZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eYPTENFQ4P0UJ28S9QyYsm0Ko4s/mV2RGtrtYvOm4sNOofQxZDQyntsd9td01O97tezr07fhVfU/K8VHooUZOZpsOOGj9HVgNtIH//hLtEPtJHJFevHgN/EIYPSq1f5QE/Tn6+jwXcscww6a+PXKc6wSVFPbylGCB3kLsHR8ReL7zGSat2bBHG94AEGVLlH97rMTAkFTHpt6iR66eh+AUEPDFwQJcE5JD9ugzDWk/6sWn9SQ54yjWA0r/PwnvR80wgDlna3Pi5Gnn1Uol1he5I9u7GkveAgaiuq2FuTaplNtThnZ8ZdSCYlCZ5xgZan5dvoiVVWrocJ+DQFhTv4bOEfL/g3atCF7y/T1J/lTBTJgzGzcRfobvGsCtEvn/sCs0WseCEAUIUBTjy9hV6g6c7g8hRAN4VLW85Nsk4eWAyidhiG27aUC7tamAk7myzZH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:10:43.2407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 799529f5-9eec-4b12-59e4-08df181c6a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999143
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

From: Lin Cao <lincao12@amd.com>

Fix ip discovery table_check, get_mall_info, and get_vcn_info to guard
on both offset and size being non-zero before parsing.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
Signed-off-by: Lin Cao <lincao12@amd.com>
Reviewed-by: Frank Min<Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 965063696308e..366588c2642d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -697,7 +697,7 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 		break;
 	}
 
-	if (check_table && offset) {
+	if (check_table && offset && table_size) {
 		if (act_val != exp_val) {
 			dev_err(adev->dev, "invalid ip discovery %s signature\n", table_name);
 			return -EINVAL;
@@ -2203,7 +2203,7 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 	union mall_info *mall_info;
 	u32 u, mall_size_per_umc, m_s_present, half_use;
 	u64 mall_size;
-	u16 offset;
+	u16 offset, size;
 
 	if (!discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
@@ -2213,8 +2213,9 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 	if (amdgpu_discovery_get_table_info(adev, &info, MALL_INFO))
 		return -EINVAL;
 	offset = le16_to_cpu(info->offset);
+	size = le16_to_cpu(info->size);
 
-	if (!offset)
+	if (!offset || !size)
 		return 0;
 
 	mall_info = (union mall_info *)(discovery_bin + offset);
@@ -2259,7 +2260,7 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 	uint8_t *discovery_bin = adev->discovery.bin;
 	struct table_info *info;
 	union vcn_info *vcn_info;
-	u16 offset;
+	u16 offset, size;
 	int v;
 
 	if (!discovery_bin) {
@@ -2280,8 +2281,9 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 	if (amdgpu_discovery_get_table_info(adev, &info, VCN_INFO))
 		return -EINVAL;
 	offset = le16_to_cpu(info->offset);
+	size = le16_to_cpu(info->size);
 
-	if (!offset)
+	if (!offset || !size)
 		return 0;
 
 	vcn_info = (union vcn_info *)(discovery_bin + offset);
-- 
2.55.0

