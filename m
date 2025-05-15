Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70FEC2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 09:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 601A010E7D5;
	Thu, 15 May 2025 09:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ymhXJOM2";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8686110E7D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 09:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0jxlMY9eDkIJ7XuHgW4cbt9K0ZbcY1gZpsYxMqruKtMTNEfxDk+8REqW3F5wWPapT0xwgyhCCpSHhwoSsg9ubb1wode1DPlmBpANRO2Nw6IDMJXPuoRPESxW4Eds8MTzOdciPTFj4zjBiS+eSdaL9z3JTpkNU+AI5ZO7uLsnaVTwTVlsCf6Cdgmg8MYVu60KmmhmZKSfy9o1A/sCVUbtWeNBXGaE3GkImGMrGPiG0vOj37tD6r8uDPWxtadc1ijpRMzQ6KaFp0k5afqUMAIMVgfyXisgfqOHwgr8So2oamR/PEAZ8xgnr8puWtQ7VF5qVsVLRot18OfPYWVjNZdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpTqUF7sn7dNA3+lV/kuljb32OKEngHJ89DXfVGrssk=;
 b=Dtriw+C+QdfCi8EtMKGs/8PeBugBXUPqGGmMF9ZN8FVneydonUHp5yCBRDcCQj4967woM/TbKQrtEsujjf18PRjQ/Q6IqjgeYGOsaijKgU+O6nHCF/JgBBoTliE5531qElG3RPK1DBTQiWSwiHK69yM3wTlgNT63rTAgxXnns+yqlBpOHPS/SOze1scwp6ddllvra1cjRFT1wxZOWvVqq1l2128tTg/GxQAspRnzped483VYzuuFS4pgZTuL9nC0f75JO51ek6ZrgcxQ0EeettmdkiuGfGAHQFD0zrNpejFFmyADE1q6AiopKkqrZ+n34HT4vej5hVUHlm01RXYWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpTqUF7sn7dNA3+lV/kuljb32OKEngHJ89DXfVGrssk=;
 b=ymhXJOM29KcA3e9qyTUPDLJI5JNb9a5stupEGx/9IaX9Zjng/rB2FZQrL6enT99BNOS2l3b3B7xFc79lX+iNcl8wnVZW4LuZeU1MMSXEbhnsOTDz88QOv/udJjai3VwEEge0QFOjRZQMPSLPuP7ZB6VcoFURDgEUxisUG8qnYPc=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 09:09:38 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 09:09:38 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH Review 2/2] drm/amdgpu: Register aqua vanjaram jpeg poison
 irq
Thread-Topic: [PATCH Review 2/2] drm/amdgpu: Register aqua vanjaram jpeg
 poison irq
Thread-Index: AQHbxHvX4898VrJ1XkeYb8N2EQsQlrPTaJyw
Date: Thu, 15 May 2025 09:09:37 +0000
Message-ID: <PH7PR12MB879600F41D623893E79C6591B090A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250514025601.42366-1-Stanley.Yang@amd.com>
 <20250514025601.42366-2-Stanley.Yang@amd.com>
In-Reply-To: <20250514025601.42366-2-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fb0b047e-9057-452f-acad-c30edc28d97f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-15T09:07:31Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|LV2PR12MB5990:EE_
x-ms-office365-filtering-correlation-id: 7a2ef497-73e8-40bc-6841-08dd93903806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YjLtgr+d17Ykj3DNPH4xy2IP8JWhaIvVPyPuCNQ9BvRIzw1i51jIlSa8f81k?=
 =?us-ascii?Q?YAmx4KdGSD9+jC6ldU5T2qy2qPu6a8KOtSWLELOaOIW3xZv/rYfOonoRFccm?=
 =?us-ascii?Q?zeYjkfrGGVhdip1BJjExJ/1LHRXJwwKX9hPQrAmhaMdYRfYfghf99Ts7eZ92?=
 =?us-ascii?Q?5h46M7Q7KvwO1LFHonwV8PTZhxEwGaeCxzRfQc+BIYlZT4D43AzWssAG99xI?=
 =?us-ascii?Q?LaVT3nUpkA41zKUdt82Rkl6jSFmpXnL97UaO6aAslBFLxdEDMQ1ZFznE0NtA?=
 =?us-ascii?Q?Y/6u4/cZ9zr/AFNYpugCZ5tGcXqJcaR3yEcLb/pGsqDiE7OCVLKMeqLJXutq?=
 =?us-ascii?Q?Y2LvSeehdUZmt/YyhislMzsl/XTPHlPqvHVa/Flat5/W1z6bBNsAEpj2twJn?=
 =?us-ascii?Q?RL6LwJ0CQQq7CLh334KXgbreEufCJ6oJmECiMhnJ1+8tUrVQG5ZOvjzujsQ6?=
 =?us-ascii?Q?MVq47NL0qRh6tYRPD03Dz2QQN7HdXUAtv4CeQfZBgtw784HATad58DHk+MTM?=
 =?us-ascii?Q?38voyYAxiSHh33FLXLoJkoDbDHmLgb4Tu8zhZfeccq1Oa8duWwS0zqpa4f8K?=
 =?us-ascii?Q?EzD+LWauKO0P7CLk3SM69f3QjRLBRvRfltc2RGVrH7zg2FrR6qTUq+x4z7U9?=
 =?us-ascii?Q?GJgh6T+WwAn2FNbugrlDup4dPZ0qychOB6xjoIeeThFZU0lgNZIrOB6GbE6Y?=
 =?us-ascii?Q?nNLhIKrecwijMLM5GBbr26/1J7EuKxdeM+zjKc2aXJgb/LV4ItCmOpxmgOwp?=
 =?us-ascii?Q?rQo8pEBRyQvSLhXEiVoak/7aOjGGq9QCBZG7inbDWOxysjXhidnFOpbpn5mo?=
 =?us-ascii?Q?sDgwRpbPBSNPWw+3ZkVNHHnSPOgUVWwpZmglXIJ+0fX5CL1rEOo1m997FOtg?=
 =?us-ascii?Q?ETFkPV8YGZJFBMEKa2wCm378x0Khk3POvtCL3TXZvm42lQjO1X2MhTpgE6Pe?=
 =?us-ascii?Q?9l5JkHmZ3VrwmUUHaIV70vyyaojr5KoKNMWsLXnw8FMa6wedSWPwivt7ieb1?=
 =?us-ascii?Q?KUSLv51GL6g1GBIWpK/a5QbA7IizFtxqBScnIEAvDQfDDhfEkWdWyRx4VTJP?=
 =?us-ascii?Q?ANfA6kIiO52nugkkoZoFU3zWmcLc+8keJdPrJfa8b+yyoGGquknMt/Vn34HR?=
 =?us-ascii?Q?MqddZeLsBppmlsyN4BJlwJZIRoNU2smgI42mG9pZEcrrUZaq9PDe/vdub4zo?=
 =?us-ascii?Q?ZKIXOWYjDEn5/JR5iJWN0IeX3clm394Rx3E4Hqo20E922L3LmSC4FtI9yusQ?=
 =?us-ascii?Q?OC4Cd6Cd64AQiNIMzRoHohNKP54ySeYa1bJ5P75PjBJ+iTsE8n4lzJ3U8mgs?=
 =?us-ascii?Q?t7kILW4/MM6un50rgm2uj4D7hcVcLCYz98ksqwmx5wghit8RzioVODnihb2q?=
 =?us-ascii?Q?0oDgji6OEt3+KyjdvYgFKt7nYBTjeOQtIgLu1+wf23AknRCSwXAU53ZjwY/4?=
 =?us-ascii?Q?2f3MmmK8vz647FAge5jSKkTl5xAJNE2WzpbJK+2WElAH56dZJKA2iQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u3+wmvxES1IfMbqQo/xx3XxA+RBVEkkLBAAAETseRc+c+hTPgxHYM5tIs2Jo?=
 =?us-ascii?Q?D1IhS8sSDL9kkFyep7StEj27zkfWP+DyFkq5X1zOvHiMtqRYjUAC6kT5v19v?=
 =?us-ascii?Q?irLohD3z0IUnsy/REXHS2yn2TBq55fUAQbbZj9vO4XV1YHxCHjdkt/0LA8Q7?=
 =?us-ascii?Q?D8xHtRpDJt76UQHL57Ak8uk92cYtNX1B6JEfq3iS/uDa+5mJu91rJnH9DAwQ?=
 =?us-ascii?Q?nOGg5uWavloqSFrdPJuYHS/eynAqfppdz+FlA/hc1+99EwMTFeVNRTMNAzhv?=
 =?us-ascii?Q?jh5MHdU9ZvuRz0lVPJk/HMkjTa0p0SOklmsevCVNtVHcyQ8gFMawq4/sQ9Og?=
 =?us-ascii?Q?D8W2UaQtqXVNixJektYOjxEy8j8VFgYALqS5g7nzoYQeaaBsvbvD2yMPAYpj?=
 =?us-ascii?Q?StCMlxEOYN2IgvusnkFFa/YiQXJaacdUHnftKJc46AowtX3HRCiEGzzkLylV?=
 =?us-ascii?Q?GjP6inJpt2GJevH2geiHQgjUicQZuSWipXvCnjyuU87EieflZIpSEExmif0W?=
 =?us-ascii?Q?1WkzjxKkNsuv9al1oA+heJdeinAwVjLnHyyPOW0IUmSmWDYh5t2IY5P8kKeN?=
 =?us-ascii?Q?SQkmbH1/o/8UCEvRyKF5jo/FBXxRYmgR4LI96kb1MvtbCDxBg5f1ZFOuJ9/a?=
 =?us-ascii?Q?5cJDtLtTg5kG/DAqBEpxmBpQB8JiBZbRzsiKux7aGKu6WoQrxOzm8aPozknk?=
 =?us-ascii?Q?Cq3TZHTpi4F/8Kh9z0636mru0SBXmOxH8jFoY/WObCd+aHSKaOH8euAjveW9?=
 =?us-ascii?Q?kjXJPS1uieBQTj40gw1kIeHl6IAeU2Ylprp3vfx659DoMcko7gDcHiWqK7br?=
 =?us-ascii?Q?0qUUI4P8tWLWWwY1eUwfZVG13E8JmowDtKvNyDkdJfz9Kw6Cl01bJvHActLS?=
 =?us-ascii?Q?Lm2w2flc1miMwIV2WpPoRJuQ8mFHGsO0rP1yOEfh1Gp3A6S1Sto0YkCCwajf?=
 =?us-ascii?Q?i5fC6uToQvFcxRn6ipGNgdBL4ibreXCX0htuwyl0iCuka7bsFAx8oQbSFpNW?=
 =?us-ascii?Q?IgtO5eNP7RkhalWLhHIbWjF61NuzdPvMnoiYjGv5UQokFgGzuMmF9J0JnaBC?=
 =?us-ascii?Q?RyjyVMFJisqEP6dhjJX3x+UQZxReEsGNRT/LIFaxazf8j98y1UAHDblJ+W4U?=
 =?us-ascii?Q?LVQiHRqaGkWWkMf5xeaSgMIky9S+geM2UOq9V8ECfuucP23OJny6xwJLPIjK?=
 =?us-ascii?Q?Q48ky9JpmrrYh9h9cxSpoACkug3YHGuJQrCnVF4UDqNFEIZ7VV/ABOmJLu8J?=
 =?us-ascii?Q?MjnbspVCKt0+aZ5X4O32/Cp4lEdt5+EQMHGd7p1pL31yAIVhqfWHNK0695Hh?=
 =?us-ascii?Q?D0RbxMzBbzAS+QI1T8GZlUXNksz6zsqIWLqsI4oFE3et8Jzzc8Q8Yy6FMdYc?=
 =?us-ascii?Q?SQNkN4vyuZa5VfSQrvTtiwnQWFNg33S5WloVxB+4OrIC0RrZTDvSlyXHdsiX?=
 =?us-ascii?Q?G7lP5DdGysetII4mc/hxp9eczJhSAepJEirPJxYgqSDStqBcp2S7qHF3TsdQ?=
 =?us-ascii?Q?JjY8Qeu8McucUMnYXqfZ8HGwfT3ZUp1j7qAUyBjb9OdxctQPppZxFzMPK4eD?=
 =?us-ascii?Q?oJU+lAs1oM4rz//zXbs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2ef497-73e8-40bc-6841-08dd93903806
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 09:09:38.0616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vT6nBL1ZYuGG8jaRHoHEgGHgXo3lw70Ltt55LYAt+cRjp2IgdIkMzgAxVhNdZDYF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

Regrading "enum amdgpu_vcn_v4_0_3_sub_block" and "enum amdgpu_jpeg_v4_0_3_s=
ub_block", we can unify them for VCN versions in the future.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Wednesday, May 14, 2025 10:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH Review 2/2] drm/amdgpu: Register aqua vanjaram jpeg poiso=
n irq
>
> Register aqua vanjaram jpeg poison irq, add jpeg poison handle.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 76 ++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  7 +++
>  2 files changed, 83 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index a8ccae361ec7..79e342d5ab28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -149,6 +149,18 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_bloc=
k
> *ip_block)
>                       return r;
>       }
>
> +     /* JPEG DJPEG POISON EVENT */
> +     r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> +                     VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst-
> >ras_poison_irq);
> +     if (r)
> +             return r;
> +
> +     /* JPEG EJPEG POISON EVENT */
> +     r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> +                     VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst-
> >ras_poison_irq);
> +     if (r)
> +             return r;
> +
>       r =3D amdgpu_jpeg_sw_init(adev);
>       if (r)
>               return r;
> @@ -434,6 +446,9 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block
> *ip_block)
>                       ret =3D jpeg_v4_0_3_set_powergating_state(ip_block,
> AMD_PG_STATE_GATE);
>       }
>
> +     if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
> +             amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
> +
>       return ret;
>  }
>
> @@ -1041,6 +1056,14 @@ static int jpeg_v4_0_3_set_interrupt_state(struct
> amdgpu_device *adev,
>       return 0;
>  }
>
> +static int jpeg_v4_0_3_set_ras_interrupt_state(struct amdgpu_device *ade=
v,
> +                                     struct amdgpu_irq_src *source,
> +                                     unsigned int type,
> +                                     enum amdgpu_interrupt_state state) =
{
> +     return 0;
> +}
> +
>  static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>                                     struct amdgpu_irq_src *source,
>                                     struct amdgpu_iv_entry *entry) @@ -12=
00,6
> +1223,11 @@ static const struct amdgpu_irq_src_funcs jpeg_v4_0_3_irq_func=
s =3D {
>       .process =3D jpeg_v4_0_3_process_interrupt,  };
>
> +static const struct amdgpu_irq_src_funcs jpeg_v4_0_3_ras_irq_funcs =3D {
> +     .set =3D jpeg_v4_0_3_set_ras_interrupt_state,
> +     .process =3D amdgpu_jpeg_process_poison_irq, };
> +
>  static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)  {
>       int i;
> @@ -1208,6 +1236,9 @@ static void jpeg_v4_0_3_set_irq_funcs(struct
> amdgpu_device *adev)
>               adev->jpeg.inst->irq.num_types +=3D adev->jpeg.num_jpeg_rin=
gs;
>       }
>       adev->jpeg.inst->irq.funcs =3D &jpeg_v4_0_3_irq_funcs;
> +
> +     adev->jpeg.inst->ras_poison_irq.num_types =3D 1;
> +     adev->jpeg.inst->ras_poison_irq.funcs =3D &jpeg_v4_0_3_ras_irq_func=
s;
>  }
>
>  const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block =3D { @@ -1304=
,9
> +1335,47 @@ static void jpeg_v4_0_3_reset_ras_error_count(struct
> amdgpu_device *adev)
>               jpeg_v4_0_3_inst_reset_ras_error_count(adev, i);  }
>
> +static uint32_t jpeg_v4_0_3_query_poison_by_instance(struct amdgpu_devic=
e
> *adev,
> +             uint32_t instance, uint32_t sub_block) {
> +     uint32_t poison_stat =3D 0, reg_value =3D 0;
> +
> +     switch (sub_block) {
> +     case AMDGPU_JPEG_V4_0_3_JPEG0:
> +             reg_value =3D RREG32_SOC15(JPEG, instance,
> regUVD_RAS_JPEG0_STATUS);
> +             poison_stat =3D REG_GET_FIELD(reg_value,
> UVD_RAS_JPEG0_STATUS, POISONED_PF);
> +             break;
> +     case AMDGPU_JPEG_V4_0_3_JPEG1:
> +             reg_value =3D RREG32_SOC15(JPEG, instance,
> regUVD_RAS_JPEG1_STATUS);
> +             poison_stat =3D REG_GET_FIELD(reg_value,
> UVD_RAS_JPEG1_STATUS, POISONED_PF);
> +             break;
> +     default:
> +             break;
> +     }
> +
> +     if (poison_stat)
> +             dev_info(adev->dev, "Poison detected in JPEG%d sub_block%d\=
n",
> +                     instance, sub_block);
> +
> +     return poison_stat;
> +}
> +
> +static bool jpeg_v4_0_3_query_ras_poison_status(struct amdgpu_device
> +*adev) {
> +     uint32_t inst =3D 0, sub =3D 0, poison_stat =3D 0;
> +
> +     for (inst =3D 0; inst < adev->jpeg.num_jpeg_inst; inst++)
> +             for (sub =3D 0; sub < AMDGPU_JPEG_V4_0_3_MAX_SUB_BLOCK;
> sub++)
> +                     poison_stat +=3D
> +                     jpeg_v4_0_3_query_poison_by_instance(adev, inst, su=
b);
> +
> +     return !!poison_stat;
> +}
> +
>  static const struct amdgpu_ras_block_hw_ops jpeg_v4_0_3_ras_hw_ops =3D {
>       .query_ras_error_count =3D jpeg_v4_0_3_query_ras_error_count,
>       .reset_ras_error_count =3D jpeg_v4_0_3_reset_ras_error_count,
> +     .query_poison_status =3D jpeg_v4_0_3_query_ras_poison_status,
>  };
>
>  static int jpeg_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct
> aca_bank *bank, @@ -1383,6 +1452,13 @@ static int
> jpeg_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_comm
>       if (r)
>               return r;
>
> +     if (amdgpu_ras_is_supported(adev, ras_block->block) &&
> +             adev->jpeg.inst->ras_poison_irq.funcs) {
> +             r =3D amdgpu_irq_get(adev, &adev->jpeg.inst->ras_poison_irq=
, 0);
> +             if (r)
> +                     goto late_fini;
> +     }
> +
>       r =3D amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__JPEG,
>                               &jpeg_v4_0_3_aca_info, NULL);
>       if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
> index a90bf370a002..2e110d04af84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
> @@ -46,6 +46,13 @@
>
>  #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR
>       0x18000
>
> +enum amdgpu_jpeg_v4_0_3_sub_block {
> +     AMDGPU_JPEG_V4_0_3_JPEG0 =3D 0,
> +     AMDGPU_JPEG_V4_0_3_JPEG1,
> +
> +     AMDGPU_JPEG_V4_0_3_MAX_SUB_BLOCK,
> +};
> +
>  extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
>
>  void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
> --
> 2.25.1

