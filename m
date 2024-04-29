Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8368BC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA01D112D13;
	Mon, 29 Apr 2024 15:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zRVf6TZI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660F910F40D
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3pLgw7YpFy7H+Wo83MFkdsgOCbSzsvE7P6AlIGFZwg7WEm+ESDVk0PvORp5GK7GmOiylWWUk0qY3egaUURDk+9Us9J1QZIOtFhJ8+uEcEWpMg75/31NHjcS3HENMnlh0Tf5r+yV7I3i7zvtabMDLhgeFXZcsHASnDLgi0yTG00VIK/5EpQXPpofKV5Y7ZeWO4ieKa292fU+23Ptbkb1WjgX94ii82K78CZapzZfK45glzKs5pvHUnICqethQhwRP8RReiKhL9Fkj/qSqNOFGsAVwSGZNOvlVFucNi3x7MGE5L7nw6YCj3fhV1R4mMNJw1tTvS8hX5oLLGKkc5Pv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChEUQhFpWMF37Frv6esRGW6V49pbDWW78JE8M1bHDqw=;
 b=IIF6Ug6f8TuqA5s1/ZiBiAas5ecUSb8byYRZVax5nIS5vKOUAH1rxhA2el0Lnibp5nHOPs6/2HsLvLUfV1NzdOMwieneZtYPo/n5Y5lLInXK3vLpIPi8v7Xv9986iRGBfa+dp8hRUtLdQV+k2dxtiQ0J+TRkXYlIe+t/YXqaPSK8A/RV96Z8rwVDnCsvtddHdTNBVzapDztfhUC9Vxr/CcmsJVg92jMwyskSHWGiLKIowVHxnQe4q8zkLlSHhyLaPzCBpyNRsB6P2kA96dqol6FGwA57kBMM3TFsaMMHC7vJcbiAJ70CF2YRePisq402MTyWySxMRZC8rI4o3FFnyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChEUQhFpWMF37Frv6esRGW6V49pbDWW78JE8M1bHDqw=;
 b=zRVf6TZIsfURoMfYq9pQXr4ndYopFcEZxrZWTm9wX3iQrPI+tkzmKcFZSPiwmylBVphRcFyXZ7pK9ryXbqcaOwhv8fMGoQKacyteLgjzm7VS3ywQLynrrGHA7wyT0b60Fy2l65QbTd3g/p3oiEQiZqCHjJgwa1rb+XapTGh99yQ=
Received: from BL1PR13CA0201.namprd13.prod.outlook.com (2603:10b6:208:2be::26)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:12:41 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::2d) by BL1PR13CA0201.outlook.office365.com
 (2603:10b6:208:2be::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 15:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 15:12:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:12:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>, Harish Kasiviswanthan
 <Harish.Kasiviswanthan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/11] drm/amdgpu: Disable unmapped doorbell handling basic
 mode on mes 12
Date: Mon, 29 Apr 2024 11:12:14 -0400
Message-ID: <20240429151219.3466531-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151219.3466531-1-alexander.deucher@amd.com>
References: <20240429151219.3466531-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: b00a23f7-91f8-4bc1-f21d-08dc685ed09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?04uTTkZUNLoX2tql1AzxRpMdWY1espLS6pg5OPkFuugGRjtGz/sf3B/UDUIP?=
 =?us-ascii?Q?sboPL/zAy+Uk43DNCIRqcxavbfrb2X/FANEK01Br2gTWiBt8+bOMztJ+bZmB?=
 =?us-ascii?Q?OAGgvlDGKxUZDSriw1F61NUU7scgymkrrKjTXtdyf4IBG85xG9WxmVfeWjmi?=
 =?us-ascii?Q?DdeSr4B1YuYCQmUuAJCQDZUw5R0BNsvWV/GKUkQxafo++sppVUO2evCcuVlJ?=
 =?us-ascii?Q?PuP6JXwGeD96WeYxcyFwvyn7zGLcEdhBmpgu6B7WMZjIbeA41tjvzajAMnMQ?=
 =?us-ascii?Q?RRRAa1M8nq+mEPcW67om5rd5SZKxMWcq0pd4jk6FzeuflUj2LouQDgp8qUio?=
 =?us-ascii?Q?vXxcfVE8c7DbQ9A4Z7miBv1EWnh+oK6GsEsXk2Xfrzz7FP5l5z9HvXWEFN4Z?=
 =?us-ascii?Q?SRITYbJneLpDnjSOgMCqOyVUABsGgyYcXCAEB4nooUG8Is0Q8dwkI73I1Szi?=
 =?us-ascii?Q?nXjngBkAKijnxo5jBFGQICvn3xAAjsI2t+L8dcKgUgq0epkqxZA9gOZSgktb?=
 =?us-ascii?Q?6N+m2jJ6SHlikZ+EGiv6d6Mt6HVFERT9uXxjZDKeQGxv5xLkiFkZ5Ins6ncp?=
 =?us-ascii?Q?l95MTN9kQ0Q4ZSUoWqQP5lrBsIuKkbdnZYIFsnhA0g7TsaeELaOTAd0mxlV/?=
 =?us-ascii?Q?QbLySz2unOpQAezWeMLVQ0ulj3u5kxaM7nSGLKF++opGmFw5YFn0Cme6Db2J?=
 =?us-ascii?Q?VUTcL6CNHTWIUxaYVRRuJIiV8Ho3i5f08errHE+z/o5Qra92Ufty9Z/FAkT/?=
 =?us-ascii?Q?7/yNvJT0XpQ1nG7InKA/NcJJnRDyht/301tbYKQdjk3dx4mCcQuRzD2RGIO7?=
 =?us-ascii?Q?smjV/zbKEaaTlgYm8VeWl18/TLzwzDYqX8+qWNaFdYxxsuqfdQ5ARfl3yY9v?=
 =?us-ascii?Q?QWseB90DLwZ9IZ9faNpcHVmp1UcwNEnyAIiz4eu5E+mVCjibgbTrPUBpWSqL?=
 =?us-ascii?Q?G9Lm3LLk9cQ/9xL7sv3yv2hOBxW/OYegwgZqandouQz/xSuxa1hRssh0xn46?=
 =?us-ascii?Q?YwqJr2hugfxF4iVDangH7n0Qh0uk75wpVXPamMZD1tYRLF3p63i0dUkBXIFq?=
 =?us-ascii?Q?G0hJjI4CVQIHe0sMtPL89pEGoR+9RF5HgP2oZFPhiuX9anOpaCtgp6Xx8Dcr?=
 =?us-ascii?Q?LP+ei7BDMx+jBq8yqv4crmD+wa2Rk8NqYqMXB/qqbohXh30uxrVdYym/CUzb?=
 =?us-ascii?Q?j1jItqVLX/KLYIvEV5xU88hmqwxiqMTffFUAmn9YBuCmD49AWGwUnEm6c6xS?=
 =?us-ascii?Q?bcxTBDNM91OFaplQjvhJOYb/GX6KUMgUuARbGUl0jgl9vEfqSy/yMsr+nJ8P?=
 =?us-ascii?Q?4rYkUGXeO0NVgA6l5iaPxxZeouDtPolpLrRso5N00ObJPbt6rMUpt7aenmIS?=
 =?us-ascii?Q?5lpB8qgF93P0TjNTvWkkwLfvA990?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:12:41.4769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b00a23f7-91f8-4bc1-f21d-08dc685ed09b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
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

From: shaoyunl <shaoyun.liu@amd.com>

The new mechanism for unmapped doorbell handling requires both driver side and
MES fw side change. The FW side changes are still not released.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Reviewed-by: Harish Kasiviswanthan <Harish.Kasiviswanthan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 16 +---------------
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |  3 +--
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 132868b8db198..cf6dea13cc955 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -422,14 +422,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.disable_mes_log = 1;
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
-
-	/*
-	 * No need to enable oversubscribe timer when we have unmapped doorbell
-	 * handling support.
-	 * handling  mode - 0: disabled; 1: basic version; 2: basic+ version
-	 */
-	mes_set_hw_res_pkt.oversubscription_timer = 0;
-	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
+	mes_set_hw_res_pkt.oversubscription_timer = 50;
 
 
 	mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
@@ -877,13 +870,6 @@ static int mes_v12_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_iq_timer = regCP_HQD_IQ_TIMER_DEFAULT;
 	mqd->cp_hqd_quantum = regCP_HQD_QUANTUM_DEFAULT;
 
-	/*
-	 * Set CP_HQD_GFX_CONTROL.DB_UPDATED_MSG_EN[15] to enable unmapped
-	 * doorbell handling. This is a reserved CP internal register can
-	 * not be accesss by others
-	 */
-	mqd->reserved_184 = BIT(15);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 2cdecf937acef..81cc0a5540492 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -238,8 +238,7 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t send_write_data : 1;
 				uint32_t os_tdr_timeout_override : 1;
 				uint32_t use_rs64mem_for_proc_gang_ctx : 1;
-				uint32_t unmapped_doorbell_handling: 2;
-				uint32_t reserved : 15;
+				uint32_t reserved : 17;
 			};
 			uint32_t uint32_all;
 		};
-- 
2.44.0

