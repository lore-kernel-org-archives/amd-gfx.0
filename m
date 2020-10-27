Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447CEC6369E
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3A221D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QR1kBwe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3A221D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAAEE6EC5D;
	Tue, 27 Oct 2020 20:53:04 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700081.outbound.protection.outlook.com [40.107.70.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E286EC56
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDP8RI/MGsSnMw+k4AvWNoE/OwVV3QFht+dMTKIn/r+//CPI4gZnu6kQsqRLQ3XOlqnY3YeXsHVzsoAPlv6Lkfky2Nv3Jl9r8YTVpx5QWja2l+W2hxhjZmgDOehy1GlryZOeK+RfH55aZnDMgOTTor3MSpXEgPqM7TJcvYzoZs3CM2VxfsQBfpumYvJ02S1g0T5/6v/1DIE/jBCVa7fmfLRzcUdr3fPFvEkzRhv95h7pgAqoq2tuDZipZ/NpBAPjmwcfOfSnRI0xJgRuWHVebUYxJiQDBBUhkhlHLkFz6GPXDpkdvYdApqwwL8GnROdSESTMei7qDA7mfOhw79APRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyfr2+8Vs3CPiHRBiZACzeb3qx4B5VjcwfhmZT/hHGU=;
 b=EWNDDXTn1OxDuzRmgZJjpRzPek89XM0BsjNsRmb8aWXYvDWdrt37+G1IO211AFvOnps6PgSxz8zj+BPIx3CT8WnAcVEmGdqh32fLfIrAPI9L6uQ9K/V242EhQA7zYWlGnqxbMLnkq6HnhHd3ygnQMWk8c+6FL4Ah/uJMlNghzNcRAylOKTp28FlX/QVz+MNhZyLSN27YGoIdDEQnKGZJFBuSXHgCHnixUErAXWgK3+z1DEPCg3eoESbLspMbP8HCEtdi3fHEDGNulv6QiOP8Xuf2ng42VdTNUZ+nQCMPOznjbGI11uNWORarK97Z2DCOozaYRR2X+jTgFGIUu/HiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyfr2+8Vs3CPiHRBiZACzeb3qx4B5VjcwfhmZT/hHGU=;
 b=QR1kBwe8Jacqy/tr09wrXA3XoiK05/U64hd9H4i/+dyj8Mf42O6+DrqjJKu4xOq/gKxMSJqSowVaYRPuPeot7jnc4tPEdkZQfb+r7U5kW/NuMhtxisSHnpb5OSy8gy1oZhKMjT/hEkDaLWaZlLsGet/HjUBRXwwxtNERfkW8PIk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:02 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:02 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/25] drm/amd/display: Reset flip_immediate to topmost plane
Date: Tue, 27 Oct 2020 16:52:24 -0400
Message-Id: <20201027205234.8239-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad4241d9-7ec5-4853-70be-08d87aba46fe
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB359570704BF964C793148812FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eeJAkALLh5RGBrohfSSJiB851a/qiubuk4fePnmxiQ5ZWzgTPtc1OFcdV/YjxbKyX9TbPCZjOUCpV4PTQc1ah8xmcNDko6wTIIeiqJKnfRpZG7mo/kiF1pIgd3VB81V6d2erqv3qWl9zyr+FddoOwgo2NphDU5KUQsZwok91V0giU7bEKNFJVy9NHHfnJaadmQ7PfOYyRgbXWS1PAVAdAiN37bpr1R5hpGjEE+y43bas4gKVu4UKhxGAhcH5lgt554znScmF/2qyp45LmHFpNiadNM5wLZdi9vVBET1xRAceR1h75A8X+0XnuwvHV5IYVYiGTHKG08EbSwYskfMvnJSSH09tjUVYeq01loTYSRwX63PhcOEbmxTzUkFeRNR0CyiKdTzFO2JxI4ulv1y8K0Pz+JHaBLNP4OsUMJtwl/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001)(14773001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MVOuidR+1kUhrcBN3AYAg2j38HKHlhjqA+x/FpSV84H37KQ7sl4Ygdhj32zh6n1JWoPtXTyRVjExE5OixkRUuDePLE3fgU3XZZUstWZny9+pWmFPLPwcV19RAF4MxSGEq2+1g/OsCrlmBdS4v+Q/yfju7u/RUVpwKDXlZDlE9NsMEPubmRAaHmua3EfCGr8J20SqpcpIx6xpV8DfQq6kP4EUDe3nddPFAWXH3HLxbSBeHTgLJFeaf/HUy9Tm6bH6rJIPmDJqPhkqOJ3x5TS8JdBPoQ4cmEWfqlHIgKWRtRgl5xgINjgLJIg+PlokU7jVoKeGR+awlF8YgazLwpOXq5faYynz3sP9Fw2pwlBQsR+S2SIys1XDOPL1A/OlehQeZWFMz2/n6VhGQC/IVfKL1zuJaSu40B2/7693YsUB0OrhWBnWRiqCQcCGRmfzibUgXUPvBg9y85WtKy1hGrf2hefMJWhvsCm4rz1D6PAotUGj8JkBmc1LpGwWzJuVXxgxZyK04GX5lo8yyDrOI9PRf8HffS6bEOGVOiPQc7VoBCBXu0F9roceZ1NnsyMH97imZzSFszTItMZectKpW4tl8iLEJvsBtKX+5iZ5psi0UnpLLRg8srLT5tLpTzDBBCSbht+KWb4QueqkBjXZWWfjzA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4241d9-7ec5-4853-70be-08d87aba46fe
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:54.8270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bl7MU36fDEJRPtk+mxNBqRMW38zXsWknPXDibqG69xj5qPTg7+ssypbAvT6C9NR0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
When checking if we want to disable GSL or not,
we should reset flip_immediate to be the flip type
of the topmost plane before looping through the
other planes.

[How]
Set flip_immediate to be the flip type of the topmost
plane before looping through the other planes.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 3b26396cbc5c..a195dfb718dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1204,6 +1204,9 @@ void dcn20_pipe_control_lock(
 		    (!flip_immediate && pipe->stream_res.gsl_group > 0))
 			dcn20_setup_gsl_group_as_lock(dc, pipe, flip_immediate);
 
+	if (pipe->plane_state != NULL)
+		flip_immediate = pipe->plane_state->flip_immediate;
+
 	temp_pipe = pipe->bottom_pipe;
 	while (flip_immediate && temp_pipe) {
 	    if (temp_pipe->plane_state != NULL)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
