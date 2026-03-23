Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D27DD58CC5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2445510E3BB;
	Mon, 23 Mar 2026 04:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ay48DKjl";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CDD10E3BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlCN3VNRlqm7nsd4xsF91Cc9zBheDT+b16cx0w/dxX3hvtDUHG35NbQhJ77xdadU8jwyylQ3vsFRdxPXxO96vHEjKnTa0lzn9fbYZqnqk0PVtXdD+1v0r4Pzk7W5kMh/Yd1muZn4edhGnx5o3XHPerl/mCeJDLGfltmHa7yI1KXRq35aC/gQFL5xdY2nfgwF6DKN/HZvfG8z8QSNdj4YPve5Pa5c8UYqXYcwkTuFsAbSUAkYq5OPJ8YQmCsQK22wgwZFBmPmc0MAlNcKHiGY/oxmnsAQnCS8UxXdcISbfhQDXDRHb094Co7/ypnA6DityKXQwGRy2iv28XPCzlqbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZI8pt0GFqIdc1youo5FqVzA1RauG0uEaoKqc/RETEk=;
 b=WHAns4CuEEWppLhFnMLn/WrGkcJjcsjjoSd/L3VUeMM8dn2tvO6oXZgQTYEsT54wOZfju+L53HXpTclOX9+cgiWceqcCv1wUJuAbJeyV51vozJDzfWSejT9B6Gh8dt8Qx9UiqgJ5vqXyWRyarQCEMjY1olyQGvkoI/YVfTi0CssA4nhPwg7IaRdV3WdPrNhKlBARHAdKKTX1/KaKaVWm0ChRt3dz3Zf0PwCy17dbn099RqKzLHbvGQfmNT7dc8WApFMQBsydWyIRvBLRz1Il9QoMepOck9aP+9hKyQC4uFep1paGJETLTZIZa8r1u5uSTruWy+51eevT+514VPOR4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZI8pt0GFqIdc1youo5FqVzA1RauG0uEaoKqc/RETEk=;
 b=Ay48DKjl9zsCGy//vcreCHV8s2Qj3okKYnnyG9RJkV+mxlMDRrTNRwHywGxxVKB8/6CiG1a4OVqTQaqqerM3sdOZWbxaKQozK/AqsOcf4iswHf547MDjdYbxArE5tR1ibs5U60uvYLVjTD9Fe9goU3WiaWequsEPpL8Nv66u3d0=
Received: from DM6PR02CA0064.namprd02.prod.outlook.com (2603:10b6:5:177::41)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 04:39:26 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::f3) by DM6PR02CA0064.outlook.office365.com
 (2603:10b6:5:177::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 04:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 04:39:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 22 Mar 2026 23:39:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Dillon Varone <Dillon.Varone@amd.com>,
 "Chuanyu Tseng" <chuanyu.tseng@amd.com>, Roman Li <roman.li@amd.com>, Tom
 Chung <chiahsuan.chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] drm/amd/display: Add update_descriptor param info in
 'update_planes_and_stream_state'
Date: Mon, 23 Mar 2026 10:08:57 +0530
Message-ID: <20260323043857.2043958-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b1baaf-6e01-4231-2b01-08de88962994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: E5fR9ezyN5hXLuiNMmjQCnZTow2VwlMFBOrl++zVSmW6Gf9A/GZXjMZ8U3Vh3i/AxA9JOkjQGreC3dq5Miv+ksdqEOZTbcSjMPmzkHbL6dGLY5ClrlXE86KHYbDRZHSIFKIa6p9B1KRfqMFqJOacmMTxfgVkpv/4ROMMpi4W0y5e/7O2xsr1Pv9OUeagWgcyNgYLg6Zk/35jf9Pb1SkwoMv7C1HHNjDix6w3P+8QUywm3fnPLc7T8ktpxnBmicTGfXDM2emFiQP3A3dqK98cM41fudnwB8ILG6koUeqc35pF8gRC0DARD0P8E89fEZJJ8as7V5WQE2jX1T2yaiQ85MP1LCs3ro9rOwxUToK9dpFgAEv6cuif+rEfssyDtgR0/ZSJRFW9NA6vIt0URkDc1CxiFAa/BoeQk9IjlcOeB5Fxxhbju7NrPcgksqiEoL9/I7vUGiuEwHGADiLj7Mgj65hNLuwOK/nMQMJ1wKev5TekPs6oWuLLLdVDQwb/W2nKRmkkoiJilJG5kc5+3A5yURCluz3i4I8y7TMQWH9S991uYTv+l9isMYYE6FObuEdffeq13JYMEfU583mmfcw/JXPJLvR8TSfisk6PUp6nvlLVELj2YDOvfFD1TFRrFLVy6m6YO8Rogg+8NngUVGUowclE9Xc4SIyth098G7clReIrFiozDIdlkt2mLXLUQeIT/ZQAUHRE/JgEA2DyQFbxMeMryjFM9vzUbtbYkW1oXsGIT45NrAj+YTTRTs9KjfOZnOmUDN1jx/GrUgYxZFvRJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZZ6KG8oSfIZJcG9Dzybr2tqu9CU8Z8oEreA/VxjK3PFBn1FH7vrw5LlbM0DzpjxZeH9ST/PCMyFUTa8bGDCrjpGlhWhs5qUgFpBnb5a8g6uz5CeKU6Dj0QU1xzdO30HJ0aWgWCH8LwhRoacxBuHNxwLhhnkMG9uScI7KhQILojSR3/E+F1ZF+n08Py8AEAVqAVafbYlkaW2R0ZtNj2G1/tZxztqC++3qY6of11LBvr4YdW9DX6oc37TZQ+XaSlUNlwg6sz+wZ716NF+Gi0Y9D838rhit0fXhhXREA6PD//nQUQIPEtpegJ8fhg2m7txg08GG46/rutQYUKqD4LAUlWZNQ5vpQzRWULzNRzjpkNe0+Yswi7E2XAeWBhgHIwgtq0JoN15KaTxp7Letoxk/YRu80jL308KMya/mFkOlz6zlDdF25FX1i0ayduKrAxLH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 04:39:25.6601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b1baaf-6e01-4231-2b01-08de88962994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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

Add missing info for the update_descriptor parameter in
update_planes_and_stream_state().

Fixes the below with gcc W=1:
../display/dc/core/dc.c:3630 function parameter 'update_descriptor' not described in 'update_planes_and_stream_state'

Fixes: 90fe5f44136d ("drm/amd/display: Refactor DC update checks")
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Dillon Varone <Dillon.Varone@amd.com>
Cc: Chuanyu Tseng <chuanyu.tseng@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8b21816cf7c8..e3992ca43c8d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3615,6 +3615,7 @@ static void restore_minimal_pipe_split_policy(struct dc *dc,
  * @surface_count: surface update count
  * @stream: Corresponding stream to be updated
  * @stream_update: stream update
+ * @update_descriptor: describes what plane and stream changes to apply
  * @new_update_type: [out] determined update type by the function
  * @new_context: [out] new context allocated and validated if update type is
  * FULL, reference to current context if update type is less than FULL.
-- 
2.34.1

