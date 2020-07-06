Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1328C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 16:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6070C20708
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 16:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hPGZjnbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6070C20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B776E119;
	Mon,  6 Jul 2020 16:11:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FAD89FCA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 16:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwJw+zxJyEmKEZnqJ0t4/hMtV5DlcgbP4neuMXXgyPs7o4qzKqQTIBoQjE5AYt3I+hbEYekQnYNEz30Ol3F/YLo9W4aaXgWgPpaD9nDJF50DEPvF8v19olk4pby6rfI9VP03VDNW21pBjr3n7SOxQYP9I/bJ5UoBEtD6c28uCPGiS8HS4hKYOSZYiOSplOp1cXi+jb5CTBDpqrwfhi+F5Wq5QkbV48KbM4uF2iFwrkfQ609rRnSiitcdGK6iATCncZYMm9ELKuMCmEOYhjmWUu2PZv+oMIlJjOFVe0KWO7TCeQIlDOksllHsk6FO1StZTXUbIQOJJp+IpWQs0ADyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WVMypRt10PUUtTwxaxdnQKvDCPDYazekrgXNsGa/H4=;
 b=K1uw7xoC8f1zHt1QYlDMhbiKFA42KWJmJjnWzYSJsXj2PLIDGSPMF940CaJHvWlqFpNLAD8vptJ3JosCtX4ZeC5zXGFxeYJQWmvCZHU5NcwuYfG1Ap/BOPWVGGHgZ6VacB7EBmkh4Ns9n2RQThDZ/azOrf5OZuwAdF5eNf5pKo/EdCo70a0/WjsD9ztdS+IWi7qGLFFypYgxdWclXfVCoASUgM2QFlyrSE/1BuWR4giY/VLfeH+a8tvSJFLXiMp85NFFYlRmLjemZB6KwPbuzl1kNdZvqFlWyhRa9kElxQDcr/8Y1YnEQKZjnkewvoRBpwimZU53eVkuvn0b7hwmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WVMypRt10PUUtTwxaxdnQKvDCPDYazekrgXNsGa/H4=;
 b=hPGZjnbwalD016P74KuOzSveoNjkNz6X57w7WpE1Y7rBqaE8pblwNZ0iOlMFYSwXBdJGcQtWpQgHiOOdKbQCB7vdhdRW03TcEtlXwzyx15tdPVs2rAay9RgKL3C8WocbW735tQF6SdxiHbAJfx3w4CqI4vqHhXXpVJQuNjM0rTg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) by
 DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Mon, 6 Jul 2020 16:10:58 +0000
Received: from DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::5894:5a7:8db9:327b]) by DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::5894:5a7:8db9:327b%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 16:10:58 +0000
From: Alex Jivin <alex.jivin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Moving out the mutex lock and unlcok outside of
 the "if" statements
Date: Mon,  6 Jul 2020 12:10:46 -0400
Message-Id: <20200706161046.8063-1-alex.jivin@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: BN4PR10CA0019.namprd10.prod.outlook.com (2603:10b6:403::29)
 To DM5PR12MB2422.namprd12.prod.outlook.com
 (2603:10b6:4:b9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alejivin-ThinkPad-T495.amd.com (165.204.84.11) by
 BN4PR10CA0019.namprd10.prod.outlook.com (2603:10b6:403::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Mon, 6 Jul 2020 16:10:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7290bb1-6f0e-404e-0ca5-08d821c72b97
X-MS-TrafficTypeDiagnostic: DM6PR12MB4060:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB406041DBC61E7CD61C9BA62C91690@DM6PR12MB4060.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCEvEXq6OHnt+PnzZO/nfeIsPQwMJeEaCae3vl5XFMj68zdJErio8+IYalWZZiZBDsfzj4KhEm0dN6vVaKOVc7N9ALK9ExSiyofCegJcto7CFEvETva3LJk4saMmqASgkFSwNoNofjDs18MLl5wCxM0ZKp5rLE7hs9Iu5HsKp7UAwawm89mkyq2IJ/WgtY40EneHOlveB8KgfxE795oJJVwvM4wFg9CY3NggDhdSz2nXu64HEaISr8rBYbm0Hw+mfrBDJs7NLasnJ4XHv3Hj8ynOcsS7Ea0lnldGTDPT0X+LsxD2MIT/uivwduWMdnl71lZFS5b5t6gSKMHw4fA2KX7QT3fAsFYxCtrkrPMD+gx83xfowTDXqtwwSQYTDNRM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2422.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(8676002)(54906003)(66946007)(66556008)(66476007)(478600001)(316002)(956004)(6666004)(2616005)(6486002)(1076003)(44832011)(7696005)(52116002)(6916009)(2906002)(26005)(16526019)(4326008)(186003)(5660300002)(36756003)(83380400001)(8936002)(86362001)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +rlBehV65B3n7c73Rbnq06A1yXbmGnb2KO/3ly5NCJ290qia5aAZRfK750po/bxY9V425dL31fs0bKZSf2db4gcWBqmid4KP6qE2pknx+4NvZ4wyknf1AfbsKuKffumFuka8l2JFWp0puJ8XI+JkUKyRYUFU+UDpfxE6Z5QGJghckuMsdNmgdh8zTAp2hNOqxbGnuTZDf1M+bQodPyB0GCPtIkx7f/ynZDrDYLOY1cGl+6LHqexmUiZXHNRiJAYCmffxhzrmEs05Z62pdKu33yKH8AMxqfGheVZjZjKZO5ruk7q35Mh7t0UT7sKdhMFC70XRGQYfDPZ9+aOgmOTIdLnpx42yV1XxPx1JnQNvgzC7/8Lafd7k+fz58YYW8j2GBMHaUAOX668aQCrTaTsaQvXsf+nkkWAuPB2qq1jkG12pQLtZb987urbLGPzqek6ydbrkeLVVPRJ4j2zvD3Z5z1oVPmyCTKTQL8UfuN4A/PM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7290bb1-6f0e-404e-0ca5-08d821c72b97
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 16:10:58.8032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHxpNT2B54zdv2o3SwVf9WSq65r0DrvZa0x0O5vEDKg4aiiov01lmgrS0wIVqvURd+OhqPlMfoLm1tbtwR5Zfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
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
 Luben Tuikov <luben.tuikov@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Moving mutex unlock and lock outside of the "if" statement as it can be shown that
the mutex will be taken and released, regardless of the value checked in the if statement.

Signed-off-by: Alex Jivin <alex.jivin@amd.com>
Suggested-By: Luben Tukov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 838d6d51904c..d2401379bd33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3559,16 +3559,14 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 	int ret = 0;
 
 	if (adev->family == AMDGPU_FAMILY_SI) {
+		mutex_lock(&adev->pm.mutex);
 		if (enable) {
-			mutex_lock(&adev->pm.mutex);
 			adev->pm.dpm.uvd_active = true;
 			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
-			mutex_unlock(&adev->pm.mutex);
 		} else {
-			mutex_lock(&adev->pm.mutex);
 			adev->pm.dpm.uvd_active = false;
-			mutex_unlock(&adev->pm.mutex);
 		}
+		mutex_unlock(&adev->pm.mutex);
 
 		amdgpu_pm_compute_clocks(adev);
 	} else {
@@ -3596,17 +3594,15 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 	int ret = 0;
 
 	if (adev->family == AMDGPU_FAMILY_SI) {
+		mutex_lock(&adev->pm.mutex);
 		if (enable) {
-			mutex_lock(&adev->pm.mutex);
 			adev->pm.dpm.vce_active = true;
 			/* XXX select vce level based on ring/task */
 			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
-			mutex_unlock(&adev->pm.mutex);
 		} else {
-			mutex_lock(&adev->pm.mutex);
 			adev->pm.dpm.vce_active = false;
-			mutex_unlock(&adev->pm.mutex);
 		}
+		mutex_unlock(&adev->pm.mutex);
 
 		amdgpu_pm_compute_clocks(adev);
 	} else {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
