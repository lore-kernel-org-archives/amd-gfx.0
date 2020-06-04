Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06681C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7182072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k94zucZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7182072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2FF89FE3;
	Thu,  4 Jun 2020 04:47:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1422C89FE3
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9wcM3yPps3/XB3DpGcy7GTUwpSVumXh6hxlfYPt9JD7Wn1Jd3YKhlN19hSK1c2evBoWUCPE+30BVNvG8Y8XzF3E2kF8VRzoTkio2EhDHGMXgs5m3llxrAJx/O8QiVZVezX0eQKJiQNCIPIp9JOhRLL+Eyov3p6XjgC1dWZwHSrHdxP+0njfTZI4Aj7evYXkVxu4H8vPjmO7hIpysohq10Fo3IR3tuTZRiizdTlDXs26LF2v8jmtKgWz8+QBMvotpE+dvAlrzVuecxHmzPu5OZVbdaCr3potELp9sHPhBy/OEhZ71vBbDrcpLgyd3VcbZs2Kd7qSDagPdOevnanYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPYkgimjEp05ExogGn4up734B+itx7IOqdD6Z2BdY+Y=;
 b=l3rhGsFdmR424wWrNdnLOUkiK5icrDggQ7W5VFcm2ktYRHYxTMW+/b0baCIxdVNCPHKdKIprqlHvKZZAD69RjP6QU8N2S2HLyNmPipxHt8zXl1BASc+Xu/IjM/xWmeIpp4L4i2D3TB+8ujXrZ9U+OumGZw9jIiMg+xJWoqdTQEvxQj6J3obhrrUYUDAazLdF1QzZRCaa3tV1qT9j8qDK0TyWzGsoBrI5/1oHgDHlxXEU//vD140M9u7m5YxMfK/mbb4rw0Zd4wFQ0WVNPwbYC5gp3xH/2IuKzNN0q6z6AJK1diOj9nge8Cvx2wYM0pxd8eb3QYpL3MGMohOjE7PI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPYkgimjEp05ExogGn4up734B+itx7IOqdD6Z2BdY+Y=;
 b=k94zucZwMRyPW7N4wkcN7Xff9M1SsKeDrmy2JK98or+AZk6shL/nKWH3Ns8NUhKEM8+1SYnRgwdIoRdeEEY806jf8YReAo1+XckAhMrG7e3EnESZuDEnp3xx/GO0vVF/zKd8A4Tz2IeKdT2Sblj533+5pHIcvJCOsoKcmFcgACA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Thu, 4 Jun 2020 04:46:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:46:59 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/16] drm/amd/powerplay: implement a common API for dpms
 disablement
Date: Thu,  4 Jun 2020 12:46:06 +0800
Message-Id: <20200604044619.18658-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:46:57 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce787b99-0bcc-4239-bd58-08d8084250b3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB300232A677FEB13E09CED84EE4890@DM6PR12MB3002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:190;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Dsu5Xeogzvyu176rIoK53lhZzNBw81W3fb5UAZ9Az8jtwcczGPKwehSvHJUR62vsRanAbkwx99UZyoXrCLWJzIpOZxk/KY/n1WG3lTU53XgY2ejt1/A7HhRrCQPAEBZ67t4qLcuf9HnVYpqHCyAd5mD1R3MKkCNIjOYTg2mOW2z28yEBSzp3XamRxJ/iEFQC8ctPr3YHekvJLEC95llMVV60LyxSmjk+7Wavpk9PtX266QC38xS5E/fc9oSKXGI628Jhw4duIdbnghn2dKfhtW/mDdIERWAoazBNxkVS/urlOTSiMt7IPlp/2uYzEClPFvvcP2uQGXsv7hJG37DjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(7696005)(1076003)(52116002)(36756003)(2616005)(26005)(316002)(16526019)(83380400001)(6666004)(6486002)(86362001)(5660300002)(186003)(956004)(6916009)(4326008)(66946007)(2906002)(44832011)(8936002)(66476007)(66556008)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ImsB2URUPi3wYNb6l5G9bo8j8FPGHy8wJ7WiEvt8L6nAnkBDECSswsZUrKeh/f96waux3ebQmxw9ci0uvdYUCJ4P+VYlOowANqmpz1SfVM32jxrfq5UqTkm6/zl8A5dtp53kU3faw1K8+NXrv1UhuGB2qKqkHwW5F+FC/U6FU73EeiOqNwI+bannqpSfPQ//XAFQh/IwmLGLOsE/LZaILoPHziqYVEKLBbu09Hco5OFPNsk9Ql1QuMVsNhyRWkb7w1gSCmg4P8Tfx4GfolPsJj5uYNhlnB26ggoMA5iwsZYwTRRsCusfogVLgpQu7r84xnfcHaVoSvTzrXIhI7PDCW29jmpBZdiUVmzHDlJYiO0QO5gOyWoNKHn0ZdozxqGgOUcXLcLGEzDjyjn5XWG0M4+Y/0Kdj+5gE0yuOO7GgGV9hAd5IkBIYe/mBbxwrjw7V+j7QwQL4Zee6rdqjSqbtFMz0dcbq9VxfN+dvd3nMiAgd0INTgpH8Fpv2S9WKqsY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce787b99-0bcc-4239-bd58-08d8084250b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:46:58.9474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5EhaMZ4wBiXVgKFu3ahk1DkTyLcQHRDgNuTpg9ZuqTmNfVmX4GRHr2v8nfFUc1L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
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

So that code can be shared between .hw_fini and .suspend.

Change-Id: I4a0eeb7cdecbf5b24fac3d0fe1d8fcb1ca9f0b0a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 178 +++++++++------------
 1 file changed, 77 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index bd0fe71dffde..87205abb1e8b 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1318,9 +1318,77 @@ static int smu_hw_init(void *handle)
 	return ret;
 }
 
-static int smu_stop_dpms(struct smu_context *smu)
+static int smu_disable_dpms(struct smu_context *smu)
 {
-	return smu_system_features_control(smu, false);
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+	bool use_baco = !smu->is_apu &&
+		((adev->in_gpu_reset &&
+		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
+		 ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
+
+	/*
+	 * For custom pptable uploading, skip the DPM features
+	 * disable process on Navi1x ASICs.
+	 *   - As the gfx related features are under control of
+	 *     RLC on those ASICs. RLC reinitialization will be
+	 *     needed to reenable them. That will cost much more
+	 *     efforts.
+	 *
+	 *   - SMU firmware can handle the DPM reenablement
+	 *     properly.
+	 */
+	if (smu->uploading_custom_pp_table &&
+	    (adev->asic_type >= CHIP_NAVI10) &&
+	    (adev->asic_type <= CHIP_NAVI12))
+		return 0;
+
+	/*
+	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
+	 * on BACO in. Driver involvement is unnecessary.
+	 */
+	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+	     use_baco)
+		return 0;
+
+	/*
+	 * Disable all enabled SMU features.
+	 * This should be handled in SMU FW, as a backup
+	 * driver can issue call to SMU FW until sequence
+	 * in SMU FW is operational.
+	 */
+	ret = smu_system_features_control(smu, false);
+	if (ret) {
+		pr_err("Failed to disable smu features.\n");
+		return ret;
+	}
+
+	/*
+	 * For baco, need to leave BACO feature enabled
+	 *
+	 * Correct the way for checking whether SMU_FEATURE_BACO_BIT
+	 * is supported.
+	 *
+	 * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
+	 * always return false as the 'smu_system_features_control(smu, false)'
+	 * was just issued above which disabled all SMU features.
+	 *
+	 * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
+	 * now for the checking.
+	 */
+	if (use_baco && (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0)) {
+		ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
+		if (ret) {
+			pr_warn("set BACO feature enabled failed, return %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (adev->asic_type >= CHIP_NAVI10 &&
+	    adev->gfx.rlc.funcs->stop)
+		adev->gfx.rlc.funcs->stop(adev);
+
+	return ret;
 }
 
 static int smu_hw_fini(void *handle)
@@ -1352,25 +1420,10 @@ static int smu_hw_fini(void *handle)
 		return ret;
 	}
 
-	/*
-	 * For custom pptable uploading, skip the DPM features
-	 * disable process on Navi1x ASICs.
-	 *   - As the gfx related features are under control of
-	 *     RLC on those ASICs. RLC reinitialization will be
-	 *     needed to reenable them. That will cost much more
-	 *     efforts.
-	 *
-	 *   - SMU firmware can handle the DPM reenablement
-	 *     properly.
-	 */
-	if (!smu->uploading_custom_pp_table ||
-			!((adev->asic_type >= CHIP_NAVI10) &&
-				(adev->asic_type <= CHIP_NAVI12))) {
-		ret = smu_stop_dpms(smu);
-		if (ret) {
-			pr_warn("Fail to stop Dpms!\n");
-			return ret;
-		}
+	ret = smu_disable_dpms(smu);
+	if (ret) {
+		pr_warn("Fail to stop Dpms!\n");
+		return ret;
 	}
 
 	kfree(table_context->driver_pptable);
@@ -1409,78 +1462,11 @@ int smu_reset(struct smu_context *smu)
 	return ret;
 }
 
-static int smu_disable_dpm(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t smu_version;
-	int ret = 0;
-	bool use_baco = !smu->is_apu &&
-		((adev->in_gpu_reset &&
-		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
-		 ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
-
-	ret = smu_get_smc_version(smu, NULL, &smu_version);
-	if (ret) {
-		pr_err("Failed to get smu version.\n");
-		return ret;
-	}
-
-	/*
-	 * Disable all enabled SMU features.
-	 * This should be handled in SMU FW, as a backup
-	 * driver can issue call to SMU FW until sequence
-	 * in SMU FW is operational.
-	 */
-	ret = smu_system_features_control(smu, false);
-	if (ret) {
-		pr_err("Failed to disable smu features.\n");
-		return ret;
-	}
-
-	/*
-	 * Arcturus does not have BACO bit in disable feature mask.
-	 * Enablement of BACO bit on Arcturus should be skipped.
-	 */
-	if (adev->asic_type == CHIP_ARCTURUS) {
-		if (use_baco && (smu_version > 0x360e00))
-			return 0;
-	}
-
-	/* For baco, need to leave BACO feature enabled */
-	if (use_baco) {
-		/*
-		 * Correct the way for checking whether SMU_FEATURE_BACO_BIT
-		 * is supported.
-		 *
-		 * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
-		 * always return false as the 'smu_system_features_control(smu, false)'
-		 * was just issued above which disabled all SMU features.
-		 *
-		 * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
-		 * now for the checking.
-		 */
-		if (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0) {
-			ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
-			if (ret) {
-				pr_warn("set BACO feature enabled failed, return %d\n", ret);
-				return ret;
-			}
-		}
-	}
-
-	return ret;
-}
-
 static int smu_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
 	int ret;
-	bool use_baco = !smu->is_apu &&
-		((adev->in_gpu_reset &&
-		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
-		 (adev->in_runpm && amdgpu_asic_supports_baco(adev)));
-
 
 	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
@@ -1498,19 +1484,9 @@ static int smu_suspend(void *handle)
 		return ret;
 	}
 
-	/*
-	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
-	 * on BACO in. Driver involvement is unnecessary.
-	 */
-	if ((adev->asic_type != CHIP_SIENNA_CICHLID) || !use_baco) {
-		ret = smu_disable_dpm(smu);
-		if (ret)
-			return ret;
-
-		if (adev->asic_type >= CHIP_NAVI10 &&
-		    adev->gfx.rlc.funcs->stop)
-			adev->gfx.rlc.funcs->stop(adev);
-	}
+	ret = smu_disable_dpms(smu);
+	if (ret)
+		return ret;
 
 	smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
