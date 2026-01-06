Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6401FCEFD08
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 20:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FAA10E556;
	Tue,  6 Jan 2026 20:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YwFXMWON";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE09010E44D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 20:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW3oO9vQXoFxMzSiH3wvEDCVeklCtCwUzq1sAvVNCoRHnm03xfjHnOJF1LC0dagC/jIsuYAxWJlZzUmFIahr7SUoniDkZx4S+aDdu9YEqhUFTk6LTu5UsxOGA6TpHIRSJBv/KZMcfVA0HdAri84tuEUY5o0ErI5/wxlxyWcNmRW+lxR4wE5DTstFy0FMj0ixyrT5ovJofFMZmzxzqKfTPw1rlLL+tNPLDeMQ3YKtnsZOVrPX7Xw+m0zhmLKJa1cFCcdOzG2Yw5OCXEsMJ+IkGpbe+ez/WRE0QdGblZxO2tq4Zcm4gynmjWQkktKo/XWjM5WNPsewOvZ0Zl43amt2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JfsFyh1W/c7sThaQcH0dU2AmvE2DtQyog5Tv4U/BSM=;
 b=j6Zh2yK5lW9AaRUBZft0qtGUaxUA7uPtUfy0CExXXZ0vaquDApRoFo9zqHaWsfUqPvwnxP/dYBnOog9cMdm6UZf010LwJXNxePMo1ePE6xzEi7JQjoCvJ8MiIrYrWOYIKVDsBv1GllTKauyYNxDpgAUpF33bXTaioVW1eijHpCYw5rKkKR5T7n06T8rYS2DU+2RJGM9R9FOP7wB6hNsUaFHf0Wy/npZNYWlNVDbRv1y1LTWfZLJgMcaBr1GRmIQgQo/S3wdkNPB5DwEmW6SOLmi+3t/e/S1IHJVTFAoY1sEezDvofoctVfGmf4uEH1xQAqkAhTpqNHH4w4Z8MuBByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JfsFyh1W/c7sThaQcH0dU2AmvE2DtQyog5Tv4U/BSM=;
 b=YwFXMWONKf/3XmdwyR3+nbexV7v6iqOSRqRjJXY7lM7cCM+P1WNOnC3W2+I0ppfwnyCFg/0rnFoQoCW8v52/shLAufv08PqQGb1JPklmPv5w//T2Iu8DQFfQjA5q/C/21kaCvkoDEgdFWRu20BnKY9kVsKeqp+GCovKtqVoOTxc=
Received: from IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 20:47:13 +0000
Received: from IA0PR12MB7675.namprd12.prod.outlook.com
 ([fe80::b2f4:4979:b048:3060]) by IA0PR12MB7675.namprd12.prod.outlook.com
 ([fe80::b2f4:4979:b048:3060%2]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 20:47:13 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Li, Chong(Alan)" <Chong.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deng, Emily" <Emily.Deng@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>, 
 "Yang, Philip" <Philip.Yang@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Thread-Topic: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Thread-Index: AQHcV4zcJTFQk1PUPUaSwNItIN1tFLVFlnsA
Date: Tue, 6 Jan 2026 20:47:13 +0000
Message-ID: <e950970b-2e2e-4151-82d9-928a1787308f@amd.com>
References: <20251117063821.3434458-1-chongli2@amd.com>
In-Reply-To: <20251117063821.3434458-1-chongli2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-exchange-imapappendstamp: IA0PR12MB7675.namprd12.prod.outlook.com
 (15.20.9478.004)
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-06T20:47:13.155Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
x-identity-key: id1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7675:EE_|CY5PR12MB6429:EE_
x-ms-office365-filtering-correlation-id: eda14d9b-fa93-4acc-9910-08de4d64c548
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AMZtfTpYjBiXyNaaz/jFQAlnAqgW/pBS8rdWdepDzByEb3ILuBIm8Y1Qeu?=
 =?iso-8859-1?Q?AdOVU8Kyrneiz/2WDYjWHh0/+XWfbgRgUwuKrenJOXTVqbHqy5A/Iin33L?=
 =?iso-8859-1?Q?SqrRIFqbb8/FwWxCJnwPwdqj7SOAb7nBGGA7c6KgRR1PYTn4bYh2W76XNe?=
 =?iso-8859-1?Q?BmTRAV/9U0jZlyYqOg9hL9zStRLfYvzaVkHwjVP2TKE6jZgHbMLjO/zr4G?=
 =?iso-8859-1?Q?9QA0/i3PXuToG5I7yYTFHRUk3bWP+QCv+vOW0c9jcDYMcNfaw4hYwUt+Tq?=
 =?iso-8859-1?Q?YM9OEC+9DraNIABEkSS8K4jn7+b+0Ick1uRNPigfoXGE+VCd1aVw/LsBzR?=
 =?iso-8859-1?Q?dvtPbOQHRkPwlkgQMKa5tlSXmfweqdtXJEgy+dfybEKjt/9iO9hbCYwXCU?=
 =?iso-8859-1?Q?YSx/bPPJCKbbY7JrdDa8yARddYAX2IqUXUez69fk3dJahRrxiyEuqcaMfL?=
 =?iso-8859-1?Q?XM7oGgVTVyt13fHlAcqyho4/pSKs0t13glifVrP7bC+aOa2YzU9Fu8Rgk0?=
 =?iso-8859-1?Q?pbrxmgxL6tRnCyPlJxArW8/7+T3N3XLmqBoc/RLhcjzIMUruzr38ceve3U?=
 =?iso-8859-1?Q?aX2MC9bvT0J8hJAOvUVBPEru6+p5pS2tHvhra82bBi5eh2nA1yucNKobDR?=
 =?iso-8859-1?Q?z7aGC/pjC9hnbI6q5/fxw5NYttz52vBsAxq6CM38do5GB8EXMda588Tmmm?=
 =?iso-8859-1?Q?O/K0ZngqcOFlHO1MeJqz1a5CED7J0Wjsr7KExsZsDTGv39OmEWuB5E+P5u?=
 =?iso-8859-1?Q?K1fYyt8LxEp1xQC7mIJog2qPEeBb5Q6o/psFg1TWxJxqQ+nZlGaw851vdc?=
 =?iso-8859-1?Q?QyPrGdq7o0tpz5rLcCKKyx4MQfMLovDEZPrEDArLv/M5fCiU0wROtpQnXu?=
 =?iso-8859-1?Q?QfbQiO5tzKurLYNzw5QPK/7EO1mnBaJwtNAVFVrPMPRZM4o/Bbg0tquA+V?=
 =?iso-8859-1?Q?WXBcx7NYPNOcN9MtcSvAP6xI408CQHeQEP37tvxEVh1/IEWHuOUbNgBtNG?=
 =?iso-8859-1?Q?Ll8mcfcZUWkld6u5WsHRH4c7sxVHIyTdtCq3SoBvWqMlUiUCPP2OOq+RdO?=
 =?iso-8859-1?Q?FqFBuLgM/h3ZkonPYv7o+FoY5RkJm7HTtsaxMOI4M0KZjrGmR8MMHM4DqL?=
 =?iso-8859-1?Q?HJ2QlLlrQvtaq1B3k256ws21wsFYNwUpFjnH3b9KMj4hXk/T4oYtMl3tD2?=
 =?iso-8859-1?Q?RBWtX+fd/vlIULlzVKsdl81sZBhn8XEWJS8ngF0oI3YpiQS0Xs56h4fzez?=
 =?iso-8859-1?Q?+iE5LiiDE5bdYrN+1LLCuknYubcoIIowO0+SVOSqo2Ev0QN+d5BSuDTl9P?=
 =?iso-8859-1?Q?XJP/DTfkRWncukHRwGiR5DsFOMuqdOntyKmmcXy8YfB+PZfwbPjZLpUkic?=
 =?iso-8859-1?Q?/WkmmhYc0XgCAM5uu8t5cYWR1MX5LemNrPpBNeG1M+eGEqiIPKwhgSRy4E?=
 =?iso-8859-1?Q?ZaVQqKl/L0Rl6zDPI4QI+3W2Qevd6m1z7xmsrpJV59ZoUNnr17lQEpVVXg?=
 =?iso-8859-1?Q?cGPCbY9nMdOOYlQZoBaf87k15S/sKMtv8qrekcf7QM6v6atZbV4aplfkEK?=
 =?iso-8859-1?Q?qyg+YrkuAzdPp5bR5hQKaoZ+Gyuk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7675.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?45dh+qmyJDjZ6buJdqO+bSo0uCCbz6rBRHgG7N9uDdjU1D0o86GAvjTpz1?=
 =?iso-8859-1?Q?QhjU1QARBNLXJ4HmlzjLrdtwPIDp1p28VxO90a7o4y7fyfuTytaPOyC5BI?=
 =?iso-8859-1?Q?hw9qIlIR1dPQvkGpsYidaSJ8NB561RwO46LqW9uWAVwaUraaWYSurTAxOL?=
 =?iso-8859-1?Q?t9l3HIc30QgUyuyU/pqNPcSX9m2HjJXcNlym/UAjYFoPzoy3WnIvGm/clG?=
 =?iso-8859-1?Q?7/B6J30yHougTELEdZtMYHfcWslcV+pLXyrdtsOt1KR0YkumdSIwdRjUdw?=
 =?iso-8859-1?Q?TDb94tqGUzk+9uiziNljBD5iw2GqEuujwz0m9JpIoz1RoNBdBRM2p1qnlW?=
 =?iso-8859-1?Q?h6e9E9SL2INIrKlo780aYL+R2NOEwQmv9wyDlC7xfRTxUQZ3nAcuLhta6Q?=
 =?iso-8859-1?Q?XLmC8hf9Wd4kOTCS0Ou+7BDpeptJpUsxPVUe7O9dh+QsccQuaDBmqcG9Wp?=
 =?iso-8859-1?Q?j9nMoigvH9FcDfoxGxlRp6INYikmyQCkuWh8Gni9zakks5r0H3M1apK49Q?=
 =?iso-8859-1?Q?cKl/ahjomoBfIGostWIGvZGGH17zU8m1IckRxbaEtrKlhMHm/GE8ygF7OS?=
 =?iso-8859-1?Q?xvxUSmzz3S95mGqbM/MRR1XAaN9NSKeJhBG+0j2Q0hqAEu5LMSNDPY7bk4?=
 =?iso-8859-1?Q?Cq02uZ4Ig0d07dIjM/t3iEjMpbB5p+xMrSy8Bh8XEZ6zuIxEe/WiVgsWOv?=
 =?iso-8859-1?Q?dzltj5yNPtb8O/p5s7C5GC5nDniKN9qd7uxFBoOjYk5+jsKTNvlivxtN5X?=
 =?iso-8859-1?Q?nIlsE//4C7XYUnkpipf24PQ1QjtJMmgXc/JflRZOtC6Oo9po/Nvk/NxXMW?=
 =?iso-8859-1?Q?3XO+bl6Ooh8tTqEtD+TUB81trBEBDw3t4Xv4VvcpIA2JBvRbAm15l0zmpz?=
 =?iso-8859-1?Q?sswj1QAlq+aUiD6p6W9miwAa1uNOdHjOf0srByzEjjK+G1CIGGs2aaXndy?=
 =?iso-8859-1?Q?YR96e2D0loT20eKy9KTC+Fn3VV5CDdnjpA2/uC+fvzDsPNwdqXNml2d88D?=
 =?iso-8859-1?Q?QTwY5I6pPzSxD3n5Mq5+y/6z65MQDSsy4sdnSIDotKDwp5cXpfGg7aey8U?=
 =?iso-8859-1?Q?Bz51EdBeykhn7+Ow6GGheFb9DGfiHZGmYSx84uRdinhqF7LlNZ78b8WZNI?=
 =?iso-8859-1?Q?fptu3xcFr5SIGOKfQVEkTK9J/uXIIWcQ0QqOk/5uvuBVGLyW2VUN8aQsWS?=
 =?iso-8859-1?Q?bHatuIsV7LX49WWt4npQwG13PDXM5wMWkBJ3wHQsXCZN0fIsqrtrGeClDR?=
 =?iso-8859-1?Q?Fn5X8oM/5tFMeVNDf7iRSAVf5x1qutbVbHmbX2XMoiA5cUg67cUf4k6Tb6?=
 =?iso-8859-1?Q?zGxFX2fivAqN2+5fKKGTFali7taSeKlkDW3qPNsMEyU8kZvsJGfu5hhmcS?=
 =?iso-8859-1?Q?zwnnBszsWlKK+lLcWZ47bIz0Uf8OWn8kSdoZV0iwNr0F3Gd+c+GBUbZzUd?=
 =?iso-8859-1?Q?NE2rHpjLolRbcZhvI9LyBA04OeZFyMExAaBGVvA1a6EXCXIvErvuqOGA4a?=
 =?iso-8859-1?Q?6z1UHDphVTHxITsoqeVKZ3m6oiBkPrBFulgmpSAJEkJBmz7riXdJNwPJXk?=
 =?iso-8859-1?Q?vyABrVUDEpl+orWYFN3q6tn4S3E+qQFBDpF3H8vri48wAmm8rj1tVBBE7N?=
 =?iso-8859-1?Q?aC6AAQsJJMt2EllBE4IlmWh4O/X88v9u5ePALMv8AOSAjlRdMk9VmeCEzn?=
 =?iso-8859-1?Q?xsl746FxK+Li99pvbJeOd1QvDeZJwV/PWQP04l6npdXJyioz0SMHq/8Zym?=
 =?iso-8859-1?Q?fYeXNsygZmFI5D7qzrlRrvMsfwKU1BEcfOasPv3rkxkI8F?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C7013B52110ACA4EA904096CA901C549@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda14d9b-fa93-4acc-9910-08de4d64c548
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 20:47:13.4528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5LD9icoZ/2S3oFiD4DX1gPOrDvSZtaa+9XXxuK6wuGv7yOc24b+QT6UQVqhU74mG4ADw0eUHEoEZjt3iChnQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
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

Hi Alan,=0A=
=0A=
Based on your older patches, I understand that this patch is required becau=
se host (gim) driver assuemes guest driver is available within 3s. I am not=
 sure how the 3s timeout was decided. I feel better approach should be a mo=
re robust handshake between guest and host driver. You might be able to tem=
porarily get away by rearranging the initialization code but that could bre=
ak easily if some other change in future causes a delay.=0A=
=0A=
Best Regards,=0A=
Harish=0A=
=0A=
=0A=
On 2025-11-17 01:38, chong li wrote:=0A=
> [Why]=0A=
> function "devm_memremap_pages" in function "kgd2kfd_init_zone_device",=0A=
> sometimes cost too much time.=0A=
> =0A=
> [How]=0A=
> move the function "kgd2kfd_init_zone_device"=0A=
> after release full gpu access(amdgpu_virt_release_full_gpu).=0A=
> =0A=
> v2:=0A=
> improve the coding style.=0A=
> =0A=
> Signed-off-by: chong li <chongli2@amd.com>=0A=
> ---=0A=
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 +-=0A=
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++++++-=0A=
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 23 ++++++++++++++++++++++=
=0A=
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h  |  6 ++++++=0A=
>  4 files changed, 37 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.h=0A=
> index 40c46e6c8898..6d204ba2c267 100644=0A=
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h=0A=
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h=0A=
> @@ -37,7 +37,7 @@=0A=
>  #include "amdgpu_sync.h"=0A=
>  #include "amdgpu_vm.h"=0A=
>  #include "amdgpu_xcp.h"=0A=
> -=0A=
> +#include "kfd_topology.h"=0A=
>  extern uint64_t amdgpu_amdkfd_total_mem_size;=0A=
>  =0A=
>  enum TLB_FLUSH_TYPE {=0A=
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c=0A=
> index 0b40ddcb8ba1..b4e1f258119c 100644=0A=
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
> @@ -3333,7 +3333,6 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)=0A=
>  =0A=
>  	/* Don't init kfd if whole hive need to be reset during init */=0A=
>  	if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {=0A=
> -		kgd2kfd_init_zone_device(adev);=0A=
>  		amdgpu_amdkfd_device_init(adev);=0A=
>  	}=0A=
>  =0A=
> @@ -4931,6 +4930,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,=
=0A=
>  =0A=
>  	if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI)=0A=
>  		amdgpu_xgmi_reset_on_init(adev);=0A=
> +=0A=
> +	/* Don't init kfd if whole hive need to be reset during init */=0A=
> +	if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {=0A=
> +		kgd2kfd_init_zone_device(adev);=0A=
> +		kfd_update_svm_support_properties(adev);=0A=
> +	}=0A=
> +=0A=
>  	/*=0A=
>  	 * Place those sysfs registering after `late_init`. As some of those=0A=
>  	 * operations performed in `late_init` might affect the sysfs=0A=
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c=0A=
> index 8644039777b8..8511b00a7463 100644=0A=
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c=0A=
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c=0A=
> @@ -2475,3 +2475,26 @@ int kfd_debugfs_rls_by_device(struct seq_file *m, =
void *data)=0A=
>  }=0A=
>  =0A=
>  #endif=0A=
> +=0A=
> +void kfd_update_svm_support_properties(struct amdgpu_device *adev)=0A=
> +{=0A=
> +	struct kfd_topology_device *dev;=0A=
> +	int ret;=0A=
> +=0A=
> +	down_write(&topology_lock);=0A=
> +	list_for_each_entry(dev, &topology_device_list, list) {=0A=
> +		if (!dev->gpu || dev->gpu->adev !=3D adev)=0A=
> +			continue;=0A=
> +=0A=
> +		if (KFD_IS_SVM_API_SUPPORTED(adev)) {=0A=
> +			dev->node_props.capability |=3D HSA_CAP_SVMAPI_SUPPORTED;=0A=
> +			ret =3D kfd_topology_update_sysfs();=0A=
> +			if (!ret)=0A=
> +				sys_props.generation_count++;=0A=
> +			else=0A=
> +				dev_err(adev->dev, "Failed to update SVM support properties. ret=3D%=
d\n", ret);=0A=
> +		} else=0A=
> +			dev->node_props.capability &=3D ~HSA_CAP_SVMAPI_SUPPORTED;=0A=
> +	}=0A=
> +	up_write(&topology_lock);=0A=
> +}=0A=
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.h=0A=
> index ab7a3bf1bdef..129b447fcf84 100644=0A=
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h=0A=
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h=0A=
> @@ -202,4 +202,10 @@ struct kfd_topology_device *kfd_create_topology_devi=
ce(=0A=
>  		struct list_head *device_list);=0A=
>  void kfd_release_topology_device_list(struct list_head *device_list);=0A=
>  =0A=
> +#if IS_ENABLED(CONFIG_HSA_AMD)=0A=
> +void kfd_update_svm_support_properties(struct amdgpu_device *adev);=0A=
> +#else=0A=
> +static inline void kfd_update_svm_support_properties(struct amdgpu_devic=
e *adev) {}=0A=
> +#endif=0A=
> +=0A=
>  #endif /* __KFD_TOPOLOGY_H__ */=0A=
=0A=
