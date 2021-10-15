Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE761C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E18660BD3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E18660BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 150046E39B;
	Fri, 15 Oct 2021 18:39:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711CF6E39B
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATLI4oZbr2zPE/xujx1c8GOCj0y/ZRXNCFA5NRNIgM6JBayoqHiTP25mq7rnBN/xzgHZfTzUIffsnKBGT805XlsRcz9wXGSOhNUWWC6hcQOGE4WBmhSKxFJnkwUv7P9hm+rREOE1/D8l0uFVnKNS4cqC8jro9tnO0PyjIn2dk9stPSfIE9xz0DVpcnrGAX9nfEyhPt2K1RF/u5uPJDbAWjRcc+gNt74bZ8bcD1d7wA9HJitqZIQi1CNZiyZVoRoba/hx1DVWc5k8qtBOqZSVOyL/EEqELPJZIPbPBqatQLozflgOyPrnTHjCt/s1ysVBT2MOTSzCQMWe2yT4V4hAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm/NoxMJGj3n1OwYit3vnFZke3rA2Zs9HiKrcFw+kbY=;
 b=C8zHzqsRev5fe1+XETGFrI/Hh3lwLb+fsLP4Blzj27PnMDCS4hyCEruIkl9LttiL0LynckqoC5JFSXD+PcZajEHcktgNdhCBpcVsUfyVl20NUsJMciGyBhxqK+ApPBKhMbK3Bmnw5I3GKQpPFGH34xJt26WRkd1UTflnglrhX749F7SXmq4i3qMx/WLOBiWKA6IyJDsiMgkmf2grsfXuHR47OHqrd4VuxcCSDhWSCkvaoktzn8tep6OensyN+fd1+ABTHaRIIBhdFnqfceahDoKB7IXodDP0Qev+Tcp6FUSZd9MXwz/S36qjCG8ePIIE0fc1rg8pNlJF3f4EBKfmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm/NoxMJGj3n1OwYit3vnFZke3rA2Zs9HiKrcFw+kbY=;
 b=19y0XOHMuv9+TULI1LUIdHS+0Ii0hIOj4Rf2NJczhG9rElNvFAcoTrT9VY7ub2MNpdcjd1M7NXXuxpb02SUcbMJpAK7sC7caXrHGgtbRd/CqLs7HKjp7xJtJTb1naB1Tq373n/+t8seFG+xnElFAN9WF321Hr/XQpj6M0MZTbDU=
Received: from MWHPR04CA0064.namprd04.prod.outlook.com (2603:10b6:300:6c::26)
 by BYAPR12MB3288.namprd12.prod.outlook.com (2603:10b6:a03:130::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 18:39:11 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::35) by MWHPR04CA0064.outlook.office365.com
 (2603:10b6:300:6c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:39:10 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:39:08 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 02/27] drm/amd/display: Clear encoder assignment for copied
 streams
Date: Fri, 15 Oct 2021 14:38:20 -0400
Message-ID: <20211015183845.220831-3-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015183845.220831-1-agustin.gutierrez@amd.com>
References: <20211015183845.220831-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36d3c285-bba1-45e2-1483-08d9900b1435
X-MS-TrafficTypeDiagnostic: BYAPR12MB3288:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3288F876D5756FFB3A27302DF5B99@BYAPR12MB3288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QArC7T+WthfCMUqBd4l7LN7600ladHs4l28SLOXq0q46cIirrby76LypPYakn4S/p4oKQ6se4NGlaTd/1NpeW6xtJByQkPT6v8UvTZZCyqFgG6eP1C9hOHR4FzGUSPeXKZapDLvrIamYIQ1tTBo+rjgcxTwkgYK8oi4dbB3A8ZoJQi9rf6M2RnS4rCBgZVcNyVElv44PJaUXK/l2+SVATsdJ4aYulvTw8TxMsBa36yQgv1wQm9Lb4Q+jgl5kxuSRSykqS0VPJkDyU0XVM9WgloFoi/bp0xEtZUNJxR7PPeGhCGf1g+25+VI97iR40kvmQHVGFhNKkMm50XnfotNkOYGdyzWz0X81wV7agPTvZj2AK3cog5HMYonCdO4ltPz4wexRbv5XfDWlYwFxOtZ5ioBpj8kxJaysesO3afPQs8Wvm+CXhR+FqbC9rp/QjU8vGP03tCpVBwKzZU5C/VUt6rX3xWU/BVjSP5dxWeBTb1KrWmIAh7XXH0OW29OV7n9BSNQ4Q/AIcmOIn7yXhhLxPoj/ZObcZywoZ3tzdlm8pJ4iNni/VbzUNjQCto3hvBJUg/ntGaNrGdKtM/HtZdmYzvt33DzcBxqbWswHCEufIP88/PraB/ofBJdaMxqZevnJg8bQOJucq1UQHvcPc46288GnvxP74Am7zOzWeqGlCOaP5EuK98s+h6Ls4rM/X4mxozAMd5Y3JnKwTxZLoxBORm1irpaT1+R5kgAvLbVCbVY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(336012)(508600001)(426003)(44832011)(54906003)(2906002)(8936002)(26005)(8676002)(316002)(36860700001)(6916009)(16526019)(186003)(86362001)(4326008)(5660300002)(82310400003)(47076005)(356005)(81166007)(6666004)(70206006)(36756003)(70586007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:39:10.6259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d3c285-bba1-45e2-1483-08d9900b1435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3288
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
When copying a stream, the encoder assigned to it is copied too.
Encoder assignment should only happen when executing the encoder
assignment function link_encs_assign().

[How]
Clear the link encoder pointer for copied stream.

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index f0f54f4d3d9b..57cf4cb82370 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -202,6 +202,10 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
 	new_stream->stream_id = new_stream->ctx->dc_stream_id_count;
 	new_stream->ctx->dc_stream_id_count++;
 
+	/* If using dynamic encoder assignment, wait till stream committed to assign encoder. */
+	if (new_stream->ctx->dc->res_pool->funcs->link_encs_assign)
+		new_stream->link_enc = NULL;
+
 	kref_init(&new_stream->refcount);
 
 	return new_stream;
-- 
2.25.1

