Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11939C54E4A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 07:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A59BB112178;
	Fri,  8 Mar 2024 07:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JM2qcHTW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C558B112178
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 07:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9ln7i3F2Rg5Y7L8+lB+965ApKrllchdm1QOn/rC/Sr09zwi/Dr/T+/QNX04IX01KsfCMkGRQh0rvc+YyG6u+dN8fLe0J+TbCvZCdPZH5cA4wOEb07AgtdhX1ClzOIQ3zc3YMUOojYwAZ8eT7cDhiDHl6pRUqlcYbbOwclUbbZYHXGVPNTHQ7/gUmGxm/gTmf3CMA7Yboq4/GXoKPCuYrN8xJGcw1toSN1LM0UaW6n5Dl4VCOWXgOCApdbw5tAR0F39NWGDvh06275PhsvP5XAO5a40Qng9wXsUl4FrCyxLetNIbBXBA5KYFGtWoxBrOqtpiD2JVEqgam4FuNRnxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Anlu5GQDywEzN4S9qyYFWZZePOyuTL1SaI52/pL3oKo=;
 b=jYf5IaR87SXKZz9QAbJXNUijg0vEL4jm8ai11Vq+M+PNmIfVNKdt13jyAKhOXNA4UNcuJipcu0DJO0chsQvjyN5D5j+4hx4ifwuXEF/jbEbLAsWVg7P8ClGbHC6CfbC90EegguQbivCgqMQjwakV4iaC31+KU4AUG+hqWLT8GDBGRxBn6x9OLCO5sIR+EcjG/h2wQ/GuAQHPb52Ol712hSpTF6nICMtNkpNWFkOAr/UDG0SZqPVTearxf6dlrYm0OeoB3uglneNkWqSt5DeKYzKl9ww7qiqL+XriGZoVWCxf0bWpK4/8qMsIIWbZkRM0m7lNlPCXqnjy5/f1bHy6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Anlu5GQDywEzN4S9qyYFWZZePOyuTL1SaI52/pL3oKo=;
 b=JM2qcHTWeYDtAaFcQZvXWcR1kI8P7rHVSw0gu41dsblnmEW1icy09dT+AcHwRqBFw7H1eSNZWnuqRTOat1DCTCNifSd9vVKP1aGg1zScOnvrS5vTt5H5v6qRxjFvakyz6/cL9TstGhyqflfF9VSLhDbtp5WSkvgFOz5n/E90eYo=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 07:42:57 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19%5]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 07:42:57 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access
Thread-Topic: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access
Thread-Index: AQHacDoKLADP/nlH0UeXwhut0RqsU7ErmElQgAAyc4CAAauzkA==
Date: Fri, 8 Mar 2024 07:42:57 +0000
Message-ID: <CY5PR12MB63698B4543D5C36D3D7819D7C1272@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240307024854.2244635-1-Lang.Yu@amd.com>
 <CY5PR12MB6369E21D1B58474E7A179834C1202@CY5PR12MB6369.namprd12.prod.outlook.com>
 <MW6PR12MB889860BEDDA9C3705E4099D4FB202@MW6PR12MB8898.namprd12.prod.outlook.com>
In-Reply-To: <MW6PR12MB889860BEDDA9C3705E4099D4FB202@MW6PR12MB8898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bfac0283-37ce-491f-ae04-e3735286024d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-07T06:01:04Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SN7PR12MB7835:EE_
x-ms-office365-filtering-correlation-id: 303c63ee-12a8-46a6-e77c-08dc3f435f73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1vhsd8N/JwW0CzVZ91wB4KNOVyHAo7ODP5nmOwJ4LHW2KEoEShK7dGvuixXL+IwYbkq29tyoBIBnuNGxtTDCaKXWONWCgkjiivet45NbWDzHuj8vzr1tL2eJ8MYTiCG1L+GG8BgfW4VyFhWntZ1ixqrMVFB5UqkBbDcJRK4JPpNaR6Z0aZyQFWynhEhYXgJWY3MhKuyMveb3DE67JN+KyzcZoI4v3cJJBOCYLLRvij/gNPRtPzVr5bcftwxcR8C59Fio+CtJ5fSTWZGRPhj8jyUh+5WqGZy0z9yo9aL7Pk+4hHax3lNzUtrTXuxQM2Dfv3cYSMbloSBuzkD01qPMKwPIMEneou2eSCuXJ3h8IQUTKHDgonKTuIWBNsS2eCoFUy8WJuO/sqfe5t9nNo0kK4tH6cs5bVR7q65gthvDxA1fQITve6F7PTcSsgsKVwK6cCIfrkQme7BslXwpYt1Isb6UQXTUom8A3xCVsM9kGIuTdAh4+brPlo0ef3hvV58FDAhctpz1545ekGJq0ZX8BYR1iNGlJ50g9079pDmb4CAaH60F+KW0njVExZ8+XhlbcKaCFqKdHl5EQVpj8Olo5KCeggaiuaP1xd06GBjbn8SpiiG3ZWZz8ijSSjdVD930lt9InoCh3TsArca0tJQwEgDynqeyrzbMV4osNuBPC9DlBQLF2EKX9ZpaBt2uRVUyZZYCzKNB9l1C5JXVum/afCuJN8Nw8K21WMbbe5rSl78=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P9cOSR8wsd1IerP5HPCAcfH2htkR6ozOY5DEp5DLLP+DxyIKavi1rQvGg0xd?=
 =?us-ascii?Q?f/djH5wDpVM+5jIrZVESwivfXQrZFfRE07Y/Y67V7BAj5/HD3rZURos6HjzS?=
 =?us-ascii?Q?x/OMH/9d/V6KW79yA2vxtOxb/a/T9Ru5/Yp7bSyWqF+9gu52z5ypx3VYL/M+?=
 =?us-ascii?Q?B8KEt8gzAxGf10whEs6c2um/2C2Nl647ggIxAT831IBP2v7pqYj6c2QkkejM?=
 =?us-ascii?Q?3MaFpo1iQFn5nwbbosxF4It/iDyiJ+/tw4KTePXLs2yn1cvJFtdi8+coLOMA?=
 =?us-ascii?Q?fxaryaEkV+3oHVnv2+g10i8DhWo5ybmGeCEW5T9ty11z3xJP/OHYNODI3Zrj?=
 =?us-ascii?Q?WiZxp7LoGFb5RgZss2JhUWcE3n5GN9dkyfigNmbyzlxlDtJsXQP+y7Q4wIVg?=
 =?us-ascii?Q?uNPVVz40Gr6EVfJby2i88xYerCQA2HtEbyK/ginjneMvVLY34LqKiHV/aTsF?=
 =?us-ascii?Q?Wih6lfpTdffn6uCnVf22GdII5uExyU7H88UpqwHuiaFOggV5t21pNKSVOB8p?=
 =?us-ascii?Q?qKXYtIxbCxy1WtgJPL3XGNvlk8eq3fWwlezIQc1DSlr/koUxApWPDeK+hIZJ?=
 =?us-ascii?Q?eBvqOBsbHDdcGAJpRgxnww3RFh9jiswwDFKqtaNaii07dG/ia6tHhZel+UeB?=
 =?us-ascii?Q?XV+f1k8CrBa2xUcZwcYqRA1ICN9qgqq8bg1tx2f21gRYuQhPguQ6fkwH7469?=
 =?us-ascii?Q?hU0K27oc4Sf2nOjXcEyPdQM/RC/lhNuKBrALU35fWvevKXDmDNVGHcbIvB4H?=
 =?us-ascii?Q?DroaAjcmLQG/dfhBz1hVbLzgsCV7rL83lC1jRqYq/QwrIGOntvXjMJZz6SAR?=
 =?us-ascii?Q?E/Ip+Nv1V0veKFRJeNHNFuIykWlZzSu+aQ/fCtFjpfI+PDOyrdQ8KywSdhE9?=
 =?us-ascii?Q?GoPbS2ZlKXpUEj8dwvDJuRTNJzeb8AODBqCYhaeACTPymOIduU2y6DqeEeEc?=
 =?us-ascii?Q?TQLRWCyA1kEoQsq80RxpWZXjcVS64mXZF3l1LAmBwv0FFWjsylPHKccIhz0n?=
 =?us-ascii?Q?UDhVUUUwc7vdbYKLv+IQ6P7tujAvjktCK7xH3mNEJlZNu4m7MO6vXnGdPGGl?=
 =?us-ascii?Q?pat9eJ9R09+vWnz17GqDOZJlCJpj5QIhyVnTKfhpmIoXelXqUoP/knsN4mOZ?=
 =?us-ascii?Q?0Shgqcya22BJ9agj5K6hEMz89Tu2lcglnnzhWZYrrsdB7mKrD/CHvF28eG+u?=
 =?us-ascii?Q?q/ojkTvoiq2VxnPYvWntiOwonpQqRFx2ZJpxOf4XuBDCTbL+SzBSUIu61Xxi?=
 =?us-ascii?Q?8GB/o+udn9EOhwR5546Q5mHF6WXEgb7+a7lD/41qDfzI3cCi4eI33NQ+5xR4?=
 =?us-ascii?Q?es7SBuWHjvMQCDX8I91+Plfi2e1rbL69J6SILM3n5QUW5cJemMQUmO6HEz8L?=
 =?us-ascii?Q?/YhHGT7hpirLxhvubWnN/6eyeIUb+El7jjTF7k0EsbRkmJnDhLQEJUUlj2A8?=
 =?us-ascii?Q?aX00VHZSCX7L3l5J0+JJtVoVTQxnpdZuYm12DOpQFY5bN5Mufg2m+ew+Lz8z?=
 =?us-ascii?Q?GFU8sF43rG4gLOnLG5JwzG8jo+NTcJb4OlsgHMTWXaxckqUDLfT//EubBDZG?=
 =?us-ascii?Q?pw8JtX4xCy3JsBWTgrA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303c63ee-12a8-46a6-e77c-08dc3f435f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:42:57.5997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cCDVDwqp5P1nZYy5MeTNofjbfPHDGg0iNr2WY2VlR48kMDnY1FTpYZ0HXdBLeyI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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

Yes,  this is a trade-off b/w readability and code size. it is a nit-pick. =
Feel free to add:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Thursday, March 7, 2024 2:06 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access

[Public]

>-----Original Message-----
>From: Zhang, Yifan <Yifan1.Zhang@amd.com>
>Sent: Thursday, March 7, 2024 11:11 AM
>To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>Subject: RE: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds
>access
>
>[AMD Official Use Only - General]
>
>Can we just add cid 0x140 "UMSCH" to mmhub_client_ids_v3_3 structure ?

Yes, we can. Then mmhub_client_ids_v3_3's capacity will change from 31 to 3=
20 and most of the space are unused.

Regards,
Lang

>-----Original Message-----
>From: Yu, Lang <Lang.Yu@amd.com>
>Sent: Thursday, March 7, 2024 10:49 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
><Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
>Subject: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access
>
>Fixes: aba2be41470a ("drm/amdgpu: add mmhub 3.3.0 support")
>
>Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
>b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
>index b3961968c10c..238ea40c2450 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
>+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
>@@ -99,16 +99,15 @@
>mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
>        switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
>        case IP_VERSION(3, 3, 0):
>        case IP_VERSION(3, 3, 1):
>-               mmhub_cid =3D mmhub_client_ids_v3_3[cid][rw];
>+               mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_v3_3) ?
>+                           mmhub_client_ids_v3_3[cid][rw] :
>+                           cid =3D=3D 0x140 ? "UMSCH" : NULL;
>                break;
>        default:
>                mmhub_cid =3D NULL;
>                break;
>        }
>
>-       if (!mmhub_cid && cid =3D=3D 0x140)
>-               mmhub_cid =3D "UMSCH";
>-
>        dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>                mmhub_cid ? mmhub_cid : "unknown", cid);
>        dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>--
>2.25.1
>


