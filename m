Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A135C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 07:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114412084D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 07:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Grvg1hoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114412084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DC16E134;
	Wed, 15 Jan 2020 07:08:50 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700054.outbound.protection.outlook.com [40.107.70.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025C46E134
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 07:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USMumtid0vfdEfjxWsYxs1J/gp8VvNGBznYJL0vsRu1I1kyM9t1W3Hj0fmBbz2SuF58kHZg2SS5arGfPruC6WSapNgPLMExmM3ZA4gw/QQfxB1YAb1Fe4C9J035N44uovlYaZxtSjR8TRQbYI42Wsds2gxZIy8eu6fcONI8Ycp0LIg1x9+/g+nUXQ+W1pqz/O3XmTm8DeAzcH7CFlUaDrybCCAFHgl0jdhbhdRFoDXldtPheMzldGbVx26hcr5by3T7Gb/Sg1CONAWnl7zUXgdRwoujRHf2pf4J/WW6MLr+094125hZ6ZDdC6tgTbMCfCr+X225logqVSvpjXq7yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlmgPQjiPVzED6aNgih4im60tqr58MxxkW5/IVauKmM=;
 b=g8DK26rWXnrLWmqKZtMmI92vr8vYJFt1SpgES5pYj+E566PXGv0bUIh5mNjONDiZzLzKyJiuQTs/4Pd7cIY9OUxGVpueZ3zzn0oDKoCllGweUyXe7ZD8WHILFVeN1p72q6wKh9HHsc4+PgY/+OpG4vYDHcJr+RgJryCPrUmOKM1JEYn28YTZWMNaXJ41D60fFC/jhg/6286V2OyzZ+6UpJIPuNNy71kCleZsvd0Bye/aHpDDAqHX0oy09iJPVQZy9VNl2ckFKYzhds55Tih2jQBAKh8oyPX6PhY5YDYZbdNxRis7z58fdp7fVl7Xm6175ypDvTQwvG63W1xZn6Xlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlmgPQjiPVzED6aNgih4im60tqr58MxxkW5/IVauKmM=;
 b=Grvg1hoa+vdMBfVYQdTlNfzfMOshMACLNfd7t24l04zxAgbx6EYSGJJthI6WBLqY4KLuPnG9d1WXwqvVtxnRMprAzZ8Jk9Iv/u+NRFOSGLf1e2612PJTqTQx3WWsDSL2ERMKZerJK91tr8T/EB3q6WHMfCAJN/ueaTPm3udnWzI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 15 Jan 2020 07:08:48 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 07:08:48 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fill the alignment for secure buffer
Date: Wed, 15 Jan 2020 15:07:45 +0800
Message-Id: <1579072065-10883-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2644.18 via Frontend Transport; Wed, 15 Jan 2020 07:08:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7f61342-796c-47c8-4259-08d79989c418
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:|MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40480913241F7B05A4B80F7BEC370@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(189003)(199004)(81166006)(4744005)(52116002)(8676002)(66946007)(7696005)(66476007)(478600001)(66556008)(5660300002)(81156014)(8936002)(186003)(16526019)(2906002)(54906003)(6486002)(2616005)(956004)(26005)(36756003)(86362001)(6916009)(4326008)(316002)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4048;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fustscU8KXSZhCEIGdHQwYlWJrZDWKQKSk4ATYcnH5uailPXs7Ax9lBTOhQpmBDLNGBG/CW/BDKnaWWojmNiK+8xSWOBagjMMBcnZe206FLPKCDQFu0CBiBEFwW2uMQAHbFyLtM+3AAMve3LjIpmR4yLCzSFzXg0Mn7oTGCyDKuNjyXSmQkeku2nxexL+/ejZLElryj7xAsSzTw0dZ3ALDT2RfN1k1LaVYYWNY3sGRIaVxjUZZSelLULfPG00d2dGST/gIzqqSDnx1X5yAf7GTSIoT/YWMMXHZURPCkJwU/w2aoMMDbpjTQ3t3jDVLIZpNZ8hMaY+WcRc4oRdWAObp5GMuGuV7lQNnGUwTYZ2R1QWHkBwY+r86YJKaf2HV3qmH0V20HPDRzrheVOVSx7DIti9PGshQGriZtAdfm4tOqdYc8+M5C+Yni0XxwQ7n49bpI1rzKGygQEa+8NDAuHBbwim2CFSjjzqM8jb5WlkTfQeAW/WJbwrQbMnUNaVb16
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f61342-796c-47c8-4259-08d79989c418
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 07:08:47.9635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOzsr5tAt9wfWU+QoMKrqIqQD4UevIV7tQXie/Ej5SBkn9S8w7z6gKtlwlefZ1stsVXol/7qBMiOZlengavatg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The alignment should match the page size for secure buffer.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f39012e..a03eead 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -261,9 +261,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		resv = vm->root.base.bo->tbo.base.resv;
 	}
 
-	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
-		/* XXX: pad out alignment to meet TMZ requirements */
-	}
+	/* TMZ requires the secure buffer to align with page size at least */
+	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED)
+		args->in.alignment = roundup(args->in.alignment,
+					     AMDGPU_GPU_PAGE_SIZE);
 
 	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
 				     (u32)(0xffffffff & args->in.domains),
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
