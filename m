Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C726AC48BF0
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBAA10E68B;
	Thu, 15 Feb 2024 20:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0k+OszQm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308AD10E4A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGI/+auZ+dt6gojtdV6ZbnyfeZYGNMAU+LqdaSeglDDYz7GvB+2bmOqyP/toPKcki4Dnu+fZFV0ksAcHRtWu9zD3mbotvSD/ir2BzSC3yGX2ci6pR7jW3FsowRZve27x+BM8qL5EHXIse+2cfYgOMkyzXEgtEapDgMU+wx1NhpVrve1sW1QtCjLydpqhEQFPcDBpSaJtu+fL1KZHudDQkF1BSkLE5LNdCc/xpyU1JXrNI7JlPCJg9uIVaLmxLOYEi11GZqDYvl+CzMjSsec1/P3gNNzDwFzdts14vSc/wDJlxNmxD47P3lt8n1DwpElHBO1fWmHglrQ1ZNxKma/VAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siLNfPTqZGSBQ+oHW7t09TRJvh1Sw1ZyVR92mvBpsIg=;
 b=G/pi38QsSuPO8C1Sld+pb/4isq9PRjsLfnS+5cvP/bHO2f5uvu6ttDS1WbH2nQ/AWtEnZhwEeikdC5LrfPtXzfgqDH8QDrcKi7j3UQbxdu//ExvZhY7o07Pl48zTR7rMR3HN9Y9zIbJcc2uXNSoFt/J4t2KBKaz5bfy4ldwBH7ShySjT0sSDOr1rtlriSLTJlbIIX6CB0P+lepeOl0rWyLi857A7mymFc97xnpc1xROVFkBt/lKNKHH0gb0N5Re03Tvx4IQTkSFmJSksOptDcAzVq2XqojA6HnbOGxW2oaj2rTrUfjk/fU/7ppWCOwo8jMQT2jZ++DzMDK1VJ4M68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siLNfPTqZGSBQ+oHW7t09TRJvh1Sw1ZyVR92mvBpsIg=;
 b=0k+OszQmrHje+Ge+SqGyu+HJsV7V/IBaCmttRBj1SC+BCxYSJWq+Z6E+QLV7mcjYz4JgsJdyUb47WXbbCb1YrMGS0TLrKuIb/AMb46++A9TX/ydTzTJJqWs3ApvLW1zGz4GJC6rlSoyMEM8z44iGGmFdsDPuyKzq4CwiTC96ivY=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.14; Thu, 15 Feb 2024 20:40:21 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::aa) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 20:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:40:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:40:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu: add imu firmware support for GC 11.5.1
Date: Thu, 15 Feb 2024 15:39:49 -0500
Message-ID: <20240215203955.415314-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215203955.415314-1-alexander.deucher@amd.com>
References: <20240215203955.415314-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b7cca8-1e77-426b-2ae4-08dc2e6653f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p42MKYlhJtL0eqa5VkWb22Kf+AJQzQKVQM19+iuVZ/jkqx3pdDyOJ+pfBjSaWmTam8tFk/3TXq5RCle1G2bfBwyVJfRL2pdNRc8ZheV0erZTZaE8P1yzsyGWNndWKWzVwxdxypeXfK1NqOMiPBS/bFitsURQwQOm9+B08Q245RURqc1gjZkcBuSh0iYP02lIv2ZO+90PwREo1NfQOu8c51JdN2ZJbnZcsQOvuCHRUK1GOw1SGXfJenAnN/e6J/c+QU6MhZSUNhjrLSnf2LE8JOnX34GS5tWhA8116tLBEwH93zQN9dZJoMn83CIGap2ugrFl4C5BB6EyiF1J/ch0VKtqvyP+JFyJIIti8XlTCsFa3GxBP1C8nRfPx9/GXXBGFgyIgMTLcscxNZfDbCQKwPV8KSNnfSEv8PGA84B1sORXZHmV/lduhoaD8P1y6NWLURqlrFyx6KudA6yJD3uvX3WhqG01x0w3zPQXV9p6tCMfw1QxjjqRM5qxgDl2Ji/sQuibpmyrYYYAb3S6oUrWzVhgMoXv6vuqDVSsIapFnAdVhQ3awV15mt12QnWVTwSXUxB9QXSq6cKF4DH6qPjY19cncAiH1Oc2eDVDNuzrrWTKNb41y6y+oB0qyF6IXmdX2P4YarTAOtTbAOz2ryL8al1UuYXbaU9CYjDGs8WxdgU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36860700004)(46966006)(40470700004)(41300700001)(16526019)(2616005)(1076003)(426003)(336012)(26005)(2906002)(6916009)(8936002)(8676002)(4326008)(4744005)(5660300002)(70206006)(70586007)(478600001)(6666004)(7696005)(316002)(54906003)(86362001)(36756003)(81166007)(82740400003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:40:20.8741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b7cca8-1e77-426b-2ae4-08dc2e6653f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch is to add imu firmware support for GC 11.5.1

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index c0bdab3bf0e4..3e91a8e42c21 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -37,6 +37,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_2_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_1_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
-- 
2.42.0

