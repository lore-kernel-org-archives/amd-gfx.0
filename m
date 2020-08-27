Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32781C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 15:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30EB2087D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 15:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qt2fyJp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30EB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4A96E093;
	Thu, 27 Aug 2020 15:15:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD046E093
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 15:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrTi/2m1odx8m5SFqOyH5EaHxc7eG/iE2wXtS8vuRZqhkdfqfUBsNI04rauxBdrCodfeT4a/C1BES7efU4FPvCRtbNoOQJhqDE54OMbS6JVSlVF1BJF/ODPt8ND5HoZ+dNjmx8MXUgPY2IMzrrb5xDFHIs8UEWoKFvaEESrdBp+EibvI6G3yoEsOBZcDGoT196nAc4HkEJGXIssoqM5kCiCsl653Ot6X57G9wo1htN1kDmiHCgpSzoSNhbpVbneSiLiHUk+NLzxXy9x5gNB1HmFEPFxjXHzi6tUieQK3Cox4HIPyjjvakL7GrUYmT0GuYzTETN5V7cSL67ZIQsJT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lkyjpx3IgUE94avJBXjzwiRpvvBBwCyJA/ykSnLdhRU=;
 b=MbPQu3hkbVLiOCc7ixzMXknzV49AI+vbDdqU/9CgSPzrQHSnQljOx8q5BvOe4GtKCCdtipaZ4PUkpJCHJvTccIni9d7VeN/mkJmp8howEU0TJRlZd8Ni8UfjVQLYRWJkFnJeXFY0vRNtiiI6uLTX4l0xWfpwSGlLP2SpgL/BfcLetv/uHguF392Q8DNNzsiKyWeve1lZc/YhgAkhjlwgms8gbVLPEar7d6j5PUZvDd/nd54M3vCM9l4MjtB2R5ql2zFInoVj3U4L/eKu5Qm5ldY0xWO9tVaDG9znCzZM/OgZFNlBiy2sAFgtsE71XyJMVL6GIHNovuZzHBWPTUOByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lkyjpx3IgUE94avJBXjzwiRpvvBBwCyJA/ykSnLdhRU=;
 b=qt2fyJp4GkzmT9Kav6WIWLz8OczrLTrSgioX8vmTfPMoHEhToljNqJyzVCIPxHE/Z3/nM1JsSCE7z+uPQN03fJhCmdG84V8e57a6Pt8bUcQci+7gQA3UwgrYbBkzA/qAMyXJovQEmixQAIsBEC2IHRsDi70SEMOY+gY6LjVCt+M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3785.namprd12.prod.outlook.com (2603:10b6:5:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 15:15:13 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 15:15:13 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
Date: Thu, 27 Aug 2020 17:18:58 +0200
Message-Id: <20200827151858.55326-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: AM3PR05CA0112.eurprd05.prod.outlook.com
 (2603:10a6:207:2::14) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM3PR05CA0112.eurprd05.prod.outlook.com (2603:10a6:207:2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 15:15:10 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2de42d9a-b660-456e-684f-08d84a9bff12
X-MS-TrafficTypeDiagnostic: DM6PR12MB3785:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB378534FE05A7075EA40DB6EF8B550@DM6PR12MB3785.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: el5Gy7mR7xUW8fZOKOq1w4dC5LAsqeaiTm0rjX86IrJbjoB+wvgIQ5ZkP1v5IOhuOHiqQ9SwLaDV2isHlZEbAf8ag9Ov3tuVflax1KM8FKgf3yD5xktDJWeL6upPsp4p6peXHfYHKhIio5RaGAk26lZPSMykccbnetMkjlAgRcNKVf7nvkJ3L5ofIc/cM550EgOmqWF+DJ7DzsYsaR+CAD1OJAqi+ZJxDgNt4uUsYRwBKfAnYcVgBaizM06UEqJSS25UOv3D6vIV7PLltbTrJbxLGmeNiTcIm6fNRn6LXX9v8J4kgOMkkT5zCR4eaQCl18+WGpk2SFL6KpOlRgj+Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(83380400001)(478600001)(5660300002)(186003)(86362001)(44832011)(956004)(8676002)(2616005)(66556008)(66476007)(26005)(66946007)(52116002)(6486002)(4326008)(16576012)(8936002)(36756003)(6916009)(2906002)(6666004)(316002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DToNgIj9dXQhgqAETpVv8+Xg5Cf7u1DAmf+nnwdBsGOC/dXJpbGVOzgP/sN9dgmevMjs/u6jBUPr/H+LdIK5Qeq8s4SdYHyxfnr72Ekw7n7WYV4GHdBpa2LcoXD66SmVCQuSFfkHM+J3apkvV/Dar7bevDeluY7pozoA8W/N+3ggfVpB0gtfo5s3psj1Ahd8E458R/7vzAgByFgxLgJy6NCHArv058el2r/+in4QKEi4bpJMREq5AaPfKqowLzBF3L/7zxpv7ID+2OrgskREomYtNturBbc1CUZCT13RRtSCs3Gdmu1p6e6E5AhUdS5OSXqIoZY47CMKSqeLIzjzuWJ7CSkUbSYCwc2tChq82ELJgueCby9BXKJlTJ1RwF9WKCZopK7bZw4EyCNJIu6eE9KX/deIwt0fWA78DcuB4T0+TnhNo90J/ZzuLLWYH5mWSCMxUVBiwx1VHsKvXP8GsJKXj7WbEIrN9PWNnV5rMIjmaEMbtFJwmAqVdUt1DLO7rSAnAfvnUSTS1X9VnFOeEyQBqxBBTgMlvmVKTpAuLgnW+sGRa4HpNl15/ATkSkyY7mq45CYVmiLB1Y6uh0ydeV4Dvh1BuwSre2JSzRlF+yIZC/Ufz7DFSEIAME13PJvZIkfFNZbYtuZ3gWF4ZAXGQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de42d9a-b660-456e-684f-08d84a9bff12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 15:15:13.7665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7jywx4LyeQ+9ce+efy8AFgbMfQhRGmi0eAqKI0+zf8yowKgUt5GfjMw7kD49TAsyO6AXGgCFtt/Vbuc6W9LMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3785
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
Cc: alexander.deucher@amd.com, Emily.Deng@amd.com, Jiawei.Gu@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, Monk.Liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch removes some unwanted code duplication and
simplifies sriov's ip block reinit logic.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 117 +++++++++++----------
 1 file changed, 60 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 696a61cc3ac6..0db6db03bcd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2587,77 +2587,80 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 	return r;
 }
 
-static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
+/** amdgpu_device_is_early_ip_block_sriov - check for early ip_blocks
+ *
+ * @ip_block: ip block that need to be check
+ *
+ * Returns a tri-state value for a given ip block.
+ * If an ip block requires early reinit sriov then return 1 or 0 otherwise.
+ * Return -1 on invalid ip block.
+ *
+ */
+
+static int
+amdgpu_device_is_early_ip_block_sriov(const enum amd_ip_block_type ip_block)
 {
-	int i, r;
+	switch (ip_block) {
+	/* early ip blocks */
+	case AMD_IP_BLOCK_TYPE_GMC:
+	case AMD_IP_BLOCK_TYPE_COMMON:
+	case AMD_IP_BLOCK_TYPE_PSP:
+	case AMD_IP_BLOCK_TYPE_IH:
+		return 1;
+	/* late ip blocks */
+	case AMD_IP_BLOCK_TYPE_SMC:
+	case AMD_IP_BLOCK_TYPE_DCE:
+	case AMD_IP_BLOCK_TYPE_GFX:
+	case AMD_IP_BLOCK_TYPE_SDMA:
+	case AMD_IP_BLOCK_TYPE_UVD:
+	case AMD_IP_BLOCK_TYPE_VCE:
+	case AMD_IP_BLOCK_TYPE_VCN:
+		return 0;
+	/* invalid ip block */
+	default:
+		return -1;
+	}
+}
 
-	static enum amd_ip_block_type ip_order[] = {
-		AMD_IP_BLOCK_TYPE_GMC,
-		AMD_IP_BLOCK_TYPE_COMMON,
-		AMD_IP_BLOCK_TYPE_PSP,
-		AMD_IP_BLOCK_TYPE_IH,
-	};
+static int amdgpu_device_ip_reinit_sriov(struct amdgpu_device *adev,
+					 const int is_early)
+{
+	int i;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		int j;
+		int r = 0;
+		bool init_ip;
 		struct amdgpu_ip_block *block;
+		enum amd_ip_block_type ip_block;
 
 		block = &adev->ip_blocks[i];
 		block->status.hw = false;
+		ip_block = block->version->type;
+		init_ip = (is_early ==
+			   amdgpu_device_is_early_ip_block_sriov(ip_block));
 
-		for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
-
-			if (block->version->type != ip_order[j] ||
-				!block->status.valid)
-				continue;
+		if (!init_ip ||
+		    (!is_early && block->status.hw) ||
+		    !block->status.valid)
+			continue;
 
-			r = block->version->funcs->hw_init(adev);
-			DRM_INFO("RE-INIT-early: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
-			if (r)
-				return r;
-			block->status.hw = true;
+		if (init_ip && (ip_block == AMD_IP_BLOCK_TYPE_SMC)) {
+			r = block->version->funcs->resume(adev);
+			goto show_log;
 		}
-	}
-
-	return 0;
-}
 
-static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
-{
-	int i, r;
-
-	static enum amd_ip_block_type ip_order[] = {
-		AMD_IP_BLOCK_TYPE_SMC,
-		AMD_IP_BLOCK_TYPE_DCE,
-		AMD_IP_BLOCK_TYPE_GFX,
-		AMD_IP_BLOCK_TYPE_SDMA,
-		AMD_IP_BLOCK_TYPE_UVD,
-		AMD_IP_BLOCK_TYPE_VCE,
-		AMD_IP_BLOCK_TYPE_VCN
-	};
-
-	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
-		int j;
-		struct amdgpu_ip_block *block;
+		if (init_ip)
+			r = block->version->funcs->hw_init(adev);
 
-		for (j = 0; j < adev->num_ip_blocks; j++) {
-			block = &adev->ip_blocks[j];
+show_log:
+		DRM_INFO("RE-INIT-%s: %s %s\n", is_early ? "early":"late",
+			 block->version->funcs->name, r ? "failed":"succeeded");
 
-			if (block->version->type != ip_order[i] ||
-				!block->status.valid ||
-				block->status.hw)
-				continue;
+		if (r)
+			return r;
 
-			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC)
-				r = block->version->funcs->resume(adev);
-			else
-				r = block->version->funcs->hw_init(adev);
+		block->status.hw = true;
 
-			DRM_INFO("RE-INIT-late: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
-			if (r)
-				return r;
-			block->status.hw = true;
-		}
 	}
 
 	return 0;
@@ -3901,7 +3904,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	amdgpu_amdkfd_pre_reset(adev);
 
 	/* Resume IP prior to SMC */
-	r = amdgpu_device_ip_reinit_early_sriov(adev);
+	r = amdgpu_device_ip_reinit_sriov(adev, 1);
 	if (r)
 		goto error;
 
@@ -3914,7 +3917,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 		return r;
 
 	/* now we are okay to resume SMC/CP/SDMA */
-	r = amdgpu_device_ip_reinit_late_sriov(adev);
+	r = amdgpu_device_ip_reinit_sriov(adev, 0);
 	if (r)
 		goto error;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
