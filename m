Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC30C55178
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0FB206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ywir0fNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0FB206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194E26EB59;
	Fri,  6 Nov 2020 23:19:36 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E33276EB59
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhGfMsPJ8r1/Cp1/8eKq/Rrsg5Vf3hCXPreIiXvEN/hc86DZKazLu+AonUWxQbgCqk4RQOtO2NsOgHzCG3Cc3v1cAndYspe4UUiuTDQyknAtTZTt2r2i39D8XbEkfXQLQVx0cqF42I64EsOiVeB9q7UobCurwi5i133Na0Z9MjJBzJB8i/8YYWL620+Q0kx7IC+JOzk91cJxCPlgK9SsIqU2n2iv5P9qwVuRhElyfZS8dHVCog4UK+5kOVVQKuxSqclu/gPyFSsC8Cs5gDilMnoOVAclLVTSPwdAWp1DiNhBacx1kddQeC3I8ZsnKeyAYHy56NWXoAf4GEQQBLkXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpfWswT8k2J1gwkroFeOYmum7Crm6QHtWaCZwB8Fgec=;
 b=EmFId5WN1ezXxcPz7rk2J2S0FOXJRY5zXwT9gYStMcctE7pTva7HQjafSqQh28QZrCCpvNAGaj6kT8Mu7k3rH7pQdyX8kOc2pQwcTvywwiQ5t3GFN86ir7bu4bzvwoMigQU/YbcI680dczgZIacr77lqp+W0oZFIY5Vhk2b3/xaTEmKUf7l2P/lvuGrEfeT+/gbjBUpSv7P6ANAhFNSVqzLnvORvr8VjASwjE6062coN1F/KaFw2lEk+tElyXSfTLi3qEstAObqG2/7ulm9yPzkI4HZBG2PQKpsdWR14Ru4OnaQzVGtUfQFzkzS2dbDg9n8AIpuvG7zBR1euRqi4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpfWswT8k2J1gwkroFeOYmum7Crm6QHtWaCZwB8Fgec=;
 b=Ywir0fNC/8s/OUBPeSyVUFQVZhKhDQl6/5mwd6zt6UKbCC/dvNcf/zlxnQgv4svx9VFvHynvj3q0euQscgsT5hgyMyjKo0DwIi4t9aY64OyTcibDQQiAca/c6W2u0kmR5vrry7fcJlN7Qnx9HJrqROMRQom/pYwqNso3gXv8ng8=
Received: from MW2PR2101CA0011.namprd21.prod.outlook.com (2603:10b6:302:1::24)
 by MWHPR12MB1390.namprd12.prod.outlook.com (2603:10b6:300:12::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 23:19:29 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::86) by MW2PR2101CA0011.outlook.office365.com
 (2603:10b6:302:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:28 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:28 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:22 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: force use sRGB for video TF is sRGB or
 BT709
Date: Fri, 6 Nov 2020 18:17:03 -0500
Message-ID: <20201106231710.1290392-8-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68baa071-c21a-43be-07ca-08d882aa6942
X-MS-TrafficTypeDiagnostic: MWHPR12MB1390:
X-Microsoft-Antispam-PRVS: <MWHPR12MB13901B8C19611633875CEEADF5ED0@MWHPR12MB1390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sa+r6M6s5VahfO20phcGx27zX2M/J1UpIoCFF2uxoVJ++/byI/MWfsDfB0OoMyRgPafUGbJ7WH8zw5ecpYd2RUgjQbmd7L/NRNBqW/WxHb6xXk5vdeHecEIDlrUyjI06CYjR7bjdCEBsUVjPRP3Bcnpqrcvm8cWTR4ysphTuHNFnR3P5n9HcB19d6S+DA1ZYrAWeshVmTCNKT0GTo3yqKQxO8ca5t85cVexhfCCcWHeyzAKjEeaAyKCG0XqoEljrZM68irc76qfy6FlSZNDIJkjj5mXtR20OCpBFhnP3ytmGusFpmwDdRuZHsh5uZ9PogCjZw+b/QVX930jF3LWHKQvPDl5TqIxJhVzwPOFIJH0jD2BUUoLD8K1qnWT7attamTJ1oAKdSCCYf+mlFecy6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(7696005)(70586007)(70206006)(336012)(86362001)(426003)(186003)(82310400003)(6666004)(1076003)(54906003)(36756003)(83380400001)(82740400003)(5660300002)(8936002)(478600001)(316002)(356005)(26005)(6916009)(81166007)(8676002)(4326008)(2906002)(2616005)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:29.2642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68baa071-c21a-43be-07ca-08d882aa6942
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1390
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Jing Zhou <Jing.Zhou@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, Bindu
 Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jing Zhou <Jing.Zhou@amd.com>

[Why]
When mpo enabled, video comes is 709. Desktop use sRGB.
So color change easily noticeable especially when switch between
mpo/non-mpo.

[How]
Force use sRGB for video TF is sRGB or BT709.
DCN1/DCN2 use predefined type with YUV.
DCN3 use distributed points type with YUV.

Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Acked-by: Bindu Ramamurthy<Bindu.R@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e6b92683dc5b..c368de08969b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -125,6 +125,7 @@ struct dpp_color_caps {
 	uint16_t hw_3d_lut : 1;
 	uint16_t ogam_ram : 1; // blnd gam
 	uint16_t ocsc : 1;
+	uint16_t dgam_rom_for_yuv : 1;
 	struct rom_curve_caps dgam_rom_caps;
 	struct rom_curve_caps ogam_rom_caps;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index e74bb2735885..bdc37831535e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1439,6 +1439,7 @@ static bool dcn10_resource_construct(
 	dc->caps.color.dpp.dgam_rom_caps.hlg = 0;
 	dc->caps.color.dpp.post_csc = 0;
 	dc->caps.color.dpp.gamma_corr = 0;
+	dc->caps.color.dpp.dgam_rom_for_yuv = 1;
 
 	dc->caps.color.dpp.hw_3d_lut = 0;
 	dc->caps.color.dpp.ogam_ram = 1; // RGAM on DCN1
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 86c21e463640..576a8f5e6f87 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3839,6 +3839,7 @@ static bool dcn20_resource_construct(
 	dc->caps.color.dpp.dgam_rom_caps.hlg = 0;
 	dc->caps.color.dpp.post_csc = 0;
 	dc->caps.color.dpp.gamma_corr = 0;
+	dc->caps.color.dpp.dgam_rom_for_yuv = 1;
 
 	dc->caps.color.dpp.hw_3d_lut = 1;
 	dc->caps.color.dpp.ogam_ram = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 5eedc19662a3..abc8af0ef141 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1978,6 +1978,7 @@ static bool dcn21_resource_construct(
 	dc->caps.color.dpp.dgam_rom_caps.hlg = 0;
 	dc->caps.color.dpp.post_csc = 0;
 	dc->caps.color.dpp.gamma_corr = 0;
+	dc->caps.color.dpp.dgam_rom_for_yuv = 1;
 
 	dc->caps.color.dpp.hw_3d_lut = 1;
 	dc->caps.color.dpp.ogam_ram = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index deeeab53ac87..a1edb829dc05 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2621,6 +2621,7 @@ static bool dcn30_resource_construct(
 	dc->caps.color.dpp.dgam_rom_caps.hlg = 1;
 	dc->caps.color.dpp.post_csc = 1;
 	dc->caps.color.dpp.gamma_corr = 1;
+	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
 	dc->caps.color.dpp.hw_3d_lut = 1;
 	dc->caps.color.dpp.ogam_ram = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 5a47b4106b7b..8824dbce6f4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1748,6 +1748,7 @@ static bool dcn301_resource_construct(
 	dc->caps.color.dpp.dgam_rom_caps.hlg = 1;
 	dc->caps.color.dpp.post_csc = 1;
 	dc->caps.color.dpp.gamma_corr = 1;
+	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
 	dc->caps.color.dpp.hw_3d_lut = 1;
 	dc->caps.color.dpp.ogam_ram = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 2345f12ceab3..7a83a85d2c69 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1327,6 +1327,7 @@ static bool dcn302_resource_construct(
 	dc->caps.color.dpp.dgam_rom_caps.hlg = 1;
 	dc->caps.color.dpp.post_csc = 1;
 	dc->caps.color.dpp.gamma_corr = 1;
+	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
 	dc->caps.color.dpp.hw_3d_lut = 1;
 	dc->caps.color.dpp.ogam_ram = 1;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
