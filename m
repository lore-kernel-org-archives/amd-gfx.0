Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9F8C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 11:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B110310E9E6;
	Fri, 28 Mar 2025 11:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lo5Qqwp0";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C6710E9E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 11:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ok3GU98B0vHTKUYgIKaIqgSux3vBzaeQ/EA099bL1i4NKS5P3AulmF9vctHZrdMdz1ziot73c0SsNutPmK4b2R7/B/n91LmNppW6k/pyN+71O/4M97XoxOuwtBFfljMSUMYA+qZF1g8C/SKYv5SUD5mRIrOQIc/d0R6dXBGxvXy3YU3y3ZLReJ773fAfXfiVRGxh1L+7D9KRXp4H0fLU0hM6HcS1ood/doEOT0QJnu/92IIsWVy7KJJpzdeUtlUqa5Y0Hn3c4Tr6ce65kDeZGY+z9ciDlEjUmyeLbiFFm0bVAvd8Arlp++6kvWu261bB8YhnQvHoyhP2D28GvjZ9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AaWALzV9qrDux6NC2bxfkKOaPvELPkAs89nIQyPvhE=;
 b=WFRi6anTXpUJ5FUi68ZwgVXnEwF6z64zsJoIB2t/3CnDhB0Z8kHA6G9SB+/lFJZ/qvJutBtuSLYJEUY1NC/QBg2ie5qa/LNNTNcUETupzz+u8/gXJan3kIAeEj6j18C5o+5EyGeljcAZioaOtW3l7KtORKMertXvvku4s3aekETOylAk5cJFSSjlNNJevI13/nHtavVlELheqHMeByAGRWqZmlKm2pJyowLkF/HQqCAI1fNG0GPh9oVS46ytfvABa8kDXAmDJk3mOSEaHzSrLQaXA+7IAavKi2CmNgflWQEyN0uladsKD13W2kVPaE/m3KdfkbulPEMh48EVmboTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AaWALzV9qrDux6NC2bxfkKOaPvELPkAs89nIQyPvhE=;
 b=lo5Qqwp0FAlYvwitioAa9E+CFyaoVyXmHszNzZsO3tabobgyOsmvw5ByZ18ejMzlwWVar5tV1RQzGH4ACWGtao+Uec3OjB/DTbjpfMPJPeShbD+w5T9hta8a7Iq++w1wBwXEsCzUdR7b0eQrfuQjzuynoQ879CBd0vRHt6qz/kM=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 11:41:49 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.048; Fri, 28 Mar 2025
 11:41:49 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove the duplicated mes queue deactivation
 setting
Thread-Topic: [PATCH] drm/amdgpu: remove the duplicated mes queue deactivation
 setting
Thread-Index: AQHbn86oOS7vxMdRKU2U+1SfyDGnDrOIbEcw
Date: Fri, 28 Mar 2025 11:41:48 +0000
Message-ID: <DS7PR12MB6005E2A098FC4FDBFFA809A8FBA02@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250328104611.1763032-1-Prike.Liang@amd.com>
In-Reply-To: <20250328104611.1763032-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=bd46aeae-571e-4357-b74f-4df91f03bc2d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-28T11:38:48Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ1PR12MB6193:EE_
x-ms-office365-filtering-correlation-id: a814f33b-52e5-4f61-bd1f-08dd6ded8699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lyINIx2kDwq6EEGWIVwwxaHB4gnTRrcQr2jW7WnSuvNoTUXpp8jGPTkkjtu9?=
 =?us-ascii?Q?JKJViypMVxf+KLnje48maVSWFYTz8bvZzkBVRh+RCd9X3IecBCm5FQ9MN39j?=
 =?us-ascii?Q?QVkSOdl6il1kIS60/uZBXm76UwJ2UKPgu1RBZDCUZfIitzCDO7HoRgS561KN?=
 =?us-ascii?Q?qv3VPJ6u9kL0/w0xDZLo2nbyISo3qTKP4/k6ItMlV+LUd5NK0GWvmH2d3Swq?=
 =?us-ascii?Q?5hBqaSSbNhe5zqEcM6TJOVmbUlTXeGGxBtozZgIL9+2OoDRyIjj6+7aP3ze1?=
 =?us-ascii?Q?y+dG046eTxzs8cFv1vAWSNHtAfYY3o8eub2Si+2rCuEmH1HYo4Ijg/ZzgbfA?=
 =?us-ascii?Q?jWNuq8Y7BsAjuFKU4q9g2kzpPQiWxdPKgUQlYHyWyYcMXp3X4k8pDmYpEEP0?=
 =?us-ascii?Q?xBlR12bN3XANd2u7XJoXla+qpT/Lf3w/oFv9lpapHssSwq7v5oUS5fnXE0O5?=
 =?us-ascii?Q?QbCDD66Thzxsb0ChC4XDcMfsOoJ7ZVeS8GauRB1mCmjyBfunjWjXG6sBVpGj?=
 =?us-ascii?Q?wuZyT+GJ2dyHws7wOaqvwglfAbGuaFwBK5zQ6ptaEhy98pW8asanrWsWe+hX?=
 =?us-ascii?Q?9FbvY4Ry/WTjWAjcPkjj3frj5dfZZSUmHfEcuGPCSb0HZZK/pQUYabPZsHsS?=
 =?us-ascii?Q?xoms/2I9h//Z1JUfjLMv5Jtw8CeqhxVJ3VWws+PFsQZ2HpFDVIE7o63nGwAY?=
 =?us-ascii?Q?MfDflPGzL6CyQM9a1pW8GXeg1aWSEeOIFjO9FKYxoSZrmdUSVA5kDwjWhxrF?=
 =?us-ascii?Q?5PnzouNL/WuKRkE1y28O6KucU022pFZReyJt6KxjS1wxXE+YS2u0q2GuzjvF?=
 =?us-ascii?Q?YyNbydMhRZrktDkOtmKb+hwGSEEMKWkvaDfBx8XaCtGz8na3EvEUjCqH9kwo?=
 =?us-ascii?Q?tHw4LrsNPCpZZkYf9Q8y3nouvWzfb33QplZUC+74MQZdDUoT/8vtU/NH4MZl?=
 =?us-ascii?Q?pVaFwEiUHwXs9phgC8mKrbhNBKtYzU+wFisCzRCR+IT9uMThAUBczytfvuJb?=
 =?us-ascii?Q?zK7evEgOhUDigZ5ogJ64i+/hImQjp7mEJMs2MhnNiQv0Oq9yBgdfPppQaJNv?=
 =?us-ascii?Q?3qnV2WY6R11l/Y5Qtem7HKp7O78xeOppGUcd+itNe57iG8+oXpftKHtw2uhp?=
 =?us-ascii?Q?MMDnzSV4sZbZxRpEQJjXRC6Fx0iEXph+GAt+X1RhZUkzU1j2DmWTOHclvMEe?=
 =?us-ascii?Q?Qbr/D4S0IsnQ75x/wlq6IfEYYwUEOhGTrqTDdDqd1yTPBCvYVpqEnzt7jhAu?=
 =?us-ascii?Q?+6M6cq8ZADsK/EZ+ffXOsMfLxWz0a5W2l5th3ig2PBP30AZ1afTu8DjIJ9Gd?=
 =?us-ascii?Q?Ofis51NT3kgFvuE8MN+xBJbvZsULDUp+uXT6dm3sOUnvT/nHKZ4sK9Ff5F8r?=
 =?us-ascii?Q?Gy065zmryPetJBG7wF1255ImwWyiAhlhOLef3tEe5pf4tKmtn6s+56QrMF4f?=
 =?us-ascii?Q?0Ey3fJ8ZA/Xy55aKTMgp+9fThZrZLpoT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ps0sYIeP3hXCzlTkBWrVvbCeSxEZJGGdYkE/XF6lqdjbMgP8FqaJ+AMzUHmF?=
 =?us-ascii?Q?6CC0ezUB0ZZFQ8+pcY/XkffLT52f2Udq77rDGkTP7Stbqpcyu3EDW7+g0zgk?=
 =?us-ascii?Q?8w6vWAWFMWtsAOcC9Jg0XIjSalExcPJUEXRvG9ASRljfDVvjtxLexgVzR/ox?=
 =?us-ascii?Q?lE18ch+Pu6m9xQPRvfCC0HpUswGJS3cBtiDsxJQ8dKANa8aYKj+NzEHK6KSL?=
 =?us-ascii?Q?bqVZzrakMT6jeckM+ySPV4fvvWso3O1phVtEtRRzwT7im7pH/mgwG9Q3BljI?=
 =?us-ascii?Q?Z9k+rqFjK2svubalYqMSIdwkSTh7cJrvC//r/i+1yDCCOXXHZ3x001vpOEaS?=
 =?us-ascii?Q?DS7nFGlA/ILSLYaDbe6sQHf4tHziR6hRjUg3D4UjSDl0GXVurNyavm5rt95p?=
 =?us-ascii?Q?GNdpxZrfQRUyeqZDHgOqPy+gZmqkZ8DQPPE/W3NYD15q1m8YzLGwNoSnNe2W?=
 =?us-ascii?Q?GDts0dCbNejLAMoUcE1qeiWT69gnrgiw+TEhYNuH18J+1FO6hgTtOu1KiBny?=
 =?us-ascii?Q?gHVYHGrjLG61HKi9QoljPJY1OJpvqVPqWreDs65XGdR+rsoQQYjwV7z1GOFG?=
 =?us-ascii?Q?i5pRE0qDHFQO+FG6h/cresojxUp6HsD3xz2RvBgUU0UoZFJvu4qCvzcIFx1i?=
 =?us-ascii?Q?eRa7obiVsjuoQpkqIJP9+jsVyjsVTiIz4LnlGN982sMlH3abB02xLdTH+Ts9?=
 =?us-ascii?Q?sXHZaDTXPgrBJJyLtxTSHAMnEiyqsrg793m9u/cooteOgskG5xCLhSj9tXK8?=
 =?us-ascii?Q?Pw4r36mAqKp3ZbOi9PXbnelX00+tPNPeiBk/+zfos/Dn0Owz6AxG079wCwQQ?=
 =?us-ascii?Q?qFXH2/hFotvmxeuW6WKTM6YLR9nor+p1PZAYj52mHfdC/zzhUzNiJnEf3vN5?=
 =?us-ascii?Q?fHj0Vbts71iatY0aOV5mknh3f8eS043TxhJTLpU8gOPMMivn/B6Fdx8lE518?=
 =?us-ascii?Q?jNwl7HlI6e/RiO3tpgHaB7n3EG5ZChSpQuhsUff1zfSVvhP3xUSwhCG3J2cY?=
 =?us-ascii?Q?QyCgqDsv5wSYfWRNVncnAHijjvd+O5/l9pqdiacR1CzA4Bp9EgPaG39+ibXX?=
 =?us-ascii?Q?96SmcV8gd1YkNUnzfQhSXDANiBiQQD588sewwhIjiAN3EL6DdYBBeAPqd7Gn?=
 =?us-ascii?Q?A+fuYqolv7st7wng4KESxvAozx+NKfG4Y718CpdXTteVU3dzjoSAoZI1cBzW?=
 =?us-ascii?Q?NKRVG33VlK5Bug1ppPoZEHv7+Bg3vhMPpeILUpgnYId3EaE4gR+avMCmtL6i?=
 =?us-ascii?Q?X13tZ3gXjPrwKR2/Y4ld9UOBYbdqVbmq61wR7p/nneZwwKeOuKfmJGhC2tYl?=
 =?us-ascii?Q?EP+q7KylxXyayzS7/2deyL+3UHG7V4UK2iZucxlz2mp3hSCHbCHHYER4pwtD?=
 =?us-ascii?Q?g7k8VEYRnOCPD8bXKb06E4spXCoKjINsivDt1rchpUQcoRXjT8lLcDoCmSkq?=
 =?us-ascii?Q?cYa0e6ygSPucZoUQHn+ZCx+ubSDMNKnOwC+146oh/lhnBUuckdEvleIKSKyC?=
 =?us-ascii?Q?ld7PyA2hP6PHVrrhTBe0mgmCSRodM0A1SP/obT0KJJv0+arVTE+QQsent6YC?=
 =?us-ascii?Q?Nh5yW7j6CxIsu0gMdoQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a814f33b-52e5-4f61-bd1f-08dd6ded8699
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 11:41:48.8839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XMqrVsMGr7YYrmClS0LSyKPwvMezqRtNei/9unj2sUFfXZWiJKg0CbekcRDNbZ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193
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

There requires a similar change on the userq resume, and a new patch will i=
nclude the change.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, March 28, 2025 6:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: remove the duplicated mes queue deactivation
> setting
>
> The MES queue deactivation status is already set in mes_userq_unmap(), so=
 the
> caller needn't set the queue_active bit again.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index b469b800119f..3669934e6e17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -358,10 +358,8 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr
> *uq_mgr,  static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
>                                  struct amdgpu_usermode_queue *queue)  {
> -     if (queue->queue_active) {
> +     if (queue->queue_active)
>               mes_userq_unmap(uq_mgr, queue);
> -             queue->queue_active =3D false;
> -     }
>
>       return 0;
>  }
> --
> 2.34.1

