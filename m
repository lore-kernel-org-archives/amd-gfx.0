Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79773C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 09:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293A210E579;
	Tue, 17 Jun 2025 09:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l3GCThe5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 645EE10E579
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 09:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFM84J+7qhfmoLrBLiqvGGIuelAlxBysdfK66Qvhwhuvh58ycd91T4mPjBIziw2EqqtFN2hY2uRjU3ITjj8SBZQnmAqnlB6DP83Shk507+GCC5i5kTArptM/NI10orMiq88hxrSvjY0/sTS3QK+kU3FW7cO/ir9MZfJYoM5I5N9f1+gTEj7lm1UuRSOdXWbg339OaPuFbG5yLdfQoswOIjkjCYEXOMp/h9LBSn25i99iFE3RuLiogD4PjVzwSKKywx3Z8SyJgeMgTPgFUYeY9v8g4YYLOG2Una0BXPQUy3TKsRZDvR35SjTudep3Z/N/XU4ITsNsByAWFBqCtrSTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4NDuosIPo3V9S/tBg37zNSNyrz4VgYcT0bDZbbErNM=;
 b=LgX+YaVvzNXOf9PFZuNbhi5JoUbpGSGeFYpisSYr4sq8o1yymlwBn8LLYWZbRsbcBQ2eAOAsAT//97ONogODigTl1iib2tIPgCDr2jSAQ0ihmc4nGbvYxrcWtradLunEvec2WAeaVUGnnMWDDm0FBsXJJLEpoS/IfZRplGHsX9xU3D7ZDYCLFAf8EgYcVselQnwwV2KsIE8htcEcvETd4EOeb+QBXhBWn/BItSBX/gf5896jrK7TNcPQldz8KcbQgKptD91Y+Wi3dQlgz50jdvDBVNy9zfW8xjhosUh/OClrh7qzuGSxISb1ujAR9BoqcvZ2uKp3QFKbcgo7S5cykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4NDuosIPo3V9S/tBg37zNSNyrz4VgYcT0bDZbbErNM=;
 b=l3GCThe5EZAtTDvOau9ScSBfgnthum2WrZKBnYR8cm6JoooMUqVlB00rT9bZCU36Hv9fetFbitKC7U7QpM8bAgKxMTG2zPoJ+9YWWF9V8yYPXlu+AXW+BLFJaEtlcbHSfvoN4RoYGYqzhdHA95Gvu2GqBNdbDHRZanpoRct09ug=
Received: from BYAPR11CA0088.namprd11.prod.outlook.com (2603:10b6:a03:f4::29)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 17 Jun 2025 09:23:10 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::75) by BYAPR11CA0088.outlook.office365.com
 (2603:10b6:a03:f4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 17 Jun 2025 09:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 09:23:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:23:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:23:05 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 17 Jun 2025 04:23:03 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, kyle-hai.chau <kyle-hai.chau@amd.com>
Subject: [v3 4/9] drm/amdgpu: Implement active VMID detection in MES11 queue
 reset for GFX
Date: Tue, 17 Jun 2025 17:20:16 +0800
Message-ID: <20250617092243.2769580-4-Jesse.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ec4e8c-c58c-422a-5dc3-08ddad809360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LxJLTol0wWKPzbKpJm4m+72Q/WELtniBRuha+RGTYfDgpakQGO0fKQVMsbQc?=
 =?us-ascii?Q?em5He78SqW3sAwwt/l4QT/4K06FfjkTXNHbQWiah2srAsr66ZiM1meDUwtSZ?=
 =?us-ascii?Q?XCZRZg+QkjfpAYlSARD/x0yscF1A2nfSXo1EaGDcVjTBiP2ncaEYv8KT03KW?=
 =?us-ascii?Q?OLfIXERUdxFtvAEGlp2P4FjStBE+A9VBYglQasGO+ZId72Ro6fLCE2q1TSMW?=
 =?us-ascii?Q?K+5F+kjHfM/4BmZZ7X+d07zyZlFfIK+Hp3tsTXhFqjgQAo97xCpRhu/cSQwz?=
 =?us-ascii?Q?bwUOfJfsGJvtsaA+3dyDrzGtHzxeTM6EMsfKkrNAddDz5XjdXXEqr4vb7z8R?=
 =?us-ascii?Q?XpziUu++eAswzyoL60/KtQwbJo3E9GOkvGJVvjTZkTZC6hk6492hJNiUGbD/?=
 =?us-ascii?Q?K4VYSP9mVAiDsjaLWEA7+oVoThlrEjbWPZQOT3vKfM5b427aunRqH/RwE8Gs?=
 =?us-ascii?Q?vXo/7lu4HwT1iPfCpmF/hCecK6GwUnLsTs3e89XvsXKfjZOo9PovHlLDlxoo?=
 =?us-ascii?Q?8bPFDaqKyTbZdwC5Y3kQ48VXoIATT3n/4lYpdsqcdmKYviutCKkWtjCSdDWC?=
 =?us-ascii?Q?pmcC1UtYBg0ec38Pa6Dm18l3ERHXhIEwgk8dpAGHCiYSvpYTVFlCSIzYD3K6?=
 =?us-ascii?Q?HiNp9P6b9blsSiSZ1QjlCb1hXcXU1M1ofbeBugNwuKwualYYqyOMdnn3+lp1?=
 =?us-ascii?Q?duD1HLjj7Pv4k9gyaR0vHhdPq2oyogX273sJMg9dcRoIjWa3lHUqqxz6SmNy?=
 =?us-ascii?Q?Y18hRB4XATfA+Gc8QFb7fpspFl4LS867FlZ+4wLI6F+xyP0Z+0tN+OMsCWQj?=
 =?us-ascii?Q?ElLqb2stlhKIKwll9VSRlG519ENX3taioqIZJ/AWRKVeod3N6vj/byNJx2ED?=
 =?us-ascii?Q?RHE5RTQqWSfEnEbZiZPTOFkU9RaLOgXUWACUIiXJ3baldueguwIF/pm93To9?=
 =?us-ascii?Q?J2L+egyzDTWR+1RmXTk0F/bH9fHm9ZlQYGIt4oSStoCSK5LiuwSBemm+s7C6?=
 =?us-ascii?Q?GWwanFLpEMb+a+aJuMqZAj2scCf28j79qUt1G4jn7gvrU1ptScXJM48eu9pH?=
 =?us-ascii?Q?PM1XJSpS3rYpxSoPAj7MxHTfiMEuDIhyPS+l9l0Xq7Pbjh7Q0lGxtfXhoqcD?=
 =?us-ascii?Q?uK4HxW35h7iGnyQ7cpbEOxqppPhHOXS9K4AujtA+YTuZqO+Qnxn5SulbhlnJ?=
 =?us-ascii?Q?9NH5B2cfMJM9Dr6CI6E7DjyR5BJuqJ17OZLds2iAXw+vRFoKy4dPqfk8S1A9?=
 =?us-ascii?Q?/tcPL5l3SYSbhgoDi976FRYisItihdBepm+dhKzR01cEBSQjbjeOXEw7W2cZ?=
 =?us-ascii?Q?GfSDnCUbpMPYizqzsRJEmVXVQMw4tugSkrGAmFlUx6QS+iU3UBi3xwT5rO4U?=
 =?us-ascii?Q?t5Msomx0EBLdTWWul0w3w1bcBesv7zjyCDiYJGAK0lbYgWqSKZHnVBtu+zx8?=
 =?us-ascii?Q?U2Qe9R9cd3zDosUFA5zPtMPirQ3VXX3hhvsokevvyorCVEoUp6W1t+ch4lHO?=
 =?us-ascii?Q?6PeDsrNtwzyw5O9clW46DjqHiaXNYC8ILIUq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:23:09.5115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ec4e8c-c58c-422a-5dc3-08ddad809360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544
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
index cded31da3f31..c475fd2076ab 100644
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

