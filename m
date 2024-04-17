Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64629C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 09:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60BA113340;
	Wed, 17 Apr 2024 09:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4G06MwmW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59041113340
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 09:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WO6HmPrfj0h812x11xc3TGYOhieOuBvN/2gKQG5is2lMLUHKSkvN7f/8LFYiglcZ7MLIzWn2Wi8GeC+gB0TI+UZv6vUOsnLB4GV3AqMEN/bLrlvxGI/E1BgwqTDMD8hQyZbo1zrV+f2twHPx9k3McCMaGVtxb3H05XClCBruEnkOljrpaSb72ncZmYGBlOUXjWMWodCu6aStdsQmC1kq81BjOusj80CLaXjiG8QZU8xINfJc5wfU4GL9hwWk0zZo5idnxX8NydR2wo1y1mQXl1Yiu39qTHsiC+s8PJS2u8u3qlThuXWh3xhcQgLgc4ffEZ4VNXTNuwZ73FX5qJK8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwTxGnLXxv1NYUOttNeHPeuE+ouAuhFcHyPviohGlzs=;
 b=HAYvExK0xOPU6fvqzDgXukiOqsa5N14xHD7aHFNpSLbHvR7PzFemGAQUfYT9khve6djTgp3XEeUycOmXXFm79ek7C6nwR02sjsI1a1mRCtk76tBjNwgZN8eSyp+JngFBLZTsZqfK35isv0Jj8Gi7TAg+WDwxJuclZh0vTw7s0A7FKbugLCj8qzbYhKytKbzfp8GoQ1IE0l8DDtwYi+Nhp/nO28M6Fbdpc/UoGm+k1wQzRPWSnt4lpGIULwg4QK7U4As+JMZEZOwtjKrx2fTNAyg1VYWM+q519DHlM7LE+TsYHa/F63Y9CUrNRptXYAnlGpKkThp/OuLn1Igi7nOF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwTxGnLXxv1NYUOttNeHPeuE+ouAuhFcHyPviohGlzs=;
 b=4G06MwmWvdfYKnzAWvFdRaNoGml9qgnOESwjVvg5WCl8ye6WT2oADGDP+c9E1ofabuJSuO5QORBQh8nFUMlRJNu/ALOvJrpGG10mjrYUtJqFTs2SXvRIGHOLaHqFhho0HJ6A0f2O4iPQXEloM8lXYfgYgEE1ZJ9+aTDPG+Z4Gsw=
Received: from CH2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:610:5b::33)
 by CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 09:41:11 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::78) by CH2PR07CA0059.outlook.office365.com
 (2603:10b6:610:5b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Wed, 17 Apr 2024 09:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 09:41:10 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 04:41:08 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Print od status info
Date: Wed, 17 Apr 2024 17:40:46 +0800
Message-ID: <20240417094046.135294-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CH0PR12MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: ef01c885-35d0-4dc1-c7d7-08dc5ec283f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnSkUljH276pAX5KCFiFZUXmy7iMuH+K5FiGrQz9izNVDNsp1S6reUI04Ld1sD/lck4YrURqD2F4qniXAuKRq+x0ENMzBiedcoN0h6MBMDsttyl5vMHUGWGqT4pq1FEwqEYoA8qYDYRy46VCMbdKLBg190wmAghM4avCuNocWqx7Hrrw2+XprQMT9SvotDL3AYo+Ycw5QemxcUqP/XQVq8jTVR6E/RmrQMBRZHxqgA3A2T8BJL7C3YgMrA7dREk6vCx+7+5kUyah5xrl2Hds8NJK01xH1qgwiMpQa8UGFucdTBw9boi1taUJ1o7N2RcuTzFOaerjOn7BS1guUVRYzJiFpKE+R3ZjVnpc3EHP6IuHSy3AC1ZYoqX+tIL1/VQSmB/XsDaD86nK65u+hOqBbtNBk6gs7OLDzRxF0vwaTBMw2MFESQoz0c2px5vnlSR7niJmwY0REsb7CCNB1GZ1viZAd730M5gK6xcNCtGduxt2+ty9/HwdB8bsxCEV1Q28LpCUimqyUgqDIn2Y+8CS4xSkzN7xEbJjqx9HNBhXGhApSUucXQhPIsoHbfOlmfXj5sErZv3yaPQwLR5AQEusW/1/wUM/p5vGTRaSPcy4G1noo1nkAUAmn3HPZxNHA2xjpSKhMxZM0hq165HNQDAedKxdhIOQ1v9o+WihYnHKOEzRHYvHFeuGhZYgoIpILZeSwNjqIQk1Zvuvx2fX76Z7dLVprGvoWCcMAKbRwd1OqpnJ0jN/XrTVo5u7OgsgiSfR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 09:41:10.9247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef01c885-35d0-4dc1-c7d7-08dc5ec283f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530
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

Print the od status info if it's not supported.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5bc1cd4993e8..a20e03e69d38 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4399,6 +4399,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		ret = amdgpu_od_set_init(adev);
 		if (ret)
 			goto err_out1;
+	} else if (adev->pm.pp_feature & PP_OVERDRIVE_MASK) {
+		DRM_INFO("overdrive feature is not supported\n");
 	}
 
 	adev->pm.sysfs_initialized = true;
-- 
2.34.1

