Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3527D206A4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 07:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B7610E28C;
	Wed, 16 Oct 2024 07:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="32OuySDC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED0E10E28C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 07:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9JNphij+lH22LtEolugNyFyMGIN00MeF8XYSfuWYLP9LF7OF16QZtwDdDcXAFXbEXAD9g8xcsc95D6+L4PzLebIrxIz45EgsN7K/uD/5/gTxjepAAZojzh6yO3bGCJeGXrWtHZh87dVGAn2s8URyzUyRAvpb5WnardcdYKNcwYmIAzVVytldy2AyL45MDJHdgtGoXEVofTtlkT1s2SNJC6sao13DNGtbQtNIV1luItbhvKnc+p7lkPiXG0wtGLzsUmi9bAssXlbN3wMq6bX6JxmKB6FMIwYQr8UVEJWVr5Paw+NJv7xAR+ZrFlCJR4eEA/HsGe6V4P/0RtgCWBznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJAiPCVizj8dnUIuRwah4YySzbBq2sb0p/WesfCa2LY=;
 b=jy1xeJJ0X6AuSKYg0Idx4DJOl8VSopyT/w0M4UltQeoHX+huXUEkeFqFPKNpOT5OODzo3S9tv3xIe2jsF5IUCN/LB8NhUFzmG1MEc05zizQyn3kxfEh5FFQZVj279PFUi64jG9xtuR9FzijFKV2fbLw8UsmzPz9Yst4p6Qr622XObQe8Umb1FM5hOGUPjZBr6tAObxORtUOK7KGjZyTAEkl+Vr3p0SMWV8MUbKdbFOeZbYf1dzNhP4voIRyy+oOPIfK6mtjD6ZL/wmQIjMM6Ecl9aIwmp9/1wKoAfBfuwqIzJ5pXwAMjjBBPdjLMzKY/wOBnHCrM3B4h5rm1DvEW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJAiPCVizj8dnUIuRwah4YySzbBq2sb0p/WesfCa2LY=;
 b=32OuySDCgT+QFhVFH7O0F8RSeIp1eLSWk28WNybqw+cLEQsWNaSgaI32ifyBm46psXrMSFdIMSTDNUmZjjoqUHchlR3GmIVUTDmVbDH+q2RI9m8eWFlK78eVxBpSXoXdZUmYZd5oAC3evCy5CLhlsxSqoOMfBFw6P60RNfTsM9I=
Received: from MW4PR03CA0045.namprd03.prod.outlook.com (2603:10b6:303:8e::20)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 07:19:24 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::3b) by MW4PR03CA0045.outlook.office365.com
 (2603:10b6:303:8e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Wed, 16 Oct 2024 07:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 07:19:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 02:19:22 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 16 Oct 2024 02:19:21 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: update deep sleep status on smu v14.0.2/3
Date: Wed, 16 Oct 2024 15:19:19 +0800
Message-ID: <20241016071919.2138181-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 27480010-00a6-45d9-7579-08dcedb2dc67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RUBC2eHVNEGJ5dErtQPv9QwxZzN0kIvqx5xZ/j3bP9GWQ2Bf41LEZ4lH1tu5?=
 =?us-ascii?Q?AYcms0W2IVlOgXNuHQjOGFaIkF27mTt8ECGh5DlQkblT6PWFtgD4K++cVONQ?=
 =?us-ascii?Q?v3vVIXwkpmSYAEjdwkb1kKgYpWMFFClR9bJ8Qkcg6R/aPaagdIBEs8Rg7L1Q?=
 =?us-ascii?Q?gM4aa7aOtCS0vN3Nd4Gr2EC7WpYc3SoS5khMjD6oM8Hv6XsaH8cOCRKuLyVf?=
 =?us-ascii?Q?S3bmxXCyWCRNTfu+VEycQ1WrMy4Ny55F6PQFLH3Y8zLGdzBKZB3dhBmubvr5?=
 =?us-ascii?Q?I5xhh1pNGpY20Qr8ilMcfBmg/rTa+ZDToWc0+Pvuo7T616GGJbn6gVY9XhGS?=
 =?us-ascii?Q?Y6+u4sVjkyaPSciuXADa+5TMxfcvaD3KKPu0LU8rFIlyQ91nhe+uNf3jD27y?=
 =?us-ascii?Q?YHRl6/ONcuonxsCfZcxd0YtA9tF0CI2MXP14AEWLhRhWkuHYXTAT/gGlthpW?=
 =?us-ascii?Q?7G7tc3eB4UWqixsiyVf6Pp2uHqjV6XBp15tdK7ZgQtDozwjGPmJhtQofFN5r?=
 =?us-ascii?Q?ND2ot7/7MdiUy34rAfvTmvP+jD+psgI0vn5DEce93GIB83crmRLBXOEraKx9?=
 =?us-ascii?Q?K9HNIDwIg70oyuX2u39v4DmxxbFIlcQU3cUVWazteUl0lteUqNqB24n46WBQ?=
 =?us-ascii?Q?XYotAFMZ1RX/NwjBYuRYkz2TNf+i/d/mzVQ9yVP7P+7keW6NnzPDs42vHno0?=
 =?us-ascii?Q?JxkA/r3w+wFn9PtsXWfB0sJRZfZs7VyXLsL7iPDX2iQpf8Hrblv6EZl8fVwJ?=
 =?us-ascii?Q?YchtlaWuETZZ2d9w+fQ3XsPurptoySPD/M6f46Zai/R64hwoTaxYr19x/kX5?=
 =?us-ascii?Q?XmMedRRZ02cOtapusNle5omJAMVHcj1wRAcwpw3RP8Q34/gXKMeo/W2Pucwc?=
 =?us-ascii?Q?G4sbaPc4opboF1/Z+DFYto/tk35MgeZZSsB4YluNeRsLNU8tKzyzbxH7FAT0?=
 =?us-ascii?Q?0wENdhWQMqsEMijMsBmJbrv5uC6zolpxdpOgzmDEXk3GVly+ijLZG37OoPmD?=
 =?us-ascii?Q?FvK28gbRngDXnNxJbp4SsIEGHrJdHYS8cqmdEkyVrF/Nwr+zoGqHM83FnjP3?=
 =?us-ascii?Q?HvkGjK9PUOH5PcRvSn0XdxrLAAlZvtoQox+AgvLBYTV4FV2ymBFh8PO/eptX?=
 =?us-ascii?Q?Peg9IQtWqWOrxBp45Zo7QizoyCBnMtvLTk9+16VgVAoQZgHi1XALT/65M2ou?=
 =?us-ascii?Q?ZWnEmXGPlpNcPE7yUOClkR3za8QEsqqxp3NMbkM2i9w3YxLDOlmRYWIO/a1m?=
 =?us-ascii?Q?GYhcWYCEbEcaeF0YdTnuXZw5JahLw0neM9qZ79cCJJDzJLJy3Ma+5QLk71pe?=
 =?us-ascii?Q?ZosMP9rvWzPHb/HCWtvMRCn4qOXsLi00KorZLaAddtviZFcr+WttQC5EvLNq?=
 =?us-ascii?Q?SzAIt6M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:23.5934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27480010-00a6-45d9-7579-08dcedb2dc67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846
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

disable deep sleep during the compute workload for the
potential performance loss on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 27f4e0ce447d..ecdd11a87311 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1784,7 +1784,7 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
-
+	uint32_t temp_profile_mode = smu->power_profile_mode;
 	smu->power_profile_mode = input[size];
 
 	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
@@ -1842,6 +1842,11 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 		}
 	}
 
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+		smu_v14_0_deep_sleep_control(smu, false);
+	else if (temp_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+		smu_v14_0_deep_sleep_control(smu, true);
+
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
-- 
2.34.1

