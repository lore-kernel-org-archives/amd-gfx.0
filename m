Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362A4C44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC47F10F6C6;
	Thu,  9 Jul 2026 21:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nZfHbsW+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9417810F6C4
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2rACDiSou5EqpeFb9D173ctGnMfnuPFBzbX0c605bQW+sZJumx6lDvmo/DOWMtNPtWRqxezjdBL8c5vMIJazR6XfsVq+O/JXR+poBO6UuWaPRfDaYfsuVeM/ro3CGK8O9RAlFfR5qAQMx03vkWQNcS+XmgmcdQjQTt4S5Lsc9Y06LSmwVirPfjxg5V8Z4RAM756kwdun0+tML5NRTNPtzpddjGiuTAogvr/wrxdea46KtU1PtB2DUmp598XgvwhzifCZZ9hmk4cNkZjuRCMeCNu8dGgnzHYr7WE4pa6CCuSzxvvBnlSd+VCy8M1HwXIq2G9lDuwFPSG2U3tkMYx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NthjUYMeyZ+66lLEnblpSE8x3SEY+J5qAcqCBMhnqk=;
 b=TBJh8Pq+Rj2vdTUxd2yi9bTsxykCwsGR9oT3wvwbvhU5qzZfIo6W9rZnznxSiwFM5x5O6L2sUP9nHcFj6+Mz1nb5JeTrWY5WBSJ3WOjlDqBcW5cn6j2lPTaBXw8ow0haOMGUkNhrWaqiaPoLbR1a3R6qE+ZGnpIhme0QDpv4Lj6c2qwqcEgF/+oVIjWlyfACR8GERDXLXzUNrDPWw6avOJwMJb7cPcOmM3sH+1h6L8nEYYd6SzZtFbQ63lBQkTuBR1EGoYK3HrVK+YDSCPzfnNHtX80++yEqfq5rJtGIMinYycU89gyrRDoG0gD/ErH0A3l23RiL+vfqI82U5eahSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NthjUYMeyZ+66lLEnblpSE8x3SEY+J5qAcqCBMhnqk=;
 b=nZfHbsW+/b2wLsFIu3WfhdczWOl+RdwctXJFNx9KMVn2FMmCLMXXE0ngg/DGSDL6rAEoRdi5o4WYbQBrUrdQTjtj9U5jaa2O3noXLk+FJtsDJuVnuCk69mDxvNQY14SX6+Ap9jHRmsbRe7qTi8n8fcURnrEW94oxrUooFi5ki38=
Received: from PH8P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::22)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:01:49 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:510:346:cafe::21) by PH8P221CA0044.outlook.office365.com
 (2603:10b6:510:346::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:48 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:43 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 12/80] drm/amd/display: Fix dead-code panel type detection
 from DID
Date: Thu, 9 Jul 2026 16:47:40 -0400
Message-ID: <20260709205936.5719-13-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 592103f4-6e47-40a1-2c3b-08deddfd4ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: zxJDWhr7ALOFYykmsvbfazQXRl1Tmzv9B5ja29lb8VQ7rZ4Kg88OiNpBV/on30fRN5bLbyVJwsZ24VYgOZ+wLJTNISa911Msm8V9eX1Z4hybNPzxYIAW+zw9YV4T6KQsFZWIaahijpaJlN+22TSHm2lT/exMnd9P5z3ZlG8w+ZF+o45ut2hUJz/YMSt5ccOsI85PDT/9020sE4z2N2QKo432APlg+8bpjSJZ88XFz1mrWQ3Vhu+qkb6D9rerxyvytnK2Dtd2einpn4K83tq37Mx84tXT9FifiMMfuV1OQdl0jaAHCXpixNCgSEMcDdrcCw3psBMa6/TNUMljDdvpFR2ccS6/QqM98YyLmpQFuIUCZFC/gszmTK+0z8ms+WZfWd5fSe5onESmkPkolLXBWPWDR35rnY5TpPzOQ+z5WOWihPR7evQIuUqEXvGpWW/meRRE9eiw8jhftsn5Xf3Of42XiXBblUk04E2jFisZhl2SCilpCEVmXPdWXb9Gh/EqfpjX7hl42rWblBEegbc+Dt67HbAC6fnoSAevU0Gmb4VxuvJ3xFiaohBC/DfEsm+AS5nauE6kh98SIko2g9489L/nZr3dob1z97GYqhWm2kqRyopOPMk8BOMHDYmhlr2rhUNBwZQQQUsFXJn00OztWi1jr4ML/G4aeo07QmxUH4epEqJ0ljpdyhzCwSJ1T680APRGyZ/bMqB2SfIqobVMpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YWFK+cuRjCJG5B/WPmkzDyhF7ParIMFu7DLC4+Y9qSWMLTKYO4yKTLxNMvkpbKn0TBHd0o5k1+H9i6pROZxsYROe1PUo4YXce3fApK8buOdnm21GR60gYAdAQWZmY5/kqGDYUYK9FAI6IPCFsdRSuIzEwAmX7JyChjjEsWsEa7IHCaCX9G9EVHXS5O6pdVp7NhWnjfKsgTqxUdx7RrNERcLt87iG+GxZbyveYPv2cgEXER6xetHxYbdWKjmr9IgWt5Lucp4AFsWRe1pqgotxIPA4eKfTN5HPomBwhtkVhLDhkp9AiiVydidHWnwnOTayf+ULx+R3J8HjNDF99UQxmG6YGrMescoq5ve2SyAsv3GCEQuIf7NUl9ulkgjv7jFPQ5HwG0MPg3mExwyVJoFrNgk5Zgy0JTrI5LdmyZ/0hoz4vHaxEmdIMQ2KZI0P8LNI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:48.3701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 592103f4-6e47-40a1-2c3b-08deddfd4ac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
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

From: Chenyu Chen <chen-yu.chen@amd.com>

[Why]
In amdgpu_dm_set_panel_type() the DID fallback branch tested and wrote
link->panel_type, while the rest of the function tracked the result in
the local variable panel_type. The final assignment unconditionally
overwrites link->panel_type from panel_type, so the value derived from
DID was always discarded, making the DID branch dead code.

[How]
Use the local panel_type variable in the DID fallback branch so that the
DID result participates in the source priority (VSDB -> DPCD -> DID ->
vendor luminance heuristic -> LCD default) and is preserved by the final
assignment.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index b9a3c8aa611e..9d0231016ad6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -420,11 +420,11 @@ static void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 	}

 	/* If VSDB and DPCD didn't determine panel type, check DID */
-	if (link->panel_type == PANEL_TYPE_NONE) {
+	if (panel_type == PANEL_TYPE_NONE) {
 		if (display_info->panel_type == DRM_MODE_PANEL_TYPE_LCD)
-			link->panel_type = PANEL_TYPE_LCD;
+			panel_type = PANEL_TYPE_LCD;
 		else if (display_info->panel_type == DRM_MODE_PANEL_TYPE_OLED)
-			link->panel_type = PANEL_TYPE_OLED;
+			panel_type = PANEL_TYPE_OLED;
 	}

 	if (panel_type == PANEL_TYPE_NONE) {
--
2.55.0

