Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD7AC71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 03:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B238510E272;
	Mon, 16 Jun 2025 03:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iqKWryYd";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3BD10E272
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 03:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYvvBnbWu7Bmz9iusvTtVVorlBCE3pdrNUaEabCcXNiBiUocRXGYOnohBOzhob3p/aYWwixmuYJFPm/PcOH9WK/VNy0mq8hAu+L1Iwihq4gfCXHtY9PQUv9veDC7uys4VovMp/mRjcQtGZBfXM9qIBWlkne1J3fKMX8Fa0dcMAzqt572GAKp7gJe+EEDCypnOfEiiolR1qztQH3kTz2R+vnFmN+11HLpvkEWHh8PH5Tjy0ZL//IH3i7O2pwt6DJM+sTwg3uYwU5gBwOcJx3zfq3pvgjKEpElIqCkyp2OsXf8eUeSjjceJrQs1/KDklaYk6lyKb8INkO58jjVqpT7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvOSrYLf9Pzr1j9SnllJEXFowwFHkDbNHkJHhosezCs=;
 b=HKEWiT9pjQC+LMO+ROfPxkvEIVgNcVjrR7J6DB4tiY6vWmHuXKHNQdn+DQvUKCoAIhPcG00Ab01dt+JllX9OOtBVYxUE48Pfq0qpOWlTdd4F3+4kYvoRJ8Ohx+09sXdu1hbixbZKrYZBK3fV5ExTznszZrNm/orV6UPPNB8nMrD/KzQihimszk8RRa8I5W7ugcdPUTUKfHRxYOXHM/MIk9nKY8SFxO/53yPjVi7QniCYtxHcbsp+H6bpT4qbzVLBdTac/5Vph0eosE5evtbGJ2Ajvwmz0fIk43DlMk2motcPy3DD+kmGbD7toBV9HpAirkFWtR7OzHn6THgIy2pDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvOSrYLf9Pzr1j9SnllJEXFowwFHkDbNHkJHhosezCs=;
 b=iqKWryYdKW2xddNYRPom7imuA3942xLZrZftmYXO/mQMxsJXMJo2E94Aqz5xHI8NAx9H835mvxvuH/q+lqZBStHeJw2Pb5mImvpgaujJnUadDJuHhClYR9CHcC+etvk6vSoSdQXSmSNgH+isKa0mA/Uq3Suh/3Ub1w0umo2XX4g=
Received: from DM6PR13CA0035.namprd13.prod.outlook.com (2603:10b6:5:bc::48) by
 IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 03:46:37 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::f8) by DM6PR13CA0035.outlook.office365.com
 (2603:10b6:5:bc::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Mon,
 16 Jun 2025 03:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 03:46:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Jun
 2025 22:46:36 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 15 Jun 2025 22:46:35 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, kyle-hai.chau <kyle-hai.chau@amd.com>
Subject: [v2 6/9] drm/amdgpu: Implement active VMID detection in MES12 queue
 reset for GFX
Date: Mon, 16 Jun 2025 11:43:39 +0800
Message-ID: <20250616034605.2683434-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
References: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e9ec4b-37a3-4ca9-9e1a-08ddac88656e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xma7M2Mo5Lay59vNij85NOk/wzKkT6Lybkfk6O5pq7oVBFOfFMLH1LMicfUx?=
 =?us-ascii?Q?F+3sCCq+NjpBAJC11F/UGhzxQSmCaUBbbjtd8SVs53wYHj7ROePhHNm9gQXJ?=
 =?us-ascii?Q?fpR5nqIAcIgpQUJfNqs0TRt0OoxBoYR1PqDwx/2GrnCdn1bjQB8ESOm0WsRH?=
 =?us-ascii?Q?sFiOwWs1GH02rp+bF0JMMeXOGpU40CrNMoB8nKTODf4Q96bnL1GoSGKwBqNd?=
 =?us-ascii?Q?lXvNrjiKMi9/P6T/oZMtnwreWhl7HLEhbjiwg6M6IKv4/jWoOnmn6oMMdB48?=
 =?us-ascii?Q?RPQrQehBV0mLChvaTu8dkUtJ6oknWwKMPloq45frXyHiztNxIuVpVXjyGEs1?=
 =?us-ascii?Q?L2w+NL/MWls65ccn7t0KUwoJXtwoXncdMaBIwI0lBeFZZxwnVlOw7Fl8tFOu?=
 =?us-ascii?Q?et9Y01ljLi0f7TdStJIuhD6L02PN6CLfG8Alpr2H2fJoe9RoRywmNpynvoVH?=
 =?us-ascii?Q?bmUGw+GVhNZHoWzXU8CTXWVFRL1+Qga6TFvpSfwsCXv4EpUxt3z640H96rPr?=
 =?us-ascii?Q?N9wo6gfhbFrefkd7NuRwY+ui2RAGpVABgcypaItd1PXI+avEGBJ6r3lSTBDP?=
 =?us-ascii?Q?oZshixPhyCxcfVodAWbibOaNrpT1rkQ3nNLuTVZ1N/9N6JVhE7XKo/IYyG66?=
 =?us-ascii?Q?ZO/Rk6AbCI5/aZG42YYZjYp6RlWt96VTiQehS+gW2rMPN7GnjAPt5tWlssEP?=
 =?us-ascii?Q?uMdP3bDBfQwXgfRYCy4AXfOxht7q5xalSDYI/u8ubFxZZtpdICsJLOyJ9zb9?=
 =?us-ascii?Q?ushzsOpMaQm8YVhXU/fLNBml049f4XJGxO+gVgPsSDvXdU5224liLBekX8Mv?=
 =?us-ascii?Q?rZCW9ksTfrQvIAibnVbWwg1+6EJGiMIeKNljicc7oEg8DCwSVMIGEMnmbZMw?=
 =?us-ascii?Q?1F3om8R+qjAijqcDaTaHvEjDc+fG0IZ8sV3txm5DCzVi7czQz4eSYoxl47Q6?=
 =?us-ascii?Q?3mtT0thIAmwMVL7e64KIbw11b0gv7vMyfAn69zj12riEsZ0/d+szKPfcxTq1?=
 =?us-ascii?Q?+lFZoBl7XDqPFiHNZFproAQg0NK83QHZgupV1x4J4sMbyOCj8I+5EdAinKY2?=
 =?us-ascii?Q?lwVrasKRXmmnogJY1lcJkyA1VD29TbTqdpTgnJyiBv5xBzgw9kuLiAf5c7nL?=
 =?us-ascii?Q?M/oWvyZ0fFmuQ+V2oXkVECmXt768zWu+eTgh9iWnt2+1KMQ5+Zlts2XP7o9W?=
 =?us-ascii?Q?7/bUliyn2P/1Qhdnim2ZPm1t7fSpPY3C/tvjYu9LUWAUyFvw6npqn4RyxJd+?=
 =?us-ascii?Q?qser8tNtYC22nmHc1dIqYfzfVnFAGcDnTef7ZxdOKfPfylIfuEjle8Or9UAW?=
 =?us-ascii?Q?2Ks11QTkgQyViy5lrcnHxVJWm+kQ+dDKLXvnuHwf0DItb8u3SyeCPdUzJsCt?=
 =?us-ascii?Q?g8PD+u2w2MUx+3+GZ8obXfsNwl1ZeXNZy9VqgDaY+KWpyP+hPeDFcxY9lMl6?=
 =?us-ascii?Q?k6jSE1yHf0uUjRWqCMgEsiEwTMRASKs8I65+mB03UhjKVnY3Xe6RALmW76qi?=
 =?us-ascii?Q?d0cVftzwxaNX/ZEWusJ8JldFAkj75WERh73q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 03:46:37.2706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e9ec4b-37a3-4ca9-9e1a-08ddac88656e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
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

