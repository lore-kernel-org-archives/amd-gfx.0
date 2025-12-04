Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267EFD1F9B4
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 10:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E1D10E918;
	Thu,  4 Dec 2025 10:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1gOU+TdT";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B094D10E918
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 10:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSgLrOPyPqMmZyVH+qxHYEZfCCPcumBy5wzKJVIC2ulKpa/KIt+0OPuirfcMgV7OcQgK08rYsBFmPosJXOxIGfHLm3PKhEHXaq+WrNHnksUzLbow2rpgTKRzc4PlMVmKCf15yXgy0cJ2ycCCOXbZCWnn4lB020Cojak3JqU6eS6z2d60Zm3295HedBHB5M/bg7huhtBHUqmYGFNHHCzoKuejPqTpFEkukyvC349Quz1z1BtMfGSb9VFCpPTO6ru0xutbdi5NzA3tpmtEcHXQk7E3Ut5zfCSmpxt2tMFcZ/IYqCMpfrH7j+yhMtBdXI4+da+dS3fLOnoFJrTP/BITag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAaQiW6bBWmTvOE+tPzB0xwP2codXlZHMuJvwhtU5ew=;
 b=OSwA++ba37D0iTBbEW3EOyYYG4GSv7pYwhcuiivfV6FHJ8MJ6qiN0THzvkIP1svc8ExO7eqwakErRmE62go/Y8onQ84Ja5csPDWqseDiI05A94/NhJ0zHjN0nCzpk+b35FU4W24U8YX0DJHCATA1C5klLexKYjaiuvc+9xfDUlVpt3ukMIehZvUYe++eObiDoswNBu4EMDf/XZ1ZnWGG0gU7zQPClCFUGrNiU7dRhiyzKyrycvXZSEVspanb1rLF7U3WiX2aJY06434YozXw32YZzTKLP4aBUQCeHznADpTa6KEaewRKLzcycP1MgC5vyeH6KXHJsssPRXXB+qkMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAaQiW6bBWmTvOE+tPzB0xwP2codXlZHMuJvwhtU5ew=;
 b=1gOU+TdTzlq7sIQNCASmuP0Q3pg3PoT0c8goljBloAxe9+2iLD8vB52mxYTlaf7Ike9fzdagfhiOvGKRbo8Q7Jhi8tKiR90W6dNQsgCalPn2p5W2T/e5IgxZ6vIKVs3eJrgyr1BzbnmI1iZYHIQJlItb3COqHCpL6doTnUzcY/c=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 10:45:48 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 10:45:47 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine memory usage for ras
Thread-Topic: [PATCH] drm/amdgpu: refine memory usage for ras
Thread-Index: AQHcZQkD47vR9+ZrWkyyTkXZbBCBXbURSFvQ
Date: Thu, 4 Dec 2025 10:45:47 +0000
Message-ID: <PH7PR12MB7988E3CEF7B019A68B9B23039AA6A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20251204102951.26278-1-ganglxie@amd.com>
In-Reply-To: <20251204102951.26278-1-ganglxie@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-04T10:31:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|DS0PR12MB8455:EE_
x-ms-office365-filtering-correlation-id: 970d39d2-074e-4065-90ca-08de332248b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?01QhRi5urmhx1RGNaSQgjYnVx7AtmTcqB4Bnox5B+TPyENwiNUIq6nqgnNKN?=
 =?us-ascii?Q?OV84tw6x5Z8gLNNiWSiUr+93xDuWgCzF47Ex7gPgHd3z7EAtUoWQNdh23KDz?=
 =?us-ascii?Q?TOUaZS89Vazs3RRUHyXOFmEeBv7A2gYR+u/PRwokra5/dnByyLg22Pi/osar?=
 =?us-ascii?Q?poB2hwt7ScTXC38KFuPT17dMqrycr+yCNwsKFJB75xFvUHw9YghebaJPG90P?=
 =?us-ascii?Q?+gfbIJBo8B6tMv+GyvyhB7SH0yCMtMgJ2fVAIuY+pOA7lHDkYKfZaB3rb/R8?=
 =?us-ascii?Q?3Ryaqm8rX5QRZqhuKRMnsNffj3SGaxtC9Kw+QjehVtqyEzmm08s3el95JH/1?=
 =?us-ascii?Q?b5oAPgOml1dpEnKDpcIQRuDgTjl/ZFFbsl027KT21nyjelWNDWn0M21r95Y9?=
 =?us-ascii?Q?eA9Avah3mb9SRRoyZtu97SOKPdRbb68hI/g0ZTQRnz3g0EedipcS7CgmpF+z?=
 =?us-ascii?Q?dTglYSXKl64xUgNrcx3ML1Lysy0kPqkipBV/SzN7KBK+SjhtTIoTNkkjQw5z?=
 =?us-ascii?Q?ue3+BRx5WroWsFdP2tzkPC8XkPd13SvzWSyTOPFHQSORLaWvvHxoVgCRh5VQ?=
 =?us-ascii?Q?RNdSFEz2+4dsVbOkKVt/Z5fNtImkqKAnapa1JRvZWYTSsXqC93DsuB1U1Ybe?=
 =?us-ascii?Q?RUTvRJxd/e643WkZ9GrX8wypc7ChdUR07zMKAaKfzllN2gy2YRIwb3GLyz2E?=
 =?us-ascii?Q?4grU8G6oyYXpeeuXLx0AZ5GCeXj03JV2vVf9rpmaWRSunDNVXmCzVX67Nx8l?=
 =?us-ascii?Q?4FBZWX3x827MJpG2Xn5lUTegU/USXEEOT+80oE5t7SeWbTSC80i3rTyUVyEy?=
 =?us-ascii?Q?m88JgAnDJb/uy48HoPBh5rYgn+3cbnfArxeuUucl80wcp6y4H4hzrhKLd4y+?=
 =?us-ascii?Q?AZcHpmEL9rxW8Ner8irrbiXGVryNWs7cH3eSaYH/NnxmFR+goci6HqOVI5f5?=
 =?us-ascii?Q?bgw4065CHLs8PI/Um2fmftLPVA20tYUaLd9j8OWg+7PSgajLvWnMElmibLJU?=
 =?us-ascii?Q?fSYHalYJHf3vl7mjFJJxwAh1rQxVs89yNzDQ0Osy+OUqrVL15/F+NXDZo5D1?=
 =?us-ascii?Q?c5wCiYMXKoFObaMv2GPV6nZZsb+2c1xCttVqcaT4cTbfcPO8OOzausY47W8+?=
 =?us-ascii?Q?az9RT+7J58G4V1XmzMlhk8P/qH6tinBN8SSUTg15VU/cY2wqzMI0gwKmcuQN?=
 =?us-ascii?Q?N0tagcrTlIrXMu50VP4feKuWM6Hs+TO1T6n6eEYFlBupWZyfI4dCcJ/leVA8?=
 =?us-ascii?Q?k51CjprGYUuLWlNTOTNTe3+u5lBjmAmvdx5EOd+S5F8mAuTACt4rs8NE444U?=
 =?us-ascii?Q?Puwp0pleR+iLUAHroJAa3Mi3IVEAGZMGX2ZSrg0N0LKuDQmIgt4TueOWJMDI?=
 =?us-ascii?Q?ip920N/ADfPUDF1R3mu3piIB3vNsP6BnFMox+OVOPvRh0hftp10MxZXn+KVc?=
 =?us-ascii?Q?ieJuzG+FRWaJ32unzf3eMGiQplUfoGacWj+XNmLE8KWoHR/GcaJk/r2wjDHx?=
 =?us-ascii?Q?tZuLQ+49BXzAY1eiHgsUKfX2886f4GloDbJj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M7m8t9/H6UEorDSpVSjnOCKLwQL8vKgdTdDWvZroALWPmqWb1x7ZumknwZKV?=
 =?us-ascii?Q?ms11vZt7tXvoZAAtPREtj6MaHCsO+A2wPhyorzBf5s7Y32HtPrg0Bl1iXXIr?=
 =?us-ascii?Q?+vhAnQnRIE+98UriZICui7dnAY4nAsRW9QlYig5Zw03Xhf1ZSU3JneiQB4UX?=
 =?us-ascii?Q?QqednN60apbgApCYdlGw1CrHBVSB+D0stfg98Ck2rxu0EXKraYOoscEwGBQu?=
 =?us-ascii?Q?s6Ik2F3PaKKwYzpVxCQdjL0y+CP3lem9rRGglTIZV95KTNb2YU622cWYSv/E?=
 =?us-ascii?Q?hI67/HJRuSL+MDQ71vzFFxRxdL2E3kT7fIWV3ymlxHXXn5M4Dpo1RB3gEyJV?=
 =?us-ascii?Q?NWs0esVg8PjShoN6Cv+ZbXeUhVGopg3lUqxt+cypnIVPQ/JlTS/3Xmi9POgB?=
 =?us-ascii?Q?losT7P3/LAKPPDLYnLSrNI8zLJfaH79dY48t6ccDh5FNXWOtoJk0FjTvBcXv?=
 =?us-ascii?Q?+IMmuaN1oeIY1JEghjD7TfmSJxzEL1pNtNN/0P8WYUptVFDvJ5jiA2FFfzjB?=
 =?us-ascii?Q?hfrlW+25QkkPG5pn/4q6nPVWnpWn404uMDXRiG8E/TRGAakNr51bK0eW5MzD?=
 =?us-ascii?Q?3CQlfLtj1N2ngvebi/+6DpPyCDyrU68HcKFVeWHLXI/EOgSEu8kiiT1JdfcC?=
 =?us-ascii?Q?GNoIAZ+1CAjg0UV3Q9AxdvoRVO/55rVfvQ8VpxZW4iDP1OjZkIBzdgw1jEML?=
 =?us-ascii?Q?N+lRs9IIJZ8VxPpAnN9Oi505zzm26BTm8/lP0t4eF2dFeHB+0P2NNGiXLdoz?=
 =?us-ascii?Q?OE172v13Zy0pLf04pQ68R6sUKCNvtLadJ9qJT7SE0PlJt6uAeIHkq7Q2sfqz?=
 =?us-ascii?Q?ZvM3ge7x7k2uF6bS7Iel9q4DXmRPuS3u7NPfv36ISwEoOeLM+OoMYrjkpXu2?=
 =?us-ascii?Q?I7cqCFcbyei5EBCKGxQYPEiDT/4TsHT8IfG7xr3wkFuxTexJp4eDsFgMELoi?=
 =?us-ascii?Q?1lXWZ63WxqE8953OSEf2enXJpg6N6SYvEutm9CtMnsiYMVhK4b+jbPeeeovp?=
 =?us-ascii?Q?AMLcEtSIz3dEP7cAOs6FkCA8Zt6Dw6212+0R2IHitbICxHj4LZzv38HOg03N?=
 =?us-ascii?Q?4IyXYpgMOc5FvB8y2N/qp7m+DSMHHyrxHvqn/mKnEBAL07jMzX4LzKS52qJO?=
 =?us-ascii?Q?BgVV2WtLZgJgVwRnOBsCD7AlUODKcnkm+crRPS8J/b+VwYXzKZUK7DbAuT0Q?=
 =?us-ascii?Q?bt1xJVWzmOYnL4aihmEIaCT6+r6/z6S7RYumFo7wx97bkwnzNnMCfZfFYSbf?=
 =?us-ascii?Q?5l52aoFx8l0NIoeiikZvH4kuxNG82RT5o1Z1yXhjTN6TObynznjl3rogaR0+?=
 =?us-ascii?Q?eTvufZBpMxJQICS4RIq01ST6cJMlE3PeM7msKY92baXQeYM4iK/41mi/sPzY?=
 =?us-ascii?Q?z4UCKTKGnacwnpd/lhKhv0XAJdQYijFt4fIonLUXnGufSRm5UaEUVis+Bace?=
 =?us-ascii?Q?ngCNGW4dVMGYg/SUR9mefUQsgnv0tHQTNC9uGOm4mn9VKOZbllvnnpOSFkoq?=
 =?us-ascii?Q?DD0aGx3gMXd4WIk763RCyUuOtzYQPo35CsJ6rgfIyJy1SSYnbSemWj2nqjsg?=
 =?us-ascii?Q?OSgSvw6xNTie/9JaYjE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970d39d2-074e-4065-90ca-08de332248b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 10:45:47.4562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SnAJM7O6yoKrzvd/g63sgVSP5acyuvz7A2QxXsyHpdiYO4YBWT4GFdQJ2d5p7YDp0rdT8ZUl2XGsb8iu47uSvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Thursday, December 4, 2025 6:30 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: refine memory usage for ras
>
> check and extend record memory before use, clear record memory after
> allocation
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 00f890bbe912..c933ac1d6c83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3001,6 +3001,7 @@ static int
> amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
>       }
>
>       if (data->bps) {
> +             memset(bps, 0, align_space);
>               memcpy(bps, data->bps,
>                               data->count * sizeof(*data->bps));
>               kfree(data->bps);
> @@ -3090,6 +3091,11 @@ static int
> __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
>       struct ras_err_handler_data *data =3D con->eh_data;
>
>       for (j =3D 0; j < count; j++) {
> +             if (!data->space_left &&
> +                 amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
> +                     return -ENOMEM;
> +             }
> +
>               if (amdgpu_ras_check_bad_page_unlock(con,
>                       bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
>                       data->count++;
> @@ -3097,11 +3103,6 @@ static int
> __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
>                       continue;
>               }
>
> -             if (!data->space_left &&
> -                 amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
> -                     return -ENOMEM;
> -             }
> -
>               amdgpu_ras_reserve_page(adev, bps[j].retired_page);
>
>               memcpy(&data->bps[data->count], &(bps[j]),
> --
> 2.34.1

