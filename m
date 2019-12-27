Return-Path: <SRS0=pkFB=2R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD4AC2D0C6
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2019 07:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E90206CB
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2019 07:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cFCDJZJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E90206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC5189D81;
	Fri, 27 Dec 2019 07:00:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AEA289D81
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2019 07:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei2xMutK8ZMGyPCRB5vOSGkRY1T+BrsoCuItDtQiRkCxFEbJhhJWU+anUdiGgxH7ugrFjWBtGuQSMrS22OglcBOheLDNuUcgotBGIAcbU6SWp1+1BTtQoG9YaHLxn0T6M53gdCiB6XyK6DfRZN3Mklu6pdkArfHjaVvBzrKdznfWCBgbdkq6c52zVCq1yw6asKwLEMyTqPB9fHkRXjjgMM/pOHlhKqGykCoJWi+eBzNMU43Xnu88kdcNZzZiIsLKdRMnrIDyrZcTK03H2F6KbeZDh/+IQcF+93Rt14c2Togi9dR3bm2YGgm2lx6r60ln49hK8bHfLeaBdItQ2iRomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00h+bdCNyoqsMUxj67cB5c5Cp5CZeeVLJ+fh7BsqyfU=;
 b=kdCnd9kF2qkCV0SRVOVPkDH1VKo7JOB4/Ujs3l0AidlG+GKUvQapKV6MqC3A4DYkl8TPn1oixKS4RxDzG8ibHZFuoSQXBJ6AThk1CnvkMBvJ/mAsjF9KlEnEwaDz3dmeROlNEjOrkB+erTjLBQ93yM2Cx8JrV4caJbna4HHCGiAt4amwn9QgyXOu/h01malPGwOmvwutDCo1T8luAfPTAwojzsr4kAPQz7LtTbKwWvOsWl4zMWFxrnBHCzuQENe8q6L0a16SVJg/jXiKe8KefFbJWBoca9Rk00ZIAXsCHIcaeajFk09g0G4B3yGQBoFfbZBj6NFZfByGfuqFPfEO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00h+bdCNyoqsMUxj67cB5c5Cp5CZeeVLJ+fh7BsqyfU=;
 b=cFCDJZJHOv/ZJcxj8RzvV1W2EJrnzi3TBSzm8z6D2IVCiwGcYrpJoVUo7eK/2R6hHbrismGGk2z+mg5tYn4D5OPuD+EstXwo2TSZ5hntyCD9byNKAJkJnTd6GlxqBa9hc3EwgqTzQPjQGAr+T2eLOADMwz4sMM2F1gGFIUyDN4E=
Received: from CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) by
 CH2PR12MB3975.namprd12.prod.outlook.com (52.132.247.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 27 Dec 2019 07:00:17 +0000
Received: from CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::31df:679e:d23f:3c2b]) by CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::31df:679e:d23f:3c2b%4]) with mapi id 15.20.2581.007; Fri, 27 Dec 2019
 07:00:17 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Wang,
 Kevin(Yang)" <Kevin1.Wang@amd.com>, "Tao, Yintian" <Yintian.Tao@amd.com>,
 "Deng, Emily" <Emily.Deng@amd.com>, "Min, Frank" <Frank.Min@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
Subject: RE: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Topic: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Index: AQHVvILjY/76J6Fubkq2JqpFQ/7eDKfNjYGw
Date: Fri, 27 Dec 2019 07:00:17 +0000
Message-ID: <CH2PR12MB3672D8C9F4D961F505205481BB2A0@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <20191227065710.3261-1-Jack.Zhang1@amd.com>
In-Reply-To: <20191227065710.3261-1-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d1ea168-8bf9-4533-9299-08d78a9a6e72
x-ms-traffictypediagnostic: CH2PR12MB3975:|CH2PR12MB3975:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB39758D0A26F8D6127C7707E3BB2A0@CH2PR12MB3975.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0264FEA5C3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(189003)(199004)(13464003)(66574012)(7696005)(81156014)(110136005)(53546011)(6506007)(5660300002)(8676002)(2906002)(8936002)(81166006)(71200400001)(316002)(478600001)(66946007)(76116006)(19627235002)(33656002)(66556008)(66476007)(26005)(186003)(52536014)(86362001)(55016002)(9686003)(66446008)(64756008)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3975;
 H:CH2PR12MB3672.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JpCgWuIJRoJFL3DzXik1UwNWMtSPUWgbi+Km+3wMQ8EPIoY1pGdB/BnIF13s6xCe50t8NIbT5RoJ4HtfOTPKkwUvOYh48lM0EaVGBe8VmQLiq54RQvfmiTt0KgJvYlef+4btmlSRXhQYiBWYTu25yuw5ktl6/px8FMlVxZJfK2EXXD1gJro6wXRUaHkBtkbgZypqDuzUoArej/xiRKC8Fa51hfmA5nHLJ/sM+ig509L5DyuPUGbYexmdnRTiW3wPvmgfLQnnoUoOQAMZuv4rrlSDd2AWDVLphYEB61mg7TT3tZO9jkvhzjneNMT/yOX8QDyjo1X3TWnLXEFRBE3j8Hywk6BXRym+DB+iiF0liYzI86tdgFVhI6+7Hiif+8d+zWCsYwNXPwdHjTlQh464/Anqno7KJKQeO+bU2+aBCnwf2uwSCj9DcEKwv7qfsQA7WDdrDbmjzE7fapAY16jJBmPIeniT6MnmXFK7c9Uk3BKn2gMYxpUoc4Ryol9CSwoV+oQ1dxtzDPtep0htn3V5ZA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1ea168-8bf9-4533-9299-08d78a9a6e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2019 07:00:17.6285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7j3CrksHzdM602elMZsfGGFDDjlR3WUusQr7YEneW9cUhbpxdDo3c5uX0BjLfXR8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3975
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com> 
Sent: Friday, December 27, 2019 2:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF

Before, initialization of smu ip block would be skipped for sriov ASICs. But if there's only one VF being used, guest driver should be able to dump some HW info such as clks, temperature,etc.

To solve this, now after onevf mode is enabled, host driver will notify guest. If it's onevf mode, guest will do smu hw_init and skip some steps in normal smu hw_init flow because host driver has already done it for smu.

With this fix, guest app can talk with smu and dump hw information from smu.

v2: refine the logic for pm_enabled.Skip hw_init by not changing pm_enabled.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  3 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 45 +++++++++++++++++-------------
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8469834..08130a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1448,7 +1448,8 @@ static int psp_np_fw_load(struct psp_context *psp)
                     || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_G
 	            || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
 	            || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
-	            || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM))
+	            || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
+	            || ucode->ucode_id == AMDGPU_UCODE_ID_SMC))
 			/*skip ucode loading in SRIOV VF */
 			continue;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index b53d401..a271496 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -827,8 +827,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
-		if (!amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 
 		if (amdgpu_sriov_vf(adev)) {
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 936c682..42c0a6d 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -531,10 +531,14 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_VEGA20)
 		return (amdgpu_dpm == 2) ? true : false;
 	else if (adev->asic_type >= CHIP_ARCTURUS) {
-		if (amdgpu_sriov_vf(adev))
-			return false;
-		else
+		if (amdgpu_sriov_vf(adev)) {
+			if(amdgpu_sriov_is_pp_one_vf(adev))
+				return true;
+			else
+				return false;
+		} else {
 			return true;
+		}
 	} else
 		return false;
 }
@@ -1062,20 +1066,19 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	}
 
 	/* smu_dump_pptable(smu); */
+	if(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)){
+		/*
+		 * Copy pptable bo in the vram to smc with SMU MSGs such as
+		 * SetDriverDramAddr and TransferTableDram2Smu.
+		 */
+		ret = smu_write_pptable(smu);
+		if (ret)
+			return ret;
 
-	/*
-	 * Copy pptable bo in the vram to smc with SMU MSGs such as
-	 * SetDriverDramAddr and TransferTableDram2Smu.
-	 */
-	ret = smu_write_pptable(smu);
-	if (ret)
-		return ret;
-
-	/* issue Run*Btc msg */
-	ret = smu_run_btc(smu);
-	if (ret)
-		return ret;
-
+		/* issue Run*Btc msg */
+		ret = smu_run_btc(smu);
+		if (ret)
+			return ret;
 	ret = smu_feature_set_allowed_mask(smu);
 	if (ret)
 		return ret;
@@ -1083,7 +1086,7 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	ret = smu_system_features_control(smu, true);
 	if (ret)
 		return ret;
-
+	}
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = smu_notify_display_change(smu);
 		if (ret)
@@ -1136,8 +1139,9 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	/*
 	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
 	 */
-	ret = smu_set_tool_table_location(smu);
-
+	if(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)){
+		ret = smu_set_tool_table_location(smu);
+	}
 	if (!smu_is_dpm_running(smu))
 		pr_info("dpm has been disabled\n");
 
@@ -1249,6 +1253,9 @@ static int smu_hw_init(void *handle)
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
+	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	if (!smu->pm_enabled)
 		return 0;
 
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
