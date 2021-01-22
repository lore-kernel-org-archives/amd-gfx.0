Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5D0C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 09:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCB9236F9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 09:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCB9236F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507436E0ED;
	Fri, 22 Jan 2021 09:02:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5794E6E0ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 09:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X98NbUNboN7fT/CV/yr1UCQkvftS5NLsJRFuDbARIOKRw/2/gpylC16TPdtojrOCZU0oRFWSxUEMTBvQG9W7bIQGt7BVxU/ohNRvq5aOgbxFdDqfDPeC6WUETX7okomWByuXjHgG75IjcHKV6EZZDauS/GFuTwcbdm3O3RL/KrGHX6/rv+89EuHufpGxnz6JQlfZR7WRfwWfg+wEAlJhwVMGEI27GOQ2wEB5CXLo8tiKAEtbbuhPV3QH4iUxq1fl7A1BZtk9GwXDHCZ7/6DL6mVs59Kg7GyOPZpATyAEXfOhIhXCbI29WfXyxB5PhFIPbo2O39GmmtVu40xwN5Zcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAXH5BIKkC0RxgLYROQnl4x4CAs4EYqJ6F6ce11KRh0=;
 b=f1cCgoatcyHW8JSpOFcbDzmSeD10EwvrRXYuGo3x11raeBwp+g+pDQtqHFTzAZWHO4f1A/DZkj6xlK/LJZrW77AtOcjEaaP9U8Ii9YvhdRy+3/0SnHZhYzDKiZFxaQ9VFzYNEGIDSHNkKkklXIGwkbj8or/CiJ7uHFDGRdl+5QQeeIW6WOXUPDlFTOI8kr0Vc9X01rl3GZea1L9c+TPk+DfC1Chf57rPdv3Qbaep1BTtk7zejS4h8TSX0ito891dybBMtB7bKIPdJWJAcn0Dj6mp4jnbKRUmn5HEmF3xqZoG5KHvucs/iymIpvDhsQPQk+I2SBJ95AD7GQZilWpetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAXH5BIKkC0RxgLYROQnl4x4CAs4EYqJ6F6ce11KRh0=;
 b=N0zbgcbn9ntyxx9c+oxdnYjWdqsGDOkABLZOQYn54EMaP7KwmB1UD4mFhtbs7mysdT5/ERVcf0e6aSRXW1phFPTAQk/j0rTMBnMTczr+4MDJXeAG+l/vAZ1Hz8gSIuYl3c1wtZ6uT4GJpLbx0qR8One20IPi8F9yt75mA4ndhoc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4629.namprd12.prod.outlook.com (2603:10b6:a03:111::11)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 09:02:23 +0000
Received: from BYAPR12MB4629.namprd12.prod.outlook.com
 ([fe80::353b:92ce:366a:8874]) by BYAPR12MB4629.namprd12.prod.outlook.com
 ([fe80::353b:92ce:366a:8874%7]) with mapi id 15.20.3763.015; Fri, 22 Jan 2021
 09:02:23 +0000
From: Lang Yu <Lang.Yu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue
Date: Fri, 22 Jan 2021 17:00:59 +0800
Message-Id: <20210122090059.851508-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To BYAPR12MB4629.namprd12.prod.outlook.com
 (2603:10b6:a03:111::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lang-desktop.amd.com (180.167.199.189) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 09:02:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4dc50ad8-4725-4bee-4b01-08d8beb46ed0
X-MS-TrafficTypeDiagnostic: BY5PR12MB4241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4241FCC1B967F02609B4BACBFBA09@BY5PR12MB4241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Y6UMshyO1prKTVWKxSjIXOAeiJXG1O9Yx+ao6Fl5dxiGUGgaiLUgQPtuTN1kmKZh+BRbyQdIF8KE+eLvJ20KXIMMfBchEsNeZMCvi6NVC5J2xWv1w3PdPmR0cInMZB++Y8kyiWSJ3QDggUPyxG/GEfQZAIaH12UxO1ihzrx3mI7LJu0n0yzZyyWn1esyDQYHdq2yD4DmhNVpCuRE0IrKW8cG/akFykyalMBgq5mJKhOeUHmnq/m7bFtX8scR8IZdb4Cn5NMiRWQPYd5Ef2EDZtyH5N2uSHqLQNudGI94OwTSRDLsWGGy/srTGb1wC7LwtM4AsleokjCzjNC/WqIvfqo799p2enS73u81lkxnGWKgWO4AX4Xp9/58x9+FksLaxRHMskqEx+cDxkyTLz6fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(6666004)(83380400001)(54906003)(4326008)(478600001)(6916009)(2906002)(6486002)(2616005)(316002)(5660300002)(1076003)(66946007)(8676002)(66476007)(66556008)(16526019)(36756003)(52116002)(86362001)(956004)(8936002)(26005)(7696005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1BNasWMiwsgAjDTUxIlvMfGMLeCiNXg4uKo69a0AIBctUowRtp6QH2oIjxBv?=
 =?us-ascii?Q?lnAO8Y7slv5/TZ4U2wywO9EazjMMHxtAVtWlIB8apo1tASeXeSRzTepVppzo?=
 =?us-ascii?Q?vBe20tFZwKxR2c3EZrvjykq7Nxt21KKsQmMHcQoKjGGtJyLn99oYHDUaPV6C?=
 =?us-ascii?Q?qvF/n58OVhiICTPMxQVSM+doWgM+LLEP+15E1eqvDFRX5qLbInYgMn02bZ4q?=
 =?us-ascii?Q?RQMQDuGNYsJkO9d0DMf/PQQonU+uYPYge2qPDHiRijEmqtBBNdOo6xHL9E6T?=
 =?us-ascii?Q?YFYbaHg1fPOANFCs2kArpTNNoWavYZ11zC4lWZKo5u585Hr+GMe+AS+kbLtw?=
 =?us-ascii?Q?zJ7C7speg2SvxdoUWPpcNxJhF0ULdJy7a1VlUED2dCb1XkR6B/I2+IVCsOi/?=
 =?us-ascii?Q?wpnhFcKCr+6nLp56+l5lKAMyPqukS9mu6RBfdKNK8aWSlhg+hryH0fPMnCuM?=
 =?us-ascii?Q?4zuymZVQtMuF3Ckp3TFGtp89SJnhsGx8bcDb7QjCJdLuahJbqO4cS0wY4WMl?=
 =?us-ascii?Q?818mYe+iuCVsKDmkhGICvbeagcEPXnEHrWD+ScDMo2soSUhy/LHMG9z6pVAe?=
 =?us-ascii?Q?pE5/khOoh4DHtERxEi1soNxrWrOd9CTcU17/sqMeqC8hfPnfnZvde9qxAXxY?=
 =?us-ascii?Q?ygopJiLeGyu93ttaD1wfupUDd3MndxcvkvD862uK5eKnsSIOH5j5trYq1BVA?=
 =?us-ascii?Q?haEDf46Y9FOisPTbX155igFFKZao+pLIOr8E+l/7Si7cEMmAv8kCtv16Y0ZJ?=
 =?us-ascii?Q?QHQfbRVciYeFKv4bEmTp/xfUWZ3mTKrMRuvVUq70JPXmiVQm0jf3FZ1zSWQk?=
 =?us-ascii?Q?lqFnE1iHWDQO5cP503InVwsW9uqE0pYpagYq/4B9FiN3qAi1SoS45/tJQ7w7?=
 =?us-ascii?Q?kC7kVUN/m/Pv00Q7UD7Cgx3Nj/n3P5pHy7vtkU5N8iG6XsofuGcNubNkobYq?=
 =?us-ascii?Q?+lnneKCK8SQ81SZAAdJfjzirhheSFMCq3dvxFunE/fNz5gTQzpeg2CKMBb6z?=
 =?us-ascii?Q?2g4F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc50ad8-4725-4bee-4b01-08d8beb46ed0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 09:02:23.7369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 554wbRPUqqNqSyDNfGIiSa51LFDcozZUoZfG4bSsiaP96AwdFOxq3vJZHRYRZKYUPhtqF68orf1xg+cZbjOUKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Huang Rui <ray.huang@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace "/" with div_u64 for 32-bit arch. On 32-bit arch,
the use of "/" for 64-bit division will cause build error,
i.e. "__udivdi3/__divdi3 undefined!".

Fixes: 27755cdf83f1
drm/amd/display: Update dcn30_apply_idle_power_optimizations() code

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index dff83c6a142a..9620fb8a27dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -772,8 +772,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 							cursor_cache_enable ? &cursor_attr : NULL)) {
 				unsigned int v_total = stream->adjust.v_total_max ?
 						stream->adjust.v_total_max : stream->timing.v_total;
-				unsigned int refresh_hz = (unsigned long long) stream->timing.pix_clk_100hz *
-						100LL /	(v_total * stream->timing.h_total);
+				unsigned int refresh_hz = div_u64((unsigned long long) stream->timing.pix_clk_100hz *
+						100LL, (v_total * stream->timing.h_total));
 
 				/*
 				 * one frame time in microsec:
@@ -800,8 +800,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 				unsigned int denom = refresh_hz * 6528;
 				unsigned int stutter_period = dc->current_state->perf_params.stutter_period_us;
 
-				tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
-						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
+				tmr_delay = div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
+						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
 						denom) - 64LL;
 
 				/* scale should be increased until it fits into 6 bits */
@@ -815,8 +815,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 					}
 
 					denom *= 2;
-					tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
-							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
+					tmr_delay = div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
+							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
 							denom) - 64LL;
 				}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
