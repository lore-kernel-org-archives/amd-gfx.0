Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA0EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 03:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7DC10E41D;
	Mon, 24 Jan 2022 03:50:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E737110E41D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 03:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETneNTEppEu7cpVR029tqwMEaF6Zz/I4M38+WFSqHe2UTinyFDuY5WEmYwKlKecRKyaz40LSgPcaBWiio3B0U8uCK2xdAiTqNQ+6BWWGcwaO7/6rEd9v9fd+klAI1zfHiFAkXNaEULKQNbilQGR9KDEkEEAbaHMAJFsr2RPCUdoZJ/wk4UUmJagxrqUWaN/R5BZDOMvV3/iy/BPFGnGFEeI0vkXIQIHQhFtvX8yhvD/7XtRGTGrVgG8MGP5s3Oj1MID5Zc6PyIuZ2pBAy2+c0H0QuHXkDF9TbXIrfFcwffk37exmtGEJLNWACeCbdXUV5NowimbELHyUX8uu4s9+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cDoubT/79YkriWUiMvkHQmsnB4ZdhdZNGVhH+WTkak=;
 b=Y5p0vzfuVuCm7qKEbgxWoYALVa90/G8YHbCE2ZDKCsMgrbqVLSH5yopQZO5jjyNoalRfZtEcLtm3Ze/94bPFUrsrgGyUbuNlaj5O2a/noMrrc1hFJirHq9k7Zlz3fzTs/T+zQ2AwVYMCf5PPCLxNOXIKbOpJ12UFR1cJHG3HjzSL14c/n+hmv+In0QNcOcorEBsvTktsp0Ye6bxOBKnNbGhbRJ5mEK2cKPaBdQlakeLuqi+f19zJs/khHiajlIzVqZZIj4dw2MVfYQCmHV9VUBvgzWUj2Uw9eDFYNNQupwFNsu4F6qc79R23wv3FJktEoxtPDHXYKC4m8/hlyYSRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cDoubT/79YkriWUiMvkHQmsnB4ZdhdZNGVhH+WTkak=;
 b=ssGF1mxpvuSO/E1gTq0VsNaixLh7BxKAzod+omWSA2oIefkYi3+iJUREJSK/OG8e+qAkh8Mmlv/k4HMYjAEIOHfMid/kZHbUnLMjkRlm/o2evvyXEu6mTvxsfS/jyWEoggLOaxrXxb+PCLT5gU1hx/brTm47Z2wED0OR7m8n0vw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3948.namprd12.prod.outlook.com (2603:10b6:5:1c4::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Mon, 24 Jan 2022 03:50:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 03:50:32 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: handle BACO synchronization with
 secondary funcs
Thread-Topic: [PATCH 4/5] drm/amdgpu: handle BACO synchronization with
 secondary funcs
Thread-Index: AQHYDwSo885B2sHB5keFjk+DIsuOj6xxiYkw
Date: Mon, 24 Jan 2022 03:50:32 +0000
Message-ID: <DM6PR12MB26193FC18A162EF084BC8D12E45E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220121202220.5557-1-alexander.deucher@amd.com>
 <20220121202220.5557-4-alexander.deucher@amd.com>
In-Reply-To: <20220121202220.5557-4-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-24T03:50:30Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=dd2a63ad-e017-48d0-87de-6f4b5925a2a7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c251759-48f2-49e3-d809-08d9deecabd3
x-ms-traffictypediagnostic: DM6PR12MB3948:EE_
x-microsoft-antispam-prvs: <DM6PR12MB39480CE6F0B42D9DFD2C0D3DE45E9@DM6PR12MB3948.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6EPRdYncRdR8xqEHzRctYg5Fp5P8Mx7mxZT91ee9erxuq4oBPrX25WneIQ1Rn5twB8r2ifsUZjDugHbD9a0j2clAKnk4zy5wjoIvhYRf6nEBXJ6JIbSLtb9uS3d0WTMYA5a77oou0+MEpdkXUegKx1HJIaWavvUNxdZDoYIsM+wGeKhIDcY0oJF+h4jgGfwVUEdYlZ4/Bzj/CUE2stAECaqVjYcN20k4qO4KbCTSZr1qa9ZE6nLwT/T85QB2kiGwCiL/oDDmdX+Jn3xZDJ2gWtSep3XPShaH5OnI7MoNOBGKHczyIOgC09nLE/20VY8Y92Ylk8WuJN+jkQzfNLl/IP4WApvxHzF+luZQFHGL63xDEEBpKV5X1g+tCa73cQnIBbG1Flvdm4OQXAdCFK3eRn2/N8rHStpajg7tja9MB/bWbV7Ou7Cnr/c6zWxBdaGrVkC34NaLjcxWx6qsu7Y2mGb/PP8elj0QoMezAWuGcWXxd4N5K1bUsYswRmzJvRhzZ1ejLGvvv2HNkW4PwoisVvwkSN3W6NR/qFeQ5igaxwAL8D9oj2e4Cm+8Mlsv3hAV/rIXq4WIstMm3lo4OmOH4zgwhTEiOyy8mr0ZgD0seq78c6WCYXZ8txr5OlWT3Xi2r/DDsD48UVIaE3yFaYAD6VujPY3hZNZ1t9/dnRUBsh/CqaevmM6HslLXBIr2VUI2m0Ck53j0x/2Va2o7W62wNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(53546011)(86362001)(55016003)(64756008)(9686003)(71200400001)(52536014)(8936002)(186003)(76116006)(8676002)(83380400001)(26005)(66556008)(33656002)(122000001)(66946007)(7696005)(66476007)(38070700005)(38100700002)(6506007)(66446008)(508600001)(2906002)(4326008)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dsTR3MWMyNlp6wGnnL0QFMndGzD5wM25qsX3hlM1mOLLCrwr3/cVZH7ahdJS?=
 =?us-ascii?Q?weBm+l85bIRt+ls0dZydQm2Xa4iYgOlkUCmTW2abMI840DnOqw73+R/edoR1?=
 =?us-ascii?Q?yLHQsxMmLtVGZITKZctz+WmVwVK0FRymEtVjuHikaG3wFL3aMy18/oeVwOhp?=
 =?us-ascii?Q?pryrPcN0/eAV5B0I8OJeS/+9Zm1mW/UBmEWtxflUflia89RpNPhx3lQYuTvL?=
 =?us-ascii?Q?DrR9H1+zs70w8S81+rLQOviyugd2iarBr515VIN7X9RmFAXj2CisuCYr7/3X?=
 =?us-ascii?Q?Vj+zrrmH2aavQSMnsoZgLJoNeWfL6xxMYkcP53vQXBpUKwPFZfXqVa5Eyx4K?=
 =?us-ascii?Q?Nv+tTfA3l+haTRj0DSEUkWQlR+2lYJzFyHtcqUcINfCnJCGattmJZ61/UHVY?=
 =?us-ascii?Q?S9zPWnxsYDnetch8xhGTgrFLJxB+QLlkKtBlXFRG5O+KQnjxNeiZlAaA8bDQ?=
 =?us-ascii?Q?+ixRbYOfSa7PzusX4CEtrdATqy29WQbe48sSwfw+fpsPbpj2K9AesVB6Bw9N?=
 =?us-ascii?Q?8JU39siQO2JocCIjR836cJoba11kQJnK7l9574OQl1ylJB698IFVWsBwynV8?=
 =?us-ascii?Q?7y4gTjJ+Kb3NURHPBiyZyFWaTwJu+QKB0tUH9IkJMy23J/J8UQV51VRzKAVf?=
 =?us-ascii?Q?exrlD4zzvfdN3i3DCtRRfr4Ni5/Yvqv09WpxKtQMM6rzhOoizndKam1I5Kd1?=
 =?us-ascii?Q?OV9EgjsyWhmRTI6ulACGWUdWmenNeMDChbUuQPH47Pr7WJ3TZFvKTDYaBi0P?=
 =?us-ascii?Q?gPP/C+mo5mEjrFbUbUi9U0Vrls5jBGVO5zbC0MEez1uX2xIh5HH4ql9qzm7i?=
 =?us-ascii?Q?yhT02KjTHJ7hQlzhr+WVNIHwOhSxRh6LLOOMhrYCK+Zpxnlah6Oo27urSb2n?=
 =?us-ascii?Q?yxEDtX2GCv6l3r/YXtX1vkPAf6MGcaLr3gybX02eAumWDBA7VlJ3vQgmGkaz?=
 =?us-ascii?Q?CpoAmOYAcsOHRnxyJib+h56t9kdc42cjQudDVW51YPrsyutN4XYolQMbnNwe?=
 =?us-ascii?Q?JaY16M7OHGfbCbUfESvOJ4JiUH7A/DW/rltQkcPqvAaXxvThvx6QLoovSteR?=
 =?us-ascii?Q?xjZKl87g2TmjUw0esrXhGGeoqnvmag8xExB97wXlBP/s+ov1UhyFEQCHcywq?=
 =?us-ascii?Q?+4/N60DRT0s5sXlDpFLIY5yKAeCvHKZ37hX4nZSKF6Ou+BjZHi8LCbruhCTt?=
 =?us-ascii?Q?N032amFX5EQjRyzaEPfcxxRCOPbGjZfyaQsi+Fx/UITykhTKoehQ0EZch6Eb?=
 =?us-ascii?Q?ORFehjQfcOWMGy10chHQ4ql+SfITFUVsxTEqcgZNe3eSvkH+HnXOMCxOdEj+?=
 =?us-ascii?Q?hOgIRYJ5r9TGFDtzdJByIcO6QrXpqw83K9iTs+E59p/W+YdPVw23w2dd4T46?=
 =?us-ascii?Q?BXo4SMWKebYMv6htyeyMlKPFdkCRnSBKyPTsMGJxrJ4sWA9SxXHDI1bYGY+g?=
 =?us-ascii?Q?WEE84+FutANGJ9BXWxO2tb19WXkL7PIhuncDgTa0hP+xbJFFqy5bR1YLZXMj?=
 =?us-ascii?Q?qZBFwFHuGGe0RkWFWrc+k4dtxl+XFk/bECylARC4TekFEDbVqYxegKx1k8wk?=
 =?us-ascii?Q?mPa6xtGJJn0/BxcNazU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c251759-48f2-49e3-d809-08d9deecabd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 03:50:32.4821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxkROnFoSMwIEoDyxRzBUitgFqqTvNNq186rfgSIaPlQqyexxQGq5APEjIrqOCNc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3948
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, January 22, 2022 4:22 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 4/5] drm/amdgpu: handle BACO synchronization with
> secondary funcs
>=20
> Extend secondary function handling for runtime pm beyond audio
> to USB and UCSI.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 30 +++++++++++++++------
> ----
>  1 file changed, 18 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 89c3578bc818..119a5798623e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1968,19 +1968,25 @@ static bool
> amdgpu_is_fw_framebuffer(resource_size_t base,
>  	return found;
>  }
>=20
> -static void amdgpu_get_audio_func(struct amdgpu_device *adev)
> +static void amdgpu_get_secondary_funcs(struct amdgpu_device *adev)
>  {
>  	struct pci_dev *p =3D NULL;
> +	int i;
>=20
> -	p =3D pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev-
> >bus),
> -			adev->pdev->bus->number, 1);
> -	if (p) {
> -		pm_runtime_get_sync(&p->dev);
> -
> -		pm_runtime_mark_last_busy(&p->dev);
> -		pm_runtime_put_autosuspend(&p->dev);
> -
> -		pci_dev_put(p);
> +	/* 0 - GPU
> +	 * 1 - audio
> +	 * 2 - USB
> +	 * 3 - UCSI
> +	 */
> +	for (i =3D 1; i < 4; i++) {
> +		p =3D pci_get_domain_bus_and_slot(pci_domain_nr(adev-
> >pdev->bus),
> +						adev->pdev->bus->number,
> i);
> +		if (p) {
> +			pm_runtime_get_sync(&p->dev);
> +			pm_runtime_mark_last_busy(&p->dev);
> +			pm_runtime_put_autosuspend(&p->dev);
> +			pci_dev_put(p);
> +		}
>  	}
>  }
[Quan, Evan] Although PMFW does not care the status of those functions exce=
pt audio. Logically this seems more reasonable and should be harmless.
Patch 3 & 4 are reviewed-by: Evan Quan <evan.quan@amd.com>
Patch 1, 2, 5 are acked-by: Evan Quan <evan.quan@amd.com>
>=20
> @@ -2148,14 +2154,14 @@ static int amdgpu_pci_probe(struct pci_dev
> *pdev,
>  		 * be no PMFW-aware D-state transition(D0->D3) on runpm
>  		 * suspend. Thus the BACO will be not correctly kicked in.
>  		 *
> -		 * Via amdgpu_get_audio_func(), the audio dev is put
> +		 * Via amdgpu_get_secondary_funcs(), the audio dev is put
>  		 * into D0 state. Then there will be a PMFW-aware D-state
>  		 * transition(D0->D3) on runpm suspend.
>  		 */
>  		if (amdgpu_device_supports_baco(ddev) &&
>  		    !(adev->flags & AMD_IS_APU) &&
>  		    (adev->asic_type >=3D CHIP_NAVI10))
> -			amdgpu_get_audio_func(adev);
> +			amdgpu_get_secondary_funcs(adev);
>  	}
>=20
>  	return 0;
> --
> 2.34.1
