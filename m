Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08139C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B2C10E533;
	Wed, 10 May 2023 21:23:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B0310E52C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUXF1+PT0QmSkHIC4VD7m7cLMq2CsikLRXUi8//BGlUD9JapYmlxEccuBRX5dQqtzoYFvOItWpTehTAj+L+1CvyvJoMV1eqooUzGdgalKiaPTQueNPgJ1cXsuIUUcJAtLi3hJotiNBdP2+vugFH3b3/lVnyNn/Ws1xpHur4l9gaSx1Go0p4i7DTas1lXvHZZasJsHpPX7XPxGi6g14YXq38Z84U5wOMoTsyBv84GmGlIjofMwAxPAVWLje0uNChC8WEkF33mXnIlnW9kEKDqwMdWu65HW446IUxu0n3iZ+tkhatBXpvoE7ng2geegUNI+l5AOLC+N2ST0YgbXtE7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNWbdNz7edFA8PYLd8rJRgy55WpaE+uXtQH4TZaUiSw=;
 b=DVG1/3DqnfB7QPZnHKnsE4p7+fg9L4DfKzt3t6CoGc1v5B2R6xzYqQEMjjPUXcL/nX4DDwFFk9tv86i/5W1diX06xurH8ZQyEy+oR50fCty7C7S+tBnJMQmj58n/mYPlHt0ectCh1n8YtIphXpZuzEbhmB1muf1YFLulwaMR4h+2SFkvDawnG+0Fy8zy2pQ5bogkqILxW5Cy5RRwaAjYTb4QgGi0p18gh/FMWKuCETLpmW0FW0ekDxJhwJ/cBH62a9m1ShNUfmRwjmqqF5ju2w9rbphLEOtmsMTxaNcRito9+BmPE1Bj9q8rSTEb3pbQkzB6WZdIYUqhpJPi83dXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNWbdNz7edFA8PYLd8rJRgy55WpaE+uXtQH4TZaUiSw=;
 b=UQSmga7ifhoxVOQItyfumcWWqkuEdd9rZ8IDP90LYoFMho9xQPtzwayQJwfSfgVe2KE/dtLlJVItKvpk+lacWb8iUF9qzEdmvCjJg26lHdKR7SLDtepOaWmtEgTNaQ2wjODPYSTCUv1+W3NpMgceiCowe3q8Hnvb3IrSQvceTMI=
Received: from MW4PR03CA0087.namprd03.prod.outlook.com (2603:10b6:303:b6::32)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 21:23:50 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::73) by MW4PR03CA0087.outlook.office365.com
 (2603:10b6:303:b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/29] drm/amdgpu: add partition ID track in ring
Date: Wed, 10 May 2023 17:23:07 -0400
Message-ID: <20230510212333.2071373-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d0c7ae-0d99-49c7-7b00-08db519cd922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHbwnqhYFygdqoV2Pcoh7309sAh15PXgMF55Jf1iNMutWkdacH3b4+mRRs51/wJAB/v//C+SyE6ccM4PxmJyVlvtT3cQYF+EuJxzOzG8rTEi4sLu8HnKAr4XNeyebvQTzrucbhbZln1ZHpqcLAaYnjYO769rbOYJTdKxPeaU9Dh8vgqWgVpG+KKUsFq9GjTslJcDGzD489Pwqa6zk/emMkLdUmP3c7qDk7z99O+65DbLqxJRQfPW6duJuPnk5OLzNm9nyoridLoKOks+emTp+iHpfagWeZl93RfdXIXqFFIvkVfPJbK+FENf0nK/OHBTRfo145JmhuSbg7mR0PzA91f2A6Fi2JulAtPf7a8W3eODDCBYZmq4lnFixt6FlPdJkiJBllytzz/NPa/8Hvug/EX8Lfz56XqGxUVAM1FBgl7CwCfZ/EqDe/2aDLL/N7Q5Q3aaqI7LppJUcz5+1Mv6SFS5tSbOjbCdiEOX/gSKDzB33bKEsS0bjnHwxMVahTUgF1FptrvSZQnRvO5qkmlLeaR4nBwv8ev+sLMGXNxz1k51Vbk74vAQvbmXUqsJttdXng61P+035ENMztlYlIzN413EUZg9aZ0VI/29U3ssgysDUbWzdzBM/aL4T9UTTh1bhPoqgBa80cdSEpEFatcF2QcyacrFotoq/tQlqmGznJQrw7zNFIBjv64Pkcxr6aY6gKhAn443oSWjyPDoRB0uGMNeE9me2f4E4cxHQx0oBB2DJ3uQ6C2UbXroEvj0RgDQpWDa5fjPwRMZwP39l1TDjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(81166007)(47076005)(26005)(356005)(316002)(40480700001)(82740400003)(83380400001)(1076003)(41300700001)(336012)(86362001)(426003)(36860700001)(4326008)(82310400005)(8936002)(8676002)(6916009)(70586007)(70206006)(5660300002)(16526019)(478600001)(40460700003)(186003)(36756003)(2906002)(2616005)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:50.1158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d0c7ae-0d99-49c7-7b00-08db519cd922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Keep track partition ID in ring.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  1 +
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 41 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 5192e3577e99..baa03527bf8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -252,6 +252,7 @@ struct amdgpu_ring {
 	uint32_t		buf_mask;
 	u32			idx;
 	u32			xcc_id;
+	u32			xcp_id;
 	u32			me;
 	u32			pipe;
 	u32			queue;
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 97011e7e031d..c90ea34ef9ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -61,6 +61,47 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 	adev->doorbell_index.max_assignment = AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT << 1;
 }
 
+static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
+			     uint32_t inst_idx, struct amdgpu_ring *ring)
+{
+	int xcp_id;
+	enum AMDGPU_XCP_IP_BLOCK ip_blk;
+	uint32_t inst_mask;
+
+	ring->xcp_id = ~0;
+	if (adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
+		return;
+
+	inst_mask = 1 << inst_idx;
+
+	switch (ring->funcs->type) {
+	case AMDGPU_HW_IP_GFX:
+	case AMDGPU_RING_TYPE_COMPUTE:
+	case AMDGPU_RING_TYPE_KIQ:
+		ip_blk = AMDGPU_XCP_GFX;
+		break;
+	case AMDGPU_RING_TYPE_SDMA:
+		ip_blk = AMDGPU_XCP_SDMA;
+		break;
+	case AMDGPU_RING_TYPE_VCN_ENC:
+	case AMDGPU_RING_TYPE_VCN_JPEG:
+		ip_blk = AMDGPU_XCP_VCN;
+		if (adev->xcp_mgr->mode == AMDGPU_CPX_PARTITION_MODE)
+			inst_mask = 1 << (inst_idx * 2);
+		break;
+	default:
+		DRM_ERROR("Not support ring type %d!", ring->funcs->type);
+		return;
+	}
+
+	for (xcp_id = 0; xcp_id < adev->xcp_mgr->num_xcps; xcp_id++) {
+		if (adev->xcp_mgr->xcp[xcp_id].ip[ip_blk].inst_mask & inst_mask) {
+			ring->xcp_id = xcp_id;
+			break;
+		}
+	}
+}
+
 static int8_t aqua_vanjaram_logical_to_dev_inst(struct amdgpu_device *adev,
 					 enum amd_hw_ip_block_type block,
 					 int8_t inst)
-- 
2.40.1

