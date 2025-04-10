Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC89FC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 14:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3650C10E9DD;
	Thu, 10 Apr 2025 14:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VTkXhCnS";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81E110E9DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 14:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQPCqmXyqqZFK/RPqlco6ypZjvd/dWpn3Aj6RJ21nUFdgssk7U5oIspdfhRI8ZP5CgyIBJn04o2FYjFuIBFVqmkM7RxbdY6XXTDSDb5gE5sGE1zjUdwNxmWzlC+tfe95Rz2GKpKZ2K+esb8yGvJnPSLa/AAaeIaSQ99Fu9X6uMXW3vIdQAuSCHzOp0UC36Y+QfKIWjIZQsZK+M90j3VDosph0IOVK488gvanLGDG+Tj8upFbVTPN+JyT7HCtAb3fuEGdT9n6AO0urLNF0GlQcpEkw+O0IrHZeydeGhmyu2L/98Z28nsooPcP0d/9dkmZZ/oS0kchbbHsrqQtk7A0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3nqhwTIEE51XmuCv9E/PNi/DNBNu5kuwjfdHmQC/zU=;
 b=Xx9SyEA/hP9tspd2qoi09Kpc0zyAWuZYh1Z97/xrR/msOMYVEigRMaL4+7JbpHVgJX6hMeUv9F9TBJQ+lDkNUsrQlDHP4HdEnzDtZYZEk+/OKGNleDWt/6fBlTuPZMJ4bKGTX0IDGsQF0K57Cu5qBZv5KGzA7tXwgrK3jojTP9goQp48tdjOHHK9GT1KyYbzPzZJq1KOjvvwSNmd054CSqD0nvGfp0jJZBvmsUW/+/5G0yh1eR6pVDcf/u2BuA5CtYB0aBSZ47J9bS1AW2EE5GKIv5TjJNtz5sdoGgiETKHB3h9E7Wv93qtMIFZPNjzaoqE6QI/69Kj9HW9czrMb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3nqhwTIEE51XmuCv9E/PNi/DNBNu5kuwjfdHmQC/zU=;
 b=VTkXhCnSO+PqARO+JoWNAxovTYQM0gc95D1ptpyXqYalFKYomIOHO2INNoyiUt87g+EGnY+5n3e5nvcFTT0fUb+qB9Hseknsu9eKPsX+iTAsF2+B8yt3BGzqp2c+9QasP7E+lrIrxc2uNvddlB4O5M96ShgQ6rirqpAAxX+YWTY=
Received: from LV3P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::26)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 14:57:08 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::96) by LV3P220CA0005.outlook.office365.com
 (2603:10b6:408:234::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 14:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 14:57:07 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 09:57:04 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <shashank.sharma@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH 1/2 v2] drm/amdgpu: Add fw minimum version check for usermode
 queue
Date: Thu, 10 Apr 2025 20:26:46 +0530
Message-ID: <20250410145646.51008-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cac959-39c1-414c-e074-08dd783ff695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4YOk8Hs+muXxPKO2u8S0cSWyIjyzpZS2QlWohtUfycAmJb6x1KTv5l76AebC?=
 =?us-ascii?Q?BRJGmKUpyM7aD9tw7vWVMF1crMDtSglOil/j+w36WKq+uX0zNC2q9Jg6L1VG?=
 =?us-ascii?Q?kC8ZNfvyQhdp+CDMdaXlHzDmI8Wm/WToKkCICGDCLnORRoktPFtjkNJzSEjU?=
 =?us-ascii?Q?2m8qVvsFBLKnx2u4fNCqNZvnSFB5n49IlqInNbQCKFDFn/Hku0xq2xyCsON/?=
 =?us-ascii?Q?CFaZ4vxp5XSKA3OIoHNRUO3k2gLpL7FPP+2e/I09pMpSd417jXscJ1vw+gHv?=
 =?us-ascii?Q?G5C4/h0RMvA4Yu+jSA25bJjYwl3a0IOq7x0Zvk1LKX/7pGgKKJCirZwymnw2?=
 =?us-ascii?Q?lJ1TBUUzIeljP3RU7k0hTTZxho563rO5ZaE5N9w/ubdzWMp8XzM4lzBPoViT?=
 =?us-ascii?Q?/NyHIb6BBJ0u5Sy3EUW8VLHMQLiLDddhM/E3aIdNP6HnknxlM1Nr6B/QmOfI?=
 =?us-ascii?Q?+rC7KYzTdFumGfhSQ440whJkBQDQN239RcwjYL1aC+o/LMMQDYVWMsaqxyok?=
 =?us-ascii?Q?w3RjsQZtomwbgx/genYw4zIILsKoHGJAxESKI6jbW1vrgzmON5KV0chonwoZ?=
 =?us-ascii?Q?HokgTpD+3GpnPDkOJXooUPXV586FDKhH+ROxZW4MbexwIFJympX1rNqKwu/R?=
 =?us-ascii?Q?Lae0rA3RrjSy+efusd0hLOxr+bVswRjuUjisRySDSGsABl9rvjUT1vWm5/5+?=
 =?us-ascii?Q?1U7vnXWlOTrF7rVawgnRG658mHsf4SFNnsJVMZC8m7RnxhfbFJTxz4pxs/CJ?=
 =?us-ascii?Q?tVuHzNNXgNiRhPVq5c7kuY/44/sOcgQ9ca0jD4U2DRxQkkWJaktOcKsCEQau?=
 =?us-ascii?Q?ahosmJD+MxWWZi4M7bDTLeocEnb1BYqhmzvhQfXdtzD+gRlu4YWDTZ4GdZwz?=
 =?us-ascii?Q?46YrJvpdf/G4NRsZjeA+PqTvkaUNlb0nARHnlDiaj6wgHzXOu90Dme2FSepz?=
 =?us-ascii?Q?APsQgXPpmfx4PaJf2xX2yptJ64GsJhH1roa5PufatpVFEIyayVJjG1dgrYzM?=
 =?us-ascii?Q?FVf2R3omHpCC3yO8H8rZHpPXt0DGHaU7xsKBXFnKftAhLlF9FiPRJJFdNrc1?=
 =?us-ascii?Q?1409PzF0MomhMLxMWUadNpmBanOvTdJjYOV3OshtP4Eo7qMMXEh6XpPKIRVO?=
 =?us-ascii?Q?YFSllmtQDF3xi8BB3zA4DAqS+YI6xWgEIDQbo4nVgsfmXLyxIr8+/+XAoerB?=
 =?us-ascii?Q?nMS1z0raunSeSOSh5ECT/TQvMJMkNzMU48Zuw9AVV9b2qTjlUYFrhDhUzRbX?=
 =?us-ascii?Q?Y7vSfz5MgRc/hOpOmm3KxaUD0k+/nBbtnW7jvGZoIdxc6+VuY8+k0v7X/sLv?=
 =?us-ascii?Q?G380vFF4DqrhE0pcyo7n8FhxFQaLCUv5ZymgC8ry0GP/wqnguC+a3ARda7Rj?=
 =?us-ascii?Q?4UBAgMi5xrU0OJwH3E64vxUALhjNqouT/Dhzi9rVqi5uWN5SLrupyuCn9ftl?=
 =?us-ascii?Q?I+/BzkGpZG+498sdCzn60aYomU/MABO5pw+LllXB6ErJC5gz+iEkVtGi9S8D?=
 =?us-ascii?Q?55xx2Cf1puDErGAWjsOYw898coS1PBlp9QgF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:57:07.1456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cac959-39c1-414c-e074-08dd783ff695
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
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

This patch is load usermode queue based on FW support for gfx11.
CP Ucode FW version: [PFP = 2530, ME = 2390, MEC = 2600, MES = 120]

v2: Addressed review comments from Alex.
    - Just check the firmware versions directly.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 91d29f482c3c..62dcdba589cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1632,7 +1632,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 3):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
-		if (0) {
+		if (adev->gfx.me_fw_version  >= 2390 &&
+		    adev->gfx.pfp_fw_version >= 2530 &&
+		    adev->gfx.mec_fw_version >= 2600 &&
+		    adev->mes.fw_version[0] >= 120) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
@@ -1646,7 +1649,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 3):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
-		if (0) {
+		if (adev->gfx.me_fw_version  >= 2390 &&
+		    adev->gfx.pfp_fw_version >= 2530 &&
+		    adev->gfx.mec_fw_version >= 2600 &&
+		    adev->mes.fw_version[0] >= 120) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-- 
2.34.1

