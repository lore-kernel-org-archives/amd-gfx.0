Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE4C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6AC64DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6AC64DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BED89E14;
	Mon, 15 Mar 2021 11:23:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5417D89E1D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPRBmD3++YfzR2yEWx4aIUaY7ywpghkS1ih8SZf66tU6VuRcwcnmPiNtr+iqxFQsEXNg6k6TchDlUNNt1NJsU5etRvSQODLRlxMEyuoZVOE/Kp0f0HsP1jAQSOT0VQ+C8LIABDoY/e+kLnE4HSGBVxMgQBmI97coJN+Iz6ywMxMfBSgt8Wy3Q0hOm3CyjJsB3f2IyX10+Uc9kZTVZ63az4hzJHU0IyCEYAZiSojf5HvSQrUNZndXnXr9A/NTlKwr3Lf70++Q9eEAwZls/m2Sw01wl2NK98O/WsfMqnI8twalia0MSSk5gm6YRWh7OPwzdjREqhulxc+oFA91NL2q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oajkUS7VhlH73ztG5i5eqO1/Cs0s+Tkbroval4JshYI=;
 b=ADbFfpQYprTtB6INcmGX4v8KJ9q6L16lasRaG6QU/aDvIJ5/xLYOSMQPFjfGBfGS15eC2eUUUV9jsPwbXzFNsVdckTN+4sL2zIjTU9aQFYnzBQpQJoPvUJgZGwj9XRBs1FRjxi+I9JU0o1MLpVOln272QzRcNSBQpLS6ii+JUOlShvXgXk+hR8p2tA8xW0nujIwleYvvRiNdWfJT6YCxL2y/5e8Eq5YqVXraBeGkwU3xgvWlGqIkBdwWavmqpvTNXN0L5WFODN6sWrUOn+I2ViPiLSw4kptUXl5T6Y50JpyTFnchcyPPgAmY45EwM8sXwfCPo8aVDL5Lxw880pFC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oajkUS7VhlH73ztG5i5eqO1/Cs0s+Tkbroval4JshYI=;
 b=poCon56CSOJmIGkUfZLTlfEhx0BFLrjVK64bQFPbLk6zwx9PFvJDAPabsg82Id/3fowLp/+Iz4BFymoBl0881BL2I5TaGflqd5TIvV8uIwv3K1UCVBGErL5r1GDHuzCyGeoAeJM9ysEKEEDxjxqKd4P62oFp3Q3/apNCG4pODvo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:38 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:38 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/23] drm/amd/display: 3.2.127
Date: Mon, 15 Mar 2021 09:40:06 +0800
Message-Id: <20210315014010.16238-20-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8537ae06-b97e-464e-d0b0-08d8e7a4c761
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB461724D4187986A6F6EA04D6976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsNzCRj2kGhuZ8ytprZB7+Gcu+eOw6xq3oAmF23ChvUUc0KXcl33Xw7w+sfOfopdAz5C++jIAMfr0AtWYcGFyliaKE4wV8sdYjsXEPSinw0PuTp6J2Y9KCooM9Dv/Nq9tSJeUZ+371MtcO6nPAXe2JhXWLKXFA7NZLgH8gIXkAlWVEhAQaldBNRvi7nYI/ipf9z6LLcDq7Wail6TUbyuVQpJW2lfgn+q+coZxKZG0a+FFqWk8hWdSGQujA6o/UPK7QPydR76p0swyIDJIwmb9Een/qHto6SI/Vi5S61LM+4bO1K/8vCqX+1JUavH1QFLtiUxQtneqMAwxQTHyvaItDN+cYAL7XYl7aXifTOfWKPdzPZHt5k1HTLYidT3Snu8CLkOcojeN6MRHpq6WDxO0qa3whVwlGJ4sRD2qkqNC50oz4UPLt0nPqdSKaRJweUvtEoWR+bjklHCXSUbcXJFeUuYD4FH5sOaP2vFMR89YZdMc0DujTXE7offGBllSj0vLg6/tHfXaVdc7CPil5G5AvSuizYQUZjpcHikKtnS6LR7SuwSay3In60l0v93y6Fd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(8936002)(52116002)(4744005)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L4sOQ6PuOhmGODsu7bGCejxAlYJNyulfi4estIfFscBBl9zRDEJYoeFzE227?=
 =?us-ascii?Q?NrNzEVPIOuWkMdY0x2nKbQpi+47NAKkiWKiYpra9/QJrrsvV/JOF1scBTFWI?=
 =?us-ascii?Q?Uj9gzdysuzMnSWhn1hjr7IFKPAsx+2focEkRfPpmUifJlSiHzQe50KHrrTzk?=
 =?us-ascii?Q?Q46WvzwaSOabN+BRCxlTb0oxNLz0hzrSLuiHqhDZyAOSgfIkYQhMbF5v4nur?=
 =?us-ascii?Q?kJ90Rq3kNKdfyRUb56iGdDqF2vlgW1Q0z4wN7vHc+rNbxTI5Ssutt0NLWCgB?=
 =?us-ascii?Q?A8tYpAq9lEekHBGd49yRRJ2LSRP/LxgCwvCOqv6mMXXMojHmbcGM7V9jMI3P?=
 =?us-ascii?Q?72b8n65trfmz2ANfSaHxWp0RhT+X6+mm0gzPx8MXLroJVqAIBY9pLFNuMlVJ?=
 =?us-ascii?Q?p/cBPJBn4F+UiH3YV0MdCvdgpDKOEp38OzWGStOoPPUVSOq0j7K/08v4+cQt?=
 =?us-ascii?Q?/jl3wgZV4SKgGTE81Epgw0YvMZb4RzXSr1nlpAOQZeGSSP8fdJoYcyTq+PqO?=
 =?us-ascii?Q?DW4QlbUEVTCkkruU3hegXmBTU4s7ey6+oh5O+gYpQOa0TLau1YLOJfUdlf+S?=
 =?us-ascii?Q?e/qRjYkxA/yJ9L5cE4bAauJLF5naLhauadUHAV3hF6VInHfuVW/1LBh4CmZc?=
 =?us-ascii?Q?6kCNijL5N3AxU3QK9JyXbjJsqDDMsimjvRG+FmkA+LcQy1/axMhvJCB1aABT?=
 =?us-ascii?Q?lJaYLpJb6AoQTOcvl8Dnxhd2/+SKLKwU+1lVd5BIJF0lZ4Qy6ft3I9gRN6ss?=
 =?us-ascii?Q?aqFq5veV8t24gy+Z8JIJX4kazJhq8/MPgKS3z51JH+mOOAFyo7HPJ8UCtp/h?=
 =?us-ascii?Q?/JSmP9/p6sAEniiiRatkCakJI3mm+qsJ2B0U1nHidJyDBZmJafKaY/81lc3c?=
 =?us-ascii?Q?yBi6deSx6nRt9ykBe57R5F61Na5qXQc0iE+zPuoaDmr5agQ4JfWX/Jf0A+1L?=
 =?us-ascii?Q?07YifaTs6cS6G+T0AbhzE09ApAuY6XiSmZhobKak8w3cNxxUOYJV3sSmDb07?=
 =?us-ascii?Q?mWT01vmS0U9QgxYoi23uEtazVDAgnVtuoLsgR9lxEFNZHBKGa3oim3MNIAOz?=
 =?us-ascii?Q?kgmdEixS5pthKDacA5AjrUS6/9yB7OIJo72/m0MrYpK6kQ182ZDNu7taHMtG?=
 =?us-ascii?Q?z2SJ4h5kwtIf3DqSSGNQwGvA82F7c6SxvZZydueOcNhM0fFm4lPTCqOs/IgP?=
 =?us-ascii?Q?0KlJ9yA6XPfor/ThDOGvo+mCfYDXdASYVM05mgA4K7ZrNgT/oNAOV18gPwow?=
 =?us-ascii?Q?Ig3X5SlXsQeggeoeTcb9HGgQzF6E9e2iCauboxGMVCK7QNwj47c/U2Q2Nu88?=
 =?us-ascii?Q?d7UGfzdlEbA8YzYPGFMSrGDKBrXjQMUnSSGHR6OKrzHLWQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8537ae06-b97e-464e-d0b0-08d8e7a4c761
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:38.5200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3eBU/Kkhj8xd4/oSdWz0RpEIsyN7fooqMVGEw6WCKtG3hYogBK79R/PJxaxFIyyvEqxA2ZRE0PxluriX6cL7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d26472ef1572..352651c805ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.126.1"
+#define DC_VER "3.2.127"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
