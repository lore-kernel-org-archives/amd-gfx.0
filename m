Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC56C02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 11:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C198E10E6CC;
	Wed, 22 Jan 2025 11:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="japV6QXr";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 633B610E6CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 11:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0J+LLP0xdSyykxeAJp9ojKbVLmU31E1AK48JtazepxsLPcWS4ZV8xUPyUDc/NXXiWssTzOpIr3FGlOjARfrBuS5VdjESOwZINWQs2+m8W7d5YDCXKiwLUrvXup+DdJp0/Xq8EizjUTPDCGGTF5DZBE/d0kBfznNiDltJ1hK91AYiZxLuW2Zxju/nwN2umRmZIJHmBXaShSDQ3mEuidhzvxMcZlwTB/jV/S3wMSrt1nccS4kRsBA1Ria4ZkUu+AgeoL+2qyQkKdruMxqhUNFMnOsiym0T4ib5n1p6tZ4UOIX4r9FttXJANa2szGfpwmuhOl9g+5h8LXypJaxZNXAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eezkxOHWur+QnbGCxjTdRJNCwGPEjVbjNm3uLMMCZ38=;
 b=mA7GkGzTnUQThXlPoowdOZE2nKTcDxvb8Jcsau/3kTmn4HviWljSE63PAaTXXK/Gb1R5wtZtss7BuJbcrkaHtEYCPTHmeQfqp12tlJwqnUocDIyY2aWvmzXoUbQtp2XdNvUZ8MmVwiGltaakzAb+m9OKw68NYANf1z6f292mpaB1q9QAa20hTC8rbmHlX44EekxipmO1TdukSP1gcU3rhm3vo7d5SApef4NWBnnkT1Upsg0EqoNKyo14eXHcMLmqssdkx4Y0GCK8n/jSij66xk6nWzMD1s6H1ynr1n3jHpbjUdYOlr3lOYlZMKemNZMhKMRbrVyaMTTNMHU/X3fNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eezkxOHWur+QnbGCxjTdRJNCwGPEjVbjNm3uLMMCZ38=;
 b=japV6QXroxLjb+C+c14/t/9C/z5odWpOBcPNK02FwaZzemq5LrFVopKo6CSFLNbnCVASD/trtPKNjTdzIriGYQ2Af5zZ+Fk4Wj+Zej83Io6xL9V41apynlGmO+JbvcN8IRcN8VyZe24tjxUwXH35fLvOaPX+PijcBRNQHZqoyqA=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 11:40:30 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 11:40:30 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Update usage for bad page threshold
Thread-Topic: [PATCH v2] drm/amdgpu: Update usage for bad page threshold
Thread-Index: AQHbbMIk/Cm6jC1bBUilV2fI069SP7Miq1WQ
Date: Wed, 22 Jan 2025 11:40:30 +0000
Message-ID: <PH7PR12MB879676267B8E989330E3A77EB0E12@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250122113758.13491-2-Hawking.Zhang@amd.com>
In-Reply-To: <20250122113758.13491-2-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=712cee1d-361b-4e47-b3b2-66f52020e000;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-22T11:40:24Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH0PR12MB8580:EE_
x-ms-office365-filtering-correlation-id: 993f554c-459e-419c-fad1-08dd3ad992dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?hKt1kOIvW9KAaFyjJDhniQtE7QWy5J2LOnr4ms0dXpY1YilVlWemW9Wx2fzh?=
 =?us-ascii?Q?p0l3CUs51wgBFrE+oGgiAZZ9iCxZUJIcW+Sf2L6v5KmUz6NvC2O60HvONEM5?=
 =?us-ascii?Q?Ye3xctXgK58clkX+gx5AREADN9uBhtDmNQPJ2cwLXulEk9JoiyLpDHgfEIQg?=
 =?us-ascii?Q?dzjsD2iiYm0/Dp6faGPlhax5XGP9OIrM0pgDLjYUmKO630cSsD0WcDMG/vKl?=
 =?us-ascii?Q?PlmdsEFaBlbd2CsrqFILNFrTp5+XGbmW5BF+M01OIZ1+0f+ySIltc/CQ7ET2?=
 =?us-ascii?Q?oSXdkaJaPXdzEuO7ttMKi1fUvMXz+Aw2dvWaT3pJEdqEBgNiRv/RWvXLlMDM?=
 =?us-ascii?Q?WoOw88B1/2ZqSfK7cVDpj+YkRK1LP0K7cHKGc3jYHoEertRe8ZZH1OnCAYa/?=
 =?us-ascii?Q?reiKoqQJL8Zrg0NoD35d9iNffgZZkF1RYHov7hSCj9q2ufgFyb25mIfDbMNe?=
 =?us-ascii?Q?ePzuDrJI/fWDFaJeTy0t1ouu5+dhKT3SiBCZ70hmDiSro6vJkbH5yMsp22N+?=
 =?us-ascii?Q?Z00DsPIN3Mu3p5hEFvVWVGEZuVQLjtqx1HB0jxKi5DAi198NnJOZFEJPtSsX?=
 =?us-ascii?Q?UTUGfwCxG0KVSAg8TxPiFvVh6+umwLUR0z0+Vx0UqKDaBOR8SMWyYgQy6e6K?=
 =?us-ascii?Q?+DIhr8iigXrNarQpidt3XJjwZp+6LhE87VqIxVyWlGKqVXuSIZkIYGQo6QL9?=
 =?us-ascii?Q?fP4MWQTabNGTjPjQWurzXy80iw0rcF7QBjHmjafEGqFemWWQUK+qGas5uobK?=
 =?us-ascii?Q?xAdoKXrDm/u3vSAnH0KZNlmeCScHq5OZQd1x23lQg24iFVZP0iEortfxnRJU?=
 =?us-ascii?Q?FAziLu9jR1V1lC4XKKfzM1gcRqaJu4ogVVIqW8W4aCTTUJhwllIQ8QA/sOhc?=
 =?us-ascii?Q?cwh155gvGcLUxlVda9sElaZOYqEk7s3rFTlSFpYb/U1zuum9UQDjiQ39R829?=
 =?us-ascii?Q?a+/fH4JvcfYD/uf2BK8+insAklRF0AUKqc6t06ctcXs2xlV9LtHxPSbPILrp?=
 =?us-ascii?Q?nQfcebaOpbRGJlhEYQH7Ir7KgK4CLQqmuIJfozbcxZqFtw9+4unNdwAbDWXc?=
 =?us-ascii?Q?qTXcZQEPdulCCaLYSHSwRstlxaYS3cV1lQ0xPhqYVqz10HGpZ2rM9dLAAMJD?=
 =?us-ascii?Q?86N5Wxg/zqMkmd3VUUH329DvHUwXdAKbbZjrqfL8TaU5IH0XekHt2sH+9e/O?=
 =?us-ascii?Q?kPIx/g+wSX6JwZpbofv2f9KpGjTGxc14QlGwOik9XKYY60b3hdm+n8XCo9Ks?=
 =?us-ascii?Q?3D8STxaI+gipnZMM/jRhWzimjmZd1hUW0GxEgIPLbqV5zIR191qOCEFy4OS7?=
 =?us-ascii?Q?UtCiojSBKONVsk/UZ8aiWn9eAjV5zgkpTKUpiVGTb6vUUw+7bfpD3MJdfgqo?=
 =?us-ascii?Q?2Q2s2WIh3PG0jdZUWu7Uv9pG0hX6v4etGWceyngo/+y7Xrz9KcA/Y7+20fBT?=
 =?us-ascii?Q?wkdC+PuVjnDXLEOG1ouVZYd1Suee8znl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T9fHs6MeTHMUKBsDUyZS5QwHJJ+fV7tHnesXEDzG1nUzfjrNV83WS865YPhI?=
 =?us-ascii?Q?1yyduDu62IzaRexqfhW+MJdb9UYsOD/+I208/Zrj7jYFtqGHvBWW9dEH5dPd?=
 =?us-ascii?Q?cWmt0udkA1YagMvmtt6pfc6HwC9r1K+E1seN2OkFN8a63r1SAbPIpav7Sf5U?=
 =?us-ascii?Q?bndlDIBD7Vf1BB7Qc0ntzEfPYd7HJOzMyI7gnPISkwfh9BktQIHwnZ1JSr3O?=
 =?us-ascii?Q?ft01LRGOPJyboq7sPL/93wNn/CPhEvWEjSo2F7ubBb8jgUlUJo2r672ocbZS?=
 =?us-ascii?Q?R5pDPXQxvhWJGwYc5uhJFKKMq7ejc03T+dFUuAS/9CTykssy0u3gKALk9aPR?=
 =?us-ascii?Q?I/h0/GdCE1WQ4+i3rTmqeP5auyajb9PkGPuK4To3zUxruEumOOo+dTgr/aEh?=
 =?us-ascii?Q?nFdk8EyJEhG1bRgN8EWOKxzAyqR/8s6hIeh06ahsEiiy8X8JUWZnWoEo0hYP?=
 =?us-ascii?Q?LTFWK0N+mnoxG8XIsb5LOp8fSBCb/zRj9T+NI3F1qPyus6oSmBdJcYfB+1Cd?=
 =?us-ascii?Q?fot98TpFQCuoPclPh9N7iF22NgFxnU10F8PF6Wv/wVeWin1C/jDh+4B/xuaQ?=
 =?us-ascii?Q?j6m+dRPv01RLqBpli7uGcwsj9NmG+5B+Ke7lxZcZtxfGRmMBU/Dgq4lJw4fI?=
 =?us-ascii?Q?WYnRWhp3YtdKzjaw6GLfbnrzTQicM+wssK046MMbKqjnaIIMTosRjtYLW2hR?=
 =?us-ascii?Q?KYmkKvipdoYfxdt8RQlvLn93IRXz6CCSzyyEhHaQTXsK3XztwztjRGEgkhhL?=
 =?us-ascii?Q?YOJFrnqGXW9h/cBcOG7K9hqlS6bpg1XZIWhQ6n530VjkbJwhdb28YmufcyD7?=
 =?us-ascii?Q?2lFgdk1OkMlplJh+MZT9uAN5IPGObpXxhFRMsQrT9YnT3QVtF4d1a/l4+LfN?=
 =?us-ascii?Q?UOdHXMUB7zVKDSfzvDnU2FK9wuv/UDD0WPM7frhdOIABcUiqHRKHqsLFpD4Z?=
 =?us-ascii?Q?0VB13PomEhgmXnYjq37fVH1iJaTrQqbRAXJYh7iJqFOG7n2oGFVejuqWqi5m?=
 =?us-ascii?Q?Jqq8GwPweVqjnAcwPtA3rZKDlKo2dmHlO5k/ZvKu1GBneXpfl7TGiJMZbJyO?=
 =?us-ascii?Q?EtsXUMtjrwPtAhnMKNX3MJwnFizzkHJAZO854xIQdM7L8CghRvM+ENQzG05Y?=
 =?us-ascii?Q?EQpr89doZwPb9yf7Oa7lMcBFZMYOPmta3jBt/dKNZEDZ+InTxeXWvGuW1egN?=
 =?us-ascii?Q?td+4QuuF5gITs9qWryxhYiWiDVmyGwME35IdJHjlgAJtobjtSlcyn1zAsgX1?=
 =?us-ascii?Q?azv9vsZAV5NVf0u79mhIMkHv9+UIt44hx9ne8BtfVbs5joxqzLSmUWWdwn8F?=
 =?us-ascii?Q?h1R+BJFV7UwP1YvjqcsfzBeJCodoap2Xt6wqfs+TMbh3fZF37cF/0mMXJHmj?=
 =?us-ascii?Q?Q5aNqSbVNo3yOiFafTfK7OzPAoynCdcoQCn8OXZuKW/Qz131WbO/OpZohKft?=
 =?us-ascii?Q?tAJyc2XtjIg8Zgu/5RkVnj+XK/9GBwo3w38kDod1k7dmOYHLEVQWw/d8V8wL?=
 =?us-ascii?Q?9sCKC91xr3GbQG4f23H9lbItz4hF0rHKAUm6yprJ8TNMQKU17uRqWdIPUAzT?=
 =?us-ascii?Q?+plhAXTMgMYDoXNRb5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993f554c-459e-419c-fad1-08dd3ad992dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 11:40:30.2639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxKKb5WYUCv7yML3/CWekFPs5c00mu/GHPXldANIc0aoOwNcV8H5JsAp0zjfdOfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, January 22, 2025 7:38 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Update usage for bad page threshold
>
> The driver's behavior varies based on
> the configuration of amdgpu_bad_page_threshold setting
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 54 ++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 41 +++++++-------
>  4 files changed, 53 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 99d884e6763a..87ea2e2a062f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -983,7 +983,7 @@ module_param_named(reset_method,
> amdgpu_reset_method, int, 0644);
>   * result in the GPU entering bad status when the number of total
>   * faulty pages by ECC exceeds the threshold value.
>   */
> -MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 =3D ignore
> threshold (default value), 0 =3D disable bad page retirement, -2 =3D driv=
er sets
> threshold)");
> +MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 =3D ignore
> +threshold (default value), 0 =3D disable bad page retirement, -2 =3D
> +threshold determined by a formula, 0 < threshold < max records,
> +user-defined threshold)");
>  module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int,
> 0444);
>
>  MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to
> setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)"); =
diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 960476e6124b..5676ffe5c43a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3071,35 +3071,35 @@ static void amdgpu_ras_validate_threshold(struct
> amdgpu_device *adev,
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>
>       /*
> -      * Justification of value bad_page_cnt_threshold in ras structure
> +      * amdgpu_bad_page_threshold is used to config
> +      * the threshold for the number of bad pages.
> +      * -1:  Threshold is set to default value
> +      *      Driver will issue a warning message when threshold is reach=
ed
> +      *      and continue runtime services.
> +      * 0:   Disable bad page retirement
> +      *      Driver will not retire bad pages
> +      *      which is intended for debugging purpose.
> +      * -2:  Threshold is determined by a formula
> +      *      that assumes 1 bad page per 100M of local memory.
> +      *      Driver will continue runtime services when threhold is reac=
hed.
> +      * 0 < threshold < max number of bad page records in EEPROM,
> +      *      A user-defined threshold is set
> +      *      Driver will halt runtime services when this custom threshol=
d is
> reached.
>        *
> -      * Generally, 0 <=3D amdgpu_bad_page_threshold <=3D max record leng=
th
> -      * in eeprom or amdgpu_bad_page_threshold =3D=3D -2, introduce two
> -      * scenarios accordingly.
> -      *
> -      * Bad page retirement enablement:
> -      *    - If amdgpu_bad_page_threshold =3D -2,
> -      *      bad_page_cnt_threshold =3D typical value by formula.
> -      *
> -      *    - When the value from user is 0 < amdgpu_bad_page_threshold <
> -      *      max record length in eeprom, use it directly.
> -      *
> -      * Bad page retirement disablement:
> -      *    - If amdgpu_bad_page_threshold =3D 0, bad page retirement
> -      *      functionality is disabled, and bad_page_cnt_threshold will
> -      *      take no effect.
>        */
> +        if (amdgpu_bad_page_threshold =3D=3D -2) {
> +                u64 val =3D adev->gmc.mc_vram_size;
>
> -     if (amdgpu_bad_page_threshold < 0) {
> -             u64 val =3D adev->gmc.mc_vram_size;
> +                do_div(val, RAS_BAD_PAGE_COVER);
> +                con->bad_page_cnt_threshold =3D min(lower_32_bits(val),
> +                                                  max_count);
> +        } else if (amdgpu_bad_page_threshold =3D=3D -1) {
> +                con->bad_page_cnt_threshold =3D ((con->reserved_pages_in=
_bytes) >>
> 21) << 4;
> +        } else {
> +                con->bad_page_cnt_threshold =3D min_t(int, max_count,
> +                                                    amdgpu_bad_page_thre=
shold);
> +        }
>
> -             do_div(val, RAS_BAD_PAGE_COVER);
> -             con->bad_page_cnt_threshold =3D min(lower_32_bits(val),
> -                                               max_count);
> -     } else {
> -             con->bad_page_cnt_threshold =3D min_t(int, max_count,
> -                                                 amdgpu_bad_page_thresho=
ld);
> -     }
>  }
>
>  #ifdef HAVE_KFIFO_PUT_NON_POINTER
> @@ -3852,8 +3852,10 @@ static void amdgpu_ras_init_reserved_vram_size(str=
uct
> amdgpu_device *adev)
>       case IP_VERSION(13, 0, 2):
>       case IP_VERSION(13, 0, 6):
>       case IP_VERSION(13, 0, 12):
> +             con->reserved_pages_in_bytes =3D
> AMDGPU_RAS_RESERVED_VRAM_SIZE_DEFAULT;
> +             break;
>       case IP_VERSION(13, 0, 14):
> -             con->reserved_pages_in_bytes =3D
> AMDGPU_RAS_RESERVED_VRAM_SIZE;
> +             con->reserved_pages_in_bytes =3D
> (AMDGPU_RAS_RESERVED_VRAM_SIZE_DEFAULT
> +<< 1);
>               break;
>       default:
>               break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 82db986c36a0..cc4586581dba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -65,7 +65,7 @@ struct amdgpu_iv_entry;
>
>  /* Reserve 8 physical dram row for possible retirement.
>   * In worst cases, it will lose 8 * 2MB memory in vram domain */
> -#define AMDGPU_RAS_RESERVED_VRAM_SIZE        (16ULL << 20)
> +#define AMDGPU_RAS_RESERVED_VRAM_SIZE_DEFAULT        (16ULL << 20)
>  /* The high three bits indicates socketid */  #define
> AMDGPU_RAS_GET_FEATURES(val)  ((val) &
> ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 0d824f016916..0e3e7127c11e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -558,16 +558,17 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct
> amdgpu_device *adev)
>                       return false;
>
>       if (con->eeprom_control.tbl_hdr.header =3D=3D RAS_TABLE_HDR_BAD) {
> -             if (amdgpu_bad_page_threshold =3D=3D -1) {
> +             if (con->eeprom_control.ras_num_bad_pages >
> +con->bad_page_cnt_threshold)
>                       dev_warn(adev->dev, "RAS records:%d exceed
> threshold:%d",
> -                             con->eeprom_control.ras_num_bad_pages, con-
> >bad_page_cnt_threshold);
> +                              con->eeprom_control.ras_num_bad_pages, con=
-
> >bad_page_cnt_threshold);
> +             if ((amdgpu_bad_page_threshold =3D=3D -1) ||
> +                 (amdgpu_bad_page_threshold =3D=3D -2)) {
>                       dev_warn(adev->dev,
> -                             "But GPU can be operated due to bad_page_th=
reshold
> =3D -1.\n");
> +                              "Please consult AMD Service Action Guide (=
SAG) for
> appropriate
> +service procedures.\n");
>                       return false;
>               } else {
> -                     dev_warn(adev->dev, "This GPU is in BAD status.");
> -                     dev_warn(adev->dev, "Please retire it or set a larg=
er "
> -                              "threshold value when reloading driver.\n"=
);
> +                     dev_warn(adev->dev,
> +                              "Please consider adjusting the customized
> threshold.\n");
>                       return true;
>               }
>       }
> @@ -758,7 +759,8 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>                       control->tbl_rai.health_percent =3D 0;
>               }
>
> -             if (amdgpu_bad_page_threshold !=3D -1)
> +             if ((amdgpu_bad_page_threshold !=3D -1) &&
> +                 (amdgpu_bad_page_threshold !=3D -2))
>                       ras->is_rma =3D true;
>
>               /* ignore the -ENOTSUPP return value */ @@ -1428,8 +1430,9 =
@@
> int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
>
>               res =3D __verify_ras_table_checksum(control);
>               if (res)
> -                     DRM_ERROR("RAS table incorrect checksum or error:%d=
\n",
> -                               res);
> +                     dev_err(adev->dev,
> +                             "RAS table incorrect checksum or error:%d\n=
",
> +                             res);
>
>               /* Warn if we are at 90% of the threshold or above
>                */
> @@ -1447,8 +1450,9 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>
>               res =3D __verify_ras_table_checksum(control);
>               if (res) {
> -                     dev_err(adev->dev, "RAS Table incorrect checksum or
> error:%d\n",
> -                               res);
> +                     dev_err(adev->dev,
> +                             "RAS Table incorrect checksum or error:%d\n=
",
> +                             res);
>                       return -EINVAL;
>               }
>               if (ras->bad_page_cnt_threshold > control->ras_num_bad_page=
s)
> { @@ -1466,17 +1470,18 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>                       res =3D amdgpu_ras_eeprom_correct_header_tag(contro=
l,
>
> RAS_TABLE_HDR_VAL);
>               } else {
> -                     dev_err(adev->dev, "RAS records:%d exceed threshold=
:%d",
> +                     dev_warn(adev->dev,
> +                             "RAS records:%d exceed threshold:%d\n",
>                               control->ras_num_bad_pages, ras-
> >bad_page_cnt_threshold);
> -                     if (amdgpu_bad_page_threshold =3D=3D -1) {
> -                             dev_warn(adev->dev, "GPU will be initialize=
d due to
> bad_page_threshold =3D -1.");
> +                     if ((amdgpu_bad_page_threshold =3D=3D -1) ||
> +                         (amdgpu_bad_page_threshold =3D=3D -2)) {
>                               res =3D 0;
> +                             dev_warn(adev->dev,
> +                                      "Please consult AMD Service Action=
 Guide
> (SAG) for appropriate
> +service procedures\n");
>                       } else {
>                               ras->is_rma =3D true;
> -                             dev_err(adev->dev,
> -                                     "RAS records:%d exceed threshold:%d=
, "
> -                                     "GPU will not be initialized. Repla=
ce this GPU
> or increase the threshold",
> -                                     control->ras_num_bad_pages, ras-
> >bad_page_cnt_threshold);
> +                             dev_warn(adev->dev,
> +                                      "User defined threshold is set, ru=
ntime service
> will be halt when
> +threshold is reached\n");
>                       }
>               }
>       } else {
> --
> 2.17.1

