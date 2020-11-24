Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A6C63777
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 15:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC85206FA
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 15:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wq+3D4nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC85206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FCBA6E427;
	Tue, 24 Nov 2020 15:55:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ADCC6E418
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 15:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZsmQaG/vcy7LsHxQVREXDVuKekr6b/wprHZUXSgSJ3NSme5cC4kv6ftzwhHdmyNeVUtT1kJmYXVRnpo2DqDPR04wQsDsZ/kSsQuLK6F+//xS6bLOGN3S8ZTEXT4Qwf+FUaqDPrldC9Od7AQI6c2O2KUFrjxOLdcN9yHXGPVMUd29aeTHby36xHx4/niz3y3tkBaC6fVdAZBGcDQJDRv6Hd2pf78tQtjmgMLiE3FhLjuBWCqAmllKTTm8H3bJBjfT/gwYu4tGGbDzGJUeLZTR7pcNREmd5TXH4BMxsRL1qA7Ix1a8nQZUbP/ceWgXwetrQEWQRKdQVOA5LaUBtfk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03OkGKNKFDwL7vWJ/Fi14G3UJil7TzvzDEIpggZ/+8E=;
 b=W4rXHtBINBclqg3HpGA2e9CcNCr5BBG4VnvaWX0PHbqpObrs5/PMaSpjyCZNAnTSq1u/iBTW6zXARhC3KlqqZEumxt4uPDtP38wXXWBGDViQ2y+rDTFlgrIJCTDBWIfUgltO0We1e04xjPAV/X5k4DnVMpq1GqPNtAPuXcH+XXRi2peYxaEGtRHLhk2LXF+7bakxdNOxZocxDzLkkDx3jl31urv4jjj5upLVCmC6CeJR5/38la5NjCULulj0PBTqMMdqzH2oZfAfAuX4+Xk1fgdEE8GVAtSvbYaKfQy+hDDeJQVvmlOZ4iqpEcxRB71Dxp8Mxvs45lTiAdD2lZgqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03OkGKNKFDwL7vWJ/Fi14G3UJil7TzvzDEIpggZ/+8E=;
 b=wq+3D4nbkB4fK9m9qGumzxM097ZYdAmZ+yuQis/SGWJDQzGr7xf4N0sayaCtzXsmRxxxj7pPg218bLqebDvmlLPxxBoYli+Y9U4rEsxNCOJf0GJdeZu9EIeaDPEEneS45gsDDCI+SbvvTMbjqf8sSLubCYOcSd+3T4nEUJBzy74=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 by MN2PR12MB3070.namprd12.prod.outlook.com (2603:10b6:208:c1::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Tue, 24 Nov
 2020 15:55:32 +0000
Received: from MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::7ccd:6ebf:40e7:7039]) by MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::7ccd:6ebf:40e7:7039%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 15:55:32 +0000
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: nicholas.kazlauskas@amd.com, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Extends Tune min clk for MPO for RV
Date: Tue, 24 Nov 2020 21:25:08 +0530
Message-Id: <20201124155508.2096060-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::20) To MN2PR12MB3117.namprd12.prod.outlook.com
 (2603:10b6:208:d1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL.amd.com (165.204.156.251) by
 MA1PR01CA0126.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 15:55:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17a7fbe0-c5a0-4b07-21fd-08d890915f4e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB30702B550FB64F2625CB65D980FB0@MN2PR12MB3070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lebDoasGJ7dIjj5sNDPONK2h/w/76+wn6JSurWJGRU/Ob9x5Ry5vSYhM9Ik+Vg/IwgakaLH2j9ESqUkYz6KEzkKGSG+8KKqlVbx/RkiL5pyuu4ZArcgD1xiMdqfNcXl/QZYDD0MYaVQi32WiU1pFmvvfCd9oJJqU9jrwdMQfdYXJTkX4TCgN2pLp9wW8xuQJ7hAKcmFr38x9qTgILQc7/lrZTXi/X+DtFeDr6hBwiLU+FoHulh5tW55ZUjanf3Th4YxNxZKFzRP+cdPh5gAHbYYs6o0TqW9iOmtzDwxWNwhvuXFZfxEbK6aU7HPOm7ULS9DL11QNYFTCRV+4g+pGTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3117.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(66556008)(66946007)(5660300002)(52116002)(66476007)(186003)(7696005)(8676002)(2616005)(6666004)(16526019)(6486002)(36756003)(1076003)(8936002)(956004)(86362001)(26005)(316002)(4326008)(478600001)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ytRDCuni1f1iTOzcZzX2nhmjzg5pqlyqmWa+8DcJ+le5XQy16EOJv7wSlquU?=
 =?us-ascii?Q?sHuwMrkGhkvMIoJ3GFSGJnjWJr8Au151IBIVNBhiq1BCoBLT69J50+0vHSvW?=
 =?us-ascii?Q?V9YNlUKdyWCAqm49DiTjdBjcqA1VXpTUgBP0ZCqHhsHlSgDrO0PmvUZcPH/d?=
 =?us-ascii?Q?n/hkIVHyO2fnVh7k4IyoQkYOXiz++AGO1/HKcKOZfrTXBhRlQLYLEgr6LPDN?=
 =?us-ascii?Q?YcBnECXjHWgmmWrtY4BKTDrXLN8/Ue4fDg5easOcuQ6qyeWyNryYsymuosLy?=
 =?us-ascii?Q?rzsVZ+46NHFZxObc8ZLzN/qDJ1h7k3bXc2LXihhszmXt3DVPzp+6RMZ4X2OZ?=
 =?us-ascii?Q?6Dy38qRViPkVgK2SlZWlJhj5GTJrtAlKyMwMwjonahsj9G1+GCZuktpnDnD3?=
 =?us-ascii?Q?Y9/HbicIc7e2ANspjwmpKnOr7yJ2k0Z69JSNVaSzmzuhaIdwuYf2yNh1OhB3?=
 =?us-ascii?Q?R+VP6gWp40O8vw24CnRB49eC9UjjUyiQKTe6mTpJWO8PXqa/WsDylbx3axlJ?=
 =?us-ascii?Q?aXgoMa1lS1wWP7/5Zsb8MKVTYR7jw8NeA1IMAbl7gtx3fzNmJUXLxx8BBkuW?=
 =?us-ascii?Q?JuXDeou5npnTd5SMv9IKdPNEqaXbbN9LdGUEKxxlqnkyls38R62aWjBbAXKo?=
 =?us-ascii?Q?H+j+zDxzh31IAprfndp3yKUS42xhYOHEUkwsDqexRelzYvKAuyO9AxeWJnIB?=
 =?us-ascii?Q?Vlyk1uEfFC0/snYie8DzmwUKEhf4UsoaDft43DCRPILkbJlwAN0wjKrQ7rVQ?=
 =?us-ascii?Q?criad/HEWPFz6QCLmxvMjYi+cRWIiZvr0pNhhLsb8i5KZDPC5Vz2xtVJiLzQ?=
 =?us-ascii?Q?uIRIj7FGBSX1FCEbpYNBOc9E2QnosS7tAZrzE2P/XElzt1H12zbAJ3nQop6l?=
 =?us-ascii?Q?Bo0Oi2QhvYEBsYIUDOoScclu97MeJ2ALSE+GGW7qEnVV4604gpP7nV8ZpeL2?=
 =?us-ascii?Q?Fb15ikNVUvyPE+gndsRTf2DF4LqZTfk0S7un6WfNsaAaldDjFd6nc/ZedleX?=
 =?us-ascii?Q?w3ty?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a7fbe0-c5a0-4b07-21fd-08d890915f4e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3117.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 15:55:32.0946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojpqeX82YB5N9XnBW21wdqcG9Vi4E8OWyPksAb6bO83goHZjfT6ov9RVfKaY6JUjDbDdOCwTdXpooxUgOyTkqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3070
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Changes in video resolution during playback cause
dispclk to ramp higher but sets incompatile fclk
and dcfclk values for MPO.

[How]
Check for MPO and set proper min clk values
for this case also. This was missed during previous
patch.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 75b8240ed059..ed087a9e73bb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -275,9 +275,22 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (pp_smu->set_hard_min_fclk_by_freq &&
 				pp_smu->set_hard_min_dcfclk_by_freq &&
 				pp_smu->set_min_deep_sleep_dcfclk) {
-			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
-			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
-			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, (new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
+			// Only increase clocks when display is active and MPO is enabled
+			if (display_count && is_mpo_enabled(context)) {
+				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
+						((new_clocks->fclk_khz / 1000) *  101) / 100);
+				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
+						((new_clocks->dcfclk_khz / 1000) * 101) / 100);
+				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
+						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
+			} else {
+				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
+						new_clocks->fclk_khz / 1000);
+				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
+						new_clocks->dcfclk_khz / 1000);
+				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
+						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
+			}
 		}
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
