Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE0FC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 00:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B7A61930
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 00:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B7A61930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 112256E07D;
	Mon, 22 Mar 2021 00:54:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4FFE6E07D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 00:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGynzVkCru+jOhuZNVm8YQREk2cyvLPlq0+9MF6rA3QY8blI2TWVrBkW2RLQqxtGWuJCwb9i57k56WKxwMJvwOBljrX/b1gjZsaWs2MnjRwUZUxD08fGJ3EfQ8gTahwK0KC4oWjoxZxzuQiufys8ZQcNa+Jla8/L04F2V+vaA/gl/RGfw5kKf0iL9f5Lyao7Lm1+WPefmi2Tks2b/ePxzS/bhPuE7cmaPHHhHy8Xcctle5anbmt/bs1vYqQS8Lo6NCZEOvKcEbw6g6F+oZX2Vi+N478zTJfmCo8H4HeCMrDJaqqPEFtJl61vTiEykYcecTDS5upAqac3yTmGQVb+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHCu9tyC31hNnTx3g5nqXgUS0Ga15IrAbucDb4uPD+o=;
 b=TdgtIMZbDkQ0jVcmHtxkeMWYa6wSIoPDwaq4NGJocTprGi8aSnd+QBfbhnBJs76sq53oRchPQ7+WQurYj+r5Bd9/ovRnSfUoOvOlNBLs5Mo/9no9Lkz+zbvyv+KLKI/fV7dXFD+RQnGoOh36VDPNwSvYZ3XjOH/oV79ajX+daI+IlRkviBN3PnnJRWudYUESU2X/U9/MF6shbhI5bQnJk5yIK3OG3XVJExRVH8vvU0FmxpVzHEH/Lget1CnEKM4A2H/c5sGU2XpK7ADxmXZgZdyVxHoj+Oqe224e0a++bZJUekDFhxZK0RXnic4gSPlchWeMPJUP2IFQUwiRThY7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHCu9tyC31hNnTx3g5nqXgUS0Ga15IrAbucDb4uPD+o=;
 b=KYUacPAhRD5x0CKClCACgm7EDzHxeLET/xSlqC4tXXdyfimUS0/7HXFAT+CTu71DiafKLjsoKSmmGjrubP5otAkYNvlMcnYRUXMgyY3agfPfPwd8a20kxxsL0bTtljPOulrhdX64tnFp7DrT1EIuNihRFLuFe7x4KIczYeXXW34=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23)
 by DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 00:53:58 +0000
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd]) by DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd%11]) with mapi id 15.20.3955.025; Mon, 22 Mar
 2021 00:53:58 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use correct size when access vram
Date: Mon, 22 Mar 2021 08:53:26 +0800
Message-Id: <20210322005326.9745-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To DM5PR1201MB0057.namprd12.prod.outlook.com
 (2603:10b6:4:5b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0161.apcprd02.prod.outlook.com (2603:1096:201:1f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 00:53:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7042c36-c48d-4761-0bd8-08d8ecccf980
X-MS-TrafficTypeDiagnostic: DM6PR12MB3721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3721D82AB03523565F03644D87659@DM6PR12MB3721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/c5YRErVRl0AWVEf1t/7W/XzpiZCBoHRnjEWePQtqAM9De1igHtXl6qSkeePelaGXeflW7EpMxDYUt+Aggx1bjkLDl3I5VkWCVkDrVlrSRRyjLOjO66L+zaICic0FxBhYX19GFspoXjXB9FNR93w+pL4Ujt/GuoqGlE+7CeNrvOCBvLS3TTU+PKeCuEzHx+OVsi22ECA9bEvhac354AhjXQ2ksQEGI33di0+Xpo2FW6BNGqHTd2a1bcZYx+P2GOhnDWsbqLzt3Ra3YpxYgDAYJIpHG93tDijGlQHo3EA0D+7es3ytLdnieMqGfS0Wf2IrktWmUoXUSRMJ/JGgRvGPbVCdV46gXS8xF3SvTrRAEOmTHI3hkkz6pHGCIsX4L1+Pu2ecP+W9tJw5xQmtMM359totp90gOzB07cyMTfB3936udFBmdxl5jPl1Szk2y6uyH5X4hWN6C7ePZp5zR4gjQ+eZ67PdSSTb9TzbiXrh5uRKtYm7YszMjDc0YjPfZLH2DR/+uLez0hIPyLlL0kNco5HM7VQPRViyr8hte9a63soE5bksjPKqcIc5R2lCK1wvtezd8eH5/apIz2gTomBLBJjeMVIXetekpVKFW5b4i556Q2+CvbUDZK3gzbA5Bna3UuOqQSu0QVRiR2R7mhHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0057.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(38100700001)(4744005)(6666004)(36756003)(5660300002)(8936002)(6486002)(83380400001)(2906002)(4326008)(8676002)(956004)(52116002)(186003)(478600001)(66476007)(1076003)(16526019)(6916009)(66946007)(316002)(66556008)(26005)(2616005)(86362001)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?35h0gfIyTmHSj6Vw+vR0OKOEQM4DKoa5TJlD9wc7yAGPVXcT98x9n3sfhY+s?=
 =?us-ascii?Q?jaX81pGStoNz+6zodmmkRyNND0vVuXJ3t5pzigDJHGKcUwhfA8NKvSibIoBa?=
 =?us-ascii?Q?NpOQW7oXRCSSGeR311PKxf0Daggw0UZWGHGEFCmoN7383NmJ0P4RK+xoK90B?=
 =?us-ascii?Q?36iFgcUp/3ulLDXm53xwDps6PyWkt0dvlBRsalh2Ni0nq111qh3T1BB56c3/?=
 =?us-ascii?Q?AhigV3EmoTWlIkQpJqPWJrsMtLatIZx4djs6yZUjlPCStDk1V6CnTv3M5K4v?=
 =?us-ascii?Q?kmxPTxYr9GqB8Rdl4LFOZDxvcE+KHOUNYd/y1EQJGz/w2QH6h9iPWMdgoAZE?=
 =?us-ascii?Q?+mRRJ+56ILuT1LuKNg63anRA1pNZLD+5hn3Oj1T1ox7CdkLsdh0tMs/CQrQ2?=
 =?us-ascii?Q?Ayc6SWhnbLVY+HO3Aoe4iut4JWYezwNqLWIshJaBbpS6Ixro3c4wM5vwqM1Z?=
 =?us-ascii?Q?HekUQ5m3sZnwHT2c1c5b9N0fJwV4qKNki9w4huAo4NPBId+LUfyiN8+3iJ0k?=
 =?us-ascii?Q?DOq6zNgD5MR9U6QCrV0UYip4P30YGuAlj/3CDE1cu0cYdJy0OaiPcsayQqBD?=
 =?us-ascii?Q?U9b2DQ+8MriegDzlXsG1ULxQ5NXYyDQp4PKoSahezlCaO9M0GNxunwi3PDUN?=
 =?us-ascii?Q?Px4UplJQjIHTDAhO4BFWfc+ov0t1+dwHLos0fSFSUXfk6NUc4mCZvFh+h6jr?=
 =?us-ascii?Q?eF60j/cwdO1K6Ydz/im3J6Q/rC9mYz8kHhU8LpebxQc+sRRBc96w2xIGYl6P?=
 =?us-ascii?Q?Q3AkOlFmxq19c44qN5hHsJSycDP7PpOIEto6m9vj1vBRxTUET6/w6F9trHkH?=
 =?us-ascii?Q?1gC5JQSdVvpyzk08nlrpSjGdH7u+Eks0r7yqVJPyYHw0As9hedAqNKh7m33j?=
 =?us-ascii?Q?cpCBuVDmAj3q0CtkdbacNgJPKpCgqVAiHt+/HjtQ/G0xVqxOZm1W9gLko3Kt?=
 =?us-ascii?Q?kOXUGviOzeWw8lkL5Qty4nIo8e+DRwR2G2+3SWsQYVgUHIuKXRBAIBFM+Pi9?=
 =?us-ascii?Q?CAUjLE9GExk6bBajNF/X+TPq67vga1rqJ0yIpyX8RGMmBUoIJdUktC/ZQhDm?=
 =?us-ascii?Q?mpHzBgKhNI9wAt5XMEZs5L8G4Z9X6OiFe3SQKA7hpsV6WITm6791TqCm4pm4?=
 =?us-ascii?Q?nVqutitHw5qMQxOd9TJEqlA6JJBKXM5LduP9SYor2gai0apXhoYjXGIZNRHm?=
 =?us-ascii?Q?fCGbgyD1PLWS8jREA/W8l0H0gxV5vduW9Q1uoNEKiD/Br2IBFB0uHQCHBXIY?=
 =?us-ascii?Q?E4LAHx4lUHfUGRp8XgAfRpDCwj1c31LaFdNaOseSU9n6D0L2qs2fHzE8hqWu?=
 =?us-ascii?Q?YTflifhPZp35wQX3DMzQX98f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7042c36-c48d-4761-0bd8-08d8ecccf980
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0057.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 00:53:57.9705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ty9SiW9vQhQU8CeA7SQJdWPBZutYmPJJmzEtgg+oYbQtX/pjXvWDxeTuwczpwzL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3721
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To make size is 4 byte aligned. Use &~0x3ULL instead of &3ULL.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6d5cf0525325..41a4c456961c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1503,7 +1503,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 				memcpy(buf, &value, bytes);
 			}
 		} else {
-			bytes = cursor.size & 0x3ull;
+			bytes = cursor.size & ~0x3ULL;
 			amdgpu_device_vram_access(adev, cursor.start,
 						  (uint32_t *)buf, bytes,
 						  write);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
