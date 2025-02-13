Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24E3C021A0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 13:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0691610E008;
	Thu, 13 Feb 2025 13:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kqgJm+Oo";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C3710E008
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 13:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ5Y+tigEk6yKgomZMd0iu2JgFytaqiknafVBt/OK6MU8PbGXamFRf18ZNqo6cxVNkrP/XeshGdsmXYiUdbNxW4kcIGVh/SNEQ8WTXdaVubngpmoxnmMde4geTefWA2TPMEYywrwp7VHTmnSWXpm5bD379SKI+TVmIgHc5imDfmbCSymJWkxjIkhR2tp1EcvkNZFXaoQ1R0ODORouLkCs95ggwGvcvLq70H5Ga6rn7EMV+1m3gfECdkY6sHN+RDp9HIifPFBCm6dRBKLDe3RuxqpH0UYsSDHXYdkkUGxmsWPjE8oA0BtaKWoGdoYWkr7BLQy/Piwv3nnrp+h1/o7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2EBdlRHcvah78OBpqS9Ztj1j0mpYXamZHEdXZg4q/I=;
 b=a07DuaKFwSVrBZqLROyrRh1QFqoViDoO1s/CemZLi5ctRF6yNYbbdty6aRXF/AduveH1/ynZtU7LtyIWeMXe9ldJHmeKB6gh6t7cjulOPYiJSW1Q+VZAhOPxi1JAOPSLUxSmXApH0PxobHM6naDmX1gsdAX2SPi9yxIDkaXq+/aLTDfMdvHM4XviV+BTGJkxuyLIV+FmWVAuyMVMvbQyP0CQ22dDizxHkxtyxoKkUq3d9SsiPbKw1mOHOGteAbwP7Ut70HNR6uaeX8ZRpfG+alGCOGdZ/fTIRFJgpJQM9bkBz31t/iis5eSb1HnkxmtWpmeRhmVAagM7VkTRYTN3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2EBdlRHcvah78OBpqS9Ztj1j0mpYXamZHEdXZg4q/I=;
 b=kqgJm+Oo+iKMZ8YGbeyVQU6B26exbxJVoRd7p/J2+BiLxz8PkMRCsim437a2yMZ+6YMdaIbLXPb9dHNhaXgQwj/CRrAlsuaI00nx2gZoo/InSLUD0owmxbfkIHBZ18LRnwA+J70NLxZGWKRxJoin/QHTLWVUMhVAEpBfbZ3Fml0=
Received: from BY5PR17CA0063.namprd17.prod.outlook.com (2603:10b6:a03:167::40)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 13:03:26 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:167:cafe::49) by BY5PR17CA0063.outlook.office365.com
 (2603:10b6:a03:167::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Thu,
 13 Feb 2025 13:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 13:03:26 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 07:03:23 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: Use firmware supported NPS modes
Date: Thu, 13 Feb 2025 18:33:08 +0530
Message-ID: <20250213130308.2028349-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2ad4bb-c77a-487c-b5bb-08dd4c2ecdde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l51QF4y3vln6zHwdFGVkJNd0T4xPsRZx4z1scLgueyb3IrRwTIgERHQ1fKE5?=
 =?us-ascii?Q?YTINgHA8oLWbjkNt777oYQtFfluAhGg4kPAsZcrB3klEHTkBfIteQqsaXlYI?=
 =?us-ascii?Q?LFHbRkJv2NUFEU+lNsqdCepJzQzMoK4mQNZvvfHOKebuPndwZWCio2Lh3W55?=
 =?us-ascii?Q?PYS+akrMEam+Gq4n5cfS0Fnb6Rqr01I8N4zFfFuukaNy0BrxIrdCOt/KSQ6B?=
 =?us-ascii?Q?4epSgypkrOqWMdTWMC6WkBJ4/7mw40w2FSJuCDWC843GLYo4OPYHMXTOm+fl?=
 =?us-ascii?Q?vyTHcYEy7ZbY/lTSRFuacUhrbCNpAySn7pljxjhC0ccfC8E17mxkU1bgC/Or?=
 =?us-ascii?Q?YOUPQYpzmJkQVJe3QAFdciHH51bwwSk4c5uY0QepiCCm61j4oLEQlSlPMMdD?=
 =?us-ascii?Q?m6vB9AO7eZoHwoLLQcSNs1kEYCmBpLTFOIWMKWKaAED7ymq2DtBLeJjTeI4x?=
 =?us-ascii?Q?8lm+jlZvc+1CX6nJgUWa4zP4kraBL9byXNu+piGfRQ3WkGTwpZVS5YVir1BN?=
 =?us-ascii?Q?624UTxqnaVocz/IPGnWBmTILspbFVeNOqeid8Jw4WNsfvynGphZdaiRcV+Ny?=
 =?us-ascii?Q?c68wPKOVbf35oOq31nU5JH4Ogiv1CxYz/LimpTT21LbyuwL0U6bl9fw9DTxL?=
 =?us-ascii?Q?oipZbLx9smdz/dghoHV44qpKRv1zoB35e53/FMIeDjOws8Sn500HTel8+7t6?=
 =?us-ascii?Q?tXOYT1nSwS1yh6ThZPIViTDnna4sTrssc7pGwrFd8eBCNCbjAfMf8xC3w2pi?=
 =?us-ascii?Q?EFkGVvMCMzlXij3KKJpRZ16pi5cWRs9gEVuCFr7B6np/1jvy5wAlQOryM8l9?=
 =?us-ascii?Q?oxeGu3A8OgjYK5rzC6D/Sr59Ju6P71UdSjWN58dKfymrgFDBUI6vkfrdgUnx?=
 =?us-ascii?Q?c8IirkO5En98L/e0kdcyBUwryQzVZ1ho6INPx+9+tZTLJtf1kBkISFlBSqU4?=
 =?us-ascii?Q?sA4ez/ruy2YydahK9RqaZB6D3pQSC3rBBQ1q3xJ2jG7ebA5R0mjnYvJLtWBW?=
 =?us-ascii?Q?4x9ZWjwD4tLSv1B7doBG2qCXUkYrufXk/E7cHtcZZj0U1K9g92/mpon5L27S?=
 =?us-ascii?Q?KcwaNpYNi0d/hbDuz7YWrkN8BDEBrHHdo2r66hsLWCndXdD9bGdQ/bA2nrsO?=
 =?us-ascii?Q?HWwRF8uLb64SgkqezVn70yS0dHaF459Bfk3Em53AOup7upt2iNdnWXnsLyZS?=
 =?us-ascii?Q?v+Qe8YVLf1CYip077wv+fIxeB7YUIA/AOJD/Gkg/ksMKm9srpYqezp5Nftcb?=
 =?us-ascii?Q?HfHa4WCX+0GarrnXcr6U+vY2634FkiRRYjsEfOIUpe+iitHn51WOyyCuBzhw?=
 =?us-ascii?Q?CP5m9jerBCvyD9P0HCgVbyV+aRhyRRtd4PntvCe73eOOTL6sMDEALzmRQYAg?=
 =?us-ascii?Q?eH1wXHEq1QLpGq8INkFVMg3d3e+rclYIiP9gZyfmCp912kB3xB4PAXlakYxi?=
 =?us-ascii?Q?CdlDKTmZMf/U476eLRmHhDT4WU9dlf2IeG5vD3zRAXtHIiZ2kWDssSJStzP8?=
 =?us-ascii?Q?GaSo7UKouMszIoA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:03:26.0890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2ad4bb-c77a-487c-b5bb-08dd4c2ecdde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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

If firmware supported NPS modes are available through CAP register, use
those values for supported NPS modes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 36 +++++++++++++++++++--------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2aa87fdf715f..4f3ce6d22386 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1594,23 +1594,39 @@ static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_init_nps_details(struct amdgpu_device *adev)
 {
+	enum amdgpu_memory_partition mode;
+	uint32_t supp_modes;
+	int i;
+
 	adev->gmc.supported_nps_modes = 0;
 
 	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
 		return;
 
-	/*TODO: Check PSP version also which supports NPS switch. Otherwise keep
+	mode = gmc_v9_0_get_memory_partition(adev, &supp_modes);
+
+	/* Mode detected by hardware and supported modes available */
+	if ((mode != UNKNOWN_MEMORY_PARTITION_MODE) && supp_modes) {
+		for (i = AMDGPU_NPS1_PARTITION_MODE;
+		     supp_modes && i <= AMDGPU_NPS8_PARTITION_MODE; i++) {
+			if (supp_modes & BIT(i - 1))
+				adev->gmc.supported_nps_modes |= BIT(i);
+			supp_modes &= supp_modes - 1;
+		}
+	} else {
+		/*TODO: Check PSP version also which supports NPS switch. Otherwise keep
 	 * supported modes as 0.
 	 */
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-	case IP_VERSION(9, 4, 3):
-	case IP_VERSION(9, 4, 4):
-		adev->gmc.supported_nps_modes =
-			BIT(AMDGPU_NPS1_PARTITION_MODE) |
-			BIT(AMDGPU_NPS4_PARTITION_MODE);
-		break;
-	default:
-		break;
+		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+		case IP_VERSION(9, 4, 3):
+		case IP_VERSION(9, 4, 4):
+			adev->gmc.supported_nps_modes =
+				BIT(AMDGPU_NPS1_PARTITION_MODE) |
+				BIT(AMDGPU_NPS4_PARTITION_MODE);
+			break;
+		default:
+			break;
+		}
 	}
 }
 
-- 
2.25.1

