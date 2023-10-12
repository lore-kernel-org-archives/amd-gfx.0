Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA54CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 09:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA8E10E46B;
	Thu, 12 Oct 2023 09:01:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA6A10E46B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 09:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gxhout+uzdAhDShPtCRVRexcaVpl+bhMUO49PlUk8LIdFqlVpaf0iKdTmY++h0f+YJZPWmDyvgcRsjcbxbRkPQH2ch6AjVOYnLUSZefceUeo+lzT++3qzw4pwh1UgBgkvcms4Nht2Mvtcd9CYVB0/agmRpwsqbWBegmph2PFNc4iUlx/oU32t4gCbXc3FUy5i0oMrybuSfhwjA62Twl4FY7LRL4xWusBuFyMFbe092y9sOnoOJ6TmvutgW+MP5vAayigXzeLPmJTB746K2/uL6tFg3G6GEDDcijW84VkpZvyhpa4mCi6kk7+I5IqcTM6X54+9d0xA5pXogKuLBJpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m++EewdcgmhaZhG3Y3n021RYgefZ7QnSa0NEbflDPi8=;
 b=b9Acp/RNR/Nr5v+LGyuHlERAK5CAwBss/0kcNGr3Hf0PJjH4IZvfgkKEfH5erYHsB5qTVvuCTUPAHAJLRrPVi5dIX53hiiqnOXktT8Yx22euxvIf8Y3aF2ogvU7AUcn9/+PXyOSfldu/xeNzHvsiIg2pggBjUVXoykmWSnmGC0oTvbpaLypXMMbINVRkrDJw3+zGhy/A78lccL0K9a8F1h1wZ09ofoZHxCXBhjFdERi637nRg8Va7Uf9onV4a8tD/NUI+pLesHFWtzg281XxzCxuuM/lSJV9Iu5R+84RyFTcXEg4C/6xQFU6GeE46Z4OI7RSwL3VG3QF9SSXL1hwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m++EewdcgmhaZhG3Y3n021RYgefZ7QnSa0NEbflDPi8=;
 b=IG6wSxFRpKa7hMO8DftX9p3R4sRyUh4kpHETXk2won4+z7f1koC2p1J+hVurg55CNVL9W9wqP+YTxuO/8Kzs7t0a51TpK2RC+lbiR0jNnU4PoaiW+6bBkEynrXLTa3iqc9hX5WODkJH1hlR+87gJLjO9BAgultd7MeM7jLbg18k=
Received: from CY5PR13CA0065.namprd13.prod.outlook.com (2603:10b6:930:a::18)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 09:01:10 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:a:cafe::4e) by CY5PR13CA0065.outlook.office365.com
 (2603:10b6:930:a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Thu, 12 Oct 2023 09:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 09:01:08 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 04:01:06 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <stanley.yang@amd.com>,
 <hawking.zhang@amd.com>, <candice.li@amd.com>, <yipeng.chai@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: add set/get mca debug mode operations
Date: Thu, 12 Oct 2023 17:00:31 +0800
Message-ID: <20231012090034.31055-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231012090034.31055-1-tao.zhou1@amd.com>
References: <20231012090034.31055-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0d6ba8-5183-4b70-bb36-08dbcb01c6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUCUYGT4arywZlZShlykNbATgaxMVH6O7JapHYvznuN8Pj5PBYvOz0QLA70m4Hbbv+u1b21rMFrrwx8hgRSuHs4RbZR0/rP0WUvfNAE3b1Jiwl8QlTm+Nv3jRsoE5nJWB9dkou+/E9xcpLlIUciPYUIJurEwC7e5WzrBjfRDYJO4R3UdhmXRcE4bvVy35oxjFJbeYdxqmXHeC77MRZuaf2Ktw7rZqoSNQKHhr7e1gOeXBtSxbyuB4OHHRRKvWBxOa8GCIQU6+wBxb/qjWIHO94hCCWi9pQMjsW4age44IGlQu8RjjuWWH/YcoybaS05DjWX9/M1ygIZjjh9CLA3EVy14QqEon6uGdz7jpQbXT8TTqmDy6ki+C7zpt5MKFjRdOlSdAcaWIrkMsP7RCiklwEVHHUjzkWnEYCWWW5XaXIh6yHxThYhdcLWXDTlvGkanl66Mvff8ORbaaUBsNy4YmlzMXwB3LI8verNnrMUiYf/gHR/M6bwybSbNamBJme4gGvz12OqXa4xKAclHcqY4MUPlDyU8G9oju3XZFP3DnyqF+uqhXRVPm3NdkwFJ0wLzyALtt2NUz5RZizUryWY7+ZcE9fsG4H0hlvrIrLlczyuPpYarbyJjPSWZwa3lxkUw6q1htygf4Hh0F0oOId1t4suC69i9g4j448/z+XpHZxxTXD7g8UfOjjwIzHXZb3N0hcs2F0Ym5uLycuNYZ52YqvXAsV0hcVrb/pS51zSI3/Rs5h0FRWILcRAfpRreZLaz9sdibNlNub9GLnmUKbyI/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(478600001)(86362001)(82740400003)(40480700001)(356005)(81166007)(36756003)(36860700001)(2906002)(83380400001)(26005)(6666004)(16526019)(7696005)(2616005)(47076005)(8936002)(4326008)(426003)(316002)(41300700001)(6636002)(70206006)(110136005)(8676002)(5660300002)(70586007)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:01:08.9791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0d6ba8-5183-4b70-bb36-08dbcb01c6a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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

Record the debug mode status in RAS.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 82ee6f3d12da..91ed4fd96ee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3250,6 +3250,27 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 	return 0;
 }
 
+void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (con)
+		con->is_mca_debug_mode = enable;
+}
+
+bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+
+	if (!con)
+		return false;
+
+	if (mca_funcs && mca_funcs->mca_set_debug_mode)
+		return con->is_mca_debug_mode;
+	else
+		return true;
+}
 
 /* Register each ip ras block into amdgpu ras */
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index deea10b6c184..c60688dc73ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -433,6 +433,8 @@ struct amdgpu_ras {
 
 	/* Indicates smu whether need update bad channel info */
 	bool update_channel_flag;
+	/* Record status of smu mca debug mode */
+	bool is_mca_debug_mode;
 
 	/* Record special requirements of gpu reset caller */
 	uint32_t  gpu_reset_flags;
@@ -748,6 +750,9 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
 
+void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
+bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
+
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 				struct amdgpu_ras_block_object *ras_block_obj);
 void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev);
-- 
2.35.1

