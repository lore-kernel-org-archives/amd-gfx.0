Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41948C3600C
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 13:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D9510E12A;
	Mon, 31 Mar 2025 13:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FikjRaiQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC7110E12A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 13:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVLBFZFGh2Ep137UlX0qXtg42/7+ezDJAFj3BbE5JxdLXP6+3Cl2D1oPsbD0jxrroQKqe2GxZ5I+h9cleQyGzzVfHiTe2qXBuUfjkXrnWKRPfpkCKpo2UOsZUDYRN8tCFUOK0OBaYz5gRYbgjsSKPUjn4l5TIoVjWH7mQY0RtETcHhwQvj6zG7McECuEfpPJQUbtbxBqRqPw3O9ogefdkynIKkOVxIiB7v/xl8Pxf/Gjt0Fxl1Ddti7/0Tfgp/LYWWLzHYCmlOhvcH46R3xBXs/DBmHPWm4BDaTGu2GImFZ08CA2CWrJDq3+XUBQ3llLswhU4qEL45TjF30dEVqkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY7uzb8p4T/6smGiM80txT8nWLNQP7SrxoidUnEyhbU=;
 b=GeQ63KZN+2jTGeFBzJyPHWWcD7UsqhzsfjTLb4yXIfL5qjdX1oZfme43WOeUyy2wYWSTn1n/fMNZFMuxKoe4TjYJRBYWTOkaAadXFKs9HdC8cVjIpjl1Z9HZZTHWpY1HeMYOqoXXA0jFUJYQacGGb6F0ZqhgNRflbxznn5c8K7cBkT4Db2M3OqpPwDn6XHh+nuz7MuOcGEjRHizero6XBg3D+5OSWjeaYHBAeij2OE1H9klIFghuwrSKC4xNjJHh/8G1hq+b+hZfQGndKg5hdm8qRyKnVYuoiW4KMGqUoKDiNoDNpyOB1PQejCuh3cYtIGDBUO3pSBXpX0GFbQ3TEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY7uzb8p4T/6smGiM80txT8nWLNQP7SrxoidUnEyhbU=;
 b=FikjRaiQ878pZVxqxt/Ski/bBlxDJ74g80YXnlhzPZlBGSoAT7mIiI4VxLeZ6Q6iYCc6V1uNDxnvFF6lox4UY8HQdj84BAhSqMatB0bizonGg4nhIj9A9G86A2dVv8h4TRuKyY4/AdfZgmbzWqVeWbDOuYbz1EudyeQj/2DQK8E=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 13:34:40 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 13:34:40 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable FW workaround for VCN 4_0_5
Thread-Topic: [PATCH] drm/amdgpu: enable FW workaround for VCN 4_0_5
Thread-Index: AQHboA7/K7RGsGeWeU+q3TDjQbXCC7ONQwZw
Date: Mon, 31 Mar 2025 13:34:40 +0000
Message-ID: <DM8PR12MB539916D6C5B2C4FFA17E7396E5AD2@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250328182633.19705-1-boyuan.zhang@amd.com>
In-Reply-To: <20250328182633.19705-1-boyuan.zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=48c7a9e9-edff-44f1-bf8a-9433ca1e682f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-31T13:34:04Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|CH3PR12MB8511:EE_
x-ms-office365-filtering-correlation-id: 8dad5705-917a-4695-6ab3-08dd7058c9bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?85ksKrfEEO49XNc5NQHAgAFIg43LNAwBU7VvDedBynR8KzmBB1jL1IWRI/bY?=
 =?us-ascii?Q?PZcmAXASEpLnrOLe0iBRyc3bdlL11m25VLM/YPDGiNu6x+HHgOt7s0qbqKiy?=
 =?us-ascii?Q?mXFBXQFX5+/BPK5haJ1a47q1SGeClWc5msORyk+1lKIdoywZrd7phLsTi8u1?=
 =?us-ascii?Q?CIFotga8i2z4wOF1YT2dr3ewVu21ff2ovZE4BK6GRblFasd8jEfcrDK/qGHr?=
 =?us-ascii?Q?UXNZugnD4dABKrMnsWfNPhXpMP3Btbgy75m75Szadp2uLuagf0S+MnYl9tdN?=
 =?us-ascii?Q?8qibZE1QhLe9VBct8u563KvEKM4TebZnwlZhdEUniFi3QOCZ6ig0Du87GUMM?=
 =?us-ascii?Q?fclj9m1MeJOY/OwRo0LJpidOUfEMeB6YC9DI7duJR4BFbE5NBnAPloRr87Wf?=
 =?us-ascii?Q?H/78JFxXX4A25wAklV36XDoSBlryw7BDMqNz1DRKI5Lm8qJyduX+aEq+rBVC?=
 =?us-ascii?Q?p5lMryt+bg2kCIYe7YncwT6ulnkiJS5kIMQo4kEoMQ/Jqw7lCE5r4OdTGIOi?=
 =?us-ascii?Q?pSPCByCxKuQuZqSycTHhXeI4uaWgdhyh2wX9TFmzubf0/cCQ9E4uDnXSiKhS?=
 =?us-ascii?Q?3kv+o1yYoLt8seaMAqCgWLM75RA2MvjDlCXhjPayG2ML92IWH8y9hLlBKnSo?=
 =?us-ascii?Q?u6AUV35+zEwFZmVSagrBkUZ1YbV/L1laDNxQJGQCGPfdTd1Ys75nukPT+9yq?=
 =?us-ascii?Q?sgqniTedIRPrgmIyXUw9ZM9VS8zN5m5pub+V5F6w7hWms9cVX44FUHvMY5Xd?=
 =?us-ascii?Q?7XMa8WR3Jzz6F72E67DFHRq8DpGFxCPdLjWgUXTzvDR2BLsxmpbldlqPAvnt?=
 =?us-ascii?Q?JK2zO8PPxsJpuDPtEUdwF7wYbYOFE/P9D1vp2ZPVHia77LEXjm8XJNJ/wdWX?=
 =?us-ascii?Q?eGaGnqwQ+1b0SXaTH1IkBQPawi7Ah6Q81IMf0NWU3HYOnS9wmUV1M1P7gExP?=
 =?us-ascii?Q?kbVoGCflv4AnPuakmeDZiatT7x5LjNo+JgoLijoX87Siyv1SrhUmmdFFc5LU?=
 =?us-ascii?Q?wKcfxSczuyAcHQmVGV3bQU1E1o0S45CVMdWlL0AlcqhrhCN3i9Nz01EK/Rdu?=
 =?us-ascii?Q?vdemVNaQldnlz14+2d0PhghieH53TPyGjFHAT8Lb9zMtlrdvwEnENGKC7vhS?=
 =?us-ascii?Q?rkN/PdbLuimoBTjAQKwSCP8gwNclq66/5EN2/rRb3Wn2PA2yHZnjD+poParP?=
 =?us-ascii?Q?30nkhwLGvDIPFo77rphVXX7vS5RGI1qhr1LWGKtTFDQrGrMKj0WIguxWQpBx?=
 =?us-ascii?Q?aApyVc0ustqoYC5ulmRkBk9eRaJO5RQVsQA1MC+F7dBpotHNVSYU2hclzOXv?=
 =?us-ascii?Q?uy0MhkoTjj48S+Fz94VwSEwZQO1pskjcI+IjvpewFEfiJw5kofoJIeTK4IE+?=
 =?us-ascii?Q?cdtScD6Ik5o4voiLzZqVRhHbx/9lLjO6wLctSBFx/LZj14yenF70FkBhmP6t?=
 =?us-ascii?Q?icSVnbDYHSA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YQE3tGRWcbBZSjdbBv158992fldYdnHzxc2t6Dsgb1kUxatMpwETjRjFzHkh?=
 =?us-ascii?Q?bWmmrHlJ7UkGNyhKbid0Jo00uPHHwKD7KHkg7f5u1ySvtjEt/KDmQEk3VgTh?=
 =?us-ascii?Q?58T34SWtiFF95h/058Th3ObXHFK79wCUNFxzyv0TdO3RUyf8mL0icxLg/EvG?=
 =?us-ascii?Q?tIzFFTMzfVV3E7+J+O2/JI8DGGuShLH4k1D4uVc56CexvYaOAnECnKGDHTKD?=
 =?us-ascii?Q?nbth3wbY3WOcfSiyFEDoSy6B3VQEtC+OpidEPApihYfm1+ctI8FuNqlOMJCQ?=
 =?us-ascii?Q?yv/Mpwz+Tm77mBG8d9xSPz6FST8akgTkqPck8C9nA/4BRyqlJ3hP2zYFOxGo?=
 =?us-ascii?Q?wG9c4MTW+giMl+x7OKaBUkHwQWv54D0Vwa0QHDA2dmlJ0IItL49zwc7R76L9?=
 =?us-ascii?Q?dN58HfJEyk6aIJaAC1ZqQtiB2g52qiQsboqvfFmxQy2tRbovlbyQ/w/uXoVs?=
 =?us-ascii?Q?cOA63F4BMCdFF6tC1lxVElI7DCwEW0Sz4lzzxXNuQZYzerDXGTs0JdAIt4gs?=
 =?us-ascii?Q?BggUE6DrHcO1J62AMh+2BMlfkzfwocp+7tnzQl4vp4U2Znu4P+KsuyWdDpkj?=
 =?us-ascii?Q?lWVfkMrQPyBrbYKgxliyHZncZSHSCQgHyVT1iL0TzyZRBxVyFFD4L6DPCzrI?=
 =?us-ascii?Q?YxftpQ2Ge7x4I6bJKk8VaPl9QwU9f2pFmGmXrHKX1RUUhAmBD3dEyS7UwaIk?=
 =?us-ascii?Q?qQL9ME1XkrY3IuLDYh2IeeOr7OKPjgzexen2Ooug1MSaAzJKGEj1yYeQpqqH?=
 =?us-ascii?Q?GpbN2FkAGXFme4Vhm/YqYm6HUGVH0KQ/a+rC6mswrVfur6SNtzaLW29lVmce?=
 =?us-ascii?Q?yswzLC68iqxIcbE6NpkN1DyzSfn2CfP0jxfA/mcSep4QK0d8p/JxyZM7RyvW?=
 =?us-ascii?Q?jRlgEkdxGFJCTtj5k9/4lMsDCw7DhtZ8lRDcT4h3pEXy/51INCIuii8x6yIE?=
 =?us-ascii?Q?L/5ECjML+79rT1WDKmZiXOo5mHXRAIaz3MIDuQNxgCSXnySGdy466HSxQKa1?=
 =?us-ascii?Q?1KeN+K6+pN9FCigNL2e0tm91PuW8qojU/Lwi4+l88owHp5GiW/1RNefrceCL?=
 =?us-ascii?Q?TfB5TpBSBo9gN/9gFwGJ6DkCUO/NYy8roOeDamBkL+nrU+YAVJlzI4Wr2z+G?=
 =?us-ascii?Q?XuPbuPdewpNhVdPtBFenElLdnnVqGjKNEJStdv6ZkrXmKyRMZkyQNFZcJfgV?=
 =?us-ascii?Q?eqlzlJtQFOfWipjCBDe7GjQaoakxvJUYOzZxWe6CYdeGaTUBgVw/8QCRrFio?=
 =?us-ascii?Q?PFFoR9KPXmEYmZtykkFCtC82uIIdMtP2fYd5L4jshbc690mB4K8sHhLB7/Z2?=
 =?us-ascii?Q?04fwf+QLLb9nLlMkkvg/ytx4NRjtFUaLBVO/N+u6oc/3cZKNK59MhdkzaZkb?=
 =?us-ascii?Q?OibHCTUeyn2YrRqUW0Qm0Rl09nOIn/vjnCodWEHOpEQoeqA9ms82l+xF1Saj?=
 =?us-ascii?Q?kabu71Y//yTNDMluoSVagNGxi9FzgIVagKzyPvgbNT87+qOUWyizDYx+mqq8?=
 =?us-ascii?Q?2N3f1j5HzijGqwI8ZRxtU1BUVoGs7j3cSvNSrMpaQcbPTMaA2C/5AaN1JLR6?=
 =?us-ascii?Q?h9K/ZZNiCrvt4W5SAwM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dad5705-917a-4695-6ab3-08dd7058c9bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 13:34:40.0276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KlvZIe2JUePMmZsPgito2hefPwslZ4hiow5rxXAKEYXXFYEi5lRI5ZrNgHBLE9i7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> boyuan.zhang@amd.com
> Sent: March 28, 2025 2:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Boyuan <Boyuan.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: enable FW workaround for VCN 4_0_5
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Enabling VCN FW workaround for drm key injection through shared memory
> for vcn 4_0_5
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index ba603b2246e2..a8cfc63713ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -207,6 +207,10 @@ static int vcn_v4_0_5_sw_init(struct
> amdgpu_ip_block *ip_block)
>               if (amdgpu_sriov_vf(adev))
>                       fw_shared->present_flag_0 |=3D
> cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
>
> +             fw_shared->present_flag_0 |=3D
> AMDGPU_FW_SHARED_FLAG_0_DRM_KEY_INJECT;
> +             fw_shared->drm_key_wa.method =3D
> +
>       AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSH
> AKING;
> +
>               if (amdgpu_vcnfw_log)
>                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>
> --
> 2.34.1

