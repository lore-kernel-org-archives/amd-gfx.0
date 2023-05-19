Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF79C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 04:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 206EE10E5BF;
	Fri, 19 May 2023 04:58:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0899710E060
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 04:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0tUnE0atJsBhLADWLkWeIl79wPBov9uIR8b033knkyQl9Ang1U9Qsms+jFHN7SfCy10ghYCt1p3lOXIAp94nKErSHyE+G2Q/acbPGbQqyymwci1WV20JZUG0k06+uymLf/GwLbNFP797vOOYraLDXkwO0v1uZ7mFmGQJlpodySNAx708pSqYExzD5H68QkkLnA943Na31gPNB1lZzrmH8CEx7ILqE3FtjdvXapBOqtnQzZWPMr7ABjqT6kV/N+Se2BOGPhvB6OUG0pxwdMpNUiudxk5aHtRkVt6J4NXvZwA/cKRLQ492Kp30hebpq6B2yYjQKTnmMgsWGxO2TT50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kndbkZi08M2BDtvy+qVVP4umrTi7CPfPnfRbLiJkJPU=;
 b=Mp+oO2zMIfAvWps3f0D7b/xLK6dN/d+Uphd+fIz7fbiu8LYhlnU84cYTw9WflY7Lg10ug5O9KZUugFxEcwIiweggmvXS8aai3HWLXAwgQqwUbVbHXyk1lNIqeUgWlVy29wkhoMtUUfFy0EpIXb5NJevo+IzJeAR3tsi3PKm5rs3s8N8gjFMmrjYXfzr5lgiNkBEp0iuoG0pAz9nS5U2ZS63IE0u+ZLE9O/Ph4vTTX9e6oDDlZT7evCY/OXVZCLA0VWjMGxJTSlFdRhvlSs+nw8GpZnYEQvneYI0BCRYQDYBLwQMDeRyfpg/Wh1XMuMRevqzH4NWQLngoDpWFFGSPvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kndbkZi08M2BDtvy+qVVP4umrTi7CPfPnfRbLiJkJPU=;
 b=Am+TS4UI2CgW+D5LsAR91YibOYI5V13oxT25ChWS04QULULwRuknaVPrRTvEuQVrimo2ixoLLWKoZj4EnSdv2Vk9ST7BqNvYyMsumPO4s4VK+aO8OJTB0ybehnfSvUJ/guPIXEJlMT70VkS3fefc064BFSVTWU/SnPL30tIHZlc=
Received: from BN9PR03CA0790.namprd03.prod.outlook.com (2603:10b6:408:13f::15)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 04:58:23 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::12) by BN9PR03CA0790.outlook.office365.com
 (2603:10b6:408:13f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 04:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 04:58:23 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 23:58:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix uninitialized variable in
 gfxhub_v1_2_xcp_resume
Date: Fri, 19 May 2023 10:27:51 +0530
Message-ID: <20230519045751.4189311-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: af61f8cf-6cd4-477d-facd-08db5825ac5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5RYnjup/r43Hz8CcTmgbwtPpNZDXAaOyyZshOVqfUxAQilTO6gId9ZZ7L75iwMzw+M9282w5MDoCB+YBFBSKydkz+MGCEDHUB5Mug6Oxd7KYPh6JDOTzwj/mLR4NHJvlJ1vVCibL7f9MhMpDJNvwOqI9rWDvhe3F53ORG5X6kk9g/+ful3oTRljVH9nTfVpPuVG6nxA+dWF85wXv1KCKff2WFFndZfOrbQ1tBkDgZi/jzioivdl+x71o6GLS9AD8H8LHLMi6cESqMkbLPsHZwHTaSUqDJrnXZnWMUGy9DGBAWDJkHwoXGN2Pt3XQ2VXgHUzfRUarJ20zl8b5nOiv25/khEC8L5WilrO35P0pFkGhHVSTrTvp8/B2CNQ4I4QCdRAT9G5eQni857eZc2aWJSxC0cmvWyczQaQweuHQJ+qYDg0Ji0aS4kh5/fIqs8+5Kc/blC4vKeZwol8uwYFGMkJT7b+egxl/ZUtKfEK8mla/lzMKx/1dxmqgYXL9Jj7jxn2jbiVrYvtFjxPoRFbsdIr+Q3fBPGrjHlFmvePplryG+dN7s3GIg7LuXgUWMZ1ncGd1nltD9lYK7Ur3Qd75tjArR7sL2+f/UiOldc6iudTcICFdASoy5brs7aSb3W28bpW0h0TyzFHqNwQprDAuigENHdtOGN4oSZrQW6kHH/0YC7R17BOLHEhx98/nnpLLOjFWJi0agc2b3AR8V+dGtQr4ZIboXQhcuFxhz/oaPG26xXjjwHVTzB5ZbxlFmfrI2VPCFSCCDc0o3mwMzh4oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36756003)(86362001)(110136005)(54906003)(316002)(4326008)(6636002)(70586007)(70206006)(478600001)(7696005)(6666004)(40480700001)(82310400005)(8936002)(8676002)(5660300002)(41300700001)(2906002)(44832011)(81166007)(356005)(82740400003)(426003)(336012)(2616005)(1076003)(26005)(16526019)(186003)(36860700001)(66574015)(47076005)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 04:58:23.1462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af61f8cf-6cd4-477d-facd-08db5825ac5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c:657:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (!amdgpu_sriov_vf(adev))
            ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c:660:9: note: uninitialized use occurs here
        return ret;
               ^~~
drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c:657:2: note: remove the 'if' if its condition is always true
        if (!amdgpu_sriov_vf(adev))
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c:648:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0
1 error generated.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 8901e73fd700..4dabf910334b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -645,7 +645,6 @@ static int gfxhub_v1_2_xcp_resume(void *handle, uint32_t inst_mask)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool value;
-	int ret;
 
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS)
 		value = false;
@@ -655,9 +654,9 @@ static int gfxhub_v1_2_xcp_resume(void *handle, uint32_t inst_mask)
 	gfxhub_v1_2_xcc_set_fault_enable_default(adev, value, inst_mask);
 
 	if (!amdgpu_sriov_vf(adev))
-		ret = gfxhub_v1_2_xcc_gart_enable(adev, inst_mask);
+		return gfxhub_v1_2_xcc_gart_enable(adev, inst_mask);
 
-	return ret;
+	return 0;
 }
 
 static int gfxhub_v1_2_xcp_suspend(void *handle, uint32_t inst_mask)
-- 
2.25.1

