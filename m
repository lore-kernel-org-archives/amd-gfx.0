Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C91DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 02:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8D410E129;
	Wed, 23 Feb 2022 02:45:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8954E10E271
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 02:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qa8YQ95G6dg5uqeJovNCDTRdzYsTHEb2yIpujZTM0TmQbKXSGEewB5NMonvMtkm7iecTbzthjL9GbFry1eMhCts9/qaNluwVOOQYyIlIAHVXgvrCTwqETZm6Sw+1Gdd1VFZHMyUs6l4fS+bsXevhDZh2cr7SmnkboxegFP2EKHtAm1ye0n3oK8ixr4xeUSSKgKsCmanXgs8oHvFY/MwomutdQUCdiUs9sE0ZzkMA7sQD/zKfKrRcw3eT1URAGPZSTq5VHCbHngUtm/h7h+jM5TzQF6a3GnOoDXTmoOiRdli/gIgSvCzeUuNbN2efUj1ZEGx/2KXbPURcJyXf12G2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKiYlLlxIcWNTWVvWTJ/3pnRLup+awcJRvZuTaZYNeU=;
 b=J6f6q+5DM+ItkYvEfga2HACvbgysVuelP/n1ttXzIJPqsggVa0KS4nIH+i+MusF4oH3MH7wFrl9x4tQJCJEdZwr3L30e+1mg8CUxlyfH1e2L2sTD3taW1natgrdS6qksU7FYatTD+zlJMQe2giYijrALywMKfegpjZTWtoJs9GZmzCsNNQxH3LUD6EHAqZ50tY8VUY2YLhs0nlPDiIOu2dFy6qgmH0vO42OnjajpKiJvAIu+8qMHtdCFLv7XtGoRxeYXZiRzYSRWwB7Q9b+o3zGwv19atFvc9zYmGB988g3NL5uW/Nj2ieAimO9H2NB4Oa7C1/bua8MSBI/GCRmb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKiYlLlxIcWNTWVvWTJ/3pnRLup+awcJRvZuTaZYNeU=;
 b=5iBNHzwppO6DcFUlr91zMon54YoTSxFtFDGkscxpP7BJ4L+9JnNwZQUqat1Wp4GTAop0hx8YtK389P8A8/ezpelDAb2zRwSUD4YTgLqzhUClXVSWlWCut7ogi45zqG1uWXVTarJVR7Q1qYg2rmZy7qerw3cXI6oBBNSGCPXjFbo=
Received: from MW4PR03CA0166.namprd03.prod.outlook.com (2603:10b6:303:8d::21)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 02:45:02 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::b6) by MW4PR03CA0166.outlook.office365.com
 (2603:10b6:303:8d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Wed, 23 Feb 2022 02:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 02:45:01 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 20:44:59 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/nv: enable gfx10.3.7 clock gating support
Date: Wed, 23 Feb 2022 10:42:34 +0800
Message-ID: <1645584155-20885-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4abd74e5-55b9-456a-a8bd-08d9f6767d7d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4037:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4037B9963329F6EB76F8C458FB3C9@CH2PR12MB4037.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMsNmOAEW044SR7lMeXWsZRYvS6HweRhxoTe2scCTOQFCa8W9d3cV7d8UFEwmiSFlpqT6gnVBZmz858f+zc4K3IvoZZHbapc7xv2RNN9Mcct2kEbistLXlRagCUjqu8ddIei2d1CXkx5bPYlRKu/u8o61E3JiksPcGRnl29hsvw3Q19aAk7obohx98qD5FByuQEA8kNKGiFY/KbDF6w4w1A+b4a7x3l7eUu5zaXJvj0IhPIgnRpjcaeqrRpivONd+D3Z+C9yfjva5aUFIm4I7AaQIMYfnDbaV8fnpLE+gyenxzht5olFJrxFzcc9grfZO+VmafpRXRFvRzenh8c96RPHrABcHJ/bOK1YbKiBWk4ITwlgem61P8jE5pJw239U5DdvnGWDD84OM8VMapt7PvbFsL2FkStEHNhVihlbqH9szAzwgNeyo/LEhdS3Y+jb/uXGUtrH/9EXmdSZC2I6XXVFSVBEPCKQwcGHw0W1QXjgfSv2NlaWQLO3JAeAwUJ12bYnWQuM2kzk2toUk9yIbJHMheaOGDRXPPf4C9uPz2hR5Bd9fpH9kXsk8WAAlzg7gKZyoPrOociYvgjaU7zXnjSqLtMWyFFkhINUzQIv8wHJVmApzj/t/kJ7llwpSKk3BPXlgx0dj8QK7nwLtKtWNx+12bCbUlW25nXQkIsJ44k4ZIhlxmIUBCgPzAIZUeabc8jUMHbOiKfUO3aSp0K9ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(54906003)(6916009)(8936002)(26005)(4326008)(86362001)(186003)(5660300002)(16526019)(83380400001)(70206006)(70586007)(8676002)(356005)(316002)(82310400004)(426003)(81166007)(336012)(2616005)(40460700003)(7696005)(36756003)(6666004)(2906002)(36860700001)(508600001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 02:45:01.9721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abd74e5-55b9-456a-a8bd-08d9f6767d7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will enable the following gfx clock gating.
- Fine clock gating
- Medium Grain clock gating
- 3D Coarse clock gating
- Coarse Grain clock gating
- RLC/CP light sleep clock gating

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 74e0550d00bd..5f375f3430e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -936,7 +936,15 @@ static int nv_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	case IP_VERSION(10, 3, 7):
-		adev->cg_flags = 0;
+		adev->cg_flags =  AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_FGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
-- 
2.17.1

