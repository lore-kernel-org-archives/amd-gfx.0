Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4883DC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C198510F350;
	Fri, 31 Mar 2023 22:46:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A232410F345
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMdYHsWun6HC9WIrC4PSaPNUNdr6Qm2jSdjODn/ctz6X1bypmIagJ0qdZuszBzizGSjX/tSjs9KtnPJKgQPTt4SEPV7TuncBSHDMGvTpgv/jg5ZOc5GXsLdsa8+AxSDaqioGNdCdskbmG9QcLJ23+U7Hax7hQJPOIf2b4pj+2PSTh+5J/e73NPYk6Rn/ubW2+59qBhGtycSp386TWfxR1fPgtLsL/mcYvy6B4UxGES/Ts2bRBUoFddXG/4ZQBcJA2j2738S4XjtXm2zeJZ0MFA5Hc44D0g9XwKuWIIG87YyajGgI+GcqntBsUQXVE5WaMJ7eo+1RDCF6TuWvL9oERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvpLxzf19yXnQDqu4nd4C4Dk4Oe+E2WL6WW+Av7nM4g=;
 b=hlHbljGfFqqYCXb2PlRKoeR2X9dRp4WyorlRKEbo+QWydu1BsLEdCpDEd49qtxEenASgknFvV1VcjeqdSZQSd0h41aOMD2IpswmxprSGZXM/snzy15j2VcRRwyA9Cmh/fg19702949fgYwx2GIM95yWOd8Mf3Yum0NKk2c5UrU91tyWaq7LXE1OkLm+cOvQ2IzOLLwu+AmHCXuF/yLJIlQxGWFwNySzJKkWVzUgQqEwD0dKJEBry+PcYFLOZ4CQBLPl8eo7PmXE01LiCLJKD6oNFNwNzxgPtOZoXKklHpLuefXeuEciH/M2ghIi/G1DlX2KuO7ET3w2A6paoEZ8iKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvpLxzf19yXnQDqu4nd4C4Dk4Oe+E2WL6WW+Av7nM4g=;
 b=cwoO8D3j73Y3g/6q+pGmkdleOY8XQrqElbe4uDpccCeFHhdB/2w3iiFSpBOzWz5Kd4jEv5ilY9HV3v8dlKquUUnMLYlp4q9wrs7Nel4u07n75ZgwwQhw07ZZeotF9Z5rWA0C4ADUgWTLdKyiYC+i7tKmMNGj9xoNcaFQ905WwNQ=
Received: from MW4PR04CA0196.namprd04.prod.outlook.com (2603:10b6:303:86::21)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 22:46:39 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::eb) by MW4PR04CA0196.outlook.office365.com
 (2603:10b6:303:86::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 22:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Fri, 31 Mar 2023 22:46:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:46:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable CG for IH v4.4.2
Date: Fri, 31 Mar 2023 18:46:17 -0400
Message-ID: <20230331224617.8961-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331224617.8961-1-alexander.deucher@amd.com>
References: <20230331224617.8961-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ce27fe-8931-43b4-99e7-08db3239ca59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbU+RCOaobEyT12x12Yjo1TLEPPdfcINvcTYgSeNYqgL2UNGPbHiMuSyDavOoOlbsm/0Q9dkYqoMvy2rE+ufLogsFiQCODf9s7KcOjc32NuYyonSMFktYPt58zMBdrWzEhRMMLxnhcjx3KGQBhz8Sz5pEfcyOOwlb4fHoFsb3rIgBbSIjWWMv7NTNlAuMTBWGQmylvJSEwyOmrECm8gKAx5MwELs4MHDUgJOTIRv79hwY4Li/Nnbn0ImEQViROLOMr6LBms3pvBvk5j69/3Dwm5y4jXotPIKgLJ1poN6cYsRd/v+wgvOpdBYZBr4D8Wm1MDkpLZNQLKFBXTUIIT+ctkdKyguMUXzmwg1YIBreY7f6ifNwIn9U6qa8wlqvIpvdt+AQlDBEzu5XOLDKvaPgQFBWZFd+qCiB4Hwef4skY2a+50doswb+c/8xx60hzFPL8EUAuOmjjDGdmSrDbaxWoNfhy/YyA7gUvXFfnrQVZFRURT1hyUwSZTdZCNJD8kXZ9LrkmKJFDf3KxQzYPHgCwQEfsvNeWZOGgiBtvuMuENa/QnhXzJAQoOD9xwoZqIAm60EHhHv1ZVjPq9KVivR2y5Ysb6SlQxL+0MSxQ3CdXTSAxdVY2uh55Uo/qwgLTu5JqoU3fLQ+7TOlMDx07gkxQALfyZygEqhfi3gDvLEnhmpFYuMnaRkD4JUE1bypb5EiwNOhynyHQ9KbwhExy9fhWV8+CtuTCDjFSnZb95q4CI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(1076003)(16526019)(186003)(6666004)(82310400005)(47076005)(26005)(83380400001)(81166007)(2616005)(336012)(426003)(40460700003)(478600001)(70586007)(82740400003)(41300700001)(70206006)(316002)(7696005)(4326008)(6916009)(8676002)(2906002)(36756003)(356005)(86362001)(5660300002)(4744005)(8936002)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:46:39.0889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ce27fe-8931-43b4-99e7-08db3239ca59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Asad kamal <asad.kamal@amd.com>

Enable clock gating on IH v4.4.2 versions.

Signed-off-by: Asad kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8550a6b0b890..d8d80cc5f8fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1155,7 +1155,8 @@ static int soc15_common_early_init(void *handle)
 		adev->cg_flags =
 			AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS | AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_VCN_MGCG | AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_IH_CG | AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
-- 
2.39.2

