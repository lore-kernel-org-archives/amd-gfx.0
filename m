Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92316C88E7F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 15:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0679210FC25;
	Tue, 15 Sep 2026 15:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ckXPM7MS";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C679A10FC25
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 15:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5T1wnG245yOdaRaTqcyUur/FPHQh0tI+pAzVEpJa3cOGpr1B7uwvpRqlyznhd4ZdEinKtw0Pjrf4Ex8eIgahD1c9mjI3s1Ns1l0qB1odDGOjsmnzb3E5HeVMqVyZxQTdC2FhDo/HR3YikOzHI3o/Nkz9wTRpFRviCNMP0uq/LvpF1WzBXndivvVOdywOGwXeQPqkwTwFtj8tbVfZecjj/IltTvaQMwfwcAbDReGVxE6qIgo0qfo+l+VZgW7aYUyQ+FfP+q+3VJro4HvrPkhw5CDDtocrdPOcYKfPCg3z7R1TeJxm9cbdNbn0DMAeqpWHkTgo6LvmaVdPfH2Ez2aMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkFI8Sw+9Kz+rWlHsrRZSroA3vx/9e6VvIWHv62hUI0=;
 b=Wmc1UfvdVQKxRf4aRvyvbLbUAjzQbFcsqS2YcqbR7Oe5VYZaJCu9I0afSUkXYLprQgki8zOFPENMnblZV7H8BwBtFPSoexnILsnyyZABT3BicBSfFUOx0z5jHmTStuMPKLBl3gUEpHBMgzarH7Xy6/aGHO5vFU0jXCUJQli01a1iSvJFYAcD8SGXMqNiFa/kciIglCUNeZZ+/qW4rMOpRUEqo3sMp9Vkc2MzvHiXhRUIfRnRINARwacmNsgpK2gBQolHFlUCXEa0qSpiSCYV/Z4tgQBF9D5HqhVuMgNsvCT3Nn9EYlE4WC9lqoK1XOA1GaE7XHpFY7ts6tpez1MXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkFI8Sw+9Kz+rWlHsrRZSroA3vx/9e6VvIWHv62hUI0=;
 b=ckXPM7MSdFrF2tI1vHIXMbi/kIBA5dyE4kHOcr3pY2dOt1/vkGxkUNakikkHrh6cgw9LYdx4jpNHS2IMH6Lu87hZzeQFTRrP5Wfd4pdT5f86tE9X1a1LRGXRX+h9wFZFRXE5z8c7nWSTmP18MrWzlPZfSA4eFo7Nw9i3XmQ1eH4=
Received: from PH6PR12MB345224.namprd12.prod.outlook.com
 (2603:10b6:510:3da::21) by LV2PR12MB5919.namprd12.prod.outlook.com
 (2603:10b6:408:173::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 15:04:12 +0000
Received: from PH6PR12MB345224.namprd12.prod.outlook.com
 ([fe80::ea89:cfbe:14c3:3766]) by PH6PR12MB345224.namprd12.prod.outlook.com
 ([fe80::ea89:cfbe:14c3:3766%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 15:04:12 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Francis, David"
 <David.Francis@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Avoid integer underflow in EOP ring size
 calculation.
Thread-Topic: [PATCH] drm/amdkfd: Avoid integer underflow in EOP ring size
 calculation.
Thread-Index: AQHdJN78UCyVtaJFo0ydB3J0VMa8k7bP/Sig
Date: Tue, 15 Sep 2026 15:04:12 +0000
Message-ID: <PH6PR12MB345224C5259664CA521CE6E5E285BA2@PH6PR12MB345224.namprd12.prod.outlook.com>
References: <20260805133131.608299-1-David.Francis@amd.com>
In-Reply-To: <20260805133131.608299-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-15T15:04:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH6PR12MB345224:EE_|LV2PR12MB5919:EE_
x-ms-office365-filtering-correlation-id: 15a47ad8-32fb-46c6-f0b4-08df133a9a08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 9afr6f03U9EZWWkCl0W/Az3xb781kPNjLL4q5++3YqLZMbrcqUlY+ApONo+2A/PKtF/qf5MdIlShprJWLvMIZ5O56XxCYS7y99ld3KJk741iL0xQktEX4nC1/a2y/0HqqJ8u2idMijz+xmPh5iSTR65BIDx6YEM/6sZySO1gZksLViN+/pQ3iCXNhjk1GVCcRooxocGl5zkfIeXOTuF4nQHi+x7KzMZSme7M23fxwLdHj3oKt48kCVbmux5mj0sUNxPgtJqZnFp66A0Ei2ANtgHD/8Wq9hgVsakw9Wi0d6bHOaffo8xp4jXkyELx03fsLzAuJZbbqhgZUCXOO5aVPnoqBjgTLU7d4fENAxPlvvXwf+sJvxCNmJw8i7lXWx77aSokFss50dO064SHxzOBMJFCbIQLs0s//lUD0XNNOUrKQ0HPffNY1Qbp8KhBsap6dsHiwQN9K8ElmK9xB/b4tdeB4IZdNG/E7SsOrvQaJWBpS7bk2IJ4c/fulnVlY+1OYXvDc4YYGehlS7ch6u8DdP8kK0qAXUr02ekiHGdLF3UtHDv+6y2SvqTxAeWx/UHWbFkOO6eI+kN/a2DworiQ7Lvg/ZMwhyKRrhJbC5wDd41xlRVtinZkITsN2m+6h2EinQVpc+FGif58awkWz1YxdNVBMPjeip+xrvTzqs950pCkc9h42qhAgj9RJNc0maKqvAaVJmdHlrapDaq3yD2Wy8lzUUVzQY6mu7blwwfXOTA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH6PR12MB345224.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0YlqbOsSfqFHHFRlOrWcOkUgLTB3gwiiGe6mUrx2ZzXnrm0EgFZJ69V1GGMP?=
 =?us-ascii?Q?p5NwSEshbTT1cmK43wQMcVtoZG1GQA3VAN3cw6LPsl6UncRcev+s2sScUG4F?=
 =?us-ascii?Q?uez6s+E+xJT7LG2GcIb0QActvIEwMirGcjY93s4bA4JnCZ7L3HwE+ysPFNtU?=
 =?us-ascii?Q?mwXbMbbGkcqlLaOIUEfnNegeA21sk4SRzQzoDs6m6PVgLX4GKeiFjqKd2qGX?=
 =?us-ascii?Q?aT/J6ugM+6d7e0lFjp7FMf6wYR+fyWCCiFV0J1yf9KNfD40JR4hU7In0B07y?=
 =?us-ascii?Q?GkhlFjI4PfyQkZvmb6/8hOlPLeFvMoBhRq8FOdTpxts7whiQ+PJ/wChlhVbe?=
 =?us-ascii?Q?5T+/F2gJ/QMSR+jaeCSHckPNRsWaBYcUVkaiaAzFfBtsVn3nwM0gW1Qfc2lC?=
 =?us-ascii?Q?kw5n3GYNZcYXsVuJ/jiFDg1VeJcd+AXbx/qjzWUmoC2Wa8PMqO3M5mPZYRlf?=
 =?us-ascii?Q?RvPtXxztGRaa3vPueHrbYEqAlw85FJzlhi2NA/dZME6eU4Xwov7Eqls4lN3M?=
 =?us-ascii?Q?40BqfxRTp9563HniP1p2clBKLAPE72HCwTPHFXyFO2MPlUivi8gbF4dlrm+u?=
 =?us-ascii?Q?oHgn9jmS/wQG65WOr5tTZFJ6izHiaDuxW8vzd1zEjCUkQ3v2NG/G+XIsUW9b?=
 =?us-ascii?Q?Ud2eAnt0dCllfGDQhd8tWOPwVg1y4WwV3YMEg9Y+lvc2LCzA7tLBJfF+YnQU?=
 =?us-ascii?Q?4soQ62ZTgTGcBshXw5fnTkzRa4O3mYRQj0UtWuXbv3+QSudnfnBU7XEHQA6j?=
 =?us-ascii?Q?d/erfybBP4yEnKxevJpPEIADdHgBGsY1xVkhr/aHhiG3ltlrrHtotewUXFhb?=
 =?us-ascii?Q?Lvfg+iWuQrpS0JoRVR7RJoF9QEPwPlxvIldPS3p2SWsGIY8PIyn9VPqickZB?=
 =?us-ascii?Q?AVrRy/cGyEBs3qRlVdgz3Zp5eqYYRYLp4aysvJSwFhwp0ITBIOIG8EPzWCot?=
 =?us-ascii?Q?RPK5u/z+3tuWo+BbTg/3SCf6/YfN+BlK0SaZf2d6BiIM9gM432MBRL68X3CB?=
 =?us-ascii?Q?ueA4+NBc1xj0AJpRqIg55mYTMUhgov9LAUcV68h96Lsizk+t3qVP/zCQNMY1?=
 =?us-ascii?Q?/wg767oj+Zcvon+f7s50+vZr6wKFGRY9EHL2SO5wIo0C7zWNhkwTw+mhU/Jz?=
 =?us-ascii?Q?tz9swGcofM38F3jqeXT1e+Q0ILklfa6reg1gDTrbA/sj2uWA+BY+nCDLUIU0?=
 =?us-ascii?Q?ORcqoxer33WQVb5LXeDqdmOu2ip5++rHM+W1kxMgSfj+jQ6ZvW5jpV/NHQ9C?=
 =?us-ascii?Q?GrwSDswgd9bvCjFOMVdzwxvIagIvieeN+CVakL6OYJlxbbIpmXnO+Fc3WvSB?=
 =?us-ascii?Q?dUJv/bLj2hQeU7kL9sEb4z5aJn623lc/jgdnZBgMAuryxp6hj0LIufqPu9In?=
 =?us-ascii?Q?cT0YfJsJIZhizg9ckdh17HzTu8Nd1DVwx5JRbf5JoF21e7oMBPGlxYzd6SVf?=
 =?us-ascii?Q?FAcjclNheWnZ8gIaLv0LADDRBxf4Uua/Hhyt/nK+CGo9s8M73R85fKGTA8x0?=
 =?us-ascii?Q?iKcUZ7HsuHY5jJI4juxxOacthpRZO9QgmsC5dRDhBpyGsR47WCF3mOGgiqmt?=
 =?us-ascii?Q?bnMOX+Z+E4QqgMBM4eB9H23v/n+l9LkV+CUECstiR/NDlOB/d2BCr+WHtIaL?=
 =?us-ascii?Q?83G1nd+PbZxn0INcuo5TF410oYcmSXYIks7bqg+QFTAZhLxygTWVul8OYSTO?=
 =?us-ascii?Q?ZNFPAFEOrrG+6GMlItAfDDkt7s9g8wdCVOo+ClSbW6fHdva7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH6PR12MB345224.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a47ad8-32fb-46c6-f0b4-08df133a9a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 15:04:12.2817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbbB0B+Lto+l2UhT4wPyBGldllQrbzmFhCLcKN6CfJf/qzJExLDJCxHVavWIE6on/+7cQOcAKw4v+UZYQ2dOUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
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

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Francis
> Sent: August 5, 2026 9:32 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Francis, David
> <David.Francis@amd.com>
> Subject: [PATCH] drm/amdkfd: Avoid integer underflow in EOP ring size
> calculation.
>
> The low 6 bits of cp_hqd_eop_control store the base-2 logarithm
> of the EOP ring size. This was calculated as
>
> order_base_2(q->eop_ring_buffer_size / 4) - 1
>
> But order_base_2 can in theory return 0, so this could underflow
> (although in practice the ring buffer size cannot be less than 4096).
>
> Change this to
>
> order_base_2(q->eop_ring_buffer_size / 8)
>
> using properties of logarithms.
>
> Also add to the above comment to make the mathematics more clear.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 6 +++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c | 5 ++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 75e5a9f67d50..2c0d501bf527 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -285,6 +285,10 @@ static void update_mqd(struct mqd_manager *mm, void
> *mqd,
>               1 << CP_HQD_IB_CONTROL__IB_EXE_DISABLE__SHIFT;
>
>       /*
> +      * The lowest 6 bits of eop_control store the EOP ring size. If
> +      * their value is X, the ring size is 2^(X + 1) dwords, or
> +      * 2^(X + 3) bytes.
> +      *
>        * HW does not clamp this field correctly. Maximum EOP queue size
>        * is constrained by per-SE EOP done signal count, which is 8-bit.
>        * Limit is 0xFF EOP entries (=3D 0x7F8 dwords). CP will not submit
> @@ -296,7 +300,7 @@ static void update_mqd(struct mqd_manager *mm, void
> *mqd,
>        *
>        */
>       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ?
> -             min(0xA, order_base_2(q->eop_ring_buffer_size / 4) - 1) : 0=
;
> +             min(0xA, order_base_2(q->eop_ring_buffer_size / 8)) : 0;
>
>       m->cp_hqd_eop_base_addr_lo =3D
>                       lower_32_bits(q->eop_ring_buffer_address >> 8);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index 60b87a500698..029572548c14 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -208,6 +208,9 @@ static void __update_mqd(struct mqd_manager *mm,
> void *mqd,
>                       mtype << CP_HQD_IB_CONTROL__MTYPE__SHIFT;
>
>       /*
> +      * The lowest 6 bits of eop_control store the EOP ring size. If
> +      * their value is X, the ring size is 2^(X + 1) dwords, or
> +      * 2^(X + 3) bytes.
>        * HW does not clamp this field correctly. Maximum EOP queue size
>        * is constrained by per-SE EOP done signal count, which is 8-bit.
>        * Limit is 0xFF EOP entries (=3D 0x7F8 dwords). CP will not submit
> @@ -215,7 +218,7 @@ static void __update_mqd(struct mqd_manager *mm,
> void *mqd,
>        * is safe, giving a maximum field value of 0xA.
>        */
>       m->cp_hqd_eop_control |=3D q->eop_ring_buffer_size ? min(0xA,
> -             order_base_2(q->eop_ring_buffer_size / 4) - 1) : 0;
> +             order_base_2(q->eop_ring_buffer_size / 8)) : 0;
>       m->cp_hqd_eop_base_addr_lo =3D
>                       lower_32_bits(q->eop_ring_buffer_address >> 8);
>       m->cp_hqd_eop_base_addr_hi =3D
> --
> 2.34.1

