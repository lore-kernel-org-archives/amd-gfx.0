Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E90DC0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F264F10E91D;
	Thu, 30 Jan 2025 09:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dbjYz88S";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB2510E91D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecOfC9dVf8swNLPCbqS1XcDoLRfpSIrVXcubOK89yNQPbotdIf1VdJV5A8kJ8/Qah626HNJlO05SUeTkYf/g8QWHnqIdCUpl/DYNKTgymqlD1r2r/LMEqUxIeQYJhzo7jmOC/lJhT3SI6H4rEzQuAuASc5u315pzii8XjoespLvnl1b7IeTDVnRUjDmXRZLIeKRhQD54hRJE6Xrvvv6kOCG0nsxOCQkMOnhEndyabOb5Y5jTwyKWFM7uQDhUnj97LyJ7q0Ncqy6i3vraNfwIssNwVIvKnS0DZlZYTYMUACbSOBugpygvmShh4i0KpNl6e5XFKjDXadPjFo4ExbudMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZS5YhdSPoBzBhJJgIQdn58syk0EXc+zP4mDI7Ei2e8=;
 b=qP9v1xCtB35OIimXyVbPFXbotsytFPjLTleLWUZCqW1me41uAycZi2ijrSnRgsQN1Ooi0LfmBUBL2Ta4TJMBh47ReqNCNzoVgWvYUXtbLvnHFIJul9qmtxpLr0L51IcyJ5CO//pkAGQwptGQkq9KWkE0O7Z21Rpl6ghs6lj55gcQ0JLV0QIBp6whi+6Pk2EnEo82YAL03PAynPzq9xFTG5mNL9JseIkvlr3Z9HiMvVvlbfiYgR80xs+iTxqn8OWgQ+f1FgPW51oMLmA9hDBrA23zHIaXM2GVTJaRzrUzCtzKgcI9TzoL9jm/9pLkJiGDUMZpLAPo7CAhszE23H6F9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZS5YhdSPoBzBhJJgIQdn58syk0EXc+zP4mDI7Ei2e8=;
 b=dbjYz88SuJHQP5eVBijK2aYAO/g6EXxkRVyAXjv8CyRR9hE2eU/zYcaApmb9k5B8uM/dQw4/qAgkX0mBAe+/1aHccLrd3vaVMbH7Xb2zSJQRm4Sb8Twy27TeUFj4hDph84n6HmW5R/EDKT533QOU16p4NxNsAmQOmRKM42C+Z6Y=
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 09:54:20 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::74) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 09:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:54:19 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 Jan 2025 03:54:17 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v3 10/10] drm/amdgpu: Enable devcoredump for JPEG5_0_0
Date: Thu, 30 Jan 2025 15:21:13 +0530
Message-ID: <20250130095113.534630-11-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
References: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: a8237d31-6046-48c8-af47-08dd41141127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG9YZUYwVlNtZk9oa1VqYUNFQU1aNWJXVmdZYXJrSGQ2dmtmOEtxa29yVG9D?=
 =?utf-8?B?aWdwUzBzeGF3NmxicVJ1TkhaK25iOVhvblV6cU5uL1ZNN0NGckRCMFJOazBM?=
 =?utf-8?B?a0czMUN3ckpWM3pMNmdqckY4MFQ0aFhBa2ZSbUJ6NHVxdm5SaXpOWDloZW5O?=
 =?utf-8?B?YmNMVk01ZTBsdGVOeE03Y1NGRXBacndTWWd6MllTR21yWVFuSFZNdVIvNVJO?=
 =?utf-8?B?dFVyOTV4N0JvOFRDWnI4ZTdCUlVZaUtMS29PM0lIQnNuNGFSSUdsYi9FcWcw?=
 =?utf-8?B?ZU5rUnQ4UXYxTEtWb3Fwdjg5Q3BsUEROTkVtbzRBQi9iSTdvZlBlZzhrU1B0?=
 =?utf-8?B?Y3RzSlNmWUs3Yk13YTVISUx2elRRaHhvL3R3ams4U1pZUUw2bU81YllZZFpv?=
 =?utf-8?B?ZGRJdHBYc0NWb0NZcVNEZERjUUtyWHNacno1Skdkc01Qajc1SUswMGQ1OWll?=
 =?utf-8?B?YlN3NktFNk9TR1M5YTVpMjdhMWV5aGVnYUtyZURBSFJaNHpCbDFDejlTMmtU?=
 =?utf-8?B?d3MxOVZNNG53MU1FWm1rNzBLVXh3ZDVwOGZXa0tjWW8vdytIcFZ4dVRuaXgz?=
 =?utf-8?B?TmQ3NmhvYXRzMW9zWVRCNzVnZzFaQjA1VzZIcGx4VjRiNklBMTZxSWNsb3Zw?=
 =?utf-8?B?VnhseXpGeWlPckYxSWxDL05RV2x5QU51bEhlUjd5djJIektyazNJbjJFcWtO?=
 =?utf-8?B?TmxrZFlDRlZhVGZTMTY3TEJMZ0Z5OVFubFgzcUJRN3oxWU4vVWVNY3VPMVhY?=
 =?utf-8?B?MkZUM1dBc1lXSWR1NTRUWjlWTmo4a2s3SGVsbkhudjlsT3FxT2wrV2l6d0ps?=
 =?utf-8?B?OGtUM0lpSVVMVzNrMTR6ams2RGovUk5KKzMvbkJUUWVDSE9TckNTZHEyc1NM?=
 =?utf-8?B?THpPR1JQQnhwNWFZeFR5TEdBNU84ODhURG10RWN1Y3JXcmkxYXY3akFidWxk?=
 =?utf-8?B?S3BZNm4xWHpUMHVkQTFrZWZOTGdmT3dvRDg0UnhyWEVUaXMvdkw5bTdvaEZ1?=
 =?utf-8?B?NXRTa3Jmc1k4UEd3eXVQUkZaYWhVbndJRU9PV1NtK1JjQnBzckVCdk5HcHN4?=
 =?utf-8?B?ZkY4N2NPMWJtaWlwclJzQlpXYWh4RFpzeS8zZURENXpFaFF6RUdha3dTRjNi?=
 =?utf-8?B?dit0RXp2alBtU1hBMVIyalZTNjQ5eG9vMlJJSXc4UkRvcERJRG1za2VWL2R4?=
 =?utf-8?B?R2NXVDJyVFVPbm9HRjE5SDFlT29Ba3g4cDdQQ2tlaHZwdEN1RHdIS2djU3dp?=
 =?utf-8?B?S0xKTGhjQlY1TXFWSjRwdTcvM25ReCtsVTV6b3ZReVlYVHpONU9oblJGU3oz?=
 =?utf-8?B?MkVVbFRhTmJYN0lpUlRyMkFqWW5aODlQdFZRdVJJMjh6K044aE9ROXU1Sk1I?=
 =?utf-8?B?eGZHT2RGUHNlZkVYKy9tRS92MlAyK2oySTlkc1ZtQXJ1Q1hhKysrcU5HaE5r?=
 =?utf-8?B?T1pyTGRtRFo3TlI0Q0NncnA3VW9zdDZpOS96UmFBdFdwamtQM2pEZEhUOWN1?=
 =?utf-8?B?Y2paTStVa0xFdzBOOGpZVE5ucXhMYjJjOHErSXBoV0o4L1JEZGoxWWFka3lt?=
 =?utf-8?B?ejB5YXYzOGlPRnJQbURYWStCb3VzN0pubGI4S25FNlBkZHltdGRLd0FoLzUx?=
 =?utf-8?B?N0RvN3RuQkhVUEZMSjdZVEhucTg0bUNEajM0SHd6REs5enNaN0d3bkg4TjFn?=
 =?utf-8?B?TTU1OURCZ1o2OEhWWXo4L0haTEhSTEhaN0xHbFJyRjFibEhkbk4xM2U1Y0VL?=
 =?utf-8?B?dGpoMnN5MGVjVGlYUDNTcnY0QkJKVTh0bEVaZ25xbzFuSmp3ejFXdkFnR0tV?=
 =?utf-8?B?RzVjVkFCczlmdUNWejVHclZxaGd1M0xYMnR0MkdjRnFiWWo2QWNmS0VlejhS?=
 =?utf-8?B?T1hvejZpK1RmYzhWc25LSkR1ejJqR1N4THNiVWVPVzVMK2tlRFNCTStVdUxI?=
 =?utf-8?B?cWxoT2VJOCs3RnpiQzRnN214d05rUlpzTUxQaEJWcnZHREVxaTM0SDNIM29w?=
 =?utf-8?Q?9TTMUO1y3+aZsOA5zsQ+V7jGwSFtrA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:54:19.7724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8237d31-6046-48c8-af47-08dd41141127
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
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

Add register list and enable devcoredump for JPEG5_0_0

V2: (Lijo)
 - remove version specific callbacks and use simplified helper functions

V3: (Lijo)
 - move amdgpu_jpeg_reg_dump_fini() to sw_fini() and avoid the call here

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index d5cf0f2799d4..4a55e0cf39e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -34,6 +34,22 @@
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
 #include "jpeg_v5_0_0.h"
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_5_0[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_UV_PITCH),
+};
+
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -100,6 +116,10 @@ static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_5_0, ARRAY_SIZE(jpeg_reg_list_5_0));
+	if (r)
+		return r;
+
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
@@ -637,6 +657,8 @@ static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.wait_for_idle = jpeg_v5_0_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v5_0_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v5_0_0_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
-- 
2.25.1

