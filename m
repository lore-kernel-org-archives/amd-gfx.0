Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344C1C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 03:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C8710E26B;
	Mon, 16 Jun 2025 03:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A9b2L0sh";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B294610E26B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 03:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWvtXUuytvJRdlRMrDIbykchcWziy44DGUpuW5lzLe/ESB2D8BVS+xpCnTfdI6PgdCqLLyje7zW18SyHC3RK2IjtOgXc+tgLFGTfGcj6ZhCc6Rfr6UnmDezXyiiC+SN/G81BNHJMegLaezlWkY0ur13Qg9MkQ1dON+3yjyQA5bhyIP9pWx7ZXPwLTM23J13y5z87B9ZxkzThVf13xUokEwAm/QJ8UfavhWai1xG6LHOnuCeTnd6+zbl1gOUCoY6CB+lO/ArFqoDk3XVDTDZ7VUOOkAKS3pRZe3kJzCjf/tWUFAE0xQmuZb9cl9IbzEiE+X4dxNVQbhCafIEf+XfBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4NDuosIPo3V9S/tBg37zNSNyrz4VgYcT0bDZbbErNM=;
 b=YJ3BLAJvInXsIx8hZ8Lc4GM8XUr5iRZmc5OibZSh7TcKy1L/A83GK274bm1MfTEyxmUWnwZQOPI2dE8Un/5XhKFfJWPF4k+FNap78/DZ/IWgxUolEZYshttM3v99OOIFKaB5ktmzts4je1iA1tU0X3jhEDifhlTko72fMour0pF+tx/G+b8Wt1XZx9Jw+Vy+eQ6ES0gu9ssJjVY7Gd+l//OW+fSz8FirTbPc7ClSdA1lPt9TBBP39U3POcGBrcMR7oL9OUfkWn94LCDliBs7db+bQLXXx1qK8GX1UXXNGDxEmv3vDO2ahEhit9M3UCZ8BxxlC6MY/frVxLZTVoc4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4NDuosIPo3V9S/tBg37zNSNyrz4VgYcT0bDZbbErNM=;
 b=A9b2L0shB9nr5jiHCvIROfDiSesgLcgslvohBtMXqEb0bexOpWiSkXiCsh6VJXWHovry73g3BRbKAyO7LEtZLoy0LxsbtsSeeuxxQDqYzOwuyFAb3dV4dfutkiA3zf7KcasSq9NAZMyGG/k93uNSEO3C5K7Er4i9vOjyLekOZUo=
Received: from DM6PR13CA0022.namprd13.prod.outlook.com (2603:10b6:5:bc::35) by
 PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 03:46:30 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::ce) by DM6PR13CA0022.outlook.office365.com
 (2603:10b6:5:bc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 03:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 03:46:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Jun
 2025 22:46:28 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 15 Jun 2025 22:46:26 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, kyle-hai.chau <kyle-hai.chau@amd.com>
Subject: [v2 4/9] drm/amdgpu: Implement active VMID detection in MES11 queue
 reset for GFX
Date: Mon, 16 Jun 2025 11:43:37 +0800
Message-ID: <20250616034605.2683434-4-Jesse.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 3786800d-4e70-4148-86cf-08ddac8860db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sbZN/ow5Pk63tFw+6kSRJoeXtsCyUANhuAaqVfIr6XPVJX/7oBudKPdK7bnR?=
 =?us-ascii?Q?wWbqLitJzlZ2uRGDovaELVal9rHwukFbldvrgvqiLGivrQhCkBkY0SjeqKsD?=
 =?us-ascii?Q?5pux4buLXpl/ReUXzL0AdRQXj/nM/srbFnoyP+5ygVf+7wsvKJ4JfCcDI8H6?=
 =?us-ascii?Q?qJwN9CJ47hFx3zhhRVWmVThwSFivjzNZ0BbgqhKIAAU/Stu+7cjV6OmSze7D?=
 =?us-ascii?Q?0Ton6iZP8S5Ffi+zK6y9Em0fsdyVneif0f86mIvuvvsKTqWxeLKQgXTerMY6?=
 =?us-ascii?Q?eqo9JkWJdj1EMv6/SSG7rnLy2j9OyNSxPC2pegbVHdYtPx3w08KQG9jU1xOr?=
 =?us-ascii?Q?heXEyw0hsw2hqpbhGx80e2s7nki/IQQE5+lriG5BYgKuKIVhUEnRGu9bKLFI?=
 =?us-ascii?Q?ZZUam+epxphmDQ56vFtPlFapcWiSmIi+JepNiW/1n5sBQl57YVMh7PV2dyl2?=
 =?us-ascii?Q?vk70Ykysr6+/dzmXb57ZUzLsIoHMObn8YMQprLkMehFcvuD7eddZ6RZJnHUt?=
 =?us-ascii?Q?CV7TitPUEuhTt/VOHT8pXN7Hh2t7TOJPegf3wSTav25+iJXClCuq66ZJ10qO?=
 =?us-ascii?Q?0UOeIBDURBbX4Qt5JJkxzfNqce+Q09k1+J36CCkJQZlhGKpbAk+gewQLMYYh?=
 =?us-ascii?Q?bPA46vWrI84OadEJA8S7zOVmDUYsWl8njrjE6NE04t4P8s7G1r28+EbvYT8r?=
 =?us-ascii?Q?pT0XJKRgTt9l3Kob3ZeyaRspzSv/dhs5flqic3lTY4RCjhCNG93dFjMf2ows?=
 =?us-ascii?Q?WyZTy/9V5HbJo6/m65sdVsSeYPyf/Bg9Ll9KzFknzJEujE+IlRtoJ9dHX6w9?=
 =?us-ascii?Q?na+zEK8AwfYUEw4H3Yts13Sn5ebnPOswwkzgGykDTVL3wfJzLwo3JiY0ioCO?=
 =?us-ascii?Q?AZw8TgiHjBUDu5Rjo4/uaPx6hkD+RyXeDTI05Nos7RPq6x04kMDUSdc4Yyyn?=
 =?us-ascii?Q?ltFvaRZEsO/DNUD6z/UcvYhV9LGyKSFezqrUxd3VocVTj7vLqT6IuwSYNsKO?=
 =?us-ascii?Q?F0LInyD9O/NKDqrmYDoikui5mopNh/sPMlSaZBtqjRuSTvCB8usLvu4nA23b?=
 =?us-ascii?Q?WOnjMExUVF79ABT3jM4vN8LsU65KL3M2M0zm3oA846eohVpLLsmzqEyiBsby?=
 =?us-ascii?Q?Fr4kl+xKRaO6+tS7VD2YBwn0nwr7cwOzZ6njNqoWbTN24AwhCnJFa/d21Hi0?=
 =?us-ascii?Q?gwrXjh8szUQfWK89rX+VYulGPsdGkgfHo4qjq9diRZSxKAZc61KpOsAriguY?=
 =?us-ascii?Q?CjltRpcAAb+IZVoxbyJjUPgQfm/UtuOV3KqZ/9vnhRRIHPo8d6HtFyTvrnGJ?=
 =?us-ascii?Q?cmwV1COF6SKmgHLzAtsJqUYiO94j3qlftENXrmSfr22K9QxyOpp0I/mTpcGG?=
 =?us-ascii?Q?7zWETd9GOsaC8OUWYvgaUCJXmIYv0NYXiFr1CoajN4Xl65tVD3DTPIOdZKqg?=
 =?us-ascii?Q?CH/KP639azur5iyJzuen+Cgl7QMI7btKEAVqegT04kP7a242BVVcB9XlLpA1?=
 =?us-ascii?Q?N0+WessAfQOsTmhcuKatjA6kdp674n/hhzlc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 03:46:29.5991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3786800d-4e70-4148-86cf-08ddac8860db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012
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

