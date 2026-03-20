Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305E41099B3E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 20:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEFCB10EC17;
	Fri, 20 Mar 2026 20:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HkeEE7V2";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB7310EC13
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 20:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7dxaykgAuMo6Tbk2og1heEhq644D6ZzLvN7iWYe2rjMsVSNxeAQpWfo1A7PNgHJ/U5eAOz/adze2r1E+dJmE1fea6IZC4Tt5/e/flFwoJGYLcaFMXmTObvOicE3z9aD+/LjVwue6FEaJFYjzp63SU9YxNOO08dTzi7ckDzYPXBrP4rAc+ncoX4pmA8CL87AOqn4MK2IGwgiZAhaxbnx+ODy/BglZxNEVPpDF1M1MretAAVz/E7UPXURXQybDVHaF4LcZwDKqI897YtkhQLDbIwZmuiecL5x3osE0EPDcQLWKibhbEJD8Q+ISL580CSO2RsEG67ULJi4EgZWMFSDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGJgqytmCzvryJGYZU2fj5B/2Zw3GzMOokqsuMiwea8=;
 b=dPQC+5tPMOZQYkKx4Oip5ITbGJQR5iUntTQMOuJZwI+HKyxmYY5g3qVBt554RHFYkgjpMLkZ6jN4ZA4GpD87Ywk4pEW4MGgnMknDsDFzh7NyB0wDhjpslEH5tg0Q/SFkFpfHwMqafD2zum2Qj4zbxmCh+CXLaB0biUq85I+KPcyJZlVQEjsihsh+ssiils7bgA7WAJdLkK5y3ZEw6PWbfnyQKYo9wcNAj7FM7YwMWZ9vJ3y7iIRu2/MWrOT1kH/PCNvuLZSsWp5Yhd2fECPdZ0pbByxjmbH3xxcT9cuhw5ZYX5w8WX2me48QQvbNjvpSdzbeem4/b8kgZxDGAXbAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGJgqytmCzvryJGYZU2fj5B/2Zw3GzMOokqsuMiwea8=;
 b=HkeEE7V2oBgwgHqaSLeCwwn4sDha+1hANe41xNA27RQuMebnYTIbJUMh5wyUJBj1jhd/1iuB5Tc9Nuy8gpSHXGd2rWKeS45MlV/B8fJCQYtjNoodEzhC/2PYgTIEiPgoxsWnr6ju8mnc8hTKehu1RhsHyKjeQT0TMN+Kh8cXhEI=
Received: from CH2PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:4e::26)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 20:02:37 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::c2) by CH2PR02CA0016.outlook.office365.com
 (2603:10b6:610:4e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 20:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 20:02:36 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 15:02:35 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: Fix gfx_hqd_mask in mes 12.1
Date: Fri, 20 Mar 2026 16:02:01 -0400
Message-ID: <20260320200208.1188307-2-Amber.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: b9105cb0-2478-42ad-7f1a-08de86bba1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: c+fZtjBLJdBrfhS0vrOG+NzWy7qXsoOtbFExhMvKE3PUGx7I+kUl0pMw6FdINFq5wwbLb9ZzZbxSub8JCC4fF529/N9tMzf3vgI+czd4eCc3D0pnBhYIUuCLLsilTHMJUtWRLhyRovdFO3DZnqNacIT6lmQLFNhJEgtswOYlYpzb7sBaJr0Fm29Gvh04LEl7Lh4lPjlGbciY9ifHrkJ1ihts2lqqkJqtzSGFVukDvE1NrO20KxoESwKHcKsB84sPsQgPcoSCoaKXPqMdiPV4tUuDYWIolsbOsCmHpJQle7CI57CJbUOYBbpMn5BG1SsZYH7cyStaXX6iup6UzIUzKWggSRm+MOnAs60rspfQnbVnKcYn2LwlGYm3weoRXow48xPmskIozhV3vMazRxPCd+R2GK78R/MvXbWd8VHP6srtj1epzhAYj5TAWzeu5AzmYqbEoj7MuRnJXBHvfzS0xs4S5aURTyZjfTMrS87h0Ft3cU522Lf4p9E8LuC52EGqYybl91o6n9fhzFptznNPsYMJG1mrkR/3tuGlzZpNPZ7yF6KlSluVzT2TsCg75zzVw1FcKvtR/iJ6ZnELZPA4Ikb/7OCnd3MYWLE6GdV+SdUCkTYFJwRgdyqCdJb61Rb+T/MzVgEQV45uv4iKIq35wx4HdnNs+HXBfum9FrwfG8y8UIZDN/fKEBe8kMqNOuKiNQaV2b5j2IurWkndv+nKJAQwMS28tE88s84ypSaZkhcNLHvpFzRzZmU9TGd+84RMWOgItA30/a8YvNfTw8LbQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SfjNauL1Jzghf/oxSHi2Pp09N+xDAMUil75dO4CjEwRvC/od0FiH7JUh3cD1Vizr3xNdo6owEZknWrGg8rpfRSa4b49z/A/6nmexxIqGvD+H0p3DrBSFe/P41pBK+t00pn/uDh9a2CSVUvjPsmQ/J19tuQ1zDMWPXrrCVitXUoajGZw+W2KqQEMzTLHiNlV1JyaHuXttVk6hPLsrnNShXwj456kQUBukthbF42ufWN/5EckWzifrv4fQDBlUtYcaGiMdl13njV9rB6TDhDM9oGFz+JdBSI9szuJPwq4Ri89nflvp+gI3kmW3yWzNwTdMtldvUhLA34t9Fl13hEQan+vIr0A6C4vaW/WPFLZ5R8Ce6lkkLpBAj7ig/4RA2ZlGFaweoJY9dVqwDKqlxbYmheQsJhsOo7kK4X6RadcS1yPMNk45Eh5gihisj933TIuI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:02:36.7241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9105cb0-2478-42ad-7f1a-08de86bba1fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545
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

Same as compute and sdma, gfx_hqd_mask has been initialized properly in
amdgpu_mes_init. set_hw_res should use those initialization accordingly.
Hardcoding it causes the mismatch between driver and MES.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 5dcc2c32644a..70d80c2aed52 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -633,17 +633,6 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
-static void mes_v12_1_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX V12 has only one GFX pipe, but 8 queues in it.
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1-7 for MES scheduling
-	 * mask = 1111 1110b
-	 */
-	pkt->gfx_hqd_mask[0] = 0xFE;
-}
-
 static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 					int pipe, int xcc_id)
 {
@@ -667,7 +656,9 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 			mes_set_hw_res_pkt.compute_hqd_mask[i] =
 				mes->compute_hqd_mask[i];
 
-		mes_v12_1_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+		for (i = 0; i < MAX_GFX_PIPES; i++)
+			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+				mes->gfx_hqd_mask[i];
 
 		for (i = 0; i < MAX_SDMA_PIPES; i++)
 			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
-- 
2.43.0

