Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0812CC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 04:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C17A6196C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 04:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C17A6196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF98B6EBA1;
	Thu, 25 Mar 2021 04:19:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BB4D6EBA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 04:19:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK/WBfNXPQz0d5HWoR5ujbzgs6wFSEv/k2iSy9f0blBqetxBnZEkp8OSXj2mh09Ba/LtL/6SuvJvhI94/urc0z/ZOT9iOfdK79+dNwTQDrZjlL9g1qr5IaehdO47G2Tdt9xKLpg/VxAvMiy7pMrygmWHeier1iJSoPEG6h1qblyewHWwripgepuTIxIKE+8FHJKQTzXpwDA63x1FfwtNTtwB8mjVKfgPeaKDnbwr+nmmwrwhnW3cfQzciGfUD1Wgo3vkwCzRNJbe3E+yORFAI/GE0b3Ll3jOZPH+aexE5eO8h4RTHMlR80RPWu5PGIJuT3+qo27tQCaWsz61chzTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnEteIxCJjx32M4et6rJeIq2POfx6MkVGux3qIZhgbY=;
 b=RTG3Mu8idSeC1/dK5pwbwXB7b9Nlj9if+stVIvEHaoVRjlFGuttMrwk6nXwvSOh7gsEslWjhaOM8KbI2bqSjZZ7/f9nkxXuX0vlniUj594fDyyrHRemsh/j216QJeWPFV7qV2BEkk6Udf/DwsR+TC3qk1R4uGsH8YHo2h1SgqqQGT70PjtocsNXIKfidIY23FXMjNsz8rBD28E4fZJfwV19T1QzZqr+0rdD4LNFMabU+aFRNrSQ+yx+9iyLNFyBzQ87yoKSLOQ9I9LbnfMKcZbfI0/boDD6QITJH3yVLZGUPBWeqAoGPsPsz7qjPtRPUEa13sMuI7O0Knyv9sPHRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnEteIxCJjx32M4et6rJeIq2POfx6MkVGux3qIZhgbY=;
 b=YvL0NEonc9XpgnQEH0oZBxrCC1lJ68ekpX3bwRNWbbvNQ8gHZ+x6uSdOcftFKcj1eXeF64KQcRBECbSohnmGNh3zPDBbMKfcSJjAqDVRd6ZJuDDsWeRTR+CnlpmvdLPw21rbm78zyLBBuphOo330A+N4sGjtXy62JFyJhqgOkac=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3771.namprd12.prod.outlook.com (2603:10b6:5:1ca::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Thu, 25 Mar 2021 04:19:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 04:19:10 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: no need to force MCLK to highest when no display
 connected
Date: Thu, 25 Mar 2021 12:18:52 +0800
Message-Id: <20210325041852.1104483-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR03CA0106.apcprd03.prod.outlook.com (2603:1096:203:b0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 04:19:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f22b7297-2cbf-45e9-3ec7-08d8ef4523b6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3771:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37713C9D5BA40EB0D8211520E4629@DM6PR12MB3771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKSSbAtLz75Tz9oR+PG/JVTSi71AVvZUIZC1yyMwDuqUsB2nhhq7Wzn2itQHRBN8x2JQf10cdiLsIdUXBAW04seI9zHkiAKV235kcXhTdnsKH8NFeocFYtW5FIF25Ut9kwofQsuVafSmDstjxxFadrf3dYGoInoNRyhLAijSMRHSdoLPMH8efudPxf3RopudhCvpZWMidvOEJhEJ4Uj3YkEPOxSCSebLwpu5teICL37wtfv4BOtV5RH1c1gn0UQL8D1tkJwZKs6mCebKAzY7ASwCt3DuB7hK1rG4WPrlKziLkhXQZd1BdeCy4Y8n/XYs8eYD2iEsco/OjhhY2Gcf3UcIZmbbmGzBhzE8peG0ggOdGp1q+4944G6nLbND6I0cDwsSE5rlA0nNIeVbYxC13Tkk/31UpjFEURQXZoSQLCgDwrxfAlqzl0zx5Nj80NV/ACJb/TXZUsSIgfM/0Yl2EwjZyt2jk0axFc4mtbHc5Om8rRaJyNDFtV+vFynbA91Kz22tWT2tREWSQTNUOFiT8hL7EJDi0QQMYNBP4TcsjB1DnqxQ3ZJ/4TbmPztb1N/8VTQ/rOfvCaLOEKq+6nd6TKZBaaTbg9P94Z7raUrdHkB5ObY0+jzNntjmv2a0T0qBX8kopmfE9sCqsq4vx4z/YGKXklPWS1MmoCziRTtwPhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(83380400001)(66946007)(4326008)(478600001)(1076003)(2906002)(6486002)(44832011)(186003)(66476007)(2616005)(66556008)(316002)(26005)(5660300002)(956004)(8676002)(16526019)(86362001)(36756003)(52116002)(7696005)(38100700001)(8936002)(6916009)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UAB5C9+Z9mdNhgNIe3fziL+wr5jFe9Y1O5a3b9lyez5zJ47QYIv4RvspbhU1?=
 =?us-ascii?Q?W6Kg1w5yyvTN9CrBmImB/BuqdfCy63VtIb0Gk7JIjaLjaLl8+K5jDPIHXbQ8?=
 =?us-ascii?Q?nvIvn36Mtp0Xoms0v3uj99y1XvG7RsBYPHlTSAU4NURTZMyC57X2LL1Tju4r?=
 =?us-ascii?Q?vPlxcZI9aPZT9a23yLPeoc8MnpI33/S9t7fmMBOU2KsoQI/EEG7BdQ+giujD?=
 =?us-ascii?Q?X0TNC+UhuSgIrZQrCPisdxTnZ6zpRWuCwP4VI30M+jlQNrqWjKILxPj1PlYM?=
 =?us-ascii?Q?eyIWoUwyB0hOZyufox1wu0GW/xBtoDb/tVOOzcEtkKaIfNjFEND9Rq1nTpGU?=
 =?us-ascii?Q?8VDreB+QQqNjzAo+c8YgpEAscntxhbe5YICT7oZE/A85tERt7EAOkF5Hx6xv?=
 =?us-ascii?Q?22IdEWNKcd1Otod5bspxGAVyhHg/Z2PjmQ3aU1iCnaVWEtrSS8kQL7eUMdqe?=
 =?us-ascii?Q?RwpeyIgjwjek9opVdMCroIepov6ZD4kk/YI1j6kOYvelJBYkQK5Rpc/2j+rb?=
 =?us-ascii?Q?0PdARtb6ZYnvPM1A20I2HRdO2fVLz/0+2eIBg9IAY7fDT//Eq+QfTuZl/QaU?=
 =?us-ascii?Q?gVnYkzmarw7tUoQkUXAps10hlwUWeDSAaoBNhjh43WmwUY6amRIXdG65phjh?=
 =?us-ascii?Q?TVQFWJaTpwjo5/ddqRA2Uc3BLHrCWyONIP6ZEIw8lBX8An55O8Qss3HZE12+?=
 =?us-ascii?Q?NcDW+ZsAkiMN11syI6iaD7mUqKHCNxh+J4ND8GBcJ/tZvl5W89QVeUNneZU5?=
 =?us-ascii?Q?vM50BbzMuzm5zHOH/BfaEiw49zaL3edlQShFA+OEuGW4W8pgeeYwLxADkTit?=
 =?us-ascii?Q?bzD1FPUIUvN0m60REZnWeWXiInwyTNEJG5pf2XYd5o+Y4kJGHxdIHzqf3ayx?=
 =?us-ascii?Q?RcQJNnbbkVA5lHa9wW/eaY9G4UxrdSapPdzLzAHKMaKPywd7XCuhP1BfL4lP?=
 =?us-ascii?Q?/kxJI1z0r6kgctwd/NAW5xLWJgJjzcw60m3uySmeJwy8qas+NtWLecOS9Hkm?=
 =?us-ascii?Q?kFPv5coYK3z9qBgDrHPcdnc5s+mLIqViXJot+gWW5rka0z9R7FAczx0Kumco?=
 =?us-ascii?Q?fjWKemJFUAgJbYSR7+yi0M9fltbFWiTROaNK8x9I7phm1tSZMSz4rPI3vhvu?=
 =?us-ascii?Q?HIKSifXC+HeRF7oC+phcAufYbBLmO1Pb7QcYolY7o7nZOGGVHtAAGOWQNKYs?=
 =?us-ascii?Q?BKQ/OG1+t8YDBQcZn2IPYn4LxKK/4E/dL8kRPlVP4wMIb1IyAMociozOuRYg?=
 =?us-ascii?Q?Qjzbsbb5Dk8JPlYkIXGtZ+OPCNOIPpQPJDNWezC9EZNqJS4/B8xUO42HQ5I2?=
 =?us-ascii?Q?bFiQ3yIkmH5IDQsdLuEuTkZ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22b7297-2cbf-45e9-3ec7-08d8ef4523b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 04:19:10.7701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mksABBUSEq6b8+qndznI8kYnkd8XAncS5B5RnkQh0Htslkhs5Z6kT5fIKUKN9h18
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the check for vblank short.

Change-Id: I0eb3a6bd95b7f6d97029772914154324c8ccd2c0
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 7edafef095a3..301b6769f007 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3330,7 +3330,8 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 
 	disable_mclk_switching_for_display = ((1 < hwmgr->display_config->num_display) &&
 						!hwmgr->display_config->multi_monitor_in_sync) ||
-						smu7_vblank_too_short(hwmgr, hwmgr->display_config->min_vblank_time);
+						(hwmgr->display_config->num_display &&
+						smu7_vblank_too_short(hwmgr, hwmgr->display_config->min_vblank_time));
 
 	disable_mclk_switching = disable_mclk_switching_for_frame_lock ||
 					 disable_mclk_switching_for_display;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
