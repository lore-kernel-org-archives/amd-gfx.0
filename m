Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97250C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 21:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E12D10E45A;
	Tue, 29 Apr 2025 21:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jgt4PF36";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA5610E2EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 21:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wzlc+HqNcnwfg7k6HIvwOdYAU90KGvD/T8y6Kk2gbdsjRKf5080fZgH3+3G8fuMFl7Sk3S/azBsxA/I11wEvqZuiKTCsmVBZPAVIwXN/N8gvjIjxCJiXS9Puu69qZJhcsns5uWRqbVZdnVP7uwZ9w3gmU1LmR0cGu2quA/8q1WaB3KsdxfaNpDaKDoZGvPLbfzhTSu6rlX4dJ6NUUseb0TQW7Iomiw+yIc3+4ZTa2BzQ6Um5VvEPTPJUdeSdlRGfvJUO1UokWEMwpKgTWNZ95D9L5doPNPV9NleOdk/UkuHoy1HvdbaAf8Ue6SUDfkadPsbMaP+GJpDM59zeCln/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3pdfl2MuO0zqLjpxdOYGEV+u+b8bLuEk9AEdz9ejV0=;
 b=kO46prLPCwI4UexBCAY1RQAGlmO7Atdc3KrlhfuPEPSO90mRnYSP7uWmg/lj/a8goeppGSJ5mN4QPgjjxeYXUjmHXqS6z2GspUxCLS8NWDPflHszkToCJX4Q/kE1l8bZfvMxEKFcAXWn3gq2xGjPwfw3OpiTHQ+7HpVfXuIdQ7kurwG+w2keL/8moIW7R63kFfomu4cqmHDsD1LIuWSZYZvu1So3z01HFRuQpwV3a16LeuZ0pMFIYWOVWQsxRnw3+wJiYZiZIg2KTwqnewkA2zEH0DgLgeWx/uPZHVQDd0SPvUN/yYLOnQ0M+SDsE1BlD+Xvz9AQgZxoSQF1PlB9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3pdfl2MuO0zqLjpxdOYGEV+u+b8bLuEk9AEdz9ejV0=;
 b=Jgt4PF36j1jnnxFw1Z8fbmcKkkPKKmaFqSyXreKYRIVRvSKGXeIs5ODXXW4BJuck9KdS7kGZRXHzK9Q2FHJRM8M22Sg6v/xGhc7kn9KP5d7Pob7fx8O+JUWpjxD1505yR98jXKOmqoj/Z1/cfqEtOg+FmHpFjx13dXkZw5QfJOg=
Received: from SA9PR03CA0022.namprd03.prod.outlook.com (2603:10b6:806:20::27)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 21:40:35 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::cd) by SA9PR03CA0022.outlook.office365.com
 (2603:10b6:806:20::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 29 Apr 2025 21:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 21:40:35 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Apr 2025 16:40:34 -0500
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Victor.Skvortsov@amd.com>, <Ahmad.Rehman@amd.com>,
 <Jeffrey.Chan@amd.com>, <Shravankumar.Gande@amd.com>, <Zhigang.Luo@amd.com>,
 Ellen Pan <yunru.pan@amd.com>, Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Implement Runtime Bad Page query for VFs
Date: Tue, 29 Apr 2025 17:40:24 -0400
Message-ID: <20250429214024.93078-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5c3e63-cbcd-466c-dfd5-08dd8766799a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e81lsFvJNBEnPtOD+a0bEEAcUAPRgj2iysekZpDE2ZzT24zDYhrCKSwYxe0J?=
 =?us-ascii?Q?cZTv0Fg/M04ZAHRpwJfXhq7IMm4II7qpbvsLZv/z/BRdIALRt/HSanLIxDgK?=
 =?us-ascii?Q?sUxkW6HPy63puYVA87CXJsGlhBEMaYKZTcIpBTM71tC7worMvqfwY3FangrJ?=
 =?us-ascii?Q?vW5rVnYc40aN9tcj85lSegOhA+8AAlGKG7Vv+ELQJRGiFAFC46trLixzBjYX?=
 =?us-ascii?Q?0EgVs5zSxvJIBzmybS+ZICzJ784J9Hhz0O3G3WPROMf2NrN6yCtwxiQ0xDJl?=
 =?us-ascii?Q?AQfBW1v7TybibCDRbzLzbVpdDXVEUdmravge2o/s5zzOD6R5o5ZTMcqjd4KY?=
 =?us-ascii?Q?npofiDQ56M627XtJ3Ps/kCwMJ6rGE7AKe3m41Sq1aWkGHbqBS812v5DTmRF5?=
 =?us-ascii?Q?ePlwwYhP2puWzzqRYT+ARK4pwy7F5EgZLnON1UQt2EbrmZ2OtRb7gsxi98Lq?=
 =?us-ascii?Q?8s/4CiLycPxQvhWsiJElFLZnuuBhvSs6rRPtc/JuUY6GgUOPbeZ8MGdHkR+H?=
 =?us-ascii?Q?Wh5h+VbSpgLF095PExxjs7LvApE/5842bZ7d1G27KQvnBndMpXdeG0VOQHW2?=
 =?us-ascii?Q?uWdI2gwDLUppehMvp2mP9x4fiU+h70nDxe6HqesFa+Nuayx0k+ChzwRWQso4?=
 =?us-ascii?Q?Rbyks4Nac7SHeODOFuYx+Hv2BeMPp5tcUY4Om+dgScaM0TzDyGrj7n/WYHLy?=
 =?us-ascii?Q?/9q92tasV2ELDE9BKWvizcx8o9CU88IZnvHLw3dbJw3poP04dFeWwg7r/0mJ?=
 =?us-ascii?Q?BIhhcDObXsh5BnnX0jHq62Ue6wjFkOP2UFgWyAY6dq3lpeGOkKWR151n8S/u?=
 =?us-ascii?Q?E9XeE21qNcsB1RVLopSE+QUMi9Rlav1EJFJFk4MZaj5WJQXHMzrn+nwdyhd8?=
 =?us-ascii?Q?mOgVfOlUrp87uEys9SpvCSTajF8/cT5/SUmo9O8E3wxbRDqINEpD2xpZc9Tu?=
 =?us-ascii?Q?fS9oRIClFPf9H2ezJDqFCGxmh5aG/PzfchDAcljJgzrM6BeRMmkmruRvCSXA?=
 =?us-ascii?Q?j8CxIwUQxc4yO2CZHhiBhKC1CBouh2A9oQE9cblZGTCYrNs2BQu8Vo5OFjkD?=
 =?us-ascii?Q?yWzh4LutV4vjy3Bjg8jT6cSXsLnp+zeVHc7UXD+H+k+hWOd0b2ZnC++khxx1?=
 =?us-ascii?Q?twUdS3aVJXxF2sCvHW1AQ/sYZ6NrhImv9PpgUTK+b4H73+NfyL358/Dtvd4R?=
 =?us-ascii?Q?iCAFGXx24spFTiQhNxFAzuHf6BX4gMJ1xBOhsnUHdqY0uqEKSImVUpDzidmO?=
 =?us-ascii?Q?wow2WbKRaZSShA0JpEbC/SpK5dMqY0WeLU4GsY2vgrgSPgVndV7lI6Nl9RRE?=
 =?us-ascii?Q?9y69Mk/DTSFBskVKUUihEREmwgiN2hafXD3TTapKIN3obgMWCR+pJop4v6G8?=
 =?us-ascii?Q?oLYdwE4CaQBEjQVk1DuAce3rb7irYuafYQceDVWBTZBIL4fXOt+rtvpZiRD0?=
 =?us-ascii?Q?fQjvvimrGBN0BYzv4D4yoaGkOfOzbsc0kl0Iqd6miAu8YuU1WaH3UMx3OeYq?=
 =?us-ascii?Q?uMP6tMsogmXsW4NSIIbJBkpBtzISAcj6t+9v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 21:40:35.2488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5c3e63-cbcd-466c-dfd5-08dd8766799a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
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

Host will send a notification when new bad pages are available.

Uopn guest request, the first 256 bad page addresses
will be placed into the PF2VF region.
Guest should pause the PF2VF worker thread while
the copy is in progress.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 13 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  5 +++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 46 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  3 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 28 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h    |  3 ++
 6 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 83f3334b3931..13f0cdeb59c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1488,3 +1488,16 @@ bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
 
 	return true;
 }
+
+/*
+ * amdgpu_virt_request_bad_pages() - request bad pages
+ * @adev: amdgpu device.
+ * Send command to GPU hypervisor to write new bad pages into the shared PF2VF region
+ */
+void amdgpu_virt_request_bad_pages(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+
+	if (virt->ops && virt->ops->req_bad_pages)
+		virt->ops->req_bad_pages(adev);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index b6ec6b7969f0..577c6194db78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -97,6 +97,7 @@ struct amdgpu_virt_ops {
 	bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
 	int (*req_ras_err_count)(struct amdgpu_device *adev);
 	int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
+	int (*req_bad_pages)(struct amdgpu_device *adev);
 };
 
 /*
@@ -262,7 +263,10 @@ struct amdgpu_virt {
 	uint32_t			reg_val_offs;
 	struct amdgpu_irq_src		ack_irq;
 	struct amdgpu_irq_src		rcv_irq;
+
 	struct work_struct		flr_work;
+	struct work_struct		bad_pages_work;
+
 	struct amdgpu_mm_table		mm_table;
 	const struct amdgpu_virt_ops	*ops;
 	struct amdgpu_vf_error_buffer	vf_errors;
@@ -429,4 +433,5 @@ int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool force_update)
 int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);
 bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block);
+void amdgpu_virt_request_bad_pages(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f5411b798e11..f2a74aa76b56 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -274,6 +274,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 {
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+	struct amdgpu_reset_context reset_context = { 0 };
 
 	amdgpu_virt_fini_data_exchange(adev);
 
@@ -281,8 +282,6 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	if (amdgpu_device_should_recover_gpu(adev)
 		&& (!amdgpu_device_has_job_running(adev) ||
 			adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT)) {
-		struct amdgpu_reset_context reset_context;
-		memset(&reset_context, 0, sizeof(reset_context));
 
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
@@ -293,6 +292,19 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	}
 }
 
+static void xgpu_ai_mailbox_bad_pages_work(struct work_struct *work)
+{
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, bad_pages_work);
+	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_request_bad_pages(adev);
+		amdgpu_virt_init_data_exchange(adev);
+		up_read(&adev->reset_domain->sem);
+	}
+}
+
 static int xgpu_ai_set_mailbox_rcv_irq(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *src,
 				       unsigned type,
@@ -314,24 +326,29 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
 	enum idh_event event = xgpu_ai_mailbox_peek_msg(adev);
 
 	switch (event) {
-		case IDH_FLR_NOTIFICATION:
+	case IDH_RAS_BAD_PAGES_NOTIFICATION:
+		xgpu_ai_mailbox_send_ack(adev);
+		if (amdgpu_sriov_runtime(adev))
+			schedule_work(&adev->virt.bad_pages_work);
+		break;
+	case IDH_FLR_NOTIFICATION:
 		if (amdgpu_sriov_runtime(adev))
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
 								&adev->virt.flr_work),
 				  "Failed to queue work! at %s",
 				  __func__);
 		break;
-		case IDH_QUERY_ALIVE:
-			xgpu_ai_mailbox_send_ack(adev);
-			break;
-		/* READY_TO_ACCESS_GPU is fetched by kernel polling, IRQ can ignore
-		 * it byfar since that polling thread will handle it,
-		 * other msg like flr complete is not handled here.
-		 */
-		case IDH_CLR_MSG_BUF:
-		case IDH_FLR_NOTIFICATION_CMPL:
-		case IDH_READY_TO_ACCESS_GPU:
-		default:
+	case IDH_QUERY_ALIVE:
+		xgpu_ai_mailbox_send_ack(adev);
+		break;
+	/* READY_TO_ACCESS_GPU is fetched by kernel polling, IRQ can ignore
+	 * it byfar since that polling thread will handle it,
+	 * other msg like flr complete is not handled here.
+	 */
+	case IDH_CLR_MSG_BUF:
+	case IDH_FLR_NOTIFICATION_CMPL:
+	case IDH_READY_TO_ACCESS_GPU:
+	default:
 		break;
 	}
 
@@ -387,6 +404,7 @@ int xgpu_ai_mailbox_get_irq(struct amdgpu_device *adev)
 	}
 
 	INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
+	INIT_WORK(&adev->virt.bad_pages_work, xgpu_ai_mailbox_bad_pages_work);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index ed57cbc150af..efb452ad1700 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -40,6 +40,7 @@ enum idh_request {
 	IDH_LOG_VF_ERROR       = 200,
 	IDH_READY_TO_RESET 	= 201,
 	IDH_RAS_POISON  = 202,
+	IDH_REQ_RAS_BAD_PAGES = 205,
 };
 
 enum idh_event {
@@ -54,6 +55,8 @@ enum idh_event {
 	IDH_RAS_POISON_READY,
 	IDH_PF_SOFT_FLR_NOTIFICATION,
 	IDH_RAS_ERROR_DETECTED,
+	IDH_RAS_BAD_PAGES_READY = 15,
+	IDH_RAS_BAD_PAGES_NOTIFICATION = 16,
 	IDH_TEXT_MESSAGE = 255,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 5aadf24cb202..74a50c0036ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -187,6 +187,9 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 	case IDH_REQ_RAS_CPER_DUMP:
 		event = IDH_RAS_CPER_DUMP_READY;
 		break;
+	case IDH_REQ_RAS_BAD_PAGES:
+		event = IDH_RAS_BAD_PAGES_READY;
+		break;
 	default:
 		break;
 	}
@@ -342,6 +345,19 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	}
 }
 
+static void xgpu_nv_mailbox_bad_pages_work(struct work_struct *work)
+{
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, bad_pages_work);
+	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_request_bad_pages(adev);
+		amdgpu_virt_init_data_exchange(adev);
+		up_read(&adev->reset_domain->sem);
+	}
+}
+
 static int xgpu_nv_set_mailbox_rcv_irq(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *src,
 				       unsigned type,
@@ -366,6 +382,11 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device *adev,
 	enum idh_event event = xgpu_nv_mailbox_peek_msg(adev);
 
 	switch (event) {
+	case IDH_RAS_BAD_PAGES_NOTIFICATION:
+		xgpu_nv_mailbox_send_ack(adev);
+		if (amdgpu_sriov_runtime(adev))
+			schedule_work(&adev->virt.bad_pages_work);
+		break;
 	case IDH_FLR_NOTIFICATION:
 		if (amdgpu_sriov_runtime(adev))
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
@@ -436,6 +457,7 @@ int xgpu_nv_mailbox_get_irq(struct amdgpu_device *adev)
 	}
 
 	INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
+	INIT_WORK(&adev->virt.bad_pages_work, xgpu_nv_mailbox_bad_pages_work);
 
 	return 0;
 }
@@ -480,6 +502,11 @@ static int xgpu_nv_req_ras_cper_dump(struct amdgpu_device *adev, u64 vf_rptr)
 		adev, IDH_REQ_RAS_CPER_DUMP, vf_rptr_hi, vf_rptr_lo, 0);
 }
 
+static int xgpu_nv_req_ras_bad_pages(struct amdgpu_device *adev)
+{
+	return xgpu_nv_send_access_requests(adev, IDH_REQ_RAS_BAD_PAGES);
+}
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
@@ -492,4 +519,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.rcvd_ras_intr = xgpu_nv_rcvd_ras_intr,
 	.req_ras_err_count = xgpu_nv_req_ras_err_count,
 	.req_ras_cper_dump = xgpu_nv_req_ras_cper_dump,
+	.req_bad_pages = xgpu_nv_req_ras_bad_pages,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 72c9fceb9d79..6d292a537c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -42,6 +42,7 @@ enum idh_request {
 	IDH_RAS_POISON	= 202,
 	IDH_REQ_RAS_ERROR_COUNT = 203,
 	IDH_REQ_RAS_CPER_DUMP = 204,
+	IDH_REQ_RAS_BAD_PAGES = 205,
 };
 
 enum idh_event {
@@ -58,6 +59,8 @@ enum idh_event {
 	IDH_RAS_ERROR_DETECTED,
 	IDH_RAS_ERROR_COUNT_READY = 11,
 	IDH_RAS_CPER_DUMP_READY = 14,
+	IDH_RAS_BAD_PAGES_READY = 15,
+	IDH_RAS_BAD_PAGES_NOTIFICATION = 16,
 
 	IDH_TEXT_MESSAGE = 255,
 };
-- 
2.34.1

