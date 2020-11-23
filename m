Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692A2C56202
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 16:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92EF20717
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 16:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a0922xjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92EF20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC196E045;
	Mon, 23 Nov 2020 16:41:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1546E04B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 16:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYqmpzDWavegERVtaOMNOyYKddcCbBKbAIXDmnQkvh3KrcQH41jR+BgqFkyMnydDS/UKWEXI5iIXKderM1XbiypVUKbDhnRWGXdIis1k+8pBr0pd4QQSQMbnKrqp8q3qh01TaAGcssmXho2ahU0yB4X8wo8QivVLnu/htTRP5zyiu3M6pfaFQsD9BXHMqClSk8CMaNawGVKIbVbjZah/aBp6UnOKtZo+AoZxjeNLLHJt8xgiU/SGxVAYjIGoKJQCeyum3rVt7493WDCHNYfMBCENMFHu0lXHy0nkMUySYDNzYxhzHBBvINsZHK7flpimd8CuszL1QK7iySXBYsatyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LprIlm7q2jpNxMqGkiuwCBzL6OcOl2ltyrqUofU07wY=;
 b=R5RRU/wkjHk46SlDv9QlXtWn8qNNwid5jrgKPXhWuJ5bEk4uvvPnOZjCUFIfJb2VLHWZuJlTPStsUpJpG0JsrtmR3tGTuNhDzKlpO3ACocn3I4Buk7Ta5K9Jyx5xznvRPoyi7hE4q2nNOgA3jSxRx0utLfFrcqrFpWB5kEHaC5uiB6wvJyEtRVN9yfi8JA+QXpgeFiME3f9yvfQr2ggv36eQmEUOP1uj+z426yurdcb9DxuTWvloM12BR/leFbqyfGmOpGyLFtgmpUkw3F+/SY2/bgWZ2j+D7wYq7u9/9/yxJgBfBV+LqTrbhSQeh5HjsUQM7eEyBvEEkgXbNsijJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LprIlm7q2jpNxMqGkiuwCBzL6OcOl2ltyrqUofU07wY=;
 b=a0922xjxWlaFemislegWXl3WsxQ8vLWCnWCEEC1bqwG41gxThHlrCPkRBUXzX+LYigmI8yoiwU+9nkiDGwpv89SkAuqBubK6jhIzpIm9CfAzi35LvL06Yx4QgWQIVq8mYP79F+OzT9PopnHMNt2o0yiqlwQ/gag9pevHz7/WTN0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 23 Nov
 2020 16:41:03 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::a468:7e14:5f23:d814]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::a468:7e14:5f23:d814%6]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 16:41:03 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/dce_virtual: Enable DPM for vf
Date: Mon, 23 Nov 2020 11:40:48 -0500
Message-Id: <20201123164048.19583-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: CH2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:610::14)
 To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 CH2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:610::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.9 via Frontend Transport; Mon, 23 Nov 2020 16:41:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: beef6fec-f4dc-45d3-0a67-08d88fce914a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2812804E1E651ACF668FBA6CF4FC0@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PuqEKMYxYKUjlgmxDnS0cvWo5OlJkgVCZs1YFN0aY7wDU3mYUKOhT2nLtn8JG04MCpglP4ie0NlVh9AH6fZ8g3scotbId9OJb25/KmQj4+QCqNWwPrTS/ITZDXhBHwN8LCQ34TkzQ3uXBd14vkcj8w4Q3YajwcrajVAZb+oRnX8Z4pu4ikPduyqRG2cOAME9tOxiwIL263PgdjMHKdvGxElzP3rNPB0KX67U/qhlQwMe88i8u631kHM/xS6L5zUGw/iqNIzI0rwJ9SrtQ8MQKoX9LplWzCkUDMxSphkYQmnv0NxN4EHVZRgKNRN9w15y4d2rXOtLy5mfZUu1KpeS21c1YM9KW0YAYJ/vwTauj8j5JlfO/SbzJJCEacYwSSD1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(26005)(316002)(7696005)(186003)(4326008)(8676002)(36756003)(52116002)(2616005)(16526019)(956004)(8936002)(6916009)(6486002)(83380400001)(1076003)(6666004)(86362001)(478600001)(66946007)(5660300002)(2906002)(66476007)(4744005)(66556008)(43062003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WtHbpXpSo2N3PiDLzpSh5+5txk1dO0w0gbALTnO8k5kl7J6dLLpOpB4oYKAps9bOr6s7PfOGwZcIqtETwuopSoZxAkT6bKrncnlxU6COo7Zj8X4AzYJ0dsUDEvhqcDN6reHHoGLYUgTyIDjSxsh9SykuAlNLisfFqJtGya1CpJjw5g7eljSSl9+DZUiujm8NinM986hji6K6meZ3ZJlOJ14lk92Qge1nr3NZteAm2N5exhhFUdjajSR9HZM1oZURcwg70PIyeWyXSkGw3JOy3HF5yzH9CrQPOzkkN5QkddmLEyO5D3+q4O/fFh0UAt+rdF06J4h9fEmTmZDnD+jLpWBW2Yy3wEDZckZVaUMG8DP6ZjP49und/rjm5xpAP16jjtJRjC4PYBKLtB308nkHPnfK6Q0xA3Tiyu5+9ghHYWeLsHftd4isE6LvGGCjrRjD1sKDu4gRi2+bV3xru6KOFxBec4gUeL5o3fYUnn0ni1zoo8owk9SUJJ99Byo/w8m8ClLpf8UnXcCxZGYEpKI/BtYV5PzXVj8bbQQzbQRTUXHmbY+LDOIX3wUIrfgxHSC7k/yuB3hHdRXqct4hiCq2H2WbT9ZEeaETZNXR5zPlImZizY+ntKof3Ybj8dfAoki35GM9La2fzOSy01DsN32p4QScRlJ6Yt78H5mykrBEFnGJmfxYShZqigIwFwpzXm/tCelBDmmhU7Hzxmqz0OxED75zNBtiVuLto4dpW+xanlS+VQjwjRmTjp2HFdwQuWut/sH4amiR6vot7zBFrxcduyFWAriwtI8NDILY44Vg/jARixJrlM/cPhSGk+eycoo95Xb02rFHNIgUb0rNE45YWDKz1RBKkVxEIHZ2pltEw2n2HUHL+dfckqM6ZbxCrIqquOXlqkoRTPV3C4wj6v8saA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beef6fec-f4dc-45d3-0a67-08d88fce914a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 16:41:03.8047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyofbV8o7VY7vOxEaESG378GMb9KVJvjLFz7LD+BqQzDx9dVzuYOhK8f7yijaxS2vkiSiuKQYI2OPaBXaFoaDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

    This function actually control the vblank on/off. It shouldn't be bypassed for VF. Otherwise all the vblank based feature on VF will not work.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I77c6f57bb0af390b61f0049c12bf425b10d70d91
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index b4d4b76538d2..ffcc64ec6473 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -139,9 +139,6 @@ static void dce_virtual_crtc_dpms(struct drm_crtc *crtc, int mode)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	unsigned type;
 
-	if (amdgpu_sriov_vf(adev))
-		return;
-
 	switch (mode) {
 	case DRM_MODE_DPMS_ON:
 		amdgpu_crtc->enabled = true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
