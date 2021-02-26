Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69650C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E3364ED5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E3364ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B836E459;
	Fri, 26 Feb 2021 22:37:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FEB46E453
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/TfKJifSZ/aBdPKf7Dj8jYEz8X5DkgtN6FiH/T7zCvXb8eunoBPB1sSQhM6azpIfwxI2DSdxWiSzL/JQhjBi+N4mIlDYrEPcaXZHsUD8618eTgGclO3Icb0jYrvgq/AfaVFUKkxHACC0retU0sqfBL+FBFkfDKSyFcCSk/iH0uLx+i/MM+e5HnfX9CPHk/KzKzpk4l2S8xdrSD9aFHel97OaSeT1rI8momnIakDdILZCZX3oSlfQPmI4sLGYgcojyhqQg18LGgBW9hoyr7fCiSC927+CTK2rLzpuN7leI8WB9E+yxxI0xpUHgvmpFu7AZ0Gusk2n9SsBA/aBsHJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/iVYMgRhuNuc0lZdf2p4YwHW3FbOMsFnf+bcIsg2rA=;
 b=fQM3TvYjxv5/c4ktyhG4J/4V+x7UdhRh2UvenWTD07zMJf3L8lfIKE1dpjiAYezft95SFRjULzQQcF76p0de35eidif/q9IvajXduYn5T0i9dA6NlU2SW2eBAp9ZZ6ukHSlnS6WOdrrbbq+B4Zz/XRuYfR90T2Nce5kRWQ+08VqJh0kV3UI8E+Nnx1Dv/epNufcj8QVntwZ8vJjN/L4nM9dP/bbwVKPwaO54ZI0akpblKfyk3EQSfE+kIqe2CpYxO1tG7jthIikFNm/4ZJkYLZZfsEF7bLdwVo+ApikboDNZ7eU4inKNMxmcup3b7Ebwn6doym0oewp5Zb7hkao9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/iVYMgRhuNuc0lZdf2p4YwHW3FbOMsFnf+bcIsg2rA=;
 b=krfbr5LDLdPH/IK+Yb8S1JCATSb/aia+3K1IbbX1QC+Q8VMc2Ct6xMxOjMGKzz7rhYWA0NhGW4ZkX/jtNXwCI+FkAbkkSiL7Xsr1U7zCYA7/MJTJu8nB3J/RwGQcagMRAt+2tReKY/EezFnUxrw4yaP4IlUPSxDfMLV0P4mkY/0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 22:37:55 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:37:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/11] drm/amd/display: Fix HSplit causing increase in DSC
 Slice Count
Date: Fri, 26 Feb 2021 17:37:04 -0500
Message-Id: <20210226223704.400472-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
References: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf]
X-ClientProxiedBy: BN9PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:408:fc::12) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf)
 by BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 22:37:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d3c4544-125b-46cd-4e03-08d8daa728f0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1883F39E8DA571A77683A0D3989D9@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMLFQFZtNfZsI4rqmgfeD04FlLcE0/Vrzw4Frq3F6wNyyIXBP28T0gWi28zTQaN4mdXTtMQx99E/lvKfHiBd7cxr4R963y4FdaPLkrIZXYYtY8ErGfo0RBg0rzi+OEreDMmqcf3cRKCzzmrURfN5bVW4bIrPGfhRvf4P/z8at/MP6Q+koAPashlaDs5mP9UhH4EocngMwfnhB2wGKmpGVVzHg9te9RL9PMpqUUBHk2Bl0XNghVP3yScClXtlzcbsbJcx0Cbi8P/6kACGC8fwe+JHFfDFL+x3Bs71g1lGha+F6U6FMKpmGFNp0WIXUhRsquct2yjJybskM5YjFKMF/FNELiYMT0Bndnx4TVW7Quwec9vuV37Sb3/6hmZv2zGTMv2XJSJ/UGLooBwBiNCinX53EIYB8bqjCIW6wqzPNHk7pBWYe+pAFKQXeMlSnM0JwpGyB7yhDY/6njQiIPNewumPKkYquXCWhv0i7wdsRf1IhPo7SfdA/rXIzEC9HGVzZVt9nAL0A/kBbgoL1k4vBLwe/lKXTW5y4IGJPDq0FL9/K+EG4RQGXqokiVD88yTp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2906002)(6916009)(2616005)(5660300002)(66946007)(316002)(16526019)(186003)(1076003)(54906003)(83380400001)(36756003)(6486002)(478600001)(66556008)(52116002)(4326008)(6506007)(66476007)(6512007)(8936002)(8676002)(6666004)(86362001)(44824005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cKv3WuzSmZXUcpCYQ0rwwqFqpUY7r36jdAxtPOizXSV+Pmz+STstwO73GVjm?=
 =?us-ascii?Q?/xXj3l61GnOrAR1jzsojbhcNlik/jR6dKaESauu3ylf5YHXphha5qYR0c/vG?=
 =?us-ascii?Q?JZsUp7cpVdkop9H9Yvp1tAG9SM+gNK3VrYMbyMsnYTZ68LyozmpIMX1cQooL?=
 =?us-ascii?Q?QRyPB89T8hTjNaomUs7i0nLBo3CMkykGqcxN/LsVp/57zqy/IWALrqgwsIsW?=
 =?us-ascii?Q?XiPWW3/u+AdDcZ9Hum30pJuoLj/NovbOO0YTr/jmJI9x6SH/or1xGNiqGG5m?=
 =?us-ascii?Q?dLVLUGaB8FTpHjCXHjs+8HxCZkLHOl0puoKNv3Tq4Jb6X7kKpMxzsKxeCUYj?=
 =?us-ascii?Q?ACGsB8rnRL6jG+wE0CZEMR760kUp2kOzmxFWsdnzUJ2LxDlRZ9mzAy8B0qlA?=
 =?us-ascii?Q?uARks33qBcrPA5oibvNnQSeWsqR0B24LxHcQ5ykt873nZV16T+9k+pI/qwVc?=
 =?us-ascii?Q?AONhq+DIg+kzQRrZO+EFLaz1+5FZxLO3x84Mh9nQCzn7CJmhL5OASsnTLVZV?=
 =?us-ascii?Q?Px2M5C4etPwdTGuGSJHxCc52xRMOTyO7nBVkW/2nNPs18SdSbHy1P8NPcI4H?=
 =?us-ascii?Q?Y3Wrm9XmV0jMj1c+3Qxx3qTvto4O0hkgjx+MQJhpCg4zPeiwmIrLBDlXzLPY?=
 =?us-ascii?Q?B2XQd/EE9yfR46V5CKcUjDDK82WH3QdGTES4mLvsk1xqRLJLgUOq3BBFLZ3G?=
 =?us-ascii?Q?t9Lf1sO5eTztYV1+t85bcyO1lxlFTv+5sxNB41329W/rK4Uaq52HXwHVVJS+?=
 =?us-ascii?Q?dqj7l6SkIpP4wBESbzKvo54pB42IlQsjuKwbeDoZrSuNgJj44DKtjUVHNb60?=
 =?us-ascii?Q?DsOGPjYpecZLTau/qCBtNEygCIdGQ9AnXicYftxYwFv9BzMnkkO9++MiiIQz?=
 =?us-ascii?Q?gaY1u6ARAT/o/nFNYad2AveSNOGphWOiX1KdI67hhulC8L/ggCigpQGDfdLz?=
 =?us-ascii?Q?+M9WfkJsrTE4TkANYU2+wicjV5obVlLAorR+7zmlUF7e01MzzeNnLA7uuq3p?=
 =?us-ascii?Q?LtY/hEtp2omlbpZ7W8t/cFBrHo/2zwug+0VZJpJqNzIQuwe5Ft5fylj3U0IV?=
 =?us-ascii?Q?Mu3jXep7NgrkNQqz2kx9W/bIeCFhlCHHciKYQuOanNfhfma3rk6X1SftFuKO?=
 =?us-ascii?Q?GImiXgk2OylDue/jLz3XIEwFSteQIGEkkvP7WjVlAX2nOGxkMV7LKCZHNCbt?=
 =?us-ascii?Q?OIt+k8SYBBjaFfpRH+843qcvY1hovYZg/ec75VZNsnf5i3xV6qZBQAXUqDhX?=
 =?us-ascii?Q?GkhgerP2Tpg9JTTOr0e6hc/tqrbxzInTAuhJs/E1JycT+eS+aqyEbi43H/Pj?=
 =?us-ascii?Q?8F7jfLWYXr2ogLQrniC8hTP5NykvhPFJ+iyE4lT7WqdBA8RFBLNegJp1HH22?=
 =?us-ascii?Q?ODL/5QMJdKPJtanpn3WXa3Pjv5wZTIaGZZRpoduKaWUuoJK//g=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3c4544-125b-46cd-4e03-08d8daa728f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:37:55.6384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odmGSKhbR3hUU310WMSFak6/oNnoQ1oj05vYaNhxuiFkLjvmPZlpAZm85w79issLjUkI/DymDPxwYreclHujVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: Dillon Varone <dillon.varone@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[Why?]
HSplit should not affect DSC slice count. Can cause improper timings to
be applied for certain modes.

[How?]
No longer change DSC Slice count based on HSplit.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c          | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index bc07082c1357..cb3f70a71b51 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -4050,7 +4050,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					v->RequiredDPPCLK[i][j][NumberOfNonSplitPlaneOfMaximumBandwidth] = v->MinDPPCLKUsingSingleDPP[NumberOfNonSplitPlaneOfMaximumBandwidth]
 							* (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100) / 2;
 					v->TotalNumberOfActiveDPP[i][j] = v->TotalNumberOfActiveDPP[i][j] + 1;
-					v->TotalNumberOfSingleDPPPlanes[i][j] = v->TotalNumberOfSingleDPPPlanes[i][j] + 1;
+					v->TotalNumberOfSingleDPPPlanes[i][j] = v->TotalNumberOfSingleDPPPlanes[i][j] - 1;
 				}
 			}
 			if (v->TotalNumberOfActiveDPP[i][j] > v->MaxNumDPP) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index bc0485a59018..94036a9612cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -599,7 +599,6 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 			for (k = j + 1; k < mode_lib->vba.cache_num_pipes; ++k) {
 				display_pipe_source_params_st *src_k = &pipes[k].pipe.src;
 				display_pipe_dest_params_st *dst_k = &pipes[k].pipe.dest;
-				display_output_params_st *dout_k = &pipes[j].dout;
 
 				if (src_k->is_hsplit && !visited[k]
 						&& src->hsplit_grp == src_k->hsplit_grp) {
@@ -620,8 +619,6 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 						mode_lib->vba.ViewportHeightChroma[mode_lib->vba.NumberOfActivePlanes] +=
 								src_k->viewport_height_c;
 					}
-					mode_lib->vba.NumberOfDSCSlices[mode_lib->vba.NumberOfActivePlanes] +=
-							dout_k->dsc_slices;
 
 					visited[k] = true;
 				}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
