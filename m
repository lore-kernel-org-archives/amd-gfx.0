Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFC5D62615
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7E210E978;
	Thu, 22 Jan 2026 10:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SOpojAlf";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5141610E973
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOcTSef1GhndsAG/jnTCzIkeShsI9nZW3jDt5Qh9y/EbzzE54tTCgNsAgRC45ZAeGiz/aQ1byoy1DUMQgRGT6vLV9EF0CFiornKuuDcovRBwyjQJw+1a6bMRGDDft2gyo1z47bmVPT7X7DcWPLdiddUl98gca656R4HEt5omQcQWnTglT8QlQPc33o8N/iteA/oOPz9snWyEo0WjiEaFnOU0+v+O7YWGW7bxWvAjMdpx0SPJTOpcek7A8lwiUxbZ5gQhLP+dl0qeCIj/Tg4x+I1zFNE2rUKpVnOuO35zcrzZf0rNZt0kgektjkP3VALTFkvW4tL2G8/FuM04d15eaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4ERpTAwblZU4euxVSiZZSMO01KetYHUfySLT+LB9jc=;
 b=XiYJG6wlIM2xrH6D0PGQVn/PrQk5RjRsIxvydPTlcK/2+2Pksya3q8dP/v3dka8I8SzEfIlAuvud+o7jVjebUlTJrXkHgTW0uURVjN3OLh9dnviOT0MmtrkZxsHudV8hz+P3hReqcAetJZKUZMBkUBNWHPiD7VYAu0WKkgOrgrdtOZtCMZAWUxkKIrT78LnM/u0m16+hXSlzyqEPsRXYdE07QaqLzNOHUACQ3SRtJzqdSD8jZ/Hrha3LFAZI98FildRtcQRz13DlyI4NYGMaLUswAzSxDbvdg9bp/AbPEyBWSjfunwK792SbbOVjq0qX01Imv+mPZFu6F6kRxWrXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4ERpTAwblZU4euxVSiZZSMO01KetYHUfySLT+LB9jc=;
 b=SOpojAlf80EzcHqpYFcZ4hAIUAUd1K7vJjYKcM1TcnIdoJp82HgXOOSN0lWEjaw0eVoMmjdeytbt9pbOJEox1ScnB5Bdg4lSRpw6PuGwRpiDB52THt2YZajwG2hGNrGynjvs46nF0QBat6EWyKm+WbgezeSvexS7lBpo3wjcd7Y=
Received: from DS7PR03CA0106.namprd03.prod.outlook.com (2603:10b6:5:3b7::21)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:42:01 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::65) by DS7PR03CA0106.outlook.office365.com
 (2603:10b6:5:3b7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 10:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:42:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:41:58 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH v4 09/11] drm/amdgpu: Add ioctl support for cwsr params
Date: Thu, 22 Jan 2026 16:09:58 +0530
Message-ID: <20260122104118.1682154-10-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122104118.1682154-1-lijo.lazar@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c43fc9-9fc9-4eda-d4b6-08de59a2dfba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?feJwmzpScF0V93vXqTBr0t6+tgZv8bOjbh3jKjeiqXo+CAj/eAbc1JiM1iLb?=
 =?us-ascii?Q?fWHiWdgiPGhtqGc8VguvlbR6qZK3YBCW9mIUsJnys8pgc4fAw4pBgVmXGijp?=
 =?us-ascii?Q?6L+g8GssklWyUx7NLZbriVFFBNFZNYLxQbhhp2E8YCRprh7MSCqtATbUDZhh?=
 =?us-ascii?Q?+6/R82y4FqR42gljgwqDzuSkX07123B7AHJsBXrYowSIXYssADhmgoERBnRk?=
 =?us-ascii?Q?GGxSwrzkMi2Y+Nm0EYzk/g+8ekTMU4JM8Nhz6fDm62d67NOurqdTK8QciZO4?=
 =?us-ascii?Q?Mpc+ZcL//GIl0q7UVH73/YYiT9Q2WqjmLbMM65nqPq0xQaRgRc4WB5zMSC7K?=
 =?us-ascii?Q?IB4wqhg8d8vK0nkE3C9JcdC4KLHIUarR+/gsS06/bfkOIPw8EFM1YWRtrkXT?=
 =?us-ascii?Q?+wnX4jfJ6eC9IjQfbP6r7vCdBjuKr+2S29jf0lY6FZ8Qi0k3LMwfdVxvLXDC?=
 =?us-ascii?Q?snMLOJc9cofeFb5U8JFePC6pMZsq6Aik3VhNGXPa3Km1bIYKTyH5oFAfN6Zu?=
 =?us-ascii?Q?dBHhWcSM3/O92k3XTrmZaTk10zaJUhkuYD8U7z53N9nIhcvtGO1NYK4t4ZWI?=
 =?us-ascii?Q?KvmMHpNDsuPVrkpTZ+cQNCw02AxFxD9o03qvXchSIFhAYNe5gW2iUHVCBy2R?=
 =?us-ascii?Q?Oaqm1adaZdjqTtdF2x5ZttcgKejgOyhZq9v78Rbbt94YyZV8GJfsgYBAh1L1?=
 =?us-ascii?Q?oO58pJuAKYSX+XVVPpYNbbmDFkyrlYqsaO73anayZiP3+rzhO4jVoJFYZBox?=
 =?us-ascii?Q?aYHkyu1dPKPI9F/AT/zgJG88Rj5BOvKj+misPwWj+ZzbBGVFjJOHzERHi2mK?=
 =?us-ascii?Q?+wigjwjAyha78Mn17px1m5UvkW4EQdOVdU0p0yQ2dRCSk9IYc7m3S4Dte/8p?=
 =?us-ascii?Q?VS7aXGbkL2VELzg5iHluJGry2qY470eisY144yzR/GsUGmgVBpAjWTH/zzeu?=
 =?us-ascii?Q?+Jk+0B5qUiuZ/Df6faAzADYSrwuTeufN/AKvfHl+z09+ArWGIaBmYV/KCptt?=
 =?us-ascii?Q?wqzJ2dtIVNOjvg5mzz5+3wi9hEQSQMUiTu2WKjXUPSADNaHvDB5xu2chjI+I?=
 =?us-ascii?Q?378tCTxZeDZ+MJmyXtnJ16IjK32b7MxHBlxG8ZOS0jWqyub5hXZGfW4dp17S?=
 =?us-ascii?Q?s96KNHMpUBeQBZNv+MuI6hY49sBYxmg/U0rI5blhrcNOl90Uwsu0Dwzio0iX?=
 =?us-ascii?Q?CKMuGHGqrfnlU1s8IvP7kyPT3nIFvx0mXi4OJnwNHl7hjmNZV96Ed7fhfL9n?=
 =?us-ascii?Q?QoPA7b/ZfzcdTlok9US4xvttnDAQobWjYvgEOdUT8d9jXZgwdN9GdhIz3Cf+?=
 =?us-ascii?Q?IZQqHmfLYl9gmsm2Y6klaRVlgjl4CiaGmd1jz+bWuWszQ+v2tugja8gZuPlu?=
 =?us-ascii?Q?L7y0B2KQ1wyvNT5My6Mxuza4qmYTRr9tnbPWrvr8UXdm7d+ddlvWOneR0k7I?=
 =?us-ascii?Q?9D6Evz0uqPI6BMqsZcgAUWffg1wZstgyCouTFdOXbH32s7PMFY5fucbyOWgh?=
 =?us-ascii?Q?R/cu/IO2IZshHXtnT53vOCANZ//5l4UsyUGj5z5mcc9fHvp7nkiTV7Qudnq6?=
 =?us-ascii?Q?RHmoPbZPjh8eysuC0NWV/fnbFDCOgG6+Po4OBtF4Bif5e5zLIygQnkZYOBSI?=
 =?us-ascii?Q?xI8C9W5OzCxYcb0qBs80ci0LYl/i21RSjd7ob0/yDOblDAPaZxkoTQ/tkvAQ?=
 =?us-ascii?Q?vTXMTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:42:00.5437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c43fc9-9fc9-4eda-d4b6-08de59a2dfba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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

Add cwsr parameters to userqueue ioctl. User should pass the GPU virtual
address for save/restore buffer, and size allocated. They are supported
only for user compute queues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++++----
 include/uapi/drm/amdgpu_drm.h              | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7ad8297eb0d8..2765317f04df 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -343,16 +343,21 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		if (amdgpu_cwsr_is_enabled(adev)) {
 			cwsr_params.ctx_save_area_address =
-				userq_props->ctx_save_area_addr;
-			cwsr_params.cwsr_sz = userq_props->ctx_save_area_size;
-			cwsr_params.ctl_stack_sz = userq_props->ctl_stack_size;
-
+				compute_mqd->ctx_save_area_va;
+			cwsr_params.cwsr_sz = compute_mqd->ctx_save_area_size;
+			cwsr_params.ctl_stack_sz = compute_mqd->ctl_stack_size;
 			r = amdgpu_userq_input_cwsr_params_validate(
 				queue, &cwsr_params);
 			if (r) {
 				kfree(compute_mqd);
 				goto free_mqd;
 			}
+			userq_props->ctx_save_area_addr =
+				compute_mqd->ctx_save_area_va;
+			userq_props->ctx_save_area_size =
+				compute_mqd->ctx_save_area_size;
+			userq_props->ctl_stack_size =
+				compute_mqd->ctl_stack_size;
 		}
 
 		kfree(compute_mqd);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c178b8e0bd3f..b7a858365174 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -460,6 +460,22 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
 	 * to get the size.
 	 */
 	__u64   eop_va;
+	/**
+	 * @ctx_save_area_va: Virtual address of the GPU memory for save/restore buffer.
+	 * This must be from a separate GPU object, and use AMDGPU_INFO IOCTL
+	 * to get the size. This includes control stack, wave context and debugger memory.
+	 */
+	__u64 ctx_save_area_va;
+	/**
+	 * @ctx_save_area_size:  Total size (in bytes) allocated for save/restore buffer.
+	 * Use AMDGPU_INFO IOCTL to get the size.
+	 */
+	__u32 ctx_save_area_size;
+	/**
+	 * @ctl_stack_size: Size (in bytes) of control stack region in the save/restore buffer.
+	 * Use AMDGPU_INFO IOCTL to get the size.
+	 */
+	__u32 ctl_stack_size;
 };
 
 /* userq signal/wait ioctl */
-- 
2.49.0

