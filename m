Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20957C2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 08:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7A4206B7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 08:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pEuU9oID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7A4206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2C46E22A;
	Mon, 23 Dec 2019 08:42:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5866E22A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 08:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzH8VGL6CV/HhtYbrKxkprGmLtZlqTp+sXtWBkynFvBuUu8hm/TNx/svJz03JAPG2Qyz+iAzv1hCYir0L9w0Fq8cFaCFqIxhGM/RISEr2I6ldlxeFUfHY1mFsRcDg/xE67PRu4imeTO7R8finpIE70j0IyucFcTj0OV3n41INoVdu6c8ZHfUFoB5PdXZ9tToBbtgQeBKu17fijYco2ZBMsMqLdrEBQsLeWQJOeBKVgeT7Y74SsCqUDjWIW+EGBp/LP5XAz6iCKYa4Iqc9NEafjQt/Og0QgJB3WbulhSvxqwFV90gMpLvbStBezrHGvMOcv5pKRaOF5RyC7d1FecwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tQyKkNgYV0V2fWHapColVZDBeVVwkLyOmWHK9KOt5s=;
 b=m7iZ5N7oDyf6yu6c1ssGZVbs+tHYz61+jlPO9hfFcK+An/Pq7DGfiQkAMx1yaL0H2/UIJwHIql/MMTuws01eUvdWKnciWGzANDlA3M53c0KvDY72TWNbpRWgYrTXwlG9iql82nMN2doVKHD+1IQuveYdB+3LT6OeYM7pIfyid300yw5WcaD5lq2pJjOcGHYPBiq4o4jU+wbuvC2EdT0yGq0MjqJAV11DEoRMMEw03ELEkVBEqynirQ5CuUe3u63UzpCEfSBQ5502MLBpLeCqAudP/eKN0g1mXRsqUpeUypFvSub7HYWzw7gEomf73WEWoX1EnnNqWivNO+Gi368eFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tQyKkNgYV0V2fWHapColVZDBeVVwkLyOmWHK9KOt5s=;
 b=pEuU9oIDTYRi/A5y0e2hwbBGPrfhImEAfgCj/0p2wmeRnypa1dJS1Ook3WqeYrrXamHmqFgJEzVDHKjZCZXkbSriCZUAu9NcyMeD683XyoP09upQu637aLzGB1jyCi1aQeiiToEWpK+CmkFhsVnYiSOL4YNCso6XutOYGffQ+EM=
Received: from CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) by
 CH2PR12MB3717.namprd12.prod.outlook.com (52.132.244.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.17; Mon, 23 Dec 2019 08:42:03 +0000
Received: from CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d]) by CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d%7]) with mapi id 15.20.2559.016; Mon, 23 Dec 2019
 08:42:03 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Wang, Kevin(Yang)"
 <Kevin1.Wang@amd.com>, "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Topic: [PATCH] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Index: AQHVuWyH98p430LSk0KUV3nPXXgyTqfHZojQ
Date: Mon, 23 Dec 2019 08:42:02 +0000
Message-ID: <CH2PR12MB36724ADD77CE6D8604792A7DBB2E0@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <20191223083939.9669-1-Jack.Zhang1@amd.com>
In-Reply-To: <20191223083939.9669-1-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29b589cb-6f6c-453d-82c3-08d78783fbd8
x-ms-traffictypediagnostic: CH2PR12MB3717:|CH2PR12MB3717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3717964665990EFD71A9FC24BB2E0@CH2PR12MB3717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(13464003)(86362001)(4326008)(33656002)(55016002)(6636002)(478600001)(64756008)(66556008)(66476007)(66946007)(76116006)(2906002)(66446008)(8936002)(110136005)(9686003)(316002)(66574012)(5660300002)(52536014)(81166006)(81156014)(8676002)(19627235002)(53546011)(26005)(6506007)(186003)(71200400001)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3717;
 H:CH2PR12MB3672.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CAA48gUSE87LN0ma1J9F45DsRhuxrl100kycbikNGdcnkZm9aSwuLZy9wCqE0uJwAwx/Uee0IX4s550KmMV+yK31oN/XsozLlVLMgokEsPr7UCDA278b8OLSltRFtacEC218FFBxG94zYIbgJWRYyHRdM9ngnl8Dm3AIQA62Qw1p+SdCLxhncwwIfPN7TgTsrTYY08lkxPtzOqOX0Ghi4R2mOUnhnWQu9D29+zdbXkVA+7pUHqXLcIJaIU7ySSno8g32w7HoIXpzWWeU6P1QdU5tDYjBxlvvxcwHbgRB1keGAsMz7v53mqii+cq9KdxOJ0RsR8kgmungki4NUv1VnJhFJD7d5U73r0naIZXbZyv8x6ke+RvJmfU/aWPNlhkdOpfIdwaCXdopTURF7jQSALad5OV9EPFXN2u6UCvOfYNetUu7XjGcHFSkNefG24eP3TKcmj/9nueFi13BlGIHA1sbuayzcrAavWTVbhziJmZLgMz0tU/f1zxsFcKI1RXv
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b589cb-6f6c-453d-82c3-08d78783fbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 08:42:03.0351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUQhuvJGEyN15daB72ChN7Qx6gfpvorqLs28XdfaNcKXKgngXxGkr+dISMTY5193
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com> 
Sent: Monday, December 23, 2019 4:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF

Before, initialization of smu ip block would be skipped for sriov ASICs. But if there's only one VF being used, guest driver should be able to dump some HW info such as clks, temperature,etc.

To solve this, now after onevf mode is enabled, host driver will notify guest. If it's onevf mode, guest will do smu hw_init and skip some steps in normal smu hw_init flow because host driver has already done it for smu.

With this fix, guest app can talk with smu and dump hw information from smu.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  3 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 49 ++++++++++++++++++------------
 3 files changed, 33 insertions(+), 22 deletions(-)

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
index 936c682..c07fb26 100644
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
 
@@ -1249,6 +1253,13 @@ static int smu_hw_init(void *handle)
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
+	if (amdgpu_sriov_vf(adev)) {
+		if(amdgpu_sriov_is_pp_one_vf(adev))
+			smu->pm_enabled = true;
+		else
+			smu->pm_enabled = false;
+	}
+
 	if (!smu->pm_enabled)
 		return 0;
 
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
