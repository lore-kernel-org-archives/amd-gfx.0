Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE38C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3923110E550;
	Wed, 10 May 2023 21:26:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C621D10E54F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP2OjsWgZAht0iyFndE61SqoiGWmcwdvD2FBPVC+0Zu/S3tKY69Ck18x/tQiu95D6aTum5K+AW6tfZL6C4NseBudmhYXQb6dSBequm8fyLJeoLY7Ru6M+X3cz5M0aKw6Z9RV1YS6DwAS/ru/1Z+NFt5cyKNzYFCAl1wceJRkCWQTNISrqoGW7muX+LnH+Iou4aZoMHz+XQXlKOwc+o/xkzEbcCVqMnuhzb3f9nGgDzg/XmUoJrdz7n0Xp7lOAsVlgrtZQAuWcozNedaj5jyKBuC3kEJJOFPgFEad1mkr7hC+n1zTr2oceuzeNOj2CbEcfmuSIJnqWJikUj3NfWJT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIt6+J9P0FdsL8JHEQX05I1K5AJ/bKw+d2M+4y6r/Hk=;
 b=l0i43YvTdPXvGWBVoAh9mIcQqtge4Wc+N0N2wUezk4JaaFZXWa638PL6ICryRDzKg3N7HKILqvNVCIZSuFTanewdPcwViUuDifqlCutcxjJkhgwG5VCEsAaiIhITe5zqtWnpZAzkzHWV0/MypOq0EBErM7oEgTMKQzfOkmLgY9K9eER97kUplnPQonRIKSEhBrvWDKRLpS9YSa/GGRv+wOGsgA0MvCWfc52oz0yKLlmlt4KIA9OeHF7Fwc9qoA/cIWr3tPAyV9rPT2xmYpz4I+EFayEVYzFV3/DOmtIEolYQiQBxCTjzgk0tcMK3+Rd4J0m+3Xu1N3oG9UxbV9NFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIt6+J9P0FdsL8JHEQX05I1K5AJ/bKw+d2M+4y6r/Hk=;
 b=xT5kS/EhIGb1qJwJisw4QJAwkfLnNjC7hPNZeq3hd/jsroYLZCKUCVFKOHBXZqiMztKBiX31b8nGQPbdCfdNsvhgm/kMBYgigT9CrLsE8zQRol/Vbnw/ke/SFFLuTYbKXgItY0pTsi/8YtbKJAl2i6mPi4eVdRsSsD/6f7urJlc=
Received: from SJ0PR03CA0179.namprd03.prod.outlook.com (2603:10b6:a03:338::34)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 21:26:41 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:338:cafe::77) by SJ0PR03CA0179.outlook.office365.com
 (2603:10b6:a03:338::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Wed, 10 May 2023 21:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:26:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:26:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: remove RAS GFX injection for
 gfx_v9_4/gfx_v9_4_2
Date: Wed, 10 May 2023 17:26:23 -0400
Message-ID: <20230510212624.2071771-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212624.2071771-1-alexander.deucher@amd.com>
References: <20230510212624.2071771-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: f6807a6d-7132-4ef2-5bf4-08db519d3e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oyzqqPTQPiQ8NJA41gOtmOA+kKCSPMcn21xVKUM5V+E9lWJKonJNQDZd04Sxb8R/6JCU3jsQc76biW94sLMAnsLGyWDuvPWAncG7l+TXvMu0HUCjW2K+Li5RoqM5P8pWXD/p+Mj/b/0ucz3KmSs2ibOYA/tWOv1RNN00bX2vqIecJdVCiXu4p+Ad3OhlRuoZoMtExZD6dl9vWMea6VRtQsfsRndiEEjYxo09QADZ5LSJrovDcCtWwuxvXq7A6ZhPxrOAUokF3qDI9sNlT32maX64LKnJEAOzM+a+m7En0c8UM5JiY9IBqKFxYGE5aLd3CZISvz8hOYvB/qSMNP7ASh57X/9VJPsNIwXAPi14QwOEaVV7lon9TnWofBxU5M9IKHueYRfpPlLFpDDuqpPfH+FUZVLLU7l0rWA/RuhZ/I/rdrB+eZyijMj2LycDF4UpMh0uewXVUhpm6lNSepDqu+p1DYECi1i19vRyjJ6v/+3MZ3ab5CtGTHDe2ZjREjBj/aHZEpd4yZWn6XvI3tlEla6IgHiF0xiF5sXjpZtvXlGV8H2ec0Jqg9aZzaJtERVahZhUzjbG5C+oUdG45eT0KdMgAZ8IKOhjvkvgDrrKhS3t0z9wa3CB3FeqfDhyslMZ/kneE6cefrXRexveg3w8dOlDr6WIS+5Rd77erAer7XAkmKNFnsBAYdtA4fon5IiJmkbozSYy6VJhmr26JMiffl446Up2TdoWPegkUjOJzxo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(36756003)(36860700001)(336012)(47076005)(7696005)(4326008)(6666004)(54906003)(82310400005)(478600001)(26005)(16526019)(2616005)(1076003)(186003)(2906002)(316002)(426003)(70206006)(6916009)(40460700003)(83380400001)(356005)(70586007)(81166007)(41300700001)(82740400003)(8676002)(40480700001)(86362001)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:26:40.3276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6807a6d-7132-4ef2-5bf4-08db519d3e94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 "Stanley . Yang" <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

No special requirement in RAS injection for the two versions, switch to
use default injection interface.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c   | 24 ------------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 24 ------------------------
 2 files changed, 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index 59abe162bbaf..bc8416afb62c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -970,29 +970,6 @@ static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_DSM_INDEX, 255);
 }
 
-static int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
-				     void *inject_if, uint32_t instance_mask)
-{
-	struct ras_inject_if *info = (struct ras_inject_if *)inject_if;
-	int ret;
-	struct ta_ras_trigger_error_input block_info = { 0 };
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
-		return -EINVAL;
-
-	block_info.block_id = amdgpu_ras_block_to_ta(info->head.block);
-	block_info.sub_block_index = info->head.sub_block_index;
-	block_info.inject_error_type = amdgpu_ras_error_to_ta(info->head.type);
-	block_info.address = info->address;
-	block_info.value = info->value;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	ret = psp_ras_trigger_error(&adev->psp, &block_info, instance_mask);
-	mutex_unlock(&adev->grbm_idx_mutex);
-
-	return ret;
-}
-
 static const struct soc15_reg_entry gfx_v9_4_ea_err_status_regs =
 	{ SOC15_REG_ENTRY(GC, 0, mmGCEA_ERR_STATUS), 0, 1, 32 };
 
@@ -1030,7 +1007,6 @@ static void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 
 
 const struct amdgpu_ras_block_hw_ops  gfx_v9_4_ras_ops = {
-	.ras_error_inject = &gfx_v9_4_ras_error_inject,
 	.query_ras_error_count = &gfx_v9_4_query_ras_error_count,
 	.reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
 	.query_ras_error_status = &gfx_v9_4_query_ras_error_status,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 4906affa6f8c..2cc3a7cb1f54 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1699,29 +1699,6 @@ static void gfx_v9_4_2_reset_ras_error_count(struct amdgpu_device *adev)
 	gfx_v9_4_2_query_utc_edc_count(adev, NULL, NULL);
 }
 
-static int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev,
-			void *inject_if, uint32_t instance_mask)
-{
-	struct ras_inject_if *info = (struct ras_inject_if *)inject_if;
-	int ret;
-	struct ta_ras_trigger_error_input block_info = { 0 };
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
-		return -EINVAL;
-
-	block_info.block_id = amdgpu_ras_block_to_ta(info->head.block);
-	block_info.sub_block_index = info->head.sub_block_index;
-	block_info.inject_error_type = amdgpu_ras_error_to_ta(info->head.type);
-	block_info.address = info->address;
-	block_info.value = info->value;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	ret = psp_ras_trigger_error(&adev->psp, &block_info, instance_mask);
-	mutex_unlock(&adev->grbm_idx_mutex);
-
-	return ret;
-}
-
 static void gfx_v9_4_2_query_ea_err_status(struct amdgpu_device *adev)
 {
 	uint32_t i, j;
@@ -1945,7 +1922,6 @@ static bool gfx_v9_4_2_query_uctl2_poison_status(struct amdgpu_device *adev)
 }
 
 struct amdgpu_ras_block_hw_ops  gfx_v9_4_2_ras_ops = {
-		.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
 		.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
 		.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
 		.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
-- 
2.40.1

