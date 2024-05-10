Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DE6C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6733A10E438;
	Fri, 10 May 2024 06:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3eiBsQGe";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF7410E438
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpdYNg99kxFRBZPCQdKZ6eBZJd3uGvv0H5VxobT7TLD+c+nWoyEtdPYZuMEzATxuy4eUX5zfbCL+cGTBOYV6hcKTvk9iks7uG97AjY5vbGXQgJViNt8Y4N+sbZUMUn038D4PK+MpvmQAU6ZkGx9b21mYWkCyii4d4po3Hw9k3VX5Ing1peNMxfbH4EPVejuygOOpQ2M7u/oS6hXX3CVXx/zlulj+h4VmihENYjYcbw/c1x61fUfACQaXhkAsy1tyrYP5qfjXODhIPh5qvxdUehzDT9mv4e/F7TNXTdPmMs9Pw3OEXRgbVWZPztQIEYRfLsmnyb0EsXBGbD+W4JX1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g3D6p9d2P8nSlShNxr2WOq/8UXrObY747GfjvuLoE4=;
 b=lpHFXT5FHz8u/wpbtDZNTPjEM2e4xR8yHEgOSFv046t7zg1RkdNJZsw3FGJHFiRv7JLndn37Hw1tL6hgmEXRCXFjaYIjRMxvzyckKeUg9bngndyn5BTFd4lOdd0A5pQ5ACwciNY4yScIPXR/GoHp+AYJfQAJipDUr16rY9wPzx9fmTjcbD3PDCfGd+HFI7szcldAos6cc+l1Lw1Cr/NpLmEdqEacuyyBl1lvGYFjVNdxP/IWyW/ZP5hnoCMVmDfCE3U1tDy5TDkEKBTEmidAFrf4EE0YQ/bbX3ZDq3t0C5WfmDIhkWJQe9zKUHHdCuHVrnWOlxf5Bo015f5DTtjWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g3D6p9d2P8nSlShNxr2WOq/8UXrObY747GfjvuLoE4=;
 b=3eiBsQGepX28VuakKmNlLTTudz7RIn/frBmQfbjWrsSshLnzObiv6mpGwUKKzn271oetJVjLjBePxHqz10Op0j1Aac/xUZoJwIEigWjm5dXLXC5dekDnJmDPG1PkD7IlNC3uZ4M0dXo5uFuLBEOPXhnvO/DA8ZDVOz1rKSNsxhk=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 06:45:48 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:45:47 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 16/22] drm/amd/pm: fix enum type compared against 0
Thread-Topic: [PATCH 16/22] drm/amd/pm: fix enum type compared against 0
Thread-Index: AQHaooVYdH4bpc5WHkOnKWcN5s3tW7GP+k1g
Date: Fri, 10 May 2024 06:45:47 +0000
Message-ID: <CH3PR12MB80747117CAE2577B12F7AF6DF6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-16-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-16-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=47c4ad95-df81-4cdd-8fc7-db5bddb07c2a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T06:02:43Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB7200:EE_
x-ms-office365-filtering-correlation-id: 2b59a0d7-731a-4990-d8dc-08dc70bcd332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gDrK6PEedieIDGXPP+9EFB8n657RPlYObWJ574+i2WDfy9ZeBSjGIEilBL?=
 =?iso-8859-1?Q?0yxLPa4pB26hIeYEo2dJavOBWCkXxvoI9ITC+EFyRUgX3k9k6s6BIUgcE3?=
 =?iso-8859-1?Q?8PwGUmwZkdwDDQZeZyRXuCejaN7hRgFXS84WNOjQRKUYZX+I/XqXHY6uUY?=
 =?iso-8859-1?Q?YqxW2sC5zcfI0gTNCD0mZQRrRtg6VHXkCbunMNVaMNQEgxL4Sg90uEHa21?=
 =?iso-8859-1?Q?dQCBzHIRTxxN6QHJRpMbT+VcJ9ifsfM2GcroVvad3PA2/hqqq/oiFt4E7K?=
 =?iso-8859-1?Q?Os4Xts/LvgsqB0Uz99T9a7fz5PKuATX0h14VQl7Au+lpkUtMKpmo0Sa56g?=
 =?iso-8859-1?Q?1clYpRCGy112Pq5XS+bnRed1qY1MBSmOIC1KD2deazaUwri/IpbFtjmXA6?=
 =?iso-8859-1?Q?8oPu1dZPsX8u44bsjplAkoOkpJRMHCOB0+UsjOubLKE9wYqFcRwLfNwEud?=
 =?iso-8859-1?Q?PiE7ls7ejNwZ2AFb2PjkWR7cmTCs3L8uUPZ1aa0eUH5keCsW1V3JrvUR5d?=
 =?iso-8859-1?Q?APVaPyDfkhy5817CfclZ04xffAa21ONRvBRecOdmann5HeVZ7tzjwMzmPh?=
 =?iso-8859-1?Q?XKMowTFRc1mWG0vbOIjbJqt3YvAo21qKvu3Oe1bIQTlPHLOg839mhrKsE4?=
 =?iso-8859-1?Q?i0NkQLIk902h9cti6KbtCLpwTjksGOAwZOfSbQbLi+hx5jysS3pQG3L5ju?=
 =?iso-8859-1?Q?UEt097QgfsyazJrw6fXAHBXWx51eJsM1NbalNJcomB7KE3ZWxuJ5N3crtZ?=
 =?iso-8859-1?Q?TG4qIcq6JVbAgSNWA/crygfstCQuW8XvLbfYVKiNaXo1vk4ajCDj6zlg4e?=
 =?iso-8859-1?Q?fq2qXEsbcyILpm2KfzqSURcs+KhQxbbkXWXjDyOVMwWNm1NX1uhLgDylK8?=
 =?iso-8859-1?Q?G623AsKJh1Ah5AEPAwGgAdB2Q+Yuk4ug37UgBGHqq3/rOg09sHAVbswp7a?=
 =?iso-8859-1?Q?l+Dh3KDnNUAFvuU+krP+nGVzr0VmvJXa5xkFkMbFfD4mwIzvgZfv2St1hE?=
 =?iso-8859-1?Q?tXeU2QEEwCEakGV2pPGLAAYZQL0Ne0IZwrrwKqb5rXHmUiD9TUus0kSnao?=
 =?iso-8859-1?Q?BX3VnOIYod8pqj+jSgk2Get6TLI+stLrp5Ofn6M5WQhYSsHk34LgoskuEB?=
 =?iso-8859-1?Q?Qm65+vukbF9RoVMXXXXHfjrPXKYmflLIrGs9CNRuNfqBFL0+qn7ZKW/iw3?=
 =?iso-8859-1?Q?M6r4SzB4cLdXFvmYTA8+pIZ8SwqE7VJusDXL76uMdFiKx5gh/V5jIbheFP?=
 =?iso-8859-1?Q?eKwAi3WNmi6l9cmgLWTSy2TxQGYwvsQEB8eV01zm6svYcr4YAsTGDp7Jrn?=
 =?iso-8859-1?Q?gRZSNX3qIL2yLCzkuPl86Iil7WOVhKYEJDwSjlwCiO2nheEZFjlBEuoJmo?=
 =?iso-8859-1?Q?dfGGxp2p90BkqYJAGQYFn8qKC+fdUwdQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/a76TrFzaGMrgXoqfHeWYOO5ZeTbWmrz7LAEN1RDmaewefhtULmxDYT95s?=
 =?iso-8859-1?Q?jSMabVSWWNYdNt5Fi9wWOdgWHH3Gc0sVQzEjvcprXYCEQoAwOb5vn1+avs?=
 =?iso-8859-1?Q?Mk3c2RqfIHDhGSYPR5/U0WEAm0kHh7WnZ0ju78U8vit4R45SjlPWzCvEjj?=
 =?iso-8859-1?Q?42Td+oKAiW8G+/IWajUHK22MA32dMRGwm8SeAmIH1+VM1a73sUW5jY/hb9?=
 =?iso-8859-1?Q?TIuWlRxuRv0Bq3PrgFi1WtnYa9z9KCEXqTHN5s6U1mfloysqUPQ0yFzTN8?=
 =?iso-8859-1?Q?Ia8XwfO4loj34/mp0dsDSTD3Tr5B/xChq03iErN1zm4hCPbzZiLH90sLRY?=
 =?iso-8859-1?Q?JX/E1wzfAyUUPI6zGmX2MzH4cRT2FMSOe8s/c5y8NRzV0CT7iS14ywlVtY?=
 =?iso-8859-1?Q?vxEEoJ4PwYmshIEXnH7My0TaOcN5+h4p1gTkdpuQpEcHka+TpVFqYqJqNi?=
 =?iso-8859-1?Q?k1rzNhq541BOImTpwNKvZEce3kMFpSVVDsnxEs66iud3nhOk3QesXlc1Fe?=
 =?iso-8859-1?Q?4PFgtsGMXQtIflOXinW+zkvUNjQ62pUvPbi4f+Pnej0htcWtmV4rxO9arC?=
 =?iso-8859-1?Q?Sui1yjM4LWS+oCdWHhW2bKIsBdKHe1FFuC3wTOLIrrxNpZE+RilEWjBZoy?=
 =?iso-8859-1?Q?3YF46AUzygvqgxUKUgjS0N3L7IxnWE4V/OtLOaZpCvHEV57XhptJ+X1fvX?=
 =?iso-8859-1?Q?MQo1ghsW5dcWwShoIjNpK+5wql3YCIQmLWwfqSuNRVRMy66r1y7v//kSe4?=
 =?iso-8859-1?Q?amaNUR43blkk9yDQO7Huni3EJkBbrG4ZmY31pwmSbCAgIfvXzPzfWTF5jn?=
 =?iso-8859-1?Q?f7T+NA+dBnkhDIgz3/RzY2OI+gD/czN+KxTnhr/AEf95qU79bz5l0/J48x?=
 =?iso-8859-1?Q?O1uGbPD4E5ZpF3HkOcZSkFGDPZmE4v6N3Fb9huKg1/ArJ2C1oCw3xPoDI6?=
 =?iso-8859-1?Q?uv5attTR/k6N1ajVUG8Cl/EiNpSU2CpxGEukmWqPuUjNnzVJ43ISqMRjIw?=
 =?iso-8859-1?Q?S8nhCxQieNfRMKowOq4RXcpJ7ldUVy4ngu0FvU14c7w+opmvdu4PfwS+PS?=
 =?iso-8859-1?Q?InQ/s+gwMSBoDCjromIEY1PxyT+mOj7Td2V2oIt7YjfqO1qa/XCcvY9vJj?=
 =?iso-8859-1?Q?TPxjjBWf1kqNqAb5R6EUfxv4v/DRGJq2rFhw233zUFZwDPNPwZkwfxcUTs?=
 =?iso-8859-1?Q?YK5dqpUNa7CH4a6XDg3POLPIcWynugQoJKxTB1n0mBtsFqnoEgXPmuqVPH?=
 =?iso-8859-1?Q?BCY9ZPlb4GVZfWhl1gg4MF5auZj8BEuVOrSDc7ooOL5D/EgGuy9RmBmO5R?=
 =?iso-8859-1?Q?eS40fRqMP8q3CtE9TCrJtXo/zh9imh0TqOe+VxcqWbML62w2ci9kVA/H4J?=
 =?iso-8859-1?Q?NISmcztQV4iLExdXQ8UbX8WOxV2pZ87HsTTzBWNXP5xy8eGkJrBBtMPAll?=
 =?iso-8859-1?Q?F09Qzim9Gfu5L/ApbGF/Z0K7o/LXHTrH08/bXEPtNb3WGOjJ5OFERyS5K8?=
 =?iso-8859-1?Q?q/VwoPU+AbEjQLR9E169+oa9qJH6EFZUarRl9FfDdE7pQlaStKJ4usPKkx?=
 =?iso-8859-1?Q?sUZXhkWKPAC9b1reipfxFXwEs+i0dBOLxyUwa/26NBaQLKBiZueERsYXi3?=
 =?iso-8859-1?Q?Xug7cgL67zToA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b59a0d7-731a-4990-d8dc-08dc70bcd332
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:45:47.9163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGsv6leWD1hElkOJK45ASrrruAxH9jet8WuqNLVzI6zQ1Dcnon3t48+Xo+wGyxTXR5BCQ6ZX5XE7DUtTA8JprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, May 10, 2024 10:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 16/22] drm/amd/pm: fix enum type compared against 0
>
> This less-than-zero comparison of an unsigned value is never true. type <=
 0U
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index d439b95bfb79..602aa6941231 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -56,7 +56,7 @@ static const char * const __smu_message_names[] =3D
> {  static const char *smu_get_message_name(struct smu_context *smu,
>                                       enum smu_message_type type)
>  {
> -     if (type < 0 || type >=3D SMU_MSG_MAX_COUNT)
> +     if (type >=3D SMU_MSG_MAX_COUNT)
>               return "unknown smu message";
>
>       return __smu_message_names[type];
> --
> 2.25.1

