Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CF3C4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872BE60EAF
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 872BE60EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 456716FA52;
	Sat, 24 Jul 2021 04:03:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C86D46FA52
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZz+SxW6naqU7PfjBhQwAPS9sMTFhQyGdF8+lnZqt29BQhsanrgcX1yEGZLVMhUuY5XKv9MWPkBjUXN62B6qqBfSFNWnSIqVBqgvwbogD2UvDCx/GFUg2ONpXJP4rXAhnvQMPH1bXSWtEI3MBvT0GbiH8hzBgNEB8kAFo3Ph822X4tm2LxwlHTZWptXJaMmgxS9WcS2t9tq8qBboTDDiLJgaY5b+RI6X0WykUIdz43VficUzGCSB64v//ssk/c4iTphhUrZJ0PR77KIALx+th4YU2flpnHAfH9x7hkylOHmbW7DE86Jp876uigANvIpYMwk6RhEUMTOW+yDOge4fIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2QFfG0balpqSENZMem/MKvJEazvEX3+OeWZjdBuRLw=;
 b=T2OYo440/21DMag9QtPr/ZeZPcKILTP+PZxbgIFyyVSVKsc+tVSauno3KlSZqsyUILoa+WUal0WSHMCmK9W4jhuJ0JuIfkF5s63Fa3F0ep1GxOgp8dIXZPhSzWULPFWdABvXAMWkvIrv6V1OlIm05fhXGwsmcrmHXCnAM8m2hAoT626VnOfz49J9I0wdF6C9XhLwrmwUPV8hX0IFQ73IWzCAUU7VBdXCEOmgnI8sbUkygVYlLP7QWWi9eMzJqu6zcjKzTlHGdjbvPdlOEp1UtYtFYiFK6o+wnO9VG0F6X1bTNDYF5AVk+y0KxB3s6Rbd368Fb/Fb+qRPtW7gU5wlbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2QFfG0balpqSENZMem/MKvJEazvEX3+OeWZjdBuRLw=;
 b=vCnERRWAB6GrVgUs91/pi31lXRLTxoCNtE0fWzZLMNcQQf0h6Q5e3h8+p/GXRzzE7h2DTYEQ85FFmv62BhIy40GIE7W9mtMS/8MEUll3uIdMJsVPIJ/DrDJx0xrNTYqy8BvpjDFegxVNj/w87Plewd+bTzneUwKH+AZmuNpxPis=
Received: from BN0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:408:ea::30)
 by BN8PR12MB3601.namprd12.prod.outlook.com (2603:10b6:408:46::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Sat, 24 Jul
 2021 04:03:47 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::37) by BN0PR04CA0085.outlook.office365.com
 (2603:10b6:408:ea::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Sat, 24 Jul 2021 04:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:03:46 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:03:43 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: Guard DST_Y_PREFETCH register overflow
 in DCN21
Date: Sat, 24 Jul 2021 12:03:01 +0800
Message-ID: <20210724040314.3865608-2-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d337843a-6a49-4e78-a3ba-08d94e580951
X-MS-TrafficTypeDiagnostic: BN8PR12MB3601:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3601AC0D0131646116B93C3197E69@BN8PR12MB3601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nwo+NGEbdPqO5MUgeR1hi0q/GxgAP5yHtr0fO6xKsY1UCwDae1gf1g5YiDmxrYWwTbDWJnQCt6rb4B/8UNLihCIj5SNTbWNG8etKJg5dmqYMVwEYLp7P1WMOw2fuhRdOFkeD4auTLpD251NzF7g7TmwmIg+zHBTZueccSxdjkCQwVrFM6Yho4bZk0Xp0zidfeDVb8HirKMkmb52P2fGNuCywtjgI9FKJCAXLJOUSc52OxMU8CckQLFp/S0s5LbYAskrchoxNKl12LKtGCyr59wgSPulBcq48GiImI8Q8Ox6h63SAUeu2CMOAkSTOvi0kDg+0OEB8XVVdlsdbYGuvF2lvKTxBF//aCQ1HXwdlMVKl0TPHvGbvTc0ko9NhlCXcThrq1UZQzur/xiL5qFUh/oS45K1o3k+LPreHdlVrof3xR247CQaRP4iwAQ1dP/1iFu0pBnwxG3y0wXEp6A8Wp8Ej+/t4qQu5woFmC+CgdFVKb+ANw7+jNz64GIFSLHPrI0P7S2uudUF3HIMwFlDEy8PS2+CewXEN/VC9EoX3GdsbWLbf6eDJgIda7/3TxN1CAbO74Xgeo63YzlmEB97Aa0MUN2iyvCaCBbQlRBZ5hmRCHgvzFc2yCYZ+FC2PK27FnfjNvkZGS5RvHD0c62DRbhpLnPuVWLd/pvY3+QErnkZNZwxmw3UvaXB9QU2jBqUVkpSV58T5A1zzExri11hzCw1g99jWZSbUoZQmyYjGvZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(81166007)(1076003)(2906002)(6666004)(8936002)(356005)(4326008)(83380400001)(316002)(6916009)(36860700001)(44832011)(186003)(70206006)(54906003)(8676002)(426003)(82310400003)(2616005)(7696005)(5660300002)(16526019)(86362001)(70586007)(508600001)(26005)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:03:46.9539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d337843a-6a49-4e78-a3ba-08d94e580951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3601
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
Cc: Laktyushkin
 Dmytro <dmytro.laktyushkin@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Victor Lu <victorchengchi.lu@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[why]
DST_Y_PREFETCH can overflow when DestinationLinesForPrefetch values are
too large due to the former being limited to 8 bits.

[how]
Set the maximum value of DestinationLinesForPrefetch to be 255 * refclk
period.

Reviewed-by: Laktyushkin Dmytro <dmytro.laktyushkin@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 506797c721ed..4136eb8256cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -841,6 +841,9 @@ static bool CalculatePrefetchSchedule(
 	else
 		*DestinationLinesForPrefetch = dst_y_prefetch_equ;
 
+	// Limit to prevent overflow in DST_Y_PREFETCH register
+	*DestinationLinesForPrefetch = dml_min(*DestinationLinesForPrefetch, 63.75);
+
 	dml_print("DML: VStartup: %d\n", VStartup);
 	dml_print("DML: TCalc: %f\n", TCalc);
 	dml_print("DML: TWait: %f\n", TWait);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
