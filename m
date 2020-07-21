Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF042C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D9320714
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0JrKRcII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D9320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C7CB6E4C7;
	Tue, 21 Jul 2020 10:29:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F7C6E4B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 10:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQyYb14mkcxe+LYcRxFGeg6Pd1u54+Uu22+lNDhXwHEiroVY27CrqVyv7Ku0XXM2Imw7LdgGOLpJ9XiN2HlS9ojKFilHIrrqnYMy4WFU9uLjw2jC6AavezvrLXsodQdF371+vsbEJDSP7U+oIi9Da+osrq+UfMmGMYiXSRjQYeObhn4geGkOPJKwrSh5rc8fMKi5czu9okhukpZHD74pNDyrtVdtMN1naOJgzEWay3LNQKyK68ZhwIzslmn0Ji1Yj9Wv8oGX4Y6ZlAm8mZIshDCiL8p8MfX5hF2RGSM77NphTeLjFBK6XmyQFL1G1vCxYEWajXNOKqwxENTxqY5C5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPVjiRgMArROULz9GycFxM9EmeWQk/LRDIFR0lZYSAg=;
 b=Mh5PftGPeLvMAF8nmB2RA5jo0uFQERDy029UcgLVAjCmyp3khV8Bcou8KUBrrZ/UzuPyT8NrEwFDSeEC2Sh9v+Vybn5rjpRfpsRNrANZIBVkECFq6Bx2FItUpWBTXbjBszHuNcBLqJT2H73TyxQFRzNilLWKi5TrElCguBPwV2KhI+UiR+NKPq96XJtJSX3cj0y4O/u7hr+ndpUSfRn53V2tpz6V4/gEd5IVXoNTd84H/tnX+6IySvlv3aq14Eqj0skz3B5Xu4j2OtVf59tULvy3wm1MgaUVXvvXhbMpj01p3Wd6SNohQjTzYhj8/OUfOAnXikq0FYXCgVX9qbJ1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPVjiRgMArROULz9GycFxM9EmeWQk/LRDIFR0lZYSAg=;
 b=0JrKRcII+YBeuS0GP5Zo4xS/EsbX5a7PgKPiLrY7/ysFEDG+HRmnAGGfXdEeOb7B+WkFB1bUveCe54MuUPPXMnB+fzH9f0h+hwXhkQwxbWCEa9v64SesYk+lqmgsud+ZZF7Ab+qVGxdFwWo7zmtzv42ULsvQAjGFqteMquGJa54=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 10:29:42 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3216.020; Tue, 21 Jul 2020
 10:29:42 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: move get_invalidate_req function into
 gfxhub/mmhub level
Date: Tue, 21 Jul 2020 18:29:18 +0800
Message-Id: <1595327359-120379-5-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
References: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (58.247.170.245) by
 HKAPR04CA0008.apcprd04.prod.outlook.com (2603:1096:203:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 10:29:40 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b65fdc53-1080-4d6e-07d8-08d82d60fa95
X-MS-TrafficTypeDiagnostic: MN2PR12MB4144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4144A4F955509C78BA98CE1DEC780@MN2PR12MB4144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dW42N6sIVHgEnmT1VFdPbmqKO52cxOh/y0zayrphF++/Zn+QDM2JoVRJwvzkqern1ZenkXtEQaBlzvTSPZBdq1EYU0klT1FgfiHRwrPpoWatK9cSE5Qh7WgMeHNRuaV5c5LTgh/tI+eDOhYkdWk/hByLi34KorcUxIiQsLwROjrPOVNMOhrYEbOn2VBTnGxV8OeDX+Pja83phlmaH37Qw3CCwjq/BtGFyVH4IdIV/E7pIP1Pvau0Es6K6f9rpRbH6Z0DEa33BhVZdBda9jUlinZt4wM2/eGVk8AIRo7w+DgFPnzanGd6tUDpRYsnkeOYym0OTciXESwgi+fOY9DL4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(956004)(2616005)(7696005)(26005)(478600001)(16526019)(186003)(4326008)(52116002)(19627235002)(6486002)(6666004)(2906002)(66476007)(66556008)(36756003)(83380400001)(5660300002)(86362001)(66946007)(8676002)(6916009)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fYqVqWMasg8IDBksfGXh/m5YH1uwaHzhpn+Y1wRaptaZStajAILBbsXDq1CgAvkLm8cCe0oNKkmsRX0XaSk2odXsi3NSQcFVD4xfaAvIx2hPNSqod3TQK2+7EQKKlV8hW+xMrSDx55WzmkAtOk+csdwGZCvcyWpCDtHFshY+2tD+dSebhNbI5Xzd9f9AB+nTrJUToyr38QPZco+0vXlAdllMZ9RNAYMoIbOFP1BPmwg6R23cf3Qu87Ms4N2E1Fb64/4vhgzmAZ4gNKRZV4r4yHgruUJcjZ1t4tveQWXlhivOiF4bzz2NTmHE9iVe72BKzP4VI0id4upYoPGhT6sgBDtE9nDNgpNXvJAdrShGJSbwD7IcNwq6zhPJH/eZ0ZyE4XEshACOAVVhQxnahW8oaO4d4nV9wa+uQbyMoXxvEZulOoEuY/O5YIhfxi+crDWrP7iT6IWTVne4lrifpLl8LtBsmTn2nS+qMBdNuWnUoGxCizQ+ZHJBFOYX2PHY+WPL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65fdc53-1080-4d6e-07d8-08d82d60fa95
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 10:29:42.1823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZH5T9olthJ62w9j8vxSxSKrflTaggr1JsqkJmdsVRItj0wbQMLXWXaBLqRB4KNZofPBhlEF6B5NkjnebmesOLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to move get_invalidate_req into gfxhub/mmhub level. It will avoid
mismatch of the different gfxhub/mmhub register offsets and fields in the same
gmc block.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 26 +++-----------------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 21 +++++++++++++++++++++
 5 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index bbecd87..9d58c56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -77,6 +77,7 @@ struct amdgpu_gmc_fault {
 struct amdgpu_vmhub_funcs {
 	void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
 						 uint32_t status);
+	uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_type);
 };
 
 struct amdgpu_vmhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 14268ea..5294f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -31,6 +31,26 @@
 
 #include "soc15_common.h"
 
+static uint32_t gfxhub_v2_0_get_invalidate_req(unsigned int vmid,
+					       uint32_t flush_type)
+{
+	u32 req = 0;
+
+	/* invalidate using legacy mode on vmid*/
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
 static void
 gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					     uint32_t status)
@@ -389,6 +409,7 @@ void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
 
 static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v2_0_print_l2_protection_fault_status,
+	.get_invalidate_req = gfxhub_v2_0_get_invalidate_req,
 };
 
 void gfxhub_v2_0_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 45fbce7..e7850f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -31,6 +31,26 @@
 
 #include "soc15_common.h"
 
+static uint32_t gfxhub_v2_1_get_invalidate_req(unsigned int vmid,
+					       uint32_t flush_type)
+{
+	u32 req = 0;
+
+	/* invalidate using legacy mode on vmid*/
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
 static void
 gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					     uint32_t status)
@@ -388,6 +408,7 @@ void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
 
 static const struct amdgpu_vmhub_funcs gfxhub_v2_1_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v2_1_print_l2_protection_fault_status,
+	.get_invalidate_req = gfxhub_v2_1_get_invalidate_req,
 };
 
 void gfxhub_v2_1_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 8f35e13..a1798ec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -139,26 +139,6 @@ static void gmc_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gmc.vm_fault.funcs = &gmc_v10_0_irq_funcs;
 }
 
-static uint32_t gmc_v10_0_get_invalidate_req(unsigned int vmid,
-					     uint32_t flush_type)
-{
-	u32 req = 0;
-
-	/* invalidate using legacy mode on vmid*/
-	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
-			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
-	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
-	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
-	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
-	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
-	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
-	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
-	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
-			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
-
-	return req;
-}
-
 /**
  * gmc_v10_0_use_invalidate_semaphore - judge whether to use semaphore
  *
@@ -199,7 +179,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 {
 	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-	u32 inv_req = gmc_v10_0_get_invalidate_req(vmid, flush_type);
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
 	u32 tmp;
 	/* Use register 17 for GART */
 	const unsigned eng = 17;
@@ -294,7 +274,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
-		u32 inv_req = gmc_v10_0_get_invalidate_req(vmid, flush_type);
+		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
 		u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
@@ -425,7 +405,7 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 {
 	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(ring->adev, ring->funcs->vmhub);
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
-	uint32_t req = gmc_v10_0_get_invalidate_req(vmid, 0);
+	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
 	unsigned eng = ring->vm_inv_eng;
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index fb634c1..749719f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -36,6 +36,26 @@
 #define mmDAGB0_CNTL_MISC2_Sienna_Cichlid                       0x0070
 #define mmDAGB0_CNTL_MISC2_Sienna_Cichlid_BASE_IDX              0
 
+static uint32_t mmhub_v2_0_get_invalidate_req(unsigned int vmid,
+					      uint32_t flush_type)
+{
+	u32 req = 0;
+
+	/* invalidate using legacy mode on vmid*/
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
 static void
 mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					     uint32_t status)
@@ -380,6 +400,7 @@ void mmhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev, bool value)
 
 static const struct amdgpu_vmhub_funcs mmhub_v2_0_vmhub_funcs = {
 	.print_l2_protection_fault_status = mmhub_v2_0_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v2_0_get_invalidate_req,
 };
 
 void mmhub_v2_0_init(struct amdgpu_device *adev)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
