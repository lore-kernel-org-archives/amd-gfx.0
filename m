Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B81CD2E9C3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 09:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2AE10E0FB;
	Mon, 11 Nov 2024 09:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3mSnw8d/";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6753910E43B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 09:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiGzWsxxOIQ6uZdo2dFO+sEhG7EESKj5Pq8quI+hzX2s/LyoxdsyzUrZ7PM3Ix8arKU5RSrionz5RcPP97LDlvM9uH36h4q+hwx/NxeZaBoA+/KkwT7eJcTrXLXH/A1VaSgs4Vw2A2N2BC15YatZ9lzsd6Gi5RvAQkEhy6zB5oVQgPiIfiwqojNayodfHNm6gYVtqJBFDkm8yUuJXH7ULnoC6Pl7biRgxlgaKsQQR4OlPdCqw6eMQlWFYxBf+DZplPaez3HKdb65IznSP89rUs/8lc6hcoiU6OV4Yd892knoZPvyrGQtyD17B6+nQXEyKNy0XnRGhWwoOij2xX5KHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOUg3qocHcOxZJC8uKv2ohMxr+AFW8/HunjgG/u7Y3U=;
 b=eKgb7kHG6PQNmY6TCO8yRTaLKYv73q3ZP1Tpo8x14B6w1PnTMR2lo7J49vxkhxTiCyIR0US/Zhu8CR1YtJmk1uwGLAYtHe6U4CqrSUAweLUtz2veuinQDWzeJY67e/IkZmcDoLtiynVWDIOVdxeGRo7k+lHDNxXrNuLag1e+yxhykyGmDFgOE+z+TmrIUnpVcsxpNhCvhr7p2xKt0E0ClPZhtmIqi9iaCOWzMkKj+6UP4SRDP4VOI+OojhmrGy0sgoAtur092MfvP6MMrtH4wRSXDhsvh2zq/mEGBMQfBpZckzGsY6I/9d38fS21DahCVpQsU4vN7SRusvKqup6GNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOUg3qocHcOxZJC8uKv2ohMxr+AFW8/HunjgG/u7Y3U=;
 b=3mSnw8d/qw6828Z9RrxfMlGXoyrANHBluoHBFAWvSTRMVi82BphUpXm2m2dDdFfgipdAL9Fv5NH6Vmu7kM+ND9XmWBtGo1ABtaRfg+5P6YW8nX+yknMNRv8z7saCyd1FfIN9MplR8hJMBAAkKUFqwYNYYUhF2x0Aln367XAOnMg=
Received: from PH8PR07CA0003.namprd07.prod.outlook.com (2603:10b6:510:2cd::17)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 09:04:18 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::33) by PH8PR07CA0003.outlook.office365.com
 (2603:10b6:510:2cd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Mon, 11 Nov 2024 09:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 09:04:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 03:04:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 03:04:02 -0600
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 03:04:01 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix a mistake when removing mem_info_preempt_used
 sysfs
Date: Mon, 11 Nov 2024 17:04:00 +0800
Message-ID: <20241111090400.229503-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: e54ec0e0-0b08-4785-1de7-08dd022fd2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EMteMN6iECSIvSuvoNUVqlylODv/XC5nZP0OnDubqEh0SzpeIz7eXHj8RP5I?=
 =?us-ascii?Q?S0vqcABv+2h7aC7KmzE4/JxRlrTjdKXg9caZCEL+pzeLsjnzuXhik09Ia9iE?=
 =?us-ascii?Q?zs77eT8iM2POFqyMhi3sEBX2O3fhekhFjBwIGdVIb17FWF6qNtacuTUTJLtu?=
 =?us-ascii?Q?sn0S9/QLS0ARbfBwDUyncnkE6TgwaGD+yEGbY+Dakmu0LDkR0l+anct4au8W?=
 =?us-ascii?Q?47V+VP6bMsLlH1pEiDyYhs7+oF+0BIfZaopQZWisU1QAdw0W6iAoXb/R9qbE?=
 =?us-ascii?Q?c3JSwRehWwDKlGgQjEY/ISoZFIotpUgac+x2f4jF9NncWiwcNj54c5MX0oaY?=
 =?us-ascii?Q?Jclwu+IhyLkOiTCvUILQNQhxS/ktRSby/0Hf/IYCQwXIeZ3SI0j+7vpimtkz?=
 =?us-ascii?Q?uPrSpykEc8FPfIAuaBVy4Lob0fxQs9/hrsxdjIKEZhEdbqKE/66wtfeByraA?=
 =?us-ascii?Q?y8AmG1p4JkL1i3PW6piZu6wR+MBP9nTVK0dC2HTHNgPF8jv7ux/9EebaoPA2?=
 =?us-ascii?Q?u6uHhPrbAyW2Be0FLqWV14j4qGoOqdW6J4YqaV7e/zEJvitWa8dudVFMfHt9?=
 =?us-ascii?Q?C3YxB3s+ZkoWgWbinbdssagRebL984VKkiuF3XgytYs490pw0j/7/riesxPB?=
 =?us-ascii?Q?Z7KG34rvgQg31llEJS3WRF120QUKiOiD4yrug/EXbh3oWzqFwY2AUFMbeYGZ?=
 =?us-ascii?Q?7scMJRk2ihmlARmJgyj8Q+TYVfLgED3UMsZLGRUum7PBq1aiZEPp3inzbLVF?=
 =?us-ascii?Q?y8UWzF6HmPYRkOt5kK/jQbRwbwUQJztY17NB0EUxOKYNXCHzee30R1RwVxGE?=
 =?us-ascii?Q?TYcq7GvTpY/ySnnQ+DqE+2Tsh90FXnu35bc6c2HQm9Jj4D7+adg3hgqqkGEI?=
 =?us-ascii?Q?cnklkmpIA/EYwAw8nF+HUN1nGXsKGoZf80hwgYdeVjcnoJplGnwmgSNC5+FG?=
 =?us-ascii?Q?DHWDXOOmbif7jPm1HYLGd1+O13LG5aCoDP7zU7eb7he2kRSfchVO/sI6RI0t?=
 =?us-ascii?Q?KcN6bDlVn8s+xHlUJaWKxgpV+RC2J3OnCvynfSd1dHDsTSUlgF1/44RwICh8?=
 =?us-ascii?Q?0DLN2HwMzTGt+AQh/fIlETuZfIpqqjLUbBvfBXbjOk6Rh/8LnCBB6cufDU+O?=
 =?us-ascii?Q?O7LdwQ9Yq3eIjfDNbtGh22Shkjlxp1a6r6ELAecSNbZOTyOkSOWkg8DEw1YQ?=
 =?us-ascii?Q?50kuVISz6Ygh19FHdExZ2LR/GjEBncjIHya051+NGSEP4rWyZtHRNJkl2l2w?=
 =?us-ascii?Q?RFEYlxu6OprGWb4OuTrbFCfEl49WR/KNTLlm+JTiTKt8k/PKSe34VP9Fh0qt?=
 =?us-ascii?Q?7eVy59rlLM1vi5uXG9zTBVEmUPmuxffnQ8eTZh6eDBKSvTeRaN4TSo2SsPPQ?=
 =?us-ascii?Q?ibSjGIoEKAyYwcEVh2oRheYzvQ0Sxm6GqT8EExhuCPwSzjVXOQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 09:04:17.6931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54ec0e0-0b08-4785-1de7-08dd022fd2bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

Skip removing mem_info_preempt_used sysfs when unplugging the device.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index 33a714ddfbbc..9a0346ed6ea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -138,7 +138,7 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 	if (ret)
 		return;
 
-	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
 		drm_dev_exit(idx);
 	}
-- 
2.25.1

