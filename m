Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9ADC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 02:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124A82073B
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 02:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sxSDNej3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124A82073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC87589ECB;
	Tue,  2 Jun 2020 02:14:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A1589ECB
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 02:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMTD3zbXwa4qraYhxaosHK9UbFTss/BYnsCJCiUkrzZIBda30nwGUsyfNIpOoPwi9uo8OcmJ5FiuFzCxiFsww3+GoRROPyB7YFLkjUfiY7h574/Qs93afhgToeX2ox5WHMCyaX5/rr7z3hbAfo5optAHy5mIhYF2IJyjC/SWhJWGjdgf6l6mD/rvYxnYB+YYkjp2a8j606tYCSH24gxtMuXSm8VavUfwSGKUP4lugRaCtR6VZT4I9hiK0X6KVT5O6N1/UpKiuAVLb5Xta3zNRsKwMg+2xSlijbrSDCPkJc9uzgQ45RMHXNM39wv6WS3U2ke3Y2jz437XMBSUxedwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T8yVrhh/8f6KqqkQp+tZqMfQfzF4LaJiEIsc8fhHcE=;
 b=k+NzyE8KMwwCSMPNfMsl4Kd4sgoiykmv/m5VKuUF/bz5w5fRzHLYvH7rwkfhPOR3G5fzgCUKe7OtKppRD9C+IfoOaMRzSfCNuUYdTmP17+n4USlC+dR+MW07UggKrdNZ9kphPZIol7lxOPF99DqE4/GexzMP9HiQCy5mh2DspzuFPDzWu2laRH9+9FgMLSGpVnK7fl1k6c2lql2Ss0CJGDLxeVXI67+nxutEAtDF/hbR4T4hikOqoHlRTLCBTZzhGmhB4iJUB9/wpniBWt0Mnf+MSyfTYRaBPrRhUjwhalLIWApi5Qf4XhQ/jZx9fEAipupuZTZJRur/YBBbQMYFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T8yVrhh/8f6KqqkQp+tZqMfQfzF4LaJiEIsc8fhHcE=;
 b=sxSDNej31BduZKfU94h9WHaLFhsqEiLe+CUD9S6Pj0R1Br9BqTKN55zJ7hgiuu3bRl/0OpodgOvNJqCN+WRd3ddM+Kr81M/NXWPAVcelh3JDLrheGymjOChy1mUX/C8jnxruOxSVDAXq3fndrCb66F0jwhQc/C54ckmlw2D3VLw=
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 02:14:39 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 02:14:39 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable renoir discovery for gc info retrieved
Thread-Topic: [PATCH] drm/amdgpu: enable renoir discovery for gc info retrieved
Thread-Index: AQHWNWkvkTPgNWyIMEW4fjC/qp/jAKjEluzw
Date: Tue, 2 Jun 2020 02:14:39 +0000
Message-ID: <BY5PR12MB430719B6351D4AD64215A7CBFB8B0@BY5PR12MB4307.namprd12.prod.outlook.com>
References: <1590722887-9333-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1590722887-9333-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=35e770d2-0056-4f68-a98d-0000a6400c33;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-02T01:55:22Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fbde06f1-05a8-495c-b5ab-08d8069ab486
x-ms-traffictypediagnostic: BY5PR12MB3777:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB377742600DDA2C5D2102EAC2FB8B0@BY5PR12MB3777.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEkI+ycrggtNf6RUewDPBrYuOZA8ZKtC+ogS1vDQC4PAStjS++Dld9FJ/QGFs9ogdBlwUbL2Z1JG6EM4C9bd52X8+dxcp7aXpd4MTvzJUknfIa0NMWxvZFzBG3Zi9CLF/+gg4KMf3/hQhLTUncCUblaL29e37WvybVh+WSVejER2eGbF4/ucpcH3cgnAddK0MUYitR4mMWuxqtPJuutY0ghzeXreHUu4+Kjy1RxV+FaABLx2OGoGTqooTjtgnvsDI3Ruhra6quqR3+v/QWGfHin/Vu1kTc5leapzd4n0azIaKccOtVwkI6E097ySrIjboKhgLtT7ViKO+ZI6u3K59A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(8676002)(71200400001)(6916009)(5660300002)(2906002)(7696005)(4326008)(26005)(53546011)(6506007)(186003)(33656002)(9686003)(76116006)(55016002)(66946007)(66476007)(66556008)(64756008)(66446008)(478600001)(83380400001)(86362001)(8936002)(54906003)(52536014)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gY+iCDB4bkcGcj+FB+eKS2PClTVlxVv0+bjNpgP691DVCu+L1hPXnI27dOPAQ7pV6RX7SYvRUUKmmJEU1FHoewZUwKIGMOMkXIFPNMRpFnDuE1iKhUUPCVT5FVs3zQxzm7MmAKwVT2DouVLyAwMSqg0KqyuToz5+pXteGmZ1u91tSCB71KzC8g7NxtvLK8rveipzZ1PJwE3soDCcJM9NvJvyHfq9uIxyYUP+CJh2byHjwVQwsgnOE+5Niq7iB7AJiiiWwnsyrraqctjAsB3VZ5sRZM54RhWX9y8unJrgTTHei46MwTrx+3EDf00Fktf2i0aDj7IK8kgtbpdNSNrzwIsZadZiTvmN5+RkBHogyfB26j+EDFY4SjFziqWWxOSe51FhkwietJ6YxFKO3bh4LSedFZYsWW0vJiQwbVXC74rnPPivOURet4wnq0RPJjVWhcnObj4nCJ+AMCoqIBgvsUEqVSWnMvRqo2nQh9oLeYCr7Guk53IN2J/pfkH/1e2e
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbde06f1-05a8-495c-b5ab-08d8069ab486
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 02:14:39.4879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWw64tUlgvzvQP/Pvz0gmCpMzLM59LbgxHWW9fQBaTorWbxYkGiXMDrLGdO0Q4cK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3777
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping...

Thanks,
> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, May 29, 2020 11:28 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: enable renoir discovery for gc info retrieved
>
> Use ip discovery GC table instead of gpu info firmware for exporting gpu info
> to inquire interface.As Renoir discovery has same version with Navi1x
> therefore just enable it same way as Navi1x.
>
> Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23
> ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2f0e8da..bff740ccd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1528,7 +1528,7 @@ static int
> amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)  {
>  const char *chip_name;
>  char fw_name[30];
> -int err;
> +int err, r;
>  const struct gpu_info_firmware_header_v1_0 *hdr;
>
>  adev->firmware.gpu_info_fw = NULL;
> @@ -1578,6 +1578,23 @@ static int
> amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>  chip_name = "arcturus";
>  break;
>  case CHIP_RENOIR:
> +if (amdgpu_discovery) {
> +/**
> + * For RENOIR series seems needn't reinitialize the reg base
> again as it already set during
> + * early init,if any concern here will need export
> amdgpu_discovery_init() for this case.
> + */
> +r = amdgpu_discovery_reg_base_init(adev);
> +if (r) {
> +DRM_WARN("failed to get ip discovery table,
> "
> +"fallback to get gpu info in legacy
> method\n");
> +goto legacy_gpuinfo;
> +}
> +
> +amdgpu_discovery_get_gfx_info(adev);
> +
> +return 0;
> +}
> +legacy_gpuinfo:
>  chip_name = "renoir";
>  break;
>  case CHIP_NAVI10:
> @@ -1617,7 +1634,7 @@ static int
> amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>  (const struct gpu_info_firmware_v1_0 *)(adev-
> >firmware.gpu_info_fw->data +
>
> le32_to_cpu(hdr->header.ucode_array_offset_bytes));
>
> -if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
> +if (amdgpu_discovery && adev->asic_type >= CHIP_RENOIR
> && !r) {
>  amdgpu_discovery_get_gfx_info(adev);
>  goto parse_soc_bounding_box;
>  }
> @@ -3364,7 +3381,7 @@ void amdgpu_device_fini(struct amdgpu_device
> *adev)
>  sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>  if (IS_ENABLED(CONFIG_PERF_EVENTS))
>  amdgpu_pmu_fini(adev);
> -if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
> +if (amdgpu_discovery && adev->asic_type >= CHIP_RENOIR)
>  amdgpu_discovery_fini(adev);
>  }
>
> --
> 2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
