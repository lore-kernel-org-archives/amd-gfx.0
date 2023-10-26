Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F30FC25B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B604C10E825;
	Thu, 26 Oct 2023 14:21:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C60E10E824
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3t/jZsSO5gioZQUfS3V10CdEAba9xDf4too0KOWEcjVqyjHqOLG/di3dyO4HSo5KCKZI2yLNeJxTenAqzC3Xi4MS3jUhcGTFUgD6CAfWTQMBX9FSALt0d73dolxvsoQJ5nBmoQ/KrW4S3Ddh7IqClTMpKSe9BEEO3akldyyUhYqWxkYIUoIkIDBJzxgPSrGwhshK4iGFMMQACVH9qoOqIJNqD++I6IEPOhDGvNaUKX2oXDLkhxV0FQ+G8u0mgjM1tsg4WNzuFOi+h+Evxx5k9pMo0npKjTlEcGCtujijLXraWjV++entMurBwVifRN7NSQxRUFOhA/4fxdxcIfajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnQ7k6UGgHQwuk76NuuDPmr45jjyNTdFqwSKHbGyV8s=;
 b=CSOWGPiysK6rIGrWZFW3DO+f6u3VezkxtXn13zOgN84MnbaahFgN637kU9fYmHMR+/mY7rSDxUenh0IqAWaVLDfY+EX/5t2ZXd46saCymQeUsz35bqRINRoL+AK+Du/1UGsD2CQpQynNG2fqDNRMKPoCF7lC6L864T4fVXt9uIODbzKaDJjOgKC6xKpulUBg+Biut3GIq5JVhFMuS1G8XRPCQNjbmPmw2Pfhx8WyoZlmKCQ/eNQ206grsPK3UjLwPtPT02oRPg6Cs14AiYTPigbafP7+y+y9g32kff8C9aHmC4qgCktNulyh8qt8z4U4i3tt8calU8IM73kAZfQmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnQ7k6UGgHQwuk76NuuDPmr45jjyNTdFqwSKHbGyV8s=;
 b=xAU5O7FA0vAu7/OtfTACgUmH4lqCpiNVaaS+iIh1er0szl1nWg4L33sU0KxQ6DKuZwU8pYHxTDuD6uhIaMZIeuCnrqzMUiZp03SFiUMmU2/BgJynTiEhHw3E+BXzMGLtCGSsJMbLCOgM7yKQe91zpNLBOE26cfebpmitVKxmF2w=
Received: from SA9PR13CA0044.namprd13.prod.outlook.com (2603:10b6:806:22::19)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:20:57 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::ad) by SA9PR13CA0044.outlook.office365.com
 (2603:10b6:806:22::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:54 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:53 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/25] drm/amd/display: Enable RCO options for dcn35
Date: Thu, 26 Oct 2023 10:20:13 -0400
Message-ID: <20231026142020.67861-19-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 456caa72-4ad3-4fb6-2230-08dbd62ec514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDhsSkTxFJh02G9Mr3rtAYzV6PgU+y8utsGuDbIQlQVAmScfsFmqPICllxY4yCa7Oe6CaviQSUdR2/1F2l4J53jIb/yK+WPpiBNKZwjF+4qN9MccaDHkTjlTjmHn00PK1bjUjZhp8wo3edtZn9Z1Mzmk4svEsUYFJMbZc/0FCNF4w2E4Q2Irgqkia47TW+c9+ii52vprPTqBPwMJixH5Bu824X1ZeHkQrpoT5d0AzBSMvJclPXne1+iMuALS+386Nj/6pwJV6UxB4pA1iCKjbungjclPBBx/Td72IgPW0VcRd9zs4c/qglHCdmDTSt3VrXbgfK0egU6szWgHtv97jh3qkX+hdaXbbpsGM77JimTSPMsBTRACbJS1VVgNUlgjtpneHKWX3PH6BAvz91SaxTL4ET92ibfY4SZtbCdhrlFYEoRp0ou72TaZ3oSzKMpgib1vtJAtMEzCCIb9KuFp1gAnQL1/sATArTW6r9HlDHR016PnEqLBdL13tUyjXg9LDc7alFp1PxM5zLX8jpHRzMnLr9+PbIicocw10AMY7Kb80SSHgN/59BkUMnDkFaII7wLHnnsx929zmn0ti6I8iEC/a42hoAAnBJqA6U2tf7Yp2msDMYbZhBMC7jzD6ozYDwOXpNBRLKK7V9wMAT9mYgfXZyxx50HtnWZ3t2Tsq+CJB8skcK0nrUYfJUfRKQ/kxgXJEB69N7EUmqyvTukDakPaH8f48/Gj4HTc0NIxZWJ61IYQRkIGT5Nlm17itwQamEp+yqkQY03nu1F551FEFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(36840700001)(46966006)(40470700004)(41300700001)(2906002)(6916009)(316002)(356005)(2616005)(82740400003)(70586007)(478600001)(54906003)(1076003)(40480700001)(426003)(6666004)(47076005)(63370400001)(83380400001)(63350400001)(336012)(70206006)(40460700003)(86362001)(5660300002)(36756003)(4326008)(8676002)(81166007)(36860700001)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:56.5702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456caa72-4ad3-4fb6-2230-08dbd62ec514
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why & How]
Enable root clock optimization options for dcn35
for power savings

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c    |  1 +
 .../drm/amd/display/dc/dcn35/dcn35_resource.c    | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 0290ece6be50..c5d7f67d9856 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -765,6 +765,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.disable_symclk32_se = dccg31_disable_symclk32_se,
 	.enable_symclk32_le = dccg31_enable_symclk32_le,
 	.disable_symclk32_le = dccg31_disable_symclk32_le,
+	.set_symclk32_le_root_clock_gating = dccg31_set_symclk32_le_root_clock_gating,
 	.set_physymclk = dccg35_set_physymclk,
 	.set_dtbclk_dto = dccg35_set_dtbclk_dto,
 	.set_audio_dtbclk_dto = dccg31_set_audio_dtbclk_dto,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 03fd270f4dbe..4eb76896fd63 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -719,14 +719,14 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.bits = {
 			.dpp = true,
 			.dsc = true,/*dscclk and dsc pg*/
-			.hdmistream = false,
-			.hdmichar = false,
-			.dpstream = false,
-			.symclk32_se = false,
-			.symclk32_le = false,
-			.symclk_fe = false,
-			.physymclk = false,
-			.dpiasymclk = false,
+			.hdmistream = true,
+			.hdmichar = true,
+			.dpstream = true,
+			.symclk32_se = true,
+			.symclk32_le = true,
+			.symclk_fe = true,
+			.physymclk = false, // Prevents eDP light up
+			.dpiasymclk = true,
 		}
 	},
 	.seamless_boot_odm_combine = DML_FAIL_SOURCE_PIXEL_FORMAT,
-- 
2.25.1

