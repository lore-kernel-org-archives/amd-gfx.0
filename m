Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110A8C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD640611CE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD640611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7038E6E8BE;
	Thu, 17 Jun 2021 08:39:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E18E6E8BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 08:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npBgmHpOuOtHEtbvSHEE/aUD88pHT8IX37/TqY1KoUfz9A0i26TRqsuE0pXKWiERU/vSqPzwJG2gRMaQJ52fYrSxuMeNeAgbha86WyXq9PqDqZBrr8BsW3IwdQDwYAsmvOBXpRHWX65VmmFoFSLmalsd3h5us2jGVA9A8yqvEaSFBd6BN2CZaNOlWNDF9tmA8JbBNXxYRQ38qW4zMdVwkxv6VkyGmGMJdFE7K95uxWC23G5c0zukHgF+hD5ab7CkCgzaiMoM8xGsxzGwzoZMKK5Y7CtEHmEpCTh/6L/hSzlT7QoDoK2kv1UXoqlnv2BJU0JbE9vByLLva8TWZAfWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr1SClS29pX1uNxubcYoWsleOVIz/ZVBmFs5kZ7phVo=;
 b=R269PqFD2Q4tCVL5xj5YPe6W3Zdqdo0ExXjoNDOn05ag10BeK3OlZ1jR6Ht4VRjERtLaHZRWZjm/I2IWkPFpY3CekxnCeHcdVF/yS12Fa4XnwIE24T6KJhpli660qbM/GqSBMMbjQkojodw4C5KEcXPRHwjsaA3JeANhmNxJTEaxE/7iefo/JbKQHFhpF28nVJJGM7w9iBYA7N9bl57SfYUFa4kXllSa9pRwR4C90svv0CA587vgA0JAq67vL49Mdh8SCayOCiMc0QjCI1EQad/juzLieIvIna21Se+uJ6yxZb8fm/3TKQfDOBq3Wny0Y1z49zsvIsAi18XkS+vDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr1SClS29pX1uNxubcYoWsleOVIz/ZVBmFs5kZ7phVo=;
 b=abchQ6hwu2EOv5hWG8X24ElZgssRiHfE3F0YWIKtGfJEdZeBztRZun8tKoe1t2mPY02dRTElvXhBlLOmeY+kVkjQnQF1usrUgPkyK5HQQm3jzChqy8YB2bL99h0GkScJltXTC4AioqFUywMwG+jthWE9ap4A4oPp1m7nSnQeT4c=
Received: from BN8PR16CA0031.namprd16.prod.outlook.com (2603:10b6:408:4c::44)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 17 Jun
 2021 08:39:52 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::c6) by BN8PR16CA0031.outlook.office365.com
 (2603:10b6:408:4c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Thu, 17 Jun 2021 08:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 08:39:52 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 03:39:50 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/7] drm/amdgpu: correct tcp harvest setting
Date: Thu, 17 Jun 2021 16:39:17 +0800
Message-ID: <20210617083923.421052-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dd0d73c-7c71-4dc1-8554-08d9316b799b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5282:
X-Microsoft-Antispam-PRVS: <CH0PR12MB52823AD413754A5717B18DA3E40E9@CH0PR12MB5282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7x4EG6whPTZbCAmyiHr/Z1ZKPRHm65WmjKnwTPlxQlVCcSEIrL/uBK/fsSNA2p3WqjcDDA/5hKiF6beMFNiiFr/I2xtK/JIrR/ESZvUpbjmNIExWc4w2TD5HK43HdweP38ve+0UEEPZC7ynf7iHXw2vy0Nllrxn4k45ZtmlSAs+NPF5D9t6eLEQZazaldCBh+725q6LF+wCsUn70cXnchb/RPDAxkpXQWrhyq1gtkIHeqmfxFErkb5cMmNLJieb9XbyYwKIzJVRXg0+v5Rzoc+1ZnrtL/8RjrXVjowt6JNfANgu7n30Tm4zBpWJRHK8+DcZl1Liu9V5ziqWDFNM9rECWF7lRZIJg3uJkq0pcLNDPplYM18oi0QN0PF29WMJpWGz9nvhi1/w0RULmX1m2Gmt64+jG2Kc0fuqS3A6DafLL16FwSMKnYBl/XsfxFMoZMk+MajtZjUKPLdkJjMuvUPcHs3Ky30DJclzi5FhHukBwTcEIOsSnZ7G23cVRsWs/3DcsNoazg8lTG9T47zN3eX161xTu5rQnD4Tagg1ftr6G/fiFmjNFf4OLxdFQdaQ4u5Z5cWNmFpeXY8HiV7z/seV28AlHGF+/VaElx4Z2UhBSEH2/I3h8ct3E7IOj8F+uLySL5uzDAgncSrNi4q8tnHsH7Js4Jn/jTwITmQWfNkIrVGY5Bc2XJzp/Bd4uijwA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(336012)(8676002)(83380400001)(7696005)(82740400003)(8936002)(86362001)(81166007)(316002)(70586007)(54906003)(356005)(6916009)(36756003)(70206006)(36860700001)(2616005)(2906002)(478600001)(47076005)(4326008)(5660300002)(426003)(186003)(26005)(82310400003)(16526019)(6666004)(44832011)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 08:39:52.0703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd0d73c-7c71-4dc1-8554-08d9316b799b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add missing settings for SQC bits. And correct some confusing logics
around active wgp bitmap calculation.

Change-Id: If4992e175fd61d5609b00328cbe21f487517d039
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 28 ++++++++++++++++----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7bfe6f9d3a52..94942c6cae24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5109,6 +5109,7 @@ static void gfx_v10_0_tcp_harvest(struct amdgpu_device *adev)
 				for (k = 0; k < max_wgp_per_sh; k++) {
 					if (!(wgp_active_bitmap & (1 << k))) {
 						gcrd_targets_disable_tcp |= 3 << (2 * k);
+						gcrd_targets_disable_tcp |= 1 << (k + (max_wgp_per_sh * 2));
 						utcl_invreq_disable |= (3 << (2 * k)) |
 							(3 << (2 * (max_wgp_per_sh + k)));
 					}
@@ -5116,13 +5117,13 @@ static void gfx_v10_0_tcp_harvest(struct amdgpu_device *adev)
 
 				tmp = RREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE);
 				/* only override TCP & SQC bits */
-				tmp &= 0xffffffff << (4 * max_wgp_per_sh);
+				tmp &= 0xff000000;
 				tmp |= (utcl_invreq_disable & utcl_invreq_disable_mask);
 				WREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
 
 				tmp = RREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE);
-				/* only override TCP bits */
-				tmp &= 0xffffffff << (2 * max_wgp_per_sh);
+				/* only override TCP & SQC bits */
+				tmp &= 0xfffc0000;
 				tmp |= (gcrd_targets_disable_tcp & gcrd_targets_disable_mask);
 				WREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE, tmp);
 			}
@@ -9332,17 +9333,22 @@ static void gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *
 
 static u32 gfx_v10_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev)
 {
-	u32 data, wgp_bitmask;
-	data = RREG32_SOC15(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
-	data |= RREG32_SOC15(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG);
+	u32 disabled_mask =
+		~amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh >> 1);
+	u32 efuse_setting = 0;
+	u32 vbios_setting = 0;
+
+	efuse_setting = RREG32_SOC15(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
+	efuse_setting &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
+	efuse_setting >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
 
-	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
-	data >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
+	vbios_setting = RREG32_SOC15(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG);
+	vbios_setting &= GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
+	vbios_setting >>= GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
 
-	wgp_bitmask =
-		amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh >> 1);
+	disabled_mask |= efuse_setting | vbios_setting;
 
-	return (~data) & wgp_bitmask;
+	return (~disabled_mask);
 }
 
 static u32 gfx_v10_0_get_cu_active_bitmap_per_sh(struct amdgpu_device *adev)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
