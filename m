Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59439E7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043B810E4C6;
	Wed,  4 Dec 2024 15:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j/z7+geJ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D416610E4C6
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPOAUTI1C/pzLbEw4F96QfGIqUZ74sMh47tuX7eIheydSJ3HBYdDpcTS8IJHm6Ho3tCSbyjodSCcIuLLmNVbHDjJDItkGHStlRjjzjGzhDTBgq+ryMd80j+r8WJQp5vtfXnQFdURauouEuKKfZbLxCqNmmM6BYI99ai5HggEgO8fPMv7okvzj8+JhkEE26l1D7oV7o1mbdjTbD0DmYU1QX98BOO5l2YycZr5K085eazlv5lOzuimY2neMNapMeftPbxWIUX0ReYeSCS1oCvLhsh7euUqTQmIvRqkTMrbMkaf3Y/gADPDpkJd6uNQCWVWy85g92/ur1PXhpSVEPamjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4I2k4hjcGjK/Iyx/KPd/Ut8+yatb01tfAZxaorWZhs=;
 b=JxhwpMRrnMKnDJNx+NyQiGQf/nUWaRtBRNdjvNOr6Ah/qF+AiJJHc4IgELf4ytAEboyZR1Yj5YWOyVJtnFWV11oGNLv6Hf6qppCwHziw3Lzq6fFuTxv2jmiUine2GYSOqEp17anYakX1xw5fehJtZwIdSXvNz/oCw5dge972Gk+GAZVEr92mdnjGR6mahzQ/0QKsFa9oxD9bntMKhM0AM4/qKtXyxU5FoWoDzrC3c0fG8tBNiGt0DYXszZ5IezdGrq0ae1r43pMmCSZcH2VGKObjadUjycbM/ZP4pa28AVDicbMhbXSPjQ4515kCjlk6fXLz+Gvn3F6NJdXQXrdC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4I2k4hjcGjK/Iyx/KPd/Ut8+yatb01tfAZxaorWZhs=;
 b=j/z7+geJ5s6KPQXjdNv9B284vJDAfdd8qjdbE53OdRcwkKiseciwjM3xSKTinCSxqkmUg0j+huwVo66ysaMXXdthPmUidtgYDUpMvtK6rXvKyQNBQnyvVa3KdP5FcPg/XAKQ/Z6iVa8gT85Cr7/+dUtVYLwLpJk5CgATHcXk9uE=
Received: from BY3PR10CA0006.namprd10.prod.outlook.com (2603:10b6:a03:255::11)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 15:08:40 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:a03:255::4) by BY3PR10CA0006.outlook.office365.com
 (2603:10b6:a03:255::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 15:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 15:08:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 09:08:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Load spdm_drv for psp v13_0_12
Date: Wed, 4 Dec 2024 10:08:20 -0500
Message-ID: <20241204150821.3424757-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204150821.3424757-1-alexander.deucher@amd.com>
References: <20241204150821.3424757-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 574fea31-8c8a-41c6-e7c4-08dd14758845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6uhbG0djcBqQ51PUN7xIzw8CR9bF9vLPLKh74SMxsY+vG51GSR+KeqY9JqTt?=
 =?us-ascii?Q?P6pVeBo9ak+Zo3GUCiQZM/psm0Pc9T2TQ34D99PjJseP/PF0F2RKTenxE50G?=
 =?us-ascii?Q?FsTbD/rpqCf+Qhfu+tfxyVdU/5BYoktJzYY91iRYbmtG1s3yYmgwwGrWHHhr?=
 =?us-ascii?Q?J3JYpYma3ZeYwtaJITOTZQiuSd21P7ZpE+I2nYidWmeKOo0MHxxJSIO1V7zU?=
 =?us-ascii?Q?8nckyoi/X/0YHj/c6tteebE9LTEjl/mfWrsXZ+hOGliylNOj4uQNYm56TIVL?=
 =?us-ascii?Q?fsfncogUg0cAiBDjHpwSbyvlNghSVzcIeb0C7I5Z8pGK1ZXWG0/d/KzlU2xI?=
 =?us-ascii?Q?AXpiM3t4OVcRoGUkqrbQQGcvnAbLv4eB4adD2jq48AXcNE3O2OXkakDz7eno?=
 =?us-ascii?Q?oLzijHTGKUMDbmmqIhsNi6KHgJqyfBquX7fr38yQhLH1NU0CDgrI0bmpqjZP?=
 =?us-ascii?Q?W60hey7FCwOrSdNVyTEfK+RpI2UEMb/kaR51lvvIB4vUX7jzMyVYhwDCdXg/?=
 =?us-ascii?Q?2YjzBVho9tT8gpo1JCOEjd1+vuXIiCxQtHfc6F0DrRxjpbJjLYQUfdB7WChR?=
 =?us-ascii?Q?5yj/3+6T6aRkY3/U9l9lRFHgFIUj1HAYj9zcIRPlb2vORBhC1AL+gnwJfi+c?=
 =?us-ascii?Q?rIRMk27MoRqoB7gXNkk0vgzMRlc+9Ko7nTAwJwBQuaumgvQyXWoq8Xfs1GAs?=
 =?us-ascii?Q?oCgwAbrsTYgVPDIeCkFkl0pzQ9NeslX5Mkk5WVfHIK3a0s7HSj/lB/ZYsVNT?=
 =?us-ascii?Q?gsdw+Jh3/FGAynEUOBTXRnlqoOD5IFhicm+EjoF8DixLr9XcULN2a/Ert43q?=
 =?us-ascii?Q?PQHFs/aqOAoQ78d+MMVf2FyPt1gemR/QVRKjty4L9H/5Pl4YylXg0MteE877?=
 =?us-ascii?Q?Q9hQwcmbbBSEgmDUUScDsuHdHUAaVa/FvJCWkzAN15g+DgiRbQmObOcmhbTq?=
 =?us-ascii?Q?slKm39zxrCfeN6iQWaYEKT61j90wx2M85R6Qc6nwg7dL374x2qCPf5YZjyBC?=
 =?us-ascii?Q?wmRp/lJi52rGR6Dd2NSxfnok4MgFeJbUIrUmdrPCP1ar3gzTBdjSppNr8Zsu?=
 =?us-ascii?Q?nTu2WrC5mxkbHUbpo+ie53MsWS+KN31Re4RFzzcv8JZlZccwq9uB8Pi5AdC3?=
 =?us-ascii?Q?eL5mpMqTLB9Omq2dfXTy/qgyR7YC8ut2sKqm/G0a4z5Vj3oqvkWTw8L5oJOw?=
 =?us-ascii?Q?Ji0n1q7ODfoDlP9u82vxcGHgXKjMmgfBeMKVhIVHPr/L/uRveelmA5ejSae6?=
 =?us-ascii?Q?WCcato8oEtej057r6GtHk7IVj2MrUHKYPdRtL4TJqlWM2sWXvJw2vya8GB4A?=
 =?us-ascii?Q?8k8vJaYt5LW+sn7DF9jUbLyhtWJMQjXLS5uwHHYDFvt3j4c8mxwz2PWTP3iT?=
 =?us-ascii?Q?Ge6fwm6ZEoJa1J1ZJXImOHPsPgix0E2ixPTkzU3svYX5pSmmthukRCY3G2W0?=
 =?us-ascii?Q?L0bUzg9Df0JSeLTpjZAaYuH18QN0N0h3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:08:38.4927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574fea31-8c8a-41c6-e7c4-08dd14758845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

spdm_drv is a firmware that needs to be loaded
in driver initialization phase.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c    |  6 ++++++
 4 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 87b368cf0e4e1..010c038b33ab2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2389,6 +2389,15 @@ static int psp_hw_start(struct psp_context *psp)
 			}
 		}
 
+		if ((is_psp_fw_valid(psp->spdm_drv)) &&
+		    (psp->funcs->bootloader_load_spdm_drv != NULL)) {
+			ret = psp_bootloader_load_spdm_drv(psp);
+			if (ret) {
+				dev_err(adev->dev, "PSP load spdm_drv failed!\n");
+				return ret;
+			}
+		}
+
 		if ((is_psp_fw_valid(psp->sos)) &&
 		    (psp->funcs->bootloader_load_sos != NULL)) {
 			ret = psp_bootloader_load_sos(psp);
@@ -3413,6 +3422,12 @@ static int parse_sos_bin_descriptor(struct psp_context *psp,
 		psp->ipkeymgr_drv.size_bytes         = le32_to_cpu(desc->size_bytes);
 		psp->ipkeymgr_drv.start_addr         = ucode_start_addr;
 		break;
+	case PSP_FW_TYPE_PSP_SPDM_DRV:
+		psp->spdm_drv.fw_version	= le32_to_cpu(desc->fw_version);
+		psp->spdm_drv.feature_version	= le32_to_cpu(desc->fw_version);
+		psp->spdm_drv.size_bytes	= le32_to_cpu(desc->size_bytes);
+		psp->spdm_drv.start_addr	= ucode_start_addr;
+		break;
 	default:
 		dev_warn(psp->adev->dev, "Unsupported PSP FW type: %d\n", desc->fw_type);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 567cb1f924ca8..8d5acc415d386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -80,6 +80,7 @@ enum psp_bootloader_cmd {
 	PSP_BL__DRAM_LONG_TRAIN		= 0x100000,
 	PSP_BL__DRAM_SHORT_TRAIN	= 0x200000,
 	PSP_BL__LOAD_TOS_SPL_TABLE	= 0x10000000,
+	PSP_BL__LOAD_SPDMDRV		= 0x20000000,
 };
 
 enum psp_ring_type {
@@ -120,6 +121,7 @@ struct psp_funcs {
 	int (*bootloader_load_dbg_drv)(struct psp_context *psp);
 	int (*bootloader_load_ras_drv)(struct psp_context *psp);
 	int (*bootloader_load_ipkeymgr_drv)(struct psp_context *psp);
+	int (*bootloader_load_spdm_drv)(struct psp_context *psp);
 	int (*bootloader_load_sos)(struct psp_context *psp);
 	int (*ring_create)(struct psp_context *psp,
 			   enum psp_ring_type ring_type);
@@ -343,6 +345,7 @@ struct psp_context {
 	struct psp_bin_desc		dbg_drv;
 	struct psp_bin_desc		ras_drv;
 	struct psp_bin_desc		ipkeymgr_drv;
+	struct psp_bin_desc		spdm_drv;
 
 	/* tmr buffer */
 	struct amdgpu_bo		*tmr_bo;
@@ -434,6 +437,9 @@ struct amdgpu_psp_funcs {
 #define psp_bootloader_load_ipkeymgr_drv(psp) \
 		((psp)->funcs->bootloader_load_ipkeymgr_drv ? \
 		 (psp)->funcs->bootloader_load_ipkeymgr_drv((psp)) : 0)
+#define psp_bootloader_load_spdm_drv(psp) \
+		((psp)->funcs->bootloader_load_spdm_drv ? \
+		 (psp)->funcs->bootloader_load_spdm_drv((psp)) : 0)
 #define psp_bootloader_load_sos(psp) \
 		((psp)->funcs->bootloader_load_sos ? (psp)->funcs->bootloader_load_sos((psp)) : 0)
 #define psp_smu_reload_quirk(psp) \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 9d0393f88bc2a..4eedd92f000be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -126,6 +126,7 @@ enum psp_fw_type {
 	PSP_FW_TYPE_PSP_DBG_DRV,
 	PSP_FW_TYPE_PSP_RAS_DRV,
 	PSP_FW_TYPE_PSP_IPKEYMGR_DRV,
+	PSP_FW_TYPE_PSP_SPDM_DRV,
 	PSP_FW_TYPE_MAX_INDEX,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 337b9d204aa86..49f5d57b3bbff 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -293,6 +293,11 @@ static int psp_v13_0_bootloader_load_ras_drv(struct psp_context *psp)
 	return psp_v13_0_bootloader_load_component(psp, &psp->ras_drv, PSP_BL__LOAD_RASDRV);
 }
 
+static int psp_v13_0_bootloader_load_spdm_drv(struct psp_context *psp)
+{
+	return psp_v13_0_bootloader_load_component(psp, &psp->spdm_drv, PSP_BL__LOAD_SPDMDRV);
+}
+
 static inline void psp_v13_0_init_sos_version(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -862,6 +867,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.bootloader_load_intf_drv = psp_v13_0_bootloader_load_intf_drv,
 	.bootloader_load_dbg_drv = psp_v13_0_bootloader_load_dbg_drv,
 	.bootloader_load_ras_drv = psp_v13_0_bootloader_load_ras_drv,
+	.bootloader_load_spdm_drv = psp_v13_0_bootloader_load_spdm_drv,
 	.bootloader_load_sos = psp_v13_0_bootloader_load_sos,
 	.ring_create = psp_v13_0_ring_create,
 	.ring_stop = psp_v13_0_ring_stop,
-- 
2.47.0

