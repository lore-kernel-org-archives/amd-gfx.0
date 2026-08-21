Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E115C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250C310F412;
	Fri, 21 Aug 2026 19:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z6pNUG5Y";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C43B010F40A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHRLji0STEtCxxHUBe2zb9nYXqM1DD7rdWfPTV6xzk8jWGjNI7qgjmMlB4v20t+foKpcm5jexwlQWcWkqrJUr1fwq2EeEl/4E0PS6Eeu0FUqR4bp5JeK62LiuF3qbaR52vNDfLIMpPcWKLvN7KPXuJQ92zuKcWTspG8FGQmdr3rTwQAdjN3PDqnCFb0vz+Mar5XTMAB6jz8vfEXDQcIteSMZkahqOGgP5J0QZVgbWeNQ3au+0H0rADbDQm4MLeTYfh3uSxOSLnCYyxbybxftP/NnoYNS2IMnBNJRcGOiVzo2fBpLgapyNSiw+gbm0QbgMUcv+CU767dYts/1ZoknlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KB5S4TPA2b/h1wZSIM4IyMpeZriCkts837Abhl4mu9Y=;
 b=V/f/YvgB7oxg198U5aNrU8tFn5VOqvXX1GI6qWWAi2bC5/G2jBmDF3e5DaN3289Hvn/7XoZpIKds4/8QSchg3yHIXf9dUUZDY14yYA3JlJw3KV/R8U7Ox7qRtXdnm7ywH79KiiJ4ZOq0VCYaaVxJjPyMeSDTd5mZlMr7WAg63xTJ2hc+QVMYWFnIgx1cwBvDsTHagsR3R9JgEvpYDhfZe+9h5X74avYJodhas7iRfgTyGtgqFzbv+9Dtv2TsEfl/tkDHU2cohascsCnzJL8LwJA0RzhvZpFUawac0FC/9F5hVTcVzytUYcFPJP1XjqNBTvVYxikMFAmNjiV/9f2d8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KB5S4TPA2b/h1wZSIM4IyMpeZriCkts837Abhl4mu9Y=;
 b=Z6pNUG5YEIBn3uMdXUmcLKOKbksNY6xMC4koyXNpeu8804zC8/kor4rakUgXSkzxDZm9cmUtaQ+u6rf7xYRFF20Kvzyto4OHTocHrrlHtH2d+S2Pdy2rJZDLZ4ix3wSuuR/wnnO5r6OwW4l0joJxSNPi7LG0d7y/RWX3uPUmgv8=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:30 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::42) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:20 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/95] drm/amdgpu: Set UALink station config to PSP
Date: Fri, 21 Aug 2026 15:33:38 -0400
Message-ID: <20260821193458.808626-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: be4d1905-3fe0-4637-af68-08deffbb5af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|56012099006|10067099003|6133799003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: z/K1vENCEnu6UkvYlNzz0EG+Ic48iOebIWhv59WadRI6EH1XkbAZz18EBXxHmGrrfrPKbvLmX4Tq7dmPDCyoJKV6/OkJe+paSmzzSAra2sysmPW76gTNsWnndRUXoqDMj21xGLjjZvNyiwdyWlft5nl1N5RWJWGFH8zoaSEIRiCK6WqL0Vu4PRcqwGGnih94Sv0dKNDMjmsmqjLzfwimn7DVKdRwqG2r2pMWsRRM3XeuisdhVWmeAIXkk6uy8v9boGGKg3qJk/o5ekKSK7EfP0Q1T92yRu8VJ4NAm5dqrRfoLI18sJyayeez3U+C8DffHUjHc5ErIwCRW5KSoKovEBAWMB4bhYcotPxIK0VoLO8Ww2qZTmmE9OWrkelVcT3cJoDMTbc2J72qwYUrRyGZWsZW+bnhGzw8ElCKg1bsGWw3Ck9TwRaLuZ1wfaKCAltWZP9CzV562GB22FdUjtX/sBDaIXbr0h4bUyH/ugP0We+DNtIN52MMWl5KMv/K/d8lsaKVz3nNT5VKH/j5DpK37wlEfN3wsFDSzkdmn1qpPebgOXozHjJH6rlJUwqTX8wMcEaT2j1FGsxi+k95PnxyYyMKWzhkUJOJ4yLtt6FHn52xvj3cPlaMcHeC4Oyzu6czKpaPuM/hlduADq0HPGoAmh5Wk0EGawFzq1eoAXnhYG7wZS3bBUGwcq3SqUZqIVPq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rf5CvYvTOmCe1i8NmtMOx+pqyB5WXRlsPTXVZih4FAt1jruwHiW2EG5lIaxXd6/EWHdOhGlGzs1frUjU9kgvzfOo2LJWjoy+Hi8gjrdJicMsgtNTBYbJinZVW2+rD5BEF631+S2ZTLN63znVccn81ODQqvETWiqzLtv/g1YgG+aAmLCEOn162XiaV3Vh96p9ur/ywWwE1y4cLcJW1Xa/VTW9VhcyqUtqw7+YA5B2v1GaZOZiUqZbffBCMluhFYP9LlOkjFRmm9P60wKydzP01/LS5xld2nwjk59IVA+/JMQ5jpt3s+LRISmBKNLYmwqLBnoPrPEnu2/6NSYw5R8JKVaLySGQxz+9tjW6TWC2Kk0eaFJRaZQjeMIkSO/Iw7LJZDm7gTrs/Hq0EniqlzK/3FyW+jooyebNwzlioqL2Ouw19XMbnQDAJ3UgZleY2MYY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:28.2362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be4d1905-3fe0-4637-af68-08deffbb5af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
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

From: Felix Kuehling <felix.kuehling@amd.com>

Set the UALink station configuration to PSP in the commit store
callback.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index b25f61f223ca7..134ff3d86126b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -830,15 +830,19 @@ static ssize_t ualink_station_config_commit_store(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(info->kobj.parent);
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int r;
 
 	/* DF reconfiguration does not interact with accelerator state */
 
 	if (!sysfs_streq(buf, "true"))
 		return -EINVAL;
 
-	/* TODO: Send configuration to ASP */
-	(void)adev;
-	(void)stations;
+	r = psp_ual_set_station_config(&adev->psp, adev->ualink.psp_if_ver, stations);
+	if (r)
+		return r;
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info);
+	if (r)
+		return r;
 
 	return count;
 }
-- 
2.55.0

