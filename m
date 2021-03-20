Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D463C433C1
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37556196F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37556196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A12F6EB26;
	Sat, 20 Mar 2021 04:19:28 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750084.outbound.protection.outlook.com [40.107.75.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48CD6EB26
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPUmxm2bLvbpLuI2fiK1+4clK3+T8hZZpyHZzu0VLLYZ0rDwI7/vI+1pLb5TLAF4Bom+s2PCx4IF7bNuSbnvxbebD65oxEv9uR2Y3+GDJGFi6GTFnS5WUKktexrQSknrSM9PSGVgZwWBNnpgGoUjC+Z1jFEmId2gFyI3cqnqetM9bsb5JlxhdpRcQC2hRBa76mkBHC2/ZHADmp+o4KENnO6OHDebAnwAmVtybRY0WK+Hbx7tbTBGOASFXEUx5X1fni/oCcjC5rCvHccTCzw4CbLLIkNC95+rF45A9V4AgXsYV4hiOuQocTfL7aum8TKAb0cVDV7ycM7ZPBn3CisLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibT/mnfc6MbZvPKYrp+FqBM5okoljjRVLOljEujP73s=;
 b=A+MIf5bfjGvJ4c1OjSHij3/VqWA6HDS90POzKXXJ+Zw1Qofq/AgsG90LEELUpwTc3vBgMOPHcIQ4PxTpTOcfnzuCfR1LXV6isUBganD6+X9sWNqgMsEgDieOwyQ0r7goAaj6zl5zMWnMFUA6voEVlskL0JkuqGP45/gzx/gPM79uh5g228b77O9sIxKMfZfOFZWrroL4E4ZA9jbTqxlTxzCVOhNjH9pSRNi1KLVOUyftgM7weXHJEpb2/HkIX4Lll0uAfhIZ+bJBktaZD2ZdZyu6HouovTXQCf8vVVYK2mm9lsM+L2mX5zvTDcve5WBd+9Sl/R4UiqqE8PHLeycz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibT/mnfc6MbZvPKYrp+FqBM5okoljjRVLOljEujP73s=;
 b=IUBW4vx7X5rM4wo++wSg9IaH3JfAOd0RGySn9stsnCS/ep+DTyr/WlXncMJy5/4o3lIKnBThV42H99h1HH5zQ23bJXp7dRPMEtCjZJU3pTCf5Vlw0tEiaI+lCKaBHnsUdefYZJgxq+yi5WfFPy/84hhfl2R3sqllrdnClQDr+1A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:19:24 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:19:24 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/14] drm/amd/display: Fix UBSAN: shift-out-of-bounds warning
Date: Sat, 20 Mar 2021 09:46:52 +0800
Message-Id: <20210320014656.23350-11-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:19:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2d581ec-22d1-4c94-a407-08d8eb5757bd
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB47041047096D92966364494897679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xf1SHv2+xSykuXRQma00es9qlCU8NVPRGULD5Dj8caly25gGFxoV49Pm2juwBjSzy+Xg4Oxxa6hAUaa8zo1EAowRsX3rUePDWOk+ALtjKTr+VixwIed3Ne6o6DYbwbip1UjHgNvISuIhZnwL/rxpbbIzqokXW6WfQS9sq6FPHgoxGD7nIFMtJynOniUjWZJc0hpm11M1U+3VU/QKiS4dyXfc3x+4mfiV2+YRYqWax59YLuSm4rQ0lVIBIC3tO8mJI3Ryos09hK4zk5yU0gS+VIYIcYqmwnSyZqAC4iobLH0460vkoBtj1vFmD2mtjANyvPWUIuGrbBXuXFq0YYdONcVJi5FXfR0SaiWb4rPGtwdDLJDbNlUIOKCPvKdf49F4A06U+shuG3bU1VamrnuWEwGFCG37p5VQ37zRq7Zy+v9CnMEOi7SziiR8NW/VjbGWhu2wnCgczJxT8aCIXhrQW76HLfvFGaTvsew20orX3MDUMHGiEAaQwlEwzpjAzo+FV0FKtJjICA6N9asEri/u0MtJYqN8VZNjx33Mtp7lfq6hbAuEBp2NrebTZakgyKjQD6XITlIiV6LSuzxcpv5w9U7rfTheLGtA8/Ss5Pq8RDvjXdT7V/YHbIb0Jxy+mvXwTOLrI8aIdJtnQy2xWRc4cuCD/j0nHKtzkCqCA5Fz1h0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c5qBJOY7R5+NGJY2sVSpKKbYnUXoZVyIHBLc49CEoIWvQ8eO7rIYyoaHG68S?=
 =?us-ascii?Q?dZ8WoMjK7nhdcnyLyEMIkJSQMX9It9xgiVZuKk3yXLu6S0/14XZ/bRbzBv6F?=
 =?us-ascii?Q?7sSBBlGd6C6cPYxgcrbm8LyjCM5Sh+wfClbVOI/bn6LsLflwIxdrb2zVZMb4?=
 =?us-ascii?Q?8AemZ2FHC+tOAbVc8Bn68uqaM+hB1020W/j1FqMKuyyE/0RAw8OIYnd69YLT?=
 =?us-ascii?Q?P6hJqZoe7QxKC0oUlkjcQXO9Mwgx4/htyaEAvaQuCkJyWGYTOnD300jtn0GW?=
 =?us-ascii?Q?FfL8u+ENTKjYieyQJ4lDuB7MbA2sIrECOREpiOKw7UN0ovveQcEwYySrjhxr?=
 =?us-ascii?Q?3fqaYt7yEKSVEZPtNuvIvLV2URnMZLK+Y2nzEzHVjzfVghU5mJnTu1YepHrU?=
 =?us-ascii?Q?Kl2BNPDtEEaxRtjWl+yFykNMHJ1oRUOBvknpMBcF1i9L1tQ8J6qha/tO8a9D?=
 =?us-ascii?Q?rN7TKv4bGvL+Rt6kQBFiExFsWIHBVV1105a9ydSn2yWc/MeXP3dqso0tV4SQ?=
 =?us-ascii?Q?CqYMIzhTUpVysszWWCLn/0Iq5MVmVNimMHrIXSYDoZYbG4fyb3EJ/tXQDay1?=
 =?us-ascii?Q?Ga9qcBxTdSrLeq3Mlutie/1sbQ81OUb2jpAOpWVOtPx0ceDREoiEdbOmeTcJ?=
 =?us-ascii?Q?SZG5pSdgNHpD59BGOL+aXCbjPYeyf9wFMMcWvfOGJpJbJeioGKvmTasqa709?=
 =?us-ascii?Q?qvmJIh5kpD5zgXPIuHPON6rJapdR7eIMrlOXRqxRYfoctiEV/A4oN7R2wOAM?=
 =?us-ascii?Q?cNfZw5KfSAhc3zwj5TsO7On0EBpsVnCT300UgDSrzSIxw8ID0HClPMJdM/5t?=
 =?us-ascii?Q?Ip8tFEUy+UoeDcPWsJOZzIwpTVAnxbFkRPD9/QLFYY7e6KkFYQrLn3XRgeMI?=
 =?us-ascii?Q?49hkUmT+u1srjxKmTQzoCRPyxBvH3yk92AkjaQVLgLUuZR1rvLKYndjEwSwN?=
 =?us-ascii?Q?H/eMgH0+BBuojwwX/1b5hY2zTx2HmkClGs3OHZqFVMh85gSUJlqBLi3FedI3?=
 =?us-ascii?Q?cbpZxyD9Tyx90Ad05RnzPj11qFoA3kAo6jttWZgFjTLbOb8VzuKPDxZHbVoy?=
 =?us-ascii?Q?1FUDwvRd9ni/hzHnsJgWIIULZrAldtGLf3+7q8VPko9YXTZCoOTgzHfUS8co?=
 =?us-ascii?Q?y9TfcwloK67CIV8qlWYxZuBuDWU5zahWD1dHz5v6kYRDf8wByd+wCW0GEv5B?=
 =?us-ascii?Q?Vw/JI9xnDoOmy7UDunLC9jx3mieWHmVU9LLAmQg5UF4ZAV9cx89orv78muKy?=
 =?us-ascii?Q?LEsiybZhR8ojMBOlHci07o6wYOPkQbFlsJJsICrxLL5ymGBF9513Jqrpz5/L?=
 =?us-ascii?Q?M2+WqdahV/AcJ5lV2DiUN1EK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d581ec-22d1-4c94-a407-08d8eb5757bd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:19:24.7468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ch/nK5eY7LtSjgYmbyFqgi23J5yAKJ2wRSMD9aHufH5gbs0y5TUPJxFX1XoKMgGr56Xj4LrAWABQhPHvZRtTsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anson Jacob <Anson.Jacob@amd.com>

[Why]
On NAVI14 CONFIG_UBSAN reported shift-out-of-bounds at
display_rq_dlg_calc_20v2.c:304:38

rq_param->misc.rq_c.blk256_height is 0 when chroma(*_c) is invalid.
dml_log2 returns -1023 for log2(0), although log2(0) is undefined.

Which ended up as:
rq_param->dlg.rq_c.swath_height = 1 << -1023

[How]
Fix applied on all dml versions.
1. Ensure dml_log2 is only called if the argument is greater than 0.
2. Subtract req128_l/req128_c from log2_swath_height_l/log2_swath_height_c
   only when it is greater than 0.

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     | 28 +++++++++++++++----
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   | 28 +++++++++++++++----
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     | 28 +++++++++++++++----
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     | 28 +++++++++++++++----
 .../display/dc/dml/dml1_display_rq_dlg_calc.c | 28 +++++++++++++++----
 5 files changed, 115 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 72423dc425dc..799bae229e67 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -293,13 +293,31 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
 	if (surf_linear) {
 		log2_swath_height_l = 0;
 		log2_swath_height_c = 0;
-	} else if (!surf_vert) {
-		log2_swath_height_l = dml_log2(rq_param->misc.rq_l.blk256_height) - req128_l;
-		log2_swath_height_c = dml_log2(rq_param->misc.rq_c.blk256_height) - req128_c;
 	} else {
-		log2_swath_height_l = dml_log2(rq_param->misc.rq_l.blk256_width) - req128_l;
-		log2_swath_height_c = dml_log2(rq_param->misc.rq_c.blk256_width) - req128_c;
+		unsigned int swath_height_l;
+		unsigned int swath_height_c;
+
+		if (!surf_vert) {
+			swath_height_l = rq_param->misc.rq_l.blk256_height;
+			swath_height_c = rq_param->misc.rq_c.blk256_height;
+		} else {
+			swath_height_l = rq_param->misc.rq_l.blk256_width;
+			swath_height_c = rq_param->misc.rq_c.blk256_width;
+		}
+
+		if (swath_height_l > 0)
+			log2_swath_height_l = dml_log2(swath_height_l);
+
+		if (req128_l && log2_swath_height_l > 0)
+			log2_swath_height_l -= 1;
+
+		if (swath_height_c > 0)
+			log2_swath_height_c = dml_log2(swath_height_c);
+
+		if (req128_c && log2_swath_height_c > 0)
+			log2_swath_height_c -= 1;
 	}
+
 	rq_param->dlg.rq_l.swath_height = 1 << log2_swath_height_l;
 	rq_param->dlg.rq_c.swath_height = 1 << log2_swath_height_c;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 9c78446c3a9d..6a6d5970d1d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -293,13 +293,31 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
 	if (surf_linear) {
 		log2_swath_height_l = 0;
 		log2_swath_height_c = 0;
-	} else if (!surf_vert) {
-		log2_swath_height_l = dml_log2(rq_param->misc.rq_l.blk256_height) - req128_l;
-		log2_swath_height_c = dml_log2(rq_param->misc.rq_c.blk256_height) - req128_c;
 	} else {
-		log2_swath_height_l = dml_log2(rq_param->misc.rq_l.blk256_width) - req128_l;
-		log2_swath_height_c = dml_log2(rq_param->misc.rq_c.blk256_width) - req128_c;
+		unsigned int swath_height_l;
+		unsigned int swath_height_c;
+
+		if (!surf_vert) {
+			swath_height_l = rq_param->misc.rq_l.blk256_height;
+			swath_height_c = rq_param->misc.rq_c.blk256_height;
+		} else {
+			swath_height_l = rq_param->misc.rq_l.blk256_width;
+			swath_height_c = rq_param->misc.rq_c.blk256_width;
+		}
+
+		if (swath_height_l > 0)
+			log2_swath_height_l = dml_log2(swath_height_l);
+
+		if (req128_l && log2_swath_height_l > 0)
+			log2_swath_height_l -= 1;
+
+		if (swath_height_c > 0)
+			log2_swath_height_c = dml_log2(swath_height_c);
+
+		if (req128_c && log2_swath_height_c > 0)
+			log2_swath_height_c -= 1;
 	}
+
 	rq_param->dlg.rq_l.swath_height = 1 << log2_swath_height_l;
 	rq_param->dlg.rq_c.swath_height = 1 << log2_swath_height_c;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index edd41d358291..dc1c81a6e377 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -277,13 +277,31 @@ static void handle_det_buf_split(
 	if (surf_linear) {
 		log2_swath_height_l = 0;
 		log2_swath_height_c = 0;
-	} else if (!surf_vert) {
-		log2_swath_height_l = dml_log2(rq_param->misc.rq_l.blk256_height) - req128_l;
-		log2_swath_height_c = dml_log2(rq_param->misc.rq_c.blk256_height) - req128_c;
 	} else {
-		log2_swath_height_l = dml_log2(rq_param->misc.rq_l.blk256_width) - req128_l;
-		log2_swath_height_c = dml_log2(rq_param->misc.rq_c.blk256_width) - req128_c;
+		unsigned int swath_height_l;
+		unsigned int swath_height_c;
+
+		if (!surf_vert) {
+			swath_height_l = rq_param->misc.rq_l.blk256_height;
+			swath_height_c = rq_param->misc.rq_c.blk256_height;
+		} else {
+			swath_height_l = rq_param->misc.rq_l.blk256_width;
+			swath_height_c = rq_param->misc.rq_c.blk256_width;
+		}
+
+		if (swath_height_l > 0)
+			log2_swath_height_l = dml_log2(swath_height_l);
+
+		if (req128_l && log2_swath_height_l > 0)
+			log2_swath_height_l -= 1;
+
+		if (swath_height_c > 0)
+			log2_swath_height_c = dml_log2(swath_height_c);
+
+		if (req128_c && log2_swath_height_c > 0)
+			log2_swath_height_c -= 1;
 	}
+
 	rq_param->dlg.rq_l.swath_height = 1 << log2_swath_height_l;
 	rq_param->dlg.rq_c.swath_height = 1 << log2_swath_height_c;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index 0f14f205ebe5..04601a767a8f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -237,13 +237,31 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
 	if (surf_linear) {
 		log2_swath_height_l = 0;
 		log2_swath_height_c = 0;
-	} else if (!surf_vert) {
-		log2_swath_height_l = dml_log2(rq_param->misc.rq_l.blk256_height) - req128_l;
-		log2_swath_height_c = dml_log2(rq_param->misc.rq_c.blk256_height) - req128_c;
 	} else {
-		log2_swath_height_l = dml_log2(rq_param->misc.rq_l.blk256_width) - req128_l;
-		log2_swath_height_c = dml_log2(rq_param->misc.rq_c.blk256_width) - req128_c;
+		unsigned int swath_height_l;
+		unsigned int swath_height_c;
+
+		if (!surf_vert) {
+			swath_height_l = rq_param->misc.rq_l.blk256_height;
+			swath_height_c = rq_param->misc.rq_c.blk256_height;
+		} else {
+			swath_height_l = rq_param->misc.rq_l.blk256_width;
+			swath_height_c = rq_param->misc.rq_c.blk256_width;
+		}
+
+		if (swath_height_l > 0)
+			log2_swath_height_l = dml_log2(swath_height_l);
+
+		if (req128_l && log2_swath_height_l > 0)
+			log2_swath_height_l -= 1;
+
+		if (swath_height_c > 0)
+			log2_swath_height_c = dml_log2(swath_height_c);
+
+		if (req128_c && log2_swath_height_c > 0)
+			log2_swath_height_c -= 1;
 	}
+
 	rq_param->dlg.rq_l.swath_height = 1 << log2_swath_height_l;
 	rq_param->dlg.rq_c.swath_height = 1 << log2_swath_height_c;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index 4c3e9cc30167..414da64f5734 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -344,13 +344,31 @@ static void handle_det_buf_split(
 	if (surf_linear) {
 		log2_swath_height_l = 0;
 		log2_swath_height_c = 0;
-	} else if (!surf_vert) {
-		log2_swath_height_l = dml_log2(rq_param->misc.rq_l.blk256_height) - req128_l;
-		log2_swath_height_c = dml_log2(rq_param->misc.rq_c.blk256_height) - req128_c;
 	} else {
-		log2_swath_height_l = dml_log2(rq_param->misc.rq_l.blk256_width) - req128_l;
-		log2_swath_height_c = dml_log2(rq_param->misc.rq_c.blk256_width) - req128_c;
+		unsigned int swath_height_l;
+		unsigned int swath_height_c;
+
+		if (!surf_vert) {
+			swath_height_l = rq_param->misc.rq_l.blk256_height;
+			swath_height_c = rq_param->misc.rq_c.blk256_height;
+		} else {
+			swath_height_l = rq_param->misc.rq_l.blk256_width;
+			swath_height_c = rq_param->misc.rq_c.blk256_width;
+		}
+
+		if (swath_height_l > 0)
+			log2_swath_height_l = dml_log2(swath_height_l);
+
+		if (req128_l && log2_swath_height_l > 0)
+			log2_swath_height_l -= 1;
+
+		if (swath_height_c > 0)
+			log2_swath_height_c = dml_log2(swath_height_c);
+
+		if (req128_c && log2_swath_height_c > 0)
+			log2_swath_height_c -= 1;
 	}
+
 	rq_param->dlg.rq_l.swath_height = 1 << log2_swath_height_l;
 	rq_param->dlg.rq_c.swath_height = 1 << log2_swath_height_c;
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
