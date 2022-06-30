Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BE1C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF1212A6CE;
	Thu, 30 Jun 2022 19:14:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD64412A6C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAEpgjO0M0B2ceNqWDyaOJMMiyXcmzrOxDDiNnVwhFBN0thm0Gz7DeRcJW7Ptakafgj3YlJCYOlzvmixkG9TkmSo5UBVrQe5YNvLED+FsURXdv/QBOGINjKldzSlThk+bXWRQiq77sWdC86NMMTzNI41TOAjneAWYc2Cf7bYrrkHmkb0ZH6ICtj7pHr0+H7O6f+afZnvxGs/odvECkeBhRIKRITBhl7pTGHnEY9PXrGqpKtKjLG4bBlzviQx2idv3Pdcug7bWxiv1po4vbsvBFvnZ6GOv+uwRQVa6pt7HYGB+EcJka8TIqgwnELw/cyMYg/fH/YyWKupX/sYDAT2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Gzu7cWBcMa5nNnoNASfLqTll0zEK1bsjCzDh72gWDc=;
 b=c2BEmePzYjFMn8Ih4OA6gxpC+iuLbFfutIST+fqnn9sYP5qDQzNsU4ViDMIamurOIYgoYTdZhmDjIHpPooeKvCP0f+sTDdFhtEpOCIb0jyVKe2rsZJtOoLRn11a1En0sO4Tt2BZyrglbtBfQh2CykMMFMrYD6X7jkerX22/sR+xRj8dBzQqTyo0tvM2N4cwlO/V7byGImmdtM6ZXhLnX0f0VbdfIvaLWIGIcuX3zB0AMMq2q7cBNIBa/WWjfkh5HcDbVwsZYOodShI8m4McZhPUU6Urs4RkB3BAcniVDboIfAU7QWwXRrUwpSc3MYzYozSuuWPEvle86JEoDYXx31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Gzu7cWBcMa5nNnoNASfLqTll0zEK1bsjCzDh72gWDc=;
 b=GyBknORF4kSQWmQNZkDKbCtOk3EBDs9szbjOAsxiwb8V78vOKAiTod8c7JYzbuVMuOVnnhZUxdimGTqdML8fwXZtfhaQtQpW0E0OkDQhwOIgNcrQbm5BcrvOhbYuLcDF50fhcR1Go/eQFDtPQDCKYoWyY7vMYE1K0bMzRUsPPqo=
Received: from BN9PR03CA0150.namprd03.prod.outlook.com (2603:10b6:408:fe::35)
 by MWHPR12MB1151.namprd12.prod.outlook.com (2603:10b6:300:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:05 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::8b) by BN9PR03CA0150.outlook.office365.com
 (2603:10b6:408:fe::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:04 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/40] drm/amd/display: disable timing sync b/w odm halves
Date: Thu, 30 Jun 2022 15:12:57 -0400
Message-ID: <20220630191322.909650-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79c3545c-191c-49dd-8427-08da5accb2bc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1151:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBnhVDf2L9rrRQQEUmQhrbWU9SMZAXCuRhrSLZZLMP57Hr3h/mjrkTKjfIxqSTuFogkvJSufevtZajN1+zUnD1+WcA4Pgk/Xni+3qi7znko7DciUmTPKluFybhiFsUDI/wfPHd6zV6SlIWWF1IBaV90GlHdp0J1J6LABj6cSMMrh85UCNOciHDo0Lzehgi6yxUZfO9XC/xmZG2U241IdevjhEuL0X4+Cx+RCZhDqjvXkL33fGh8i/FS3JJ3SD9vGfw8wJCvk9lzi6JJKaGUs4uzb3k72QR+aCEXfSykhmp52KZQxGPWANL+ZFluf5DNz8Ix78imPFAknNCd+vN+cE/LG1AW+CBu7SJt7UivHnYc3u/Ce/fx6nUTkBCcNv9JVMPGfh/vZTJ00FtHtjVnEqgjQv7RSDtyfTa1KOsNiTTRcHJbr/0N8ES4frAT9tDTY3gu3GE6B2fSzfEhT9PvXS+qhRZNWwihWQJxaCScabiNyglSuejrfqez2enRuXzlNLCaqAOC8smyB3niypwi13zkANgvv4dUmVVlcvdZVUS6Hc3ix5WT6O+XNZePKBmW7HfaX5MwIPPV9TxW6l1pMTaavuXme4C9auW5uqK/+cR1uhoueknrCmfc0bpmUWq47B2j5THQywaRd1qCY2L0tF1OekWveGbBYyQg6xeZzmdbEQwXGSge2kXvNmYG6cGbypXG/576od2bsBa/KGZTr+VHv+/JYuinWElCQNJCs0K7v3GDCDphZYEYOaSDL2eW/tCuOaBUTaTjDmtQKULHwTEIG6rvYW/CF9wA6fPd4Iqil8UPuBf1sfsr7etgxss41DCzdPrPvuD4jcS+kJnYdAdx/vqZ2huNFhavvnL/kOTo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(36840700001)(40470700004)(46966006)(336012)(2616005)(1076003)(16526019)(8936002)(36860700001)(36756003)(426003)(7696005)(54906003)(186003)(82310400005)(316002)(47076005)(6916009)(6666004)(26005)(81166007)(4744005)(40480700001)(5660300002)(4326008)(40460700003)(8676002)(83380400001)(356005)(82740400003)(70586007)(41300700001)(86362001)(2906002)(478600001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:04.4248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c3545c-191c-49dd-8427-08da5accb2bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1151
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Fix for a bug where we would try to timing sync 2 odm halves.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 40848eda44d9..795766cb27dd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1333,7 +1333,9 @@ static void program_timing_sync(
 	struct pipe_ctx *unsynced_pipes[MAX_PIPES] = { NULL };
 
 	for (i = 0; i < pipe_count; i++) {
-		if (!ctx->res_ctx.pipe_ctx[i].stream || ctx->res_ctx.pipe_ctx[i].top_pipe)
+		if (!ctx->res_ctx.pipe_ctx[i].stream
+				|| ctx->res_ctx.pipe_ctx[i].top_pipe
+				|| ctx->res_ctx.pipe_ctx[i].prev_odm_pipe)
 			continue;
 
 		unsynced_pipes[i] = &ctx->res_ctx.pipe_ctx[i];
-- 
2.25.1

