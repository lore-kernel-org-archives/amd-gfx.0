Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCA0CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 21:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CD610E188;
	Fri, 10 Oct 2025 21:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nmZOWcLM";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3746910E16D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 21:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Irrjb/oNaPQSyHp2xx8+wIUzUvpmkVgDSqEqLDMVPldAmWPp+mqNWR6Eaa8NaMwDfoB3qkerkJWSeQgxB8GQy/a7277baBFZaUKKP0EUvBEuew4gyLlptQvaFuA/QUxdoks+ZKNAE3QgMAkcz7TVXQjn/Dh/kCpitC/jHxunzIxJVx8YgZ7Zwk4Il3n/bBQPFeVYfg+VbwH6XSpfxDs0iTtZF2x/tM6iVafQ8SH/Nkd00LPFqOn4MwvHCfZRnMOwDMPp2X8COZHQzF9T6+Dd8zlHWknPLYCtjyrqnGQu37ZX7OE6glw/OPGMfL4XnkI46dXTcHZMP+0MOQ2F1rsy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EW3LOGfezlscaZKYjdGpKrog8Z4zNW3OrQis9j5ojY=;
 b=y8PQh/acKJeshGKplKfmKoAkA+1Rsc6mT4+tj9LFgL2qQmgCJF0BEIAZNbcwCS/hpNa7uKaM5JoRxokR+e5zOMpV7TZFFpUvoi+Ru6/dA20+2SRj204FUP0U4hZVRe+q0OP6T5G1AieOFOaOpiUXtxtXfuec2RILLh5+woCuCd2OrlP2rFSNwfpH0ukMf7rOT+DrtSqXMTTayjgXhJESCHDHyp/iWnBbJW4HpvMiLVG5PfJ+yWNsl5rgkEKEf7NbJlQZoUeYyxdL9187VprddqiVis/MQIdwQZdej7SBUSlyilldybXF7emh20UJ17+yTogiq421uJNG40/Z/m29FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EW3LOGfezlscaZKYjdGpKrog8Z4zNW3OrQis9j5ojY=;
 b=nmZOWcLMshhLU6nAtdnicE0AKE/16IaoPXixtko+6VBHE79yqdHQ3tl3tdaUfpJX5vjdgT4Ko1ZPMNJfu82bVNO94Mym8BSoA2ReBowCOObha/VsW3yFGGffxyYxuBD4qanlZ4N+m5BEu54HWxsKnw5tBhWOG55V3G9SsTM+k3A=
Received: from BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::11)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 21:15:37 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::6b) by BN9P223CA0006.outlook.office365.com
 (2603:10b6:408:10b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 21:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 21:15:37 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 14:15:35 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: drop unused structures in amdgpu_drm.h
Date: Fri, 10 Oct 2025 17:15:04 -0400
Message-ID: <20251010211510.1528572-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 0346b481-9a20-45a4-185f-08de08422875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hea7W86V4789hEdmka7UN+sQLcUhDjIXQ599mxdlj0lE6fXaKSdb4U02Op1g?=
 =?us-ascii?Q?vIYuYxpxGRIkYNZnDOiShf8k3xJri8o98BooxjPDmf0WKWbDEAQtdhH5NTXr?=
 =?us-ascii?Q?kR7/fFpMncLo6Y3WGAf9T9aoq/MOGemY7ks0RVM4+aQ+9Uxtw5KuIIkKpL2R?=
 =?us-ascii?Q?qY4uRuIFQVEEzPXIQqAq1cJip0F398+UrvVnXodtYKfk9wbAWsSTgwomeKBY?=
 =?us-ascii?Q?77Mj2O1eLk7uVy3gGScS8BssPt5YIdVd8crawQDNAXha47UHjI8n+ZB2shsI?=
 =?us-ascii?Q?fYHPr8jzPeHI3p+AejzFl4cuRC9AZDKgkwdwTARxrMIHaCDNaT+VsnG76jI8?=
 =?us-ascii?Q?1A5vP5VZO9fapG9WdP7yJLDsQ9MnqCldlwIu22pjhA4esu4PMc0PPBWziS9E?=
 =?us-ascii?Q?IgSfzhg3wWIplO7mCxfLy6r3k10OPH8HyAnbqr1HP4iVcG6UUj020A+FDsbg?=
 =?us-ascii?Q?LagvSjm9rG/+VGIJpcmOFB3+5bBy2YjUjIMWsaCRSw09hTthIVUs0YNCGzY5?=
 =?us-ascii?Q?07VoIQysX7uxk76aK4FdIEQn7xe69ItDzW648XbE0Piah0RC64xQXHlXaeRU?=
 =?us-ascii?Q?yYd5+cucqSIpry/NDGpFLUnlE6eRF+4htFzjmvFiTXg+QQTfJYcdr9N7wL2I?=
 =?us-ascii?Q?2QvXI+D3mFue+0X5KNsEjMsXY/cHQpl0aC0hL/hXx3XkxRhK0t4OKHcHj6hL?=
 =?us-ascii?Q?d9dv+VHzKo68HCKKcgk86yG+h/Jg8kMTrtRxrNM7SC9SOt5HbNcOZPS+tNpi?=
 =?us-ascii?Q?wXHMKy8TwzUwqUq6VXpc3QaqmXl3xJLnOMAeoYeZNOQqZkKwbZtO/9KYZVQ1?=
 =?us-ascii?Q?//DfsXhfCDJKbXF1fgkvdfa9ffcmJ6L3NrmZYuuThqpvxR0WLO4S5I16GPTU?=
 =?us-ascii?Q?07NonUYXVjqMY0dP3oBq6kt0igNGKGoJuuqgytXTQz63KUfVpFYtH/7bZVPx?=
 =?us-ascii?Q?1CnK6pjiVNvuM6WmMYW1HHzdFbOh6eAKaX3Rdd+/JZkolYof61PALv/sxH1P?=
 =?us-ascii?Q?yHexfgrScLL544dvvdCjGQwB2e+dXQ68zAByz3Lg+Kv+D6qVvXiop3eYaj1y?=
 =?us-ascii?Q?xDebLmd98ciJjbadpc2KoQG35VVR721FASdVoNhHnUtKsG+NLx7RmBxmXvAp?=
 =?us-ascii?Q?Y4xYD5N/8yd+JNNrHWmJX3gwvmoK8ncacuA+Ci7xXopynMLK68c1SMlOMUoq?=
 =?us-ascii?Q?tylvctg6PGgS2c00wsyD60fU8+eZp5Euea1Uuo0F8LEKTFqtZ6PdESeumpKk?=
 =?us-ascii?Q?Ol8woXNZ2Le0bGENRX0zSl5hB5IAHzcb9cwqK0DW+ZrGtAqvI5o/cB00jQl5?=
 =?us-ascii?Q?/cSeu13ly4ccN92NLOIr5ZwwyGJC9Duu0Z8eePtXdkCFPm6ieZg/QsJDACXp?=
 =?us-ascii?Q?+h2Uy9iyHkSgcwUW3Z3H5fotW9685RWf8lgMubpMunuAjuBV8MV5UV+kyhWX?=
 =?us-ascii?Q?OmVW2hJYZ245K5sOtpKWTr2kGl/WOxCxco1igHfjjdUbv2OfP8PeOc2ZphdL?=
 =?us-ascii?Q?XAKHs+uX+zIuQO06efdYXo8FjXOzQ6GQMDLi1a2z263PxnYrm15sgGU5ZkQu?=
 =?us-ascii?Q?cdx8TH5ql4abmS74LE4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:15:37.2346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0346b481-9a20-45a4-185f-08de08422875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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

These were never used and are duplicated with the
interface that is used.  Maybe leftovers from a previous
revision of the patch that added them.

Fixes: 90c448fef312 ("drm/amdgpu: add new AMDGPU_INFO subquery for userq objects")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3cb316ad54b34..e5252bf597b36 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1564,27 +1564,6 @@ struct drm_amdgpu_info_hw_ip {
 	__u32  userq_num_slots;
 };
 
-/* GFX metadata BO sizes and alignment info (in bytes) */
-struct drm_amdgpu_info_uq_fw_areas_gfx {
-	/* shadow area size */
-	__u32 shadow_size;
-	/* shadow area base virtual mem alignment */
-	__u32 shadow_alignment;
-	/* context save area size */
-	__u32 csa_size;
-	/* context save area base virtual mem alignment */
-	__u32 csa_alignment;
-};
-
-/* IP specific fw related information used in the
- * subquery AMDGPU_INFO_UQ_FW_AREAS
- */
-struct drm_amdgpu_info_uq_fw_areas {
-	union {
-		struct drm_amdgpu_info_uq_fw_areas_gfx gfx;
-	};
-};
-
 struct drm_amdgpu_info_num_handles {
 	/** Max handles as supported by firmware for UVD */
 	__u32  uvd_max_handles;
-- 
2.51.0

