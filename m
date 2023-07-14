Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0323CEB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 11:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F4D10E87C;
	Fri, 14 Jul 2023 11:41:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1A010E898
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 11:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb2IvCqEju+MOjfxhbVBQNCt9Ylzr4OH5zugMZ+IJ2Iepcrj33NtKRf30+80gpB9q9WGR7qSDPwFd8lLeBtNKW33Zf93wxRURGlW3jmgYZRobh2Hz6MAk6gR5z6EAAjC+t8FvzZiYSRauKr1V3Bi5f1MqkLyaGJ+secPCf2vT2almFT/CmTSKu1skgHpWJlcKzeW2134rkS7oleyl6e/yZuMnQFtjS3+aOb4EXcpEtsOUBa0B+TiaUt+zkNd9tfin9/wYKps34zvxFeixGJlMg/jZRdXwe3gl9G30ArRLyeDRnLys+3cwSgafCRgGGdM0l2VsopXIwbWlwEshe1rWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbhHQjEWEE1ssbQj48U/GMR4J6insVxbOzrlaWePUBc=;
 b=SC31AlpJw0UcUgEVaCfHwePd1Yyqp4Jq6cdFqfSOuxdnO7bunzzukycLCwBB+iwGO/Ph+szOM3rY0084UXgFopHitm4CP5/Ky5xrw0r6VWyJid+6YpP/UYMHzL3cv3vT/D22sH9Vd5DB7IXiYxjKqijNecB1UpyEIlQNYCHWbsE616v61PsNPZQ0m7HzEMNHq23C7s6eduF4oKKI4P7tC3TFPxze28BVYK8puWJLWQJuFy+eBPoI+svptSKultdqsUD9UyGb+Q2WmtZ7FXwE3Hpsi4r9S/JtdX/XJ+WRgnEdCnS33NYNSsi4kvA0fzjjV9y+pfA/AzTXvl/sSaRGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbhHQjEWEE1ssbQj48U/GMR4J6insVxbOzrlaWePUBc=;
 b=vve/s/aJq5/SgYrR6K60uhJrRjqyPIclJPnyqDxlVqpobtYFMChejCvx7z56+juVeiMbf0O9EHOmfsHncMeFbEMOlQrPPYe7Zu5bQU9wn+A7ow8d7Yz9gW7xx6WvL3KWYsjpZmoQhA34QKygQdYxmfdTQl5ettQ6Mixf+JDMNYg=
Received: from BN9PR03CA0080.namprd03.prod.outlook.com (2603:10b6:408:fc::25)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 11:41:52 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::56) by BN9PR03CA0080.outlook.office365.com
 (2603:10b6:408:fc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Fri, 14 Jul 2023 11:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.27 via Frontend Transport; Fri, 14 Jul 2023 11:41:52 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Jul 2023 06:41:49 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: use a macro to define no xcp partition case
Date: Fri, 14 Jul 2023 19:41:29 +0800
Message-ID: <20230714114129.3711251-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe06081-01f2-4bde-829e-08db845f511d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDHG5vZSKdiZh+5QRA0dDNFC4DVioS1ORiQS7ZMmXmrK9YvkCiVBV6sGQQB1jDkdmWrGJoz9pz8VKLVRBGrfIay7QQ3LPNQMThM5bTvjADPrDpUt71kcRwdmpUCMWENHrFJ9HNzkp64ULmSnipuq7Pwe8fBNh7vNuVh1D5oGx/rrCmQm5RoRMWmXQYUaiymwrf9KPhs/FPVVfB9kZyGxlALX0UiAHRAopCbV8sKbp4Mg4+3UG9I2LEvKSwKNMNZcjss1B1JuMkbJd61JlfEFIg4nNFI01qgsdtVcGTqWYwRsCS5K3ydynUXzZhxIU8LvLiaoiQ1C1SURKMpUpfhGb35UhU/e3kBN4anbPiKWijKwHZEVkochpnQ2OC/dAqdF37tGaq48JXM1pmKXC+mKZVJDgO4QURDmYxTB1ti2go2t2MBylXZ/1RDCCmzowySFXnrmzqRreaQM3oPoFwexq/yoQkUkJPA1FyOZowKloGFcSIcRzuMwjyPtVQRCcW5FnQVNsWFcxvZT07ArQOPwd8Q4/I9Ylu5VZUIwaKEtp/Bm1D0y9w5hYp75uMYM5cW0gYUBl/M9IMiRzSRfFsL1+KGPmrB0bE4Fy5+C1HoNrc/kgjI9MlC+4d6AV/OESOc0YbyNNisUsho69X2Q+4ulbCeucP3iIf6OLPCMAj8O62rL0z8sxqrFkbN0af64YthLleut/h7zWznuxlvpy62iizhwJyxK+Uw8/y34bS6dmXSribWBfiFjfc1MSpjPSOWYsAFNYNqiM7eOr6YHMeC0WRJEHTvxYnmkXWg2ZuiWAyQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(7696005)(6666004)(110136005)(36860700001)(426003)(47076005)(2616005)(83380400001)(66574015)(86362001)(36756003)(40460700003)(40480700001)(70586007)(70206006)(2906002)(82310400005)(336012)(26005)(1076003)(186003)(16526019)(81166007)(82740400003)(356005)(6636002)(4326008)(5660300002)(316002)(41300700001)(8936002)(8676002)(44832011)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 11:41:52.0246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe06081-01f2-4bde-829e-08db845f511d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093
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

