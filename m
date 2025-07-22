Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056A0C83F25
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9613D10E3DF;
	Tue, 22 Jul 2025 03:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ObCMRCa";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24D210E3DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFMeEc0tO/NluOgY+mulIQJ0C7ahaWJbYVuuE7y/Pk2PhiAKussmmY2fAQc+1vY19vP7TaYFnko6RbcacKTkXJgPWQJ5ryxbaYzqWOK+1nWvwASvwcntzrWuvxSY9L73O6vtSKXYgVq9zpR6DrOb7xuwqbqaSGNu+vfvj08+6+khmYu/x1WnuUmqWZ2sjWnq3tPL0ggbyvKGYUaTOAXccmjHmlPix/Dhka556aD+pdwsNlUbnG7Zg6uqkWsi3BeyBm2+lfH0zmXa9NfeX2im0RR7G2Az9toDHXmvDhp/DQ926NFzSFhglPWnzOS8deIDHCceaixbEphOhCC+OU2/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp7cGsLGdS2qLEUNMOJSfgrG9RSHriXBMHA7QzYMPXc=;
 b=TVW8KHsvo2o2aFFMllli8eqCK1w5N2gmL/5FmOgld2BhnQ+jmMOshTXlNULoJJDgdttX+5dUJLpilhMKCpcTI+YChVaiceGv0uOVVze3xWtqLh24gN5DUtO5+jok52m9MroTsDheNnfdCpX7Y3q4PmBX2U2ZkA9UaDLMieyXt58uRUGzWkfC0Fn4FyH8UPUUYuifSNQ4XsWpEIxF6ARouQreaAXXm5EM7MzCoFSq9X1PfcxVkLYnQ4tK0BxJGoetOcBD8gNZLjgk+SVxVNvV+LX2OUD/skBimRE08RH+4QrQrRxmqwgkmqBfwjSpC+Zk0wq6oYmr3D2ZEvzVsaxY/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp7cGsLGdS2qLEUNMOJSfgrG9RSHriXBMHA7QzYMPXc=;
 b=4ObCMRCabxB+6KGvrIhDszc/xfSWmx17JCS2rsT5UyAzdhm1nUDOnwNwsnJX38XMtvh+egwI4W2ZhJ6zYcqVzj01EtbewClVLrz2Y7P5717SlVRyu8j/BO5c0hAtyL3aDWBhMrhBPWdY6p5jbhurPl69HLWj2uASmpMol59jtJE=
Received: from CH2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:610:20::20)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 03:06:30 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::de) by CH2PR07CA0007.outlook.office365.com
 (2603:10b6:610:20::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 03:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 03:06:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:29 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 21 Jul 2025 22:06:27 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, kyle-hai.chau <kyle-hai.chau@amd.com>
Subject: [v5 5/9] drm/amdgpu: Implement active VMID detection in MES12 queue
 reset for GFX
Date: Tue, 22 Jul 2025 11:03:41 +0800
Message-ID: <20250722030605.2741435-5-Jesse.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b91b23e-5b36-4d04-1ede-08ddc8ccc1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KI57gAMrtikAL4G2nzBTaqRr4PBn/gIehuGe3/Xg0hRH34ZGaCOXNtVeo2U9?=
 =?us-ascii?Q?JwcE2g+ZgSHH8lmJ2z2z1qnu+49V379hD5UeuiRe+tx67gFNgrOQTrxkkXWu?=
 =?us-ascii?Q?RvAFHplTIeDCWyo0uOovg0IoCCapdO8p7Y371ylS5e4/zMlQIcKXTHM5SGpD?=
 =?us-ascii?Q?ftCzStO4WpNiMNLZZCTT+6fIj18TxgUJwFkOUYTWVkaaSnWppjx+DuR2BCSl?=
 =?us-ascii?Q?CdCOuvbBx108l26oaBop67DahG3hyBglTCgTr0eyiVAFOaC/+vCGteiHesA0?=
 =?us-ascii?Q?O7Xe+CWFT7Szs3b9o7ouK6+qug+Uv2gOAFvlEaZkk8RIi3XKMwRqLkJhmCib?=
 =?us-ascii?Q?7HHdEHp4zjAewEoVYMlA9WMDQkj8Z1UmmLdbvoV5f0xe0v7gDDw0r9tC6797?=
 =?us-ascii?Q?I1k65iDPgPVt57dyBIEr1ZUYDyyP3pJX87AMAGwy9l4teUzg0Xf7uMxex/hI?=
 =?us-ascii?Q?DOGvy2opBvsKGfWByuCKaTwK9XmuS1tgC/+DcI3wNb5+qtaidTnYDW5uqKrB?=
 =?us-ascii?Q?Pl476BdA5pHSn/tZaIzrKdPq1C0mZd04orrNDOZvuqHN+LAvHa9bqOXZ5KCK?=
 =?us-ascii?Q?dVpOakF1hp415zYxbSZoo+j1l9ThpZkb39NK2KekDcwT3js6+dZ435Dl+Clz?=
 =?us-ascii?Q?y84KxKlpELNHwMd8KJlqcj8nmrM/zwc551Cn+bQfowc85AoPqu8fzXfASAIR?=
 =?us-ascii?Q?79exH2XEHzI9UxT4Aa6wOq6i5vjihFj1BJZR/cLxAwAWa99KqM8NSVSSzdTy?=
 =?us-ascii?Q?BRcsG4tPtQ+ENRpEl6SJJxwCGW4U0a0+k7yojuwlI7dL43l1NEwi1IGacMX/?=
 =?us-ascii?Q?9G/UN+SgEQtUE3RwdwtNb9HGXeFCJEPrkBjGQ78GDA8q8eGSLw13kopkE8QR?=
 =?us-ascii?Q?T8NDHfA6Jtfnq2xqomFDfxD4DJIesOtk5O8OmXDnklpDjxvB82rrSnU7ihIo?=
 =?us-ascii?Q?HzHUUpC8JMK96uu1qJELmCAbb3IdRsobqOvcVKlsVyX7vF/fNjKTIcvbDyUD?=
 =?us-ascii?Q?26aXR/IBnY8Y0MYomS7VUH3doKJaOP7m3Q4ZBfaEMrADsoFit44x8AhJKb2S?=
 =?us-ascii?Q?6DKPVcWmNlWUYB86dM4mKPoZ8P+V0I6vONuLm7zUYSq6nKnzmes0wG06EwL9?=
 =?us-ascii?Q?fWawH7VtSO5iJH9Yx2gK+joYD7lim1JCVgLqwcFjmAp38JHxodJBF+hjYPb/?=
 =?us-ascii?Q?ciWj4489qQBDEM/v+nDWw5O5boM64K91QNU9W2o0eqL9GHfFZ2ojRzx8RN0S?=
 =?us-ascii?Q?EKYEuV7VJLMgfMal2qzzPTuEJjUzC0vcBQnr+qjveria+cRCSN8/LzK+QNCF?=
 =?us-ascii?Q?ltdTJfU9V9ZAcG8hXvy0dnO1O0xAH777gmA4MGEgSx4JgoMRBtQDPo6/8HPd?=
 =?us-ascii?Q?3Xs26JQU+L94JdEP0Mw4pj3u4kmeBq+85/c1ZvBxSG++hKbk7HZMCG+iI62h?=
 =?us-ascii?Q?OJYx6Ll2TbFb0D+LiSuLbc//soyo2fTTv/5iEvu8QbZmGFozas0oIINzLEyw?=
 =?us-ascii?Q?FRZZaFg4MsKqa1GRQiL5R0TwNcyMHCTKTKkm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:06:30.8002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b91b23e-5b36-4d04-1ede-08ddc8ccc1ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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
index 29d38aa1897e..579720695e9e 100644
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

