Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414CFCC6B2A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 22:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D189810EB37;
	Wed, 14 Oct 2026 22:19:52 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E3E10EB37
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 22:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPhbWKyQr+GravivRVIPn2SGoKkffURGd1Sj2EMmM5jHSl2ADgyJR0RgpruIpTDqzNqCOIL0BK4WusAONCFObY1hkuf+gHT+UqfjIyKFQDk9/7zyU2o44kJHTzPFVmxBnOvXJ7zqB1hM6YbLha4Hvas9C0oHz6nN7jy85YHaKlTsqYmhzOkg+4HZ+NXvmykMVpDgGuujbQFlYBXLyG6Z2SZDN+SjIZg1IV+RTjtWqyA9QsudfnZOTdNtR16ci1Da0SbeaBRfmBi6bWjtNh5Sgp9c8E8Pco9TmMIJ6pkneqoHSy1Lu0d4Rdk1o4245pAggsbSmlpb/5xbE7tIGR3aMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5jkAVXDyKA6nsiU5RwggNRMWFUYwQW6ye4s4AfAh3M=;
 b=NJYeFljza2S4euSy32jF7yD2/o6w5JmRRCojDNgnGvW+0mPY1QMIYVtbWSdsipVLwv8VTmlpgHmZQwzBLEEd06PaLo6c3/FM2pDOvP+nDMoheaxFvorfEkXvZkvQjeXMlE22QZGn3Fgu5GkCHKqzNB0MrFVorsd5eL0jBkUHiBPefKPNpKs6aJVa7VcjiiWq7/4CBh4YrCBxO3u3ES/usmM3eo1MDZ4a/qtQ+62cFYELqVzrxHBK/uWxb5CS7n7T5gzb67OYhqEl175WZYbhmx49KQduxx5BXW0ykxWlysusjoZVhTSA2Gw4ovNX0hlPeo/yNaNs7QRh34OzmjquLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5jkAVXDyKA6nsiU5RwggNRMWFUYwQW6ye4s4AfAh3M=;
 b=Lzwhe29XIQjj3mMvpg1gWqzB2c4xa16apIjsP+ZK/jAcnIppCkP7pbTeKqTfdAgsFd4MOJoFyHpAF2uE5YWEKtldjLG+6ak4UQFKCdBcvt/C8d7NcKaRCtQhR/h7TqJB7ZODJow2LsJAYJs35dkOpUGxPPq1d83Zn07AzYKjowc=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 22:19:42 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 22:19:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Min, Frank" <Frank.Min@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Wang, YuBiao (Ethan)" <YuBiao.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT
 VBIOS image
Thread-Topic: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT
 VBIOS image
Thread-Index: AQHdW7LkD20SWBV6h0ipkK+aqO9Zlrb9m2Qw
Date: Wed, 14 Oct 2026 22:19:42 +0000
Message-ID: <BN9PR12MB51465FA6B74D63574BA3CCB6F79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20261014080523.186533-1-rezanikzadch@gmail.com>
In-Reply-To: <20261014080523.186533-1-rezanikzadch@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-14T22:14:47.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SA5PPF8ECEC29A9:EE_
x-ms-office365-filtering-correlation-id: c013004c-af39-43cc-5c5f-08df2a413ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|10067099003|22082099003|38070700021|56012099006|11063799006|261009223027099003;
x-microsoft-antispam-message-info: 6bi6cQPkQS1efq13WWYQMfefrHYBhFNFMRhPO+SEh25qQ818Ns0Xjw0gNpIlFOYGqtJ86BDPk35SRLtYG0FsHoSYpyqJ+lRvkfygiFBy6h5uh6Q5AHTdtCGPBUVQTHHFVigmVz8Vg8Jgcw1CvRApGpFLCHL4KVzMyZ43uXMF3g3ZoJLk77Z7mX6IqzjRsBSZJ9jcG1nrpde3qYjYpWPARrAvrKrkzpOTWWFYPgc94zA1grCmkLh12TzMb+8Ec7ISIo3Fb4kVdqvGYyfooQfbOcgC0eXHP2JGJb/KFWcyxPeXS67+TMEzjel5bsYWJ0RneLyQhiOG5tK2JcFb/ASHkuVx6ZmXw3NiMjhsx/SAwyoK4MzddGrYjo8rMTD8CaapT4UTv/7fUP90Ii6yN+9eEokAauWhKZlxBKZhX9CaOAycvFT0oQFfD0laf/XK3PELiG1gVi68BuycP0ut3Le/3/5J1AFzZqSV+MPi5pjUaFntuHL4YmYQeaJedlaWtjarkNP1dRRiEf5W4oWhzlD/QNqFA6uKbVL2QhewOp/fyOILXPTz49MyyYyCoDdfSzfffhi9yKuH+zQCmGaN/IuLU9thhbc0jxSvCo5gmuGcfmC+BkaHzT4x3p7k6nXieWbfioe1DZelQnrxfzGpCDSbNnZEKBuvFwZsDJ1tgFrT+vz7a/jOXlbPARCUq8eoW0Jle0Olg3/VuEk7aHk46E42qBv26x2RLk0hWN7QlXAHrL0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(10067099003)(22082099003)(38070700021)(56012099006)(11063799006)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JE5THFSmwo3En7EK1J80huc3ZmBdBHTQpJfzx5aZ6o6aKHSxGKdmi7GHJbTm?=
 =?us-ascii?Q?Q+GTcsGlVDVXDV9ls5WqyejQ8qFcem3w891syzX8Q6s1qFtmhscMV178ue5c?=
 =?us-ascii?Q?FqppwbhWIcv1lmE1CxPNj6nbfyFJPAgjbUD8k/COEQ0z0mGQ2tL9GJnKqfIO?=
 =?us-ascii?Q?z9RC2unlSTGuWdhzmOHAAV340N+bedmNg63NiGfmd5BhDPd2RRvdIl+erLJW?=
 =?us-ascii?Q?eCQRAROs7ZmBePAxZx91qtou42JVyRm+FUK1halk/UEjRN1r3Mu9t+CGG4C3?=
 =?us-ascii?Q?wf5cmwRd5ck/Y7jV/8Z3F5P27szoeJbMDPw2aRSblOPLTGBq3PWPwvfhK24v?=
 =?us-ascii?Q?Bi4du6rDwlp/n7tXmap5t55t/erK6gWYGClaoMFckR2mXmUj1qcgNwJzKg1l?=
 =?us-ascii?Q?MtNFRh95bcBzz6QJrOUBClNdwCAl/K7P37AJEkfgQJ8Zaiv1mPrFEplVSGjB?=
 =?us-ascii?Q?V/MBbVeLenTE1ac8ElfYkwvd9sHDzcKxHmOqhXGOiGHBBJCrxZEuYcDCgwdV?=
 =?us-ascii?Q?HLll/DDqKXH5omvvXkIJM/tgAgM145JJbN66RfKXUaF1dS6cvOmLo7uZ2COv?=
 =?us-ascii?Q?GT28mgF96IJeKufIsh9KjTsSNNzwjYYRGE27RtjlU8hK5eA0BKtw/b0oRgyC?=
 =?us-ascii?Q?Xn8i+ojaxASzLd2KRFieGo2t29ZGW2pNgd6J32bwi161fOr6BzVrhMFQQF3t?=
 =?us-ascii?Q?aVg3xW9RTvD9fAOcO+Jjtg3GWTpP97CO1iAS5xqIu5O11u/yXlqvOi/ysPYN?=
 =?us-ascii?Q?82NEY/d+B3WrWCb6U9TJcyahdRs6IuiWsAnfDF5pyU28JHPsQ9X/KDG3YWjV?=
 =?us-ascii?Q?7+gi4UsTt+aqavMFsxE8TpmUahTzbfuYq3X7k0K/+IcWEFnsX+qQi5hUpD1k?=
 =?us-ascii?Q?2k4oWekFQ6F0+zDwqo0jmZ5bz8WVflp3gOS5pIVGPibvKpy7jSmMtlC8Y269?=
 =?us-ascii?Q?MGkLqw5H9LkcBffsOHV1caVNWrALOFk8VAH9t5IbiysZ1467CddIF0jBg5p0?=
 =?us-ascii?Q?Z1WSYuxX8YbCXLedzafTvkpNv+dSBPuifcQ1aVHHZoKReYYiRUsQP8WO7zRI?=
 =?us-ascii?Q?4a2jWq68nrAoIQgMJJQJT6ZGzKqhITEfVq5TfhhvZ/0wNL0iF6UbderPNams?=
 =?us-ascii?Q?NxIajm7c7UXOldKPyCVTgdSVFHDcH4Kkg+Z7aS824OlC8PpLPhdGJ/72g4oI?=
 =?us-ascii?Q?/j5km2o+xZmIR2svzHVPxEqyhO7UDU1C9PMO7Sn1YsVi/T8PEIWmT5JykCKB?=
 =?us-ascii?Q?xRkHZhFQZy+BNa+30qV1nugv38Czd4lzp1oylUBZpKfzQHnc/CASdctM0Ejl?=
 =?us-ascii?Q?sSjpA4Hrre7fTRUS5Tqk6nZFiN/EGisA3vxgMn4IrAYadIoqMyalr62bOHEv?=
 =?us-ascii?Q?0aDqlREFQ4f+qLihsSg1SrH8tV5tceIEKyKmgSi8ZjA0P7WZJxYOwezKTRrT?=
 =?us-ascii?Q?Zq/7wdqdeskLR9iu1P1c2OLw51BNz/er3BTdru3ZJNoP1l3nf5YxKN5M5t0R?=
 =?us-ascii?Q?yXexwudiK2A8kQWd4XBTzNhIumvTb1aLawKRXvuOUSj4PFKTGLiIpmeaRh4V?=
 =?us-ascii?Q?vjA9JMl7mudKnNADn3383Ozi2Z0dEJjoO5ZD30f1dFCB2kl8Mk+1eqUDtSwA?=
 =?us-ascii?Q?Nt90+9rcVq0eDrCQ5/lgSQRpqBETAcZkjX7kaAieKnKm478/h9zK0TXvSWIJ?=
 =?us-ascii?Q?f6fSFx6L3EYY01WBkooMwEhZPHvraFQkWtmHeQYcXpMFMGDA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c013004c-af39-43cc-5c5f-08df2a413ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 22:19:42.2205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07/1+YiHBrhncylhORMVKksFO6bVtAAHjvu7E2nkh1JsR1NzeE3HDreHgZVsD+L3MctHfhHMl781vhM2MpW6AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9
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

Public

+ Mario

> -----Original Message-----
> From: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> Sent: Wednesday, October 14, 2026 4:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona
> Vetter <simona@ffwll.ch>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Min, Frank <Frank.Min@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>;
> Wang, YuBiao (Ethan) <YuBiao.Wang@amd.com>
> Subject: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT
> VBIOS image
>
> amdgpu_acpi_vfct_match() accepts an entry whose bus number differs from
> the runtime bus number as long as vendor, device, slot and function match=
.
> The caller takes the first entry that matches and stops.
>
> On systems with several GPUs of the same model (e.g. mining boards) every
> card matches every entry on vendor/device/function, so an earlier entry i=
s
> selected for a later card even when the table contains an entry with the =
exact
> bus number. The later card then runs with another board's VBIOS (differen=
t
> power/clock/memory tables) and can fail to initialize, for example with "=
UVD
> not responding" and a fatal error during GPU init.
>
> Search the table first for an exact bus match, and only if none exists fa=
ll back to
> matching by device identity.
>
> Reproduced with two RX 580 (Polaris10, 1002:67df) from different vendors
> on an ASUS B250 mining board: VFCT holds entries for bus 1 and bus 12, th=
e
> card at bus 12 was given the bus 1 image.
>
> Signed-off-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>

I think I'd prefer to just revert the change the loosened the mapping.  The=
 loosening was done to fix when someone sets pci=3Drealloc on the kernel co=
mmand line.  I'd consider that to be more of a corner case and presumably e=
ven that would potentially break on a system like yours anyway.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 71 +++++++++++++++-----
> ----
>  1 file changed, 46 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index f9315e047..d42485e6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -441,10 +441,15 @@ static bool amdgpu_read_disabled_bios(struct
> amdgpu_device *adev)
>   * the bus numbers disagree we accept the entry if the device identity
>   * matches.
>   *
> + * @exact: if true, only an exact bus number match is accepted.  The
> + caller
> + * first searches the whole table with @exact set, and only retries
> + with it
> + * cleared when no entry matched exactly, so that an earlier entry for
> + an
> + * identical card on a different bus cannot shadow the correct one.
> + *
>   * Returns: 0 on match, -ENODEV on no match
>   */
>  static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
> -                               VFCT_IMAGE_HEADER *vhdr)
> +                               VFCT_IMAGE_HEADER *vhdr, bool exact)
>  {
>       /* Vendor and device IDs must always match */
>       if (vhdr->VendorID !=3D adev->pdev->vendor || @@ -459,6 +464,9 @@
> static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>       if (vhdr->PCIBus =3D=3D adev->pdev->bus->number)
>               return 0;
>
> +     if (exact)
> +             return -ENODEV;
> +
>       /* Bus mismatch but device identity matches (PCI renumbering case)
> */
>       dev_notice(adev->dev,
>                  "VFCT bus number mismatch: table %u !=3D runtime %u,
> matching by device identity (vendor 0x%04x device 0x%04x)\n", @@ -474,6
> +482,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>       UEFI_ACPI_VFCT *vfct;
>       unsigned int offset;
>       bool r =3D false;
> +     bool exact;
>
>       if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>               return false;
> @@ -484,38 +493,50 @@ static bool amdgpu_acpi_vfct_bios(struct
> amdgpu_device *adev)
>       }
>
>       vfct =3D (UEFI_ACPI_VFCT *)hdr;
> -     offset =3D vfct->VBIOSImageOffset;
>
> -     while (offset < tbl_size) {
> -             GOP_VBIOS_CONTENT *vbios =3D (GOP_VBIOS_CONTENT
> *)((char *)hdr + offset);
> -             VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
> +     /*
> +      * Pass 1 looks for an entry whose bus number matches exactly.  Onl=
y
> if
> +      * there is none does pass 2 accept an entry that matches by device
> +      * identity alone.  Without this, on a system with several identica=
l
> +      * GPUs an earlier entry would be picked for a later card.
> +      */
> +     for (exact =3D true; ; exact =3D false) {
> +             offset =3D vfct->VBIOSImageOffset;
>
> -             offset +=3D sizeof(VFCT_IMAGE_HEADER);
> -             if (offset > tbl_size) {
> -                     dev_info(adev->dev, "ACPI VFCT image header
> truncated,skipping\n");
> -                     goto out;
> -             }
> +             while (offset < tbl_size) {
> +                     GOP_VBIOS_CONTENT *vbios =3D
> (GOP_VBIOS_CONTENT *)((char *)hdr + offset);
> +                     VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
>
> -             offset +=3D vhdr->ImageLength;
> -             if (offset > tbl_size) {
> -                     dev_info(adev->dev, "ACPI VFCT image
> truncated,skipping\n");
> -                     goto out;
> -             }
> +                     offset +=3D sizeof(VFCT_IMAGE_HEADER);
> +                     if (offset > tbl_size) {
> +                             dev_info(adev->dev, "ACPI VFCT image
> header truncated,skipping\n");
> +                             goto out;
> +                     }
>
> -             if (vhdr->ImageLength &&
> -                 !amdgpu_acpi_vfct_match(adev, vhdr)) {
> -                     adev->bios =3D kmemdup(&vbios->VbiosContent,
> -                                          vhdr->ImageLength,
> -                                          GFP_KERNEL);
> +                     offset +=3D vhdr->ImageLength;
> +                     if (offset > tbl_size) {
> +                             dev_info(adev->dev, "ACPI VFCT image
> truncated,skipping\n");
> +                             goto out;
> +                     }
>
> -                     if (!check_atom_bios(adev, vhdr->ImageLength)) {
> -                             amdgpu_bios_release(adev);
> +                     if (vhdr->ImageLength &&
> +                         !amdgpu_acpi_vfct_match(adev, vhdr, exact)) {
> +                             adev->bios =3D kmemdup(&vbios-
> >VbiosContent,
> +                                                  vhdr->ImageLength,
> +                                                  GFP_KERNEL);
> +
> +                             if (!check_atom_bios(adev, vhdr-
> >ImageLength)) {
> +                                     amdgpu_bios_release(adev);
> +                                     goto out;
> +                             }
> +                             adev->bios_size =3D vhdr->ImageLength;
> +                             r =3D true;
>                               goto out;
>                       }
> -                     adev->bios_size =3D vhdr->ImageLength;
> -                     r =3D true;
> -                     goto out;
>               }
> +
> +             if (!exact)
> +                     break;
>       }
>
>       dev_info(adev->dev, "ACPI VFCT table present but broken (too short
> #2),skipping\n");
> --
> 2.53.0

