Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1CEC5CFC1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 11:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F7410E309;
	Tue, 11 Aug 2026 11:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vLwKoFBp";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2AD10E309
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 11:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ih0ZDjSrnaIol845SebSiqdW4X2e9tP5WePOQsptIS5/W2xizCNdo37z4LNPm7YFfJjDwx23ZWCo21m7+a+gQKDFrvfYdTjzMj6gc5tzIXPc5QdypvqWOQfwtnMynM5o6pi2OoXN8cYdZ918iAosSNV64I4nAEO5px9Hjdz4lJEOQVF6VutTKbAbvWjKNcooyMacMvjFRNytQsigd+cqWxl8OndU5VcNEdlG/IH5TpusNipuWWJZbVc459RREh8m1rf7aUP1F8pC8uwFpCVFuDtY9EUhMjjfLB+VJmA9AqG5PThC+F+E3+Mo0IQl7KGK+/Tl8v3ZuIfVTGIiKeFIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESaxYXidIpQaLoZVWU5VDHTf6nZi47qBnBjGRrcjdTM=;
 b=pZ6nlLgGMozzIHv5HjU6I8AxtuFebARuvov61CWb5Gtny0TTMtDaqCUzXeg33pOPG8PiCvXjFwK6Pr//obG4f/qUEMxwo9DcpG+2bBtur/RML1yuxqmd+xdsa0QEuoXtgbJh+Tfle7gqZ9f3a0JSrp7M/npnia4y4mHemwb/GhZPtT1EW44MzkhI6QgMNqmTg5c5llKIVHd2+FTO+hL6PqZFIMcWtfyoZBsMONaNRFZH3tygc/86JBMcn8fqaajqJWohZFeAJt0F1mOI/kpAtj8NR46J7G+8JXL+Mwa1iYPrp4ExzAnuQT8Wyeb3b32sXv+bWDDWDn/P3jSTR47tIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESaxYXidIpQaLoZVWU5VDHTf6nZi47qBnBjGRrcjdTM=;
 b=vLwKoFBpYDDTWE5GhCyPdZh9LMjwbbDHkxsP1twTb4nzf2XA79pi0S9lsxxYXxxMvrLOVhw5vVCIFjE5pCQec9i0/OKsOh44y/6KAq5ScG4WTOU8b14X4TaEylricuACiSZ7F9tvc6oQVg0nUxHMicPhnVoWtRos6LValDHCvMA=
Received: from CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17)
 by DS0PR12MB999265.namprd12.prod.outlook.com (2603:10b6:8:432::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 11:41:47 +0000
Received: from CH3PR12MB7572.namprd12.prod.outlook.com
 ([fe80::709d:234b:b2b:ba82]) by CH3PR12MB7572.namprd12.prod.outlook.com
 ([fe80::709d:234b:b2b:ba82%3]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 11:41:47 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Rosca, David" <David.Rosca@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Rosca, David" <David.Rosca@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Reject UVD message with invalid number of
 h265 refs
Thread-Topic: [PATCH] drm/amdgpu: Reject UVD message with invalid number of
 h265 refs
Thread-Index: AQHdKXFU/C4zjprPcUm+Z9PkSj2dN7aYubRw
Date: Tue, 11 Aug 2026 11:41:47 +0000
Message-ID: <CH3PR12MB757293F0BDBBD845406C0890E5DD2@CH3PR12MB7572.namprd12.prod.outlook.com>
References: <20260811090702.95235-3-david.rosca@amd.com>
In-Reply-To: <20260811090702.95235-3-david.rosca@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-11T11:41:06.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7572:EE_|DS0PR12MB999265:EE_
x-ms-office365-filtering-correlation-id: 049994e2-1e9a-4442-21b3-08def79d86ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|42112799006|23010399003|22082099003|18002099003|56012099006|11063799006|38070700021|10067099003;
x-microsoft-antispam-message-info: 8QCOqAtllal5FzcuBQ2JE2YdjGVUzs7/ittS72xZsBnNQSpDsN2GzM6AyAPFc7DEXvp8BPA3+cCBzfex1dsbYQQ9dFeiAqG7qzjWC1hnVaLz7arK02Cxz5o2W/r1qFoU2MTt2JEABxjj2vq1leoh6pTw0XXLgKhF8eOxSvKFKNoiSRS3lB+/fYqgE92GurEMuRWr0mvlkORpcTjkxdAG7AsgQZ76nN79+m7Opsid5umbpUPm70RLjOhUhPgwVTlQJQ9RO32Zo4wVBFUdv+MpVa61gOT54yzarjKFypMOanaud5IEvSAoqcunwuWxt9K8SVN9fbiLAg1uEaWcaR5joMLaozb5s6nSmGM9/MkdTYxIr7NBxvipRNQ8prGlxkOSHuhKQ/bAO3n0oA+ikitKMelyr0DUw5ooh+uF2nEnfzO8WuCIVoAtVBCgmBVOnxjGHl0paNoXKxhfTW+jXFKLf6k8p0IQx2Uo8gnKZVP9Xr4E7qhbbZwqPmcMO3aKwXoK38qoYMu7KxkBtRCXIMFkEERQ3KuQRUlH/Up+ZdaOV17T3kIPPck+fMy21P6TW5Q+vTmGVgNmZcQ53Hcw8CUhUVoqfuhzRjnlxP+cfjib8nea8m3TsrxM/Ir+jsYWErSKfjCTEmgZmLY0sjueNW0cozszs2xx+s4JL2XAOvKpDU9Uw9+IocVlpkt1KWFyB7s+DaRl6ZBcCkQGh75vzw7YsQN6vd+AdGcZL74pMiDG+PA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(42112799006)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kvI6RJdKMk76ShatgzJ7a1l+YfQO3dAwCvIif9hTQ79rjhelU8PvnJWWPLf1?=
 =?us-ascii?Q?o5nkJHpQEN2rHuoLtS3ASZUeD94WMwpcfhsQSP/6HlgENUX8ppJj121mxb2n?=
 =?us-ascii?Q?fNeKVHMsvMdwDCBXeFXs40FymFnaYxaru02kurw8kWCisEOGHFCEYNPCQUT3?=
 =?us-ascii?Q?8fWTsWiJKvVxJ8AxdNVDPoYF5nZ4AUEmwpbvDHc7jJVFjXXZbCGjMsXGlb67?=
 =?us-ascii?Q?R+w1d0EoNczJHOL1C8rrycJgfbAi4P5BQrDD0VU99ANsTJlvz6Dqm+s6+txd?=
 =?us-ascii?Q?nRuu0YVX4nIRh8l19R7zuhg80+pSKMn2b490f4dlxDhLq5ryHyb3VE0cZhLx?=
 =?us-ascii?Q?xOoXTate2SWXs+Tm3v4ZCusDXY2wwF5RbVes7Ma04bBSoEf91jO5eE9SbgBX?=
 =?us-ascii?Q?Q6yCB7VMrXXigueH/YDNVI/1vzey2bYTXjSk3SobM9bxId7A9e9xzHEnx5wo?=
 =?us-ascii?Q?5/5i6JtUTEcwuBMk6+qoDwfCNxexfe7MMy37b558OHNgnJi7bYPm1qF+w7+S?=
 =?us-ascii?Q?xW2StxkC4h1OsD6cwjjSH84r9UqkeDFoOxA3KITtdIG2uQ1w6MLjaTW/psx+?=
 =?us-ascii?Q?MbSvp5vCUt0PLP3Gfjz6c2s8ME5XkSRcT6KQ0uAfaSYlyD3dkQZJnDZYTqg6?=
 =?us-ascii?Q?qGpEucgrsPagRFyS7XmAn00Im+vqqXwdvjRStR3V4EZrAKFfF3budEKaWbRM?=
 =?us-ascii?Q?miGKtxXRpvoh/IqXzyBuV74tgbNiQso7c5I1HIDj20vDmaS89VyJEbrlWWGB?=
 =?us-ascii?Q?GV1XXu651C9WDz//rSGQoop0bH2cEWSPPAnBOBRwR335OQ8kseKoG/R5JfM1?=
 =?us-ascii?Q?TT5iqwYWle0vude5HcL7+TP/l3n4Cu/dSikrS3McKoWptdBpbmtX2g7nCE5X?=
 =?us-ascii?Q?PawX8SBvQ2qC/NWw8JV5HDQnZrzxNMtvwwptuSRSIC4APDVAfBDpMqL02dNf?=
 =?us-ascii?Q?9n7L0oQI84IoiL0V/lEux2N+Q1xzHM0KC3yngJrH2gGlpTRQCyn23/tCV/e2?=
 =?us-ascii?Q?zEIzH/wXwJUd/1cVF4OGYT4mKMgRJGf/MeSbJ3tPWhFkl6kd8OtE66CrH8Tk?=
 =?us-ascii?Q?qSSXL985B+NV0+de1XDR/T655PDHSUkd0c2aBkc4gHPPQ/ZbozmrTnrhLcJg?=
 =?us-ascii?Q?9wdkXq2G/NQT9urZESswmV+puLY0Q8h3BgKIN5ifV11qcw8bjzscfc9K2tjy?=
 =?us-ascii?Q?9ji+XWwdRa2PbwDx4LJWcZLS7fwdg9ma5ZqvKYLZqQIaYvwKlxB9n7eG2aW0?=
 =?us-ascii?Q?J8SJoCWGpzL2XQGV/wo0vu/m1I0ni+hRz7DEC9g5TiH+4uj+Zo4SIM19SeQq?=
 =?us-ascii?Q?RI/Y1PB3TuXZrPk1q399nGGWSOsgj+1aKgCtYhwWsVRxQF4D3wSF9lCY19m0?=
 =?us-ascii?Q?rVe7FRRvuSEE5bz3W/rMk37qhQKNECPPfjJuoV+kwMkrSy5z7Bcvyo4z3Vf2?=
 =?us-ascii?Q?QXm6SNGW0OoV2Mro1xQtbehf7MJRE0aQg2m6/TFZyDeL8D9ZQvf9XE03o/Iu?=
 =?us-ascii?Q?zwqEXEdVkJ2WTF8Qa3ZxWSlYvleZOy7tfM1ltxjbGJSXmnPpiKxqdaA1+DeL?=
 =?us-ascii?Q?pfIL/cdzLhw4O+jB1wORY11FXqUNEMHYJelqWL7tBXWEjvuDXOS72NfxiiPB?=
 =?us-ascii?Q?yKmdWbRA/Xddrl2CMS4ZhdHj2yVMzDDBEX0IDs4weIaTw54rPdBNVDHfbdvO?=
 =?us-ascii?Q?mgm0By4QCh6nm5Jor+uf45M1m+Jp4hyhdyveH7sZKsTgEY6V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049994e2-1e9a-4442-21b3-08def79d86ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 11:41:47.4245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NKn2IwAjUwuPg8vdbKvG/ghBQX5XGdXwcT9upgSq9NQs5pYo3yvUyXZgI+Z/786
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999265
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

AMD General

Reviewed-by: Leo Liu <leo.liu@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Rosca
> Sent: Tuesday, August 11, 2026 5:07 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Rosca, David <David.Rosca@amd.com>
> Subject: [PATCH] drm/amdgpu: Reject UVD message with invalid number of h2=
65
> refs
>
> Same change as for h264, avoids overflow later when calculating min dpb s=
ize.
>
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index e2d0f23d48aa..228a405a94c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -749,6 +749,9 @@ static int amdgpu_uvd_cs_msg_decode(struct
> amdgpu_device *adev, uint32_t *msg,
>               image_size =3D ALIGN(image_size, 256);
>
>               num_dpb_buffer =3D (le32_to_cpu(msg[59]) & 0xff) + 2;
> +             if (num_dpb_buffer > 17)
> +                     return -EINVAL;
> +
>               min_dpb_size =3D image_size * num_dpb_buffer;
>               min_ctx_size =3D ((width + 255) / 16) * ((height + 255) / 1=
6)
>                                          * 16 * num_dpb_buffer + 52 * 102=
4;
> --
> 2.43.0

