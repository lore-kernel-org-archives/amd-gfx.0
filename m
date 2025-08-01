Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DE1C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 06:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B2E10E2F6;
	Fri,  1 Aug 2025 06:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SJOcM3oa";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C0410E2F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 06:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1mlnM6GG1SEwuGQYGVcy+rCJXz4TpcBp2sLKR+RlqwnIEyBmwyJnZsDuvlYSExQtFGpgypVfMYI6tYuLYSjUviGtMI9aJ5DsoTZijd4YC6lAVysb/DBmtGtQTzOlacxh7u+24KPiaoWzExN/Gd0fU6V/9AFFUzLyv5NOvE+K7HYKViY/VUpEb7R2ZBSRN5UL8F2ot3zPRg9dVLjPvrONRyCpKt977r+EoYCb7oNyfpr2dOsKfLj+Hz8cyco7siZU9xL2LQrRtpe6+jSJ3TTxl4vDGkIzeMZbeRGWQCMnT1R/07K9JJJQESgHIL/Q4PvPnxntd+TFSm6II+tcpd+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQjIkKgbRDXPykNCmEfWgpRaoLttMhaTBxDWd1bcZAo=;
 b=gOP8/aZghwqqUjdxqiaS7Jp52pdQSZ7E6bgkIqJvB66BYU+0lWr5YjU8JHQRZl2VoTpM0UEcX3m7WNyON5ydSPGITB4auo9PKAg38QPrTiXSTVHuJ9woj1MjhJCGFeKLLJ1inBeGXvmL+Dz2RQzL9nyy7K+RRa3XN300KYLidvDQreXJlwoQdW9kMeSeUkpEz5RXWhz9+wrWoaCSa07x9G9crqfS7M767+yi+SgxYt+JMgM3qY9dC0qp0yzQxunPt3y4iGdt67rraxSzoF1PAl60T4prfrWEIc6P9Vh6F3fNiz1hlsLEdRGzng8/HkCv/AeVYDEhnTld3DFXBCq0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQjIkKgbRDXPykNCmEfWgpRaoLttMhaTBxDWd1bcZAo=;
 b=SJOcM3oaqV/lzFUTQCsXHd+229IrlJkk6tepAlrzlfcpj830Q4FTJ+nCTzSAEMQpx/fc8MGcKKmcj+XGKk/zARA3TnknZBePqK5uCHmGOH2/MYQzWlKT61ZUyeeBq0wqJLgaPZnIroqzjylneu9bogME+ZMDB7JrEnny0XyVJx4=
Received: from MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::28)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 06:26:12 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::21) by MW4P221CA0023.outlook.office365.com
 (2603:10b6:303:8b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 06:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:26:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:11 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 01:26:09 -0500
From: <Alexander.Deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, kyle-hai.chau <kyle-hai.chau@amd.com>
Subject: [v6 05/12] drm/amdgpu: Implement active VMID detection in MES12 queue
 reset for GFX
Date: Fri, 1 Aug 2025 14:21:03 +0800
Message-ID: <20250801062547.4085580-5-Alexander.Deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
References: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Alexander.Deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 098ec478-a17e-447f-6b84-08ddd0c44f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uGsd7GuIQ0iL6PYNz0m28z79juDJJeQp7eh2FzsQNdoZiAwwGJxWkZpuGPYV?=
 =?us-ascii?Q?g3DNJXsjRIks82v0ywF1IjEkcP27na30cD8zjkt8ucNT4eiWMR/Gq5yg9fOT?=
 =?us-ascii?Q?NqLEDL3F31bvdPAUnSbrjanT6CEw7hN31IfceSl15hLe9ZCFbml3lDo3iNq9?=
 =?us-ascii?Q?UQCCCE7yHZi1thfUsLHiAY5znHfOwmIuA/5efSpEy4QAHaKaPzK18XmUPnWu?=
 =?us-ascii?Q?KON92WE+gs8gKjTRC6CWRH7kOneOmSsAo0tgGudEMMQ9tfjpl2zu7HiHwvYM?=
 =?us-ascii?Q?rexY0RCmI+gHBe64y3QD6g0PCzRU3yNKO+KFaoyI1zol6/bK28CUce9Sw3Bu?=
 =?us-ascii?Q?grTAf2nsGDGN/GYX7bm3QErqhZdsa9NpbrAMY7jRsCVGFlG/8dqRXEBlwq5V?=
 =?us-ascii?Q?wJgIS48YbvEdb8IoL+sPORjtyz2Lm4KSPeadfNN3hWJaPK7m9pZ+P2Akqfcz?=
 =?us-ascii?Q?fWwHaEj2iShQjuMJzU5dET6KCMZrlWoBtHthmxpzFsgB6uA7fj8TcAZm5QUI?=
 =?us-ascii?Q?RjMTjI/93lIFZrQopsWjXcV/X4XUexdQoF+mL0OgD2tCDNIP6pi8G5QwTMlI?=
 =?us-ascii?Q?wpqr1p680YBQ0s3DmS9hYWrQS3XK2a4tXyrCLgAFrieP8zNWGcKzy5sgepGN?=
 =?us-ascii?Q?agEIbfmZQBTVW9xEHUcx/JfFmJk+R9gJU0292yN0i0495dRT1+NsyA3XWIU4?=
 =?us-ascii?Q?qcSxTdOFucn3siU75PBhZbnBjI2jVg0F7AVe4rM/9xMx4D1h5IoVgBrhBLQr?=
 =?us-ascii?Q?4fLgxQlN3Qj0wZbwAnfHdU772BC2f+pGlXIyWPgtaVc1Q7kHA28T3SSzo2T+?=
 =?us-ascii?Q?KyEpmgyw365LiIfSJ+6KHp5llo9x4l2y/+aciqdqcnWydry9/V1ffms0QKIf?=
 =?us-ascii?Q?GDUPZ2Q1MB7goauKY6DkO6umiSxAxpjgRFHEGBTfvlAk/fHsNxPOJj3r4zaj?=
 =?us-ascii?Q?Kuj91T9/8jKNVKdW3PctYzyLPM/9qRGMQtrORlxQOsPLKNlMWwnDU/Z0nQr8?=
 =?us-ascii?Q?hdC87nsjFEXUqSA0SSAbQdIrZS7MVGt0KGpjRm5E50uzyVTOHnVtOb5wbV4e?=
 =?us-ascii?Q?o3CD1YYWMCUWXUZkDKRCm1WneCxJ5U4xuCvqsU/GDQc63CT2Da7oWo7NPRaq?=
 =?us-ascii?Q?lTmmV9ePrMrsDfxwahioou1ZtZcWQkoJxGjBmoGZuhlkouSlSuU4XIjRwXcx?=
 =?us-ascii?Q?DMrbCPpEZi3+mMzW86n9mSXepxCnnSWx6/iv+stMlZJp8Vu7LyyIJyY3UPoI?=
 =?us-ascii?Q?+w+HgvK3/Jb6fRdceH08PQyXZwpdj6TKth3Lm5IyG0c0BqCARYGc/EusZ/3D?=
 =?us-ascii?Q?cTkrrZGRppg1m7cP8p9aYJXHbal64Y11slSHL4Lc0PwefMSqkY0XZl4kR7iX?=
 =?us-ascii?Q?Z5ZD1cMfSH7SsZQmIBEJh+cxgFr+mAjsBluEj7UjRqnkwaAZOGVCjsaTgWY7?=
 =?us-ascii?Q?Vr3FIWAOpPWkM9BB3+aizYYxMGcwl7Y0WwZhuh6X72NXF1ahQ98bFC1zMu+5?=
 =?us-ascii?Q?runUYT+wCVBfQHCsEbFHLZ9ccHVyzvxwe2aa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:26:11.7776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 098ec478-a17e-447f-6b84-08ddd0c44f4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

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

