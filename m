Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D220C7EE24
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 07:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FFF510E138;
	Mon, 15 May 2023 07:04:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5FA10E138
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 07:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFOJXM8+9D2hWK7yVN/zNanmJmPUnrFX/MeNYQ3eV96Cyg+UfyxT0RktgR23eXpj1ABbXe7im+W+CATwBYhtKLKW+DeXF59C/8XlF8/AEmKVTWFet9KR4YE5H7zOu0Cu4ILHK8ORJFT+Y5oQjm03s/x/z5OeQhgtINaRxVliTr7s3MgFMK9jhvZCt4dSXvLvIazgqsapNfjwa144iA3fpBOBmVREuKGLWNmUscWI4FbVsvPT4VKfnypKtdZOLWYO8mrfAWBCkgqSP2KguUd+TPd1J7L0E16tineCJQEF6YZomg3J9ss41jwl038bPERUmiznDkr8j9DsTkbrr0bjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njfv70fbXJ0VXCBSsUFsDAozMXqss6Ew+fGG2obioj8=;
 b=MoLQ3qVFpYwD6voPm0lIXt27yCBQMvQ03Sd6v1peUlCtOXATlUbBga6sKaPs4AvHf4z0eQ3XnZ8YF/hnrbsN5zX6F5OQNzZfFutzZMNUWesW83V+gjqNRHzirQgJKw/a+Q0tlI/MzLxbyMwmkOfQu5R8bTTxctvG40o4POwpDq8QFSuIBG32gIpDq/HS+vFWqE5nR19bGkowfRsbhFaB4SyItSpHCL93Lpzc1tDVSyrTQIc/hIaZGo5pVw18+75BgKvB+lnqogz6VXs55JijVYPq7kjjyFTTxPPP7QgOKIfBr8x778B3VlfkzjirX2ixT+A1N7Y4Gjfj95K6LIzO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njfv70fbXJ0VXCBSsUFsDAozMXqss6Ew+fGG2obioj8=;
 b=j+Y8y7wuM8Rx3j+JpD+idoO5AY6rpvjoUipSJs40WaAQI2CTKYqNjN4gS7667ox+M4UcWxo0ontXvarh+3VTGMZopnEpSydtW4YJrjUugTk+Z9r2j8sKoJSFMDA+XdNGcGvYPGaeTveFeiiPWJUAkBgZ6HH2SeUnRDV2Pt22uJE=
Received: from SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 07:04:40 +0000
Received: from SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::173c:337c:7c97:781]) by SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::173c:337c:7c97:781%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 07:04:40 +0000
From: "Zhang, Horatio" <Hongkun.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/2] drm/amdgpu: separate ras irq from vcn instance irq
 for UVD_POISON
Thread-Topic: [PATCH v2 1/2] drm/amdgpu: separate ras irq from vcn instance
 irq for UVD_POISON
Thread-Index: AQHZhtToGZG5j2V1OEi5t1r2rimwFq9a4eQAgAAG6HA=
Date: Mon, 15 May 2023 07:04:40 +0000
Message-ID: <SN1PR12MB259129EEB49184FA97ED1F70F7789@SN1PR12MB2591.namprd12.prod.outlook.com>
References: <20230515022803.9482-1-Hongkun.Zhang@amd.com>
 <DM5PR12MB1770E84AADF9715877769667B0789@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1770E84AADF9715877769667B0789@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-15T07:04:35Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3eb836b9-1e41-4512-a7a8-f77342996b51;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-15T07:04:35Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: e08a61e8-760f-4d51-90e3-2500320b27fb
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2591:EE_|LV2PR12MB5725:EE_
x-ms-office365-filtering-correlation-id: 9ea8d1e0-4c04-4a58-d39a-08db5512a6e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bV04OSeZPhrqIKB+STBVWdLxa8Y5LgzFD0TUI8utI0X39jut2LYy+vvXiMs2n0Y7PLEHhcd1s55dmzIuzG5bylsx/P7DSsle64j+KbP5mxt0A9oZG67XdjDmqUaNkpZ8Fvbij9pHu+x4wZz32IttM+fwsmuZOmyJTZN4AJwJYIImXrKClkWxPc3eRDwOPPWtrlyfCca8Np7mpsuld92ncRISMefFTHR/8D+EbN+v1NJt9fErnISutIbbwGcJoaAdNQej9PUZFQ+SkhDFpNTicnSAKPsTl+3cwwy2bg8r9W/F6Z0danKOmd9I6uaRs2VihoJGG1llCaBgkHU1OTrAYYkS+hnNbgxrnSWTBrMGFma69XQFta+6fTWXbZHwgUsT8ayWi0yQxs5un/DLo/DPzBZPHg6Ki99Ls6FuXT8NGpHNGQZBLV9vBR9c9Euqm9zeqpIHrrLa4JdJ5yIEgrGx1i4k37KuydR9SDyhql8m74AKQ3nkCZgdi62escOyTxAFQf0JhFFcq4CnbAJwaYNN+2SueU/lOwWRUeSYh6ZOgPitxBcWzr1SfG1WDZLpqgT9T64gNpoP/S1BZLpoxveYwHpmxDG8VF1vdJg/uAMG8BuLq9VPOfsrKFY8wSVIZKPJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2591.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(39850400004)(396003)(451199021)(478600001)(110136005)(54906003)(5660300002)(8676002)(8936002)(52536014)(2906002)(30864003)(38070700005)(86362001)(33656002)(4326008)(64756008)(66476007)(66556008)(66446008)(76116006)(316002)(66946007)(122000001)(55016003)(41300700001)(38100700002)(83380400001)(53546011)(6506007)(26005)(9686003)(186003)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vs6MyDzkeOruNqsSZQezl9GfR7DQoJePXCO5trfDTO7s4pmeTF6a6ScpXiLg?=
 =?us-ascii?Q?bAmk3b5NvmTHFtWlTJYulDacJfTINcUtwvHi+4GYBVC/0+2htqQriMrYT/0i?=
 =?us-ascii?Q?BP50csQhCZZtXLW5uMU4wyQxpY4UCZq1cW6RaWun4r1Th9ao4wum/n0xj/E+?=
 =?us-ascii?Q?i9YRi0kFjnSyC9UbDvo0FF5d9OmNVcWpSf5djfLLqj2BHAVnwq4QXzSpT/IV?=
 =?us-ascii?Q?K6gltMoxd2DEw/80f20VwDOYCWCa7NWcbjmCWBo20QworRJK6suBCo0gmW+a?=
 =?us-ascii?Q?ZZ28dYgKFifuQCpNPlCbgzAGxLty2mnDUl+yGcxcyvrW8Z2h1fCsZlUrMXfA?=
 =?us-ascii?Q?1J+nTdgpF5VZ0Y0/jotf3hDGiHmIrNdonAYRsQBs3Xb3OyMeCYM7qR+eRsB1?=
 =?us-ascii?Q?kthfyyFstzvAHmKMbW1LeSS8iwGGLIiYutRtjXaJBsGrz3+PBf6MDab+DtxF?=
 =?us-ascii?Q?heOx44RNy+TVddGiWKiDUKPTlqhPzb+i/Rl+zJilQvt336Uec8RrJ+yxqObC?=
 =?us-ascii?Q?e734pxDom/l9sUq5+VbBlKUpGdPDAknuaTOmSZj/2Ur9ZMkpw3ECDnfQZVaf?=
 =?us-ascii?Q?sxmetFDymI/Eh7GX15lQbJsqNiRMaVIB9UAUYh22zm9c/W5428y8yeOmxs2J?=
 =?us-ascii?Q?Hh87VBu1jKhN/I76gixL8AYlAsvL52Bv2eN9/0ZY4rYp1ns2407NXyOr+br+?=
 =?us-ascii?Q?xqkIVvHbTYgyHOdfZ6Ck0QBX4HOezSvUWS86sUtCJhu91T8+8QTAxFmjDZGM?=
 =?us-ascii?Q?8emmkMzs8WQjTxczR+b7n+o0LAuR29QkU4SGBaMCDOW6TLm1u0V4JpuBnwi8?=
 =?us-ascii?Q?Gp/Myvnaky94n+PHxZLGSl6sB4X4BJ+Ciwc46NtOn/3X1Vj8vgXsv5jsMXak?=
 =?us-ascii?Q?qKqaJ/shhKuZs+6GnvR2i7X8QVh3QshbT9xITIC+dk0Yh7P9/+WNfbQlKEuJ?=
 =?us-ascii?Q?y68Q072IDpNRItQ652lb11iA59HaPNNs28/neJ29RaAIfsnSXoqynr/WsMWA?=
 =?us-ascii?Q?i6cUBlkuM37iwWl/0c+j3C5hdZtNw5r60A8Q8xOOBOVIy42MB3vSgOQ6zLUa?=
 =?us-ascii?Q?PkMpDD18555r2GGc07hX+RfVQAOE8EY1pS+nZcaR1ljVNBwI+5K+r6+7W5RE?=
 =?us-ascii?Q?dm+/bx5596JQ62WQbm1Dz9fEflLWsqQjqq4a9wQeMvtBm7ZdBMbCyFfRx9oJ?=
 =?us-ascii?Q?lK4zodCbLTVhoC1e9YczEb/gmmbMgXeoJFGk543DR4QJC57p8Zlu37aPdg8c?=
 =?us-ascii?Q?Fhqb+bkh/8lVkP0zHXPznq0+SaZCSVuhSCQTrkUtZwj74Je536+JUZ9+ilTc?=
 =?us-ascii?Q?OnWHQJPFBc4MyUe71pieHNLrcyZE/DZXI+eu5MCtd7UNfCMqkiBq6E7DOQ8p?=
 =?us-ascii?Q?BzqEOnjtxG1w+glIRIVSRUKL3ccreoSAcNaQezqo8jaxcl7N/aUiREfFCPM8?=
 =?us-ascii?Q?qeKDMAmoP+YiNfm/kmP/eY6/CuTPikpS0W95vOQ+dJ3VGiSajNN51MhfffUq?=
 =?us-ascii?Q?I+qugOW08w+Wb1qN0aOJqRp62pDTCfUwbM6BaqJxLJ0ht1vSqK4rrHDsY7ah?=
 =?us-ascii?Q?rPAoDadW4z0Ql3d50CY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2591.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea8d1e0-4c04-4a58-d39a-08db5512a6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 07:04:40.0590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzsmNSWM9GL2Bo5c39vIbDnaQTkGRGYE4K7FDva/lsIlXdYIYuNQfIfXcMhs7WiAT0Wt7mKKlixLAqOpQuVn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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
Cc: "Liu, HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Zhou,
 Bob" <Bob.Zhou@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Jiang,
 Sonny" <Sonny.Jiang@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thank you for your suggestion, I will split these two patches in the next v=
ersion.

Regards,
Horatio

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, May 15, 2023 2:38 PM
To: Zhang, Horatio <Hongkun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciell=
o, Mario <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan) <HaoPing.Liu@amd.=
com>; Zhou, Bob <Bob.Zhou@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>;=
 Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amdgpu: separate ras irq from vcn instance =
irq for UVD_POISON

[AMD Official Use Only - General]

The code is fine with me, but it's better to split the patch into three par=
ts, one is for common vcn code, one is for vcn 2.6 and the third one is for=
 vcn 4.0.

Regards,
Tao

> -----Original Message-----
> From: Horatio Zhang <Hongkun.Zhang@amd.com>
> Sent: Monday, May 15, 2023 10:28 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao=20
> <Tao.Zhou1@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo=20
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciello,=20
> Mario <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan)=20
> <HaoPing.Liu@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>; Zhang, Horatio=20
> <Hongkun.Zhang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH v2 1/2] drm/amdgpu: separate ras irq from vcn instance=20
> irq for UVD_POISON
>=20
> Separate RAS poison consumption handling from the instance irq, and=20
> register dedicated ras_poison_irq src and funcs for UVD_POISON. Fix=20
> the amdgpu_irq_put call trace in vcn_v4_0_hw_fini.
>=20
> [   44.563572] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
> [   44.563629] RSP: 0018:ffffb36740edfc90 EFLAGS: 00010246
> [   44.563630] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
> 0000000000000000
> [   44.563630] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   44.563631] RBP: ffffb36740edfcb0 R08: 0000000000000000 R09:
> 0000000000000000
> [   44.563631] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff954c568e2ea8
> [   44.563631] R13: 0000000000000000 R14: ffff954c568c0000 R15:
> ffff954c568e2ea8
> [   44.563632] FS:  0000000000000000(0000) GS:ffff954f584c0000(0000)
> knlGS:0000000000000000
> [   44.563632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   44.563633] CR2: 00007f028741ba70 CR3: 000000026ca10000 CR4:
> 0000000000750ee0
> [   44.563633] PKRU: 55555554
> [   44.563633] Call Trace:
> [   44.563634]  <TASK>
> [   44.563634]  vcn_v4_0_hw_fini+0x62/0x160 [amdgpu]
> [   44.563700]  vcn_v4_0_suspend+0x13/0x30 [amdgpu]
> [   44.563755]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
> [   44.563806]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
> [   44.563858]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
> [   44.563909]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
> [   44.564006]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
> [   44.564061]  process_one_work+0x21f/0x400
> [   44.564062]  worker_thread+0x200/0x3f0
> [   44.564063]  ? process_one_work+0x400/0x400
> [   44.564064]  kthread+0xee/0x120
> [   44.564065]  ? kthread_complete_and_exit+0x20/0x20
> [   44.564066]  ret_from_fork+0x22/0x30
>=20
> Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 ++++++++++++++++++-=20
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 24 ++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 35 ++++++++++++++++++++-----
>  4 files changed, 78 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index e63fcc58e8e0..f53c22db8d25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1181,6 +1181,31 @@ int amdgpu_vcn_process_poison_irq(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> +int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev, struct=20
> +ras_common_if *ras_block) {
> +	int r, i;
> +
> +	r =3D amdgpu_ras_block_late_init(adev, ras_block);
> +	if (r)
> +		return r;
> +
> +	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
> +		for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
> +
> +			r =3D amdgpu_irq_get(adev, &adev-
> >vcn.inst[i].ras_poison_irq, 0);
> +			if (r)
> +				goto late_fini;
> +		}
> +	}
> +	return 0;
> +
> +late_fini:
> +	amdgpu_ras_block_late_fini(adev, ras_block);
> +	return r;
> +}
> +
>  int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)  {
>  	int err;
> @@ -1202,7 +1227,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device
> *adev)
>  	adev->vcn.ras_if =3D &ras->ras_block.ras_comm;
>=20
>  	if (!ras->ras_block.ras_late_init)
> -		ras->ras_block.ras_late_init =3D amdgpu_ras_block_late_init;
> +		ras->ras_block.ras_late_init =3D amdgpu_vcn_ras_late_init;
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index c730949ece7d..802d4c2edb41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -234,6 +234,7 @@ struct amdgpu_vcn_inst {
>  	struct amdgpu_ring	ring_enc[AMDGPU_VCN_MAX_ENC_RINGS];
>  	atomic_t		sched_score;
>  	struct amdgpu_irq_src	irq;
> +	struct amdgpu_irq_src	ras_poison_irq;
>  	struct amdgpu_vcn_reg	external;
>  	struct amdgpu_bo	*dpg_sram_bo;
>  	struct dpg_pause_state	pause_state;
> @@ -400,6 +401,8 @@ void amdgpu_debugfs_vcn_fwlog_init(struct
> amdgpu_device *adev,  int amdgpu_vcn_process_poison_irq(struct
> amdgpu_device *adev,
>  			struct amdgpu_irq_src *source,
>  			struct amdgpu_iv_entry *entry);
> +int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev,
> +			struct ras_common_if *ras_block);
>  int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
>=20
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index ab0b45d0ead1..44262d67b3ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -143,7 +143,7 @@ static int vcn_v2_5_sw_init(void *handle)
>=20
>  		/* VCN POISON TRAP */
>  		r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
> -			VCN_2_6__SRCID_UVD_POISON, &adev-
> >vcn.inst[j].irq);
> +			VCN_2_6__SRCID_UVD_POISON, &adev-
> >vcn.inst[j].ras_poison_irq);
>  		if (r)
>  			return r;
>  	}
> @@ -354,6 +354,9 @@ static int vcn_v2_5_hw_fini(void *handle)
>  		    (adev->vcn.cur_state !=3D AMD_PG_STATE_GATE &&
>  		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
>  			vcn_v2_5_set_powergating_state(adev,
> AMD_PG_STATE_GATE);
> +
> +		if (amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__VCN))
> +			amdgpu_irq_put(adev, &adev-
> >vcn.inst[i].ras_poison_irq, 0);
>  	}
>=20
>  	return 0;
> @@ -1807,6 +1810,14 @@ static int vcn_v2_5_set_interrupt_state(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> +static int vcn_v2_6_set_ras_interrupt_state(struct amdgpu_device *adev,
> +					struct amdgpu_irq_src *source,
> +					unsigned int type,
> +					enum amdgpu_interrupt_state state) {
> +	return 0;
> +}
> +
>  static int vcn_v2_5_process_interrupt(struct amdgpu_device *adev,
>  				      struct amdgpu_irq_src *source,
>  				      struct amdgpu_iv_entry *entry) @@ -1837,9
> +1848,6 @@ static int vcn_v2_5_process_interrupt(struct amdgpu_device=20
> +*adev,
>  	case VCN_2_0__SRCID__UVD_ENC_LOW_LATENCY:
>  		amdgpu_fence_process(&adev-
> >vcn.inst[ip_instance].ring_enc[1]);
>  		break;
> -	case VCN_2_6__SRCID_UVD_POISON:
> -		amdgpu_vcn_process_poison_irq(adev, source, entry);
> -		break;
>  	default:
>  		DRM_ERROR("Unhandled interrupt: %d %d\n",
>  			  entry->src_id, entry->src_data[0]); @@ -1854,6
> +1862,11 @@ static const struct amdgpu_irq_src_funcs=20
> +vcn_v2_5_irq_funcs =3D {
>  	.process =3D vcn_v2_5_process_interrupt,  };
>=20
> +static const struct amdgpu_irq_src_funcs vcn_v2_6_ras_irq_funcs =3D {
> +	.set =3D vcn_v2_6_set_ras_interrupt_state,
> +	.process =3D amdgpu_vcn_process_poison_irq, };
> +
>  static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)  {
>  	int i;
> @@ -1863,6 +1876,9 @@ static void vcn_v2_5_set_irq_funcs(struct=20
> amdgpu_device *adev)
>  			continue;
>  		adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rings + 1;
>  		adev->vcn.inst[i].irq.funcs =3D &vcn_v2_5_irq_funcs;
> +
> +		adev->vcn.inst[i].ras_poison_irq.num_types =3D adev-
> >vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].ras_poison_irq.funcs =3D
> &vcn_v2_6_ras_irq_funcs;
>  	}
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index bf0674039598..1dfc7cee6d59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -139,7 +139,7 @@ static int vcn_v4_0_sw_init(void *handle)
>=20
>  		/* VCN POISON TRAP */
>  		r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> -				VCN_4_0__SRCID_UVD_POISON, &adev-
> >vcn.inst[i].irq);
> +				VCN_4_0__SRCID_UVD_POISON, &adev-
> >vcn.inst[i].ras_poison_irq);
>  		if (r)
>  			return r;
>=20
> @@ -305,8 +305,8 @@ static int vcn_v4_0_hw_fini(void *handle)
>                          vcn_v4_0_set_powergating_state(adev, AMD_PG_STAT=
E_GATE);
>  			}
>  		}
> -
> -		amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
> +		if (amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__VCN))
> +			amdgpu_irq_put(adev, &adev-
> >vcn.inst[i].ras_poison_irq, 0);
>  	}
>=20
>  	return 0;
> @@ -1975,6 +1975,24 @@ static int vcn_v4_0_set_interrupt_state(struct
> amdgpu_device *adev, struct amdgp
>  	return 0;
>  }
>=20
> +/**
> + * vcn_v4_0_set_ras_interrupt_state - set VCN block RAS interrupt=20
> +state
> + *
> + * @adev: amdgpu_device pointer
> + * @source: interrupt sources
> + * @type: interrupt types
> + * @state: interrupt states
> + *
> + * Set VCN block RAS interrupt state
> + */
> +static int vcn_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
> +	struct amdgpu_irq_src *source,
> +	unsigned int type,
> +	enum amdgpu_interrupt_state state)
> +{
> +	return 0;
> +}
> +
>  /**
>   * vcn_v4_0_process_interrupt - process VCN block interrupt
>   *
> @@ -2007,9 +2025,6 @@ static int vcn_v4_0_process_interrupt(struct=20
> amdgpu_device *adev, struct amdgpu_
>  	case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
>  		amdgpu_fence_process(&adev-
> >vcn.inst[ip_instance].ring_enc[0]);
>  		break;
> -	case VCN_4_0__SRCID_UVD_POISON:
> -		amdgpu_vcn_process_poison_irq(adev, source, entry);
> -		break;
>  	default:
>  		DRM_ERROR("Unhandled interrupt: %d %d\n",
>  			  entry->src_id, entry->src_data[0]); @@ -2024,6
> +2039,11 @@ static const struct amdgpu_irq_src_funcs=20
> +vcn_v4_0_irq_funcs =3D {
>  	.process =3D vcn_v4_0_process_interrupt,  };
>=20
> +static const struct amdgpu_irq_src_funcs vcn_v4_0_ras_irq_funcs =3D {
> +	.set =3D vcn_v4_0_set_ras_interrupt_state,
> +	.process =3D amdgpu_vcn_process_poison_irq, };
> +
>  /**
>   * vcn_v4_0_set_irq_funcs - set VCN block interrupt irq functions
>   *
> @@ -2041,6 +2061,9 @@ static void vcn_v4_0_set_irq_funcs(struct=20
> amdgpu_device *adev)
>=20
>  		adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rings + 1;
>  		adev->vcn.inst[i].irq.funcs =3D &vcn_v4_0_irq_funcs;
> +
> +		adev->vcn.inst[i].ras_poison_irq.num_types =3D adev-
> >vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].ras_poison_irq.funcs =3D
> &vcn_v4_0_ras_irq_funcs;
>  	}
>  }
>=20
> --
> 2.34.1
