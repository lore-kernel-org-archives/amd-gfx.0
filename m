Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AECAD340A1
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 16:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4CAC10E599;
	Tue, 27 Jan 2026 16:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uVDrdsz8";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF3110E5B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 16:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/W1KJRvFMj1ZzdE9uidY8y1HWSg1KS2iB3GxKOoUgo0zs6FgUHdpBaSTR8yuL56LiJmHSn041dejEhSlDICy+o4MQrnDr3lk9NRsYEgBUL4XUYD3zJZuic5b02RW+VZiQdZk6CGUGBG/0futFJ81WQ4waMNYRs8jztudoHZWyWwxWPmkVfYeltsC0hMd9TyhiakxSjVhc+Iq2KRogQhplu+P+HpTQGuKCVWVPdSqf/6jOJBpA0FKboArheqJVfzIO3oInJDY7iNH+Ix9RDnP7XywXMWuCZ4xaPpYOQjcyVBL9hHQuHpR0/dA397CZrvuD5eq19QYljnAeR7T51zEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khJc5iHONQayHqjZijCoJ50dKar/sIljISX1wQU7D9I=;
 b=K0Ltx5v46d3Od2eoyYKS1Sau+kwhpU7bFkc4Mrys/a9JUeGebsuH9GmOEHRvQIU4ZlvUf5UHaDI9tAXvLQfOcoqpBxSho3MVycizNThmoejE7RR+0vs8QexuF+P+cB2oj7ioerU5k0mvIaS6qrnWn3+v3oGThmITCOP+uZta/fXjZiEXjCFQQpKsFMrsJeVfVOQFARZZOgGRygP6b6vqGwYj/GdOlSFbDK7fN5mvKrY8IZGOOss6rY2vH9cRDzQd1RfsH0XPNCtK2dQ1UO5N7vgvtgn+SV1FDyC1FMNiPU6TShLvspbdPhnb8zqn+wCrNn2Hublc2xzkzcKjeiLrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khJc5iHONQayHqjZijCoJ50dKar/sIljISX1wQU7D9I=;
 b=uVDrdsz8PTLaDs5b7y9rFxa6Qvi7XPZUF7jAc1sTjvNQ0U8msyGfrT0m6i1JFDUNID6YIgB0t616v6lT4rbE3COKmryMnhb3JljdXtf8Kyi0P2Jw1+3pnS1d4naS5GRpVAAJPVTqVA8duozhpJ4gZcInL3QPjNrWx+3aFliL74s=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 16:26:14 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 16:26:14 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Belanger, David" <David.Belanger@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: Add a helper macro to align mqd size
Thread-Topic: [PATCH 1/4] drm/amdgpu: Add a helper macro to align mqd size
Thread-Index: AQHcjq4lOdk2zi/tgkC03mMYlxfgVrVmNA+Q
Date: Tue, 27 Jan 2026 16:26:13 +0000
Message-ID: <BL3PR12MB642522950BEB4F9936929AAAEE90A@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20260126102514.273891-1-lang.yu@amd.com>
In-Reply-To: <20260126102514.273891-1-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-27T16:19:28.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|PH8PR12MB7254:EE_
x-ms-office365-filtering-correlation-id: e4b66281-7b25-4666-38a7-08de5dc0ca31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7T9UrjZ/IorKuMBugb7NYEF1RggPPG1zomItnSx6GJcd02tAvHUykAYM+sF2?=
 =?us-ascii?Q?NH/26RlRdlh/TVZx8PbECUfKhkHojd2jSlvjoPMx/GM9NrWBoL/1nMYBR7bF?=
 =?us-ascii?Q?SVpJCEwshka4DEPjLZmygO0VA20Vpe6sMad5y6bqC76rB/F+q8N4X9MQf0pp?=
 =?us-ascii?Q?fKCTvcJ23p/G4BSbwqgLLLc8Qvx4HpthkUrBDeaKO7nQ1iVDnuy2UA//kN63?=
 =?us-ascii?Q?/pCUeYULeL5Q/QYiVdWf2ENqTqotuJls+0W46EaHyBWKFTBcbxuQBBohW+W5?=
 =?us-ascii?Q?GM8DNcjsG4C89pUuk4qon36t+rKD/91zSyg2gMgpXwFXR19T58GSJwq/wnyx?=
 =?us-ascii?Q?F24Q6doKwZrvkc7L7guBmu1ZkUi770ve7Vba3t15baiMzfq76uQGg5TTVPZk?=
 =?us-ascii?Q?m9y+mlAm7UoUHvzLZp231ayVyCclXSOT4c8VJowAgfgld3HZKfwV8C6sftix?=
 =?us-ascii?Q?IeTajNDBALXtTLQhFYMovbp9bKL4ut/kCmIwqB77Ltd1Pfh7TkEb5i97t4TP?=
 =?us-ascii?Q?T56hsV7UvQaBavzKsmMr9ozCgltshgw5j5uBgFf9WMlkubaDWmY8R0nw9tQo?=
 =?us-ascii?Q?I1bS83GtZB8J55fctBJc8uaAv6o2pRpQn13TXtQqk3oqjQZDXiw2eh6WSJe5?=
 =?us-ascii?Q?df5hCsCCbx4ApY19qM1vvQHFJfv2Q7aBhIe5PvIf4C8kciXVpZGWQp+bit6Z?=
 =?us-ascii?Q?C8jnxRkzoISPLcxpDiMLtahPgsvf6rOBMTkKzOyRhRAbNwSMDAaNLyEioanA?=
 =?us-ascii?Q?SvfIWQnsrvguINQq8RqH1cGsQ2nUtRyO3ttuf2y7bci9dOabT7jGrevb6ztp?=
 =?us-ascii?Q?Qqjg4h+D5P/b7HINGhAiZ27pG8Vr1GB0my8BJDohAx5uALSoo0ojSZYXqNcn?=
 =?us-ascii?Q?cYk49wVfSNm5Io5AoCLhhyAndIBLpGbQFwZx8hFRpsUSkrRfKyUeA8sX2Mn3?=
 =?us-ascii?Q?XkpmhVZKRHmSSIxVr1IZ7cnJ2mLBEN2II4omI9O6GE3hx4FCVcC9tLJuW1lG?=
 =?us-ascii?Q?zOH5owFfJskysLA7DdIWRi9UZZDEPKJq4fmrMwICF7IgDeKFq7ZyRrqJYMIN?=
 =?us-ascii?Q?keKogh6G+y+ttqOsFN0P9WvvSgV32+5pzMAm9IpjweewLrJZUjXmTKG0S0V7?=
 =?us-ascii?Q?U7zaXAlPXsZXlZ1ltGUCyeiOtoELdsg/CSNT2nJVuINTXDwrCvEROWD5ZuSf?=
 =?us-ascii?Q?yKglfHl7/8dSHQSeWB45OUcXYeAT3DDkLDdxC7ggN0Bs80u5gE1FUDlGZGBi?=
 =?us-ascii?Q?rNnrI/s2xbWe444VjQcdoJDHWHv+Fu90SHiRgVNVF+m8QVr9+M/CELcJ6bwM?=
 =?us-ascii?Q?iAG+Q2icQFfqzj/7mbG3E81PheIYP3op8WGxzb5izvfjoNBapZ3u2cbOrelp?=
 =?us-ascii?Q?CUTBJYpRPgIEz44hd9SnCDmz5mJXVhF1BcPxAK+GO0unzsm8gM8qz3INRynV?=
 =?us-ascii?Q?4m8SO5dCrtNLWRNLgQveohUtvHakedXqY5K3WtozzrbHUxbuw72aFlkY+hCg?=
 =?us-ascii?Q?bgpxOgF+268ZpaHRxiylPzuo+/MpdLYvfiusSnGcz6EsBkfq+DU9iPxh5Xh9?=
 =?us-ascii?Q?qp21Wm4T63cQFxnvGdEcdHr/5FC2OctrO+JYs9uF1yUj3ocNkJ8GwdmmmX4z?=
 =?us-ascii?Q?WXm+QkmCBPNtRiMiKvqgBsw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oxqMdidy1cdsnKLT6IoKMVDbkjLm/ezyC2+em/r8sbdW0kHGH+aOsiZR/Jxh?=
 =?us-ascii?Q?ntZUUxPtAy0MFlmFCeg8IZFvVYw5y/Ls4oNV1BO3kmvLJ08K6TwP4z45R3XR?=
 =?us-ascii?Q?YcpaF2wyFznmkCAxsTCzWaWspexMGUzdmw9cxVuf/CtggK+57VqfrV4017CV?=
 =?us-ascii?Q?sd91ju0TlDZYrjZF00YS8fZQHLdwmeuCApWD/eqVpjgyhEPQpeYPWafM08LK?=
 =?us-ascii?Q?39UE798Gt+TJLuE8L9WnMSHl5PaZKmxTgtJvSzKcuDR6uxisarXvzmavuNiI?=
 =?us-ascii?Q?Z0QKtGzv6Rm5GyBmArvOg8Tb3M6DIrjqncypfD8kZkHP29j0FymhQCNnOJgs?=
 =?us-ascii?Q?kh5mZyJXa63Oh4w3GJiZDObFOJD+/jcpwc3stgNXercZLeR+Wn8VEY3/qSQW?=
 =?us-ascii?Q?BkgVRR1ScEkMUOyj3OQtnF4VG8LBxeppmda/vRoV9XXFL4ADlJXXIFzGtYsq?=
 =?us-ascii?Q?6EV8aAO4gOGE5mJ1b43nmrd3ZWDCzHIqqbU53jMqHFpOUyZtQEgLCdRf9D19?=
 =?us-ascii?Q?aD/qulYLij5Xk3XF+zQQWTLnMfpB5lKzgXN/dChUy9Py3RlbWeclP2tN5hCm?=
 =?us-ascii?Q?cZjdxGx2eErwyuCwDhgABhGkoV2OgUKXxwme7yIFY/UE8aNP7aB5AtTNyT9M?=
 =?us-ascii?Q?2pLFxNYfBQmVMYxq6PZFj/W0OQKZP7YNq8B1IuFEVPiLQmWm62dwqGZIkTZT?=
 =?us-ascii?Q?yMzoOakpxOnjMHPLqo7jpAXOLOaiFENItqCi3RgNla+r0Hhu+7L12MtrIomD?=
 =?us-ascii?Q?Fwjw00WJ+6kYm+N2NBTmQRnSJleXjXZ+McjiOiCSzfTDrmWOU7e6FJMsQ3K2?=
 =?us-ascii?Q?LYP8qSmWxDeIGgbU4q3S/cKxX9iFQgopHAb/2CG+47enNLA6NUFZgm/M8kiy?=
 =?us-ascii?Q?VEgB+doGo/g+M7O4ECMcMinL+p81Xmt5D7PEudCEXoFTiylIpo4uZ9Z1BUHk?=
 =?us-ascii?Q?/rmGb/QgGaAG/1kRMLpMIL4Ls290Qii7C9uh/NUC3exrC6CtDzyUa+yMH+AT?=
 =?us-ascii?Q?pnbRyOMJTUYCNcK+WywtCLsnObtBIzWEUbXICH0FBwxiBSwrfcXBiFbw+IWy?=
 =?us-ascii?Q?PNoEJbuIN+LnTw0l+WphggdDb0OdT1almAlMe8VXO47g8UP+A0x4BDnMBVf2?=
 =?us-ascii?Q?08pkogknnhzZvlcA3PnyBuNPcgWW6/ujovwf26TSERjkoEpIHrI336Udoezi?=
 =?us-ascii?Q?CUrxq7Y/GXnB98rJnEKF39gcqFMgLg83luzp7T988SVQY91bqrHGNXZE3qZl?=
 =?us-ascii?Q?+7cXhbZ0kbrQcpMwqyMQX4i/o/yaxdUxs4xwIOdcOk4OdINPUaaR5J0f59Qm?=
 =?us-ascii?Q?TP1N3MEsdcgwwTg9xVVkPxZDJ5QvWJipeI3DGxn+DyfqGhkuFvmRC4FGiaBV?=
 =?us-ascii?Q?dFPWebhQ0WYUjiMJ9W/emi97o6g7Zc72wQRd94dGVqwqZnbOgeR7NV3JjPwf?=
 =?us-ascii?Q?H88yzBqi1xblN5/TejsI+rLioeiI4GnF7FKiVUoBXIIvq6hmsZmmrJlXhp8N?=
 =?us-ascii?Q?liCiG9ac4slG7DKuD7bDPbJzAvxX4MnKfPI6UblR4Lf/ng0IFanP3q0/63CL?=
 =?us-ascii?Q?vvIEyO7nnJpCwxlRe9EpkooM/Tl1hSvAj3k+YbGYKwy314aeHRFqJW3jxkvO?=
 =?us-ascii?Q?xirxEVIEWwxgtrN2EUPhj7VMuiEq8wJnYw3NKWgZ/SmKKbxQZnZedSKgmSnP?=
 =?us-ascii?Q?JFu0xQYi4HDSIS8QAQO7PHgXDjAAGJI58RsEknURwd40gGDR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b66281-7b25-4666-38a7-08de5dc0ca31
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 16:26:13.8913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAQRgTr+2jludh5dtze/Fp+ffRjOj7IkrJn5G5AYv9DlGgtyCfVhHM0cgwVgIJ7uuqNsTOj9Uh6WbQLW0DmPCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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

> -----Original Message-----
> From: Yu, Lang <Lang.Yu@amd.com>
> Sent: Monday, January 26, 2026 5:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>;
> Belanger, David <David.Belanger@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> Subject: [PATCH 1/4] drm/amdgpu: Add a helper macro to align mqd size
>
> MES FW uses addr(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t)) as
> fence address and writes a 32 bit fence value to this address.
>
> Driver needs to allocate some extra memory(at least 4 DWs) in addition to
> sizeof(struct mqd) as mqd memory.
>
> For gfx11/12, sizeof(struct mqd) < PAGE_SIZE, allocate mqd memory with
> PAGE_SIZE aligned works. For gfx12.1, sizeof(struct mqd) =3D=3D PAGE_SIZE=
, it
> doesn't work.
>
> KFD mqd manager hardcodes mqd size to PAGE_SIZE/MQD_SIZE.
>
> Let's use AMDGPU_MQD_SIZE_ALIGN to avoid hardcoding in differnet place
> and across different IP version. It is used in two place.
> 1. mqd memory alloction
> 2. mqd stride initialization
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9c11535c44c6..41f32ed39113 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1239,6 +1239,11 @@ struct amdgpu_device {
>       struct amdgpu_kfd_dev           kfd;
>  };
>
> +/*
> + * MES will use memory beyond struct MQD size, 5 DWs currently  */
> +#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) ALIGN(((mqd_size) + 20),
> +PAGE_SIZE)

Should we be using GPU Page size instead of CPU page size here?
Maybe this should be AMDGPU_GPU_PAGE_SIZE instead of PAGE_SIZE or you can u=
se
AMDGPU_GPU_PAGE_ALIGN macro instead of ALIGN here.

Regards,
Mukul
> +
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v,
>                                        uint8_t ip, uint8_t inst)
>  {
> --
> 2.34.1

