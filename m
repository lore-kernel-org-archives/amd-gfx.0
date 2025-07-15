Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8465FC83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2F210E513;
	Tue, 15 Jul 2025 06:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PELi5mug";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 364B110E513
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SU0gtwpmyMmRTniyVZBbUkBlLStOwFOd7ajdmR1fGlUbv7xqcIrHVIhSnrDgcWy6rJUBEe3v5XUt+dT5WLX2eTv9vX6hurvGrjrDXHHt1vaAObusHaNoNXoTl9K1pmlTVdpnUtQkrOsR91zIARfJ8/V5uks+tTetn4Qnb6VdHMqtj8QbA8kh/TRYotsAmpoQNVIjr9LEak+50W6in9RbCOql2y0YFnmxo+6/Qwx593CMjsZu/ONptoL0+FmV9Wr62t6kFg8NpDER7JmPih4QXvni2ReYOCKcT5kfrodEfup41CcILyPrH0JEDJujclDx0uf0ac69hgkVWM6XZd74wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j06VtlnlRnn0y6CfqIdxBdqkaQpmDQSGaiOvdcUvp3A=;
 b=nVKDg5CIas16VG9jjFxvB55vCLIEX7DaRUBjsA1YvUfs6xXNzSk8RsmKkBh9BqFwe8cl7LLVP2L5d/B9BUvibvfPzsYxJmB96B8NZcgPCsOpuEMWabqKIyOtzvSrE5wMvVz0ybc8kvs5f0wT+ONTWT/YsyIuEGbPs5Wr/lFC8B2/5ws3+aEwbxdxZy8NYdVjA5S6W91wt5jJdnVVHOHDWsGfAzjO2tKeZ0ecEHON3jKgq/gvo2pM4llyTBZ1D4GsAkbRXYKVMcKVrcBtLPVqL7qv2MdIgCh9ontwc/gWybBRCLPTnWGMv7vhLYOuCJFMhNPFL1DySCoCZcOp/M2CZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j06VtlnlRnn0y6CfqIdxBdqkaQpmDQSGaiOvdcUvp3A=;
 b=PELi5mugkTETbwoRrKs8bn31+m9zXxEO5tcKr+iRhAbGfIneOBO0pvT0JvmUpAOPOzvPxONG/7NcnJtGmdmjKAZRiUYqsRKPFIpJY0t1wRaToc3wEtMaLYYypuopAC+DAdBJNBIqY0wUqetOzF4aIkILwa6JT6P0Yg5j15T6q6A=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 15 Jul
 2025 06:36:39 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 06:36:39 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: query the allocated vram address block info
Thread-Topic: [PATCH] drm/amdgpu: query the allocated vram address block info
Thread-Index: AQHb8WYaOlFlcigsI0uA+aEODE0DG7Qw6RiAgAHZt8A=
Date: Tue, 15 Jul 2025 06:36:39 +0000
Message-ID: <PH7PR12MB87962079EE78631401DBF2BBB057A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250710064355.670983-1-YiPeng.Chai@amd.com>
 <CH2PR12MB42153B299D236DEB2AFAB802FC54A@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB42153B299D236DEB2AFAB802FC54A@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-14T02:20:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB7147:EE_
x-ms-office365-filtering-correlation-id: 96c08515-ef26-4e04-0b3b-08ddc369f428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Dv3tfC1Zmfz3MVhaW2awb+l7UnVnPAOYPt0KzL/ui5+MkqU6NGigdPMcmUj6?=
 =?us-ascii?Q?JdHMBFcs7RYcp6qKTlE53QZpJHmVQV7319nzNgrrsrZRo7QrRZkjxg8dWclx?=
 =?us-ascii?Q?9aR1Trhu44brUg3qYiFu0AkU+rrGetS0+0CgTSVVR82nca7fOVa8M181GLri?=
 =?us-ascii?Q?l67LKqLRHsQb4bhJNqjOBTamlUfbYKk4qvXPu+i2x4F7w6KgpZfc4TE4fIjB?=
 =?us-ascii?Q?qK3G1SV0Neq27lIalkHbl2cJLraiq8LuwP5j1rkttUFu3RUHZ0JJ97XC9Yc9?=
 =?us-ascii?Q?pxouu060J1HrwrMcZm1nwWHnK00WJPiI2MklNDLHbU+AXivLLJhXTtOraiNd?=
 =?us-ascii?Q?b3u/wWzhB0gZokpinCnt9rDRYXkbScY50g4J0NaZpKkY4vFMde8bmYtXui1t?=
 =?us-ascii?Q?XAnr63GhMvPSguXnQG4W21Js8M+RBJ0ozzCss4UVB8AtqCY6CDUB0Qlisccx?=
 =?us-ascii?Q?OxRJvE0xMNWKtPmE2WtqCwwF8Cp8VUurtVvMzJxl62lT2N1gb99cF7y0rD9g?=
 =?us-ascii?Q?qrVTYBKNayK02n+hiUHD+fN8xonwnr0nkj28eNEJ20LFOhOl1AGGcXWSTx8N?=
 =?us-ascii?Q?+NLzVSNgXWP4+Dy4Ozvcdz0dvOVjZ+aM1xQXnoeQJZZOAejUw8zOcvchyr/k?=
 =?us-ascii?Q?V33ggiECBAQmSaxKGT5m8K4Hkdf382NqMF6uFx7GqKszLJsVmzmBF98lQ3W1?=
 =?us-ascii?Q?tLFriuURZPfcXQETG6esamdF+I9N8y7NGFP7gJxt73owD5mTaG+Fg96Ow2Jh?=
 =?us-ascii?Q?VYYjyewjGLoOm0WKauMVAbTnfBJcZKMDM8Yhjaut48fTNtD8hV83IH+ZGLt3?=
 =?us-ascii?Q?vo95QYQK6CtBiDmSGpJje1jT5lcDrEvIf1QNeFNpLS8fHpisIEfeNAjirA6c?=
 =?us-ascii?Q?ei0t+QBuov2Xrwx6FLGeEsyRlA0NMlmmeJ2iWdwlYOdHKJHhTWDwXtyFPjvR?=
 =?us-ascii?Q?tv6G6ktVX8SIZi4F+hTS/rOhTZpVDcCQ//26kaJjJRnn5FC5y9zjYdf5fUv1?=
 =?us-ascii?Q?HwH63MOqyp5SIqJvSaG3pM8s7vGLo+K80HGAhtQyoj8yUfmMhbwqft1LD753?=
 =?us-ascii?Q?D0YSz1F8qOxzyk6j5LLEKihWaL00Ty4GTKXb6QE5DQxh9COvvuJqDxN+KnGF?=
 =?us-ascii?Q?khGXm/xJFIPzu+q0k9nXfhN1Aaom9nLQ3KMEfmCBICAL/CP5laThMzKQSN7r?=
 =?us-ascii?Q?QLMkL+6roeknoqroLQAzxH0P6Ezue0aVIkv2+eP4nspD1p0ACCTj5wiwqMRY?=
 =?us-ascii?Q?6bP8EvyTjYagSJcoR72Ejs7u51nxwqzVSAkvl9I/mleuVvSFEE60KyKqNnAs?=
 =?us-ascii?Q?fv2JtYcqzyUTk/1+dpi6EnOGNc/zl+nbJhVngrallWUASVZRiq12c2caw6O3?=
 =?us-ascii?Q?fFa/0/hR9WbhPgyQJXy0OqNRD7wzcZVwMRiK5Kv/ZxYsVCwT4yvgqD/3QvNC?=
 =?us-ascii?Q?WyqV9oGx/G7zktvlKrJPSaoLM3eyleh7dkhzoZ2XI0YKvRfrwnIvcg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nd9S8eLf71AtylIl5ehIBEItQ4WwC7zg4gMaUJLKEdb+DkreLZFwbTpEpXdI?=
 =?us-ascii?Q?AISJBN3r94JhM3sk6C+8cn95jwmoa17614LmVjDyT7QqslSzMbZaGEn+oaLJ?=
 =?us-ascii?Q?skMbIrV5AtXKLVseWexAxBSZwdineGU5Ea3Dy2R9WGFziROewivnMFRJsqZw?=
 =?us-ascii?Q?IdT9/eLWIViZuc+lkSq0QK3jtX2nOa296NS5SZoMOAJjMsRj3eHYktEvF1jb?=
 =?us-ascii?Q?LHXVroB+vsPqNnbABxdym20rJpslRtl9bbbdekcRyQ2y39WipTn22ZuKvxiB?=
 =?us-ascii?Q?e4h/nqkzvjWzDyVvhBepBViFkIPyxeSzxyiDrZb2mKiJGiNICFic0+KRh+EJ?=
 =?us-ascii?Q?H54mUUS8SoIoQWGL3kH+eAtQ+1XP5yZx0djbtuofzMtbkaWQCqq82HOvGKRB?=
 =?us-ascii?Q?kQzjQiGo/9/VxiPMg8pOHdNq+yDuz2tR+1hfNyZyXBKq4tY8WG3TtPRuRj3d?=
 =?us-ascii?Q?/uMXQEatEomQ+9cU1skyxihGdYvvRzatltohMrDXJZWVoQ5tQs/8YBZ/40Im?=
 =?us-ascii?Q?sOqUzQ5t9lMH35tAc5H+Fu5E2v4mrgE1PDG2Iy3+GCA08H4EbQjJf+xaj0pq?=
 =?us-ascii?Q?s2VsULddDl8GXO3odF32gJNnv9abMCne4gLKt8nZNUp0hS8lUWWImDpSu2dE?=
 =?us-ascii?Q?eGzK26urI5N66GEHCYMhhKldK+SuEwncn+kU0eJedCSn45xKXPmNgEPwN10G?=
 =?us-ascii?Q?Qee5eJJ2qmOyq0/rZrsU2lfNAftrvvPpSUtrNCrkV8K5Sea0XZbb/OgeHZyQ?=
 =?us-ascii?Q?J04svK0PpViuZZ1cY1RQqMsYUYpcKLMWJgx1C58FSjyZFhtv2mgoAu1UrCzT?=
 =?us-ascii?Q?HJFxsOKzAppP9FZm+rqddsJ+s6yfYkWkmp2UZSAssUkMG17sNLAGiVNEDs4e?=
 =?us-ascii?Q?RSjaeWZNtk7wyhNQH4EBpF78kooU2hCOoyIhPPn3esFuBK962CbPuTTVbPjc?=
 =?us-ascii?Q?UHOunWTQ6V0jkkDZ6L8eoXyf5iEQedpVpSAewAXiBK7iFva//a8BhXoZ8mWm?=
 =?us-ascii?Q?/3MdYQhLt3G/6tQ3guHJc8R/b/xu5lv+FfyOwJlr1uoQsJrNhWFffoC6xHyd?=
 =?us-ascii?Q?7PudtNjjtCdoPAuuooOBnQeTuYzO0mpITXVJyf2y/I/4682ufz39y7nKi6Ck?=
 =?us-ascii?Q?Nh6/4QklLrjZce3GPM+JxSVUy55qzZcy0F+SbbBUmfLeDyEe4NDUXrqcMD50?=
 =?us-ascii?Q?T2eoycAsizDLQD+TV3rb9Iuma4tQy6Tva44YVUt6P/FFpY8RkpdOKBOac11m?=
 =?us-ascii?Q?YdGzv03Ys5VFrkYu/7ncXbofBCPdax/GJ5HQ0gh83+jYS36aQKL4IpzRdKiG?=
 =?us-ascii?Q?KPZ0j9TomkTfBEfUA60seTmVfhz/fHKamxnCD52MHnC1fSGxmSv7qQjQyjSs?=
 =?us-ascii?Q?0joLwCv4yFBEKf8oa1dtLqCiJMEzeOs4ktW/YwZ4Xowks5a/h76rS1h5zrOY?=
 =?us-ascii?Q?qZM2iXoWXrwWIJgvh/K24rdolxnSFwIR6CzaE9Xx9lRa1MCTArd2c7AgbroA?=
 =?us-ascii?Q?sfR2vJU2v741mGAnzuB3bj0PBKwvUjHWZBSidPG/keiBOqq+trtyroRB3KbI?=
 =?us-ascii?Q?fwdTewXgkBaFeC9Fd/A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c08515-ef26-4e04-0b3b-08ddc369f428
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 06:36:39.1121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iekiStbhCW+h+qNkXhPgVE11ArXXCmkeCi0gxxRRUm7xxkkDBS7YiHAUVsiCezXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, July 14, 2025 10:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: query the allocated vram address block i=
nfo
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping.....
>
> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, July 10, 2025 2:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: query the allocated vram address block info
>
> The bad pages that need to be retired are not all allocated in the same p=
oison
> consumption process, so an interface is needed to query the processes tha=
t allocate
> the bad pages.
> By killing all the processes that allocate the bad pages, the bad pages c=
an be
> reserved immediately.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 38 ++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h | 17 +++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index abdc52b0895a..4bf3e99f47fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -396,6 +396,35 @@ int amdgpu_vram_mgr_query_page_status(struct
> amdgpu_vram_mgr *mgr,
>         return ret;
>  }
>
> +int amdgpu_vram_mgr_query_address_block_info(struct amdgpu_vram_mgr *mgr=
,
> +                       uint64_t address, struct amdgpu_vram_block_info *=
info) {
> +       struct amdgpu_vram_mgr_resource *vres;
> +       struct drm_buddy_block *block;
> +       u64 start, size;
> +       int ret =3D -ENOENT;
> +
> +       mutex_lock(&mgr->lock);
> +       list_for_each_entry(vres, &mgr->allocated_vres_list, vres_node) {
> +               list_for_each_entry(block, &vres->blocks, link) {
> +                       start =3D amdgpu_vram_mgr_block_start(block);
> +                       size =3D amdgpu_vram_mgr_block_size(block);
> +                       if ((start <=3D address) && (address < (start + s=
ize))) {
> +                               info->start =3D start;
> +                               info->size =3D size;
> +                               memcpy(&info->task, &vres->task, sizeof(v=
res->task));
> +                               ret =3D 0;
> +                               goto out;
> +                       }
> +               }
> +       }
> +
> +out:
> +       mutex_unlock(&mgr->lock);
> +
> +       return ret;
> +}
> +
>  static void amdgpu_dummy_vram_mgr_debug(struct ttm_resource_manager *man=
,
>                                   struct drm_printer *printer)  { @@ -568=
,6 +597,10 @@ static int
> amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>                         remaining_size -=3D size;
>         }
>
> +       vres->task.pid =3D task_pid_nr(current);
> +       get_task_comm(vres->task.comm, current);
> +       list_add_tail(&vres->vres_node, &mgr->allocated_vres_list);
> +
>         if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
> adjust_dcc_size) {
>                 struct drm_buddy_block *dcc_block;
>                 unsigned long dcc_start; @@ -645,6 +678,10 @@ static void
> amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
>         uint64_t vis_usage =3D 0;
>
>         mutex_lock(&mgr->lock);
> +
> +       list_del(&vres->vres_node);
> +       memset(&vres->task, 0, sizeof(vres->task));
> +
>         list_for_each_entry(block, &vres->blocks, link)
>                 vis_usage +=3D amdgpu_vram_mgr_vis_size(adev, block);
>
> @@ -917,6 +954,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>         mutex_init(&mgr->lock);
>         INIT_LIST_HEAD(&mgr->reservations_pending);
>         INIT_LIST_HEAD(&mgr->reserved_pages);
> +       INIT_LIST_HEAD(&mgr->allocated_vres_list);
>         mgr->default_page_size =3D PAGE_SIZE;
>
>         if (!adev->gmc.is_app_apu) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> index b256cbc2bc27..f5ac0eeb092c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> @@ -35,12 +35,26 @@ struct amdgpu_vram_mgr {
>         struct list_head reserved_pages;
>         atomic64_t vis_usage;
>         u64 default_page_size;
> +       struct list_head allocated_vres_list; };
> +
> +struct amdgpu_vres_task {
> +       pid_t pid;
> +       char  comm[TASK_COMM_LEN];
> +};
> +
> +struct amdgpu_vram_block_info {
> +       u64 start;
> +       u64 size;
> +       struct amdgpu_vres_task task;
>  };
>
>  struct amdgpu_vram_mgr_resource {
>         struct ttm_resource base;
>         struct list_head blocks;
>         unsigned long flags;
> +       struct list_head vres_node;
> +       struct amdgpu_vres_task task;
>  };
>
>  static inline u64 amdgpu_vram_mgr_block_start(struct drm_buddy_block *bl=
ock)
> @@ -69,4 +83,7 @@ static inline void amdgpu_vram_mgr_set_cleared(struct
> ttm_resource *res)
>         to_amdgpu_vram_mgr_resource(res)->flags |=3D DRM_BUDDY_CLEARED;  =
}
>
> +int amdgpu_vram_mgr_query_address_block_info(struct amdgpu_vram_mgr *mgr=
,
> +               uint64_t address, struct amdgpu_vram_block_info *info);
> +
>  #endif
> --
> 2.34.1
>

