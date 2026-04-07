Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BFDFB5188
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 02:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC85010E311;
	Tue,  7 Apr 2026 02:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yvVyr9Ci";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F8C10E311
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 02:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPWkrP02HsfOs/ps/PlvFvq6PnaCHgZEBjv3FBUH0aaSBLAT/YJ7CuOk+mh5gwHXrqa5Q9ly4CA4B09puQPPVk+34RHmncbMmbOWcplljZZS5n12LGM3pFhdtjLzalx7e1dScEuB96xxSAxByaXFKS6tBWJJd6xJ18KHRYkwmKWp+GkgumxbMiinQ3w5+uTHCZe3q1K7IoyduDVu2/kiBctgQG4e9P5H0RNLq5NLgufQ0lwGnKA4UDQ5Im5wh1ttGm79jSEC7gqEZTBVGDz0eWOu6XBtV/kZxn2ZP/ZVtZavNMxM5CC8ZQ3WRN4nsQV9Hra5a6rV/T5DAoT47TqAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buJXyQrgilaS1uyE6YEJLJKE8rYkb09uAuH5VSsVXO0=;
 b=K0nrK1xjZf34VcyPjnaH6nB3AVyn5rUD5I7Qeg+HDPgGYl3Zwzc/i9Vpbww/yaaEz0kcbXc6H99EgQOPKcj4QuM+03/2opOAsmqV0i+jZjunlxqw5no3jH05HKaLKiLLLjOTchVy2BkivX5W9v9U3X6AhrREf5orZ8TAnyHjVzq9nY3XT1q2ALjwrK+xa1Mnp7ViaCiaPiXZrHF89TNlS/4TxXcSkKKPWUawSwWNYlg1DZQizr21uKL/59mL2Sczmtg7ZNTUxLMfHVSnCipcSdP9z44mxksO7ghHNJe+FXvy8cyJoJbNprtD5BTmZpMW47hkor0Ut80PTG1RzruU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buJXyQrgilaS1uyE6YEJLJKE8rYkb09uAuH5VSsVXO0=;
 b=yvVyr9CiJOzAfc8tyixn3x1qjTnu6q5JOD0LrTebZIVrp2OKhuwwDx3Jjwwjqmc6hhHVUfl+cDUKC/TvcGC9T4/mD2JHFd5s7m4fUH/hS8wB3QHt/K6uSR048XvCabEHEtN41OULnqe8AEB0YuHPeUg+b/3IM7VxlzNaC5sB5Io=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 02:57:10 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 02:57:09 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Chen,
 Michael" <Michael.Chen@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 1/2] drm/amdgpu/mes_v12_0: use mes schedule pipe for
 legacy queues on unified MES
Thread-Topic: [PATCH v3 1/2] drm/amdgpu/mes_v12_0: use mes schedule pipe for
 legacy queues on unified MES
Thread-Index: AQHcv+VL9F8pgEPomUy19UUG7YaikLXS9J3w
Date: Tue, 7 Apr 2026 02:57:09 +0000
Message-ID: <DM4PR12MB51522665F8E22A61237330B7E35AA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260330013346.1054624-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260330013346.1054624-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-07T02:56:59.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH7PR12MB5618:EE_
x-ms-office365-filtering-correlation-id: ef66c156-7295-44db-193c-08de94515c5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: b+2XxpQn6il0MC+ubYOTmclnyQVi7H8XQ5rkVHeaTND7lLxufGrvyayX8Q3wTxeipQtuqcKz6ex0tdiYrr8Miugr1+IPhTeMpt2GeniWTgcz1x52+sX6C5fU/Y4TMzEizaSVtR5kuwgslbVrzSmWXEiBlKuW4eUXSPnQrNkec47PFhfAV/BlIGmYjb1rEwhMdF98w/0f+TylvIBfqpTnzd1QEK//0MGQ1DMf/fJZRT9zyRxiswLmNgLw+YLzLHMs30GzkYkfnhfWt8r+BRnKdpIXqAZHpuUBA66yeWdfXaX8r6bu6tHilcubgwdFn6ZuBOtIPTs/1KWSbaOWjGDvxOPsHUDSbRRPEhImjLKLHy5gr30EkplMWPEixLc6siBYMMbVzQEgqmCg7cfU0ycyGxCZ+qjmtlrV/ZKX8qQlhIKy68JHlKcVsnNnelxP0gqI74NIlwhpvyhf73rlmGMpvQ3d/A75Y8VFQnovKAHuZ/RHTWO0OrnOj2Sf0C7+bE9URyEhZhm3Thkr80fc8K3s2IaEenUDTLKaHO4CuflwAqxafwyZEAW/bBlQkPwLaZw1fVK1ePg3YFNJUJlQJBfC58dBlRhHzzU7UzJ7GIWHLrCk7qcymU/w+1B7pGPBY2LYQV6RDnCPl0gwPGOU4clJsfQj0blFbxJI5LfG/Rw4Isa+se0uAfSW/5DIWf5kbN5z/agjSkSAMgyCDN5H4UGzluYcbiZ7sVdW/fwX6BBCCkHl3qZea6U7GrWkF28I4GpY2NVnl4TJcpwZwXQSpD74p1yflrM4AvsLYgjkXNr7Rj0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tqugeywfKBrzlhZqCsj5RReHfRghazG9WFaTNiXIqM5E7bqnYau8QSnim6Ek?=
 =?us-ascii?Q?pY1KjDuYs6S7z1QKjh5Z2o9QujnIIyzjB4p/tpa1+1/tS4epdL1nYjwB33TM?=
 =?us-ascii?Q?YbAMBmMomcM/QY/XLASHaiOTXzoCMXwbKSGusC/xaZ5AInJvXUS7dqeuC0/Y?=
 =?us-ascii?Q?qHZtP4ulFs4OwCHFm6LyLPRf414ojlH57S0twmmP7SCHxopErcWwXo1WaQqk?=
 =?us-ascii?Q?ijdzW20VDGeC2xTfJwi0xFY7MM2sgqoFjz5+E8zwiYrOp1DSxhMY/a2maD0b?=
 =?us-ascii?Q?bzbPD+iIyYbZWKVYeNpC3hW/VxvQ5Fj7KZhQrp45oN28n1VLShNQ9gyU6jaq?=
 =?us-ascii?Q?+KaKkHJxyrd/twA9PuiXGdQvZltEaZgaHTtZ734LAUwVXYXyQ1gr2O7Sxz9P?=
 =?us-ascii?Q?CIKwI08kOuIEWLADLoSLpJe0vbLvSiMgkn+Syb6g3XvQpBDHnXGsJAdbwJlX?=
 =?us-ascii?Q?7Fz8b5oSui62l1p+PPAebVHxEQYLRRbAu7NrOiUnNFvpDMnlLDwlnnGaf2XJ?=
 =?us-ascii?Q?HggUG0HB1a5Dv91/q3HcG7xE/x5YhonPE/97wDtZ+uUHdwa/IgHwPMNCC09p?=
 =?us-ascii?Q?sWkYzvvzKI1efEduyVGnGdb2Jr6wj2R6cc4KaxIA4aCqTEiM9STajYJE+ZzV?=
 =?us-ascii?Q?+f6TwWClSKGS/viRr+ImeBEAGYWfWyicasCQjtuvXf6fuQem+r4tC3iFJLw2?=
 =?us-ascii?Q?Wl4KB87ieoo3QKbDoSuJBB+gEWFJvwa0hm1gPI9N7Nx+gvYwLNAAIcdFnmLd?=
 =?us-ascii?Q?Kj3lX+2emE031ZPgr8WQOerKH/+d6r/QvFgpa3/jj+d3SzvL3iReZhOWcyBj?=
 =?us-ascii?Q?tz5GiSll0El/dy9igfaE0j362if6xDN1VaSo7a9/HZZWTjAdRC3ckhzg6NW0?=
 =?us-ascii?Q?Qb755DW51YDC6rLreMNgpd2gDVek2JcawNYQGsPZzdTM+x/EXMPakEQeL8jh?=
 =?us-ascii?Q?kRiNL0IxOnAyFLq6xKywl4XRMp/SGyxvVi74RY11rlLshv5Gmxnc7mVY46Ya?=
 =?us-ascii?Q?UUQoIRZGrtqb53GEVzGqWsFgPh+H2Wsor5VnxW21UeMcHWYAodGt31cjk9PM?=
 =?us-ascii?Q?/CB1ZpbfkbGMjORu2TL1tc7X+jimE4t8zjRgr1LvPoUow7beE9kYdxNcr/HA?=
 =?us-ascii?Q?adMiC4io8zgwC6qbJHGwIfvwLhhSYLrMqWjbcMaQiTZ+FR0MbMRdIS4Q/Z4+?=
 =?us-ascii?Q?nl1n0mWevIgCOEH/7M6PZ+vupirZcuKXtT9pB1nyaoPvq2o7dmE62VkkHuW9?=
 =?us-ascii?Q?wd+Es2ERoLNmz3ICpRBcG6ws/R5dyjZLMixnNSG6JKjJLYvd+hOIJZrvgnBS?=
 =?us-ascii?Q?yLE+BdFVzGmmsiqq3J/z1QRIfWH7fAjt9736Qo0zXa0XVsmYxJoUXP7OOKS1?=
 =?us-ascii?Q?wjtVqlImpwUB7F1J3ZzV6bcAF1JXHU3gLd+ZmtcXhI5CGdw3hdfZRzDKXBYf?=
 =?us-ascii?Q?JEgiOz16wxD7hCaQ/o4/v3o2J952BI5GTnXaHuzEQ07zaIIoKMWKWwg9Xk32?=
 =?us-ascii?Q?SNWugbUkZB4jvoKTgB1OnM5uKGUP3aDJ0LYiP6ycrDLQ3Ngi3Qeg2Txuy5AT?=
 =?us-ascii?Q?621RPI+NZ7g2GxuS640DyERfmYHWoXvrC/CaHgUI2Bn3akP6rHsOM5AzU80X?=
 =?us-ascii?Q?MxvSZ+5XqP/OsEPglZ6+8zVsLFLELLL1MfA9hHJ+VovkLHSOuFbdTuGXoDcw?=
 =?us-ascii?Q?39Th8WbmC6QA9RfwSpA1iJkoZLtSOTcG/5UxqhPRbJ5PG7cc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef66c156-7295-44db-193c-08de94515c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 02:57:09.5416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8taxmcEO3Y/11vFtDj2HzLUJPOUIQ3drWTDFN3Q/O6uY+8dhE7NwPOiqQFrd3Bg7Yun2vGzvzFlf74KuUkaZ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618
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

Ping ...

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Monday, March 30, 2026 9:33 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Chen,
> Michael <Michael.Chen@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH v3 1/2] drm/amdgpu/mes_v12_0: use mes schedule pipe for
> legacy queues on unified MES
>
> when suspend_all_gangs is issued to pipe0 MES during system suspend or ru=
ntime
> PM, pipe0 can only suspend and resume queues it has tracked.
> KCQs registered with a non-zero pipe slot may not be correctly handled, l=
eaving
> them in an inconsistent state after resume.
>
> v3: fix the schedule pipe issue
>
> Suggested-by: Michael Chen <michael.chen@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 023c7345ea54..67fb5161c0e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -528,10 +528,15 @@ static int mes_v12_0_map_legacy_queue(struct
> amdgpu_mes *mes,
>               convert_to_mes_queue_type(input->queue_type);
>       mes_add_queue_pkt.map_legacy_kq =3D 1;
>
> -     if (mes->adev->enable_uni_mes)
> -             pipe =3D AMDGPU_MES_KIQ_PIPE;
> -     else
> +     if (mes->adev->enable_uni_mes) {
> +             /* Keep scheduler queue on KIQ pipe; map all other kernel q=
ueues
> on sched pipe. */
> +             if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
> +                     pipe =3D AMDGPU_MES_KIQ_PIPE;
> +             else
> +                     pipe =3D AMDGPU_MES_SCHED_PIPE;
> +     } else {
>               pipe =3D AMDGPU_MES_SCHED_PIPE;
> +     }
>
>       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
>                       &mes_add_queue_pkt, sizeof(mes_add_queue_pkt), @@ -
> 567,10 +572,15 @@ static int mes_v12_0_unmap_legacy_queue(struct
> amdgpu_mes *mes,
>                       convert_to_mes_queue_type(input->queue_type);
>       }
>
> -     if (mes->adev->enable_uni_mes)
> -             pipe =3D AMDGPU_MES_KIQ_PIPE;
> -     else
> +     if (mes->adev->enable_uni_mes) {
> +             /* Keep scheduler queue on KIQ pipe; unmap all other kernel=
 queues
> on sched pipe. */
> +             if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
> +                     pipe =3D AMDGPU_MES_KIQ_PIPE;
> +             else
> +                     pipe =3D AMDGPU_MES_SCHED_PIPE;
> +     } else {
>               pipe =3D AMDGPU_MES_SCHED_PIPE;
> +     }
>
>       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
>                       &mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt)=
,
> --
> 2.49.0

