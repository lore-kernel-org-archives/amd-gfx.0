Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A86C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 03:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C90710E26A;
	Mon, 16 Jun 2025 03:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d08EYxJT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD5710E26A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 03:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tp4s5izAtvwZ7WeiSeDxzR4WJEOXJNxi2hyIVLSQER5NEd4QqnD+AxG6KTrnt+tUH+7sokY98D5uREkVPyVnhysL+BlMLQ/3W6zqJIx3l6F7+RjjmTQrzvkzvNmpZyg2VrfQq3sxOsxYp8w166ULoQWCI+hWnP2JL3hB9WqeHRgEeoW5U5GAa04xCuQ0wftFBRLpafvO+kI8OBtTuNIUa6QM448IazSHn7Xwcb6FhwX1iXhnrL7K/w1EnZg0eC8FR4e2a+yLEKMaEZJlmdrOO80qJsqG4gI2c2gPzxe0c62yejSExoKy9TBp01m0YKZb2uNQgfgP++VDSSnoal1pqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jeggdPGCWzTi5DhozF0OjRvI4gKRv+oY7dcY3vQ0DU=;
 b=wFBcHiR80Fhua63CtUfD4bFJ6SQfVCgLGuYfZ++qrtCAFYF9lFGilbEi8cOUJrR99Pj24CLqUJHsGhA0id4pkgbyknOiY8s0zHewUHJvPiJrtKV9C+heIyy1819TPYsw7TqcndcPThIFeUkkbKmEPFSTrLpi3QX8CEFh6zwl3FtRJnjKi7bE0Fe2wfncCQiqMi43ka2CV32pPUif7j0cUd/5YbnlNG2DLb08RCXOe2X+LtczAKOpI5bUgAjmzjr0vHYbf6G29XnAT55zRAzibzoyZZzyrJXoQmi82n3Alb9k4nOoH8GGBeVmoGBiv7h4jO3D/byo4uhzMfWvjTC/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jeggdPGCWzTi5DhozF0OjRvI4gKRv+oY7dcY3vQ0DU=;
 b=d08EYxJTgZH3hxJpbKMyG/y1fNVR6BMTOGZn0kyYBf+EQZhO86YZ2HAZvFSCVWFJkhnn2oT72l6JdzcLMHDB/eqWDyTc1lg4QaWONAPRJH/cT4bttVgB3/IJH92rKk5EjSNZHajj9yzs6eccBNsrqUA/ObJ7ALvVvi3jw8kprvU=
Received: from PH7P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::34)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Mon, 16 Jun
 2025 03:46:22 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::a6) by PH7P223CA0003.outlook.office365.com
 (2603:10b6:510:338::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 03:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 03:46:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Jun
 2025 22:46:19 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 15 Jun 2025 22:46:13 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v2 2/9] drm/amdgpu/mes: add front end for detect and reset hung queue
Date: Mon, 16 Jun 2025 11:43:35 +0800
Message-ID: <20250616034605.2683434-2-Jesse.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c951d6b-155c-4a93-4d0a-08ddac885c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1jZFLQseWItSNzUUYCRyp2N5Ah+X4C1m7uWpWwdJhht0WZReFPUG9CxiMklH?=
 =?us-ascii?Q?bv1XWMss2hSvzHPOJ7FEo8cOchGRvp4exJDb/j8dHEeWOQaKEGrP2g2sJ00Z?=
 =?us-ascii?Q?kV5+qBLhTfU8XAVgN5B7qb+w6zTwIvk5XKx8XWkallw7bE6puFeWbKFCW0Wp?=
 =?us-ascii?Q?gbR27lv81WWzKmlZIILMvAvCOYt/3twErHNNdmLj95vReEvwswAjocOXWLbL?=
 =?us-ascii?Q?N4uRAd3szWqvoh4L/TOol3oUwtHyxFBSm64/Es/KNaGFGzqAAD3XccwK2NLt?=
 =?us-ascii?Q?k4rR/GifpJ9A2j0n4ZiN1uXp+F3opdk4/1Ge07cBD8CxEJTkTeTut3tSd535?=
 =?us-ascii?Q?iEcJO98ezvk3J2+oPxyZBQhH356MgbDg+UtdMw5PQUDWtKnv8uaWFcnNILCY?=
 =?us-ascii?Q?vjG45prClvBjYLzt30tBfacOZzmWDqvpfgqRojbu23VW6EijTKGynVm+XQfW?=
 =?us-ascii?Q?P/Pu8qchZji3a4m62Bp5RghXMQ8qEU9Obpgdy9xeaVL+KIpRzshvQpGUBxI0?=
 =?us-ascii?Q?953Og/sf/W+uBCYO9MYfu3HhkJ6dIJC+iu+FyTlPokXRMTbsrU4XmULXEJvC?=
 =?us-ascii?Q?8yWENtpxn/Nmpzrj5G1KE6SNMQj3plRwUHMJQ2XcC1Nxp0eyGkl0t562qDND?=
 =?us-ascii?Q?9XMToEzwc7s6nqVS0gVld1PVEgtNb5BdTLsK/UsCjilhPc8zd4fUZA/wAwRj?=
 =?us-ascii?Q?ZHT0oBotPC0hg2JLqtVGShmy8+H4NVj66cr3aAv7n9pYf6uD7lJQZ+1/dTYc?=
 =?us-ascii?Q?KJqI+OsGOkq8CkW38eWmbWgK+YZgvZuBHcBqb7leMa0/B3iXOCOm+mzLs5xo?=
 =?us-ascii?Q?jZWYv/f79f4y7vWV9CMOQY+C8txY3aMRkiL0a0gX6Dy/AkcC4OXeKZC4NjMR?=
 =?us-ascii?Q?Wb76/sBtqH/0hxZrEmVmMkjy6ObXhW0GMsNeg6VRjZAygp+cG682aH2v7+ag?=
 =?us-ascii?Q?USJr0ewZ62puiLXrWbRH0LteZAx54xVprvJZMQlFmHbBYFHhC3zjk6UYTT8j?=
 =?us-ascii?Q?70GS9BnmyVNZvsR7I21VyzauHhzRZ/gEOtVVPDCutng7TuD8ywW0wt6ZBvHg?=
 =?us-ascii?Q?e0/UitAu3y7Kwkx8qywD8qaesJK+KcaBH5yriKOZaqIFAsGHESiJjTkIN0Q3?=
 =?us-ascii?Q?E4WH1+J0LGCwvlGu+Up0fMfpxlxRwWFfdChZINcNO4SJ2ZU6DwGi42Qgjhbu?=
 =?us-ascii?Q?TJECWbvJHhg9Yk1qkEJF63S8ObmSHN8Z0pQKm6ZYdNJnLag0IuFOwRvt3mID?=
 =?us-ascii?Q?zpL0vxRCEX7SUnhcG4tgFMxNBwDyy01KHsT+AyQpLFhTH/lecfUFq8dtHHBA?=
 =?us-ascii?Q?2QH1TcfVZoLUFo0mF8JqahrO4uL4VvlRKq6I/2UnqyP1rPbb+Tn+ivpPTbd3?=
 =?us-ascii?Q?MM/7k+kHutTCSXT8J/x1IafbaBqe2CiKuhw3KuGNmKZdtLZcu0Jz7W9C2xgK?=
 =?us-ascii?Q?we5zYoSL7LJlICWhiXFXKTz9w01LG709yq77lhGU4+vqmRYs382ThaqW+WHQ?=
 =?us-ascii?Q?gKK4QHEmd+8E6kz/JtoEHsRd9kyM+kdk4LFM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 03:46:21.6498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c951d6b-155c-4a93-4d0a-08ddac885c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
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

From: Alex Deucher <alexander.deucher@amd.com>

Helper function to detect and reset hung queues.  MES will
return an array of doorbell indices of which queues are hung
and were optionally reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 62 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 ++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 6fa9fa11c8f3..c1c7064237fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -191,6 +191,20 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	if (r)
 		goto error_doorbell;
 
+	if (adev->mes.hung_queue_db_array_size) {
+		r = amdgpu_bo_create_kernel(adev,
+					    adev->mes.hung_queue_db_array_size * sizeof(u32),
+					    PAGE_SIZE,
+					    AMDGPU_GEM_DOMAIN_GTT,
+					    &adev->mes.hung_queue_db_array_gpu_obj,
+					    &adev->mes.hung_queue_db_array_gpu_addr,
+					    &adev->mes.hung_queue_db_array_cpu_addr);
+		if (r) {
+			dev_warn(adev->dev, "failed to create MES hung db array buffer (%d)", r);
+			goto error_doorbell;
+		}
+	}
+
 	return 0;
 
 error_doorbell:
@@ -216,6 +230,10 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 {
 	int i;
 
+	amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj,
+			      &adev->mes.hung_queue_db_array_gpu_addr,
+			      &adev->mes.hung_queue_db_array_cpu_addr);
+
 	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
 			      &adev->mes.event_log_gpu_addr,
 			      &adev->mes.event_log_cpu_addr);
@@ -366,6 +384,50 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev)
+{
+	return adev->mes.hung_queue_db_array_size;
+}
+
+int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
+					    int queue_type,
+					    bool detect_only,
+					    unsigned int *hung_db_num,
+					    u32 *hung_db_array)
+
+{
+	struct mes_detect_and_reset_queue_input input;
+	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr;
+	int r, i;
+
+	if (!hung_db_num || !hung_db_array)
+		return -EINVAL;
+
+	if ((queue_type != AMDGPU_RING_TYPE_GFX) &&
+	    (queue_type != AMDGPU_RING_TYPE_COMPUTE) &&
+	    (queue_type != AMDGPU_RING_TYPE_SDMA))
+		return -EINVAL;
+
+	input.queue_type = queue_type;
+	input.detect_only = detect_only;
+
+	r = adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
+							  &input);
+	if (r) {
+		dev_err(adev->dev, "failed to detect and reset\n");
+	} else {
+		*hung_db_num = 0;
+		for (i = 0; i < adev->mes.hung_queue_db_array_size; i++) {
+			if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
+				hung_db_array[i] = db_array[i];
+				*hung_db_num += 1;
+			}
+		}
+	}
+
+	return r;
+}
+
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	struct mes_misc_op_input op_input;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c0d2c195fe2e..2c4568951edb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -41,6 +41,7 @@
 #define AMDGPU_MES_API_VERSION_MASK	0x00fff000
 #define AMDGPU_MES_FEAT_VERSION_MASK	0xff000000
 #define AMDGPU_MES_MSCRATCH_SIZE	0x40000
+#define AMDGPU_MES_INVALID_DB_OFFSET	0xffffffff
 
 enum amdgpu_mes_priority_level {
 	AMDGPU_MES_PRIORITY_LEVEL_LOW       = 0,
@@ -147,6 +148,10 @@ struct amdgpu_mes {
 	uint64_t            resource_1_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	void                *resource_1_addr[AMDGPU_MAX_MES_PIPES];
 
+	int				hung_queue_db_array_size;
+	struct amdgpu_bo		*hung_queue_db_array_gpu_obj;
+	uint64_t			hung_queue_db_array_gpu_addr;
+	void				*hung_queue_db_array_cpu_addr;
 };
 
 struct amdgpu_mes_gang {
@@ -280,6 +285,11 @@ struct mes_reset_queue_input {
 	bool                               is_kq;
 };
 
+struct mes_detect_and_reset_queue_input {
+	uint32_t                           queue_type;
+	bool                               detect_only;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -367,6 +377,8 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
+	int (*detect_and_reset_hung_queues)(struct amdgpu_mes *mes,
+					    struct mes_detect_and_reset_queue_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
@@ -390,6 +402,13 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  unsigned int vmid,
 				  bool use_mmio);
 
+int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev);
+int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
+					    int queue_type,
+					    bool detect_only,
+					    unsigned int *hung_db_num,
+					    u32 *hung_db_array);
+
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		    uint32_t reg, uint32_t val);
-- 
2.49.0

