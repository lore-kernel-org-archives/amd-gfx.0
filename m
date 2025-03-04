Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0DFC282D0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 10:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0BBC10E309;
	Tue,  4 Mar 2025 10:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cPgrifqC";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D90D510E309
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 10:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5WjBI2rEesead7V0PvdfrymAfU1/ky+y381VF0/8P5vdMIzlkMFMiKMIZNeZ/LPPEaXRpeFXrNTIA9PMJllWsUwGGf9YmYXhwbEACyGWqAzmlnAyDGocrLQ2Ru93QfowAmPkaPDYGjKOmBtULUlCOgOaeg2feS9RVvDuT7q0EBdvUHB9gXEHEmFxBMp1BiL57fAyC989KymKosIKQjo5Hz5QrVb4Oy0f3rd10EzsGtIKrkMNaLTAwyrhtxODY7eClL66T7eWEba0zDtvkfuoY+N5oaCP/zNS614B6NXe0Odny5hu/hcHEL9JmsMqLRJcxvmxdGLLgG1xrLNMPeCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn7hm7gjCagR4ZGFI9sz9cEJQrtafGvSw1tbl3VOKWg=;
 b=aKQuXhkD52yZmGy8OegPGtDXj8AlcbMFyPtuZbAs5zYJFfAlhnskokJz9FMEDdj3gwNZBjZeDoseUYVX0BtWgrI5E2tWBnkRa0Baw1hWdRXF3R3aAUCyt6C7Qt0v/oUQwC7t96Y+ITYp9E+wpa9Ce97DiSo0gRdPreSjQOq9jC1y623axYHY8XyfNp9mKeJkp0R8SMWkEaVkHCErfqkSpaifj5UXpROm2rsgJw5/GCZjOLzE1CYjBqE5Ny6smD4FgRh8TWIiKsKYNsom8hgysNGJrL2luNdqK0xgYxDDGifWq7L6hHFhFX20zNBdm3c0/YRewjCZC6qLsdC7uzGAOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn7hm7gjCagR4ZGFI9sz9cEJQrtafGvSw1tbl3VOKWg=;
 b=cPgrifqCuiBWIJIAndVh4riNOY6gM810P9ZMYjtt3nT6vRC+9nrjQM/7WLN+DlEkSNjJrLeQOsFBtZltuS9HFcbFEbnJEAAjqnes6coAQlvQWPp/J8NTK5SR3glWzI+5JhOg+RjiYWDZ+zD0gaHe3lZ0zs75F9iNbN/lyqmc96I=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 10:30:07 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 10:30:07 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yi, Tony" <Tony.Yi@amd.com>, "Yi, Tony" <Tony.Yi@amd.com>, "Skvortsov,
 Victor" <Victor.Skvortsov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Luo, Zhigang" <Zhigang.Luo@amd.com>
CC: "Yi, Tony" <Tony.Yi@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
Thread-Index: AQHbiSo6iXz1azjfEEmDaWakGF6hl7NizmgA
Date: Tue, 4 Mar 2025 10:30:07 +0000
Message-ID: <PH7PR12MB87965D0976F306143111C9E7B0C82@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250227151217.2620348-1-Tony.Yi@amd.com>
 <20250227151217.2620348-2-Tony.Yi@amd.com>
In-Reply-To: <20250227151217.2620348-2-Tony.Yi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d03a88b4-9c53-486c-ae73-8ba89c2b835b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-04T10:29:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY5PR12MB6155:EE_
x-ms-office365-filtering-correlation-id: f6ea6b0d-b2af-4f20-c30e-08dd5b0788a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|921020|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cEtl4fAQN0JW1SGtRAKh5WZEIbpQNUxgfTvj+l3sgCCLEHMPpQjcnbFKXlIJ?=
 =?us-ascii?Q?ji/ivpA2NV8LbIsmwit4P1FNWzvtNmFjN32p83b9728cgx1ZFXxu/1R0YOfi?=
 =?us-ascii?Q?ymCmElGnoxovvcYOx+ozvVFofm0xuc8c6ifpPR+26ZVf/DJjEDtEtUubkM8M?=
 =?us-ascii?Q?/XdHqALLqB3xhvL2b3OQqwr/hUIjfoey2lGOkRlbKQjllQrWuKNh5ypE1EW8?=
 =?us-ascii?Q?hS6J5rgqZnOzjCOcBxnpB0gUZ4M5H/LtUqiAfGArakEde1qSifJ1yUfh0ZIq?=
 =?us-ascii?Q?Y2aDfHKTXl9L/D9d/xET2wVvKSOPty32JmRc3u569WcuFx9SGUsY7tjvrdpl?=
 =?us-ascii?Q?r+Rn4z1Q4bz993o5PEIuAkiBZpXxeAO8qQOntDzX62yj7He2OuaXkc/qrdOJ?=
 =?us-ascii?Q?6cXZ0k5f1vsBol61qGHPTcbpVs9XZK9PSxZwMbCBV1LBvaBHEVeHamEj33GM?=
 =?us-ascii?Q?KTcYd+lT6djXcYfw2UO9wh8OQo7LBOL2tDPY6Cp1yPQrKWIp4kxlLKjUud1m?=
 =?us-ascii?Q?wFLxcgqYbdTuytvtNXKs16axbJoRmr2+Z2yl/Y4Ph1TblPO/7eNwUJKhyVFS?=
 =?us-ascii?Q?Gex9fK3nOftDgzrhfmgVy2dIqL9uGdw8nNNxsGUEG67xvoLXdB12ze7OcO6B?=
 =?us-ascii?Q?hi82IkMyYlWPZGAS4msHfC82szPgp+qoPq+MusRYwBTZ8cnVtHXNIzm0PJrR?=
 =?us-ascii?Q?KRFxb8dKxmeWbAegODPxPFtYF+KC7bvHKviU5mFBBwz1tN0OwXecKEfCTw96?=
 =?us-ascii?Q?zwC0cnS0GFG7cEJ1Qe81+kqxha5pMs5enLU9mjRxXPgYRgP3OVMDH5qQZ5Ox?=
 =?us-ascii?Q?4Gax5OnSRlPjUIR87SQteSm6cBtZy73TamV2vbdHhVAJ7jWH/mEssGNMisCC?=
 =?us-ascii?Q?YM2Ci5aWEPy1WNN3546D0ZGc6T+DfCAZpa81hWSHV4bIKNNn31uVwrhWrUE1?=
 =?us-ascii?Q?B2mjjLTmKpEQZy0qkQIKJjeYdAV7NKp2EAxbh1zQkCJXtAWH2h4zEn2z0rqu?=
 =?us-ascii?Q?I+UeMs5bcf3Y48yLaYHrMWH4fOBUOZRxdg3CzQ90/30HA5ZplkPfKnJb3AAK?=
 =?us-ascii?Q?C2N5YIBN2RHszcm3O6owE2yinvkLz7hq4pM3xIAwIEDTGiGIesUVBtt3vs+R?=
 =?us-ascii?Q?aS9fvAT9f/fxPBv/D1VeiLkY1KvwQUhgik9HaDOrW1+6Mnq6l/uCqBfgal08?=
 =?us-ascii?Q?kIq/NWOO9I403sKTdaGgc26DmJIxRU/3aKWIBoQ0mQ/DANnr92a8BIvsfZd/?=
 =?us-ascii?Q?W0OZyGFagtz3cicI/IPG4bcO5JX6rZKtSMScqn9Y+9iWdyY7iXm0bIN0Zzdq?=
 =?us-ascii?Q?kTe6/GZoq0zx1tPvGt/Oe2wpBuZLg6vjzgn8Scg9Xp6XU0zmQe6Dpj4vbtF2?=
 =?us-ascii?Q?mPix2NiC4LJvo6c4HnxjnO+HkfKBqbCCRsf+GA0pRvV3AYf465LOkNjUDb2R?=
 =?us-ascii?Q?Aykjk/Pmf/Q8xy/vXY41u1kfFt/nQrGr76dF80SF8acGjPb5OrCdIw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(921020)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UmYWqg0MNF1bbfRG5/j/qEwu5jZWKywPfhidLhOTOnN5JvXaOFKE6Vzfp4bG?=
 =?us-ascii?Q?FM6uivSTjJo17gD9/Y5tbIm2D2PSMoT7JLHwMLcCh3QULNzkWk0sKljDRHMc?=
 =?us-ascii?Q?QaMWFa5HRSXoDgL6OpCJRfMmRxgKlDOmfxowRI3FgOpdME1d3uWJ4GROQKyK?=
 =?us-ascii?Q?USpz9BWgE780alNYBGj1QtE3Satq+VdpJNkOs60l1A9WLhW4kVvZBWoyBoqv?=
 =?us-ascii?Q?2DfWk493awC3MMeNDy12BEu8APvXKHLzbgmqy8pr8tJ3+RL1QWIzE8AytDgV?=
 =?us-ascii?Q?eKqmJ4oWEWgnQnrwK29MceWF5Mfzkcqy0sX56SjveDHWOLhNLDR85oy4JfgV?=
 =?us-ascii?Q?+17pz5XsE5KyYl7qO4qujua51AfzoG8vJapKDzYjnPxzk94GvL1wX2xvw7k/?=
 =?us-ascii?Q?qT7+k8AerAPKUcxMXo5iVJw1XbsbRNEj6x9885Tvg3ey307b8I4N55gKD88x?=
 =?us-ascii?Q?qJePiQxCoxU7fVYSkjAFIhGyXrnI5jBvxk9ce9BV2wCZKA/PvGrCnoHAcjNi?=
 =?us-ascii?Q?6hMbCWKw2/XTo2E8gd0f8NJbrlcmu4Yj+AEg+KB6ERhegyno89QVpWoZRUYi?=
 =?us-ascii?Q?UwLA8kkscnyB4jnWVJzrUjU8SMsxtV8mflRUBx6fkJhBz7mglu0Op5cLDF8B?=
 =?us-ascii?Q?DBfY0lADlznm1nIMt7taDovxZ+nOu6GKAvrxnoDUNkNWciv1X9igWRLsYVMJ?=
 =?us-ascii?Q?k5VQ2sNcr7vYoQecYo33jdH9QUDSuIsIxk6+yug1vxm8HbCss1fxKAuogQgQ?=
 =?us-ascii?Q?hN/4hCYl+CrtI7Sn7RoYr/IklF/0yDzogwDvz20M7nIXUCF54aaJ/trMLgpG?=
 =?us-ascii?Q?554axFFDsD94/0trrzI9ClVRfR95M3mq4MCnJDdBEJRJesNfDzvKsCfhpm/9?=
 =?us-ascii?Q?p8fAqs3it9LRNPsb9O8Rk1W25opVTy+qnxNYLoMJTITvw7VDpdXAzHmN3br1?=
 =?us-ascii?Q?Mdw30l1dcA5zz+2rZ0vEnDMK34NmA7Sl87Wsc8s5ZrEdDpVg2Guv4n3u6sgj?=
 =?us-ascii?Q?WVIHxA3TJmtraVzxA1oFmYs0dfb9GgZ1IaIf6DULR6v9HdgLf6o8d9ofH/Jz?=
 =?us-ascii?Q?nNe/we1t2/vYgyqdFT4dWzQPYBwYz9ufxMNxYGxr7RiR6Qfttux/5HhFES3t?=
 =?us-ascii?Q?PHzBPX3N+AdEV+FQDHn8SyjVVAhaM3ZqAfLH4mptHE5D75QdOPDEcnDHesYT?=
 =?us-ascii?Q?0FanEgrUBuw8YgBHUQj1dZv9MpySyRbxqjD8nfYuB0aED0ugGVKBUOQCxw/m?=
 =?us-ascii?Q?qGBD17Ejzm1s6JnxUcpEVSw7kLqbITUdZBvrVcqtMPRPMIcEyG5v+8BcZDJ9?=
 =?us-ascii?Q?PniKu3AA1vzdTrm4zylCDykpVNveXAOFExXMUS/vm3x/qjtVfHU6eW5QNcAX?=
 =?us-ascii?Q?+0z9exGQw/Rxz1vRlK36RaiVwyy1zq7KGbHL2NJCsJvfOpfr4ySZDBFptlr3?=
 =?us-ascii?Q?vWr6tVlEck1UUycnJ5NivZ+5F08iyiJte81k4zYF94SQBSk+AZCqM7vHvKYt?=
 =?us-ascii?Q?b4bpKMLoi9nTWNj3b56FdnLGR8FWpAVh0xbx6hEHDkxH2KvuQ/FKAAUO17OF?=
 =?us-ascii?Q?m9tED62pwdQ1caeSgycXpR0Qn+SQoUzTMRWrhFjDUzCZuSHJUXPXFtfgKDmk?=
 =?us-ascii?Q?5iDxN7FWYoepkWi84QNoMLc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ea6b0d-b2af-4f20-c30e-08dd5b0788a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 10:30:07.1533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ciRBhNJWAGZxx9oC4M4S68Bh/IYeCKSvBGl9j6FYrUg8f4+sDmrIPxXJvHJTgexY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tony Y=
i
> Sent: Thursday, February 27, 2025 11:12 PM
> To: Yi, Tony <Tony.Yi@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.c=
om>;
> amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Lu=
o,
> Zhigang <Zhigang.Luo@amd.com>
> Cc: Yi, Tony <Tony.Yi@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
>
> Add support for CPERs on VFs.
>
> VFs do not receive PMFW messages directly; as such, they need to query th=
em
> from the host. To avoid hitting host event guard, CPER queries need to be=
 rate
> limited. CPER queries share the same RAS telemetry buffer as error count =
query, so
> a mutex protecting the shared buffer was added as well.
>
> For readability, the amdgpu_detect_virtualization was refactored into mul=
tiple
> individual functions.
>
> Signed-off-by: Tony Yi <Tony.Yi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  31 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 138 ++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  18 ++-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  14 +++
>  5 files changed, 195 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5e1d8f0039d0..198d29faa754 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3099,7 +3099,8 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce
> *adev)
>
>       amdgpu_fru_get_product_info(adev);
>
> -     r =3D amdgpu_cper_init(adev);
> +     if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_ras_cper_en(adev))
> +             r =3D amdgpu_cper_init(adev);
>
>  init_failed:
>
> @@ -4335,10 +4336,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>        * for throttling interrupt) =3D 60 seconds.
>        */
>       ratelimit_state_init(&adev->throttling_logging_rs, (60 - 1) * HZ, 1=
);
> -     ratelimit_state_init(&adev->virt.ras_telemetry_rs, 5 * HZ, 1);
>
>       ratelimit_set_flags(&adev->throttling_logging_rs,
> RATELIMIT_MSG_ON_RELEASE);
> -     ratelimit_set_flags(&adev->virt.ras_telemetry_rs,
> RATELIMIT_MSG_ON_RELEASE);
>
>       /* Registers mapping */
>       /* TODO: block userspace mapping of io register */ @@ -4370,7 +4369=
,7
> @@ int amdgpu_device_init(struct amdgpu_device *adev,
>               return -ENOMEM;
>
>       /* detect hw virtualization here */
> -     amdgpu_detect_virtualization(adev);
> +     amdgpu_virt_init(adev);
>
>       amdgpu_device_get_pcie_info(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 81a7d4faac9c..d55c8b7fdb59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -578,12 +578,32 @@ static ssize_t amdgpu_debugfs_ring_read(struct file=
 *f,
> char __user *buf,
>       return result;
>  }
>
> +static ssize_t amdgpu_debugfs_virt_ring_read(struct file *f, char __user=
 *buf,
> +     size_t size, loff_t *pos)
> +{
> +     struct amdgpu_ring *ring =3D file_inode(f)->i_private;
> +
> +     if (*pos & 3 || size & 3)
> +             return -EINVAL;
> +
> +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_CPER)
> +             amdgpu_virt_req_ras_cper_dump(ring->adev, false);
> +
> +     return amdgpu_debugfs_ring_read(f, buf, size, pos); }
> +
>  static const struct file_operations amdgpu_debugfs_ring_fops =3D {
>       .owner =3D THIS_MODULE,
>       .read =3D amdgpu_debugfs_ring_read,
>       .llseek =3D default_llseek
>  };
>
> +static const struct file_operations amdgpu_debugfs_virt_ring_fops =3D {
> +     .owner =3D THIS_MODULE,
> +     .read =3D amdgpu_debugfs_virt_ring_read,
> +     .llseek =3D default_llseek
> +};
> +
>  static ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,
>                                      size_t size, loff_t *pos)
>  {
> @@ -671,9 +691,14 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device
> *adev,
>       char name[32];
>
>       sprintf(name, "amdgpu_ring_%s", ring->name);
> -     debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
> -                              &amdgpu_debugfs_ring_fops,
> -                              ring->ring_size + 12);
> +     if (amdgpu_sriov_vf(adev))
> +             debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
> +                                      &amdgpu_debugfs_virt_ring_fops,
> +                                      ring->ring_size + 12);
> +     else
> +             debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
> +                                      &amdgpu_debugfs_ring_fops,
> +                                      ring->ring_size + 12);
>
>       if (ring->mqd_obj) {
>               sprintf(name, "amdgpu_mqd_%s", ring->name); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index e6f0152e5b08..3832513ec7bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -739,7 +739,7 @@ void amdgpu_virt_exchange_data(struct amdgpu_device
> *adev)
>       }
>  }
>
> -void amdgpu_detect_virtualization(struct amdgpu_device *adev)
> +static u32 amdgpu_virt_init_detect_asic(struct amdgpu_device *adev)
>  {
>       uint32_t reg;
>
> @@ -775,8 +775,17 @@ void amdgpu_detect_virtualization(struct amdgpu_devi=
ce
> *adev)
>                       adev->virt.caps |=3D AMDGPU_PASSTHROUGH_MODE;
>       }
>
> +     return reg;
> +}
> +
> +static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32
> +reg) {
> +     bool is_sriov =3D false;
> +
>       /* we have the ability to check now */
>       if (amdgpu_sriov_vf(adev)) {
> +             is_sriov =3D true;
> +
>               switch (adev->asic_type) {
>               case CHIP_TONGA:
>               case CHIP_FIJI:
> @@ -805,10 +814,39 @@ void amdgpu_detect_virtualization(struct amdgpu_dev=
ice
> *adev)
>                       amdgpu_virt_request_init_data(adev);
>                       break;
>               default: /* other chip doesn't support SRIOV */
> +                     is_sriov =3D false;
>                       DRM_ERROR("Unknown asic type: %d!\n", adev-
> >asic_type);
>                       break;
>               }
>       }
> +
> +     return is_sriov;
> +}
> +
> +static void amdgpu_virt_init_ras(struct amdgpu_device *adev) {
> +     ratelimit_state_init(&adev->virt.ras.ras_error_cnt_rs, 5 * HZ, 1);
> +     ratelimit_state_init(&adev->virt.ras.ras_cper_dump_rs, 5 * HZ, 1);
> +
> +     ratelimit_set_flags(&adev->virt.ras.ras_error_cnt_rs,
> +                         RATELIMIT_MSG_ON_RELEASE);
> +     ratelimit_set_flags(&adev->virt.ras.ras_cper_dump_rs,
> +                         RATELIMIT_MSG_ON_RELEASE);
> +
> +     mutex_init(&adev->virt.ras.ras_telemetry_mutex);
> +
> +     adev->virt.ras.cper_rptr =3D 0;
> +}
> +
> +void amdgpu_virt_init(struct amdgpu_device *adev) {
> +     bool is_sriov =3D false;
> +     uint32_t reg =3D amdgpu_virt_init_detect_asic(adev);
> +
> +     is_sriov =3D amdgpu_virt_init_req_data(adev, reg);
> +
> +     if (is_sriov)
> +             amdgpu_virt_init_ras(adev);
>  }
>
>  static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *ade=
v)
> @@ -1288,10 +1326,12 @@ static int
> amdgpu_virt_req_ras_err_count_internal(struct amdgpu_device *adev, bo
>        * will ignore incoming guest messages. Ratelimit the guest message=
s to
>        * prevent guest self DOS.
>        */
> -     if (__ratelimit(&adev->virt.ras_telemetry_rs) || force_update) {
> +     if (__ratelimit(&virt->ras.ras_error_cnt_rs) || force_update) {
> +             mutex_lock(&virt->ras.ras_telemetry_mutex);
>               if (!virt->ops->req_ras_err_count(adev))
>                       amdgpu_virt_cache_host_error_counts(adev,
> -                             adev->virt.fw_reserve.ras_telemetry);
> +                             virt->fw_reserve.ras_telemetry);
> +             mutex_unlock(&virt->ras.ras_telemetry_mutex);
>       }
>
>       return 0;
> @@ -1322,6 +1362,98 @@ int amdgpu_virt_req_ras_err_count(struct
> amdgpu_device *adev, enum amdgpu_ras_bl
>       return 0;
>  }
>
> +static int
> +amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
> +                             struct amdsriov_ras_telemetry *host_telemet=
ry,
> +                             u32 *more)
> +{
> +     struct amd_sriov_ras_cper_dump *cper_dump =3D NULL;
> +     struct cper_hdr *entry =3D NULL;
> +     struct amdgpu_ring *ring =3D &adev->cper.ring_buf;
> +     uint32_t checksum, used_size, i, j;
> +     int ret =3D 0;
> +
> +     checksum =3D host_telemetry->header.checksum;
> +     used_size =3D host_telemetry->header.used_size;
> +
> +     if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +             return 0;
> +
> +     cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size,
> GFP_KERNEL);
> +     if (!cper_dump)
> +             return -ENOMEM;
> +
> +     if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
))
> +             goto out;
> +
> +     *more =3D cper_dump->more;
> +
> +     if (cper_dump->wptr < adev->virt.ras.cper_rptr) {
> +             dev_warn(
> +                     adev->dev,
> +                     "guest specified rptr that was too high! guest rptr=
: 0x%llx, host
> rptr: 0x%llx\n",
> +                     adev->virt.ras.cper_rptr, cper_dump->wptr);
> +
> +             adev->virt.ras.cper_rptr =3D cper_dump->wptr;
> +             goto out;
> +     }
> +
> +     entry =3D (struct cper_hdr *)&cper_dump->buf[0];
> +
> +     for (i =3D 0; i < cper_dump->count; i++) {
> +             amdgpu_cper_ring_write(ring, entry, entry->record_length);
> +             entry =3D (struct cper_hdr *)((char *)entry +
> +                                         entry->record_length);
> +     }
> +
> +     if (cper_dump->overflow_count)
> +             dev_warn(adev->dev,
> +                      "host reported CPER overflow of 0x%llx entries!\n"=
,
> +                      cper_dump->overflow_count);
> +
> +     adev->virt.ras.cper_rptr =3D cper_dump->wptr;
> +out:
> +     kfree(cper_dump);
> +
> +     return ret;
> +}
> +
> +static int amdgpu_virt_req_ras_cper_dump_internal(struct amdgpu_device
> +*adev) {
> +     struct amdgpu_virt *virt =3D &adev->virt;
> +     int ret =3D 0;
> +     uint32_t more =3D 0;
> +
> +     if (!amdgpu_sriov_ras_cper_en(adev))
> +             return -EOPNOTSUPP;
> +
> +     do {
> +             if (!virt->ops->req_ras_cper_dump(adev, virt->ras.cper_rptr=
))
> +                     ret =3D amdgpu_virt_write_cpers_to_ring(
> +                             adev, virt->fw_reserve.ras_telemetry, &more=
);
> +             else
> +                     ret =3D 0;
> +     } while (more);
> +
> +     return ret;
> +}
> +
> +int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool
> +force_update) {
> +     struct amdgpu_virt *virt =3D &adev->virt;
> +     int ret =3D 0;
> +
> +     if ((__ratelimit(&virt->ras.ras_cper_dump_rs) || force_update) &&
> +         down_read_trylock(&adev->reset_domain->sem)) {
> +             mutex_lock(&virt->ras.ras_telemetry_mutex);
> +             ret =3D amdgpu_virt_req_ras_cper_dump_internal(adev);
> +             mutex_unlock(&virt->ras.ras_telemetry_mutex);
> +             up_read(&adev->reset_domain->sem);
> +     }
> +
> +     return ret;
> +}
> +
>  int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev)  {
>       unsigned long ue_count, ce_count;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 0f3ccae5c1ab..9f65487e60f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -96,6 +96,7 @@ struct amdgpu_virt_ops {
>                                       enum amdgpu_ras_block block);
>       bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
>       int (*req_ras_err_count)(struct amdgpu_device *adev);
> +     int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
>  };
>
>  /*
> @@ -140,6 +141,7 @@ enum AMDGIM_FEATURE_FLAG {
>       AMDGIM_FEATURE_MES_INFO_ENABLE =3D (1 << 8),
>       AMDGIM_FEATURE_RAS_CAPS =3D (1 << 9),
>       AMDGIM_FEATURE_RAS_TELEMETRY =3D (1 << 10),
> +     AMDGIM_FEATURE_RAS_CPER =3D (1 << 11),
>  };
>
>  enum AMDGIM_REG_ACCESS_FLAG {
> @@ -242,6 +244,13 @@ struct amdgpu_virt_ras_err_handler_data {
>       int last_reserved;
>  };
>
> +struct amdgpu_virt_ras {
> +     struct ratelimit_state ras_error_cnt_rs;
> +     struct ratelimit_state ras_cper_dump_rs;
> +     struct mutex ras_telemetry_mutex;
> +     uint64_t cper_rptr;
> +};
> +
>  /* GPU virtualization */
>  struct amdgpu_virt {
>       uint32_t                        caps;
> @@ -284,8 +293,7 @@ struct amdgpu_virt {
>
>       union amd_sriov_ras_caps ras_en_caps;
>       union amd_sriov_ras_caps ras_telemetry_en_caps;
> -
> -     struct ratelimit_state ras_telemetry_rs;
> +     struct amdgpu_virt_ras ras;
>       struct amd_sriov_ras_telemetry_error_count count_cache;  };
>
> @@ -340,6 +348,9 @@ struct amdgpu_video_codec_info;  #define
> amdgpu_sriov_ras_telemetry_block_en(adev, sriov_blk) \
>  (amdgpu_sriov_ras_telemetry_en((adev)) && (adev)->virt.ras_telemetry_en_=
caps.all
> & BIT(sriov_blk))
>
> +#define amdgpu_sriov_ras_cper_en(adev) \ ((adev)->virt.gim_feature &
> +AMDGIM_FEATURE_RAS_CPER)
> +
>  static inline bool is_virtual_machine(void)  {  #if defined(CONFIG_X86) =
@@ -378,7
> +389,7 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_dev=
ice
> *adev);  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);=
  void
> amdgpu_virt_exchange_data(struct amdgpu_device *adev);  void
> amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev); -void
> amdgpu_detect_virtualization(struct amdgpu_device *adev);
> +void amdgpu_virt_init(struct amdgpu_device *adev);
>
>  bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int
> amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev); @@ -406,6
> +417,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 off=
set,
> u32 v, u32 f  bool amdgpu_virt_get_ras_capability(struct amdgpu_device *a=
dev);  int
> amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum
> amdgpu_ras_block block,
>                                 struct ras_err_data *err_data);
> +int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool
> +force_update);
>  int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);  b=
ool
> amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
>                                       enum amdgpu_ras_block block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 4dcb72d1bdda..5aadf24cb202 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -184,6 +184,9 @@ static int
> xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
>       case IDH_REQ_RAS_ERROR_COUNT:
>               event =3D IDH_RAS_ERROR_COUNT_READY;
>               break;
> +     case IDH_REQ_RAS_CPER_DUMP:
> +             event =3D IDH_RAS_CPER_DUMP_READY;
> +             break;
>       default:
>               break;
>       }
> @@ -467,6 +470,16 @@ static int xgpu_nv_req_ras_err_count(struct
> amdgpu_device *adev)
>       return xgpu_nv_send_access_requests(adev,
> IDH_REQ_RAS_ERROR_COUNT);  }
>
> +static int xgpu_nv_req_ras_cper_dump(struct amdgpu_device *adev, u64
> +vf_rptr) {
> +     uint32_t vf_rptr_hi, vf_rptr_lo;
> +
> +     vf_rptr_hi =3D (uint32_t)(vf_rptr >> 32);
> +     vf_rptr_lo =3D (uint32_t)(vf_rptr & 0xFFFFFFFF);
> +     return xgpu_nv_send_access_requests_with_param(
> +             adev, IDH_REQ_RAS_CPER_DUMP, vf_rptr_hi, vf_rptr_lo, 0); }
> +
>  const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
>       .req_full_gpu   =3D xgpu_nv_request_full_gpu_access,
>       .rel_full_gpu   =3D xgpu_nv_release_full_gpu_access,
> @@ -478,4 +491,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
>       .ras_poison_handler =3D xgpu_nv_ras_poison_handler,
>       .rcvd_ras_intr =3D xgpu_nv_rcvd_ras_intr,
>       .req_ras_err_count =3D xgpu_nv_req_ras_err_count,
> +     .req_ras_cper_dump =3D xgpu_nv_req_ras_cper_dump,
>  };
> --
> 2.34.1

