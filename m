Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A682CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB91010E814;
	Wed, 29 Oct 2025 17:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U0T7smYa";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0425110E814
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZ0d8Wuv9LPTsKlSoLYL93iddC1whKs9RI642X8rKEEiLo8WF6z14vB1Sdfy0ESBksGeMm4fdDasPd4/XgtgyG2Ug8j8liARtrbRI3QjyGtHOD2aZuntXK2bbptD/LPBYQdbo+AJ2AoOsGY3jyp4zAsidLHz0NQvqFUJzQ/8OAhmlgN6EtGMWSACNvg6mUy4uxtd1iTuSqHmVTcBCK4G8R0LAsgiN9kIlBNneFcoBcaDSXylDFriXz4GTIJTWAVS3zGJAVOewRn0eAx2kMZiEOyXVoi4vwd1nXWV2ARI3UQgdslTQv6Y/hzEksR8fYouc8HynEzvJ0hlC3LjKIlX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWKB9+LJ3f0qEx4LEdyzy07NXYJHXmLR698KJdQm7bo=;
 b=t/QNEsjZ1T/z97kruHC5/e9fbzH9RfDFqHdzuydQMy5spESrz4g1J0ksMOwgjbnStjnqKGvYanjyxm6aWdqrp6JIBIOD81xGuk/4a7MehLebsOi2qSlwF6zVRobrqPt0/pKgo/PU4oRc7tiTqtD9npz0hvLaKzkz3ISu2jdOc5pdJ+0Jn1pdvRLt4aWVKNarKDhTu3Oq65Bfm4iKv4hZb/yXXJgJ+UO1a71WWvpF6G7LZ7a0iTiAK9/mbKboCaV1ewNVwOE/3tAPd8bLf+mGU2EgeSv0wUOeuDhHXSHzqvbZ0X2M0T6k7eLgePmsLq0MddpXGqDuF1plDoyobW3SiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWKB9+LJ3f0qEx4LEdyzy07NXYJHXmLR698KJdQm7bo=;
 b=U0T7smYaFloB8rP4zCrmuo3RztUTCpeUi/T1Cfe0rIcwrZCuqp4gl4foq3McHN2Z2A9Xe9vK9asPE6AnBMMT/mnT1MV3TiEPdLBn4JasID1DEI/jpH9TMh9ky71TPMesfO5PGHps3dXx7Lv+caRJhXKGUNQ8eNbE8YdNL5f5v8U=
Received: from MN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:52d::17)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:54:13 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::68) by MN0PR04CA0026.outlook.office365.com
 (2603:10b6:208:52d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:54:10 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:54:08 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add get_gpu_clock_counter to smuio v14_0_3
Date: Wed, 29 Oct 2025 13:53:52 -0400
Message-ID: <20251029175353.2861924-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175353.2861924-1-alexander.deucher@amd.com>
References: <20251029175353.2861924-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 39533774-2c4d-4495-436b-08de171429c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b9X6NrojFcqPJHGw3Ezp+AHE3t1pcsl4vua5jpShLOxze+CA+PPEamOv9V7x?=
 =?us-ascii?Q?ngRgv9hDp2a1GE1vRdeChdLNN/UsYOgiOf8ftBT5Du2ScGs8K0sDXVJ5bmz1?=
 =?us-ascii?Q?/uWV1Mh+cxAlyMjvpOPcMB8DslxehZ0sGGoyK4Fgl8wutz/oON0346hMygkA?=
 =?us-ascii?Q?7lN/yZKFHoNar7Prz7p00IACFkxGv2ke5DB1Gp0xVyAJguKH1c7livK+h00h?=
 =?us-ascii?Q?wG5oDu6TcRm2YjApw/ZPTGgQOSk2y8X44E3NSJKewP+ssfAhgeuaz5ONnl/W?=
 =?us-ascii?Q?1c5qopSqmqh2A4ZcOMKQWH29D+UMdLSUAkWN85B+M7Y4kZXCLRndOZrauUj2?=
 =?us-ascii?Q?oJy0IHHEWTK7wMJezfOEwnCcO4zflEdRDxY8xniqBvnPFXw1IorA8CCVmPBr?=
 =?us-ascii?Q?uqAOEvD9RQpnbyEcIABrrvtgRvz6A1aEP96nJ3AEiWo9TiqpU4+z2wFHmszZ?=
 =?us-ascii?Q?PtgBmR9XMM89PgQAt7fLMG3ec6YKOnfgbI7w4aRWT6qLsnAyDxZZMCbvAN8d?=
 =?us-ascii?Q?pLZ7pVTaVEX6aR+Xo9p1AncLI/l0wzHc4k6NzpUt0pggbJdIUIShennlVegM?=
 =?us-ascii?Q?N4dfyUL50OZX0248ls/iIWhrDgmlk4n0KLf5826iCdm2hkQnHMhlsaW8CkI6?=
 =?us-ascii?Q?8aCq+3UKtvQn/PjnPCNKMVpBE2kP+zlqKC8432XAAMbaAfq4RF11/hukbZHp?=
 =?us-ascii?Q?2cK2F55d6gkHH3s0n9C6EEJYSYvhmBjgjbjzjhChuYiO3oJYn4a3V0reYEPB?=
 =?us-ascii?Q?DsnU0DlgGk8HLn+WH6qqPQ04quevo03KDctA4frOPrLmnZXO48gRF3uKKIZa?=
 =?us-ascii?Q?0UxRpBkedGkdrBr9x7xiDgk7dk19pcjh2iYjrYI4jIKb1FtaJJAkiVDvwrof?=
 =?us-ascii?Q?ekHeY1otmRAk0dGlOtZNjMDsWuhanSFvoT27SZuJ9UItFC8LJ5uSUiX80spA?=
 =?us-ascii?Q?swJRF12s0DPxvEYRHVAI7w8oQ7Xm84UmumVcmbjnTu1QU2M3aKA3GTJVNXb2?=
 =?us-ascii?Q?Q1jTfhEI9kS+sS/rupca2xTS95qGKOcjyy7uR8GoSGU9wtDqS5RgOsS8sTcG?=
 =?us-ascii?Q?gi3+udUySr7h/MKn8A7OxLRBHAYmCSDcr+orw5wU6eWm/xbgd6bm6TfNzaeT?=
 =?us-ascii?Q?fZXOQSJVV5MYY6A5VfNyKqaMsAgA12mUWz7PpwXEkaZXHNM2e7tmfeA7yTxn?=
 =?us-ascii?Q?xxrLQBfgMgRtDTTmozlcBUxgyTwedGBPWoD3atto7Oscd9YoMvNtIOFvUPAq?=
 =?us-ascii?Q?tbomQpnhEZyy5DQlDN1NHtpDtty0XEZv4axIbWl1AXZ2xnbUG3dbOKpUlzgb?=
 =?us-ascii?Q?pCA09WuTlsEhH+HJ/nz0aZdhqjtfRn1rI0fHeLHc+jJNhqwq0Nnty7u651u5?=
 =?us-ascii?Q?RXICrOQjo3HxrqP6NBMZ/6vwPe1rx8IRy2PFDWp9xLYc/AZ3KdKYwI8DEV3M?=
 =?us-ascii?Q?zcgvYDIrYknWwoByFq4RQpD6f51Nrx5IfD6QZBv/IrpMlngPZlcIu5rAlauI?=
 =?us-ascii?Q?UlRx8//Zxoh+DuQekzQVOeiL7QNHI+CnPDZ0IoLV2wv3ZMEbcAQFXE5S6nyo?=
 =?us-ascii?Q?m426+1m8fdgaL0DoVvQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:54:10.0253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39533774-2c4d-4495-436b-08de171429c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

From: Alex Sierra <alex.sierra@amd.com>

Function get_gpu_clock_counter missing for smuio v14_0_3

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.c b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.c
index 804b7458b0661..f48ef572d9b41 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_3.c
@@ -44,6 +44,25 @@ static void smuio_v14_0_3_update_rom_clock_gating(struct amdgpu_device *adev, bo
 	return;
 }
 
+static u64 smuio_v14_0_3_get_gpu_clock_counter(struct amdgpu_device *adev)
+{
+	u64 clock;
+	u64 clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
+
+	preempt_disable();
+	clock_counter_hi_pre = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+	clock_counter_lo = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+	/* the clock counter may be udpated during polling the counters */
+	clock_counter_hi_after = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+	if (clock_counter_hi_pre != clock_counter_hi_after)
+		clock_counter_lo = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+	preempt_enable();
+
+	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
+
+	return clock;
+}
+
 static void smuio_v14_0_3_get_clock_gating_state(struct amdgpu_device *adev, u64 *flags)
 {
 	u32 data;
@@ -184,6 +203,7 @@ static bool smuio_v14_0_3_is_custom_hbm_supported(struct amdgpu_device *adev)
 const struct amdgpu_smuio_funcs smuio_v14_0_3_funcs = {
 	.get_rom_index_offset = smuio_v14_0_3_get_rom_index_offset,
 	.get_rom_data_offset = smuio_v14_0_3_get_rom_data_offset,
+	.get_gpu_clock_counter = smuio_v14_0_3_get_gpu_clock_counter,
 	.get_die_id = smuio_v14_0_3_get_die_id,
 	.get_socket_id = smuio_v14_0_3_get_socket_id,
 	.is_host_gpu_xgmi_supported = smuio_v14_0_3_is_host_gpu_xgmi_supported,
-- 
2.51.0

