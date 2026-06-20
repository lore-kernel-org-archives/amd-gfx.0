Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2791CD4F26
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jun 2026 15:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AC810E21D;
	Sat, 20 Jun 2026 15:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pFCypE6u";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013070.outbound.protection.outlook.com
 [40.107.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E861610E208
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jun 2026 15:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Px676jVxgIHdDbIlPkm0cQzpVYrn/yAykIIe5ainSPQ2DeQleRTZtTbQqavSDxQiIxXVTy5ct/OBpFKW127+WUsJUGPTFL5P7NeIiIey0Dqqm2UFZKUUDrcVz3xytmTHcwbELXx6Sx0e3VaXIYaMMzk7thOf4sy+CmsTg88h2T1I16m+r+/dE6caMSb5nIWb02a8r1ifebuQPR+A9VtP7CuLUAl2PNQOyf57EQhSWzNmdmbbjFTNf+1ChvqvicIWD3JlZ7igZaP4V+TKszz5LFp9xCwqewg641XcONrrlaqh79csOYJ0Wy58bLafiRcPRNuNzfr0i5YxSYo7/2Gwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6NzRHNI3pUHLhgFOrZuurvKge7HEtkAiSHYLAvjoq0=;
 b=JDiy0pK0Dp/YIcFhLD15r6qUIoFD38CeXDsl0w24scPvO4iE1fZ/uQZTstqXwaF7ltfPCxXEVTTLznBoGH62pM+h88Fwb4S+HIS4eUZSmsMb6D3lII8zCifyEyF0NKBCkiySbhrTQ9zLDVn1LSs9pliGTojkmeSTxwCsoRICloG98A0Z/irr/FTbhM13O6x7Fw9Phn1vUvwvGin0mOVP4SOSLyLO25b/VUallXighWMpINDgrgapjxIBjC4fCyUdfdEZcNHoA6HmtnTdgUjNoMwepzIBmJbQwRHb0dHqZGbTsjgdBzZp2wAyARiDz0Og0FeESophf+bRpa0MLQuJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6NzRHNI3pUHLhgFOrZuurvKge7HEtkAiSHYLAvjoq0=;
 b=pFCypE6uU+e2zneDiumh/pXUeVCZjSwokswT4pek+BqLlESlUHEv4Q/opTOAt1O6gvbWTCUmBLUIPE+8dUUfmjXlkfD5Z+WitjV93MF0jOnZIQ07lTmDxcefc+cLr7f07Qh5kpYNOB7GsgFUXomfv/4LTIWexkMiqRScwDbAq5A=
Received: from CY5PR19CA0129.namprd19.prod.outlook.com (2603:10b6:930:64::27)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sat, 20 Jun
 2026 15:37:59 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::1a) by CY5PR19CA0129.outlook.office365.com
 (2603:10b6:930:64::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.18 via Frontend Transport; Sat,
 20 Jun 2026 15:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sat, 20 Jun 2026 15:37:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 20 Jun
 2026 10:37:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 20 Jun
 2026 10:37:57 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 20 Jun 2026 10:37:56 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: flush MES queue on reset-time queue removal
Date: Sat, 20 Jun 2026 23:37:34 +0800
Message-ID: <20260620153753.3061314-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260620153753.3061314-1-Jesse.Zhang@amd.com>
References: <20260620153753.3061314-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 068c8c2f-5251-41b0-2e85-08decee1e7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: G/v6xe5QQ9eF0RdJfzN/tjaCz+yKIvJmGcQMy7Hh/mH0s3OzrTv8/v+gy8FFCD56oQUe5KoHBWzdQ3dwTXAWKfdYnN7ZaXH1Mwn60xvFZKyjOtcJwp1siPO70g9mEFkAXOcimIug5MaF9mVDVHNW6QKFdElrZ0p4IzcywMWShdmdb534rhsvzX/q/+1axEeRWrPWFYOksGxwiWtBZnJ3A/r/a15dEUhGiLSuf6X5m2m+AsvXC7dPhQCGpbCSNByk4udtaxDhE8a/AjKIGOsu72gtyE4YFftX2ENdjgc+dG6jdGf16j/CvpQ/5ggPeSIyxriQLpin5cYFGnw2ScrCfM23vdaDmPYOhG9qE/e0VLSAvuWw66pDzWdW2YrbFO7ylt6D/e5lfqKwLFKBdRvgSSHk56uQXAS384AEDb2ZD9HRPaKOANGiER7MxCJblD8A2W4ahSUlvr1bdj0ekxDi2ugIdu0WwXyZn+4XJDvYt0e4CmgX8NCHzGnU2I0sVMsaMfrk+siQ7glvv5DF0i+Yp7AL/3QcHrNIOWpZJZ9+4aaGBiwMNPNM5mP9hCKA/BOebPiR9igeO8lu6Vk5pOcefUZxlYEDvHaL9sdSf9TaR4Lki1S0Uh6NjghhWA3vb/NCyMY73zR4waNjPyZ0QxKyPcR+nrxgDoj/J8aVhaZzapRXKOxs1TYGGxkvGz1vH6qvdlK47wTSz0N2vdZoLRN9iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZRT8gLzOOXFv9WzM425Vo0xBGyq7dMk1rMnsuF8IwlN08SCAdLpXWxHKIqmV95+oIK5SS3UOdNP3J2jPi0B/fKLMcaGV00XSkpRHcmnKfaf1wzZfNILx01b+rz1IdvBbDst8or96MqnZmxphwIS6I+yKVRMQn46xOW+6YGNH4vzeljqDoUpCz2GLrpDLMzETs1QC11QbcB1i25o48d4Ze5AQHVAklZ00JQgkFt/vjklVN65x1NGYbsPhoE7J+vvbgWdcAON24NHLyoXTeW1MTHUaGfejyhviTdwkOMwZ1svg0ggwxi7+h45Hgg2h/0doeT3JupEZvtiOvC7/0pgcidud+SXBxZDqhGx734VT5gqVp/MLuq/5GLPoB6aNmHru7UWwByzWeA9wF2hthYU4+rQysvidhTNJBiXSQYsD8WMK4bJxlyRgBC7pjqLU3YUt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 15:37:58.3540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 068c8c2f-5251-41b0-2e85-08decee1e7c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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

Pass flush_mes_queue=true in reset_queue_mes() to match the GFX
post-reset drop semantics.

Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 166dfa808cfa..9f28974f25b4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -427,7 +427,7 @@ static int reset_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	if (r)
 		return r;
 	/* Proceed remove_queue with reset=true */
-	remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
+	remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, true);
 	set_queue_as_reset(dqm, q, &pdd->qpd);
 	return 0;
 }
-- 
2.49.0

