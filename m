Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85EFCAC58E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 08:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796E210E327;
	Mon, 15 Sep 2025 08:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z1jiK0C9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95A510E327
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 08:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTVSVPnlvqWqXwiQAx80mrjrjH5NgezBI+gmwwHGVhKw0FHuWvWdm6TVcMoFPsrrwHT87KHFcxH43UYSRJNpSXc1QI9rVou56D+4sYzopyze0xTD93xFePyGa/n+5VrGZkyjoPFCbzK48ZCGRj52hER6bXELwBZHp4HGUPK653XF9Sa0qCAMsXJKUi2hf4QCfFbgCLbbGqbGXbRVkxp+4U3ooxkDOnp/pi56J6j2gfhS/aY2EQHzOb4moJksIb+cbqgB5UIY6ls8v2gnbLLJgukHb5f+y6aiqdKK/UWHNA6V/OP0xZ/HGfYXTpF4ZGv5v+zTfYADprirCdz9F4ghnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R0Ku9VgNVIYi1U9AqMfIUq+XKdH2fnQDnJBsqPmV00=;
 b=gm8vbAuwR9HxHBSZuya3KZTsjDfH9nNU9aVvrDWmpXez20yFEVt2BTRRjBVuKfOhvHQZLDQPI8vZUE0djVpFnO3x1v0F6kDJE1rDD387U7WnRDuWqmuSmwYw/6pjP4D6SYZ2zhzVC+cDvrCN3pHiKvB70nwpUH8Tu1Tuvmk+LTxpP2qChd9fG5ZRGsZdnx9i7fy5UrlfTL0fdm+o6u/rFumGRj0zGO+z+43M/mOyPu+SbT2mTffTaSPILugzNDkBUTdPe+VfjLOYR9evtDTMdDk+h6rT7MWKL3h9I898chp+sKrofkV0mT5I1XB99inVARZMEHUWQ/SdJrwfV/jIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R0Ku9VgNVIYi1U9AqMfIUq+XKdH2fnQDnJBsqPmV00=;
 b=z1jiK0C95FyA6NLs9cyEKI5Kx++HDNmNXpBco1sk8SdfKSGjgeDAEa1CX16m1pjMYNmf7MFeDU86wuS/Qitb/Y4CPk7/oD8FY5ywV1f5+4ZH2H1z7FFRAskiL6C+pAM3BP2V7K0QQMPSLQavlD9J0lPJUKwToS4nqX9UB7hUdOw=
Received: from BY3PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:39b::22)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 08:01:53 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::b) by BY3PR05CA0047.outlook.office365.com
 (2603:10b6:a03:39b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 08:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 08:01:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 01:01:50 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v4 2/7] drm/amd/pm: Add helper functions for gpu metrics
Date: Mon, 15 Sep 2025 13:26:31 +0530
Message-ID: <20250915080123.3024297-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250915080123.3024297-1-lijo.lazar@amd.com>
References: <20250915080123.3024297-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7a0ca2-abb6-41df-fdee-08ddf42e2191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hsiN/05GuwJC7UcIPYCHEMMzvMak7+TT+KsPoxc/aukIrPljTJUwUcOOyzU2?=
 =?us-ascii?Q?gxwA1reCCBKv+nQ4r3G1Jd0G4yqHmf2jyLsx4elFC09cJkTCnd34omHJNQIz?=
 =?us-ascii?Q?2lTTGFamLCaeeMDRAVhXqcV3T4Pj5cWfEhELae6FV8R6Dmu9F9uRqKh53Tuw?=
 =?us-ascii?Q?R6DsZdrllL0buC7RuZJOH6BxEC7CTCdFbC7/ivguUbFTGFrie1BOjFOavK6/?=
 =?us-ascii?Q?HGq290Q4gmFJQOUnsKqWYNb0UhMcyKPZy41PO/VX2VkV0t9ayRmv0UO6lutU?=
 =?us-ascii?Q?7U9MwpzJEyKyX3zBIfKNwIKTRaxiYXnQFMxqjNPMr/OZcdsuztjuqi+rv7XI?=
 =?us-ascii?Q?cisUYXjG64QFDgNWd5Nya/CWQoXhySmacHnoUGKgf7N5zgHro9vAUoYwL8eI?=
 =?us-ascii?Q?QsdWgW7Nt77wQpkfMRRuT1bOk5m7YhToAfH8E5ZkKRci1fJPEi3AmBL/OGwg?=
 =?us-ascii?Q?SpItXF6CulY+xWwRpWCNBUS5L369GEz2ma9jS1V8ssTD5bCciTqD7Tn1Kyu5?=
 =?us-ascii?Q?LB2YjNgjSRFi44zHtxdZnl9lqZSmwnv5YoLk1wYoKyjrwaYaiS4RA1m+6Uhi?=
 =?us-ascii?Q?h9hCZC4MWRv71MfDf9Dci+6Sf9TMiV/YIqYJyBZF5AT5QPdD0RsbE8maUc0X?=
 =?us-ascii?Q?0AikDzw5jgaHbOp0hj1p2qRwdwHeH0bmr5Ra4b0MK6eRqYR22Reo2LNbDxjQ?=
 =?us-ascii?Q?j1uykjYXqb8r0qknb7hSjYEsAD2gtx+NOwLCWSmspWBeghGvkk7+gIOI6o7u?=
 =?us-ascii?Q?SfZElpnrbgCTW5VX39hhA3IleLmc8SYhTFNt7+MVS6BLYhF28D9P12ScwUjd?=
 =?us-ascii?Q?zzVIH/JhFPyRicvisLtplNi58waq7Rteq7TQfQXy5nRbSWAu2z8weBYjjTy0?=
 =?us-ascii?Q?fFpr+2gcbqdusBvOdFpSIKuXK/PNFLQRss1qzWl5Mq7oyg8oNZlG7/f16LQf?=
 =?us-ascii?Q?Dlk7Uy16RSTQzE6X4Ai5cWPlu2yY+VH78uv43DNl4WIFaQGMYmVxINdUqPuv?=
 =?us-ascii?Q?CV5cWH+KGlbDZDbVm7cIbBnPJG5u4TurlRyyx0LbH8WqMKhAmO8g4RHM11jY?=
 =?us-ascii?Q?Dzx5z11V+ZBdvRJDx6UErVwzZ2oJJ0Ht5kMEIn5ZmxTbHcx408ybQ+45HrKv?=
 =?us-ascii?Q?Gc9sp3MtplIwLLaxUU2Hn/617qE5OA8daoldoqagn1fkMJXMwdQtZJ38Vpuz?=
 =?us-ascii?Q?YzoVppWdoyFC5LhFTrcOOhjHeUWgIuP5YnxttcDcg0Gmvo48fDERRvi+EAgZ?=
 =?us-ascii?Q?Uw9oOS5OXkFzIc//NbFW/H6grIGCG6VU5gqv1+2pz7maWFNpCoub2oCqGsq1?=
 =?us-ascii?Q?XYIiTKJJxGkrVFPNEy2x3ximzLMRQjpevzVxfTJszj44WMzMHNNJeL4+SSyk?=
 =?us-ascii?Q?YH5pA0i00JDuN3QeCGoDmMys3KOcer6zXdZpkVl0qkwH0/b7Zo67eCzhnqME?=
 =?us-ascii?Q?QgUlk5bJp4PW+d6u4NuSjpOuTvFFrV/DfsxJ0HPEZPgU98HFMhylVJO10TvU?=
 =?us-ascii?Q?qVid99Ic7JjYADdjRvjZ0VzkilQbRdToHEV3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:01:52.4028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7a0ca2-abb6-41df-fdee-08ddf42e2191
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
v4: Fix ftype as u64 to match encoding field

 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d588f74b98de..d7a1c5e211b1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -200,5 +200,67 @@ void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
 				       u32 workload_mask,
 				       u32 *backend_workload_mask);
 
+/*SMU gpu metrics */
+
+/* Attribute ID mapping */
+#define SMU_MATTR(X) AMDGPU_METRICS_ATTR_ID_##X
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
+	u64 NAME##_ftype;                          \
+	SMU_CTYPE(TYPEID) NAME;
+
+#define SMU_METRICS_ARRAY(ID, UNIT, TYPEID, NAME, SIZE) \
+	u64 NAME##_ftype;                               \
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

