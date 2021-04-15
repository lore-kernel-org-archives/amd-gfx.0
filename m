Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D813C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 17:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F35611AB
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 17:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F35611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD986EAA1;
	Thu, 15 Apr 2021 17:35:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACACF6EAA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 17:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2gwDCOADi5756+49MjJM02IjkbvGuDXTUb+KK0ROso5f5uRUA4ILndfsRdwHqVdT4mB4JoLJH5gSe2wVPxZFnh1P38NnC3ECb6dmktMhQdKkYb6tJM8ojKegaZdMfrbCBXDOMt4B2wu6yZUD9rGteadSgPQTYOaXyz0lF1UZtQ4ic/Eu4I7jcIs1iWZxxs2jbTBeTrah16EEnwllMEHRJFWUwo/9K9cufZbeyuYtoDN9zgxWbBHrBPMd8D3uaFbSqs3ZscOspwR3Syz6NnCHBvhl6KPIr6pVmZlyZKLcY7jDWvozlTKh9ihLXbtihGg7Imktc7K9swBp820sNof4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KSEG1OSf6QsUZS3phnGTogmaf0MXS83WDI89FA8AMo=;
 b=G1yfwzwP4lsh9KrFhJfoSU+jAA3p/pwZR+yVoNqYePrvG/Gch6rh/VXdStoALUvdWJ/A5DnLzmZnOsyt5kCVGT69sbBKfeze7Mj6hFMJq7NrpnPeUwo8h1uXE8+EXdU9UudkvqjgWSf9D9Z+g3WZugJSvyyHyxk/ZvYM0Gfex0uwIvHXCpiGHpSEKymYmnk8s2FEb8A8vv8mrQbpUtUDK05I/2qta9WiRwGC+hSUBPoWv61gODpoAkIP/URUiIMdaAvj7821RSDmoyhrbE/NDUK7e7UP0aa292oG9CeShgNwhhak6i6K9jj1FcJa+/zYfaNskBoQ3FfsFHgGim9UeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KSEG1OSf6QsUZS3phnGTogmaf0MXS83WDI89FA8AMo=;
 b=RNp88eBC2kXtCNxIz40Um5UsIwq1lTBFPKnHxRyC7OguwbZeU6DzatR7SFvA0LTNdeaboH4wdlmyw/ECkWV78zViNRK4nsmPDDhEcmpBIgRMu+Xr/plTC00adgD9tDghaMVZgAMjRXilqjcrQnzFsIZytJePZcl96/JBt6nbp2Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1244.namprd12.prod.outlook.com (2603:10b6:3:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 15 Apr
 2021 17:35:19 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.037; Thu, 15 Apr 2021
 17:35:19 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/display: Update modifier list for gfx10_3
Date: Thu, 15 Apr 2021 13:35:07 -0400
Message-Id: <20210415173507.4235-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend
 Transport; Thu, 15 Apr 2021 17:35:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7f29202-b95e-4754-f2cd-08d90034d6d7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1244:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1244C381A23706E161F1E1C5FB4D9@DM5PR12MB1244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYCul4KMIzdJS7jc27Ymsxh3kPhTJQ5SUPKh7V7js6PD8kasWldljK1lYCFyqYIr9vdjk8IufuPrjFdJCOhNchnyb7loZmEPiRpFSEKrUOaUm10OB1/3gP1o6xqrraeQse1PzjD1M15i1eK1Ja4KWbRVia8HEZrtc1QRdj8zNEdqx5z286wlo1q0LuQL0c++1gBcKG/fVvR0SnIT2tDrsOZh5EFZkMvRTXcRbrKge0ti6uzFdJeK9IpUZf7zh8TBwHe5hmxzTu0OBP99WhVbtFuAzICtoLJHGdRNwK+9i72xUJkvMZ8ltGCax7cxVxePuvsWKbpOJREbbZfaxZM18UehXV4jxUKsp8lFJ7KI5o0+/tIJk5gdAh6ErU++1N3ZgNKP+8YQAGgUSEowQGBZJlBopj7gmswf/A3P69oQuj09jZc9X1tBvhKWZ2fxYruy3pTzirs5RY3uvKNKI+cU3O88n2DPwTgjXTOd1LGXYzz/QSNC9nyx+r/xMU3jmHFJ007eGLm2uIdL+UaHIAuGNvWdXpvbxf4vPab8uR58WxsKvZ5LYEbYqv/YSiFziuGJhKHNFwceEv4MUKa4VekQy33VJdrhktH18Wc4x5hhVcfBvQjH665ffPLXjpnMb0Rf+B7pJxhx3m8d/wjvEjOYTiKkCgcL0GqXcUHO77QabOvqo0OXsep08Zl/4p90J5h6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(6486002)(69590400012)(36756003)(86362001)(38350700002)(316002)(1076003)(44832011)(52116002)(956004)(2616005)(4326008)(38100700002)(83380400001)(6666004)(16526019)(478600001)(6512007)(66946007)(26005)(66556008)(8936002)(2906002)(66476007)(6916009)(5660300002)(8676002)(6506007)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SrblfghaEbcbkQ0u9HHRdQoPXX5pfHymXLJU/NlBs+ZqLNxcW/dZvOYhkSGA?=
 =?us-ascii?Q?yqFTdUa+PI3Ssl0aa1rKz3C91FhwpccUNLf2kMg+fiD+yqSbgrpab+JEuh0H?=
 =?us-ascii?Q?gXlmRyvAYp4b9sgIOugnG2uXewmkwuCl6BIJRsnEqlOZx+UZ+KEN4MI7T74u?=
 =?us-ascii?Q?Cc/Uq9DL0to2wTVLlFMbGKUBrqq/yMK6r37I40vQoBbdy1QJyOZEuAiaY1Gy?=
 =?us-ascii?Q?xEDojiilXze+Kc8QLH01x/xvY8YJrLzjAT8yDjLYJPS2hlaxuXtC4K91GVtx?=
 =?us-ascii?Q?oyXJGDJnAbliwawak9E8y+vemtCa4LwnSVHjL9Kg6aADjFOghiq2+u6f8V9H?=
 =?us-ascii?Q?oq8k5AAuznbvyR9SFrMRijIn/CjQKRwrT4A0PzqHPwAWDH6y7mS2bI5CYiDc?=
 =?us-ascii?Q?8Hk9IOC2uXBshNMF2dozl9PINVkpp8I4oc1EiBwwasiQYaXqXjHxCaXpYMgc?=
 =?us-ascii?Q?M9K01VvOnlc8IB/Hb1Yod+jOMUL4ApfJIa24TP6IBiXE53VZ/P6RkD2NVv2I?=
 =?us-ascii?Q?uwQBKdW+XuznDeF1Gz68DTi98NFuhA6pyRfFCTp/GkqXhDdFZ7FFJDvk2Ija?=
 =?us-ascii?Q?pW0pxrh6zyCsLZibRF/dP6wXD2TVBxmRcA9oTECjYCdYbAlvvTkpsUJC2MGW?=
 =?us-ascii?Q?PjNByAguxUIy6/4FXbXgxYgdZpWcyw+xfupBi5J8Lf9Gi3kYTNAlQO2rj2hM?=
 =?us-ascii?Q?skWTMftElAJFMcLgg5K3Onf1I/FXQS0iL9ys570F69wZbR4sOfHCk80Kj/O+?=
 =?us-ascii?Q?MH4H4zqUwF3R0le0oUa1V/gFZXLmjrowUgYp1bLKWSHzgrhwxn5uaFbkkWUR?=
 =?us-ascii?Q?QFMEpV1qwDHK9KAQF+WHW/gEggWR769sI01YbnjkqRb2Rv4f/UXU2eOCY/Vb?=
 =?us-ascii?Q?B/4tUoh2Q36qGsDLcPDM9Cns0TpZqbmUvvQl23yXufZSDtN8rSdmf77TPXbd?=
 =?us-ascii?Q?3F3egyukJYum9qbd9O7jczPzP2Svutbk29Ed9Bcrlj0VLhiOajwxsClctmHo?=
 =?us-ascii?Q?u6rDjBQVLZJlUXzeAnJXhIb7NcDfqT1Ump9yVv5SPXvMDtxjjTKRGDQroljH?=
 =?us-ascii?Q?6ChA5J1od4AxLFav3n+cabt7xjznge439Wks5/5yXgE9uvV1CYYPVcUyWaE/?=
 =?us-ascii?Q?1DTHxq4B6VniqvxqIaRP97hT5v5Qzl3Vz2AFMB+OB572f2/DPXia4c4o3r1m?=
 =?us-ascii?Q?ejl7Tj64caXN38TxIrubTggQ6GNxSZJ1LBrsrt/bLDFs4A7xRSEjlWZ6/3Uz?=
 =?us-ascii?Q?HYxOV7PGE8EU1ysztFPmMZp939TLCeMaWkgpX83sjvfbiIAwgjSZ62UV/Ebh?=
 =?us-ascii?Q?JEbySHzMvuja0i1Hw3BCvt9S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f29202-b95e-4754-f2cd-08d90034d6d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 17:35:19.3821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOhkGHQQYSpM0uBDKEXbAECYWpn/zQ3szgBKr+VDS/TJhMqq/jfAOxzgZDaYzWbn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1244
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
Cc: markyacoub@chromium.org, Rodrigo.Siqueira@amd.com, daniel.wheeler@amd.com,
 bas@basnieuwenhuizen.nl, alexander.deucher@amd.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Current list supports modifiers that have DCC_MAX_COMPRESSED_BLOCK
set to AMD_FMT_MOD_DCC_BLOCK_128B, while AMD_FMT_MOD_DCC_BLOCK_64B
is used instead by userspace.

[How]
Replace AMD_FMT_MOD_DCC_BLOCK_128B with AMD_FMT_MOD_DCC_BLOCK_64B
for modifiers with DCC supported.

Fixes: 91e54fd70c6a ("drm/amd/display: Expose modifiers")
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e29cb2e956db..9fded25d2363 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4544,7 +4544,7 @@ add_gfx10_3_modifiers(const struct amdgpu_device *adev,
 		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
 		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
 		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
 
 	add_modifier(mods, size, capacity, AMD_FMT_MOD |
 		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
@@ -4556,7 +4556,7 @@ add_gfx10_3_modifiers(const struct amdgpu_device *adev,
 		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
 		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
 		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
 
 	add_modifier(mods, size, capacity, AMD_FMT_MOD |
 		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
