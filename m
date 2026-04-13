Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D1FE937E0
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 01:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAFF210E2E8;
	Mon, 13 Apr 2026 01:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oKVUDRWK";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9115010E2E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 01:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1pjEH8NWLXh5dQoxC4My60bEAjNZqYiuuiJRx29XPVV7/K01bSGiVc3lYt+lgcGK+cR2nimXiXlup9DncneGWNIaBoja0pyFEUOMrDXm1PPp76omNmqCMUYnQT6QUb1NpnxQSoS9O9yIIFd+tSiuak9qJANaO524kQWSYtQaiMXDu22zJDltmL8ywvlZ0C7lyfEVaSxi4IT5xc/c5Zgr5cTIM8e5PYyzTZIc2way88mzAd+61iXJWaOLSXZ/CEOmZ6J+aj0jAqt07VDZYxGA0Ra7EXeAXomMgjb5GxLglnDVp50wfZXz0nCSBr9TULuRolWy3KzBwevsJxIzDA+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KCVZ73u3kXgNtvidq0EM9C6b3juEiNZ0bgzTMCAT4I=;
 b=iCTAGh1OYH9T5V2AQxVe4wB96a4tWTKr7f7EDmOVG9Pn+3wK4talicsxWRM9gaKb0B6kTj42MZyk3t1Q2rGncgUk0FCOoahZJ8i8INNh8C4er1ZkU+/RACm8sxOIWEYmeyaGPVBXtc4TPXMPX1sYfOYY2tt6eRnjQz0QsrQBYTMmLuqpuphKvmFa8rpJaOLeZERx6rK2yrVVT2SLahcaojQPJUo1k3OPbUm9bMD0tnHDSvhdU6QiOIyfofaAsYzBlLx9ftFa6A22dVkXNiDzHyvcQgpkr/u90A3iXhWNgt1GaZJONG7l5EOhjdzWgogZUIx4EyoW1ob8EL+cEcweMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KCVZ73u3kXgNtvidq0EM9C6b3juEiNZ0bgzTMCAT4I=;
 b=oKVUDRWKTEN0vDQeuf7kA9Xav4+oXyqSahCmf3IVWv9fl1v7RiYcaahz0YyJPM8dTAZysyfssD6RVXdH/aQQaIBT5w3fWtQHk+dm/O8cB5RLvi8XlTWJoUWpjng2VaRus9OKWU7x0AuOuuiXSGxir0j6ayhk8YNJLh6R3kb6Svo=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 01:26:05 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac%5]) with mapi id 15.20.9769.044; Mon, 13 Apr 2026
 01:26:05 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix CPER ring header parsing
Thread-Topic: [PATCH] drm/amdgpu: fix CPER ring header parsing
Thread-Index: AQHcyAK/ywgAONhk80urtRZ+Qhub9bXYMdgAgAQGsaY=
Date: Mon, 13 Apr 2026 01:26:04 +0000
Message-ID: <CY5PR12MB63459C79C2B09B4D539B124DFA242@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20260409092403.572319-1-xiang.liu@amd.com>
 <PH7PR12MB8796C34213C5C06CA8B055BBB0592@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796C34213C5C06CA8B055BBB0592@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-13T01:26:04.275Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|PH7PR12MB6468:EE_
x-ms-office365-filtering-correlation-id: 4d5aae16-6091-42ed-73cb-08de98fba1ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: BaVfpw8CkB3TqklaHKhTmcMM9UIROlD3pWJAptPK3eBllqW9f9GV0Pzsw5ziFB1f1EQQ4VU8CnflAUkzv+kKK4iRgOSno5D5kmb+WfAEBTc0ytyI7/M5IKmppA4yVuGxGIpJpgbu1brdHsVdkGDhGoT6htNyzaiuf0PiNr5gd0OMr+NHTtVM83RdDD6xzIzbK0kwLxNY4pfcFQWo4H8Knbx8R0tf/IIiXnqsqGizDQzpdD57d9Pf4nWtzupFch/Zobr74rSnCWzAJkuvoYq/bgjPwhorxoBDstUAjGtWMiFWg9i46iAB01qC7G4Der5nNa7NL6Kj5aeVSjBf9yHzQ4uMep1dTkgQDD6P2qngkcFXoTp2rbwU0pUu1VsD9RihmTY5uDsX6gHBKvU3fcO1bhCIEnx6Y4V6kqdZU8iaTFemNrVETx4iAQsCGyDeCTxCKcOI+/cZ046GiRlJPXjTNRvbfabXsmL5pfmcq+A57e3V8KjUvpV+TEwSrFYpmz82ocCGgKPtVhr1BJx9u0f4RcM3qHEBqx0pGuGAesr5YFCn/TyCLYcWCTirsxmYEl+SR2VFZUTOmtOm9uxEPX5wda0c0lgQjzRhwOttv/Tqlk45uHmmdgknedWFPUz54wjLzfeYtIZPWh0v8qXw80nbNxg2kbBgl19ZKggfrw5OgPJomgbDpk1ltETW4ZvMkpBo4OWkCdY00/6MGXj5pqk543mIpoVMVpvYMf9ihXnFVP9d9jPCUmVdxWOe36xTGk6YXuUkxsIcqgUAQU2PiGz7rk3FJhD99R9p++Q1TgMMltA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T3A5+MRQnW6IltXdzpvxTaNNC3HX41/8p30aQJMeh6YwXAV2oLsrP0r4R4OQ?=
 =?us-ascii?Q?TGYvmxCDjIbKtgK5OUdVv12RbzlqFCROdfM1VlPKF6Ng+WWQFcXhU1BdOfyZ?=
 =?us-ascii?Q?ba4fBr2ZfPCBczRU+3rYggz3qL5VyBB1ohamWVW97IbQsbVVSTBxvyj8aHP5?=
 =?us-ascii?Q?3vH0EzF3H23KAIr7WeRjNxKAXOqU088arkQXpOt+AKHiKvG/znG1+2PaU4z1?=
 =?us-ascii?Q?fRUtZ2Kh2x2fq3x2pG8M2+jvl4XPb7OjAKRT/r8wxAYu/VcDJI0bLQkqCtMy?=
 =?us-ascii?Q?iAUjeeTvu36dcnSZ98XJrSxIrEKat39F/JEDbOECbC/bT9ZdewE+soqrtiVY?=
 =?us-ascii?Q?+WpCklGKVMU5R7jcG4R49RyqO7Fia7hLdwMZPgbnBDJ81IhfNzsA4r4K4Qox?=
 =?us-ascii?Q?tj+hCZ48jWa+8aQClLUGt2SYfApZgfCHZicgZ2T4m/XqQGJib7rm8qDZH57V?=
 =?us-ascii?Q?KuWI3nSgCJJvj1w5JiWqou/nOxpe2UpKsD//ztLrL3sNN8dg7cdFBUVxgX55?=
 =?us-ascii?Q?qAy3xj/5gljmOJLlkbL7CrO1QyKoSwTSlevfX90dLeGpCcEwGNRHsmiGZI4T?=
 =?us-ascii?Q?Jf4H5ia6DTb04XZsOovTSf00XDnTzkTuYx+RtVlbh8ny9paBAqu3HvRvW5Om?=
 =?us-ascii?Q?HxXXiGn32OVvc5gl0D+eHabmzdYDINWHf1ARxM30rDpAF2/VicXmHIgQVPFG?=
 =?us-ascii?Q?CWn82me/9GaxuxGUr65Qbth0xsisqkINrl4t9VgdHSR9hgMI5uc92P3vRsTZ?=
 =?us-ascii?Q?AQ7q6YehEi5WMDtl5fKiM2Z2pXAZbURw8Z1IG32KvwY3Y0bU85/bC3h13dpN?=
 =?us-ascii?Q?w/nQqgxOghlZ2sJg1buooMiqe/x92dpI2CSNNUipr59e3sC5fqlmmkotBS+/?=
 =?us-ascii?Q?QtQTa0X9hqtFlr4oriGNkpcBhAUNYyWQCXRaZmR9NiuJTzzZyZp7kb68dA4a?=
 =?us-ascii?Q?AObFwVDAhsdcI/6EtkUxg75/4r3UdOF4mbycePDSv9c0JXsYZpbludPUyGK9?=
 =?us-ascii?Q?0+ngZsC5nDkDjPX1yTB4Jqfut8TcDewlXQvjhzGp4Ae1mWLioc4OSIxvYeUD?=
 =?us-ascii?Q?E7x53DvgCdPH88V8dLdiUQcr9NTALJ8HrLFzwSlbI65Q+hxBuudutDVd4nxH?=
 =?us-ascii?Q?yOcsdQpdeUug3waGdmSGgy/ToUCKa1b+ws6kTc67QdKM+16YzrVRFob6zC8v?=
 =?us-ascii?Q?VxoxVG5bXlaKbfZBSKHV9AtOJmzUWnM9OVuIr3tnsP9SVFZjTAHp1RE0FtEd?=
 =?us-ascii?Q?gofskDgkyOMLivR5u/8bnV6kTQFlvS6OMk9dYMG++HLW8EriTIxDH4hNZXJn?=
 =?us-ascii?Q?po1cStfALUunmt6gmUVOXdk8A/CqhWQ5jDpQO/5StILE/gPKiiR2rh/raYN9?=
 =?us-ascii?Q?NzqQoBTaPEM2UEHjMbPGBqfsouhqTXi36uz9UVzegqC0xh1m6xFheEqw72c4?=
 =?us-ascii?Q?dfw6ebtHTOSwJo1SXpRVA78ylpM9Upt/8fDTC7TYSGwmUbVc+a15Cxo+QSVF?=
 =?us-ascii?Q?aomwrigrNHKa5cpQ0ChxxvYxCMzyJWH3nMp3z1MKowJciy29MfD/D4suQ1/1?=
 =?us-ascii?Q?NxTQcAH+cryNZXDVFTjwrm8JFGKbEouPNuVla4fKD4tH8IRgnQcwGVqFiafs?=
 =?us-ascii?Q?2DGlDEqvt/pnvMQVZqX3pmcNZTStwsinqy7bgiNAYy9gMFDmRBtjBETI9kVN?=
 =?us-ascii?Q?uFcBCGVp7gkr/c2gb6xM0QdZPzs1MmefymZWc1Yy4cdelTd5?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB63459C79C2B09B4D539B124DFA242CY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5aae16-6091-42ed-73cb-08de98fba1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 01:26:04.9387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0C0OMJXpYgdSa04/Iej7yu/OxjI0mrJL5tyAbSzhthaU2XR1DatJVMlJEw5BcXifoifZjo8IKHGy3ij36uktYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

--_000_CY5PR12MB63459C79C2B09B4D539B124DFA242CY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks, will improve this.

Best Regards,

Liu, Xiang

________________________________
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, April 10, 2026 7:55 PM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix CPER ring header parsing

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Thursday, April 9, 2026 5:24 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: fix CPER ring header parsing
>
> amdgpu_cper_ring_get_ent_sz() parses CPER headers directly from the
> circular ring buffer to determine the current entry size. When the ring i=
s full
> and the write pointer lands near the end of the buffer, the header can wr=
ap
> across the ring boundary.
>
> The existing code treats the 4-byte CPER signature as a C string and uses
> strcmp() on in-ring binary data, then reads record_length through a direc=
t
> struct pointer cast. Both assumptions are unsafe for wrapped entries and =
can
> read past the end of the ring mapping.
>
> Fix the parser by comparing the signature as raw bytes and by copying the
> header into a local buffer before reading record_length, handling wraparo=
und
> explicitly in both cases. This avoids out-of-bounds reads in
> amdgpu_cper_ring_get_ent_sz() when the CPER ring is full or the current
> entry starts at the tail of the ring.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 34 +++++++++++++++++-----
> --
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> index 35fed4a05e1c..54ee4f7e7a0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -426,23 +426,40 @@ int amdgpu_cper_generate_ce_records(struct
> amdgpu_device *adev,
>
>  static bool amdgpu_cper_is_hdr(struct amdgpu_ring *ring, u64 pos)  {
> -     struct cper_hdr *chdr;
> +     char signature[sizeof(((struct cper_hdr *)0)->signature)];

[Tao] I prefer to define CPER_SIGNATURE_SZ macro for sizeof(signature), wit=
h this fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

>
> -     chdr =3D (struct cper_hdr *)&(ring->ring[pos]);
> -     return strcmp(chdr->signature, "CPER") ? false : true;
> +     if ((pos << 2) >=3D ring->ring_size)
> +             return false;
> +
> +     if ((pos << 2) + sizeof(signature) <=3D ring->ring_size) {
> +             memcpy(signature, &ring->ring[pos], sizeof(signature));
> +     } else {
> +             u32 chunk =3D ring->ring_size - (pos << 2);
> +
> +             memcpy(signature, &ring->ring[pos], chunk);
> +             memcpy(signature + chunk, ring->ring, sizeof(signature) -
> chunk);
> +     }
> +
> +     return !memcmp(signature, "CPER", sizeof(signature));
>  }
>
>  static u32 amdgpu_cper_ring_get_ent_sz(struct amdgpu_ring *ring, u64 pos=
)
> {
> -     struct cper_hdr *chdr;
> +     struct cper_hdr chdr;
>       u64 p;
>       u32 chunk, rec_len =3D 0;
>
> -     chdr =3D (struct cper_hdr *)&(ring->ring[pos]);
>       chunk =3D ring->ring_size - (pos << 2);
>
> -     if (!strcmp(chdr->signature, "CPER")) {
> -             rec_len =3D chdr->record_length;
> +     if (amdgpu_cper_is_hdr(ring, pos)) {
> +             if (chunk >=3D sizeof(chdr)) {
> +                     memcpy(&chdr, &ring->ring[pos], sizeof(chdr));
> +             } else {
> +                     memcpy(&chdr, &ring->ring[pos], chunk);
> +                     memcpy((u8 *)&chdr + chunk, ring->ring, sizeof(chdr=
)
> - chunk);
> +             }
> +
> +             rec_len =3D chdr.record_length;
>               goto calc;
>       }
>
> @@ -451,8 +468,7 @@ static u32 amdgpu_cper_ring_get_ent_sz(struct
> amdgpu_ring *ring, u64 pos)
>               goto calc;
>
>       for (p =3D pos + 1; p <=3D ring->buf_mask; p++) {
> -             chdr =3D (struct cper_hdr *)&(ring->ring[p]);
> -             if (!strcmp(chdr->signature, "CPER")) {
> +             if (amdgpu_cper_is_hdr(ring, p)) {
>                       rec_len =3D (p - pos) << 2;
>                       goto calc;
>               }
> --
> 2.34.1


--_000_CY5PR12MB63459C79C2B09B4D539B124DFA242CY5PR12MB6345namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Thanks, will improve this.</div>
<p class=3D"elementToProof" style=3D"direction: ltr; text-align: left; text=
-indent: 0px; background-color: white; margin-top: 0px; margin-bottom: 0px;=
">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: black;">Best Regards,</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: white; margin-top: 0px; margin-bottom: 0px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: rgb(36, 36, 36);">Liu, Xiang</span></p>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhou1, Tao &lt;Tao.Zh=
ou1@amd.com&gt;<br>
<b>Sent:</b> Friday, April 10, 2026 7:55 PM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: fix CPER ring header parsing</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
&gt; Sent: Thursday, April 9, 2026 5:24 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao<br>
&gt; &lt;Tao.Zhou1@amd.com&gt;; Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<=
br>
&gt; Subject: [PATCH] drm/amdgpu: fix CPER ring header parsing<br>
&gt;<br>
&gt; amdgpu_cper_ring_get_ent_sz() parses CPER headers directly from the<br=
>
&gt; circular ring buffer to determine the current entry size. When the rin=
g is full<br>
&gt; and the write pointer lands near the end of the buffer, the header can=
 wrap<br>
&gt; across the ring boundary.<br>
&gt;<br>
&gt; The existing code treats the 4-byte CPER signature as a C string and u=
ses<br>
&gt; strcmp() on in-ring binary data, then reads record_length through a di=
rect<br>
&gt; struct pointer cast. Both assumptions are unsafe for wrapped entries a=
nd can<br>
&gt; read past the end of the ring mapping.<br>
&gt;<br>
&gt; Fix the parser by comparing the signature as raw bytes and by copying =
the<br>
&gt; header into a local buffer before reading record_length, handling wrap=
around<br>
&gt; explicitly in both cases. This avoids out-of-bounds reads in<br>
&gt; amdgpu_cper_ring_get_ent_sz() when the CPER ring is full or the curren=
t<br>
&gt; entry starts at the tail of the ring.<br>
&gt;<br>
&gt; Signed-off-by: Xiang Liu &lt;xiang.liu@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 34 +++++++++++++++++-=
----<br>
&gt; --<br>
&gt;&nbsp; 1 file changed, 25 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c<br>
&gt; index 35fed4a05e1c..54ee4f7e7a0f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c<br>
&gt; @@ -426,23 +426,40 @@ int amdgpu_cper_generate_ce_records(struct<br>
&gt; amdgpu_device *adev,<br>
&gt;<br>
&gt;&nbsp; static bool amdgpu_cper_is_hdr(struct amdgpu_ring *ring, u64 pos=
)&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct cper_hdr *chdr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; char signature[sizeof(((struct cper_hdr *)0)=
-&gt;signature)];<br>
<br>
[Tao] I prefer to define CPER_SIGNATURE_SZ macro for sizeof(signature), wit=
h this fixed, the patch is:<br>
<br>
Reviewed-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; chdr =3D (struct cper_hdr *)&amp;(ring-&gt;r=
ing[pos]);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return strcmp(chdr-&gt;signature, &quot;CPER=
&quot;) ? false : true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if ((pos &lt;&lt; 2) &gt;=3D ring-&gt;ring_s=
ize)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if ((pos &lt;&lt; 2) + sizeof(signature) &lt=
;=3D ring-&gt;ring_size) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcpy(signature, &amp;ring-&gt;ring[pos], sizeof(signature));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; u32 chunk =3D ring-&gt;ring_size - (pos &lt;&lt; 2);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcpy(signature, &amp;ring-&gt;ring[pos], chunk);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcpy(signature + chunk, ring-&gt;ring, sizeof(signature) -<br>
&gt; chunk);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return !memcmp(signature, &quot;CPER&quot;, =
sizeof(signature));<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; static u32 amdgpu_cper_ring_get_ent_sz(struct amdgpu_ring *ring,=
 u64 pos)<br>
&gt; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct cper_hdr *chdr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct cper_hdr chdr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 p;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 chunk, rec_len =3D 0;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; chdr =3D (struct cper_hdr *)&amp;(ring-&gt;r=
ing[pos]);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chunk =3D ring-&gt;ring_size - (po=
s &lt;&lt; 2);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!strcmp(chdr-&gt;signature, &quot;CPER&q=
uot;)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rec_len =3D chdr-&gt;record_length;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_cper_is_hdr(ring, pos)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (chunk &gt;=3D sizeof(chdr)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;chdr, &amp;=
ring-&gt;ring[pos], sizeof(chdr));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;chdr, &amp;=
ring-&gt;ring[pos], chunk);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy((u8 *)&amp;chdr =
+ chunk, ring-&gt;ring, sizeof(chdr)<br>
&gt; - chunk);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rec_len =3D chdr.record_length;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; goto calc;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; @@ -451,8 +468,7 @@ static u32 amdgpu_cper_ring_get_ent_sz(struct<br>
&gt; amdgpu_ring *ring, u64 pos)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; goto calc;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (p =3D pos + 1; p &lt;=3D ring=
-&gt;buf_mask; p++) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; chdr =3D (struct cper_hdr *)&amp;(ring-&gt;ring[p]);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!strcmp(chdr-&gt;signature, &quot;CPER&quot;)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_cper_is_hdr(ring, p)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rec_len =3D (=
p - pos) &lt;&lt; 2;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto calc;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt; --<br>
&gt; 2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB63459C79C2B09B4D539B124DFA242CY5PR12MB6345namp_--
