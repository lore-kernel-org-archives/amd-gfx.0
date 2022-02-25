Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78294C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 08:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BFDC10E4F7;
	Fri, 25 Feb 2022 08:50:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A29EB10E4F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 08:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxT2UVtKpuSypE6Hb5cSfo8+hwwrpoCnMBvc34EWcF0FYH7+4ky92WiYydTRZlXyxlcPNj3B21evfSrknKl9/bFoporhOvGaepJNcqs5L9v2e637bbxmQF6u66Y87CCsc/prmutuUnS1U8ao2NKKZ3qmb2c02BekF/Pgj2tHaxAtP+1BC+ooWgBtxj5ftl2nTiuDmUCEZVTlh49148fgiteCRcrIlsW//yo8YJletQ7EjPH/4KQacIwls3VnxYXhfWKybJ+QwWHQyRWNjBo2iIxiTdQXVcKzTgYkfoMEKVN6Qylg8MYOjwp/GudGjAnk2FKMaCp3g15wzxEiVl0m0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pys2x6h1QIs0UqrGrMna5fvnVuGdLblDDrbNGgYTzY=;
 b=OAOYWWD5YVIiK5GMPt9b0+GzNh5SlaJ4wxx2nNngkgF8WrFmXN0ywYJe58ZiKA0MekOFboK0eeh+RDXaF5X5YN5XDu8CQ3kF9KNjPbdq+jwM/UI106fxCC58Sm0xnSc9v5q92mXxSp/O0z6f5o048eT1KBjPpJcn4o/M8Bmm7EGVczgELGmVb6mh4BmOPxdlRWWrEaGpar+KaLM/MsagncXat78mtTDwRBgXegbr4cyUOZjZYzNZB1hqPe3gJPjayOQIv+Y1wIIFKE/7DbRLB1YuPKzYCiTvBg6lyqg3kphz7UyTV0JpdqjfjY+EWAYXDaLkxmDCPhWaYQKypOBCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Pys2x6h1QIs0UqrGrMna5fvnVuGdLblDDrbNGgYTzY=;
 b=MVnGzv1v5Mo/Im7VPlSROq1FpSxx6c21FbHN3BFiyXDRV/UzdBniLQ9nPLLy6CnrsrHBOTSSVeg1tpG0WK/3PwahBvFHIxJI/W7v31C8WPs3mI2VoZ5X7UxccOKSzqDGp8Qs1nfxVeMqYsSd1/zyqeBbpTZE6cUVS3CX7Sxm4WQ=
Received: from BN6PR1101CA0003.namprd11.prod.outlook.com
 (2603:10b6:405:4a::13) by DM8PR12MB5496.namprd12.prod.outlook.com
 (2603:10b6:8:38::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 08:50:09 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::22) by BN6PR1101CA0003.outlook.office365.com
 (2603:10b6:405:4a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Fri, 25 Feb 2022 08:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 08:50:08 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 02:50:06 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add gfxoff support for smu 13.0.5
Date: Fri, 25 Feb 2022 16:49:39 +0800
Message-ID: <20220225084939.2096051-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a62878a-6862-4b41-8f2c-08d9f83bd39e
X-MS-TrafficTypeDiagnostic: DM8PR12MB5496:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5496A1E7AFECE97DC7848878C13E9@DM8PR12MB5496.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3O6VHZZiBuzP7NwQ+Tl1Qm4VAp43XxB47/uAo7Mj8IW6FI+FI2/uw04m+MuHDy+LAhvVBc5hLclyoqvOmKZ3tbzeOuxnrcAUI3HyIoBbLYINjL9IGekVFr3UEB+sJk8H8Rea8MOMOhOy7FXwBfXzk0Yv6/HCWE0GlG6cQHD1O4viKNaYoeyak5w64iuq6mI2NM0I091PJZxcxkjGcKTppCeFNacT8vdM1smTZ0wvgx/IIUm0i31n7enl+2SbDjrHJVGa5snBT/QUTcE153rG0U+0aQzI1anSK6VF/KhTSTA/KAUk/eMhvdJFs95HLz52chlw9nDh86iIF2ovc13a9RyfoZEaHzCd3DoR3S22T5RpnIZMevgib8r2FJvFFQqUbMSk1Tsq3auVpwkXC41PFl3aR1CWc01NJZ3HsvH0DHDRvlwwH2aLgEgW4DdRQih6ykV3p7+nzqHWwP6BAaG7iX1qYS8E2pbiNQSkea2xMKfWnmiVCzKjkib/s9byvzfro5oE4OHRjGRWkzIBRuuK/awz3SRN8qBwk81MFiV4u4S4fGu3dCZEfSSq2mwRZ8sDvWD3gmmFFI+f+fPVe583oVK9dTIHjnWWpBirav15BHZfxEbMdHEbgEdXlgW68lz3Ujs31pzlfPgZI3nW0muF3TG2POLVD1/ETxc6XdhZDnGrOg1eVfIkbABWTXCrYIm2r46CWYtA7dp1oZZPRQ2RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70206006)(70586007)(7696005)(6666004)(316002)(86362001)(54906003)(6916009)(82310400004)(508600001)(47076005)(40460700003)(36860700001)(26005)(426003)(336012)(186003)(2616005)(1076003)(16526019)(356005)(81166007)(2906002)(5660300002)(8936002)(4744005)(36756003)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:50:08.6146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a62878a-6862-4b41-8f2c-08d9f83bd39e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this patch adds gfxoff support for smu 13.0.5

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 261a3749c089..4e557f4f7c4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -751,6 +751,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 5):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.25.1

