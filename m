Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93272C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 14:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2264F89C19;
	Wed,  9 Feb 2022 14:30:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAED089C19
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 14:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOidFfHPklBW+foui87TIK3mjp2a9sLNfb66UIQXRgr3pFjRjsnELJvUdkYlOrEXxpafVCO+qqfdIMjuCK+jW21wnRT9tCCmN/t8hqO4Zk/eBc8R5llWtlPh9sO3VL7e23QOVhyKL6S2y8QosIHWAZzv/cx+c+2RzPAQpyAr2mIY1uqyEpaE6mWr8PrZ0Q5TTI8GLjHCpZjhp8WcaS77rkoGh4Q/Ug+/RYaiyyWA/jtZY5ejs6gx2K2kXubsV/i70bAMjtaEaO/guxhTgC1HNNJdCEr6aWRiJWnPAIZtJusz3ho4BZhyjvJKyZyrkKwVvUyUDZF6nVwNyDYNDcmutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yOa8L1glbjP3QbplqfFAQAtnxhxmidmqbaE5+6DWrU=;
 b=JI3J6u0q0kUKQ48EWXnPJQFg7GPHUzcMYfMTqTj1bOMdE4E/uIz26dCWmnsDBULnzPWVxgwIUwRZeuYjNtZ3L9SQkePTvbfPQt7k7o8WwL7Ugp+l+bZOu3/8VtECthc97kMv6ShGSog2grfWDHEnuWNKiVZuFLbdwYTBNXUpJ1N0qnPpUjLgEVtnCPl96NBrJSIcERC+iEjRBBE8q6ef3vTduF/tEqIoQoS1AN9PdATyn1qTdsgG4C6vJ45V0wewuynfu7YleTKYgkTHhuXxKkFeZs5ghKY/Xkst9jKy5hq8Zf4Tv0M7BzMsxRtvRn3SWy0waXkRLqgfGHiGwGH15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yOa8L1glbjP3QbplqfFAQAtnxhxmidmqbaE5+6DWrU=;
 b=p248NnXmUs2CQYYd9GsDy1zVGK0UjbcXzk65O/BJgBT+gZ5V0VmsG8FoM5D8fJ3/e2ZTfa4TLT07KHRc3nM2TWkq15TsdlCt3a+UHQIkz03KAqQoNlHQ/rGhGLVe6eQmro7K+kq0sevf964xqjYt1hQIAkjXbvzKBnI4L1cOnpk=
Received: from CO1PR15CA0109.namprd15.prod.outlook.com (2603:10b6:101:21::29)
 by MWHPR12MB1952.namprd12.prod.outlook.com (2603:10b6:300:114::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 14:30:54 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::44) by CO1PR15CA0109.outlook.office365.com
 (2603:10b6:101:21::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 14:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 14:30:53 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 08:30:51 -0600
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix gmc init fail in sriov mode
Date: Wed, 9 Feb 2022 22:30:22 +0800
Message-ID: <20220209143022.1437127-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe5af29a-78c9-4d47-c2b3-08d9ebd8c777
X-MS-TrafficTypeDiagnostic: MWHPR12MB1952:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1952D1CA4A731661A8F1BBF9822E9@MWHPR12MB1952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8If//yZ3FmtQUVdhDM+9F7jufOGAb03B47UEhRZPL7/bFZ8V6lhExk7Rpjanj0MCEzns+u8js+nWiFS1EK43cPCDRUl6kM8mztWb4V7vH/AlcsUPhypQOkB0UlZHMuGMzPONPMu2N4nQh8zRM4B3UVSIgnr+oIAWl4PcHv8DLmDM5tDlJRMSVFcQA66Dnbk1GKauskZaiv6h6FeAIFsfczBd6vIPoHXUhPWLcgX107/gVA6xHLYmIsw3IvDpsh0yOyan5Ip/CL8bROv+QtkD8hl2Vu9BzQ/t7152krkVmHgcEInWUdS+UpSB+V74wjuDXefBo4Yj9fTNk6PZ7yLPNCMQlZaYQgNrGCUkcw7AQc7ZTdgL1ftvQ1EmwO5QQ6DfHkDjJ7itjlmH/kTdnGwv5RNCqG8JHYD5z6fMLhnRH0cuKfTI+zmWqPdVLwgxY48l+MYS0X+1ncln9tFqV7+y2ELwio8Tvy/84od9kX6XI0O3DbMXVQB7hp13BzLBGIxujph3rLwY/+mL8ga2ERwMmYQg/ORscv/rHXBAqsvRLm/7KWubK7pmskzds1AtqsrAnIn21VjQ6YA7L43OgB4RWEya129MPoBvjucVPdkmotamqN/55zX/v/QePYNuVOOWQn4zBbm8lSxBOApUwR8ZcXjKYiIobGxnb5ViT+URjI+HsW+nixxJirFEWFsEqg0hq2IEaHLD30t78UP/vJHZIz62APi7bD9NFFxNHjhHDSo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(36756003)(83380400001)(70586007)(2616005)(1076003)(26005)(16526019)(316002)(6916009)(70206006)(54906003)(336012)(356005)(47076005)(81166007)(508600001)(86362001)(40460700003)(4326008)(36860700001)(8676002)(7696005)(8936002)(82310400004)(5660300002)(426003)(6666004)(2906002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 14:30:53.9738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5af29a-78c9-4d47-c2b3-08d9ebd8c777
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1952
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
Cc: frank.min@amd.com, Yang Wang <KevinYang.Wang@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

"adev->gfx.rlc.rlcg_reg_access_supported = true;"
the above varible were set too late during driver initialization.
it will cause the driver to fail to write/read register successfully during GMC
hw init in sriov mode.

move gfx_xxx_init_rlcg_reg_access_ctrl() function to gfx early init stage
to avoid this issue.

Fixes: 51263163eb3 ("drm/amdgpu: add helper for rlcg indirect reg access")

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f54e106e2b86..3d8c5fea572e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4343,7 +4343,6 @@ static int gfx_v10_0_rlc_init(struct amdgpu_device *adev)
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
 
-	gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
 
 	return 0;
 }
@@ -7682,6 +7681,9 @@ static int gfx_v10_0_early_init(void *handle)
 	gfx_v10_0_set_gds_init(adev);
 	gfx_v10_0_set_rlc_funcs(adev);
 
+	/* init rlcg reg access ctrl */
+	gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ca7b886c6ce6..744253be5142 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1934,9 +1934,6 @@ static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
 
-	/* init rlcg reg access ctrl */
-	gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
-
 	return 0;
 }
 
@@ -4755,6 +4752,9 @@ static int gfx_v9_0_early_init(void *handle)
 	gfx_v9_0_set_gds_init(adev);
 	gfx_v9_0_set_rlc_funcs(adev);
 
+	/* init rlcg reg access ctrl */
+	gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
+
 	return 0;
 }
 
-- 
2.25.1

