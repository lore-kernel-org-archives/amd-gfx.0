Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5502BC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B94C208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j7OjeLrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B94C208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 235F16EA5E;
	Fri, 19 Jun 2020 20:13:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF8D6E98A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFPj7kaKEw55FSy743yZb/a4puOu0LWNZgoJTQn7zRFC7Hl2UTuq9w4iEcKUdAolaAXfNysqN3qP+bdoXZV4fdxQSirwDgJJk3Ejqiz7Xo40Z+Oo65FaMLgt+KGFUNiB+9CGxXBCrZZTJnc6HgLK7SfeF/vBOBvjJZxJO8tMHBcYIeLbv7EjOelzgLFsCzC61KV2wsXeDumawh/B1FQ4vSyVBAa8QK5LfZkbKyjHtf158KAbMKhmcvSFV++hnurBU4F1h8z0B87qcd4EHYVL1QcAuAag7Qb6vRUV4laPT2tNAITCxo2ARAp7DmxVjVAEU1u+8+P8pmrSJ6ftfBFlUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaYrnoEP+p44/TZbyVsopyvaw+8DL/CRnzssXHBnHtc=;
 b=McDUKzSrN6pG5dJ4NzlAEH7+moYYQobQxq2B78iOJ7mGvLiEdKOUbO7rZIoDrej5QO2X10fut+40q6EYuPz4+UJhg2v+dhYbo1T5TBvjvmKPa2ZbwK+ZgEbowihTxVXrhWaB0f5T3hFp/ZdBLswQvWj07JsnbrunlsNpnJv+a8CM1nU5F/jF5xmEJHvgwgmX6vJBFzT8s7pZL3oMLE2+MquEgb3XyFmSoS3EhMsgkrOeBy8Nd7jpBCMDDfcMAGdGNo2/bPts60WKuwo7kbjQ4RWVLI3jqualNuF6xp3mhfvWhU81vnKPwiPSJ51+64ytqdz0ESNxvk5ryrKXVJwoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaYrnoEP+p44/TZbyVsopyvaw+8DL/CRnzssXHBnHtc=;
 b=j7OjeLrtJnm5wfM6hDbjuJiyt3/oYmYvnWme0GNizI13TABNNXrci3KrfisiVrKDcFxFvYnQzJiXEaS8GoXocqK3x8ptp7nB/LqxufJZBFHrJPq9F73JApY+rrqRivNzWyqgz2JndwGlZfkJXQp3Qt8xe03meOGzGK+tCL+m+RI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:53 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/30] drm/amd/display: Correctly respond in psr enablement
 interface
Date: Fri, 19 Jun 2020 16:12:01 -0400
Message-Id: <20200619201222.2916504-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:53 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 991a515a-d360-4d21-a162-08d8148d262c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408707622FD505ECC8E23B6598980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMLjXQsk9knjDNNAFxlITw2X3+wqA0FmbilZciYy4glQZ8utAzjImMXO1f8iFjvy4aSBRsXOTgWrpnqCXiojCBrUmj8KCJ4QPKavnahj/madIQWptqyvkcx/b0w8JGb/UBybZdwrJ8ecKr+4vydhlBloCcR000C8aBPw9U5DQZPtRsqiWSu0T3Oa3fgnPJ0P52+Pw6zq9R3PfLEUzqCcZssfRsEzTttWPWAmCCvnnbIenGDhfnxqu8DH/2tcRILAXOY7rtrLIyXErgIxGhUazEKarz3dkvxWEZ9wQibzoGCvNnrqRJ+fXT9FRMDqot2Wb1nJ78jqDP8evq4b+N3bzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zRO48JJFxhaGXsqNdeQS04VE3U2roFaqsnpN9xiHxMn9WRHhwAdX4dmaB3pvSCv07qJYvyyRcmMFiN7ZBys5R6l8EAfD98ThFX89LXSF1g/gT/7TnV6zAf1wRR9j61XqZFSecwQELtTyITRcZt5N6jd6mEPL/CoylAA+hIgYYLlaLDXeJMVgvT0ZUjzhAA74F1MjrxIlEqJvoc8D2c2Dbns8RlXDiQHsMU0vie8d4gtjpjTBC8CuiSHMWj8UdLwNto4YtIZNRky1Vl0JYseofiEzE2Z+uzfEWcffunmV/gsUPOEcfWO6WnDrtMvPFUqBFJPoEONRvFeu7F4TLyVyinRwbV+M0Z/dGmkgesQpQpeabbt5BQBPMOozn3J8wJG2URpzbNKsguGKztwunYYTrkrONUOlXNghpftiv4BtItUr/KfVzsZqjAXpV/TwJrr0faXMFFD34aRluSdJv48J62c3Tdc2irlt81+YQCn4AlI/zDhpXC7g0e4vNXi2abgcr+mG8ZFnUz4gPa0eJP9pHQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991a515a-d360-4d21-a162-08d8148d262c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:53.7866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djIB4gDzfhVqAXtuj2ZSX55xtTrryJbm2d7dqGNYHhvc29F8Y9qIrBhoQCsRxCLiteZ14HW9aUctOH/Rr6Nw2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Camille Cho <Camille.Cho@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Camille Cho <Camille.Cho@amd.com>

[Why]
dc_link_set_psr_allow_active() always returns true, even in the case
that PSR is not supported.

[How]
Hook up the return value of dc_link_set_psr_allow_active().

Signed-off-by: Camille Cho <Camille.Cho@amd.com>
Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 114ee29132fa..f020b3b67f0d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2557,12 +2557,14 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active, bool
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dmub_psr *psr = dc->res_pool->psr;
 
+	link->psr_settings.psr_allow_active = allow_active;
+
 	if (psr != NULL && link->psr_settings.psr_feature_enabled)
 		psr->funcs->psr_enable(psr, allow_active);
 	else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_settings.psr_feature_enabled)
 		dmcu->funcs->set_psr_enable(dmcu, allow_active, wait);
-
-	link->psr_settings.psr_allow_active = allow_active;
+	else
+		return false;
 
 	return true;
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
