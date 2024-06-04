Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D68C25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 13:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BB010E487;
	Tue,  4 Jun 2024 13:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l5bElqcq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 777A310E487
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 13:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJHhx/bgLa5WsoJn/6owIo3rUDUCUOOUNZQDGMcQ8/ZJuipwy8ZWRXCUUR9+NtLOYNcpHXQGXUmNaCgLQ1Llaw2mDDWMgaxFyU26A7iwaTDLhk5CNIvbK0aBYkm0XcBtByMGf3fofnm0lVx1JLzT1AxR5yaj/GOS0LNbWcZyz/6XYHvLjoV/RHV6sVJFmfAr4sVqzx8P5/bn4Nh8SXCS3e9LZorfBRbrr0ECvz8lAPewyKlMw12pGg8MPdL/k/bLGo/32qWesmPudj5R+gvebUh/Z8uiSGJK46cV2K8C/8+nYvmzZ8PTSSgfmfDQdy8EofEGgswgjWXxrgXTW/b+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d+61O6ZbIUJ2woCgo9f4QZFmGUAkdPk/t00iBjHzyY=;
 b=LYTFEqAEM8ktZwjyzpDCGVM6Ztj/jgaVSNQqmLhRiFCz0RqtEu5/bf0Q1wqHfdSr40zepZ8BQr4XmcqI61AHtaEHJoSnmuK9aWPh/2ui98iyJdYTVTLl4B//HY6ZinXRF8u8EObwkr0P+h7lV9H8QnCm6x+r9ZBZ3tHhOVpIbc2DN3ZR8IaIfk7kuRN/E3nyRFw4U03f53kS1LXPlJBKbUplQgPu4PsDwQsrDUmxfzPDblgoBXxWcFEeWpEgpIkWd3bX/vIScDokZa5ncBktqz6qM6whbDSUpQNZBu1YTsQ4DU4knqsxATMobNoQ/fGg+W8pa6rhM+rzniBRIST4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d+61O6ZbIUJ2woCgo9f4QZFmGUAkdPk/t00iBjHzyY=;
 b=l5bElqcqqzIdcGNezUtQgWM+gObXbUqi/ChO5SeBwXGpsvxmuJ3NNdU7DqHnes3ifDkgQdQyv8+7Ej3TDHPFofZFMerc0dgIWoJjjE2sB2V8b/M0/JbpLd0cuEoC6KvraBjyqJBKxby3t9rbyZQhhW+j2ox/EjkI9QSDhNuQtTA=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.25; Tue, 4 Jun 2024 13:28:17 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 13:28:17 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Jiang, Sonny"
 <Sonny.Jiang@amd.com>, "Dong, Ruijing" <Ruijing.Dong@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
Thread-Topic: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
Thread-Index: AQHasqHviYwrSNpDIUOCmFFG/v26KLG3oLOw
Date: Tue, 4 Jun 2024 13:28:17 +0000
Message-ID: <DM8PR12MB539991A6C2CE1CD486F536FAE5F82@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240530145858.4022206-1-David.Wu3@amd.com>
In-Reply-To: <20240530145858.4022206-1-David.Wu3@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7f06c152-2171-4be9-b281-3974f2048b62;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-04T13:27:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|MN2PR12MB4343:EE_
x-ms-office365-filtering-correlation-id: 1e3186da-1120-4486-8462-08dc849a3198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?URSvj19EaPLmEwDDxgnoeeAs4SB6p0rFK5uOByiNttWa1pZDVY0ufq8CAbnk?=
 =?us-ascii?Q?osOnQUjQYHfSHbp22Dd9rvb3MaanWSOZqw80ofs+E1Yr0/ldeMlq5tMH28og?=
 =?us-ascii?Q?3JMalqwZUAZW06hOq7HX+f8V90MJjZr5lyFb25O1CWSy8PfPkjHF1yuDrLG/?=
 =?us-ascii?Q?la3NAxEBX/7yaglWDDIFSUoHsq8wSkKcW+v9ZuzTCd+wPJA0+/xYcU2pwouI?=
 =?us-ascii?Q?7umKzkVpb3H28KeOApMk5Aojz96chtKo9HhqTvdKyGuMuc/Boqb3490mbisr?=
 =?us-ascii?Q?h89s+TypizYTfde/1i5LAl/HHnt2u4LkwtRiUnVRsAGjOQqaNAu/uwnuzGmY?=
 =?us-ascii?Q?MX08HqLhVIqs6KDiPGip/ObbZhDTki7+G0LpSV4UcHYEwnE+PpIJjOYais5y?=
 =?us-ascii?Q?RLZGB/Nwd6OmsQHy8HSUdJwPMrOfoW9Jp4hOg/BmZmqsvVR4d1aCw4iWm9hf?=
 =?us-ascii?Q?BDLS2By7HfYYzQ/cAZqYWUxxNSeNhSi32l5xPN6p1KfLFlinlv49lV0NxiVb?=
 =?us-ascii?Q?2Zd4LYnEs88M9BAgE2WInut6svRl8QIg3T5lsCw8Z9jGWv94P3+5xROGtr7u?=
 =?us-ascii?Q?pcGxhO6kSP11wKHRKqVDmH+6vWM5dLzNendFnf+B55uZPzo+ovpFwQ/ndLhW?=
 =?us-ascii?Q?lR66jKBkyH8A3aILYBiMBKMIrMHfAeiylpO7CQKHw01g4UJfVEJry83KijMz?=
 =?us-ascii?Q?c9AGI4oi3oYJpAouhTtCo9h2XLr/MVQDBPL2LVTFFhDy0E+gEEXMkuQSK1Mf?=
 =?us-ascii?Q?cI6iVmhGJZNVGsxrNfazVzZWt2kNgmvoM3VOjpA1m/UEC6pVIbnSp3nGHCnt?=
 =?us-ascii?Q?AJk/GdHT9Q69GWOTplY0CbttN1s4+SiCg6adusZC+EYKiHIXgntIOcUSp8Sf?=
 =?us-ascii?Q?UunS8Sn8Mhe4phJPtcqmKwPdEKtaG1aWkMkn8FmAyG1OBIknjHCkm0EL39bQ?=
 =?us-ascii?Q?u968JHXE94GLyUwTBU1ShePszQrEekmic32rX/S8+CBJtmmBqYDGBVMWYf/O?=
 =?us-ascii?Q?nhTT9qTZWWy8eiDqVds5XJnKdYtlortqGlKHI0ozWYmBO8k+YXQOtf3wpQb5?=
 =?us-ascii?Q?hWGtQrG2izIzppRhMaEo9LswzaZAdMtLFbSsN3QY8ZZa3YG7g9f/zZEKB1z4?=
 =?us-ascii?Q?/2tMAK9VXH+l22lXgegMfAZ789EOznC33wNGCJOasL8bXP8sXHgBNpQ42pev?=
 =?us-ascii?Q?QVh1aazFAJQuGrpYxFGT6g/Kdee9+Oc3fPkCHtiDMWgZl5nCWt84GlizI5EM?=
 =?us-ascii?Q?b23aWkMjoORD79Bqi045JHMrzOTrsfsohyJXe3Jr+oUxVkStNhs1WbLGvY4p?=
 =?us-ascii?Q?Bo6gvuq5cJFuYeg105NgiX3pxW6pCuNkCzspHOSsGd6LAw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?//BxSG8J89BxZnrnhB6SiRDujO/fTmKMixw6Wm3L7FJ1AgfSbG3BZ0yEpBBu?=
 =?us-ascii?Q?agYsJHrUFMXk9llcWT5cpaEUTr5ASiLK4CneSXjrTOMS2b/PwUnSikuTmWo9?=
 =?us-ascii?Q?rEjSFSPDxh5te8nhvtZdiqoKCKklnB1xizrNXARlBCpoMSFEwuWTydXCvuhm?=
 =?us-ascii?Q?iYQjO1XAe75gc8H4kbLVlp/MMpBhAHVOwOYwE+65z7GQadpaGma/o2L/lTXZ?=
 =?us-ascii?Q?9Y6z63fVONpDe1kOOfxQKecnD+2vLfTKASuTEKrD8xTq7Fi3gVCLPSpuW8uI?=
 =?us-ascii?Q?unHyBrkNl4VgHMYITyRfd9Ep1Uxkrf8Uizmdx4F+gDg3KJPVeGeLO2qYfEq0?=
 =?us-ascii?Q?X9Dgf1J/mk4R3p3AyFVlZZd6QMrZyO4pDq6EMcW2qCoLanpPJz5QQmOpxqwK?=
 =?us-ascii?Q?qae4Jo6gRN7ZGyJVS8XZH9B7fVhWJkwLwHKEPgJJt6B19QF9NO/nN4CWN4o9?=
 =?us-ascii?Q?XwDTN4efhzIkmc8+BLRdpKYlnYQ0XjBrff5Xo1gpt8ALGPVSAUbAjzMqYIEO?=
 =?us-ascii?Q?YqS1bsoj2CdyO0b/sUfzkVftPntqxGbqrP9XXzDqSeIAsWolMylovrUCnAcf?=
 =?us-ascii?Q?CSoHixqEwslcIm1vN/kbYZ5ZbbMiJd8JeBbcTRRHuuSxFcgJGylbtrsdJsCC?=
 =?us-ascii?Q?g0g42l3KIxEs8naZ4M79upjS532ewPJzBW58MoRyNmX+pW7qim4VnOGpJBre?=
 =?us-ascii?Q?KY7+NVdqVp7/n86emhi42LkMiofkRzSabIa4Tji6uQ9kA0vZyp21jtpDXwvm?=
 =?us-ascii?Q?iFcZhBIbpWTLvEzUha7aow9K0M5rCu5paFh8cW6pFDAinWFdxQ3qfU7+8p3Q?=
 =?us-ascii?Q?b6CGAf3SuraYxBiUq7dOPUWt6CgzG0A3HMwMnfhE3A11jTN+tU0TRBu+ptNM?=
 =?us-ascii?Q?ZfmB7aDDgLVTaaB/sQW9aK1hB21WaQqBsfhKsj4WRzHFsuVxW+F4NVlzabWP?=
 =?us-ascii?Q?POZPQC+p8JvGL1djKvOwhrh0PiPbQaPoe+uWyFgB+8+JJS+GP09zMsuNZh83?=
 =?us-ascii?Q?zj3GS0vc/2zBBT0n/eA5mY7mI0sH67AzEe+F/GRrTmVLRwO85WOj+ebi3+8j?=
 =?us-ascii?Q?DNO2+ug0DdGujaSv8j6Fq+zyPADRTA9eTLQ6uwmdqi8nH2SNuACz6BuzjL+d?=
 =?us-ascii?Q?WrIJw7ui+aewkyVd2k6cna89rEJFEWIhyWbgoK1A8Odfm3T/rqvR96TQTmoL?=
 =?us-ascii?Q?cLv9TCUriuxyuuj9mt2EF1fZ+Rj2+m2Hyb6SUg+i/SCUBZv6gnpkoy1WnWM5?=
 =?us-ascii?Q?l1jCZWBbVbIMArCr3SBX3at24rhOyLQbOrFpIoVU3B+o39SYDoiV0Ck2VGKJ?=
 =?us-ascii?Q?e1cUJ1j60M1dDuXWXiwxawBKQs6RieOK6DhjBqKECIGyHWITSDTRgPGlkZMp?=
 =?us-ascii?Q?L2ywk3IJ3MIhig5Q4lxXPDdh0uQG7ISgKNXuIQ4qFac0pVpDRNaZsYv+N5NA?=
 =?us-ascii?Q?nYBoJ7OqspBjuTMPOUO4XIyYyMkdxoRK2LtpCNn5yzHjSKRcCzdnjCfEVa49?=
 =?us-ascii?Q?Guf8c1IdQqgMtCdVdWZ2qvtGuhQ6rsFKi4GKJTw/jg5Cj0XN9wHnLwnmn46F?=
 =?us-ascii?Q?iTxILcEUM2bCeD2Hc3I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3186da-1120-4486-8462-08dc849a3198
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 13:28:17.1185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gD/5fpSJ3sFzcuM++iPfzu/et5rDDWX5uOJG90Y4v876uAoIS+7BAP+mlzJt88vQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
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

Acked-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: Wu, David <David.Wu3@amd.com>
> Sent: Thursday, May 30, 2024 10:59 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing
> <Ruijing.Dong@amd.com>
> Subject: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
>
> Similar to commit 15681da214b where some kernel log messages are dropped.
> With this commit, more log messages in older version of VCN/JPEG code are
> dropped.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  1 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  8 +-------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 10 +---------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 --
> drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  5 -----
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 14 ++------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 14 +++-----------
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 11 ++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 16 +++-------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 14 ++------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 10 ++--------
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 10 +---------
>  14 files changed, 17 insertions(+), 104 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index 77595e9622da..71f43a5c7f72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -581,7 +581,6 @@ static const struct amdgpu_ring_funcs
> jpeg_v1_0_decode_ring_vm_funcs =3D {  static void
> jpeg_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev)  {
>       adev->jpeg.inst->ring_dec->funcs =3D
> &jpeg_v1_0_decode_ring_vm_funcs;
> -     DRM_INFO("JPEG decode is enabled in VM mode\n");
>  }
>
>  static const struct amdgpu_irq_src_funcs jpeg_v1_0_irq_funcs =3D { diff =
--git
> a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index ef3e42f6b841..99adf3625657 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -131,16 +131,11 @@ static int jpeg_v2_0_hw_init(void *handle)  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>       struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
> -     int r;
>
>       adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>               (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -     r =3D amdgpu_ring_test_helper(ring);
> -     if (!r)
> -             DRM_INFO("JPEG decode initialized successfully.\n");
> -
> -     return r;
> +     return amdgpu_ring_test_helper(ring);
>  }
>
>  /**
> @@ -795,7 +790,6 @@ static const struct amdgpu_ring_funcs
> jpeg_v2_0_dec_ring_vm_funcs =3D {  static void
> jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)  {
>       adev->jpeg.inst->ring_dec->funcs =3D &jpeg_v2_0_dec_ring_vm_funcs;
> -     DRM_INFO("JPEG decode is enabled in VM mode\n");
>  }
>
>  static const struct amdgpu_irq_src_funcs jpeg_v2_0_irq_funcs =3D { diff =
--git
> a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index afeaf3c64e27..d8ef95c847c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -196,8 +196,6 @@ static int jpeg_v2_5_hw_init(void *handle)
>                       return r;
>       }
>
> -     DRM_INFO("JPEG decode initialized successfully.\n");
> -
>       return 0;
>  }
>
> @@ -728,7 +726,6 @@ static void jpeg_v2_5_set_dec_ring_funcs(struct
> amdgpu_device *adev)
>               else  /* CHIP_ALDEBARAN */
>                       adev->jpeg.inst[i].ring_dec->funcs =3D
> &jpeg_v2_6_dec_ring_vm_funcs;
>               adev->jpeg.inst[i].ring_dec->me =3D i;
> -             DRM_INFO("JPEG(%d) JPEG decode is enabled in VM mode\n",
> i);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 1c7cf4800bf7..31cfa3ce6528 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -146,18 +146,11 @@ static int jpeg_v3_0_hw_init(void *handle)  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>       struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
> -     int r;
>
>       adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>               (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -     r =3D amdgpu_ring_test_helper(ring);
> -     if (r)
> -             return r;
> -
> -     DRM_INFO("JPEG decode initialized successfully.\n");
> -
> -     return 0;
> +     return amdgpu_ring_test_helper(ring);
>  }
>
>  /**
> @@ -593,7 +586,6 @@ static const struct amdgpu_ring_funcs
> jpeg_v3_0_dec_ring_vm_funcs =3D {  static void
> jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)  {
>       adev->jpeg.inst->ring_dec->funcs =3D &jpeg_v3_0_dec_ring_vm_funcs;
> -     DRM_INFO("JPEG decode is enabled in VM mode\n");
>  }
>
>  static const struct amdgpu_irq_src_funcs jpeg_v3_0_irq_funcs =3D { diff =
--git
> a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 237fe5df5a8f..3dac8f259d7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -181,8 +181,6 @@ static int jpeg_v4_0_hw_init(void *handle)
>                       return r;
>       }
>
> -     DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
> -
>       return 0;
>  }
>
> @@ -755,7 +753,6 @@ static const struct amdgpu_ring_funcs
> jpeg_v4_0_dec_ring_vm_funcs =3D {  static void
> jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev)  {
>       adev->jpeg.inst->ring_dec->funcs =3D &jpeg_v4_0_dec_ring_vm_funcs;
> -     DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
>  }
>
>  static const struct amdgpu_irq_src_funcs jpeg_v4_0_irq_funcs =3D { diff =
--git
> a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index d66af11aa66c..04d8966423de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -341,7 +341,6 @@ static int jpeg_v4_0_3_hw_init(void *handle)
>                       }
>               }
>       }
> -     DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
>
>       return 0;
>  }
> @@ -1100,7 +1099,6 @@ static void jpeg_v4_0_3_set_dec_ring_funcs(struct
> amdgpu_device *adev)
>               adev->jpeg.inst[i].aid_id =3D
>                       jpeg_inst / adev->jpeg.num_inst_per_aid;
>       }
> -     DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
>  }
>
>  static const struct amdgpu_irq_src_funcs jpeg_v4_0_3_irq_funcs =3D { dif=
f --git
> a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 4c8f9772437b..f96ac6bce526 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -191,7 +191,6 @@ static int jpeg_v4_0_5_hw_init(void *handle)
>
>       // TODO: Enable ring test with DPG support
>       if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
> -             DRM_DEV_INFO(adev->dev, "JPEG decode initialized
> successfully under DPG Mode");
>               return 0;
>       }
>
> @@ -205,9 +204,6 @@ static int jpeg_v4_0_5_hw_init(void *handle)
>                       return r;
>       }
>
> -     if (!r)
> -             DRM_INFO("JPEG decode initialized successfully under SPG
> Mode\n");
> -
>       return 0;
>  }
>
> @@ -805,7 +801,6 @@ static void jpeg_v4_0_5_set_dec_ring_funcs(struct
> amdgpu_device *adev)
>
>               adev->jpeg.inst[i].ring_dec->funcs =3D
> &jpeg_v4_0_5_dec_ring_vm_funcs;
>               adev->jpeg.inst[i].ring_dec->me =3D i;
> -             DRM_DEV_INFO(adev->dev, "JPEG%d decode is enabled in VM
> mode\n", i);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index cb253bd3a2a2..a280b9fecb77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -202,24 +202,17 @@ static int vcn_v1_0_hw_init(void *handle)
>
>       r =3D amdgpu_ring_test_helper(ring);
>       if (r)
> -             goto done;
> +             return r;
>
>       for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
>               ring =3D &adev->vcn.inst->ring_enc[i];
>               r =3D amdgpu_ring_test_helper(ring);
>               if (r)
> -                     goto done;
> +                     return r;
>       }
>
>       ring =3D adev->jpeg.inst->ring_dec;
>       r =3D amdgpu_ring_test_helper(ring);
> -     if (r)
> -             goto done;
> -
> -done:
> -     if (!r)
> -             DRM_INFO("VCN decode and encode initialized
> successfully(under %s).\n",
> -                     (adev->pg_flags &
> AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
>
>       return r;
>  }
> @@ -2043,7 +2036,6 @@ static const struct amdgpu_ring_funcs
> vcn_v1_0_enc_ring_vm_funcs =3D {  static void
> vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev)  {
>       adev->vcn.inst->ring_dec.funcs =3D &vcn_v1_0_dec_ring_vm_funcs;
> -     DRM_INFO("VCN decode is enabled in VM mode\n");
>  }
>
>  static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev) @@ -
> 2052,8 +2044,6 @@ static void vcn_v1_0_set_enc_ring_funcs(struct
> amdgpu_device *adev)
>
>       for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
>               adev->vcn.inst->ring_enc[i].funcs =3D
> &vcn_v1_0_enc_ring_vm_funcs;
> -
> -     DRM_INFO("VCN encode is enabled in VM mode\n");
>  }
>
>  static const struct amdgpu_irq_src_funcs vcn_v1_0_irq_funcs =3D { diff -=
-git
> a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index f18fd61c435e..d3d096909a7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -237,7 +237,7 @@ static int vcn_v2_0_hw_init(void *handle)
>
>       r =3D amdgpu_ring_test_helper(ring);
>       if (r)
> -             goto done;
> +             return r;
>
>       //Disable vcn decode for sriov
>       if (amdgpu_sriov_vf(adev))
> @@ -247,15 +247,10 @@ static int vcn_v2_0_hw_init(void *handle)
>               ring =3D &adev->vcn.inst->ring_enc[i];
>               r =3D amdgpu_ring_test_helper(ring);
>               if (r)
> -                     goto done;
> +                     return r;
>       }
>
> -done:
> -     if (!r)
> -             DRM_INFO("VCN decode and encode initialized
> successfully(under %s).\n",
> -                     (adev->pg_flags &
> AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
> -
> -     return r;
> +     return 0;
>  }
>
>  /**
> @@ -2074,7 +2069,6 @@ static const struct amdgpu_ring_funcs
> vcn_v2_0_enc_ring_vm_funcs =3D {  static void
> vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)  {
>       adev->vcn.inst->ring_dec.funcs =3D &vcn_v2_0_dec_ring_vm_funcs;
> -     DRM_INFO("VCN decode is enabled in VM mode\n");
>  }
>
>  static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev) @@ -
> 2083,8 +2077,6 @@ static void vcn_v2_0_set_enc_ring_funcs(struct
> amdgpu_device *adev)
>
>       for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
>               adev->vcn.inst->ring_enc[i].funcs =3D
> &vcn_v2_0_enc_ring_vm_funcs;
> -
> -     DRM_INFO("VCN encode is enabled in VM mode\n");
>  }
>
>  static const struct amdgpu_irq_src_funcs vcn_v2_0_irq_funcs =3D { diff -=
-git
> a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index baec14bde2a2..96f60c303161 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -314,22 +314,17 @@ static int vcn_v2_5_hw_init(void *handle)
>
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             goto done;
> +                             return r;
>
>                       for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
>                               ring =3D &adev->vcn.inst[j].ring_enc[i];
>                               r =3D amdgpu_ring_test_helper(ring);
>                               if (r)
> -                                     goto done;
> +                                     return r;
>                       }
>               }
>       }
>
> -done:
> -     if (!r)
> -             DRM_INFO("VCN decode and encode initialized
> successfully(under %s).\n",
> -                     (adev->pg_flags &
> AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
> -
>       return r;
>  }
>
> @@ -1710,7 +1705,6 @@ static void vcn_v2_5_set_dec_ring_funcs(struct
> amdgpu_device *adev)
>                       continue;
>               adev->vcn.inst[i].ring_dec.funcs =3D
> &vcn_v2_5_dec_ring_vm_funcs;
>               adev->vcn.inst[i].ring_dec.me =3D i;
> -             DRM_INFO("VCN(%d) decode is enabled in VM mode\n", i);
>       }
>  }
>
> @@ -1725,7 +1719,6 @@ static void vcn_v2_5_set_enc_ring_funcs(struct
> amdgpu_device *adev)
>                       adev->vcn.inst[j].ring_enc[i].funcs =3D
> &vcn_v2_5_enc_ring_vm_funcs;
>                       adev->vcn.inst[j].ring_enc[i].me =3D j;
>               }
> -             DRM_INFO("VCN(%d) encode is enabled in VM mode\n", j);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 6b31cf4b8aac..24f947751c46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -303,7 +303,7 @@ static int vcn_v3_0_hw_init(void *handle)
>       if (amdgpu_sriov_vf(adev)) {
>               r =3D vcn_v3_0_start_sriov(adev);
>               if (r)
> -                     goto done;
> +                     return r;
>
>               /* initialize VCN dec and enc ring buffers */
>               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) { @@ -348,24
> +348,18 @@ static int vcn_v3_0_hw_init(void *handle)
>
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             goto done;
> +                             return r;
>
>                       for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
>                               ring =3D &adev->vcn.inst[i].ring_enc[j];
>                               r =3D amdgpu_ring_test_helper(ring);
>                               if (r)
> -                                     goto done;
> +                                     return r;
>                       }
>               }
>       }
>
>       return 0;
> -done:
> -     if (!r)
> -             DRM_INFO("VCN decode and encode initialized
> successfully(under %s).\n",
> -                     (adev->pg_flags &
> AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
> -
> -     return r;
>  }
>
>  /**
> @@ -2041,8 +2035,6 @@ static void vcn_v3_0_set_dec_ring_funcs(struct
> amdgpu_device *adev)
>               else
>                       adev->vcn.inst[i].ring_dec.funcs =3D
> &vcn_v3_0_dec_sw_ring_vm_funcs;
>               adev->vcn.inst[i].ring_dec.me =3D i;
> -             DRM_INFO("VCN(%d) decode%s is enabled in VM mode\n", i,
> -                       DEC_SW_RING_ENABLED?"(Software Ring)":"");
>       }
>  }
>
> @@ -2058,8 +2050,6 @@ static void vcn_v3_0_set_enc_ring_funcs(struct
> amdgpu_device *adev)
>                       adev->vcn.inst[i].ring_enc[j].funcs =3D
> &vcn_v3_0_enc_ring_vm_funcs;
>                       adev->vcn.inst[i].ring_enc[j].me =3D i;
>               }
> -             if (adev->vcn.num_enc_rings > 0)
> -                     DRM_INFO("VCN(%d) encode is enabled in VM
> mode\n", i);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index ac1b8ead03b3..f6d96a44d75f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -258,7 +258,7 @@ static int vcn_v4_0_hw_init(void *handle)
>       if (amdgpu_sriov_vf(adev)) {
>               r =3D vcn_v4_0_start_sriov(adev);
>               if (r)
> -                     goto done;
> +                     return r;
>
>               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                       if (adev->vcn.harvest_config & (1 << i)) @@ -269,7
> +269,6 @@ static int vcn_v4_0_hw_init(void *handle)
>                       ring->wptr_old =3D 0;
>                       vcn_v4_0_unified_ring_set_wptr(ring);
>                       ring->sched.ready =3D true;
> -
>               }
>       } else {
>               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) { @@ -283,18
> +282,11 @@ static int vcn_v4_0_hw_init(void *handle)
>
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             goto done;
> -
> +                             return r;
>               }
>       }
>
>       return 0;
> -done:
> -     if (!r)
> -             DRM_INFO("VCN decode and encode initialized
> successfully(under %s).\n",
> -                     (adev->pg_flags &
> AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
> -
> -     return r;
>  }
>
>  /**
> @@ -1900,8 +1892,6 @@ static void vcn_v4_0_set_unified_ring_funcs(struct
> amdgpu_device *adev)
>               adev->vcn.inst[i].ring_enc[0].funcs =3D
>                      (const struct amdgpu_ring_funcs
> *)&vcn_v4_0_unified_ring_vm_funcs;
>               adev->vcn.inst[i].ring_enc[0].me =3D i;
> -
> -             DRM_INFO("VCN(%d) encode/decode are enabled in VM
> mode\n", i);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 2279d8fce03d..f53054e39ebb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -210,7 +210,7 @@ static int vcn_v4_0_3_hw_init(void *handle)
>       if (amdgpu_sriov_vf(adev)) {
>               r =3D vcn_v4_0_3_start_sriov(adev);
>               if (r)
> -                     goto done;
> +                     return r;
>
>               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                       ring =3D &adev->vcn.inst[i].ring_enc[0]; @@ -246,15
> +246,10 @@ static int vcn_v4_0_3_hw_init(void *handle)
>
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             goto done;
> +                             return r;
>               }
>       }
>
> -done:
> -     if (!r)
> -             DRM_DEV_INFO(adev->dev, "VCN decode initialized
> successfully(under %s).\n",
> -                     (adev->pg_flags &
> AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
> -
>       return r;
>  }
>
> @@ -1450,7 +1445,6 @@ static void
> vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev)
>               adev->vcn.inst[i].aid_id =3D
>                       vcn_inst / adev->vcn.num_inst_per_aid;
>       }
> -     DRM_DEV_INFO(adev->dev, "VCN decode is enabled in VM mode\n");
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 81fb99729f37..f45495de6875 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -234,16 +234,10 @@ static int vcn_v4_0_5_hw_init(void *handle)
>
>               r =3D amdgpu_ring_test_helper(ring);
>               if (r)
> -                     goto done;
> +                     return r;
>       }
>
>       return 0;
> -done:
> -     if (!r)
> -             DRM_INFO("VCN decode and encode initialized
> successfully(under %s).\n",
> -                     (adev->pg_flags &
> AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
> -
> -     return r;
>  }
>
>  /**
> @@ -1558,8 +1552,6 @@ static void
> vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
>
>               adev->vcn.inst[i].ring_enc[0].funcs =3D
> &vcn_v4_0_5_unified_ring_vm_funcs;
>               adev->vcn.inst[i].ring_enc[0].me =3D i;
> -
> -             DRM_INFO("VCN(%d) encode/decode are enabled in VM
> mode\n", i);
>       }
>  }
>
> --
> 2.34.1

