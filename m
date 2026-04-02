Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6387FD6AB10
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 21:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E550F10F52A;
	Thu,  2 Apr 2026 21:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HY8KgAa2";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC58010F52A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 21:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgiSSfv0L3n7sW/Qq7Z9fnFU8qnwcwLe+B20lYPttQoZH8XkMWJ1+dGlvNGC3+YwJnTS+kPOYwIW/BMM0gbt8cTpZp1194A9BA68+E+bDvOgDB+uRjJ3aQgCDXozRz6Mv6mKNR3jx1YYtJ8HLiiV31xvju5H3st39mehqoLlDfGh2pB4PloDTulKNiQ11pLmXShXWlb+PzpJlxXkQIS59buww0PJZ2FSfhwfF+H3bl+JVobBbb71ox4YdygjwZCZp3xCWI8BQzHw0G/yTEiMZ/6sFtd8BfGnKem11BapqIK3Y2UkCc3egWBIyGhhXrZcZsZnIQz2YAPvizTkTUKs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+44C7Uxul378NlPu4PCRnhE3FcpQ8dqF3JEIPYPYtjw=;
 b=f+H014mly9Ygb1GbFCBZ/0jbpI550EWRdQaJnsGoWXd2d2hBZCW78Gqbvou6WXZvF84NJhAHv6YnTtxene3P+FvIs1397Dv520530JJg211rtSDm6VFl/ptLsSrzimgSBHFp7PEURx7LWgReFz6Caj7rmnOl6itjEIEWVQWz5qOm/7sc7mmEQXLvAWiHkx+o0DLPMfoCTOO3CfOKPiyLcM3XPmE1/f3iHPxZHTAdOihBPuFkRu1JKv7pANYiY7VEf0tl5qqgM/NCgxiOi/vy3GWif2n8EHRtm/OfJmCslzyfK9c6iykuXPFowyGbxgujijYG4aLiuJEN6OCmmdBCCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+44C7Uxul378NlPu4PCRnhE3FcpQ8dqF3JEIPYPYtjw=;
 b=HY8KgAa2CI1cxVz5IY2KW4Lu273PPhlCte4GjE7brH+TXkwVWHZ2fMWs5zBkYw4ji64bx32/UiyHr3wH66VM2SBEfMG5u0RA9EiIVGkoOL5WnD4HkjYkJqTf8hf/s7QoH536ZgbQ4TTAmNY0vdkQO5eI7rOUO6VOibqxPf9oZ5E=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 21:46:34 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%4]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 21:46:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH V4] amdgpu/jpeg: fix deepsleep register for jpeg 5_0_0 and
 5_0_2
Thread-Topic: [PATCH V4] amdgpu/jpeg: fix deepsleep register for jpeg 5_0_0
 and 5_0_2
Thread-Index: AQHcwunJXa8s9ssvmEqPw2psWsEJZrXMTljQ
Date: Thu, 2 Apr 2026 21:46:33 +0000
Message-ID: <BL1PR12MB514490363CC91149D7526E51F751A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260402214331.2430926-1-David.Wu3@amd.com>
In-Reply-To: <20260402214331.2430926-1-David.Wu3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-02T21:46:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB6385:EE_
x-ms-office365-filtering-correlation-id: 6976ec28-87b3-4de2-d44d-08de91014eee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: GAwEpS63FA8GgT8k10YcmAKaDM662GB7bBgVNHBJfvKcNNx2bbtN1fRGVuM40FMIIGLxaAjci72yRC1IXcXPd1HpqJbx0TcQom5rv8G8vyNbne8nPI3xAkpUrnD157RKr4gFWXw/EOOzHqhvTysY2+JdFSu08w50BdloczdX6R/Az+V+X8Kxs9waiwAnx0mxo6MnQH5AFMIyhmtThRp0dy3azLlqPUFosl865z4jD93yoVpSrTYnbLVuoLvQPKFyTPlXS6VGjloTnhMCFKmTayF9bUrut2Ht8Lxq03dwl65J5LxlnVUw6UkRWv07XYdXwomz9cEP3B83e0qzJICrSsBU4gikFxwwTqMcyHa9AfM0K2EfqNAroxCXwx9mqhFENKBvy+IXlEGd/Ul02HqUGWRHEFY/MOHdAXKJJzeEmcH8aOAGPz4lCfMrs4bbe0Ftj45FhzfBarXXJgSpsXOjJ35YpzJDoIdpLw+X4UNKC9IhbRmyiHKlnbUr94gJJtq9fC5j/6RDjNPvzKMSvL5MKuoVP1/ybyg+WEk1Pd/K9lnrij4RcmLnHUlUSYRWWEM5CGPal4tQmoIhMNzrhwPXwKM3tk/c4Ml79H1WwUHfp+yVR4SR9mWTkHqXCSbxtfUfoSELwJJ2waobd5I3q6hiufzYNI8O6eB5ZWvupU36urto4HgHc49FUx07aI5crTI6pCnbrbxJVtKdWlPXJDewgvexYv2yJPlvVxQfriF9eH8/kbA/s2BYRk62mJqh5aAG4m723NM18UBhfJ7N1tQhFGuirIj+no3iTFGYKseT3dI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i3xl5o4caZHAU7oGPJ7denxusL8Y4XGzb8AIiT2G8f1d917P57tDotWm3la+?=
 =?us-ascii?Q?sPBhHVgq3mNVLqqYroFpRFM6hi4B3geGDrjfxQJVyIMKdTaN+9cOQfC/kJAj?=
 =?us-ascii?Q?soYhld28Ic6OXbbBLH2yDpcfz3GunsYlM6A05Lf4q/qudliVHEDAni+v1xS9?=
 =?us-ascii?Q?VTp/C27jzGOdHPGYwIvTgMlrtghsHIZ1wWbGwxXXM5jrZQS5Kviwz/LSQ/G9?=
 =?us-ascii?Q?WkcQYYdbn2HHBGEfz9IMImsfFjHaOAx57OJg8n5Xa11FYeVaHNJ8JYYXf2QR?=
 =?us-ascii?Q?2Me3nSySfxtdemHVXWwujb3sNIh4TRTZhEaOv00z2UXzuwvSBqpK+Yndpsm7?=
 =?us-ascii?Q?Awa+MouzYFT/qwbCin9rsWuUlE5asX0pBlUf1ADAvy50QRaAKMxUmemJvbP7?=
 =?us-ascii?Q?3iHaQFyxw255v+T3+/4Y1ZgzIfiGsxOQX5XDj6rnp2rJI64mgJvAuT6LwmBX?=
 =?us-ascii?Q?YVreVhDLmF7KmiR0mgoQS5gggNwR5QMGjBIQxACnTJ70XpPE6IvGXvDueKfG?=
 =?us-ascii?Q?Sd9MeYx7y9/bBQKQdf3S+KnVj/hGXTGeUmQPfGfT69ZeWS5ZGUdsDq4j1shE?=
 =?us-ascii?Q?sNhcosuByJE7Wait5+IRKmjz/SUVcENI+iTs7B6vsAV+J2KRRJlB6kNacbow?=
 =?us-ascii?Q?GNdAMrz6I1l6bfq8b30njGd/45dfn8vWS7aJ+15G56eubjdHxr0LN6zfn8+h?=
 =?us-ascii?Q?Wur0ksE9oeg1cyzmchDglwG5oiXKagHIFro4Y7e2Edm0bq565taao0Ee3qAv?=
 =?us-ascii?Q?yNtlng7HSofQ7KlhFo4kuIW327AtI+KqrhagcjIyISyUKHoU2rthkZps4UXK?=
 =?us-ascii?Q?GqQ44boZyJAbDwHm+GbLynSDW2SDFwmOokohkwIKIWeZa8TdWBYukNai+eap?=
 =?us-ascii?Q?T7DG8FNyG/NMsbJeBfv3/qk9q7LD60W2vlIdfOsjZJ1nITEz0YJcOH454Ebd?=
 =?us-ascii?Q?wMIUgE6XyP3lrmquRJiYVYrIW5f8rlg7LtBlH5IIaz9siRp9no3yzVt3uajQ?=
 =?us-ascii?Q?8Mx2jitBpa4asb9teTiVXc6CSETSn5zydczzkuPagr8QgheXdmDBu7/AcX/2?=
 =?us-ascii?Q?N+/fylOjlXmzG7fdk3i/t/BKCl84d/WzxxJKFATaiidCIauduzd+uYIZb83n?=
 =?us-ascii?Q?/lVne/WYwhcWej+EaVdeDAyap8vw/d3D37WrEmcxlDb7WDpekokgQDgSgJHT?=
 =?us-ascii?Q?SvRe2k4dC+HzoTFyQv81TfsPNJzjZUWm15DH1lJqhB4amS2iUns1yTUnDnHF?=
 =?us-ascii?Q?2FelwlUEuoUedV+akJ8Ix2uNt6nvLPi/f0m7qSg/ElxZKUWk7aNzLdgjIdn7?=
 =?us-ascii?Q?JrEWI3FTL5iuKVyulnztAL6v8FrsQy8iGdxIY7epXdwYLhwr1kL0eVgW8opw?=
 =?us-ascii?Q?gRCm10LmEQHsTrbsb9QWvw+/D7p/zYvaVBtvOnU3FP1Nzbojgsfow6LE6CSw?=
 =?us-ascii?Q?SFHFqqTI4Iy8V0P5aHZ5wtQp1+t0AmaiqiLHYPhVhIMp24KQsxoS9nexh1ju?=
 =?us-ascii?Q?J2ukcORwMTt0Tb7zCz8YiumL+UyFitJwVnrHmE8zzXiwrSaQFpdgAodZD7w9?=
 =?us-ascii?Q?3CjprP8wX1OoRSOqBA52ZLA9B3eR6PdAHV4o+8p/IxWBOkif/KMV7pHWo+z3?=
 =?us-ascii?Q?PxBCLKpMAtYTMeRRJ9KsXZ0spT95/1nh/whDcuVxtfCwUt+IklvJXR/NcmZ5?=
 =?us-ascii?Q?94dsVt4EXTmmNZcXNiuvnD2ks/nHYcfiQHjwJMXMZB5zRid7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6976ec28-87b3-4de2-d44d-08de91014eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 21:46:33.8326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkmQw9poStH2wwveyL6asnrzClFWO3yecpPQWeZ5gmsZX4BOZRBZGFoiSBlyzPpfpRStpliuBhMLMPw+1Jb//Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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

[Public]

> -----Original Message-----
> From: Wu, David <David.Wu3@amd.com>
> Sent: Thursday, April 2, 2026 5:44 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Liu, Leo <Leo.Liu@amd.com>
> Subject: [PATCH V4] amdgpu/jpeg: fix deepsleep register for jpeg 5_0_0 an=
d
> 5_0_2
>
> PCTL0__MMHUB_DEEPSLEEP_IB is 0x69004 on MMHUB 4,1,0 and and
> 0x60804 on MMHUB 4,2,0. 0x62a04 is on MMHUB 1,8,0/1.
>
> The DS bits are adjusted to cover more JPEG engines and MMHUB version.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 52
> +++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 4b4aa9553624..82abe181c730 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -736,15 +736,35 @@ static void jpeg_v4_0_3_dec_ring_set_wptr(struct
> amdgpu_ring *ring)
>   */
>  void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)  {
> -     if (!amdgpu_sriov_vf(ring->adev)) {
> +     struct amdgpu_device *adev =3D ring->adev;
> +
> +     if (!amdgpu_sriov_vf(adev)) {
> +             int jpeg_inst =3D GET_INST(JPEG, ring->me);
> +             uint32_t value =3D 0x80004000; /* default DS14 */
> +
>               amdgpu_ring_write(ring,
> PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
>                       0, 0, PACKETJ_TYPE0));
> -             amdgpu_ring_write(ring, 0x62a04); /*
> PCTL0_MMHUB_DEEPSLEEP_IB */
> +
> +             /* PCTL0__MMHUB_DEEPSLEEP_IB could be different on
> different mmhub version */
> +             switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
> +             case IP_VERSION(4, 1, 0):
> +                     amdgpu_ring_write(ring, 0x69004);
> +                     value =3D 0x80010000;
> +                     break;
> +             case IP_VERSION(4, 2, 0):
> +                     amdgpu_ring_write(ring, 0x60804);
> +                     if (jpeg_inst & 1)
> +                             value =3D 0x80010000;
> +                     break;
> +             default:
> +                     amdgpu_ring_write(ring, 0x62a04);
> +                     break;
> +             }
>
>               amdgpu_ring_write(ring,
>
> PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR, 0,
>                                         0, PACKETJ_TYPE0));
> -             amdgpu_ring_write(ring, 0x80004000);
> +             amdgpu_ring_write(ring, value);
>       }
>  }
>
> @@ -757,15 +777,35 @@ void jpeg_v4_0_3_dec_ring_insert_start(struct
> amdgpu_ring *ring)
>   */
>  void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring)  {
> -     if (!amdgpu_sriov_vf(ring->adev)) {
> +     struct amdgpu_device *adev =3D ring->adev;
> +
> +     if (!amdgpu_sriov_vf(adev)) {
> +             int jpeg_inst =3D GET_INST(JPEG, ring->me);
> +             uint32_t value =3D 0x00004000; /* default DS14 */
> +
>               amdgpu_ring_write(ring,
> PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
>                       0, 0, PACKETJ_TYPE0));
> -             amdgpu_ring_write(ring, 0x62a04);
> +
> +             /* PCTL0__MMHUB_DEEPSLEEP_IB could be different on
> different mmhub version */
> +             switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
> +             case IP_VERSION(4, 1, 0):
> +                     amdgpu_ring_write(ring, 0x69004);
> +                     value =3D 0x00010000;
> +                     break;
> +             case IP_VERSION(4, 2, 0):
> +                     amdgpu_ring_write(ring, 0x60804);
> +                     if (jpeg_inst & 1)
> +                             value =3D 0x00010000;
> +                     break;
> +             default:
> +                     amdgpu_ring_write(ring, 0x62a04);
> +                     break;
> +             }
>
>               amdgpu_ring_write(ring,
>
> PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR, 0,
>                                         0, PACKETJ_TYPE0));
> -             amdgpu_ring_write(ring, 0x00004000);
> +             amdgpu_ring_write(ring, value);
>       }
>  }
>
> --
> 2.43.0

