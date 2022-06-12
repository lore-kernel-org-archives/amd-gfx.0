Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59F9C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jun 2022 04:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7E210F2BA;
	Sun, 12 Jun 2022 04:33:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E7610F2BA
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jun 2022 04:33:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELhRhNX+vIA3wmexZAtWM5xYtNxslL880b2diBp+5+Aao5UyqeVHIj1yKiE2MpjjTg9EGt1pWpgQFqLs6WcbbsDkAoCMlGt7xSnxQxI/3gHfQ58VC3Pk/R0wWtn1/Yewna9Ok5LmBGVTnNi8UaBt6qLtz797lKvR4w/BQ22fywRaCKZP8tHDt0doN5vcK56wj8RLOqVKt8bTWVhPEHJBPorUuZHOkj3ewWSk19vY3b5qFwYjF8P795iUu1WzHCOR589vuTG27RetB53WVATcxgKXGX8QN9h36SX1OT7BqS82zkhWOsqTskV7Zpf+X4lzuaYxU9zAwYoGNV1sskrBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZkY8T/eNnhRuFKTjo3olx6eA7s+ngBZdw5GRQxrw/M=;
 b=Ikv6wLPWlIjM9GtLskZG0G/N0PaBuIh/H6DFRcVoLontNwig4I9XWEN+H9xdgNpdNsTTEexizEy1gzpX8HsONXd/uRPLSF7qXAjS+EWQ69tGEoLP+UjVUa9X0Vpi91Tn8mx4IhCd7x4MSPiI5BXZGcuCr1ME5ANV3UrZ8Zm+Pucl5t3T0PmnRKio99p2c2Plj3TLPk1GoEoK1JWzTfqbznmAgHxanVhwo0AuPvvReF+15ClKT6Y94ES2HBkp2Dg4vVU0TX4JmJNGpDJyW9UUnzbU9pJyTvKv7a9uzYhrmciVPqXfW/4V8drceXXJXQlnDOQtKgihi3y7YXdL4oXRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZkY8T/eNnhRuFKTjo3olx6eA7s+ngBZdw5GRQxrw/M=;
 b=Oezd0Rup0HeFKJyE0cHJ7StLErB/y+DyZ+pd6pDX5On8PL0V+6a4IKrLJqzO8EbHbvL+M/Lm9x9CV1DdO72+uHhH59kCeBfOm2w6pU04WM7xBx8XIbUSGJk+pxPG0nXbuKwkwEUQ53ppF1/k5E4HNz/HvmlD7pbpoFQZc7+1KaU=
Received: from MWHPR1401CA0010.namprd14.prod.outlook.com
 (2603:10b6:301:4b::20) by PH7PR12MB5736.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Sun, 12 Jun
 2022 04:32:57 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::1e) by MWHPR1401CA0010.outlook.office365.com
 (2603:10b6:301:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Sun, 12 Jun 2022 04:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Sun, 12 Jun 2022 04:32:57 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 11 Jun
 2022 23:32:55 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove redundant enable_mes/enable_mes_kiq setting
Date: Sun, 12 Jun 2022 12:31:43 +0800
Message-ID: <20220612043143.2755859-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cccff54-98d1-4f99-e5dd-08da4c2c9ff9
X-MS-TrafficTypeDiagnostic: PH7PR12MB5736:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5736A155C2CDAAE5AF2BCFEAC1A89@PH7PR12MB5736.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJGi3bMXHHJl1xewaPnInhEBxzBnGH430OBbuXl6wB0tevwhV65xOGvaG5GH8f1HZ6hMbn3Kvsjcy9iXHgAfNp0eJMM9NJRgr7dY98kwZTv/utIU8D6fCMLUZ8r8+yLRoBlzdhFO4leLK3lUcwUdEQPQbBnxaRBItAyLS9DqWSPsNwwYSZzDHf0hgNHdUgk7lfpe3Qf75PdR1j9uvxmDZu+uJ++f02JSg6obGiYfaLKMfzQUTH9vYPT7dzBZ708ONYkiR3XFt2fbHGR5Xh3xgD+PoLoZJSzX98WKT1TOUJA8hb9Iqn69OzuNrGL/MbuD82KPO5nYS5QY96ywQ5BKciC5XMm0zef1WGwn7HWUkw6LiII1V4hQPx7p+RR9muJ56CFawLySQaSO0WgZh0cCzPlRxDLICMWnwNJk6q2FlTaidrErY4AlTs5htlbCEJcjCp3nuTIQG554A6dX6nHZD7qOEzUCohRoniJgM1MfC8dvCJEg+HC785A3gLDI5ZVPh6mL7X31SjrSnKXNJ1bHlKwlbI3jI2l4RE5x46U7kLBjllEmjidSQU9uVB45UxZB8iao3Krrw2/77YaNZmxJSQxNGuIeqfAuwKJvWF7kNCp54ia9LBsJgXpjaRCCKj2zvz9+bBZ3tEJdFgWHScPWBTEuepcliOJP3cIeI59+BInLHETe/vjwCDdr/H53SpENu1k7y0EHfIXxuoyroKFKrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(1076003)(47076005)(426003)(336012)(16526019)(186003)(6666004)(7696005)(81166007)(2616005)(26005)(36860700001)(83380400001)(356005)(5660300002)(8936002)(4744005)(8676002)(4326008)(86362001)(82310400005)(36756003)(2906002)(316002)(508600001)(40460700003)(6916009)(54906003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2022 04:32:57.0854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cccff54-98d1-4f99-e5dd-08da4c2c9ff9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable_mes and enable_mes_kiq are set in both device init and
MES IP init. Leave the ones in MES IP init, since it is
a more accurate way to judge from GC IP version.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 68a53528089f..2b92281dd0c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3614,14 +3614,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_mcbp)
 		DRM_INFO("MCBP is enabled\n");
 
-	if (adev->asic_type >= CHIP_NAVI10) {
-		if (amdgpu_mes || amdgpu_mes_kiq)
-			adev->enable_mes = true;
-
-		if (amdgpu_mes_kiq)
-			adev->enable_mes_kiq = true;
-	}
-
 	/*
 	 * Reset domain needs to be present early, before XGMI hive discovered
 	 * (if any) and intitialized to use reset sem and in_gpu reset flag
-- 
2.35.1

