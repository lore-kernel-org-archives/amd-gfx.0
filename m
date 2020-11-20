Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C3C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0277D22D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PVJ3qk0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0277D22D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2939C6E916;
	Fri, 20 Nov 2020 20:20:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2061B89A08
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWiQ6ZLjbzvu0StwFmf2wS4yfxwtafl/sDgTt8wTSL2BTSvnsZh76YDabDpbsH65HUr+rOQUtxKShvMHYXJGAovNXK6oAGHSNmRme3S6hZNZp8ULCqpV3nM3Ylf0zB8I1f3s9yGrZG66XLxUIG/fBPSikD17Xbx+kl6NENCQYETrUogB2Q4oUT/Uhby/mmnE+cHO1yff0TZJXJ4yAEcebPDgmpw0RSwuDpvovZfiJ4OeG2G3jsbGR+nCuZUTrLZfIS67/BkFGBybtLBIMUYWE5BbD5cut/f66zZg3o+zXAq8YEsOMZN4h+n/XT9f4wuD8AYyTHv1rNQ9yA8flYustg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7nC8eGY9L03a6mNG83zc/1zyfaNuKX7CPRR7NbWZm0=;
 b=Qa+mclXp72eWs2TDDS6L1Z0S5uBnkpcH2f1Lhlu+3fQ8kjXO2wk+RDoecP2Gm4M+p42uz4kYQzEvLbx6Xd61ZuOL/Z/FEYhElwISqSQfoWjYh8Ad3q5EqTr1hjkA7dfUwqjEJeNOCJ97UtlCvos6+SNW3d83VXl6FtckegANT+JDEmC06Iy8Wi0ErOP9+8bReCEsJuK6ts9BoRAC+M+w8+hTmz+KtK5BuC9TGeif28upvER/Px+AdtN5qRASzbHPpCU0P2dqwVbMTyViH4WPblFvtdcuIKz363QPKOAqUrgEC/DJl6ss1vpSWaO19LWvRhXnfEAwl3j4wkNBE561fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7nC8eGY9L03a6mNG83zc/1zyfaNuKX7CPRR7NbWZm0=;
 b=PVJ3qk0nligURMreyeK1myyamkI2EzHb0nbm45YG5+eLTTFlR3Rik8j3yQcBTSyWhMnTOO94ubTlRzc7AnUraVN+9OIGd+OV3hdYZ4K93tgvu2OKJKEb37hzhkVsxp96ndEO2JjPHAlLftQhKc8+4DM1uPjqmm6gz1KefKLqGM0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 20:20:23 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:23 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/18] drm/amd/display: Update panel register
Date: Fri, 20 Nov 2020 15:19:43 -0500
Message-Id: <20201120201958.2455002-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97202453-e994-46d4-6a40-08d88d91b5de
X-MS-TrafficTypeDiagnostic: CH2PR12MB4216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42167DF64EEBF9663FEB41B498FF0@CH2PR12MB4216.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T4w/FIDIKT7daMxzGx3wHb7BJ6qUsVpGzpWwi1ymSsB2U9xSdLTkdWQCciZKExY9fB0INiv7yU884MU46QykteebR8+VjgBjCuVRM59wruTYndXKeokokdscfSiCrsjIYtnnKeMYOiyxdL+Kcul5zhONCh8GYoObCUKzRwJBooIkA50xCs1t6SbFbTYGg7eyGL4UkKMLJAc3C2F4PPUzJCs7fRh7HbX34BLrLRnaVPyHS/NVgg7GjS+bBsDUbdCX0mWJwMnmUtMlcD6HH8gpy0iLbjrIb6XNVO15066n12Djt4SHp7atjBOd9yWl6eAdK2mxITdEAvHO1CDCz1yUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(8676002)(2616005)(66556008)(66476007)(16526019)(66946007)(6486002)(186003)(6666004)(316002)(54906003)(478600001)(6512007)(8936002)(86362001)(6916009)(36756003)(4326008)(5660300002)(6506007)(52116002)(2906002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3d16tBbVDeXsrEmJNiVIdXkTpLk/yEJPxF0xJ4MigEFU8TKC+eb4ZcZYUD1vGkFGBdYPQvVZr1LQMRVNIXMyq2pPcPNS6dVHuXVSWYc5TdZoJaflZL4Vd5rUTmv3wvd+VD5yrewqIfV0QeOsnzQfhWrHgwsK+kUnEsZYddq82oVWab32SyJaPyRqCM6YXSF7lFJ60DF5KVJ7VUd1uuvwJsnwV3Eua1cUXQAMZg41LMZy3YawuXJPdfE47ulxufi9HbV0qw3GMM1Xz7Sfp68WeG8MZ8gi/WYjsDRMcOuugR633RPTUvuK5kZL1ujfUk/W/6VThjHnDK7cqjzTWJHb/ekU3TZNKlPAU+Uri9QYGtLJKFjisGPDX3+dchHgNeMHe217MD6QogaBr5xr42KJaKqjCB8qKKVDcX8HrQ984CLSzvfNtfMhpt7gmafg90MFEiIVYGfL7TM11zm3UoPjlVX6mP/asRR9HDlCim8tLfyjyeR8N7ZTV7moagq+f8nc0NWG5GksLDb5CSo4+AsJuJ9YoW18FSxQUFuf+cMjzKwl6JRh/rQrDMNwz8aTp3LdAeoae1UPcAKD4dgelkNCOU1cLu+gdKaqlZV2JRp+sp3pc66y/cqGzembFi8MAqTvagS/SpowK1uTtpHIa5OjZfs+2lhEmzh8+ZgfdcZ35GOVqXq2zRuVR5BnwMbT/CU1ngYAZdFqjWpcdGoW9M8G7lSZhSpYsGv14VjDmNObseVe4I8OpL2hH9QHm9+jRe4K+L4uPNLGC6UMr/j4ox5f5CGmZEjDs0IbWAR2GxIlkhUJpryz9obH9Es/Pe0DssylnqRd3yoAVbsqrsDRV8KDR1FcegWW25Qo8H5XiTA/vFsiOFQ49l9WZjrUIP8vTtJ2RTj2j0tBZPcktz0I/MbAtXffrliryPjT9U9JUs17ebyk+HvmTxvw+UAOfzAJo9SX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97202453-e994-46d4-6a40-08d88d91b5de
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:23.5790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btELfGjX6bgz7YFBDQ0WWG+n0uhOVM3Idx8Yx5E9tzlS1/ZFNfNC2rV6n0Ao/0ygkI2UmiH1B9AOcLsAioQLww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
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
Cc: Joshua Aberback <Joshua.Aberback@amd.com>, Chris Park <Chris.Park@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Incorrect panel register settings are applied for power sequence because
the register macro is not defined in resource.

[How]
Implement same register space to future resource files.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index be58134a7954..9ce9d9603942 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -521,6 +521,7 @@ static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
 [id] = {\
 	LE_DCN301_REG_LIST(id), \
 	UNIPHY_DCN2_REG_LIST(phyid), \
+	SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
 }
 
 static const struct dce110_aux_registers_shift aux_shift = {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
