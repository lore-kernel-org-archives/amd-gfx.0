Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDABC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 17:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5768D10E835;
	Tue, 11 Oct 2022 17:32:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B15C710E835
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 17:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8ucQ/bo+2BX4pkRY6TzjpiOX9SO7iiyLRM6nalaN/cGqo9DkGetohRhpWt5UhzvrrPBIXX1VKMA0M+4C6epJx1S3jxREkW7j03SNWOTfDdJbjqjGj4py+ej7bDMjP3Vosw0NIKC4gCenmx7pHRoZKrHavZAYEzGNCodptXxG2xXfISgaM/eplcEiiXgGbfxWHkup6AyYtIptSUodEaRymUXMBOsY9vGFesuK5y+1Fh+JKRKtpvkiPjtDSD+ygnk98K5KALb0IHD7LZxjTf+HwIjSz0PE34p70n1LRP9BBSWKEZ1OgZZonde8oiinOO18dUkBEoSAjsljf2RFIUbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3unLMFyevURq+PqHX3Woy3dAX24VF168T0CqBkxwZo=;
 b=SSEmHFfv7E1+gyUxLkJ3QQLPJL/zJMqaqOYFNiAb8k0rwgtBJh0QLklUi1OxCz4p8Aab1rLUAQKuCXOgTfx1mxsJIo5W/fhc8EGO9OoXs7TQ12LTrg4WCcvHvy6uh0f//PtkMH3Z9hCzOieeukgebtAhVkbBuHvtDehJenNdCi+WGdfsuocKZdTvqWh7Azes/sg8S1AblUIIb95dncs4xkkZMb8jzc7ufLcbP8Z0VJUzI2F1cRDwig4J9lTSfkl2KzxKg6MSROPXY2GRl30XrFHlo3U/Ayst6oQ+3F2SU7uExtCK/aLLb/EvZQ+Fbi5ZL412tSrPMb4PyCCiVZ2XHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3unLMFyevURq+PqHX3Woy3dAX24VF168T0CqBkxwZo=;
 b=Oy0dJ/58LTRMEMN7ee1bbNx99McfuugvVayEyH7J9e3408JuTD7tbWvlreGpoxRc3AddPB0eAIzKsbHiEH79EPqRS8oW2x8LzySdMhSR1qFVc4YRFMPYLtHzwqE/sva1kQ3lgaZLV2xXQ2M9ySUIUUE/OwaWJKAI8IPZFtIDdV8=
Received: from BN9PR03CA0897.namprd03.prod.outlook.com (2603:10b6:408:13c::32)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Tue, 11 Oct
 2022 17:32:11 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::3d) by BN9PR03CA0897.outlook.office365.com
 (2603:10b6:408:13c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 17:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 17:32:10 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 12:32:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Add HUBP surface flip interrupt handler
Date: Tue, 11 Oct 2022 13:31:24 -0400
Message-ID: <20221011173124.89534-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 339985ba-5c60-4005-1f4e-08daabae8761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QppQ1F/454iUy2QUPs4Bt6kEOvfuRky2AvWGO6KhIZM9WJoZ0nlTW4eaq5oOn2sJvtXEcgMfPgFKc++e9uF+JSgYIfosxTts0aO7xyF8ipyoU9knO/2ufuBz0SoKkrzwomuEgjPpDcZupDHkcVqJV5kh/MGxj55/aM4uwVvUoY3L7G8CTwlKCmi/mwYR19nh83D4y9akprExcuIv131K71U/cc6wmQ583Ov0fq9hoUXmeb+G9KXzP0A0u2CXbUIoJ1jB/QJGG5BIv4/j841sl4/zv1OYpboQLgNFpT40u9aAxTqYgwDicV23Zvqh4+8zaFg6oUF6vK5pPjfo/yHKmAf3YdoJyb5zx88zHCJDMJwu2brhdpKzBmN22XHvZJvMz5D1RKxuC70vPYaIhv2xih8PikZwMEXR1LXvQalMRE0RRCMoB43+pSbTzCtWZb7gOK3v2ioAq9rWAXdad0I58fnw2MU6v4SuIfXTkHFk944E5iLanuFGFfKjg4M0EmzAifgGTok70odCTndeUv7Qoup8jUcl0oxV1nyq43COJK5c/BKeiCBQA8b8qmSqfN4AONcubRGKDmKeU0AyX+LYCjwOe83nj2D0+MugOtNb0AgQoZfXsl4lY+Mg5XQsxnNT79rXEUZjokHfwMqj7nZb3XTfI05xJWZSRHuvvZLWJL/srbNHEf4Ih+SaVV/ICMOz4nGSLKJmXWJFFZCLxJobcaqbdfWouyAx6Lay6riMG/0+Sh95Ym4KUsbjNAae/kgCY++M0QaSoODbEGGmzGafq5o6q/77K6f3Q9D3nMIa65bI6QC2Q6PMTJZk+TasdoQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(54906003)(36860700001)(41300700001)(86362001)(81166007)(356005)(1076003)(82310400005)(82740400003)(478600001)(316002)(16526019)(110136005)(70206006)(5660300002)(186003)(40480700001)(6636002)(26005)(7696005)(336012)(8936002)(426003)(6666004)(2616005)(4326008)(2906002)(8676002)(70586007)(47076005)(36756003)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 17:32:10.9826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339985ba-5c60-4005-1f4e-08daabae8761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
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
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Add the hubp surface flip handler. This fixes some flip timeout issues.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
index f4b901d393eb..ac1c6458dd55 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
@@ -181,6 +181,7 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_init = hubp3_init,
 	.set_unbounded_requesting = hubp31_set_unbounded_requesting,
 	.hubp_soft_reset = hubp31_soft_reset,
+	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_in_blank = hubp1_in_blank,
 	.hubp_update_force_pstate_disallow = hubp32_update_force_pstate_disallow,
 	.phantom_hubp_post_enable = hubp32_phantom_hubp_post_enable,
-- 
2.35.1

