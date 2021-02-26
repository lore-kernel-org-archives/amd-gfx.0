Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E93FC433E9
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38F364E38
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38F364E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1F06E456;
	Fri, 26 Feb 2021 22:37:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDFC6E454
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:37:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsALloBdkuJjp+UdLV+9HgSEgq50D1dxR4HtPliuTu4OGyzdFpl6oja/qNHnHBhT+niLY9oezrzuB5D/tt86SYyhWzDN8HNnhbf8nmwQo3i20/oS0YEoMomVTb81ms3+hPrwVOgYlgESNdC41eVn3bX5NtjBM/nOFJfhs9crUmJaYOhzkBFvYLQu3HFxdoW7OjkMtYbaUuG09xL4bc01sLopdw72otkBzN3UE7QsVMmZm3v3SgmTuAHcO581Yt+6Q92DxTF1MQzysaDYQE+UP6JpVWQDT1o47q5uDZItJWnXmeTt7ZD4JdS4NnewUDszFH8FAsSkVLoUr4TjntEsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsPriEzgWXiwtgbdktZp3KM7jPIrgzdMjdPX2I845so=;
 b=DUQV1KG0ILS//zLUVfm2PLyeCnKwDhdzTBN7MWUuj4mwpqFwCXzcqQ0NsJj6a1fncpfLO+JRPnx2fbZfimO2LrrGI4nJiTQu0UpYCtTRWrzdqCPq6gdl0Gk2Cr1jTYwoNIwzd3bo9zi7X2EZ3zE1MX+cTycBoSQaBJq8yadLWgUgSLnWIkDYCfheLIyRmMFzjSRKPDJEZqbunIy8cSmYsqb5AtyAae/XH1d+RhDIoXxDlIQRhOaLnXf5OkH5Firha0GmPsAjt00g0XKyVKQsZU10wAg04H/n2bqpaIegMpxR86ysXqlIaBtYi3AcVHc+YpatOqR6UCVshl45Bya3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsPriEzgWXiwtgbdktZp3KM7jPIrgzdMjdPX2I845so=;
 b=Lodi+QaM8daZgGGMIOryQovmDr7Y3cebfQisAUc+Pel+cP6knDH6ZOS6nK1breYfao8Tw9sjyGZ/rVxdjteKkiXTrXffOuVPFnv2rc5D6yOWhZnt9W1wBRLArrZPPjDB+q3YHJ0XqFYrwuhL691ZT7eUtIJ3+29RTTp1eKbjDi4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 22:37:51 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:37:50 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/11] drm/amd/display: [FW Promotion] Release 0.0.54
Date: Fri, 26 Feb 2021 17:37:01 -0500
Message-Id: <20210226223704.400472-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
References: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf]
X-ClientProxiedBy: BN9PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:408:fc::12) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf)
 by BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 22:37:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c82c387c-f4d7-47a9-cc00-08d8daa725f3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1883BC38DC2DDFA6D6C29692989D9@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pnsbDxVHYtfq1ir0LT0vKEi6KyGsE/WttwEvqsnVmR3bLheFj1yChSq1Pvy/olgKUTgjH5QPcAW6Wq3V85YN2fgEO49Ki/O6xJxZAMikt0Q2Ef9sks16EHfBgCiL+tDElVgWH2e3pNWwDCpqJSF9+X8A3ffQZgsEX7ojpByWpq2yFkaVougeCfNwa1biUMlpyQosdzx3cEFbCECSLuOD0F42Fh45Q+9nZII6EexUIJqDy0G+DBttILXDSt4tyzWYxavzHI8Fq4eNxpydfJIzyWme6sWIt0kNBobLm/zOpDETQLUMOnRE9Tzr/BvSg10fbUaz1ozvZktvxkQ86hpboL7MvKxS+msCgDrB9ZQNY8pqJWpIgV/CoGGQwOcCATsN8DEw0UA40/ESoB3ZTWif6qri1zcOQKFrnGHe98276MiKYu7ZgKFbhHjAl7hrI7/bHiFpGD21/OHSHDY7KkCjrREBiSy+c8tSenG2n+L5fDDC3RrlcYYSZYwTJPpumoKts2kMLy5Vx5z2AZyH+VMrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2906002)(4744005)(6916009)(2616005)(5660300002)(66946007)(316002)(16526019)(186003)(1076003)(83380400001)(36756003)(6486002)(478600001)(66556008)(52116002)(4326008)(6506007)(66476007)(6512007)(8936002)(8676002)(6666004)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Oq/tky/JRS8n80P999fX4OBHlymSygG4wzo0HYQDhwyVUe1nnwCzJfY6/yw3?=
 =?us-ascii?Q?H+/d8Lpkl6ipO52D72zXwdtQ79gCk+TY9c+E0/GJQi+eGKclOw3sTvdcL/xs?=
 =?us-ascii?Q?OQB/Tzyoq8Fvp4MYpLfa1nvKgrOrOBKXhBkjwZNabrMXw88n7DnLZ5htVG20?=
 =?us-ascii?Q?EV5C3e3TnVU77ASsoZTMXHS2TYFTJp1PiQczwOB6P81kT5OlMTdmutIvAHOf?=
 =?us-ascii?Q?MfaXiKV/2AsFOg782577BvGuOJXj/aMWvE7FeiU4IC6Stq+U0SR60iO34QLv?=
 =?us-ascii?Q?+O773wAT/0ISWrCOd+95v7iiSQFoerliD33p5wDQWlr7Ns1+YeC/wdITrN1x?=
 =?us-ascii?Q?7UITaLqF5dr4yf+YKITcLm30lZe/0G000vzlz08/n88XqP8gmymc/7kExXfM?=
 =?us-ascii?Q?knKkeBkJ71/9HmThcEVgSWhZ+A9QbKXYIYHbALdUh8Sw43Xwi3Z+hzjx++6C?=
 =?us-ascii?Q?CWwS+lrg8J06ics+tD/39bvpj8Fz1Q7lV0JK30ZwaK5DT1D47/dMyOLFHNHV?=
 =?us-ascii?Q?QKDTjm4wTzWFX0aaKbCEwXYBZQEFE8I7ymwuPfZ7LqmNfP0fmHyVusOdMzdL?=
 =?us-ascii?Q?1O4bQb3liFP64LF6V1cDvwxy5UDMp4Tb1PE0FzJY/vl9fQk4EwO/CGBASdB1?=
 =?us-ascii?Q?IcwCroam1TwhZKtyOa8VQWZheC4oZfvC6n9pXv14kkd7EW31Tq41hD1T2j6f?=
 =?us-ascii?Q?K+nIwOqJefZ38ipCHxEBP5AcJfdMx/AxBK4SNwD4rriGV88ekwW2EMkjWtqa?=
 =?us-ascii?Q?3wkVkskGGbc+taoKt3g8+peu1SpbuL2r8io21VjWhDI9mYjDtJnwJxjaK26V?=
 =?us-ascii?Q?jaY+O187NNvTvsTJZozkOrBjbf9ZxRMi47M28CFf265W7MZkY2I6kSTE+WKf?=
 =?us-ascii?Q?FWj+mNo6QXXgc3ExcmfNLCZql83lcwnK7xxS8Qt6mkgjDCGIqH97YaI6a4Ys?=
 =?us-ascii?Q?29nUAqIpnXhnSLiP4cgraIfk5snlHYdxMMZDzu0sOaGqGUr3x4xVa7BouHEU?=
 =?us-ascii?Q?kSsd/ImXZ9VzgA+AS4EupluqdXPgx3ntRUIogPDNP+hUOh/QGaNe7OQ/pgeA?=
 =?us-ascii?Q?n5l9HMNNLb4KSTMPxY3MHjcyL+EXZIeO8A6szhTw5Ynw3LpruLjlL3w4tTdM?=
 =?us-ascii?Q?uMmdKXBb4MK3o9HHvWiYvIk8VPApmix5OEIXvyxPksblyEBzn7jhffjyOGHT?=
 =?us-ascii?Q?MPWBv6LWelnP/l1Na8uL0GYk1CAWHE9J8LXhupGYUCO56ieLX6AgXe6yOi3Y?=
 =?us-ascii?Q?TcwOJbVqjaIMBSDDiKNZHFPT7cBCEMCisgaBXgfh2hA6LbSs9Kzw99IQMOY/?=
 =?us-ascii?Q?M6etm2HYMqNoi+MBCPcVlT9ac+Ndt9FLT3BoMkpcBIA3tARWCQG/6IPc0YPI?=
 =?us-ascii?Q?SchkptIjvYiFlbxYYMS506DQIw++?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82c387c-f4d7-47a9-cc00-08d8daa725f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:37:50.7621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+ZnOIwd0TPfIjA6cYW0I2tg35lTXq+dzpMhtlLxaDcQ6+R05RPxiOML9L5msCmEWa8oGl03xB+PiCU51QZXmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7100089bf7df..99356d0a048b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x3ac600697
+#define DMUB_FW_VERSION_GIT_HASH 0x22538c5e3
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 53
+#define DMUB_FW_VERSION_REVISION 54
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
