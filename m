Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39D7C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 11:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3AC20721
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 11:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s7t6ljXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3AC20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501026E1CD;
	Thu, 21 May 2020 11:11:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC426E1CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 11:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrkbnZCXkSoSbvHxWWNyalCzk7oJtkykHTVaTS/BGXwhGPhdmW9Sj+XMgtYMAp81k7F8D0D2u3j6AeqwaD7322bC05K9kYiZwzCm06nmA0P447ol0ki6ECvTPQYeWy1pqz/fFxHvveTEaw8euIW4PoBJZSqC6tdjvm3pWfcStsQAhkureRA0ccj9o2NS5Da4JzxKcjvqDlSeKZ1fvE+P8u/p2w1JyK/mHL4btIznk73NCHEtFN0PSvIAr1tIXdqLxpITB8mrRL+JgVbMunUprAioF5Y8BWt+WqRp9pv0nmywiYgwqM14NKRE3xYc2VVBH9M90NZiVh0r3YGyeOsARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0AUA9RJP+I3Bw/De52zJil/tAwqUXveH+njJG7Ts8U=;
 b=S7gDcoACYdvq9oLigM++s6srm+Xe5Q8bUghuD+L4O++pRgoQvyKKHdMfArh/wZGlbe4e3ONDXIWK6DDnZgMcQUBN6lR84NW1YydaFSpK46fwPoS9y0vIGhWGp1cBz/tRnxPXdcmrAeT7OusRpDqcAoHh1b3+Zp+M32KOqQlDAKTq4lzgHsgypwpTmvN1r/yM3sc5fVk5F/EitMVIBautlQcyXkFQG7TIvw/L0qkNB+KyEy+1Mv7DlYiXz7ipNhK1hvDIz3ZM7fLr/NpAlqngsI1HKrUt0IlH28TOJsRxyn1bvog9D4mCd+G+F91oLN/YAWpbm812op5gOqnRn5CCxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0AUA9RJP+I3Bw/De52zJil/tAwqUXveH+njJG7Ts8U=;
 b=s7t6ljXEhcl31RDP6kVqCVn3u0sAnySyxJMjIR05NtowgGKykboDYJ2MTeGoUY3kBKGTsX1nv423j6MqjkSt52uzDCPTB5uPjTXdRq++Jn+3wGuyHWwcbmxRUrlIuSoVby6Up0bH6nxaEl+c3LKPYBbY9Yj3cMCKGtf0rdWNt5Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB0006.namprd12.prod.outlook.com
 (2603:10b6:903:d3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 21 May
 2020 11:11:04 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::8d22:7d25:8892:a09]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::8d22:7d25:8892:a09%8]) with mapi id 15.20.3021.024; Thu, 21 May 2020
 11:11:04 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: change memory training to common function
Date: Thu, 21 May 2020 19:09:46 +0800
Message-Id: <20200521110946.2488274-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK0PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:203:b0::19) To CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK0PR03CA0103.apcprd03.prod.outlook.com (2603:1096:203:b0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 11:11:03 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efa405c8-4680-4459-5141-08d7fd77a725
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0006:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00065CEB7F7E7DEEC2A60F6FEFB70@CY4PR1201MB0006.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5CqY58jMscW+b6belYzTrZLGHw+SofwTWDAO2nH/DdeZpL10tdEYygINu3uTIBLwV3c62jGFxZ1ndjOhbJky8FeQoad/VxXvHp4PNyS7b87n44Ixj6KyYUH0yeIfOwqYTXQzk/XJW1ZKaqfij5cauOxjL+Z7akq6ralMPnWlCVtM3C7TlYm+ixWAmccsQ7PYM3dFl7CeCw9sc9dZo45RH/RaoTtKc6jUO0CvaAMdotmJbCRx9JBs1qZZF5zDYs9CTadIf7yRAj2J/ujcskabmbIToSLN2n518lCHU1V8msoYEZFBWGSYZ15Kqax9kqpHhL18IPNJ5f2LU+KrlxCauEojdeCswRzU06nnK9WFoqrjQLwfGdrLGWKodEkqydccVbbvBIPKACuZgO18dhUqdf2h6oRKICBXFYEimoRH5FjNK7zSxuPMOMpgFaGv2sL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(36756003)(2616005)(5660300002)(4326008)(1076003)(7696005)(6486002)(316002)(186003)(86362001)(16526019)(6916009)(52116002)(6666004)(8936002)(956004)(66946007)(8676002)(2906002)(44832011)(66556008)(26005)(66476007)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: L7iNs6lVxA4waS+WaFLC4FI1EAGkrSNNxjWcfLKSB/PuWdCxLAbdASkVyP6KiHxgnculMNUxClQqxrOtzm/0zoZLYmq6tGGnDkp9fpihxFTYX6H9Ekgf/vX9BSJyT3i+RhkwSiCJT79+rgi3xfrhdxRlfGiocm81f+wCScR59GXjcbCp1eL4QHs0VdaVALWItZg06fSlTLH2ihOYQ8X8ZXyTSzoqqnl6JKOvUoXp4wwWrBgU33SYPEt0STHEIAQNmFZYGLs99YCcm4K5+MCSnzWXYCXSMGX9keFtsoKgjYDjCNthD5IjDxCsMHhpVwB+3QFgLmUtIpvIR1S1+M9gbMv1AWdjU+Mk+21v1DHNAIovbtUiK8TJdCBTiRzXvQXrR/v+KZaPztoQ8n6Y6YxLO2enHuVoZBPKjHTartV76p4FZyuOTd4+NFdQI2EzaaMcC+YVER3ht/Kk5J5Tu48lwkbUNlopzNJTqOs62eFapFRPRVHxSvn6jvJ4GkRQ/XWM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa405c8-4680-4459-5141-08d7fd77a725
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 11:11:04.6099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+l7Vr3VD3hJi5VcpINcoBm8fSlgqPit8pAlZeMgG8XkJejaJzDqXsZ7a42RVOuU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0006
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
Cc: Likun Gao <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Change memory training init and finit a common function, as it only have
software behavior do not relay on the IP version of PSP.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I0a81d3c3cd1813480781876101e9bfb6787bce3b
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 42 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  6 ----
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 40 -----------------------
 3 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7301fdcfb8bc..679d96719410 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -115,6 +115,44 @@ static int psp_early_init(void *handle)
 	return 0;
 }
 
+static void psp_memory_training_fini(struct psp_context *psp)
+{
+	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
+
+	ctx->init = PSP_MEM_TRAIN_NOT_SUPPORT;
+	kfree(ctx->sys_cache);
+	ctx->sys_cache = NULL;
+}
+
+static int psp_memory_training_init(struct psp_context *psp)
+{
+	int ret;
+	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
+
+	if (ctx->init != PSP_MEM_TRAIN_RESERVE_SUCCESS) {
+		DRM_DEBUG("memory training is not supported!\n");
+		return 0;
+	}
+
+	ctx->sys_cache = kzalloc(ctx->train_data_size, GFP_KERNEL);
+	if (ctx->sys_cache == NULL) {
+		DRM_ERROR("alloc mem_train_ctx.sys_cache failed!\n");
+		ret = -ENOMEM;
+		goto Err_out;
+	}
+
+	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
+		  ctx->train_data_size,
+		  ctx->p2c_train_data_offset,
+		  ctx->c2p_train_data_offset);
+	ctx->init = PSP_MEM_TRAIN_INIT_SUCCESS;
+	return 0;
+
+Err_out:
+	psp_memory_training_fini(psp);
+	return ret;
+}
+
 static int psp_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -127,7 +165,7 @@ static int psp_sw_init(void *handle)
 		return ret;
 	}
 
-	ret = psp_mem_training_init(psp);
+	ret = psp_memory_training_init(psp);
 	if (ret) {
 		DRM_ERROR("Failed to initialize memory training!\n");
 		return ret;
@@ -152,7 +190,7 @@ static int psp_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	psp_mem_training_fini(&adev->psp);
+	psp_memory_training_fini(&adev->psp);
 	release_firmware(adev->psp.sos_fw);
 	adev->psp.sos_fw = NULL;
 	release_firmware(adev->psp.asd_fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2a56ad996d83..e19b98d48c98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -95,8 +95,6 @@ struct psp_funcs
 			    enum psp_ring_type ring_type);
 	bool (*smu_reload_quirk)(struct psp_context *psp);
 	int (*mode1_reset)(struct psp_context *psp);
-	int (*mem_training_init)(struct psp_context *psp);
-	void (*mem_training_fini)(struct psp_context *psp);
 	int (*mem_training)(struct psp_context *psp, uint32_t ops);
 	uint32_t (*ring_get_wptr)(struct psp_context *psp);
 	void (*ring_set_wptr)(struct psp_context *psp, uint32_t value);
@@ -306,10 +304,6 @@ struct amdgpu_psp_funcs {
 		((psp)->funcs->smu_reload_quirk ? (psp)->funcs->smu_reload_quirk((psp)) : false)
 #define psp_mode1_reset(psp) \
 		((psp)->funcs->mode1_reset ? (psp)->funcs->mode1_reset((psp)) : false)
-#define psp_mem_training_init(psp) \
-	((psp)->funcs->mem_training_init ? (psp)->funcs->mem_training_init((psp)) : 0)
-#define psp_mem_training_fini(psp) \
-	((psp)->funcs->mem_training_fini ? (psp)->funcs->mem_training_fini((psp)) : 0)
 #define psp_mem_training(psp, ops) \
 	((psp)->funcs->mem_training ? (psp)->funcs->mem_training((psp), (ops)) : 0)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 1de89cc3c355..9ec6e3819dff 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -555,44 +555,6 @@ static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, int msg)
 	return ret;
 }
 
-static void psp_v11_0_memory_training_fini(struct psp_context *psp)
-{
-	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
-
-	ctx->init = PSP_MEM_TRAIN_NOT_SUPPORT;
-	kfree(ctx->sys_cache);
-	ctx->sys_cache = NULL;
-}
-
-static int psp_v11_0_memory_training_init(struct psp_context *psp)
-{
-	int ret;
-	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
-
-	if (ctx->init != PSP_MEM_TRAIN_RESERVE_SUCCESS) {
-		DRM_DEBUG("memory training is not supported!\n");
-		return 0;
-	}
-
-	ctx->sys_cache = kzalloc(ctx->train_data_size, GFP_KERNEL);
-	if (ctx->sys_cache == NULL) {
-		DRM_ERROR("alloc mem_train_ctx.sys_cache failed!\n");
-		ret = -ENOMEM;
-		goto Err_out;
-	}
-
-	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
-		  ctx->train_data_size,
-		  ctx->p2c_train_data_offset,
-		  ctx->c2p_train_data_offset);
-	ctx->init = PSP_MEM_TRAIN_INIT_SUCCESS;
-	return 0;
-
-Err_out:
-	psp_v11_0_memory_training_fini(psp);
-	return ret;
-}
-
 /*
  * save and restore proces
  */
@@ -820,8 +782,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_stop = psp_v11_0_ring_stop,
 	.ring_destroy = psp_v11_0_ring_destroy,
 	.mode1_reset = psp_v11_0_mode1_reset,
-	.mem_training_init = psp_v11_0_memory_training_init,
-	.mem_training_fini = psp_v11_0_memory_training_fini,
 	.mem_training = psp_v11_0_memory_training,
 	.ring_get_wptr = psp_v11_0_ring_get_wptr,
 	.ring_set_wptr = psp_v11_0_ring_set_wptr,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
