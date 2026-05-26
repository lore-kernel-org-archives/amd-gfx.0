Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE33ECD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2DD10E4EA;
	Tue, 26 May 2026 07:16:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="weliLb5t";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B00E310E507
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faFbjIJduw1JqHfqLuGhzJmoNitQMyWxvcNp2JK9lQ7YPGiJ21tlAp8Jzk7EmHtz+eD4VXqJFMV+OI81HLpmVZUdqo/YhG0Rvw7vtLlUks0aRm5NE+4S5EKCtRl3eIvCPRjltPxJ7HayhzMLTILjSV49zSMHKsXWdNW2fhTdgFHB3d2uUzevvSZmzJMec4/NJXhx4h6kk6Ue3B7kdUjO1LBpBfZQBjrbl33Oow0tz5IzewxkLO3GRZGTKq09WWlQs2W33cn25zRMlOKOZVd3uh452rHoOxEXXFQtjdrFYXzqKXqMKuzcbVEyI4JVIRYHcIjgbA1OpwaGDhJRIlBN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL+aPiPWA8pEeS94mNn0eo6J5XtUieTWlj8v80GPhL4=;
 b=kbBT1NLD2mshLB+HasJ+5acplnyT10eAX7Nsetby73tbtCQkJHCSypriA0k4QC0Kpi7bUEbAzcNiQq3LPCB0UUDDh1kFub+4cdVvQokvkZP9MGL86foXJFzfA0zTRt7nHKKB5kUPtA2KHLnMEplnwFiJr8roZy1390tF2cLqMt8LLyZbD8WYLtftn51Vto3m55VFUK8ceyfoKyn7NFJyl419qJlotQFR7noguv2tHYHl6W0yDsC+8uZVwQNklA9fb8J/GbXiABRo5OE92aI/4Ffg6bR07hNnlQdb2vtx25tVc9QZOdZLHSHwR+xMYUj0scTpV+fxaRGilP0nb2j+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL+aPiPWA8pEeS94mNn0eo6J5XtUieTWlj8v80GPhL4=;
 b=weliLb5tfHuMLJRGHObN6c7j/v5xwLH8BBxO7GghVB1WUEpRAPfcTIKcnW0B+LJlZM+9Gay3ITCg674/80EyQfXF/iqmqrm/PKv4jBvt0EqxhyXJSaNJotMctXexgSkbrtvrYYnGUAlkErTKeSMR9DtQQDJFG05WVSl6O3mWWYc=
Received: from CYZPR10CA0006.namprd10.prod.outlook.com (2603:10b6:930:8a::12)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 07:15:56 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::e) by CYZPR10CA0006.outlook.office365.com
 (2603:10b6:930:8a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:15:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:15:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:15:55 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:15:46 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 11/41] drm/amd/display: Change default driver setting for
 "Force ODM2:1 for eDP" policy
Date: Tue, 26 May 2026 15:01:34 +0800
Message-ID: <20260526071413.2181251-12-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3e509d-7b59-4da7-e1bc-08debaf6a175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: z8mGciwe76ojzSURtcXHB84PY91s1fmr/n6KdtHatdmTs8Jkr4onRrQ3zXvnWB2u+KfP6/DsTbAG3b+VYnp/hrBj7SqNsGcWp0IZcjOZts+45khotNvA0Y8rfbCBzCWwelLmIWr68B6mvckMl4CRgK1sj3zU0Rd9+MNO+dEN3rn1sI0dr3JnrgVtuxagYeC3jpycyLJaeCpInb++8d83oMl3aK66bpXiiOHaKg7CdcavwDBtSLSGfgmv17QXs9+39qf4O6FqrIAtRBaV6hPn+AF5Knuvv8xbKWjpN+TU+nCsVNDs031Ffy0NN7iccqoV4bPhiYEKokemze/M8G4mta+mwvWFSUs3Pm1Wfo+KiqTP3wC/y3+zWSRrBvGAd1XJ0JLjMGZkEaZuE5EV9A03A61uZDcQGADxLYgS0wv3aJRNq7jrsSl3rNP/OwSo+CbgDqRBcR8KSXAxDIP91OkRlAgD9nITnn0YlTzEGhZkVFSCSP5pRZXA64l3xNIyy1dpKElYmKXWDXDu24XeFchbX3G7y+DDL/iGWI+1Nf6hdJCDeZ9+rypgghNu9HOBxyBGNMWtxAPnxwn1vJHEVbcmC5DCEPsT8IP4fo/kUdZ6wi3pCAyN5BBNMtD7TqvEA5Q/cCWHuVpvj5wIoDrsCPt0h65qnKEG1ezLlcPPaoObAZ98YTaPXsD9BlkntrPvAWDcrBUIe+ETo49i6j17Q8wuH+HkJspIkpWRCMYVhDikJxc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IrzB8l97BqEAX6mzzVFCGXKYBFjD+VgsxDLVnEsftOU6N1o//fbf4Mm5YeYIW4T2qnygxcwyzWrKqgKKscCB71h3WMBNkKFDkvCYb8H79S22gHYE7mA0GDjXxnKi8eSWr7qrmO5UkRTo+bNLdSDFZO5bOfBSsA/tlb35tsMm8PtPueSjQ98NhAnSJ9WmhYXC2/pQrvobJd8mHZ7UWXrqtdFeqPsOOfY2KfclN9Aerd+Rt4qXOi9rzKKIbXptN0gSqStfbJwLt78gtGHZP+FtCt7P5Kc6MSbxJVHbkK+ogUF3m44ZTOzORKWk3kgjl+R1znP/Lc5HZ+OtuuDHnrYmSRKKHlrS4tj1Emy1dxIobARPAINUSmta4b7DG6oDPAGaYQGEG+nHZQoigxzHkXAGVJnJSdnWrbVM2lVuhkW9QlvcVMEmTpBibGErXYTGkeRW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:15:56.6368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3e509d-7b59-4da7-e1bc-08debaf6a175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[Why & How]
Change the driver setting: force single eDP ODM2:1 disable as default.
Still allow user to enable it via debug option.

Revert to unblock testing.

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index b9f998ea2d0f..0feb4872412f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -765,7 +765,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_deep_sleep_dcfclk_khz = 8000,
 	.replay_skip_crtc_disabled = true,
 	.psr_skip_crtc_disable = true,
-	.force_odm2to1_for_edp_pixclk_mhz = 550, // Force ODM 2to1 for eDP when pixel clock is above 550MHz
+	.force_odm2to1_for_edp_pixclk_mhz = 0, // disable the policy for now
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.43.0

