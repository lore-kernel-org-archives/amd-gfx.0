Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA51C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 02:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC1010E197;
	Mon, 17 Jul 2023 02:26:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C04B10E197
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 02:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrDBdAINXbKYDvn5Ro6Cxs6aRkc1lx8R2iGhq8HN+1Ef1PjqHpoPycC+E++P0iIRcOVHrIaEDX2DVypil4ruXZ+GO+/x0SpnJMrt9opDfwVUY7rtrezj/ocvSRnLmMJDSvc8Y8+qQgKCUSzPNX7fuC4x2xBxWvzUPoG50Bm2WbSLmFBWA53A+NJLWjxLE3hcx6gctzCltxchCDLcd3hOTT50+/u3lNeF+gwj2XLXb4yZgXiCbd6/+VxmS3UkD1QOhqR+bmmn87fjtQ8ZkQTkse8zIjAGq7NQQhA0yu4LAO6e4dyzOenQubKfGjFCd5cYxplcHXdTZy6mnIlXANVfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbhHQjEWEE1ssbQj48U/GMR4J6insVxbOzrlaWePUBc=;
 b=htpG+Dm5U/5tJuVIbbzyHbeLq3Z4KBYFb2ivzgEtr72Dc7N+s2ICC18vUje0P6C3MvAHqwxF++1kmpOvjLKXZmIO2QQbOL65P2aezgWcyPosu2b41RU/V4kpbF7sFp8DvD/VwZFcjHhuFdksayZoUF4AnLJkFWMuctgynvRpRAdil/LVcAyIBrB90/CJil12TSpWGphRphVzPf1yVmnBuy9ISQQscCnywZuGbaH9CT47K3vHT7hRHs9qB9yxJeHnYp99D+yLXPAiMqR0XTprFQbKCo+XMIKk5XCLNc2XyAK2v+aJY+QFBfoz4/HQoZFvIC6BXs7zN/UfxUalZF+UhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbhHQjEWEE1ssbQj48U/GMR4J6insVxbOzrlaWePUBc=;
 b=ZYaogU5pr0n35fuDRfLggL1oreHPFZwwRhMVnpxzQB+pQnLAKzphoL6gd8HG3JM2LwYUEBXmgNMN8N9qgDIuuzXdXeezyXYSXnjO9f5tRlo0at9Znb0mxjGePo0szhnqICt/zvvP3U2Tq40UfKjjjBmz0OYlEfc2SCjY8AJNxiM=
Received: from BN9PR03CA0851.namprd03.prod.outlook.com (2603:10b6:408:13d::16)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 17 Jul
 2023 02:26:52 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::38) by BN9PR03CA0851.outlook.office365.com
 (2603:10b6:408:13d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 02:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 02:26:52 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 16 Jul 2023 21:26:50 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: use a macro to define no xcp partition case
Date: Mon, 17 Jul 2023 10:26:19 +0800
Message-ID: <20230717022619.3833601-4-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717022619.3833601-1-guchun.chen@amd.com>
References: <20230717022619.3833601-1-guchun.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: d957fc76-5ac7-40f3-6e0e-08db866d483c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pl8gVe7a7ezFKEvzACd+iTwMDzEx1fz7VGiGxQZ9RGkM+d5eDIC0DiO2Uz4ha9ejslL+QU/hW/W8Az/CT7A08CphZ2SFjwWZeIklHdvYkBq1BvyZ10rVOH1zfqI5mn+ik0+gYfiFsakRtCgcND31qyZNkvtfgraO2dUSjro9XhgbmqeD5SLM6mU+He6Qhc1/Rsb2XHpvRTRGbk0iPpp1ENpdPnPHTAA5JEnqz+mUj3c4MMhgVJC3PnN9vJGtcemSXvQTQ8oeezHn0OA8Rnq0laJZaTDrPIkQHdkfhflugdSz2RN0n4yeEVFX/bdvkU4OVxqOYvbieekaRAPdUvjdphpmeOOOvxdcXRf8+WjhB8goEVG9duMbIlN5mkhqCfQG7+K/LCMDC7MPZcnv72cCJf0twIcK1wh+ZxvHc+odNASJAy2aDtLmszxSUm6vqFuu2aqRCpCAEmCa98wHeV4S1a+l6+SNg5lbubiAY9THlrD7kKMcge0xKfPf+LdyYE19yB9xfOHZ8XYw6/Dx4E71Rrg4/kVj+fcP5Rz1VYJcoYWXuwq2/jFTNiGb9URRNPsQ/MIA+bkxOGF4zwp2bWmMsMsJlWY6Qnt0edioYFz473pWHfkEYOOX/w2/r5+A6virTbZXJ44WlXUWzF4fPOU4vt8MxQZNS9ArAOhJ9uzEJwSfghYPvbqn1ZpP7rPmFY7XLwpLOhxuKG2Ld2gfn2L1A1HT+iSzrlgRljU8ZaIad8HkeyN7EADVQwMi7ZjbkpBLUp6Ivqdxe8MFTo8qGOHKo8HEEfL02f4vgkGcIaP9nX0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(426003)(186003)(40460700003)(5660300002)(6666004)(1076003)(2616005)(26005)(336012)(47076005)(2906002)(8936002)(4326008)(6636002)(41300700001)(36860700001)(44832011)(316002)(8676002)(66574015)(16526019)(83380400001)(478600001)(7696005)(70586007)(70206006)(110136005)(40480700001)(81166007)(36756003)(356005)(82740400003)(86362001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 02:26:52.4065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d957fc76-5ac7-40f3-6e0e-08db866d483c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

~0 as no xcp partition is used in several places, so improve its
definition by a macro for code consistency.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h          | 2 ++
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c       | 4 ++--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a7f314ddd173..d34c3ef8f3ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1709,7 +1709,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
 		}
-		xcp_id = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id;
+		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
+					0 : fpriv->xcp_id;
 	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_flags = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index d175e862f222..9c9cca129498 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -363,7 +363,7 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 	if (!adev->xcp_mgr)
 		return 0;
 
-	fpriv->xcp_id = ~0;
+	fpriv->xcp_id = AMDGPU_XCP_NO_PARTITION;
 	for (i = 0; i < MAX_XCP; ++i) {
 		if (!adev->xcp_mgr->xcp[i].ddev)
 			break;
@@ -381,7 +381,7 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 		}
 	}
 
-	fpriv->vm.mem_id = fpriv->xcp_id == ~0 ? -1 :
+	fpriv->vm.mem_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ? -1 :
 				adev->xcp_mgr->xcp[fpriv->xcp_id].mem_id;
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 0f8026d64ea5..9a1036aeec2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -37,6 +37,8 @@
 #define AMDGPU_XCP_FL_NONE 0
 #define AMDGPU_XCP_FL_LOCKED (1 << 0)
 
+#define AMDGPU_XCP_NO_PARTITION (~0)
+
 struct amdgpu_fpriv;
 
 enum AMDGPU_XCP_IP_BLOCK {
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 16471b81a1f5..72b629a78c62 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -68,7 +68,7 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 	enum AMDGPU_XCP_IP_BLOCK ip_blk;
 	uint32_t inst_mask;
 
-	ring->xcp_id = ~0;
+	ring->xcp_id = AMDGPU_XCP_NO_PARTITION;
 	if (adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
 		return;
 
@@ -177,7 +177,7 @@ static int aqua_vanjaram_select_scheds(
 	u32 sel_xcp_id;
 	int i;
 
-	if (fpriv->xcp_id == ~0) {
+	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION) {
 		u32 least_ref_cnt = ~0;
 
 		fpriv->xcp_id = 0;
-- 
2.25.1

