Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEA1C433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8898D6186A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8898D6186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C846EE7A;
	Thu, 11 Feb 2021 21:45:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED3A6EE7A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIB/vQ4kJz54sUoibH2YOk7Jkcoxfgl0U3KbxziLg11b77OoMtlTEQer2MwH6NO8c4lB+QCQLCJ4Q/OaSKHhEhF3DFr5a5CPy+uW+hqjQ/rjo5jP5jh6DsKW1QQuSXbVdZAShYDWEumFbXmwFqXQZ0Ii2VjQ6fh6T9EpPI9HE3i8PGrmU3ENmmq1Q2PDu277Zil4xN65/BPbtUlhtqlCo/UwdpxmQTmMP31ZNFabn9YSYvLCwzpZTZrxzQzHt5iFdW2JGeK98h9vNPkoqIPKE/EPhII+yDVSTQ76TiGPRuXp9w0Qh/3X+g3RRXNaZom4U4pGmrWrTspZlzsJpeaI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3niY0AelhjLMym0M6dJCIrWzXG5u07TKZtig/A0d9rU=;
 b=UgxwAx1Q2UBUf1YKhMOXTP7xzd0HwduRuN9Vyi1MDWrwQd1oTRP+AhWCAt8LIGw0tylGuTNTEUs1XHYrrzuGtWDGV2urS2Nfk8lr+TKFeu+HclwBhYPMDYC3nMVALNN7cKVQ1pihQh3fpAumeF352C7EX3wLDVrJ54cE1CbpM3xz2GSKQRFoq/QRlMEtVpeC00LEWshHoWApkxW+HVMs0abrkdiXdQWtn7rRVsDz0lpbAXJpSZTM+sExZruEi9SW4FGWIjIhAaWTNkfCeUCwxbZaZWEZgg/I3U+s7bDbcVyp8tdGlTeg5DR6t9YplrDlwe8BcVFd+DplujmzN2yiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3niY0AelhjLMym0M6dJCIrWzXG5u07TKZtig/A0d9rU=;
 b=zgRz4kWmKm0lggcC6U1CDRTGq4JpUme//Xmys5d19pudghO3rLWHPkIQukgjowG5c0dabVvWYNQ4NCPq/p13P5xlYBwjAA9NG/KJNqBYZR/0rp/bH9b+Bc1fPNpL1isWteJdkOQmc0OPaiD5BnPmOPyil7TshHDUYLiwfI/7OlY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Thu, 11 Feb
 2021 21:45:13 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:13 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/14] drm/amd/display: 3.2.123
Date: Thu, 11 Feb 2021 16:44:44 -0500
Message-Id: <20210211214444.8348-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:45:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c95e05a2-e201-4294-f4b5-08d8ced64fbe
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114FBAD96C2837A3D8EF130FB8C9@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAHmjeI0rPGPu4UbO7fI7JLd/2dZA6bbJ0HIJWBFUQ/DW/c2CO6uSpJytN10XjUzDVhqgXcYVZBKzvpVaNYZli6swztjHHRKnYyxz+tOsDOytE1SFcy2ZBc2tNpui6WLuocmJy2Hm58jQFbmLJK9rLmYEKDEBHSYUGA8zMI5iVRpYJol9wPaRPeuBk8r0Vu+Zpa1nECFEMyfNYraRlhLdKuP2BX8mK04CZS/5YLeujU9qyvhUOM9cX3woC0hhWEUS9wT4qzzmo4kUNTMFu4GvrG0nk1GyX/A9Q4EuBOQvteK42cUClP/DDDEDjbCM0m7Vg6NWKHS0kIdt8UpWN5qfjlMCD76TbAuVzUVZ0BoQ/caCE5ei2fPYuSyBhnvqQBj4TOGeAvgr8e6DDLnFskAUbtENKKyXtFmMsx/OzUa9XvQjmWV9IX5yvrNFWNqUxRKGEgUYbmHGmZLRZkfmXQF/rsA9jpb8qTn6fY/MFLzrpwBMWSIBWJ9udsWl8L3qjdhF960DaxQca/ZDjqsIZSG4jmRhm/+dEH+9QjVced29vkcX51nyBiFuf8VlkX90P8Pl1QK9+lVrgC8ChkD2y2aBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(83380400001)(36756003)(26005)(16526019)(186003)(6506007)(6666004)(2906002)(69590400011)(66946007)(44832011)(2616005)(8936002)(4744005)(6486002)(1076003)(66556008)(66476007)(316002)(4326008)(6512007)(956004)(5660300002)(86362001)(8676002)(478600001)(6916009)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ra3kpCF2Kn3yH/A+ooiHTvjijerN2KT1hqa443bkXngy25YZDtdei+oAOTft?=
 =?us-ascii?Q?LgyzyMIjWLaBJFE4cQqKxIHyERw0LpohTVmOkNhDrKXsEFTCDHV1STKGfy3Z?=
 =?us-ascii?Q?Egau0iK44DuRI4t+XY7J98k3MJTA+k5BgyrhTvTXwn7wMl5xCrORRjocxOgT?=
 =?us-ascii?Q?TmjaQeUnOFqbaGu9DlKCKQdTr0J2iI6+ihFUM+NX6qNjFrg2XUJya23r/aSW?=
 =?us-ascii?Q?LcEKGDcE6IwnoKztVO3icNFI7Jako4QbvVB+Snjc9dE+nBuXt/p6oZjc7aZL?=
 =?us-ascii?Q?ElPecoD0llo3kPmqkLhuTwhigWo3P9yFWMTh7Bu01QkPejp4HLEXxwvIpOL+?=
 =?us-ascii?Q?fpF9xI74MpudAXtw30ECT2XpW9ZdUDmSaNgZ86neQZFTfeT9OyKjncpBnc0N?=
 =?us-ascii?Q?Q15aJY93v7kW9w4Hyz8BuVZeY1a7KF6fbR8b9dXDsHdWLjnW2BlJe5DGCYoZ?=
 =?us-ascii?Q?UBTzG0HXotOK1kHvKDZQ5QFRhubHGuUDX1tLePxgOoWCMmg/LAFTrl5RYn2H?=
 =?us-ascii?Q?4G7lgY0sWwjPHjQECVOTJW4mQQKywN6VpDRYQnGu57JJhtrjKIRUjcA7+ywq?=
 =?us-ascii?Q?Is2ZZ8w0Vzvk4ris2lMT6iBUVIFPhSaIad9Gt4Mgu1jz6lcpZBvqCa/ja2QJ?=
 =?us-ascii?Q?aRgdNXN7K3owhXqlOQwHKxxgIJsyCa4TYgncv5XLlewfPuoddJGVv8gXpiDD?=
 =?us-ascii?Q?lgGTjxcsg21NOMomqZ4Lc344XmUZ8KaHsUAQV4KapbL3/61Uzh2rZc4rpfDx?=
 =?us-ascii?Q?n99iTugOJt6JGAYL6hHT+nPajnksF0nAiX4/pZNZ/WiGEpf9T6oGavbmMzGe?=
 =?us-ascii?Q?eeED9vOujVNFhORPtvmbFj2JKmotX/YGRVQ2CvF9b0ffNf5cJ1jS1puaZbjo?=
 =?us-ascii?Q?+/2W4LUhBSjNXPbvFKmengXR4ZGPENE86cWRkrIj7Gp7GrJatLFjs8BtRXca?=
 =?us-ascii?Q?NyEqbL2qvO25gDWW1a/sGi0+jLw8KYq3i7w+ulyv3OeK6OO55v6DNFHALDk1?=
 =?us-ascii?Q?w23Lz6cHEKdmUVwetmZq9607xIbVTj3+awf9sS7O7xMX2mJIPAnr7QqpMO3H?=
 =?us-ascii?Q?NXYpxZ6ury96ugL+lSlZkaJmV7ZOD37qLhKJPw5kQochcsUjNLNWbqn0slX3?=
 =?us-ascii?Q?4trBW/5wUQEJ0Dg9s2eFfnK1nFevBF1Aoo+MNPefvd1PCwxAnvVgTNNF/QVI?=
 =?us-ascii?Q?Zw+Atb5nsb4VO+DetA16iLq17rQEx2mUU8rr2CzgMP6CqghNwwRGbbBeUKtt?=
 =?us-ascii?Q?jpqHuWUL0eKZ0YQY0TB6kpqrsG7iGV3MFSxzbc+Ffj6TMVIqpDrJjqcHK6LG?=
 =?us-ascii?Q?A8YwDG4Q+JWSeDJZOmehvWNW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95e05a2-e201-4294-f4b5-08d8ced64fbe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:13.2051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KamZVlk6TE4gK1qOAQGRc1QMFGGatAY115T8q3z9+9WlafJmVVQSRh9Rtf7bbk/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[How]
DC version update to 3.2.123.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ef5d8fd0fa1b..a10daf6655f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.122"
+#define DC_VER "3.2.123"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
