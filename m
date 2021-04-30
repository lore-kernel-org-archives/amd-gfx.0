Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC653C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 16:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A7761264
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 16:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A7761264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D006F56B;
	Fri, 30 Apr 2021 16:42:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C976F56B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 16:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdtZzCEJZj+JoVDBoHZQ9kvwAgWkMd5oGrsztaQtMsMak0FdsP0c0sDBGY+flas6bkjA2jky7XzdPiSWketBvG7c/Jo928wGXWtnFZkwffsEwpZkTK04GyXwyV/yzoJKj1PU/NRff72KtTtBp/bUvNosWXTUfTdS2/Yucvi2XKIkD8BB3goZxRF3hxvtZA8+Flav/Qap39RjravlZvLEg5kgwXdB+YysMNFJ2ZYiXfQNXAZlk+3stH7EAwqZdfJVU7YgnXdZP9Yi8RK+Vt9RtdpZ8GlxVVyRYenr2NPHaEIlyq82ZE9HXQPsebnS2kPESwXpt+iOKyD7upAsRcoOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns0VnNPtgFOBhcs4uN6Oo7bEyy1ozG9yP4y0crnwKOQ=;
 b=lIKd0lXzJICpQN8NfJIZnT/bv9qjfX7LYJypFvAgD9eQO3Nm9RHBgCbaJ6Zgy8rEV9LDt7dKa7LIx37IYb4arDQpotd6pFIUYmVxa/IUdTjv0tw7+IK+XMQGDFplzzHjA+qgISTJmrRBnqfIRNLcXotV2c5RolotEUWnCgY9xKN9oJKaEkE9quB29zbC+ZXJK9jV2uth7dfHGTeTEEgu3BgcBhWPO2bcZNWV7QjH2N6FwwVCdGYLFBg8i5ZYCNz0HvXaXDRTDcfYaPta+DjGUOgiCv0MYMYbBTUdtM4fbsCRe9zVHmspB7nvUIfP5NZr0nhZ9H8yUvYTp0370N3NMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns0VnNPtgFOBhcs4uN6Oo7bEyy1ozG9yP4y0crnwKOQ=;
 b=xm5ZLBoqMAT9wL0qumwpIIcdoIM9ZhZHzjEIGiHxnc1Iw7V6D27wgJctarTwMTxLK0/VzSPY6UQuia1DICxScIc0p/IK/vn3B5D1vB004d63SsPdsoJebZuiOWV/As5sxGqhbRFV9ZjSpAL3ilQhs5O5gLXscqm0btXKypl8xwI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 30 Apr
 2021 16:42:52 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.026; Fri, 30 Apr 2021
 16:42:52 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/pm: add documentation for pp_od_clock_voltage
 for vangogh
Date: Fri, 30 Apr 2021 12:42:32 -0400
Message-Id: <20210430164232.1335629-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430164232.1335629-1-alexander.deucher@amd.com>
References: <20210430164232.1335629-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::21) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Fri, 30 Apr 2021 16:42:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88c3795d-7f8d-455d-01d0-08d90bf6ff2e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41769DB98D35B2D35999CBF0F75E9@MN2PR12MB4176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJGIYJOdkIM4ARTYBTxR3JHq8d8cJtZ+PTYCRBzv7u9g0Wqv17HcrlqG14ggE0OeMixMuEFPnT7ZwwU5KPJHo+97r/OEKfoPY9mYIVwwbeDy8/Dwr++Gkb6t8wBhhK3eisFx3Uqg7VRvwINpLJ10wOyCMsF8ovprsMSQT83BCdEqOe+DJ3tuVdCeb4OgeGzugO+tG9E+YNrklNB795P1aMsFdVLxe/KTgs6SKXJ/VxNiGc1P24QjxGwt41p3R74ygiasqL7dr6yiejdewFVKBHkC8EvoLlhYVwndkAMMNLR9JIAydaq+7SHmFDdZB+d9UseMHPcUpnXYyMQgJYN7grZWtRD0PUgBs9sVVkSvTRSnSHp7eaKFqmYAr5H1yxM2DFRJ7z/EbkT/ejXpkS+N/yvQWJ8vsBLJcuwdTNlS0IqGw8eNcz8GLdr6xtWnTP8QgWkXsnK37FN0QgpSN21TpxL+zYZPnQERjM8tXG4NxHqVa9BXDrkTIS2ehyi5d9PHft5U1BWec9RFAOa54jT0zXZ/kCzcJo6yC+XaaaGcbVpxXWdTYq28D2kuY6fBu+EQlNXwj3lcV8o8t9L5V8foiDVxs+1y4j0aNlyUikwfj6czbBJ+IfmYai5qJMpZGoR+cFUD2WvhruBrqsMI8TAMZZCdumFbpZlrVpafKOjQarn3F4FyALTeb7JxpW+Ck4P9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39850400004)(396003)(6486002)(1076003)(2616005)(66556008)(36756003)(478600001)(38350700002)(956004)(6506007)(2906002)(6512007)(8936002)(4326008)(83380400001)(6916009)(6666004)(5660300002)(86362001)(186003)(8676002)(38100700002)(66946007)(52116002)(26005)(16526019)(66476007)(316002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZyBLkDoqkDPLb53msKeP7Pw1lc5L9ebZhryNcu3vdEXCUaVzLBHG55DJN/1R?=
 =?us-ascii?Q?MF+CDFTVStgVGHlmkvfP8hGNUFbQYvkc0a1GIsHw8Du+R//ubxkhaEs5VDLn?=
 =?us-ascii?Q?jE4SK4YGGMc24pKdYEMr36mdwnrLBSjQfS9OGHIjuqBgp+vfKaR7OBNgDPrF?=
 =?us-ascii?Q?LrEpLe8VYqFcsNwTZviLjC5ZsTKMLx91PIe4q94GcOnxfjRM/Z5nISIFia/E?=
 =?us-ascii?Q?sGfyz5iew2n4xHZ3UJYubdhP+Jiy4Gv9TDEt1kV+5DMzXQC4g3I0xm9uGR0/?=
 =?us-ascii?Q?sB22FIN8bm5tC0GuNSn21B2hE31RvocO4bEfFQ4dRGvSpz3aZSIHbL+Ar4kL?=
 =?us-ascii?Q?Kza8ebaE2GotY7D+2YXPVpGdHOY0v/nmvxSnFDWYl+CvvHqvyntmlmCMfLjq?=
 =?us-ascii?Q?whV80TJb4/dwm2AsfOLY1FwD6kSGhSyNMlWGb5jgvRjk2WPs54oTr2wTDxHh?=
 =?us-ascii?Q?gMc9AqyvumciuhTneSxyiI6dnm14qX/d5cZfA0OlsXRRpVMR7jv4sW7tcQch?=
 =?us-ascii?Q?5RFfEbzG3UpV/bmBAN2FYbaKweOX8aCpiSAb5UC0W6g6guEMNDHgOb6XmpF/?=
 =?us-ascii?Q?PG+2pN1N+BXdNLSfUOUr/F9pdUJ9xpD8h2mz4f0c22t/AT4uLrGMgH/cK4wN?=
 =?us-ascii?Q?TuDcKUbyEqGg43pG91hMtUe6ksFCZwhoA/J8iOaGM46iqL8WaiA9t9BG0IYX?=
 =?us-ascii?Q?qxvXbEhetpnoDKLw3VmR7YNeIBkeU/wDNAWqe/PX2JjmtLC/lMeo9sBRTjpN?=
 =?us-ascii?Q?9lhVI9c99x/LMUhl0yh7wxo1uqDC56G2zYgDBVnagINMwRCPtKFtjozf9I+A?=
 =?us-ascii?Q?o2A/Nl2ixYmY6ZjoSDDS1noIyQmukViw605ib34lAV3xZrJgnl74hAvnIKJl?=
 =?us-ascii?Q?zyclOfzVisijBox0Ez6pzaajvLpddTkN1oqxrZ46CIOa5Hu6pIsNRfGUYitn?=
 =?us-ascii?Q?wluWy0b3MIGMZwuvVCINggotKI3tsh+Mb6HXJCdKJK+6EFR/Ht27OsU4hiiY?=
 =?us-ascii?Q?JMAUVQWfp8z+isKpJsdjH/NcM+X31IxmPmuQFykcfdQkqxAuT/U77CdI3C1R?=
 =?us-ascii?Q?FDg0AoNIEGAP/C1KD2In/ZbVIsiXlqAh+TFMcc1zD+sg0ZxYoxaoLnl+wHKZ?=
 =?us-ascii?Q?Fp79CgCAxTcy4snoZ07cyLDXaH9ldmC2q0EUrQGL9JMMlup5aHpwV3puhl0A?=
 =?us-ascii?Q?N6LSIHagGnVKg4NRqbsGhtJIHMGJ0sRK1T4A46kzERLFQ8e8Y4VSBqkeP03Y?=
 =?us-ascii?Q?bixb6XOonD89uptRjwuYafpUqv1L2nXNHJB454Ase+kPJlyMnjceMd8fkFYO?=
 =?us-ascii?Q?++Tw8z3wfM0/u08Uj/epbNu2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c3795d-7f8d-455d-01d0-08d90bf6ff2e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 16:42:52.2334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VR9EtRCJ1V7ZpON9oXHyRvJ7uXCmK9t5RqFrA9RL4aWPJ0Mb27lqJjQ9Z6e16a7snmVpGIbrGacvb9Yj+g22UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Vangogh follows other APUs, but also allows core clock adjustments.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index cbd38f2be958..082b01e872fe 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -743,6 +743,15 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  *
  * - a list of valid ranges for sclk labeled OD_RANGE
  *
+ * < For VanGogh >
+ *
+ * Reading the file will display:
+ *
+ * - minimum and maximum engine clock labeled OD_SCLK
+ * - minimum and maximum core clocks labeled OD_CCLK
+ *
+ * - a list of valid ranges for sclk and cclk labeled OD_RANGE
+ *
  * To manually adjust these settings:
  *
  * - First select manual using power_dpm_force_performance_level
@@ -751,7 +760,10 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  *   string that contains "s/m index clock" to the file. The index
  *   should be 0 if to set minimum clock. And 1 if to set maximum
  *   clock. E.g., "s 0 500" will update minimum sclk to be 500 MHz.
- *   "m 1 800" will update maximum mclk to be 800Mhz.
+ *   "m 1 800" will update maximum mclk to be 800Mhz. For core
+ *   clocks on VanGogh, the string contains "p core index clock".
+ *   E.g., "p 2 0 800" would set the minimum core clock on core
+ *   2 to 800Mhz.
  *
  *   For sclk voltage curve, enter the new values by writing a
  *   string that contains "vc point clock voltage" to the file. The
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
