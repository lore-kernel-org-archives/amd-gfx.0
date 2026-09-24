Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57C9C98304
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 02:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D664910F272;
	Thu, 24 Sep 2026 02:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ogCDRg1q";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4341C10F272
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 02:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwQGy0UEdM/P3iSEQh4C+9zLXExhQo7OrT2L7GasXI2lOmxZRftUvwaD34SMyZoyUtnAaIf5e+EfeUeLUBVAJBwNpWI5RcY8Qx1Igy3v8WA+b1u1U+rDqj8nZ+ZvQsv7CW3ecXHNmbzOmGo/Dqpi6Fb65a0TAhtx09OpKdnew533Egl6oaCvRdg5rWfWltVkNqh+746Niu+2zUGqXcnm6FY/hwN4wvgKBmcjpCAaTx1+ydEdHuWZDamvOV/b9YY3CvuvweOy5f2QcVvE3M/K4i9nNhWapfTBYjOfIOobu/FPAXBA+bLP4HIhag2SlHVlmlx+nxT0IBDlzMGWhsu45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENzOfFREHxsUt6sFTckoSAanzLXcBP1OTkKZ6vCfj/k=;
 b=IGUHFS4td5ZEGh8mfqMu5E5NhmS8SEBP4O9CcdpMiDKsOtWExGKW+lIOPlxYuI0SQtEsIFyO+mLCFjxhVOHHy1BxAX/XyaKE1NM39fwR8TRF37A0KqnZ1tCawF5StI3RmAXFKWvgn69yJF4Uw/ja9mrEZKl/WQ5N/pyNObOk5+bxVuHyU3UdmmJLZWg5p9vGDbov6VwN85jHwmpvVAaHmAle5F8q6psw1XGT3Y/OUfJmnijHb/tSvQvU6rLlz6UhU8+kn4hkYus7HYgYT5CNiC6KlQ5m1P39ltup154Qx/XrP71FiK+21LaIRI4cO+RY4xUkWFPwK5+qG2Si3JGLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENzOfFREHxsUt6sFTckoSAanzLXcBP1OTkKZ6vCfj/k=;
 b=ogCDRg1qo7oU91NXt+uhYdXqKZ7h29mZONgpKMUQo39/eBDnq85BUeje8uaiPstlU1Uvw5EwtbefU+eg8QbN1wZGVCKVBRmmNA8/4NHocJcS8PwssWlYtmygMkFNC3biLL2FovzQ3eFtT9vl55GtmauXFWJrlh4EwMuY/KIV/IM=
Received: from BN0PR04CA0131.namprd04.prod.outlook.com (2603:10b6:408:ed::16)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 02:39:07 +0000
Received: from BN3PEPF00022BC5.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::24) by BN0PR04CA0131.outlook.office365.com
 (2603:10b6:408:ed::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 02:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC5.mail.protection.outlook.com (10.167.248.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 02:39:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 21:39:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 21:39:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Bump frame warning limit for all builds of
 dml
Date: Wed, 23 Sep 2026 22:38:44 -0400
Message-ID: <20260924023844.2153715-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC5:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 078d68b5-9b45-4daf-2c6e-08df19e5011b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|56012099006|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: otj0O5OggvbL4riAUoa1p/7iUryFcWHurpdV1CtNpGjjGqFAZQonit0Pmby5BODODm3rL6bUnVoRW99KVkMrOrBFlBlGg4R8U5CmUXW7ZfJntN5PgMHgfosc/AymBwUIiGEWUCmaui2yPUj+rJtXKkxZwiG8rbaX/wOIV6rXseg1I/4O/hGF27MXzTVCALvtbGT67Ppkr8OptZCM6Vaioh01Q7DgzjyUN/GSLzVHP344U+sj8JU11b2Q/XuJuQTxaHTCi0QnJ+w6ULWJgVNb5o2pu/9+p/5CxzY6QgojjNiiSxfnghNtAmlXwU07Q5O2ReUxmFNBSrWNowNY+SK+cXnEhJs6QMCcTfHGkMtPtmnnG3yPSVzj9Z1HPHwcGrejeooyGjFOR6dbLwOUdTaYER8ITkvoD15WNRWLJ5VJENqaXFY6VYVM1mNciBfALQKRgDk8t0OfE/Dg8S7f3KDAXVWPvH6QmF+fm2Sgi0u1w6A0ZWoiVAU3tyodxxpO9o/4Dhc7nB7mGe9oliJcnqLHISVzM0OKR33BjoiHsZqv7CMMO7X8aWAXh6eBgSx/Z8pUZPr3NyyoLVxqBLVq1FdNvT4nzOIR57EG895uUD11h0//f2DPacpgFTc2oSrDKoeMpEtg8A9J3Hn5mkzKiRr+GHKQJrIiK+GRXvK0IwUGoOdRqOyBuTEedgzqp0Kt3pcxccPZSrgglUaT6Dl/ycNzyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(56012099006)(11063799006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bWMgu4CHpc1wxz5mo0mYv2ALqTUlVhFPH+b1ALAgypKTPzySGzn7zrhM6Epx//6RQ2M3t/Ts28egDMccOGnOVLGyDwoKb/Hc4XuRiHfBhT/89RUKWfBg7A1FF8ViLfNN9vyjI+nUhat7gNRbhsSUieQg+WdItqM1s0KzRK+HrD/TL7VBuuadXJ9mdyjPpyLNe7yfzCOqA8EgTqHayDayD1I2V0vigZiUYyT7WwZn6PDljUfSRW7CmNWK8ctXq9NUq7zqpH/ZwDF/zMM4skveHMJ2qo9LBsqbp9Oko3AlkEtZNjPOJLkyfdydZoegdVONTFv45RbsmnCCZD3BavPaNwVgD6k8A++mvj2sAny/5LPQPk6vMFgoR0UVe4KL3D5zrAfLPb53ndukbj5mGBZLd9uTheCBFfC044Fuq3ICPp6bQAK5vdRwE4bzDrT/62Wo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 02:39:06.6267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 078d68b5-9b45-4daf-2c6e-08df19e5011b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604
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

Some configs with gcc are also now affected.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile    | 6 +-----
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 79eeb3721b996..91465ac05c971 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -36,11 +36,7 @@ ifneq ($(CONFIG_FRAME_WARN),0)
             frame_warn_limit := 3072
         endif
     else
-        ifeq ($(CONFIG_CC_IS_CLANG),y)
-            frame_warn_limit := 3072
-        else
-            frame_warn_limit := 2048
-        endif
+	frame_warn_limit := 3072
     endif
 
     ifeq ($(call test-lt, $(CONFIG_FRAME_WARN), $(frame_warn_limit)),y)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 615cd0ca9450d..e8bd061be05c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -35,7 +35,7 @@ ifneq ($(CONFIG_FRAME_WARN),0)
             frame_warn_limit := 3072
         endif
     else
-        frame_warn_limit := 2056
+        frame_warn_limit := 3072
     endif
 
     ifeq ($(call test-lt, $(CONFIG_FRAME_WARN), $(frame_warn_limit)),y)
-- 
2.55.0

