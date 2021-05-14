Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3069DC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC98E611CA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC98E611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D29B6EE05;
	Fri, 14 May 2021 04:51:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48CFA6EE03
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbXx1H/nwo7hKGuwFzT1XCJGA9HwiNL2xYLqYNCsyr0CjdQvfrL786UmKnNjRn8buO3eucW+7j/arddh4u2tBvgo4OqH+cmUCZ2hsmJIdsFjxJ7/fwO3O0yihRP/vsGW7dtV1Gw13u44Aw9OswEXiMR8LrGLWCqallHdSoOeKANxxm32BJS/SdCbH/T/b4+3a1sHetvJi9sA6c4C83xS4cESxDC5OQXq7nITUMw+qRBxi5cv82sRHB47o8021d4qo3ydhsR5KdNFTmKTFztcY6gqrxgvqMbBAHnJZGZjQ1QZlQxM5kks4GPS46YuNE/AXSglKcvXEJ5TetkL70FUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i79NDNGlnXxuEOqQjV6iDDaXvSbH6M3avw9CHQF1Iuw=;
 b=iALM4Byj13d5iaqJhpuDePr/CclA8KHsSsXvArZ868QuZB9JkceHto2RuHxhEgtcra9j6nvwO6UCSGkw0SaKkcBz1PKrv+POhlrB/YSPIPvcOzHj1iSv/wFGnpj3J0KPo3RjN0mjVeSmfSUeymRyYiblUOxE0m3e0v1QzPieUX9LGoq9pwcXJ10+sJnthR+z2ucaFmnd06X5Zls5RvxyKP7jb491q5nRMRFPPT6sHd7eti/DwC1nQAvMG9ArguVnXMyJVBDQLGVDu+SfwyAd2vNwIn0t5XxPB38FKqJQI3UaRTOUDWidmIU4EDNjVwXScMEdk8Qxs70yKMgmlp90Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i79NDNGlnXxuEOqQjV6iDDaXvSbH6M3avw9CHQF1Iuw=;
 b=M0PGjy6MzDJHnS9WFx3MBONPEv9HNpNudJE0WZCAopCk9DHYSMyZ4Uy30WcBtI7AmiXoXfm1wB2I4ueooQFUGqf8vxmLugQeb2FQoqCn/YlDfZDEBRemn65f/AbNlxE4+OZGNhmqAW6nrIwClYtOmBm7dARnyqT1X0vnZ+MxwbM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3609.namprd12.prod.outlook.com (2603:10b6:5:118::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Fri, 14 May 2021 04:51:34 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:51:34 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/20] drm/amd/display: [FW Promotion] Release 0.0.66
Date: Fri, 14 May 2021 12:50:02 +0800
Message-Id: <20210514045003.3069681-20-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:51:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b352b2e-213d-4fe1-5ea0-08d91693f2ed
X-MS-TrafficTypeDiagnostic: DM6PR12MB3609:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB36091DAFE0B239FF1611A290FF509@DM6PR12MB3609.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzrh6ScGRf9oAbeA9r4PKvW//Je4CAU+7+8duVt8+a2ptMyp85XbOv7p0vD7goueTKdTesUKulrDgH8h14n5pnapT30Ixc6vBE9n5a1O9eSmp4Mqnr9D4Pq7Ggs5XZhhBf2M/oHapM+mgsulvr80AgBswqprrHly47UJu1uwKxcix5YLwfqj93QWpS6RCx29aTUb797WLwOzaJvaU/fdA89XhZUXYpWFnDHtVm4FU34TvfKQmj4Tjh4TysLSpG4bZU21fX0bBxmKBVDw+gHSh7jVAiz9SOzb+ZSbVFD58HyAP3GnHtPm22uyu7BplYaYPuOts9MkYDAJCPvxnc5smToU2dwF0sfUEpKrRQ9dRtQDG3FEnUNvMfNTF4ySbM3u/LN87gTnm2lo0VXhz+V9X9AbxTmEvvA6BWhfT2BdAZUf5Bn/xx59RojjQM1yL4Z9Ha6fZBUWgm/vnpuqeEbbav09x99gemtlt3iEp2/4lRA0XGnwVoEGoRgH/uGN2hxxNHdO9cWtePiX9PgrJPvweCcHayF4mR2dQVhixW6suwZNAGtNxLucTilngfPENiwLrKvn413JORqInqPjKYgsW14Y5O2Cay9qsVyAkia2xvIGI0rSz2vfKppG18dEFyqtd4pghiZDb8ZxejgziZ8YiyDg8uDruxcpjv/l1B0BRqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(6916009)(38100700002)(4744005)(4326008)(26005)(186003)(86362001)(36756003)(16526019)(38350700002)(2906002)(1076003)(2616005)(956004)(66946007)(44832011)(316002)(83380400001)(54906003)(5660300002)(66556008)(6486002)(66476007)(7696005)(52116002)(8936002)(478600001)(8676002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9/hyMXaUZJfL2wkfiz7pgNC8Je4Yov1SuC0ojvcjpfEUNQmTFu6iZ27ShOl4?=
 =?us-ascii?Q?Iu9WYl7MP7nI2T8UDkW3vfEfG+B5bHvIFA3IWW24RPf119a5y04mbcdsGh76?=
 =?us-ascii?Q?SNe8Wwerjli1DbsTO4vBybjwSNq5WqfV4tk8/EryeTnN8pa0k9LzcGic3z0N?=
 =?us-ascii?Q?V/iEo5teI6PWPy31ZBE8bQo279+XoOCiyQ3PvX+yfx0R8LfswIANXvDZykot?=
 =?us-ascii?Q?aKrmtZeGunJTZfeMCkTQ+bZts/1y2nf5OyX7xrCrRhzOwOO29S4b3nG0ONVu?=
 =?us-ascii?Q?OtsMNGDunwnEx1vUjvR/yD9jm6W4MvZC/k/oOIoWAovXvkSdjdLBreKvWaYo?=
 =?us-ascii?Q?N2GHt6G7oIR+l5i8efVV08j/yEtq8Waoxejvw0dVaL6QuJAd9+a06Onke0m0?=
 =?us-ascii?Q?KuukFeFiMKhLfSSbXSIY6cOK238ghMAgnYEZAqvu82NBcC+p76P+teyVfvXq?=
 =?us-ascii?Q?DpriSVfIzZIZ7QxGHYPXMgxKU26uvY8oHV7Bvk/y4oBwdkthQ8IAzvpQ3vWt?=
 =?us-ascii?Q?1j4jx/Pf6hBOWPlakPAO/K5O4mKIqAtYUd0bppz+JKHYZPoP5iF1peWvF5bv?=
 =?us-ascii?Q?QzloFy4Pfg7neR1ekLbt7hBTmurksSM+LHbtDsldrHyxpHj4N2ClSCcCPE7r?=
 =?us-ascii?Q?sB3MowqRgMrnfuMmZtEuWvCBXmCxuAfRM2WCUflZosH04SLLWkr4wbEQWLGB?=
 =?us-ascii?Q?RYq9sBtn/OJeGbsVVkMeaT4wAgk1bukbM71DM9734KfVNZsjcijJuVx4ycxS?=
 =?us-ascii?Q?ywiZgnR7zLBQfWbKfhJMhWse92w0EiON0vFSKxnRdDdaGQGPNGwGWwBREN/Z?=
 =?us-ascii?Q?0PQaHhrylUwFpXbE1vUE2kqg1ueCXKcm9IhG9oyUxBJyQN+F+hEj3v06a1cw?=
 =?us-ascii?Q?0KjY7roMwabhQTfiMz3UicU+iEovzMLYe4htRxMKvxAh6J4hVNJ1QoT+Mtgv?=
 =?us-ascii?Q?LPWYFe+WCxglDlCU1rjEo8go+MguOSqHiIprdia4dEV8Yhqo4YtYlmVoBNdS?=
 =?us-ascii?Q?KYdAwHoeZHWgbkYo+Uzlmojn9VKWHlp6rQ1lLv7gXBgoLmeUxFQ5w3uIZgRF?=
 =?us-ascii?Q?6s6ozpZazQfFVsIe1ZDWPh1FgstcXj0yZaoO900Ahgkm5kwlc4KZu5NamL30?=
 =?us-ascii?Q?48ntvwp0rXPPi71HIP7qp9ZzN6HkS/LixSsdhVCNEItfvnrmhgrT4dgeLbx3?=
 =?us-ascii?Q?+fo4/gSRyqEq6TR3RxBj89Le7WPJWZLCpDqM6rfS7VnzcbJWAQkaOtbCXpY7?=
 =?us-ascii?Q?Mt11AuuIojEQKPoBBmwtIJmxG5nTWQBq60v8uOVOxRnqQgo/YqVbDcCxS1X4?=
 =?us-ascii?Q?ytxXYhsRu04q1Th9nWrAC7bAIlV0ZJhmsvG89wps6YtdUg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b352b2e-213d-4fe1-5ea0-08d91693f2ed
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:51:34.5000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8A1yKi7GxE7gVJUFvpeuAjtGk6ai3P9oc5fYy41nWgLATW0nHAaCfEdyk3FZS/4vjmgMxV7DNQx/EQlECsMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3609
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
Cc: Stylon Wang <stylon.wang@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 40ce15eb934c..0b351da48563 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x2cab49dfb
+#define DMUB_FW_VERSION_GIT_HASH 0x992f4893d
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 65
+#define DMUB_FW_VERSION_REVISION 66
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
