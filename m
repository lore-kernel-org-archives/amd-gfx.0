Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA23AC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F2410EE19;
	Tue,  7 Jul 2026 15:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y6PFR2p8";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C98B10EE16
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5kdGE5KejAUIPctKFYAoZHgd4DAs/v90UvgYBS6ZfkueSCsBLb8488k4loOVOMlLAsQHaYd5EvPyR2xRvrkGHE32MI59tJmmNRcj5+1jyQhkmO0lEY98oq/5x7xY9L+DBwI02FQMxunMdHRaGW0RSY1AlM54R/fBkp3eZc31gyDWq0quJVARhhHw8wmP1nNkpL+Ov2GWFuBqMT6qKZm2RORQKVRgy18RrswTgljQ0rneWG/SALcd9U+AnjBo47MLAR9rYT2+3CL3QbfeOLKz+Wyl/bUTqAK9pFl0tDEB7CQTNKyx48yaXH5dpLbSqZ/GB7T94vVGtIj48X5AoA8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VExEGR5VzF68iDtgvHAaqsut+iuNfMufvYvxTe17/vQ=;
 b=Zr7gr3e35MXCaHFusDsSgaQBKn0xlSlpST/glW7VWJ34lvAaOHkItVf4QL3VFW568L/vz0n9VlO5AqUWqU+Mx2Pn0HorJsi5mWJWrviW/6jDVIXkqKme/6MmEImaCbecn/KfgR6F0wGosG1sxOAL+Pp/Q0kNO30LKO90a0hMUM31Lzx24RIAIqKBICi8Ra4A47+BgP6lNij8j7V0pGTgxhg7V8Mviy7Md8O+NgjZVeuHvqighqbLQ2CR1gPYFH/6MBcJ5MRmUwjn1g22erj3+X0PNBP1UvctxYGtPbRCW8FOXpAI6LUljjgvTZx0WPhGJlCUaniGaaoxakyevd7Qpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VExEGR5VzF68iDtgvHAaqsut+iuNfMufvYvxTe17/vQ=;
 b=y6PFR2p8SY9etTCTsrmO+2yke1MH9IgQJguRy3fzCn8oVTVrOJVWr6h+zRFXftJUe3UMbO96IrNCwmGiQ8C0sqr9Li1vEclzmm8vSP5MtSFi/Sz0IYT/y6Izw7Uyy++s7CZU6td6cp4qDltbAmW7up4g47I6mkkV9xlMS/F9r7Q=
Received: from BN8PR04CA0055.namprd04.prod.outlook.com (2603:10b6:408:d4::29)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:37 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::39) by BN8PR04CA0055.outlook.office365.com
 (2603:10b6:408:d4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:42:29 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/30] drm/amdgpu/gfx7: drop all BUG()s
Date: Tue, 7 Jul 2026 11:41:56 -0400
Message-ID: <20260707154203.2603209-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|BN5PR12MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: 0090529b-b5d2-461a-6a55-08dedc3e5eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: Ed6N4kRmJjd1YnZy9ROVhSlpDpJ4O35OaQ04vPioeJ+I6Ns/4cheUC6tYneJjFLkaXSZI8Av3OfSQeu1OtGXmaqU9NssjwWZ1w+oJuuNlLGiUrgAvCd2voagujwoT/wOcmu5iUm2jxCNk2eZbEGPFY27HHcQD8RaN2uIzuDiH3Z2glBZ054S2oAqjSN0a4XWDOTblWI1NgqNJ2shoY8Ii4KWxBeyBpL1pZo/vrx6PS8mZj7iYONRN+TiJPAoM9YtuqLkIV8aU0CfvjGxhZGEMzZI2RwEThoVJzrafF3R0c/1T9NOTnvik0XTIpShotieTV1zpyhSOZGC5Lx7l2dKuWsryDFu1suIOZbe5l4e0P98tOvR1NGVZe2MrkWPHkMXJVxmYSfkHckP+MhT2qVp0dRZ2DZErwsmX8C35OZsnN8fCWu99y3BD9A+BX9mCKjD56TbQSHgCrrhAU3YzxWrZ+Ly5Kv+oCdIvGQCY9wkfqT8PzUd39mtMX5nuK0aN5cL3yMp3/NrMYuFPnjSD4ortDLSC0c34MxO/7qbtXHaju9kloo7D//C/IBmUgvIGF3nezlE9YZYMlHQCecctlRCF9ahtb6a8jhfwWkmTohlvLwcaNvTSHi933m12kM4/1MG6D3N6S8wDQj1JTD9Z6IBr5LM4E3Mg/LPgRj9qNvtWwiG664GsFt/g68SrHgE5+/NYock/cRJcv8O5OmfMuGaxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wST+psK4i6JhIVmffozL/7VJZQRx5zN5EbeR7xHEzI8QvdPf7FPL3IXTcIqvMPSNW9Pv4lELYiwINFL62Dz0kfaihWplA6QFL41O1TqXrxtHlBgd3IUCSLj1hp5W97WYlWY9Z03D1jsZzISaIEgeM3l6Tw++Z58Ki6NWqP2XrF6Sj3rQzHjJv/ovv+fP1tbsfG3GX7O72BrcrCqYxMuEqmfru3a/xEfk2eXnaLc5SfnlRCbZDBkXiePNWhwEMyQl2LONJx/pY2a9RfKqNov0wRf4bKBejyXMahjNrM/SiqXDh0z5DyV55Hn/rXPadMafHkojIAEp3SvaUyTaYstLUWEpn4G8HD6GYJQJa5b0Fl1728Igvgbp1WuQa3S3xEKyP8aw61AIlOB4t09W8w0eMSiYu75fZyile4vFI7Ons1x2Ie57Dob/+qA9KW07H+Is
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:36.7527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0090529b-b5d2-461a-6a55-08dedc3e5eb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 65b8497ad5f02..4a020323469c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -933,7 +933,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "mullins";
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
-- 
2.55.0

