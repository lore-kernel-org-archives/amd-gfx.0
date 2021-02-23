Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDE5C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 10:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F6C64E4B
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 10:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F6C64E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831BC6E825;
	Tue, 23 Feb 2021 10:33:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971C66E825
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 10:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQQKaudnVSxbn/1ivsIub9aI8bNwVBgXUAWDKwBMar+IN8muzjkcG0TuyooaB8fPlZY/SVo/gsSbQCQ/20hlhzh00mA4EV1pv4ULzVlupSaoZ5XAxRd0+WqWSzqO858eTsBm6YzOt/b8rep3EIQbAUNDPGmR4kRPhDIYcu773+mpTA5Woki5cE0jCm0el7VsfMPV897ahOMB48ToN/ge5NPZhL+D8nsTAKzZlkH0fcIgiuutbkI0hHh+H8EiQt7NeNhn1RMtC7SOKjXpmw8o7kCFdzV9ZpXugkKeHTtmtgbYeBikQfFDeTHI4Kkd8OU5Ph3gWblnuiBfVm7oqg6cJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFJiPMdRjEmqM4PY04yGDsK6WAIsI6hj6Meyo9B5uWo=;
 b=hz+5U7+1qQMNd4Vl5JhC9KBzfsHcoNttnpitMDKOE+zjYlHmd1k76mhIIYVM5xtOWpxqrmLhnZQ6KlGNyGlYwbvwlCJbOWtudB8GPZBKMIcMeQfonMQ+20OzuUsEoVeRmVRniMWBvx5VpVrPCvYPa6XViYnHh+Q3Wn8RH7gCrgjFNvjK7/QDNWJyA4uIOPXJifF9kyVCACfcWa0UhucKu2iRzf4rXEjZ3mj9oOXXsFm7NlAeyQZVpnBEp8PF3j6OlKpBtuqSHHVi9b2fRCfvVCr29aFDXhRsMeyk2frHg73dTpYUtd3tgFJ/WJuXcB9e91WbdFjVt+K3XqMQ65ZwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFJiPMdRjEmqM4PY04yGDsK6WAIsI6hj6Meyo9B5uWo=;
 b=u7fC/bgn1llR72c8XVbiz/H2Bw0LeJRMHGCvOzuntmMUyQ1lEPsazAf+npLQUg2d72M4ejLHmzv4MWcr2ZPEgHtW7xO+9rzb6PVbosE1VHKWqpRu4W9Ob95X6Ni7AnJq+4Noo9z2Vw4SyXCh9Uwrpjqh6e0F8FwjrX0q8IbJcAg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB2567.namprd12.prod.outlook.com (2603:10b6:4:b2::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30; Tue, 23 Feb 2021 10:33:01 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::b0db:d5e7:225:7fd7]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::b0db:d5e7:225:7fd7%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 10:33:01 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Enable ASSR in Linux DM
Date: Tue, 23 Feb 2021 18:32:09 +0800
Message-Id: <20210223103210.5148-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-T495.amd.com (165.204.134.251) by
 HK2PR02CA0210.apcprd02.prod.outlook.com (2603:1096:201:20::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 10:32:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 789df689-e7a2-42bf-5946-08d8d7e664b8
X-MS-TrafficTypeDiagnostic: DM5PR12MB2567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25674BBCDB97212956A3A288FF809@DM5PR12MB2567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AY3vduevFUkOXWvkmzIJd/fOxF373XLS925Y2hIBo9bLQc4KdIDGMu9EeTp7O4jdo+ieI0fWSDlPmwcmb601bGkDfFGXFZ+7trnyrghf/4LYbFSFcZ08mab7Qk9PcYf/TC02TFKnmm8b9ShDq0ZxjRRo8ZPWEg2vqq9aVV8D4Z2avtqUbdxvZ29jFHNYKejOtWIGu965SuMg4JTtxfDuIdxN0nExQB0haZDJx1uth8KxUkZwIfm9D+r0FT4LDfo/77V97Ts+QPntPATbzxIL9iDmQP0z+CUmHYFdkeb/mt2yOt+wqEgsusAK7h5+3Y9tXrODRbexIJhKip9RhI5+m9t0P8LKtem8GOWJC18x5rRLhQcXW48ZDOCibudO1JEdP4jkItesAWaPJWLAl5soAVRXf6ViYGBe6fx53uMpeYi1as/4NxIJmA9UkKxTG/18fmWNgrQIA3RFWNgLxOH/3xRAn+aYRqu+mASXZ+HhFP5lTrZZA4BFb9T/zN+I3OXhJZ2TnUSXLLmDwMZHvJVK9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(44832011)(316002)(26005)(186003)(8676002)(16526019)(6486002)(86362001)(8936002)(4326008)(2906002)(6916009)(66476007)(956004)(36756003)(478600001)(5660300002)(66946007)(6666004)(2616005)(52116002)(1076003)(7696005)(66556008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uBTK29jusGQ9IKXT/r2mzo2flw/qx/hAS0QebY6gG6blBKNrk0fbtR7sQjs2?=
 =?us-ascii?Q?sVTZhHtXYJ7wd9ApLyZJdy9tj2RoLi4YZJU/sfOS5j8qint0Fnfw0j+VNts8?=
 =?us-ascii?Q?xmtAia9VD5Lp0I0iK0wOeSb9sf2NYpD4zQp9YQKeY0qrNV1HTK+vZnIQoMTO?=
 =?us-ascii?Q?Ed6BklGK3KpItPBhGdPR2JYlCy9mXr3d2H50bGtLVKoJGsp1KC/vqFeqYjsJ?=
 =?us-ascii?Q?7WN8K4iN3HILJ78zd0bubR8eqBiB4BTkxZMDc+GGhcZBS3cFbNVRHuHGM4h+?=
 =?us-ascii?Q?YPiwax9sJY7Glj2y8JNAf18X2dShfbOF8nXoCxe2OTsayIxOjOUqjPdI16XM?=
 =?us-ascii?Q?lhJoskNPXSHHsfwm+YaS2/O7GQ1G40V0P7NoB2uQuC5VYEKipNcVq1G5dp7e?=
 =?us-ascii?Q?G71Q2bbs9+FiTgT0Lb50PliJ7Oh+iC47QDaJeU9M/CASDnIykSlGtPh7qxvA?=
 =?us-ascii?Q?bMOBtGV3o+IMwMX0nZfAqjQQY0s1Uh3CHd/PWI0GenDZMtfDxUcKk7MhzOaA?=
 =?us-ascii?Q?LRUGrV/O7SeSjuj3kfu7MIpUFfLvMxcIAQvOi9HouuZhNxBkW0rpEjU/nGkj?=
 =?us-ascii?Q?+XTjz5FjEgMJVT6Z2puTlcAv/iBFxnv9lRBQ+++IzqpNja/2WIXGf0FlnmKH?=
 =?us-ascii?Q?Ye9ly2bxt6taWM9KkZFj8iS3mwbQ0XQvxtbPDzdNsYkRPkoWp/XJni4PFeQX?=
 =?us-ascii?Q?4SnT0hQCb8PwxP0DlSpZxeSPd1/NuVY5PF8MkSOkUe0DwkIAqqy76rqET/af?=
 =?us-ascii?Q?L6pmJFEPkvcmNDKKx3cFGDRWy22uUsm2GxKCdd7VRMX3LifqgK6Kx+EdrRFC?=
 =?us-ascii?Q?fKTYaQoByDhKVYqicOR+lSL7B0Yy6Ww6hCjEZ2BSOxNy/oIrp1KnCqY3btmF?=
 =?us-ascii?Q?+9rJGAxDT9TeltPQyUGhpC2UpHDUtvW32fvHIHwxKB+Bof1pRpKJheGaipks?=
 =?us-ascii?Q?nGS5JwRX9hRodmIdRKUJmD0lV5nLG02R1RFNcNL3MNDLaem1d/Aow/aNzJQd?=
 =?us-ascii?Q?Ao45laiuBTDa6RqPAKxJllpcTPuFcI8yrniSgHM6kz+SwrJKE4fdY2P/wJ72?=
 =?us-ascii?Q?UOROBTDYhmXDtThYfuR4ojeJFRD+m+eUq6ZPJFtVYSh1Xl0L7+dmmIW+cQdM?=
 =?us-ascii?Q?5R4NEAkPdgATA9APzKNz0u4tqzDAJIsV93H62x463F6m/AmzlkNA47wW45Gy?=
 =?us-ascii?Q?33ENg8YoIicjPYZozxiLVirY2HpXEPop42QVQHQlB6f2/dVFLR8tX5r5+dLP?=
 =?us-ascii?Q?M7Ucex60i1aH2zsOhTJqg6vyOOhZkdknL3P9FONlPaht3sjAw2hh9CqdVpts?=
 =?us-ascii?Q?3EJUbLuvtErFJF5nrnb4D3Zk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789df689-e7a2-42bf-5946-08d8d7e664b8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 10:33:00.9586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wQsWC3scNysfSW7U2oiU9DHR6AZnaj2Was/oVe9pl1x6Coycc2GsBkGMzBiysgSKumd3VN9/U7dpnmnNFkiAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2567
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
Cc: Stylon Wang <stylon.wang@amd.com>, Rodrigo.Siqueira@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ASSR implementation was already in DC and DM guarded by
CONFIG_DRM_AMD_DC_HDCP. This patch enables ASSR if display
declares such support in DPCD.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c1391bfb7a9b..099f43709060 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1669,6 +1669,22 @@ bool perform_link_training_with_retries(
 			msleep(delay_dp_power_up_in_ms);
 		}
 
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+		if (panel_mode == DP_PANEL_MODE_EDP) {
+			struct cp_psp *cp_psp = &stream->ctx->cp_psp;
+
+			if (cp_psp && cp_psp->funcs.enable_assr) {
+				if (!cp_psp->funcs.enable_assr(cp_psp->handle, link)) {
+					/* since eDP implies ASSR on, change panel
+					 * mode to disable ASSR
+					 */
+					panel_mode = DP_PANEL_MODE_DEFAULT;
+				}
+			} else
+				panel_mode = DP_PANEL_MODE_DEFAULT;
+		}
+#endif
+
 		dp_set_panel_mode(link, panel_mode);
 
 		if (link->aux_access_disabled) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
