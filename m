Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48D7CA600B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 12:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EDAB10E0A1;
	Thu,  8 Oct 2026 12:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JFKiL6Xz";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A1E10E0A1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 12:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlWVHIgEpqmlpSCuFJpqV7fXGcj4hZA+9hEMCHKZWMAZB8MU6ONKmjrPP161lBIq579Cvl1Xc4gt7yaXrqGERQV9Ta8DdormyUTyCZMbet5ZGoSDAtI9l+rFyrmtM47lY6cSIBLxrv6Ot55Ins+cF/ZslWKpeIrGS15sKs5gkC65/vXCiigRHcfVsnj+xttmJ6GzdBGgmf6A3pqIh2KlRf8k6NppKuSdAjBjwiDlyOr85Lt8RvlqTTtEmldEiFAbxJnIguAuFg9Dt+DeahUaMf5xSDri/GxgtibZocBqCYmkiKs/n2cb2p3t7d2cjFPzj15rcxP+2Vrgi8NFyDBxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea385eaadJXQltcRi7yfZhe6y8xSUZrE+XwwUTqhoUc=;
 b=fzn1MpHhnWrTAqy5+sAZVRm5Web87lHg56BYLgkasK9mYPCQV62U+hjRhHxYuxXvwG5kaZgrYcJF1Rd+m1P/7V/3DDYf2nmwSztwJ0hoUKTauNOYbsNFUeTkqGhyP0zyHAAnaerYwSg/Tk4hIeB9bsURCUufNR9BQN3ZPNlLq3n7iGBwGbUlwSJhR3kCx5s1UYO7PZclfnNsLdahGEk6TEVSQVjhzAFCsMNUFQPvK70lr2rXziwb6CCXeosqidWM0EbWq4tEuIGIUGiOsVrja7oz7bUvyUwGT2JW3oCUbgXAfXjjATZ7Qq7bjR9woD7O5OtNK4qHKvGEAleS+EWRPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea385eaadJXQltcRi7yfZhe6y8xSUZrE+XwwUTqhoUc=;
 b=JFKiL6XzenI9OR8CCeDXrR4MOe2WKch/COSw7k7cV4FQn4rFAhtxVLYVYVGQEkLBixCMIk4w76BOV8gRVuL9MCHEChmGDLAOU1JWrIC5z6k+JIId6jjdw0jvKH8dLzvn8xlxq5XzD5RIGSWdB4CgE6dv686mggLi1nlDbQFtTrs=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 12:10:09 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 12:10:09 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Liu, 
 Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
Thread-Topic: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
Thread-Index: AQHdT8U/OFtQTBjuH020GWqQmH3vt7bzm+Ww
Date: Thu, 8 Oct 2026 12:10:09 +0000
Message-ID: <PH7PR12MB6000C5665A2265B98B90FDFCFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-9-Prike.Liang@amd.com>
In-Reply-To: <20260929034650.2393125-9-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-08T12:08:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|PH7PR12MB6562:EE_
x-ms-office365-filtering-correlation-id: ab3634c8-a4d7-4bcd-4651-08df2535192b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|38070700021|11063799006|56012099006|10067099003|6133799003|18002099003|4143699003|22082099003;
x-microsoft-antispam-message-info: nTzylK3sFtm9w8oXb+0UuNaRNJXZXAHpPnz7f7MInCMtXnpNni+8JdWHWgpyRkHdKeVL28MPh1BlI++8dL3ZkcvI1o2ojHP6BXdVo2UPfyz63cqgN8tI23ZhkwUvZ+uOKfOCHS86OP6LLmiK8ysj+Y0rpfiar5xzglSHEMIf16ogbtMC7HQJkrk+rmwQdUWVD/FD86f1C9+2IwFzF0RO62o7osxuoMjalQd/o/1vaNwXnqJLQUFIPDQsCE4H3d6FtjQ+xpGeqBAmbT4IE7T91XWr6snhdeUs1kC8cGZ0khTJqzKbSbGvP5kwqVXk+FuU/R9zcFHDuSwsUtsb4TJW5La+sriPqH50wlfk0KWM5QTEr40C1SBI3+6EG5Z5PsbRyNFchEZrJxvHN1uKnWm6V/c2lUWNfCKLu9CwJLdqn/hqJTE49GyJTJAN/kZNGQCQTnIR7wCrjSvOztLwRC+YOM1tnO+1J8sybimVcKt7DpwS4cwikgka0v9bslN0IvbSiH/Pdi+xWTCgqhHJGSOAvBJyG7yZhsxrvnPxqAZL8A9o4PaC0+bB1ORh6wJzQUfWTzdo+V92c1WS8S0GX5yWXRk0BOJ3Rdha0452CJ+XEqymCLNVY0oK+AC4jHiC2LcYK8HZA8bJ5izQCMqgTyeBqQMELc6qBmKRjyYCQQLE/I+nr5qMZQEMSDRacTn59tzupzJ+S3rzW1pGhcsRs7QxXM5FxUO4c3cIlWVtLyq0sFg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q8dnDQ1a1vKrocEeBuTF4p57LN9Ws76pSiCZ3CgpslO7ii3yiXPoA7D+8T9r?=
 =?us-ascii?Q?Lq1WyzuJG9G+m8zPB2R1CEJ7kMl9CJQ/XUzZGNFx8b8KGgoARbv10sIHA3bK?=
 =?us-ascii?Q?spJ3IKqdQSYjozdM4QTpEFFpk0QbqCJQXvcAhYvcyvcn8xWVxtJ/zftM9v28?=
 =?us-ascii?Q?+2UHhC+4Uhj8oCmIe2chMuALJopVvyNbzWaCg5CzQvwEIiukkDmDAChFTONx?=
 =?us-ascii?Q?mgPJ75IsIqDSy9GHEszAG2vZwhIAoAxh14O0W7vi3RmPayRojGevoIRvOAHp?=
 =?us-ascii?Q?jdZmXjUxoYfBA84sNfqP6xO3ePaMr3d8T1158HEEyxxggcQiiYwvSnNGzr5f?=
 =?us-ascii?Q?7Pq5P2cO1Tx6HZJauUrl7cGT5FhYxIyxArGvFO2k6lk4KVgH2IuJWU99rjSo?=
 =?us-ascii?Q?Nf6nQaFkpiAfSrC0JFgzL4eHa7zZsTVBHvIdvH8pHLsmkJksz17vctWM+VKi?=
 =?us-ascii?Q?SvGs7MfbW07ICz7NjIPn3bBiAhXG4Za9g3By2plx4OVj55nitWQEwbttck0y?=
 =?us-ascii?Q?6Y2dhgzGqxyjhG4kLeiJJwjmzqzE6BLoISfYOy60Ygs3fHQrxj4qREXtT+28?=
 =?us-ascii?Q?dSbhyNpZ2IsgJ0BgA66GIB4p4NMHz9IHS6heKyjnLOqWN2vVi1a4E2r6oTdg?=
 =?us-ascii?Q?lcLBj/SSm9t4+Ovq6oUrhj+9aTdZhCERhm1VV87Av+h5rdDhiFns5l+Yxz4P?=
 =?us-ascii?Q?lqzQTH+UAgoVlmgcqTpRgA+mAxi4NC1nmjM3nlHXP/MAPi1uGI/nOv9s9IVY?=
 =?us-ascii?Q?ZFiyo0Zj00dfvwY20n+J0knfJOE3nouGXjyUwDmPze2gLoIGlVHOCmsEDmgv?=
 =?us-ascii?Q?ai3wdW0uvzUQMHyWFv8SmKLiATKQ/FtLpWdObaQ+0pjwCfYiTfgrnfczgTUe?=
 =?us-ascii?Q?SHuDhlwk77J+ilmBio2UORer6nZ/8cgWmitbTURM7KW3pJJ6xp2L/fecSa69?=
 =?us-ascii?Q?gYavg//rDQoUk1SKi2ruDvvGDt7zq27AM4dXkQImEntSgnplFVsB5Ar49GUN?=
 =?us-ascii?Q?boLjIBT7FD54+bHm2YE2RmPgXyQ1zNVzQwvS3DM0JzIXslN7wLv+DiG28RsC?=
 =?us-ascii?Q?IjTCQHeIDS6Dj/sZOOfTo5pNW0Xac6RWN/T43Ukar0blDZOG4iM++uxCLiuk?=
 =?us-ascii?Q?Tz0ceMLnyvGTgHgTC/+Pw7850spvLht5NN5xdsim7xZ9J9d3K2Z99maL5aBz?=
 =?us-ascii?Q?8T7yxxEH63dSDdW2M9ZZbaOjmjCdTnu+f9BtPrQfYNIT6Pcdv7Oq35tvybi7?=
 =?us-ascii?Q?IF/m71ikbpqXOGaUwLxugAvhjW6AJ7LIdBrLt3hXgYIkfgCGJLMdSCuq/yKP?=
 =?us-ascii?Q?ohPdVH3ahtffhwNgvgKi5PDVSy+JbqanqHsEtZ5/nZ8pAFCM3AnJ4KBk7JlE?=
 =?us-ascii?Q?HHoZjgdBDtc1BZ2ntWXfDKdKTNXSVxkczA0DZCOcudGtEwvdbtfsLHtmAAcP?=
 =?us-ascii?Q?8RC9j/K5CXUjGImTk0C9lrqM6lqkp1SEkhe3+0y481GFwisdIkaVGsbdUo4Y?=
 =?us-ascii?Q?Hkx3C+iPW1P0Iwm7/+Ln0I8spJz5r41m20udCaNxgtpjAnBhh/rc28fwQ8S9?=
 =?us-ascii?Q?dAEDLU13hLc85Q5bJZTiF73vdz1YwyOxmIz4wXRGquFCMrFOjO5HswgOtH73?=
 =?us-ascii?Q?6Zek+yD4miqXGrJWjnMe4wV8WTzO1DzVEKv2WHfRizjPKGXLS3JEm/r/6O3C?=
 =?us-ascii?Q?JaUVm66y50wEsyPEgx5FJ+U1Z7tjF4oCqEtwuykOo1XwPuYJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3634c8-a4d7-4bcd-4651-08df2535192b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 12:10:09.5521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5D+2UwzpkUfICK6hB4UBKx5Al4b0MlKVVFnXcPZMAnz9lyYjzxA7Dwc75Z/36yn/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
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

Ping the fix for VCN/JPEG idle work.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, September 29, 2026 11:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Lia=
ng,
> Prike <Prike.Liang@amd.com>
> Subject: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
> GPU reset
>
> Protect media idle workers with a reset-domain read trylock. On contentio=
n, requeue
> the idle timeout and return without hardware access. Keep the ordinary en=
d-use
> scheduling event, including from reset-time ring tests, so otherwise idle=
 engines
> eventually power down and VCN drops its profile.
>
> A blocking read acquisition would deadlock with reset-time synchronous ca=
ncellation
> of these workers, so the workers must only try the lock.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 7 +++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 7 +++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 9887a4f99aed..7b10260ad0d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -114,6 +114,12 @@ static void amdgpu_jpeg_idle_work_handler(struct
> work_struct *work)
>       unsigned int fences =3D 0;
>       unsigned int i, j;
>
> +     /* Reset may cancel this worker synchronously while holding the wri=
ter. */
> +     if (!down_read_trylock(&adev->reset_domain->sem)) {
> +             schedule_delayed_work(&adev->jpeg.idle_work,
> JPEG_IDLE_TIMEOUT);
> +             return;
> +     }
> +
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               if (adev->jpeg.harvest_config & (1U << i))
>                       continue;
> @@ -129,6 +135,7 @@ static void amdgpu_jpeg_idle_work_handler(struct
> work_struct *work)
>               mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>       } else
>               schedule_delayed_work(&adev->jpeg.idle_work,
> JPEG_IDLE_TIMEOUT);
> +     up_read(&adev->reset_domain->sem);
>  }
>
>  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring) diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 17db7264269e..f851a6ecea1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -470,6 +470,12 @@ static void amdgpu_vcn_idle_work_handler(struct
> work_struct *work)
>       if (adev->vcn.harvest_config & (1 << i))
>               return;
>
> +     /* Reset may cancel this worker synchronously while holding the wri=
ter. */
> +     if (!down_read_trylock(&adev->reset_domain->sem)) {
> +             schedule_delayed_work(&vcn_inst->idle_work,
> VCN_IDLE_TIMEOUT);
> +             return;
> +     }
> +
>       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>               fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->ring_en=
c[j]);
>
> @@ -499,6 +505,7 @@ static void amdgpu_vcn_idle_work_handler(struct
> work_struct *work)
>       } else {
>               schedule_delayed_work(&vcn_inst->idle_work,
> VCN_IDLE_TIMEOUT);
>       }
> +     up_read(&adev->reset_domain->sem);
>  }
>
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> --
> 2.34.1

