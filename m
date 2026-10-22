Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECC606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=P9iPhJCF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A0C1123D1;
	Thu, 22 Oct 2026 08:20:45 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6291123D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2ErvW+wJu064OiMy15bOs3Csv7ZJXus3oOK5x+VKpgFMswVnITKMrnVlrXwS1yKskemgIGvYE4kPiy1GMEG75t1dpDbfxqJRaOjI6mk6YCkifcyGBDgcBSSuW9mHHhTcYP3BjSRcFQ+Xc7PNNUng8mOfQRqPEt6OO0quazC6b79eGWmbjaZB6KHsH+znQx2gJ+fxiJQzpNOe1k6o7GYK65g+9NfM28o92n4nzfMP7ckRYjHCmoMyTHmOEPS0KASMWnhE7sxbA9F45jloqNAWx8+NHOeJcSsFRb89t/px/zTST7xedFqi4WiCJ/fKTGeWrCj/YxWIKKRm6BVywHEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DGm6uE0WX7LxoUSNyu0RtKtxevFVBweS/c+9VLKEDU=;
 b=CkmFznrqFvJZ7eag7ptpLFLN6dCHRDffxHO2GUmeja/3mA/cAFWp3jr8lg+XEI8XqQ1JZa5k7jQ+Dqjf/u607w22JiIv/xTohaBcYEVABxa6WrX13ao/j4JZ/3mFS2KtaVpMITLptTGpbuWfa2Vv0M51F+A/xe+tTFDJZVCxc27wNg8yymTd7Sb2ODXyBaIsAFxPwrSadE6x3R1+85IDzkHwxh996g5IWcNrEYN6/hQwbo8sSwHdEMTIKDUE25K/bLceFnQltYloCyrSqSKIvHPNGhn9EyHrFdoSRreY/JMvVmqDFbmcUB0i6oSdSrFQ8WQd/nFJjmV3vJr/J/ukXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DGm6uE0WX7LxoUSNyu0RtKtxevFVBweS/c+9VLKEDU=;
 b=P9iPhJCFkrwj+qM2pk37tY5yvK/1aSmI7LEYM+Qe/ixBjFqbjC6D+VlfR+ojl3PzoV61mWy8LnVKdIC3vQBo4z7H1BiUAZtBZMpCxGy/tf+g1ZnAtdN5HzgzY4H5Q9OcmE3kwtTmqFAJB0B6tOKPTWV61rI9s95tL0l6t83e51I=
Received: from CH2PR19CA0019.namprd19.prod.outlook.com (2603:10b6:610:4d::29)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 08:20:30 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::64) by CH2PR19CA0019.outlook.office365.com
 (2603:10b6:610:4d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:25 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:23 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 04/15] drm/amdgpu/gfx: add callbacks to read and restore
 the ring state of a gfx queue
Date: Thu, 22 Oct 2026 16:19:44 +0800
Message-ID: <20261022082011.331462-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f832d11-16ea-4a5e-79be-08df3015552d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|6133799003|22082099003|18002099003|10067099003|261021121427099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uaYymYoYCQRFBzmZjjZ7BAfJ1vGu34s+bt8kTdlqPZG0AtHYfa8QtBof/xPGpv3D7Y5vptRTwQ4nlHtrOBtJoApbyg7yutRX29aBzFiqIH2OxbER/jyz9UXqKwHiluq83tBbbHaDw9KchFzj+rHsVKRbPxw5/ZESbZACftEROXDGAxk+XdGgJwd50EHTwjLZaeiSJ7Qu/ZA+ZSiAR3eNZ3DH/Mo5Eqe9CgSjcS5mvWgtu6ImkRC86bfQ+BqqVy75QgQGhSEpMGEZkBTSOgCnX4ADQAHSw83V1rtnsj23tgexh518MjnM40f8d3xX7D4fyKe9JGSAAXcyMgziTL7BzuN1qXTKHK+Xz+xyNr8f0DqaQNCtIozZl5sIGvn3aTFugzfmdJB9Ok8Xls2Ux/xTzAt8EsSm5Xe7q1zMuBDI7U1jtQ5j8Aqrt3Rk36JmHcsr6K5Y8wH76zRPYB4o+ysbvtG7WpbdjC1sMDsyhkD3D5Fn+iryyQc8wBqypSv2dXG6PN5SXzbAQWrN+rqIT6WirolIgMLbtcuNirsL4YHOIBMsBuds9W84bi4qEwlz4M32hyNIolvWVKs33R2/xvTnu/8TbA+joq3fKN9RH6Po2Jq1mPWPeFL0bZ6KZ04X6grHzE4dLgE8GTGlBYibpTJ4Z7PXKU/VLVtS0SQHm2kCemOj8IfSgltHskA4j5+C7wFG0xk2lu0lATdHGJW4eNqH6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261021121427099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yZiDNDzFXa4WBZ8Q6FZrY8yaTNlWNF9jD9A9mq/3/qFG2OkO7anpX06iO1HPLj20c+YhOM+AEZw3YmyPQT4DxyDCl9gsCAjSIQPcLv5V28SJ7+qEUyPb40JjZMVswYlwAL6IqGH3Mb7B/VFMq9wlo3HHeYBhSeG0PHjhHrO8gkWJTA8ugBwqtMprV9zLQbyRg5GgIXLeauGTOQGzQqBSdm7bz+jtZxbJh7CIEUiyY5ywRedzLjQU7lF241bWKvlkO3VoK3XGwYQAGycxTgi78M2nZGbOifOKAyfSY7N6isfBxsM1AUd6LB7C+md2iJBNDTduNWBGQwk+3nlB+pJvktTgpDW8Ff9+/HSZvHaiwlP49CahTDZIVwMDBLli4Pe9EywQlmHo3bg3YEdBxaX4aUCVyZw/0WmErJ4PU0sxwzrGTYVKiZ6VTaZa6W+u0w8L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:29.0993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f832d11-16ea-4a5e-79be-08df3015552d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A gfx engine reset clears the HQD registers of the gfx queues, including
the only copy of the ring position of the queues MES didn't preempt.
MES doesn't save them in the MQD either when the engine hangs.

Add struct amdgpu_gfx_hqd_ptrs for that ring state, and gfx callbacks
for the gfx IP, which knows its registers and the layout of its MQD:
- read_gfx_hqd_ptrs() reads the ring state of the gfx HQD of a doorbell;
- restore_gfx_mqd_ring() puts it in the MQD after the reset, for MES to
  map the queue again from it.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 8dc669e89db5..ba6dcea3f7db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -345,6 +345,17 @@ struct amdgpu_gfx_shadow_info {
 	u32 eop_alignment;
 };
 
+/* Ring state of a gfx HQD that a gfx engine reset clears. */
+struct amdgpu_gfx_hqd_ptrs {
+	u32	doorbell_index;
+	u64	mqd_addr;	/* the MQD loaded in the HQD */
+	bool	on_hqd;
+	u64	wptr;
+	u32	offset;
+	u32	csmd_rptr;
+	bool	connected;	/* the queue the pipe executes */
+};
+
 /* The engines of the GFX IP that can be reset on their own. */
 enum amdgpu_gfx_engine {
 	AMDGPU_GFX_ENGINE_GFX,
@@ -386,6 +397,16 @@ struct amdgpu_gfx_funcs {
 	/* reset one engine, leaving the other one running */
 	int (*reset_engine)(struct amdgpu_device *adev,
 			    enum amdgpu_gfx_engine engine);
+	/* read the ring state of the gfx HQD of a doorbell, if it has one */
+	bool (*read_gfx_hqd_ptrs)(struct amdgpu_device *adev, u32 doorbell_index,
+				  struct amdgpu_gfx_hqd_ptrs *ptrs);
+	/*
+	 * write the ring state read by read_gfx_hqd_ptrs() into a gfx MQD;
+	 * true if the work up to ptrs->wptr was dropped
+	 */
+	bool (*restore_gfx_mqd_ring)(struct amdgpu_device *adev, void *mqd,
+				     u32 ring_size,
+				     struct amdgpu_gfx_hqd_ptrs *ptrs);
 };
 
 struct sq_work {
-- 
2.50.1

