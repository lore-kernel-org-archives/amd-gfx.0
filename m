Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E438C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A0D60FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A0D60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1EAA6E93C;
	Mon,  7 Jun 2021 16:49:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E94C96E93C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WP3yzAF/l64X02LC1DEdFL97eK+YhdvxXV5wxjuot4Jm9l0dj5qjSHK+qF9ErIocbxtCuhSQdgTh5nyLGz9sKWSJqtvabrBSgmpkarUSqaGlzkkKGzXSD1M16JwAGhp/1Pb3er/x8oDiJqSCOhXBnwmZWuj0tBvf5F0npT2WFrpQR2J6wexszIvXBf0aev8kiXj5z1LgAfOm8vFH9kthu2TuJ4dCu78N6TNzADSJ0jtjchbX7t0JedYY4x5SFJ8+S4BqH0weT09ur05ep/sr90bzLhNS4KeQh0X/zBoV4iblsydNMHE4bOrNvFQKBG43DpAsCR3JOI9ZlOOfwHNjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LL0FjnWohh2vqW4aAytvCYBgNrVm5FO4MiW9HtU0Qo=;
 b=Nt7yrku+H1BWheTR1QUqk+OVLW1t+yRUQFvbhlj3ECWURzPsTkLWPmrmFvvFihMsh8mAnJUUnLOaG928Fvl48NhFbfzthkN2fg2hqaqu0IlvzoU2RU521AYpRiKjHZOhI/NeSMQDYSZcCTAKNfkc/ccSkYnr/D5hE/jc4uTNEYUDJPjY+dxTMLypKLnHn6aTKEYUM840j61G/rB7B2quj0pe1xTYO75lsphobLS0eY1N3tiVagtdzkLaPSNER+6KO9udTa3jVWtF9El0tFVDUF3hehr1S9YeBkkd3AUVzkx22wWCKcf6pdjdvcfyhjEMvRfOYZxs7VWyAukK1c20Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LL0FjnWohh2vqW4aAytvCYBgNrVm5FO4MiW9HtU0Qo=;
 b=MU5EvrCDSZ1n1h3JRn3zBCAOd8etlV9HNoMDy67z+/DiCX086Oj19c1Wj0KQwKun9JmdA7KtdQiTYy5zyleRqpzp52cVFcJvOh4nfSPBbQ7PBPHl+DFKP/E8kgg/i3666bPiQuHQNSRp0zc90NEEjI2pnqj8lGfmQfOPAddhDBo=
Received: from BN9PR03CA0093.namprd03.prod.outlook.com (2603:10b6:408:fd::8)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:49:04 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::75) by BN9PR03CA0093.outlook.office365.com
 (2603:10b6:408:fd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 16:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:49:03 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:49:00 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/30] drm/amd/display: Fix crash during MPO + ODM combine
 mode recalculation
Date: Tue, 8 Jun 2021 00:47:07 +0800
Message-ID: <20210607164714.311325-24-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85339bc0-812b-4eb7-3812-08d929d4287a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4479:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4479505F82D085097B3D8BA9FF389@SA0PR12MB4479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIfzhwwBMVjzdqQV/BoEq07ZX5YjmqNnfSFJQpd659q4ssq6zWedDR0U5kIvoqnQMHMA5WX+oXZHaRl63mUxn4lFNJIRS3aKb9YpeMd1uW3OpYZL9fYsowq00UGv+FXbdB4fuB61aLwlACO6rvvphSzPIcMoWLWBTyXoqsF1pbRmiK2Bw605UEP0MzDazIEUyB0jNmKYF8bIfulTLE5E77euNaiWpVFNh9+IyvtoHGmBv/PEVNK5qNYzpt7ul6TG/fmwVQf01e7Ifx+KPeGz/QtK7euQxI2KpXsXv/JKRNfPc9bNGOBCXEEDeD9XtJlVxpBZmIOe5TmAxgXenwT9W17iQX7HjpS6L/TqcHaLBV8coc/TnyTfriM4REv65I0b1kdwYpM1H8m7hvdvZPmkxYhxZ9qkTJMlsfaYy9h36HHwbGuxubyECFRMJUpu722nBYWQzEwzcVqS1sWF5/89N1a3cE6xO3a1rxTR+NTwv4FS0ROAWx9tIKKxUssj8oHL1q2RQHD4I1XPoKPx+JAs/xI9+pnbnkthdNIjTaPKS/EbEH6QblMWPpFw9VcWWt4HpzDBzUY9M/iYDXyba0d6xflB/7qpcjRGcF3b2mbKYYm0DVkaT3NMJBBFJt2ZTKHW7PX2b+RP7Id9DXVx8yTQeJUVsjgpft/7n6hafLY5Znn9yXRVmwIDS4K5CtsuQpz5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(136003)(396003)(346002)(46966006)(36840700001)(47076005)(70586007)(426003)(336012)(70206006)(86362001)(36860700001)(81166007)(82310400003)(44832011)(1076003)(2616005)(7696005)(16526019)(26005)(82740400003)(186003)(8676002)(36756003)(6916009)(8936002)(2906002)(54906003)(316002)(4326008)(356005)(5660300002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:49:03.8110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85339bc0-812b-4eb7-3812-08d929d4287a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
When calculating recout width for an MPO plane on a mode that's using
ODM combine, driver can calculate a negative value, resulting in a
crash.

[How]
For negative widths, use zero such that validation will prune the
configuration correctly and disallow MPO.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index cd864cc83539..e0598dd9be94 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -783,6 +783,11 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 			if (split_idx == split_count) {
 				/* rightmost pipe is the remainder recout */
 				data->recout.width -= data->h_active * split_count - data->recout.x;
+
+				/* ODM combine cases with MPO we can get negative widths */
+				if (data->recout.width < 0)
+					data->recout.width = 0;
+
 				data->recout.x = 0;
 			} else
 				data->recout.width = data->h_active - data->recout.x;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
