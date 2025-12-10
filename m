Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC50D3C525
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 03:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4520810E23D;
	Wed, 10 Dec 2025 03:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RuzYEiJP";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012048.outbound.protection.outlook.com
 [40.107.200.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C352610E23D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 03:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+Bn3OsTYITi0M2fFT41Cj5jG4tBNwPOpuZu9PhkzmRhMcutNz5UIbSyDxYVlc7v+14XahUpECsDnYGtaLjngBxToQhpeTldcIYb+gZy+Dtgcw4VMCG4d+ClB27jvUNps3fYXYj0MSZyPZhZsObOFNnln7wthKMwzRrZk+RYsLAaMmCwFES0VTARshiXZnWS6Ism5iYun/5yGyZIg05FeLw337D3nNuYYrvfL5lo6Xd/GkO9hRVtT+ape4VqIMv3OJY4AqYam3VjmG5Et21GMygFqQeVyNAEVcqtSsEuzS3rueaDeQStt+mPlwNRaqkhb9I+ksPGgroNVXDom+s61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/xFi4LihZm7ucbUwOSQx6q+NK9HW9Rf2T4j0WOqEVQ=;
 b=iRrY2Zm2/19j6Enasoa9SKrjGkkcMXrfT9VCfscolMT9QXyVrQH8WBYEiIub1AcaZklLoEE/RoNETFTWQAepwFjymHJJUYAkqdeC2sMkjvY45/nfKvsrK+j03G4pSG7SA7LnHlNEAOO3rvEpNQFpRdocvnO93QexgTDHafEebG24qIg+L6MV0scMOEWeIG6wueEv7FHjWpvdB1gdh3E1lbWFVMvNyUEQxaFQuj4na88W/MN4yRKKd+h6Ktg+QREAsKBkRbuCNjK3Zl5r3zertQsQBB9+b4X0a+rfnF89vVbL3UtWq1bcMc2SP1M8WmwB+4/MXT8tl24/gxGXFxFRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/xFi4LihZm7ucbUwOSQx6q+NK9HW9Rf2T4j0WOqEVQ=;
 b=RuzYEiJP0zIwB5C9nnT/E0pSrqSFfJkpvrq7qBHDLzOk+GI/OkuSS9q2GGWXl5maVAiZ5tkPkujoeGkOQcysGo+Xg2UgwEGkPXCFT+mLXHTSUdCAKlY/Guio1CPdp8R7JEpXNZeBmir5r5Eci6t17YyPiH5ykgYD98C+9ji7YZU=
Received: from MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 by SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 03:02:47 +0000
Received: from MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::4886:4704:de81:5d2f]) by MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::4886:4704:de81:5d2f%4]) with mapi id 15.20.9388.012; Wed, 10 Dec 2025
 03:02:47 +0000
From: "Li, Chong(Alan)" <Chong.Li@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: fix mes packet params issue when flush hdp.
Thread-Topic: [PATCH v3] drm/amdgpu: fix mes packet params issue when flush
 hdp.
Thread-Index: AQHcaN7bzetMJJFhZE6KzPVZ090qkLUZFC2AgAAXumA=
Date: Wed, 10 Dec 2025 03:02:47 +0000
Message-ID: <MN0PR12MB5761696F1F3009C6F4EB2F969BA0A@MN0PR12MB5761.namprd12.prod.outlook.com>
References: <20251209073831.1426657-1-chongli2@amd.com>
 <4e4a99a9-5fff-42c1-ae5a-b2f925df2633@amd.com>
In-Reply-To: <4e4a99a9-5fff-42c1-ae5a-b2f925df2633@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-09T11:27:37.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5761:EE_|SN7PR12MB7786:EE_
x-ms-office365-filtering-correlation-id: 233b3bad-90e9-4197-5b1d-08de379898d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7sGQTf/cCMXDqSVvA/CGzs8T3uHe++l2Z7roIykvnFZfhBBgxFGyxHRM/Aiw?=
 =?us-ascii?Q?n388wtRIC98HqfEUu5vRIlPI4ZaibC3s5Z1HtJC9VGJF/H8iE6w+Zyp+mssb?=
 =?us-ascii?Q?CJ8Tepw/jdLKaaYmoEECIMbNkImypBbQue7OIDK5H7vrQCEkWl8yeAmrd6RO?=
 =?us-ascii?Q?QwnV86gTESYX4LMLqggyd0RBLePRKidN1lCrJbbJvHUq//LwuQ7LiyYhuPPN?=
 =?us-ascii?Q?lUXanAZP0RiH8gNG/IjORU5QY8ot2bKlzW9mB81feQeGVZI/pT6IiE0SJtrH?=
 =?us-ascii?Q?hwC8B1nD5gQrUTdqs76JcwWS655rSj8vJ8L5FB7J8wcQnhnUomMMT1RLNxh2?=
 =?us-ascii?Q?EXOQebEKfByfVh0XTO7EWhmZ/E0IksYXGdMQ3LFlOYRC3GeGuHZUN807m4KE?=
 =?us-ascii?Q?7SM3fRj0egP60J1nU1J/ZMn7H4/rMthLPgb32AQ2TEwzZ7QMphhuCjDrX7MW?=
 =?us-ascii?Q?6RzDShPGZv52iHXoYShgYTwiDjy9JYSmFekIbmfgJfMpkGFsWTxvG0AKpou5?=
 =?us-ascii?Q?AVFJJpAhVOLJ3HtwO+hJMSDJgasyzULeY4NXFx0vuYf0i15XptEX8Rd5R5J+?=
 =?us-ascii?Q?UHodFZJxkEX5EvWqNJYmJJTF5rBFAuzAkJ4vhxXSqOtGeARsYhNC6LAgq8U4?=
 =?us-ascii?Q?QH3Ncs+o0LlChPfvV2Lp3dfMaYWR2H0OBJ3W0h7Ev3VdbXBFihiIyp1lt/yt?=
 =?us-ascii?Q?kaM7FQ0tT4m8/tk6Nis86lrJ4OBngubxgvHbONE1JTf4Vsal1Q8iEixiZpsI?=
 =?us-ascii?Q?rmhJli951Jc+uAzZmUXi6BGnGN3SgcFfDTERHfVw/DHut8hZW2Y6DcB/mUGs?=
 =?us-ascii?Q?K++NbBHU014MBZaYnAqMeXHuh/oYdxLnUaXYewYdF296z+4M/Kw3fNrXOGxh?=
 =?us-ascii?Q?4LxHkhFo6UOEuwyARigzXUk7NXXL7tvUmycty6JuHZbMbvubzo+LtyUw9GfQ?=
 =?us-ascii?Q?1zCwpPuvt4NKJSVBZ3DC/w0fY7htQfoWCkJTsoZ0YBL6cz0RTYQ4CO+cYaDA?=
 =?us-ascii?Q?DnG1Q/tAzxP+BBlXZQ+0VxfNCzJH70rVOy6QEoJIgXkgJqzPq83kKEz8vCTQ?=
 =?us-ascii?Q?U4z9wqpacrNvV5/iM4KO04eAHxttPq2UpqLq5jSFs4fiwX9vHmGtqp6ZL0Jp?=
 =?us-ascii?Q?15x74CblgFkROB8r6tIm4IJAzNYhNnpDiFF3pvAdv0h7tuNF4SRiEGXgHbg4?=
 =?us-ascii?Q?ON/U/V5gCAhzCb+ENFLo/Vm4jHlPpX3pf3077/pZaTyGAilq7Cn8+kYLEU/e?=
 =?us-ascii?Q?8JsyqqVE2WhjTR7XBOWUsRsGi8RZ9iJ+yyhnyh+v7gVYJ3qArf7jW4I0IBVU?=
 =?us-ascii?Q?brZy3wsbYXKQWO7OyP4C9Zd5IALFUKSLwwsqtbPmepI4I2qVvzewPB6miZfj?=
 =?us-ascii?Q?n5CDEGUk2iviMA4FnXEkVQ97/p39LUfSJ1fcdOu9tUJ1n0JoGgoDoA5xpODs?=
 =?us-ascii?Q?8pcG6GaCf7+jysDgXk5lmycG9jHMHcyxrH9zD1gBTUXjDRnZvYRuOxhYgqqg?=
 =?us-ascii?Q?zf2FCcMci3+vFrju5gm2yfqV34dLG0Hw1Tdm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?piZajzcVxwCQGjErcCFcabzRnP4XbtOfdaWY6tWNjNrnOYeoR4khGJBAcTc7?=
 =?us-ascii?Q?5RBV089q20IHJa85xqwnWAuX5LIPeeEXtV01N37fa9l3TIqcLy69cS5v4JgQ?=
 =?us-ascii?Q?I3sCuTINXyf07qds3ObT+BCuBDYhkI69+65177/1FqeyEjMcqMSWnKs+YlJe?=
 =?us-ascii?Q?YrkBhX0A7fz6jl5t0JeIvyuNqYUID6qDrkvCwGWS1A3/o1bBYSEFT9CJxFza?=
 =?us-ascii?Q?acsNyP2bzhJYzWdidyym27uY8xXBGPRCQnc/t93WkZvqdV4YqQIgkGqE97N8?=
 =?us-ascii?Q?SVhNcT30FWo79gHHd9072WQtOcpI1NfF5hpTILk5bnZdauLdUErY8u8/Tzn0?=
 =?us-ascii?Q?DgLTF+9IqsoVhVLnTUs1ZSf6jNDBqvPiV512bsF/Gk70gexV0w5n79OcN2AT?=
 =?us-ascii?Q?8lNRy9Dk25+iZRBqb0DPv37Hpip0JVwzFpYc2aCBJRZn2miIXoE4QUr8kX9K?=
 =?us-ascii?Q?i0TargRhsJ1W95T/ftnvoJEG6NZlvqfUaG45gyjEAPBj6vZqFZmWkU35f6PH?=
 =?us-ascii?Q?y6bg7VhnF+3E3/RKkTxZT8lxiuF8BtN4X6xCdRVcwGAkeKIe8orw+ol4L1+A?=
 =?us-ascii?Q?ilAFk/oXDE9XQ628yvSpCdMAsXCbbDFoW4PwOQYdF5ea8bSyqXx6N369dFuc?=
 =?us-ascii?Q?K01AuPD/u+XGZOTYiCEPhnIsaAFWtqFkR0KRVW4DBU8ztH351ZDW7SbL/95D?=
 =?us-ascii?Q?uGQiD42z5ybnlgp9ocKGDW6sTwOkPd0JahiEScN0buc98YMiVm4r7u5Opbcv?=
 =?us-ascii?Q?q1wdQMKtY3UtC4wbe4EzLjVQ/DUOC5+JBLs500aWNZiiYKdz/2dInzydEyBs?=
 =?us-ascii?Q?e65TsQN/lpPfQT+53ZDt9YklpKj8/muOxHZAQqI6Y8HrmtsIp7GEdK2iG+2b?=
 =?us-ascii?Q?fkSGxemJYAV69zmbMLtqdNiyNg2zc8Hj8l/5506z00ksO3bI9/YDnR7ooEt1?=
 =?us-ascii?Q?psjHBa5k4P3aBNxbfKNYKkdSdfedHW1lU8bYSsCNxl4tg3Vq0h9EVKpL2jTO?=
 =?us-ascii?Q?BD1u/InfAcG7p16dXJTvsPgmgqSTTJ1AXTkznN7/3IFYwDLSQLTTaBdWlTU2?=
 =?us-ascii?Q?q+aWH0UUvttqAE0sa0mD0Pn08jZHnvgpVMJXozLsE4dePpu/2DAzu3NNQdmy?=
 =?us-ascii?Q?TZTDE+wfO/4yrULYURCKDi9kf+sWHJY7GtPN/upbYm9oKC+X/aFm3K2jxnmq?=
 =?us-ascii?Q?7aVq2XzvxlTkMI6/4LR/0oUb7KRLIMFQXPRkDodw544UJShCRVDnRsHNKUAm?=
 =?us-ascii?Q?eROHay7D/eXH+6SBmgnVpcJRdU5mQGQDifvrq/wgizmc2nDrHiGpG9eeSxPi?=
 =?us-ascii?Q?QfU36gFObvV1fgz4y5yYM2yecsPHy4nZQCOCW9/y0IeJvHx9l5C97+DCjNyp?=
 =?us-ascii?Q?klqffD5JCAfVFOWaQpHu7Owi5BwTA2E7JQjQeYX7cw2BAkCizZtfxow1du/z?=
 =?us-ascii?Q?nhE6ZfJOjj/L92hOVC0Y/UjX2ce3iuuc4aLTTURkKyDCSMdzVO/E4lwiHVjS?=
 =?us-ascii?Q?2CN44xqoNZ7BOW56IaFtT+qWia6yesHLzcJeI0I7OWvhw+Dzqft2YZfAsU5G?=
 =?us-ascii?Q?l3BFtY8cKsYtXQg/Zeo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233b3bad-90e9-4197-5b1d-08de379898d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 03:02:47.1885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqfQJt6PjOsr9ehtAuz/SkcVOdTfnKnDWltbvN4EVqSXEzBodMeclwyVHd7zQ8bLlB+yQTZYfRmoR4kPPjazgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786
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

Hi, Lijo.
---------------------------------------------------------------------------=
--------------------
It appears like gfx v9/9.4.3/10/11/12 all can be kept in some amdgpu_gfx_ge=
t_ref_mask generic helper, then it's not required to repeat the logic.

if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
        ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ) {
        switch (ring->me) {
        case 1:
                *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << ring->pi=
pe;
                break;
        case 2:
                *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << ring->pi=
pe;
                break;
        default:
                return;
        }
        *reg_mem_engine =3D 0;
        return;
}

if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_MES) {
        *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
        *reg_mem_engine =3D 0;
} else {
        *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
        *reg_mem_engine =3D 1; /* pfp */
}
---------------------------------------------------------------------------=
---

In gfx10, the ring->me of kiq is 2, this code can pass.
But in gfx11 and gfx12, the ring->me of kiq is 3, so this code logic does n=
ot work.

As the value of ring->me has changed with gfx version,
the code logic is not repeat, I suggest keep the origin way to assign ref_a=
nd_mask.


I accept your suggestion of add params check, alignment mismatch and delete=
 the unused variable "usepfp".


Thanks,
Lijo



-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, December 9, 2025 6:03 PM
To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: fix mes packet params issue when flush =
hdp.



On 12/9/2025 1:08 PM, chong li wrote:
> v3:
> Unify the get_ref_and_mask function in amdgpu_gfx_funcs, to support
> both GFX11 and earlier generations
>
> v2:
> place "get_ref_and_mask" in amdgpu_gfx_funcs instead of amdgpu_ring,
> since this function only assigns the cp entry.
>
> v1:
> both gfx ring and mes ring use cp0 to flush hdp, cause conflict.
>
> use function get_ref_and_mask to assign the cp entry.
> reassign mes to use cp8 instead.
>
> Signed-off-by: chong li <chongli2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 54 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 58 +++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 58 +++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 55 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 55 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 54 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 54 +++++++++++++++--------
>   9 files changed, 275 insertions(+), 128 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index efd61a1ccc66..090714127cba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -356,6 +356,8 @@ struct amdgpu_gfx_funcs {
>                                    int num_xccs_per_xcp);
>       int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_no=
de);
>       int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
> +     void (*get_ref_and_mask)(struct amdgpu_ring *ring,
> +                             uint32_t *ref_and_mask, uint32_t *reg_mem_e=
ngine);
>   };
>
>   struct sq_work {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 895b841b9626..5c7724f203d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -556,11 +556,20 @@ int amdgpu_mes_reg_write_reg_wait(struct
> amdgpu_device *adev,
>
>   int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
>   {
> -     uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
> +     uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
> +     struct amdgpu_ring *mes_ring;
> +     uint32_t ref_and_mask =3D 0, reg_mem_engine =3D 0;
>
> +     if (!adev->gfx.funcs->get_ref_and_mask) {
> +             dev_err(adev->dev, "amdgpu_mes_hdp_flush not support\n");
> +             return -EINVAL;
> +     }
> +
> +     mes_ring =3D &adev->mes.ring[0];
>       hdp_flush_req_offset =3D adev->nbio.funcs->get_hdp_flush_req_offset=
(adev);
>       hdp_flush_done_offset =3D adev->nbio.funcs->get_hdp_flush_done_offs=
et(adev);
> -     ref_and_mask =3D adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
> +
> +     adev->gfx.funcs->get_ref_and_mask(mes_ring, &ref_and_mask,
> +&reg_mem_engine);
>
>       return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hd=
p_flush_done_offset,
>                                            ref_and_mask, ref_and_mask, 0)=
; diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index aaed24f7e716..ed79ceafc57b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4566,6 +4566,40 @@ static void gfx_v10_0_update_perfmon_mgcg(struct a=
mdgpu_device *adev,
>               WREG32_SOC15(GC, 0, mmRLC_PERFMON_CLK_CNTL, data);
>   }
>
> +/**
> + * gfx_v10_0_get_ref_and_mask - get the reference and mask for HDP
> +flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring typ=
e and me.
> + */
> +static void gfx_v10_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +                                     uint32_t *ref_and_mask, uint32_t *r=
eg_mem_engine) {
> +     struct amdgpu_device *adev =3D ring->adev;
> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =3D
> +adev->nbio.hdp_flush_reg;
> +

Need to do NULL check of params (this and others).

> +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
> +             ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ) {
> +             switch (ring->me) {
> +             case 1:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << =
ring->pipe;
> +                     break;
> +             case 2:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << =
ring->pipe;
> +                     break;
> +             default:
> +                     return;
> +             }
> +             *reg_mem_engine =3D 0;
> +     } else {
> +             *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->pi=
pe;
> +             *reg_mem_engine =3D 1; /* pfp */
> +     }
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs =3D {
>       .get_gpu_clock_counter =3D &gfx_v10_0_get_gpu_clock_counter,
>       .select_se_sh =3D &gfx_v10_0_select_se_sh, @@ -4575,6 +4609,7 @@
> static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs =3D {
>       .select_me_pipe_q =3D &gfx_v10_0_select_me_pipe_q,
>       .init_spm_golden =3D &gfx_v10_0_init_spm_golden_registers,
>       .update_perfmon_mgcg =3D &gfx_v10_0_update_perfmon_mgcg,
> +     .get_ref_and_mask =3D &gfx_v10_0_get_ref_and_mask,
>   };
>
>   static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev) @@
> -8614,25 +8649,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdg=
pu_ring *ring)
>   {
>       struct amdgpu_device *adev =3D ring->adev;
>       u32 ref_and_mask, reg_mem_engine;
> -     const struct nbio_hdp_flush_reg *nbio_hf_reg =3D adev->nbio.hdp_flu=
sh_reg;
> -
> -     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> -             switch (ring->me) {
> -             case 1:
> -                     ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << r=
ing->pipe;
> -                     break;
> -             case 2:
> -                     ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << r=
ing->pipe;
> -                     break;
> -             default:
> -                     return;
> -             }
> -             reg_mem_engine =3D 0;
> -     } else {
> -             ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->pip=
e;
> -             reg_mem_engine =3D 1; /* pfp */
> -     }
>
> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
> +&reg_mem_engine);
>       gfx_v10_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>                              adev->nbio.funcs->get_hdp_flush_req_offset(a=
dev),
>                              adev->nbio.funcs->get_hdp_flush_done_offset(=
adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f4d4dd5dd07b..c3d8e7588740 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1072,6 +1072,44 @@ static int gfx_v11_0_get_gfx_shadow_info(struct am=
dgpu_device *adev,
>       }
>   }
>
> +/**
> + * gfx_v11_0_get_ref_and_mask - get the reference and mask for HDP
> +flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring typ=
e and me.
> + */
> +static void gfx_v11_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +                                     uint32_t *ref_and_mask, uint32_t *r=
eg_mem_engine) {
> +     struct amdgpu_device *adev =3D ring->adev;
> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =3D
> +adev->nbio.hdp_flush_reg;
> +
> +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
> +         ring->funcs->type =3D=3D AMDGPU_RING_TYPE_MES ||
> +             ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ) {
> +             switch (ring->me) {
> +             case 1:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << =
ring->pipe;
> +                     break;
> +             case 2:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << =
ring->pipe;
> +                     break;
> +             case 3:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp8 << =
ring->pipe;
> +                     break;
> +             default:
> +                     return;
> +             }
> +             *reg_mem_engine =3D 0;
> +     } else {
> +             *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->pi=
pe;
> +             *reg_mem_engine =3D 1; /* pfp */
> +     }
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs =3D {
>       .get_gpu_clock_counter =3D &gfx_v11_0_get_gpu_clock_counter,
>       .select_se_sh =3D &gfx_v11_0_select_se_sh, @@ -1081,6 +1119,7 @@
> static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs =3D {
>       .select_me_pipe_q =3D &gfx_v11_0_select_me_pipe_q,
>       .update_perfmon_mgcg =3D &gfx_v11_0_update_perf_clk,
>       .get_gfx_shadow_info =3D &gfx_v11_0_get_gfx_shadow_info,
> +     .get_ref_and_mask =3D &gfx_v11_0_get_ref_and_mask,
>   };
>
>   static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev) @@
> -5833,25 +5872,8 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct amdg=
pu_ring *ring)
>   {
>       struct amdgpu_device *adev =3D ring->adev;
>       u32 ref_and_mask, reg_mem_engine;
> -     const struct nbio_hdp_flush_reg *nbio_hf_reg =3D adev->nbio.hdp_flu=
sh_reg;
> -
> -     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> -             switch (ring->me) {
> -             case 1:
> -                     ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << r=
ing->pipe;
> -                     break;
> -             case 2:
> -                     ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << r=
ing->pipe;
> -                     break;
> -             default:
> -                     return;
> -             }
> -             reg_mem_engine =3D 0;
> -     } else {
> -             ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->pip=
e;
> -             reg_mem_engine =3D 1; /* pfp */
> -     }
>
> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
> +&reg_mem_engine);
>       gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>                              adev->nbio.funcs->get_hdp_flush_req_offset(a=
dev),
>                              adev->nbio.funcs->get_hdp_flush_done_offset(=
adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index f9cae6666697..b805ed4f88aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -929,6 +929,44 @@ static int gfx_v12_0_get_gfx_shadow_info(struct amdg=
pu_device *adev,
>       return -EINVAL;
>   }
>
> +/**
> + * gfx_v12_0_get_ref_and_mask - get the reference and mask for HDP
> +flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring typ=
e and me.
> + */
> +static void gfx_v12_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +                                     uint32_t *ref_and_mask, uint32_t *r=
eg_mem_engine) {
> +     struct amdgpu_device *adev =3D ring->adev;
> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =3D
> +adev->nbio.hdp_flush_reg;
> +
> +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
> +         ring->funcs->type =3D=3D AMDGPU_RING_TYPE_MES ||
> +             ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ) {
> +             switch (ring->me) {
> +             case 1:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << =
ring->pipe;
> +                     break;
> +             case 2:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << =
ring->pipe;
> +                     break;
> +             case 3:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp8 << =
ring->pipe;
> +                     break;
> +             default:
> +                     return;
> +             }
> +             *reg_mem_engine =3D 0;
> +     } else {
> +             *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0;
> +             *reg_mem_engine =3D 1; /* pfp */
> +     }
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs =3D {
>       .get_gpu_clock_counter =3D &gfx_v12_0_get_gpu_clock_counter,
>       .select_se_sh =3D &gfx_v12_0_select_se_sh, @@ -938,6 +976,7 @@ stat=
ic
> const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs =3D {
>       .select_me_pipe_q =3D &gfx_v12_0_select_me_pipe_q,
>       .update_perfmon_mgcg =3D &gfx_v12_0_update_perf_clk,
>       .get_gfx_shadow_info =3D &gfx_v12_0_get_gfx_shadow_info,
> +     .get_ref_and_mask =3D &gfx_v12_0_get_ref_and_mask,
>   };
>
>   static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev) @@
> -4389,25 +4428,8 @@ static void gfx_v12_0_ring_emit_hdp_flush(struct amdg=
pu_ring *ring)
>   {
>       struct amdgpu_device *adev =3D ring->adev;
>       u32 ref_and_mask, reg_mem_engine;
> -     const struct nbio_hdp_flush_reg *nbio_hf_reg =3D adev->nbio.hdp_flu=
sh_reg;
> -
> -     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> -             switch (ring->me) {
> -             case 1:
> -                     ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << r=
ing->pipe;
> -                     break;
> -             case 2:
> -                     ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << r=
ing->pipe;
> -                     break;
> -             default:
> -                     return;
> -             }
> -             reg_mem_engine =3D 0;
> -     } else {
> -             ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0;
> -             reg_mem_engine =3D 1; /* pfp */
> -     }
>
> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
> +&reg_mem_engine);
>       gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>                              adev->nbio.funcs->get_hdp_flush_req_offset(a=
dev),
>                              adev->nbio.funcs->get_hdp_flush_done_offset(=
adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 66a4e4998106..b3ea45e3c60f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2068,23 +2068,10 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_=
ring *ring)
>   static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>       u32 ref_and_mask;
> -     int usepfp =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ? =
0 : 1;
> -
> -     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> -             switch (ring->me) {
> -             case 1:
> -                     ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP2_MASK << ri=
ng->pipe;
> -                     break;
> -             case 2:
> -                     ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP6_MASK << ri=
ng->pipe;
> -                     break;
> -             default:
> -                     return;
> -             }
> -     } else {
> -             ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP0_MASK;
> -     }
> +     int usepfp;
> +     struct amdgpu_device *adev =3D ring->adev;
>
> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &usepfp);
>       amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>       amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait=
, write */
>                                WAIT_REG_MEM_FUNCTION(3) |  /* =3D=3D */ @=
@ -4075,12 +4062,46 @@
> static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
>       cik_srbm_select(adev, me, pipe, q, vm);
>   }
>
> +/**
> + * gfx_v7_0_get_ref_and_mask - get the reference and mask for HDP
> +flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring typ=
e and me.
> + */
> +static void gfx_v7_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +                                     uint32_t *ref_and_mask, uint32_t *r=
eg_mem_engine) {
> +     int usepfp =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ? =
0 : 1;

This doesn't look used inside this function.

> +
> +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
> +             ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ) {
> +             switch (ring->me) {
> +             case 1:
> +                     *ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP2_MASK << r=
ing->pipe;
> +                     break;
> +             case 2:
> +                     *ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP6_MASK << r=
ing->pipe;
> +                     break;
> +             default:
> +                     return;
> +             }
> +             *reg_mem_engine =3D 0;
> +     } else {
> +             *ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP0_MASK;
> +             *reg_mem_engine =3D 1;
> +     }
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v7_0_gfx_funcs =3D {
>       .get_gpu_clock_counter =3D &gfx_v7_0_get_gpu_clock_counter,
>       .select_se_sh =3D &gfx_v7_0_select_se_sh,
>       .read_wave_data =3D &gfx_v7_0_read_wave_data,
>       .read_wave_sgprs =3D &gfx_v7_0_read_wave_sgprs,
> -     .select_me_pipe_q =3D &gfx_v7_0_select_me_pipe_q
> +     .select_me_pipe_q =3D &gfx_v7_0_select_me_pipe_q,
> +     .get_ref_and_mask =3D &gfx_v7_0_get_ref_and_mask,
>   };
>
>   static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs =3D { diff
> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 5d6e8e0601cb..cc5acfcdf360 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5211,13 +5211,46 @@ static void gfx_v8_0_read_wave_sgprs(struct amdgp=
u_device *adev, uint32_t xcc_id
>               start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
>   }
>
> +/**
> + * gfx_v8_0_get_ref_and_mask - get the reference and mask for HDP
> +flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring typ=
e and me.
> + */
> +static void gfx_v8_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +                                     uint32_t *ref_and_mask, uint32_t *r=
eg_mem_engine) {
> +     struct amdgpu_device *adev =3D ring->adev;
> +
> +     if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) ||
> +         (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)) {
> +             switch (ring->me) {
> +             case 1:
> +                     *ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP2_MASK << r=
ing->pipe;
> +                     break;
> +             case 2:
> +                     *ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP6_MASK << r=
ing->pipe;
> +                     break;
> +             default:
> +                     return;
> +             }
> +             *reg_mem_engine =3D 0;
> +     } else {
> +             *ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP0_MASK;
> +             *reg_mem_engine =3D WAIT_REG_MEM_ENGINE(1); /* pfp */
> +     }
> +}
>
>   static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs =3D {
>       .get_gpu_clock_counter =3D &gfx_v8_0_get_gpu_clock_counter,
>       .select_se_sh =3D &gfx_v8_0_select_se_sh,
>       .read_wave_data =3D &gfx_v8_0_read_wave_data,
>       .read_wave_sgprs =3D &gfx_v8_0_read_wave_sgprs,
> -     .select_me_pipe_q =3D &gfx_v8_0_select_me_pipe_q
> +     .select_me_pipe_q =3D &gfx_v8_0_select_me_pipe_q,
> +     .get_ref_and_mask =3D &gfx_v8_0_get_ref_and_mask,
>   };
>
>   static int gfx_v8_0_early_init(struct amdgpu_ip_block *ip_block) @@
> -6000,25 +6033,9 @@ static void gfx_v8_0_ring_set_wptr_gfx(struct amdgpu_=
ring *ring)
>   static void gfx_v8_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>       u32 ref_and_mask, reg_mem_engine;
> +     struct amdgpu_device *adev =3D ring->adev;
>
> -     if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) ||
> -         (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)) {
> -             switch (ring->me) {
> -             case 1:
> -                     ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP2_MASK << ri=
ng->pipe;
> -                     break;
> -             case 2:
> -                     ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP6_MASK << ri=
ng->pipe;
> -                     break;
> -             default:
> -                     return;
> -             }
> -             reg_mem_engine =3D 0;
> -     } else {
> -             ref_and_mask =3D GPU_HDP_FLUSH_DONE__CP0_MASK;
> -             reg_mem_engine =3D WAIT_REG_MEM_ENGINE(1); /* pfp */
> -     }
> -
> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
> +&reg_mem_engine);
>       amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>       amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait=
, write */
>                                WAIT_REG_MEM_FUNCTION(3) |  /* =3D=3D */ d=
iff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e6187be27385..f2ebacc73eb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1997,6 +1997,40 @@ static void gfx_v9_0_select_me_pipe_q(struct amdgp=
u_device *adev,
>       soc15_grbm_select(adev, me, pipe, q, vm, 0);
>   }
>
> +/**
> + * gfx_v9_0_get_ref_and_mask - get the reference and mask for HDP
> +flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring typ=
e and me.
> + */
> +static void gfx_v9_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +                                     uint32_t *ref_and_mask, uint32_t *r=
eg_mem_engine) {
> +     struct amdgpu_device *adev =3D ring->adev;
> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =3D
> +adev->nbio.hdp_flush_reg;
> +
> +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
> +             ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ) {
> +             switch (ring->me) {
> +             case 1:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << =
ring->pipe;
> +                     break;
> +             case 2:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << =
ring->pipe;
> +                     break;
> +             default:
> +                     return;
> +             }
> +             *reg_mem_engine =3D 0;
> +     } else {
> +             *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->pi=
pe;
> +             *reg_mem_engine =3D 1; /* pfp */
> +     }
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs =3D {
>           .get_gpu_clock_counter =3D &gfx_v9_0_get_gpu_clock_counter,
>           .select_se_sh =3D &gfx_v9_0_select_se_sh, @@ -2004,6 +2038,7
> @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs =3D {
>           .read_wave_sgprs =3D &gfx_v9_0_read_wave_sgprs,
>           .read_wave_vgprs =3D &gfx_v9_0_read_wave_vgprs,
>           .select_me_pipe_q =3D &gfx_v9_0_select_me_pipe_q,
> +             .get_ref_and_mask =3D &gfx_v9_0_get_ref_and_mask,

Alignment mismatch?

>   };
>
>   const struct amdgpu_ras_block_hw_ops  gfx_v9_0_ras_ops =3D { @@
> -5380,25 +5415,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgp=
u_ring *ring)
>   {
>       struct amdgpu_device *adev =3D ring->adev;
>       u32 ref_and_mask, reg_mem_engine;
> -     const struct nbio_hdp_flush_reg *nbio_hf_reg =3D adev->nbio.hdp_flu=
sh_reg;
> -
> -     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> -             switch (ring->me) {
> -             case 1:
> -                     ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << r=
ing->pipe;
> -                     break;
> -             case 2:
> -                     ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << r=
ing->pipe;
> -                     break;
> -             default:
> -                     return;
> -             }
> -             reg_mem_engine =3D 0;
> -     } else {
> -             ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0;
> -             reg_mem_engine =3D 1; /* pfp */
> -     }
>
> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
> +&reg_mem_engine);
>       gfx_v9_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>                             adev->nbio.funcs->get_hdp_flush_req_offset(ad=
ev),
>                             adev->nbio.funcs->get_hdp_flush_done_offset(a=
dev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 89253df5ffc8..b4ba76110c34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -838,6 +838,40 @@ static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_d=
evice *adev, int ih_node)
>       return xcc - 1;
>   }
>
> +/**
> + * gfx_v9_4_3_get_ref_and_mask - get the reference and mask for HDP
> +flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring typ=
e and me.
> + */
> +static void gfx_v9_4_3_get_ref_and_mask(struct amdgpu_ring *ring,
> +                                     uint32_t *ref_and_mask, uint32_t *r=
eg_mem_engine) {
> +     struct amdgpu_device *adev =3D ring->adev;
> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =3D
> +adev->nbio.hdp_flush_reg;
> +
> +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
> +             ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ) {
> +             switch (ring->me) {
> +             case 1:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << =
ring->pipe;
> +                     break;
> +             case 2:
> +                     *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << =
ring->pipe;
> +                     break;
> +             default:
> +                     return;
> +             }
> +             *reg_mem_engine =3D 0;
> +     } else {
> +             *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->pi=
pe;
> +             *reg_mem_engine =3D 1; /* pfp */
> +     }
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs =3D {
>       .get_gpu_clock_counter =3D &gfx_v9_4_3_get_gpu_clock_counter,
>       .select_se_sh =3D &gfx_v9_4_3_xcc_select_se_sh, @@ -848,6 +882,7 @@
> static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs =3D {
>       .switch_partition_mode =3D &gfx_v9_4_3_switch_compute_partition,
>       .ih_node_to_logical_xcc =3D &gfx_v9_4_3_ih_to_xcc_inst,
>       .get_xccs_per_xcp =3D &gfx_v9_4_3_get_xccs_per_xcp,
> +     .get_ref_and_mask =3D &gfx_v9_4_3_get_ref_and_mask,
>   };
>
>   static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle, @@
> -2818,25 +2853,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amd=
gpu_ring *ring)
>   {
>       struct amdgpu_device *adev =3D ring->adev;
>       u32 ref_and_mask, reg_mem_engine;
> -     const struct nbio_hdp_flush_reg *nbio_hf_reg =3D adev->nbio.hdp_flu=
sh_reg;
> -
> -     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> -             switch (ring->me) {
> -             case 1:
> -                     ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << r=
ing->pipe;
> -                     break;
> -             case 2:
> -                     ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << r=
ing->pipe;
> -                     break;
> -             default:
> -                     return;
> -             }
> -             reg_mem_engine =3D 0;
> -     } else {
> -             ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0;
> -             reg_mem_engine =3D 1; /* pfp */
> -     }
>

It appears like gfx v9/9.4.3/10/11/12 all can be kept in some amdgpu_gfx_ge=
t_ref_mask generic helper, then it's not required to repeat the logic.

if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
        ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ) {
        switch (ring->me) {
        case 1:
                *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp2 << ring->pi=
pe;
                break;
        case 2:
                *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp6 << ring->pi=
pe;
                break;
        default:
                return;
        }
        *reg_mem_engine =3D 0;
        return;
}

if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_MES) {
        *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
        *reg_mem_engine =3D 0;
} else {
        *ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
        *reg_mem_engine =3D 1; /* pfp */
}


Thanks,
Lijo

> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
> +&reg_mem_engine);
>       gfx_v9_4_3_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>                             adev->nbio.funcs->get_hdp_flush_req_offset(ad=
ev),
>                             adev->nbio.funcs->get_hdp_flush_done_offset(a=
dev),

