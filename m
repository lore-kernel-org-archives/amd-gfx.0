Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3EA1099B3E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 20:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC4CB10EC1E;
	Fri, 20 Mar 2026 20:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZBSv11cr";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBB210EC1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 20:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jK7GTpPn4rxVe2ezw0l98CW3EVYKWnHIey3UzAIBa/pORcGD77d2U0v0VMTlUsBkIoghTfH23BVY2W+z14rvd0i7C2ru7fOQ26nvT8EzEOuQ/cWFnkxdYkFFtH2NQ726hWcNEMCKq7Ye7NgyfTT0O2yUGba7RFyZoDpUmgyZMBdeJocCl+OUlbkPk8D6RahvZKBTA1CTyRWi89x8uKH4+BdaZD3QtRVKLhWji39nqF6/nHGG1djh2f9ji0FBr6VSxzJVOWp65ST8kVTlDLD4vYk4YpsAM/WxNy06qc3Pk1jfaCAVZmSPs/LivdK8b2eqh0NfHN0CSGDvpEvTAQ0Odg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIN0ysqR7hLVQZ5VqLWKwiGW9ChhvIShlMDKcne0z+E=;
 b=d691IRYDfuF/v1lQ4SnqLguBt22/3gSmF3ABYWaOdpb4l/S3y5BeEiLMIB7yufNIXAw/Le8ycnwgnG9tB6Jzwa2M7qLMoFe+l/B3+CAQUMtCAQ1mB47djApOjIP0tOQFsHzz1FP3wwZWpExch5VDtlGk+vL+QJwkkrhIxfP/W6VIBYm2lV1UMjtUEGb699mYqSjk0Z7tTLFQ3k8FVis9WAAygCoVqDYwUiR/Vn8Y+zVGcZPps6ryjDcIih0B5vLc6H8Y6XyMrkwkhF5SvBIEnMPXSHou2KtAvY5K7ulLDhR+akMHjyQDiJdbO6ERDlyCxB1AOCpS9iR9JUEy3rt9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIN0ysqR7hLVQZ5VqLWKwiGW9ChhvIShlMDKcne0z+E=;
 b=ZBSv11crd05j+V1jNGhJQJx2+ylPdCE+Qno1L8supGfZGgJd8d/gQ1TXaubCiw+qmvAcoSXpN7ZyQbqpgtOsI0OtwVbyjeKKHeOV7RrPI8Y7Xr2G5nDHLa41etV8q189DWfvQsGnUTQ8U8ooeJ32BzIhcE05iKfihbIWsl46jhE=
Received: from CH2PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:4e::21)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:02:39 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::a) by CH2PR02CA0011.outlook.office365.com
 (2603:10b6:610:4e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 20:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 20:02:39 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 15:02:37 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: Enable suspend/resume gang in mes 12.1
Date: Fri, 20 Mar 2026 16:02:06 -0400
Message-ID: <20260320200208.1188307-7-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320200208.1188307-1-Amber.Lin@amd.com>
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: f472613e-8f03-4e13-73a2-08de86bba362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UphU6/AOB2t3qXRSz8h5WlqTsxiRcTEm+DkkeF2CQ+49pKdWjbQEtDSPN2p7dLtMpF/42+n6DgzJNVXppcYpkPHeJDMqvREnhXzBwGZUhLWwQq/BVwJT1gKfNEN8E1ONkFs2eSsEvAPaJWyHkp1K9q9O8/SAXby82OOXlJyPp0IJFpiJVWvwkwM8xlek0inbAVv0jFOI7B+05hIprlGAl/7GmVXCJfY1xJCg+m4fOndqQlx8P9lhVs5pwyo/qDTyAjgsD4tnWy+AmsWJNkSIrzhIpop+Aaev/uXno4ZA+sGokGVVYGhpRxzPt/tnPS4oQPRGnVSPDOgdggKf5lLE8Gmxh5V7AoVLxKe7+E81l0eRIRZ2emit7sMxOJ0dan2B5vr1qxlprM8o56DMv/UuFy1s0zTi21t4y4UesbJGU5RNdjjWoJux2qH8LPtl+AjNhFU0e1XDguMFflS32re+Z3/5cPCT/Wk/p2/O7yd1h6f3KGGroJGiO6q3nWjB+fb0n+S9nliWqjdrtL1BNk5R0BG8CFAdXGlqfxltP0cPdMISNCohbHnkf9bFIFZRRHqKWlQxq0HkaWj+SVHHvSGwt+NcRmBXZFQ0Wb/wpgY2efDcReQ3QvT0vsEAHCvPmn1zx3nQ8XpjgHH5S5kUKH9/QkfcEPAW1gt9czZoT62rU1Tz/uLMuCrFlbvg1cwXbXwZa2DP4T4ElblwNhTY+mG1TQT1t22bloPhvqCb2ANeYyri4Z5P9eOZXGI75BbLHcB0xXfLOiDB2M7yfzEJ1Wtohg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /pK1FWqxVwgeScM8fCR+KK79cGFbX5U4h2pSOFUSaclSBVEb/UQ/DNSadmRO6udm3OMtulGYaBEW0HUy7V0uBcCiAr08GE5zfyMe9i6GGtIYQoxT6DpA2XbvSC/6sD+BQYDJq4gIOJFUPhgo6/8k3ckAO+Y5wiDjMA5EQ/ex6Ho1FYUMIhsV+tLqb10oU84hTyQSxuv1Fnzu/PHthnoZ61nDNlBpbkkVRTYG3spuVPLK/D95U0TFrB7ky/FQUKOr9UTv2OcCXiUo6boAkzPk5klOV08MV4KNzSAoS+JANOOslBN+kQp9kyJJuYFzxys6l7KmG8Y4dTy3x1dcrG4KY9U7jxRYerDVzwu2US2WvpagKvlPZXWrTI15Ye7wjFeqmuv84lIZj9dlga6wK60tgA1pSB+7AyghBIczzDUktoNaGbWKQ1G11rV+45FmtJFL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:02:39.0781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f472613e-8f03-4e13-73a2-08de86bba362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

This patch adds code to mes_v12_1_suspend_gang and mes_v12_1_resume_gang.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 34 ++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 4b279259b9d3..7aea3a50e712 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -468,13 +468,43 @@ static int mes_v12_1_unmap_legacy_queue(struct amdgpu_mes *mes,
 static int mes_v12_1_suspend_gang(struct amdgpu_mes *mes,
 				  struct mes_suspend_gang_input *input)
 {
-	return 0;
+	union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+	memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+	mes_suspend_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_suspend_gang_pkt.header.opcode = MES_SCH_API_SUSPEND;
+	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
+	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+
+	/* Suspend gang is handled by master MES */
+	return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_id, AMDGPU_MES_SCHED_PIPE,
+			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
+			offsetof(union MESAPI__SUSPEND, api_status));
 }
 
 static int mes_v12_1_resume_gang(struct amdgpu_mes *mes,
 				 struct mes_resume_gang_input *input)
 {
-	return 0;
+	union MESAPI__RESUME mes_resume_gang_pkt;
+
+	memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+	mes_resume_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_resume_gang_pkt.header.opcode = MES_SCH_API_RESUME;
+	mes_resume_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
+	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+
+	/* Resume gang is handled by master MES */
+	return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_id, AMDGPU_MES_SCHED_PIPE,
+			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+			offsetof(union MESAPI__RESUME, api_status));
 }
 
 static int mes_v12_1_query_sched_status(struct amdgpu_mes *mes,
-- 
2.43.0

