Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9656C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 03:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFF2611B0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 03:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFF2611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF6F6E9EB;
	Thu,  8 Apr 2021 03:42:31 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760071.outbound.protection.outlook.com [40.107.76.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DE96E9FD
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 03:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czruyh1IrpIr8BGnG/OioyiPM+Ob0RJZptnjX+Q5HpSdPKgYhS2LqC+tVR1rH+nKf5RZN0LJciOzgjamMeMKv1uW0kKOwcvfTKESLnOp97QKlW9vlOn5BbFGzWISDl0CUtylhT5KPoO2XeLEELX12q/XmVWur6y3t0srFYLfwSaW3nySXH/NAOFzOkwJprsQ/WszsorWvGI2wAFMVe3FLvlzBcit8ud2hmS8+hsMvgoa39QTPMkMZNaWUlkwALWm3Y0m+YM14PsesnnGUS1KB7AQ5AT80aqGV2tgJEDaKqWauNYKcJsE6KJmcA97s+BZp+c8wE9YlW1xCJPDNkh7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t889GqSwf6qoBhDiphJOFpt1e859PNq62UpFvnr+pHQ=;
 b=oBU/91U07xvdZi/R+nDQG4zYHB5Sgg1PIrcvCefMft+ziQzeajLzhCgEhASgXb9MCvzImSpbaGomwXfzYEa62U9BsQWmTN/HIswI2CNEvGJdXGvXi53sqwKU1h+tdf2C25GPLMUwTx/rGdDxoWuOaW5lSZ2EbtBsEldbQws17UwvGQyxCucBybOd2xv2WCLOQPgGnUF+pVe7qhmhqX25JA4uh4wKJCsIVJ1lGyuzJtu3w9dRAKVRV0l8nz2fKViMvZv5P2Q7VtIgRyER2W325rl8jV4LZc7fn7kxPwxcqnHoNdjAL9chrFjg/l6kvGmAtBFceepa+00TSB84zx706g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t889GqSwf6qoBhDiphJOFpt1e859PNq62UpFvnr+pHQ=;
 b=A1v/r4BKjWtqL6jwuMPK4XItA4xA9NQMUC1LaDU/d529lcTGBwEyuJdTnPQVAnnnJ0mpjw+OaJlsIOuHvIH5tNPvm0WPpKBP2RwBvjMtVB5NaxsIWW8ia6tS52nq1dzldqBnDt5DGRUptJSivokbY6ghsiMM/a4eSmQDqisyZco=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1140.namprd12.prod.outlook.com (2603:10b6:404:19::14)
 by BN6PR1201MB0100.namprd12.prod.outlook.com (2603:10b6:405:59::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 03:42:27 +0000
Received: from BN6PR12MB1140.namprd12.prod.outlook.com
 ([fe80::ed12:8b0c:4402:1a3]) by BN6PR12MB1140.namprd12.prod.outlook.com
 ([fe80::ed12:8b0c:4402:1a3%4]) with mapi id 15.20.4020.016; Thu, 8 Apr 2021
 03:42:27 +0000
From: charles sun <charles.sun@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [0001-increase-time-out-2s-send-msg-to-smu.patch] drm/amd/pm:
 increase time out value when sending msg to SMU
Date: Thu,  8 Apr 2021 11:42:06 +0800
Message-Id: <20210408034206.960849-1-charles.sun@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0167.apcprd02.prod.outlook.com
 (2603:1096:201:1f::27) To BN6PR12MB1140.namprd12.prod.outlook.com
 (2603:10b6:404:19::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from cs-Flute.amd.com (180.167.199.189) by
 HK2PR02CA0167.apcprd02.prod.outlook.com (2603:1096:201:1f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 03:42:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7d1976a-8147-4c64-51cc-08d8fa40542b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0100:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01001BE58416F1738563E8D7F9749@BN6PR1201MB0100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5D29NwVsSSS24gAAMYeu6q2TaDoksGLlyTTsgNvwEYuTip01nIcPweaWCZKwIMiAp7QQQQlHlrIo4O2UdEeD7AoKEwaD/BWNpelkGgvuJtbAkk91lubeGes2fej8wpg+dOhjKRS0VesCOHz8kOdyhKekYbHHidZZj0nsmkh1do8QL7NDNBCrOWpdb4jHV/rAjaE209oAkmTTV5Vs5v7FCCNOVg8g+9OAs9KIRq3g5ztMxFV8NJx+ck878ZphDsKCiPtm0cwn9IoO7amIiI7G+Cof6Y/JHdcYj17amCQFvl/jQfcgvSbMKWtl3dloNEFLoWQ34R7YgTZjsWxxMVzyBEyXS2HevNPJGfWPAYUFqSke5GtK6sDaZMjPIMYeFddz494Z60eHqZjJlkyQOVOFJIQ04G7E9E0voyqnPIPqnTBVwLfWMdJdQ9GifxPXYgkc2ax+OoqGITAE5K4aOWg1VoT3DXENaQrMnnwJ4TcZLX7k+YUAKhJuPcscU4yZYkX81cQ0PUHt95VTDpyQBtVRrZgZLp6COV1UK3gMn7a+b5Zu9YO9hthg/5ioHsKXKt13BOIzgQ+dIp6KTCJ7lX5IN3lRNu9rXPRS12tOROXstB5rVnOPIJoViJZ1Gkw+4/fq82JSVjyx+TdF56lq1xiJD49hib2p2RRMV6uaYKm9gSZcAbW1JosYxV08YuQ6Fwl+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1140.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(16526019)(2906002)(26005)(316002)(6486002)(6666004)(186003)(8676002)(6916009)(52116002)(7696005)(66556008)(8936002)(66476007)(1076003)(956004)(2616005)(4326008)(5660300002)(478600001)(36756003)(66946007)(83380400001)(38100700001)(38350700001)(86362001)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qvdG+DyC5LqLtnMhAXOet2uapk23FeUT4gKCOSllfCFgcXs+Xl3a5GKrDrXN?=
 =?us-ascii?Q?c16CLyxwO9oUnNND9e7/OeB1GlKZMuVumpp8RedK0z+eZoW8zIBRcclkPXUP?=
 =?us-ascii?Q?seF3C79PyIvloXqE5HNUdJH0f8WNwqzN7Vb7h1YXYVh/gTyt8vftbajINmhY?=
 =?us-ascii?Q?ll6sywT2ICbDtKn1WHhSNQcZ0S7YIh19B/O0Gd4chDIBCGJTvZA4t/c0Nw7b?=
 =?us-ascii?Q?QpYJKkhvjXWE6j6X2t0NWy+iQpwicKNXp2tgdsqwMC7BvkHnpMPUM16SPys+?=
 =?us-ascii?Q?4Fh7StOhb2EkU2dlcVY3TZ3u3eD5zZlJNgqVjKAe4ChxyXETKX4vyWTaCD2w?=
 =?us-ascii?Q?vN0FbWRpREaFzhw0pta7LE2PkJnVzMP4kghG/5RI8PFy0ar+aJiV9eqQ95Gd?=
 =?us-ascii?Q?hflnCMdU5VvqEOnTp8qjgn6+9IS/hRHtE1xHSrdNEX7vgKafXd0XE4XdxYl/?=
 =?us-ascii?Q?s4svRMqiC6Lz3QxVEgu1w7qT+/I8ANU3JQAjDJMtdp3cBCnZC6v2S1mHyvUn?=
 =?us-ascii?Q?3nuqdU7I6nUTvXaFP8ivKadxf2OdM5aEsmxOoZlHJ2kXxE5vMtVr7uIty+nq?=
 =?us-ascii?Q?Rg2a0vDzFFBtZyoUVug6OuieZ9cEmAg56dxMsAlqsmEVarxAKazccv55WJfC?=
 =?us-ascii?Q?yiKIlKi/MQsnwM1lDIxRtKsK5KiNqK3wHVOjCRDfudJh+dIGvlkHiMzKsQQm?=
 =?us-ascii?Q?lDmPVk7gk+IyXHpytuUS/YHz5K8Ot+GHKoGzBL2eOt+/FZGoUJl+1I6SeX7i?=
 =?us-ascii?Q?hXi1f7U/G6lPgyFPUXKwlbXYBd+OjCe5d0P8kIam8Kwvlk3F94RlfToLJC1x?=
 =?us-ascii?Q?dNGC3pDNiKkiZexXOM4czL2qJcmubynsxBpAevY2D5+78zrnu1ZbYcrgRd0/?=
 =?us-ascii?Q?1G9zkO9r13bYusHrf8Kw3IcSxd/sceeSuIw9LV2tXKLCt2q6uWdERPXjdaof?=
 =?us-ascii?Q?LMb3h30nChUe4yIpoQpQRZTq5fKwNlI+b0+NdXFqmer06z9oxqhjhwczOenf?=
 =?us-ascii?Q?UNkAxzjV3xWdggfAcroel3pZqDGT40I7R15Eif08ueavF8xDtixsa/EmesQw?=
 =?us-ascii?Q?bHrJTQTNAAp13VdPnO+zdeVxGeD3Vwzvcm1pmpz4k9iK52Rh8vWemEfotSgl?=
 =?us-ascii?Q?WXS8+5epg58fs/iyc/JK+ydsUyX9e7/Zsa6Ck0lciIHRXxlEmtHCRRtjyfJv?=
 =?us-ascii?Q?2NDY2gU1unCHjp3odfd98r79hytlOSmmjOgXPz0EFuRs9AJcXGsz1SVLpohH?=
 =?us-ascii?Q?tVRxTYF0UG8WWy6zsgRzjw2MjFdwfHxrtHNAEogr7oUCoNsxSMqQZYicvJrM?=
 =?us-ascii?Q?XTYS6qbliu8Pef6183+e249+AmBAm58Rm7Cy2sonLBwvLw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d1976a-8147-4c64-51cc-08d8fa40542b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 03:42:27.3629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fm/L8nrwvziEPaeLWM4v/tQEVhjRiB5jBPGF6ItqEcoG4EnmrqFJrNhK+RpljT1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0100
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
Cc: Alexander.Deucher@amd.com, Jinzhou.Su@amd.com, Zhan.Liu@amd.com,
 charles sun <charles.sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

when do S3 stress, low rate that PowerUpVcn message will get response
more than 1s, so here increase the timeout to 2s

Signed-off-by: Sun, Charles Charles.Sun@amd.com
Acked-by: Deucher, Alexander Alexander.Deucher@amd.com
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index b725f263092b..dc7d2e71aa6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -79,7 +79,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t cur_value, i, timeout = adev->usec_timeout * 10;
+	uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
 
 	for (i = 0; i < timeout; i++) {
 		cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
