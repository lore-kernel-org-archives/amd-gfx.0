Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B3BC001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF5710E4B3;
	Wed,  2 Aug 2023 06:52:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4108610E4B3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQONsPECrFzKAgCvhZjo5nVkc+0hL5xlGzWyrFBDvYcDdjWFuP/9sfPIPtkBHBJokjJVcIRUZwh8szIZ6+ZkOpRE188IVXEXvTa8eCfb6eKQn9T4ZHyavBFCy6y7bSzIfEm2r0x1mb4lG/zlQFl3VGTfgWQjVQTJumXgSHIlg9ZtETZHIsed+YSfqFmVPI4TdIyUV3QLXMyCEbc6IGP6FRa+s0yBYvzhtOL0romAGuLTUPPvVl+Zugs84KP6cbfLR9NiiBlkrg3EiJjGtl3mZXaMWtXIIrAR5F8yp267F0PW3HcPI05ihUJMHtx5uu4juWk5N0Eme7IfS88xRGr+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4z4JXDjScDpJjEInlNqW6ACPbXLwwIq//Jg79v4SaA=;
 b=RpJMasdscm0ISJR6vwusO3TzUkwyFqUxLuizaRKkN2jphUsi/YhSoT4LyAw37+bEhwprol7WwWYBsLqmqj74lOtsEHjI3zHnl8UTQhs9B4JGyLcSie/j/XL7TdarQw13cuy5L6ZTFG1MfjZNI3KBoEgV8XUJX6dNBPToJNzm8+OwkcCRCXgxcPkJBdcVv56+5F4bw89H6Y7aN3NxFOe754dy3SAIlMmjiOhEfwcQNekz3aTABYvad2jjq4a9sKdC6zTdWF2VghHV49E/SpxPiPChzpIO1azvXIOVhmMe089vf0jE4rF9cYkQ/ptk6+g1KM+boQVfyfG/FEegwncrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4z4JXDjScDpJjEInlNqW6ACPbXLwwIq//Jg79v4SaA=;
 b=fF2Az9UuRhQMzuACxUbU8jJR09ZGSEX3/jo1l+n9Jg4BJyXwhOtAMx4X9BHTKmkT4b+wckOCWvzGKYSf6RcqaEDIh+j0sU7JkLPCrvqD3PMkjzzU5C0b0tpxQDRS5eiHP24BEgXUNXOPqechPNqnkxVMLQPcDcCVX/j6GyUyie0=
Received: from MW4PR03CA0163.namprd03.prod.outlook.com (2603:10b6:303:8d::18)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:52:51 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::f6) by MW4PR03CA0163.outlook.office365.com
 (2603:10b6:303:8d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:52:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:49 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:46 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/22] drm/amd/display: do not treat clip_rect size change as
 a scaling change
Date: Wed, 2 Aug 2023 14:51:22 +0800
Message-ID: <20230802065132.3129932-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d669a7-a499-441e-4952-08db93251750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFDNQCdmmS9Ygt3RUqhnm+IIsvkIJvlQXz6ylhVPttYJjYaB6d84Ci5Jby/yEEWJNhXx2DteGMrEV0pb9gE9a0XoWfv7SONyVRzEdh759dP9yxewAJsVZ9tjmPLsoHFUhBnGxVXQ2uSHnUpRldb4wn7B8Ayz5ghZ49W5f6UWs97T6JLgHFaTz6p1ykyNk/KQZ/ASpfJhV9xX3Md2muDp31l/QA+b+eS4rWt/Uco3S4UWx+MuagQqkMQq9BfFRwvCTzurMOByurhj5ZzIoqdC0YLGU+5hY249gTxGqRM9i+Z3NxRO2Ahe42w4Qw6CVpwrOmf7crMk7NWSqvwGOTC0JPOVYGBf12db+CxLG4OBhNfcgCsw+dV7aPMS665hzxVeSxqFIuLMpbmCX3M3GhJKHQxsAOdkMaD3fVIB4cVQJdqqtvpeAqzZEiQ+ZQ9ItdUA+pCEut/taAZssJ4TOLGsp68FFgrWEx3Ve+zpPjo3OEIKmPct+iIgNG/7LNrPgVBojWM4MRYz0TubvZmbSfF/5pBfOU9jncb5s+9mrYcFcYKbheMkrNTeItpQSjl0mi4DFaPvZVSqftai/y2n+gWShy/ihUF1FBh689vFvvM38Dxj5reklu9QQOulsgvyATfmlRWrI8WXKg3dwCiV4RmdHUS1kz+o9KJk8CgQUoxcktqoCm/N5uuHpyfcrodIy4cuhOLfnnG7gGbWkpNqEJStyhKOhibwY5jg4KmM0Mi6AeiCQr2BEf1oWUs9W5X4rx6HIYi71mjh5AIdpAA2xqsZ7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(336012)(40460700003)(2616005)(186003)(316002)(86362001)(478600001)(81166007)(54906003)(70586007)(70206006)(6666004)(356005)(7696005)(6916009)(4326008)(82740400003)(36756003)(41300700001)(26005)(426003)(8676002)(5660300002)(8936002)(47076005)(1076003)(2906002)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:51.5705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d669a7-a499-441e-4952-08db93251750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
With previous ODM + MPO policy we will only allocate pipes when MPO plane
has intersection with current ODM slice. With this policy we have to indicate
scaling change when plane clip is updated in case plane clip change causes
MPO plane to go in or out current ODM slice.
With new ODM + MPO policy we allocate pipe independent from plane clip size
so we no longer treat it as a scaling change. There no need to do a full update
due to clip size change anymore.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 413258db6746..8504e6ee9582 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2495,9 +2495,7 @@ static enum surface_update_type get_scaling_info_update_type(
 	if (!u->scaling_info)
 		return UPDATE_TYPE_FAST;
 
-	if (u->scaling_info->clip_rect.width != u->surface->clip_rect.width
-			|| u->scaling_info->clip_rect.height != u->surface->clip_rect.height
-			|| u->scaling_info->dst_rect.width != u->surface->dst_rect.width
+	if (u->scaling_info->dst_rect.width != u->surface->dst_rect.width
 			|| u->scaling_info->dst_rect.height != u->surface->dst_rect.height
 			|| u->scaling_info->scaling_quality.integer_scaling !=
 				u->surface->scaling_quality.integer_scaling
-- 
2.25.1

