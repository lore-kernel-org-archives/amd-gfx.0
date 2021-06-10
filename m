Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B7BC48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71B061263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71B061263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DED26E4D0;
	Thu, 10 Jun 2021 16:29:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538676E4CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDb02IOsDAq1xVpYo4295ZMzCP6lvlAWDyHeFrZ3j+J6m7kRJ/0nGi4vTjA8XOUJKwLmTwfAyaICYDy5Cvk6HSxIbov7u/+03zJZPtPvbWWioGKlJ/PW3q3s2lOFz2hTFuopTRsF2dPuEaGfGKRyIQcuRIdNSXPjwwAZyBBctknSyFwUcI5XLNSWsOxUZBLFRzAyM6vGb7S6gC+G7rzw6MDO2+wVpzu8lBmhIQUhfXVILUHzvua4nKLwv8pweBoL0OT1wY36m7IJe48j4W5esDvwaZW5kPu+aWPZgoCfmNAtB+x7lDeip8wEcVZs8xFgdlht053hTvcfR5hPIovtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEwYekOLnnaCc3B6btpnXfyjuMC+mtwYuzZ+3xOitPk=;
 b=ZXsjZS3lqpuFNrbQEL4Vqk0i07mKqjQV1lHuIWiU7nJr4wazN2acFzRfz7068bn1ugZ7PANqOj0IpqJGExBqvN8sL44wI/1JVN1ARcU3bs0SJ5dWJYFt+7X3jdPRDsgqS+griY7TQc/CASxXQPjv3MIKgeWNL0KM6j2r1WnCUbzzITIOe4RVY1yVW7cOCZSE6IXr5+R5ad0jRzGhOtQ5h8tOBIqnjGveZVhjcX3CInsiXsUpsERSdHXKg3nPorJXdlt+99cBK/QVkId0TJo/yInLd/dlicu4sHpQfewuZ9+l60mYZcPqIChyHnRmQyy3zoa5E1B6K2IZhJdgCq2zpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEwYekOLnnaCc3B6btpnXfyjuMC+mtwYuzZ+3xOitPk=;
 b=qqH7+IeOiGPVONOPYNkthFMiHKg8fkobcYNSrtnPjgOXMS+xcMlHzH2A24gN7oOijScAWYpIzlhKZmVQhsqhf7PzVtphAuYzNARQQjXJlydS1uBy6IhiIV0BvbnGhUh73fWyhndyW7+UGV5qjzZqrDwlCE9f97kILqlHdo7jxeg=
Received: from MWHPR17CA0064.namprd17.prod.outlook.com (2603:10b6:300:93::26)
 by CY4PR1201MB0261.namprd12.prod.outlook.com (2603:10b6:910:1c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 16:29:08 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::b4) by MWHPR17CA0064.outlook.office365.com
 (2603:10b6:300:93::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:07 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:05 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/24] drm/amd/display: Remove unnecessary blank lines
Date: Thu, 10 Jun 2021 12:28:15 -0400
Message-ID: <20210610162838.287723-2-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c7c6f03-e43e-4151-d973-08d92c2cdee7
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0261:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0261BB3000EE1A9FCA42A62EEB359@CY4PR1201MB0261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/EAH7ggdBFiULdhpZVVxCzvj8gcONdyhX3c7TKoA3MvRKNvXFzkXdLcKyxd08YoHLW+xkrUGfyLNPvTiM4Sn4szbHu2LaS7YowApCMpYytgQl94EtHxSuvV+ORI+qicVsQlOKwzpzYE/46P4RojfKLJp0EXSrFmDN9uf1YFVNM3J36O7OScEo7lkzxS3buei4mh8jbmDnjeB8rOaODPAmSaygfiAeQCEk6zz8jFqyDbPDEKFGC78SBec5jHr+jVl6XUH2mWHoU2wVxlonkTxv7vz88NLtC39AR8ecwiXvdM6pf9fhv0ZR5HkjNe6ORkqOA0IbemuHrUPmJ33+hhnoQVqWzaP+wzWzwDr77B0gdKE+MymVbNnDSz6099dPJafuZg/0DDzg6OkPGpel/Xerv7Fu6g9l1riuSJuhunTzPgickwMfll/0OnXteU188wPWrKquAX1tJRlQYvdbxzD7xcnySyuXoxbJF/BaoO9UKZz6SLlipr8a9f3ZnpZpB6jKO3ZSSbHVEEktNkhlcbbcRWiZzT2z3uj56+NJxVhvRAEKOWiKM8o9wr8rCjL8YLr/wDqmsW1XlIHn0PdW7xA2MXYuq5jT+mqhdh1/bSdiQv0wFOeUCQfOUCSgecFw9C+pWDnk3QQPeI5EIOvqN8ZoWUtrDritM1+pMKFuRL2bpaAQVMo4Fi//DwjE8pZ4QB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(36840700001)(46966006)(8676002)(2906002)(8936002)(36756003)(6666004)(47076005)(26005)(82740400003)(81166007)(70206006)(36860700001)(1076003)(356005)(70586007)(5660300002)(186003)(336012)(2616005)(426003)(478600001)(6916009)(7696005)(54906003)(86362001)(316002)(83380400001)(4326008)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:07.8036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7c6f03-e43e-4151-d973-08d92c2cdee7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0261
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Dmytro
 Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

cleanup

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 345d2d409a6e..0ea9b18662e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -159,7 +159,6 @@ dml_get_pipe_attr_func(refcyc_per_meta_chunk_vblank_l_in_us, mode_lib->vba.TimeP
 dml_get_pipe_attr_func(refcyc_per_meta_chunk_vblank_c_in_us, mode_lib->vba.TimePerChromaMetaChunkVBlank);
 dml_get_pipe_attr_func(refcyc_per_meta_chunk_flip_l_in_us, mode_lib->vba.TimePerMetaChunkFlip);
 dml_get_pipe_attr_func(refcyc_per_meta_chunk_flip_c_in_us, mode_lib->vba.TimePerChromaMetaChunkFlip);
-
 dml_get_pipe_attr_func(vstartup, mode_lib->vba.VStartup);
 dml_get_pipe_attr_func(vupdate_offset, mode_lib->vba.VUpdateOffsetPix);
 dml_get_pipe_attr_func(vupdate_width, mode_lib->vba.VUpdateWidthPix);
@@ -419,7 +418,6 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		visited[j] = true;
 
 		mode_lib->vba.pipe_plane[j] = mode_lib->vba.NumberOfActivePlanes;
-
 		mode_lib->vba.DPPPerPlane[mode_lib->vba.NumberOfActivePlanes] = 1;
 		mode_lib->vba.SourceScan[mode_lib->vba.NumberOfActivePlanes] =
 				(enum scan_direction_class) (src->source_scan);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
