Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B8C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310E420657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0U6nAYK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310E420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5067C6ED16;
	Fri, 15 May 2020 18:13:45 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700045.outbound.protection.outlook.com [40.107.70.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD6F6ECEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n68BetZbKC7zB1hNuhnHqRhws+96irxpv8nCR2PlRCoxh+IBDCEC/TD4lHSaUyfs7g2ZgF4rbXbESnthNV9dj/wfZ6lfyp+ObfX8jVInL6aVbYBd0OWyHCtcdJxh0cbRFAbK2CYpr4tPnwHNaigCt21KZQO5UiRR1GFPZ7MJHnzqtyyRYhkdNztNBVGaBDvCwNZcmZDity3P4kJOP5MpIFVAgJ+XGlDW83mDgnnJdG0ZyVoVMfTun7OmSt2ilPyrTA6PLyjt2v7KIq+w5x9KZqFSmGA60X/+PwPEkhW8vsv6Hd/egsNyegMpN7947SF8J5Rd+wg8xyD84MBALNOHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdBzmsHPi1lR4X+eNB3kHl1fbX+OKcjYV12ss6y1XvM=;
 b=V1RzZSPrbDoutRDycKRnN8Fw3EFabIAGkDyvl9om1hqiv3SZNM7wOE/AgurFcMOxGg+GWpoETKeHPl8g0SvomwYx3V9EmnhE13wgV/K3fV6tF40hNmtyW+zOf4rXth5gO0+bFKmwvXm4pL0psQoxJvQfw309o6Li9eJ9a5rUpP4cjj1tiBcdsGm7pSN+eXcvwqkE2oQz2ObOzd9pwBS7hXRiND6Pqdg2d9HttD5wzzH80aBXI96bZey6iCDrh6SJos+3srem6ZJwKm+NixDg32beI7w5AlReLsHF1VmGhTAChuVCEYUvPcmdPNjZfoPmKrvv7xGj6xfyptxkOkax3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdBzmsHPi1lR4X+eNB3kHl1fbX+OKcjYV12ss6y1XvM=;
 b=0U6nAYK3ZYE9WWBMX40tnXc6gtpkK2HIHB3Es9wXhfxWeSKoXh9vfPNOqLsrQchndl/9Hh0I01KHNlKE695DXePaGDmfuAulZ0uK0/C+LL+wraiiSD7JLtdJMsPcwURCKf9mEiDUnSANWSepf0lyo1CPj5bvz38BXRsu2tcEVqs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:13:41 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:41 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/27] drm/amd/display: Do not fail if build scaling params
 fails
Date: Fri, 15 May 2020 14:12:51 -0400
Message-Id: <20200515181315.1237251-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:40 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61343d62-6300-45bd-6e43-08d7f8fbb27a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB397470CCEF2A00D67FB3903498BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6B01EqLKmrJIoX7LHluuW/n004igtg/MovTFmR3C5keS4v2C5mVdOK9HwQ59ix8XIa3Cua2HEhWYeIqvsxJLk1kGpxShvWyKHkMS/mS4Zb1mgseUe56frLMAcdqwWIXYaYjLelBLL+4Ssuru2qkR/dxMhwi3oQGqGB7cuLyajy0v02m4mSkZXxWBH0KdaQrAhJN9OJviRbZGHaWgz409rplhgGmJZze/54hGarndHUu6cTHOSpmNFZ/tgL3aqzIKzxd173kSbq63/vzpCJA7c3h0rNYq6jYZkPfsuswm78y/vIu9WuGIPZxbnCn5S2TsWDMrVme3vj3PWUJvO7qKHkhe9/GCubhy8CF7SGJZ5b+yc6ImeFEzLnByrnlDA4UD9UbQ9YkomKcOPsaZsHsprzM1jmunz1+LuIlWUREsdb8Gf8LtY499KwuQckvCz6Qv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: liOmQShIKIbEehUQ+Id0nZq3xym1nYvllQZyJKXcgujj6Mdi63VqZ8J2E/18MTm4fNYH82HZ6WjYCZp8v4KuLoRsz4XUm/ZoquhUeMnZQd1pONNJFqBSvgY4FjgzCLFWgCTmeMcxZ6a5capR1CCqM+SjaIR7WuTUqwaTLFe7PRB2GNZpTBhqeITh6nzk9ZFI/blbI7dDzggDFLslSKgTGAuC/bPEtEe6uBFGEe8u99gtkcLf7FWjCMlVNxinHf+iDA1hfIAy4k+y/0aGsStdQoSy516YOi4Dmqkap1io2neDnQQTxp9urTo4fklrSr+45quC7jsXfywGKYUJ/JmXAYMzO5jChdsOnS5Hrcwt3SRXGeTAwZ2QYwrQIQM5ngMuJTTSU780GoaqHXEC/RCvgT4gGUeXkgstjJcKZqq5RhSitY1L060Sjc67bfFSQiXjnfy0ATJqZ8enLayEMnYATq5wEaQpD/+fU803321bVqeIxdiesBZjWaFUpHAAw08qkeTe371azTnSpXHv+VXVXQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61343d62-6300-45bd-6e43-08d7f8fbb27a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:41.3621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HOLl8iHheEN99fIjWXWDSbWtehgSSnj3u7gWrrFo32GGkdS9xJKD4ftbkvX46wJ5Qg50V3JEnW2tUTROAsqyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Sung Lee <sung.lee@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
Failing validation when building scaling parameters causes corruption to
occur due to pipe splitting with smaller pixel widths than HW supports.
This needs to fail silently for now to hide the corruption until the
corruption itself can be fixed.

[HOW]
Do not fail validation if building scaling params fails.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 4190ee592e6d..d00de61ac720 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2824,8 +2824,8 @@ bool dcn20_fast_validate_bw(
 					dcn20_split_stream_for_mpc(
 							&context->res_ctx, dc->res_pool,
 							pipe, hsplit_pipe);
-					if (!resource_build_scaling_params(pipe) || !resource_build_scaling_params(hsplit_pipe))
-						goto validate_fail;
+					resource_build_scaling_params(pipe);
+					resource_build_scaling_params(hsplit_pipe);
 				}
 				pipe_split_from[hsplit_pipe->pipe_idx] = pipe_idx;
 			}
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
