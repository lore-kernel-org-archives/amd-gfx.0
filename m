Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DC6CDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 11:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A52310E3CD;
	Wed, 18 Oct 2023 11:40:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EF510E3CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 11:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq3TupjG0Z6TNsRRyhbF2U7juaFmEdA2aGQwBcDkSXLnnLdif/gG+ksREnE9kj6WVGTzS7g7PytsSOzdrpeBYzqcNNxyhE3AJBzPUqvWF2mNCo54LjXTw7VbdURPYASh9RYbosvVPZb4L1CGhK3Zz3sbnQdcqKQOPhVe/tONHlTqCenD2hVznI1si2ChSfQ7akbBmOu42ZIlWAEbYmAfqIR5/iKVjFtejD34V/USA4lrXizep7Iv9+LBWf/X6eZ6BzTjSEVhFy+jOO0Ei83UO36gRPp4t9LoHjZsXCveDO05WBBvLMk4hmHWE0lKaj5MGOqTAT2ovnwKRCieeSFz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbALtWg1HtHe5z4V9KbY5oG5j4Ongj5Po3KqZEK3Ho4=;
 b=kxWgX9ARek5KOv+Fltxs5Fs9/MJhk9p+hEoRFhlZLQA0h3km+GRJG9n9qhjk8QbaSO6HcWX3uHdQknSbmMxp2s159UAAlztN07zMgXi8M2su0fmBx8UMr1SHD9fSkFqkgMgRkheO8cta2BmjJGCBp7rjm2R0tYOwV5eL8+Nhzu+Q7E0bnJn45LuzUeaByXBs5sdBVNEoG9x9O7pXhuMz893zQ6+tioStoVVzdR+O7PCw2LFfEC1DvgVYmtCdQGa+Pz/f8Z6bO9enf1yvut+BOWdmv6qjCqsR8gQDTeTcmJka4Kifcf0fVkHQQQwN5WhrS6oI7pncEoZUabzIraxaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbALtWg1HtHe5z4V9KbY5oG5j4Ongj5Po3KqZEK3Ho4=;
 b=2IWe5HWyKdFVt7Og2/imqy1MpUfBjcUjeRJXzgGR97GohskyeTbZngMT4qGiLnFvVai2607l4Yhxyg2ydwchGS5OtI4sXDb8zSkA/Z6YjhaRIEBWqDF600sjgnlXcHrUBxFhrlMmuItuhACiR1vS3J4jyXRhWYH14ctD3D0v8Mc=
Received: from CH2PR05CA0034.namprd05.prod.outlook.com (2603:10b6:610::47) by
 BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21; Wed, 18 Oct 2023 11:40:25 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::dd) by CH2PR05CA0034.outlook.office365.com
 (2603:10b6:610::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 11:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 11:40:24 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 06:40:22 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: define ras_reset_error_count function
Date: Wed, 18 Oct 2023 19:39:52 +0800
Message-ID: <20231018113957.20079-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BL1PR12MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ff00bc-0a03-4c47-f275-08dbcfcf04ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beBh6wVuWW08/D0oakKPITsbhsId6xFuyBphcLLrlM//zO+5WID5EZMiNFNPdSJ5L+//Lo0aSIFy24DUv1MoYHbxY/39ee6g51T8neDEnbod4zIGeoSjiPdXRWg330GIoYZ1mg6E1QSl7rEsbfY/R9AdKWwp9vg879tqNgIppB3umlH5kSjV+MQHW2R2F3ksF2duPdSapcJqO+XG/yy02yJA8DEcb0cP+OAfrN8nv3CpQGyZPnzzd1wJeI5Nx9xWG5I2rw7WkAFYeDU9RJxsi1jiRHQ+rLhc/vf/9DKmr16I34YnW3fY1UaHc3SRLznc5h0BU1jfpHh4r93UJtomvcBjUtxKcee5OMNdUgZVyXzWa/MMU8SdGfAIy6pu8N6GZ3QR8jO250BN7SDfux8LEPZZE5bjx3UuuQUP7RTA1sP2YRzLLM/+oJWv5LmwIIo3bhviFcjA1hk1n1jtoPEDerWTqJmIg2lskw9sw9CvxcfIDrohZoOZNf+TPqmsiFgy9EMbcG8Y30YcQeOYUn9xhCf//AiFAmGuYCXPSfxSkvgxkDgJM8o4/PcWmM3avl34i0Um3PFYDGdkMM/FIU7xacazhp6P9WVIcKKB8MHqxlK+LrSdYDY0Qg0kRDFIcZ7snQtbjNlMrCrxSKY3IiZNV8+pkTno7EerfpVsVv3shjIJ0aqjXS/7WbMkclji1G8pBjaJAwvU0SKKTTFDFGzhBIMHc9OgPy9dIYiusHGPZUsBJiNdJPmTNAy0TWVM0mtEllyAyROnRWsN3CODel3GhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(36756003)(40480700001)(8936002)(40460700003)(316002)(110136005)(6636002)(86362001)(82740400003)(81166007)(356005)(83380400001)(336012)(426003)(7696005)(1076003)(26005)(2616005)(16526019)(6666004)(2906002)(36860700001)(478600001)(70586007)(70206006)(41300700001)(47076005)(5660300002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:40:24.7865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ff00bc-0a03-4c47-f275-08dbcfcf04ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the code architecture more simple.

v2: reuse ras_reset_error_count in ras_reset_error_status.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1b23651cacf4..335f5d8bc20b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1174,23 +1174,34 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
+int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
 
 	if (!block_obj || !block_obj->hw_ops) {
 		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
-			     ras_block_str(block));
-		return 0;
+				ras_block_str(block));
+		return -EOPNOTSUPP;
 	}
 
 	if (!amdgpu_ras_is_supported(adev, block))
-		return 0;
+		return -EOPNOTSUPP;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
 		block_obj->hw_ops->reset_ras_error_count(adev);
 
+	return 0;
+}
+
+int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
+		enum amdgpu_ras_block block)
+{
+	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
+
+	if (amdgpu_ras_reset_error_count(adev, block) == -EOPNOTSUPP)
+		return 0;
+
 	if ((block == AMDGPU_RAS_BLOCK__GFX) ||
 	    (block == AMDGPU_RAS_BLOCK__MMHUB)) {
 		if (block_obj->hw_ops->reset_ras_error_status)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 0a5c8a107fb2..3f9ac0ab67e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -714,6 +714,8 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		struct ras_query_if *info);
 
+int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
+		enum amdgpu_ras_block block);
 int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block);
 
-- 
2.35.1

