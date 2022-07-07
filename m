Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B20C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 21:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4824B11362E;
	Thu,  7 Jul 2022 21:35:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ACAA113856
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 21:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROLH8+hp4eoHlB2lWr3/5LrEL8f5pbnTYfCDCmNGI9HqLjY0gBFOt/TLJen26XFBCn/kgHNnBVDYklg7i8MLjHee+qs74nS6M0mGcQAxzkz8VkxNXbdCKIYohqBw+GUGgQDSnprmYcmIF2g0sjawQNNmI7HHxP5L0GY7G2La0vo8K7ss/R50PqKviV3J9d+4Rk/TkvSszEdaX67VYFfA3/wFTgVI1uam7BSbskJKAuYY6TCALCQ+63aTHajbH+hUVBN1egGX3aYopH6Wa7odLlfp6tSFraH7YaDJeXDocjkZN4GRXKQie3EaLWHnb0vGToFBILNXLTIT/VjknZi1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQQv5ZlAGq2NR9GtzHkNzQ3DAFwjdAnW0g5ECaGdN/4=;
 b=XNIJ3WTIj1t/3gN5yOq2cS2jKBY1s9464aCbg4ev/ta7hJXuCNyWC2A5tQPU9pvTIBxrm1Hh9tS4A1EAphLi6utzGsDo0SqQDkWyerTPfikSAzl00IOxTsBdvzfIxpgyf2vT5BsJzsj/s64Q649Ol9q9cVhyT0CK1H+ryIEN3ere8reTCEDkqx1mVwurs4Z49fRYo59GrGdlR3nJjaFhbuO97EFLxs5sE7MFXEreFeGW6WYiKhjUD5rkuDgoap8mHCI8ta0bC9ksKrwH23EVyXPgQYnESPNi2C/uHaRw83IV+vtNFz0RlSS6/gAd6/fHVSr0hkSlDo+nYy+KsEpkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQQv5ZlAGq2NR9GtzHkNzQ3DAFwjdAnW0g5ECaGdN/4=;
 b=jW6JcwZ2Bdpimy6i1ZxJrVrqopnPkHpDgPFnbrhpqrNwjjCsbToGz/2yrwFC5GR1obv2ojEsQ7lx0T+EYfad1GdYmFW5AHpAvU+j4vTH1riHWTdaemqPo8j/RQ9OAmT/N3ANIDET6qQMc+2Sb8OdekmagzBY6MW5fLv/vJch6VU=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by CY4PR1201MB0166.namprd12.prod.outlook.com (2603:10b6:910:24::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Thu, 7 Jul
 2022 21:35:07 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::b857:1b2f:d637:9b8d]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::b857:1b2f:d637:9b8d%7]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 21:35:07 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Select PCI_P2PDMA and DMABUF_MOVE_NOTIFY
 instead of depending
Thread-Topic: [PATCH] drm/amdkfd: Select PCI_P2PDMA and DMABUF_MOVE_NOTIFY
 instead of depending
Thread-Index: AQHYkj3LUbJ/mYLaeE2nI0fJTIWtnq1zW4UAgAABo4CAABA7YA==
Date: Thu, 7 Jul 2022 21:35:06 +0000
Message-ID: <SN1PR12MB25753890EAF97B5DD24AE09AE3839@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20220707201135.5070-1-mario.limonciello@amd.com>
 <SN1PR12MB2575AC720C83FE2193811981E3839@SN1PR12MB2575.namprd12.prod.outlook.com>
 <MN0PR12MB61019F4FB71D60DB46065C9FE2839@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB61019F4FB71D60DB46065C9FE2839@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-07T20:33:28Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=dfde5a13-b2c3-4f83-8596-13ebbf2faa9a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-07T21:35:04Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 96f9c4bc-4fea-4042-8639-7299cfcf1950
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 507acfc3-77e8-49dd-a581-08da60608fac
x-ms-traffictypediagnostic: CY4PR1201MB0166:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +NAV0gSL+nzNI+oQJULna3Y8UUhGVn0Sg7rfukc3J3cK5DSJMpXcvFa9uT2eGEte+8yC5W9Y+n6uFJFdiAynw9iM2FWj5Y2153qmhAQNnfwSARE00NJEoLHCcp+VidUs1afSrFZINDb/q6fP0o58oeSSXAzKU6Q0BCfQBOFhSolEj2Wpvd8NpBLeYRqpZHHTSnvEdu/lXXH0One+//4UjGQWtyLGCVv1XrCVIRafBSW+eWI3ArnASe0P0AaLHAgzY/rvFrHVW4w1pcwMGlIil/me4lvTGr+68Hz4GF/z5U8iHb0It0dSRGSqTTJI4MHfdU4BzM1Dilo8Vc3DOhd+KHMfpXg7FQoh/IZ1lLFUG166cwQIxJvv4xBGmekDPrAyW+yZQN0KbQ0+FEn8mYDgLENKVV9cfslZNg5cNOzml+0ydQNFXsinSdrzqhuOoJbD7EGjVuutFL/6zSjXyxST8RS9dvBD1F/kxLWQnAiICHeVuX18Aa/33tHv6SUkv2DGPnrNryFli9mZQ3URo8nib3lk31nwa9uQpM7fnu92XHB6JnHnNilKLF4wGOxUv/SSDhjgqrSQjXf14fRzdb2nT+VpDEUtBDSiqAkW6gjRz65QkXKLZhIaSr9BRzJeqw9qVAGfm/8+4Wns1pr9z8YNeCfv5gEQ3DfN0C5yFhc6vSg0MgI/hWsaaDGuOFOkPauFXnhcp2d+YJ5blmQsnXxYV1XoP/iQvphNw6V75pOhh8+RXXTYiHJX2LHCENq44rgi80dox7K3yPZ9jgnP7VyEusx0FXXaPgJsv4NEa35kU3YKPsav31BnpHLm1x6/kNze
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(2906002)(8676002)(66446008)(66476007)(66556008)(66946007)(186003)(55016003)(64756008)(6636002)(76116006)(71200400001)(26005)(110136005)(83380400001)(41300700001)(9686003)(7696005)(53546011)(6506007)(33656002)(38070700005)(5660300002)(86362001)(316002)(122000001)(38100700002)(8936002)(52536014)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ee1D2EcscS3RgoZJTc+sgd0rzfnODEWItZU3pLr+H1L9TTWccYG9WI/PWDPf?=
 =?us-ascii?Q?TIExEQSz1h6R07QU9YUaJqbir7mH8DOQIf6LVY8JzKNERm8S9Bopp27nyZ7g?=
 =?us-ascii?Q?/E5JuuiMRLT7q8X9nEEs4IbXUGcy5gZjHdzUzRo8c4a1UQXUI3RsARt6PIRm?=
 =?us-ascii?Q?VkOnGmbht4fjwpfcuSGqPhlewvIJl02btFWJCLVvZEP8NGi78hdqOL/0Ig75?=
 =?us-ascii?Q?TC4NxJ0RGgMYGU1qJTLANEVSey0l6iM5mSmOT2MIjInf7gtiei95gEeuNAL6?=
 =?us-ascii?Q?S8mPtE3eOnl4L1H5zOaPSW8G4uo2I5Xtp0hvgGP7nj7PsnSNtflsyeT6nFxy?=
 =?us-ascii?Q?rO80k9dDKfjJyrjKwiMSnA7r42MhrzDgU38pWuWFZCND2Loam2jHZBGg8Yok?=
 =?us-ascii?Q?p4RmEP5D1CM76xVqTWFk6EWi9w6Bo8wz4y8bU+BHM6gCwVIl4U5rjQXwbY3K?=
 =?us-ascii?Q?fppB4nyCpsjBb700hVrNlhBR9LyjxFod80h5ZQJZg4wE1mSROZ4htIjsa1DF?=
 =?us-ascii?Q?8KsR5mALND0bOc5AG+sO9CIyaJM5zp3S/JDQF0f/PLi5IiLi//m7Yp9KCAKH?=
 =?us-ascii?Q?/HaO7ofF0oX8HyoNesQfFikSaDI/S7L5XQj/EGc1Zl86toRP7piPC0tUcD3j?=
 =?us-ascii?Q?nE0w61BU8U6Vw57/ESHtTpAAyFXP+VE/4ipnGjeju26/ohsO6kjO11NGpl7m?=
 =?us-ascii?Q?dz8O04lo8WEc3SGhrxIWW0jIKmHoAv+wA4OoWIRDr9IR0a41RvbAocHYMHZl?=
 =?us-ascii?Q?W8hHDc1zjJhmuFdW+mQWwypkyqMHHY9TiFuaOapaL/Wn5D+nAOJleHtR+OL+?=
 =?us-ascii?Q?UCicNlBej74H9VVkhJAzUhPKtUlouijDErpNADJifYULGUUFCH3qFrX6LkPd?=
 =?us-ascii?Q?PS2FmsXQxfh0ZBKWS3It/43F0Gya9bOwWhXHESIhgnQYXRXNYmhdTa7hqEri?=
 =?us-ascii?Q?GJwgO1hYMJNTBKCGUSKprVwOCln7yZJ6N/mjv98sCyKq23WNKXzX4jLHLZSG?=
 =?us-ascii?Q?7VmLdj2bDkjuBJBNWCa0y6OI6BEeXG5qitri8WnmVwc7i/zx4Q3AoPOWHbeK?=
 =?us-ascii?Q?Wf6Yybq/hlWdP+In064o1kV4vfzaofBWi5VOluYUQXVAM+zD9vdlOzGNeG7v?=
 =?us-ascii?Q?EbwdMgTLW13QFmzmj8hYCZU5HvlqPQaoDv4nm4W8uOmjFyqJ9SWSVhXpj6Vw?=
 =?us-ascii?Q?Y6eBKblAXH/By0mzixZTRQ77+cqnqnKfQBgGS4+QrYKHMeBv5o53Tf0bPEy2?=
 =?us-ascii?Q?lxvxC2ywSUCJp0Pq+jnJ61lD0JQMEqZdyabwAa1OxHE8dL0hIPZMum6DDARR?=
 =?us-ascii?Q?z+JW+ELl3/hi2niDBfm9Xd2yEvL7LeIWi3FcGzUPZ4aHMXUabSjqkiE8sAFU?=
 =?us-ascii?Q?hn84nipR96beKi3oCqJtOEyyTprn3yWOv9rT6sfvtG++FUqJpDlTFh3cOCou?=
 =?us-ascii?Q?KuGOFyou3PB9tXQ8MRlKk1KzJtAG3mSIxaHl8gK/CdYlsk0A3nZ6DpCtAJvu?=
 =?us-ascii?Q?rpV5Snoy1UguphcOVXYc1hXxXcL4Aqhtb07Xu7lTbKkSMM8Z+RNPnC+Ihbfk?=
 =?us-ascii?Q?HB71uJ915zgp3gA+uNY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507acfc3-77e8-49dd-a581-08da60608fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 21:35:06.9461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKjWHZigBX7yOv/y3vg1e710UGfiEuDlb6FrEkl697rSliUPQQzdhEYo6nWgLG9c9fWxbUoPBR3C9prqAKxOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0166
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

[Public]

Follow the dependency chain of either CONFIG_DMABUF_MOVE_NOTIFY or CONFIG_P=
CI_P2PDMA.

What happens if you enable CONFIG_DMABUF_MOVE_NOTIFY but its dependency CON=
FIG_DMA_SHARED_BUFFER is not enabled.

Therefore using "selects" is not the right way to go about it.

Regards,
Ramesh

-----Original Message-----
From: Limonciello, Mario <Mario.Limonciello@amd.com>=20
Sent: Thursday, July 7, 2022 3:34 PM
To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; amd-gfx@lists.freedesktop.o=
rg; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Select PCI_P2PDMA and DMABUF_MOVE_NOTIFY i=
nstead of depending

[Public]

> -----Original Message-----
> From: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Sent: Thursday, July 7, 2022 15:30
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-=20
> gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Select PCI_P2PDMA and=20
> DMABUF_MOVE_NOTIFY instead of depending
>=20
> [AMD Official Use Only - General]
>=20
> Using "depends" prevents shallow binding. Applying "select" can cause tro=
uble.

Can you give some more information?  What kind of trouble can be caused?

>=20
> Regards,
> Ramesh
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
> Mario Limonciello
> Sent: Thursday, July 7, 2022 3:12 PM
> To: amd-gfx@lists.freedesktop.org; Kuehling, Felix=20
> <Felix.Kuehling@amd.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH] drm/amdkfd: Select PCI_P2PDMA and DMABUF_MOVE_NOTIFY=20
> instead of depending
>=20
> [CAUTION: External Email]
>=20
> By having dependencies on PCI_P2PDMA and DMABUF_MOVE_NOTIFY the option=20
> HSA_AMD_P2P is not discoverable.  The kernel menu configuration hides=20
> it if the dependencies aren't satisfied, making it harder to find.
>=20
> Instead select these options when enabling HSA_AMD_P2P.  This way=20
> distributions and users can just enable HSA_AMD_P2P.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig
> b/drivers/gpu/drm/amd/amdkfd/Kconfig
> index 93bd4eda0d94..b153c26903ee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> @@ -28,7 +28,9 @@ config HSA_AMD_SVM
>=20
>  config HSA_AMD_P2P
>         bool "HSA kernel driver support for peer-to-peer for AMD GPU devi=
ces"
> -       depends on HSA_AMD && PCI_P2PDMA && DMABUF_MOVE_NOTIFY
> +       depends on HSA_AMD
> +       select PCI_P2PDMA
> +       select DMABUF_MOVE_NOTIFY
>         help
>           Enable peer-to-peer (P2P) communication between AMD GPUs over
>           the PCIe bus. This can improve performance of multi-GPU=20
> compute
> --
> 2.34.1
