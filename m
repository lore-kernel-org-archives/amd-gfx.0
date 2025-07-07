Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEEAC8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 07:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5794110E425;
	Mon,  7 Jul 2025 07:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bYzP6cGm";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCBF210E425
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 07:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6TG87zFJ1+87dX5oSOwW0QKCLRS7qZj3SsSczVosN41S8MVk8P63rMmEUx1TysglnyrYWikphU1ljCDX7s52JUqSqHRQotBKnoicy8WK+OOtSRkYB4T6J3t98P5YrQf5CT8pY9BzhBEvYgJQOivaOx2CBhSgNCJBa9hcLfPd/nWmsssBprHDakQiagYqRevgl+v75mogFCCJPeq/8npEiTjcgX2FAWkLnwOniYUTeGdNpPwAvLlP3bY6PcY4UKsUiQ2+dYZ77EOshwaXnAvFmaig8ygw3a+ZGXp83cpwGdXB7DGypuywT6qrml7/j2AlywVS6pNW0LCAH14Qd/usQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmtjNuKnXNGnwATcu9l9f+PW9MrORF7Y3ECePKRPtFg=;
 b=BhMblaUcCmHrIdKLatEteu9KaEtBfUoYw+3teKFXA+ifnqpDPCbNnslLWAr8ZKvEzVul5Svg3ZKeAkyVsba5OiU2pz4qBs4XvO5zuv4F4zA/2AbybPXqr/kYY/0SBQ+1AieFbkb9Wrv5tWffwz0J6L216AvF32dudkBypawLndIRHDOF8pHssZtVs3VSRxITqpmZ+SSCH96plFwfxo2VoCA5kElQn0IXg2tUDq6zbBipaB86qn8O44ChLvvxCKWqLASHeBQ1ZNRsjDJyIqWiG6NCi+suDmWATyWRktvilGZx+dYkftl7/Pr44Vg3MMN3jrTPwVawd2ye2ESWGgYdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmtjNuKnXNGnwATcu9l9f+PW9MrORF7Y3ECePKRPtFg=;
 b=bYzP6cGmUG+dS6qcAPfhaKiWsqqiwu/AqyGbSnTHqxswMoHdjVbppOKXdg1L4ohsKPQITwZIwwJDfkzZBUBOuyxdMTaQ7lVA1KccWUgZ9MkZG2XKtkvN1PzBRNUdNyjQQG7P0zTrHAlPhYW/mOBqlsYSxgPO30qG8zTAGysGnj8=
Received: from CH0PR13CA0008.namprd13.prod.outlook.com (2603:10b6:610:b1::13)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 07:10:31 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::b0) by CH0PR13CA0008.outlook.office365.com
 (2603:10b6:610:b1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.19 via Frontend Transport; Mon,
 7 Jul 2025 07:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 07:10:30 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Jul 2025 02:10:29 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: refine bad page loading when in the same nps
 mode
Date: Mon, 7 Jul 2025 15:09:39 +0800
Message-ID: <20250707070939.6852-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707070939.6852-1-ganglxie@amd.com>
References: <20250707070939.6852-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c565b33-6aaf-44a3-816d-08ddbd255bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A0uVYQdlEtuS24W7kdaXXAwOqTfmTTu+pkMahqJdOk44nS+EeaOEDqxGqBkr?=
 =?us-ascii?Q?EiueU8gSARP2iSAeMCrbeCOhKUAQUpPPvf5ZtH5DEujWnBP0huFwWO2qTVjF?=
 =?us-ascii?Q?/dnq6O0Pm94Z4hJTcaQ60D7xX5nYIvx0QqL9ZTWciJkv8V6dcEz84tZKgmcV?=
 =?us-ascii?Q?vsGQm3q8W2qKUOVv3pq4OYgI5A2bdK1j5Dcd9Y1QdJ7dPjAj3rhfeds81HeN?=
 =?us-ascii?Q?NgDOnQn8/BOqIN/QsrmUzLUt5pRYaSGQ01nqUT3hTrgQQemj1veVng06gFSM?=
 =?us-ascii?Q?rOUCO0zsYrzd/r7+hRf+f2VHoRzQ+tw0DBL45ovDJUbXtooQVr2VJkDUWOc8?=
 =?us-ascii?Q?6O1RpgwOJDNqHhkafrV5BQN6+94UFfrTtgcazS3TxSY/x5CstIxQJ0tb2lXP?=
 =?us-ascii?Q?xIohnOEDpVU5nxVieyWVnItE9QlYfCDe5hPCrJ4lIDXSTho3hZA/cifYW/+7?=
 =?us-ascii?Q?XXapOzS0M3emt266+EMz8jhj1ZsIh1bgczvKSAaQj+F5K7QvnXZO3y1Mk9h6?=
 =?us-ascii?Q?dvNrdU8fhlVju2Mr4sjmYdAOngHxTplBAjWDO+SYgwKrldLnLLkT/ce+hT7K?=
 =?us-ascii?Q?XyAGhZPnrmksQFxoSNaOR9F8qSdxK9L26QyyGV22n/+Op3jeQOTJAEoS9T4J?=
 =?us-ascii?Q?Ki0eRC0VS2oNwet2msl0jg6Rv09i2w8Ywj2f/SrKCyV71RbnU6UMxQOD26fY?=
 =?us-ascii?Q?OCEk6cNxJlXMUm2233Ojn1QHnykKxjbFu1+2syOVl1N8J7hjHI0oZZBs2JZR?=
 =?us-ascii?Q?GOr2nMG1/k1CKHqK+0e5D8bmY517pRN6gsjvYNVbSDLCS2CArrtdBLp3U9DA?=
 =?us-ascii?Q?QTFkRbEww/hu7H9kjaieH9VyVnMeG12eRloBYM9BCelSHycFdkXM2U6kNhYH?=
 =?us-ascii?Q?C4au+Oa8oWghs0xN4eJjwps6HrvUoVFCLw36b1C45fvR0+NRK7L/gwrlFI72?=
 =?us-ascii?Q?hkoYj+43zBlYx9wPuFgFA3HDL/yaXjIRylWNylxYuIrRqJPyxiiJB2FE3kOL?=
 =?us-ascii?Q?a/8+T+R/aiWEd/pWJU/7I7PhbHGMQz9xWPp0YbJRpQkGBaIwl66gByoMIslj?=
 =?us-ascii?Q?SWKx9C6xpoChFPSFUyLdekOQuESlNJCv3/KYQzX609DtLMs9iKVUoclmjxF1?=
 =?us-ascii?Q?MDdIkC9puC2ZyJor5ApgjrweUp+WiT39Gi5kMM4F3DZFdhS6vTo15T2mtBDT?=
 =?us-ascii?Q?6RJcSIInPfdpjbEMslI25TB1IOPqnMr+tPDj6nGW4gYa9QrhwSwzMkmr4Jc4?=
 =?us-ascii?Q?UpGs6Vkavb1I21E5ikz0wGgznj6Ky7XQicOOihdTKAtBoQSqH/YZKidFAvpp?=
 =?us-ascii?Q?XZ3bOMY4tcrOXDVFGOMVMAk8Lfgk+uWu9b4clrkOdA8ReJEopAWhx6bUZ2+H?=
 =?us-ascii?Q?kUTZ1jz/RKzrvmcQWhxKRW5081Z8DTG1Q4kX/bIi0thXq6GQxEY639XFlUeQ?=
 =?us-ascii?Q?yz29XGwzSuyLNmREPdap3KvKxtHuSWNzfXu3/c/270Tik+w82D1FCHSORbt9?=
 =?us-ascii?Q?9kcwg+put9ylKHno6P6a1qFJD/6xKFX0ZaHK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:10:30.9803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c565b33-6aaf-44a3-816d-08ddbd255bef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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

when loading bad page in the same nps mode, need to set the other fields in eeprom records manually
besides retired_page

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e03550be45b4..e02af20e6204 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2861,6 +2861,13 @@ static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
 			if (amdgpu_umc_pages_in_a_row(adev, err_data,
 					bps[0].retired_page << AMDGPU_GPU_PAGE_SHIFT))
 				return -EINVAL;
+			for ( i = 0; i < adev->umc.retire_unit; i++) {
+				err_data->err_addr[i].address = bps[0].address;
+				err_data->err_addr[i].mem_channel = bps[0].mem_channel;
+				err_data->err_addr[i].bank = bps[0].bank;
+				err_data->err_addr[i].err_type = bps[0].err_type;
+				err_data->err_addr[i].mcumc_id = bps[0].mcumc_id;
+			}
 		} else {
 			if (amdgpu_ras_mca2pa_by_idx(adev, &bps[0], err_data))
 				return -EINVAL;
@@ -2893,6 +2900,7 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 				enum amdgpu_memory_partition nps)
 {
 	enum amdgpu_memory_partition save_nps;
+	int i = 0;
 
 	save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
 	bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
@@ -2901,6 +2909,13 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 		if (amdgpu_umc_pages_in_a_row(adev, err_data,
 				bps->retired_page << AMDGPU_GPU_PAGE_SHIFT))
 			return -EINVAL;
+		for ( i = 0; i < adev->umc.retire_unit; i++) {
+			err_data->err_addr[i].address = bps->address;
+			err_data->err_addr[i].mem_channel = bps->mem_channel;
+			err_data->err_addr[i].bank = bps->bank;
+			err_data->err_addr[i].err_type = bps->err_type;
+			err_data->err_addr[i].mcumc_id = bps->mcumc_id;
+		}
 	} else {
 		if (bps->address) {
 			if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
-- 
2.34.1

