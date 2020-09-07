Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB50AC433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 09:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8217F2145D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 09:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LkFCbjTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8217F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30D406E406;
	Mon,  7 Sep 2020 09:02:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611E46E406
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 09:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBt3uizvMkuzZBuqHsm17+qLm6foAcaVtax8FjvUGMc/yrRQKjXTLmm49uFJ38t1oWwstoa9N5ckhYIhSDTjxQdYQ1Ncc0MPAwIQq2g6DsZwsBcRmIz61eyfphGi4qfj5PHbTmvHqFwbL0s8N5xJ2tYXgDr5EOzBOKK2ZUvlIyOO54Wv22rnXlXTy8c9uvRXY0Z6UHOJNnI30ebqJzMjgXR8zEAIB+0B2eA7WkqpakIL/KOGxZvtoDswRj8/a7H86MX1gGzgYaAdalM+nDrbAEqWXzOqJ94Hk5jm6Kt4EcxDRFYqevLZec+N7byrdDPUW/YyV46OYuUGEbW0Mc2Hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y6lU2W6xgHLGWiZ4xuZaNzBKfrDPl++KkQEKQyq840=;
 b=CVcR9jd3ruX3zNevnVXvOGixYcvnjPqYx3TIhXKu/bNKHZWblWGI901zjbOtwFf5TH4tXkg86mEXCN3G4X/OSygvTe0rtB6Jei+RrJdiim5v7ubpkxwP7q5m2yYeSG68kKR0LRP/XzMrtzuhq0tiM6jOj7NYheQ3JpFEOT4dPYtmjXIZ/EWD9fZwTTZK/firaZgaAjM+lZqjclDDy1fxk5gu69Ei6/uuFkkheqZjVruVC6KmGOpSiiH0nuaqKNH5zyXO5jD++shBlyS/u+pz0HfX28dfNxqut7q+D2uAK7BBLd+57ngwo+dTvJ0v5jr+LA4g7U1L9jAjZyoo6ILi4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y6lU2W6xgHLGWiZ4xuZaNzBKfrDPl++KkQEKQyq840=;
 b=LkFCbjTLO5KgOLshqcthwwrl35HYfQPTv4I5aEEV+iE+IPhjCmwzOcOjwzvceIR8fUdQqIyNOOHXEn9bmYaPqy1K6E6L5TFg1ppXFjNuCWXUPjfQkFpyjnQJre7SUXrX5E7+ikiX5THU81C4DoflW2XCqI/u0zLEQmCSZhoZrqA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0026.namprd12.prod.outlook.com (2603:10b6:4:52::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Mon, 7 Sep 2020 09:02:07 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 09:02:07 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amd/pm: add Raven2 watermak WmType setting
Date: Mon,  7 Sep 2020 17:01:26 +0800
Message-Id: <20200907090126.2542-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907090126.2542-1-evan.quan@amd.com>
References: <20200907090126.2542-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0155.apcprd02.prod.outlook.com (2603:1096:201:1f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 09:02:05 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d083e39c-8bc9-4a35-ba83-08d8530cb26f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0026:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB002654DC4839A8B8F26CFB53E4280@DM5PR1201MB0026.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkENE/xOIbJ26woFFDzaQaBY07Gy5/ztm6Y6lLi3rxtXJsa+yEs1e2gbaES7Ih5pm1y14n8NhNBINkFgMsrD8+bYF0s/OV1mbyBIrQQ8B9Mh64+e3ubQnEUChd4ZemKf8v1fWJpQ28hZaO8ESgivG9WoESzfNeA2MVc6N1jckvuuDe9JKZ4BT3g1xd7umgEtwqz73NPjlMAI8RzVjUZjg/SNwBSehXvuVjdSv0tRX0l3fzI87Fk8fQ3iTee1FY56iNsJm/CWJZ8Gcna/7Qpf99Kd3e17uZIjcv6QdmmfuNDYpSeBi2h+WLQWMHMAkA2jLROpGXTTnZwAEY5WY/36uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(6029001)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(6666004)(186003)(16526019)(6486002)(26005)(2906002)(6916009)(7696005)(4326008)(36756003)(66476007)(66556008)(8676002)(316002)(66946007)(8936002)(52116002)(54906003)(83380400001)(2616005)(1076003)(956004)(5660300002)(86362001)(478600001)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NyHSEynkbJR8EP3bg81i65Avma21/BlZhV2m81+rAqnZQjlLFdOilcx1/Zkrhl0KuNhAlx5WAhXfx3QA6pD+FL+/Q1Rb2UJGPWgvkJVcLsC7MDlPeY/NKKK2WxET4e+U7gUdilDRSH2uGN/sZtK7wp0ObgFber0mQCx9mrNXAMHusMnbuENc/AeF8sLk6VOsnZ8jMq2v2oZ3EXURSGeafOCgWNo7L/s4K81WYUF7UPj7nc7u9GTBkVPpgHOGrewG2I5FnGIvP0e0tUs67QLgI1dRKvLgZEzVPugHVSVFTYhgwti0X/XeCe8nOWFxWzmaSRNXKviY/KVhkcFZJkDgF7YMbRQr9IuKwTcBvzI6R9o0SNruXKXmSTOSWxpjtn4a6hchlILve84ccv0R+nsax2Z03WrpfM+xbhHAOyZW2sfOYBZanw8usDUui8hOrBMac7RNhe1l6VpSdled3TdzgU6512DBrJqVPzfnH8yL0P+oOYTHZf6Uknz+D8SRE2gfUYw8dauOaSZD8sdvgE228XWhHevxIw1YSCNcBGOpdmh+VBz3OOgp61kAnEJ1xvwjU1nhEaE+Pa1UtRdH4/PPo9W+gWNWIfVV6fmalm0Wd8S1Ur56ltIQh91OENTU7n+gx4xvmxLr00tf7Cx8xbsLiw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d083e39c-8bc9-4a35-ba83-08d8530cb26f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 09:02:07.2863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTL8n5QkVTcskSO6U6be3OtZvVzcNv9MIxM+V4GaN/cB1dyVTd4VwuI93zuKgJW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0026
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, Evan Quan <evan.quan@amd.com>,
 Changfeng Zhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Which tells it's a nomral pstate change or memory retraining.

Change-Id: If55d6c3f1dfc28005c6d767154664feddcda6f5b
Signed-off-by: Evan Quan <evan.quan@amd.com>
Tested-by: Changfeng Zhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h         |  3 ++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h b/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
index dea8fe93da63..c498158771cc 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
@@ -54,7 +54,8 @@ typedef struct {
 	uint16_t MaxMclk;
 
 	uint8_t  WmSetting;
-	uint8_t  Padding[3];
+	uint8_t  WmType;
+	uint8_t  Padding[2];
 } WatermarkRowGeneric_t;
 
 #define NUM_WM_RANGES 4
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 9ee8cf8267c8..88792dba1759 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1181,8 +1181,19 @@ static int smu10_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwmgr,
 	struct smu10_hwmgr *data = hwmgr->backend;
 	struct dm_pp_wm_sets_with_clock_ranges_soc15 *wm_with_clock_ranges = clock_ranges;
 	Watermarks_t *table = &(data->water_marks_table);
+	struct amdgpu_device *adev = hwmgr->adev;
+	int i;
 
 	smu_set_watermarks_for_clocks_ranges(table,wm_with_clock_ranges);
+
+	if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
+		for (i = 0; i < NUM_WM_RANGES; i++)
+			table->WatermarkRow[WM_DCFCLK][i].WmType = (uint8_t)0;
+
+		for (i = 0; i < NUM_WM_RANGES; i++)
+			table->WatermarkRow[WM_SOCCLK][i].WmType = (uint8_t)0;
+	}
+
 	smum_smc_table_manager(hwmgr, (uint8_t *)table, (uint16_t)SMU10_WMTABLE, false);
 	data->water_marks_exist = true;
 	return 0;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
