Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EBCC19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FFA10E6E0;
	Wed,  5 Mar 2025 05:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ay2UpPXw";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E3710E6EC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:16:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoMN25uIM06424kikXHisp2X4OsFE5csFs32hUybzahTBEsaGD9/UaYPSOiIpAsKMBRC79YJdecmFJM+n5ITzYK7WW0J8U6Ck6GpmMcS9Nb4Rlr8+nSwPaTAkJrFM9rzGTnPoQUCd1XepGPlHqbRTEAnER2tiEK4CPMHpbl08hX2BmQS/IKDWbUZ5mJVHZvEeAkNADAAiWiK7PmH5s++GEHxwqenJu/EwVorGpZ4dYiGF3AiurJUTeDyoNOzs8ceFKebeFKKM536dtuGjGniiw7Ow0IvBfKsVCxoo+h3Jx3/yHH4HXnxii2KenTzdNz6gwZ3vLwW540Xrrpkc+Y8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfMIfjwKUmGp+1DUBwkqaAby+9xMKCDEX6urANGDMuE=;
 b=hozyrax8mBhROzMzlTz/8fVzqDuWZe2Q074ApYhQo0bCWSZGcTCyId9DPG8NaQSw8dxa7+07/ldj6IPrprZ99ODCbi0K2oauU4bLkFhSlS4688nHgaIDgdrpzhL2lMnxS5S6NOpOtRz4qT1EnrJqqhCakded4QVpak+e49tOi5vN1/VU/eEKwLUNgz1QDidHUtP3a0RIdgd54kW8mRmG23rNYSkFHpPY6DwAZFSHLxSHpU77EjaWStRUrepl61dOo0MuwzZeqXVxGcdhzVAJDPWk7Hx0p6IUYhaT8aGD5FjxihlMQoAysfu9WILsFff60U6bB84Nc9ekYzg5+8+/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfMIfjwKUmGp+1DUBwkqaAby+9xMKCDEX6urANGDMuE=;
 b=Ay2UpPXwtoKv9Q7VR0Dv8e1lX7xCOyluWJCj6u0Adscw1SOS6ba5P7D/c/iEfRGpvtkRDyNhIYowew42jnQEbC+8NxPbhYHdv8KnloZzhOxGYUoQmcUsp82HpQW1obHU4a4mCg/BF6sYSbyKWuNpGnsXlzAA4JajzRbbko8ekxc=
Received: from BN9PR03CA0623.namprd03.prod.outlook.com (2603:10b6:408:106::28)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:16:13 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::6e) by BN9PR03CA0623.outlook.office365.com
 (2603:10b6:408:106::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 05:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:16:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:16:12 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:16:08 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 13/22] drm/amd/display: dml2 soc dscclk use DPM table clk
 setting.
Date: Wed, 5 Mar 2025 13:13:53 +0800
Message-ID: <20250305051402.1550046-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9a2d02-b255-4d22-5755-08dd5ba4d8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gRPKtyd+MVjHpc/FSTW1WDsU9UepL7s+X4rebhSZAPcCt4hflGkdhWYVtHiV?=
 =?us-ascii?Q?WVLiXOlrXWL/bReuEZeh2hBm8fWDGlXxdLcsWXAqQvLamb3eyCz8oj6jMyOu?=
 =?us-ascii?Q?t6DviuYzF8hPZ2SM4nMGZkmPiuJkMrb9L5E19kQNs6VAXFTlCFIscndOhOJL?=
 =?us-ascii?Q?l/fFrETxd9uWu3b5hayHS8Ns29bJ/jCLlN3JubWP5l5v3b8NbiM7GGjG8GQD?=
 =?us-ascii?Q?JWw75VHHjEG30lmBQoEkmp9fM91vA+DeoPSrEMaSCcHhVmgg8iwdyUrexkME?=
 =?us-ascii?Q?7Ypwi17YsI+kN5dKRLgOP/tZ9+xuGs7Vdfsh6mcIYgbmEgQP8G90dYTzXii/?=
 =?us-ascii?Q?gGPgcsfuX1ESqGo09swr4et+y/NHPvrGIdcduCFu7FN8mL+BQ8hiNNHKXm6p?=
 =?us-ascii?Q?ARhCj+zi+r1NY741wCu0tZWTJ4gExTiGVEOMEL3D98LnMTjMEYzzAmU9fUlf?=
 =?us-ascii?Q?LWSLrIn6BWcmzZ+NDnVrRB5WIc/EIPKbxNQ11QPf/VhofX12/tQkkEwaOebl?=
 =?us-ascii?Q?YOJUHFXn4qxLFYVeMR1q0mgsNYSvvWZw0jB5ChTAjTC+GL6wHUwEPuWuiVPv?=
 =?us-ascii?Q?QtX93gWcAP2k+5HPAh0M2EDyceMS7R+gZs+mljHBItcqIvK0s6SJZ3PujhWr?=
 =?us-ascii?Q?a/IWjhjFKxC8HVdBklq5AdVWzA8MSvkBl+n3kk2o/jYTrmoaZ3nFCSR8ja9g?=
 =?us-ascii?Q?BG7Ju+y4odX2vT46P0M4mVirdQ9k1VY93FMXPRZeQLAEbvKbcxR5PLxlvQVl?=
 =?us-ascii?Q?e+mjHcd3n558brTNSrBy5O/YVV4GAmQePYEVpMjZ4ygiPdHGgEwejWUtBi4z?=
 =?us-ascii?Q?LTrQECgCm8jr4aC9F8BNMvDE6ycub6SLLsuMXiZaos4Jas46C9p2IDzmbwtd?=
 =?us-ascii?Q?ouDPMoxYRzBB0MeXcq0HqE4KpkWcN0k3otTJl9239k7hMK8+cBLBnF1NgjH9?=
 =?us-ascii?Q?DU1KR4kU41x8UOdpKNOByshAzyHhh0XCGYYfDT1cZL7+OIdGBMBA0NIXT6hz?=
 =?us-ascii?Q?TuhZ7hJ1pH2GhCY7u72uBFSi1JVNpmeGRoOvN0Arvh0MDHLYPMskcXACc3wj?=
 =?us-ascii?Q?DKUDMn29gScZ5qbrdBtmpPJw6RbX92TEwmQ2NlJK2efJilr3Cjn3Fvj8DqAZ?=
 =?us-ascii?Q?5AokEe6h1ocUirEfk6kjOq97SkQALHE6J2l1dHzs5suad1BOzUw3gf108xEe?=
 =?us-ascii?Q?VtiUJWuMClItUt1Ri1vOzd44HVoLp1uWzQikZE9j9eezTsQmTg8zG9+d1Fxn?=
 =?us-ascii?Q?y9Ep9Z1ID+znYeiYUHprVjsrzPYBAUiusfbAtGf2O+IvIhMnaQZ/DD2eMFI/?=
 =?us-ascii?Q?YmpeztaGqXY0RmiOmT4OZZIJpK8eDAohQRod+akwlB8ZNWkA3UJFENehODO6?=
 =?us-ascii?Q?2zZ8D004stFycyF700MIu5fSXqHOMO7XI76M7fOSTeX4Y43ptArYf0kAuPL6?=
 =?us-ascii?Q?7rpmIbrjf8/GJrUpOKgL2pye+aoWHaGyiMcO+olyXAHWfnaqn6MD3DgHgyo/?=
 =?us-ascii?Q?p+PHPlZYwZcxdrk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:16:12.7969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9a2d02-b255-4d22-5755-08dd5ba4d8e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why & how]
The dml2 will calculate the minimum required clocks.
Use DPM table clk setting for dml2 soc dscclk.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 2061d43b92e1..70c39df62533 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -590,11 +590,11 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 			p->out_states->state_array[i].dtbclk_mhz = max_dtbclk_mhz;
 			p->out_states->state_array[i].phyclk_mhz = max_phyclk_mhz;
 
-			p->out_states->state_array[i].dscclk_mhz = max_dispclk_mhz / 3.0;
 			p->out_states->state_array[i].phyclk_mhz = max_phyclk_mhz;
 			p->out_states->state_array[i].dtbclk_mhz = max_dtbclk_mhz;
 
 			/* Dependent states. */
+			p->out_states->state_array[i].dscclk_mhz = p->in_states->state_array[i].dscclk_mhz;
 			p->out_states->state_array[i].dram_speed_mts = p->in_states->state_array[i].dram_speed_mts;
 			p->out_states->state_array[i].fabricclk_mhz = p->in_states->state_array[i].fabricclk_mhz;
 			p->out_states->state_array[i].socclk_mhz = p->in_states->state_array[i].socclk_mhz;
-- 
2.34.1

