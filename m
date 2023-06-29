Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F0CEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 22:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B19010E3FB;
	Thu, 29 Jun 2023 22:30:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D69110E3FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 22:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiVRiHLsETCQx3JXE9U+dWdB5QIbiSMlhqM1aeTtBC8LZsKx8RMIFhgK/SN1vyDggg6KsQJhTQKUAfv9xzz6nwKG1MbnEgK7+W5RbzoxY2/p48ft2NNnbjX7maWnI3UOfGxaufz/9sn8sbbA+o9g5BSPCmGDPuZR0SvHltW+Hj/pSjNifWSVu07bEHR+Ux938NgIfovRYYM8VNn77QxZf6UaAh1USvL9DNiVesJECFc5W8o9oaIiu/v7dF9lLFhXmlSGYlLszA+UF/9q/PFmhwnbXjhgqXuh23qGUVdR9roUoVoKhC1589LX0cjIlG6+gkpxSZPxRJuERhqYP1bp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJjUfWeE/ACeswnlhK+X0NmnBSyV8TMK0wCy+Q4jRTE=;
 b=CfDOSDK1MR0zRGk1yoOXdKL62+0/+NHSi+WfeUfAkj4sfZ8qU3wzhKEEAjPO+XLhD5XygKxU/xupvsAWyK9Du/yF36+mD9AfatVENNbxhCOT6l3kbUU9SsPfzSHDsdO6RbJ6JEKgQeitw1epfUm2UCIrbqfrFtLnyGIwKoC9NLdFolTSTL6qocRo0UHDCJPYVIckrPib2ZMCZoIcq1WVfCF2k/XY28lXFnviCiwgT5ybnpapmkKNzlRBLFgJybYD2SdlLatGf+tGUCQ7YwlNWPMDQgiIdEwqb5prYjyCY8a0ru3KBWzRSKIP4TXXlhpitHPmrhWyqAxDpuNUvP9cIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJjUfWeE/ACeswnlhK+X0NmnBSyV8TMK0wCy+Q4jRTE=;
 b=ilQjUMneHW1PbqapeXbjmCPnIA8QKaBsXqBYQR5Y/Jgki/+7GyWqoloRtY8O5RjGEC5KXe+OhcvauX6+mlT6twEU1vLA8csGa1kqq/4aDSk/po4s51LSfnbdwV3Z3i3Xla1xsFjxohCoKNNRFCRlyziFANUJzxZmcg79+lCcFKY=
Received: from MW4PR04CA0085.namprd04.prod.outlook.com (2603:10b6:303:6b::30)
 by BL1PR12MB5303.namprd12.prod.outlook.com (2603:10b6:208:317::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 22:30:16 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::4f) by MW4PR04CA0085.outlook.office365.com
 (2603:10b6:303:6b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Thu, 29 Jun 2023 22:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Thu, 29 Jun 2023 22:30:16 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 17:30:15 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Skip handle mapping SVM range with no GPU access
Date: Thu, 29 Jun 2023 18:29:26 -0400
Message-ID: <20230629222926.9078-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|BL1PR12MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 339ddcef-8c30-41de-edcf-08db78f069b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nG3maJ0ycAn5y9ft8GxuSuDuxVtKLyMNXCsOBzHJ9QFcDP2PQi63QfQ4AA92zds8JJ8UGh8p1bUjcA5j/6lGxetjp2sh9Q+JA/rpVTHz9eA/jaZvvfeOJjuWTXR+IwKGiNTfcUf9fGbrSZ/i+8IvPpUBX/WErTNPn/ybCBwuf2POx4C/N0OWkcsxVDR5i8hOiQxzFpNnzh/El8giiLPdab46TRhEVH7tK/mAGKebx+/5QnAiUDR/F418m7zATMmSGpGfek26oXwVmK58aZwslqQ/n7EAlsFgPYgHWvUhPf8I3ckc0wHL+bIzqF+D7hwmdQoL3bVpx2RC5Co+oFrK03WlWl71OM2yE1DhD80o1tH5+UKSuu/qtvmUKEREpSG8YVG51TvGifBkJ5AIkokS5fXpwP5OOLSkzFX7RZHny+JZNfq+dPyl1FGTzEYcT8ttPfv24Ug4zb0Vo45/IJQFSNXIZzI3ydz2pXzIPClWeZv9kDtHjNhRNkwHX5Op//28wtRfMguXF9TbzYJ4n2liq+MxG8uzR2tCANMkgAq7bLc6i8UptCv4Q3NPsPUEsUxiFr73cso3A8MiDDb2eF7R2LO42SlHgJo0Pq7BCCGCccLzdP/SWS6OhXolQE+QI5bgQjbFu6guqyKUUXyH0R6VElVrdA8/td3/vdETesBCKQ6r0i8exXZKRHC3jzpZiTZgqMPN7mp5kYxU+g1M/IhIHKjoA18JqOQvwTmg9+gQ4IJSlPh+aM3YJmUVMYiaMKOCP7XbMl3TobbiFjc9Y8cVzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(36756003)(82310400005)(36860700001)(70206006)(40480700001)(81166007)(82740400003)(40460700003)(356005)(86362001)(5660300002)(316002)(41300700001)(6916009)(8936002)(4326008)(8676002)(70586007)(47076005)(7696005)(1076003)(2906002)(16526019)(186003)(83380400001)(478600001)(26005)(336012)(426003)(6666004)(54906003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 22:30:16.2706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339ddcef-8c30-41de-edcf-08db78f069b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5303
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
Cc: alex.sierra@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the SVM range has no GPU access or access-in-place attribute,
validate and map to GPU should skip the range.

Add NULL pointer check if find_first_bit(ctx->bitmap, MAX_GPU_INSTANCE)
returns MAX_GPU_INSTANCE as gpuidx if ctx->bitmap is empty.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5ff1a5a89d96..479c4f66afa7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1522,6 +1522,8 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
 	struct kfd_process_device *pdd;
 
 	pdd = kfd_process_device_from_gpuidx(p, gpuidx);
+	if (!pdd)
+		return NULL;
 
 	return SVM_ADEV_PGMAP_OWNER(pdd->dev->adev);
 }
@@ -1596,12 +1598,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	}
 
 	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
-		if (!prange->mapped_to_gpu) {
+		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
+		if (!prange->mapped_to_gpu ||
+		    bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
 			r = 0;
 			goto free_ctx;
 		}
-
-		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
 	}
 
 	if (prange->actual_loc && !prange->ttm_res) {
-- 
2.35.1

