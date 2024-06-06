Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9780C25B75
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 10:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D06B10E8B9;
	Thu,  6 Jun 2024 10:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t7PXoHTN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8382010E8B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 10:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEau4KXVW/9hZqz0ekf9sZqVD6cRXs744wIILtnMFJwaXFV8kchqvRPbC6kc3ho/XkG+d+dJKRS8Up41lRmvArUy+NCAiHaaS9b60IujNFkF1NJgnRPs8rjWLTN09U+fOHKDlDVnhQagdw7rJZxYjwaC0p54NcLHcUEBE5QyE3Gijqdpl4B1wkaE58j7BRRvhJ45uyM6kJjouOQfmtkNpCOXVabA4cVXPDOHdpBn+3q8TAqPqDimk3s7OAbpbqqJKnXO97g7spAXk/6L7zqGi+cgIoJQb1tBlZbTD/Z/QmXteDK6dd5J1+LCV2zuYHx8tNHjHzA1gdGNQdCrw5vJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te4huNxWAgq/l8qle3NA7HwEcZhEOiGz2QZWCe0RH8M=;
 b=lSg3BX3D7UbQ03y8jouBdP9bXBSQUnXAk2X2/SRRoiCLIgxOTaUgOVoFuAsZUe0sz9Mc6oUhU6id/x9v9NxVCbdWcvPM5S7iMbIbBbB2VfkGAIuZiQj0eYVwhiYWT7WyniLuUQxN7YVZH5jA2vJr8QgLf5AtXR28AK9PLxBNfH8RrB8A9miF0EeWaptSzrY+r9ZAC4wfOPQUXt63C7iOBTbLKipXDOJizSs43E8Ly0cPR9T8f2D4FtleEyZT5yJlynK6wXNBzEyMcD7rg8b8w1pxeaUpFNYXCJPpGsZ3No0y7juhPnq77q22mIesputPOUppD4LeYbfrmhQzcptFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te4huNxWAgq/l8qle3NA7HwEcZhEOiGz2QZWCe0RH8M=;
 b=t7PXoHTNTA2/TNzSqD0joeMf/Cn4sKij1EF3zzumpY2DGmyBsBEbAmYZz3Avu5qJh2voBAzEdd5RBrzUYNv4Cw5eX9jB2Dxtl7hY80vc87F2G98GsK8wqojHTVnHiYEXq8fo4AGPR/C+gytVzNoBsEYjdgcs1rt3nmD6ucGfzdA=
Received: from BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 10:06:03 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::a9) by BLAPR03CA0027.outlook.office365.com
 (2603:10b6:208:32b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 10:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 10:06:03 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 05:06:01 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: update check condition for SMU mode1 reset
Date: Thu, 6 Jun 2024 18:05:47 +0800
Message-ID: <20240606100547.22269-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606100547.22269-1-tao.zhou1@amd.com>
References: <20240606100547.22269-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: be8761aa-439b-4db6-6bb4-08dc8610466d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0VP8G4gewIoltuHUxvuz2F4J0DN8JLtYWPnZuZUTkF4v5OG95meGde8PYIDL?=
 =?us-ascii?Q?5V2bkgZYIpMz1iFixX7A+waS6KaVFglt60c5tXlZngpHSxJV6cSO7/6RDXt0?=
 =?us-ascii?Q?txDC7+v/nA+agRwxDEkvRlvQJ3kkvKSrQgy7AkJUfwpmJY3cBXjiGaGZz+I+?=
 =?us-ascii?Q?WnCy39j8ilvrWqvC4xtZJ5snUkr2Hz06lKQRYFR/9PZZcDwhvup9SqMdCUBU?=
 =?us-ascii?Q?SMpHf2eWE6MnY71RCVcpinRla+coeKHZsneKCIrlelCuGOYozz6vuWvkT0tu?=
 =?us-ascii?Q?7W07nYlw1EYzJIJ7w07hDkuVVODlS5fHMTZ02SsrtO39lJyaaqHn2NmTI7Ez?=
 =?us-ascii?Q?NEYnUEauBZHgcbDShtwcQkYYXYPIXGI0fMpMLz0u2ofRUNGWZFHG4e4MDz4x?=
 =?us-ascii?Q?CFBgdS37iTAiLDkoxKcm1fLTP0kN9OaWf/DrFXGqGCdVcBlEluL9UAi2FzKF?=
 =?us-ascii?Q?br9Mt9nhSIgEl2pDZptaDmsF5BBYnhyLhhS2RIvIIX2YCwJeof1U6PHUDJGs?=
 =?us-ascii?Q?cmhWVRNM1W6FvVX1ib1G3nZqgMRUwKOpX/3D00lv7CfwR3npkxvvk6M6mrbz?=
 =?us-ascii?Q?VQnWpMET7cufW9Lg/z7mPgM8GI6Pm/kD5GPtJyry6ii7mMFpB+Yf+cLHefrg?=
 =?us-ascii?Q?D5t7HwJKuavTnS4oZR5oCLNxTo4jQgGhq63+W4jJUX06bBK+gOm4x4uTah4o?=
 =?us-ascii?Q?uBMxfAibguGyQkAmxdmkRIo6k7JzLNl4jsmP7wP0UKerxkMfXTTBiQT0r14+?=
 =?us-ascii?Q?6CoExr9i7RuQDUPhJno2SgGfer6OZQQd3aR0x39UmuEguLHZcPV9PwE87R20?=
 =?us-ascii?Q?Sm6q3BjcARtV6a5fehwFe/b0eaXbLbI0VXvH92p6dmg6Q0reoIURrrjmLOwy?=
 =?us-ascii?Q?fD4VkDwiZJreGz8buBTeZjcJJovHSUFx82PmIBOhcpmOuD6ox7C5HYdLVRLp?=
 =?us-ascii?Q?Q0dceP1ywemrDTHH8CJev06BCQ83UkefNaXgESq0GgF09hegof/o4jPwCkD5?=
 =?us-ascii?Q?4vzXemFTGNNiEu0vvwUSm+8f1/ypwX4gPyd6y/PUNi+hFiE+mI4c3QKkVal2?=
 =?us-ascii?Q?yxP/peSPmmeSGr3jmZ/eeb9eAjoZHAtvDoj2kNbv68Km+SgVxr1PWTXCVKWh?=
 =?us-ascii?Q?gKt8fEkWDyQ/axu1NCqbz/asJSbuW8TevfLL27QU8I5pkOFDH8e7Ouh+8yFC?=
 =?us-ascii?Q?WUpE6vGb/6w68aULHYziwSW7inRtydZ32PPKH140WW/DiLcjSTWs7BRoRziy?=
 =?us-ascii?Q?Q/itzPcfE5SXut1Du2AWPQZwxB5lUzrYtqokjRC+TUOqsKtl1mNCZ6n4PE18?=
 =?us-ascii?Q?5b6JxpncNqi3HFnrJ1psyV/p9pBlsh9lXlFuGm1jqWrM0+v1p20dOxV4dE0I?=
 =?us-ascii?Q?EhC+vTigSjAZUh7MkNEQF+f2zyMPT5hNrcSSNAioHlCfR9I5cA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:06:03.8317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8761aa-439b-4db6-6bb4-08dc8610466d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435
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

The fed status does indicate RAS fatal error.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 04533f99f1e3..2c35eb31475a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1876,7 +1876,7 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 		/* fatal error triggered by ras, PMFW supports the flag
 		   from 68.44.0 */
 		if ((smu->smc_fw_version >= 0x00442c00) &&
-		    amdgpu_ras_in_recovery(adev))
+		    amdgpu_ras_get_fed_status(adev))
 			fatal_err = 1;
 
 		param |= (fatal_err << 16);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index d1766a603bb9..c9639141792f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2788,7 +2788,7 @@ static void smu_v13_0_0_set_mode1_reset_param(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 
 	if ((smu->smc_fw_version >= supported_version) &&
-	    amdgpu_ras_in_recovery(adev))
+	    amdgpu_ras_get_fed_status(adev))
 		/* Set RAS fatal error reset flag */
 		*param = 1 << 16;
 	else
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c1d7528a6dc8..7fda7196fa7c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2580,7 +2580,7 @@ static int smu_v13_0_6_mode1_reset(struct smu_context *smu)
 	param = SMU_RESET_MODE_1;
 
 	/* fatal error triggered by ras, PMFW supports the flag */
-	if (amdgpu_ras_in_recovery(adev))
+	if (amdgpu_ras_get_fed_status(adev))
 		fatal_err = 1;
 
 	param |= (fatal_err << 16);
-- 
2.34.1

