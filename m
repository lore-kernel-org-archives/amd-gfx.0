Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3D4CA600C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 13:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B7410E0B5;
	Thu,  8 Oct 2026 13:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cG+ik8L4";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010022.outbound.protection.outlook.com
 [52.101.193.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A281310E0B5
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 13:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq6fcoMHF4YnRfkdrL2g5cKRD0AFR5mCFaA/EyLU3NM+R7UWtKlHzlbuOap2WJRT7VQg+Mn6sk1KmMjFjiP9g9uhXfA3lSCPI2PvcVx3ZeZYwPU101tCd3Kt81eYLFpwF/wwuvcazwv3SLiItltET7YCUGuc+SUPNiqxFtT+jn/cYMhGpBYn7ypWC1amm/SB+cuDKupZZYGt1ceXza0zVeml317b5r/8IImq8qHGTLCnpcLyhiljGqkO6gbJkHk9CGnhvVyE127zsABsZ99BVTI/UvrHEJ2LnLLCZ0tHUrJwFeU4pdfO/E8ECxZicm4EoA1FB2LwiVvrI9qIp68rFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh3Zvwc4epb5OKZVKP+oUPAdDScicRpOb4GugmhKjqs=;
 b=lfS9dup01vSpUzwUPeiXYHjuKqScNA5pJE61ZG+/gOLDtHJNxwxV5pThknkqu3ebk0I7qR4NEyFTWQu7graHY/E3SKgCog/ZVme6GJDMN0mXbO8GCKMdBrjBNXSrbB/56TwULXXdbpuBuKSQLK+plnWuP4a5Osjup5qR8fu4tBJhuYLIW98zPwnmFSDCHHN9DBVwVDbyraSelLGHGawoD3vwcIf2AmQTb5kOlKRE4bR14ttobb0EVXx9JgDZfDM2nKod5Auqe3fqLG4gePyGaut8buj1JlwQh+UIs7NPSMyqxJFAncEpr+kssI9D1vyWEr5WHFv3u44X2Kua1lQenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh3Zvwc4epb5OKZVKP+oUPAdDScicRpOb4GugmhKjqs=;
 b=cG+ik8L4wP5qMmmJUYTocVqf5NQ69yytoIBw12vSZrGhHQrK69yTmmJptbChp3tbvMiKwy3wrJmrlG9HF9wC5hHJKLybTH2WIA0Y4uqa2o4xd+E8ZBL33Bof/95yiTEhiNxqubhCliT4BCck4KIvf6nAoTBKp9w1rno883DDcQs=
Received: from CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Thu, 8 Oct
 2026 13:28:42 +0000
Received: from CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55]) by CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 13:28:42 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Chen, Michael" <Michael.Chen@amd.com>
Subject: RE: [PATCH v2 06/14] drm/amdgpu/mes: move RS64 query buffer setup to
 software init
Thread-Topic: [PATCH v2 06/14] drm/amdgpu/mes: move RS64 query buffer setup to
 software init
Thread-Index: AQHdT8WIiXcYa0oVjUKcAYewPxlV2bbzogAAgAAQMvA=
Date: Thu, 8 Oct 2026 13:28:42 +0000
Message-ID: <CY3PR12MB963126CEC38797FE9C46E3D4F4932@CY3PR12MB9631.namprd12.prod.outlook.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-6-Prike.Liang@amd.com>
 <PH7PR12MB60004AE69B9978D2F8903769FB932@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB60004AE69B9978D2F8903769FB932@PH7PR12MB6000.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-08T12:29:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY3PR12MB9631:EE_|PH0PR12MB8824:EE_
x-ms-office365-filtering-correlation-id: c9138e4f-e84e-4ecd-1eed-08df25401244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|22082099003|18002099003|10067099003|56012099006|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info: Y6nNEtlvv9J4ARPT50CRouyCvcXHnTcUWVqQFAyMwzZoE6sjQ9w/bmlGdH7YZJO5cFxy3IGbZNOe696itNTvUqZWW3QBfT32mlraLLEYZTvQ8SQW20GE/WC5qgZJhVb2UJXz9JOR1O9HdBHLCnNcJrbPVSzV5L+GqxLQQMikhj3S6obGmhsKQt8dKkHpBU8OWkaRwcVEMx0T2dsnAuXOsBSBkoMzpgp8htpKiKCSDX48dthU4tLqbbC6zvINW885bM+ZCAekZ+hIqtxE93I0n4KLQ/Mv8Lrt9SFnA1DQsj550Wfbnsd+aRwew14SSeKXj0Xv5mZuLun5tr77yWQ8PaM1+aPqr8eN7POAjpnEfUKgsEkpSSYNvDGxHUt2NfuviHBZabBgDrPUJLbAbYiuB8A2rzZ6l9i53PUDkeM3pB+oCQoGLfWhZDOjdEKPs+JDItiT+M7zhUfXQDMUvRK27S2p7dXYs6kcBEW30nYd6/2RxY7xbjyHsH+k3jySkPkaNCKUGnDQBDD9G0DrBgKX3vMqmbM+k10Nj8xWkeb53Y98oQ/28tZRXiJNBv/Nzz5WK7XOcVLjo5Me2aygBUieOEeG2auIR1xZ8GegWht+EgmFSFLfSwgjAfN/wqoDsCO850MH+5A3+dAXV9ZC6Cy0SRE9EMS5sarnTplKY+dWtYj/AyWj/PeN767MqLG9rzYtOxzIDXixqevOC9WP/y6MfHBd5tY/fXiKG54lvcRFpoo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9631.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(38070700021)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p7sevCkunH5bUgJn6LbN0liL9xge7nQJmSL12yyxYyalBCWhj7MqKVyUPXRe?=
 =?us-ascii?Q?jKHIsgy3C4Ajti5M0ziXT2ejx+iSyFlZvoO6DiqyyVj2Cm/G5PvBxnh7G0zY?=
 =?us-ascii?Q?sj601ETbYMjRaR5z5KyGZIqdizduZe2uv+M2mfCT0NCXDCfRN+rKiSUKfEAl?=
 =?us-ascii?Q?aHs1khdfznOQSNNAvfyk7smdS+vNA8LK03BmueuAQKour6GBNlcwoL0xR96M?=
 =?us-ascii?Q?jzdDF+JFgnPjnZK2roXsQI9Tp2X1PQHJJIxVhoyef7lujUvccztAgEQAmNAo?=
 =?us-ascii?Q?aDK1ORg9ZypQwYSlwysQE95P2oFsd7rcgwA6VYMgPnD2mJfZGUqgNh+HjJD1?=
 =?us-ascii?Q?MtOyBBQdkuStdzHDmyagZl50MPuvDdT9OxbdQ5EeUeHDM3SWWJY8Noz4sOwS?=
 =?us-ascii?Q?sMq63jkK4pcwJs190xLiU7BhULGORebCa3UXs/o8lqaKVkXu1Zh3oPIHhQS5?=
 =?us-ascii?Q?Oz1zMGHyNWu9cL0eq8R9oh60KW/Box65l4MNtbY+WPX6HtaEuXK1DOQsGXw4?=
 =?us-ascii?Q?UsHZEho7WeaTaxsSr+QcLqLrYgl4+V+tnLJPs/6AeUprvOZeWgR982i9j1EK?=
 =?us-ascii?Q?oRgZlOyYyq1vReIcrrRw7aJOD3PzxDPlgTnNmevPGm+KKQQBKR0RlPHlA8X4?=
 =?us-ascii?Q?yup1qkKCjfKdg/EPTVLpA4j1sJ+PvwOg+SWdqweE687/E8rCcALU07nSQ20F?=
 =?us-ascii?Q?2SgZ7sSBTLZ6lnNIHqMfnFtudZWpb9wMSNjk6kal7TtoNrr0z2e4ph0IrLWp?=
 =?us-ascii?Q?Z+x/MJC2hh+X5xg5ugTQjrCUyAPf0lW53uZKKynzyu6Hhl3C9fd10FTMlDur?=
 =?us-ascii?Q?sSr59BfdgBR+4npcnqMwPVMKpSpbRU2Urge3ReeJdFTba14Tlwa9N6mm9+Yn?=
 =?us-ascii?Q?u7oDrLVFQyQwKh+1XznhkOdhblhuwwRZBmfuHyMRusYRUBy7wv3tC+NNhTx0?=
 =?us-ascii?Q?klqcGidQudsuTKgWH0Md8GcAH8JGSNiPnWpu+zfm3YnLHt6LpD1tG/hs2L2X?=
 =?us-ascii?Q?qJ1Rx6B0fs77wn37zzGJy9F/taY1Y3nKR3VBovY/yCZLds/2w6Q7KKn2NwTz?=
 =?us-ascii?Q?SDyQ6yOYjCLpoH0dzKCzM4K837ki1F6/kmrE/C9PBlRFVPoJHcirwVmt/lz3?=
 =?us-ascii?Q?ShxgeYQFlhwXlxuZtezlGJoIMQIpRnla3Q2Tv4DyguosKA64dq/RTUmAEscI?=
 =?us-ascii?Q?qObD5/g4WcsDPEkyDLzZ3ZY71bhsATmR+9tMjJ+3r13yk2lNVT+wZc3t0CDz?=
 =?us-ascii?Q?fTbEn4lUnrJfZCZy4qg+LuHLiVmPDyhhSV7tOi5lzLVSwczDs8rrPmWwwI8x?=
 =?us-ascii?Q?3Hbs1jq0feNr4QURmj5ysELvoLQehvL98R1fqbndnHeyeHts6eoij2Ddg5Gg?=
 =?us-ascii?Q?AvdCtYMUCPcnYqGNWXo+ny13mYyFZUlEJLA89REgTg+3u3F8hKr7k99jFn5p?=
 =?us-ascii?Q?U+9eL3EHtgDaObCNSM7BR9bNp+UoAl/ynDzrbwN30dKGMfa1qm/UPmsfs6bx?=
 =?us-ascii?Q?/RQVhwTsmyZl8as4YQAwoStJe03upVQHH9f6lgvWsKofeBKBcAI25QNvbVTo?=
 =?us-ascii?Q?yCyOgj0mAFq6J6EqFx5huBKlkXS0/OPt9WSrTF6wy+eOnAwb/XzJ4aH/9M0C?=
 =?us-ascii?Q?iShOLPonuBGfOG+a36un+oAl/v8fnMQE38y9CVORkl/paJnEqf/17dbPhayH?=
 =?us-ascii?Q?QPOov3mPMsSNC0802KuzIKbh487loZypZpB/tW3edUOcEIou?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9631.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9138e4f-e84e-4ecd-1eed-08df25401244
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 13:28:42.4380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTUXpvMNoCykpZ/XXlLrZm19lsfef1Np9dYdFRbQ6IpfsvQIIcrCE3H5lcvZpnPfirWib8bLyV1q8BhrI6RXcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824
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

Looks good to me .
You can add me as RB .

Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liang, P=
rike
Sent: Thursday, October 8, 2026 8:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Chen, Mich=
ael <Michael.Chen@amd.com>
Subject: RE: [PATCH v2 06/14] drm/amdgpu/mes: move RS64 query buffer setup =
to software init

AMD General

Ping, any comments?

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, September 29, 2026 11:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH v2 06/14] drm/amdgpu/mes: move RS64 query buffer setup
> to software init
>
> Place the RS64 context-size query buffer's allocation with software
> initialization, outside reset-time hardware initialization and its
> firmware locks. Hardware initialization only consumes the buffer.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 51bfb672bed7..2f62214ab24f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1746,6 +1746,7 @@ static int mes_v11_0_sw_init(struct
> amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int pipe, r, bo_size;
>
> +     adev->mes.use_rs64mem =3D false;
>       adev->mes.funcs =3D &mes_v11_0_funcs;
>       adev->mes.kiq_hw_init =3D &mes_v11_0_kiq_hw_init;
>       adev->mes.kiq_hw_fini =3D &mes_v11_0_kiq_hw_fini; @@ -1796,6
> +1797,14 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block=
)
>               return r;
>       }
>
> +     /* Allocate GPU buffer for array size query results */
> +     r =3D amdgpu_mes_rs64mem_init(&adev->mes);
> +     if (r) {
> +             dev_warn(adev->dev,
> +                      "RS64 memory init failed (%d), using system memory=
\n", r);
> +             adev->mes.use_rs64mem =3D false;
> +     }
> +
>       return 0;
>  }
>
> @@ -1973,8 +1982,6 @@ static int mes_v11_0_hw_init(struct
> amdgpu_ip_block
> *ip_block)
>       if (adev->mes.ring[0].sched.ready)
>               goto out;
>
> -     adev->mes.use_rs64mem =3D false;
> -
>       if (!adev->enable_mes_kiq) {
>               if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) =
{
>                       r =3D mes_v11_0_load_microcode(adev, @@ -1992,14
> +1999,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       if (r)
>               goto failure;
>
> -     /* Allocate GPU buffer for array size query results */
> -     r =3D amdgpu_mes_rs64mem_init(&adev->mes);
> -     if (r) {
> -             dev_warn(adev->dev,
> -                      "RS64 local memory init failed (%d),"
> -                      "falling back to system memory path\n", r);
> -             adev->mes.use_rs64mem =3D false;
> -     }
>       r =3D mes_v11_0_set_hw_resources(&adev->mes);
>
>       if (r)
> --
> 2.34.1

