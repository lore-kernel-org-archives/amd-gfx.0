Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD3C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 15:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4F320771
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 15:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S/z20ZtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4F320771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B36C76E063;
	Mon, 13 Jul 2020 15:39:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E616E063
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 15:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdzUdogrP8WZdWyAFIqzdgEM/vN+dMvSEXQ1G1Wk2F0J7v5FihDszbk2nQCLDk9UKCCgqTko0aH1cAJd3umPxvkCAM39ufUzprEQq6Juh7800vMwIXFaQSGXi0POkJySSXLzi+YDD7V8nO9kC7Avg4S9JJUfvMqZkw9ofMNGcqOmOv+FHYQd24dlxxmYkp7i7bRNAqDZaTqttYATHP8vsQfDxSrpXGuflqnOH+WuRwqD8JzJhvZqTVEu/PPnkDrcaVaV+rIRAt8ordXE18nrWkCVuOKCcnxcZinnTbVWNAN1yHXUG08zbL9w4Ud9QGmwi9WznxqaJ1xoMMiT/gtErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALm6Kt0ZpvNRU+WaebvNOWUhogfJRin4MjVwc9O9dDc=;
 b=Xd+6hJgu4HzLX6FeBcfkyIYBN3dQWeIs6hilBQafpq9p4O1oEf60+WwvEPgvoe4pp20Oe6b84kpucBKmh8YYOgZNOj3L6zumLZxpbHl88EPihoOd4zeP3slw3MKYza6Y8ugkbK8y5ptLhhI/y7eCvv0gF3p4p7DxEgpYxT6ZpAYc+YcyGjZ92kniblejGRA4GOP3jiIapyV1ZAjmn6/N/efgkooOyUwCZZxDbTyhNUOm956O/7PNRrZQ4ZlBbvyt8IP/Wch1wEPOYmD3LlNhZ7vQkh5qvmbyiR7M4IulEPMibnvsuWlHkvS+QY0hrJt2n/nFicCULFLuRJI4g1Gw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALm6Kt0ZpvNRU+WaebvNOWUhogfJRin4MjVwc9O9dDc=;
 b=S/z20ZtBxJuUqT2jQUuFCD3lFO2p+duB31AGoCjuk2WVniEOd59KPrIw2PXoUkRsg/vnwyvlDinu3ADrweO3tUI/xoI94095io/NlhjX5t6I3QQ6OxMa2g3mkv+ljtzN+h17eC3Hfhf/UlWMOtTDe4u2Da1f7p2+GKOHXCzKzyo=
Received: from BN6PR19CA0105.namprd19.prod.outlook.com (2603:10b6:404:a0::19)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 15:39:30 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::59) by BN6PR19CA0105.outlook.office365.com
 (2603:10b6:404:a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Mon, 13 Jul 2020 15:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 15:39:30 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jul
 2020 10:39:29 -0500
Received: from DESKTOP-3JO4JG6.localdomain (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jul 2020 10:39:29 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: Add missing DCN30 registers and fields
 for OTG_CRC_CNTL2
Date: Mon, 13 Jul 2020 11:39:07 -0400
Message-ID: <20200713153908.14815-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(83380400001)(47076004)(2906002)(44832011)(1076003)(82740400003)(8936002)(6916009)(86362001)(356005)(8676002)(54906003)(5660300002)(6666004)(81166007)(336012)(478600001)(2616005)(186003)(426003)(70206006)(70586007)(316002)(26005)(4326008)(82310400002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 647021e4-d692-483e-0ede-08d82742eee8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4285:
X-Microsoft-Antispam-PRVS: <MN2PR12MB428544E6A3C91BBED10E3FE7EC600@MN2PR12MB4285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KoW6jPBC340j3VtZ9LyzhtiNMEmF2Z7X+qCak/OH6Kp16uSvtuYY3JNw3nadApfLcAKsmujb+5yhP5oa8A519GmGxYaNwrYzHRTvTAv9o63GRZW622HufbYwHFBeoCGP8vg9WnJEEEC0KcfAOiclImULQ2Yyi91okakQR+Uwl6jrdd0xlvSxWsLd12IqfOk28ZbOtxCJsPtBpEmPws88b5EElsYkO2jqSYrEyoJDoRK0OOP7rxJONgAeH9xTo3EELbIW8QybCWmsWlxAyr8PdfEznxNsRoCMes7CqmpuVMfX3jJ7FFA6mTXp1CjX9rjiOp9apPCntHeEWZYxEBESU7BHgYnYyWdPaTd1ZrfuKjJbHEM2aG0JnQYxlmfFSGfwH0dGSRmT/fLYwdnhCmgm6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 15:39:30.2005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647021e4-d692-483e-0ede-08d82742eee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
When enabling the debugfs for CRC capture we hit assertions caused by
register address and field masks and shifts missing.

[How]
We want these registers programmed, so add in the SRI/SF entries for
this register.

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
index d4106dd5a9b0..33f13c1e7520 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
@@ -98,6 +98,7 @@
 	SRI(OTG_GSL_WINDOW_Y, OTG, inst),\
 	SRI(OTG_VUPDATE_KEEPOUT, OTG, inst),\
 	SRI(OTG_DSC_START_POSITION, OTG, inst),\
+	SRI(OTG_CRC_CNTL2, OTG, inst),\
 	SRI(OTG_DRR_TRIGGER_WINDOW, OTG, inst),\
 	SRI(OTG_DRR_V_TOTAL_CHANGE, OTG, inst),\
 	SRI(OPTC_DATA_FORMAT_CONTROL, ODM, inst),\
@@ -248,6 +249,10 @@
 	SF(OTG0_OTG_GSL_CONTROL, OTG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), \
 	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_X, mask_sh), \
 	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_LINE_NUM, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DSC_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_COMBINE_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_SPLIT_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_FORMAT, mask_sh),\
 	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG0_SRC_SEL, mask_sh),\
 	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG1_SRC_SEL, mask_sh),\
 	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_NUM_OF_INPUT_SEGMENT, mask_sh),\
@@ -280,6 +285,10 @@
 	SF(OTG0_OTG_GSL_CONTROL, OTG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), \
 	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_X, mask_sh), \
 	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_LINE_NUM, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DSC_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_COMBINE_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_SPLIT_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_FORMAT, mask_sh),\
 	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG0_SRC_SEL, mask_sh),\
 	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG1_SRC_SEL, mask_sh),\
 	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG2_SRC_SEL, mask_sh),\
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
