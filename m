Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CBFC3F2CE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 02:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F912469B
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 02:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oknegmBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F912469B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFBC6E9A6;
	Fri, 28 Feb 2020 02:58:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E57B56E9A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 02:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Brr7jdnej3NU1YVGMTbhtrv+L//w+6DfTxFYTRfKY2wrFRf7eC90UqY3VIjDNUZ/Ze4t1UjdT+GyvdXGqvk7VKphbZLMiD1akPUe57KmD7XI0+MMnJsf7oefOQqXqdCohrqVEwcLzCT0VCi5Pj1diXgDuJr0YMP4YtekPmaG0HzaLd9y8Of94e2S+9V22z1VMJtJhURICyd/BeyMWiPnjkBprOKgdUG0/jdPMKQH+jdf7wrX5FD+rLHT6j1apu0MONDyJf0teuGrDCliJSVM1jomBqFnCVVDyyHc/P6v73Tog2t3atG6gdWCjIJvhx2B1Yfl4lcDbryIpykVfy7BUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp/4/tQ63YpMXh2iRngyMIaKc8U2f2/c5NoQYw9Hz/M=;
 b=MppiK8iLOgStrdgzsFbVSom90/sm1ZBH7z4F/qsum8tLUyCSbUG2XMTNIJjkM2kBX4+Z39OsXIu6CDS+cy1739mPPEfyU+CwiWfohMxeDBSNf/0DpJC3zYftLpOGaP9Mb1zW2U2AfC+O/+jQfoaIKaHhT4Dh5bMpPPiyqOb0RaGhEKFKELiEgTq88Erj5ByabD/sFm3CyucQ4MqcRcnqDFpjQbGyj//qnvkxtLcrDTH4qu8okL8dKaVsXusbK8jHcxPOChctVW/w4OWN34Cl8WOJ0HV3Yujat2lp6ZHoksBYkIkgRX2/nIaSPPwAMSdQ9pAcRRZYJ0V4NGxLwHf/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp/4/tQ63YpMXh2iRngyMIaKc8U2f2/c5NoQYw9Hz/M=;
 b=oknegmBJUl6KBzS6K/Mefichta24xxQr1hZc+dJeK+GaMTkBNOYa1GmKF/tvdcZbVBn9C8Qif4eNqtLY3fJGOnearJ1SmU+2nU20tUuk6MvjwsZ577wtDoj48UggZVzsPlJsijNfIyh+vsxBs/oOs7O3hkw9DoBdFQeVgxjvNJ8=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 28 Feb
 2020 02:58:21 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 02:58:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Wu, Hersen" <hersenxs.wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock
 settings to smu resume from s3
Thread-Topic: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock
 settings to smu resume from s3
Thread-Index: AQHV7YYgrtvifOjtV0Ge4g/Lc3C3bKgv6n+w
Date: Fri, 28 Feb 2020 02:58:20 +0000
Message-ID: <MN2PR12MB33448440496BD112CE52820BE4E80@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200227155349.10993-1-hersenxs.wu@amd.com>
In-Reply-To: <20200227155349.10993-1-hersenxs.wu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3660e013-cb2b-405f-a39c-00001cdfc665;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-28T02:57:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72762de0-934c-439f-2a4b-08d7bbfa1227
x-ms-traffictypediagnostic: MN2PR12MB3598:|MN2PR12MB3598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3598EBDA76178159A83D51AAE4E80@MN2PR12MB3598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(66556008)(86362001)(66446008)(316002)(54906003)(110136005)(64756008)(478600001)(6506007)(53546011)(33656002)(186003)(9686003)(66476007)(7696005)(26005)(55016002)(81156014)(8676002)(4326008)(52536014)(81166006)(71200400001)(2906002)(76116006)(8936002)(66946007)(5660300002)(32563001)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3598;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VgFx7ZP0gN37RrzuvB8gDP9+iAuZPv9oMvYISxC0jA9Vdr519jnO+jDrrqTvsF9gsKRv9rGqpb5ie+ed0d5fxWKS2AHL2toBauGa57NlUHGzTe47/VUr8xnTdG8Ol3w4OLqEFf1+SVJNNG+QapX9G3hkj03EhGXedaonLGa3D9+K9UVm4rB51BHlgvk4+BrjhJlCekO774CHcw5Fl75Fb9Z7hNTasgtSby4I4qLUd00i2OX9d3WywRbsgqlsurqllyhkB+XtfxRYVORw578JDQKhAlkzhgcvNtfFjWdC431i4zXopMG5NMG+jJ2CjoASxbL7LzYuuc0U6uWO7bsy/TlRucXJk7uy8qcW/5zFYE4b+ke7opCFq9kCr8hc875rFMZgauPOHp2XBgj3mRGAgyhbuH3gD3U673fPiSK1CxI6om9ne7xuOdasegsbK292oinj5ijTdml9JBhN78ngUUONGOB5U3AHTjRiSCUlusa+TJQubuo9/dPADaVEI+QZvP98U/6uAZ/DVbWc2byCsw==
x-ms-exchange-antispam-messagedata: lLipjc7ByuPPA7cUghvw9Tt4R39ermOqZiIIM18YoqGpqH03TURosylm3r8h7syj40ZJUv2pEbBl3ST359QVLTcyo8hquYY4wNaOnXmzUg58J1fpDY/Rl4+9iZWfxkI/Sjre62MwUzldQI31dmzIDQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72762de0-934c-439f-2a4b-08d7bbfa1227
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 02:58:20.8064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4bemgFo+NN/nqW6Jp2EdaCmju9agHWgudd8z/DkcZqZ7EdhE3XovQY1WJk+FVL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3598
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
Cc: "Wu, Hersen" <hersenxs.wu@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks. But could you help to confirm whether this is correctly protected by "mutex_lock(&smu->mutex)"?

-----Original Message-----
From: Hersen Wu <hersenxs.wu@amd.com> 
Sent: Thursday, February 27, 2020 11:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock settings to smu resume from s3

 This interface is for dGPU Navi1x. Linux dc-pplib interface depends  on window driver dc implementation.

 For Navi1x, clock settings of dcn watermarks are fixed. the settings  should be passed to smu during boot up and resume from s3.
 boot up: dc calculate dcn watermark clock settings within dc_create,  dcn20_resource_construct, then call pplib functions below to pass  the settings to smu:
 smu_set_watermarks_for_clock_ranges
 smu_set_watermarks_table
 navi10_set_watermarks_table
 smu_write_watermarks_table

 For Renoir, clock settings of dcn watermark are also fixed values.
 dc has implemented different flow for window driver:
 dc_hardware_init / dc_set_power_state
 dcn10_init_hw
 notify_wm_ranges
 set_wm_ranges

 For Linux
 smu_set_watermarks_for_clock_ranges
 renoir_set_watermarks_table
 smu_write_watermarks_table

 dc_hardware_init -> amdgpu_dm_init
 dc_set_power_state --> dm_resume

 therefore, linux dc-pplib interface of navi10/12/14 is different  from that of Renoir.

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 931cbd7b372e..c58c0e95735e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1435,6 +1435,68 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 		drm_kms_helper_hotplug_event(dev);
 }
 
+static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device 
+*adev) {
+	struct smu_context *smu = &adev->smu;
+	int ret = 0;
+
+	if (!is_support_sw_smu(adev))
+		return 0;
+
+	/* This interface is for dGPU Navi1x.Linux dc-pplib interface depends
+	 * on window driver dc implementation.
+	 * For Navi1x, clock settings of dcn watermarks are fixed. the settings
+	 * should be passed to smu during boot up and resume from s3.
+	 * boot up: dc calculate dcn watermark clock settings within dc_create,
+	 * dcn20_resource_construct
+	 * then call pplib functions below to pass the settings to smu:
+	 * smu_set_watermarks_for_clock_ranges
+	 * smu_set_watermarks_table
+	 * navi10_set_watermarks_table
+	 * smu_write_watermarks_table
+	 *
+	 * For Renoir, clock settings of dcn watermark are also fixed values.
+	 * dc has implemented different flow for window driver:
+	 * dc_hardware_init / dc_set_power_state
+	 * dcn10_init_hw
+	 * notify_wm_ranges
+	 * set_wm_ranges
+	 * -- Linux
+	 * smu_set_watermarks_for_clock_ranges
+	 * renoir_set_watermarks_table
+	 * smu_write_watermarks_table
+	 *
+	 * For Linux,
+	 * dc_hardware_init -> amdgpu_dm_init
+	 * dc_set_power_state --> dm_resume
+	 *
+	 * therefore, this function apply to navi10/12/14 but not Renoir
+	 * *
+	 */
+	switch(adev->asic_type) {
+	case CHIP_NAVI10:
+	case CHIP_NAVI14:
+	case CHIP_NAVI12:
+		break;
+	default:
+		return 0;
+	}
+
+	/* pass data to smu controller */
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+			!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_write_watermarks_table(smu);
+
+		if (ret) {
+			DRM_ERROR("Failed to update WMTABLE!\n");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
+
+	return 0;
+}
+
 /**
  * dm_hw_init() - Initialize DC device
  * @handle: The base driver device containing the amdgpu_dm device.
@@ -1713,6 +1775,8 @@ static int dm_resume(void *handle)
 
 	amdgpu_dm_irq_resume_late(adev);
 
+	amdgpu_dm_smu_write_watermarks_table(adev);
+
 	return 0;
 }
 
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
