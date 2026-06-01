Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444C5CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8AAF112DE3;
	Mon,  1 Jun 2026 05:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c1rt3NrV";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 033AF112DE3
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiT5UbXkFPhGRVrCy29jISRbEbMuplhEsSmcr02j6B5ImaD/U5CSkVKgU4OWdHyJiuU1qv7oUvvvd11R7m7f/OwWvSX+PMsWwLzqBm0YzsU6sekLJodHwjFecSEDBo30UNBueh9jUyk3UYtr7rWUCHjVq3KmAKrdMtwPrY/jHKvl9P2hKx6Uvyrpz/6unuB+ust083OJgI5TTniDR34WlhpCMjy79JM2jTqp9ZxCeWOeRPJMKlL6c45oQjH4dSkBa0H+cv3ojfkgbNDEArXLjEdvKNgVl4GSCmCPaIkNRBIgJDhdHPPQlh9Zxuc+1H90ewKPqQ5C/E8gORaHClix0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrDYDT4q2pVEhXFmcSnrMIwcB0kujHh9cGz96QEG4/8=;
 b=X73VGpXU8eKiGpPHFc6CCJXknK0a9MuTylXhrvuSfkvyjU+qB5aaHyGEbSgnvQDmd75YvtXx9H28WB1qnzftPJzCmvizgcw+uwPC2bb+D/Vbp6m9j7t4sgd6gIHyT30mQGBBqlw4vTVvVScQHISJZ8u8Zfzgc8m3lPWB3soWdik6T3uOAWZc8sQbIWWNySZ2gps5mWZHc/z05Nw0YvQ6DXGypmL/nzdp7wvPIynjAQKy1rCzHnsN3cKJggr0TIlsrfhV/4yiiRbSCBoufzJm7pLF4qoshUxBFeF2T/Pmk0406zTazrwNlfV2vHLRXzGzt4VaE4p+WqimSn+BThuiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrDYDT4q2pVEhXFmcSnrMIwcB0kujHh9cGz96QEG4/8=;
 b=c1rt3NrV7S6i7spI1nisMOBgqW8Vv4yCNOQIizdr8cCgicJJDNIcFCEJ0F71PUGZIxylfomPxNhrqf/gDomxU3UAOkfBh2hG2rfqGmORvgnRQewlnQsMPClwp5Gcrqe2q9glKTmVDu43sOzpl0aoXw7MWhiVfEYFRbVmT9bTIjg=
Received: from BN9PR03CA0107.namprd03.prod.outlook.com (2603:10b6:408:fd::22)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 05:55:43 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::4d) by BN9PR03CA0107.outlook.office365.com
 (2603:10b6:408:fd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 05:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:55:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:55:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 31 May
 2026 22:55:42 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:55:35 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 42/42] drm/amdgpu: Expand MES queue/pipe reset support
Date: Mon, 1 Jun 2026 13:49:28 +0800
Message-ID: <20260601055034.3700921-42-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: a4959978-be2e-4d23-f584-08debfa26aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: MWNg3ykkzC62YUNQ2GRB/SCvkpqzpCB0Zxuc4OuOJNHV4WA8c6fQkSL5zSCDlPn7y3bb/SipDPPNtF8FUPAlW/o2iBtoek848PYlF4sMl8+No3Fmil7M4suRCPiC4XKt2ceC2tgKQBRTcrMt2lmMZR5LJviV9yA6YzJwxDSbMA3RgNUcHP2u423aHL3OythUtYfR0zLIrIht5hhJpEORUS970RhoFg0+c6Q3o672p7NdKhZecBRWmDbTtD2twG2L8NFdDC71l9OEKjU9XaIE8/KrRXPPmK62B3Bv1ktBQKKeZ2DJm6VBuwYwPQSxyPb9kBJR5yuY8m1Tas1DMsAqwn1DxgYl+58hGT2xDWr84AW2+9Vc/Ep8SnNBhf7zja74fLgEm6umRgFLvkyVeoG/PM9M5+S8RgWADpokAmxOUUzt1mtfUU5MDWxu/SlAli7X60jNdt/iLkLoC4mf/oco+tNfJBQoZPy7zzLUxfLiOGV8DnIgWPKRzG17eviCa1EOqlGJhFo5o4BQ+ntPVRVD9XGzR0v/auzDSVH4bwhstbwVj74dzCheEt0etydaPqcJ+deoBMctQyKacYty+Op/0K1Y3tgXs3P1GT265+zIwAGKgQWWp3RMpWXVwsnl+SPae3MeTxbdIYRaZFfZLyFazdnyODt2Xo9XGA5+PnZxiMHogD5taOyLjvTN5TWY1ME4D8W1TPXWWISh15oBt+6brti5jLHree8eEqOC53lZYLY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tx+2HME4PrPq+vMV1ZtMi4IhCzRByZfdHpmuP/2TrC9XRDmBCxm3DegsYAT9i7AzW7xROjV54IsAZaiq9U2D4n6M36Gg92LEcKuW0zNhy8t7KCmJeWeXwNe5nGyxDsTBukelu9HigCkv2kzgvazJP1ncuI0r+UGecLYugluyhzsrOi9LX33bmOjV99wwNOW27LWVkChaFaPC7uJfXhcai5deud8JSKmF4ZLcR8vaRv9RfnSL8ZeTrvq1hzAJssPH8EE7Hamjs8DhErYvMkczGQIWwMw2zbpRiaEhuSH7bKPon9nAAhUVVQseZfBzDrp4ZHCa3nQoRMKyCgLCL/X1cLtI25jTiYU655+k2f7eZbFXUktX8qDCPiPaA3cP+FXoYvZHTBepUvx/h/G0DS8fRHqA0lFweilI5eNTyUtzVJlBy8BWnx2BawhEJa+0R5zS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:55:42.8157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4959978-be2e-4d23-f584-08debfa26aad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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

From: Amber Lin <Amber.Lin@amd.com>

MES in newer versions on gfx11 and gfx12 can support queue/pipe reset via
MES.

XXX: fix the version numbers when FW is complete

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index ec4d9a1e029a..c65f893815c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -853,7 +853,11 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
 bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
 {
 	return (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &&
-		(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x73);
+			(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x73) ||
+		(IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
+			(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x8a) ||
+		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 0) &&
+			(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x8b);
 }
 
 /* Fix me -- node_id is used to identify the correct MES instances in the future */
-- 
2.49.0

