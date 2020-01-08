Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54755C33C99
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 02:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CDD2087F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 02:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VcBnbrYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CDD2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60C36E162;
	Wed,  8 Jan 2020 02:48:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC1646E162
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 02:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnaPx+wePCZ3EVvdtFu9lpgw59UN7ilW301DaCoI+64OfAOkhqxPvgAEf72cXE5Z3lUXzzNP3IJbNAvzQ3HjR3brSx69v+YQzC7uQ51yxUQcAqh6WXcUgY64/0fWht++W1lD7IuMUmGbKLpBL02Sz2BIDOu0xbhmjXn5QTbhVNiSjy5G2eaPiatV7+RPPqDTtyi4QnHExLpO6/vlQoGvz4mgDbA+w++CDkTK6WVfZ9gWvyFF03kH2iWXgE2ULwmspxK3VHEK5JjQiUNyrQATy9N1OP0QkaNJswPwlNWmnUVG/sPEs0/ma7jchapu84xuQ8TTpb9OkS2t2W8RV9V3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyuF/b2aCQTovSRMhtU2kSMRMrUuQoTdeS8VycD01DQ=;
 b=TqkZF2qkqRXmKa8kpCuQm767WIq7fqxto0i0lEu6m/pFs12WykSJg/OurtwrFk7TX4ZUMIqKGyZbsXRZ70ITXQvuIISnXmxlDNQRMPp8UZQyV13AnOPYZ0pkIqEXwLnL2pY76+FJi80jPILjPT3VaTpltE2PQGM7nTNflQo+EzNBuKS765ewJSqlS5NppPcHGP32H2du9VEqsff8H8kEMEntgBJyWwITTc8VtcV6i/QcS5x9KmdyA1c1zW/udJ3EV+wHKAolsjAkPYyLPMMoDz6RhBcp1ZFdfYi/BRMGlYtv8/UsNp1qqzI0NQEJyeNnrU1NE2QMBmsiOtHGI5AbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyuF/b2aCQTovSRMhtU2kSMRMrUuQoTdeS8VycD01DQ=;
 b=VcBnbrYIUsUUbA6i5EcDgmsSXyGTE/lMo8d4vv4lZz0RDMrsF8MwjBQoybDSLf9kwvaALP9lNVOoNWRXM7U1rkI6YBA5wlb6fFTHP0UL0jhJmzShprkJjyfi9bjAqxzMOYIo3u15tfP/O/elUUsEcCAW+qEMXe5hakUo4YOttiA=
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3678.namprd12.prod.outlook.com (10.255.239.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Wed, 8 Jan 2020 02:48:29 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c52d:5a67:be50:c4dc]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c52d:5a67:be50:c4dc%4]) with mapi id 15.20.2623.008; Wed, 8 Jan 2020
 02:48:29 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
Thread-Topic: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
Thread-Index: AQHVxZ9kJbZcIrU5VUCe5XxDZZ23jKfgEOJg
Date: Wed, 8 Jan 2020 02:48:29 +0000
Message-ID: <MN2PR12MB38381D98F744CDEFA02BCEC4F03E0@MN2PR12MB3838.namprd12.prod.outlook.com>
References: <20200107211320.1820393-1-alexander.deucher@amd.com>
 <20200107211320.1820393-2-alexander.deucher@amd.com>
In-Reply-To: <20200107211320.1820393-2-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=41952cfb-a966-45ce-846f-000061bdb87f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-08T02:48:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9dfebfe2-dbf6-4031-32ba-08d793e53e2c
x-ms-traffictypediagnostic: MN2PR12MB3678:|MN2PR12MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB367858BE9F0D114E222E15F3F03E0@MN2PR12MB3678.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:459;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(199004)(189003)(13464003)(52536014)(2906002)(8676002)(4326008)(66446008)(55016002)(64756008)(9686003)(81166006)(86362001)(66946007)(8936002)(76116006)(66556008)(66476007)(478600001)(45080400002)(966005)(81156014)(186003)(71200400001)(7696005)(33656002)(5660300002)(316002)(53546011)(6506007)(110136005)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3678;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L5liKnautc3SSlGw21DKTW5y1DOgxRXwpr2b9yvCgIL8gFPeArA04UJiN5Le2Clup6myE0ezO841gqmUcF8NBJ7gkq7DmZQUz3V8a5GzU3SpD6SdJwjy75/53LIz34hosqpC0REEDWmpA+BZjxCfNJi3jtwOO8PUA+WCGM+bo4wGuGI/quJwwtX78JAZE7N5TMDW6k/qyjXnHmyP30sY4G/yQhAq+wJPJ9QJczLQUibZ370D6ecnM/BbljIRYaPNATJv1yjOQ5p7O2BZcgAUsNrn24w7ZgM/C9/FFrisJHAfFKN+g9aWJiRQhfX4+3AW100qcpOu4mLrYegMneabzbVTKn70/tp5WAJxL5GEwY4WnMMMoGfo4ebQWAzWbLuuyLdpe8Z8cNIQW5S9ZiiKr6gLTuekdBpH7pVGoj9uncI8kagci9YadeIKmeWiEEf8T17zqfGYTFFS9OSuKbIBWahAQVSMz6x+cxxJnbyH/GpP32mdkpvJopFw0fFUzfmBidh/vE8Ko6oimnyoVapRW0gbeD6fK6rdDCgmx69ZleE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfebfe2-dbf6-4031-32ba-08d793e53e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 02:48:29.4523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNCZcHXBcN4rrwNa1jUFhGcKuXYqP08DD9MfezrUluoG0rDN+spwU3uytqCubBmY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3678
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed & Tested-by: Aaron Liu <aaron.liu@amd.com>

BR,
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, January 8, 2020 5:13 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
> 
> Everything is in place so go ahead and enable this for renoir.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> 
> I don't have a renoir board handy.  Can someone test this?
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 6d520a3eec40..318605ca9bc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -519,6 +519,7 @@ uint32_t amdgpu_display_supported_domains(struct
> amdgpu_device *adev,
>  		switch (adev->asic_type) {
>  		case CHIP_CARRIZO:
>  		case CHIP_STONEY:
> +		case CHIP_RENOIR:
>  			domain |= AMDGPU_GEM_DOMAIN_GTT;
>  			break;
>  		case CHIP_RAVEN:
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 05118c8860f9..3be7ab0ce9e3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -909,6 +909,7 @@ static int amdgpu_dm_init(struct amdgpu_device
> *adev)
>  	switch (adev->asic_type) {
>  	case CHIP_CARRIZO:
>  	case CHIP_STONEY:
> +	case CHIP_RENOIR:
>  		init_data.flags.gpu_vm_support = true;
>  		break;
>  	case CHIP_RAVEN:
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Caaron.liu%40amd.com%7Cd9cdd08e60a942e97c
> 6a08d793b67ea1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37140284454500549&amp;sdata=TGuS5qqX8siW1sxWUZtQggnk4P2RPjxUiLk
> dvS1Fcog%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
