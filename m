Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA6AC5AC7C
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 07:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041CE10E18A;
	Fri,  7 Aug 2026 07:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4+ihqpf";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCFA810E18A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 07:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlCBky/F01kUkDInRqEGG1qRqIiUlPNArR95AV+EgZV7+Z6714Xa9JTztBD3pDm39T2WENxsnN6ptjMtesawGYzk8r1zX1lVnCdBk3XOtWcaN+/7cyThzt/PPsnrbMOXTYU6JvaEbUFaFnjxTG1rL0WdsCwBclsgebGzI3156yP5z4cIle9sR0U3s0OZFM/lzPQPkI29Qi5hjiuxFbWjR1kACTy1JisHMTyZ7UXpvivGr15TJbDMEKov8p3khypTtD0g6LtaPXEJHiq/Q8yufscwqZ41wALsie5qKAfMOOv2t1NPaguax7z4TBrdF0L5T53XyVg/K6Dw9ttBIEcg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c02kkCNwKPi3586cdLcG51giVW5boC/D+jvRGyyjWeU=;
 b=QA1t+c8KJbR4yHICJgV6LabIBvXJd9S5s7+PfdbYzQKQXbZye0EhQN7yV1LLaTwKxI3iY5cOPmb6jLm6m6auvWXougrnW/Q+C2pvebvJoYKHCl5R5IcQ1HDJZxDRmaqTlsB+90DH0N8aR47BFrpQTTMuQbI3aymstZBh0OriUcrqGp1wRCta3RxEzagOzhdJAf7p9qu95/dVJUb3B5Z1Wps8XBEvYcGi7wlUiliNDfK7bKXJVL2MeLzGZGkUrSA7BBc7xSKxm9FBvhe45CHMtmVYrEJ+n+M4p61WNLdhzX1Rlc8DyKqbDoudGnYmW7HVx1JNKBteM0q/32hj0bWP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c02kkCNwKPi3586cdLcG51giVW5boC/D+jvRGyyjWeU=;
 b=N4+ihqpf9MbCMZInZEi7cY6wDGAkR2D+aJybsnjM/p6kzeLj45ZOaoQUvrJ/xgQAxnLFbuMaYU/QHDCY1t4lIGKpP8GpbT8UMRF/5NwUYBEQn3ujI90VVZBRTPDKyS4U297GMxX6/8kJYTv7KT0g4XsIMpCn7cjjfng0so0dNJY=
Received: from CY5PR15CA0091.namprd15.prod.outlook.com (2603:10b6:930:7::10)
 by SA5PPF5D41D38AD.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 07:03:45 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com (2603:10b6:930:7::4)
 by CY5PR15CA0091.outlook.office365.com (2603:10b6:930:7::10) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23
 via Frontend Transport; Fri, 7 Aug 2026 07:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 07:03:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 02:03:36 -0500
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 00:02:46 -0700
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, <Lijo.Lazar@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused by DPC
Date: Fri, 7 Aug 2026 15:02:37 +0800
Message-ID: <20260807070237.1169684-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA5PPF5D41D38AD:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0d02d6-8c53-46da-604c-08def452057e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|3023799007|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: IJyEEXDkfEzrBQ9IPdYvIDDHqOjZmbpc2DzUzcrJ2S430HkoXBOL4qiihTVsc14QfeQS0orFbRa2yEvFOMJTQruwpjkoqHRqXn5CRPF87LqzAweGLjktuFumpwT1k9Yq8U2dFzmYAZ+FTH2OhjXnPQ5VpXM70oMvi6K2MzVwju/foYjEest9DNGtavLPgQmb1HWHPz/78ZdxMN313gMmYryaN28dwE0r2hxXPR9URBAvrkQGCxy/O8c/bdFuHpu6zDRrGk6rc0uySbRgDhW9WI6ZGoNndY/T0WZLkECbFLCF+Si8G4seOrLd15tBEnZ0L6ijNkyDAzxcfkBni6UUDkO0M78Yj1Wh+ZzFSoEnBqHEl82iZ5H5tPqihanoT6Cb2Qd7HNiHiciaqcePGjddNuT3q689E0/p2ogtTqtgnI9KUP3h+KLK1FtlB02WIDj2Nu9kvswAXE1QBzZSHY5SFKPwNFR4X7GrO1c0h/QEWA5017NRa+tTIh6dAzKHeoHxUq1UJwehvYybmlokv1wzz2s+PfPXOGlWclBX7Bzpvq9r8oy3HmWpQza3VS56sUagoLVNtbBipW8N5HyWmP+Kr2USfKqRvmbz2qBsOel77F4QYwimGjCqU116YRHImMuFGGl0Uhajon7WtX3NxFIskdAMRy5qARa6sgpwm5gAofBQ7xrxgrU7UwlH3E7ENggxo6tsXWmXVmJZwdwc4VlKWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(3023799007)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7NErfL5FzGsKpaNF11IvyQzh4xW0i39/0b2tew0iMwdemS3VlKFl5PZxSoyLRNJBv5ZDt1cZBWDO95l1fYV2sqFxLduSadSidTEM9XIiSXtxu7gXzTfifZ+CMFKqAI1nzNZISyouJH9EGdFHaAqBRoTLfGjolaLJFulZZPFx24VQ39w24jqjs9X3uXShUbnxVLHBIQvhmESgvfBG3bIHSRSEwSlvxjg59HA72vMxB628ch1NgOReN2VFraJA+GX+0YdvZIbjwVPZ18em/EtYja1+gTNcqLrqsC+8XGFW6J5eQX05pX0U+mQG/AB9+1jCF66JIA7TNVzNCYpPGkCtFWz8yvD44vuElDHtmmlzaXFwMm3xT4wL3S9jlaUxVytvO/t8X046yFw3H9msEoBKE6CVP+ZoyowzXZNtzA1Jnuv9VuZltIYKTh22iCMLjqc3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 07:03:44.8970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0d02d6-8c53-46da-604c-08def452057e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5D41D38AD
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

When DPC events occur, the GPU bus becomes unavailable and all user-space
operations should be blocked. There is a timing race where rastool may
still send RAS error injection commands to the driver after bus loss,
which leads unexpected failures.

Extend the readiness check in ras debugfs write handler by adding
amdgpu_device_bus_status_check() to detect bus lost state. Print warning
and reject injection requests to notify user-space the function
is inaccessible.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 35eb87591740..4943be034c80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -564,7 +564,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 	struct ras_debug_if data;
 	int ret = 0;
 
-	if (!amdgpu_ras_get_error_query_ready(adev)) {
+	if (!amdgpu_ras_get_error_query_ready(adev) || amdgpu_device_bus_status_check(adev)) {
 		dev_warn(adev->dev, "RAS WARN: error injection "
 				"currently inaccessible\n");
 		return size;
-- 
2.34.1

