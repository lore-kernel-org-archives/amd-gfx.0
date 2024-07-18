Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9953C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 03:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4067C10E4DD;
	Thu, 18 Jul 2024 03:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qPmCpYxH";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF2710E4DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 03:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBqRAp7HQxvUVVni/j3UICRCsSdbdxWiZs71S7PYv65q6adqxxKk2MABKY87Cd7r1jgk20089+lSjd9Rdr1kNNUvdGtBydvxqC7wjcL6aj0QTD6i/aa088Y/M3BjKz/3mw1jKkoeLXktvYVee3o0urqH+TlUD94h0hBEDEsNaFrkOOQXH2guoBeGkD6ajdNACHJwgxXoQEzcw2JD9P08rRrY6DrFdVc3EVfcAO2G7yxYZqANgzAts10FEGJwHh2M3d/FhmCSxyYFg99LCYTddmsQ5n4sMa2o7Q7sg6hON0lN6nip23ZVW8vKfEjE4WaJwAxe/nCZVLbWENekiU2d1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKTpVKGebIfWSizLOpiMZ4YyoWrHYe/V2od7jnELKXQ=;
 b=haPFQkO6MxlxWbFde6PtQE9DPS6Re53H0V+10wScLhEtvvmSJtxY3OgNyEBS03MlsXmELhuQ38cUpAh5l55W3RQbBKj94GBdaGW/YH6O8imKNsb7TeDx3FMALk7FE02OuOtHdzCnkYbXjc5zWHpOCheLmU5BD6Bss38v7MWVCK5BjinXIfO0X6xkLgRm3Lfrn881Mg/fo4Iy8eQTc0BNt0V1y59tbSpvT8s4RvqEg8meUYDR3oTPcvfyI5KZ6V+mzaCJbuersYlr/1N4JTrWFE9jBSSFwcRzCVrEgog0WhfQ6YU6naLIpi9bf8EKAzGKGwWe1aNXxaD5kqLB9+1C1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKTpVKGebIfWSizLOpiMZ4YyoWrHYe/V2od7jnELKXQ=;
 b=qPmCpYxHOy1nvSUAxL+wmZ8GKTOy2d7hqmu9h4C+t9+MNIGevAuTIWq2OUe+XOY7MnUS91DJtATc8LeYOK4dbZ1olY6Dnts43brqxoYPOiEPhRRptHK1rj4zpjKqju7FPEC9uqTF31zJdA3lkoiquy/7Q3EJApobgfpW8nASJgA=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 03:35:13 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 03:35:13 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
Thread-Topic: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
Thread-Index: AQHa2CGZlu8rn/rGz0qvkKo/wpiqyrH7zCCAgAAJ6VA=
Date: Thu, 18 Jul 2024 03:35:13 +0000
Message-ID: <CH2PR12MB42159F3051B2254E1A5740C5FCAC2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240717081547.224193-1-YiPeng.Chai@amd.com>
 <20240717081547.224193-2-YiPeng.Chai@amd.com>
 <PH7PR12MB87965FE14B4B083B38E3CDBDB0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87965FE14B4B083B38E3CDBDB0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7c3021fd-db53-4b87-840f-056fb3730b62;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-18T02:56:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|PH7PR12MB5734:EE_
x-ms-office365-filtering-correlation-id: c359170c-42a4-44ec-5d12-08dca6daa264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NbfzaZsLplOlj0YXdDNPllYPfIIOyFK6KFjCJVeB1XyCDQgkoj50jKx+TglX?=
 =?us-ascii?Q?bHcIpcwuZXXoaAcv4ADpW/WuZNA5Zcis/TNan56TqqC48qr9PFkatML0k2tv?=
 =?us-ascii?Q?e/WoDHBN2ZO1vhNV6sGX01jH1TsJRaoRduGKIDqDsRKK4yJWtNeHIk7an2dM?=
 =?us-ascii?Q?BYRzeeiFpvehhb8M0mrLSXzQD/WHn1UCgjy5dLMHtV8X6GvQCXyb5mA5WfEP?=
 =?us-ascii?Q?wDDs8Dxrm/BX/RqbFnioAPdlxdZmFCY7goWBG6tgjEyupLUHwC8oKT+g/4ya?=
 =?us-ascii?Q?mNIttmR8hl0EfSnTEvEyslXO0zSHKlKFUAdQgInj2SCJhuHJ1VZUnSO14KmY?=
 =?us-ascii?Q?KITnByicQenVvm+Hz6klvvJ9yBWJWCPJPYvyiWYRkVPy3Bol+gvVMedKRZwx?=
 =?us-ascii?Q?PBqMmndkQ8uwumxJY6ZeCN3pq82ZZfs1WIr1onH+n1FJ9lAF/Qn/mL7rQwf0?=
 =?us-ascii?Q?Duo6eYOgSNhQkuTSIxFoyoV0M7ykqoZGgkgQmlMHygj1NI4VyagUvxOY5V69?=
 =?us-ascii?Q?jmxjDv6EE/evgkLurSzWMgd4/1SYXy1eAfIb/Txk8A6qt9GDeCC/KI+TanRs?=
 =?us-ascii?Q?frwgazISGfLgrVIW1u9C/sxePVbUusW7CBYUTcFcyw3ckFwnf94V4LE4sBIe?=
 =?us-ascii?Q?tUSZFS3sXKGC/qq3WVPKymQV26/fHeg1qwnT9zqYVLaxlgaQ8ainZPMOQ7sv?=
 =?us-ascii?Q?09zwCzmaswMiRoCbamE+nbGeOElw6W6VTZzaGzmbZSV5McfvD8vGDtVw14Cs?=
 =?us-ascii?Q?alVEmjIym4hEOSzcIuqIwlOHk4ZPgAkLO8YJeoptpcHc59it3zdLE6S5eRLV?=
 =?us-ascii?Q?mvQfX6HXTa5Gcjsmb1EGeKC+ZPXWXizk3BWg6COuanjLH7V8z1NL0F35I1tR?=
 =?us-ascii?Q?vz8JjVprO220v+tIeUpSz2/knY5QXL54vqsmgAjjUsnIhFexUVNw8jX/Xee1?=
 =?us-ascii?Q?3M4DLR3zv45dmTTppRcVh7ACrj4Z4Pap8RxYLdGiqwoYF/Mn+igbszaKCkeV?=
 =?us-ascii?Q?jvV0mvGhRBFkEoMqmvOXXUGGEs/76BUtQPpcBMZeBPALZbKKvapXvKx/za/u?=
 =?us-ascii?Q?NEKEa5T4Uu/12JXFj1Yt1XB58pB3s5rY1NZgxQcrV5cGkoqH7XxoFf8mCira?=
 =?us-ascii?Q?5IgHQMZwRVViWraxXPpoMCN5HwlsUcKxG3MZnXDn9H5oIGLbbn5BwriKV/Ht?=
 =?us-ascii?Q?wUBJT68d+Dt8HiQwuMgAC9dVsV9oQSpZZ3+ibXHdFLqPMuRPpGp5gsTvtyi4?=
 =?us-ascii?Q?mU5r8q5IkEez4Qs7JFdEJRTemBxoSXo0pKJkPxtBEc1VwFQjtOg59fdfNwEH?=
 =?us-ascii?Q?JOiVtVGj+xJ6zmDW5XS8W9QbuiI/jDiwf0VnWTmJwwvpKI6QlXoL1ZTFpIpm?=
 =?us-ascii?Q?UIqkWYb1YhEc+nNfZsiZ1i/6pqrkL4/Lm+akuumAqwOwMva4vw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SwtZp5bV20v+SeWfHUeI3eG6PgFSlkTxiDKGL6EV1VojEmzRpgVA/zcreihd?=
 =?us-ascii?Q?L8Xz3sgLacsfiVTGNeXEx9H/YWYSRfbeH8sqcZYv8LOEAyfM9QUIkdKQM7Eb?=
 =?us-ascii?Q?kQ3N81zJL5mu8nqr/2w/AociNQYPerLCpOtZgkNLlzHI9YltEBXBLaiBUw6X?=
 =?us-ascii?Q?c6/Tlt9bI1ll58NXUpkjEMvSSYfMfieP9g47GqB3jh1sWaVORYVOl2lOZqgV?=
 =?us-ascii?Q?F1nrUYgXgKRNvsI2vtYiCwVc0W71rlu7tVSbnOESi+07K+bDqU1Z2WgSlKxW?=
 =?us-ascii?Q?j/Ox/gfN0B8Pkmg9XRuTmtKLF+XkaLZGLS/ihV6aSXioAUWaNs13ZoD8Kinx?=
 =?us-ascii?Q?plJArc5DD2kEfTBmMs+mUwxD8qTp64NnR2JDHBpiyzq/YjRA3ouvB8RMykQp?=
 =?us-ascii?Q?sjb5Yln+u6aB/HYTnvCvZ/txFpHjxTdjsL/6sphF+IX/ChKxJmgFW7qgr0+o?=
 =?us-ascii?Q?5FyRRrfYwuhx4K6N+osR00eA1OrxbNUAPBEkxqU+Uxk+QgRU+Fq6ZVmB9oGU?=
 =?us-ascii?Q?De7a9f6fRJXmEUbG0bkUe9iVGEPeaCJx9m1t+8cJb0V8vtlTFFhuWiANEFAb?=
 =?us-ascii?Q?EbUWnGotE8/MghcZlcboqV/lgZHxoKdCkrQVS1Y/l2WKhE5Gf+IOxygfDzoI?=
 =?us-ascii?Q?2aOLkfUtR1CbnNeXXtRDBiBaNS+ENw8+eUnUkenGQCJwjrZE6PjpI1b31Kh6?=
 =?us-ascii?Q?t81w9VVlLS9p2KoyPVhTP9D1Zn0qOS/xiiLyK7HcjFTvuw1WfutNiV2Tw1bM?=
 =?us-ascii?Q?K+59W3iWPXiYe3othi+zPUQjizb9HV1PJx/Atiz6+vYVd+0rpR63tf2Be8bf?=
 =?us-ascii?Q?x1zs19HRx1xCMhNSj+ht/p1tkrvnnDG0/w+FwViVq3+Ogjdi6G/jRVx+rZa2?=
 =?us-ascii?Q?3cMfdZd2z6g+P5UnfZIlptjx5kqCOJX98W0IT2UlWHc0a6BS72ZTGc6+KvQU?=
 =?us-ascii?Q?GY+AURdann/DCYdK6L4VpWTCwpuTUuaVkJi4yMrtz7JvtefCwRlDVmJXRgjI?=
 =?us-ascii?Q?hQH6MkX15CzwGyB3QH/eiZDzcIB78pFRGolaYtn6z6bIVZ6zyUwggm5fEuST?=
 =?us-ascii?Q?igVX464KZu/Hkxt2+q43r3FV2Pz784Yrwep7wP0GMMoF3q88cUvCJpZOL2sj?=
 =?us-ascii?Q?b1nv3Q0jIHTb4+N3q63dlPBXoyAPmJA5wqAxL8kPw91+9c4h1NlxpqqmWbRQ?=
 =?us-ascii?Q?e4wIbTTZDBAhmYsy2I9E82kjTAf/PlCj458sxmJnpfUVEoMM4F7S7ZlEDZMP?=
 =?us-ascii?Q?mB4HVSUodlFXKZohNr7qD9x1t7KN7kvmdnzeiDmBTDyw5iyeiTMMX3s+LZV1?=
 =?us-ascii?Q?ivgek7XgTJp+yePcH39gRBR/ZvV4y6WvPfbzPDTp7fRW6dAiGK8Jdb1fW0+H?=
 =?us-ascii?Q?xVpDVqgPRT3Nze+HRJ8ECDUlKjr7HbHhhUY4sxQGYuVBZ6EAdMOrgG70qclx?=
 =?us-ascii?Q?y5o8QB7Li1b2jG9Yr9ycGp3tvIiiB+yYmFRQoYxdcVBHLL8uuePpzNXEKSJC?=
 =?us-ascii?Q?3TfCPBDUu+wPlPWqHP3vzmjrWZaQdxpYI4wkfx/w5+IjibMp7wokoJj/6FYS?=
 =?us-ascii?Q?GlBr6awS4/JkvFL7cqQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c359170c-42a4-44ec-5d12-08dca6daa264
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 03:35:13.7158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0XiYpxMhSoz1nda1547BUFCuXakXnV9r+crLzYQSuwBDHQxvQ2d1jg1e1RaMzuzumxCyt5yJkEfhWgGbwmlOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
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

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, July 18, 2024 10:57 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, July 17, 2024 4:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,
> Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
>
> 1. Use pa_pfn as the radix-tree key index to log
>    deferred error info.
> 2. Use local array to store expanded bad pages.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 14 ++----
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 65 ++++++++++++-------------
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.h  |  5 ++
>  4 files changed, 40 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index dcf1f3dbb5c4..f607ff620015 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -476,10 +476,10 @@ struct ras_err_pages {  };
>
>  struct ras_ecc_err {
> -     u64 hash_index;
>       uint64_t status;
>       uint64_t ipid;
>       uint64_t addr;
> +     uint64_t pa_pfn;
>       struct ras_err_pages err_pages;
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 5d08c03fe543..2fc90799bf8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -523,18 +523,10 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device
> *adev,
>       ecc_log =3D &con->umc_ecc_log;
>
>       mutex_lock(&ecc_log->lock);
> -     ret =3D radix_tree_insert(ecc_tree, ecc_err->hash_index, ecc_err);
> -     if (!ret) {
> -             struct ras_err_pages *err_pages =3D &ecc_err->err_pages;
> -             int i;
> -
> -             /* Reserve memory */
> -             for (i =3D 0; i < err_pages->count; i++)
> -                     amdgpu_ras_reserve_page(adev, err_pages->pfn[i]);
> -
> +     ret =3D radix_tree_insert(ecc_tree, ecc_err->pa_pfn, ecc_err);
> +     if (!ret)
>               radix_tree_tag_set(ecc_tree,
> -                     ecc_err->hash_index,
> UMC_ECC_NEW_DETECTED_TAG);
> -     }
> +                     ecc_err->pa_pfn, UMC_ECC_NEW_DETECTED_TAG);
>       mutex_unlock(&ecc_log->lock);
>
>       return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index eca5ac6a0532..f2235c9ead29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -524,9 +524,9 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       uint16_t hwid, mcatype;
>       uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> -     uint64_t err_addr, hash_val =3D 0, pa_addr =3D 0;
> +     uint64_t err_addr, pa_addr =3D 0;
>       struct ras_ecc_err *ecc_err;
> -     int count, ret;
> +     int count, ret, i;
>
>       hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
>       mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType); @@ -559,39
> +559,18 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device
> *adev,
>       if (ret)
>               return ret;
>
> -     memset(page_pfn, 0, sizeof(page_pfn));
> -     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> -                             pa_addr,
> -                             page_pfn, ARRAY_SIZE(page_pfn));
> -     if (count <=3D 0) {
> -             dev_warn(adev->dev, "Fail to convert error address!
> count:%d\n", count);
> -             return 0;
> -     }
> -
> -     ret =3D amdgpu_umc_build_pages_hash(adev,
> -                     page_pfn, count, &hash_val);
> -     if (ret) {
> -             dev_err(adev->dev, "Fail to build error pages hash\n");
> -             return ret;
> -     }
> -
>       ecc_err =3D kzalloc(sizeof(*ecc_err), GFP_KERNEL);
>       if (!ecc_err)
>               return -ENOMEM;
>
> -     ecc_err->err_pages.pfn =3D kcalloc(count, sizeof(*ecc_err->err_page=
s.pfn),
> GFP_KERNEL);
> -     if (!ecc_err->err_pages.pfn) {
> -             kfree(ecc_err);
> -             return -ENOMEM;
> -     }
> -
> -     memcpy(ecc_err->err_pages.pfn, page_pfn, count * sizeof(*ecc_err-
> >err_pages.pfn));
> -     ecc_err->err_pages.count =3D count;
> -
> -     ecc_err->hash_index =3D hash_val;
>       ecc_err->status =3D status;
>       ecc_err->ipid =3D ipid;
>       ecc_err->addr =3D addr;
> +     ecc_err->pa_pfn =3D UMC_V12_ADDR_MASK_BAD_COLS(pa_addr) >>
> +AMDGPU_GPU_PAGE_SHIFT;
> +
> +     /* If converted pa_pfn is 0, use pa xor pfn. */
> +     if (!ecc_err->pa_pfn)
> +             ecc_err->pa_pfn =3D BIT_ULL(UMC_V12_0_PA_R13_BIT) >>
> +AMDGPU_GPU_PAGE_SHIFT;

>[Tao] why address 0 should be avoided?

[Thomas] When address is 0, it means the data has just been loaded from EEP=
ROM, it should calculate  pa_pfn.

>
>       ret =3D amdgpu_umc_logs_ecc_err(adev, &con-
> >umc_ecc_log.de_page_tree, ecc_err);
>       if (ret) {
> @@ -600,13 +579,25 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>               else
>                       dev_err(adev->dev, "Fail to log ecc error!
> ret:%d\n", ret);
>
> -             kfree(ecc_err->err_pages.pfn);
>               kfree(ecc_err);
>               return ret;
>       }
>
>       con->umc_ecc_log.de_queried_count++;
>
> +     memset(page_pfn, 0, sizeof(page_pfn));
> +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> +                             pa_addr,
> +                             page_pfn, ARRAY_SIZE(page_pfn));
> +     if (count <=3D 0) {
> +             dev_warn(adev->dev, "Fail to convert error address!
> count:%d\n", count);
> +             return 0;
> +     }
> +
> +     /* Reserve memory */
> +     for (i =3D 0; i < count; i++)
> +             amdgpu_ras_reserve_page(adev, page_pfn[i]);
> +
>       /* The problem case is as follows:
>        * 1. GPU A triggers a gpu ras reset, and GPU A drives
>        *    GPU B to also perform a gpu ras reset.
> @@ -631,16 +622,21 @@ static int umc_v12_0_fill_error_record(struct
> amdgpu_device *adev,
>                               struct ras_ecc_err *ecc_err, void
> *ras_error_status)  {
>       struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
> -     uint32_t i =3D 0;
> -     int ret =3D 0;
> +     uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> +     int ret, i, count;
>
>       if (!err_data || !ecc_err)
>               return -EINVAL;
>
> -     for (i =3D 0; i < ecc_err->err_pages.count; i++) {
> +     memset(page_pfn, 0, sizeof(page_pfn));
> +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> +                             ecc_err->pa_pfn <<
> AMDGPU_GPU_PAGE_SHIFT,
> +                             page_pfn, ARRAY_SIZE(page_pfn));
> +
> +     for (i =3D 0; i < count; i++) {
>               ret =3D amdgpu_umc_fill_error_record(err_data,
>                               ecc_err->addr,
> -                             ecc_err->err_pages.pfn[i] <<
> AMDGPU_GPU_PAGE_SHIFT,
> +                             page_pfn[i] << AMDGPU_GPU_PAGE_SHIFT,
>                               MCA_IPID_2_UMC_CH(ecc_err->ipid),
>                               MCA_IPID_2_UMC_INST(ecc_err->ipid));
>               if (ret)
> @@ -674,7 +670,8 @@ static void
> umc_v12_0_query_ras_ecc_err_addr(struct
> amdgpu_device *adev,
>                       dev_err(adev->dev, "Fail to fill umc error
> record, ret:%d\n", ret);
>                       break;
>               }
> -             radix_tree_tag_clear(ecc_tree, entries[i]->hash_index,
> UMC_ECC_NEW_DETECTED_TAG);
> +             radix_tree_tag_clear(ecc_tree,
> +                             entries[i]->pa_pfn,
> UMC_ECC_NEW_DETECTED_TAG);
>       }
>       mutex_unlock(&con->umc_ecc_log.lock);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> index b4974793850b..be5598d76c1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> @@ -81,6 +81,11 @@
>       (((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
>        (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
>
> +#define UMC_V12_ADDR_MASK_BAD_COLS(addr) \
> +     ((addr) & ~((0x3ULL << UMC_V12_0_PA_C2_BIT) | \
> +                     (0x1ULL << UMC_V12_0_PA_C4_BIT) | \
> +                     (0x1ULL << UMC_V12_0_PA_R13_BIT)))
> +
>  bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t
> mc_umc_status);  bool umc_v12_0_is_uncorrectable_error(struct
> amdgpu_device *adev, uint64_t mc_umc_status);  bool
> umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t
> mc_umc_status);
> --
> 2.34.1


