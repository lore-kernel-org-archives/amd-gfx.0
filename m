Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35FFE95374
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 10:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565CD10E5AD;
	Wed,  4 Feb 2026 10:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NGtIINhb";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B3210E5AD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 10:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDCshZ8bfhTGLJOT/Ach2lWsYkMmh0KiTYSgdSpTt47f74oXm05M6FuO4LXBtZZ1FVlB9Vsg+OIXq/OIPpE9R7KAQXX/ClvM0faO/Lf4SeITE9i3z6fyVvjdxe1pYv/Y4ku/VR7RY1zHVxxNLus3ifny4JoD/UWnORsjw3ZY2Tue8c9b0QX8I8At1R7pbT/oBAOndoamSckG1wp9eJ6ZhKqh4bqkys5SwOty3QkTDTRhKo4ggMhCpMvOmx6pWEfgy1Lr3YW7sDC+MGbXtYTMistMrhkC0v4P8/C+2F9KJb42O7GJloQe/oHcX7XGcQf+Aa5EWet+bfc75wCbABUYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rftLeib5/deWivbf5ji69AhVnXeEchyFepWWUYzMnU=;
 b=Th9X/FMjyLuqVUWkmeaXkFCaFVAo07CXOh6q0WWsZQCyt9a19rbvRJMekQ0VjgdfddKDWDCNuBwm/REm0b9tmVZRoUCcZ1VmcmCC5nY18OxEBy8hMZH5Mw+ENnhssxIh7+7+EVdPJOkKDU6GdmoO3jJQLuS8DuUwhARpR4A80XYFCSDzGaYlPBHJNpeFdgufEkwrggdDW5m1AI3ts0c3ZXvN9+GvrkDTTOzb/xuaYB+0ax9xXB9pqYnGugDS5oWZWfaLriuvRru4dVKPM1RXBq0dFEQCuVhPrJBdg6BFdd2xhkGvkKqYcy6ZM1B7kqoIZcy7NuxyhUcXPG+MrJChKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rftLeib5/deWivbf5ji69AhVnXeEchyFepWWUYzMnU=;
 b=NGtIINhbB6YRzmjh/XqDJfBvkalVaFX1utL1GpNUaRShmnLJFC80eDVKyCVrdJcqnZQNQcMTmfDa9NV8F8TftPsRjkejcQ/dZ4u3G7GNF+phNNGDIZdOI6A+zDWs93uht3nsf1PVacAZtIALJ5Nc4SkVmd4IBTuKdsh1C8HSAbc=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 BN7PPF9E4583E15.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dc)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 10:12:45 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 10:12:45 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Remove redundant and incorrect multi-vf
 check
Thread-Topic: [PATCH v2] drm/amd/pm: Remove redundant and incorrect multi-vf
 check
Thread-Index: AQHcla/u8m+P9r/UQ0OM9soipsqvNrVyRquAgAAJh4CAAAEOoA==
Date: Wed, 4 Feb 2026 10:12:45 +0000
Message-ID: <DS7PR12MB6071888802F9511F9040F1468E98A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260204082547.3799740-1-asad.kamal@amd.com>
 <13ffc589-243b-41f6-b219-9136fbcaf09d@amd.com>
 <PH7PR12MB59970022C8B598A0111B4F478298A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59970022C8B598A0111B4F478298A@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-04T10:00:05.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|BN7PPF9E4583E15:EE_
x-ms-office365-filtering-correlation-id: 273ec17f-5fe0-47e9-af5b-08de63d5f0f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?AsBRHnsy3TFpCOVlV+3q6/cQWh3CAg4kNryFvhS4z2VmJ5WaIDEhgBrRXvx/?=
 =?us-ascii?Q?tQ9qWXEXz2f5ab9BYPgO+rsO4XZriLZY8m/xQU1/BoX1FprNoJUCTkL5aHFL?=
 =?us-ascii?Q?vIqdA8nQA/pwXopgHeNAC9ZQ9bOJZqAXs7VZZCetOyDpiPSvM+2eaMoomB0l?=
 =?us-ascii?Q?GQ93Wgs2ws8uvRejddcPmON43zls7SdGMoZwjumVBJo7+QzQnBwfewmQ4rMN?=
 =?us-ascii?Q?Z4aMUkyvG4eMLAS3iRp9ZLEQBC7jKrJkPmYpbdKHJzx9Rmb/MiklOADpf+cB?=
 =?us-ascii?Q?MsNc61QLM974ciJcPIb1/n1D3hntVUm8LELy88dPpofdG/FImIWfGIFb2KCe?=
 =?us-ascii?Q?KO2PSvlITy8vZFd2Pze38UlUZoew6ZNyWxMAWyg4Hl6Ly7eACaUnD+KeMJCO?=
 =?us-ascii?Q?k/9ZLX74grGeqgozxtEQERxLMsWkjKVduHxtYzVDxm7GrhJAGg6ud7iWOfv3?=
 =?us-ascii?Q?nJgqM7WAzBzW07+qX0S1YolcSE+KDWJfYeyS4YrrQSZl+BOjtlKZ7JqBny2D?=
 =?us-ascii?Q?dNqX4CJxTMJpvdqWfAPsjYszTTQqOrbYyvIT0CuCAnPFjIRNGYohxc5RDtrv?=
 =?us-ascii?Q?UawOGqgSnsF2WF1ZY5t5bcmIJBPlnMoxX0ppUjiUtrGfJ7Xvh8WSkGotciod?=
 =?us-ascii?Q?dfRdaRpZC0inC4fz/lpsbnajO3W4GC2SE/K6HRqlVdKPc6CGtmZGVrtVgilh?=
 =?us-ascii?Q?e7+bvKRLaoLbl1iVHEklfPrf6HlaoZZGUznzhILiPMqjkWdwXeBrjCLLV7tQ?=
 =?us-ascii?Q?wMx/7nxeuDar/JOnbgQ1E4FZNjVJ/TuQVt1VM35yJ+zF4OGwNLxwAmLK3H1x?=
 =?us-ascii?Q?xUNvw9HKSSTS3seewbRR1ZPZQ+urIwvmS47AfYSWCgTB7FugjQPk+VOcX3Xb?=
 =?us-ascii?Q?/ixCbsAMs68P66h3G4ATCvhU+YIKEMMAP2GfXGgJgCGeLNkvJQnBwF8I+qxE?=
 =?us-ascii?Q?B+ds2Nf98oXjeRI2gPFUKINr95A1g7t3OLPE7QjObU51uZIp31z2rlOWTW9o?=
 =?us-ascii?Q?y+RP9AnY/4QZJr6eG5gCwZFKaNZo/R/y2VgxTZ59ODwbQ3RFTKzR4bGuWdlG?=
 =?us-ascii?Q?8e9n8hPQSHAxsR+La7uzSN4n7lByOA6gAvl4X26LDA2DO7qXbWOQaoqLkbSU?=
 =?us-ascii?Q?jBmrGaeF5xjSn1l7ai9NAXv4OplZbF0UajjatGAH88/m9QaHV80Ay46xrdcx?=
 =?us-ascii?Q?Ibpf6pThzmVnWD8x4Sbjokq2GDqDvyEfpUfz59ZXQGq0l23CUVnLE0ZYLuZT?=
 =?us-ascii?Q?icXYT/ObeB/z4teSx5XBa5cYgIu6JR/BxFKZekPkL9g+g+1vKB78WY0pRkgU?=
 =?us-ascii?Q?7RY/1G/2huCS3lY1bL4x15uaM2/LrO/h7yTo4jaKxpapvV4jhNugf4TMPzOg?=
 =?us-ascii?Q?ZBdabKFUyqr4DtPPd6UUEb7abFoXPYpMX/x5t1M1ZtlFR2O+XHDhHX5LMNux?=
 =?us-ascii?Q?Emw1q66vLfLjwpxCdcR4qpvbErufUVMvpscIZljAa7bnJ8Qv3LQV9fUPFqZI?=
 =?us-ascii?Q?8I5REj7JNR3/606Ukm3H63WN1E819uoRbK7Ef0SW6Bx6AqGf6IaoMUROhw4b?=
 =?us-ascii?Q?8FtKgxV1Ev4XAX9NIxvJ4IizaTlp7OhXiRxsLT8IPXR1Qu+Y8f+3P/cuwAcl?=
 =?us-ascii?Q?tOX7rkuUnQ1Wy8RyCIDlD0k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7JQ+NhOdKwZyZSqKizg71lOajV0vnKFv1MDfHtsTN9twMl3ZjuCz+5392917?=
 =?us-ascii?Q?M8sNWnFnbUoB3M4Ngmu0ySsNnCZ05n9V0yFTQC0KjlBbe2bViuQL7ThPiw7T?=
 =?us-ascii?Q?ukh3GMeHKcK4rrwfXxBzQ64oZYzFEWBWbVjj3weaVoWb9tZ/UjxN5PUmT+hr?=
 =?us-ascii?Q?O5paDzxJHrpLwUf18xFUtXpr01FDqL7ZVD/N64nsmp8N8qUqp4XnXBj6EqdW?=
 =?us-ascii?Q?OduCTgWe3TnAdGZpMBbpW63MUgi3tHkvoSRrOL7kZeddERDQoh6mLe42AIbV?=
 =?us-ascii?Q?WnPa4hvvNWZuxy+8J4Dns7OWwOSQI1xDbU/hlE99OzRRGaUrdMwTK7OZiDll?=
 =?us-ascii?Q?2hD4lz7y5JbVAKBlm23Sl/SzysN2kz6Nyx69Z6J/8kHAnuy8lU/ybfU9x2mG?=
 =?us-ascii?Q?uJcYchuJA00ekBDgGAxO6b2gR+ay/RKiRIWtnSuXiOzVPM4ncHctaHZMO/OC?=
 =?us-ascii?Q?Py4xy1s8FPbM17tFZmYw667W4zVJsgHM40rYN81Bslosj7xtWIZGoQKrjxBV?=
 =?us-ascii?Q?dxYaxQv5cwjwyjZOlTdMPVIsuskPhcnF1ULy3Auk2V9H9jcb3CGrwOkgik/K?=
 =?us-ascii?Q?2p5r1XKT2h3n4lxB45bEsKuFDPtsLn6LFtZpMlZ3sRhXwwwYZNwybw2liJfk?=
 =?us-ascii?Q?eEz7G6iTaHBxW4mKJ2BAp1vk81dRmmNlfu/imqluChFIGzfvpP/c3inZEhA0?=
 =?us-ascii?Q?hZwdTbEk8wmnnTy5bn18Oy0AVOPom58/uD4MyMV1BqqGf7XZquK4kEQ2/cUs?=
 =?us-ascii?Q?Cp4MGy49yga/9UaGBEwY9ILuSBVsnx7nQkE9YuY6E//6jOyJSfqINayjyeqg?=
 =?us-ascii?Q?Vd2oYhZc9AFejCBCaboxbl44tzoZJhBlfUhfP6EFO42NpSLF9w4bvXkdl7aV?=
 =?us-ascii?Q?ntVlv3iz/OHD9mukgi2UKE3ZKYHI6afbDQxAsqgsV8g1yK224SwS7HGF6WH4?=
 =?us-ascii?Q?Yad5sYmVayXNPTmxvd+lVr+J+7cXdFXUuMsLvi9KDr6MAs0uJzK+aYOrRiTT?=
 =?us-ascii?Q?jYGH7eQGGYSO5KPDwNntL/0OhwI2UW2sLxmesqeQ64sacIiMlOimRPJyKRdN?=
 =?us-ascii?Q?b91rb66wnjklpOud2QiopfUVQdll4tw8unD7hXTvPismblT6grS7QuNaZTy5?=
 =?us-ascii?Q?5j712bGH9TiEywPtoREFzzfKi4sMtc4JrRHq2EthlcgKu2wff6AanRrQYbL0?=
 =?us-ascii?Q?BPgzFqOKLb+Vgnuc4WP/enu0OQDtgx8wVdy1Pv366zqmnv+5ITBccnhj/zuJ?=
 =?us-ascii?Q?OezV7UPGQlb+yb3CAznvM7KdjDNk9G3x5l9tz89haecNKF/fBp5OPiM1wlIQ?=
 =?us-ascii?Q?zVDDGIce7vgdS+DUzUlfoaLINNkQPkdidxahjmB61zrqPKqt4zBhE6Plnspn?=
 =?us-ascii?Q?9FfAKxI9KTuIXsPN0IKSxQ6KufMKOghRP8+1d88WaB1Wk8ebJ3bI3iuCWsRT?=
 =?us-ascii?Q?YYtEmBTPp8xHCKCGNjdGRUhnvfqGAxrXf1fV4PLTvSEnsNtzPFTvN1s7XZNW?=
 =?us-ascii?Q?OeHdzFBXpAUud2HH3HLGkJb8TBQ5iaP2zvBj9YHV/O2A+llsTGYxEaPjfVJ1?=
 =?us-ascii?Q?8iwmhv9WhD0FmroFUomzPxImS8bztbEoMUYNx7AQKg1t0ddZdQS8Wr01HkKf?=
 =?us-ascii?Q?6vo+dE34Sc/DkNd/opeVoeviZOGet/xa4wBParaQT0eVev9bSOtL7koTHXCN?=
 =?us-ascii?Q?SWQJzbahV2JEw+aiyx300Ai2yQN+7kXvJYuXqhb0su4+h5M6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273ec17f-5fe0-47e9-af5b-08de63d5f0f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 10:12:45.4628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aUfQdQuGxpE6ST0x+tjwoSG4A+zbxbuE+HEdwrUXZryv+dOxEN2JZrPYq8Ab/pdS3iXfKNdvWDWfIZ4o1P3Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15
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

Hi Kevin,

So, you say setting should not be allowed in 1VF mode as well? Comment says=
 otherwise

-     /* setting should not be allowed from VF if not in one VF mode */

Thanks & Regards
Asad


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, February 4, 2026 3:35 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; amd=
-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>
Subject: RE: [PATCH v2] drm/amd/pm: Remove redundant and incorrect multi-vf=
 check

[AMD Official Use Only - AMD Internal Distribution Only]

> Remove redundant and incorrect multi-vf check for pp clock setting, as
> the code path will never be taken. Mask check take care of same.

I suspect there might be a misunderstanding of the code logic here. This is=
 not redundant code.
Currently, AMDGPU does not support the multi-vf case, so no sysfs node will=
 be created for it.
However, in one-vf mode, for security reasons, setting frequency informatio=
n from the vf side is not allowed.
Therefore, the .store interface is removed and the node permissions are con=
figured as read-only.
In conclusion, this segment of code serves a clear purpose and is by no mea=
ns redundant.

Best Regards,
Kevin
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, February 4, 2026 5:31 PM
To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: Re: [PATCH v2] drm/amd/pm: Remove redundant and incorrect multi-vf=
 check



On 04-Feb-26 1:55 PM, Asad Kamal wrote:
> Remove redundant and incorrect multi-vf check for pp clock setting, as
> the code path will never be taken. Mask check take care of same.
>
> v2: Update patch title, Remove the check (Kevin)
>
> Fixes: 166a3c735c95 ("drm/amd/pm: centralize all pp_dpm_xxx attribute
> nodes update cb")
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

You may drop any redundant multivf check in other attr_update calls also.

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 07641c9413d2..81bef5c5aae9 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2057,12 +2057,6 @@ static int pp_dpm_clk_default_attr_update(struct a=
mdgpu_device *adev, struct amd
>               break;
>       }
>
> -     /* setting should not be allowed from VF if not in one VF mode */
> -     if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
> -             dev_attr->attr.mode &=3D ~S_IWUGO;
> -             dev_attr->store =3D NULL;
> -     }
> -
>       return 0;
>   }
>


