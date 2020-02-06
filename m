Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D11C2D0B1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 08:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5993620720
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 08:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="39/pM0WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5993620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287F76F9F2;
	Thu,  6 Feb 2020 08:19:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026826F9F2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 08:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRIJ3PI55LjsJpmfkLhmgan67jPmx46+iLPVfn0rloAPwIBoUUHkuznh+TPTZEW9AyolaEGKQivIycB8b+tcpcn9m9T94TzVYVmw4vyWks7hiB6JW50s8V8e1+tyGzLcHh3Bh4hyqcG+hwmLckw5x31FAytGviowXmCI5MvKlE499gjX+zSC9W/AYMi+j9vK5NxqQEqlFvdw7y1yb0+lYjYtnUUuj83Gwdu4iB0E7KEMKkEW/fKhrrcUF6Y5BA2D4Vs9GpQ7LPEIwKW3Zv3o2TD3M/EH97kfoKWsYQAt/yzPZygVHmGcYY4Gkr5Y6fqdJ1M1h+wMurZw9WTIXghNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZckE0giyKTNx8RmpDSofZnyipqeGwP7EtkvFJj//4I=;
 b=VYWFOcqaLZ0QaWvFFEP/VJnxjVrcCbGFpnXDC5pPHyRFeBunmNqmrfyL4exhwrAViCDMnRUFsFSjOJ2042VIP9UB9SjdXv4VmVCvoi2+iWfjE4aFqQX6GH+rC7pRjbSRo0Oz9yPEYMeU5ngqzZ0idi3K2FgFEX1YO1yBHNKF3FO8U8XMtudnc2ZBXB+9He5+Z+VbttG/ePrHd0ypIRPdDVbzSm//UnqBrNrf6aX6Wgg6cgnbbYmerFWmK9dsZjztldNz0mACMktmu2l7yza+GIS5FMaktLrI/R4CpnK0Xs0S6rpaknPI4r602z9dyMWghM5N3/vy8Mowyu2zPqZmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZckE0giyKTNx8RmpDSofZnyipqeGwP7EtkvFJj//4I=;
 b=39/pM0WNrdVMVVnqLILnnKsLKFHeGgrMhP3EJr2Ze6l9Az92izLLydZ/vOIt6iqkMv08xIVFmQ+rsXrcRqPF0PUJgqLVB4f5UAlT9ei8oTlXFLn/mkfa9jwhhhIyf9QRtS0FD/t/eW/xF3RqMpAtc46tEmXkgUe/jMYGCgJOOIE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3440.namprd12.prod.outlook.com (20.178.244.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 08:19:44 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 08:19:44 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: handle features disablement for baco reset
 in SMU FW
Date: Thu,  6 Feb 2020 16:19:20 +0800
Message-Id: <20200206081920.18766-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.0
X-ClientProxiedBy: HK2PR0302CA0010.apcprd03.prod.outlook.com
 (2603:1096:202::20) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0010.apcprd03.prod.outlook.com (2603:1096:202::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.14 via Frontend Transport; Thu, 6 Feb 2020 08:19:40 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4efabdc2-4e23-401e-8470-08d7aadd510b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3440:|MN2PR12MB3440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3440BA32828B9C34E1221807E41D0@MN2PR12MB3440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(189003)(199004)(8936002)(956004)(4326008)(2616005)(81156014)(81166006)(2906002)(1076003)(8676002)(5660300002)(86362001)(316002)(66476007)(6666004)(66556008)(66946007)(26005)(6916009)(16526019)(44832011)(186003)(6486002)(478600001)(7696005)(52116002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3440;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYF+Gsc7TqhivHfGoNt5alcUnXRREyuz4wAsMxyBRNw8f4hZRWbKGaWrhmC4HTVvYkOJRS2Ru7cEf/RjgO/DAdkarD4efLyxlQz7NnE/OG1MXoTKKRdmvi6uZQZx4fPQ4i63+1LuIGSMpiR9EZ5AouImFebKesJGE7o/UVbdKuD/THtjMOPA5t9kiy6EbKO8IHEUCj5ic4ua0OA+bOjEovvYMS79i8cxrqaWGh/Vt2YYDk5Ib7ddR8/e+RcGXMHW0un1CE/kzJJ3Jdk7Lep6vmGh5hR7+zefyafMV/kf5gNU7n2t+noOn1FwFB88uPwQLpKPp4AI4C/7UcS07vNwUe9LtnyMggb+8GeRANOAoRygfBg1x49SBghreJCuOqQDjEi+INgnUHnHV0vpz56PExoWpVH+oXf2t1HGsEnx+yrw7cIsTjUjyokASmWXMzm+
X-MS-Exchange-AntiSpam-MessageData: tHEW0yEqDrsHxDn1eYkcarf0oE2rUo7CJNyi4Atn3Kd+mORJYMo/21WYoI+/BhYQebXJiyjXYDvvhNvHjgKRj3ixhst62fGLy4oAlj8sHRms3bM8avOSGnGoly/Y0T9jp3bJh1EsO6TWy4z5BAdj8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efabdc2-4e23-401e-8470-08d7aadd510b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 08:19:42.2436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/BwS9e5xySMIErh9I87GXhrIehKAdgfe0mwCrck3cjq3+UyaKI0BRMiiqBBxwep
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3440
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
Cc: Evan Quan <evan.quan@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU FW will handle the features disablement for baco reset
on Arcturus.

Change-Id: Ifd87a09de2fca0c67c041afbd5e711973769119a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 53 +++++++++++++++++-----
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 9d1075823681..efd10e6fa9ef 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1467,24 +1467,39 @@ void smu_late_fini(void *handle)
 	smu_send_smc_msg(smu, SMU_MSG_PrepareMp1ForShutdown);
 }
 
-static int smu_suspend(void *handle)
+static int smu_disabled_dpms(struct smu_context *smu)
 {
-	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct smu_context *smu = &adev->smu;
-	bool baco_feature_is_enabled = false;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t smu_version;
+	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return 0;
+	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	if (ret) {
+		pr_err("Failed to get smu version.\n");
+		return ret;
+	}
 
-	if(!smu->is_apu)
-		baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
+	/*
+	 * For baco reset on Arcturus, this operation
+	 * (disable all smu feature) will be handled by SMU FW.
+	 */
+	if (adev->in_gpu_reset &&
+	    (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
+	    (adev->asic_type == CHIP_ARCTURUS && smu_version > 0x360e00))
+		return 0;
 
+	/* Disable all enabled SMU features */
 	ret = smu_system_features_control(smu, false);
-	if (ret)
+	if (ret) {
+		pr_err("Failed to disable smu features.\n");
 		return ret;
+	}
 
-	if (baco_feature_is_enabled) {
+	/* For baco reset, need to leave BACO feature enabled */
+	if (adev->in_gpu_reset &&
+	    (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
+	    !smu->is_apu &&
+	    smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
 		ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
 		if (ret) {
 			pr_warn("set BACO feature enabled failed, return %d\n", ret);
@@ -1492,6 +1507,22 @@ static int smu_suspend(void *handle)
 		}
 	}
 
+	return ret;
+}
+
+static int smu_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct smu_context *smu = &adev->smu;
+	int ret;
+
+	if (!smu->pm_enabled)
+		return 0;
+
+	ret = smu_disabled_dpms(smu);
+	if (ret)
+		return ret;
+
 	smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
 
 	if (adev->asic_type >= CHIP_NAVI10 &&
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
