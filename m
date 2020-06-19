Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326A7C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09301208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AiqEy/ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09301208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE6E894A7;
	Fri, 19 Jun 2020 20:13:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDC56E98A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAtDDa5veIrkdG/eOxyOCAGqOpGJslxYTUV+X/xmO/OL7w0NjZxqrcPbdftcyHEul/s58+/JhXkBzJnKbUXireQsinoCjPzF9UE0wVOAW24SWzm81xRKr/J9nxq+4xj8gSbD5Ool05nL45Ln2medzcVY/eUjrbzCDylqJsn6WJ4lfh9MDiJWlWt4Y7WhZtwhJ800wxX1nzZKYKSiQMyVl101oCurAGuojKMt2vkRpN+HXnFDOhhqUZ6AzfuMU/mpkGPXeP4JcjcAHAATujU1OWACmV+ic4V7jbPpkVG6mlVAC0gUHgt6RTxRhETBsqfwK6bHVBgYoe9y4G6qvh2QBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg31xKZ1yJaIFtE8HDz8S9YE7qL+d1JmBp9B5lDtuQo=;
 b=Lstvg9H+Zihm15vT8F9jG/qSynQpIW7tanp2/C3f/UeWIniYK0iR4ml155nY3JRwRI8vjOap8HFCI0ytppook6MndQV+1bocV5YM17cOpDwWmwf6dJ9CpYGs3jOm7f0cBubEynxyLQD4qM0giLbL2BNI0dH/lzzMUkoAWcBZUlR4Fh6WNMSyB5Zi80xnl3+HIKm5q/j+ylxwpEArKjmNyrY10mXFjtSFJFfgSeAooI033fORUqDsMBIVgv1GjzU1z6nwezaPEu1lpzKEQrzvZIWz9MBiV7eF38LTZbB/JKMlZcZsg8dw3tw+RlDJPtCrYzZ9RjBsa844ySdUV7e8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg31xKZ1yJaIFtE8HDz8S9YE7qL+d1JmBp9B5lDtuQo=;
 b=AiqEy/neJzuItBNOTq05nAOwoWr9xFdDFrTsFiUgEuhn1KDNep9kDasSgW2ICDosqUCXBOIOpFh/OQidNIy6WllhFkPgnIdwwqCkJ80NYyuvgaIJZe3bwITKGpjGukjqNOjADP2tsO+2spk3qSNZRCB/0d7754is1R76QVywXDA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:59 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:59 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/30] drm/amd/display: fix 4to1 odm MPC_OUT_FLOW_CONTROL_COUNT
Date: Fri, 19 Jun 2020 16:12:09 -0400
Message-Id: <20200619201222.2916504-18-Rodrigo.Siqueira@amd.com>
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
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:58 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c483788b-7a7d-4263-e8c0-08d8148d295b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40875735C58679DE6434A95698980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FI/Y+q2KOG6KvdQjEnUmGFzgzIjdMSDfIqgF9G8khqqtvfScv12X6q7v0sSAsgXduyE4tpyh/kV1M4XZUSXvKlgN/H62I7i0r6m7aPDZCxmnt6uuUIrO+vom+rX6Mk16BmOLGiSQi5afNf0rzM7JysYptX6n1YTZHEjRjeQEyL00cQ44zkMWthiuWoWOQFzmeoQm5kpjLCvi96YBXsSrgDfRkNQbo3Qv4VqjMQZwLeixs7M+JEAh6MY8Uuyk8mu0AM6MnFVs3EOUcGaEAyk+g5VAVY1zCD6A0S97y8S73eR9wRsl4h5QoqPkbxEfjB2dRHCUokR4gajBT0mIWLLCOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(4744005)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YyAWHt3yjlfCgQfb8IWxKKOOcnSbBMa1XVtZhio1LSjDMrYOjYTnH6T7EXmYikzVLFsiMESko8viNQtlTJIAqeCOLRAXmhf3JAYI+QcBSzW3cJxCQaaz58PZPEpnTdknWgos/g5ulOEWlxa+sHIZX3Ml/bGpTMtt9hBEnavpS9smma5DNmH8gN2XH1Jr7iZkKBEXrbZlIwTqIQrcrjSTVpeq+KWRjZxa6Pi1hIYqJiTLqXO5QheMzvOqxtN7M4+VQ+9oFxcVBAouC8WBPBTVYEvzz0PVAB2NMLbJNmuGW77kr03lSlu/86Cz+EwxMoCz3KWQkSEmYlgCJam1etjq5fqAt/JpGK9xeDBCbt/dCmndPszkd7tPb6YoDG+boPiEonvwDip/UrcS3brkNkJMATSW1F8Mfrfm9zLpA4enczMtwG3MCw5ZWQJTg3tl7fFY6f6Y3SPsyXlgZ6NgdL67v4ecuJYIhgrt9XEX35dVtfKPxwVJi+2PhYYbKgXkUm/RHAU9wolzen/OKgC5So6CJg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c483788b-7a7d-4263-e8c0-08d8148d295b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:59.2232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WIlwSEWCA747UxuVBGYjT6q3UCg738Sp+3eDkE5UdoA1A2fPALTOB60mnzzPF679aV9a+13JELqB2zNT9VHYg==
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 789e33fae016..5621c95177d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -618,7 +618,7 @@ static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
 	bool hblank_halved = optc2_is_two_pixels_per_containter(&stream->timing);
 	int flow_ctrl_cnt;
 
-	if (opp_cnt == 2)
+	if (opp_cnt >= 2)
 		hblank_halved = true;
 
 	flow_ctrl_cnt = stream->timing.h_total - stream->timing.h_addressable -
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
