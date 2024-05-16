Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A1FC25B77
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 15:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4303110ED65;
	Thu, 16 May 2024 15:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tfPpEfAL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8080E10ED65
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 15:05:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMwyO26MAXb08xkzRDrKXcaIRd2Qj3QvbNtU6mpqstegIllHKYkgfT6hR2D8bC6zlIpRvTynnMfUzZVCoDruGTQQ3VJxMe/8uqwahm1vYhwiiNF3uTUf42YV54d5ZnE/LvdwPTRcusdaei5imQrzZ+JM4IzMupAWJDGwU7xUO67gS2SoEzCroLiUASnniIJVN4uejYrsecatAiPQAXNkrlK0tAg/DxhMRWz4ZO6q0zd2NPmPoySQF8gXCt8BmTAfxTwXwqPhe/x0tfHAS5f2x0mEJyPuCVIWRJqMRrec0RxJWiia0mAzpR0F2Da4jtFg1509+qLrmcWr0owsvOZ83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS4OLSEVjTwjrbXsi/mOedoBt2NfWugX8IixKGMg20w=;
 b=KZ3hmx/W996x00TA+1aqEB1qRhRK9pAqjxvxIRM3W4G2JgrOlJj7I5N/bXsP6nJ1+g1HsYpm6C9Di/fb+e3txnBhrgumBbuc/FNAeQDY0GcU14GojFjGLKY5w5Y2lGbFiGIS4AzvK3J8KDSF4pBrBNN1oql4Mjsc/Ccg74Hx2WPnAFfiZ2VVAmjHO2BPNMHCXbZibudGPi+2Bikb3wjMDzUnMD9WkCNk8rT6lfXrt2bhd4i03kgaNq0kE51zIRn8z0KstU40VlLAmC+X+ZCocVt0JMXVV10FPVHsjrIXYSoj6z9yxcVkY9tBlxXUZiMbIaMBw6ld7Ozmfjs7k3pY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS4OLSEVjTwjrbXsi/mOedoBt2NfWugX8IixKGMg20w=;
 b=tfPpEfALCyb+vtBYIkig4D2G7sCaVWl6vA0arsY59CfWuQlC0eyOxiW7YZRY/8lyF+k5Oza/SFDDRdC6cf3rta7ivWRkAfjZVuDUjXLLNcIWVO3T+mt4KFRrKocLtRUlhDIrVEHaLHmn62m7e0IONlXkKCFHg8evMZ9uR5OYBbI=
Received: from BL1PR13CA0207.namprd13.prod.outlook.com (2603:10b6:208:2be::32)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 15:05:31 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:2be:cafe::e7) by BL1PR13CA0207.outlook.office365.com
 (2603:10b6:208:2be::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.10 via Frontend
 Transport; Thu, 16 May 2024 15:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Thu, 16 May 2024 15:05:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 10:05:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Adjust logic in amdgpu_device_partner_bandwidth()
Date: Thu, 16 May 2024 11:05:12 -0400
Message-ID: <20240516150512.2260787-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a24af5-ca8a-4450-9c36-08dc75b9a108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S/uoLJhVjIhGcvLL6xEKfXfogiihMR6p8H9zjgoaVjY6pslmaT75sdHZvWIL?=
 =?us-ascii?Q?b5Cz3wgsX/yoDBSyeRYegWiIimLKk8X4GasUMBGyJD4EZOSeV9odnimrekZ/?=
 =?us-ascii?Q?LPNNCePQ2s8EWj+CzcWu3PSJBtx5G1LuY3TSAZz0q/8ZalcLGt1pu7MbrrFc?=
 =?us-ascii?Q?IJnSJZzaNTkant/D4azONkLclbYDQd+ZbdpuYJP9Z6qjpWyS2UTQXyFMTmMF?=
 =?us-ascii?Q?7p0au1/Q+j/AjmbwanmTAjsIDcqA1v1B4fgDZbo9KE+6nbp8xBeUeAWmoi1j?=
 =?us-ascii?Q?l6jTXFKlbtKwoe2P+5F+8DydDGyQ0dnBSOUTt6RATZYv1NgpdVNcushMqosz?=
 =?us-ascii?Q?O4pybmwsAnQyWPmhmiKhYWyWhmR6GdpXWI7eUX0xUNaUCp+0wDPuslywTvfr?=
 =?us-ascii?Q?9TvsRJwDN8DiHl4hI64LIvU6UzCQogV5lklS0BEKUMQ/OJ+nFZAcISfT06pp?=
 =?us-ascii?Q?engi2dOmrS0/NGKgzQE5vv2migJLdypbj9+Sv1FK7cnzNeP6RfHvcaCMmHmZ?=
 =?us-ascii?Q?CTToHdk8NDMijRamvsnWBDN3YULhBqvIowWXIANNAuPMQD41NGmv65Igw6Vk?=
 =?us-ascii?Q?pvuyyp5UTBWd3fUpwIarMkxiCV4jAef15UfaKo8PcixFMh/zdNNhUUULh3UD?=
 =?us-ascii?Q?m/Fhx4hgvScPUSNJw0uPi5WQ3dWWrSxX/mjK07Kq1XIwaRqGUX9ihA27Ozdx?=
 =?us-ascii?Q?bjxTPaqGHG5NS35Z1x5v2JINc8Ic/WMPFLZmBbwv7Oxrhv1hQ0HTtklYaKpB?=
 =?us-ascii?Q?+x6c8NOBADvwBIe20vRxQWrGH3PLZlZWMYmzoqaSisdPX9nb+PsCIajcBLsJ?=
 =?us-ascii?Q?AfDUwDJDt8lvnrSqBvNW3C+/d/7vzreiuEIzeY8VfetVHHkPf4ep8ILtpyUo?=
 =?us-ascii?Q?9zzk+x2Xkmprje6Drb7h6KSxPt1leyZAUI+xX2QNWRfqZfs3SHkgah2SmvYw?=
 =?us-ascii?Q?yKHwmsWc01mQswhhqhVwyzUdTRPVhocgWCjMvUU7JW5DOVZO+nyTwa9sK/Ol?=
 =?us-ascii?Q?LS68CXQHNSFhdwiD+sUeK+MMUyBLpJNxMg2YQYfn8ZbCuXZNSP1f0IUQADQB?=
 =?us-ascii?Q?kMxgC62obd1KdD2OTSyB1eLGXN14QXbMuYFeHZJyKFeYhqDErgcbzez4wpXF?=
 =?us-ascii?Q?xgCfsQlmEbMQe2fHSpLq0tnSEVaSG1d1dD+GaffM3P9enCUt1v+8A1QKHFJu?=
 =?us-ascii?Q?Zhb/qIQLpl5q9dAeqIoDwwSiReaQMA9xiBMrMfI3mYVkucwPKab04Q6X1mxV?=
 =?us-ascii?Q?jR/TQEyjEpvwUBOKb1VbHDX8qrAEk34SwYZI93iJbRLrZjAqnE4qsErY1YJZ?=
 =?us-ascii?Q?Y6R/WTgtaYauKewSI3BSvjID?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 15:05:31.0394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a24af5-ca8a-4450-9c36-08dc75b9a108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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

Use current speed/width on devices which don't support
dynamic PCIe switching.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3289
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e72e774d17e6a..f0011dac589d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5946,13 +5946,18 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
 	*speed = PCI_SPEED_UNKNOWN;
 	*width = PCIE_LNK_WIDTH_UNKNOWN;
 
-	while ((parent = pci_upstream_bridge(parent))) {
-		/* skip upstream/downstream switches internal to dGPU*/
-		if (parent->vendor == PCI_VENDOR_ID_ATI)
-			continue;
-		*speed = pcie_get_speed_cap(parent);
-		*width = pcie_get_width_cap(parent);
-		break;
+	if (amdgpu_device_pcie_dynamic_switching_supported(adev)) {
+		while ((parent = pci_upstream_bridge(parent))) {
+			/* skip upstream/downstream switches internal to dGPU*/
+			if (parent->vendor == PCI_VENDOR_ID_ATI)
+				continue;
+			*speed = pcie_get_speed_cap(parent);
+			*width = pcie_get_width_cap(parent);
+			break;
+		}
+	} else {
+		/* use the current speeds rather than max if switching is not supported */
+		pcie_bandwidth_available(adev->pdev, NULL, speed, width);
 	}
 }
 
-- 
2.45.0

