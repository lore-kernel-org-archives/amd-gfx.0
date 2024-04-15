Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71F0C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 16:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA9510ED0D;
	Mon, 15 Apr 2024 16:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bvR0Qewz";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4D01126E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 16:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RL3fkUK4ugU4WPUo+CmT2ZnxwsoladIEj+oz8wj2QCSNlYV39438udd/FLGXkNX4H4Hk5CpVLuy0zJrl6NXPP1WfiKGJWP5IypEoQvBHBYe1TDdYPpOuBFOpUpGRbxkvY8Q6MkhU5h23fI+UIBH2biwoWs3AvcDt79QEwkGBqckHhU46/lF449WbcMP94s7r/uEybG19N9f5S+VbfMGvnC6WbdTaJsCI7PVdARWVDJ7840LgpeHVo3eQqUiZi8rnGdITEPyTpz8qDmg3q955k5UlYqbKqZPBsCueEWgCB3knFG4TVuYQZEcwhL2L2bvs27QPNwzRayB5Toq+5hJirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXD/OpDO6b0OcCrD9J6CCp2aqiLYebq/aEEaXxB0F84=;
 b=AdfXSxP78qd80FTqDTQBDLzvVX92dW5S5JBFDaeqEX2ykBO1A1UstvLFQ/rsMbEJLFQ1+rAKw2sV2Pn4HNkitGr33WqdY0r8WWnfyBbZJCm1vRnKxDIACN2qGk5h8A6NdTWB0zxjcAk6nL79AijNDF48276UGx2KpceXHx/TIBdA5IeA6Fw4ZipSkFWtdJviOG1DRFhBlKNRXJ9f0WiQ6eiaDSyt/OW+VTUCHJnX97zXDLseswp/a41EYD5KoIPfLKyA+/eiBeTb5tLFiG1pMiIQH3++UcJLYSQk6XIpdGy5mJsaiVKsrj6nx9MRAoUrTRcnxtJCF5QXgjj3u1fnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXD/OpDO6b0OcCrD9J6CCp2aqiLYebq/aEEaXxB0F84=;
 b=bvR0QewzmAKqqMYraqESHm5Irk8S7liAiqoxMhB5hL8FfiDM5iR1/wNWIfDnbHZ7EGRNGYmcYFSjOrB3DoY2MKGOyVLPoE3lpFxbMAo1Snpm+kr6lIzi18zQcM00JsUYC47ZlhKZn8lVPyVSxpIMXbBJiinOdYFHUB6alZ0Vt1s=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 16:28:33 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::e76d:cc32:47ca:b039]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::e76d:cc32:47ca:b039%5]) with mapi id 15.20.7409.031; Mon, 15 Apr 2024
 16:28:33 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Six, Lancelot" <Lancelot.Six@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Enable SQ watchpoint for gfx10
Thread-Topic: [PATCH] drm/amdkfd: Enable SQ watchpoint for gfx10
Thread-Index: AQHajNiANSUgodbw/Ua1Ck+XkECl4LFpigpA
Date: Mon, 15 Apr 2024 16:28:33 +0000
Message-ID: <CY8PR12MB7435884A687D2FEC5BF53CB785092@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240412125333.257946-1-lancelot.six@amd.com>
In-Reply-To: <20240412125333.257946-1-lancelot.six@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=277b0939-0b97-498f-9f39-2d48968e62e4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-15T16:28:03Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SA1PR12MB7368:EE_
x-ms-office365-filtering-correlation-id: 161bd62f-cc9f-4f18-ac33-08dc5d69180e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WKAiTi7whiwx+tdj+jwhYV63bDGxUtK1ez+ROYSaZziU7sez3wuEESumzNSrBSYTj0Ii/1RERvT6Ev3AqslFUybHE6/3h+hoo7gCn4aq46VIQd6WMo55T7rKo/wVNI1zq6THHGMpy5XNGABzi0y5VQBImx4WIwwbRPlljNwSC1oQUC5Os6ClEh8lkQAdPQVMqdSHqzp4kkeb/aSyY2R2mF2naHEk7+5hcUEu2MZHecl/lTpc83ku0KsymW6FzVISmzfRT+/QvYnn+6s7o9l/Nva478OvCwMQZY9Uv3LTimtbhyw190ew2pvXkvYgtk4AFrygpTqgBF1HS1knxTqW7ErP7eud1nW7lMSgyfPtrTqwrA/Z/MrxYLFVG9Xhcv+QjS7QiRL/1gxAuSksRf6Yul5QOW3SumbdpCNYdl6i5ExUIXWFQIGWxqAR7CI3hQIrRMamOWM9RZRf7YNQ0auS/gSK4NAITZXLBWzKRTobwXeunienjGqDpY8Ua55xHMKOaGxAkSCqk87L4R5taUMRaRAJyXTlMzJWDXjpbg0lvu5YdJDReI0JAgVNsYwfGdMSERf5gkviWshYRnbIp/ehfL3z3aHqqXVInkH6ZbT0DU46Y0FbyBzQkCNe34CMDRLFblEAMeb6I4JuCLDtkJEkO4GGrt6dYN/R2RDezJOPowkUtnXUfuFBbzXeMI56XVRxQgm1gDlci1QNjhq4qdaZEmgNvnz6N1lM7PFCY4UwOIk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?95pXAoyRKwUTJ0TEpXJ58afrTI1EIA9z0fnCjXq6pZfNrAAl7muiJ3J27vNy?=
 =?us-ascii?Q?nK9tgP83WcJmRaMt7UAbZTfTgOjAH0i/+SpfHtUg6XSU1sLFTgGq6zC/HY5q?=
 =?us-ascii?Q?IjZzff+XpKmgwefiOaWSdh8RrHwgZtJk6QDXwmNt7UP1rrH0ZLSn9sXix9/D?=
 =?us-ascii?Q?yZw0TNzrSLOdarSwLiQh8iCjN/Y4sUHfSimxvyQth09SFcA5JFEcBattsqqL?=
 =?us-ascii?Q?6HYp3ER1luj2sTAN+s98GNRwO4Geb2lw1AlNPfLmawPJUkfGZ0S+mMmShuOI?=
 =?us-ascii?Q?Mj+mKkrhfZk4VwjuXYjmKcyrGgFv6qvo8Y0p7dxHDPG7VINI+C5/tXKJZ5gg?=
 =?us-ascii?Q?9Ihl0xxTIDcxDyFQ2yz28UsYuPy8KHpz5piJT/JTLu5DGTUsJibuD/+RvJDw?=
 =?us-ascii?Q?6jhu5XQblvTgvdEQ4YcjpqKHu8gj4wGVCV85V4AFUMsZAcwl2AIFTU6+yToG?=
 =?us-ascii?Q?OzD6LRKKFKoQYBt3E+4jHv7B4QmoxbcCN7F0IAt/G+gdbA3RoiRXPeZ8RpSY?=
 =?us-ascii?Q?V+QXIR7xBvV8BSA9WqjjRLyiY6VEIioUmbF/d3zy0pJQklwD2jrB6AT5SmHi?=
 =?us-ascii?Q?y+Ag781FS36EQexkqAsUqCgJQ18uaBsOfu6nyT48QGWRiv2UCGVNBhrKEoLv?=
 =?us-ascii?Q?Syq+3JYcSHWo/PoSRBIyXfBxcbWdOhcCQwXkY7CcgS2k59SnwM9fyw37JQB3?=
 =?us-ascii?Q?6bq5y7miVFl9PtOW7/h5SCPXt0dNtkSwNUzSV6IMTWRHCCMGireXvByO3z9P?=
 =?us-ascii?Q?PdMCzYUnfywr0kHD+DT3aeZgWDzqKqYZCKeBmRYoDfeYNXLCCJg+GC6B2sEQ?=
 =?us-ascii?Q?MBIJNOaUucEp8m2ON7ppMOVr1Qdjs9tw9nKBrhJ8v7JjPQwl/s7KrcHJ+NR1?=
 =?us-ascii?Q?rcjKNa/29gL5SMytYGAArREcNTQNxGxWcwPXwO6Ie8O73lruZKfiWZOLBq7q?=
 =?us-ascii?Q?r9OyaFJJGmeQyk5KnZO9QOlEGAfaSmQtyCqmlWa8fBeb1H9Z/0GLBgsR3hiI?=
 =?us-ascii?Q?xtPzbb5D5Ajpby0f28gW3/IRCg5lI0U4j4hNyzXgIzi5Oij4hbN6y4DVQ8ya?=
 =?us-ascii?Q?V1MqzdgAyYwoayQj29a9yxRh17WMV8sipklUSqYezIA9+J2FoDjRE3Liz0kQ?=
 =?us-ascii?Q?v6+Cvyhf2aDtighbl5bzuG8spmtjGOx2lO7iM3UWixOpEEySQ+9jkvV5ZcFV?=
 =?us-ascii?Q?7R7eWt5KOT7m+hbXtkl07Ouwtw3mxE9eDQRc95NRNfMe3OhZdunmD9QpzStk?=
 =?us-ascii?Q?FanDuSQH3qJkhLnV8v0gXkYAnvZnA1HGBq4kLIa/W/kMqYLsTcjW5RD623gy?=
 =?us-ascii?Q?zfqsx3wk/6qZUttof55MJM75UopB5iok5bFgiM8EQ0OgzcguryUR5ocRxiCu?=
 =?us-ascii?Q?4xpBVNUZ1DA/1Ei6NhXdPJ1ihmlxzM35KBixy7YUlWGuc61W1QFGyyMTSAKT?=
 =?us-ascii?Q?u48KL4FvHAdXmMLDBO+642oaKJfMk/Qp18nAIlsVf1q+BDW1jsnV5aRxjULy?=
 =?us-ascii?Q?XAkMt8Nt5qL/2blgP4r85pz2uNFzQPR2Cym0GjC2Zfsy0fMW6cyvYH/G0Z+I?=
 =?us-ascii?Q?uxMfJ7ZXwN8Z0Wag+1Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161bd62f-cc9f-4f18-ac33-08dc5d69180e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 16:28:33.5909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGVFGiAdBuKNu1WdS09aCXLRREfWR189Dyn5qh8dR284G6pHbGbQXgkLCkkrV4Re
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
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
> From: Six, Lancelot <Lancelot.Six@amd.com>
> Sent: Friday, April 12, 2024 8:54 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Six, Lancelot
> <Lancelot.Six@amd.com>
> Subject: [PATCH] drm/amdkfd: Enable SQ watchpoint for gfx10
>
> There are new control registers introduced in gfx10 used to configure
> hardware watchpoints triggered by SMEM instructions:
> SQ_WATCH{0,1,2,3}_{CNTL_ADDR_HI,ADDR_L}.
>
> Those registers work in a similar way as the TCP_WATCH* registers
> currently used for gfx9 and above.
>
> This patch adds support to program the SQ_WATCH registers for gfx10.
>
> The SQ_WATCH?_CNTL.MASK field has one bit more than
> TCP_WATCH?_CNTL.MASK, so SQ watchpoints can have a finer granularity
> than TCP_WATCH watchpoints.  In this patch, we keep the capabilities
> advertised to the debugger unchanged
> (HSA_DBG_WATCH_ADDR_MASK_*_BIT_GFX10) as this reflects what both
> TCP and
> SQ watchpoints can do and both watchpoints are configured together.
>
> Signed-off-by: Lancelot SIX <lancelot.six@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 71
> +++++++++++++++----
>  1 file changed, 58 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 69810b3f1c63..3ab6c3aa0ad1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -881,6 +881,7 @@ uint32_t
> kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
>  }
>
>  #define TCP_WATCH_STRIDE (mmTCP_WATCH1_ADDR_H -
> mmTCP_WATCH0_ADDR_H)
> +#define SQ_WATCH_STRIDE (mmSQ_WATCH1_ADDR_H -
> mmSQ_WATCH0_ADDR_H)
>  uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
>                                       uint64_t watch_address,
>                                       uint32_t watch_address_mask,
> @@ -889,55 +890,93 @@ uint32_t kgd_gfx_v10_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t debug_vmid,
>                                       uint32_t inst)
>  {
> +     /* SQ_WATCH?_ADDR_* and TCP_WATCH?_ADDR_* are programmed
> with the
> +      * same values.
> +      */
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> -     uint32_t watch_address_cntl;
> -
> -     watch_address_cntl =3D 0;
> +     uint32_t tcp_watch_address_cntl;
> +     uint32_t sq_watch_address_cntl;
>
>       watch_address_low =3D lower_32_bits(watch_address);
>       watch_address_high =3D upper_32_bits(watch_address) & 0xffff;
>
> -     watch_address_cntl =3D REG_SET_FIELD(watch_address_cntl,
> +     tcp_watch_address_cntl =3D 0;
> +     tcp_watch_address_cntl =3D REG_SET_FIELD(tcp_watch_address_cntl,
>                       TCP_WATCH0_CNTL,
>                       VMID,
>                       debug_vmid);
> -     watch_address_cntl =3D REG_SET_FIELD(watch_address_cntl,
> +     tcp_watch_address_cntl =3D REG_SET_FIELD(tcp_watch_address_cntl,
>                       TCP_WATCH0_CNTL,
>                       MODE,
>                       watch_mode);
> -     watch_address_cntl =3D REG_SET_FIELD(watch_address_cntl,
> +     tcp_watch_address_cntl =3D REG_SET_FIELD(tcp_watch_address_cntl,
>                       TCP_WATCH0_CNTL,
>                       MASK,
>                       watch_address_mask >> 7);
>
> +     sq_watch_address_cntl =3D 0;
> +     sq_watch_address_cntl =3D REG_SET_FIELD(sq_watch_address_cntl,
> +                     SQ_WATCH0_CNTL,
> +                     VMID,
> +                     debug_vmid);
> +     sq_watch_address_cntl =3D REG_SET_FIELD(sq_watch_address_cntl,
> +                     SQ_WATCH0_CNTL,
> +                     MODE,
> +                     watch_mode);
> +     sq_watch_address_cntl =3D REG_SET_FIELD(sq_watch_address_cntl,
> +                     SQ_WATCH0_CNTL,
> +                     MASK,
> +                     watch_address_mask >> 6);
> +
>       /* Turning off this watch point until we set all the registers */
> -     watch_address_cntl =3D REG_SET_FIELD(watch_address_cntl,
> +     tcp_watch_address_cntl =3D REG_SET_FIELD(tcp_watch_address_cntl,
>                       TCP_WATCH0_CNTL,
>                       VALID,
>                       0);
> -
>       WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
>                       (watch_id * TCP_WATCH_STRIDE)),
> -                     watch_address_cntl);
> +                     tcp_watch_address_cntl);
> +
> +     sq_watch_address_cntl =3D REG_SET_FIELD(sq_watch_address_cntl,
> +                     SQ_WATCH0_CNTL,
> +                     VALID,
> +                     0);
> +     WREG32((SOC15_REG_OFFSET(GC, 0, mmSQ_WATCH0_CNTL) +
> +                     (watch_id * SQ_WATCH_STRIDE)),
> +                     sq_watch_address_cntl);
>
> +     /* Program {TCP,SQ}_WATCH?_ADDR* */
>       WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_H) +
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_high);
> -
>       WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_L) +
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_low);
>
> +     WREG32((SOC15_REG_OFFSET(GC, 0, mmSQ_WATCH0_ADDR_H) +
> +                     (watch_id * SQ_WATCH_STRIDE)),
> +                     watch_address_high);
> +     WREG32((SOC15_REG_OFFSET(GC, 0, mmSQ_WATCH0_ADDR_L) +
> +                     (watch_id * SQ_WATCH_STRIDE)),
> +                     watch_address_low);
> +
>       /* Enable the watch point */
> -     watch_address_cntl =3D REG_SET_FIELD(watch_address_cntl,
> +     tcp_watch_address_cntl =3D REG_SET_FIELD(tcp_watch_address_cntl,
>                       TCP_WATCH0_CNTL,
>                       VALID,
>                       1);
> -
>       WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
>                       (watch_id * TCP_WATCH_STRIDE)),
> -                     watch_address_cntl);
> +                     tcp_watch_address_cntl);
> +
> +     sq_watch_address_cntl =3D REG_SET_FIELD(sq_watch_address_cntl,
> +                     SQ_WATCH0_CNTL,
> +                     VALID,
> +                     1);
> +     WREG32((SOC15_REG_OFFSET(GC, 0, mmSQ_WATCH0_CNTL) +
> +                     (watch_id * SQ_WATCH_STRIDE)),
> +                     sq_watch_address_cntl);
>
>       return 0;
>  }
> @@ -953,8 +992,14 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct
> amdgpu_device *adev,
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_cntl);
>
> +     WREG32((SOC15_REG_OFFSET(GC, 0, mmSQ_WATCH0_CNTL) +
> +                     (watch_id * SQ_WATCH_STRIDE)),
> +                     watch_address_cntl);
> +
>       return 0;
>  }
> +#undef TCP_WATCH_STRIDE
> +#undef SQ_WATCH_STRIDE
>
>
>  /* kgd_gfx_v10_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2
> values
>
> base-commit: fd1be4972efe2c3f1183404572c34e2b5549c07e
> --
> 2.34.1

