Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8F2D36107
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 19:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2812F10E606;
	Tue,  5 Nov 2024 19:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FiG6mZTT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C7B10E60E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 19:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpWaLIe9zjFB6ggQnhbIEHlI7HEM4BuYOP3OVknvNNDjvi2QeR7ydZnZ1r9H03UEG+pek1AzRUm0gDHCyp9b4eozBJnbvCFQVMUuWN6FAmX/UOZdIU+NPS4Ky9mA8apf1hKj5+ToVLwuRsDPDRK1UYcza4YA1itOJo3Z5eJxcvCoNF10D+TsS3uK/DWV1y2eLv+cgJZxAEy1x8iMFpG7DuA/LxCvlchdL+D5GZwKPyhkLS7k8VglWPEfq2kkc9Thqr/lvTIEGTgGDNGfgLHI2SEUhI+SFbWlBYrB8dPkrsANWuIl1M4xt9ngfXcbZGqH6LhDhynSkuMxj6EqIPPRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gbum4fw1Ij1hJHQe95juNUVF2mX+iHtHsHTu+Y3R9eM=;
 b=gO866DzVFVn+yvcjof880HsT1i7TmDO6Klm0VV+ko3CFBUHoD8kHqCqiLcvM+Z/RNJ9XNcuOAoh6xf8m3Rzlwj2tD49R+yaZPrRrzaisexSV1Y4YpWGak69O7x3fdOj/37RAi30ltatGqLPDWOPo25HcZEaX6l+k7UfJ1uuqV56MlRbbi5grxgLaMaxf3w+psb3ffnHEBpl1wdXBVicTQc9EdbY4lQoftc6eaXSTQfojTtKaaNDLJRWoKRB/7upvPKJUvbQnFYr4zN9fF76IMKG9mDyUYRM3AGSXOz/1w5epGTauYdOexNBJQOXpeVS3bnj5tFoqGwriB7xAm64BFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gbum4fw1Ij1hJHQe95juNUVF2mX+iHtHsHTu+Y3R9eM=;
 b=FiG6mZTTu0uq+FQ4eGXHGoX9VrdQ2jS7jIZI6CqnGOODPY5Se7LyHZQBX/MHU18/qtfKFmkEtJW4EHYf5kXaAVqu9LoM4mnD/OM2Cfh/anY2nESH0fQOjqfvhcdsyec82vVkqQ72Ir62VQbtlpqlKPk14rpBNd2w6Z/K4bVnRm4=
Received: from BL1PR13CA0284.namprd13.prod.outlook.com (2603:10b6:208:2bc::19)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 19:04:52 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::4e) by BL1PR13CA0284.outlook.office365.com
 (2603:10b6:208:2bc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.14 via Frontend
 Transport; Tue, 5 Nov 2024 19:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 19:04:52 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 13:04:51 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <victor.skvortsov@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <zhigang.luo@amd.com>, <tao.zhou1@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu: Implement virt req_ras_err_count
Date: Tue, 5 Nov 2024 14:04:29 -0500
Message-ID: <20241105190429.323478-4-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105190429.323478-1-victor.skvortsov@amd.com>
References: <20241105190429.323478-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 6435d7e0-7084-4d0e-c44b-08dcfdccba64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EGXIwrpzKCgu/bSd8rYLLA0oNXBZe1anrxIN8J2PSh4ySzrsgfWcmBXALzJV?=
 =?us-ascii?Q?K9cK71oYM2WnVNyZ/po6i/yVCRvBKlMlibp71yC4mR6HTsUFvmmPAE77MWUS?=
 =?us-ascii?Q?di+YGV6PGvKQjoIgws46Pdw33z2D9cXPLDrF0btgcWyg1C1z/29ceimtLDPN?=
 =?us-ascii?Q?DVkHTMeWi/iXy0kJXg0hqnFSDPZTDD31DLL/fg4QoCf6JKax/sePI49asxyU?=
 =?us-ascii?Q?1RiuvsjoUYDYUfck0xPkT9manfdHNuLKHggTLlv97neSzCE78I4h/NHEfq95?=
 =?us-ascii?Q?xQuEWTJvmKoL/XjfGIKeZqDQ/vnPCbmKFlbc0Uoydkm7WmIOJNHRIz/YAKUI?=
 =?us-ascii?Q?gjIC9z2h347GTV+r85JL+klHFkJYCoZiIVtUR9HnaI1jGdF1m37E9IRxLPXU?=
 =?us-ascii?Q?3ok9wN6aZuLzdonQlPLJl+C2cincrwuwweVmBeOCoIQ+pXj9fBe93Uueczrn?=
 =?us-ascii?Q?r7bEuTUtKsG08TQKMckqX4k7zFEoc/U8XNCUNiA2uRBsYMQcSqGv7aUWgkjJ?=
 =?us-ascii?Q?7Ov1B9nHrzAw2H01MUtQQbVYPylnntvWUeMXcmx63w7a5s5+2HB3ppIhOTGm?=
 =?us-ascii?Q?qgnXGxLRPxKyOiTrwofksqOOa6n0sSpx25EcIkF82STdBSc6MtCIqpamTyHs?=
 =?us-ascii?Q?DFVqlymqbX4jIFoLS9pCGpajmnx458kYpqNfQokBSzrKGU371MrH64m2gXh4?=
 =?us-ascii?Q?nFEy8WAirtn7ZFnQTzZRJ0OeqKl8SbrS3fOxmDN3qZv/+jUKoO8ENLCvAbcV?=
 =?us-ascii?Q?IPp0TIoCPzyA7R4RDHu+SirC/NcM62fiob7GGsBB3wJtG+LVtikdLZw4LIgK?=
 =?us-ascii?Q?XA+Y9nYJv2fNQKWp6tU4lgW7vtfIsvJGG4eDfWwaSUeRZzANk7BNKxe11oRV?=
 =?us-ascii?Q?pY1U+gVGX2LBNyZZnpg9D+I3BjgpEEiHAxuZqFLDbWL7wJq6roZrh+GGsLl/?=
 =?us-ascii?Q?YZTpCf5/wxq1JZ7Ezgpsw5dhM6d0lGy5JzFyYVxP1uiksg2+5dKtPO4BL/6u?=
 =?us-ascii?Q?z31J//16UIAF/YUa9OXTI6OzbFGnJboPCImDKhSgPlgEhhKDRFtN3viEwAA8?=
 =?us-ascii?Q?i8/QzNeVmuURurQ10WZUdEs85AAfRsEPt4djSB8ueE0AV3EyqdG7b5/jmyRr?=
 =?us-ascii?Q?GA9zClhypUJ2vjzE1ua6W1bZ7BxOhzbSvg26QdcJYZ+37KZvSdA6NfurxNwG?=
 =?us-ascii?Q?srR8oA+wQImQmmbacCoApJ+ZmqS9d7fqB9AX39ZBaLzTcz8QsLU8xr6+vUdY?=
 =?us-ascii?Q?7qlfM7bw7T/cRGx3AlhXUDXKyX5Ie2uGnkMpVTMXktLMSE3U3YXBEBMXCZFM?=
 =?us-ascii?Q?Am89vvgcTRgcN9o8VrXZ34ZXUBYJhhjOj6DJ4XD7d8AcAEXxWZm3YBTzuCz4?=
 =?us-ascii?Q?kh4gmwo5SLR0XwcXWIoYeUDTXdifL7gNtOlrz6Yby0EdlLqxRw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 19:04:52.1464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6435d7e0-7084-4d0e-c44b-08dcfdccba64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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

Enable RAS late init  if VF RAS Telemetry is supported.

When enabled, the VF can use this interface to query total
RAS error counts from the host.

The VF FB access may abruptly end due to a fatal error,
therefore the VF must cache and sanitize the input.

The Host allows 15 Telemetry messages every 60 seconds, afterwhich
the host will ignore any more in-coming telemetry messages. The VF will
rate limit its msg calling to once every 5 seconds (12 times in 60 seconds).
While the VF is rate limited, it will continue to report the last
good cached data.

v2: Flip generate report & update statistics order for VF

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  72 +++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 138 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  15 +++
 7 files changed, 231 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 383bbee87df5..c22a9925cba7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4235,7 +4235,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * for throttling interrupt) = 60 seconds.
 	 */
 	ratelimit_state_init(&adev->throttling_logging_rs, (60 - 1) * HZ, 1);
+	ratelimit_state_init(&adev->virt.ras_telemetry_rs, 5 * HZ, 1);
+
 	ratelimit_set_flags(&adev->throttling_logging_rs, RATELIMIT_MSG_ON_RELEASE);
+	ratelimit_set_flags(&adev->virt.ras_telemetry_rs, RATELIMIT_MSG_ON_RELEASE);
 
 	/* Registers mapping */
 	/* TODO: block userspace mapping of io register */
@@ -5185,6 +5188,9 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3))
 		amdgpu_ras_resume(adev);
+
+	amdgpu_virt_ras_telemetry_post_reset(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8cc4b146bdc..8c9fcfb7f22e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -885,6 +885,9 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 		if (r)
 			return r;
 
+		if (amdgpu_sriov_vf(adev))
+			return r;
+
 		if (adev->gfx.cp_ecc_error_irq.funcs) {
 			r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
 			if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 89d87dc17ac1..a8b4f4178e5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1214,6 +1214,42 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 	}
 }
 
+static void amdgpu_ras_virt_error_generate_report(struct amdgpu_device *adev,
+						  struct ras_query_if *query_if,
+						  struct ras_err_data *err_data,
+						  struct ras_query_context *qctx)
+{
+	unsigned long new_ue, new_ce, new_de;
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &query_if->head);
+	const char *blk_name = get_ras_block_str(&query_if->head);
+	u64 event_id = qctx->event_id;
+
+	new_ce = err_data->ce_count - obj->err_data.ce_count;
+	new_ue = err_data->ue_count - obj->err_data.ue_count;
+	new_de = err_data->de_count - obj->err_data.de_count;
+
+	if (new_ce) {
+		RAS_EVENT_LOG(adev, event_id, "%lu correctable hardware errors "
+			      "detected in %s block\n",
+			      new_ce,
+			      blk_name);
+	}
+
+	if (new_ue) {
+		RAS_EVENT_LOG(adev, event_id, "%lu uncorrectable hardware errors "
+			      "detected in %s block\n",
+			      new_ue,
+			      blk_name);
+	}
+
+	if (new_de) {
+		RAS_EVENT_LOG(adev, event_id, "%lu deferred hardware errors "
+			      "detected in %s block\n",
+			      new_de,
+			      blk_name);
+	}
+}
+
 static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, struct ras_err_data *err_data)
 {
 	struct ras_err_node *err_node;
@@ -1237,6 +1273,15 @@ static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
 	}
 }
 
+static void amdgpu_ras_mgr_virt_error_data_statistics_update(struct ras_manager *obj,
+							     struct ras_err_data *err_data)
+{
+	/* Host reports absolute counts */
+	obj->err_data.ue_count = err_data->ue_count;
+	obj->err_data.ce_count = err_data->ce_count;
+	obj->err_data.de_count = err_data->de_count;
+}
+
 static struct ras_manager *get_ras_manager(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
 {
 	struct ras_common_if head;
@@ -1323,7 +1368,9 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 	if (error_query_mode == AMDGPU_RAS_INVALID_ERROR_QUERY)
 		return -EINVAL;
 
-	if (error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
+	if (error_query_mode == AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY) {
+		return amdgpu_virt_req_ras_err_count(adev, blk, err_data);
+	} else if (error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
 		if (info->head.block == AMDGPU_RAS_BLOCK__UMC) {
 			amdgpu_ras_get_ecc_info(adev, err_data);
 		} else {
@@ -1405,14 +1452,22 @@ static int amdgpu_ras_query_error_status_with_event(struct amdgpu_device *adev,
 	if (ret)
 		goto out_fini_err_data;
 
-	amdgpu_rasmgr_error_data_statistic_update(obj, &err_data);
+	if (error_query_mode != AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY) {
+		amdgpu_rasmgr_error_data_statistic_update(obj, &err_data);
+		amdgpu_ras_error_generate_report(adev, info, &err_data, &qctx);
+	} else {
+		/* Host provides absolute error counts. First generate the report
+		 * using the previous VF internal count against new host count.
+		 * Then Update VF internal count.
+		 */
+		amdgpu_ras_virt_error_generate_report(adev, info, &err_data, &qctx);
+		amdgpu_ras_mgr_virt_error_data_statistics_update(obj, &err_data);
+	}
 
 	info->ue_count = obj->err_data.ue_count;
 	info->ce_count = obj->err_data.ce_count;
 	info->de_count = obj->err_data.de_count;
 
-	amdgpu_ras_error_generate_report(adev, info, &err_data, &qctx);
-
 out_fini_err_data:
 	amdgpu_ras_error_data_fini(&err_data);
 
@@ -3929,7 +3984,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	/* Guest side doesn't need init ras feature */
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
 		return 0;
 
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
@@ -4396,11 +4451,14 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
 		return false;
 	}
 
-	if ((smu_funcs && smu_funcs->set_debug_mode) || (mca_funcs && mca_funcs->mca_set_debug_mode))
+	if (amdgpu_sriov_vf(adev)) {
+		*error_query_mode = AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY;
+	} else if ((smu_funcs && smu_funcs->set_debug_mode) || (mca_funcs && mca_funcs->mca_set_debug_mode)) {
 		*error_query_mode =
 			(con->is_aca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
-	else
+	} else {
 		*error_query_mode = AMDGPU_RAS_DIRECT_ERROR_QUERY;
+	}
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 871b2d6278e0..6db772ecfee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -365,6 +365,7 @@ enum amdgpu_ras_error_query_mode {
 	AMDGPU_RAS_INVALID_ERROR_QUERY		= 0,
 	AMDGPU_RAS_DIRECT_ERROR_QUERY		= 1,
 	AMDGPU_RAS_FIRMWARE_ERROR_QUERY		= 2,
+	AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY	= 3,
 };
 
 /* ras error status reisger fields */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index bb7b9b2eaac1..896f3609b0ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -318,6 +318,9 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	if (r)
 		return r;
 
+	if (amdgpu_sriov_vf(adev))
+		return r;
+
 	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
 		r = amdgpu_irq_get(adev, &adev->gmc.ecc_irq, 0);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 53297c40f09c..b1e584e4ef13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -524,6 +524,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		adev->unique_id =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
 		adev->virt.ras_en_caps.all = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_en_caps.all;
+		adev->virt.ras_telemetry_en_caps.all =
+			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_telemetry_en_caps.all;
 		break;
 	default:
 		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
@@ -704,6 +706,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 			adev->virt.fw_reserve.p_vf2pf =
 				(struct amd_sriov_msg_vf2pf_info_header *)
 				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+			adev->virt.fw_reserve.ras_telemetry =
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
 		} else if (adev->mman.drv_vram_usage_va) {
 			adev->virt.fw_reserve.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)
@@ -711,6 +715,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 			adev->virt.fw_reserve.p_vf2pf =
 				(struct amd_sriov_msg_vf2pf_info_header *)
 				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+			adev->virt.fw_reserve.ras_telemetry =
+				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
 		}
 
 		amdgpu_virt_read_pf2vf_data(adev);
@@ -1197,3 +1203,135 @@ bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev)
 
 	return true;
 }
+
+static inline enum amd_sriov_ras_telemetry_gpu_block
+amdgpu_ras_block_to_sriov(struct amdgpu_device *adev, enum amdgpu_ras_block block) {
+	switch (block) {
+	case AMDGPU_RAS_BLOCK__UMC:
+		return RAS_TELEMETRY_GPU_BLOCK_UMC;
+	case AMDGPU_RAS_BLOCK__SDMA:
+		return RAS_TELEMETRY_GPU_BLOCK_SDMA;
+	case AMDGPU_RAS_BLOCK__GFX:
+		return RAS_TELEMETRY_GPU_BLOCK_GFX;
+	case AMDGPU_RAS_BLOCK__MMHUB:
+		return RAS_TELEMETRY_GPU_BLOCK_MMHUB;
+	case AMDGPU_RAS_BLOCK__ATHUB:
+		return RAS_TELEMETRY_GPU_BLOCK_ATHUB;
+	case AMDGPU_RAS_BLOCK__PCIE_BIF:
+		return RAS_TELEMETRY_GPU_BLOCK_PCIE_BIF;
+	case AMDGPU_RAS_BLOCK__HDP:
+		return RAS_TELEMETRY_GPU_BLOCK_HDP;
+	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
+		return RAS_TELEMETRY_GPU_BLOCK_XGMI_WAFL;
+	case AMDGPU_RAS_BLOCK__DF:
+		return RAS_TELEMETRY_GPU_BLOCK_DF;
+	case AMDGPU_RAS_BLOCK__SMN:
+		return RAS_TELEMETRY_GPU_BLOCK_SMN;
+	case AMDGPU_RAS_BLOCK__SEM:
+		return RAS_TELEMETRY_GPU_BLOCK_SEM;
+	case AMDGPU_RAS_BLOCK__MP0:
+		return RAS_TELEMETRY_GPU_BLOCK_MP0;
+	case AMDGPU_RAS_BLOCK__MP1:
+		return RAS_TELEMETRY_GPU_BLOCK_MP1;
+	case AMDGPU_RAS_BLOCK__FUSE:
+		return RAS_TELEMETRY_GPU_BLOCK_FUSE;
+	case AMDGPU_RAS_BLOCK__MCA:
+		return RAS_TELEMETRY_GPU_BLOCK_MCA;
+	case AMDGPU_RAS_BLOCK__VCN:
+		return RAS_TELEMETRY_GPU_BLOCK_VCN;
+	case AMDGPU_RAS_BLOCK__JPEG:
+		return RAS_TELEMETRY_GPU_BLOCK_JPEG;
+	case AMDGPU_RAS_BLOCK__IH:
+		return RAS_TELEMETRY_GPU_BLOCK_IH;
+	case AMDGPU_RAS_BLOCK__MPIO:
+		return RAS_TELEMETRY_GPU_BLOCK_MPIO;
+	default:
+		dev_err(adev->dev, "Unsupported SRIOV RAS telemetry block 0x%x\n", block);
+		return RAS_TELEMETRY_GPU_BLOCK_COUNT;
+	}
+}
+
+static int amdgpu_virt_cache_host_error_counts(struct amdgpu_device *adev,
+					       struct amdsriov_ras_telemetry *host_telemetry)
+{
+	struct amd_sriov_ras_telemetry_error_count *tmp = { 0 };
+	uint32_t checksum, used_size, tmp_check;
+
+	checksum = host_telemetry->header.checksum;
+	used_size = host_telemetry->header.used_size;
+
+	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+		return 0;
+
+	tmp = kmalloc(used_size, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	memcpy(tmp, &host_telemetry->body.error_count, used_size);
+
+	tmp_check = amd_sriov_msg_checksum(tmp, used_size, 0, 0);
+	if (checksum != amd_sriov_msg_checksum(tmp, used_size, 0, 0))
+		goto out;
+
+	/* Copy sanitized data to guest cache */
+	memcpy(&adev->virt.count_cache, tmp, sizeof(adev->virt.count_cache));
+out:
+	kfree(tmp);
+
+	return 0;
+}
+
+static int amdgpu_virt_req_ras_err_count_internal(struct amdgpu_device *adev, bool force_update)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+
+	/* Host allows 15 ras telemetry requests per 60 seconds. Afterwhich, the Host
+	 * will ignore incoming guest messages. Ratelimit the guest messages to
+	 * prevent guest self DOS.
+	 */
+	if (__ratelimit(&adev->virt.ras_telemetry_rs) || force_update) {
+		if (!virt->ops->req_ras_err_count(adev))
+			amdgpu_virt_cache_host_error_counts(adev,
+				adev->virt.fw_reserve.ras_telemetry);
+	}
+
+	return 0;
+}
+
+/* Bypass ACA interface and query ECC counts directly from host */
+int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu_ras_block block,
+				  struct ras_err_data *err_data)
+{
+	int ret;
+	enum amd_sriov_ras_telemetry_gpu_block sriov_block;
+
+	sriov_block = amdgpu_ras_block_to_sriov(adev, block);
+
+	if (sriov_block >= RAS_TELEMETRY_GPU_BLOCK_COUNT ||
+	    !amdgpu_sriov_ras_telemetry_block_en(adev, sriov_block))
+		return -EOPNOTSUPP;
+
+	/* Host Access may be lost during reset, just return last cached data. */
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_virt_req_ras_err_count_internal(adev, false);
+		up_read(&adev->reset_domain->sem);
+	}
+
+	err_data->ue_count = adev->virt.count_cache.block[sriov_block].ue_count;
+	err_data->ce_count = adev->virt.count_cache.block[sriov_block].ce_count;
+	err_data->de_count = adev->virt.count_cache.block[sriov_block].de_count;
+
+	return 0;
+}
+
+int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev)
+{
+	unsigned long ue_count, ce_count;
+
+	if (amdgpu_sriov_ras_telemetry_en(adev)) {
+		amdgpu_virt_req_ras_err_count_internal(adev, true);
+		amdgpu_ras_query_error_count(adev, &ce_count, &ue_count, NULL);
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f0ff84add692..5381b8d596e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -104,6 +104,7 @@ struct amdgpu_virt_ops {
 struct amdgpu_virt_fw_reserve {
 	struct amd_sriov_msg_pf2vf_info_header *p_pf2vf;
 	struct amd_sriov_msg_vf2pf_info_header *p_vf2pf;
+	void *ras_telemetry;
 	unsigned int checksum_key;
 };
 
@@ -138,6 +139,7 @@ enum AMDGIM_FEATURE_FLAG {
 	/* MES info */
 	AMDGIM_FEATURE_MES_INFO_ENABLE = (1 << 8),
 	AMDGIM_FEATURE_RAS_CAPS = (1 << 9),
+	AMDGIM_FEATURE_RAS_TELEMETRY = (1 << 10),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -280,6 +282,10 @@ struct amdgpu_virt {
 	struct mutex rlcg_reg_lock;
 
 	union amd_sriov_ras_caps ras_en_caps;
+	union amd_sriov_ras_caps ras_telemetry_en_caps;
+
+	struct ratelimit_state ras_telemetry_rs;
+	struct amd_sriov_ras_telemetry_error_count count_cache;
 };
 
 struct amdgpu_video_codec_info;
@@ -327,6 +333,12 @@ struct amdgpu_video_codec_info;
 #define amdgpu_sriov_ras_caps_en(adev) \
 ((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_CAPS)
 
+#define amdgpu_sriov_ras_telemetry_en(adev) \
+(((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_TELEMETRY) && (adev)->virt.fw_reserve.ras_telemetry)
+
+#define amdgpu_sriov_ras_telemetry_block_en(adev, sriov_blk) \
+(amdgpu_sriov_ras_telemetry_en((adev)) && (adev)->virt.ras_telemetry_en_caps.all & BIT(sriov_blk))
+
 static inline bool is_virtual_machine(void)
 {
 #if defined(CONFIG_X86)
@@ -391,4 +403,7 @@ bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 					  bool write, u32 *rlcg_flag);
 u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id);
 bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev);
+int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu_ras_block block,
+				  struct ras_err_data *err_data);
+int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);
 #endif
-- 
2.34.1

