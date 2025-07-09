Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE911C83F09
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jul 2025 08:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 655A710E762;
	Wed,  9 Jul 2025 08:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AiAgykk8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A073510E762
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jul 2025 08:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0dHKJUymKAiJHpLPc6ZgdFSNkvZPsA5skPdg4YYP3gWUNxho9t8VywK1yTzmhx7fIUSa1NHTEM9zRpXgxQvXN5fMATf7MTDD3rOrznwPHut96jeHWz/kFH/IrW1+UQIGivUs/31ynMpkWnBf7OUEwlO8u4ivJyTiQ06jGbiHMRT4Nj96iAdYt2zS7JhSSOAuE/e+C0INed8sgKikD4xkdvETbIaz0cp4DuoziesxAysCgDEtPbSQUWxQXRlKPpuctYKysqPlsp/GDMgEKNWfkfk6+pstI/X+MVs1WXOvTUEu5b7+vtP47uUKOCX/j0BhRC0BHQbz3i3XqOmfalsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNVLaTt4Ma87GWttaqBPmsoslBwKmjVjRL4GuAUMoPk=;
 b=vmCJPMMbyr084OsWuuuxoM8AfDoD9qDyyGY0mgeXs/86JP2PkdZVyzj9q5o9TyDBL+dmExrgd0BN63ZBVv/1+jcwkemjdp1YNl+t1rcNzhE3hqJ++blTfgTZ71CMDhpLnlNW/ZUWj+YMw5yN50Vq96Se9Du2E9t4QqSM9pUXSl6fcfDYRiQ2wrsV+VXhYWJT2egzLXmbygIAwU6y9Sveefi939QK6J1rNO0+0DE8mB/+YlS+sDPedp/Emsqvh69JjB8CVCAUgMhaqPeCj+Adwz4/SCq3SN0AnF0WoQzpqoi9h2bV21ch6P0zP9/CkRJTOs+ehr7hI0i3qBJdljRbvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNVLaTt4Ma87GWttaqBPmsoslBwKmjVjRL4GuAUMoPk=;
 b=AiAgykk8TCiWPZnCMQlfrVi077F5vMSNZqyqBoEhN4C+zs/A+h/OMmFAR+65gH5J8YZ6caeyVRuDbBVB9848NLPRN1rbC+aztgBhv6KwJnB6h9jgcVxwRMxcVWEEjk4ugUnNXR4xsf26Gggu42cKMraVM3pKztHtRm5DYm265Uo=
Received: from BN9PR03CA0151.namprd03.prod.outlook.com (2603:10b6:408:f4::6)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 08:29:50 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::6c) by BN9PR03CA0151.outlook.office365.com
 (2603:10b6:408:f4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 08:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 9 Jul 2025 08:29:50 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Jul 2025 03:29:47 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: refine bad page loading when in the same nps
 mode
Date: Wed, 9 Jul 2025 16:29:15 +0800
Message-ID: <20250709082915.18904-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709082915.18904-1-ganglxie@amd.com>
References: <20250709082915.18904-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: 644c36c4-77d9-48a1-0d7e-08ddbec2c5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2HYuMpC9MBoGr2B4DZ7BUYGt6WokT2VHMgWpxdYeoJf2Itsob79FzLkfnDKa?=
 =?us-ascii?Q?eGFjp/ckLpiF9cvtznHH1QYWHIHApTgr8+qzw/5XqohbFnFl3z3OVrPmzvej?=
 =?us-ascii?Q?vR+4FBFKeci8oFezWe7kABz9pS/q8hphVLaeS/OyNejZ8Fxx3kKqHgUPm+3U?=
 =?us-ascii?Q?zotCvmxyyzMBP+uTIjPngW0j6MbyXQIHeC6jf4EBHshjaMa0XzRBOshGY+dL?=
 =?us-ascii?Q?x5x1UnVLmCqnNVnLpAqIQ1eYzP8C4Q2bfyvABnmjD7m9ZfOMpwMu1yaXttvk?=
 =?us-ascii?Q?Egl2FEjEuMzasL6JnJkHWn0Yrqa39FQrTH7sjQTx/BIoJUWppzKlwWzihJ1k?=
 =?us-ascii?Q?b4/NdrQc3jL38HGyIelOOkANmo28ST63JMhSBY8btUHehzkQmlZUttw0oOS9?=
 =?us-ascii?Q?Mc/+CST5NiK792zyV+K3gwtVVag2U9r1mMjOf/m86D1Yr11hbeobwbml9QFk?=
 =?us-ascii?Q?0AbKvBtGertUwJKVgMNKNDYYo7lA2ihI1LJDjT2ZvinEej8UqFCiY1wksrI5?=
 =?us-ascii?Q?8QxKoBOw8mB5DIOBNe6TTcacqO0gAh6kel7ZjY5TQyfU0l2PBsKTOAHI388G?=
 =?us-ascii?Q?Pm9zegZ1rDieQKyCj/VV6YO5CWBQK8T4M7LrW8benY7p0kQOE9NOb2zoDOnD?=
 =?us-ascii?Q?LuFBqeu9u8NImj2iTX63TewZqxGZNxopHQLz8nR4OuGp2hKiPIngqHhDmLE6?=
 =?us-ascii?Q?ZgoAMG1eUtBO8WMNzFCgeQd0dPikoo42PUij6djA0mf6RSxN9pxzsjXvDBsY?=
 =?us-ascii?Q?V9D6Z4DVckktwPXluwfLzrNri6QTnaB86WqLlUvm6OCtrhRIy6kS7X6llu7/?=
 =?us-ascii?Q?ja3uHPaInPERg+AHLfHbinnq1aauNq2PVinTSz5LUgBYlofWYlCk73wSzKl6?=
 =?us-ascii?Q?urwF3vfTqGN8otHEwyVTV3zZDkEyz3ZMIAmGnPZREYR6rdk3tIcELs9mAatA?=
 =?us-ascii?Q?SxcRMofvlx72Mth8IQB1p/6ik+LdELwlIYh55cFcvBrXQmS1ELQvEp2BwIjf?=
 =?us-ascii?Q?beXi/9gzV28djMpOc3LsgdCGmgk27uE+wCoSZX3zUUEw3UsrwytK0OsRc+vf?=
 =?us-ascii?Q?U7bPFHpSaKVr/j7j/JeUEaUjEPbji6C33rtEbmTv5c80bJTNpkaMOfDiF/ok?=
 =?us-ascii?Q?+SGXZHGkcSzd0vgUdSeY9X3jj7S4O3vawO4aD8r4qGQogv3ggD0b31/zMgfX?=
 =?us-ascii?Q?VFXRfTw8QMMEafh71iX9+TsiW/GOlx2Fc5sOtRomR2ksdvY1xVkGTAhG7Ayd?=
 =?us-ascii?Q?t/BplnqtLPUhNfEfG7QBB6MPH9dsAWg3g0Wb1q7VvoXK60h6b4tagrQLvTnV?=
 =?us-ascii?Q?Xxgq75oPvYH6UbqmVCZmWg37yYmMZBiHiDTYgqlSt0w1LvGzIMEjWkOg5iHr?=
 =?us-ascii?Q?fMB5BzvtcuGzWM/inhkx6fEI4jyiiVgqoS7tpllVuWxl3y2JzfzKZDTIgWDD?=
 =?us-ascii?Q?EaTOZK1U7o9WZ31WPF0tNBvb9wKME5nFGuiFqi2lixY80hQazfcaG/8YrRyq?=
 =?us-ascii?Q?mfQJyIKcKb92BFz10LV/bgvTW/8d4MbcJwyt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 08:29:50.5306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 644c36c4-77d9-48a1-0d7e-08ddbec2c5ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599
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

when loading bad page in the same nps mode, need to set
the other fields in eeprom records manually besides retired_page

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e03550be45b4..d1180c3d4c46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2861,6 +2861,13 @@ static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
 			if (amdgpu_umc_pages_in_a_row(adev, err_data,
 					bps[0].retired_page << AMDGPU_GPU_PAGE_SHIFT))
 				return -EINVAL;
+			for (i = 0; i < adev->umc.retire_unit; i++) {
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
+		for (i = 0; i < adev->umc.retire_unit; i++) {
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

