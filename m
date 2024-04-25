Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE15C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 07:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D95D10F9DA;
	Thu, 25 Apr 2024 07:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cvDJMzhh";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B186010EBC2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 07:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1CpvpPm4ptEyeDGK/tuTqku2WWc8GHEVQl3kFM46yudYdI8sPo2LB+3Dsrwt4GQjQX4+qGIOcuZEjTS26CmDvJpvvoAxkSTvYf4H/5gByrrhAgu2vwzM4aFA+bNl0IxvYpZsgody7PnMgmEThGVb0pZeMFGK7zYbnmR17MXqB6nrxRBgki5tUCfruYOrTN2maGpL0q29B+04tSgXIB/0WPUc6bgoagYh7x/rloNa8uSG88grhnwqFK8iyGX8m13CN7Xs2LTU5q3xTvYd2Z/PW6X2twHQTiW/2Jo/adkaskZClVFML53Aivtn798BVq8Vtw3um6qyBrs/96gMaySsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcUAtvtIK5wsUuDer55HrF6iXu1g7F5dNyKfoLUyNL8=;
 b=dlsf51MgLH7lmCOMY1jA88IZbJbkccz6g8DGGikAZF8jnj3CYD7QcMIlC7kIV2x3CT+9RcDUfev0D0qFB87t+LYD0NtDuFynXWHj4ZEgGI7IEtOntTMmBQ6Emga0nlWv+2pb79UdmUhBagNVz+jJYL+CV0zDJPZ06ffkCNyPcWnvJA+s/tI41P0vF/GzxFi9zM2/k8lKKhcM5i/hcWfsg1Eic0yVQI5yX7xcdy7Nt8whRS2w7kyyzBduDdphy+xovaWYTiMLSJ5dFn+fzJqKHF67ObOknnUnz719pyeMbffph2aakFf4irF8rFePKiUHB+5hnmPiGOEB21xhtptJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcUAtvtIK5wsUuDer55HrF6iXu1g7F5dNyKfoLUyNL8=;
 b=cvDJMzhhVsvV7sBivLcrpM5KZqq02AojSu2Dn+dz4UAndFloFIO3k6PFCRNLu8Lbn6IMaOqcyDK3JhZqQlmHFOWEMep7LIOCnZSJoLpXdcTt0WGjR0TI08B/IFwTDJbA0uB9B9K/aHlcsEjL2MB2gqzmCrVb8Af3fGSawLtFvKg=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 07:31:41 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::e45c:ba8b:1eac:6dc4]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::e45c:ba8b:1eac:6dc4%4]) with mapi id 15.20.7472.045; Thu, 25 Apr 2024
 07:31:41 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Adjust XGMI WAFL ras enable bit
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Adjust XGMI WAFL ras enable bit
Thread-Index: AQHalt9THESnnnKFPkK92PjYmvWGKLF4lfEAgAAAuxA=
Date: Thu, 25 Apr 2024 07:31:41 +0000
Message-ID: <PH7PR12MB798877A97A8588243B84B9489A172@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20240425070750.4058395-1-Stanley.Yang@amd.com>
 <BN9PR12MB5257D3F4A81B6235E7382514FC172@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257D3F4A81B6235E7382514FC172@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6ad9cd06-66cc-4512-87f4-a5766a7506b8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T07:23:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|SA1PR12MB6726:EE_
x-ms-office365-filtering-correlation-id: 04faa049-dc93-412d-aad7-08dc64f9c049
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?H6bcA5QPDwv7DpuwfL982g8ZgJtdIeYdEPX3HdQ3zgnqEnB3xbiyhERWsqWV?=
 =?us-ascii?Q?ilWlHdyyU8BEFyBjSiDLukErJsFRDM71DVp6kggUnuGva9ZYka9w5pPGrOHe?=
 =?us-ascii?Q?6T3qPXPaYtjEqbNC2fzHD+tefVYU2XjcQOIHk9qWeGPcBDb/45walu2Ndsrj?=
 =?us-ascii?Q?wqUPRYq/LETb7Xkpsuz4ijuotWTbTGB6lEntsDRrRuRqDohUBIiGgHdButCq?=
 =?us-ascii?Q?ilUBc3V7Zu+21dk4oCwmL3v6XwiYUUK5MBIGU/h0oT3ZxZuvRre8EYnytZnd?=
 =?us-ascii?Q?OISQnzcqudJ/AaA3v2+9PubmtdIQXNToSwYpH6Aq7/jPapGMELgsyVlIkP0f?=
 =?us-ascii?Q?0ePVktIHUrUQt8XrHFxhA+LTfzXkaa1XTUrxmrBVC6lztbMn9pWQGKDipNoB?=
 =?us-ascii?Q?SGu3twZTH6q//trE5enLrV9uvTs/W576aK00ohURb0HCtiKjl5aiu8OcMiGF?=
 =?us-ascii?Q?ZWV0wVGjKN5gMnT2JrXyvxTHyQA4sMkwo7R2LzrgoSpzUHFk7sQG+PIhB1bV?=
 =?us-ascii?Q?8nXb8kUsDRkSDCHettPO7jSZBgmIOKSu9nz4grEELla6feTef+7iB1oLZJnF?=
 =?us-ascii?Q?l/l8RCfK4oqZLQ8Ch8PLBynCufw2NnZyZ/lGKGYKeP32teVx1C565+YvLCif?=
 =?us-ascii?Q?V5B1N5Je7iIwzKalYDPGf/Kpchxp00yjtApTYeF8+Jfuo7qupqGD6TMgvlGF?=
 =?us-ascii?Q?h35q2nGr+Q+QiRWaJvB7ctA+hRlXLfo64T5ZT8cqQ2bX87NSO2SOKqAjJJ3S?=
 =?us-ascii?Q?0oCfWfiQMYBzcJvouJy+ar4C+5quxm5pDSVg3cf7UnduFbWaOCQ4PRuOlPTl?=
 =?us-ascii?Q?EH5Z4LCn6lq5xAf4hB7qnd3RDoFCn5o+nRKVsnIDN1JvlU+yrOUFMpSljql6?=
 =?us-ascii?Q?/Q7cV44bkjNjMQ1jNrQumPiQ++aPjsXsECAFnnoqOw/srpiXRyjrVFYuthro?=
 =?us-ascii?Q?gHUDbcw+5fzqsehke98VLbvpXeXCDHfMZ1Tp9du7uEcX83tOa7XePAC5NeB1?=
 =?us-ascii?Q?ICvcoiDf1DZu1YDmRVfRFH11QWFamA2CEXtlbTjYXHU8hQCoOqUukyQgKsQL?=
 =?us-ascii?Q?dPDYBHnUj8b3034a/fRv0eAFWZrFqJsVOZrT1R/v4hxk68WfDtaK5qro2uNv?=
 =?us-ascii?Q?suTPm1hHW/u8y5g41NJVClJC6BXc0UQgZfi3K6rU5J8hz59LYLv402fF6wfH?=
 =?us-ascii?Q?eCjoaBNmiQROjXZ791TXzDn/r/JRAsvF8G0XJtJLmy7BwMYHfN3uI9JVV+2u?=
 =?us-ascii?Q?U10jHpr/7BAGjhYH/qwN0o0BH/G1UDYV62x/IxeU07HL7PPgd2O+V74fdGdE?=
 =?us-ascii?Q?sKjeAK/+yf9AYD+PXAukrJO1dokq420NtxHP4Djq9K/ymQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NaAasYsxQNEXcIUzAMEOZY7KJyiHeLq4vI+m4+ijRSQikpoPhv2pn6WHBuH+?=
 =?us-ascii?Q?Ob+2dL8i7RO2Dcw+uzU0A/YaqGrK2BtnVMoOA+MSdwXvFlkAJ9WuiBmHdwL/?=
 =?us-ascii?Q?WRu6rt6d8Yu5o5dP18J+K6cm1is7lE610a0it3C8IjzW5RSuB6K37fgF6QcN?=
 =?us-ascii?Q?nNFBFXOsDMG1TkHhcXpwg1TgXg6VQT31M/P5G34rgDPuRWXAEHQOqqXmpebT?=
 =?us-ascii?Q?BVtPhXEFEKy8VXzDARQnawWOpo9E1ymqU7Gi1jIGka1r2ysnYR9wjPudvE5q?=
 =?us-ascii?Q?Z0BVKaUr8fbZgj7A6xJf2KLnM9d9TWof+BIFT/XtGsgkYivvb4D2BMVPZiZL?=
 =?us-ascii?Q?udZ3+2Oe7qBPWTpHt0j7NFy5blC5p4PJ5xXqGNY4nQkIL3TOBkreA5QaupuY?=
 =?us-ascii?Q?1kM837htE4XSUgqq5j6mZv+SMSXohHUsmcSZc9q+v1bNc09ifU4a5/DSixtS?=
 =?us-ascii?Q?U+PjscKAlInkGKgV1SeM846I/LQ3fWyko1HRPhcjyb4GyuGTk5Ok60s/2sv8?=
 =?us-ascii?Q?CQejHTSXItgiOegtVagKhpGvwBjeLvowJKFWgetwjhRUWHm88oDptClgfZp5?=
 =?us-ascii?Q?drTVqwg2rquGuk08u/qI3sWYtcqA7CDvC4esG6CsnPlnB6HDEOhm3nugD6Ki?=
 =?us-ascii?Q?aTryFAn/RPer0TESCSiWuhFlW4sTn81YrJpTSouLP4Wxo0r2gtE9nkwUWAUM?=
 =?us-ascii?Q?MLtDAm3e6jB+u1rWlQa31oMgc5sefGnq1dM+I7T5UaayqhvfeUet5TgQvl9S?=
 =?us-ascii?Q?ecq5nNQOk4d0f2DDZAvvn9yLmY2H4RA4iXSisSfQh7kPFJA1RJu5LXpbctB0?=
 =?us-ascii?Q?yRGlDdu7e7PPdkmBPsrXiqbFgKoMBKNs2YvtUvXpbmfrB1fPocj9AM/X2LzK?=
 =?us-ascii?Q?smCcISUzHw/h/G6b6hvk++vJN4WQ0aBfEZWzxNLz2F05BLPngqLQ2SQvENxN?=
 =?us-ascii?Q?4XmE0S1YpYeGb970nyOuhZJ3q+F24ByHg3RjJ1XSjlOLm1avjkh4xUuLMX9t?=
 =?us-ascii?Q?yGQZs0MjpV8wE1TLgVKalklbEWu5BzzKFkucAbo16mN3BuXuwXjBXZyxLWaa?=
 =?us-ascii?Q?ETiAOVteNHUV4tJgOakN8vnoBdLWpTxjnggeHdR3RURHY49IqKzFIopBy4Nh?=
 =?us-ascii?Q?5S8+ajB2D7rXUb81SGA/R7AGzZiIo0lUVLlDtkbPDoH/Q5WIMZ5Msq2Ulqdp?=
 =?us-ascii?Q?OZ83KmTvGwTHiXLgEtOVXmfUTfk6e8miJ3bMOqTDPSxHzVDQNkB87X9qYipf?=
 =?us-ascii?Q?5nO+prvrUue7uX1E8Cn/emgsaTARqk96ACIg0CtbnI+reTD0zCfybZBVPETv?=
 =?us-ascii?Q?iqV14LN/0IHBaMeFPefE+0pSwI97NayoXzfIQKo34UeGC8vuziF+eLuGm8X7?=
 =?us-ascii?Q?edEzC9ktNCiXdDYpWJ3BSebvFOrPKr1a7VEwrrS0wUks7sVCbIjaOTpTszWl?=
 =?us-ascii?Q?MSBIFfIFef14bybeJ5zgGDlIzTKwS332qlMvC+3g0jBFsNam3kjxgyNvGbV7?=
 =?us-ascii?Q?LQlaQYOx2r5Q7RZr3EqA6/Pov+/l18sD0an7tXo3eHRp8QbnE8WfkK6ZKuuk?=
 =?us-ascii?Q?y3mVHabtGImRZajmwYg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04faa049-dc93-412d-aad7-08dc64f9c049
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 07:31:41.5047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idl/FBlh/EPkQvmc2pO9utC1tSEGu0i8kyMnu/Cj4iciCrmME1VdO0MGTd+QuYyid5Vnx1moXEZRCz2nIzdFGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
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

Thanks for reminding, the XGMI/WAFL caps is set on device without XGMI link=
, will notice PSP firmware team to fix.

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, April 25, 2024 3:26 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH Review 1/1] drm/amdgpu: Adjust XGMI WAFL ras enable b=
it
>
> [AMD Official Use Only - General]
>
> Hmm... we do expect PSP report the XGMI/WAFL Caps. This is different from
> legacy RAS CAP check through atomfirmware. But if you found the XGMI/WAFL
> bits are not set properly in the new PSP interface, let's reach out to PS=
P firmware
> team for a fix.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Thursday, April 25, 2024 15:08
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Adjust XGMI WAFL ras enable bit
>
> The way to get ras capability has changed for some asics, both of them ne=
ed
> check XGMI physical nodes number to set XGMI WAFL ras enable bit.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b2a883d3e19d..ea77e00cc002 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2918,13 +2918,6 @@ static void
> amdgpu_ras_query_ras_capablity_from_vbios(struct amdgpu_device *adev
>                 else
>                         adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RAS_BLOCK=
__VCN |
>                                                   1 << AMDGPU_RAS_BLOCK__=
JPEG);
> -
> -               /*
> -                * XGMI RAS is not supported if xgmi num physical nodes
> -                * is zero
> -                */
> -               if (!adev->gmc.xgmi.num_physical_nodes)
> -                       adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__XGMI_WAFL);
>         } else {
>                 dev_info(adev->dev, "SRAM ECC is not presented.\n");
>         }
> @@ -3002,6 +2995,13 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>         amdgpu_ras_query_poison_mode(adev);
>
>  init_ras_enabled_flag:
> +       /*
> +        * XGMI RAS is not supported if xgmi num physical nodes
> +        * is zero
> +        */
> +       if (!adev->gmc.xgmi.num_physical_nodes)
> +               adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__XGMI_WAFL);
> +
>         /* hw_supported needs to be aligned with RAS block mask. */
>         adev->ras_hw_enabled &=3D AMDGPU_RAS_BLOCK_MASK;
>
> --
> 2.25.1
>

