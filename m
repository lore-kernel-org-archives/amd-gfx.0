Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19CDC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AFF20723
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xZrWN/dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AFF20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B0889BF0;
	Mon, 25 May 2020 18:13:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3541389BC2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUWPWqd1c7EiCtJF7hgcYzqHsNlcTqlLszHUeCDyN6Heyv5//4cZ+gOqKIe8ZxtNbPyF8TdOLNdfUw91jRCpMIlm+gv3DinzDtEa5y/PL7fJgK891EDM746fwGU1m3JLpa3++ARvYM3+O5qqIVJhJXGJHalTZ5dhR0P8FIptElGdS3JHHpFeH5H0NF+21W5ooRokTQNW2LinbNd7uzTAWxRGXDs9KdusLDspW/vokc6ToDq+IcfJ4GopBEZHy9EJLUcF9hqtOjoz4zTWz9TW4+7zi9Od+Aj8sEXTWkb6ypeQACI+ir/a1rbF3pbUSOffksyS6M3nBpu9eckJ2CBcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SODvBVYjriYcUp/EtsOKAO8q8rwFrXlYhzKu1e98NnU=;
 b=nsI124ADP24flsjAUaYC3t9HjxpvJaZrxqD/GGyEPAnWuuMyk7cyAvRiKkMRIexhrkUghHCAj3PQol8q9QhuZX3ThMqPmQc8w2PKwbyY8NNzWk3EoDnR+RxTUFYlVe84LV6ujamN3ss4drn/hOY0VG/cvdqZx5bqFaMkoEXw+6r2LnHdbz6c5a3lJblUfEL6SIaS7r1opeR18ZskNBXF/Eq/HwYEVrEiRc387Rpfn0Gn0ETxRGH6SofofikgZiqWhumbGg+2UW1Yp/ppD6v/ocIt7SUIlUtZ2eKgCsFmIIIyQwsN5o2JJvV4EemYm7z6XNXqymA/rRjis4pzpAL9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SODvBVYjriYcUp/EtsOKAO8q8rwFrXlYhzKu1e98NnU=;
 b=xZrWN/dJGq27z5XmTZci1d9Vcrg4Vw6w3dwvmNj8hJS0pIWvT6AN65RBrPN6pmqaswJ1xl3irRTlvDS+3H1XrpW7fJ7nyrPzCGhLq/0UX5z4VZ4Ip4uRZNk0naO8tYh/OWZMfiXwCrZlDkaC2dakO8rWyiHd3AbCQW6rqvbTSVk=
Received: from DM6PR02CA0039.namprd02.prod.outlook.com (2603:10b6:5:177::16)
 by BY5PR12MB3746.namprd12.prod.outlook.com (2603:10b6:a03:1a7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Mon, 25 May
 2020 18:13:12 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::71) by DM6PR02CA0039.outlook.office365.com
 (2603:10b6:5:177::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Mon, 25 May 2020 18:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:10 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:10 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:10 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Fix potential integer wraparound
 resulting in a hang
Date: Mon, 25 May 2020 14:12:55 -0400
Message-ID: <20200525181306.3749-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966005)(4326008)(44832011)(336012)(426003)(316002)(8676002)(8936002)(2906002)(2616005)(86362001)(82310400002)(47076004)(82740400003)(5660300002)(186003)(356005)(81166007)(36756003)(26005)(54906003)(70206006)(478600001)(6916009)(70586007)(1076003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f485d568-fc92-4631-5b1a-08d800d748f0
X-MS-TrafficTypeDiagnostic: BY5PR12MB3746:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3746DF5288C1AD1A04C3B798FBB30@BY5PR12MB3746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIuSjtTIHf+eL3ZQLub2W8sKBkcXxWqyERp+QctVk2stppNpg0uY2ZG6zftut2+762IoecKIjSPOJHg8yBI5EuzFI/V0/EWgL2iKxm5tLNJimKaRHLLmFVhgQOZjTctx/7C0hNYmOlUXzYDI3QEVSb2bNPbnTpDztOmMOLb6t+jljgECpVQvsgTvvr5JUUsnlp1e8oRYYNm2bjQi3oq+hctdBYWn9eRuiZi8LdYGkgla8o/afWAxolXzuI/GnLIV6w9xotgcXaQ9Se2K5GNf+SvjoyPWyhWAIuv/U1Akj8JopJvoiZ6KV+Mwi5sdxnqW+qI7SyxOR+Qi4E9FP7PMiuZsn9byJk8sMguX9HNH55zKOeqlI+vkR0vF6goBur7kPlPJJeu5kYPnB5Qfv6dqWw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:11.3625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f485d568-fc92-4631-5b1a-08d800d748f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3746
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
Cc: Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
If VUPDATE_END is before VUPDATE_START the delay calculated can become
very large, causing a soft hang.

[How]
Take the absolute value of the difference between START and END.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 4db6ec96eea1..0313ca83cdb9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1742,6 +1742,8 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
 		return;
 
 	/* Stall out until the cursor update completes. */
+	if (vupdate_end < vupdate_start)
+		vupdate_end += stream->timing.v_total;
 	us_vupdate = (vupdate_end - vupdate_start + 1) * us_per_line;
 	udelay(us_to_vupdate + us_vupdate);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
