Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6666AC5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 09:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019A810E71E;
	Thu, 29 May 2025 09:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0SgTtvDU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84DC410E71E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 09:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5XuJiuKzqdLbxELNwPXCWhH4u6xXphvMqXmj9R+P2l8usy/pQGFDlIHpB5QPJOuFOsCdq9zfF97VZi6FrQmSkaLuFXxmhv8TosjekPN/4T34z/THcabZrIWgxlLZ1A4SH7SoemInVQ71oNGldywak/44j4XBFUfd5iyxyyzWC1iiJ/mmFtWOXiHliLWQki6H+Nye2P952o2Dr9HtjEDzaAAXnY0gGfiRDPrZkWnaH8v4DC0XNNXSYESfqIq08kp8yC0nGdKun2J6VcvBaPHqDUzGi6akrfZeVSraLOXkwUemc0e26EviGCN7nyBksmVe1LPzejh/1WTvLBkr+U62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cDNZcSoUiVZ4zQTeEJTGdoReHEFnEolbdJSmVpO7zM=;
 b=aJfxwT7hMOApBl51qEBfxxH09kW9xDGUudEIqR/k02rxq2sU3cQMVvP7FjXoNTZ9RYp3W5fRHL7Ob+l2JbZ4XY61/XDVDqN4tJqnpuMKc8u73QsQPrsMZeV1L+DDW3WLxbtyv7evl57Mpb9CD5SpnM4sicYfy6fXktKVIJFZ6rKytwO1AELQkLYG437yAo/s8M58d8Qakz2qX02geDzPKNb9eLrVoBUOtTW+h7eC4xK3aeI4BtTMGxeH1OVUetcjxul3F/l7SnXOo5JX0J0YY28BfxC9qtJECHulQPqsViA7GsXsPwwtVFFIZ9Pr1JM185px/F2TaUBIjLxs4tZMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cDNZcSoUiVZ4zQTeEJTGdoReHEFnEolbdJSmVpO7zM=;
 b=0SgTtvDUcRG+/MYqlJAkXEVgCBdDueKRq4S22CefE8Ka8fcWC/L88MgfqhZObOfsjpj9YGzLfz5dcEf/U7NoTyvZSqxxqIsAI2j5ctU0DqRbWyEvev6RIQByWWXUIkRO8zHwBzCAAbH5e615VSKrrCoN01of/sxOGxkuHspuEZ0=
Received: from CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 09:04:47 +0000
Received: from CY8PR12MB8339.namprd12.prod.outlook.com
 ([fe80::e269:bb1f:4872:538f]) by CY8PR12MB8339.namprd12.prod.outlook.com
 ([fe80::e269:bb1f:4872:538f%6]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 09:04:46 +0000
From: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Remove nbiov7.9 replay count reporting
Thread-Topic: [PATCH 2/2] drm/amdgpu: Remove nbiov7.9 replay count reporting
Thread-Index: AQHb0HP06YH6uVzEj0m95W24o3JGcLPpUDeg
Date: Thu, 29 May 2025 09:04:46 +0000
Message-ID: <CY8PR12MB833987701F48DCAA1C83349FFD66A@CY8PR12MB8339.namprd12.prod.outlook.com>
References: <20250529083015.589652-1-lijo.lazar@amd.com>
 <20250529083015.589652-2-lijo.lazar@amd.com>
In-Reply-To: <20250529083015.589652-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=19e415cf-b8fd-4073-8ca6-13210c57253d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-29T09:03:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8339:EE_|SJ0PR12MB8090:EE_
x-ms-office365-filtering-correlation-id: f022eb29-e083-4136-f956-08dd9e8fdc24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zxc/4KXwtt4EUag5tsrxhI8UOF22b4Ok7OGGILNvtfCASxETYFOtdP7+HUX8?=
 =?us-ascii?Q?w/Ic8xwK849vWCHxoJFHsKlSrDTC2/ZreGZlSJb5DMvKGsVuRBowfN2FaZx7?=
 =?us-ascii?Q?ny811H6caG2ciKpSLZVPq6wlsl5ldhIW4zE2kxVKBAFhLkgQyKrHG24g//5e?=
 =?us-ascii?Q?GypF44yqPYrgWAP5wEuGrYkpjMVL57riD+xeLAxvHyqBd4fO1U9K0FJZlvkf?=
 =?us-ascii?Q?wdv2RyjWHcQ6gYxtWmhy2OqTcQQkBHw4AKemc2t4ExJMtynrGQ/dRIDYzj3v?=
 =?us-ascii?Q?VC0hliIJLVbwjutbmCMD5irrkKpwznZD260soeW0uoYyVX+Rvis0HERDkU5+?=
 =?us-ascii?Q?y/Omccme3v9cz06SP0jZ6LZphfk0coN9so+ESluCIymrEilh5FLoDEufr/2x?=
 =?us-ascii?Q?GwGBQFaFPacN1HxkrvmQzJJkW5Tl13dZJP53GNtK9W18+k3YgcT58oNU51Ro?=
 =?us-ascii?Q?XLRQ+q7aAYQFGYS+NPs1NQHLS06m1TbM51LL9L+d8a482PUyCGpSd03UBR6l?=
 =?us-ascii?Q?0mDtB6FoiG3+i92qspupGAxEYWIWJSG4F7fcQ8XUnVMv+werDHWJnkHh9hMh?=
 =?us-ascii?Q?c/+zQD3Gj7l9f+LS2uQU0WPO34oI53FSG9G5p8FnhpFVFbXHPZ7+ACHipZHl?=
 =?us-ascii?Q?KtOv2p+Jt7buO8liGbCuJTnylrKA4RvD8bCkWrtQl7N75zNRmkNk3ri75hyP?=
 =?us-ascii?Q?kjF1IEOL/aFYOb2u29irG25pz9qoHlox82EWzv+j0P+eSM0poXBFHDBpB4PP?=
 =?us-ascii?Q?Cx0S6nmD4Vd/C8b6dtaWGzqpFw+dnsWjByGyyX2R8gp3v2SaIM2GU2YRWV8F?=
 =?us-ascii?Q?LlKjo5eG2wGiAXr8YH7DVTzuUeo0ED5d8mkDhx/2TtMvEhm1K6OALxAcOz5R?=
 =?us-ascii?Q?I8Rb2FNePDAs9S97huwV8WDWygVgNKjygXLK3LvoN45BNwnvbezdcIrWsske?=
 =?us-ascii?Q?aN2TGd2jWMwhDOAdmR0dEtxdYygh2CdFn6qc4EBklFMej00HJoT4c2XVMAgq?=
 =?us-ascii?Q?ciXA5gWAgkwRWl49pzpzwshqtiDiBRPu4/5bzXmX2beo9zBI0uVfG4u8281I?=
 =?us-ascii?Q?fYFHVsw7dgITVxyAyyS2Kkt3yvinlWOpIBTLOe0f+vkHxdth5u0wX2mO0yMH?=
 =?us-ascii?Q?LhK6b1AiD0vWDPB31uiRsLm5Y7/prW9ePhpcM1fIiBlkwjwQBmSaIyGN50yI?=
 =?us-ascii?Q?rN0BDL4wAUUdKS+GTLH0TVZ5OqC0GCY/vnHBpxAYZqReLcUuHmWENepHi7TO?=
 =?us-ascii?Q?XBjIWJ82F6VmktkR6zTty+YAhjk4FFOs6tdBCdL1lbmtGp2qLWfYyJ/n0tbe?=
 =?us-ascii?Q?G6wRubU15bzyPRVWzJFRJR9QFeBPLxDazUqoIHLzbfnacZiQBxi4M7lda4zP?=
 =?us-ascii?Q?bm0z1sKfnmUdK5alcX7uR7aQ6kzXNKO+MA/jc9/7gnntY9yPtX/3MhwG/7/L?=
 =?us-ascii?Q?BLke7gjdBrCh9bCTeGG9kpoIdF8PEYiq9w76HpFDtXppNCt2LAHV5WoPRK03?=
 =?us-ascii?Q?IcoANORJbkJc94U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8339.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CbBf21zKA6cPQ5BrEdaUX3nKiViSKWiG+CiyGms/nya3MepC4UyhF1t3IvwO?=
 =?us-ascii?Q?FCIsfwQgO4guD00GirnVyE1TNkdax6UH+IuupSBqYCaf3DQNdqCbh64PK8+W?=
 =?us-ascii?Q?iZC6IRTLTPhINx8dEcBPwwJy1CL21hnWmJZnsahXJHTPZ1n1dpbPBlmio2sp?=
 =?us-ascii?Q?r6DEdF4h80gdULRYXVadqEEP7B33L1oAXs2nfRN4om0q09awBOTetAtHM88D?=
 =?us-ascii?Q?83c0JCpOoS9DcEvQZ4P1LgI7037euzb+266Nx6EjbpdcHIlpxJ7By4d9FQc5?=
 =?us-ascii?Q?Sv0MXwyaEH8lKsOjEI3ajc6HPLu7dVL5f8PaLYuaCyToZK3tiQPIdSR7ZjkF?=
 =?us-ascii?Q?wgGp6HYaY4pZDMPWbiE7UlwhO1pqdBMGvuHGRx5y7svBHSoSHk4XXzKa7uX2?=
 =?us-ascii?Q?A0UjJLBUOUZDiWQLns1zUa0F/1bg9txUger+6ani3PMx4LuRoZJyKdzT5CmY?=
 =?us-ascii?Q?vXFFMj8Ggl3marITwzOs3x73y0Ng+6kIQttMHXOnY2mzU4Fh8zZVLU9Q5YkX?=
 =?us-ascii?Q?kwwiQxtUqFIEdUDKcWcXxGAtU/56t2j8VBEOYNGm55TvBUiqLd5cJFany/7K?=
 =?us-ascii?Q?8/x8jFHMzpBnAWs/rdN3jnFyo8QsofNCgl2SUkqiMtpqLuCnNmwtwxVQtz9A?=
 =?us-ascii?Q?ah2W/wde6m3JDuVTuB5BcVdPjsi6qMQL/yItzlqYL7Sua/1gclo421oqDxvf?=
 =?us-ascii?Q?xN698BivktqtX24M3fEpr7UcHmAPQpquW5/mc51+vCtotntdRtAKDudZd2/5?=
 =?us-ascii?Q?p/Sj40Xxdg+9zvLUyTUFCyVvF7Xn/20iawjjBYdLsGTEHp6X5V8iurPSWNGx?=
 =?us-ascii?Q?c0GqcfDGyMlZ2KXqhHDXTKASOndFKrHoELok15V1DxBm1e9zzXr7bjJrnWsn?=
 =?us-ascii?Q?2dTDCosbOS3GEPXD8x+buP9acbfmiAoMcMlzU4Y6quvmBIbHC7auTPv39VHE?=
 =?us-ascii?Q?WnuSo5kRRXcXfQ8upj/LYaMhAsZ6rTrwUfBGQZEZNZPKt8MmNeUD1D6eQkUM?=
 =?us-ascii?Q?RNFVwnDh+wS+ZJafvGZp+BlIjZZDzx5uv84bXV1liWASCxpdZo2/myZXyxQ1?=
 =?us-ascii?Q?xncEuSFqq3yFQlwT8YKyXdGMHGvIcU8VBjWpUqJxne+vhKCXL0ptFs0Zocp9?=
 =?us-ascii?Q?1pSvtyW28kQsAgrtP2s1YHJMnmeFP8x8mImFmFahbQzd3JL0pHhaiSJe1qW7?=
 =?us-ascii?Q?cYecEvgrXzXRlAA5WkyOi0Ce4+776wU4gwB5k5Vc/kmp41E7vH/hMp19my9N?=
 =?us-ascii?Q?qK6AYXYgFqdgx1wuLyPGC7xeAlk5s8Q21NePwCT+rG2k4pixLCZ3uwmbIR/6?=
 =?us-ascii?Q?uJzNde585K125juo3i8GvheKdlW0l2AFxOICOagzyfOmbfCbHThBWi3Bbmvb?=
 =?us-ascii?Q?M7B8acvoDjvU6eTybm+FsBx1xacTnnJtRPRKsl9PkOmNscmEmHo3+jnWPYeC?=
 =?us-ascii?Q?ddTaeKQUfFYej3lkAsZJHqTWBFFX12VFghwFam916VaZT2q4OsI6IDjZp2tV?=
 =?us-ascii?Q?h8ga+FgQhqMnCc9LUUOIrfxbTW8l8mBTGlNMUEg9LD2kbpfaPxyzDheKRi9E?=
 =?us-ascii?Q?S4WrNbYaj7xByDv3ynI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f022eb29-e083-4136-f956-08dd9e8fdc24
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 09:04:46.6850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36xEkC9p7A6jqhZThREOb2yWkv0RvGDmo1Z1FfM0QHmthL6MOvye9C5sJnKaUGN5KExH8+I5oKGpPgunGQnX+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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

Acked-by:  Mangesh Gadre <Mangesh.Gadre@amd.com>

>-----Original Message-----
>From: Lazar, Lijo <Lijo.Lazar@amd.com>
>Sent: Thursday, May 29, 2025 2:00 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Gadre,
>Mangesh <Mangesh.Gadre@amd.com>
>Subject: [PATCH 2/2] drm/amdgpu: Remove nbiov7.9 replay count reporting
>
>Direct pcie replay count reporting is not available on nbio v7.9.
>Reporting is done through firmware.
>
>Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>
>Fixes: 50709d18f4a6 ("drm/amdgpu: Add pci replay count to nbio v7.9")
>---
> drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 20 --------------------
> 1 file changed, 20 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
>b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
>index a376f072700d..1c22bc11c1f8 100644
>--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
>+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
>@@ -31,9 +31,6 @@
>
> #define NPS_MODE_MASK 0x000000FFL
>
>-/* Core 0 Port 0 counter */
>-#define smnPCIEP_NAK_COUNTER 0x1A340218
>-
> static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)  {
>       WREG32_SOC15(NBIO, 0,
>regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
>@@ -467,22 +464,6 @@ static void nbio_v7_9_init_registers(struct amdgpu_de=
vice
>*adev)
>       }
> }
>
>-static u64 nbio_v7_9_get_pcie_replay_count(struct amdgpu_device *adev) -{
>-      u32 val, nak_r, nak_g;
>-
>-      if (adev->flags & AMD_IS_APU)
>-              return 0;
>-
>-      /* Get the number of NAKs received and generated */
>-      val =3D RREG32_PCIE(smnPCIEP_NAK_COUNTER);
>-      nak_r =3D val & 0xFFFF;
>-      nak_g =3D val >> 16;
>-
>-      /* Add the total number of NAKs, i.e the number of replays */
>-      return (nak_r + nak_g);
>-}
>-
> #define MMIO_REG_HOLE_OFFSET 0x1A000
>
> static void nbio_v7_9_set_reg_remap(struct amdgpu_device *adev) @@ -524,7
>+505,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs =3D {
>       .get_memory_partition_mode =3D nbio_v7_9_get_memory_partition_mode,
>       .is_nps_switch_requested =3D nbio_v7_9_is_nps_switch_requested,
>       .init_registers =3D nbio_v7_9_init_registers,
>-      .get_pcie_replay_count =3D nbio_v7_9_get_pcie_replay_count,
>       .set_reg_remap =3D nbio_v7_9_set_reg_remap,  };
>
>--
>2.25.1

