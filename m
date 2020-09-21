Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5C4C43463
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 02:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E4520665
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 02:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CqK67ydt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E4520665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC7B89B62;
	Mon, 21 Sep 2020 02:50:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0F189B62
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 02:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYYPBI69QC6D2M/5l++nmth/naagRWLQEesJCp0EPni3vv1+Lm0RaWJZs/C1BHHzxUtTKYxeATANDyFC6v8OJur724TzLRC5ZnnzM9ktzUOqn0l0BLn9atifO/LJ00gfX/wYKaJ5VOfuk3t42AiXlPT1nhT/T9gDvb9tJSDoamhIU11lTesqB5eZMLr6BSGqv8J3+tRwtV82bZn5xzubBREazk2+D/hkcAthpJzINZHlZDlD5USzjdAS2ACdQZ3KhZUZA2kHMFuIzf7N9TtnX5d9tfGVThIaFdaGNtgfBlUl6zlbHIULSgjZg9bMTpDeGN0/B+Aoc0Eq1gqT7zYQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV48tz5sph+cENfOgXDo4oHkTxq+aXx524+GLq/YQSI=;
 b=Kbn+JwgAbtobC6nhoumqmkmy4GHAwYz5Dkh4GNsq9vznV488vfktIpfvm+vmzeH7e4ybLyFVr8bKx8RO8Qh/YDNkkU52WfIVNB4CeoFiOh2lo9ZR6sdlR5EICn69HP2dxWdeW58pe9QYTYjxy84UBj//OEYwKIm+mgA6M3O4+YmorM5FcGV9orIuhtcA4xpu/Yyz3t4kyhk4q9a/Pk2zor6m0uen8cjy4oPvB/SvxoynKGZNOSep3o6oElkPZDFwILhj+JzdwDDqQgnBUezPYf9Uti11ZVsdMQumDCE0xWbVUrHt37KjNVbY5UkA+f1nk2Si2oNhZdAHf6E7L8n7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV48tz5sph+cENfOgXDo4oHkTxq+aXx524+GLq/YQSI=;
 b=CqK67ydtKHb0dg1xpM3R4wTdR+BbMTW+kTv1dkHB0t87NkSUnei8FhXhXjJHGVGNfObeSApxzvsOZlJnNk3jZNZe+HTQizRuDHbQ4Hi9fVU80QmxRm5v0Vq+wOHKSHhv4NGPzvHxymjFcg8hnIJq16ucKNZe0W0jezrGlrdGc2E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3084.namprd12.prod.outlook.com (2603:10b6:5:117::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Mon, 21 Sep 2020 02:50:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:50:13 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: decouple the watermark table setting from
 socclk/uclk dpms
Date: Mon, 21 Sep 2020 10:49:47 +0800
Message-Id: <20200921024948.15164-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0009.apcprd04.prod.outlook.com (2603:1096:203:d0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Mon, 21 Sep 2020 02:50:11 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 358d79b9-d42f-4e1b-c31a-08d85dd91002
X-MS-TrafficTypeDiagnostic: DM6PR12MB3084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30849678FBF9697713232665E43A0@DM6PR12MB3084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hn0CMBwVUdYP9Hz7aIn2it/hELF8lq+xbdbrqpjWG7/pfzj8nq627SYGJpGPOUkKFxokCIJSzalYDcz/ZfKrUyOG5KFd91OLG/wG3zLG+O0b6RtxnUBK3xpjn8z7rStN/6miwtueuRPNkDT4EyI0gV+e5xhs5DILzOWYDEFenf9tIt1k4QTGBmjYKTOA19TGW+1WKuffhuYguoYsKLJESqfeFFAsSFXGs/e7y3ZR+V01eoinmQzE+XxHnf+h5hssoFhd6Z045v9FlCv1l+xHVOLBd3bI9855F1wnDJI+cw26H25E5B4+slHeMCFKkJNi6KPKxmKIvo3pzM7qpCQbgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(66556008)(6486002)(956004)(2616005)(6666004)(4326008)(44832011)(66946007)(8676002)(8936002)(66476007)(186003)(16526019)(7696005)(1076003)(36756003)(316002)(86362001)(6916009)(83380400001)(478600001)(5660300002)(2906002)(26005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5hmnmKlbIHnq4k7D3MCjTvOehbJqjaWiXN8ceHS6oi3WBQRG/Sa+H0x7fAjyI0s2CEDxSTAKKp79PL5goN9w+rvH/X8m3XmPcr4Yz+fS6e5tqs1YdvOdwVC/XXYjJDgtCcrd102vQUEXM6VhgS12T4IwLueUBf4231dxW23kwMsVhkTYUb9KRx9mKZQdLG5zlQ8+Emd9dZaHZFyg5VAD/JGi25XhVD0imG/eKO+ylCmR/p9OpJnNPQaXufi6P1sOZqxtRTrMmUhmGI16jWh6ZBNtFMKmoNFfbmo1PMScfZxm0/hjfLFK0X1H0v1jO1G9UQpUTIUREjeX4GWP9CZQ/ILgjjRLdv4KddUBgoEwgGtcbAVPeExQvtI57jtwVLw2vlwU3Xysuze36+SBU/4dwWLgHW9gM5JAVSAfkz1g2yM/5OtswtfZ60QOsCMXI80BkeIITy3lNkrUAkfzQ9hNkBswnb9c7QLnIQoZ3eXTs28P5RfFnV7sKJXCTqhbWfGJcHUntf1yem1E8bOkWAuiMeh//wbNZ5JjrHPgGbE7QCN1FVTGmvW6Y7f8u4mX5BdBxt08TBBf14/5doa56dpJLEefFHhYc1qBG/UyPTkonnf1pNdrw+K3Pp82QeYkd1Mf12Samn9G29nFgnb2Zb8u3A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358d79b9-d42f-4e1b-c31a-08d85dd91002
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:50:13.2926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIAbAYAdGA4ZANsTmMct4G/ZpB+Og6u1eOBYMaXWmiQWFVpST7Qlh9GRjmwH/kqn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3084
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As they have no real dependence. And for Navi1x, the socclk/uclk dpms
are enabled after DAL initialization.

Change-Id: Ia66a92155aadff40e4e2e46edbedce840cfb57ca
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2b529885b05b..002bae81b856 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1831,17 +1831,16 @@ int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if (smu->disable_watermark)
+		return 0;
+
 	mutex_lock(&smu->mutex);
 
-	if (!smu->disable_watermark &&
-			smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
-			smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
-		ret = smu_set_watermarks_table(smu, clock_ranges);
+	ret = smu_set_watermarks_table(smu, clock_ranges);
 
-		if (!(smu->watermarks_bitmap & WATERMARKS_EXIST)) {
-			smu->watermarks_bitmap |= WATERMARKS_EXIST;
-			smu->watermarks_bitmap &= ~WATERMARKS_LOADED;
-		}
+	if (!(smu->watermarks_bitmap & WATERMARKS_EXIST)) {
+		smu->watermarks_bitmap |= WATERMARKS_EXIST;
+		smu->watermarks_bitmap &= ~WATERMARKS_LOADED;
 	}
 
 	mutex_unlock(&smu->mutex);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
