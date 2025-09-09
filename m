Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AA1CAC585
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 05:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954D710E610;
	Tue,  9 Sep 2025 05:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="28sywJ0/";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7EF410E60F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 05:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2r7pMKPHGNkbPiiZcyJ95VN8D7HFN42Ukus/m7iOLIXqrsxrRjkvzs6Eu/omAqGTlSsNWk7O3klqv6oTmiNker86mXSV9f3yAj2tl8z00N/3Y1bDhlHxeRD6bzCrMpQWJ2vzZuKueWqmRCtGl8ru4vW6YLByGCbLyIUuXUVJZRomjEsP+6TWacPHhJA/bJ3VlJk15OUAVZkuHnnIOqMTP7ZPFVSSjuOi0ZzlrRl/PcCmgHQtvz5bjBsNbP/cUprw86tz0PDtQorm32VaajiJJkU5Dx1Ud425/jOgU+6mTYGnpf9r5VKzwZ1FhMd9xv4DEdjcwWCXsVRJ88stkQdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rla8K5GufQeIgFHSuKOBg4Kl7PjXDIY4wYgJ8UDCjNA=;
 b=yrLGMbxZbV5GDIljeUnzOvu8RZqYnefThDO9pyQv4VLLnKGnqxgJg2+mERUYg8pLVv1rerO5SdDIV6oJrfjppgNKERTwiAxuDzAHqe3jomLW55oCY3ceA7MBBJaAsibdAdlSqYU5iVVeV8JnNSZR3LzXZHWkY73x5icknXISeh8coCWelGtyHRVqW6+VrQv1xdrGjcfQh2sYkHYuNdtG6++GmHktheZddh3z5+j9PPcvthfGrfP1WDBHf4vMPLcDC0tnhMHJWKSzQ45qkys2KpOmnhVYT8JiPmy2xkx1To7QfceR07iC67qnssouwz5PSwnTMssfL/4Ebl2FNg9quQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rla8K5GufQeIgFHSuKOBg4Kl7PjXDIY4wYgJ8UDCjNA=;
 b=28sywJ0/WjjwE5sGJbOEz8g/Gfs8dKXFqvoauQHWjC3meq2RcWCdttdfSa1Pin1g2RfJmhaIUvk1RU2tSwkVpUWoZUlRt5ecchaEfr1ufWmXv+rruWhsj2+KW+4e7spTAV+qE2izkTisPjsg8WcsUAzbN2ncZs7XYo2N+cGSpRA=
Received: from MN2PR08CA0007.namprd08.prod.outlook.com (2603:10b6:208:239::12)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:50:00 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::8c) by MN2PR08CA0007.outlook.office365.com
 (2603:10b6:208:239::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 05:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 05:50:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 22:49:55 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v3 1/7] drm/amdgpu/pm: Add definition for gpu_metrics v1.9
Date: Tue, 9 Sep 2025 11:17:31 +0530
Message-ID: <20250909054933.2911159-2-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 177b820b-9975-40f5-6c1c-08ddef64b762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j9hCVyB4I0Cz+QoWDXS4FPor23IKY9zMaUmF99YlEMAU5+0yaXNVMILs/aE9?=
 =?us-ascii?Q?Ci4v3vE+ybqN5ABG1h45MxPbFWsKqJ5ISLvSspwi6DmWvsh0WdvZrbq9Ks95?=
 =?us-ascii?Q?AEOIJR2GADLVJDu3Aoj61qpgPJy63qOnOer9GoaJrcwJmIp8oeLaTNkPyGyT?=
 =?us-ascii?Q?uY9jzwOEVFSMSOAGg57S/ff3XQ2d6xvzckKGp4essxEgTQW2vPCSf3j9eB3s?=
 =?us-ascii?Q?JhqTwTqIlyGPjTypwxecmIEnSmwGTuOfdxcKHaHa/bCx+tiD4iZIcbDQ0G+Z?=
 =?us-ascii?Q?evBP9viMrzMNshGao3vdL8tl25V+h7EGSetFYVkg9HTP7FZs1RoAjTSCLc0c?=
 =?us-ascii?Q?d83wYBdODzpkd6b55gVAOxaJ/lmEnrwaTldDh1Kren5qj19NJk+7h6RyEAX2?=
 =?us-ascii?Q?sDjOgPlfu6BnkL4lXlGQVOiNKTjqma95wkMi1AETxVO3pqzGV4mOQ0Wp3P0T?=
 =?us-ascii?Q?o7xzC2ZhC77T/6ZK11Zfr0AnjVvwOYXK8TDt3pa/x0piLluAbgOG3t+0vPBB?=
 =?us-ascii?Q?4l6VZsmuBqkI8R0GY5Ez+TGK4jVPi7I751Djyk8bsxf96xSgtuS/xeWWUngl?=
 =?us-ascii?Q?48orKM2ssfRf7oa2Q5KN/aiMfKtZnmtyc+GBaR77D8m+5GhxHlafskikjM8k?=
 =?us-ascii?Q?VCjkTlDZWXENovAu1f4KS9pYMFZufuIrC/tHagiSIIBfrwjtxdluXgLNOuxg?=
 =?us-ascii?Q?BycI4WmZ6zjZSFqZ2CcNiFuXPy+bOu+8vdI/hO4/70bFeBKr+yiTM0lFJq/i?=
 =?us-ascii?Q?vfy43iU8KZ4doHV+VNZItUcuKrtSQ7Ju8ZBi7ny8cXrCTwqzhnPMHbBDVQ89?=
 =?us-ascii?Q?YlbEISUHEpyjVOs4TjycWAQ1ZShnThLeDBAqQWP2G0JSIFqVhE+ing4QSAyD?=
 =?us-ascii?Q?2gLrT2eJbgD4tVeZXcR1Rb50f7pdzxpxB0bSxQ2BMJilwLjGXdfkFpn6RHp8?=
 =?us-ascii?Q?LU4SHeekIo26Yh/iUS7ZiOI5YXIZK1t0jw3rh9Nk7v7AuaGJ0P9UyV9t4dYe?=
 =?us-ascii?Q?a/AvaGIlFBMzNHrLQL76quQY3jLr4yvziWw8wgddyAe9hXvru69DMgQP95cL?=
 =?us-ascii?Q?dGkSsisUUHor2cVe4ZJOScsm6qKBy15Iec7/WxJqkObeddwoTtwE3W3TCpEC?=
 =?us-ascii?Q?CdcPtzuzT+wzhZ1mn2kkqyNP6w4a8+WNlxcsj1xNonFh3p6I4mIIvoZtZd3Y?=
 =?us-ascii?Q?OFBB9cC9e34f+TQLnAgNmKLKrBm63DoEJH4SEkWQw2Lg3e04GsrIQhgrj/at?=
 =?us-ascii?Q?L+x4W0B5PieuF7JQnr4fyF8hO68Qilsyq7UNiEGQsWhKgAnz/qzdqBWziWKr?=
 =?us-ascii?Q?gYTWNEnKHVGUuhGS+iT+rpsLlsDr7DtM3WWXYQMb4jCsXEHTOPF6l9Jsjx/Q?=
 =?us-ascii?Q?U3sRJj7N7hALu04pu6RzLv8iQl3Fi6V5EB+eVn+03tgvF45W8tPsJ6q3mwT0?=
 =?us-ascii?Q?pq6ZHX7MjClr0G9QmQXlv8vyxDMGcgaDTzaXWzNpjkHlR/vQt/0lp/zVpMfN?=
 =?us-ascii?Q?jQGpZjyNj2psyusVbvlhNofq8OBb4nKREaao?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:50:00.8427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177b820b-9975-40f5-6c1c-08ddef64b762
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538
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

Add gpu metrics definition which is only a set of gpu metrics
attributes. A field is encoded by its id, type and number of instances.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Add unit field and change encoding to 64-bit.
v3: Fix unit encoding

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2f7e4b5bebf3..5538c7c671d3 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -528,6 +528,110 @@ struct metrics_table_header {
 	uint8_t				content_revision;
 };
 
+enum amdgpu_metrics_attr_id {
+	AMDGPU_METRICS_ATTR_TEMPERATURE_HOTSPOT,
+	AMDGPU_METRICS_ATTR_TEMPERATURE_MEM,
+	AMDGPU_METRICS_ATTR_TEMPERATURE_VRSOC,
+	AMDGPU_METRICS_ATTR_CURR_SOCKET_POWER,
+	AMDGPU_METRICS_ATTR_AVERAGE_GFX_ACTIVITY,
+	AMDGPU_METRICS_ATTR_AVERAGE_UMC_ACTIVITY,
+	AMDGPU_METRICS_ATTR_MEM_MAX_BANDWIDTH,
+	AMDGPU_METRICS_ATTR_ENERGY_ACCUMULATOR,
+	AMDGPU_METRICS_ATTR_SYSTEM_CLOCK_COUNTER,
+	AMDGPU_METRICS_ATTR_ACCUMULATION_COUNTER,
+	AMDGPU_METRICS_ATTR_PROCHOT_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_PPT_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_SOCKET_THM_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_VR_THM_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_HBM_THM_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_GFXCLK_LOCK_STATUS,
+	AMDGPU_METRICS_ATTR_PCIE_LINK_WIDTH,
+	AMDGPU_METRICS_ATTR_PCIE_LINK_SPEED,
+	AMDGPU_METRICS_ATTR_XGMI_LINK_WIDTH,
+	AMDGPU_METRICS_ATTR_XGMI_LINK_SPEED,
+	AMDGPU_METRICS_ATTR_GFX_ACTIVITY_ACC,
+	AMDGPU_METRICS_ATTR_MEM_ACTIVITY_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_BANDWIDTH_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_BANDWIDTH_INST,
+	AMDGPU_METRICS_ATTR_PCIE_L0_TO_RECOV_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_REPLAY_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_REPLAY_ROVER_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_NAK_SENT_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_NAK_RCVD_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_XGMI_READ_DATA_ACC,
+	AMDGPU_METRICS_ATTR_XGMI_WRITE_DATA_ACC,
+	AMDGPU_METRICS_ATTR_XGMI_LINK_STATUS,
+	AMDGPU_METRICS_ATTR_FIRMWARE_TIMESTAMP,
+	AMDGPU_METRICS_ATTR_CURRENT_GFXCLK,
+	AMDGPU_METRICS_ATTR_CURRENT_SOCCLK,
+	AMDGPU_METRICS_ATTR_CURRENT_VCLK0,
+	AMDGPU_METRICS_ATTR_CURRENT_DCLK0,
+	AMDGPU_METRICS_ATTR_CURRENT_UCLK,
+	AMDGPU_METRICS_ATTR_NUM_PARTITION,
+	AMDGPU_METRICS_ATTR_PCIE_LC_PERF_OTHER_END_RECOVERY,
+	AMDGPU_METRICS_ATTR_GFX_BUSY_INST,
+	AMDGPU_METRICS_ATTR_JPEG_BUSY,
+	AMDGPU_METRICS_ATTR_VCN_BUSY,
+	AMDGPU_METRICS_ATTR_GFX_BUSY_ACC,
+	AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_PPT_ACC,
+	AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_THM_ACC,
+	AMDGPU_METRICS_ATTR_GFX_LOW_UTILIZATION_ACC,
+	AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_TOTAL_ACC,
+	AMDGPU_METRICS_ATTR_MAX,
+};
+
+enum amdgpu_metrics_attr_type {
+	AMDGPU_METRICS_TYPE_U8,
+	AMDGPU_METRICS_TYPE_S8,
+	AMDGPU_METRICS_TYPE_U16,
+	AMDGPU_METRICS_TYPE_S16,
+	AMDGPU_METRICS_TYPE_U32,
+	AMDGPU_METRICS_TYPE_S32,
+	AMDGPU_METRICS_TYPE_U64,
+	AMDGPU_METRICS_TYPE_S64,
+	AMDGPU_METRICS_TYPE_MAX,
+};
+
+enum amdgpu_metrics_attr_unit {
+	/* None */
+	AMDGPU_METRICS_UNIT_NONE,
+	/* MHz*/
+	AMDGPU_METRICS_UNIT_CLOCK_1,
+	/* Degree Celsius*/
+	AMDGPU_METRICS_UNIT_TEMP_1,
+	/* Watts*/
+	AMDGPU_METRICS_UNIT_POWER_1,
+	/* In nanoseconds*/
+	AMDGPU_METRICS_UNIT_TIME_1,
+	/* In 10 nanoseconds*/
+	AMDGPU_METRICS_UNIT_TIME_2,
+	/* Speed in GT/s */
+	AMDGPU_METRICS_UNIT_SPEED_1,
+	/* Speed in 0.1 GT/s */
+	AMDGPU_METRICS_UNIT_SPEED_2,
+	/* Bandwidth GB/s */
+	AMDGPU_METRICS_UNIT_BW_1,
+	/* Data in KB */
+	AMDGPU_METRICS_UNIT_DATA_1,
+	/* Percentage */
+	AMDGPU_METRICS_UNIT_PERCENT,
+	AMDGPU_METRICS_UNIT_MAX,
+};
+
+#define AMDGPU_METRICS_ATTR_UNIT_MASK 0xFF000000
+#define AMDGPU_METRICS_ATTR_UNIT_SHIFT 24
+#define AMDGPU_METRICS_ATTR_TYPE_MASK 0x00F00000
+#define AMDGPU_METRICS_ATTR_TYPE_SHIFT 20
+#define AMDGPU_METRICS_ATTR_ID_MASK 0x000FFC00
+#define AMDGPU_METRICS_ATTR_ID_SHIFT 10
+#define AMDGPU_METRICS_ATTR_INST_MASK 0x000003FF
+#define AMDGPU_METRICS_ATTR_INST_SHIFT 0
+
+#define AMDGPU_METRICS_ENC_ATTR(unit, type, id, inst)      \
+	(((u64)(unit) << AMDGPU_METRICS_ATTR_UNIT_SHIFT) | \
+	 ((u64)(type) << AMDGPU_METRICS_ATTR_TYPE_SHIFT) | \
+	 ((u64)(id) << AMDGPU_METRICS_ATTR_ID_SHIFT) | (inst))
+
 /*
  * gpu_metrics_v1_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v1_1 or later instead.
@@ -1217,6 +1321,19 @@ struct gpu_metrics_v1_8 {
 	uint32_t			pcie_lc_perf_other_end_recovery;
 };
 
+struct gpu_metrics_attr {
+	/* Field type encoded with AMDGPU_METRICS_ENC_ATTR */
+	uint64_t attr_encoding;
+	/* Attribute value, depends on attr_encoding */
+	void *attr_value;
+};
+
+struct gpu_metrics_v1_9 {
+	struct metrics_table_header common_header;
+	int attr_count;
+	struct gpu_metrics_attr metrics_attrs[];
+};
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
-- 
2.49.0

