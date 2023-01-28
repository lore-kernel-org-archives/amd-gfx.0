Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B76C38142
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Jan 2023 08:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F41EB10E046;
	Sat, 28 Jan 2023 08:07:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11hn2200.outbound.protection.outlook.com [52.100.171.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B9610E046
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Jan 2023 08:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN/VJlwvdHp5nfuj/2eT6RP1vtj0Qdvfv6R252BNi+aT6hi/nk7GNi/ZZrzK9UuB8IWzeS9poHs7BNsNljin2llK/g05pDK9MCTCLObjIiUH4wa4h1M0scAXaK1txHRxHHPsSZ1/hcKE5seWRCEoNQktD+CGMzAzZ5LbJQLG+cZpr11YWoSH4HiBBcG26t14idTbJyFIgxV6LBzlga4h9AmLKm+YE+iyiIDHuBZO7OZZ5nAXMCdoe6fMCi1iq8CCPPnPSKKHlnMO1QW2sonZp/WT2MGOACH8UWJvmcbjg5NkUiQXq1O4wXd8MS9QtMOLLbz+I4y/7O3FHa74UNsF1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbeLRW0I6SvPzW7UC/izb5McjJ7YuWIE5m1R/u2y2Do=;
 b=Zx4OuFJmu2+/Vtt+opxtJdNf1CWOG8sxsssckbvJN8W0RzGMs+9rJb0zI7fHtaP/BZB1CMqWgUZKFelyJ6OPGy7ExvWDzfMpqAW5yKkVEikeu7S3/wsIyBYyi4eCZ3JzfSWkeNTep5Ba9Awhx/0qaQpaxJQXI9QLtCysQh/fY0QUGRqPGHiotk4N7ByFPJvSWFutavSzDiTyjIbiHcm6FMxfWdqyk+u0l+IsFc9s8DFdTzwRaWH/nvtFdCRCf/DTMoIml7xG26gROFaJ9CetGOBLVXc7Xf+r6NK0MU6fZqjX81mG22P0LLpmlHasQxejqX6NPNw/rfu7DSJ76NpfjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbeLRW0I6SvPzW7UC/izb5McjJ7YuWIE5m1R/u2y2Do=;
 b=IUsKswCMLyRygNopHc1w8ggZxzxqZXEFEil1Yjucf4aKkGazZYR2+vVyg9m2YoMlLMPxShbHCIzCl84K0Dh3uc8P0joYyCzrguNYTxi1u6I0BEdpfNSBNM3nKtqsXrQngbjj8GVTBpQkGMoM/zSWl8cODxdlrq9a/J6nQYifSy8=
Received: from BN9PR03CA0514.namprd03.prod.outlook.com (2603:10b6:408:131::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Sat, 28 Jan
 2023 08:07:06 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::a6) by BN9PR03CA0514.outlook.office365.com
 (2603:10b6:408:131::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28 via Frontend
 Transport; Sat, 28 Jan 2023 08:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.28 via Frontend Transport; Sat, 28 Jan 2023 08:07:06 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 28 Jan
 2023 02:07:01 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable HDP SD for gfx 11.0.3
Date: Sat, 28 Jan 2023 16:06:17 +0800
Message-ID: <20230128080617.3935541-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: dcdebab8-78b8-4e16-4975-08db0106a57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +EI77bAMGwZnbJn0AdKrQZqnz84UeAbtJayisnkQwp59eItfKkwCIuQZTIrZC+7+PfJbUmhZq0iZ/784yzuQhpqIq3sMlRuevNxI7bATsqLAA1e7oNUbR1xdzYmUNxCqM2Y53wEJhMX0JKVGGJs723a4xfOTS8tohavDcc1Ef4AEcbv36OOpfLZ4U0yeR/pPuTtOcsErqSvcfNeNpF7/PcmbKz/3Ah9yJWHp9YSG/BSpAvzz1K0IFQWiVx6wlxdIdJdkX600f+1//VacaCYHn/LN0GRwj7Ds64YI0dxO7l6xFNThzi8c0E0nv/nzokbrfMD5a8aQllHrsK4E5wS+glQRndcCj70XztenVUavnJX1QekAc4lr5wFwe3zrkMRRDYSdnZ/x5RIAWYCAxk4FoAsUo/44Ur+Jokj2UQE6gWQkMT24NTIEEFoSbhtKi2TtCH+lUxGTmIAcbv8qvQHODFQwMHSxOGBFtkDaGwJodrMS6wkQUY4TenSVrG5D3nE59Zi5RX7nf0KGrRnWYdoEUxQaxHqdfZlyGp4FKH6E3lCXKul+wHfRM56K59/DjqgOir11Rjbx6H4+zjWNtp5uU3sLMItxmcs3ncNcS7vpqhPkvHNyKqXiXbTBsGGhqSESXuJ+GK1w5/E7zXpIFZd9GOmRcrmmkRXFWYnsRIZiah+JY+B68G6dIOP9odnutuN73/O0dmQ90TFxYn6+YY5w/SS3NHdsaCyuLn67vpXb88c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(34036004)(451199018)(46966006)(40470700004)(36840700001)(47076005)(8676002)(36756003)(7696005)(40460700003)(86362001)(810100004)(81166007)(26005)(82310400005)(16526019)(41320700001)(36860700001)(186003)(83380400001)(336012)(40480700001)(2616005)(426003)(54906003)(356005)(41300700001)(44832011)(4744005)(6666004)(4326008)(316002)(5660300002)(70586007)(1076003)(70206006)(8936002)(6916009)(508600001)(2906002)(36900700001);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 08:07:06.0562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdebab8-78b8-4e16-4975-08db0106a57c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable HDP clock gating control for gfx 11.0.3.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I0bac85a05692937917e2916e79e6e74a1e11aec0
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index e03cf7f766c5..477be4b62bc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -676,7 +676,8 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_REPEATER_FGCG |
-			AMD_CG_SUPPORT_GFX_MGCG;
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_HDP_SD;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
-- 
2.34.1

