Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4396C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3AC60F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE3AC60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091B36EE82;
	Fri, 17 Sep 2021 19:26:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6DA6EE82
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWp8zwdQfexL5criTcXcm/HDiCigKJns7oKy/IEl1Qocjyg48G6CZaFuRBfo4HLWaUG1WlHNLiE6/WVD9pKrhSdlktfpvsouWEo1VUE+fGAypAJb9QO7QwgH4enR+FvqR0ysK59FBb8Ixo1daodTk6rAqQgxvQw/ZXfcHaGypFh22fsEWIoafr1+yQr70vOBLUU1H8UckNYnCTj4CtuD2guHjBzbgxehCR1CvaknvZ07uZgt1HVcG/4FyyEQ+KQkvY23GAIS8vR+DyRPsy2zkwES5hebaAC+sg6As4XRi/2MsjnFOcVuD46uc0s9FxTzH1cehN3JR2VqAQwV6bnKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=31UkXsjzST5j6ZInZb58cEql1VT75m3OyETk/Ycvzuo=;
 b=LcnpUTysO/LwDgJveEjEEo5rFtCPY3BcnRyWB+4FfC3Zosb5lW8q8pxb9W6vM4+/fyaukVCndIFuyS58ZrFXxOu4TXRHxsL4rIcmdtDPNjtmSj8d6nDOAIO+ciww4xMAujFDRrm+YIH6RgcUHV1prpjUyMny9uBsw1YVRdpiH+fnC3140PlSzAuYK9bZH7rtO5myAuC5KDppiXptsKNhB0UbhwsqH6nBY/enhHKNO8Qgmgg2qwTOlLSvbGQsjYaoJtO3/NDDKm9K5QNQ7BmnYuueoe4iS6M1c3oNSDobmxxxvPT8TKU4O6o5U8MtvlgILMixdWab0/HqX8fIhV+jkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31UkXsjzST5j6ZInZb58cEql1VT75m3OyETk/Ycvzuo=;
 b=k9DYQCXRfL9lvNaFjsyeV8Bqy6Z463/iAS26pnUyozYKErEwB83Z+gOlBLF3UvC0paXK4OdLcsZpTDUZyLjyiMic+1R0x6o6kEDaN0K3wj0V6w18K5dwoYrU9wMUjKqR7CovPvml00zMv1dPvQ63TkFoVSamoYhwpewqB2gFVvg=
Received: from BN0PR04CA0205.namprd04.prod.outlook.com (2603:10b6:408:e9::30)
 by CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Fri, 17 Sep
 2021 19:25:57 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::64) by BN0PR04CA0205.outlook.office365.com
 (2603:10b6:408:e9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:57 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:56 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Haonan Wang <haonan.wang2@amd.com>
Subject: [PATCH 11/18] drm/amd/display: Disable mem low power for CM HW block
 on DCN3.1
Date: Fri, 17 Sep 2021 15:25:17 -0400
Message-ID: <20210917192524.3020276-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c3d9ec4-fc28-4541-2217-08d97a10f998
X-MS-TrafficTypeDiagnostic: CY4PR12MB1639:
X-Microsoft-Antispam-PRVS: <CY4PR12MB163917165B1DD961EBBF918E98DD9@CY4PR12MB1639.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjrfkHGYYuryXue6A8Q0ung92YSkyVn+I4WnzUXIQX+0lzIfuZb1A6IgxLLbgWbsMih3QaSFVeMoYuCCBEeUjmsoD7/bPDBhTg5mzaW25G67y2Bw8wU7dXn9KIUElKOHFcoMs0ow087k93Mx8jf9OrShUNDSverfr1oWWFsp3qk4pblcbThdmAaZcmChbnOIU5wu0k5Y10YYnVLSR8BKbTaTugOmhaXnQLSV65rujTQNPcQqKEjiVr/CpvS0ExxyLGv7RREkrLIKggG5bPgnt72078MVAR6Ardx1TFyytW9drXUmTpdsq0j5VicroPpxAOXmEFIGqdtDxe0WoNba7XCinJ5SveMu/UiTgp8ugbehL581kZ4EcEJDMmxJo290ej5O94WOwu2KSisQuhXEhqOG8JR4kg1iad9w3fr4rzh92lDFoTM3POSNTG5toZ+gVQlSw+ZkcW7X8Jb4I8Sk6lQZYdlAnyzb0eLzfGOXdFzMNfyOYUmCbGXNyXokEMk6n/ptzXVpvtKd/IzPTXbHxIGRDSdRAyJ/qtmkBLaU/cVWEL3qFRg72Rh64Mr8e+4a6cWwPTCI/mrfSsgHDK+3DTSWR4oTDZiX7ByLHyGWh4T/sCe4D+n6EIbSIJ9PqJcgrd6KMKOtmfEdt+yHRSoZ4Hp6d+v/uyWHoRF3749FerYLAVFlRol6+4AtXIByFXd3SufZlPLAXvCBCVVOG5I09WXz8waNP5O26aLHXEllcaA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(36756003)(4744005)(478600001)(6666004)(70586007)(70206006)(86362001)(36860700001)(82310400003)(426003)(81166007)(82740400003)(186003)(2616005)(356005)(1076003)(4326008)(16526019)(316002)(8936002)(47076005)(54906003)(5660300002)(6916009)(2906002)(8676002)(26005)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:57.4748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3d9ec4-fc28-4541-2217-08d97a10f998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1639
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Currently causes visible flicker in some scenarios on OLED eDPs

Reviewed-by: Haonan Wang <haonan.wang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index a823a64d02a5..0b60ac676423 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1013,7 +1013,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.i2c = true,
 			.dmcu = false, // This is previously known to cause hang on S3 cycles if enabled
 			.dscl = true,
-			.cm = true,
+			.cm = false, // visible flicker on OLED eDPs
 			.mpc = true,
 			.optc = true,
 			.vpg = true,
-- 
2.25.1

