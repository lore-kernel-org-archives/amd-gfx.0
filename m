Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83125CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 05:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B53010E60F;
	Tue,  9 Sep 2025 05:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AfG0oud2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FD010E60F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 05:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhFdOYsszkCcsVXUcfB+UJn/g2F67mM+5egTeh2e+IxwCceq0JKh5WNF7AI8w3LJ8wwPqpHAQmXFWCrWIWUojeXqeqm9vKKHyIfD3Q7hV8J4jZ3GFKIf2PinkS92sS3+64T/TyZZugh59lv2kkfTdo4wX4ixoheLF1lg2ZxUkGj9ZLpA920sm0LV2Ffd3urvZ6Z9cWwo6nBAbuQXCFDDmOQDeo1QCWkLGHb+asgWcrAhVM+X5sNZirTX2rKciXQ5p7PGbE4FeJpqsE6aN7F2l006ffhmKJyyxDNJUnhGHnHjOsyh/XF4qnpyKIdTWk/pXeQE+S46MS+9bU5eFwH/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRC7PiWkdS2U6LEq/Zapxoyuc/OUZh7AZDiY6pbZGlc=;
 b=eznoHIlt2AVj3zQxjv9CyCWqGT9mQSWAQKOH6sV3MnMzgBOL9ewiwej+9QhU1Rzor937ibZvZWT1GgGLzMfv0iPWW4ttjD5EtNcpkxMq3T+7xcGqnYjCXWu8CgLUkYDI13Gr3LIVgQJ8QgWp8rae62Tgehf1G99ulz2DH9POl1kNkc7sjN/UeYRzrUvWNDg0JEUpCqQupGPqmpLM1WK68354nC4LyF2avZaLh9vHEHGjDs2XrW1EzYfXKeMFi0d1+ymEDdhp3am/02uzuMuVtj2zU21n7CrdWAbQO0NjXO0VNiJcg54qOQYd2B9sdG4ihLqpoLlhdkwr9t/kxar32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRC7PiWkdS2U6LEq/Zapxoyuc/OUZh7AZDiY6pbZGlc=;
 b=AfG0oud2dqvK3yxgvZgfSyi9KEmEei7SHS4pnXae79I6h8zboEtwdi7ULt6MkQLtNUscieBmhj8hLNzHF4YV9/LJcJotUW4926vEjK1kufm/haHoiV4Xn+Kf0Tm/sKE034iYpeM1R8oo/+n528ilGs91gbLBOSrJLxVg4JtvSNs=
Received: from MN2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:208:239::8)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:50:03 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::c1) by MN2PR08CA0003.outlook.office365.com
 (2603:10b6:208:239::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 05:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 05:50:03 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 22:49:58 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v3 2/7] drm/amd/pm: Add helper functions for gpu metrics
Date: Tue, 9 Sep 2025 11:17:32 +0530
Message-ID: <20250909054933.2911159-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250909054933.2911159-1-lijo.lazar@amd.com>
References: <20250909054933.2911159-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8cda1e-61c9-4cdd-cd13-08ddef64b8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pTivMBhf2JDy6em29VPEcmJfXW0r0Y8ftRtSpAe1NA5PK9v8z/IKcTH9PBN/?=
 =?us-ascii?Q?Un6ZX5yoUSJKAX4ZS468kF0MrbkcVOGYQCFEKbB6Fdy7TR9rrUheSiVnygEI?=
 =?us-ascii?Q?xWgJgkf0hQrXITTaNfPmftdkWg+O/619lv+BWVvmX40621wy25nO8SlKHMDO?=
 =?us-ascii?Q?sZttiEZXYhgjUaXXpPvBnId4Eg4G5q8Tg3qiTp+6ZSIXZEBdCi/VMj+klkYV?=
 =?us-ascii?Q?FSooOmV+lT0kR54J8EGIuDklaamm13qORM5cZl1MZQq9bXMol77SKgVkhYic?=
 =?us-ascii?Q?g3D9NmEC73Bt8JloSCkuKgnvM7ueG0qLE6mxq9Ay8mwfMqTVD0AVByyULvxG?=
 =?us-ascii?Q?SN/5z90X17pI01Nhl/IiMfFw8+JEs91Cr17DrB+2KtpluX3hjsy4oH0IA2Wz?=
 =?us-ascii?Q?ke7mMQPX84jzyOqqy1WQTxIs0FHFP332Ia4C0t5DIejHQIM72+Uu6XwDuM7d?=
 =?us-ascii?Q?uU8rozdtXzbODXCv66LbHQkDUWjFh+Dadset6YypfVATE0MWjuZCDUHYGTOJ?=
 =?us-ascii?Q?GOwpNv68daj95oTS19MtjP2YOZ1yv1DmG+0NaPjLFUIkMwooDlP05UFqHKB5?=
 =?us-ascii?Q?aGSR5Clu+CY1qAiIHCTBAL5oj8vEvTBvJzlJ0iODWl72RaQ3EweD+nbOByWD?=
 =?us-ascii?Q?MaqpPnmfs3BpBvw8Lvo73sWgT/b/Fhjs8uJvwQA/11W+SYNf2YFaFgNYgjxK?=
 =?us-ascii?Q?21VLWk0JYyOfxcD7ncsLnvjQ7LZ8erdt99L61zTBdgQaZZeNFubfYb531HaN?=
 =?us-ascii?Q?4LV77ac5Xsdb2vGAU0bHRKI+O8Qzkvqf5oBW4vAhnmdXCtBVJswGnP9ygM//?=
 =?us-ascii?Q?JoGY2XliVaNXNnZE2pvRTY1VyjTXeonsaClH5l3qpRm8frjjMWN731/zdBA/?=
 =?us-ascii?Q?+Pi0npJNMLQTgX/UdCa3c2z0e+hZKORikVpmaJUPqbSiyPeEwo+RAWjjfNhi?=
 =?us-ascii?Q?XHC4HJwmgvx/oNSMhXcqSHW1UvHIVXZA8hMbWf+jtWVoplZZdxt0uFJJFa3T?=
 =?us-ascii?Q?u2rZRblmKCQERGIHiBQ0r6bb9GeVvWlHw1K9p8EPJ5/Wy4Zg3kBQbufSWRlk?=
 =?us-ascii?Q?OdQCXu0SxatlkKGTzrMa8FVlCve7ahJl2uP0L6wweOZJAloO5+Bd+7VgHkJ2?=
 =?us-ascii?Q?zKvUwai9jOFIGGH+VRN+g4niuOoZVufFE1GtNrd7nCGLJJykLeELriuC3MYN?=
 =?us-ascii?Q?sV8qvuUEtvjbgp52KOz6qHRIcX4x48cvHP9SkSbBqSXs7L3YiDAO410ONqLK?=
 =?us-ascii?Q?bN6rZ5LZwT6VVDup9718yowFxplK65zMNX4HaQ3kcYYQHZx0lSlBWWzAgDuQ?=
 =?us-ascii?Q?Cw6nnIjve75VTMMnsLfrHjXVw/5YJrGtdM0aNEryh3dnYPUchkHNql0s41k3?=
 =?us-ascii?Q?mA/JoXxLbzinjD6EUJLbjXQtcEpgQEx5EfnM6tY0G2MQ2ISKGBLOEsoQvGs0?=
 =?us-ascii?Q?LWa/K8OQlgyZhI9f9eB9xo3jJZJlNVQiK2GUcHq4cPiejxNDvjS1lvqIogA3?=
 =?us-ascii?Q?MKH4/YU4dkPuyGOpBAAekvgxYeRM4+VpV3HC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:50:03.0751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8cda1e-61c9-4cdd-cd13-08ddef64b8b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
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

Add helper macros to define metrics struct definitions. It will define
structs with field type followed by actual field. A helper macro is also
added to initialize the field encoding for all fields and to initialize
the field members to 0xFFs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d588f74b98de..92eaf13680b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -200,5 +200,67 @@ void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
 				       u32 workload_mask,
 				       u32 *backend_workload_mask);
 
+/*SMU gpu metrics */
+
+/* Attribute ID mapping */
+#define SMU_MATTR(X) AMDGPU_METRICS_ATTR_##X
+/* Type ID mapping */
+#define SMU_MTYPE(X) AMDGPU_METRICS_TYPE_##X
+/* Unit ID mapping */
+#define SMU_MUNIT(X) AMDGPU_METRICS_UNIT_##X
+
+/* Map TYPEID to C type */
+#define SMU_CTYPE(TYPEID) SMU_CTYPE_##TYPEID
+
+#define SMU_CTYPE_AMDGPU_METRICS_TYPE_U8 u8
+#define SMU_CTYPE_AMDGPU_METRICS_TYPE_S8 s8
+#define SMU_CTYPE_AMDGPU_METRICS_TYPE_U16 u16
+#define SMU_CTYPE_AMDGPU_METRICS_TYPE_S16 s16
+#define SMU_CTYPE_AMDGPU_METRICS_TYPE_U32 u32
+#define SMU_CTYPE_AMDGPU_METRICS_TYPE_S32 s32
+#define SMU_CTYPE_AMDGPU_METRICS_TYPE_U64 u64
+#define SMU_CTYPE_AMDGPU_METRICS_TYPE_S64 s64
+
+/* struct members */
+#define SMU_METRICS_SCALAR(ID, UNIT, TYPEID, NAME) \
+	u32 NAME##_ftype;                          \
+	SMU_CTYPE(TYPEID) NAME;
+
+#define SMU_METRICS_ARRAY(ID, UNIT, TYPEID, NAME, SIZE) \
+	u32 NAME##_ftype;                               \
+	SMU_CTYPE(TYPEID) NAME[SIZE];
+
+/* Init functions for scalar/array fields - init to 0xFFs */
+#define SMU_METRICS_INIT_SCALAR(ID, UNIT, TYPEID, NAME)                   \
+	obj->NAME##_ftype = AMDGPU_METRICS_ENC_ATTR(UNIT, TYPEID, ID, 1); \
+	obj->NAME = (SMU_CTYPE(TYPEID)) ~0;                               \
+	count++;
+
+#define SMU_METRICS_INIT_ARRAY(ID, UNIT, TYPEID, NAME, SIZE)                 \
+	obj->NAME##_ftype = AMDGPU_METRICS_ENC_ATTR(UNIT, TYPEID, ID, SIZE); \
+	memset(obj->NAME, 0xFF, sizeof(obj->NAME));                          \
+	count++;
+
+/* Declare Metrics Class and Template object */
+#define DECLARE_SMU_METRICS_CLASS(CLASSNAME, SMU_METRICS_FIELD_LIST)          \
+	struct __packed CLASSNAME {                                           \
+		struct metrics_table_header header;                           \
+		int attr_count;                                               \
+		SMU_METRICS_FIELD_LIST(SMU_METRICS_SCALAR, SMU_METRICS_ARRAY) \
+	};                                                                    \
+                                                                              \
+	static inline void CLASSNAME##_init(struct CLASSNAME *obj,            \
+					    uint8_t frev, uint8_t crev)       \
+	{                                                                     \
+		int count = 0;                                                \
+		memset(obj, 0xFF, sizeof(*obj));                              \
+		obj->header.format_revision = frev;                           \
+		obj->header.content_revision = crev;                          \
+		obj->header.structure_size = sizeof(*obj);                    \
+		SMU_METRICS_FIELD_LIST(SMU_METRICS_INIT_SCALAR,               \
+				       SMU_METRICS_INIT_ARRAY)                \
+		obj->attr_count = count;                                      \
+	}
+
 #endif
 #endif
-- 
2.49.0

