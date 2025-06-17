Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6887C71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 09:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8381410E583;
	Tue, 17 Jun 2025 09:23:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tXrO8H+C";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C6810E583
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 09:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSl3pK2uHM+Ekh9ZZXg6WNt1KPoRLXMH+AFDx65CSmI/dXa/vbOuTaCBVoGxBq3USDkjUOh9UAC5KiX2Effhqcy2IuW25XyXLI9BGUU885Ny1Ti6thffENEtdMOvaMJVz2R3V6Huez5cu8ZkEPLEOLCS0TPcxcEFzkX4d6iX8gD6XfRvmBAYhQa9WOsDSifncYQVnzFF9RnXGBLjmmVVqOujUbZp9JClEBfSbeP2scNF8MSHT2OfwXgllSKzQ1yjwS+spHssKFsolRmmi/ljyQ07iIB+8uCzcdTF6ttM1+Yu7ABH/pSDdzp0kzzb8WkreMF1Uio9xLjXAr/oN/aDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvOSrYLf9Pzr1j9SnllJEXFowwFHkDbNHkJHhosezCs=;
 b=oJMWqG08PHhJBJlTQv8QooHZuyVCZkAmsD6w5L921KQP7REZzvgUYvT6yyrJN9FRqYtvPn38v8SzrfYIGFpp4XNbg7CQx7AjNXDqEIgzN4n45N9aDG+XO+PewjmLLfvzwFLpM4M1jL9BEVAfxbNOGdyAhlVca3Rk2bAnksJf9rmNQIzSHcBXBbR5hHoJDXfJtVha7aLZJJSvzU6W+nKJZyOX+oVld+wts3g9tx+g12cgaomdYa1or3EOGkMXsCWigWsn6Fo8yNQ9dZsJc/OX/oM58NwBv4qaACN4Rn6RH38rsm9R41CDQ+z1xwrh+id6FEo9TBeU/gNyKI6cA2W4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvOSrYLf9Pzr1j9SnllJEXFowwFHkDbNHkJHhosezCs=;
 b=tXrO8H+CayPwj5Evcc4YOGL//69ICALq54wjmZj/uj6eiju3sEhmQK4sXyRYfV8Ur0YkaAX9qtzsOj/yPLo3nFg1YSxajJz8jaEmSmrbrqiJw+YxpMp2Tf3puMm+G6DVHngUUVmWeRf6Bp3Ghk/yO9urqVTm7t0Qp0Ps1p17dlo=
Received: from SJ0PR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:332::33)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Tue, 17 Jun 2025 09:23:16 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::9f) by SJ0PR05CA0088.outlook.office365.com
 (2603:10b6:a03:332::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 09:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 09:23:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:23:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:23:13 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 17 Jun 2025 04:23:12 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, kyle-hai.chau <kyle-hai.chau@amd.com>
Subject: [v3 6/9] drm/amdgpu: Implement active VMID detection in MES12 queue
 reset for GFX
Date: Tue, 17 Jun 2025 17:20:18 +0800
Message-ID: <20250617092243.2769580-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 268178b3-2cf7-4190-25c9-08ddad809703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HLyv4M5FBiSqMmWybWXe0iwqX1H2nFYTn3NWkNJ2443XdkFEFw1YyyQWI5k9?=
 =?us-ascii?Q?Q1SVALBD31/AzFT6DOtyOCZHFLtibyDd6QqG/PdfGDR+G006evC60ACyJ/GL?=
 =?us-ascii?Q?z2Olec5J8Y/TTkWTwfFcF5gHfg9qL/4PrvUCuIzikCKjq645ffZNBWfF10D8?=
 =?us-ascii?Q?Ey32HXExt65k5NHdtwXFzKnQKhrC95q3dYqXLIrW69LqxzHrmgabDiG0glEx?=
 =?us-ascii?Q?mTO44bXciE0XsIMJJoMSJzbEDGC9+AYkIWEOMLOdwXnkptNhLaZJ+GGlQSiN?=
 =?us-ascii?Q?W/DCa3qwaRD4V4DHCYiFr3TgiifV/Czr+OSISQYVbniuzFy7uQUQcihdgv3P?=
 =?us-ascii?Q?Uwe5CkrsGP7hTzMFwIieLLvUY3ri0JP3URS6XEHoHfyPVqivBPWcavrFzdU9?=
 =?us-ascii?Q?J7NG5UehiyeRuFNHGih5/kXdgMG35CckIJP69AH5U5qXgleirYXsrnddyjAd?=
 =?us-ascii?Q?NRt2PnitFLP/zLlx8UI7uO4OGKmivzFwEzM0rASPZKRXUrqxtNsuS9dL5I39?=
 =?us-ascii?Q?neTgsq3pcW5NW6trBbjFtjCHoLIXIJgMe6x/Pxj9maXxwliwc/uewmltHLQw?=
 =?us-ascii?Q?IokfMd8djWJPlebH+JcGTxLjcg3dv2Y0yap20ww93C5qp2OjQnjgBCvyVDYI?=
 =?us-ascii?Q?oxIXEhThQ6KHnIrJTJccrrlILbgD0C7zHANHM169THS9Fg6U+6sGmoQi5g/1?=
 =?us-ascii?Q?x6c2e7Fur+icBKO1Cr+ahdxaWkR75zwJh2GHwVHndhyVFsxAg0MPey0mkxev?=
 =?us-ascii?Q?aMMumDIHRY/IhsGBwoKvwxQO8Fx/W1YKUkcVheQwBNGUKDVIjYaB5NywEtEQ?=
 =?us-ascii?Q?j+++8p6tsBPJCNw52p51c+Xhz+cmkQMbiTAKPrlyrB7JI5YLGoDo69t7MBKc?=
 =?us-ascii?Q?ua5hAAA09DJRNHMM4SYnyPftkDlv5pg+ztKnKVdtKhwhMqxCkjzukSucs943?=
 =?us-ascii?Q?hhy7qvsTJflkXWQObLR9EHMMaTnbA2legQXDScs429Fp12ZW0uyR2yHtMWMx?=
 =?us-ascii?Q?/FjwhcRv4xfVxhgEb475fH06stw4ux0zDKOdR+Ljzeb6SYbhEVlTSdgwp6uE?=
 =?us-ascii?Q?9w5H0kW2jmXeUulruqPyh/ZLtxeCrq625R2eiJwL6U4f/Oii8tMY7uVRzDdY?=
 =?us-ascii?Q?mJgSQR9xAZdSgSuqNtGOkOTFZFe1aOTVsB9NcHx4aBLmsmokdpiWKCvZ67MA?=
 =?us-ascii?Q?7F4JWmGNGPAiBCHYhvTh8vpPHeSeo2JEhOJ/dDVQZp7Nd4nrqqAx2M268Wvv?=
 =?us-ascii?Q?XYdcJsFvEEu/tqpsqny86vvrkNjL6YSLDvTVdMOSGvVwaoXaNUrG+8EvOeyh?=
 =?us-ascii?Q?Nr7PRjv/BbSWST079pyZ6ZeVT+yAI1TuCbKr6U6K4+AmE0HRQRWFnn250zKS?=
 =?us-ascii?Q?NFlmgTWHEKTUXxWj2YunY5vcddVS5up1oeTpv8odyX8ko+VqPJnhDDy7GGEs?=
 =?us-ascii?Q?+Celoo17zmQmTd36MiHA3SUJ1JQz30WENvjD/DnCXDJ0BRdrnxjGfokgI2tG?=
 =?us-ascii?Q?eHOlDEEPmPpsINQFIDW3QGSt6xDzBi3J8czQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:23:15.6127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 268178b3-2cf7-4190-25c9-08ddad809703
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 51 ++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 7d545a24e2f7..fa643929d6b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -885,6 +885,12 @@ static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 						  struct mes_detect_and_reset_queue_input *input)
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t active_vmids = 0;
+	uint32_t connected_queue_index = 0;
+	uint32_t queue_status = 0;
+	uint32_t connected_queue_index_p1 = 0;
+	uint32_t queue_status_p1 = 0;
 	int pipe;
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
@@ -898,6 +904,51 @@ static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
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
+				cp_vmid = RREG32_SOC15(GC, 0, regCP_CP_VMID);
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
-- 
2.49.0

