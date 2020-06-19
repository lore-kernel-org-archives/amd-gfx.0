Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BA9C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2B2208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pWxLB+Z7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2B2208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C28A6EA6C;
	Fri, 19 Jun 2020 20:13:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B9489EB4
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJrep9n/1h7OtdRYrGaJ0w/Bs5RrqvrxFAdycyCQE5qyLetUdz+XUOSNrTE/liFa5THOg8vE6mQJxD54WEU9eix4ngZIPUv5eMIOk8oS0IEA0H7iTJ7UzZlfy5woKHUzVCddarENsIV6VnBv/0COZ2O+u11v+Rlwy3f0NMmEDYTI+ucZCeO5vk8+2ESMWUMzLFvQk4TqWslPhxLjvp5ITEfdYffaoYW/EGd2+rmKa28HjTDSB3HhhHZ3ppuwlSguv3vqI0fOA/IyqpVtbd5pFmh5UYwtZ0XBSP3NOtmtU2bCrMWjXXDKzuuCcG5n1jdfCsO0jDTlEZUUP9uBXvaFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KBwLLKuj1kpPzKpr3OisX1ztWbIElH2LkmFG61v/sE=;
 b=YOdRvI18dXEzKCaOz97aWuRzxpZDMVDKRKBYYNptt8xg4JqD3u0sTszbYl9aSHhk06N6E1MbKl16BSoX8IJojBaCOztGbq4N9xDHdiZiR2tbkUG1zF6603+wQbWAM/UjRvQTC5onm4vQpDjwmRmLFFp+tu+YMHWgz7MTciUWX1QXnCLxu+CIPM4ZYasT6tpcTJJGCg6/xwDYlxmCa4Slyywi6FIYxD0F3/tc3cGWC+rvMPBkbW7M+W3Nrd+sK0dj3iwxUNPTUy2YbYQsUeo/t4Hj/UeRcjXs2HnVcSfck0FmwJEFJbXwjeg/9yBJQpLpBiaZd6YaWUczDiHxktcTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KBwLLKuj1kpPzKpr3OisX1ztWbIElH2LkmFG61v/sE=;
 b=pWxLB+Z7T7WxEW9080Ly8REJ1hwpd6Nza08y2J5sYfxj3fVRte4MsgTK9vyBJqGPtFMZmFlwd3MpYTtRfUjEfmt6Zx2UXre3f4sryrIHHAqDUTY6pEFpZ1irKC+hLZagQWxTOv3Y6XhTkWmECCoLcEHn1M0M9iGsAG3aCOUgOGQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:07 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:07 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/30] drm/amd/display: Compare v_front_porch when checking if
 streams are synchronizable
Date: Fri, 19 Jun 2020 16:12:17 -0400
Message-Id: <20200619201222.2916504-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:04 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb73fe52-8c3e-4582-26cf-08d8148d2cef
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4087B005615477F00F397A9D98980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hquxueRKH7bV3fDVybXjncopp6NqpnkqF1rrmEhW+8veXYOyzIL+mQYy1rqfp9FevvUg9bSVy9onpnTBxI3ZcUUAk5VJo0tCOmNo24ka2YfP/dpdbGG6sqvW62/lfUDh/i0MJZhC8kqDIxx5HLnN4SB9PifmyqyPbqnFOU/TeU8vsBBGnbYVAHEoEfdaXvu+ivxTuGIK6Y/EFJi5+NIKp8RRr9g6hkd16w8AplLrtgmAjLw+vU6SHjzDvPhwmxR+QZefeUOX4b3tPHU3NXZwmrjIMvSJlBEN+3RcSW6ONKnAmpS9vSdXftgN+3G1nvMX9XWyLdT1KUYaNUNWPJx0Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Aka+EzAZsdIlAAKqKNr/pAqaidOX2PaQN7JvpaR5DxmIHouuntRjFbKY5tGM+rsJzSobh4TLcZa2WDiTPUnV/n2L23rAjU8WH3NccXoDY5md6nH/DWOf6YKALEtzeN16eBGdkDGoPu0ZasFmxtODtyWXBB9YtqoFLZmYX1R/28k9yL8VRo5zyhREJm69BjyqwztTaAsP8EosKEYhOPhVWVdNV2f/2GlqWOhcUqRk8nGfWGDk1tceJ6vEB7Ef+wVXLvPpYy+0FFaeAJ5Tb8RJR+UJTANPyXTfDuZKKmtjFVDOB5AZcKx9OosyhziWhVwZ5b5N1Mxkyz9GCzAIqP0JZQeN4T4FmNZEK58x/Q7hvomLIHuIbB+yIh+/jugwe1TIRe9Koib/FSg50ofb0R5W2+3zWQwAfnc7lquQvwOfyd3x/wC2hb6eaYMTQKXG8OvKUzaEwgA49guLGMfVhACXXUsrrp4nMvAxTaEEQ2zha+zoi/fb8wmTm1ZHX0oyoi53uvX0Fb8+pzo2HHo14LPiDA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb73fe52-8c3e-4582-26cf-08d8148d2cef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:05.2044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiUtUnGku8OKMDGElpPJykmbYuoSmUXfMimsA5mvKMM/+bStEg8aJoP5Pk4li3rNwD1M6+4AXsKQ3DJW1aZDoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: David Galiffi <David.Galiffi@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[Why]
If the front porch of the two timings differ, then there may not be
enough time while both streams are in vertical blank to perform a memory
clock change. This can hang the system.

[How]
Check the each streams timing.v_front_porch when determining if the two
streams are synchronizable.

Signed-off-by: David Galiffi <David.Galiffi@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 3d0003c69373..1000dc6daf72 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -399,6 +399,10 @@ bool resource_are_streams_timing_synchronizable(
 				!= stream2->timing.v_addressable)
 		return false;
 
+	if (stream1->timing.v_front_porch
+				!= stream2->timing.v_front_porch)
+		return false;
+
 	if (stream1->timing.pix_clk_100hz
 				!= stream2->timing.pix_clk_100hz)
 		return false;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
