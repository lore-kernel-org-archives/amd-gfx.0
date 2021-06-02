Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15FAC47097
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E6361C53
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E6361C53
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF4D26EDD6;
	Wed,  2 Jun 2021 16:51:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40806EDD2
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/WG1Zjga68521k7Owi3FdfTrotvcHt8S1yWB9IV2pViGlRWRMWuu/FyG0j/KiIE8htPkMuyLxWDMjsBj9c0TFetOfocq0ZF84Y1VCq9MCNH1e+iwAzDC9YKqHnADoAOQy8EecbLx3qSxLVIrtw/sRtLv8eFIeqG7Mj81KhMx6h0ZkFDBFRjasWy+blJnkdZoYOxhmsYs37Nkb3AXX1cbzz2t5OQkbsvUGZJkoi3tngX59EsGzCEiKMCk89qzADGlW7ar9JFxW/iSPhA0Us3YE2QawthuPAdciNa88f3fxW4uXb0k9eSDXJn7USnXihZ83EcKDlSNhoBsxqsLc0ffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoI2Z56sHxHFarkVoyBX8r/1GnpoiQJ+SInytNGM6vk=;
 b=lWQsFgjWV6t5MDnurmhRitM6wmwjnrAUru6vdINeglNyhmZV98JgR433N/8Pffmj1y2ARPkrtr6MmlTWwEzaMGzLQn43JWHWdSbJyO6ws/TmKa9UBcXmDIrn0vuJC6YQ1eH9PAtT9KlJucLSIk+9RGujd5sPEelancjJq8ebR/cnS7ivfL3/Ubvr4/82J5GdqKxzkE1LEQ0G7VWgVgDg81MJrrpF2u1Ka/I49A5Q436Z1r+wCnjTW+/mwYCpxRgcB0/r1K/90a/LTxZN20CHjLlOVoG/4mUCEOAbKERKodbWaAkcm4FaVk38Tltg+RkjBWBjDwAHe91dG6JO+jeEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoI2Z56sHxHFarkVoyBX8r/1GnpoiQJ+SInytNGM6vk=;
 b=WGqTi3afPXSWGpc27ZSHYD8KXeBLhXeDtgx+f3//fmUDvZdWPH0bzhCNI3LtX05XVp97HC2hksSUnJ4qBiSJXdpvhk1V1/aDq/VOx/0BI9H2gq33DVroKO6zPhAh+ktyiLaWiW9f177az1mVagI8d7rCaahCtd54eO4C9VV79po=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:17 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:17 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 70/89] drm/amd/display: Add DCN3.1 yellow carp asic family IDs
Date: Wed,  2 Jun 2021 12:48:49 -0400
Message-Id: <20210602164908.2848791-70-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 277dcc23-a4d4-4c6b-51b7-08d925e67f5a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2369AE9C31847C1D24EF0621F73D9@BL0PR12MB2369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRr6DBUM4A5lPC/8Sc8NlHO4JGaTCIDYqdk7U8j/rdmEIqdkIPaJ9i88+QKQC9Mll5e9388zYl7mp3GPYGDjG6rY2Z2LOUanEqIvf/9mwTWfA59ulmWUx08I0zbHNPTWyI1LIS2KVvEG42L+ROIARPm0zQGNDjlqDJYqaATgF8QwSoGngIs1qd1eUySYLJMFzf9Q9ykcyxE+pZDa4BO6H6q2gcBrSzcEys5YPjTneAT1AQnMlK77uZibkpZfex+kOfAxLkTB218ASE7Xyfqx7rYryfTlVj/O8HiAS3KD648RP5WWkd8ZXDXG2KsDbYeuwqSToofms/dAGOuRx6Pykx6JbmRwQomMB+X8jZX1jrsTKh2EmEuYT/M1I0X8DYu/oO0D1RgLyRXSnvdEtIZSCRUrUPgTO+UXSGVl7wF2PbO14wzedw/g+eR3qw0ORicbRaR5oyojSDiSo1kXgaqbXzm0PfnSWZil028GWIjgkiYBJI6qV9nO/OmB01RQNht5C7cBS7IHXUnSq5idsU4hO7lEeumUv2DId4fg5HGUc/CUm1oAH2y77wSHT+YGxIBBjmjPwr1SRLvP6fKWcwuW+ptnPlAYs/B7dXnwwUuaUeTZ4IAkpdemVhuUjUwIJyD6GhdQKpQCdJDte1WqLsgonDAKsvURztcOUquFog7wRN8VObhGWs4SRt1T3LqPOKe8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(346002)(366004)(396003)(54906003)(1076003)(8676002)(6916009)(956004)(2616005)(478600001)(6512007)(6486002)(86362001)(6506007)(4326008)(6666004)(38100700002)(316002)(38350700002)(52116002)(26005)(186003)(5660300002)(66476007)(66946007)(8936002)(83380400001)(36756003)(66556008)(16526019)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LSMrpYFD27AfgkY/Rx4TODvEfOeSX8Y78UhtouR+oG4WdEEZzm8t5rMzgcbu?=
 =?us-ascii?Q?MP5a7yQJRB6BipuwCtD8bMC9YCVqPntRb/3eSuOA+A1Z/T/7ZZwBSX2fWIbO?=
 =?us-ascii?Q?jdBa5paCTBY6RWZifiCEBhY6YujOTFYu2UWb9yJV2MLiWF8ZVM4XLtMfaufj?=
 =?us-ascii?Q?TW1BhTJ5CVvlIWEN3qFZIXZXWyEwT22u9/WN4hTTbf/ZNn0EKaYBQVwk/qi1?=
 =?us-ascii?Q?pU8jcLVJMXPKQ3L9qM4xc4mC8yHt00a+YkCAcGSiqdagqA/JVoR+ETN+QZY7?=
 =?us-ascii?Q?FbW9LGSoEy9xXhr2+zdig8sV9tQ71lN7Wqa9HKUFxnm+deeY8yD8LFOnlZpb?=
 =?us-ascii?Q?S0JBmJOdEBJCUlE6RQPg9WsHb6E8AIDNqRw4AlaHpQv0hFSL9ODtYDWvXHuS?=
 =?us-ascii?Q?tl6aZqTc6LF1KBYYj3rgu6nk0oI8mqQXXaX6/jl5Vwbg/rWaMqjHt1u1ECAH?=
 =?us-ascii?Q?WsoLK69OhIoe5ysgMxBnOtWU9OwKuwL/yTPpjAJBYJU3I9aFXTN+YyIW4wBN?=
 =?us-ascii?Q?6eSAMtebZ3lgnRBBDpEdncjg3yQi3FrRSQNaFunH4+Y7oOizSFO9NWaKomeo?=
 =?us-ascii?Q?tufVx6Vww+CLGZ3/tRydHvX4lni/tzqsmxfQJIeeGUa3d1yUtiQ0DZmr4/gs?=
 =?us-ascii?Q?dpBv25rtJNAxMWvEW3wr8k5MgmjqKPYO3zmf0JKeETHJERd2NgO/UyWyA6mn?=
 =?us-ascii?Q?mgSfiarG3sntv1y4D9bwk24FhvZLZCT1XmqCF0j0UQ7Oz6EFqOXkPhQ9xrGW?=
 =?us-ascii?Q?T30jgYt23KNnlEsmXXMFtLhPo3Kw5sUykVvN1c6bF2X/A+ZCjeg6jyePWnvA?=
 =?us-ascii?Q?RK7baziNZwvRgabq92kpEUgaCy/Rv/as/gXjPoA627oPNkIEQPX8wo2UtALi?=
 =?us-ascii?Q?F1tN2Rg2R5O9cs9tRZR/hugfrvUVQJ5Y/ItNdA/mdBg/uDIWpfiMuRreFeB3?=
 =?us-ascii?Q?xaeZS+Z07PQXxRMzWVc7XIsjQWTmXNqkAztrbbjU8wIxYqh0BtAjEb51Odfw?=
 =?us-ascii?Q?keW3uiwejuCfGtBDe+le5Y6OijSyIGiC4K0pGAL8TOas/MpvxPio9UQR/SKe?=
 =?us-ascii?Q?FCpBuiNHM/lFF266a7E1I+4za07gTVTf0cau7vQVib6iMtFpmR49Mnv/+Zq4?=
 =?us-ascii?Q?FBaIRab8RkTspf1NOr8On6RnpTLuwU0L2xQ3taKLA94f6/KzzEo1vrPE3TT/?=
 =?us-ascii?Q?2FHK+8pFsvT4T/3w5vahLl9RN24RKkezFXj1Ao9DoTITwNLQyG1uJpb3WKi/?=
 =?us-ascii?Q?E77iiPclh1B7NWMIV3wHz+jTmFgFD14HkU7HnbWa/PMEabr49gVAnZktCATj?=
 =?us-ascii?Q?QeWO/ITrAAasJYyHdIdjQzt1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277dcc23-a4d4-4c6b-51b7-08d925e67f5a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:16.1346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjzF9BlVEK4XfLSE6QgSL18R0qh75RgaFj9ekXiXv3Fm6U1hH9ifWNa8NAEAE0+RQQbdOUK59gYHKt2Zm9haHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2369
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
To determine whether the chip is yellow carp or not and which revision
it is.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 13 +++++++++++++
 drivers/gpu/drm/amd/display/include/dal_types.h   |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index cb35eae29ca0..d615a8e00f8c 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -224,6 +224,19 @@ enum {
 #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
 #endif
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+#define FAMILY_YELLOW_CARP                     146
+
+#define YELLOW_CARP_A0 0x01
+#define YELLOW_CARP_B0 0x02		// TODO: DCN31 - update with correct B0 ID
+#define YELLOW_CARP_UNKNOWN 0xFF
+
+#ifndef ASICREV_IS_YELLOW_CARP
+#define ASICREV_IS_YELLOW_CARP(eChipRev) ((eChipRev >= YELLOW_CARP_A0) && (eChipRev < YELLOW_CARP_UNKNOWN))
+#endif
+#endif
+
+
 /*
  * ASIC chip ID
  */
diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index 85aed509c01f..59453ced9ece 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -55,6 +55,9 @@ enum dce_version {
 	DCN_VERSION_3_01,
 	DCN_VERSION_3_02,
 	DCN_VERSION_3_03,
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	DCN_VERSION_3_1,
+#endif
 	DCN_VERSION_MAX
 };
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
