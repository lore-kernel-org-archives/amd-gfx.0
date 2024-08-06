Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CABC52D70
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 17:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659E710E3E4;
	Tue,  6 Aug 2024 17:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sxaxV4xF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8940E10E3E0
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 17:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5f+0eJ4G5x3swNYJCGAK4ModRVJYmb+SX/zSCW1eEGSEc6Dwas61IrgYTTVbD/cT3zoB86HezRUpL6dbm+xigg3ZI5FO+5YK8UMtfqBPQpXNH9oZ8IW1i4HyhtTWB3sKfkXQRXx02y4ZK9EyqLR3K6D08YdNC1XRDYIoIIdVz1aRiZ5sbfU6a7ovWuYO2M3ssTFdxt63iRv3GSgetc8eqmqaLYanYn6oN/cliNJHcA/dsJFBNIWXW05Cj5GKCzGJ9GiEtkUaPobGGK+Sw5n/ZE0P1mFTuDnOTEZ5nNWVwmd43/1ECm7iXaDEmG+6Iit+fUeeB2EvC/I5cQYjt8hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WklagYXTcmPBNUloyJDdooTPsz+lRfBXmpgzD/4zEpk=;
 b=NlytjEzYaoTFYfLCAXmdZnOngTD5+4NFBKpeWlrIuNkFSnDPu/IxvvhZePW43SvTRna/OdoKQCA0HJU/zlEMDfhpG+H7Trf44p/dcaO5+tU0jn7lfM3lacxepD/RVfsk3ALrH0hfamBgCMXPlTTP6b0ZXWma3ejtlvmMu/BnLQqjTAzyaMLSR8JfCx4MgUsl919feHXFn5Q1f5NKjOrO55ERY/ZsGgfEfx+Yc7rsmUXQecMGnq7b8C+CgmqB0gi7xUQb+Hv7cChcrTRfE4ojIGv9bsu95NMagJ4JWysN95KOemlEGH7l6imgLaxbN5Wz3is7Lm+kkOputRFoVQ6z9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WklagYXTcmPBNUloyJDdooTPsz+lRfBXmpgzD/4zEpk=;
 b=sxaxV4xFZtHkM7TKoTW6VrS450TklVvFZEBTDvCYc1+ct9Qf22aNio9/kw6swn5mEtWTikfYsAoIkQDx73fPp+eztk32i8B+sxGIANfdlaoZZutxLCmQ9Harucay8L6/k4foZBioV3Wi5VvZ6ar7XZju56MHOZfednhMCfaRbwg=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 17:25:53 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 17:25:53 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/jpeg4: properly set atomics vmid field
Thread-Topic: [PATCH 2/2] drm/amdgpu/jpeg4: properly set atomics vmid field
Thread-Index: AQHa6CKS4Ozp2p3LWEm1QyiInoMFxbIaevcw
Date: Tue, 6 Aug 2024 17:25:53 +0000
Message-ID: <DM8PR12MB53994D6CF1EFAD5D780EA310E5BF2@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240806170301.2064080-1-alexander.deucher@amd.com>
 <20240806170301.2064080-2-alexander.deucher@amd.com>
In-Reply-To: <20240806170301.2064080-2-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c79f02a7-a478-4659-807f-638d929e6d88;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-06T17:25:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SJ2PR12MB9212:EE_
x-ms-office365-filtering-correlation-id: d86bbd43-e4fe-4472-9d15-08dcb63cd2ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BB6mw+ZPPBzJlHMkbCgYRDPsfLVdLoFsV0IQ2iifJdIhZOUXlMjm30uUuUyH?=
 =?us-ascii?Q?oDffGb/Nt5jjixNKNSUKxaVR+nRpG8HnJBoM63pKaumDXRL5t5CDkoOc51nH?=
 =?us-ascii?Q?wqTlanKKt0a1yGKvET114XuNF1TLc8H0u6etjYGbEJx4Kks7FP2LERMCnM7a?=
 =?us-ascii?Q?MrDD0CKCoCfUWgUusMMYdpWp7h/y/Ywxy5WwIt4sbF9ZuiZoEpgRKyMjZMmF?=
 =?us-ascii?Q?PhUkuR1WfszjKjDnGB0McPenn9Cs4vMVIVIeAO3imnpiqjNTGw4gwzxasdDU?=
 =?us-ascii?Q?r2jAzhoSh0ueu0G6DixcseID5PT+P/yeQNcr/DXhSA7ahx2+F6zm7dt6/245?=
 =?us-ascii?Q?HaoAL8X7AHRSB/S1759pvE6HGC7qp4k1uDFjpf6RZBJ+meHw1fxYCWGAdH0t?=
 =?us-ascii?Q?zY+SqGROFCpIM82gxWczyTpvDu9qX1o80DlL5VoKdzJJ4Qmr7H4Bx4OPy8ja?=
 =?us-ascii?Q?3ZBIvTsTEHSWnDCbJq+Rc7kmFRv3G74cddv4B7ik70DlfD8e9uywK6Rz1F0P?=
 =?us-ascii?Q?tIz/d5Nz2pLvi8LgJDs0zuFFd2jJFajfT3tW4bj7gMY/NmS/9l4oRIcVQjyi?=
 =?us-ascii?Q?VbP/dqG5XiIal8YLH/DQJnDvV53FqwGDvNmGxCD8+/zm3Bx2585loHoACIeU?=
 =?us-ascii?Q?lS0kyczWcJUFTWoAQwRN9fepxjDejWrcP83IrGooDYk4OsGCXuyW6pgjv0FL?=
 =?us-ascii?Q?C7M9d4wOpu1a8m1RK1sagsip9NcSs3HzKZFBSipabfVtXIf9UdFsjVEWxLWo?=
 =?us-ascii?Q?AxQgU79rb4Lckrs1rMtKTgqCSwHuLBV0PKlASLsW8sSdH3xDqrdi2FPwekro?=
 =?us-ascii?Q?llzCjfNrAOSwZ9RZkmgzRTysyuwvm4xTPmbL6nl1IUXXsfRxFFHhJCmOFUo3?=
 =?us-ascii?Q?WlCOcNMvZgmJwjE4DOqFWSFXqNFBjsjUcOcoWk3bk7UZcz1frqfDrW6CgTT3?=
 =?us-ascii?Q?Me+C7sxlwY6kdm5h4xTzR9O6jB00H5bGQf9hJ2uyON3VirFHz6DXCn1Pn78l?=
 =?us-ascii?Q?H21jigwyzKriHBJjiMZST1QP7GcAhtRoJs5TH3VZIoAMptchP3IC4u24rHDl?=
 =?us-ascii?Q?idYjsONMydipgCCWDFacmo1OQuAUWuGvIGmGm0cRdloDdrx4F0zaWLguwm4g?=
 =?us-ascii?Q?G5WUolFcMTTkYqh8m0W8QHMdRxupHKd/Wni2V0loe4IyAyMw9HUQKBI7Bhd/?=
 =?us-ascii?Q?5RAdmm96Tb44iuxvv8Oil0I1kWjBPrIli5TaglTs/miMu87j73vlpNU6JVAP?=
 =?us-ascii?Q?K6U0KqJvFlGxSSNeXeZyNycWL/VDHtBojY/rto9BIqGiQD4uCC8JnrvWOyZV?=
 =?us-ascii?Q?QwzXh5Ytck9qwNZqSPkPAKT4FTZlmEYQsHFDBPz7cZVtLiSeh6yHd5JN49Ss?=
 =?us-ascii?Q?j7fGWejuvznXjkagdftLxgBxvP5x6CgaL28qvOmUquLedxx7EA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XED+BP3RiV4DdB8Prdp0cLB3EarO3KStgmlDkdq+71MI+aG/ohrTvDc/Towt?=
 =?us-ascii?Q?Wl5Mjx4hgdY++bGfC17bZ5DGiT1Nm4u40P/uUkv1bC7nocQWYP8Q89LCh6i2?=
 =?us-ascii?Q?4ub/VaWjVIUzHxU6oxLvzelEngJFetwnPs0Jh4q+nLe/AqGjFFEdOmKf+nGD?=
 =?us-ascii?Q?HmMwDeklH14lIBY52Q4gbbsbr+lLyTGrIcEsJtFFBxpCiIuy/+N8HoIN5Xmz?=
 =?us-ascii?Q?hONrd8h1Lb+ngMMutZ2OSwL5ULe9QCqvI2t0T7a3T6yxiYK2v2ElgKMAb5jC?=
 =?us-ascii?Q?4HjoBNsXzl/vk7VCOkj5GyfmEXFEkRioil0jdS49hX+h27Gqspu29qPLhcOk?=
 =?us-ascii?Q?193Lo3aUlWP8XdJPCI8xgM25mPxfey0DGB/Aiuqf/tisSIdUNpopZISaKxVt?=
 =?us-ascii?Q?n44D1UiHETLdSJNGXZZlCsMNMK0gLwsnsLLCSY49+M6CwunIqYde6dOqCgnI?=
 =?us-ascii?Q?Dq3CTkuj8svvHpIcBkoKQEuhonf+oIM+M4LajkZTMFClIvCt2Q7uK1gr+Rip?=
 =?us-ascii?Q?UruX+/qVLc3KyRpmggDxLVYMrvCmb95OSEiVlTjYGge7HPnIM4fkDlcu1joZ?=
 =?us-ascii?Q?ZDGrHF+Uv/xnVjbgYwJtU1qNWvc4hXBWHdLhdFX7S+Ff7FFYylf/1w166aTY?=
 =?us-ascii?Q?MqUv4Cl828J0Q1qqy79fpW4YNLVeXaFsuLjk7Ytfytzy7plMCyRQc879lCHT?=
 =?us-ascii?Q?z/rEyIUY6XXcRBl1E9rVbGsHHWigvIDw5MEQH3w4ABbL2dRKLaZ6mTxucTQB?=
 =?us-ascii?Q?zET2Zb50WBG4vUHc0Dk3/ZXbB3A6WB2w2NSQd67+6V/lEwxUwmX64qBv8cP8?=
 =?us-ascii?Q?+XVTE+smQkqjGGkIH6AJm9fMxjbFkhqDd5L4Zm9vvcFNL/H6X+j0D76MgzCp?=
 =?us-ascii?Q?igfWlDHQ63xNWo9pb9pguo3yrkIC4BQQ9kBCGfOPHh96bFPgWEOt9hRcsJlW?=
 =?us-ascii?Q?GsWpXJi95N1ppBGW6cvQt8bPmfBwUl5zIkixIwFCbQ80Jdpn0LhTUfWMX2n/?=
 =?us-ascii?Q?9TAPWLm0vDkWTQesSZFnJ/PWBd1RFgvbo10PJ3aq+1kbDwH4zN6fcEJp3PCy?=
 =?us-ascii?Q?vuJLqKnf+e6DD9NGq6YDi3ECJ9RO5EgTtL2BZGKCZP0eyGVJkDSzdPJJq4VV?=
 =?us-ascii?Q?4ssKdiYFRiitIj8i97qKC6oMwBvQYL1wWYB77vYcP4PVzXPN7tb8+92ASdfn?=
 =?us-ascii?Q?CISMIkKEi8TWWJkwilqPPEwwyspY1uDSKt0mCml95l70awOkAMX0xPRQZCua?=
 =?us-ascii?Q?jlLLINsUK9KZe5OVl7niYamUfGg7Ti6IR56eSLxDMc2hYiVDDm7i7nZXjmSD?=
 =?us-ascii?Q?Qebw+K4JGFNBAwHoR12hcZo4rID03zBd1QcUkquQcGmV3u7NHD6U0tCKcxKv?=
 =?us-ascii?Q?4Sxd0KkeS6S5JmUZHX8QDvRzuEqnBkMPIkiFVr+GpGBbEf3AOGO7ys8ToXTV?=
 =?us-ascii?Q?0vaBsOLcaljaX0E816dQWhz7jOZg8um/jTwbjrIGJ1k2V6iscfsLgvO2khaV?=
 =?us-ascii?Q?YSERdFZyq11eF6T/BPeOfmCfGTmw2Vbjx7YVGRq6DpA5NNq/w0j9UccXIgtU?=
 =?us-ascii?Q?Fgq/OXAfJ6aT7zlt324=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86bbd43-e4fe-4472-9d15-08dcb63cd2ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 17:25:53.4001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0g1YxIjAIuAph6lsz83jEtlKtXQQ2xTgxd/wmfNje00IvawVM6ZYs+fBhHl7iNgP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
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
Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, August 6, 2024 1:03 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> stable@vger.kernel.org
> Subject: [PATCH 2/2] drm/amdgpu/jpeg4: properly set atomics vmid field
>
> This needs to be set as well if the IB uses atomics.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index ad524ddc9760..f4662920c653 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -782,11 +782,11 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct
> amdgpu_ring *ring,
>
>       amdgpu_ring_write(ring,
> PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
>               0, 0, PACKETJ_TYPE0));
> -     amdgpu_ring_write(ring, (vmid | (vmid << 4)));
> +     amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
>
>       amdgpu_ring_write(ring,
> PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
>               0, 0, PACKETJ_TYPE0));
> -     amdgpu_ring_write(ring, (vmid | (vmid << 4)));
> +     amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
>
>       amdgpu_ring_write(ring,
>       PACKETJ(regUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET,
>               0, 0, PACKETJ_TYPE0));
> --
> 2.45.2

