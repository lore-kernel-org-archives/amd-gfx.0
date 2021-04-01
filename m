Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF92C43462
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C0A6136B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C0A6136B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807696ECE8;
	Thu,  1 Apr 2021 16:46:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817676ECEF
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2FgGrvpz92ZZG1JRbuEb8Pv+3A0N2jG24F++atsnrbgYUWHtWc7ULr5wmAaODm3rKa+b4/MydkyGzeTCBPTap3Rt5OhiHxRCvThHsRkfkkSBqrp6Ky4WtKWm63wY9WzOI3IMzp7LudwY0jvxwxrYW2y8YLyF8YOBiDwE7xZfK+SW/fdtRz4Da/iTNsO/x35WtcCrdbd/Mx2VyQNvN43DGCqa7lXL+4hqFWnG/zHaPBfn/hkFVJay3ZYx2x8QUUnIMn1UEJLrTtCrAqyMZBMX6wSJjqxvDbVmdSTIkLlfIKvLFwZeW4PzNcyO6DaNmnDUjzvKaGHY4lVznW0YF5geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn9Fzs0QTl4P7pBVBZK9lDNrmSTm/6eQArtWmtnJUTM=;
 b=oErUaTWVHurrxzK+t2g1kBB7mLnoaQznWqKlt124ESY/LE+tmkLa34w5YhWC3gUfxrjHGBk6wFMA3B1WvnS5CbWaKyEGTvYf/Rw4RgMDBJM69PNWNzd/VO8X5cmywH+CajRJytVrb6MO+TbuxyA3n44KlvqBjAA7US5CQKmkt0s6/m9+B1iWMPnwuhie+TiKQTUUVpcvJv16Ct75r+BfIBkZybMj19Yp7+LbHpk67K2AT2WTTsSQlhHjb232qvsXfcrum0ljRNXsmYK0G+lKzT89uW5bBHSi/Q6w6yjcYlHqzWsUW6sO6+iQGKwSCXH8z2/fqiAwf5Xw9E3peSb90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn9Fzs0QTl4P7pBVBZK9lDNrmSTm/6eQArtWmtnJUTM=;
 b=CAJlRrfIbGPOQxQVuvGpNhCiTORh+L10B15j9zojCkGqdkuFZYEr5GGVHWGg2cBhWWruWfMMEV+nR8wTpScxsK3GxXL10iuKZaj5SU2xi56qYeVq2m7DgDW7StIDm9pcpa1+b7v8/30eNk9ddSCoQaEDC9B4Ey/rGJZmPqZywOU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 16:46:10 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:10 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/21] drm/amd/display: Fixed corruption on 4K tvs
Date: Thu,  1 Apr 2021 12:45:24 -0400
Message-Id: <20210401164527.26603-19-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4376633-fc7b-4ff1-aa95-08d8f52da73b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB114830D28601243E1F5C5840FB7B9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLLnvragyr0JHt5wvUzBWVA6JaHjhaAgSKG8NSNCLSEfXkc16UHuSix/0plaHlgA02j346I4zLX1Z4dciw6KmQLQ+S6RkMYqtuf2CJX0f1AlQ9+qBRbDI1QPWz7CFIFIOw0N+13lgLvSJ80Yp5atH3lNhLGfVVxrwI/KWysNnyh9yubUJ1PbZGfR9LM3R73SfHzkd8cQ2+pNOqCfQjPZ8/7SpNH1zHPIN+D1G8CyeFwYEHP1JgngTxQTJPFPQUgxXMTKgAAsEjszrcr7NbgjVQ2CB9sYzs4UWGQVYxP2n6YZ8O29NiZ/YMfwxs1tH+L6KPJ83FvXAbbg34bIjIVHpDyAEwgezIy6Zoa2oSfHUFkvAaNFnaCxZTH2T5R2KDrupWEs6xLf0o1Lz9C3uUU+JiIiH4HTBHj3RLgdYpdepyoSBkgpzsicg2bnvY4KQG75XXCLkN8M3mVCViMeAFfZ18oaMraxYiU7BEEdhD1g/hksNnpBbJ/V9IzruOuM9jYjvButaylKLqIwEqpfDoTuejOYDX4Lt8ybuC5pdvXpFuSmXUAanI0q+HGGN1OShY7zYnio2vlEHWsPBYMD5nAeEM/Z5ovT9oxY8DMlghNjn+af8wRJJH25/5eTy4P6baE8TVSEcfjDzwGbGyjtVgb8EB4mVTz91ViW/Lsnr5Xt8A9q6FPwl5Z0tbUI55+lCBGO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(36756003)(52116002)(4326008)(6506007)(478600001)(5660300002)(66476007)(66946007)(316002)(6666004)(1076003)(2906002)(69590400012)(66556008)(38100700001)(2616005)(956004)(6916009)(83380400001)(86362001)(8676002)(8936002)(44832011)(6486002)(186003)(26005)(6512007)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sevEs3i3u74W0PAXAR+aQOb7m9LqEkLh0p06IQytgGkNuI1osrVhqiJ0p3u/?=
 =?us-ascii?Q?lbtbkLdtL6Blvtbj/ofGkwsXvmJlH7ZIZl9usdHzsSFvBhEJsAzItA7z7L81?=
 =?us-ascii?Q?8vebfk58jpPOXaWexyD2wR0Pn6EKACiMVFNhSlFOEam9oeEwz4yqepK3s6lq?=
 =?us-ascii?Q?9Bcx1vkxF66CVtjnZFcK8xJZYFmUyehmUIGbpQib3ajCv2h5TtoVoCnLlffv?=
 =?us-ascii?Q?CYts0e12rl/ZAq4VtLKRcjgspRPOfDh4c+nbQawIr0KTFsYuWEVRL+xyiaVh?=
 =?us-ascii?Q?pYLDEzUskTCjzrFZ5yKap4DpipgzYzRkXxGvQpkQmV7ykOAxxVs88x/NoT+o?=
 =?us-ascii?Q?h8Tid9tZ8Eg5ZV/9wSfBiCOJ6lLwM/rf9VJ9dcuOvNMHaTk7TYfiQOeH5xyX?=
 =?us-ascii?Q?6tSwIFmw/S3hrVVyMw531mTKOEaSilTqhRSZBPJ0zxify/RQlZLcO07wUUSH?=
 =?us-ascii?Q?0gGQPoyQjF0J+FVvOLfj0uMA8+tlEr0aY1sdc3d3xjIxirHdlorSSvg7cRzl?=
 =?us-ascii?Q?qqshp/ugVH4NAEXJGypSr6dJx+3J+vQNSgT8RxHV6jOkEBZjC5qJl3M4lKzd?=
 =?us-ascii?Q?8vjgT9ZBooOcqoeclhoviiI3LGn4R3DxjNCbDU5n+bO6s1D/x4SZcKpOfpHo?=
 =?us-ascii?Q?YUzM+fOkUbbuAsymKOE+X1uppkgO/Fsjt0JVmDnV3hHQG+pVNAD47MThW4ru?=
 =?us-ascii?Q?Nsc1Jjo6giTQ8KYmut4pWMlY3mVBI3M6o9tAKPo/yd0WoSquohWHm4Gj6Yra?=
 =?us-ascii?Q?B2phbceQhJXpjVtt8oo331cxaHTaguD2Ln//jajxB3VS+ahizaDtSIVrraR4?=
 =?us-ascii?Q?+A+YPOQ1WSSXVwSR9MxVwnktbaxGjTkJoJCuN31rRhPEmu3yuw8vycc8XsFf?=
 =?us-ascii?Q?D4NA7jmjRgF5Nd95J9bB344X7rXVVjjKCpkldKyTfFXLzr5nmdlxKFD8twhJ?=
 =?us-ascii?Q?m6Gmq2Iha2/O9KFQaaSIzox3hBbf1dxgqhpOVT2mQpZTHx0T5SXQG0Cj22Xv?=
 =?us-ascii?Q?z0hXHWdcAI+vZAvK3kjxg5zlchlENfpzUNsNw9iIBved7wCJYr/wgMrcJUNk?=
 =?us-ascii?Q?h0fpDOnXsw4JOoZgFsDZBCdsKUVv29lc7qVnJ3yQerepd7siKI3rUgBDRwuS?=
 =?us-ascii?Q?U0RZLRATOQH0mU9dMgogCShgMucG4Fsv4JJQWGwdX/CP2z9jqFidyR2cNjKX?=
 =?us-ascii?Q?iY12E2rGxYLF2Nwga8Ut8naHN5UnoCba+MrVIcEWzkGAm/Me1+X484EATci/?=
 =?us-ascii?Q?31KP2Nzzm7KEiswfLaoRv8/mi0wLk0LLL8OCZsxEGN2YuFRyQhQP4AtdlHcR?=
 =?us-ascii?Q?oTXYrh6kaMvDaDyHVIdJdrIP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4376633-fc7b-4ff1-aa95-08d8f52da73b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:10.2862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7h6p37wrCNLVhawMAgQQBsQmQTXaOI6aGB0hgX1z4/ik3G9n3T8lTQIS4DAZ+lUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
Cc: Eryk.Brol@amd.com, Harry VanZyllDeJong <hvanzyll@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry VanZyllDeJong <hvanzyll@amd.com>

[WHY]
When on the desktop freesync is not enabled,
doing a frame stretch causes the TV to display
undesired output.

[HOW]
By changing the logic so that when ever fresync
is supported the TV is notified we are in fressync
instead on a non fresync state.

Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 4287be79c11a..3f4f44b44e6a 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -543,8 +543,8 @@ static void build_vrr_infopacket_data_v1(const struct mod_vrr_params *vrr,
 		infopacket->sb[6] |= 0x02;
 
 	/* PB6 = [Bit 2 = FreeSync Active] */
-	if (vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
-			vrr->state == VRR_STATE_ACTIVE_FIXED)
+	if (vrr->state != VRR_STATE_DISABLED &&
+			vrr->state != VRR_STATE_UNSUPPORTED)
 		infopacket->sb[6] |= 0x04;
 
 	// For v1 & 2 infoframes program nominal if non-fs mode, otherwise full range
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
