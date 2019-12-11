Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA42C2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C392077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UB5fBVnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C392077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6576EB85;
	Wed, 11 Dec 2019 15:33:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6F36EB7E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZWLBySvkz4AgVVN7L3yOmWH6gAJFAyD8TVMCH7kIvj9a6JGBN2He8XtWajIFUrEKKlc/AfoNcljiVBmzB1U4uwWOsCOyeDlozbMlnD3FYz7Zy7VkMUMvmIEjHhNpzIk6AOWdDs3VUha+dyvjzgO6UXToxWGqGJncpxlzup44pmAuDug5Nb+qh0Ok+6mN6Wm2m28gGvkC+Yep0yyFvepgcxemIQOx7oBdflAKVQFUAiMkzBncpXmts8wkcQmj8QnhYKJAoYaS9Q9cZJUqZMSeY0wUkCayNVndKwPwQwBObuwFLVOQ7xFIQfC+iY+VIMKJS1HiRT8JoRVauHzzLbe2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrenxuV9SqVd+MUlqVcZWZ5SO0emySKA3IbsqBoaB7M=;
 b=doKdXFGaFzJmUST+IeWjQp6wNYgJiqnmIXP/xTdX6s+CwUMHSlTzQHVeMlyAylcHPe3yWh1lIiC+N4V6/PrAE6DGF9w35AonMYM3DdYOfbpkTieDrWz7tOp5Q677B7dsCCVPcwF8RACRTL9d2tyNaHX49kpF5I2as58DtaztrO7L7Qd04PbTf+k53Qnh58d3ip7uoS2s57o4O4TnClB+MYii5xhYyhg/VKRMRBW8v3tg+A6io6u04d7L06cJpKgXaqOQ+gA5JNM/iZrQ2Rp2LcNiKdHcFdju0hS6Wykfpg+U9aezfIomTMCI7cHGns94ix3UzDkfpgWdcomXDyNVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrenxuV9SqVd+MUlqVcZWZ5SO0emySKA3IbsqBoaB7M=;
 b=UB5fBVnZg/wm63euLi2ajsCyo681tHORNwZY1xT6bNHJeQjVPuzvyJ3txsDz++sCZh3rkQ+mhSkEOo3obWdiz/2I7PZIACQICiKdi9PwPcwaiLisDAiVCQQJexWsdphMPNcOzzaAljhpRMOZdLue2CIYRX+ae5AR3NimHG12JLY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2426.namprd12.prod.outlook.com (52.132.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:28 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:28 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/39] drm/amd/display: Collapse resource arrays when pipe is
 disabled
Date: Wed, 11 Dec 2019 10:32:27 -0500
Message-Id: <20191211153253.2291112-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: afc4cbae-5831-4baf-c7ec-08d77e4f7838
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:|MW2PR12MB2426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB242642DFC9EF32C0E9725272985A0@MW2PR12MB2426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(86362001)(6512007)(1076003)(478600001)(54906003)(4326008)(6486002)(66556008)(66476007)(66946007)(2616005)(316002)(2906002)(81156014)(8676002)(26005)(36756003)(52116002)(8936002)(186003)(6916009)(81166006)(5660300002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2426;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4RBxBbavTVztA8CBNP7f0pGpaDas4UoOM3+2SQe6AsA12tmEJaMPvk637pCB6EvNG0PaPb01HLIdnfZEhkDWIIbMIku5zrwc4jQDEDFDkkPcc8BcftdDhbfv70EdXAEjkcdyXBKHPyM0xMtQCTZpDbtZ+pocWU/qgv/aSn6Vb5Kv5iHxwrqEjutRGYjW4b/h5FzOegwe3SDnoDA9poZM3Y44dRwo/fxMPvT6gVDif+0au5pEbfHqFClIuWTjE0VxTv1Ega5anx3yb0qi3mOCTLi0XSZmfkn000GyXLRKogR9aeT6CpNRJCKVuDJ48LcMpUdliaUpSk+ca0tALVZZcPEGF8JTKO1/S1OiQTxq4uB3TY8U/JuREcqAMjIJwnkmEF42+dPnIwGWmUfsMtk4VXjMW+1OEqGJWyKyVbLWbNMT2pU1M9c4kpnj2xz+53X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc4cbae-5831-4baf-c7ec-08d77e4f7838
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:28.3086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdT88EuDHjIa21OZN5fIlxkx8Xoe79NEyouGys19DY85gKxc+qqN/sLVhpZumsnZUXOIEUx24IwZkko7sm1/UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2426
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Harry.Wentland@amd.com,
 Noah Abradjian <noah.abradjian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Noah Abradjian <noah.abradjian@amd.com>

[Why]
Currently, pipe resources are assigned to an index that matches the pipe position.
However, if pipe 1 or 2 is disabled, there will be a gap in the arrays which causes a crash when iterating based on pipe_count.

[How]
Fix resource construct to assign resources to minimum available array index.

Signed-off-by: Noah Abradjian <noah.abradjian@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 98f0267300a0..a662769b0c48 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1774,41 +1774,41 @@ static bool dcn21_resource_construct(
 		if ((pipe_fuses & (1 << i)) != 0)
 			continue;
 
-		pool->base.hubps[i] = dcn21_hubp_create(ctx, i);
-		if (pool->base.hubps[i] == NULL) {
+		pool->base.hubps[j] = dcn21_hubp_create(ctx, i);
+		if (pool->base.hubps[j] == NULL) {
 			BREAK_TO_DEBUGGER();
 			dm_error(
 				"DC: failed to create memory input!\n");
 			goto create_fail;
 		}
 
-		pool->base.ipps[i] = dcn21_ipp_create(ctx, i);
-		if (pool->base.ipps[i] == NULL) {
+		pool->base.ipps[j] = dcn21_ipp_create(ctx, i);
+		if (pool->base.ipps[j] == NULL) {
 			BREAK_TO_DEBUGGER();
 			dm_error(
 				"DC: failed to create input pixel processor!\n");
 			goto create_fail;
 		}
 
-		pool->base.dpps[i] = dcn21_dpp_create(ctx, i);
-		if (pool->base.dpps[i] == NULL) {
+		pool->base.dpps[j] = dcn21_dpp_create(ctx, i);
+		if (pool->base.dpps[j] == NULL) {
 			BREAK_TO_DEBUGGER();
 			dm_error(
 				"DC: failed to create dpps!\n");
 			goto create_fail;
 		}
 
-		pool->base.opps[i] = dcn21_opp_create(ctx, i);
-		if (pool->base.opps[i] == NULL) {
+		pool->base.opps[j] = dcn21_opp_create(ctx, i);
+		if (pool->base.opps[j] == NULL) {
 			BREAK_TO_DEBUGGER();
 			dm_error(
 				"DC: failed to create output pixel processor!\n");
 			goto create_fail;
 		}
 
-		pool->base.timing_generators[i] = dcn21_timing_generator_create(
+		pool->base.timing_generators[j] = dcn21_timing_generator_create(
 				ctx, i);
-		if (pool->base.timing_generators[i] == NULL) {
+		if (pool->base.timing_generators[j] == NULL) {
 			BREAK_TO_DEBUGGER();
 			dm_error("DC: failed to create tg!\n");
 			goto create_fail;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
