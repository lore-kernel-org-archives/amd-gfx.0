Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B66FC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 08:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDC32074D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 08:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u48CLxsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDC32074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EE56E3B5;
	Fri, 14 Aug 2020 08:44:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEBDD6EB25
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 08:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS3LzOwTH1Fb8rjkjEwdVUrC9aL8DOQ23cOpTGpPuUak6Dm3XcY7vBLAs4Njim3+hPMOZwv4mcFOppdGMOnxJ+SKfxNaXKMeYczUAvM5kG0YqOg5T4Bubb0rjNXs0iH5ME0g2nFiBrEVrV6Ju9rqIAstUjVYXO6Z5GV1k2PVs2TL3GnYQzkVHlJAb+TeKKDM17ugRkFil8FElK3A3Su2NcFn62E+re2exA8jKeRSsaM6YP7E3O6PqK3rdibr5Ens0ZnN1vjwcWa5wPDu+GvuJngz8QCanC2WvfVNcU91bEK0r/OC8NkHoZp+cfLLN6zFJ5qeNGxJBuXZ4eTl/M+KZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+DU3UBhujzPTJ0l5J9ckiULG6BOhV1YdsRm+3YfgC8=;
 b=UqJmszeONyn6BzITIThK4CBPQZ5SjaDzkDAvDK+mtQnAqGrzhqWO8ksnWPRQUHGHvlRUP+aM8HvH0goniuF/YRpXBuq4CxyGXVH3owINsnlWL7pZ04ZaF/TJaiRUHfC3cH1/0E1ZrjMlsOWzMGbP5b7ubu31933fsr39evY3bCxpz6ugPRax2t7BK1v8FRxkaHoRkL8UKtaLXtwu7t0nDt0F3nkbO8fYfd7qP5sazrtwnPaKTUhp7LuljoLtFJQOwxs8vSRtt0yTFTY5/f3/nIqH7TsaxtYJeZlylujMHdNU9IsI6UjQVm0cWPAckWWX+VXCbxJILwOFEbyLP1ZTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+DU3UBhujzPTJ0l5J9ckiULG6BOhV1YdsRm+3YfgC8=;
 b=u48CLxsW/hUU4YUxbvId5eVtoT3YP2kPWp55OumT2F/zqVmwcLoeCtZWR+vc8+E/cUiZ2v2NuyL1wHtlNG6YrnKip88y6HFj78Oo/CMwKe/hWqMr8qiGQo7LtQIZDuSOWp/fdRG3KRIOSjyU7lfo2rjEFCPqc1jy+L4N3roqe7E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1868.namprd12.prod.outlook.com (2603:10b6:3:106::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Fri, 14 Aug 2020 08:44:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 08:44:16 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: drop redundant MEM_TYPE_* macros
Date: Fri, 14 Aug 2020 16:43:55 +0800
Message-Id: <20200814084355.3440-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0011.apcprd04.prod.outlook.com (2603:1096:203:d0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 08:44:14 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd544303-696e-488a-2b4c-08d8402e3a01
X-MS-TrafficTypeDiagnostic: DM5PR12MB1868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1868B0FA7BB6D2397064D77AE4400@DM5PR12MB1868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJAMG6XH3wtvYC7/g6aGztlfg/97bD5eKJrevJxf315QDZZFJnjHUVCeGlI8Sseu9KXx9BAHaURSLRzXdUNpsZfLb1CfcmNHThu68FIfn/iDjzhbyQF5dwjO0nCBlzqNUY0rjgMrFKA+5OHyUENj/Av+t9DGJZXioZa1Tw9HqrDvZwWm63hA+JAiPs9BkzB/q0C9oa8mhxUh8962l8/x9HxeP6epwfjx9C0HwmSYmgEZPsuWnN/VP2taTsDp6CeP5beqFnWJraosq0c8nzfxIo8uuyLD0fP+6yyrRIWOXX/NMtYeLfgiQ25Vo9Ochbh6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(8936002)(4744005)(2906002)(66946007)(83380400001)(26005)(6486002)(44832011)(52116002)(16526019)(7696005)(186003)(478600001)(1076003)(8676002)(5660300002)(66556008)(36756003)(6666004)(4326008)(86362001)(316002)(2616005)(956004)(6916009)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: p8YM+HxwPh6UgNGAyDF/F/5B3cJv4rILmMbKT+PTh57Sjv6GrJEUdKaReZL4DFxKqfTyUdfdt9vx5Lm36MN9lveYqt3xfsAxfSbujKIVdguhLR+oGf4bjVrzXJG9cmkCXNeGV6vm5q2gwUhvS2OYUC8TrbsZxwGyg5eazxpY3XCwRkE7gMvXpsZIrhtCYQwhIIZX2WKUqpgo4jViHj4f4J5OAna88J4FpadFXkDWuKKxuGtawj0JlUvohUpVuoj+qgM3X1wPFG70F6H8SQ+IaYtTjAaWqdmJZ7puVlMyU8Tsl3gpGGKefzhXUHdujun6yCNVWPNyLoJ0SKJiJ0x4+zzwm8mjSLJEpIBwSWi3fxcBncVIvMcCscewZvuSzQHRjj8NKBS4mLKZ0KitbDU0spBNJjCeZrBypVxhjOvY56GSYJb/ZGltsCqEXVvkMvgtdEn0SqYN0cW1PRr+qKwBn/rWYad5LXaPjpHlfc3Lkbm9Tf2fK3wChgklfYVGKbX7PuL7vl8I69OJQKnru2JXo9SoU094KnC2WdIXyLD1xAsjx4oXm9gyNwq/DKSZAk0b2E6gR8Unpo2/Qai/3FPpygPIgjnTY/6fCzAqLHhlx8Lod09qNO2v3Kn4hKFgCG+r9XfjJQbraB4SQCojOfmhZA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd544303-696e-488a-2b4c-08d8402e3a01
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 08:44:16.2861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f59cZwhBET61em+AaMl1++FCpktrYlBoZak1pl3C5iG0Kc0oHlfjWCEOJ7oDcmf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1868
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As these are already defined in amdgpu_atombios.h. Otherwise, we may
hit "redefined" compile warning.

Change-Id: Ia2a9e10b35173fedcbbd8e0abb8ad38dd231baf4
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
index 3ee54f182943..76ed2e413594 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
@@ -26,15 +26,6 @@
 
 #include "hwmgr.h"
 
-#define MEM_TYPE_GDDR5  0x50
-#define MEM_TYPE_GDDR4  0x40
-#define MEM_TYPE_GDDR3  0x30
-#define MEM_TYPE_DDR2   0x20
-#define MEM_TYPE_GDDR1  0x10
-#define MEM_TYPE_DDR3   0xb0
-#define MEM_TYPE_MASK   0xF0
-
-
 /* As returned from PowerConnectorDetectionTable. */
 #define PP_ATOM_POWER_BUDGET_DISABLE_OVERDRIVE  0x80
 #define PP_ATOM_POWER_BUDGET_SHOW_WARNING       0x40
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
