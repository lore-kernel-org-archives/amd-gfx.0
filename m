Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3C9C5B552
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF4E10E82D;
	Fri, 30 May 2025 09:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vrMFqSKw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B7D10E81C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrA1eMKldcVqvLgQ1euAcgE+Laterjpzrt3Y0zpMpnXOqO8p1NB0fuNkzcjp7YmKdYEIbnY/zAzMRPGWbMQ5c7y+MWM7MfZnU2jKqozgu5KycPwoAbbcgPEiXWlED7jZgJ44kBR+V6Y7t/wyB7fdX2DOw0Gy1y3KkiArqPJbIIK3jjl4MrXudnecK7mi06t0kGmRPObdi00c1gBfXG4toMZUdpXV+6FYAkzy/E3cDmgTeYvcdo00G84Be2gbUTpp09Wtns7BycELUHzEhmUobaLHdxgoFRi7c4xrrdncQ8S9r8+IqxtzcgTO2++cIfBXozQuOMS3xaJIzjZVFX5nqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoH/bwEw14uDkc6nPLe14+AIcYc/DSpHLvi5goT/8xc=;
 b=H+mQNKo1a7W4VghUMxa6NvAmdOa4WOO84AMcscgRBXAa4zGr6oaFrUkncFtRVdrI+DA4ig8FhcbZhhne8FP8RcUY+NrDOSd3+Ei0kt328VnhYknzc+/4cBYfCugWeI4aK7ZZy5McdpmyLJsbS5oux7wZen2OT4yi2AUhStwpHqK3ETHkIraBhw5LQVtvuqUbes0OBT7d/28mw4mYplsSTbQM31xOFf2zZ+jTOw5LPdegxung/kMpsPy0CnBco3iCQT9wml1s2I5o4Og6KqKU4swO3CLK6Y2SzSNN8MKWMKcN2puL8UJk49rA/D9mfy7CohZ2j2nQgMkeKB6tbBOiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoH/bwEw14uDkc6nPLe14+AIcYc/DSpHLvi5goT/8xc=;
 b=vrMFqSKw8CiSR8dEzJilsP5YdN7BY4i3epOMP6NzM3MHbWibgd2pZIkOnXOo3ECa0zUJFjPvJwnKnuwF/UB/b3YUMWDxxIjJE5YavngBZdPCLqk2BuI6B4VVHRD3PNYKtFewDNYlb9XT5PGxmWA4alyaEF+ODWd9JitrGlvI8AQ=
Received: from LV3P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::29)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 09:04:25 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::dd) by LV3P220CA0007.outlook.office365.com
 (2603:10b6:408:234::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Fri,
 30 May 2025 09:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:04:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:24 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:04:17 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 09/14] drm/amd/amdgpu: Add hang detect support for MES v12.0
Date: Fri, 30 May 2025 17:00:10 +0800
Message-ID: <20250530090322.3589364-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: b4883713-3fa6-4029-36e3-08dd9f58f973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xt9pjroRy9KyY47Ud8ObD+IUPiA3Y9g9FDVd05pHV+P7vcaZ2gDq1ufwWm5b?=
 =?us-ascii?Q?A3YPCRNbV2ddoJWYeVVhEcgabmZjbUs0rZ+qpxcw2L57Kw8NMqWRd9jRi2HD?=
 =?us-ascii?Q?Pk6m670eidqZ7Uo8gbi5AJEhgEyUbomr0183H2Jvon1+JFI5r7FkfV6NVl3+?=
 =?us-ascii?Q?4OqN7IvPoIKD6EtKT5A1jFfMFrfeNz2mVWW+lROyprXL9TONRda1cxGZHhtw?=
 =?us-ascii?Q?th77iVuAbjIHZNeq/ima9b4wO9BfnXMDFieWcyqQquqho6pbaGyO7BFpDHMO?=
 =?us-ascii?Q?vyz1agmvGaqqyqFevKpFXvV9hcB2zoJ0ZSj6bpK682naziHGH5RGWb+qeREK?=
 =?us-ascii?Q?B/3n7bWAVbks2SbloEWP1HoY/Bqhxtz27N4Z1CJzF8s1xu0cN9TyYo+g61FC?=
 =?us-ascii?Q?mc8Ep0Vr5SlOJtfzM7VF94C6joUP8Bf4z9OgpCADr+tMetpHHBx0ez5Zfumi?=
 =?us-ascii?Q?Gu+Z8MLSBE5XRTEiTVxU2x59ThefdsDAt2YGnE7JCfd5g6OR8BwyS+YxaWh6?=
 =?us-ascii?Q?oVVL4Olqnu7Y11j0YwkN5FNepKipPeJ5dJVbTx4FphQjqqfigvt+7r+UmV0y?=
 =?us-ascii?Q?AKhWTnYEIYUwgIoLdEu9e1Pk3P2tbyhwIB9zoFdzAUgnd+4yRZD7TY0u4PS1?=
 =?us-ascii?Q?jQ3H49Pm1Bey2FDxQHG7+hFywQo2psRAsTu8odeLVLVZ2pV6iERoRTKP1OgY?=
 =?us-ascii?Q?ZhzFozRTSTkeMrFPncm9R0XvwHb+WyJ3Ol4lGPQFkCnSDQSUhM/04zmhydIK?=
 =?us-ascii?Q?CQSADUR85Wu5fgoLqoAL2IIntTHAXlXqk1EOEyK4tmFWjg/pXUwm+vuIihqw?=
 =?us-ascii?Q?0+0xUBx+EjCH3qVaugKkwRRr1ZCx0QW+ZigQ0zQOkfHBVW28FTdkd2UGiomU?=
 =?us-ascii?Q?UeZOqx5oFpzJZz2YHjpNnmilK2/2a3RbsJ5nkRJJzAArEowZBWdxCcedksHN?=
 =?us-ascii?Q?/MzCV/vB9oNALgbgrT0+YW0jVOX0hFBaX0rb5Q/ZnkUFUQrGyoy1ZEe+2LDF?=
 =?us-ascii?Q?CWs+3wmhxqscnn520e12NEmOjuWtObDv9aHH/vSG14mpFdZhmaSy3wsxPLVf?=
 =?us-ascii?Q?9sqYN11GYlRi3KyE7S/66+/dDaDNIf7kkJqrtJH3PkD0VXc7Xf2QYFvjbIYd?=
 =?us-ascii?Q?gL3TzwsfUGT+C/X0/BlbBk15xtI1tlkB0rbH24l6TIo2G5HZPj52zoWGA+5x?=
 =?us-ascii?Q?bOOWWdJk2MWz2a3QKyptx4qGEnsOe/LX77TnchFK97uLbK0ZlEqQeMVey3Ix?=
 =?us-ascii?Q?yip6t9QtNKcRQWmxWN9HK8gHl4uFSnKgh53xnlZiFWyJ9vQJxc8zEcMVj/dM?=
 =?us-ascii?Q?3Lzq9Il4ffTYwuDiCmeheJb4XUD+EeClLLYBplhNvQwTlIZV3cLxhaip0eGE?=
 =?us-ascii?Q?cjLk0uesBcWJrnuM1MTyszYDj8eLYtsMwRZr4qlj+4suEZeboGu9fRUY+4X5?=
 =?us-ascii?Q?QYSArCzvWh8AlzXOPc/VntYGXKueyR+/qJOCiEoumnP+o91ovdneg1dbV3uO?=
 =?us-ascii?Q?2WOA1hZN2tOz8Ow100XwiDf5MGalUTW5goBZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:04:24.7066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4883713-3fa6-4029-36e3-08dd9f58f973
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
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

Adds the hang detection path for GFX queue resets in MES v12.0,

The change implements:
- Handling of the hang_detect_then_reset flag in mes_v12_0_reset_hw_queue

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index b4f17332d466..f763f91ff9d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -864,6 +864,9 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 		mes_reset_queue_pkt.doorbell_offset_lp = input->doorbell_offset;
 		mes_reset_queue_pkt.wptr_addr_lp = input->wptr_addr;
 		mes_reset_queue_pkt.vmid_id_lp = input->vmid;
+	} else if (input->hang_detect_then_reset) {
+		mes_reset_queue_pkt.hang_detect_then_reset = 1;
+		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
 	} else {
 		mes_reset_queue_pkt.reset_queue_only = 1;
 		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
-- 
2.49.0

