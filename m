Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE1AD5E15A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDDF10E95B;
	Fri,  8 Nov 2024 11:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HCEj+T8X";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A0410E0BF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGVaClPKRl2h9UnWi7775d0EyxzPWexWoWhdXM6wrWsw951mNsW3pL86CdYEB0xksKo1JylhogDpF4nC2rxQq8Q6wXdgIvs0ujTv9Y0f3lA43DB7KCsQoGqv0GEdOFJy8NEF42k9Vi/63ckwHNE2QVyLTlNrIcIIhDJ/EDnmTDqXWud8s5iooWebrcLhxlzhyYQFDZvfqCZ5k+BOclLgTwKi/CwN40y5Aai/B4vwz0Cb3tnbHqslREaqLc3ICdjg4nOnXNnvMSXT26G6P9NRirlSuFWtxT3qZu9Gj/Gu/nHvqrMQBUy02mfRYR+Lj6u/juXeBQmxZcfFRNjfENOWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uWlS5sxjeglf5Er5ytBbh4X6EdE7w9oDxG/5bCtLHs=;
 b=ks2llS+C0MtH3DbX8eKwYHCL094PhDEahP8ryN9vRSP0/F+ZVqK8ZSS7FuIQD2UYEaILw2rPdJBPYr1QhBIUxFCwyUhm6cJZ8bQKFI4C1JD5is7mKx81aOlTfaasJRgqrgJ1QOoGJEjzVGEApnDFx6y1YSI8ryq4amZw5XglVwbtwSM2DR5mGGe8chLXogNU0ZndlJ4vH5jDIheMT/yqbrKoGEXZ6ziE+1RiWbTNCwcGl7hDIZ/xu4otcGil6GXjjPsQWPrl0vpItWO/cgfC8gNha2EHBXkz7qR3ihD6S8uC/0inzapBT37Omh9C2XA3r9ipECNepMlOUX8VNsdVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uWlS5sxjeglf5Er5ytBbh4X6EdE7w9oDxG/5bCtLHs=;
 b=HCEj+T8XqykcnKYCtEotBM3T196ZSooulh9Hf5keIsGiYl97kigAIqNMYQzhVwSc+rgORnDIw3YwWpd2qgW8BoFVuK/kShNMFlyufRhJ69QQsjihxacbadPFxhSgt80nWLjyzZQPnzuHdxzN2RZLEdz+a8jDRX7g1amMTNPFpDI=
Received: from BN9PR03CA0262.namprd03.prod.outlook.com (2603:10b6:408:ff::27)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 11:14:59 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::73) by BN9PR03CA0262.outlook.office365.com
 (2603:10b6:408:ff::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:59 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:57 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 22/23] drm/amdgpu: remove is_mca_add for ras_add_bad_pages
Date: Fri, 8 Nov 2024 19:14:22 +0800
Message-ID: <20241108111423.60169-22-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: c96af464-fd6c-4c23-4c48-08dcffe69540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r1bXvQJioP4HZJEc6Yk541SGBrgPHe56t7l9o6sc2vuJd/o0XFZz2y0A+TGz?=
 =?us-ascii?Q?j68yLybo+nGgmPDSaHjd44iaXQ+PZic9oU1BxyTIFgBylR2qj/DAATwjN5OT?=
 =?us-ascii?Q?5qFa63LC4NklOEB0OnQ377QvMOtvJNFsu4a1xe4fVVp2XeSNTFnERjqn4XX/?=
 =?us-ascii?Q?XEY8p2Wk1rGma602uw7AlupfoISun8doYjUt6Ptk2qtlz5TXlmZi+xAiR27F?=
 =?us-ascii?Q?yNmfJtz+RUDE5xR5TP0bx0o1seDVow3ce61r5FmVGKLN4qCURTwhs6kKH53N?=
 =?us-ascii?Q?R9A41d5fKbwCuDRCivgYxu7E4wY4fgVCAlN+KzZ1MvQP7npU4bmD+p8EnAU3?=
 =?us-ascii?Q?3WgVHr7v2CPUis8zD9ri9neQBdK1Mb0R2leXob2bw/+YJPJAjLyUcX1t6hAM?=
 =?us-ascii?Q?G1jMaT3uk0ZWiNxTyFMF1lOnj9Zu4QqCF5GxnVmNsiJ79Flgq150Sem69Q2z?=
 =?us-ascii?Q?zm7ugqGd9lTV2tgRoc8vBsZeO9aKtYmSxIqKQKR7YPbRp9WWS9rBDJ4l9nfb?=
 =?us-ascii?Q?Aw6qOgGndqtr9++lWt3XALzqy471qbqKBpn90oVbRA8MJCEj1XDJDUME6QQE?=
 =?us-ascii?Q?mKM2jSXa/qoANCtTNhWEeleLkDjmxAtqWmP9DHKvTuGMYRzO768sPfN785F1?=
 =?us-ascii?Q?h7V/7oMbpDndxKFfGL0JWVtz+kJDQKVGrbfy56SLndn0aEiHHCXUnacSPE2w?=
 =?us-ascii?Q?Qj/H6pekzoomuZwOb1zuv9v/4/XXbL1eYWCyhPaNYjhtjluiA+WeBONBW4nT?=
 =?us-ascii?Q?kyrzZvuFJhU6Y65LGH+Xew2vTvDhDI2VJutwrAftDcuNWsJGxxWH8k62wRH4?=
 =?us-ascii?Q?bDvdEPpEF2mN+3QAhPWOPh/1hXXDb5OdkhUKOao31DvpIL0Il0rXtWGqHMlv?=
 =?us-ascii?Q?Ur1FharE5Cpj2MZDJN2IhzWMoJmdO4cAtUC7W3oqx/tL5ruNP/KXgCFsvqhF?=
 =?us-ascii?Q?2jABgOeI/JeC7xucJW0eyFDxjdgq2/pEdLIQBSFy/SfCV1gGAPUEfgR2P3XR?=
 =?us-ascii?Q?3NFRL4vXn8WRbbEnPCNyNFLrolNe+dVJefBGd+Rsg8JUcNnQNVlQDQmUtJ/q?=
 =?us-ascii?Q?Uynz6HKOR8QRzRG5d+tPfhBPDhBl4gXyB+lqJ4myEpGB9iAUyVFYINGSmPew?=
 =?us-ascii?Q?7mrEqiQNei8/OInlNjL1JoHecbQ2ZpWkXUzTv2EeQtJixvanlyvUPp9+rvlZ?=
 =?us-ascii?Q?Da97z2QF8SNcIIOzROMeMfH//CF2TS1YUzyflkWqaJRSu+GUcFQVBX+jDSBG?=
 =?us-ascii?Q?pB0/WxH0xu8R96jgKsOjjgPS/mX4q0JCQBxbXZNTZAYIGMEjcAadfBLb2Eoz?=
 =?us-ascii?Q?h8g2NMclf4UEzYI3PJxPFaVV1A5nFMhDx6ohSJkwPaA+Rmtfdu/qLtArDk7k?=
 =?us-ascii?Q?GCpKoznVkx1fXD+0yk/9fzKGbvW+/dDjOlVsyvNZD4ffqwa8mw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:59.0722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96af464-fd6c-4c23-4c48-08dcffe69540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
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

Remove unnecessary variable and simplify the logic.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 324c71d99175..966a9fa3a3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2744,20 +2744,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	int ret = 0;
 	uint32_t i, j, loop_cnt = 1;
-	bool is_mca_add = true, find_pages_per_pa = false;
+	bool find_pages_per_pa = false;
 
 	if (!con || !con->eh_data || !bps || pages <= 0)
 		return 0;
 
-	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr) {
-		is_mca_add = false;
-	} else {
-		if ((pages > 1) &&
-		    (bps[0].address == bps[1].address) &&
-		    (bps[0].mem_channel == bps[1].mem_channel))
-			is_mca_add = false;
-	}
-
 	if (from_rom) {
 		err_data.err_addr =
 			kcalloc(adev->umc.retire_unit,
@@ -2781,7 +2772,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		goto free;
 
 	for (i = 0; i < pages; i++) {
-		if (is_mca_add) {
+		if (from_rom &&
+		    control->rec_type == AMDGPU_RAS_EEPROM_REC_MCA) {
 			if (!find_pages_per_pa) {
 				if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data)) {
 					if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
-- 
2.34.1

