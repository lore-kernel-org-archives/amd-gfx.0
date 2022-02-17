Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6477DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 14:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94CF10E940;
	Thu, 17 Feb 2022 14:51:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0502C10E940
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 14:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8j440+6ytlHSaT36IyPLGpbgzVfNIISGLhGv8bkockljnvNCOTTBplWuuiT/8StMCxwC6LCDhM6RP7Wqf+XGrztHL3otswU2+AgASvFz6t3pej1sHGW0L4xqHQMoEbsiqPSwuiL4+XFedhONZgTfodPPLGFdNN0wPos0UsUIAiDdeGg20E4E/w/01hK+lP13/Tbx9NwIVaob7k1gHFS0sa1m85jpdC8f2FTvUJEjpb4Jm/DTxuzvT6332jygY2loIO8cwefireUEo5f1zCJNLMDshI/p4z1an/YuUM7dQWlepPx+xyDe5O7MIhesA+lVIt76K+w+E8Luv/KUr+Ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Qqy1N+6bQCn6377qhPD7jlo/HTAfepKn4Qcl1AGFXA=;
 b=ihe17LIzavH9eJFBd8vNAuw0wA0JW/pnXwtfu8jyM6Vf1HC6Sb45NlfCyAgVmn2rSN6fWW/bmHwID3hKbCgGfNJM2FAjKxGIq7CcIeNPZ2TwzsTgoL20wBhLj6G+3zVXGHX+CjURGLU5KZm8h0bJcG5lLgVtNNVsap+OPAMvki1CtELaKndqtu0CCO10J7JmW7XOtBnnIph7XCIiPSeLn3Vuj1XBS0u0BoP6zA727PuTVz4S45IBlDPcW2Ve22f6aZb3nsAXFuH3BlREAHyCLSrjuBi7DiO1ESgHzJJ6ruh0HF6ronaVVlwhTXSba7jHGJOMwiiEpqT6Uv1AHqC3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Qqy1N+6bQCn6377qhPD7jlo/HTAfepKn4Qcl1AGFXA=;
 b=5QC5BfaIVfTcFfEWtL2Z7rmy+5HzGqz8V+VSGUSkIUZ2bDBz8AElHSQCGWPEBsU++Knia4jJ8DPoMhyLthM29UFlqxY3wGWEyQ0wDrFf6S7gZxeHmtW/pvjCTSi7lrUmb0mYz9u9wbZFjRpVINqSDAxHU5RfAOedzKUi+RgSRDg=
Received: from DM6PR06CA0031.namprd06.prod.outlook.com (2603:10b6:5:120::44)
 by DM5PR12MB1483.namprd12.prod.outlook.com (2603:10b6:4:d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Thu, 17 Feb 2022 14:51:52 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::8c) by DM6PR06CA0031.outlook.office365.com
 (2603:10b6:5:120::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Thu, 17 Feb 2022 14:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 14:51:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 08:51:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable vcn pg and cg for vcn 3.1.2
Date: Thu, 17 Feb 2022 09:51:40 -0500
Message-ID: <20220217145140.11988-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04ee1dd1-5cf6-4a8f-0b09-08d9f22508d2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1483:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB148387C2887CEB5475D60185F7369@DM5PR12MB1483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+4DZCrM+rmdZbaJ7SndWGpkDgArp19f6MdgmYUYGb2BKRXaeNyyQpyzcfd70KRN/vCx5GMqQb7J858ZZuI1pz36IFQZpJvvousIXruBcZZsMgaVXx67v1Fbbmnot0fZNGcA7flQ4uyx8jJDssfhDXgHJqwN7Vtv1Kxsl5FIa76ciBaORHJKbDovw2s6XwbvqYKgrAtDtsmUOZhQeMs1gM/vopx9f0VEntnHTAfg/CJde5Xg1oJOFgCt59MhFSAQiW6dxIWbqrlwTrmvFWZzT6JENse6VjmC8AePT/rX/t73kxj8lYUHiIc3IFWGPpnWK8ITNK5HjB+aYo9sZHogzme+E/dV7I4CBIGhrStzAQSZQk2RFolZBcXMRou7YPT8L1exp9kcZxiA6EbTARPVvo/i93j69oyOnS8gcxc+C0D9+uA35etckBDuFLh9fvR4igDA1MrF5a2PpawrjEmvzuGxaFXiyXFjakD3lZjnQs9/kHKsS5GF25eFtVbF7mACFIBqdgj3CbGgFW4WLE8KWLrLGhbqg9WRFIB3+4vsew97PWNfxWVs01qIbSpm07iU2JWxsFCXNLWY01FEONv3ZRQE+Ey/xRnAyDN1ZseDEUZ5JeaFQBoqixy4SibykTXWrRO9aaXkQHz/M2SWE0JlpcdNPnB4JHEzwpMmkBBZIQHZt5+4wPAmarTVzzUpP5cR7ZqB1kkLAf2nnZDoA3RtUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(426003)(26005)(4326008)(36860700001)(47076005)(2616005)(2906002)(1076003)(186003)(40460700003)(70586007)(16526019)(336012)(86362001)(8936002)(82310400004)(6666004)(54906003)(5660300002)(6916009)(316002)(83380400001)(7696005)(81166007)(356005)(36756003)(508600001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:51:52.4237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ee1dd1-5cf6-4a8f-0b09-08d9f22508d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1483
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Enable PG and CG for VCN/JPEG

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 1a25db6958a5..782e5b5267b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -923,8 +923,13 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_HDP_LS |
 			AMD_CG_SUPPORT_ATHUB_MGCG |
 			AMD_CG_SUPPORT_ATHUB_LS |
-			AMD_CG_SUPPORT_IH_CG;
-		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
+		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
+			AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	case IP_VERSION(10, 3, 7):
-- 
2.35.1

