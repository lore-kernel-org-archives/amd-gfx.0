Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3257CC87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84DD10E084;
	Mon,  4 Aug 2025 08:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oI5JTswm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0032E10E084
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmY0SJxKypsOLtlHUtnth89FrO6CIrKXK5JFoLk3ck4Jwt4yROFlehtrUXKaH9fqdqHcBpk0OIB8HlOtVN5jC90zEc254i21Cap3RONaSAxHZOjYQxXjfqpOEQ2kiqApfACIt8oGs5U+sAjHSjakLzRTgxlT1Zj21bWg1WCzO/GW278iqQuNi7inH73oOrf2j6mz1/00b+A4iUf3RAR91TmY2BRzMtvcpoS4CSKu0AEZ0nAacEwnqGbWJZhpguTIFm5ubuVRxF0ruSkThQK1hWxIuHBiVUOrQPVZFuNza299ydJP+eBQLbb7CB+EME7lkQRXBuCA9Qae3608hvVhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD+bLSxAEQkFIlpNJOL4yl8n2YnPpAufugwO4cbeZ4M=;
 b=H9VszTmPPCdmLZ88zNqJTq3iAQkx6hjkgl/WVs5QgLprzGz9cNk4IRlzEkYDya8Ngri2b0/kp1fAJaZcTqVaV9LCb9qDzT7fLJ9cTi3eiRHH+d5wc83e2qaffHEU/tqc9P1C/iz9T5qWWE+I3bCJv4+4sC3FG0ELOallwxTlDtbAeoCnZt9j/urNoucz8q8EHgkavCuIxeoBpziZqHjMK8jpLefN18t/Px7ESTo4HxeTLb+LfklZzW1WDyhHWluIZoRRSNLQY+0S21scvQzA4z0LQ5zgGBbG4iCseknmI3UZ2M2wScqn0MpxjVMtw2XM8vzRCywc2ihpEHmJA5R8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD+bLSxAEQkFIlpNJOL4yl8n2YnPpAufugwO4cbeZ4M=;
 b=oI5JTswmag0/ESok1hW8cKNUFtPCZ4iyYJp82duG53Hlq+IONZgBZjE8yLoLIkd+d5cNN2K6EXl3bG8DRJTN98N47lr+F97MkFjX8p/HoHq5nFj7Tl92q7lEwYMbiJGloErv4h05AP9f+p+esP1MibTrcN4uR+LidXWlc9Ju6oQ=
Received: from BL0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:91::15)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.19; Mon, 4 Aug
 2025 08:40:38 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::12) by BL0PR05CA0005.outlook.office365.com
 (2603:10b6:208:91::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.10 via Frontend Transport; Mon,
 4 Aug 2025 08:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:40:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:40:36 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:40:30 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 01/13] drm/amdgpu/mes: add front end for detect and reset hung
 queue
Date: Mon, 4 Aug 2025 16:38:19 +0800
Message-ID: <20250804084029.863138-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: b291e2f1-5984-4dd7-fb7e-08ddd33295fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PA1Ce77Wxwz49fKsITFo6DdJkiXG40O2aj7H77rycL30fzdiU3M+K5bFmZs+?=
 =?us-ascii?Q?143nJK+UZgBBUhS96iwVj3ykuzRZjux/BAcsFsyUZY4778K1kB+Qao9aggbV?=
 =?us-ascii?Q?JkmqPXdg0MvltmSM4mJ6jRgmY2GC1snQE4ZCIYkCdngXdqesD+vsryWdXpUz?=
 =?us-ascii?Q?7+Ss2T57KSe/8DJEtlSMdJ5zVkVAk5YSZFcv5aB5AJkPB3NZ1aeMVZMF+fqc?=
 =?us-ascii?Q?YhQvmB4SbqarkwEUh8X9RK1+SW/K4MTp9UsE5BDSd3ArPQH6P7ouGMISdZQH?=
 =?us-ascii?Q?bVkYYAXKFnLgEeoqCEO50ONdHZQaZFqlUP9xaN53pdysttpkAq1PyP2XO2t2?=
 =?us-ascii?Q?T1YD7hPgzSsaYUVPzyHM2c/5S0axTpy1jJwibkvPaRxRWYXrr4yeKROTADTQ?=
 =?us-ascii?Q?/y1ztImR3uBdHeJHZrY9STdk3j+nrFR4kSLbXfLUG1r7iPkDn7Ql+ubjWMS9?=
 =?us-ascii?Q?nF2igOJkyDEQwdCbhGQBvh+4d95D6B2MDolJZWklD8WW8sDXDLo+1dygJhqG?=
 =?us-ascii?Q?i0MRYi3PX8X5mFRp11El0300Yl8FsnhAw4GwGWzcVY9gG1T5m4C8e7LVBj9S?=
 =?us-ascii?Q?u90F2/T4j/C5WJApecG3BH/M2A6EVglEXujhjVdNrsT5iGyWs69tMV6o8aEx?=
 =?us-ascii?Q?Axmo3Qr73yvlP4Iw2QzGg9L8SJXO5u6esCFZBScNDywC0/7JHmMWpaSW4UoQ?=
 =?us-ascii?Q?+xrnw0tXAQQ2rTVdVDaU4yaPNaBmNaAw3p3zPsW8meRz2e3D6GksjHqkkZUj?=
 =?us-ascii?Q?r14pMLEfWqjS7qhjGRJj8zjv4Ic1AIg849xZtvcO78HVrJ5HE9RpI5HE19Oa?=
 =?us-ascii?Q?WDyPuYmNYOfPVkO2p96nir8jveA924IPWoCtw2PHHGjK8vyrqDz+0TlGV6LR?=
 =?us-ascii?Q?01egXTsiUvECBo1ktme9UFd1F/AEFdWW4Uv87+KIq4CUbYrkdrgchjEmyjIr?=
 =?us-ascii?Q?9aED1zTFUa2Dtaj1B6ABkZK8zS4zwajN2980bYknsI2CS+mZzArJSWV+aPgc?=
 =?us-ascii?Q?EbrdUE5wkAlfszkpuEM3YoGRkS3FTRLk8QA3pxdkaEZFB00rvpi5hIGGhLU3?=
 =?us-ascii?Q?oUHZp/Mm8z5GUXxJrQANzn1NaTQJ8T8HBGEUJQInYToIlvAtPTFEFseNLPr0?=
 =?us-ascii?Q?ODfX0gzoZa1iF1rC+syZXhCf3+qb9hdPi+EweCde7ub2lEwcMdJeIdnuyaN7?=
 =?us-ascii?Q?81YGeOCC7yjEwYKKRyKDKNqYko08gDMELyEXPUX7kSwYHvSDFC8PAfrBy0Xn?=
 =?us-ascii?Q?7XAYgX1hdZtlbBTlF1DF9FmhqDi5fOc4wBIwO6n9jz9ISBS2BwQdLv8vtQ/t?=
 =?us-ascii?Q?YVvgEn9xBcnAh5736w46CLiiQxVIs+9uxWFEgwqc1RJHMC8slvhu7y028yES?=
 =?us-ascii?Q?wZSn3+MtlV4DYD6dwx99t8kkuHTDwxzWHA6+XRttfWvhIHbD4vo/bihLeLWU?=
 =?us-ascii?Q?3icboCpKA+DWWPl9AdYZ1rblEtq72X7uRJ1FQ+HuL2FlhnjPjxZR9Wmvsy+9?=
 =?us-ascii?Q?jP49N1GGriJllCa9UyvRToN2az3jd/cVeD9y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:40:37.4129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b291e2f1-5984-4dd7-fb7e-08ddd33295fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659
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
index 135598502c8d..64c5cac9ad5b 100644
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

