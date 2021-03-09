Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC698C433E9
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7375C6518A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7375C6518A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1764F6E44D;
	Tue,  9 Mar 2021 04:10:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D206E44E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 04:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuzabbVyQTii1VEesVBJMKlkTy1LWr69Pmo3ggwKhYYfj9iBJnkecPe57JTs2YFk0/cc2vh2WOCCGU3CXEZVzhNij0IEzSE/RsYP+VGRNBEKU04OGZM3TJvfFp/DI0iCyrnNC07B7vjgTxVBWr0PaZ4ZyTum99RfGA+sFGsyDH+EVINEIzN1PlVVCUxzQiN2PBO1nTHeBFxr+nHfqj22N8x6CEpKnecxzGmdJxs9WCc1+ougGs68nX2Kdom2VkFrVqwHXdcWrJFEYXt6WxFEHmdvMJh3jIoyPI6Ru3JkP6lYRQ9dZRPIYWwwUvq9/uQHTNb/VAOOtlDK6zZwsk/ZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy+cpXyb4ZPiMj/D9mYNllNs7fw/rVhFaO3k5uMumx8=;
 b=LRlR4sK2BGvEOYoxGFhgIDnXlQIQk4EyBN9zaZ4wrezGMCytvORJUGwsKo/zAsIWViFGX0oiGKlL3m7Jag4p6d32cC2NiNpIn9X92JMM8NXFB2uM2RRrTOKuLTy01+CyZu19sJ0ECyljGIcztyqse4tN0Zziomt4IIfguCtxJG8XSAXEZ0SCacF4GXmdwzmqg4+FAO5GtjqogG0Sx0MZZitfV4FwraIzz9q/DEo8VzkZ1e/X+S3WEPX08cLdMEkz/rhOOYg2VBcXAJNfZJC+7iZ9fJqNXAf7XR4kZL0comk6bLYfPkPXaySJVD2tgtxKgHz2MsY0/D4VjpO4tJD/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy+cpXyb4ZPiMj/D9mYNllNs7fw/rVhFaO3k5uMumx8=;
 b=5gpZO1j3Rm9ydr1BXJOQUYYjWGW/mTSuUldoyIS1mKv3RnrQIctDd1bpmWeEhBbUpHoCuP804QLD9CJKXQD2vMi84M4Zne0VtFBB+TFjWr34jPolMVc0u1xrHY/+8Y6ea5hIXuREPeE8tiErxqbwLnEsXJIbDb7azd843AwMwUg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 04:10:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 04:10:34 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu: clean up S0ix logic
Date: Mon,  8 Mar 2021 23:10:11 -0500
Message-Id: <20210309041012.23367-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309041012.23367-1-alexander.deucher@amd.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Tue, 9 Mar 2021 04:10:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07d767c2-1f31-4ea5-9471-08d8e2b14993
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB448601E4033F409632BCC50CF7929@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Tzuu8Xj2AecEXfEraTI3iV8/qfn635rkX30xP3Is1o3ZlL/VgMow+AYra7/r/9gKV7vP0eh7SQsdy874DuU3epC8dIIwtlJKwLQDFHsZuzxEHDAE20o5fuESBqPjT6aNE2BTK6oqjF3Tp6Qw5hhWFURvfbLtdE+b3p4iuJw+MMjCZR1o/6wA1ucwPxSXZWVifRoU3dJcuCgihy4nr2WtTKRoeLzEidMk7hIAsRxBcARG/++rtvTaztzYHKDqKQeex5HeWuYGgt+/pJnMa+Q32Biz/2VPA/n2OgzmwiqD5z3uPF+OqLWGUp7ppr+V6FYCJzdKxicIKXGK6VrmT1nLnvlxirKp6ceuAyU/UaPl2Lt+s2iApDhzxARvj887DULRpOwlSmg6Rne8ZznPHrzqRN1yzGTG+8dTW2qmBTB5RRfVPrZdG5PNbeSEm+54ZUSQpxuiuxi185/By+DcUH5Z3w1UwvsJSvoM2ITB3nfNZT8GI+ji5iX+ZyV7WOgMlh+t/DdstaGf3yF4g3A3gDkh2S0PpD3aHE2HyQg55A+otuybjSVb0e7cRRu+rBWBAuQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(478600001)(316002)(66476007)(5660300002)(16526019)(6916009)(8936002)(26005)(83380400001)(2616005)(8676002)(186003)(36756003)(66556008)(66946007)(956004)(86362001)(2906002)(4326008)(6486002)(1076003)(6666004)(7696005)(52116002)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K9nSFUqUbThLWVX+22pA7ZijnHn94vza3k/KmAYNkkyIm8nsQUKCrrwPrk4i?=
 =?us-ascii?Q?PxTvdDinw/QTpUAHmn/uasDhiismqEPliI6MQVbvwJfp+qH9b+mSEoNBIu/L?=
 =?us-ascii?Q?sFC22tXkzWEo+qOUb+qjjCvilvNkh1xNsFer5i1+W1wGdA8Y6W42ocLBPw6A?=
 =?us-ascii?Q?d5SU275CP0ImbglPzUjnCehICyg7fsCkROBXbqCSZkjIpqOooeSoVWxHNCkn?=
 =?us-ascii?Q?1uGKsBX7GiT63wsc1o9G5SX9k+R6ARCk2qCebcmVLdSLu85h5xMccGbHcpXm?=
 =?us-ascii?Q?1AFhcTDjPk3wPo+Eb6HCB5/iMIj8qHT3AbkQuVvjJgmBSXKRIx8tCuFoMheO?=
 =?us-ascii?Q?oWUoxz3E28ORtRIWBj+Ay9MqaABR6MuH77j4mVzpjTudGBUwCvTpD0amdmmQ?=
 =?us-ascii?Q?NXcxboag4hY55S4ZZTxDJeLNZ5PrgAFldWEvbIH6lHfm7Q6WCVYQmu4DpixE?=
 =?us-ascii?Q?IBlRT8L2nbWgxyaHrqF06ajOHGukAteHz2peKsWEhu5CkifubTl9+0ggwInz?=
 =?us-ascii?Q?0nYAqbwWilUa1ZXlqwLmCKFizku47RnaxFlxW5szZFD6qTq6ycozBlaCCfoP?=
 =?us-ascii?Q?W+i9iteSTT29Yh1NJPD/FivT19hrENda3dIibynAKT4lp6u3M240Pfaxy/R8?=
 =?us-ascii?Q?+9rwaQqgT0v1g0U2eRhUKkVw0Y3SPriod000t1I8VcVJBCZ10Wj3x+IYA5+s?=
 =?us-ascii?Q?7YLLyWwLX3Pjo8l9DiKnykNKrBJZUsmZ3sKscpJ6+4G9mT1NzAUAedZmBvHK?=
 =?us-ascii?Q?tRG5AMglUROaU9kxhmqq0adq6XmpXviUmi9E+/ul+03ZZtHouDORsG0CfI+Y?=
 =?us-ascii?Q?XRsBMcBJaMZdL6CEnfMAgDOVGh6HC77OOQMj+FknFuyq9OkF0x+9MbxomDMa?=
 =?us-ascii?Q?cGT88jWvDE/ZxcR0w+DNTG5AWaYz9XQ7KYaWkOairZVRsc10BgF6UstLg+I1?=
 =?us-ascii?Q?TBF9tKLgvGCBJ0bnq1HauAynqjcpfnFwzCazX/pBVRapyWFEH5KtYdYbAgsI?=
 =?us-ascii?Q?WUaq/l/fbyJe4eAisaqaZx2uDLscDTqvIl/W9d2ScSXN/1dkpB6VKfCatOCq?=
 =?us-ascii?Q?CtdMF+6XEPHvJKaSkAAqOBdLWukk1hZNcrftKPh7wheJhUCxd67cth4RsTNt?=
 =?us-ascii?Q?jjzvat9gGzGXvsKF+iBmb4Js+tefKONvRNx/QO8qIZR7Z8aQjAzb7s7n0eL1?=
 =?us-ascii?Q?pWOXqAHHyJffgKj61vvXfJno9Gn1HpnKewTzeXO92+gCon83fhztbdHSxzUz?=
 =?us-ascii?Q?zKRJPiEN9Q4xT2tNTihRpFbuOas5fgUnGr+/YWthe4YGzmq4NTQfajx1fKiJ?=
 =?us-ascii?Q?vf6WBIHUBABstjOUd17cEWdj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d767c2-1f31-4ea5-9471-08d8e2b14993
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 04:10:34.6204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEnN+K7MJ5vfTIEhGFKt3bu03nh7iaaSnhRevYfsj8cSgcsvaenoypaSFQN0DL/1q29cmu3+TIW56dgYUu95UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We only need special handling for the S0ix suspend and resume
cases, legacy S3/S4/shutdown/reboot/reset should use the
standard code pathes.  This should fix systems with S0ix
plus legacy S4.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 ----
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4ddc5cc983c7..bf9359ccf3da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1040,12 +1040,6 @@ struct amdgpu_device {
 	enum amdgpu_pmops_state         pmops_state;
 	bool                            in_suspend;
 
-	/*
-	 * The combination flag in_poweroff_reboot_com used to identify the poweroff
-	 * and reboot opt in the s0i3 system-wide suspend.
-	 */
-	bool 				in_poweroff_reboot_com;
-
 	atomic_t 			in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
 	struct rw_semaphore reset_sem;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ac5f7837285b..2b6e483259f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2680,9 +2680,10 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
 static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
+	bool s0ix_suspend = amdgpu_acpi_is_s0ix_supported(adev) &&
+		(adev->pmops_state == AMDGPU_PMOPS_SUSPEND);
 
-	if (adev->in_poweroff_reboot_com ||
-	    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) {
+	if (!s0ix_suspend) {
 		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 	}
@@ -3672,13 +3673,13 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
  */
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 {
-	struct amdgpu_device *adev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_crtc *crtc;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	int r;
-
-	adev = drm_to_adev(dev);
+	bool s0ix_suspend = amdgpu_acpi_is_s0ix_supported(adev) &&
+		(adev->pmops_state == AMDGPU_PMOPS_SUSPEND);
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
@@ -3741,11 +3742,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	if (adev->in_poweroff_reboot_com ||
-	    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
-		r = amdgpu_device_ip_suspend_phase2(adev);
-	else
+	if (s0ix_suspend)
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
+	else
+		r = amdgpu_device_ip_suspend_phase2(adev);
 	/* evict remaining vram memory
 	 * This second call to evict vram is to evict the gart page table
 	 * using the CPU.
@@ -3772,11 +3772,13 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_crtc *crtc;
 	int r = 0;
+	bool s0ix_resume = amdgpu_acpi_is_s0ix_supported(adev) &&
+		(adev->pmops_state == AMDGPU_PMOPS_RESUME);
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
-	if (amdgpu_acpi_is_s0ix_supported(adev))
+	if (s0ix_resume)
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
 
 	/* post card */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0312c52bd39d..dd6d24305b16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1288,9 +1288,7 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	 */
 	if (!amdgpu_passthrough(adev))
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
-	adev->in_poweroff_reboot_com = true;
 	amdgpu_device_ip_suspend(adev);
-	adev->in_poweroff_reboot_com = false;
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
 
@@ -1380,9 +1378,7 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 	int r;
 
 	adev->pmops_state = AMDGPU_PMOPS_POWEROFF;
-	adev->in_poweroff_reboot_com = true;
 	r =  amdgpu_device_suspend(drm_dev, true);
-	adev->in_poweroff_reboot_com = false;
 	adev->pmops_state = AMDGPU_PMOPS_NONE;
 	return r;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
