Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53FDC001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 15:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9F610E18B;
	Wed, 26 Jul 2023 15:02:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106E710E18B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 15:02:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhvfSEyRHpO+O+MPfFhqb6gCN2AY4szUpixn1algH1DLChImS6OgJ77SGzre4NvUs3TuprXrDuM8UL/R6XbOvsr79YZhlSx4nYVIHC9BgR9tYTZDIcKiwPMrvlKH+HQgafuYYJGjtcw0ON+IgD/xEQL7eigaYrC9sSAUtM7673A8RH4yYYWOnvJ4leY5I/0ybvfmoVmFzgyLEgQpHNxMKpy0urEwcp3c+iulPldyd3ibsDTAJAyV4Daqw2OTd2c0lrhGu/mJjJsI44OzzZIuBXWdzFHYTW663/JC/9CsIXhWf6aCSEj12XUW7V3Gxs8D3qs00lmcNGxUR6/fYamUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OOeuQPGCY9I66OP1UtOm/XZWboNsqbtvvvzbF0sDIg=;
 b=MXK0RSYuQeEb92nfljIqar4QN+oDPeHsBvfciwNmJN7wg2t0xNZKjA6DSJNOau4iNYfqip/ALbnU0Fjr7WqvWx+XVc5WGgDiT3V7SGDyXJNcuUGZzVrsPB4VVG5fpd/Dcj5mw3haZz7qk7ZpU0qDdCzV3eOGOGNOPer2496im7MedbV2IypWID/WgJu8XogZ6Mt6PBG26/469vT1Jr6ZxNtuZsqAqPwkWAbHR7G9oqtoFMr+4G/J0GR8V/g2Gike5iW7NeMoxnh4Q5x70q5jY8o45xPp/JexH1P1mGlacNKdR1B8K56qbssVRO0uYIBGvFuqIAv5fmwttzf+lsY3Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OOeuQPGCY9I66OP1UtOm/XZWboNsqbtvvvzbF0sDIg=;
 b=HRCwlXoUvhgCSYWtZ7DxfCDZLwxZs977ddVylp+h9cumMRpFs0t53Xh2LV22kNBq2+lHdxBjHNOIht8ZvGLiKcdg4rTJfZmG8YJMjrGTzSCf9vuTV1NW55bZ6dl6arOCfs10LKQcuQttMT9nARhqbR7XHOVOHJKzYPLT74ajlz8=
Received: from DS7PR06CA0050.namprd06.prod.outlook.com (2603:10b6:8:54::32) by
 IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 15:02:26 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::2) by DS7PR06CA0050.outlook.office365.com
 (2603:10b6:8:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 15:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 15:02:26 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 10:02:24 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/radeon: Prefer strscpy over strlcpy calls in
 radeon_atombios.c
Date: Wed, 26 Jul 2023 20:32:11 +0530
Message-ID: <20230726150211.2489890-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea18f22-3247-4e05-0799-08db8de95348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lIj5tF/6m6gKadirCj7WCUKO1qn1d7/oDBo1dU1duyI2v139Qe8rJyM0K368e0zchFDaudQ0OZEz9yNyJkGeRzO5l28t8Ja3VxE33xqLTmUzRiv2frshPkq6f27Im3CwkDiJjqb0n2bz4XDkbDX652YXjjo6SD7WCgNWbLdLST+youEOeM3rW0zy9laLDX+PgQxJbl6FpYmqVK9dtR9dxH1TZOBu/ENl9QatrDVIL+NnqcZzekoq2VpdkoSJ1YAfzPWJGRD3D9uAAIf1zWD2uWOFhBUKLpuKmqHmwpmZSFdMqoTq8/1GMxjjx/y8R8grQWety/YZaPMS+MXNl5Zt5V0CTqHTCVZperlB0QF3IEA7UNqFi+AvIJN+XjxyQiGIS/olFnibltrA/aMXhlGTa/lGHhMSboEyGYUHzfrqYY5G6UYdv8Eyj1BuJnpBehlLF8E2b7KAO8L678mo8YqbJnq+tpsyE/OEyTAWf00Hbf6A8NCNumQMXc6b4kiEl/FqZK8OTUCFzESsxpVPLTj6uDMaFeInj6gz71pEQweHfInUdPO+zzuFvuMy/bynTijjed5jIdrDtXfEJDsVz1NkvVox/w1z/tX/Mf8PDRvY+fwEFNcBaZ1h6Sta5UDj02HDdrZ8gaJ0Ejd+xWm9x/PzG+V1NVIKEAJapOy0DCFtwVFAK3HzFwkMwxlNwbgVhq2vHCRrWjRQNUZs71S6IqOt9IlgpLF7zTseqpNQI1V8d7vNDvtilJW6nfyWO5uI1F8YQuI/+NQxMVpulQa+Lw2iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(336012)(26005)(1076003)(186003)(2906002)(82740400003)(54906003)(8676002)(36756003)(8936002)(6666004)(110136005)(478600001)(7696005)(36860700001)(16526019)(81166007)(356005)(41300700001)(5660300002)(4326008)(70586007)(44832011)(70206006)(40460700003)(83380400001)(426003)(6636002)(66574015)(47076005)(2616005)(40480700001)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 15:02:26.6089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea18f22-3247-4e05-0799-08db8de95348
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the strscpy method instead of strlcpy method.

Fixes the below:

WARNING: Prefer strscpy over strlcpy

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_atombios.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 697a5989c045..85c4bb186203 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -2105,7 +2105,7 @@ static int radeon_atombios_parse_power_table_1_3(struct radeon_device *rdev)
 			const char *name = thermal_controller_names[power_info->info.
 								    ucOverdriveThermalController];
 			info.addr = power_info->info.ucOverdriveControllerAddress >> 1;
-			strlcpy(info.type, name, sizeof(info.type));
+			strscpy(info.type, name, sizeof(info.type));
 			i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 		}
 	}
@@ -2355,7 +2355,7 @@ static void radeon_atombios_add_pplib_thermal_controller(struct radeon_device *r
 				struct i2c_board_info info = { };
 				const char *name = pp_lib_thermal_controller_names[controller->ucType];
 				info.addr = controller->ucI2cAddress >> 1;
-				strlcpy(info.type, name, sizeof(info.type));
+				strscpy(info.type, name, sizeof(info.type));
 				i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 			}
 		} else {
-- 
2.25.1

