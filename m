Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99752CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 11:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D70910E4BD;
	Mon,  8 Sep 2025 11:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="guWTYuaO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3058F10E3D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 11:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp6esqR7ViGJyWw68Nbmea3upMKEyY6QqKiT3JDMmwjDxg1UrThrMWJ5AUhZblqhgNqb6YcA0pYyTNyu5qYvwjSIK8XAkziAan9CGFhjm5KQ4jLSkmnJaWYXtaaJGNfxhrbLBV/s41aJR3p4D7h6qlzPEhSqGvSJYyYm6Mf+kGF5J/mECmTp9XJFIppv9de8wpZKO/lyqY7gkI2QnX2MD9eEB+7XIFvSyA+JNIUBrBy6ZX4752dB95adtmXH5Jit1be9T7/FYcIYUMYyGTCTBK7dBTsooSMVXAdiuVV7HqQjTfhAjiZg8quwfHdbu4WtScjU/ABAtpYysAj1nniOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRC7PiWkdS2U6LEq/Zapxoyuc/OUZh7AZDiY6pbZGlc=;
 b=PFYQASTuuBks+/ndHrq++KACrGapnTxbFsEm10WgulH0LUNm6IG4NrAu4OhAYIGv+WCKqeDrDNepwLmQy49WGFAIsn3649GsDE3/K87aE1kEah2ogUmrjDE2qZQ2DC4KyoxW6sDjAeZjzayHonXB5OV24wcbszMtrarDRKb8cJW8yiWVV/41njL1W6f43oYbKxvOO0I+6zIZi9/v90Li3kBZbA4W6AOyxpzdaJHeb+lO3EhMVu/dhbHcYmJaJbJj/THWCc86WV0zZsH4MMTHZoqTMRTPG1eZC4Dq/r+HRtJLw0TAsAx7aigwXq5FHI2VJ7PbHMCNcvDpeVLgfKlipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRC7PiWkdS2U6LEq/Zapxoyuc/OUZh7AZDiY6pbZGlc=;
 b=guWTYuaOJCO0bq8T5kfnBLScf8XlfUWXlXFbqWsQMk3n1D1SApoGAjyzEKqsmb1pkGDAPHPvMOXtu40/TgCVS05GvKTNkEcEHwF6G5x+bwMMXRMKBMzdMzh50la7PldlKzz0JUeavexrm1XR0XDHdHGdyRmhEWdolpOB9NCr5AM=
Received: from BN8PR04CA0053.namprd04.prod.outlook.com (2603:10b6:408:d4::27)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:02:58 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::4e) by BN8PR04CA0053.outlook.office365.com
 (2603:10b6:408:d4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:02:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:02:55 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2 2/7] drm/amd/pm: Add helper functions for gpu metrics
Date: Mon, 8 Sep 2025 16:31:13 +0530
Message-ID: <20250908110231.2888628-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908110231.2888628-1-lijo.lazar@amd.com>
References: <20250908110231.2888628-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 2207a65d-c74e-457d-32ab-08ddeec744ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VOzCrqQbWbI2wTE1BL0EyLzPmph1qFWFIkKkk4oq85U6QSkEZJUag2h/kdWj?=
 =?us-ascii?Q?IOeDwWqp38j/5OfcLojGXpQabdgq5+VT/UXTJMiaUaKfdu2NNoAFZVY9fScW?=
 =?us-ascii?Q?CdFIt4BhRBzfKvgO4927iDWkj6wl2vDFYacTDk45MlC8gND8JpeqLBZybFpc?=
 =?us-ascii?Q?+GVDynjCNQMK7r48zWSK3CvYGbRQMXVb8danDQhV6k+QInqC194mgqbJ806O?=
 =?us-ascii?Q?O+IlHwpnUk+/Fr3JK3zWSXblFYGT867ZpuXp96DScbk0Z/8jDmLYt6CXl69I?=
 =?us-ascii?Q?HtyEB/zFh5Owg+M2ES23u0IGRky2pCvTbA4Pxv2ReqJXs1HiQErmbVGoUi+f?=
 =?us-ascii?Q?GakiUXjqKznyUQlFY1NAcJtd1/Tgqhx0ttxjAc2joPu18HpOa40EKH5nVqHY?=
 =?us-ascii?Q?lVsg1WoEsi47LYmKl1/cXzDxcHno48iKtDtgF5/NmqWHDlvopIQkLJMgm0jT?=
 =?us-ascii?Q?iCHAqQq48sMLePni6drjFbkLCllA5aHzxF4d9uDHa3oHM0WzdjXWglMuWoRO?=
 =?us-ascii?Q?Qpent0RkJC0EVJOofXHMlNQtSLB2paecZgykc03Au6/mBgOE2Xj8DUnwE+vO?=
 =?us-ascii?Q?NloGyDlnOoX48TIP+tif3Kj+0azJ8JNlIxipYWX1PG69bjWg8AnGKecPbgWp?=
 =?us-ascii?Q?IjPdn3EGqASm/2PQRa0zYWn5W3IgIvXciDDlDozTBEyQubAC1O2UbufqB+7h?=
 =?us-ascii?Q?tYTe/K2oOqfqTaiH7nY3l+kqVGDKncEQrzzdw9pmf18XtTIr3pUfRD8hAfY1?=
 =?us-ascii?Q?bb5DJ4lbSKZLCDOIWjex1swm94r1LewcDOM7NPuzxJ7y9kKvXaF9OvTf2mhZ?=
 =?us-ascii?Q?3VQusWlCb9TWmHJyTT92XNc8H9OXCmCrTWcXytPatbOCx9oFyApm2xMalMzR?=
 =?us-ascii?Q?0FVCjlaCxxz7avwm5jfLaHzmCnhel3VjrW9to/G09ZX3yoS790l9p4hjA6XL?=
 =?us-ascii?Q?83nWYKLcqpgwdAgQ9jjqskuKR4KY/RteIfQLgSSTPx8tqOzeMkqoAWYkRJAp?=
 =?us-ascii?Q?6ltHGp/qX0SyQPgnpbW28vmU/Lu0k555LSvWPZxCAXZpPUu7Z06jV8Fg9lpO?=
 =?us-ascii?Q?KL08eUjLXx+Vo1182t57l1EcsrRTNZ6q3fEJ9QvjFLwHad1xrxT80TMNkyBy?=
 =?us-ascii?Q?DPUqKb1Nw773JWg8wd4lrlV76J7UCpUc2VWFYCkQ5x782D3e8AoAsH94zIxx?=
 =?us-ascii?Q?IbppgPfHv3c2lgzvTDx0B70SXQxCch/vlfU2jWl6qdrxXYJTq/sw5YVm2BUu?=
 =?us-ascii?Q?LRElE7jmi4XOb8ty0M2+SxH/bd87//o8VED5rQMbc3F2wQcJ5z2js960xoKu?=
 =?us-ascii?Q?oybHUsZpvaNzS6wnYB77OZXKdY59aQCyX6Ri4WVf/J1XQYIMN9U84TsPZIaB?=
 =?us-ascii?Q?Z1HUe8rm8Vdz5jAcHhAHOLBCQBjYP9lBURoJG6tLemPOeGLSU9/MRMwNeVl3?=
 =?us-ascii?Q?cLPgCOfkqzfCXC+3D5Iicslv8o0i6NUqxkX0WpqitZq/jnlXJCWJDjmHAmlY?=
 =?us-ascii?Q?6CWuvtr9WfPaiRJ2tdmyjMYmqk8blkFnRjtx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:02:57.8152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2207a65d-c74e-457d-32ab-08ddeec744ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
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

