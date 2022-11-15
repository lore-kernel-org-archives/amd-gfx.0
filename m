Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6C4C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 02:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C931E10E060;
	Tue, 15 Nov 2022 02:45:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE74F10E060
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 02:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOceykITJI8thzAcro1BPwSA1PVdsgeh/VFdA4NG50hvcvF7lyPeit8iP7KcJ4xCbvA5TCLdA0Q/BIuimA+e4duP9T/56JRnjz3rDjetFYD+8HnwDpMOg8iQFXRys+ZFkp7E3NbQVc5IIfv5qTlWKhObKfoxes0FjTQH6p6OyztI5x4HKAiwfODuHBO2b+1QOQUUM1EzZxaN5LmQLOtQAkxOMIAS5QD2RL6hjI2KGapSIMKcRXV52kYgK0lLFrR6EQV8K1RLox+iF5B3DZwl+r6S9jLOp0MoCVnQRdoMxHU7emBCyCV0mtaYYwKL082D+zUy6RnLFwpVceM37MKRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBePd5yigh1qtZXL+VnnWOKELcYeS6pa6GMd/IZMWgU=;
 b=KeIRhHMefrlY/XmwrkUrxLclfGmFxxcsfNiF1fXuNvvkp/XLaaeakoEcZhXTxfE/oJNdI98e0lHgWbJ8r94WgzKUQrYOL7q8xBGpttW9XtFhLrGe6u+yfoKGghriMQT+ntMgamQzhlVrbXEZFUX3+V7ik7sMPD0jPOFnq2tjbDvipElg66CYIwXIdcbyHoekXMPVeqcRenWWghVwgpMUqAWp5m/aYDgGyWd0t08rPFimvMG36dA6T3MzLD0MxAhW9gwCSC6zTI/rGdNMMTk6SvcvfDBEvDYCL/UNV5pw+JYn22sKy9HJs2yYCIZfIRhemH88rOKE89KEjMJHVQNmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBePd5yigh1qtZXL+VnnWOKELcYeS6pa6GMd/IZMWgU=;
 b=cJpv837B284IYH28vFw5AhAAmx3h8OWG+8FtytqxE4tMswcuUF2moz+Aaz4ES1weT47BeYuo2xCvVc8gqRZHqmQ8hvrzAk8fDPC4szfp95rdNHdCpwKvcEBRwwyr4/Hzevp469DBxMqiR8S5C6V0BWs3OZpSf2h05UFYL4e9wH8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Tue, 15 Nov 2022 02:45:54 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a%3]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 02:45:54 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Jonatas Esteves <jntesteves@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix output of pp_od_clk_voltage
Thread-Topic: [PATCH] drm/amd/pm: Fix output of pp_od_clk_voltage
Thread-Index: AQHY+JWVuDY/J7d13km6s7Ay2HAtYa4/RviA
Date: Tue, 15 Nov 2022 02:45:54 +0000
Message-ID: <DM6PR12MB2619FDCED7C17F2B79166462E4049@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221114231325.18698-1-jntesteves@gmail.com>
In-Reply-To: <20221114231325.18698-1-jntesteves@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-15T02:45:51Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=50f95981-3e34-42c2-bc29-306bc573b260;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM8PR12MB5445:EE_
x-ms-office365-filtering-correlation-id: 123c1d06-9593-4ff8-12c1-08dac6b38447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nsX7/chS9LBaumDTt/9vQWk4/8KvXNa8EqA/DO2qDFpMNJeUIHoLU2n6rOVvSu2qn6y3WRWWxC0Umvt2kbcI1VKCEoin2yk5aUppZV2Fp5JejDrVPiqcIPSKb9Ib5zGhnI5WaUItq2fTEkwOKlHri3y4FGgPraMwn6Q36/fomLrvYar9Ygfo5cIMvLUhU/bKojpzdJqDiIp0PcwYIqife88ckMXVlisGGTG0SxqZbaH46NxwmdGULA3GIqr2HP+1A0WV9IDvnbvY9p+4dELmy5OEV+mSK8Ej7mpsuIdz1eQWZE6uaz+i9Xh5JomWJ8/T9hLxKR5X3osB6dAmls6lIHsnyUQUKtzDelsMiwl22s5stj/eWdQ0SDxRZ+YtkwZtorxB95jSV41crNLM1vl2ar+timcuEqFr1K7V54+iyAPw/2nb5Uw3SzhKHrTCE2qZVjy+TczzQn7Xo1yuj3EkLp59GgnokCYrMHOzotcrE98TzrhOAgTEQS3hW8pF4UXWidDdE/0hZzq/HtQhwQPYCcwvbLnGzR2B6lfEPo+b/ulnV7IbGgKoQy3nMMKhYJv35YutRGlvBQ3bv+pNRJhIPpwzBnJghHTd+kVawLaOoG2TAFlhGmqyMpIHKyzXdscWrO8umqO0bd/xobDrEOr4zhdItO7Aej4SWmolkw7Sq71wBBtp5NXrckHpoWyzY9n/Cypr2VZcH5Bnw6bgyjuL/q06PWN956RoVdLNqjRpDxkqjdQy9KC54WbeVCRtKl7RKzxLACeJ88EWomSlPiSTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199015)(52536014)(5660300002)(2906002)(8936002)(41300700001)(110136005)(316002)(55016003)(33656002)(122000001)(71200400001)(478600001)(8676002)(6506007)(53546011)(7696005)(9686003)(66446008)(66476007)(66556008)(76116006)(26005)(64756008)(66946007)(86362001)(83380400001)(186003)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x4Iw6i3IMaET7HQoVJVPWzTarOegBQ2Ngub315nwVi1PaLiCE7vNuY5Aim35?=
 =?us-ascii?Q?J07DDHPSGtNqAvDTvQZCmAhUpZgU7/8+jausDNhNKWeMBU6PNg5gvS3E1T23?=
 =?us-ascii?Q?CQN669t2E0c5wn0pnRNqGpnLhFMAmMlzgBouqL2EX0jAxU4SSFzJNxIEbEKb?=
 =?us-ascii?Q?xQQ27qvOg7bvELM7oJL2H8hUWHNRZQ/1glT3eHRemrIcn4yphmi2oGiZuFG7?=
 =?us-ascii?Q?r7SryqWxLKlGuCazR5GrCEJDdlL034J1KCesPnNt3lUXiHlgHuuE1ToyLfLY?=
 =?us-ascii?Q?7W+DyJQN0Jk+x8n02IzHit8hnYKsWzoNQenoLqdZTF1Zc7k5zkRLEC3ihv2t?=
 =?us-ascii?Q?8G6LoIwZta0xvTTnHwsdK2SjsApB7phql1nHxqZ5dq8HabmQHW6HIRrbltBD?=
 =?us-ascii?Q?rRT1yPVWSjt4njGIh8IYjrQUJmXSuma32qoGlfYUEyb//X7bu6sya0LtQ+Fa?=
 =?us-ascii?Q?jpJ564TT9JfmcRlfBAdQTyv9Wyi0KclG7q+tUwthYv0yWGF4TlldLd5FXGXg?=
 =?us-ascii?Q?Ffkp1+mQH1yD+pSPG80qp2tiaaKEU8/1Bg04gzSUgilnKuTCO4GZj2XQuXur?=
 =?us-ascii?Q?oHdC7U4nMMRUdvsKFXyKJyfM20kr4hAhV9cZfzBOQgVoqqTAtyPGPKYglhqL?=
 =?us-ascii?Q?mXT4E5KG5WF7LyDcr1VC1yjfTu/1Es7xVlH7l0mFfiTQsAwbT6N5FgsKT2rT?=
 =?us-ascii?Q?Oqipd0aDOruNHhVrKqIsW2iMez5xg989pWEkk6MEKFJNwXN4yXes0ogOenzS?=
 =?us-ascii?Q?8G+67thGzUqq0oPDGCsoEwaJpr1XPDa1lVgiLvWdTte0rmVNA1oa/XtDbUo5?=
 =?us-ascii?Q?kGIfnbwYriWgLi8YEI1rJRcu+tSJ8AXyz7eaG4rdhnx+hnAi8T2crlD6AoV1?=
 =?us-ascii?Q?a7epVQyQpSDFaNn3uz92iiLdW5nWct/pvFDwQ+4z02GTF6EEDyH/MQjsu3Xb?=
 =?us-ascii?Q?R8XR2gfwx1JoQM6We4kzEt7IULZN1wac79ZQEpP3iINBlwKhrZz0Y5DZw5e9?=
 =?us-ascii?Q?De6MZeQqaqQRHUvlaEAXwTLf4VbjnfaHzf85ZRy44IJjr8xCUD4364qcDrNE?=
 =?us-ascii?Q?csI/6Z4e//Dpr7MZ6IWEyg6sTzh2T/7F9s/Dgx13dd8AW0RoDURPsrgtQ8sP?=
 =?us-ascii?Q?FOuIMujNOvOa8HEitlTtmR6wfY0Nfxj716ugapUHxwYB0av2XPPN5LZYLqF8?=
 =?us-ascii?Q?gkL5ltdSoDmi+aMxmb7CY9UAAtYVmqx1BR/KWbrPT9UcAswDJ94qZXhifozO?=
 =?us-ascii?Q?FCNW1ofJg9FOgISk0PJuSkudu9P/q7mGJ2ZiJWIwO/xSgQOKottrO+hgrhEN?=
 =?us-ascii?Q?ihqUfOaU9yKk/0Wgi0n0QyeZAPRRgdOI+2SIeY8pmV63uJ+8WZYV/9nLw2wj?=
 =?us-ascii?Q?aWj4ahTVfhitxz26OUcb5NswwcY/g4/UYrRSzgsB33ojdvqY0gvdekZYvnhH?=
 =?us-ascii?Q?L5wiGofjjSwxMKVSk0SCj0cbEGyHUSI0ILcgT87QaXN8htuH8mw12S2NDdpY?=
 =?us-ascii?Q?nbJeICnOJKqMm1J7ePul45oZuCVDqOlUxrsxx7PBFckJZifkHZ8U9NGdVmyT?=
 =?us-ascii?Q?E5DCzo689cmZRgca4XM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123c1d06-9593-4ff8-12c1-08dac6b38447
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 02:45:54.6573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEPWpcStnQv7038e3FsG7Hj2rjW59fE5SxpxXH3Jm2ySPBdqCCXOpcrrFtIdfAIz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5445
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jonatas Esteves
> Sent: Tuesday, November 15, 2022 7:13 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Jonatas Esteves <jntesteves@gmail.com>
> Subject: [PATCH] drm/amd/pm: Fix output of pp_od_clk_voltage
>=20
> Printing the other clock types should not be conditioned on being able
> to print OD_SCLK. Some GPUs currently have limited capability of only
> printing a subset of these.
>=20
> Since this condition was introduced in v5.18-rc1, reading from
> `pp_od_clk_voltage` has been returning empty on the Asus ROG Strix G15
> (2021).
What's the output then with this patch applied?
Meanwhile can you show me the 'lspci' output( I wonder which asic is used o=
n your system)?

BR
Evan
>=20
> Fixes: 79c65f3fcbb1 ("drm/amd/pm: do not expose power implementation
> details to amdgpu_pm.c")
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 236657eece47..9d364bbc78e1 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -869,13 +869,11 @@ static ssize_t
> amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  	}
>  	if (ret =3D=3D -ENOENT) {
>  		size =3D amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
> -		if (size > 0) {
> -			size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_MCLK, buf + size);
> -			size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_VDDC_CURVE, buf + size);
> -			size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_VDDGFX_OFFSET, buf + size);
> -			size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_RANGE, buf + size);
> -			size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_CCLK, buf + size);
> -		}
> +		size +=3D amdgpu_dpm_print_clock_levels(adev, OD_MCLK,
> buf + size);
> +		size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_VDDC_CURVE, buf + size);
> +		size +=3D amdgpu_dpm_print_clock_levels(adev,
> OD_VDDGFX_OFFSET, buf + size);
> +		size +=3D amdgpu_dpm_print_clock_levels(adev, OD_RANGE,
> buf + size);
> +		size +=3D amdgpu_dpm_print_clock_levels(adev, OD_CCLK,
> buf + size);
>  	}
>=20
>  	if (size =3D=3D 0)
> --
> 2.30.2
