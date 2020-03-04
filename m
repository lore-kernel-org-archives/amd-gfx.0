Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15712C3F2C6
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA2F2073B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c8apNk9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA2F2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2727D6EAA5;
	Wed,  4 Mar 2020 02:57:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1976EAA5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 02:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaMMJJF1lvMkBj0cC8g5ekSs3oY1zwRK7afmDwXG6Zod56JuFpx0DcY0UxppPpu43PUFeoMEkvp71KQW1Fb3nahwgWMski7PLBJuidN5ZPO4L9Rf1S4biOqoVY9Xpaes1wx/G8VifQGuyX3UMEPXvMW3ADHBGadBcmXKrGsN7w12UU1iPlL9lQR3TISn+/iogkrpcYjGTksMqAd+bxHgQfnGsACPopshfDdvj8upn33Z/wbHvoz3EOGkECeAq3DEBF9gKxP7vZy9dWjt8m6r4c+Sve6xn7bz5+jjcrUiG18oGP8BSW40zR8PnEEk8hskiQJjgtfegTO/nFKBRuVIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72mR56VZ/B1s3Tqlw18EHUYuJkdbwRh/ZqpWhbQBnls=;
 b=fSDhkE6RtYYNrL7ZjH8Vz2kIcAprHsExnFE26yL/5bKrdB/q1sRowwK75hVYmYrvX8ON7PIoQ/nYdRUiDvfr5QeNUbxkjhO8IBWHYJsV5EDH/AsHE5z5yhplVi4XBBAetiydn/3ogdlFGC6yUOSR1zXyR9oXlC8y3nUzkeMAeb7SZVdtLkVIWShKe50DEIc1m8/QTpF3vr0fuWaOGYKzvBhztn6hphz3h5LayszlBlkW4qtFZ8lm0Xn5UeiyFB01KOm1xN9kpWqnNkmsS8LG7oOuoEE6XncXUo2UWpHkzCwNMhEyWc/38Gtw2KrhEnKMPMjageQYIkPbmult02U+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72mR56VZ/B1s3Tqlw18EHUYuJkdbwRh/ZqpWhbQBnls=;
 b=c8apNk9vc059AbfP/JXyli0tb2unO0ne7TwOaxxa7Vf6c8+veZyRZR56Ropqf5TP3Yhkjkry3pKEc0Pxg7O7JmqSrnhYhyJ+cyaoI+VIUm5lnnMeT3hsMPw0YVUh4p5ACEZJbYQE9VDB8VcagQlkaAL1rr5L8xIoqvkBDvxH+H8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB3647.namprd12.prod.outlook.com (2603:10b6:208:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Wed, 4 Mar
 2020 02:56:58 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 02:56:57 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: fix pre-check condition for setting
 clock range
Date: Wed,  4 Mar 2020 10:55:37 +0800
Message-Id: <1583290538-30426-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR0401CA0015.apcprd04.prod.outlook.com
 (2603:1096:202:2::25) To MN2PR12MB3536.namprd12.prod.outlook.com
 (2603:10b6:208:104::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR0401CA0015.apcprd04.prod.outlook.com (2603:1096:202:2::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 02:56:55 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a0b5b84-f8f8-43e6-90b5-08d7bfe7b3ad
X-MS-TrafficTypeDiagnostic: MN2PR12MB3647:|MN2PR12MB3647:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3647022B21F5025CD683A944FBE50@MN2PR12MB3647.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(189003)(199004)(6916009)(478600001)(8936002)(16526019)(86362001)(7696005)(6666004)(52116002)(186003)(2906002)(5660300002)(26005)(316002)(36756003)(2616005)(8676002)(81166006)(66946007)(81156014)(4326008)(956004)(6486002)(66476007)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3647;
 H:MN2PR12MB3536.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrlzkBDhBG42g8H1VKDxpIa23kN2NSZ48S/DvzC5Dq7km4UvEyD+r8RuHrXLBiJGGCVHor+BJpVqL00WOYzJWMz+bdMlstNho4gGvqfN4anngKmVCEiWQsNd+q9zRlZG65iVrWOawBPRRQnbgkiUnYx2cl8Y+EzZPNhJjCCv8xbBV0VsuvejhzJPM58yKFia3wSJ4ZUoqWVAx5di1/BvrqLuSXqnJWEwL6ikW8/JQYKCXpNvwq/vmCoGu4Ja4IXL2zSvgOlPP43EA9rbEHU7/z7yWE/f0u4tq2fPiw8X69GR6ndO5Mv0QX3QSvWclqe8jgXGT8AoRbfBrEMw6QBMHv+s+tooD66UbShGcbha9jJK0U+KG3o8RB3jWjqJow07kjx4R5NFRbNIXqcUaknCtI6SpbjEg2o6p/TBA3dISc6X/Iluah7Rcg9+xsVi92RH
X-MS-Exchange-AntiSpam-MessageData: kFp2FP2j1tqf+VhXAQlbTl/wLemES+EXQQcHg5QcQtj/SOr4wSL6s2f0hy2tR4H447gdvXNfA28U4FpODU13BhiNadochkIA4xZWMu9XBD0wvZh+ei99NRzZG+cTq/MptoAtVGna8OSMhj1xHcIOYw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0b5b84-f8f8-43e6-90b5-08d7bfe7b3ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 02:56:57.8506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9Z6n3Tpsvb6Q72I/Z3ZW47WE24Bg3RC1d0oCRnjevVOJL8jnQ/ryL4vI9kfQo1/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3647
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
Cc: Prike Liang <Prike.Liang@amd.com>, Evan.quan@amd.com, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fix will handle some MP1 FW issue like as mclk dpm table in renoir has a reverse
dpm clock layout and a zero frequency dpm level as following case.

cat pp_dpm_mclk
0: 1200Mhz
1: 1200Mhz
2: 800Mhz
3: 0Mhz

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c  | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index e3398f9..d454493 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -214,7 +214,7 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 {
 	int ret = 0;
 
-	if (min <= 0 && max <= 0)
+	if (min < 0 && max < 0)
 		return -EINVAL;
 
 	if (!smu_clk_dpm_is_enabled(smu, clk_type))
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 93b8558..d52e624 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -461,9 +461,6 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 {
 	int ret = 0;
 
-	if (max < min)
-		return -EINVAL;
-
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
