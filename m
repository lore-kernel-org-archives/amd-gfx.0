Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FC2C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F5821D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4D8nUXDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F5821D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077B36EC67;
	Tue, 27 Oct 2020 20:53:21 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700043.outbound.protection.outlook.com [40.107.70.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CDC76EC61
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJdDo8l3iUlpldZli5BCNHzieg9lvYXJuEDJscMKtbHudqlpf5TQunvd6dKM7QoOmMFPsrfcSiyriANc/PGmBMGAthBoPJKu4XVsaXv+YDKndnlANP8FUFKFMtEsEJMgPRoTMjU7BBDLswbOCiadrt12FVdbO2FrrVFMWgJnxaeVB5Tz/22Q4shC24FnaWOYzKLcuNjAmdPZGanws5cWJaKTD5W5G8jnmHtNiryIkeFLCyf1FPjHIE0Qv28+9EuTdu0nOT5aLtzTghYRkOERi9VufCxxoFX/sUyLsOVxgt9kBtVwrxgI3tPBxPthCWjFD6FrKFQXStfkXAKluZePzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfI0K5o20hr7W4QKjnOWLWOq3kBTIZVyVb1yEH0y8jU=;
 b=lIr1uviXlA60IVNG7/fD07azykb9sr2hkjM7zCp1iJ4CEX6VZnqP9+1dQBmAfwlNT3VXKE8N+9i8bO7uvmc2B60kWx2ZPboanPPkrUjr7Adj+LcuOHQLSY6cUHiGpnzUWwU+CsdMC1tbVaXJWjsMEk0Kb65J/lLldcYVJi148Vf8f988C+iGZCTbboXrYUQSiktbIdD0h6G340RttkhUJ8GthOrkjiXbXY0T0tIPULUJPxPltj6GMDjvWzfEu9/3PkpP9zYkSIai/1YQdJqu9AQd9jIXrEdZBYqJMgWIOkf2OY82pPlzFpCpy480tEFaZ7dAoEwAB1bpwyON4Q37Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfI0K5o20hr7W4QKjnOWLWOq3kBTIZVyVb1yEH0y8jU=;
 b=4D8nUXDwICp1CruXLm+ehy4DZkJHkNnJalLwzh2qy9jFqByibkDlskgceU2g0WtxOODeEV8uGNNROKPBV6we974nVXeiwVe7FSEVyfdBTw4WJ8+HHNJFtRj4Il8Ife35N4DW2hLjnjkPMWK124Coko01DNmE5daYCugoeu63nnQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:10 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:10 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/25] drm/amd/display: fix recout calculation for left side
 clip
Date: Tue, 27 Oct 2020 16:52:34 -0400
Message-Id: <20201027205234.8239-26-qingqing.zhuo@amd.com>
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
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:53:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75525d9c-9628-4f15-70cf-08d87aba4c0a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595A27A7A134E2DEA077733FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8vRfj7Qic57sL8ufXFYeSLyhqSlCQN5HC0pW2UP6107sCeSvwEm8o7oh0yLg6UXqiUgsRCOJDkdVkfiizP8dBfHhldBYUQEIXbLP1irK1zzbzrYT7QYL0leVy4CgZQn77y9jcz703n7HXanTmIMzemHcoRB9bi/Llgufchtm1FB9jNyFb5WNwIpD98XjuqAPlY+El9J5W6+JUQ1JUzZI8z+G8AzUZbjteG+y1aTSMLU0Xc/+nN3O5WfWECinBLFnUsuHbXOz9+yfcIcZMf6/DsvXwJRxf5Q5jDJLORmSKTzvHERswmDJNTffMfYURbdPrW4M9rJw3rnQqYFUJtU+9NniON1EFRE4fNp3cOCZk44dXBsH5lqW1V2FbASM91r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DhqNPWVPrNrkzd/AKr7i5KJLCKhA9fgWfUP891ef768FpqOeyb11QPvPnz6X8OaPILkeHmKRZ9QGy3+X+2qFgVwBzVgnPH/eUugK/wEhUnnyVT1sP0GjnUII9sCvtoineaDkDAQh/TuDx9K0enJkxUjwzPXAOwhxwhx5637GTyUDCK8xePBXSKaqDpS3ZCVqR+n6D0CFSYxhEAWjwfm+/xTEHctDPbfsRzPuzb+PTxNYZlVqDWg+i/v4z8QZWR4r8q/OhYY9eUKVrYj1eJ8cg7KXUHEUucuPeWWerhqglc4Sz5VM2oW3lWL9L/gaCcAKPTEyhq0OkxVTKrjrIukOR2CAB+jClCBx6efSWrUVhBiPeY72A9V01vYvJ+Loc89EjlfZVxxiaFzy4SJPl+dIfEILsn6o4enoHcOp+Ffi/gQM7qTisrBVBbtPRpphmbqpVdIVy6PY1TuSCiQA0GrsuYzBHGuqWG0bdXEdq1Zu0XkdgxvRc9q7vlyHsliPKaTsZIFKQ7O2vOba0FvHF7ja0k4RL3QIzu82njr5afagyD6UfCTAYo7rrT6Sp5PzCAVc1V78ockVsz4qSGAkLd5l09ttVXX0FfcAUopZOv8fwh5xDXiuoEmXBr0Ho1RWgW7CqQUfGHwwTjlrkgSfeRgUSg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75525d9c-9628-4f15-70cf-08d87aba4c0a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:53:03.2852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPvM2Od0rZxVqNfeARFCJygy+mTwVWO+xzZhQ67hzGe9Wfn0zsHP/viSse/GVIqS
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
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Recout calculation does not corrrectly handle plane
clip rect that extends beyond the left most border
of stream source rect. This change adds handling by
truncating the invisible clip rect.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d49a8b3e5137..998d87b852a7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -825,6 +825,8 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	} else
 		data->recout.x = 0;
 
+	if (stream->src.x > surf_clip.x)
+		surf_clip.width -= stream->src.x - surf_clip.x;
 	data->recout.width = surf_clip.width * stream->dst.width / stream->src.width;
 	if (data->recout.width + data->recout.x > stream->dst.x + stream->dst.width)
 		data->recout.width = stream->dst.x + stream->dst.width - data->recout.x;
@@ -833,6 +835,8 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	if (stream->src.y < surf_clip.y)
 		data->recout.y += (surf_clip.y - stream->src.y) * stream->dst.height
 						/ stream->src.height;
+	else if (stream->src.y > surf_clip.y)
+		surf_clip.height -= stream->src.y - surf_clip.y;
 
 	data->recout.height = surf_clip.height * stream->dst.height / stream->src.height;
 	if (data->recout.height + data->recout.y > stream->dst.y + stream->dst.height)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
