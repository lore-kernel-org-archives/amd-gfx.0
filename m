Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0659EC2D0C8
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 01:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9540206CB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 01:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2Cbq13g8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9540206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6917D6E139;
	Mon, 23 Dec 2019 01:59:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CBAF6E139
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 01:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H69MNz+BD/PZsHo6ibVEtTlyH1nyUHjPpkNgq/4eenWLttiE150QU8Wkc+lmyGDZj8NBOnmIv52xmtuiGqjY0hseh7Wl446qlb4QjhfGt6X0BSpVBwFg/Q8fjlhrp1BYVhnnpT6RGO4/F3VVt7rMg3XttPUI9a+Fa5PxcOFJjpLblOgy7gql8QUu4ZlHkvZOZDlKBGBqSK47EovQZupMhhnM/W1XJ7w48OM8BQtyN1ONKpD7Hu688M6N4xHMT65Rw5OF3OodrQa1Bb8XHpl1jgJOxT4lXVzytJNS/u1tusyknh+C0/t+CugJx7wzhJ5f2YijqSnb+ZaB717BWt0AnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylPx8PjQ6QsBujWY3XNEXPN4XyYG+zhy0mKTQ7zcEFk=;
 b=Kd2+Y4+13iSjp6pUtJedo15/Zyisrlh3pvEe5l+69F2gbjyHbvjIdmIxbY1EUEN+tmWzN/DCn0J5wOEHkToUeandSCfoI/ocG9Rjo/VAxCHnXw5kSRmY13kRNiYJc6ueROOg3igWJs7VbNbXanZaDHbAQ/bt8EoCfW5LcTXfmC+YV1gWnxkDkeRiJpk04JkMvTNZ+eUAiI8z3/DX67+uyYprwn8Pz+FvNv1l1L0TU0LfhNehVX3O3aLXynwat5UJdRSXEGdmTfG6KIIjgToBI3WoJR8bIlPLW1KJVJrCsg9769vACZj5ezZDrZLp7RJ3sMV8AXLj8JbfOEXiaJCNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylPx8PjQ6QsBujWY3XNEXPN4XyYG+zhy0mKTQ7zcEFk=;
 b=2Cbq13g8bCjOkNoh+Pch6o4kD3F6gPhBDfXwabMXxmou/OAdzJ48GRQ1k3n4ScdW79d4SpjiwKMGfWel8uIxJMCTmv4VKDMHw7OcUEC+2INq1WCsVk82n+5/pnkHPZQY+deOIONl4McAzOKnhIPE+fT5X5S5bISqsySYdYTx1Ec=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3886.namprd12.prod.outlook.com (10.255.238.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Mon, 23 Dec 2019 01:59:40 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 01:59:40 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/smu: add peak profile support for navi12
Thread-Topic: [PATCH 2/2] drm/amdgpu/smu: add peak profile support for navi12
Thread-Index: AQHVt3IDT/mp/HDM80WJTiKukOASgafG+itA
Date: Mon, 23 Dec 2019 01:59:40 +0000
Message-ID: <MN2PR12MB3344F74FEF2C06A9C63A6E45E42E0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191220201336.1083364-1-alexander.deucher@amd.com>
 <20191220201336.1083364-2-alexander.deucher@amd.com>
In-Reply-To: <20191220201336.1083364-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6e3b4fd4-dd0a-4b42-88b1-0000facd425e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-23T01:58:55Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04dbfe88-b632-465b-e501-08d7874bc583
x-ms-traffictypediagnostic: MN2PR12MB3886:|MN2PR12MB3886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3886ADB501233A27CAC9BC32E42E0@MN2PR12MB3886.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(199004)(189003)(13464003)(8936002)(71200400001)(7696005)(4326008)(8676002)(81156014)(110136005)(5660300002)(316002)(81166006)(53546011)(6506007)(478600001)(86362001)(45080400002)(2906002)(26005)(66946007)(966005)(52536014)(64756008)(66446008)(55016002)(66556008)(66476007)(186003)(9686003)(76116006)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3886;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/Ll7D8VgUhdSRe98XCI95XXNFAXkWJgtAqPZn7WNWwgC6pVbPxz9hGBW1CmDkwNw95HfPVXHwyPrbUrnpQuSm8X1omGMahTMm+gM80ZbVfMLKlEhmPZ4oQV6mtZf97X+JfOlBAMUAPG7h8bsozSvZvi+LRecNTZ4CNhGGFuUZVvJNNHjTj3HqLarttEdQ2yY8VG0uQQzAg8x/wC1BmbWVfRD3arRQTeDmc3F1PA0b1wmEH5pxheqyAzM98+JJoY/Kw+fS9H1+YHb8g6jkRVsWhg8VfZ+qV5WWLogkUDyzsCHKO3I13Rp+j73yGCy3THMjfH8Rgid3dn62vW1qYEkk4zhmZq8KuxcDIUhMFwLJ0737VBIbRHfqnQKdyiYWw4dAQJKptews6WmXAo5W2phzvCRYA220s2PP3zvrMb84yI5m1/4g+LnO6b77aN9ltNtutso3JnyKnJHEyhs8uzxd6HniVcROOINa2CYunY1sgSBjW2wZdc+Yzjyoq8qjFbvu/YqhvjDwlBGwBTJ2iBk1+5GLghzLAj3OM5Xxn2r/s=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dbfe88-b632-465b-e501-08d7874bc583
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 01:59:40.1197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouJRKqPvxdf52Nf6NpV0ojRxSHHBXdupuG9/awjQwLJE0vL8+9sLFXT5J0kXm67k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3886
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

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, December 21, 2019 4:14 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/smu: add peak profile support for navi12
> 
> Add defined peak sclk for navi12 peak profile mode.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 3 +++
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.h | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index c33744a0d46b..106434689ec5 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1628,6 +1628,9 @@ static int navi10_set_peak_clock_by_device(struct
> smu_context *smu)
>  			break;
>  		}
>  		break;
> +	case CHIP_NAVI12:
> +		sclk_freq = NAVI12_UMD_PSTATE_PEAK_GFXCLK;
> +		break;
>  	default:
>  		ret = smu_get_dpm_level_count(smu, SMU_SCLK, &sclk_level);
>  		if (ret)
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
> index ec03c7992f6d..f109401c2ee8 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
> @@ -33,6 +33,8 @@
>  #define NAVI14_UMD_PSTATE_PEAK_XTX_GFXCLK     (1717)
>  #define NAVI14_UMD_PSTATE_PEAK_XL_GFXCLK      (1448)
> 
> +#define NAVI12_UMD_PSTATE_PEAK_GFXCLK     (1100)
> +
>  #define NAVI10_VOLTAGE_SCALE (4)
> 
>  #define smnPCIE_LC_SPEED_CNTL			0x11140290
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Ccc05f630ed9a4f84c64
> f08d785892013%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371
> 24696390890745&amp;sdata=S1dNXVIhtpYQLPueYCHg8oGowg464P%2FlFDlmU
> f8UVLY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
