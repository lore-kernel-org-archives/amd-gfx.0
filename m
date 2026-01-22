Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F795C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E86DE10E94E;
	Thu, 22 Jan 2026 08:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RSuopHG0";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012023.outbound.protection.outlook.com
 [40.107.200.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 439E710E94E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 08:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pF+aVITo/MufLJtH3V/nm6sOUUSHqQFT1KldDhAyazj+2psWQT4Rr/9EcS36r4W+mJe3bwpqNP3v9Z/vEedPVMbce7stToRRexMJItuEi7Pth6Tz6BIvmwyMdyPUGOB0sDyWhewmc6RM3HxGMiIcWq9tELLJKt01khSsBQku8Drdi/hKAAsekt8no6QAcamTzUjEPIniUWcELMa2VJsBZaNC2P8VP55I9lzctdv5pDAG8hgWPZHH4EUJPu8UU/fLygaCPAUNqJgGjGp9LoXsMPxGNIhBUfjQxL9nEQwwD8s7O7YTnAhpYbl6quwbCRtCBN9csSPP4SFnkfqLiF0Tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajwKxJR4/p1udAC3mz4mvLRc2NWw6HYPOIsi2kauUD0=;
 b=Sp41cVVp4MyGxvypbxgk0RxJWsLdiCY14eWr2o8uwRtmZrPyg28OmfeGOqBajPFywOVRA458M6bpek4Sh48emB2dFtIM/XnCLzkQAIOYfYp8S2Bdp+eNfH/XRVHJCI2EtHW49HdeTafIpn6vdo6CvvchNCeEXqFThNKdu2cJyJKNTFw/gHZioJveXa8tbLidiVfwsD5EXgDsSD91OhSEG+LaKES+AceN6NYjDaSH+NKL5w4dVCH6yhgmU7a4sXa62Y+hk3UzBMiou8KUyLgrVKj08eY0fxRyRLIRbXMQ6ZVI49Gl6nl6nZqkuEf8iKzr/2w9P/qdLstrpJAq1Dmdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajwKxJR4/p1udAC3mz4mvLRc2NWw6HYPOIsi2kauUD0=;
 b=RSuopHG0ALQ2MWMASP0hYfN7m1GpJ++lLtRMgNBuVU8mwW4Aj8FrsUMmulwAC7XOHF5BrQ6ZX7hD5HpxOOzh3QPKekB0s7KFMSXd/D32KG1SIv6ErveFlXunzABjuAV/3vkOEDAgsLUe2oiSy5E/zqgyiT8BlpqHUVUuD7Ej3ls=
Received: from BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 08:57:57 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::ca) by BY5PR04CA0010.outlook.office365.com
 (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 08:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 08:57:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 02:57:57 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 22 Jan 2026 02:57:50 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/9] drm/amd/amdgpu: Add mqd_update callback to
 amdgpu_userq_funcs
Date: Thu, 22 Jan 2026 16:57:12 +0800
Message-ID: <20260122085738.1542800-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|IA0PPF80FB91A80:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fc9dba-543e-428b-e621-08de599456a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XMT+jInz4Eu271Qo4YQYHmR/NI1QVYPhekbjqLamuBL780qpzs8BkBrmavkq?=
 =?us-ascii?Q?JW6ykal//xvCZLI9+Kt4YhSzVZE33/GOitmFEj0+f9cljkdisUE7HPoLfnKJ?=
 =?us-ascii?Q?0NVS4DF6WYM5a8dfIOk0bC1MXQsu+l8I44GTMiOPW5xdQ3heTTmuSMLxr6/E?=
 =?us-ascii?Q?VjXbjMYbWILYd4LLcphemaM5TtrnUU89LMh1b6llRVue2SaffsLlWbcgOKnC?=
 =?us-ascii?Q?d/495EiIQd1k2ICKv4vuR43oi2a442UtguxEFqFLYmuKyc9ObJrMch3f+fxt?=
 =?us-ascii?Q?cV75PcQ3VrQ1po5X8dRX9lrc55AdbpmJzkCgfMw1EV7M/VCIsmv5I9ghz7tY?=
 =?us-ascii?Q?eHnKXPw5YCa7QMOG81VG3s8S2QChGLqxPYeLRThrxKXVMBHGS4Jku5wgwsOA?=
 =?us-ascii?Q?l6vlY7FL9CvfFJkrd4l3X243gdVHG9eKv38lxL9RC2u5tFjHiLh6rCPbbykw?=
 =?us-ascii?Q?wmV0zkasP6qx5SCvJ6rGXRT1JqB/Igp2cqaL2CdwBZtdwhaAdAJNuPvHVPvN?=
 =?us-ascii?Q?ANLgfg5bGwTAL7IyZDhfWdtI9fkPN2hWvxai3vkE3QJWVjuYUTjeRQVoBEF4?=
 =?us-ascii?Q?HbyiXtaOX/9nCfQYnG/XO2S+nYyEXD6l9Srdf7D592bC8LPmglJQD9QR4t4f?=
 =?us-ascii?Q?sxACQtMQcUqHgd85mz32ExYI5XHkBoKhbZ5hef1/amvdqr1OCJa3suraVJ6q?=
 =?us-ascii?Q?o6YbQBO4GvakwtWZ237fmmU/bdSdnFoHlXuEFdQ+aiyqKRwO8ZCd8kvh0Fqt?=
 =?us-ascii?Q?fP8z6vlZK7Mt+5SpkI5ye+D1hL3qqIsRAriWTxDCZV3XCPAsd80VdYkcyPoW?=
 =?us-ascii?Q?jIVpxf3Ywr6MFPhNrKjaDNqRbkWJIFHFqja0L7N8lj4CBGAUF7thVLxdkW6n?=
 =?us-ascii?Q?sVhVMhad6mZ/w/8/aTDE14NgKfsCEcnZi644auJoxmoqAp/h6T8dz9DDR8zi?=
 =?us-ascii?Q?FGXC1TlfTryvgQcFnYB1QV6sIaCk5aOu3aEpssyDk4+k7ezZi3Q1RAezve6g?=
 =?us-ascii?Q?xJR3WEJylWKYGqrC/pc5mFGNJ9lTo1qd6//MYbR4zA1Cp7Ip5Vd+OMwRz6c8?=
 =?us-ascii?Q?Ijpc4H/nDS4sYeVfypzj1hEqavD+0pVCkB2JGIW7Y4OEZbVEeWz4gABUAiLr?=
 =?us-ascii?Q?OpG97lHoPTHvOyHFn/qC43XFxj/cXKdRtyUhSS8Is49jy+LNOGLZ31gZjNB4?=
 =?us-ascii?Q?RqestXkkflHqbFzbPg43eElbWc+opcKBz4kPIPoKixzsy1XGG+mv0pmWofxM?=
 =?us-ascii?Q?dyRa3L0aFwySWftSNVCRbPz3klCrFuBlzi8VNbll5X/IPSLl5RDjz8RSXkWP?=
 =?us-ascii?Q?JHFzz5SOH/a/ssKWtBy5rwPzYZFi5Qe4CsN3296NLEEsn8GwbZUBNn7BdoeN?=
 =?us-ascii?Q?lRGCtskWZLKLGloOnWufse3eH/pTKjS84j3l61fllY0xIh0PgbDnR2K3Kimc?=
 =?us-ascii?Q?u8o5f9ka7AyEDa26AAujv4avoGQ6bwD2fJg1SdxXCbBI66d91w9tU5gToS/4?=
 =?us-ascii?Q?ksf+CX4JsaCA7iIeewLI4FgLgZnS23c+bZa9R7bBw4a47pxOtd5VrVgbrtNz?=
 =?us-ascii?Q?BJcJwTHJr1YuykQdJidKbN5lmA7ttcOHwJo//epIiOe6oui90HaOpffx7Dxp?=
 =?us-ascii?Q?XSbYsgSxsyt+2Y0XEWbuvZ/D3wTDS2U2WrWXWBQAzKC3etMOzHbhcONPrSmP?=
 =?us-ascii?Q?I7TFRQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:57:57.6028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fc9dba-543e-428b-e621-08de599456a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80
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

Extend the amdgpu_usermode_queue function table (amdgpu_userq_funcs) with
a new 'mqd_update' callback to support runtime updates of user queue MQD
configurations.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f997fa17e8bd..64e69f0f9a02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -811,6 +811,25 @@ struct amdgpu_mqd_prop {
 	bool kernel_queue;
 };
 
+
+enum amdgpu_mqd_update_flag {
+	AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
+	AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
+	AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
+};
+
+/* MQD update information container (aligned with KFD) */
+struct amdgpu_mqd_update_info {
+	union {
+	       struct {
+		       /* Must be multiple of 32 */
+		       uint32_t count;
+		       uint32_t *ptr;
+	       } cu_mask;
+	};
+	enum amdgpu_mqd_update_flag update_flag;
+};
+
 struct amdgpu_mqd {
 	unsigned mqd_size;
 	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 95ace14e458c..1ff0f611f882 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -41,6 +41,7 @@ enum amdgpu_userq_state {
 };
 
 struct amdgpu_mqd_prop;
+struct amdgpu_mqd_update_info;
 
 struct amdgpu_userq_obj {
 	void		 *cpu_ptr;
@@ -79,6 +80,8 @@ struct amdgpu_usermode_queue {
 struct amdgpu_userq_funcs {
 	int (*mqd_create)(struct amdgpu_usermode_queue *queue,
 			  struct drm_amdgpu_userq_in *args);
+	int (*mqd_update)(struct amdgpu_usermode_queue *queue,
+			  struct amdgpu_mqd_update_info *minfo);
 	void (*mqd_destroy)(struct amdgpu_usermode_queue *uq);
 	int (*unmap)(struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_usermode_queue *queue);
-- 
2.49.0

