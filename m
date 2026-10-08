Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA986CA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 12:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6480B10E7C9;
	Thu,  8 Oct 2026 12:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3JdysnmB";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51B2F10E7C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 12:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaMj61fQgXNEEjCZjps4wkDK3/0QHqRLlyNtPEzQrkDv9SONVRKOHGqIP21Bn85x2qlGdLMvGvG0Vj3f2rrSHRX3CV24kbu/B9CbajDhK2mAzPOl+N5s3J9LyItEthyMu7vJP1DRgWrVSd4bn4GD9soLV/Js1d/1uLe17eCQG2mAwe7wH1FLsthuGlRM+EHE3WfBB8Qu5cohkowa2o48+evhcZiu6tiHrdbAPkJkjBB0oj7fZLmEcQa8maJsZfU8vqPLpOTAmaIWhmpvoE+qE8X3H5+RYoBrNQVzxTJIPPEI2s0yHqV9YL3Q9+dCJiWBkicLeT7ELaFE6EZlowpPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neZfa0q3/jrp28AsN65QXjOl+8w+90Aqv7k3qHVq5/o=;
 b=BhTd3QAkLqi9mmK+KxwKWab/8NfjxuFStDP5xDIjj8OwwNCqgpsBCFlE64Vrk01fRiADbz3DvMZ6SQC3MUr9fAcb6QxgpzSMGEF+MnojoijuDkqbaPWWzJYicO9UF/cXdWsUcoeDOaADvHoTtcrPXCeguvPvzoNJfQwBEchO0N7yqYudypp1mEDLUdRYFdWFNVJ5dM7obvyvwB3JTaExVX6S4ZYIBnHzQheCwSM62J7Ff1WP8HK8ntXgEYWryTWE3+CoyGc48r/W1DMywE+HV6Qj+sKo9OYkd1y/wqIhAW6sS/1TlydJ652N6/3PTAd7lQiQrioSBSh2IIFryljBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neZfa0q3/jrp28AsN65QXjOl+8w+90Aqv7k3qHVq5/o=;
 b=3JdysnmBVRgryMVKxjjXZWN/AirFHXBEJFqKJaFRgFsF2BfMC5CDOACb+UM2UzataDI1oBVOLPfJIbY+vaqOex7OEuuRY4OITaOjbhiLBrUCrtDpxFpVvgM34wbtXklUyZ+NZFD1f5fFixQx8FF2PGQ8A8oZULHA6ZQlw3iiptI=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 12:21:16 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 12:21:16 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH v2 10/14] drm/amdgpu/mes: defer unmap notifications across
 GPU reset
Thread-Topic: [PATCH v2 10/14] drm/amdgpu/mes: defer unmap notifications
 across GPU reset
Thread-Index: AQHdT8VDJ3vfxC6S+0yNMOu3fX+BrLbzng+w
Date: Thu, 8 Oct 2026 12:21:16 +0000
Message-ID: <PH7PR12MB600054CB05DB9A4DA2945E9CFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-10-Prike.Liang@amd.com>
In-Reply-To: <20260929034650.2393125-10-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-08T12:16:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|SN7PR12MB6862:EE_
x-ms-office365-filtering-correlation-id: 906673dc-23d0-43c8-f13a-08df2536a6ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|10067099003|4143699003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: Lp5ZLdvHNr1ETW3e2USQD6ojNWLpmwAKUSquhO21WqPp7QZ3PaMq//QGzM3wWJxyUZfopLiw/DKKd1y7xTw2QN/WS0iTBCfrGRWezhFXBhQ6bJtEDbf1cDEuWavOgpsdFHJ4YhxCFr/3pd3fU0wDevLNcULXsgmGiSPeif6nE5bQUcerYN5vSzGcGWk4NC9ogqabd8Wqq3UFbdV+oTzDKS3ztJQfcNkPVp1HTeFoyTTArLQhhm3LPTpuGd+sQ8WxRfd+LYeBVXW7+H4QXwRB9ZyeElHq3hk+0fqHehsGo4LdV4WCFy1U0TlQzSMCFRyt2ktUkZsRa+yREfxnVi1mJ7IFzzL57LZwPZfO3Lrw2GrJ+Cttlvzqvj4KQp/6Cfjt0b5Al3dJQ4XLDu68EdTDyqUqFM0yLoytjfhED+HjyyiO9YzvhaKSHnjhnotoaoPgacx1g4FZQAJ/3CMYnOkdPFA7ZnBFrzcwugqvYNzSE6KPL1+gcKFvjDlyzDtmLlBccxHfzapBSFmG+4wCSB7a1tEOZmFwKB4+9bGSWapeOKC5eMfRh+Gsj56nbCX7vRYOL3RcdSjYEqsO7+biK93FcJB62ZKCZU+gQagofYH7l1DBUoHNjbnFq2M5q5kbfwzi492bwewQpYwLKhZeJk+VG/RH9l5BbWA4fwHoVi4a13Uxpxm8+WXZuWjdcuaPZ9oO534TsABLEQQpnBx6XhOg4iK1TEVVftRwQ5PzegST+J8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V71CF+Uflqo2T6FckB+SoVGHnicZwcvRagJZ8HWTy7hupswPMsq3bPf6OrVn?=
 =?us-ascii?Q?9MBuCuhqYW6ix2INjGVrsGfmArNEoo8idEnUCgGRPcVe01wRDY2XuahzVuHb?=
 =?us-ascii?Q?8HlpO7VOPsmGUIazQqwZ3TvxpK3F1BoElgG5a7QCUQNvAOZNyPqch0Lmv/VI?=
 =?us-ascii?Q?VxydZXqE1Nt+6NPGxMICJ2d6eV2rnU4nvL/zXbvrPrTlq3xe9cY2NzkLrdgm?=
 =?us-ascii?Q?gka16561eqlmMPfOL409ZrPa53jNjOS3qbr9PgcLqOcsvYXRqrnQOXoydEz3?=
 =?us-ascii?Q?vO+adjqOcb5LKx+L39zYiQpjqsM1TNHBwlk6tjtOfbTrerfxJ8vBcko1GDl1?=
 =?us-ascii?Q?xyWl+9U2CuJO8Oj96zhUAj42MVblR9YSkUoYRfezo4KTcmmD13i7jmP1G0oW?=
 =?us-ascii?Q?hwlUH4WIcipZqilO6pQci3hgP9dXUv+GwLBWUQuCblhGq/evXIpFgBY8nAZr?=
 =?us-ascii?Q?ODqDLqExJTH/aYaGJm+uBrD3Ivs3qa7D6wahtA9RozrzxM0rZG1FAtKaQqLu?=
 =?us-ascii?Q?4oTB7i04OXY8TiH/GMPeivTWD+ATHs0Yy4ZO2L5kzr5dH+DD5IdB5mJQmK1/?=
 =?us-ascii?Q?CbJZcI4WD3yCx1YQMG7020jF1CQVfdd/jXVH05Cql+SECMzJwAl11zK35L3i?=
 =?us-ascii?Q?/sEl9jyZTb3FZVXBov2AQ7zDzdlGOOR+AClEkUdbz4dzHFRZAhtUIaG3Nk7T?=
 =?us-ascii?Q?9a5O9fe7v2zpMr7F4B138A7eCO52wpPOdPdbf3S2ZN9TRuj7Rc+WF7JTIJkS?=
 =?us-ascii?Q?LV6/9NEik1EDeew4iq0I7idVwUpxzsszvd/1iex/q9e7uynC5UGxwk3HMBbT?=
 =?us-ascii?Q?r4ktGTuZ/capiJNtr+a+eveYr6QqmMQlyxQatHIPJ3FqKmG9iPWCWRMGR6rC?=
 =?us-ascii?Q?tAO/0vfP9WI87Fv+nifo6+CyUMPO/piaOL2/WSFIFM6KGzF2T6aM9azCZ3UW?=
 =?us-ascii?Q?JNedVKHj0p3OkSoL7C8gjP+dgBVGRWId9zc2qod6wcn2414N/wna6+nqGkQx?=
 =?us-ascii?Q?6gWAbvM9+UZIaIWcbVhj89SaLlvzHNOVk8piohK38NP+OOA3FapbY7/0YSLo?=
 =?us-ascii?Q?LaFymggtQfbRdFQbzbKLCTX+Gx92xQjhSEGdFbPYbLUGiY8J9kwgUYx5K3et?=
 =?us-ascii?Q?/JF9JySWxMkCPC9DoF7eQAZz2uoY+pekKZ/fuY94RYNSb4o9LvinvXxLJrPS?=
 =?us-ascii?Q?mMbMfWZH1GsVzOGTaQDFs78JWfVi9EbbBrDvkaIcgwYsT0trFjpahlFAremu?=
 =?us-ascii?Q?X/W/h9sb76aK8u/4/+OI/qGQ9C+nf0MpEtFzuHCyKjq/SAZCsK3+qY9t91JM?=
 =?us-ascii?Q?6pbvap28ejd6rXq7ri67ivxANRuqtsM04LKOGuCzFmwtupoq3s0niI0eantY?=
 =?us-ascii?Q?zpljc2IR4fUoXXtU/gUYV7FIwxLYV0JbsiHjtGRSpnEDG69PhQRWdF+x391M?=
 =?us-ascii?Q?yKA8E9j2hdco1pn7DKo6ONgQSeZp4KoITK3uJKZmBx37nIfn9MqPKStP/WYB?=
 =?us-ascii?Q?yid001mn4NAsIGtOirD02bcmTTkVw5c4guMfh+sBLOjf/h6acoj0Hpl3IgSC?=
 =?us-ascii?Q?7zP3r7ceV8rPPbVOHmd7X52pnbHYqEgtdXqgdZiRjWpR6FB0EA7Q5Z70mbXF?=
 =?us-ascii?Q?+pnchGBl8Ie+nBHvPJ+ETaglFH1DVVBhqoJEuCz3pzyCPSdDR8FvBW+o9xtI?=
 =?us-ascii?Q?8GvQ7MGzYLGoD0utRFU28b8NlEKJxFOSzXYv0DLKSeDv8E66?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906673dc-23d0-43c8-f13a-08df2536a6ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 12:21:16.6507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1ZqFYxJDlMzBTrmI55EilGHuuXbapS5J1JHpq3pFiDMMef3z39CvYtLL18+7bP6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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

This will keep the MES unmap notify sent out of a GPU recovery, which make =
sure an available MES for serving the unmap notify request.

Ping. Any comments on this patch? Reviews are appreciated.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Prike =
Liang
> Sent: Tuesday, September 29, 2026 11:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Lia=
ng,
> Prike <Prike.Liang@amd.com>
> Subject: [PATCH v2 10/14] drm/amdgpu/mes: defer unmap notifications acros=
s GPU
> reset
>
> Acquire the reset-domain semaphore for read with a trylock before sending=
 the MES
> unmap notification. If recovery owns it, skip the hardware access but ret=
ain the
> periodic rearm while queues remain oversubscribed.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 4cb37cdbf821..4138080edbea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1192,7 +1192,11 @@ static void
> amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
>                                              userq_notify_unmap_work.work=
);
>       struct amdgpu_device *adev =3D mes->adev;
>
> -     amdgpu_mes_notify_unmap_queue(adev);
> +     /* Do not block reset-time cancellation or lose the periodic retry.=
 */
> +     if (down_read_trylock(&adev->reset_domain->sem)) {
> +             amdgpu_mes_notify_unmap_queue(adev);
> +             up_read(&adev->reset_domain->sem);
> +     }
>
>       /* Re-arm if still oversubscribed */
>       if (atomic_read(&mes->userq_hw_queue_count) >
> --
> 2.34.1

