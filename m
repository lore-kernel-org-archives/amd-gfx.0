Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666C9CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E790110E450;
	Tue, 26 May 2026 07:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z+htWIgI";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01DA10E457
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioHcG+ovHbHJmbBFfkDvMZVb96cTAQZBvoOmIL6Cy8jfGw6qtU9aAyufTCZfACKyuvuTsUaWSELBIGU9rEUD2iRJZwQ8Z2fXQJiBIzTo3Sx6an9Ygi19NkPCj2yfJJGT91DLQ2VDqRYXs2vDCNVlEyavHDlYnUesIGTinbEE4rQ6YzdBCLBV3EEjJJl1HDWDTJw+kHHj1BPWPM1cPMRID6V3GXovnt08OpTGmawdhD0Os6YU1lzDOq1YJ34NNx9/u/MrXn/P6OIyFuGokNMRxIwMxC/QcwKOd52WHLXtCOzbCTyAOPOSEgbDAtiXT0bWC7Iy+KGIjxaTdjsyTK9D2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTpxTeMJhOor9UBj5/5dhVAi0Y59xz+MiaSe6ZUdklY=;
 b=G21NlKQprc/diwID7beS4NWyamjhr3wRTbxBsLXmA9nzFmt185hSi3/zbd7NiQc6G1hGUtGZJSo+uIjdCSy34ancp5GnjyOj8RLv+IZORi9+150qhCSPZWrol4aurr0eG8lasl6IqtyzEu38VSmIuV1PZcSkahxZC4lrooBcrtPzBiV2ktbL6LyHziXwn+b2QrNTNuM+uDINFBFzMLMn93jX9uW3D4uEmoKsC40Q2+d/sUHxZkiVjilvuXUYs+FmRa/ojSvRN5bgQhv+Q2Jmku2Fc5H4BMlC6dWQUhGo7itvyYMh+wPhtNqehTR0mxnbFPL5b9TTwo67AO60sQ0fyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTpxTeMJhOor9UBj5/5dhVAi0Y59xz+MiaSe6ZUdklY=;
 b=z+htWIgIgZkMN+P6PwrTYg6z/JyyokJJvUQdFdnzGvr1WOtg5DHRXWC1mu8JXvqTru4WGwENlUQENoaxuPRal5R5zgHD3axPXbflvT4Sh9K4kocAv9zWVsr+4dCO4g8WzP8pcDpa9i87iLSEQhAN80Ahwb1VlKK9i9R21Rmjmos=
Received: from PH0PR07CA0069.namprd07.prod.outlook.com (2603:10b6:510:f::14)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 07:14:45 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::75) by PH0PR07CA0069.outlook.office365.com
 (2603:10b6:510:f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 07:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:14:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:14:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:14:43 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:14:40 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 03/41] drm/amd/display: Enable dcn42 pstate pmo
Date: Tue, 26 May 2026 15:01:26 +0800
Message-ID: <20260526071413.2181251-4-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: d23d9929-1115-4f58-38cc-08debaf6764d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: pFBVJCsojga7Akw1d+sB4BCJGz0SEVuSuaCvIPyNJY4g2bCw+J1RM8rimuFFbmRlQokQbdX+OqIW+DzsvtV4A8WO7GR0udP80Qm7qe+wR+QD49PPIdz1Zsgzzb3B9w+EvqJNOh8+ryUe3bSXpThfynAU0Uxo0xqHhhDRPIQ6U6kKK8HgONiJmC8fT6TvsMuO8DHDBVUbftY1Wx2EFVzSsit7mcIRQo21zEHmvN+MQXhpRXptB336R5GqmG+fQfcGEvO74HEjNIpZCQRO2afUJS8MGyyXmTGLAzoKbUaDpIQIdJfWWTxTqqtDIKeMkd9sDCjC2KHjhkyXsEc/fWkom9uxB+T1ZSkLUo8ZVRxWZPxOmxg9v/hR/zOSOc9yzcZ/8vLSYKGrC4JUnAG5ybnAv4YEz0Wf+rjSF+cC7FnntxxlrfKT8xk5KjgXPB8K96ueFTfZ1mJ1Q8KPQr8A3YuyKhiyBFaDYUzfBcAJYBPrv8TI5+1lhWQ8p0tbn/6qUMMkogR50/aOzrFFBF6DzV0gsvKeWUSt2KhgVPE5uMSOB07pYHgLhCOs/KXJE2ZT3x3OrQ9Gvq5DxZAsUBquETazXJ7MPmIE8wdmVrHuYwzRhn+VcPazlTkL2jydpM5eFoZsMX0qcmS7DUtvrMNvA9jVtdKDpK7YSb71/7/+QgAdf8tSGOYUtvc1dkhYYQ4ILdwZqRSmj7axYCzHPoRLiG6yeq15by8Og6e3C+yRDLNHsUY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qt4+KF2s9pZJL8eByyjfj/7su3M7LkK4gRLxpwEmkmQ7esCoWeoYpMsJHHFSGauGBmGe29b9IiYh+ObJhh7FrzlvDZSSUT9Q/5lXivwQnsVjrZpmUAIw3D3AUK/KN34dncukTZLtpL9FSIQ7uxBt+QYGwAsML/deLBYT7iwbqYlXBf3/1jaeXjkD0Sz6dl6z2MnHqMH14ZidOVvKGdTuUIqGzdvPOr2R4chinpvvHLgT5WIZkqTPXzxOzvQ5JrNH0RmabNILC0Qn0I8vhnAPIqgqTngsOwZXD0Kl87tPHkFLPv+NeDV7zHFQXvbKIDLDXQpp4VvGsyds9iKsqQogNBGuqdTXWQhGIMwaP1fkw5MsYoFj+kBWkn7JlCQYGKoidlNqRQEDJZGK9RcObD14J0hxwMI9ASlGQXLTMfs0KVI3I9befT892NajqEpU6CX2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:14:44.2150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d23d9929-1115-4f58-38cc-08debaf6764d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[Why & How]
Set a flag to enable pstate pmo, we want to always allow pstate
support on dcn42

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 1fc457cec293..efe025ca4ed3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -2290,6 +2290,8 @@ static bool dcn42_resource_construct(
 	dc->dml2_options.gpuvm_enable = true;
 	dc->dml2_options.hostvm_enable = true;
 
+	dc->dml2_options.pmo.force_mandatory_uclk_pstate_support = true;
+
 	/* SPL */
 	dc->caps.scl_caps.sharpener_support = true;
 
-- 
2.43.0

