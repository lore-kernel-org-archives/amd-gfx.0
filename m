Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B49C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 07:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4942076D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 07:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4942076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BCDA89B48;
	Mon,  4 Jan 2021 07:47:53 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750059.outbound.protection.outlook.com [40.107.75.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9689389B48
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 07:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKnu1hmdK/a3pvzYqDOQGf7fJxtHsgnfYbTZoN1wyp7hLlvtkv+RV9bEhg3il/ePNR8eUTrnWIDOCUSQAN9UZGOs9blJG7FiRknhv3q8r0YXkwp5GGs4JzHYlszcu9xQZ6ukFQW7dYAHaeynvoZWujXzvqE1poNBrNBs/O8EJHx/gUiY0odFHAd9q+JN+6UxWeNubd+rvT8XPfE5UaUnYlFRU3FN0aW2FqY2/a5cXQSH7PR7wzIoEXTx6wxookwgXkK4zAHE+M3UnqP/7JgAUJoyzdmwV/8sIr83w6M2JGq9xwgNyfpvoLTzKFUg5FpADP+UPj5D2eImItmRjKyiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY05N7eqV0M7EyVVuBgugkM1YzgDwIpHHoK6c4LRWzg=;
 b=LpwOf4UlbCg39OfXMNpNeH3/jU45R4KACCKzqxQEcug34z+nVJGeWOCDZg3umFIg824ypIkG98/tIN3NV8JNVC2MIWtTjyRyOXZafq6f5xWWwHKALIjX+tyi21K4Q1uHVVM24w6g7wJKDM4HQelNi96hMOHJxDvcXeRMuY9kMxlSrUxaW5+bXRH4B2O78ZUFkn/1LqCCgkKYEU/NU07/OFQW3FLTM9Eb/afXy12jIXGFMDmCFVXsEbH/SyYYJMNhE8eWGYGrLbmtDNh4L4kl/NjgqQBg4YWeiT8XjczjGZHxm1cBz0shmKCH9YHdpke9FYmzFcof0qReqdZQrmIeRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY05N7eqV0M7EyVVuBgugkM1YzgDwIpHHoK6c4LRWzg=;
 b=1aSTfBioDTJdHaCOMlSS3tvxOE2+zmtOUnPtDgW30WnvH/6S+1dPa/eO0oAGeYaqmem7MGCNBkQDLhovfZWdX5maX7fLv0Iq7fOQ1zHyX2sfi5ZYjxTqWiS9NW/qJuN0575ndyVvEsrGjopqkAv3z2V1CZg2tPNdCASNlpO4aGg=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.21; Mon, 4 Jan 2021 07:47:50 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 07:47:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic
Thread-Topic: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic
Thread-Index: AQHW4lYv0l+cCqgufk2XeKPJ/QWSnKoW/aaAgAALWQCAAA0pIA==
Date: Mon, 4 Jan 2021 07:47:50 +0000
Message-ID: <DM6PR12MB4075FEB348FD9E5E9BF33309FCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210104045741.22623-1-guchun.chen@amd.com>
 <DM6PR12MB40753D9F3AD6F45122AD08EEFCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
 <CY4PR12MB1287B5959D62E8554A1B4CA6F1D20@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287B5959D62E8554A1B4CA6F1D20@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-04T07:47:48Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cdfbdbad-02bb-4862-8a8d-c469d16352e3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97d56132-3195-408a-79ce-08d8b0850966
x-ms-traffictypediagnostic: DM6PR12MB4436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44366D92127E56E08B46D703FCD20@DM6PR12MB4436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUSxAoSGejtu1oMTykLvVepWp6EIQUfWG4GBUdTWZU7V14EyLAKfGYGaC6kQD32arWdUpBqSr+E6bOLGMpxSf8OBxCqBC90N1qVcnL2TBvzRohfazWBCXCchoMU6MHeS29/sQDUDx8KDyV0+MCRdM3UG2M4CZN/EqpXkHIbvOd8u0FzBCQglWR+KFK1nMebiXIU69YMkrL1g9i3jx0eQXiXnCsXAzWPWdnSy6NZdB0i1hPscaRk4fxQLrbXyMML0OqnsliOpdip3mXTDZ72ldHYZA1Cs0ZMetKE5SXc1jo8x1EC+3D1CediKfdRtmVM0XVsZjinD5ja+WKvZl/KkweEvyBB5bRwuKB1BSGxdf6byTEBrbueszhw2T0fkyvlg+TSNzR4CaBXBpfcaEAVMuuel4gE3CgSI4uoq03CWZwmJjk3EDsBPKUQXI6jx+nj9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(86362001)(6506007)(186003)(8676002)(71200400001)(316002)(478600001)(9686003)(921005)(52536014)(110136005)(6636002)(33656002)(53546011)(76116006)(66946007)(7696005)(8936002)(5660300002)(26005)(83380400001)(2906002)(66476007)(66446008)(64756008)(66556008)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GlZ99FyAQf95ix5ODiclSGxggn87sOqzsUBk2bOp8lfi5w9QbqAsP8gRaniK?=
 =?us-ascii?Q?uFX2o8tN8VdvC+Jmy2xywYgxJxKb9W4UEP36C1HHR5iLVSTYjyFcQ4mrfKeE?=
 =?us-ascii?Q?yMg731ECTsgNMgz9w+9RZHAQX0Geo+d5AIRkZfY3rzM/+0c6q8WA/MbfojhV?=
 =?us-ascii?Q?4sUBgqfEM/RZcSUJD+09wOSkHDQOH5i9xfLX9irQUmWBtIaimTj4L5Aqo/EK?=
 =?us-ascii?Q?yhmjsBPjWj+WtyO3AbXc0TMqkqveSFfoFwT8arhd7TNEWdZK/XrVTMae1WrP?=
 =?us-ascii?Q?9DZsf7JR6pp93f0c9lcO0l7YLHRJe2z2Z6+wopTBci1Hd2V7j3c2aicFDZIS?=
 =?us-ascii?Q?GSjaj3e4xhKNUFBqHedt/2/Ph6FwsS6NOpEp4RjCZxvn89vpqTdt5Q8ReKE6?=
 =?us-ascii?Q?Mi4vEtH/Ygth/69JB2JnwbfQ3Qj6wlDridiiLeKZzHHkiQ9SWST4o9F9gYTR?=
 =?us-ascii?Q?BfLw09Llp8TgwKfgBboTVPRPmkztzzIvP7ohpCGPskVKsuA8FBSX6tXiziOW?=
 =?us-ascii?Q?d/fVD5nFks0EmCqmAMo68PX4AvdDg2Hmdk/HpYBhwYSsv91dbEBypDUggKYP?=
 =?us-ascii?Q?kTjE3zzDdrRlVEitMGcueKHAbg09EmunucXjsJdIRMM4xC3QLI0nplvymR6R?=
 =?us-ascii?Q?lU01inRnLp4EzASAhciGh15q61qKCGOGf4HlNmD5moLnoEg1vCLtxuqdK9u4?=
 =?us-ascii?Q?8bIGnpuvuO8anDazqhIvTSq0fp9PlnF3zxfQ2eoyEKdCVBYxZsxk2J0Wcltl?=
 =?us-ascii?Q?kyJpfDo7th5NcIXwn3dUP8iDw4qlr0gbf3kZsiRh6zNslzzP+VdaIcQFVd7O?=
 =?us-ascii?Q?VOT7YQsv1B4zibi7y53WmBnKvioVCoSPjJIN8GddeBqyFAokd2hPTXzcXxQG?=
 =?us-ascii?Q?PJ3J9+7e/NODAJmeo9EI7gTBVT10uTo2LlRdWnwKDBgF1N5sBmr8IUsW+Jsm?=
 =?us-ascii?Q?FTCo4P6wu1pghxXZsfO5F/daS/IV58Nt9k5iAACINCVnE5Ov0PNIrv8qKeuu?=
 =?us-ascii?Q?imNY?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d56132-3195-408a-79ce-08d8b0850966
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 07:47:50.5305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rZtFDCF5y/OeDzimeOOBVBZMNKsnw8nciaZ1NZSxMhkIOYF3CDN6NVCeknECndRKviXj7ipgYAQs8SgW2ompg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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

[AMD Public Use]

Then we can refine the wording, or make this to be debug message, although the message already states explicitly this is "optional". Split amdgpu_ras_checked_support may not be a good idea since this is strictly not correct -  RAS is not necessarily bind to ASIC type. 

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, January 4, 2021 14:57
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

[AMD Public Use]

Hi Hawking,

Yes, these kernel messages are indeed not harmful, but some audiences may feel confused on this, as they will guess why kernel said " ras ta ucode is not available " during boot up, and furthermore, if the users miss some FWs? So this is to exclude the confusion on the ASICs that don't have RAS feature.

Asic type check for ras is not introduced by this patch, it exists already as it's used in amdgpu_ras_checked_support. This patch extends its scope by moving it to header file(amdgpu_ras.h) for wide usage.

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, January 4, 2021 2:23 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

[AMD Public Use]

We shall check ras ta firmware image size or/and ras ta binary start address to exclude ASICs that don't support ras.

Introduce asic type check here is unnecessary and the functional also need to be modified every time we add a new asic with ras capablility.

Kernel message that indicates ras ta, and other ta are optional one seems no harm to me. this is not limited to ras, but also hdcp/dtm.etc. If people have concern on this kind of messages, we can leverage amdgpu_ras_checked_support to only allow the message for ASICs that support RAS, although I don't think that is necessary.

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, January 4, 2021 12:58
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

Otherwise, below confused message is always printed during boot for asics without ras feature, but with common ta firmware.

amdgpu: RAS: optional ras ta ucode is not available

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  5 +++--  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++----------  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index eb19ae734396..730bc1fe2036 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1135,9 +1135,10 @@ static int psp_ras_initialize(struct psp_context *psp)
 	int ret;
 
 	/*
-	 * TODO: bypass the initialize in sriov for now
+	 * TODO: bypass the initialize in sriov and non-ras case
 	 */
-	if (amdgpu_sriov_vf(psp->adev))
+	if (amdgpu_sriov_vf(psp->adev) ||
+		!amdgpu_ras_check_enablement_by_asic(psp->adev))
 		return 0;
 
 	if (!psp->adev->psp.ta_ras_ucode_size || diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c136bd449744..41d97e56271e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1897,15 +1897,17 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_ras_check_asic_type(struct amdgpu_device *adev) -{
-	if (adev->asic_type != CHIP_VEGA10 &&
-		adev->asic_type != CHIP_VEGA20 &&
-		adev->asic_type != CHIP_ARCTURUS &&
-		adev->asic_type != CHIP_SIENNA_CICHLID)
-		return 1;
-	else
-		return 0;
+bool amdgpu_ras_check_enablement_by_asic(struct amdgpu_device *adev) {
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+	case CHIP_SIENNA_CICHLID:
+		return true;
+	default:
+		return false;
+	}
 }
 
 /*
@@ -1924,7 +1926,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	*supported = 0;
 
 	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
-		amdgpu_ras_check_asic_type(adev))
+		!amdgpu_ras_check_enablement_by_asic(adev))
 		return;
 
 	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) { diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 762f5e46c007..06b5f9d14bea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -629,4 +629,6 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);  void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready);
 
 bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev);
+
+bool amdgpu_ras_check_enablement_by_asic(struct amdgpu_device *adev);
 #endif
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
