Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF41C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4B8910E420;
	Mon,  4 Aug 2025 08:41:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2n0HTpe7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7881E10E420
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyhPJCfU5vVckSFkVBmud/arNzz5VmCz2wyeFwlsTbkZDwMcuu8V4lARD8IF8Q44Er7uRmWxPszoEArP27V65SMX1z0JVWrZ9a3gbaQyCAbJmT82p3jVj25iCoopvGSjJlWIbb3N1WugvIV9nbv0Cje1h+anYBF3qLvAOjpC2jXCSh4W27yI8T6H9GcpUTR9qHzHYXWb+0VpUcwkiyUnLjOG8tnI4zJqnHeBZdTOEfNnMYS815vug5dZD4/Mw4ZYQzrWMxuADWjXKlgHit0XnU3zAfKbyiuju45dAHvwoU0TEHMh7vXO2MaNcEdV4DI0cN923yUhTQqtJVHX9KMCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTcxkm7DlIBVzKTnjLglKWDDgkrle6Wxq/GZ/GwDVlg=;
 b=EifeGjPSvCCx8YYUBUa7uhI7leCP1YtcfQQDNK1KUnv8a1shQ5xW88sRrWsSHVURyM932KLGh4wl5bp1ZmiPygqEtEndT2V390jtG3EyjCSR9Otr9srjEbqiLaxQHwtu9U7tR/iEHgEflmotbyScTo6tgFQ4ORajii2PDU7m44vCgTYNWbjQUIwNVneN7cxn6YqqeP3y02IiZhUrye7brj8BveaOXcucE7ToX8HtWhfzsponjwMTiNYX7nigLbuH6hezTS0RMBVTSuW/laSPmRSWcBqrXvKOzY9LFJdsZMEuXh0EN6eCnp3EJELha0TQG0+j75dUTCTRA9WWQslRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTcxkm7DlIBVzKTnjLglKWDDgkrle6Wxq/GZ/GwDVlg=;
 b=2n0HTpe7UmHrfPPhJPf2xOA8cDmMxTV7/ZpBGRIQ3CP0wwgYUQrLpCD6fgzTB2/hKlFNAMWmZeSlxbiAeagriTUyybZZ1uS+XOBgF9lfHY3adS6vh6bdWt5cXFxzecco/8BMlI+GQtWg0sE5X/7n6n6boAJata5NTalTPk00/gg=
Received: from BN9PR03CA0855.namprd03.prod.outlook.com (2603:10b6:408:13d::20)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 08:40:53 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::bf) by BN9PR03CA0855.outlook.office365.com
 (2603:10b6:408:13d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 08:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:40:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:40:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:40:51 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:40:50 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, kyle-hai.chau <kyle-hai.chau@amd.com>
Subject: [v6 04/13] drm/amdgpu: Implement active VMID detection in MES11 queue
 reset for GFX
Date: Mon, 4 Aug 2025 16:38:22 +0800
Message-ID: <20250804084029.863138-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804084029.863138-1-Jesse.Zhang@amd.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 38661133-0a5f-4f90-bfd6-08ddd3329f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uhmcthHOYQrg1YedRJ0OzcpEBil3M4JCXV32RToArubB4k/veqfe+Z2eCOym?=
 =?us-ascii?Q?zBwoBxY3i/JnlTCP/lsrgGDWVXc0RaOek11JDxg+IfpFMdh9X/M4xr+4HVGp?=
 =?us-ascii?Q?cIvvLxIM4O9U2eWgQa0UjnrRa/ddlrUHUA8beJth58bRDEZy9IjCcy6z9A3q?=
 =?us-ascii?Q?oWwZOm4jb44baw0ZaryrUlYuOlLF3XuLpg06+MrP43bgWb3k2txZipZah8Im?=
 =?us-ascii?Q?/SjGhqnC06/zvvfTKFDtkIpx4BN3PZJptz/nXD4MR9tUtKBQTHcKmUpraE0Z?=
 =?us-ascii?Q?H+YEy/0m90WepItygBOzy4F6i7N5OziXZG154s2wIsowxyxBi3laZsTSb4O+?=
 =?us-ascii?Q?aCcKB9tV5C5sKUMPrvVk6V2PBEMXxpKdBSyiH8zhfViok7zjxyIA92iQ8b+N?=
 =?us-ascii?Q?hFrWrN6q3QcoFzkmWNtsQVgH6ik95HOXEsTilbValFVocQrQvXttFxQDyRGp?=
 =?us-ascii?Q?23ZUZ1s7SsyOQe9J4z96hkMMX2IVlMco+0kMcWgW1Z1nb86W5YZEP7ZfJ8Tj?=
 =?us-ascii?Q?EMuXQzsMrqpOoUVVeHJxTEbClsG+fL7F/bXCM6hHZxZfvvblxfACy2CG18Pn?=
 =?us-ascii?Q?H3WDPpBNUO61ygnKGO4UqiksTixdAtRejyw1hJMO1vXXusM5NWNHiqOWksPY?=
 =?us-ascii?Q?wUtnF1vgQDuV4Y1DiquC5QNIsbtC2Rk6DMGtOSwfoevVUTjfA2qcdjzV0Jt7?=
 =?us-ascii?Q?drkI7Y1k4LamNSVtRJoJX6/GHY/97ASpgsy1EWlFsG2LSt1O1vTUly+1q4Z4?=
 =?us-ascii?Q?7QtaJdEpawDRIciv32r6lFnizsPFzGZIyR7tDDtySp7OWrTSPu/quCwidHOV?=
 =?us-ascii?Q?zwpix2xoak/1tGPWJRSczZchHvD+aIEZrQQqhubzhOrcG6HpbQgnymLUpSOA?=
 =?us-ascii?Q?tKsGUQx7Ga9egjreetSnrHBTm12FLmiDQzMIlFPyMsxv+dr2bgl5YcMAs32P?=
 =?us-ascii?Q?4c6M5druY0BP4B+H8n6Ak0f7TyH8BOjBnb0VTp1sKwJqJVdIkURbYxWI/udh?=
 =?us-ascii?Q?sVTUbM7nwwLUckVlkBdn1Qp/IMLzjK8wlN2GIZ5imMmu4I7E9EY3ZkQSd/Ma?=
 =?us-ascii?Q?fc999FWtULwpjF2V1H50JhK2ZIZjeUzZqWAkPI6ITRpVmPiG3XWMDvM6C1uH?=
 =?us-ascii?Q?0Yj/jx+nAOMVK7knv15qev1X4GuGDFVYsFcI81v18iWLViqswXT27mGa2w4w?=
 =?us-ascii?Q?2HVKoeqJxgCEqZjhPnDeAXWfnoyqco50lf22GXR/6mTkcmDvHQsNyTNKHfbh?=
 =?us-ascii?Q?SMMVqwWRDs29pVa/D50GiFUAeY01a++HgoWfqlhLLuuKSDbQPfcZRgjFFZo4?=
 =?us-ascii?Q?TG2gBYCJNOHoRm1lAWumXjKI12Kp6PRYcc5K3xzWuF63Gza6P67iOene884t?=
 =?us-ascii?Q?7DmSZAo8hk2pNX94dUKLVzO0EqzdeF1bxh0bwHfRtxgUXBOM+d7WZkDHs5HF?=
 =?us-ascii?Q?0uH9a+dwpqWZtO0FWFWl0Q5RzymTExQPX0Cv3KpICKakSCcFwr5CtaWwNAKl?=
 =?us-ascii?Q?ueoeu92eyIJFmj8VBahj6fo5SmMLDStjL6RK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:40:52.6338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38661133-0a5f-4f90-bfd6-08ddd3329f0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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

