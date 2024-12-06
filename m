Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57D7E77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 09:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9101710F03A;
	Fri,  6 Dec 2024 09:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nwQelPmz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E6210F03A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 09:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsAlhs016unewcu8dejtCWWES0OZeX7nbhr8E3oZBLildJEHIn6o8hMj4v1Eh1jkMX10DXbn+Yl8P+irbijS2t6AaL/QynRj2S+v/oUvVSHHdjUgKNUwBHBHa7GpqpbOt93sPM/mzS9ljqcme9102gVnkVhFt4Algff1IzaU9W68XnK8s7zBzs/1yGCy+BVh8obYgDiEpH6LdJ64w7IyVDAfSiQuHcWgrZwKw6XM0KSSBvvE7d0PbVOcrGNoMG7vw0Z7d7DSAxxIaHp9U9vBqN317FUIJaInAumZt52eUDojJk0LQHOXXL0q+f+apNzRNaUEz1efv66PzITSRKhP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8I36v3ARjXAPXeGRiaQFogol6UEebv0Q+XLa+GBeIo=;
 b=DY8TnxhGbwV4fJDOo3Djj5zaIULiIx7rtLfPb66fc1Hy8tI908KTXR2zfc3r5ilEVY7z6OTwtjgpS9bRYDGRgtMlmwnICXoOOyUr2IqZYNpEAV6mWqwEn9+k2BwWAAeKhD7pW0rehfEmhZMnV+LoqK8OrCpWz0nxxTGPCDT14CzAj4pQC9kJlCHBOU+rsjUTozotuTZQmi7YHzA+KchJvVCPDEvT6Dc/rG5HMficAw/ykSH79B/JTPXUNU4OAYKakIMBVIgB9G2dHNas5Uzrqg4vQ3Jbydro0lOfEqxuBB37qVTeLeQ1rAvxLs3EZAOfpctxn2M7oGYSuoUzE9xvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8I36v3ARjXAPXeGRiaQFogol6UEebv0Q+XLa+GBeIo=;
 b=nwQelPmzn6awVb2SAGvsKO4Kw8aC0F9hNYWwj2v6kZPW9CByk8As4MhuR8su0H/zs1rZx7Y79BOjQmqLUmRAexQRH0HihktCTs+pNRx9zO3cN8jmhziOt8CItqRZW8taY/gdn/7IcJ8LmqfS+pFtzEBiipZbf6IEl91CgowFltk=
Received: from PH8PR21CA0011.namprd21.prod.outlook.com (2603:10b6:510:2ce::19)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 09:05:35 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::d3) by PH8PR21CA0011.outlook.office365.com
 (2603:10b6:510:2ce::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.8 via Frontend Transport; Fri, 6
 Dec 2024 09:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 09:05:34 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 03:05:31 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Support nbif v6_3_1 fatal error handling
Date: Fri, 6 Dec 2024 17:04:55 +0800
Message-ID: <20241206090455.182520-4-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206090455.182520-1-candice.li@amd.com>
References: <20241206090455.182520-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf5c6da-5ff4-4150-1c10-08dd15d524dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?toaKTGS+vlB8PMA1JKSOqGkcaW/slKTepo30avFKghIsrkgPtk524+3S1aBI?=
 =?us-ascii?Q?qKlB1rMtmc5mDDzn1vsE7vOHQO+hJi0xnnLzN2LNiE9AlXuGy6PTvDu6usYR?=
 =?us-ascii?Q?l9S4Z69J745gXcqyfBBKlVyQQ3aBmh81XTwO2AAU8JHR5ROnytpqLs9eo5NZ?=
 =?us-ascii?Q?BZ+jFKOim0Y3bUCy0D5xvbtkAXN5Y9xN131BHBKSjf2jOBlbbtS8n5iQymCU?=
 =?us-ascii?Q?aoJ6DGbpUz/7iWFrkJ5nVCwC5O/E8A44MdNsZ1ndzYOV8/QMIKvyb+P+JVCv?=
 =?us-ascii?Q?oQ5Za3aS5guy+cUBRIka39dR3UU4/xfz4S9vvWJJ3z3MpMHsrHwzKkaZD02M?=
 =?us-ascii?Q?Iy3Or0KSx4H3yqsIzgUWmH9cZUmqRKJF2Dp+Vxl7cyF2qzb8obwAj+2f/2ij?=
 =?us-ascii?Q?I6BMBiLooyS0XQS/3JhoLVXh46O7F3ivdQiUgWLWbFNtzJ6rIm15VKE1/eBo?=
 =?us-ascii?Q?S5Tb1fUdT2MpHgYhJrMe31UcL9Kr7ftixMLYxDN3FbWd0msXuA9ahrv2gvUV?=
 =?us-ascii?Q?39+Lf1zZbWSOo3rnMIOGiZv752p2jxuzaHYaVOyEPQSiWBRr7guDZJKHBz/+?=
 =?us-ascii?Q?jIIvSphqfFDH1J6SovzR64v7HSdpcH9SVvYfDOIBGwnQ78TKi9IfEKSieqqn?=
 =?us-ascii?Q?pQyiHMNQgI62VHcAe2s9fkz/gtgcVfxOHBCi4UI+JVAoGntdd49hrZbdzkGP?=
 =?us-ascii?Q?4hqXck4q0GV6rOZKJuoYgragUSpNmpIe+nGSt6I2XK7OgqaOGWxXTRERWoob?=
 =?us-ascii?Q?vgYjnG/Dx6TZ6pqXMLPOrQ3gK3aRI1okIwPcWqYIlgd5vUxdhMjVATvxMZO0?=
 =?us-ascii?Q?ouE2ae5LvfsMTLaa5Z3OoMkiWMBn5jw5RoBJZND8z7ZhoDXNTFvNXMwSIlMy?=
 =?us-ascii?Q?vRG6B8Apl2Gj3q0jaMLKb6uP5x8QhY+wmFJ53dwzlIQK080Jtjk2Z6jGkqgG?=
 =?us-ascii?Q?xwHAN1ROyrvnR4oAFYREAxjex5FOzA6zu5ovCmmxC6MuMaD4t1/UcW56rb6J?=
 =?us-ascii?Q?ddOxcZvsS918LiG+zvOa0eBo/08/+NorYRDtDX+0NQ6zHmvgaHioLHkVA+ws?=
 =?us-ascii?Q?PWmdkQwxKVYqSgC9q8rcXVHlXQodqg07cPoJXPMTBVIBVT4Chrspzu03SUNm?=
 =?us-ascii?Q?B4hXy/itz9NnPb+D0wwYjwm64/ow1UY/CWeCzlfBZR+lZ3zvfwPNf+4FLyJS?=
 =?us-ascii?Q?jFJsbEoQj8LhUbvyOWlMVep5K2YE+PYt/2jeV29SQKxSe4q7IvuYZc3s0D4e?=
 =?us-ascii?Q?usnJQNa03typQTp8q1cx3cXtn0hJhe6mwFvyzv0xk81dsBZysDTConeR4WLw?=
 =?us-ascii?Q?DYD5aRjKF0A0uhWOXaSBfDo74VRqpX9sYFFTVt+qyabhKWoYQIzmpVFfF977?=
 =?us-ascii?Q?iABjVPQ4k36gZLyun5YiSbYOQcHRAAHbN5+sJ57ai77fYyOuEeeD/CDIWWBQ?=
 =?us-ascii?Q?C907Z+9H7cBlkC7vCS+k/FYPxBpdz6cA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:05:34.5382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf5c6da-5ff4-4150-1c10-08dd15d524dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123
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

Add nbif v6_3_1 fatal error handling support.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 12 ++++
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 81 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h |  1 +
 drivers/gpu/drm/amd/amdgpu/soc24.c       | 19 +++++-
 4 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 623ae9b3880037..db081618e85c3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -36,6 +36,7 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "nbio_v4_3.h"
+#include "nbif_v6_3_1.h"
 #include "nbio_v7_9.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
@@ -3911,6 +3912,17 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			 * check DF RAS */
 			adev->nbio.ras = &nbio_v4_3_ras;
 		break;
+	case IP_VERSION(6, 3, 1):
+		if (adev->ras_hw_enabled & (1 << AMDGPU_RAS_BLOCK__DF))
+			/* unlike other generation of nbio ras,
+			 * nbif v6_3_1 only support fatal error interrupt
+			 * to inform software that DF is freezed due to
+			 * system fatal error event. driver should not
+			 * enable nbio ras in such case. Instead,
+			 * check DF RAS
+			 */
+			adev->nbio.ras = &nbif_v6_3_1_ras;
+		break;
 	case IP_VERSION(7, 9, 0):
 	case IP_VERSION(7, 9, 1):
 		if (!adev->gmc.is_app_apu)
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index 39919e0892c148..c92875ceb31f45 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -28,6 +28,7 @@
 #include "nbif/nbif_6_3_1_sh_mask.h"
 #include "pcie/pcie_6_1_0_offset.h"
 #include "pcie/pcie_6_1_0_sh_mask.h"
+#include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>
 
 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
@@ -518,3 +519,83 @@ const struct amdgpu_nbio_funcs nbif_v6_3_1_sriov_funcs = {
 	.get_rom_offset = nbif_v6_3_1_get_rom_offset,
 	.set_reg_remap = nbif_v6_3_1_set_reg_remap,
 };
+
+static int nbif_v6_3_1_set_ras_err_event_athub_irq_state(struct amdgpu_device *adev,
+						       struct amdgpu_irq_src *src,
+						       unsigned type,
+						       enum amdgpu_interrupt_state state)
+{
+	/* The ras_controller_irq enablement should be done in psp bl when it
+	 * tries to enable ras feature. Driver only need to set the correct interrupt
+	 * vector for bare-metal and sriov use case respectively
+	 */
+	uint32_t bif_doorbell_int_cntl;
+
+	bif_doorbell_int_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL);
+	bif_doorbell_int_cntl = REG_SET_FIELD(bif_doorbell_int_cntl,
+					      BIF_BX0_BIF_DOORBELL_INT_CNTL,
+					      RAS_ATHUB_ERR_EVENT_INTERRUPT_DISABLE,
+					      (state == AMDGPU_IRQ_STATE_ENABLE) ? 0 : 1);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_int_cntl);
+
+	return 0;
+}
+
+static int nbif_v6_3_1_process_err_event_athub_irq(struct amdgpu_device *adev,
+						 struct amdgpu_irq_src *source,
+						 struct amdgpu_iv_entry *entry)
+{
+	/* By design, the ih cookie for err_event_athub_irq should be written
+	 * to bif ring. since bif ring is not enabled, just leave process callback
+	 * as a dummy one.
+	 */
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs nbif_v6_3_1_ras_err_event_athub_irq_funcs = {
+	.set = nbif_v6_3_1_set_ras_err_event_athub_irq_state,
+	.process = nbif_v6_3_1_process_err_event_athub_irq,
+};
+
+static void nbif_v6_3_1_handle_ras_err_event_athub_intr_no_bifring(struct amdgpu_device *adev)
+{
+	uint32_t bif_doorbell_int_cntl;
+
+	bif_doorbell_int_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL);
+	if (REG_GET_FIELD(bif_doorbell_int_cntl,
+			  BIF_BX0_BIF_DOORBELL_INT_CNTL,
+			  RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS)) {
+		/* driver has to clear the interrupt status when bif ring is disabled */
+		bif_doorbell_int_cntl = REG_SET_FIELD(bif_doorbell_int_cntl,
+						BIF_BX0_BIF_DOORBELL_INT_CNTL,
+						RAS_ATHUB_ERR_EVENT_INTERRUPT_CLEAR, 1);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_int_cntl);
+		amdgpu_ras_global_ras_isr(adev);
+	}
+}
+
+static int nbif_v6_3_1_init_ras_err_event_athub_interrupt(struct amdgpu_device *adev)
+{
+	int r;
+
+	/* init the irq funcs */
+	adev->nbio.ras_err_event_athub_irq.funcs =
+		&nbif_v6_3_1_ras_err_event_athub_irq_funcs;
+	adev->nbio.ras_err_event_athub_irq.num_types = 1;
+
+	/* register ras err event athub interrupt
+	 * nbif v6_3_1 uses the same irq source as nbio v7_4
+	 */
+	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_BIF,
+			      NBIF_7_4__SRCID__ERREVENT_ATHUB_INTERRUPT,
+			      &adev->nbio.ras_err_event_athub_irq);
+
+	return r;
+}
+
+struct amdgpu_nbio_ras nbif_v6_3_1_ras = {
+	.handle_ras_err_event_athub_intr_no_bifring =
+		nbif_v6_3_1_handle_ras_err_event_athub_intr_no_bifring,
+	.init_ras_err_event_athub_interrupt =
+		nbif_v6_3_1_init_ras_err_event_athub_interrupt,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h
index b7f2e0d88905d2..9ac4831d39e17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h
@@ -29,5 +29,6 @@
 extern const struct nbio_hdp_flush_reg nbif_v6_3_1_hdp_flush_reg;
 extern const struct amdgpu_nbio_funcs nbif_v6_3_1_funcs;
 extern const struct amdgpu_nbio_funcs nbif_v6_3_1_sriov_funcs;
+extern struct amdgpu_nbio_ras nbif_v6_3_1_ras;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index eda03d40d76589..6b8e078ee7c751 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -444,8 +444,18 @@ static int soc24_common_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_get_irq(adev);
+	} else {
+		if (adev->nbio.ras &&
+		    adev->nbio.ras_err_event_athub_irq.funcs)
+			/* don't need to fail gpu late init
+			 * if enabling athub_err_event interrupt failed
+			 * nbif v6_3_1 only support fatal error hanlding
+			 * just enable the interrupt directly
+			 */
+			amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
+	}
 
 	/* Enable selfring doorbell aperture late because doorbell BAR
 	 * aperture will change if resize BAR successfully in gmc sw_init.
@@ -501,8 +511,13 @@ static int soc24_common_hw_fini(struct amdgpu_ip_block *ip_block)
 	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
 	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_put_irq(adev);
+	} else {
+		if (adev->nbio.ras &&
+		    adev->nbio.ras_err_event_athub_irq.funcs)
+			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
+	}
 
 	return 0;
 }
-- 
2.25.1

