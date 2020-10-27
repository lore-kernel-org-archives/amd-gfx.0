Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E313FC63699
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B46C21D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JjvYqrk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B46C21D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC196EC5F;
	Tue, 27 Oct 2020 20:53:04 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700079.outbound.protection.outlook.com [40.107.70.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92D26EC5A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwRZebxaMzEoXSqoY2hO5g34xQShXFekbB57n87XkyxjxvtSbvOmfsp5DOimw86/K24lt5699ZCpHH2Dpc4YmSjYwi61/yM4TkMNY6CnvcvLxqiCWMbP0iUCeJWFxA3hbkm2IfY7PYbVw3NEKrWNtD2LZZ95Ppm4mQTjjJF5WxEPUEDogAtF+8bjZetU/0nA8yK+fX1LP9SHFeX8qfPluRM8aYVPpvepkQOC9XGe6SpQvrFXV3VukMz+XMuIC82NfyZkuKaAo4xkI9wcM86sZ3S8mR9/0wrCNUFJUjEv3gLRu4PNQd1qTt6zHkbaThDLp2ouH3Njj3G2Jnk1rKT5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI4QrdrTVPRcouI4pwC14XvjW+mMZItQXyGovl+5itc=;
 b=CaCOgnCYKtIBDip7I1Wkubfmwl4Ew53AgFKHJTIOKVG+YqchCw3KlKVI/Vd2usF07w+ujCxugSZPeWOFgZvMk6qWTGp5NuVKjURtg5js+tQllNNaM0UXHRx2JLrJ3LW+Q1r+uLcVqNHrpVD4GxBORShZe+9xmfOfM2B5GOi+69Du4I8wX11NTYdq5L4DtR7VMbU6AMzMz9CMt54jKU6bN7+dj00UYeYPAA1KRi8IcNVK2nOMBfZVF3hzAiUdNd+pHmt27F51RCdDyXfAzhHvAspYUCC6xj/aMb0NuziAmYCG5Api+DbAMqZLACzmhkwadVfYQ0HcqVSncWnTEbVNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI4QrdrTVPRcouI4pwC14XvjW+mMZItQXyGovl+5itc=;
 b=JjvYqrk+UguY+SlIE4BFSlnLcGeVsta9FaOIg/DsUGUJsDVdysqeb3iMFww6CccCHqWQOPKmK3Ed7uCtBUgsq9sjNiiRPOeNHJOj81mII6XlHVcVTbkiVn+XgjDwhNQn3f4XE4UBMFNdBken9oUVG+8lc0l+h2IKqdx5C4WVvhA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:58 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:58 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/25] drm/amd/display: fail instead of div by zero/bugcheck
Date: Tue, 27 Oct 2020 16:52:19 -0400
Message-Id: <20201027205234.8239-11-qingqing.zhuo@amd.com>
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
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85fb36ca-16c6-4107-eae7-08d87aba4515
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595A837089B7ACE781A98F0FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:85;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iB3gERxl8/CUxw42FKMnwUOQrXriwLMLUppAXvTYD6xAkSrbKHTTFa+HvywdCkp95SIW2MeYZOwk34Oor3nopvYYlpENBE7Ru+Mw2is39r6TCa+ARD/JPJaUPu8rtxvZNOzEbOZOie9jvdH0/UejSeZSocmigZEEWvhanDB6rMo7VKN3So96orK7yao9OySYx/wwfBun2mWFl/FJGdsjEpo0Qdo5M1Fn+2G0053dOE+Ns3RCagD6ID7oixy68kmC7JRZy9qDsW61bZSX3t987IYJjo998y702BfdL8MLs0wQ1KDDXU4ssaKxe1Pogj4U0eCknrMZSHvDi8ceQGweJJNETYqeL7Dvy66R86A3DMJnDdxyCMLlo4+qdLKOt1Nj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: evmQNMgT3g0lmYM1ROJJsyt/b5abW3rPitJ5myAdBgMsDN8Kn3+xvmPhY7PUA6R5GJt1du6iFo5ad3/bbYNmqnfea51QheNofctIdz6pxfRNSu7P3Q6xMPrngt/TlgtRXaVf1QGX17H6JrRsoarbqbLnp4OUVncQoSN8klxSZ69aGw6WjyqPs0YxuNWmio9bdwilAAJY8VAFVHPmrm5FZ0ocOadEyCbxUVnyqAxLJLYMZUUatDsSXlT4UOkIMkby4On45C0yROpqsKt1GpByLoVajuF13NjA4TmJ5b3C0Hln9e+OaD77OywOo0zuBfD3i+r1fWX+AnJs4/dJ/qrAr9vJs9QjRub1yRTMitDhgXo+blH9sc+8o6zfdK9FUs5vVIqKF1x60hlqYNqw3ZKkk39+/p3icrmJKF3hAoK4Y92Y7GSwPixX+9SHrC7VoAWgltu5fO2Z05YP9F8ewiMtYq9L1+KB5rMhVpQ/lGfa0zKOLiSPjswvblF6+QOhfWiI8EO3A/cf6KAzBnUkBqz407W7l2Xj2ZAT4Rtpi7JEU8hNeJezkvcM4ikuOjRyz6lwWhZgws53Z7Vl+yY71h6Lb8B7M/m7nSOj/S+NX/M9/OhMVcl/qBzOxd2q0OeGy09aXe/nIvVdZceelf2Gv0+x6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fb36ca-16c6-4107-eae7-08d87aba4515
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:51.6594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6f2zjcUM0IG4Z4B/+0Zt/VPWjZQLM1x/dV2Ep9SHFnOntPNFljPSRv1buFhvKKwB
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
Cc: Ashley Thomas <Ashley.Thomas2@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ashley Thomas <Ashley.Thomas2@amd.com>

[why]
If pbn_per_slot is 0, fail instead of dividing by zero and
bugchecking.

[how]
Check for zero divisor before division operation.

Signed-off-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Reviewed-by: Wyatt Wood <Wyatt.Wood@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    | 4 ++++
 drivers/gpu/drm/amd/display/dc/inc/core_status.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 7977e2839065..21be2a684393 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -420,6 +420,8 @@ char *dc_status_to_str(enum dc_status status)
 		return "Fail clk below required CFG (hard_min in PPLIB)";
 	case DC_NOT_SUPPORTED:
 		return "The operation is not supported.";
+	case DC_UNSUPPORTED_VALUE:
+		return "The value specified is not supported.";
 	case DC_ERROR_UNEXPECTED:
 		return "Unexpected error";
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 4dfa70c0301b..eafefcf3696c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2951,6 +2951,10 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 
 	/* slot X.Y for only current stream */
 	pbn_per_slot = get_pbn_per_slot(stream);
+	if (pbn_per_slot.value == 0) {
+		DC_LOG_ERROR("Failure: pbn_per_slot==0 not allowed. Cannot continue, returning DC_UNSUPPORTED_VALUE.\n");
+		return DC_UNSUPPORTED_VALUE;
+	}
 	pbn = get_pbn_from_timing(pipe_ctx);
 	avg_time_slots_per_mtp = dc_fixpt_div(pbn, pbn_per_slot);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index 714593a15590..d34b0b0eea65 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -51,6 +51,7 @@ enum dc_status {
 	DC_FAIL_CLK_BELOW_CFG_REQUIRED = 23, /*THIS IS hard_min in PPLIB*/
 
 	DC_NOT_SUPPORTED = 24,
+	DC_UNSUPPORTED_VALUE = 25,
 
 	DC_ERROR_UNEXPECTED = -1
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
