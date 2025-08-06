Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135A3C87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 02:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8616410E705;
	Wed,  6 Aug 2025 02:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ly7rjkvP";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 336A810E705
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 02:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5+LBoQq2MM0nkuCvBQPhnyhuRoC7ZsA3ofzDcpikR7zlUG3miTGshYK4+O9D45tcjLW6fD7L0RjbBOun7D2SwSMFtzzndG17mT2RTZcWbHuijgyLPSX6Efj9znbJdoxM/HHECm5Trb79jpy+8/goM9CLsZPeMxn3nEKW2zd7KZxsG/+k8lYs0bzPyOrtTzVs2P4cXcBUZICLmif04Cbgy/0OvrRZT9Sa7j1HKDtZzuucSBLSclLFfKin4HZ4AVjJs4ZWiYSuOPWLUS+OHmBVRm+8VbGy46UX/5L9aGMGygPznHbsfSzaHFflFDYKAFQSEr5mLypp/d7pJP2gOsqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=gAl7G9+7M0UGK5VdjCCZLh5Xf1p7I7XM32YxXR4rdH9YGCvACwWTDBegpffnJVnYl2kqF/L92zQ/M4py5TxiS0qy+KBEzJ14VKSx3fOMVzqJqD4/8/4jsTeSCjP7xdovUotXp3sGWKFpnN4xfq3NnKBv1zyQtuKm4Sgf0t4w7W3ymmXnalUlnlQPqM+cDXtotlYzhjRx6xC+e7VDZXjeHFPGb7cQrvq0gLqPNreBbGGFdjeEXZKmm9M3KLrrjvPbHtNgUKXCMMhkdFWtlgH7ah71q8jDNxXqzv3g2kxrqbyvfGE+PZgRaTH0AZpvsoPSh3uOplGLMVBFyL+jgHzMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=ly7rjkvPXDy8sBzuFyU39eWrV389rDqGCTaeNl7DyQDkzEwrqy5lwV/Uhts4HWYQB85ebOqNoH4KGf2lEl6m3D4DXiivgXXcAMT1+O2PtSASfKtjynFjpbQziQbTjhKp3d4/s7DUpc0nT4RxSLDryPOwAGW38bu4s8+FLYLT9xY=
Received: from MW4PR04CA0293.namprd04.prod.outlook.com (2603:10b6:303:89::28)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 02:28:52 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::54) by MW4PR04CA0293.outlook.office365.com
 (2603:10b6:303:89::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Wed,
 6 Aug 2025 02:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 02:28:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:28:50 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 21:28:44 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v7 05/11] drm/amdgpu/mes: add front end for detect and reset hung
 queue
Date: Wed, 6 Aug 2025 10:24:50 +0800
Message-ID: <20250806022816.1050823-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 661fceaf-14df-482a-af0d-08ddd490fb9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pTMtqmu2+AwTiE1pdwvXuVGegYv+ma77gGjDy9F9kUhGBbWxdqr77RFpxsUI?=
 =?us-ascii?Q?yJF3H2EpecRf5yHyqBXGupmcGN4I64BJ12E7yfWPQyKB/Pe9koJ8XcQSLjkM?=
 =?us-ascii?Q?WQ03NXvA5DtKj/uJ37AlE6/8dkx1+ZbmvkgvPBEoOqAUNzP/3mtmu5nKwKUe?=
 =?us-ascii?Q?4/vZ7HU1wBEo4TG35lsxQudGH99VMP269RjeY6K0Drb+qmERfjKGggZ77jAF?=
 =?us-ascii?Q?Mlu2jMGfzmZKGCGPiLcKjLE0KNvvnZldU9/WdjgFjBEUJs0gOAEFqecFfEbZ?=
 =?us-ascii?Q?PZkULT0jWnZANxViOMAxEkCCkdTM1ykxHSveZWjb9FH5MFWw1tMHG2hTCkiI?=
 =?us-ascii?Q?KRayxsbF9IkuUn5Rv4QL04P8g16pZZmrkxjB4yj2nCHu7GYwK3oSGMyZMIi+?=
 =?us-ascii?Q?Eytxm0Gh/W++DjGcaIQnY3bJCFEE913VkQgpqmMAEjQClFf96+d5ld/j6Yfv?=
 =?us-ascii?Q?2Nn2djwW5lZX8V5QXxeyW7xGYC0+qcuvH2dqWrxQmqtEpC4jUoir8dYtDMjq?=
 =?us-ascii?Q?c7FnIo94isT8OHn1cy6mtsyZ00mJwRr9OFZAXLjCOxOVAdSuabbIthG3gb8T?=
 =?us-ascii?Q?m5whugQ1JY7gV6LN1ZBIjxjjiSnVo6+v2eqVs7mhWu7XmPwBIEB+u/rjklX5?=
 =?us-ascii?Q?p3lYxn+6OgML9RyO1FoV7kBQnILMaIIBD0E+euzqFv1+G6OA0LFmbusM7S+a?=
 =?us-ascii?Q?0gu0DlQyiWsF0FjYIK7K9ClIbQ5jdlJv9125cawHXgjH0AiliJGmSPfZNNko?=
 =?us-ascii?Q?D4dX/crE6n/84L/tFQlYYeyNyUbgQbpDhDGMYxfgdBxQ5519BaGQKdNPiYgF?=
 =?us-ascii?Q?pDtEAwBy2j0DcqcINQl4B/YvTUP4s0/nEGrKdJVBT75/tkRIDI09u6hskVjv?=
 =?us-ascii?Q?mV0baW91uBfe71sir9Qpc8JxMJCl5ASYPGAQ4RgkocxVt/ZplcVbMztQQQTF?=
 =?us-ascii?Q?lJ9U3ObSj+wvw3RvALYLzxzN1XKbTg0JgrUpjOkechrzwiPoL4500hhlIHw8?=
 =?us-ascii?Q?l/0hcMz43ocQyIgqHFAvu6DZfdXq+9wNquKWDFKOhT5FVRp/f8nT6U0Xcow7?=
 =?us-ascii?Q?tjzTJagU45ryoszJkANwvc8yJsifAbfrTuwxbmFmpKGlzgZXHwooatVF0VTc?=
 =?us-ascii?Q?Vv0f7h/NsNZlVrxjVry4Gz7wvzSZegpSt6puFVy2MCE/W2SdubF4Jdz/N+8U?=
 =?us-ascii?Q?6ezl96xoOvpinZc2QnqGmerbOdX8lRlHUD3vc2Oko0/rMroeTQUctg7grciq?=
 =?us-ascii?Q?YIoWMuYAFxmWxhx+cH/TrNnhBrScrG/9aJ1nNzngx9cWJepStlfqBhr/nnSe?=
 =?us-ascii?Q?vZrpr0NXnycpgESey6lqV3YEMc59rpVAiFolFGvtjsB5mNgGGqkxw8bdtJ/r?=
 =?us-ascii?Q?g9YdCr8PrrQpE0A1+V+vTnO+W6IPJnyjLrAKdQ17FLmx48H6r44l10O7zwPo?=
 =?us-ascii?Q?RL/02RiZ5SpmH0ycwdvyq7N5rD9UL/8hGk0fBoBZ81w/xIOUYCg3G/goVCB4?=
 =?us-ascii?Q?2LTlhBxYqC+HEWx/DflXh/g8SLsWDvlCAHNR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:28:51.6866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 661fceaf-14df-482a-af0d-08ddd490fb9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
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

v2:  Clear the doorbell array before detection

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 65 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 ++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 135598502c8d..5bf9be073cdd 100644
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
@@ -366,6 +384,53 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
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
+	/* Clear the doorbell array before detection */
+	memset(adev->mes.hung_queue_db_array_cpu_addr, 0,
+		adev->mes.hung_queue_db_array_size * sizeof(u32));
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

