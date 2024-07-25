Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C03C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B265410E873;
	Thu, 25 Jul 2024 15:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OgObCjWw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA80110E863
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS8kEpIxtP9qSOqLDL6Racs0bbyMf+aUsKWC57g5WIWl3bL7IYW0odFmmu5G8QKq/dt8gmW7+EcY4d54S2Vf9fMq05NcBqnQErAKD/5G9t3Aon9x7/cRjb/m8sY7v9KiYa5PTTaoZ0/8wz4paCfphpuEDzSsWm2X1hSgqVUSnZx/fZgqrCphQIvuoI5DDHCN7lxtfRZJvqt3BEKdhAlyysuOoRWQ92OydfFsqd819mQXMD4jfMLQ1vV87UtDy3cDNGMLipVLkRZlbvvfKi1AwmmVsKWiXWTU3K6C1bN32pLSKYGxBiJCChPJNGrpp+aB/l0i8QWBq1XfrkiJ3MYPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNo7MwnnH2+yKtgZQb6RTmOP71AJnxajE0QKsVBgtNI=;
 b=CxX1259nsuDEpVBQI79qFf5gRkeIDMdrA9PGK3v0HMF4r+/vlMHZ5WEsY1zDJ5k1doeI2KO+aLVLL7/7ScU/KufRrkrjWwqf+Gq3KPzItHzH3/g1MD9S08gf1R85ghiy5XJxbrlx6e+yFMBRJIQRzd/WxbXkMSVrGSqhzK72JHjN/OXvqvopxMm5PPet5tXlQdcp13DnQYx3yjZvcUOA1W16Y6qUOH3AdIQTQY+UrKx/XbR7B1S6atow5S9JZMaLLkmaeikVkOEp+1a5JG7Q/xW4VhPfFJWrWldvkjJGhVq5JpJDhE/1E6CST4vnUqsEbg9nIQUvyRORfGl9d/uJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNo7MwnnH2+yKtgZQb6RTmOP71AJnxajE0QKsVBgtNI=;
 b=OgObCjWwEOJHeG94REmEHS+/qO3S9k+4XWUzf1cDsBz/waI9ybzzce1jqCBY8htR+vevELikbgtgCO+dezsVsANH6tWmHY1u7rdAuCozAOGzDdqwoXUc28TGITAKHMv/jDrodjr5zUW5pxoAFTfrJCbSNAztqbcS+LSS5cb+3Uk=
Received: from CYZPR10CA0013.namprd10.prod.outlook.com (2603:10b6:930:8a::21)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 15:01:28 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::88) by CYZPR10CA0013.outlook.office365.com
 (2603:10b6:930:8a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 36/53] drm/amdgpu/mes11: implement mmio queue reset for gfx11
Date: Thu, 25 Jul 2024 11:00:38 -0400
Message-ID: <20240725150055.1991893-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6c22df-6d7d-4637-894a-08dcacbaa98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jsjC+KPX/gg2J7nJBrUPSCYuRDraPqzq7BZdYxijlZYEuY02tUw8s4ueLvnc?=
 =?us-ascii?Q?ItwNK05c2So+vArECq/UrfnKP11QA0nhYmSw5HTb5cRhzn0mTPiD1OK4kNLy?=
 =?us-ascii?Q?bNi/Hw/w5pLon0oCjoOkrlyoYBMRFGUVF7O2QjCsLiy8gLgZGHEWqugZ5vpX?=
 =?us-ascii?Q?wFdjzpgLnYrmq+/dJ6yQqTeUCNKIF7guYjkCCIbq4yD1rTLCjbjEmiKWkNIb?=
 =?us-ascii?Q?CcK+v1vOfOIfQmDiTlddQpQYreoqEfU1U5zE6c9usW7o+xwm10dDJ2gK8j4m?=
 =?us-ascii?Q?JSyGC1Ou55Z7jQKWqdSyNRIkaOHxGRlxvopVzlooNcgWBOMCK0tFEC/guEbw?=
 =?us-ascii?Q?zAwIU8GLctdTOg2tDA5ZPJFwa+eVcp03GV34qbhvWOAuC+lQnCYPwRFHMa5O?=
 =?us-ascii?Q?Fnl1msyO7h2QN1sWmv38xuabiHcXKALRULr4CZjxzwQgrjr14a99iK2FZbKr?=
 =?us-ascii?Q?qVUFTEn91Su71jfPdPG+RdHevZ5m/JN4rvAAXISwhQ29G07N6w9jaAHQOrQC?=
 =?us-ascii?Q?i0wlVIN8w3ICrVv6jWfMq0+4dco9hQu3p90dqC+GlJTusJ+hI2XeP93mGb8O?=
 =?us-ascii?Q?ZXwHz2HmNiRBJlefiRJceLR5nZWEHFQujLk9lJ+Lf+qRZi4acgh6iKk4cTY5?=
 =?us-ascii?Q?C1Tyvd+pa6xE2kKXIJ7fgVi/GUN0zZsDMSikQrzIiFUN84zWMZwv432BLD0e?=
 =?us-ascii?Q?O+uXhc4xOYcOl52AvH3ZwQ73glZYYb4ak+uOY0cwfJQCujM9Q9gbfEgcSyVy?=
 =?us-ascii?Q?v6zch8NF+mw4oGUp5EiynboVJlx/y8O8VL2vVly9/4uhs6IrWO0JtpLEkV4L?=
 =?us-ascii?Q?t1hp3BPAL6cjsnzjqioEFy34hPeMYbNeulAAb6TtHUH4Mdy4R5l7bk5rWQ7G?=
 =?us-ascii?Q?7KRny6eiptJymiUyo2F1Dv0nGIIwlXMVYkG1rpXy6JPCX/Rj+LQ13Wf8Pw1d?=
 =?us-ascii?Q?XNGTgG25O3CK/q15Sd4Pjl6H+aYrD0ceNBP27CEfXr8PCO5RieqpaJoyRJQg?=
 =?us-ascii?Q?ZPPBdO4Aqq+aWOI9yUZAUiEGm9q13QKWMp0WjDrig2SFlGa43Cfb4iwGmsIL?=
 =?us-ascii?Q?fPogexnMTevEjl38k/YCpx3okgTfwcWolG2hQvmgBz5btkb5HTxLUqdoADBV?=
 =?us-ascii?Q?+3eS+iEaKMRX3my92VL6taaheV2JX8Q2AtRr0jEUMH5m6rSSOjvSk13Rxq7O?=
 =?us-ascii?Q?as/f0HJCs0RAKAKbvj3RMXQ53rK4/elsDpuYXbl+Vgp5Z3gOZ0sbFaZXm7Ue?=
 =?us-ascii?Q?qjMUcck66iNJlaUT218Qx8q55XOE6AHbIhwPXdbZdpaOkBXUyPwQluTWyVhU?=
 =?us-ascii?Q?kzPUk9sw9PnNpPnB71F4ZsBw0TLpgbKuPKnlgFiV10TyKFd0B8DOxyrnyGjB?=
 =?us-ascii?Q?fFi1YkAw+9gtWho8icotssz1nk+VVKY3u6T2/sPOjbjWVdfkJqzyEG6rpwdW?=
 =?us-ascii?Q?g6dS3pcEPDO2Kodvgd+28ZyUoS1gi5+R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:28.6684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6c22df-6d7d-4637-894a-08dcacbaa98a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Implement queue reset for graphic and compute queue.

v2: use amdgpu_gfx_rlc funcs to enter/exit safe mode.
v3: use gfx_v11_0_request_gfx_index_mutex()

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 78 ++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index afb40d70e41e..c4bbd2f95fd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "soc15_common.h"
 #include "soc21.h"
+#include "gfx_v11_0.h"
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
 #include "gc/gc_11_0_0_default.h"
@@ -360,9 +361,81 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
+				      uint32_t me_id, uint32_t pipe_id,
+				      uint32_t queue_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t value;
+	int i, r = 0;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX) {
+		dev_info(adev->dev, "reset gfx queue (%d:%d:%d: vmid:%d)\n",
+			 me_id, pipe_id, queue_id, vmid);
+
+		gfx_v11_0_request_gfx_index_mutex(adev, true);
+		/* all se allow writes */
+		WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX,
+			     (uint32_t)(0x1 << GRBM_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT));
+		value = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+		if (pipe_id == 0)
+			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE0_QUEUES, 1 << queue_id);
+		else
+			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE1_QUEUES, 1 << queue_id);
+		WREG32_SOC15(GC, 0, regCP_VMID_RESET, value);
+		gfx_v11_0_request_gfx_index_mutex(adev, false);
+
+		mutex_lock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout){
+			dev_err(adev->dev, "failed to wait on gfx hqd deactive\n");
+			r = -ETIMEDOUT;
+		}
+
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	} else if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		dev_info(adev->dev, "reset compute queue (%d:%d:%d)\n",
+			 me_id, pipe_id, queue_id);
+		mutex_lock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
+		WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
+
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+			break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout){
+			dev_err(adev->dev, "failed to wait on hqd deactive\n");
+			r = -ETIMEDOUT;
+		}
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
+
 static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 				    struct mes_reset_queue_input *input)
 {
+	if (input->use_mmio)
+		return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
+						  input->me_id, input->pipe_id,
+						  input->queue_id, input->vmid);
+
 	union MESAPI__RESET mes_reset_queue_pkt;
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
@@ -622,6 +695,11 @@ static int mes_v11_0_reset_legacy_queue(struct amdgpu_mes *mes,
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
 
+	if (input->use_mmio)
+		return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
+						  input->me_id, input->pipe_id,
+						  input->queue_id, input->vmid);
+
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
 
 	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
-- 
2.45.2

