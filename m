Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CFCC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 04:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6476B610A2
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 04:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6476B610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF2C6F5B1;
	Fri, 21 May 2021 04:08:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946E06F5B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 04:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZBGdSU2vpPerSN11sojCkINzJX91hg69U7X/9dX5q3EsFPjll1jpHnRCJuRfPSlv3XU8/bpP0ZKbGCE3/DrZyeTIPsCfvad2ALWxFepi66yvmvV58XsEnGPu8HZ2EVxCnkoerDDPrxiF6wGQfZ0w8UFQKXr8VBFFdX3LymwfSp9C2dSHS/IvkCdk03a1nySjw1xzYPWag9gBeEU1+pkXpwbt9f3et0QklcoHbxkjcNh5fS0nFBv6VLDGNhIbC3o0+8rAUygZiMfPvektGdA23uYgZbl46pnRr2nhsxl4fpcj/dQZYE5jxP4xVOQz0GCBRW/P5bzzlDkr9WIyP6OOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUinckNI7SI64yYLHp52dHqAQ40qM4Iio3nwp8IVcGg=;
 b=WjMlbPp389zvqQzE+RIukjGY5/ajP31JN8mD06EJmMGzo+hIcnq38jQVDDO1Ipbpe6rjt2rf/w8FyON2+uAyVZa29mnjv874UyYITvcE8rQHk1sEk0J+mnxBpjBfBwI1f6oKm7Wzrr3siPQCoO+tFli+ruX5KNJpApO2nFQAoJ1YqHrM//RiWngt5LW8TyOqt3Q0taYMDb1KFcMfUGqkyMsezq6JOSsgZJPbFu8fn6aByKSfCKdTdWUKHZ0I6xCKVZZIsAQLWrb9GyuNPK3o/ItPi4HoRmr3StFl7aeyZnkWMbF0Xk0s3xdn3cgHrCyeQeIB8ddzmyfYjj7Ma2Zq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUinckNI7SI64yYLHp52dHqAQ40qM4Iio3nwp8IVcGg=;
 b=BA6YAeaJPnV6ZGcQTbBEKNqNG+oXQO1q1RyHc2JywlbcBZ3RNZUpxHxMPDj5vJkD9HMeFocZbEI5+zU4TE8pDMr1J4jdmf1NTFKRJMkeleJinaUK2Fu+zHHZXbX8clKoQ4AyRnjpuXFb+BGePeQGwqZ2Tt9TdmfmL9pB6XjNW8Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 04:08:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 04:08:34 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: make backlight setting failure messages
 debug
Date: Fri, 21 May 2021 00:08:01 -0400
Message-Id: <20210521040801.1530064-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [204.111.139.213]
X-ClientProxiedBy: MN2PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:208:234::22) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (204.111.139.213) by
 MN2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:208:234::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 04:08:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0f50c1d-71b5-4264-9984-08d91c0e1a20
X-MS-TrafficTypeDiagnostic: MN2PR12MB3759:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37596695353E15C7656D91A9F7299@MN2PR12MB3759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGFzqzHbUmVFT0RHgTkl3f6WxJhmXOg0NzrAD9hj4BqF9QQL4nysDgoUxnhDMFNnx67oiAT58iOvwFd44+2IDF1UDuxf0cYHuQqhhgDOE/oKPQAAAXrAIbfn5zlD3odCUyU3m3lmBMQ4nB5aR5Jg5OC5CB+PVdNDl2rAW0mHaHUQLhj95ufsmwOwBASvYyh77rSIzmL/4P8kOCdwaekMxiek8Hapm1cfGVHiC/7c00d1+e1osWEXn+4XLPyDK2qnFkkbCcoz8+UBXHYYa+4ENuIHPTyplo/++JE51n/z32L/+HIB8wTLK8LYBzGjyS5VO4/mf2grh8UccSgZr16KRX4wodO7fYsnXBXtWH0wARKLRCaikc/o9bCeJ9fWIEJfo0gmB9B8USYRZnHiQxEnO85xYQzS41FSQpx+ZEC+M0EORHHoSyIJMMKiCCHPfwA919+pf/ZnQmCiaETmvU0F3TC1Xu8wQ4dd0NpGWJFmgxCT/jDIMtQEW+E+OFVUmd3FmKw1zNiRVVMEG2GgMgr8A6W13a3dA3AnN7IZi+UTq6y7IgEkFDEq9tMENRsDB/uKZ00x6pPpso/OHNtG6JIIeKI8wK2H16CXkscVxHRPyMc2+U1xudwN4RUS+7ZIXQnahDG2W1K/K6/sHEFAWwbq7TfSW3DeCulLtQi2sicoFN5X5Dsw8pm/zITjNmaRL1RS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(26005)(6512007)(86362001)(66476007)(2616005)(66556008)(66946007)(956004)(1076003)(8936002)(478600001)(6666004)(6486002)(6916009)(16526019)(186003)(4326008)(36756003)(8676002)(5660300002)(2906002)(52116002)(316002)(38350700002)(83380400001)(6506007)(38100700002)(15650500001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PauVxe64JOvilExs4wYYZkofHRp63p6eTbuxND3yWCCdBgMgP1Qs30d0aVu+?=
 =?us-ascii?Q?56XSINRz7xGOV3iMkVaITW2ch30jFqJ2BtaLgiADIwYsUm3wZE+eBtcnwXJG?=
 =?us-ascii?Q?g+MUGrdjNVRrA45CsWpQW155aEITQuf3LyHKpZF86CitO39D6vZLmENw/X1P?=
 =?us-ascii?Q?5wSaRsFYRiIdxbxeFR2TmmtZlaJeGxQBcD4HMBDnlu/tfslrTtR6CzHTw2H2?=
 =?us-ascii?Q?by/1oQKHk9FRAe8jVqOuP6e0F++tjwhSTXci/fm5jsqIFayCNl039aAqBhRv?=
 =?us-ascii?Q?bSLrFoBIr/8zOGdzpNXACB2e+1BBeK4wIeGrAsnUOUksYTw3kufkC+t6Gfvd?=
 =?us-ascii?Q?R0doNGqAemxG9DLOeXL55r35/fb5Ylau0gpk3flbuTFJCJrO8MtskN3fna3q?=
 =?us-ascii?Q?c6U05fuBVHOxnUpUcWohHaSqvU2q2vjC4MbZaxoyPJNyWPtv2LGEZD4yM5Rm?=
 =?us-ascii?Q?RPWHCLhkkapEUfIUxTh60KeHFQegoCvqoN88Vt84j8vWjR3G+nT672uqwWzq?=
 =?us-ascii?Q?+5//9AnJywGJohW5w5kNV6v1jEFznas3RqnM9MNjf6TTK7lUGkm6Ri+dxZrb?=
 =?us-ascii?Q?rBSBg50besjhQalSUEEZaLeLFcz1YPNavrOZj5FQBMjvqqY/qQYdvQKXtztn?=
 =?us-ascii?Q?p1j+fRyPiLPWNPJ5JTOwXoTWg5VYgGfnICpCAJOS0qCrCK3SFRXcFzc0Cloh?=
 =?us-ascii?Q?QIBHePDhdBLGu3d+NPijKAYUjfX9PtPSg9Ic4XJgnDok1L/OTn165hej4nFW?=
 =?us-ascii?Q?6GqY1dt689Gs5avMz24CCJdku82H2UNkQT1ydVNUZYx2Zc7h5csL5XIFXuxu?=
 =?us-ascii?Q?AU26r69jx5rXE5EdZBirVgXAevVq5nvTgPcJXue0S/V9DCOqXzArr6T1AhVy?=
 =?us-ascii?Q?EHe/S7f/pGT07mtpPi9AjiLLw1ngjXaaZuUkBit3NVmZTYPMTn2WvOU1O0tF?=
 =?us-ascii?Q?emUkk92b95q+Wt1JPZ3JW3hoEH4jHgeEgLDTZAGNoZEjrSrlSHupNPMX2GYg?=
 =?us-ascii?Q?IX5e96mDmO1ozPbSKFbVMyd4bj1B0iXpJcWW9IpO94qxSv957p5dZDSZJDoR?=
 =?us-ascii?Q?E4gbrwOb0EsKc31ZFPiYoIfnSBMw5BguqTsR0nD3hB6rI8UK4WmlwEYUeRb2?=
 =?us-ascii?Q?N6DEV4Uc4/YbdxLmpw4c8ZyS905X8IEVxi0pWS840tBjlA56zsYMLOvZJqzt?=
 =?us-ascii?Q?VFUMlvpj4AwD3O8JqFa6ONNE6XVNxn3JZxI2AGQwz48i1BM7oHEoYt3ruH76?=
 =?us-ascii?Q?vTMEJQ9sfq8ufAHLpOufbFRvtbuwa3P1h/iJg2uRHLj7qzrMjzK7ieI4ReV3?=
 =?us-ascii?Q?/yvgmlsI+1FHPzVcx50YI/a4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f50c1d-71b5-4264-9984-08d91c0e1a20
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 04:08:34.4573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdjPzIJGRsOE1MvUQZaMzFyTfCJUHQm/Ub7iNkuKMmk8MwyaiAxzmA/Bmd/7uKG+rfxNQAlSOt9LLO2xwhqiRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
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
Cc: Alex Deucher <alexander.deucher@amd.com>, harry.wentland@amd.com,
 nicholas.choi@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Avoid spamming the log.  The backlight controller on DCN chips
gets powered down when the display is off, so if you attempt to
set the backlight level when the display is off, you'll get this
message.  This isn't a problem as we cache the requested backlight
level if it's adjusted when the display is off and set it again
during modeset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: nicholas.choi@amd.com
Cc: harry.wentland@amd.com
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b8026c1baf36..c1f7456aeaa0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3506,7 +3506,7 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 			rc = dc_link_set_backlight_level_nits(link[i], true, brightness[i],
 				AUX_BL_DEFAULT_TRANSITION_TIME_MS);
 			if (!rc) {
-				DRM_ERROR("DM: Failed to update backlight via AUX on eDP[%d]\n", i);
+				DRM_DEBUG("DM: Failed to update backlight via AUX on eDP[%d]\n", i);
 				break;
 			}
 		}
@@ -3514,7 +3514,7 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 		for (i = 0; i < dm->num_of_edps; i++) {
 			rc = dc_link_set_backlight_level(dm->backlight_link[i], brightness[i], 0);
 			if (!rc) {
-				DRM_ERROR("DM: Failed to update backlight on eDP[%d]\n", i);
+				DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", i);
 				break;
 			}
 		}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
