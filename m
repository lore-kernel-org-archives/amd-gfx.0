Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007BCF513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CF110E309;
	Fri,  6 Mar 2026 03:27:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fqpSWa4c";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012012.outbound.protection.outlook.com
 [40.107.200.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6310910E309
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oc3Vhf26uarFwJ/DDvTi4HLbVbbuMwLnGHCHHOot0KW454mrxjtpOOddZD3MAVAYghCREfArfgQIFHImTh46UEKC3p4uDblsYZ1php16OtRvOK2qFP5OcysjChRRnjmCHPvghYZC3evYSZCNa7KxHZ1+k31FPM1evWZgLYUuUYIuC4R2KRrwGL86SGUCKeQ+oSQQQx9sL8PsP7Cn092zR+p7WgyuPYi/S+lMLgj5HvveTzDqAQcGD1hoqeeo8MhhaBi8/I0MXUQqY3R+g3M/B9YrbYb6+TNMGhrJK/iHxEqairyNDUsm8QTWjIOGppiHVotyqvvVjls291WStyH/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/MpHzTGgokKIGGnehVWNTiakLaQwoJvVtn+N1l+yXA=;
 b=jw0Q30O+zIE+iNoG5kpZ8LcuAv05pgRdDiW5baS+zoVjAFp4sCbeMYFboZpqlJXkZkilumooVctzwSIUARmMDzbxCbOfQ36RiJfKbRpima6GHqWb1AF6OrGXKTYkde1bu9ThtuZ6y0XxKykhdPB1x9RD88QdzLecNuxOPPPHwG9twagMsOc9ogX0nGMzaU1sciVDx9zgJindy6aUrO6SN2uVv1xXHqCaQmO9a6tg7CJvf3iwHx0lvONqVBBagmVOUlnnBEwMAnhPCE1qgiG7CdjHZsYU0uaLM39YMlAXLl1AX0ys+twZArO+v68TYvrMvSpAgDHudufZzvO/MEQDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/MpHzTGgokKIGGnehVWNTiakLaQwoJvVtn+N1l+yXA=;
 b=fqpSWa4ciPltou2nVYjvrLeVfLjCrY/sZn0YB0zVVY6G6DbVB7UYAmj0q4cdGd00UbDBxbXCkqBj3qqYI7Be1uiixeHAzv8zBYi0Mn0LMICsx2yRuwpkhEAwtYKx5w4jhvpPOn1NoeS8+w5P7YURj+S7npYWKe+iX6QuVJz0KSI=
Received: from MN2PR14CA0023.namprd14.prod.outlook.com (2603:10b6:208:23e::28)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 03:27:09 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::5d) by MN2PR14CA0023.outlook.office365.com
 (2603:10b6:208:23e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 03:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:27:09 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:27:07 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 15/21] drm/amd/display: Add back missing memory type in array
Date: Thu, 5 Mar 2026 20:13:41 -0700
Message-ID: <20260306031932.136179-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a37ae3-27f3-4753-39c2-08de7b303fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: NcgVSZzoKdtc0FPPUHOU6cPMqOZRaXuEyRARGFqYhlFZPEKWJMmavzc11/lsaxm0lCnyHC98cP9n1WXclH8zdro8pH4Lt7h2IbfP8EoecWBVs9Z3tTUFYCT+EZDM9Fy1lmmtNi4ZKnUOhN8VouesghhathprG1YJKbIz1kE8dS/iprtJ9rgwpviscLU5n4Bk1/YtmZM4tOCk62HiuXS5Ko2BqYK5Ogy9FRRdXWUnHn660BsUdrR8FNcOVV9fQPfhlmxsMABRziuh2nxv+0CTpJCKQS9zomg6THQGkEFG/w+K/+szyFOOjnL/WfubqrX9itWb6a02L2n8Wr/ZGuvhNwCiHeCzpCGFYX0jjB+68xUqZ5OAaDsYNoMdy0M/Q/MVi7xwwGlEPNoXDsRhbhxN5yV+OcUNPpLUDvH5eIEVha+AVp/GvAVxiC37ZO/jZUtJ1TL8c+7AyhG9KrVWj0Mow+xRI0oNZ0mh0OIatANr3tVKZWNLqCLME6cAJEPa+iiVVV/Hjhf+5fBqpWuSM45n5mDEx/gFQFDtnd+uaAFrTE9lUh5SKOmuhE8w/1RBY3pAw9TuLQnK8Pzk5pz0hP1EKppodfDb7YH72n0Lt6DCS0O6yPAw3s+7idtw5RHutgX3PM/Ek5pWogRfUbQTyxvCTDQzKPydMTTKVqCTJLRqkl0Al48p9ksD1iFGtT/MPKMKzx5FV+x21wgnRqkrQkzqvfi9m+9m2PVIBfetfF5Df1pRMjkDGQ5HiFkrffr1MBdpIc0YQf1S40wTY6V/pgm6RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uBRDnXthHhgX7pfmjgnHlRqeR0FW5yKCMhKzsQ0WO70x/R30tJrElCESVEEo78J8s18XN60aIAjrQlv4xC6MhqMDnFlVmAPajCBdPSRAOv8TjxFuJpw2GV2X9p9tVW+6n+jvTCcpQKqzWnkN26PwxjI4LLvtD2rcxMP7bVH+b5GSkLGfz0qVToAzFNAtikdHoTuj2w8feNPhvijzIFfPIsrB2QahPpsahzCSnma2Oxb2lEjpBYB0MZV504RIs0ZWuUcVbgDdBA+rd/AugM1fo4wNWh5G83p9F7HdfWW0IbcCIghcO014P17vnED9uO2VQEbcM69oT0OKfOTa4m3BYLqZDz/ddJ3SQKVapajeF18AHpd5kd8RZDaU8RQahKw1F6THN3RhzbHGoA0loFfz4uJmw5aQejfCtq5SNT/qR5ymAyQPILiq5MJunK4ttJSv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:27:09.0894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a37ae3-27f3-4753-39c2-08de7b303fbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
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

From: Tom Chung <chiahsuan.chung@amd.com>

[WHY & HOW]
Add back some missing memory type in window_memory_type.
It should be aligned with enum dmub_window_id.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9f4c9f89c13e..01cffc789218 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2469,6 +2469,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_7_SCRATCH_MEM
 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_IB_MEM
 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_SHARED_STATE
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_LSDMA_BUFFER
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_CURSOR_OFFLOAD
 	};
 	int r;
 
-- 
2.43.0

