Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A861BFF4927
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 01:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2FA10E2E8;
	Mon, 30 Mar 2026 01:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tV8rgjnd";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012059.outbound.protection.outlook.com
 [40.107.200.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B74810E2E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 01:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld5Pg5RCfg64Neqmhgnq8X8ZQ3gEqFMNLSHJaPvb3XgjiDxRb39Bpp4pDvzFk86gnXyNQKQQT8QdC0I5j7onvAEilBfrK/06NQ187zAQdjakw4PNW6vIkta07jB1x3S6fiAM/a6riswuke9iOyfUIHn1F99Fqq55FwG4+oqVCxhtxjccYNBta2dYnUzgxHHAq8ArX3mhdGOm9xhWGALscshqU0EonWMQBLPOON/4vzNeYCPk/E8pvSKqOEIWOBJjZiC7Z1k4b4GVAljnITSr9R/wkbGQdylvOMk+daEDpbcuxR/B/H3wSuAXla/UvqaoyS6gk2wdl25Qbw0Lo+nTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PzJ0VL1+c3VqI9iuIgKpzkUtfkVcCSAShHKgxUqqM4=;
 b=q78tFitQw6WiYhuHwLJgD+uXSPTZEobYChAQpLuLvP5l/fRQ7RT555QFf6CdPI/7JTCFJo9l5NolXY8Vh39ca24LwCNyd/C0XohbyBxjVXdXs1xeR/u/wmZxf3MAGFMfn50GlYgk5VXewRAjE0YReJ49+rBnLrn0QiftOMQnhy2Oa2LH9zugf5L9C8//eT7fx1wqVXCcJJV/a1bPblHMniaTPQ1BFvts+r9qFcQC1a5qISQB4nU6xZEO65Ro1kwKLXTDqwVd9KIuJDKgxW124yQ3rUujwp7eyQvknRhyiqvE8e8sIXcFxFL7ykAeg3vd7WQjh5qluBnjyGCqTGFx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PzJ0VL1+c3VqI9iuIgKpzkUtfkVcCSAShHKgxUqqM4=;
 b=tV8rgjndvqs4J16lbN6tkq1vHEqKAGc7oAvRkU58w30hcwH+dqz7G0t1fOmZjYpSD+Lhr8HsrrlZSVbbYu/vzhdy/iAvTvKyzzkCfxee5b/67rsolOgeRnD5TOR8IeSub3S4v2P5bKzkRmLP5h7VXmKjTOthsSn0uFl20skCg3U=
Received: from SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 01:34:13 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::d9) by SJ0PR13CA0110.outlook.office365.com
 (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 01:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 01:34:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 29 Mar
 2026 20:34:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 29 Mar
 2026 20:34:11 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 29 Mar 2026 20:33:59 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Michael Chen <michael.chen@amd.com>,
 Jesse
 Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jesse
 Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu/mes_v12_1: use mes schedule pipe for legacy
 queues on unified MES
Date: Mon, 30 Mar 2026 09:33:28 +0800
Message-ID: <20260330013346.1054624-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260330013346.1054624-1-Jesse.Zhang@amd.com>
References: <20260330013346.1054624-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f1c9ed-1cfe-4722-48e9-08de8dfc7295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ztDXpvqQx/9eR1Yu7Yc9vKUA1z7weuiNBl2WShPeGRMuIHbdCmEfJ147tOAMHAr62McDlnrAh1TgbAgQL4IAEecMJ948/BVtCXiW+7eUaiLs1bq0tgz1FL+IYY/rabo8CfRhjXge4kS5ekq7+jLcUT8sy5bSuR+HGp4uwDvkiAkGtu0xea+97D/ZHmbbhoE4E62RKIITZKiHfA5BT1AJc/VrBHofXgzDDu+ONfvn3a6nZf4T/nVev5nFyBLFeTgPlrKVmV7uAG8qU216psAeHoGxTkbTg8Fks958SKz43+9uOwsLWL6uBtEon4+DRzhaePVhA1sbEMS++X2/Qi+LbUUkuKLmizu0JYc/AiDaaElQ9xsrNxupBFSMimaoi34Nw/qQPEh2kj/P3y1l5K0oQtvCyEW7B8XkIFckQt3wbe0AtlaArW5sG5ttTKmw2nTzp0aUkXKPI9bpdi3uoL9et9E4oopA1JeudvK899LzbRHwVetiniFE+olY32UKner19wDxZsiJ/8oxlZmUXQRTq/uWxDCcuKKIqGxDKAmG9jQfKm/XAE8tRtPLeY5/SFnoNY06zH18Gj1ytvdwVmZizcaerAeyauw/+gJtey2YtwTwAOIJfqll52WiFuoZfPD1CAURJoo3trk4QB5ZLXsqqfkazr6HfuNgI3dF2go+fMcWoL24B0RVFfrzBOA63HgYV3iPOjZKhHQQK+YzBPCa9PhF7JF6W1FsE0CS1lyOEQ18uqkWBPgtGPmhbE33TV16pqNjjp64nq1W6pvgtV2ftQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BGFAQJ0q8wy2AhQYWekVfMdSpG5FA5K2jds+HAcVkJLLg0UEdV1cW/1LnnFGQi0dLGviKFi+IunO8RNbSJaLNIbMaUMbtIp5OAe9L8RQ0ffaDEvnBXTHPAykoJ+7SEZRiXCpKxtkqhTA3eNRZMqIhtx/ov6rpPj1lurxi736msm1r8RB0KXLfPLp6FG3OZle+QQ0orAE+YNxjkBZwKPqeEYAOGooWXHQ+P3i2o0YYPpRHi73J2FFiMiFnM7UVec5oHqKQN2k6n4agIGNuGSIXUizmxWi8mfJ57wkL3KgQ7cREeN2DaEeVjRW5UL1N6m6ydJL6PVSWVIHXBuqftSzVHT93TTxPGoIpSGk8tVQ/NQFwqPXSouQCUhIFfsBtObq0HjLvCjpfg6ReeMsrAt5tnoW24TEMUGBLPJ5k54x+mkL+W4qFpzCAphkllNmOiVW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 01:34:12.5497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f1c9ed-1cfe-4722-48e9-08de8dfc7295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204
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

when suspend_all_gangs is issued to pipe0 MES during system suspend or runtime PM, pipe0 can only suspend and resume queues it has tracked.
KCQs registered with a non-zero pipe slot may not be correctly handled, leaving them in an inconsistent state after resume.

v3: fix the schedule pipe issue

Suggested-by: Michael Chen <michael.chen@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 0e9089544769..71cc4e176541 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -414,10 +414,15 @@ static int mes_v12_1_map_legacy_queue(struct amdgpu_mes *mes,
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
@@ -454,10 +459,15 @@ static int mes_v12_1_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
-- 
2.49.0

