Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FB5C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 09:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E97610E4B8;
	Tue, 17 Jun 2025 09:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LtG9jHvD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A52E10E4B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 09:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bagJkoWvqpq7Mm7unJtChvTW1izjZUguPkw9PtHAfRhKxTvBX7j5kbUFKdjAUIve+98pnu+dyG0KSnbdOvyVLTP8PzIXh0h+E4GyxgTN1/51ExtPN0tYVmhoKcdYMSQXHQGKcoj85VFNdnetHykgAucAlUIiTApYe9RJPZxjiwzmsL8qhT7s8io7boMtkQC6V0n96loyfMufLprSIZXaFyKa939uOiGeMoPRIBwwesySBQYBBgbuNCVZimM3d1f55VxI2qVBs98/zp025Vacfjq0T6dc5cr/fWKgt5CCPtOX7p0pWTEIt1goVIdqrNfI7mfwCmOJi65v/JU3zmEM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jeggdPGCWzTi5DhozF0OjRvI4gKRv+oY7dcY3vQ0DU=;
 b=y6/V882SMxuGX/uJik3FOXAK0RKkTOfSsYPGX+/oGZq89Yi27WTix61T/t8ADfcQE2cNixLu8/WNFBWlixS9nwus29o31aqZgHRkmZXhRbO+UgnJ4GcfbeEJU/365hwoofiWByYUKg0OAi5V6bmX1qczpYeQ4iC+ke7TN2bXDXGMTaP65u957SYz0ucHCySDfU92CaG767vDGloS9xa1CFjde1gKi0I/4JakrsBKascQLHbSMRK/o3D5gB0UxTz573hJ+mcaZC2g0mqY7IIKU7MH+5zIVoJrO7t5B0DKLI/OKXMSGQtO+96XSYdWGHvGdQ6dy2kx/z1jsiolbsZInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jeggdPGCWzTi5DhozF0OjRvI4gKRv+oY7dcY3vQ0DU=;
 b=LtG9jHvDQE0omyXWjHshDS6nDyBH4J3qCsWq8qoHu+7yp8axC0VW8vm4z9xB4/eZPT+v5MG+KzNS/g76woEBCdqJX9mi65FPFqOCphkWwHT3IQbw7AD9CIsPmaQ862sRIBBQzwXmtDPg+JvkaigUhDpggSSRc7B+GxV01AshRAE=
Received: from RI1P284CA0060.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:153::8) by
 CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Tue, 17 Jun 2025 09:23:01 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10d6:10:153:cafe::30) by RI1P284CA0060.outlook.office365.com
 (2603:10d6:10:153::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.29 via Frontend Transport; Tue,
 17 Jun 2025 09:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 09:22:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:22:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:22:56 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 17 Jun 2025 04:22:50 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v3 2/9] drm/amdgpu/mes: add front end for detect and reset hung queue
Date: Tue, 17 Jun 2025 17:20:14 +0800
Message-ID: <20250617092243.2769580-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: be3cad24-3e7d-4de4-380d-08ddad808d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4GtJfIxhu6peSVL4af2bxo3nj8pECLRkslp36PGVVQ+ytm52nAw++ViMVGvk?=
 =?us-ascii?Q?2DBRB4s1pA3vpcpmbw8NR/rKWtjAFr/sOK9I3gS8WrR+fMWLwsn58HKUF1Wh?=
 =?us-ascii?Q?fNbbl3QZI40J9HKE7U66RtIlP7X1aNtAMF/G7CMl6me47WFPHiMNQsxNZAsb?=
 =?us-ascii?Q?/MrzVOyo/IurRuzmTvbKrxKRfw9O1lDMg+yJg93bpr/SDuqDTYyuPPsfmF/w?=
 =?us-ascii?Q?GWDEAy0Q10JdTu9LDC1S0nQsLZVYmC+AJXY8FYzu2CJBwt2GuJldbRASeH9a?=
 =?us-ascii?Q?R+UHNYqcEHeFe23I0Y/27OwW/QBj4VbRPvDIJtBpUAdtFGocXP8CMLOqcM6y?=
 =?us-ascii?Q?90MOTSvH7tt0nbSkwEeMIcpEk9t42hy8+EZkFxKJvpdg2WfcMN3F1EqIhpxQ?=
 =?us-ascii?Q?9cyf+Fi9hqh/XVxaEBCFl9xoQlKVa6YSz+QzKW4dqPwhNtgWH/uGUJXtDrv8?=
 =?us-ascii?Q?MDkyc1MjXKsunxdjrm3uWDkGIl+1RWUEB+PFgM4lRtHGqjrO4IETTz/XesTF?=
 =?us-ascii?Q?wgDNKOjJjVcv+9Oi8HKGydYNbsc0vcuQzR3CfblQ37uM45maJqH6B8jTkAqf?=
 =?us-ascii?Q?eCebMNDiDR8JaaXBvXVl8VYTZirhpnO0p937n/HWwDcxowr7+JzJQIbmXtoY?=
 =?us-ascii?Q?oGsdCrbRIGwMEeaDP8ovAFim3TcqYLd1tccsWMxuHqrmdN0XDBnnILiRa2r7?=
 =?us-ascii?Q?tvdB8SIPXCiZVJdqPwaFLQSW6RgDGws++Dz3dk+AlM4NzMAHo4ou5373ERpM?=
 =?us-ascii?Q?Dm1fiv4iePw6D8ecF9c8H18n8mSMI8A3kdcVk4dv/FwWDUYLL7OOcyNs2WA+?=
 =?us-ascii?Q?/SpPfSzYqrY6KXnXAkYJfhOcHRv9IjE6znbrHSiqU79cH93e72zinfyW1N3F?=
 =?us-ascii?Q?Lmd1reImuBuZSl+CC03oAfei04ml45ik1JbaCuiKyXqASGTptRMwbHeeYKlW?=
 =?us-ascii?Q?soOJ3ZGToJe1kSOIGTywKNMOiwaIolhmahFzlxB47Az8NgNTKp97ZgSYrPAa?=
 =?us-ascii?Q?R3SC3kQ8HcPBqU+Cb5z38UDpZa2OpHY2SsG00Tly1X1gbNAtWl2zdkSKfG3T?=
 =?us-ascii?Q?J+1LwlxpclWpa5+1QJ+w6SOAu9WMbq+VrymHGZg9loZdbZ1w1yo4Ma0Bvn1O?=
 =?us-ascii?Q?tXIdY9xgL2YZtzlN9AERjC7Xx3YMQHfst4ZPSXc83Csc0JQhhj/aeDnCbaVh?=
 =?us-ascii?Q?uHgwW0bpJ20wwmTnVP3uP6Vkcv6a8TtjqvOrIdHZjwcxF7D6oyEdfZaAZu4m?=
 =?us-ascii?Q?b9IILCoJ9TKKfgKZKO8Lg6TI7RTLtkYaoIgBcejjTpP02LY8KpAaLb9jl2TW?=
 =?us-ascii?Q?HS2/EAL3c/vkGSANCAaazryIvivDBJIwbGVn+mFezk5SJ6MjlXapt9n/82va?=
 =?us-ascii?Q?mEBXXA2DX1O19uLozt1QCzRUgZDd167aavb/bY46N0z8d/Bf1DL23NbMtaO/?=
 =?us-ascii?Q?ebR7VzLmup14mxe+n4KPfrfGmvtHityWpPz3zp5SNv5ToZvsu7RYZq3EU/Md?=
 =?us-ascii?Q?NfjsztX5ql2ccJOeFDk2b06+i7H8Osm51TpQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:22:58.9669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be3cad24-3e7d-4de4-380d-08ddad808d17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493
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

