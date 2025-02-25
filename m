Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADB3C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE1D10E56D;
	Tue, 25 Feb 2025 06:38:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zaWb2aSX";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDBE10E56C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYYmWe5h5VAxRsSaqMMBHxNPhqDHBqWnGNMukO9LxZhuZ6abAhIw+No0lEOb7rNdMUP7yHRCE0UbzJP3h/qpaKs6or2yxqnQK4P9w+ID9xR7vIHeKBGGHvhC8zkPRogCZwydY+Il5iA+K011UeXf7Zns0+ub4XklHIuiFm8ByZ0X61wJt7Iei1gBjH4abOprVrGnXVa+2dKegjo/fO0sxgkLqDmrmOIPgjQRONfyfWCPNQEi2eu4ECYUC66H6UCqC0sD1Zl9Xi47GOvW31JT0KX4tQ5qDa1KhURw7LPnNEvKp3BbeUWt9UHSzwxxwQpZ5QXNp6vAloJbMEZLC6/d0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYyqbA6JZuAbSE1tF8jVnjkEAq5bLUyBrUgo7O2hcUI=;
 b=G8Z+qfAbeB+a0yKL+4AMszMEO/kY1SM2sKkv45j1gkQJ7nyliLuQW/mYJmspNrbYpPIVzkzdHjtlO0t9EHjqjW+jkkFZEXzqmCzB4Oi1CHLkm1rrdODmMMJux0VqPGTRNyc5B4Y7c/X7/w6cmnt8c7/6BE1cP2ISxUc0VWoLCwVQpjQDRoRECGv+qtFwHcDfWaCVisWy6FK+Y/C4vRP2h3q0hLkpra71E+F5p1cOEZUz9XDcH/JewgxYXx7UMo6jey0/rXQe4lnUKNCIacpv6PKI8QpeWqmpQsUBhmi5O0hJqmlZM7qUhHfb9pt2wdKQRGUb7K5/YN+XBPd7dV3axQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYyqbA6JZuAbSE1tF8jVnjkEAq5bLUyBrUgo7O2hcUI=;
 b=zaWb2aSXH8Kd98nEPDavsppuAb9xZQQ6gbPJnDN6xqBmodiBemrrVVNT5xPrxroBX4xpdzQavDpYCtPuouqD/MFEIxjzN3S7MV4YDHYNr4go81+s1papcdxa+jPW+YODDPkUqQbHpj1MnCRVv26QaYIW6PcutJkDUy1BAFKnkuo=
Received: from BN0PR04CA0138.namprd04.prod.outlook.com (2603:10b6:408:ed::23)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:38:27 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::55) by BN0PR04CA0138.outlook.office365.com
 (2603:10b6:408:ed::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 06:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:38:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:26 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:38:22 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 23/27] drm/amd/display: Use scoped guard for
 amdgpu_dm_update_connector_after_detect()
Date: Tue, 25 Feb 2025 14:36:06 +0800
Message-ID: <20250225063610.631461-24-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e268d6-2933-41af-06ed-08dd556702cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r1x788uOO1fIW9QX6P8ICBPh/9WmVofQ0nf66qfXQN3bjw9jRty1rm4tS3FN?=
 =?us-ascii?Q?+UmhPdvtE1DoeCzvJQJgQ16R8CpDcq8ZlLjKGchdYj6P70i7Zy1Avd70MyAI?=
 =?us-ascii?Q?XNd4sii7IgqZduBxxJntPktNU3nKl32acgT1ptZ1HpkLYKvzmCHn1mWeasDk?=
 =?us-ascii?Q?zH81Xwso1JFVh+YEJhVsN5gTGNmKyZ+N4JfL1ln/jzAVOh2oVfKW9Mn842UY?=
 =?us-ascii?Q?Bo+lxDImKZ7aIxZYFJb+s2eNV7n7lBT2PkhUCuc5h2HQ+vRkwtS5/Dw9sAxi?=
 =?us-ascii?Q?xYgk17dxNaJoMs3jF58tHllsDbztqJ015Vvl33j5c5uSG59UBD8QACqqNhee?=
 =?us-ascii?Q?tsutm071Ud084KKEh9/UL1LmGGtCp/e1v52o7DrTqW9+GrPTQyR4B1kp1hUl?=
 =?us-ascii?Q?xnVgzGLo6J1KOi+DNBPy/ni+AmoCp9Rz+0TopboTO26Jx+UqzkvLWNRz9tgv?=
 =?us-ascii?Q?/DqAzIEJ2NI09vG0ntDBx+VBGCh8fW0arZcsilT2jVwi+YqOWLhLe5nYLE/B?=
 =?us-ascii?Q?oFhlVbno8gyhp3Lk+/EGDsaYMH4gR35q+wE66jpAqvtHCu+2M3ispNB1LTnF?=
 =?us-ascii?Q?OTFQNLx8kI9Lm6qh/Vj3JuMQRZAdQ14FbqgCCD2YOf3z9MpKan2W7VQqxquL?=
 =?us-ascii?Q?blsDU0WCJ7cawMZlYLG6MQMFGEDezvSGuNZn6B53dJDqQVdSh8UZkRToXWHj?=
 =?us-ascii?Q?UJBJIMF/kWIONZA0UqJ60/mPeojusIs1brqSBPTqAmLxmGUpOD7CIddN5wVd?=
 =?us-ascii?Q?FXkj4qQvXlMKFIk5Bxgsf6SF9Kmstyumnmb/QOeO5+xqYTHt7rBbIW59Sp2x?=
 =?us-ascii?Q?Y4k+E1I4SbVYkbcvDWdAkQzScEkEmNwGsOefeZNx9H2dM+EETj8V2nezFatQ?=
 =?us-ascii?Q?o8QPOaBoiFeoGbIq9sVaAMAQGzE1XOunwvomU6pRui2E4cDnxaM+vWk3oZuW?=
 =?us-ascii?Q?Mw82DTw4UnlOZ76nJjRHEKhaiQJRTYOGraAOjsr6GrxyYMBOY3KKBRDZaQ5I?=
 =?us-ascii?Q?UXE8kt9z3Qksn5y1ATW6DVKy/9BLgfyCK57m1UbL6QrKmDP67AMl87cqATle?=
 =?us-ascii?Q?D1NsnxQ2TIm6DLe24zPCoPaDj6v3PWyYgQJgqUKYWapB9ACu0KsS3/31Wduc?=
 =?us-ascii?Q?zlGys6Zx2UBYlkvoOZjXytmQXlNKvKSM0xV9SktxNGLkmazoN1KXKzEHn1w5?=
 =?us-ascii?Q?x1UJmDskAHefNYVFj/fIRkQQ6dHjfl+mNhV+O16JEbqkRJgiU6ys33v5EP13?=
 =?us-ascii?Q?kEI+Ey4mVsVT/dCmyQ295e+dmfpp0tqs6fA84ieP7nLJTtUUVhDM1tmZA2dv?=
 =?us-ascii?Q?jjt98hkZZH6MBAwh79cAJSDvoNJeG5dWYSgwU8Aq5QdyBAOSj6DrIsckuJqu?=
 =?us-ascii?Q?Y6BLY71YG1bjhttBw+i3UhCyz2x2T0Gegda8eTMDMwk9t/2tOzZ+sSd6fBc9?=
 =?us-ascii?Q?e5ZRPadYUW9biBMVDTYh4+0ohqJPzRU5sN+Lsp1mxhAmKarZS//qIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:38:27.2862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e268d6-2933-41af-06ed-08dd556702cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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

From: Mario Limonciello <mario.limonciello@amd.com>

A scoped guard will release the mutex when it goes out of scope.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 153a073f93de..e0cce4883148 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3673,7 +3673,7 @@ void amdgpu_dm_update_connector_after_detect(
 		 * For S3 resume with headless use eml_sink to fake stream
 		 * because on resume connector->sink is set to NULL
 		 */
-		mutex_lock(&dev->mode_config.mutex);
+		guard(mutex)(&dev->mode_config.mutex);
 
 		if (sink) {
 			if (aconnector->dc_sink) {
@@ -3698,8 +3698,6 @@ void amdgpu_dm_update_connector_after_detect(
 			}
 		}
 
-		mutex_unlock(&dev->mode_config.mutex);
-
 		if (sink)
 			dc_sink_release(sink);
 		return;
@@ -3729,7 +3727,7 @@ void amdgpu_dm_update_connector_after_detect(
 	drm_dbg_kms(dev, "DCHPD: connector_id=%d: Old sink=%p New sink=%p\n",
 		    aconnector->connector_id, aconnector->dc_sink, sink);
 
-	mutex_lock(&dev->mode_config.mutex);
+	guard(mutex)(&dev->mode_config.mutex);
 
 	/*
 	 * 1. Update status of the drm connector
@@ -3791,8 +3789,6 @@ void amdgpu_dm_update_connector_after_detect(
 			connector->state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
 	}
 
-	mutex_unlock(&dev->mode_config.mutex);
-
 	update_subconnector_property(aconnector);
 
 	if (sink)
-- 
2.37.3

