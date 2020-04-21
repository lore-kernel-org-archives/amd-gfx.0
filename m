Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5024C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7072076C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ri6f3gEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7072076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 426EC6E885;
	Tue, 21 Apr 2020 05:24:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65CA6E885
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 05:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki7YeI6jVtpkC5AhDF4yXLvQlNZ/2Y3WvYhWLHg91QxM06QFSE4cYcir20MLTEvVH53EY1V9jdaprEj+9nKNyWSYppJqsvLXyYq1PIm50XM9FBoWp8TYY1QEEFk9uSNyTfdczmdA/E624VgOTiJ2xcxD/HIk/h29phDOxh+FGHE3AiSzdRCxBRsStJh3K69CD01MzRYWrh39rAS572NkgmRbkmzdpOVeyWzzuBr1/0CFRlDvklso58Sanmc9jxfcfL7bQ6j4Mvd3wES0ua8+mg6mG3AVu2J7cPOlqBUNWmBtB/ARK1TpGZCvdxN8Yis3R372ERD2Cqt3Z1WRDP9WuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBDF91KjlGcroTPd3g+SRolQCGFWH8FrvP/yCU2qrfw=;
 b=kB19v3AtFzWPh9YOxDxk9dWFFsVRL+yFx2KChWM5xDU6BJpN+s1kpEBAjVvcej8Nz6sncMhIqhptP5nx74pNy5rIGcGTixMRBKjSao57E3Bqdmi7DrrHmi0JG3laohxqVGey8ibua3vF6CmRsGMDTMgLVWiVmh7Fih7vNn9ES/ad+1XKLwzVsQ+u5cQCvBoa3FXt21YSvHj7p8jkFdye4e65BW59bzIWzJUogMWPncyf+6htXcAIBVFv+6e4hE+449d3UWCCZdUJQY/U4sEUOaT5wj6vNsMYFHEXKU/jP1R1ewlGmcu1nqv2sT0FkXXKTx0jY16CG/FXN/np00NG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBDF91KjlGcroTPd3g+SRolQCGFWH8FrvP/yCU2qrfw=;
 b=ri6f3gEJk+iZp5X50F3fHq0OauAYPThkuSVD5ArE/r/yCrLMjYskekIycscAQmRRHRB5bY6ghLvlZvRTvgIRuPf5GnMRRFgcvyi1FpJ5p0sUWrrSGbOuK4ad0oO0fHWaX2FNkJ+Jel+V8tU0nH7kw2B5dogFpFcX9mlzWnelM1c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Tue, 21 Apr 2020 05:24:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 05:24:40 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: correct cancel_delayed_work_sync on gpu reset
Date: Tue, 21 Apr 2020 13:23:40 +0800
Message-Id: <20200421052342.23037-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200421052342.23037-1-evan.quan@amd.com>
References: <20200421052342.23037-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0006.apcprd03.prod.outlook.com (2603:1096:202::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.6 via Frontend Transport; Tue, 21 Apr 2020 05:24:38 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d5a3fc2-39cc-4856-f4b3-08d7e5b44a71
X-MS-TrafficTypeDiagnostic: DM6PR12MB3164:|DM6PR12MB3164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3164B80EA2D804F6B6150DAEE4D50@DM6PR12MB3164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(2906002)(2616005)(956004)(6666004)(44832011)(6916009)(36756003)(8936002)(81156014)(8676002)(86362001)(4744005)(7696005)(16526019)(5660300002)(186003)(26005)(316002)(4326008)(478600001)(66476007)(66556008)(52116002)(1076003)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLGG+kXlGCCBJpoda9E3r4oD7TAhPzwhzsGEM66triUOt9IlYEJ2gCMu3nUP747cUFmTUoTdF8Jqs/nh4JQzqM4R4bQmYM3IM8RNqOTRY0WzKkuQc5a4cnPoiecNovrtOittIGn/Wmw5KywCehMOBL+kmQ9G9CB7b+ZsTt+kSYUMaGg8jaR78aYYx8aF9/dfJPiYZaCzWdDt8q5sv90vvgPoqjxMWl/xKhHLTqi0TMGLZ0adxSmx9Zesdczs6aUTWgZYpOcLhm6a4k/SQiVo6Pb56P+dacW3RzNh5xxbqh1V/uEGlFH2o/Ms98jEOWXeoP6KyHhUTc/5RpUTZdFcghYcmnT+CtcoMgsoZbPMpxGpU0Vw3mECaXc2zVGtY/w5Neph1870rwMYi4Dlvy5+QiY2/TMWOiIdRzJryZQ1kAxOayZK0MLGyDQGDUnph98G
X-MS-Exchange-AntiSpam-MessageData: 6U4jqZzbHhf0mcrmq4Gb38dkWhCSocwd2i6r2E3+HipF5qyRSZgmDHM0+CWr/gU0ju/11hyL3ETZAkasLIxQVeYIBy9V4OFKHyYSNX/4zEk4n7oTOZ1W/XcWDJ/bnZ/Hlhp4rPmAFxoP/mVuU0tWPw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5a3fc2-39cc-4856-f4b3-08d7e5b44a71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 05:24:40.5948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23fN8afOkFuiqiUpxfbqXyBLt2TsxTqgZ5tIH40bWym2yhngsD5JX5q1vQUUi5Al
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3164
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
Cc: Alexander.Deucher@amd.com, Andrey.Grodzovsky@amd.com, Jonathan.Kim@amd.com,
 Evan Quan <evan.quan@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As for XGMI setup, it should be performed on other devices
from the hive also.

Change-Id: I08554c27216efa21c2c46c0b3379d856b5264c9e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6cbe5140b873..c8fe867d6ee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4248,6 +4248,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			                amdgpu_amdkfd_pre_reset(tmp_adev);
 		}
 
+		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
+
 		/*
 		 * Mark these ASICs to be reseted as untracked first
 		 * And add them back after reset completed
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
