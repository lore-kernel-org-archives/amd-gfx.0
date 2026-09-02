Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E2CC624D0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA33610F1BD;
	Wed,  2 Sep 2026 12:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1BY19ZV4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3303910F1B5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RS1PlS8K5qFdCVjHNiNDX1hfMq59hGt6CT0lGSj4WLZj9JZTmo3+OT8e5rRD29iW6JED/E/aifeFEcVisCkmVkYMzqLz9XIIktnyg9AByYpSdT1GWl9XGnXhqZUhE2qasw9dGDorbBnWPChe/uvAwVlg8bdoIUrD1p5lmYLI61BhLlydhj3ZpcxLUmTkOPVJDm1EzfRUre8tLzh7q4hZPkRlHelQyDl5Taa56hyqJm8MA3H8jiVK+c9oNURXBdgNusou4C/NLy6/XTjb5QXTaExkBXH3bGNowlRRrv/TULZBSIeR92j7a5GazkljQrz32/CDn4IwK7N/YGJcXL0ufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DixyhbrTGXJ6ZKcm31x4+3klzTgz2e66OZ7Q6/m4aY4=;
 b=Jn7uRlCW/0ocA9PkDE7Z4WoqQ/qd4tG2Xmwy/ryAn9derAsoNoR9ipo1bpr41du4y40aF/3v+5SBJksnE3hqss4+PFr8R28JDFtLwlcAJ39G//BXR3J4e/ItGKBGJyyStA7+9kix8zNoNcSVBVU/6FZvquBQ/ySS26PLdq9D5HN1Ehwgins0ToJtg/hwSROTj+SoJAHdW6D0XniWWGiGOaXVWlHDoq4IDi2cKavaHAMY1LwInJYkJIdLXjXKS8ikWcY20vc2oAZgAptbzlkyzi2uhLr7yQsd+FsWoB3PBJMO14E5iMp4Z40KAynFBSY+/vpMDbPtUuI7BmthkVDnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DixyhbrTGXJ6ZKcm31x4+3klzTgz2e66OZ7Q6/m4aY4=;
 b=1BY19ZV4cXB5ekB60M1ZrjVDVs/c8/i/WnC9wdmsWpghrb+1D5rEFsika0sCl40rQ7baHMz6Lcdy+yBQMnsM1SNK24ZPVdLw+3cZjablCV8vN7fLzvpOFBI/V05ZAtKJGpZOM/saS6knquSYfkqhk23/7dlDJgO3kMPNxP3PWt0=
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:28 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::66) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 12:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:27 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:25 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 10/18] drm/amdgpu/mes: put the mes context BO allocation in
 mes sw_int
Date: Wed, 2 Sep 2026 20:49:53 +0800
Message-ID: <20260902125001.621629-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: b47828a4-e4c5-4036-e9e9-08df08f0c39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: ewRJ4hZ/hYw0rFPET0zQf2L/dXXbhKBGFsZBgtO+91OWIF+THQXxizpvrTS8GFNSadiHcnAuu/epC7etwl71N8ib9EymXIPlDAJk49SoVb/fyXlt94hVy4RnS8zToQ+u/jhVat5xNmJ/Pc9SX+bxG5K8YU5S/e9vaFRMEEiw5dK+tkQyI4Ej7EufOdPXRop5DZw4cRPry2ZLyFBQKHDvvxgjtVQhN7/U6Bs+OsjxWUsG1zi/Q6fK9mVHajDRnTgjtq1UT1lcuJD8ihZUSE5E9zAD5fcejWeZ6KFifktL/NQaAqzABisLz9TqRtgdici1XQzwrPczgVxT4LCq52CB5g55mIR5YigAMDrfW+okQetHR6tjzkmQfuYe6hO0l38qAgFsWGuzkIeB1hQZBISMW949ux5mF+z5zrLWvm3oq2Eu9ozbmftQ5xm4HzVQhlWwqGHiOuAkTyXtUd5H2v32LTB/rpi+H2EjaFs/1Olljkkku9uH58YTBSzD7Oi8nB3LqieEOpad2Rj8PeVCi5snvE9NVv585YK6DI/HrY/tZHTE2wmmSLGEte6WeNOz3XOJkl/auO1K7RLgYDOFv3W7c+wNhHrLzZa1qkquMB/GsYF8388T7xeaMJH2lvRsdkaUJiS2YI//+8o9PNGhNr05VeNRQKXRHa7t912GS6Br67RXtaFVjtOXZRd9zVUyAdWMr5Rx+AnQB5LgbqP35TJSJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oym9KPeBz0sezk8JmDG9JpW8w1CEF9Mz7+dE0f96DokD04wnfHLGCosjgzPWUBk3T6YxNNCwTye2Sx+LQCgf2lu3tsQKNdfI6swH7KZIXlYXZ0O95TP5AkSBCwTiNpidCH/lb/3G7kyb/01yZsBYXtyLu4rcKGBgseN2z/8DE5eBaZjTuKUryna9FRGBy8T27T6RUslEgboYJTPzByVUwkcOg/jCJwmbZP5ZDf+wPeZYqGfepbVn7k9HTMJ0xLCaNFvMfdZu/v8xjRrFVRX3vo9TMDQ67gpwyPHvMuqfRGngF3E+pCNSTuZG8FeBxWfaD8gN2F+mgnS4P9Bf4YMrMtgyzQ2wz3l8TYjXBQzOgC9L3eOmKFM7QlG64NyuJDZBlyAoGQY9tCHmUdwjvakmoXmdkxECbQ9YvUu+eb0mtzRxIwK3VHuz9M8NJGkbquZR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:27.5696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b47828a4-e4c5-4036-e9e9-08df08f0c39d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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

It's more sense to put the mes context BO allocation in the mes
sw_init, and this also can resolve the risk deadlock issue between
bo allocation reservation_ww_class_mutex and mutex lock voliation.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 33ff1afd7c4c..b755d9239888 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1734,6 +1734,7 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r, bo_size;
 
+	adev->mes.use_rs64mem = false;
 	adev->mes.funcs = &mes_v11_0_funcs;
 	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v11_0_kiq_hw_fini;
@@ -1784,6 +1785,15 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
+	/* Allocate GPU buffer for array size query results */
+	r = amdgpu_mes_rs64mem_init(&adev->mes);
+	if (r) {
+		dev_warn(adev->dev,
+			"RS64 local memory init failed (%d),"
+			"falling back to system memory path\n", r);
+		adev->mes.use_rs64mem = false;
+	}
+
 	return 0;
 }
 
@@ -1961,8 +1971,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->mes.ring[0].sched.ready)
 		goto out;
 
-	adev->mes.use_rs64mem = false;
-
 	if (!adev->enable_mes_kiq) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			r = mes_v11_0_load_microcode(adev,
@@ -1980,14 +1988,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	/* Allocate GPU buffer for array size query results */
-	r = amdgpu_mes_rs64mem_init(&adev->mes);
-	if (r) {
-		dev_warn(adev->dev,
-			 "RS64 local memory init failed (%d),"
-			 "falling back to system memory path\n", r);
-		adev->mes.use_rs64mem = false;
-	}
 	r = mes_v11_0_set_hw_resources(&adev->mes);
 
 	if (r)
-- 
2.34.1

