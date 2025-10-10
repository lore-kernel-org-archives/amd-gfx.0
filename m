Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76737CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 10:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF93F10EBA3;
	Fri, 10 Oct 2025 10:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zb8zWSZN";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011024.outbound.protection.outlook.com
 [40.93.194.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B3010EBA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 10:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOZfHMfgQ9LIGfUKtQLBHhm6Tc60AnESHwi9OR2ad9XHwazDrSeOtnL1TkSDLcRCeMhnleww+BJGBIvL4sDi1zPM1Lu9BpIcTmWv4lcSSrDJLhoWVLY8YV0KzFXXR1GZsuNOqsG/co+uQAb9jo/fkHX24f5k4oQFlWom8hkMHsoUDX/SyBjwnwFiIkLth17A7lretNadD2MGk9jZNMo3B2URjiweZKCpOrF6JNhb/NZmFkxrkiVcLBxvYVCA3PWFoZZvSPOKUx14+RPDiT0FkvR5Y4NdLdFyd1H4E7N+Y9eY3Znk/KIJriU4G0KLuWAk0/uvm+wsPmf3Vhb69AWPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBSMiMVApJbMLUDa4QYAajKzfbB4kjP+ke6fHF8d72M=;
 b=JpZ1NQLu1UKddeKdDj506viOIIRX46MHsY5HXbksQFlBr5Mq0ZorssZyl/UE9MFMj1qCwY3l4KQAlZwyDQR81k0+4PRKP8ZgvRsSA7R5cGhGLuVNHhRARtu4NsSajikq003rxdG79vHUvbB6a1zPnJM6WUs24ZpqPu8isztVX6mRxlBtHQLeDgLFZrRJlwKZU7gcXgshphAyTEPZeOFLTGV+KHWD6ckqFpBHPkT3rB7p58SI4U8jd5mIW+R0lVuw97dejhhqzenfSSJsWyLzslyIZt3Uw27VVswP1d2twtRyaYlcz0hchkN7IjbkU327UCBkDJvIZiFABhUWboVp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBSMiMVApJbMLUDa4QYAajKzfbB4kjP+ke6fHF8d72M=;
 b=zb8zWSZNYXdW4aE2DKfRA4brjb708W10UsLPFlc+vxsQfpZkWCkDirTAWhsHHkSyC7pOzUUx+V96KQMZrDS2J+hwjZRpifqV4gpn3L84IZFvwYaqRscFhVNqamuwdJlIz3kq8h6VMvSK7azsw98k0ZS4focjrTmbYbC1WfDpOPs=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Fri, 10 Oct 2025 10:46:29 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 10:46:29 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>
Subject: RE: [PATCH 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init
 from dynamic crit_region offsets
Thread-Topic: [PATCH 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init
 from dynamic crit_region offsets
Thread-Index: AQHcOaBwSxUdkaLdFkaS2RO1a9EUD7S7L7Cw
Date: Fri, 10 Oct 2025 10:46:29 +0000
Message-ID: <DS0PR12MB7804C3781736F226550FFEAC97EFA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251010044309.11822-1-yunru.pan@amd.com>
 <20251010044309.11822-5-yunru.pan@amd.com>
In-Reply-To: <20251010044309.11822-5-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-10T10:34:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CYYPR12MB8871:EE_
x-ms-office365-filtering-correlation-id: ea716ba8-e34e-4dff-6914-08de07ea4505
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OKlN/7zctv599LSeXFd3qQdDdnEYh+Dqv9r9SqaOjnFZGgM8U2SgM8dvEUhj?=
 =?us-ascii?Q?wxXom0OSlng9TbEq425c8cmaYNAF+LYidAoep3fLGmTXWUDNGHPfr+Tfzp3t?=
 =?us-ascii?Q?p09pAP2yV9lxe+Zpta7RrYVH/lAq4V7yJVR3JES596exkV6fxVp358HoDe1V?=
 =?us-ascii?Q?JjbtJmKzWzlRPJGScZZS7j1Q5peg122mc6QDzKJRINv/Io/BGDk7Q/mRH2KV?=
 =?us-ascii?Q?d7MJU5X/EXIxsZfihQLpu6647UQ77Io2joPueYDsG0iRiSR2i/acqp52dXti?=
 =?us-ascii?Q?UpnnvfpYPCPyegswn2aLyRC0gFb6LSOT0AccQ3XRYeq0I3xEa6Tak/m6RuG+?=
 =?us-ascii?Q?GlKStFPt4eqgUObpjpltW8J89NGn7UYl4YsE6LyEJsVd4FxTtqK8xaMEKBLe?=
 =?us-ascii?Q?NBJPF6usGIhAEYrPhrNf6qrR4/cRldMT3R7C+JnffXCxPMIZgVHPRI4R32Lj?=
 =?us-ascii?Q?FWDd/3vOkIa5V5rr7pxuUu3aImOvyMplzeeqrH+ohvYs6mmqilqL6PNQwZKO?=
 =?us-ascii?Q?meEDvctTzW0Bo3X7co30xaxBpnsdi7/D7dAyWpFjrYYi4V3fdWoqNb6qkeww?=
 =?us-ascii?Q?NfNxf5r3bkzzlklDn2qyM+/AZYyfCeAJmUMh1tIaGOD35zJaGmIQMNKeEjmC?=
 =?us-ascii?Q?TBWkYXMmDjlyIgRxqFRABR8xiTBUfJyWxV4gQlwA/7XHxbhnlA85kA/PHxBZ?=
 =?us-ascii?Q?lbv0vhMnzp3RoV8NaYKoAGXTze7EGZny5aCr/VSHawtdQqx3tIpuQ/Pbeejs?=
 =?us-ascii?Q?S7+5pOLD9aqFWitgGzXAUZYn8/MU+/Jl1MipI3lSDMPJRc4dRB4On4f9Uz3A?=
 =?us-ascii?Q?6o5Ol5F27bMqkQj72+TnubLh3WmbSkU3W9j1Mj4P2BfrHGHzUZxh2ZUwsxj8?=
 =?us-ascii?Q?/Zgsc173qNQOSFO7CU+P9iLHSj94F5A6w6GSOtlSdN4jxVdq/X2w1WzMNQxd?=
 =?us-ascii?Q?OnxIXgCH3Ri2/VxGmbb5uKHGnc2yd2mMyy2Onv090ARnF8DwXimcUXQfxTCW?=
 =?us-ascii?Q?iK9dFFaXpA+frAlPEoJjUVe7KCvdX8xEOFHXzBbw0Dlo461l3CIFBfTCofbW?=
 =?us-ascii?Q?DOeBrfEARlmVR5A50CNr63il3+cfmVoRDoHjnrgHQIwNsLnl8ZT0+f0RV6Ta?=
 =?us-ascii?Q?tjw9SP09AJIoL5W1pPkvhYn/5NygFqUguugByE9YBMihl1WX3S/NlIZ83YZ9?=
 =?us-ascii?Q?9vZU1/lpzQRvC73tFuauRfl/NIuJBpgKXmJQThsCr1U/YR/fkADC32XdSfeA?=
 =?us-ascii?Q?WI+q426gvDUJc6Dkg8etekMQqlNt9E79pEkzDS8kzk560Y7J1Fk96a9qwlze?=
 =?us-ascii?Q?nz+7t3DLMHzxbl/WUrEBN2Rctgx+oiSZz8e8BOBLU4xThu4+Zzk6VLdJMenQ?=
 =?us-ascii?Q?kq5tQdmYFVfjIjbxIxxYyNO2rycP5h30mNqQp64Weh+n1ADQtbif8jpD/t+a?=
 =?us-ascii?Q?JQWJVj7+030X2a76UhrOXHoFr4N1XcON8L+ORg1Owo5QMEFqZKv6bnkULwKy?=
 =?us-ascii?Q?B5j04phY+JZ89M3q15baCsfd2yC4fsilL0ZH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8/nSlzjbFQOohmsvjgyo0qWFwJQ7pRMN56lORCprNgH44i2QGSX6nelXUOJE?=
 =?us-ascii?Q?GgIUPPZJWipOd4wg2o7vCgslMru9aAO/PIb7Ke4ubxCi5XS1G8j7Pb9fmWia?=
 =?us-ascii?Q?GfhmVqbjRXTGugS/tUdWDJO67FG7DmjPqgauCY1Nxp0gzFHasHOmi5l9mpvr?=
 =?us-ascii?Q?YyCvMkAnsnYnns/aY4zzt54K+NwM889w8JZrgMlklQ3UcDlz3JcMYP7FEQZV?=
 =?us-ascii?Q?YHe3mHyRKPQTtWb1JQ4Jjqw8K1ZlVJSQrrLVk2BOCA4kygYwQHmK6ngEpx+B?=
 =?us-ascii?Q?Sy8zeJtRpWURf0mdrLsM3LnZJSroebp4g73BVLIjU9j1LaqdTIWf0uUqZXRV?=
 =?us-ascii?Q?FAeIh9IDGZzlgHP11jACcD0hTmc6nnL/HyeYEx60HWAoYj1URg38F4Lg7qoi?=
 =?us-ascii?Q?uhmS855DBCS8WkFS64KG2fl/UBlrYkWu7TKo7YHD/UHIObr78OmzAPsYTvi1?=
 =?us-ascii?Q?ERaAR0qHqnXwbHGMtYih7VCI455BsIieqNeWXpX6HR1uPd5Q3S2cg/4Szq4m?=
 =?us-ascii?Q?wKmee8iEccrStdrw1iB2X2Cd85Z9rAZGeEZXDAs2yoQHzHKuxU3/WlhTjPGx?=
 =?us-ascii?Q?b29wSNl+mDdrfAWzKa/zmF4YID2dvrteg6AlxnG6uTUU0VCOQcKypaxPgnvn?=
 =?us-ascii?Q?HzIw6gkgbewnJ5A/tqiitG8YLv6R6uVPtkEzvXlp821Eupbk03/CXt9oM4Lt?=
 =?us-ascii?Q?d5DUt41uDSGl0+kTZHSB+LMH9io+llTN9d1Wq5kmAhwccwkwLGjrU4Sj20zb?=
 =?us-ascii?Q?uewwTktDdasD9Z3OhFGviJV0HNg6OHupejkQlAtg7z2XkWLhxxI0dhebfWOA?=
 =?us-ascii?Q?e4qQ4SMng58M7/FQoR7J0sgABVoEZiwfc7aKEford67G9RvaLtPk7/dO0ClE?=
 =?us-ascii?Q?IWdlR1kXjEyW0RvjBaWRu520nZNZYaRICvBbVDReGwSpEhtv96PVnALfDncA?=
 =?us-ascii?Q?uF/MFAgSD88wHRto7s6mQPhyZxgDEcxPoWMlwvbalGJyz+jAzEDvVIYtmrIF?=
 =?us-ascii?Q?8Iwn6SLvQh6eUejxx3WGjZfw0o9mD1XBfZSMRxcnr+hhM1e46MeYuRRiIl9O?=
 =?us-ascii?Q?gb3YLW9RWCl+QhIQQOHlqqC1+iWn5w8h62AGhf2w9zrwJ7/X7RTXE60YZpF2?=
 =?us-ascii?Q?IN9hVktNFs6irVAFMMocwpK1LHtYdBFxrtwMHL5prFrG676ILdJmNGSnbVAL?=
 =?us-ascii?Q?tB1LohwPV1/72v0QEX4wCNiLYkEQa977Mb+bCSRQX+/0Zbc7IxIkyQUNw8KK?=
 =?us-ascii?Q?5b4bOVRU9Y+GQs8JK0pH9rKGviC7cj7Pv5N+Qi/l4qpfwZu3Gvdrxc56mwY/?=
 =?us-ascii?Q?HqvplLeNj7anXvOehcIBxVVNg+gMvB2ZOGoVWqsoQNKMyDtZZePbekP5MrN8?=
 =?us-ascii?Q?wY8lbe/f7Vz8qbHF95eTGAKoWGIGQ1nY7LzOc04Rwk1QxF8f9IpbaHUwZfte?=
 =?us-ascii?Q?lKVh4cy5LMtZDtVOL/N6T4wL8wCrRccJuQ7CJ9GyqgKi2NxKTSywXGNNhRch?=
 =?us-ascii?Q?yK9vhCssE7eEy0IiDiQeQuT5ERqBhx/j1GZyxpa/KUQWE1aynOQjroTSrFfG?=
 =?us-ascii?Q?N1xYw303xy7qnvm1wUo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea716ba8-e34e-4dff-6914-08de07ea4505
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 10:46:29.3970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMWyJoupZop47GXvnyACcQfFwqPH+H0M+/R0XIIKkl/hUjktjilNKvlaWtjjk8PP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
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

>-----Original Message-----
>From: Pan, Ellen <Yunru.Pan@amd.com>
>Sent: Friday, October 10, 2025 10:13 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Chan, Hing
>Pong <Jeffrey.Chan@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
>Subject: [PATCH 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init
>from dynamic crit_region offsets
>
>1. Added VF logic in amdgpu_virt to init IP discovery using the offsets fr=
om
>dynamic(v2) critical regions; 2. Added VF logic in amdgpu_virt to init bio=
s image
>using the offsets from dynamic(v2) critical regions;
>
>Signed-off-by: Ellen Pan <yunru.pan@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  26 +++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  33 +++---
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 107
>++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   2 +
> 5 files changed, 142 insertions(+), 27 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>index 2a0df4cabb99..d320118858bc 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>@@ -416,6 +416,7 @@ int amdgpu_device_ip_block_add(struct
>amdgpu_device *adev,
> /*
>  * BIOS.
>  */
>+bool amdgpu_check_atom_bios(struct amdgpu_device *adev, size_t size);
> bool amdgpu_get_bios(struct amdgpu_device *adev);  bool
>amdgpu_read_bios(struct amdgpu_device *adev);  bool
>amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev, diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>index 00e96419fcda..787584956214 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>@@ -47,7 +47,7 @@
> /* Check if current bios is an ATOM BIOS.
>  * Return true if it is ATOM BIOS. Otherwise, return false.
>  */
>-static bool check_atom_bios(struct amdgpu_device *adev, size_t size)
>+bool amdgpu_check_atom_bios(struct amdgpu_device *adev, size_t size)
> {
>       uint16_t tmp, bios_header_start;
>       uint8_t *bios =3D adev->bios;
>@@ -96,7 +96,8 @@ void amdgpu_bios_release(struct amdgpu_device *adev)
>  * part of the system bios.  On boot, the system bios puts a
>  * copy of the igp rom at the start of vram if a discrete card is
>  * present.
>- * For SR-IOV, the vbios image is also put in VRAM in the VF.
>+ * For SR-IOV, if dynamic critical region is not enabled,
>+ * the vbios image is also put at the start of VRAM in the VF.
>  */
> static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)  {
>@@ -127,7 +128,7 @@ static bool amdgpu_read_bios_from_vram(struct
>amdgpu_device *adev)
>       memcpy_fromio(adev->bios, bios, size);
>       iounmap(bios);
>
>-      if (!check_atom_bios(adev, size)) {
>+      if (!amdgpu_check_atom_bios(adev, size)) {
>               amdgpu_bios_release(adev);
>               return false;
>       }
>@@ -155,7 +156,7 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
>       memcpy_fromio(adev->bios, bios, size);
>       pci_unmap_rom(adev->pdev, bios);
>
>-      if (!check_atom_bios(adev, size)) {
>+      if (!amdgpu_check_atom_bios(adev, size)) {
>               amdgpu_bios_release(adev);
>               return false;
>       }
>@@ -195,7 +196,7 @@ static bool amdgpu_read_bios_from_rom(struct
>amdgpu_device *adev)
>       /* read complete BIOS */
>       amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);
>
>-      if (!check_atom_bios(adev, len)) {
>+      if (!amdgpu_check_atom_bios(adev, len)) {
>               amdgpu_bios_release(adev);
>               return false;
>       }
>@@ -225,7 +226,7 @@ static bool amdgpu_read_platform_bios(struct
>amdgpu_device *adev)
>       memcpy_fromio(adev->bios, bios, romlen);
>       iounmap(bios);
>
>-      if (!check_atom_bios(adev, romlen))
>+      if (!amdgpu_check_atom_bios(adev, romlen))
>               goto free_bios;
>
>       adev->bios_size =3D romlen;
>@@ -334,7 +335,7 @@ static bool amdgpu_atrm_get_bios(struct
>amdgpu_device *adev)
>                       break;
>       }
>
>-      if (!check_atom_bios(adev, size)) {
>+      if (!amdgpu_check_atom_bios(adev, size)) {
>               amdgpu_bios_release(adev);
>               return false;
>       }
>@@ -399,7 +400,7 @@ static bool amdgpu_acpi_vfct_bios(struct
>amdgpu_device *adev)
>                                            vhdr->ImageLength,
>                                            GFP_KERNEL);
>
>-                      if (!check_atom_bios(adev, vhdr->ImageLength)) {
>+                      if (!amdgpu_check_atom_bios(adev, vhdr-
>>ImageLength)) {
>                               amdgpu_bios_release(adev);
>                               return false;
>                       }
>@@ -467,9 +468,14 @@ static bool amdgpu_get_bios_dgpu(struct
>amdgpu_device *adev)
>       }
>
>       /* this is required for SR-IOV */
>-      if (amdgpu_read_bios_from_vram(adev)) {
>-              dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
>+      if (amdgpu_sriov_vf(adev) &&
>amdgpu_virt_read_bios_from_vram(adev)) {
>+              dev_info(adev->dev, "Fetched VBIOS from dynamic VRAM
>BAR\n");
>               goto success;
>+      } else {
>+              if (amdgpu_read_bios_from_vram(adev)) {
>+                      dev_info(adev->dev, "Fetched VBIOS from VRAM
>BAR\n");
>+                      goto success;
>+              }
>       }
>
>       if (amdgpu_prefer_rom_resource(adev)) { diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>index 73401f0aeb34..de8676d6ff9c 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>@@ -275,21 +275,18 @@ static int
>amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>       int i, ret =3D 0;
>       u32 msg;
>
>-      if (!amdgpu_sriov_vf(adev)) {
>-              /* It can take up to two second for IFWI init to complete o=
n
>some dGPUs,
>-               * but generally it should be in the 60-100ms range.  Norma=
lly
>this starts
>-               * as soon as the device gets power so by the time the OS l=
oads
>this has long
>-               * completed.  However, when a card is hotplugged via e.g.,
>USB4, we need to
>-               * wait for this to complete.  Once the C2PMSG is updated, =
we
>can
>-               * continue.
>-               */
>-
>-              for (i =3D 0; i < 2000; i++) {
>-                      msg =3D RREG32(mmMP0_SMN_C2PMSG_33);
>-                      if (msg & 0x80000000)
>-                              break;
>-                      msleep(1);
>-              }
>+      /* It can take up to two second for IFWI init to complete on some
>dGPUs,
>+       * but generally it should be in the 60-100ms range.  Normally this
>starts
>+       * as soon as the device gets power so by the time the OS loads thi=
s has
>long
>+       * completed.  However, when a card is hotplugged via e.g., USB4, w=
e
>need to
>+       * wait for this to complete.  Once the C2PMSG is updated, we can
>+       * continue.
>+       */
>+      for (i =3D 0; i < 2000; i++) {
>+              msg =3D RREG32(mmMP0_SMN_C2PMSG_33);
>+              if (msg & 0x80000000)
>+                      break;
>+              msleep(1);
>       }
>
>       vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE); @@ -467,8
>+464,10 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>                       goto out;
>       } else {
>               drm_dbg(&adev->ddev, "use ip discovery information from
>memory");
>-              r =3D amdgpu_discovery_read_binary_from_mem(
>-                      adev, adev->mman.discovery_bin);
>+              if (amdgpu_sriov_vf(adev))
>+                      r =3D amdgpu_virt_init_discovery_from_mem(adev,
>adev->mman.discovery_bin);
>+              else
>+                      r =3D amdgpu_discovery_read_binary_from_mem(adev,
>+adev->mman.discovery_bin);
>               if (r)
>                       goto out;
>       }
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>index 461e83728594..67d5f15a72a1 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>@@ -965,6 +965,113 @@ int amdgpu_virt_init_critical_region(struct
>amdgpu_device *adev)
>       return r;
> }
>
>+int amdgpu_virt_init_discovery_from_mem(struct amdgpu_device *adev,
>+uint8_t *binary) {
>+      uint64_t vram_size;
>+      uint32_t ip_discovery_offset, ip_discovery_size;
>+      uint64_t pos =3D 0;
>+
>+      /* Get dynamic offset for IPD if dynamic critical region is enabled=
 */
>+      if (adev->virt.is_dynamic_crit_regn_enabled) {
>+              ip_discovery_offset =3D
>+                      adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
>+              ip_discovery_size =3D
>+                      adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb << 10;
>+
>+              dev_info(adev->dev,
>+                      "Got IPD info from dynamic crit_region at offset 0x=
%x
>with size of 0x%x bytes.\n",
>+                      ip_discovery_offset, ip_discovery_size);
>+
>+              if (!IS_ALIGNED(ip_discovery_offset, 4) ||
>!IS_ALIGNED(ip_discovery_size, 4)) {
>+                      dev_err(adev->dev, "IP discovery data not aligned t=
o 4
>bytes\n");
>+                      return -EINVAL;
>+              }
>+
>+              if (ip_discovery_size > DISCOVERY_TMR_SIZE) {
>+                      dev_err(adev->dev, "Invalid IP discovery size: 0x%x=
\n",
>ip_discovery_size);
>+                      return -EINVAL;
>+              }
>+
>+              pos =3D (uint64_t)ip_discovery_offset;
>+              amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
>+                                      ip_discovery_size, false);
[lijo]

The intent of my comment to the earlier version is only to fetch the binary=
 and the corresponding size.

u8      *bin;
u32     size;
r =3Damdgpu_virt_get_image(adev, BIOS, &bin, &size);

r =3D 0 // Pass
r =3D -EOPNOSUPP // Not supported
Anything else =3D some real issue.

Check BIOS etc. will be done inside amdgpu_bios file itself similar to how =
it is done for other methods.

On unsupported ones, it continues with the legacy path. Same for discovery =
image as well - amdgpu_virt_get_image(adev, DISCOVERY,  &bin, &size)

Thanks,
Lijo

>+      } else {
>+              vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE);
>+              if (!vram_size || vram_size =3D=3D U32_MAX)
>+                      return -EINVAL;
>+
>+              vram_size <<=3D 20;
>+
>+              pos =3D vram_size - DISCOVERY_TMR_OFFSET;
>+              amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
>+                                      adev->mman.discovery_tmr_size,
>false);
>+      }
>+
>+      return 0;
>+}
>+
>+/* For SR-IOV, if dynamic critical region is enabled,
>+ * the vbios image is put at a dynamic offset of VRAM in the VF.
>+ * If dynamic critical region is disabled, exit early to proceed
>+ * the same seq as on baremetal.
>+ */
>+bool amdgpu_virt_read_bios_from_vram(struct amdgpu_device *adev) {
>+      uint8_t __iomem *bios;
>+      resource_size_t vram_base;
>+      resource_size_t size =3D 256 * 1024; /* ??? */
>+      uint32_t vbios_offset =3D 0;
>+      uint32_t vbios_size =3D 0;
>+
>+      /* Exit early if it's not initialized */
>+      if (!adev->virt.is_dynamic_crit_regn_enabled)
>+              return false;
>+
>+      if (amdgpu_device_need_post(adev))
>+              return false;
>+
>+      /* FB BAR not enabled */
>+      if (pci_resource_len(adev->pdev, 0) =3D=3D 0)
>+              return false;
>+
>+      adev->bios =3D NULL;
>+      vram_base =3D pci_resource_start(adev->pdev, 0);
>+
>+      vbios_offset =3D adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset;
>+      vbios_size =3D
>+              adev-
>>virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb << 10;
>+      if (vbios_size > size) {
>+              dev_err(adev->dev, "Invalid vbios size: 0x%x\n", vbios_size=
);
>+              return false;
>+      }
>+
>+      dev_info(adev->dev,
>+              "Got bios info from dynamic crit_region_table at offset 0x%=
x
>with size of 0x%x bytes.\n",
>+              vbios_offset, vbios_size);
>+
>+      size =3D vbios_size;
>+
>+      bios =3D ioremap_wc(vram_base + vbios_offset, size);
>+      if (!bios)
>+              return false;
>+
>+      adev->bios =3D kmalloc(size, GFP_KERNEL);
>+      if (!adev->bios) {
>+              iounmap(bios);
>+              return false;
>+      }
>+      adev->bios_size =3D size;
>+      memcpy_fromio(adev->bios, bios, size);
>+      iounmap(bios);
>+
>+      if (!check_atom_bios(adev, size)) {
>+              amdgpu_bios_release(adev);
>+              return false;
>+      }
>+
>+      return true;
>+}
>+
> void amdgpu_virt_init(struct amdgpu_device *adev)  {
>       bool is_sriov =3D false;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>index bc1fc1c6daba..f2aa306f4192 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>@@ -438,6 +438,8 @@ void amdgpu_virt_fini_data_exchange(struct
>amdgpu_device *adev);  void amdgpu_virt_init(struct amdgpu_device *adev);
>
> int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
>+int amdgpu_virt_init_discovery_from_mem(struct amdgpu_device *adev,
>+uint8_t *binary); bool amdgpu_virt_read_bios_from_vram(struct
>+amdgpu_device *adev);
>
> bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int
>amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
>--
>2.34.1

