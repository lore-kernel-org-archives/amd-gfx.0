Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8908DC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 10:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCB42083E
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 10:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cnr8r+U6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCB42083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD6F89EEB;
	Mon, 31 Aug 2020 10:41:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674E389EEB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 10:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvPC5X+ivs0VWxi5urSNukkGEGtBjfbQjNrLhFnaVJBov0+lqYS7nkpRlRCAaglZyRzca5tjn7NPWN7wAWnWzlO+2dg0bsFTvFtKIYsfwukLHae6CIB11NL9XWaBPFbXfSK3DMEcZBdEdJL1hO8UHd2fzBgr+cwgVtZfz6x8xGVyVSHgh4TIcxjezObFlN3Gl3Xlr2ve67xczIPYgk29W9Eyn7NbZ0Wji2qnM81zK3qoP1lu+TOg8e13kuF76OHIQQ7Gy8dZh6jX+ecdH8/UmY3zHQi0akiDKvemQaHSTHwD3+PKLYCPoNb1e4zllUGz2FWsiRcpWVwQenDFZRH6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sxOQ89FCzSlWxYXVgCwcBtnLfxno8/VvZ86LWoOePY=;
 b=lDFaqB9e9vMYCgxmNEg60ao3W+f0PBr2eZr0RZpCVth2poLYybtRtsveUomw84jgJ+YwTPvgKITIxJ6P5HsgIIZ1gsrO0FGzvhW4ZqvMFbyL7mx1CAdNpe37o65zJbzmdrTo515rTPkpsTpV/kvRGD615vC7kpj0fjQ8cfTB5/vaKj5SqNDitg3TtlNfBukAOXzhIIsHj+XuzXiT3MHVHdZoFZwcP6GTTogQi+3ea9O8R6s6Gi/8g6zez/aL6BO5l7XpFVL5MHxwwmeDzKC/5mSZrwz05THmMBksPQLaDsbCc+QqfNw8lpLav5+84DFSQHWEIfjINfFAgbIvdSje/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sxOQ89FCzSlWxYXVgCwcBtnLfxno8/VvZ86LWoOePY=;
 b=cnr8r+U6mMCP/WCpwEYeaatxD3n/ehOcIGcXnakiBrEr5F/0SmwLtoOQNsS06gDCgALx3MqzoymlmkpTljdTnMp1vSHecgpjbxsTM7OOovEGEapEpNIxExF2sAohlDpls1NtGG37HM8Yovy9ndoS+T6a/GE13UORlOCCnxwGhoc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 10:41:55 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 10:41:55 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd
Date: Mon, 31 Aug 2020 12:45:53 +0200
Message-Id: <20200831104553.10207-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Mon, 31 Aug 2020 10:41:53 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [217.86.113.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93c66e03-35a9-4758-f0a6-08d84d9a7a60
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4579476690BFB32DF152D4AC8B510@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pa06jlQx2NnHioY4c42MztCDAVcq8m3FCcN2WLXRm37z86RJyTSdF4VGman7LyDjBeOi0mOBXUfJVtZWPIZT6sRbiOQm32ZNgrdrmYH8Y4YdLH2JqRWAO0tvCQ+lL9ZmCWYqyT4lnWqJa3Djk7XbnZ60OcjJy0fa0LPZ9nUf8MBPRUk81twf9T4C1E2/SxRb7qZHweHINMsBK4qaYOiqP43fZsiDPvwlKgkJYiYr7V+QVeLq9aR3cl6Br+WhX3LuMIdUQelbmYv9JZC0WzIF5qFAeonXrApL2fM101jQTe5j5OMktiuDgggbeZPEBAXaOYQ6lhP99FLrii4y+yyIOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(6486002)(2906002)(8676002)(186003)(478600001)(8936002)(26005)(83380400001)(36756003)(52116002)(6916009)(316002)(4326008)(5660300002)(2616005)(956004)(66946007)(1076003)(66556008)(44832011)(16576012)(86362001)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: P7iFsfB00EFjMGEBJW1LNp/FVMIgVT+MjuFtS32KAKeijYnRCICcJLBuJAMlmt3n1UfL4UCCdz2Pu7uXAcJhepeCH+e29vHd+6V60bHXLDI0VVvAZO9OwPmttt9DtWphqjNW4DP1Txg55LxtHHTEXEyZA2d79Z4qyhwD/LOQMKNrM8zaG7prx3P4tImv40Qk31xb6HKmxbsE/eHMnDXdbIr2pj0XssLsgfMwcDNZfjuFl39wso0fyQ2PXlOE0zKfILOIrYcoVBNftB38kblYa+uKy006JE9HI8OGt3ORo/ThVcwOgipJhLGx5bE6GSyOxvPZAS9Jgi5eNLQ02SLD0DRunGBKTji/uypGzVcKBsgMwQVVcYRIX1s8zYo4FuZNxwVrHJabwVUyEb1KBW9hdE/yl4OSpkUMQKOdyMThWwAJC//9MBa7qZEivUy/jY5EBs9+pkNpiZ854diqU9FrBEEtE7aQ+BuW4nl3VDOr/ctzRJ7bF0i5RpIbVH3lnIc3ee1hROQDCf/ncVqq7URbHlBQ+9u1Pk8dRPpbuKMTvwL2vAe3iGG5rJ2OcV7fzCvL1nlKj5PichUrEqr8AcfzkOVXp5PBONuDuTX19vY/iJvSealrjqUmU2w6X62nkeezgAhijwEsT8eRPLVnl0rLzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c66e03-35a9-4758-f0a6-08d84d9a7a60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 10:41:55.0178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbNwdIWls5yrN2U+R3invNVw+4wC9XeBjgKEeEcmAbi0b8CZGQnRtpss7ETKmSPvbB/FLg9Nm5ulUY/8VsyHEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Tianci.Yin@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UVD dependent jobs should run on the same udv instance.
This patch disables gpu scheduler's load balancer for
a context which binds jobs from same the context to a udv
instance.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 59032c26fc82..7cd398d25498 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -114,7 +114,9 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
 	num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;

-	if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
+	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
+	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
+	    hw_ip == AMDGPU_HW_IP_UVD) {
 		sched = drm_sched_pick_best(scheds, num_scheds);
 		scheds = &sched;
 		num_scheds = 1;
--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
