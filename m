Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DD3C369D7
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 06:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0581010E3FD;
	Wed, 23 Apr 2025 06:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kh2KvPGZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B117010E3FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 06:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gn/6Xc7uD+aLuNLU0YbrOpAkrmMUGPoLRaPCxgn1+32RI4QsyMSIvlCGkcD5eED6yqNtc6lp6f6nrSGB9onKv/r1GCNaCkT+k4hxLpJxfXKpyNq1S+iw1RM2fsWDfT44GSrC7LDYwH2QdB2La97hjlRoBfdi1SB/4pgBVMUFGtbkNecMrCgpIP32u9hMnOkBq8dHvpM8TZbgYzb7KorBW/Jc6WEyBnkEmf2Kgo2OgkZb86T7N/T5YVPX1QeC4kNrc7MpluGJiqv3njLRBsSYFBTIc+v/b6mPzmVV5VkCdQq+Tx5GhqMIsy0wdqIOzy98LjiwRiQOccuDZwvqnKULzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H8D2y76wIMi2L/P61LKQfXs7caGIJxG9o0irN41YxQ=;
 b=YX9wDWakw3X73nj0MMNndidYpcnBN5LhquDiiZzI0dg0GQuQIrNGKrvduyL/rwjsBPXmwK4kCAuPTop01YQjA92Keu6idvXHvY8kAkGIMGmbgOCM9ETT0OrYRiQ/XQo1EtIEppvmvAuPmhWQsQB76v80Mn1KgH/AX5+v+ZvT4uN2Vfv3ogV4dSydBFsK87QIPxFUfuTcHvFD1wXICy5NxvlhZJcgYt3lomepASIbaCLPsP0Nt75WtjaumiFNLaAbbQe6dwP3s2mJkRPIy4fKg0Qw1Ur0tirdgWt0cxgtJxhbh+eD/xIvyC0ab4yZxaqfm5OZde13YsjbBtRb/s/rcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H8D2y76wIMi2L/P61LKQfXs7caGIJxG9o0irN41YxQ=;
 b=kh2KvPGZO7Mzs+LJjh74N3t1kknpckbiG0ZIctfX6OL1bPl/yCZmsJhf2+1wl9YBKcyb5FZl0AoBDQP5r4J7TmbhmCDF/yDHswHnbSf3IxE/aMdArkAsvGrtYolIAOVkU72nXC23PLMpw9bPBzyrrc6EMFKJBrQQA6o5RzBbRaw=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 SA5PPFF3CB57EDE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8eb)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 06:59:07 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 06:59:07 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Zhang,
 Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Thread-Topic: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Thread-Index: AQHbrSrP5jEga9/xXECMUfv7z3IS+LOmU9uAgAKqkAU=
Date: Wed, 23 Apr 2025 06:58:45 +0000
Message-ID: <DM4PR12MB5937E0B16D42C51FFC0D3E45E5BF2@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-7-guoqing.zhang@amd.com>
 <0ca1a883-4ddd-4bc5-8d58-9865a6d497b5@gmail.com>
In-Reply-To: <0ca1a883-4ddd-4bc5-8d58-9865a6d497b5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-18T06:37:37.7964291Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|SA5PPFF3CB57EDE:EE_
x-ms-office365-filtering-correlation-id: c3af6e7d-d543-413e-e77b-08dd82345759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?87Jr3tHPxxr3/ceqR9dsN/zFwMJPS2yoQtaKXz+UGkH6yoiFVbF3SpNfGJ?=
 =?iso-8859-1?Q?EKGq6ZgCmjLeXRDJewX8qSuYgLczMpoKo2we8vLFmeMjchOZoyOKGnTe22?=
 =?iso-8859-1?Q?s2dV68IVfjQCDB1rnFGorfW2AhZypnUPvIXdvKc92uwr+aS4I6JMs2V4Eu?=
 =?iso-8859-1?Q?hovGS9/wi5DocRz11VhUrp11sA9NW1CR+y4gM0iE2MRQ09zAHFpnzDRYp0?=
 =?iso-8859-1?Q?y63dM/ZXDw4BReJV5sD3KcY5SiT1LHwxtxo9fYwQxiuDX9HnpPEfYHxjh5?=
 =?iso-8859-1?Q?wyLx4kUqn4bfW6t9o4ov6VQhPDNLMbTZE5uzkSx2zVjSTLQxA2D1L3M4Ms?=
 =?iso-8859-1?Q?rYRqFxonadCTb1Y/xzUmKL+zH7mFYg2A0fhlQxVT0JCKRUmRQPoXKrMlZJ?=
 =?iso-8859-1?Q?V9X1gtvk0xP1CPWJ4IU2cI3TlUYwOXqW79NjF+GRht2LYwhnZY5GmLtP5T?=
 =?iso-8859-1?Q?RB5F67B3SKJdg+yb3LLVpwQIEOV6uh1m/wflPaH9xuveBW5hQQYwPzazo/?=
 =?iso-8859-1?Q?3xlwFIcFU3uJeuM4NlVd9qih8rYN/hwqtykaJqqayRWbRIPt67LEIzSZla?=
 =?iso-8859-1?Q?9whZaMhVWxWLAozPlYWkT6Dh7mxfe3TaoIaPmEV3QuLrhLeju5gmZHtYp2?=
 =?iso-8859-1?Q?g7ubnohwt9vwckB9p7L/9E5M4zm8oaopX3xtzkhLaYRaNN81Tdcio/G/+7?=
 =?iso-8859-1?Q?7abl8XJtrVBKWFPBQ928tbXRPaDUEtsaMCzlpkhYzMVHmQNbSYxORUVKOb?=
 =?iso-8859-1?Q?eu3rh2D/BkDY6Ps26JLoeqna+DiF8s/slyv4mFrkEdd+J5SszvO4jx7qAy?=
 =?iso-8859-1?Q?PlbChBOp4ZSVLJpyghhvCjIGiRQP5rPNV3cU00DoHcFiudfHoR8z/Xe4Np?=
 =?iso-8859-1?Q?f1ZqTJ+atv7hYWWqyITIS/KZdPL9Su3PonrxW22maOjr33EVWkRiSRBPYw?=
 =?iso-8859-1?Q?0k7Gjwa6HiEDHoJktwML1/9XCQoSUiXdzMYENAcfxk513k83uOWzY4HkPd?=
 =?iso-8859-1?Q?pjQC/qkdFn5G0Yy8MNGLec37Hw2FH+2PhXNDkLs/44lP4qL2oyPRB0u8Dw?=
 =?iso-8859-1?Q?URxUi0APqLvveRgCt1SR5tekhYamHMa15JcHsjnaCYaw+RkPk99YzQ0SY3?=
 =?iso-8859-1?Q?XlJW4K3a/kPq4ZQ2w/uCoQHHSHLgQj0Jv48AMPfK0zsHpyCYeuU8NAHVlC?=
 =?iso-8859-1?Q?s4TNHhkQJtMr/5GV5ipFrFHFAA/PqZYS7CR13zi+12RLaNtwoH0ZlA7mJi?=
 =?iso-8859-1?Q?W9HrjP+NVWsNOsMW4EuzQc/X/rrX05nQPOKIm/vvGVz/iv7zzSvMRI2m3t?=
 =?iso-8859-1?Q?JAcAz0HXu32uJWel7780+qlgkFa7Mny1nIEFiOCF2/vdNz8UgHh4zv9W5S?=
 =?iso-8859-1?Q?IuvcnwxXDKFom6XhTJuWHyQkPZ8DNBmlSfxi9TASlAKOalQ5wwriyUL0K4?=
 =?iso-8859-1?Q?38DPE6JzCkY633eLqItf+1O54MzY3otcruFpsnxt4mUYh1KKStSr55R0Ce?=
 =?iso-8859-1?Q?/yjYP9DZ8DJMPantiSBknLyccUdK8/UKSp43GV3SCbVUh0kGWXccF9rQcO?=
 =?iso-8859-1?Q?a3S6gAA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kCrj1/QHT4/1tgbSdXETFtz7HXaJCUI1DLeCEU7WwUsh8DoPlKAzVxSzOZ?=
 =?iso-8859-1?Q?udN9uskRVrDojVUP23gRF/5nJH+GcPyAgXfDWOvxhbELVTNyeH78UFLEQT?=
 =?iso-8859-1?Q?pJcmfvQ468gquEV9t+kls6uMzdCWh6gvsEHVQ4NpRwe20Qs7ucdy44VawX?=
 =?iso-8859-1?Q?UTu1vNu7+mwbKHyWgbFlqyJdu1I/QH5r8ZsLsb3YCznZczruM949iSbLrt?=
 =?iso-8859-1?Q?d1Hexoq4GMD6flxhvHwKEFX29rWvF4JgFcG995zsYjDO+7swxeBN13Xhvg?=
 =?iso-8859-1?Q?g2K9jYbf72nRw9QGbTTGjOAuB1OFX9YYvAExJBj3OBDMwzYJMaWyB2+/tc?=
 =?iso-8859-1?Q?2uS6YjpN2YO/2BKP4wTV22aD4631kHuqKK8Lbx/9QLHlbMQs0cTMbUyoLD?=
 =?iso-8859-1?Q?7HvU60JGnXw8DTRe7JF70RsAEEG0xCigCUbimYHl7AcSEH4F49C8PJFha5?=
 =?iso-8859-1?Q?zgVTQfoNoo+y816JX4QxIHIUmdwfiSTrHN8VijpNzmnZ62cHnzFzfi7Szs?=
 =?iso-8859-1?Q?m+/oJZ0gSrnLUNqwz2Y5y2PptEk5IZv+Uj6xrfvz1Bw2dqhIMn/OvyJl8r?=
 =?iso-8859-1?Q?UixUs7ZU4nm+PZqGWM3CzA++8QIWrKgpF5YsWAXzd3YpQkG/7Dboy0pFas?=
 =?iso-8859-1?Q?JHo9v7YZLtxCehhsK7mT6hmwQRgnBvxLp7O/oiWxzh4Nj1COuNv9LtCJ9g?=
 =?iso-8859-1?Q?Ue0DjtdsPSb9IpmVJuIfF+PiqJiVkKUTE85A/UEVwxk0wSgNCW+AyUwKEw?=
 =?iso-8859-1?Q?MWWa2gjCF0ywGQUzxR7u6IVIAW8gffqEPNVvy8wq8uOZG49YbgdFSJkXt+?=
 =?iso-8859-1?Q?b0JYc0bZwXxL7YhlrQ75WzYPHfB64TGzUMtMCLnUCI65cT3eRZOBmLGdsl?=
 =?iso-8859-1?Q?L1lqt777NHC0mvHzdnXS40vb5zq9p/AYgg2Bb++zaPJPEzEeoHlzfl369X?=
 =?iso-8859-1?Q?jApNoM23x0Mm+msrXYV7oZw19yHmjLVKZ/KfNZS1nhvRcmHrTMwEWX/pmc?=
 =?iso-8859-1?Q?OaB3JJY46tfXJUhTR/niunANV4cvDuYv17zpTO6I1gGmxOnSBj1q3x1r0v?=
 =?iso-8859-1?Q?hJeuzb7nyd/GpVXrRwBOkYUBJYQvVcu58MmpImZW73ZTKoucOooDf26AO2?=
 =?iso-8859-1?Q?627eQwjh7thXJuQiXPMkDtDikXWbt7u8WQPQ90H3JIE1E0DLKef64+NxSX?=
 =?iso-8859-1?Q?ObErU1pu6O+9xSMI/4ntt75Gzzb+6lTZ7kKVw7GR5iNYU4h6sXSqtHG2Mo?=
 =?iso-8859-1?Q?MPFQBjNYTRKMLoZQtwhnys9lc2/zztlT3E/E7tx0GJJhZu9Ir7pk7CJ7D3?=
 =?iso-8859-1?Q?Tc/y+fFfvyp5ENG+/hSAKgPRP5phZibpDxHZFjm0bxn/XHzcv7qri8/GU4?=
 =?iso-8859-1?Q?+M3MVt7X7MDOCsC+NmmqNBd8nxxio1k6SHID8BKozO+jtzZsJGBrsGyKZb?=
 =?iso-8859-1?Q?2TVKKH3JNqdI41WRxMZ9Exgn9s3bu8FxoloxSqSM1YgGNA2aRGu3J0tUWZ?=
 =?iso-8859-1?Q?oSXUWz9qM6lkD/hA6xqzQ7BWkLinFKL7mx7tftPO63FGHv5RnHUmV2UK0u?=
 =?iso-8859-1?Q?C0GCIqlHORR3fTnX6B8YFa04dvRMevmQ2qjW4Da+Xx89ku/dmho1Pd3K9r?=
 =?iso-8859-1?Q?TQi2zNKqJpEl2kN3FBFV8+GcpYQpiXvlEW?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5937E0B16D42C51FFC0D3E45E5BF2DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3af6e7d-d543-413e-e77b-08dd82345759
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 06:59:07.1738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56chrLuyxgmomM9Argy6n7+4BL4fK+eBJ6f3LzHbBh2Bpyu4Fv4trI/BQkIMJGM3JeVSjwRiH9T6FXLz5TD1xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF3CB57EDE
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

--_000_DM4PR12MB5937E0B16D42C51FFC0D3E45E5BF2DM4PR12MB5937namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Christian K=F6nig<mailto:ckoenig.leichtzumerken@gmail.com>,

On QEMU VM environment, when request_irq() is called in guest KMD, QEMU wil=
l enable interrupt for the device on the host.

When hibernate and resume with a new vGPU without calling request_irq() on =
the new vGPU, the interrupt of the new vGPU is not enabled. The IH handler =
in guest KMD will not be called in this case.

This change is to ensure request_irq() is called on resume for the new vGPU=
s.

Regards
Sam

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Date: Wednesday, April 16, 2025 at 21:54
To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Am 14.04.25 um 12:46 schrieb Samuel Zhang:
> IH is not working after switching a new gpu index for the first time.
> IH handler function need to be re-registered with kernel after switching
> to new gpu index.

Why?

Christian.

>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Change-Id: Idece1c8fce24032fd08f5a8b6ac23793c51e56dd
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 18 ++++++++++++++++--
>  3 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index 19ce4da285e8..2292245a0c5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -326,7 +326,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>        return r;
>  }
>
> -void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> +void amdgpu_irq_uninstall(struct amdgpu_device *adev)
>  {
>        if (adev->irq.installed) {
>                free_irq(adev->irq.irq, adev_to_drm(adev));
> @@ -334,7 +334,10 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>                if (adev->irq.msi_enabled)
>                        pci_free_irq_vectors(adev->pdev);
>        }
> -
> +}
> +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> +{
> +     amdgpu_irq_uninstall(adev);
>        amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>        amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>        amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.h
> index 04c0b4fa17a4..c6e6681b4f71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -123,6 +123,7 @@ extern const int node_id_to_phys_map[NODEID_MAX];
>  void amdgpu_irq_disable_all(struct amdgpu_device *adev);
>
>  int amdgpu_irq_init(struct amdgpu_device *adev);
> +void amdgpu_irq_uninstall(struct amdgpu_device *adev);
>  void amdgpu_irq_fini_sw(struct amdgpu_device *adev);
>  void amdgpu_irq_fini_hw(struct amdgpu_device *adev);
>  int amdgpu_irq_add_id(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd=
/amdgpu/vega20_ih.c
> index faa0dd75dd6d..ef996505e4dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -643,12 +643,26 @@ static int vega20_ih_hw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>  static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)
>  {
> -     return vega20_ih_hw_fini(ip_block);
> +     struct amdgpu_device *adev =3D ip_block->adev;
> +     int r =3D 0;
> +
> +     r =3D vega20_ih_hw_fini(ip_block);
> +     amdgpu_irq_uninstall(adev);
> +     return r;
>  }
>
>  static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
>  {
> -     return vega20_ih_hw_init(ip_block);
> +     struct amdgpu_device *adev =3D ip_block->adev;
> +     int r =3D 0;
> +
> +     r =3D amdgpu_irq_init(adev);
> +     if (r) {
> +             dev_err(adev->dev, "amdgpu_irq_init failed in %s, %d\n", __=
func__, r);
> +             return r;
> +     }
> +     r =3D vega20_ih_hw_init(ip_block);
> +     return r;
>  }
>
>  static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)

--_000_DM4PR12MB5937E0B16D42C51FFC0D3E45E5BF2DM4PR12MB5937namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Hi
<a id=3D"OWAAM7B04ED50E2293946AC1575664F4D4885" href=3D"mailto:ckoenig.leic=
htzumerken@gmail.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Christian K=F6nig</span></a>,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">On QEMU VM environment, when request_irq() is called in=
 guest KMD, QEMU will enable interrupt for the device on the host.<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">When hibernate and resume with a new vGPU without calli=
ng request_irq() on the new vGPU, the interrupt of the new vGPU is not enab=
led. The IH handler in guest KMD will not be called
 in this case.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">This change is to ensure request_irq() is called on res=
ume for the new vGPUs.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.co=
m&gt;<br>
<b>Date: </b>Wednesday, April 16, 2025 at 21:54<br>
<b>To: </b>Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject: </b>Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expire=
d error<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 14.04.25 um 12:46 =
schrieb Samuel Zhang:<br>
&gt; IH is not working after switching a new gpu index for the first time.<=
br>
&gt; IH handler function need to be re-registered with kernel after switchi=
ng<br>
&gt; to new gpu index.<br>
<br>
Why?<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
&gt; Change-Id: Idece1c8fce24032fd08f5a8b6ac23793c51e56dd<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |&nbsp; 7 +++++--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |&nbsp; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vega20_ih.c&nbsp; | 18 ++++++++++++++=
++--<br>
&gt;&nbsp; 3 files changed, 22 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.c<br>
&gt; index 19ce4da285e8..2292245a0c5d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt; @@ -326,7 +326,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -void amdgpu_irq_fini_hw(struct amdgpu_device *adev)<br>
&gt; +void amdgpu_irq_uninstall(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.installed) =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; free_irq(adev-&gt;irq.irq, adev_to_drm(adev));<br>
&gt; @@ -334,7 +334,10 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *ade=
v)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.msi_enabled)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_fre=
e_irq_vectors(adev-&gt;pdev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; +}<br>
&gt; +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_uninstall(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &a=
mp;adev-&gt;irq.ih_soft);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &a=
mp;adev-&gt;irq.ih);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &a=
mp;adev-&gt;irq.ih1);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.h<br>
&gt; index 04c0b4fa17a4..c6e6681b4f71 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt; @@ -123,6 +123,7 @@ extern const int node_id_to_phys_map[NODEID_MAX];<=
br>
&gt;&nbsp; void amdgpu_irq_disable_all(struct amdgpu_device *adev);<br>
&gt;&nbsp; <br>
&gt;&nbsp; int amdgpu_irq_init(struct amdgpu_device *adev);<br>
&gt; +void amdgpu_irq_uninstall(struct amdgpu_device *adev);<br>
&gt;&nbsp; void amdgpu_irq_fini_sw(struct amdgpu_device *adev);<br>
&gt;&nbsp; void amdgpu_irq_fini_hw(struct amdgpu_device *adev);<br>
&gt;&nbsp; int amdgpu_irq_add_id(struct amdgpu_device *adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/=
amd/amdgpu/vega20_ih.c<br>
&gt; index faa0dd75dd6d..ef996505e4dc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
&gt; @@ -643,12 +643,26 @@ static int vega20_ih_hw_fini(struct amdgpu_ip_bl=
ock *ip_block)<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)<b=
r>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return vega20_ih_hw_fini(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_block-&gt;=
adev;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D vega20_ih_hw_fini(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_uninstall(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)<br=
>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return vega20_ih_hw_init(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_block-&gt;=
adev;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_init(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(adev-&gt;dev, &quot;amdgpu_irq_init failed in %s, %d\n&quot;, _=
_func__, r);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D vega20_ih_hw_init(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)<=
/p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5937E0B16D42C51FFC0D3E45E5BF2DM4PR12MB5937namp_--
