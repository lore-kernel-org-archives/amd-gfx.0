Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDE3C87FC5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A87C10E3E2;
	Tue, 22 Jul 2025 03:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T6eWoM39";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CEC810E3DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lg9NVmOAo8P+dxuU3oJl3gUnF0JtYEnZK/Wt/WRflcdHXrJBwfHBG9eDbr/qX3SqvdUVu34E/tYCuMLZ6NE48Fp6y0phsgcj02MWnXfTFbFI8EFm029X+LmRblNn9V8l+NlASfjmva5PSDaK7vhuB6fCJi0jM6hEOEycHdyGsoEI0asTGZ2UoCfw2CNOacTyhInW7r8SadYk5wvcECfgdxlN/zxi/qXzC3K2YfAhLXiwHs4oHqKypVQp107DqjjyQ91VobmCqh6JSsiNZMiG3L+KY/IDs6/Bcwq3LkwQ2/1nDIzGIJ6RX4njwwaQrfgwRYwQfUoTA6xPfEcD/ZsKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTcxkm7DlIBVzKTnjLglKWDDgkrle6Wxq/GZ/GwDVlg=;
 b=ASjjsZP12L4O71IlIjLCeuaN8vvaTxctrRqzqYGE32jprRupoca6659NvSQ/tZ8ARqYYpOQ/xreEXt+gH0YbljPmNJuUWo7F/eTEvZNDQdLjrot9Q/Q7y4cq8LvLpC8tb+QdIB8R/bUgo9K9fRjGqZE24B4w/fxuRmC8EtWaxCObpl2Bfh72QdB42E6ePSctyC88snNiQmvDNfGCb4X8/8Ppb1dArQT7CcoE3t2kAKIJ4SccjmnQmbUh5QTweVG4L1MLgyVolT5r5II2HGOyvax+UgOrnkRcN4c7M/TCa3i6+cEetB952uxVDTRBM9re9JbU9tKXKeWyTATRjOjeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTcxkm7DlIBVzKTnjLglKWDDgkrle6Wxq/GZ/GwDVlg=;
 b=T6eWoM39rdafX+9PO0ojN2+BdSqwsqyVDE8ez2wfrggFa6459pgtYwJKmgjNT9ZXZInRRffB4c4z2jQcqVAPw578d2toFMnm9CsBR/umFQpTMp8pPH2znMlohiLWNH7E5PE1vkEYCc6Q08HQ+szFO3AkEgfAg2nYqFw4E0VuxbE=
Received: from CH2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:610:20::30)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.27; Tue, 22 Jul
 2025 03:06:29 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::bb) by CH2PR07CA0017.outlook.office365.com
 (2603:10b6:610:20::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 03:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 03:06:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:27 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 21 Jul 2025 22:06:26 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, kyle-hai.chau <kyle-hai.chau@amd.com>
Subject: [v5 4/9] drm/amdgpu: Implement active VMID detection in MES11 queue
 reset for GFX
Date: Tue, 22 Jul 2025 11:03:40 +0800
Message-ID: <20250722030605.2741435-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
References: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: df52f8b3-e15e-4df2-2c07-08ddc8ccc0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HywdHx/+8LO4ndPh8yKgBMZmkFjAC3SoS2kwlTlU2JXgV1YiwsSFrgwMQ7KG?=
 =?us-ascii?Q?YucmN2tSi7mYWpgjK9IySSPhHqKrgLMM4M79xnDGkzPd2yR9iGU60bnHWIQG?=
 =?us-ascii?Q?Qx5W416z5cky9fmljO6faONCeSblYt6aueDOhT870PnVQx6SS3cH9OW7KegW?=
 =?us-ascii?Q?fvf1wIASGW/gsL8gxZUITy1Q0vU9qDn5wkDMAP7xWxs1d1bU8Mbq7iW2mtGr?=
 =?us-ascii?Q?oJduIek26xBf6fbo7fsDf/TN6uTo+eyWO1YgMApfEP7hm0qwRNxdlUb7Ccvy?=
 =?us-ascii?Q?ET5MqIhBYuIYEdduxJZn9WHiU2cxx4M46+Y8zFpEC+Nywh0dl7rh4TTUiUql?=
 =?us-ascii?Q?va62lW7MVB2IXtneDLUGXkceqp2+nI89F6uIzUC6CbNJnxsuR0xQECNHp/n1?=
 =?us-ascii?Q?CEKZGVkQsinsGQw1fcchtkrwAMk8p/FylOIzh2iwKC3bd/P/POUexschGkCK?=
 =?us-ascii?Q?6JanDFe9qyvrQNRWH9gGRb/3mVQTz/kzRF5jHoaK5zZOS7ECKvM+ZX7NoyQe?=
 =?us-ascii?Q?Dym5i/ACufXbGiFG75tQNJCVQLNLWtuSsTmZ5HIxdw/br4oNQx5zpdJaH1th?=
 =?us-ascii?Q?OaAKo02qNHN2U0qXPYw0hQcqW9q6DSOOpRGJ4gAsEhBE0K1Yp2tPIZuyGweI?=
 =?us-ascii?Q?mzxOgaOisoJjqV63oZcbdAmGHQ+uE1Y6oCLteOAm3T1H/Qf/pzTVJmv9LmRQ?=
 =?us-ascii?Q?+a6DJkOVzjskgMHryo63y4aof7SMVFMnUOquJ+Ds1G1B9Yd7bumhq3Q3N9kY?=
 =?us-ascii?Q?HR2vPUYPWi65LVC1GvXMq+WHFKYfqzyGkMBf0ItG49L63+6laeM8hhdM4hBW?=
 =?us-ascii?Q?NMlq6ucC4em1WoEGkCf4qEXQ1W4LP0R1BR6MBD5DFRXlsnYhwe/TkSslfron?=
 =?us-ascii?Q?ba/+OIDj2otl6DtUwCHkRqJavL5DkezBwYjW75AWp29USPAr3sou0FazDhKz?=
 =?us-ascii?Q?nJpJaN4uFyKJiU/XB2Ah5PfNlwfD9JiKcKBNmE6PVJ1O/oZYblfJeGmDMvgs?=
 =?us-ascii?Q?fTWbF8LIYrVp4GNTXLSVO3cAakw1RVMTcJfo1WJxlrGvey/xs51Qw3JSgvCG?=
 =?us-ascii?Q?gmgO9zF6pILse1XVzajXyHy5zbLnMNeXZRFhSbXirmKFaT14HVb7uoSuHdUS?=
 =?us-ascii?Q?6f4DohBa6wunkS1t+L1CYzUV2kBR9QJBUI0VXDfKYks/qXqEgxJSDn4YGbUu?=
 =?us-ascii?Q?bV/zGTKI22FBFXld5IdSMW4b+TDl1tnvBhtSlT1RjWA/ud9oDRHhhVohIxXT?=
 =?us-ascii?Q?rrmPHaIVE5HVqyx7Gps4ncqvzmqUw7rwVtTigZ0Y78hiNTYB5n/HfS+4NOhF?=
 =?us-ascii?Q?AHqkwWZ2ATrKfkEKsXABN4+VkhmV65OGMvA8hTx+X7qzVLM1d1U5/31qHIUq?=
 =?us-ascii?Q?tbEggzBxw3Q1fUGdhmPTZ0/Kpymq7M838gROwGsKyn0EbVQqs1M9sQ+0rH72?=
 =?us-ascii?Q?fwIQc0uC9gEzKho/U3hmO+JlNQTaHCXgco/6zRhO2f8XHasvmQ6kQHrNlxpN?=
 =?us-ascii?Q?Bc3/SaZrkRMpdfuPFfa3VONmfip7yVrgqhW6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:06:28.8378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df52f8b3-e15e-4df2-2c07-08ddc8ccc0c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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

MES queue reset functionality for GFX queues. The changes include:

1. Added detection of active VMIDs by reading CP_CNTX_STAT and CP_VMID
   registers to properly identify contexts that need resetting

2. Implemented fallback to HPD status method when no active VMIDs are
   found, checking both pipe 0 and pipe 1 queues

3. Extended the MES reset packet with:
   - active_vmids bitmap
   - connected_queue_index for pipe 0
   - connected_queue_index_p1 for pipe 1

Suggested-by: kyle-hai.chau <kyle-hai.chau@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 51 +++++++++++++++++++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 13 ++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index ed6a7f8af544..1422bc59cd40 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -789,6 +789,12 @@ static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 						  struct mes_detect_and_reset_queue_input *input)
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t active_vmids = 0;
+	uint32_t connected_queue_index = 0;
+	uint32_t queue_status = 0;
+	uint32_t connected_queue_index_p1 = 0;
+	uint32_t queue_status_p1 = 0;
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
 
@@ -801,6 +807,51 @@ static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 	mes_reset_queue_pkt.doorbell_offset_addr =
 		mes->hung_queue_db_array_gpu_addr;
 
+	/* Add VMID detection for GFX queues */
+	if (input->queue_type == AMDGPU_RING_TYPE_GFX) {
+		uint32_t cp_cntx_stat = RREG32_SOC15(GC, 0, regCP_CNTX_STAT);
+		uint32_t cp_vmid, grbm_gfx_cntl;
+
+		/* Check active contexts in CP_CNTX_STAT */
+		for (uint32_t i = 0; i < 8; i++) {
+			if ((cp_cntx_stat >> (0x14 + i)) & 0x1) {
+				grbm_gfx_cntl = (i << 11);
+				WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, grbm_gfx_cntl);
+				cp_vmid = RREG32_SOC15(GC, 0, regCP_VMID);
+				active_vmids |= (1 << cp_vmid);
+			}
+		}
+
+		/* Fallback to HPD status if no active VMIDs found */
+		if (active_vmids == 0) {
+			uint32_t hpd_status;
+
+			/* Pipe 0 */
+			WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, 0);
+			hpd_status = RREG32_SOC15(GC, 0, regCP_GFX_HPD_STATUS0);
+			queue_status = hpd_status & 0x1F;
+			connected_queue_index = (hpd_status & 0xE0) >> 5;
+
+			/* Pipe 1 */
+			WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, (1 << 6));
+			hpd_status = RREG32_SOC15(GC, 0, regCP_GFX_HPD_STATUS0);
+			queue_status_p1 = hpd_status & 0x1F;
+			connected_queue_index_p1 = (hpd_status & 0xE0) >> 5;
+		}
+
+		mes_reset_queue_pkt.active_vmids = active_vmids;
+		if (active_vmids == 0) {
+			if (queue_status != 0) {
+				mes_reset_queue_pkt.use_connected_queue_index = 1;
+				mes_reset_queue_pkt.connected_queue_index = connected_queue_index;
+			}
+			if (queue_status_p1 != 0) {
+				mes_reset_queue_pkt.use_connected_queue_index_p1 = 1;
+				mes_reset_queue_pkt.connected_queue_index_p1 = connected_queue_index_p1;
+			}
+		}
+	}
+
 	if (input->detect_only)
 		mes_reset_queue_pkt.hang_detect_only = 1;
 	else
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 15680c3f4970..62ad4f0337eb 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -460,7 +460,11 @@ union MESAPI__RESET {
 			uint32_t                hang_detect_only : 1;
 			/* Rest HP and LP kernel queues not managed by MES */
 			uint32_t                reset_legacy_gfx : 1;
-			uint32_t                reserved : 28;
+			/* Fallback to use conneceted queue index when CP_CNTX_STAT method fails (gfx pipe 0) */
+			uint32_t		use_connected_queue_index : 1;
+			/* For gfx pipe 1 */
+			uint32_t		use_connected_queue_index_p1 : 1;
+			uint32_t                reserved : 26;
 		};
 
 		uint64_t			gang_context_addr;
@@ -488,6 +492,13 @@ union MESAPI__RESET {
 		uint64_t			wptr_addr_hp;
 
 		struct MES_API_STATUS		api_status;
+		uint32_t			active_vmids;
+		uint64_t			timestamp;
+
+		uint32_t			gang_context_array_index;
+
+		uint32_t			connected_queue_index;
+		uint32_t			connected_queue_index_p1;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.49.0

