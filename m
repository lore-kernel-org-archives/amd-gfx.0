Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A0CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 13:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 339F510E55B;
	Thu, 20 Jan 2022 13:32:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D9310E3A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 13:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AagQ2nf0YY36uJB+ECV47ykgUN7i1p7y13OfSHtGLjbUMJ1b5YlPLYriXGr+qOTLg7XsFOCkpA4s18kvmuMrAlOx5V68vB9rFaDLtJf38/vSwTwUlzuJkcvcGekbg2FyQLV3fwVboOjnkKBX8wMVoBX8dm2cbVzWQjMfrsScGqMBt+4ACac4HUm8HDPBD0x385JkQij73eJf8tKau4+nE9TWphf3iNU34a4x2j69IiFuUhuPpcnJfUPnIGoV2XlPifuOWpGQSfIh97AZRxTvT7NMZKTJeRHZYoHk3bNOe1Mm3akdpFRVHLHsilKcxhvbhzcaOO657Ud3wUdQCf5RAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUlF0ekCg0p4iL4/Fm4qgP0DZF2ZosaLy/MK1mubWS0=;
 b=O01k6m58bhlUAWKLYMHqbRoLBKS5av1cYxZg+mo7tHSbJiEDqPF2fSZLlKtdK97gnGt03sWQha5u5uEyDkEmnPYZsz1DlxWkJ7s8FCM8UWIQ7BMdEQZQL6dYCHKjUD/ad2vjinHS0nKfxyaNLUSRWdXOMNBUTzh9zruiwAd1QRc02fBCrDBLxNTnQOLQ7wQ/FxlODst1wgfJTbaFkPfeyePbeNnKP1TTOgdflzAZyo1jxW1eTRT+8YL5U3X/gDn5m3Weng64thvYFqdpzNcRw0TmqKLlCVwatESthgOQ1YDJ+XKT5RAh5XAtsNwuqN46M2Py1AEEb/DyQgl8cI6+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUlF0ekCg0p4iL4/Fm4qgP0DZF2ZosaLy/MK1mubWS0=;
 b=1Zwf+JA1UMzRQY8w/cYHmiObmd6YNA1BZ7/tRt05wspMzEoAoUHmsdO94KLrBcR1khwFuQZKFMtNf0Pr0/WwaNY5u7kpUgUyaPw3pVfJzk26YqO30VopceaLdK8Y/xEa3LB6zrF76K7ikZ3Mpi/kMSsMm2z2AzaGkinnkTCm690=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by BYAPR12MB2919.namprd12.prod.outlook.com (2603:10b6:a03:12c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 13:32:08 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 13:32:08 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: switch to common helper to read bios from rom
Thread-Topic: [PATCH] drm/amdgpu: switch to common helper to read bios from rom
Thread-Index: AQHYDfCfedlHrZjlgUyhKv5B3HvLaKxr6CzH
Date: Thu, 20 Jan 2022 13:32:08 +0000
Message-ID: <CO6PR12MB54735252E08C8C3BF086D184825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220120112635.11904-1-Hawking.Zhang@amd.com>
In-Reply-To: <20220120112635.11904-1-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T13:32:02.118Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 104be664-476d-4b0d-b41e-08d9dc1941ec
x-ms-traffictypediagnostic: BYAPR12MB2919:EE_
x-microsoft-antispam-prvs: <BYAPR12MB2919939CAF547E2BE24371F1825A9@BYAPR12MB2919.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7AdmMbCXDoEv+JBK02AkPF2RpN39tLv4LPpf2UCR4pdoHoGhPwIjkMxNpvTl6MNGrc24e30Fxd4gUS/J6okWqnvxYTnM6JQD/TEtAS14DO9VPyxE2CZr3hBp16KaHJFDWXF7FpRXn0UIoqINpdaccmPGNQHTfqcSdc/5m0Z0k/Qkb873nO14AHrp/HzXjdBn82rq5+TOUFCtVKrZGUWTp2lLtF4LYnroSoRaYZn3FJCx1Zm5VnMNJBxo3Y2VQOXQgwmXRK0lUrZjZHZJJde3U87pG9wEma3SKKAjXF5xV6Io9daZgDRI2ZjU8nig6WnsUFGbFMGAcNZFKAnU43EGGG81FeTqzhp3b3xSYiAFym5/sFBhGXGl4J8HatNjNFBufZynWYWbUyH1XZmbPYZugH6PgHImx6TUoIgsjHqwsz/idhRzpy37zqTgaUkDNHdA4BURXgjWkpDw1Upgb64TQKr00RMNP0Poc3vguHiGhvvWJ+xYxkru6pRckzOYXrunz8zNG/Zqelq9Rp0c687FVzTlxA+p+0JPDXYcF8GzTM0PAX8wO6FTjOW0HunO1KIjklszJz5ga42tuSw23b6HqwboP3hP/0AH4d+HPsdmMWIg4jts0ABbZcv79dbepwSEzATtnV7nt6wgf4Jeuj0nBfONuTuYzArvhLbMLw+EHsCz6DDayLZ88D/BGXmlkEkfpf6/ZjLzuiXifh0G7J0zNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(52536014)(8936002)(83380400001)(5660300002)(33656002)(316002)(71200400001)(508600001)(7696005)(6506007)(186003)(26005)(38100700002)(55016003)(8676002)(19627405001)(9686003)(6636002)(64756008)(86362001)(76116006)(66446008)(66476007)(66556008)(122000001)(66946007)(2906002)(53546011)(91956017)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XXRZjn9Mbabhxva2rFwAoRH2gCjHXslx6nbmfJT2ATrH4B5vQ25Bn+pJbE?=
 =?iso-8859-1?Q?w5TEf5M2w+TR7sHc49MjhXBhFPKiPun3LL/cwd/AjtiUPMHFSey+FO84yZ?=
 =?iso-8859-1?Q?UjFFXmw1dSkiiBHU5ol5NvocR96mWMYRhQ5BUtAt9MRkn0/q/lhGVLnwK6?=
 =?iso-8859-1?Q?vejUktMVPf3hLZLqWAYIGsixwhY+3+AT36CXkMaTLbJ/1JGYBwbS5+tKnR?=
 =?iso-8859-1?Q?lQ1ulu4XEs1ipdrn5e7lLRx2kIJRMHnvQmFh+0YT2dH0UDJolKmIZs/zKy?=
 =?iso-8859-1?Q?7ZX5C0WCNvaYy0NEXQiT3TQ7+TfxJnJ8K58woFz/hPWPe6LqSPkr0ds5ff?=
 =?iso-8859-1?Q?GiPExzDIb0PJXbHzwsej0Ci2sP3R8p4GqafPp4xlXbwUOCKDShjiUzN1nc?=
 =?iso-8859-1?Q?rpn444yX+ZfU3huT1k4jF1VDkYRyKw8nsqbsR89J78Nds8cPz/NdNCRCYS?=
 =?iso-8859-1?Q?Na38hm/qnDvx9zfWDQHQQD0Dz+NBnoPQM3kEFKVt0eXcgC7d2/ICtBcmyh?=
 =?iso-8859-1?Q?YktmFLIEQlESw4dmWhwmH823xBeW08T74BWmYPzFXc9mUTodXn5DQSHFz1?=
 =?iso-8859-1?Q?SlxHbap8Adj4XQVKf7TQ5ikIip924sK5k48LIkqn2265FDjRp25iTnsb9z?=
 =?iso-8859-1?Q?H6fozbeoBLvFGwNT4qKvZ3LJPyNSnSbX7qE/LwtQa/3HzUOSV6lVFJEYwO?=
 =?iso-8859-1?Q?TONyEOON+1cE5y7pgDsH5rGYC8DrE88lm3ALUIUbyVHUSZnp+As1t3isww?=
 =?iso-8859-1?Q?2Xd0F69BVShBTAqwta5Ka/2Nw+1r1HUAHTMFpfG3Yij/l1W1o/QIfEjjE6?=
 =?iso-8859-1?Q?RoE2HDobaYvdUNhhdMNep8Hn/TLv6pydgjcpbKOGnQVQ2Ly0Rqcm1fgfdP?=
 =?iso-8859-1?Q?gP5Ee/cnDYuXAaPlNKwZPY91GmDa3ZAT9wlszMMy4IUNp0MWkciZqzhkY9?=
 =?iso-8859-1?Q?PyyOTnQ+w0hiY+zU8QVSI4Dsf8+jXWurR51am2imGLDMpCwdTbYhirhT6H?=
 =?iso-8859-1?Q?htNY9PUmHcbC9tKG5+rjSvUJCb5UEOD1XenKUcixeoY851CcCWad00PCE9?=
 =?iso-8859-1?Q?BB0ibCaOmPWs2qg8r7HwTIsZfVuBvyRGtPY26b2dBNvmP9uXkQzRg66NJm?=
 =?iso-8859-1?Q?ecLnmKw+JHTrotW5Lbq/ST5xvL5PcihUMJQTeh7/qCxWinxi0XgdDBlkyv?=
 =?iso-8859-1?Q?DV+mnxhFqOzPg8KMg2d+4mgUbYUzHWNVf79CpbEl7whz0sD+scP8FkFMfI?=
 =?iso-8859-1?Q?CVXo+zNACInfMu7avBMMqCfOEnEdysQyQOuwZjgqHi4jMYAMsUgEDZTUde?=
 =?iso-8859-1?Q?ZwQx3AJysY5r7uJGhItUltB+bKtjQ7iZ/UgPdOlekvx3JZy2JVuuPku4wS?=
 =?iso-8859-1?Q?1WIS6N/Fyl93DtUNq6+3X9Vb871VO0qASe89T/zJWzXea+l5RPDbgsxqmm?=
 =?iso-8859-1?Q?j0nVlTJVMLnbjOVvoM13SB5fJATnv2uFKRWQPZzhj8ZkbNerQXezQOwPPL?=
 =?iso-8859-1?Q?4ntEOPmvEn9eyr2UXHO1sk+hDgn/AvHgfZkjceH4czkO4dMxNerbPHKvD/?=
 =?iso-8859-1?Q?1TMOzV9DdFWelSUEPw6edv4Gj+a29+OhHb8RaF0Yj0fAUlhSwEMFfBcsN3?=
 =?iso-8859-1?Q?zwiwnnDxVhllw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB54735252E08C8C3BF086D184825A9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104be664-476d-4b0d-b41e-08d9dc1941ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 13:32:08.6262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYJ3+j/B0NfZGOI7v7x72bkFYFuXY1uUoR2BfRTP4j/iIZxLvOr2alvg4HkH8nUU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
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

--_000_CO6PR12MB54735252E08C8C3BF086D184825A9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Hawking =
Zhang <Hawking.Zhang@amd.com>
Sent: Thursday, January 20, 2022 7:26 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: switch to common helper to read bios from rom

create a common helper function for soc15 and onwards
to read bios image from rom

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 38 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c          | 34 +--------------------
 drivers/gpu/drm/amd/amdgpu/soc15.c       | 37 ++---------------------
 4 files changed, 43 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 8a7759147fb2..b2da840f4718 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -378,7 +378,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *ad=
ev,
  */
 bool amdgpu_get_bios(struct amdgpu_device *adev);
 bool amdgpu_read_bios(struct amdgpu_device *adev);
-
+bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
+                                    u8 *bios, u32 length_bytes);
 /*
  * Clocks
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c
index ca0503d56e5c..a819828408fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -476,3 +476,41 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
         adev->is_atom_fw =3D (adev->asic_type >=3D CHIP_VEGA10) ? true : f=
alse;
         return true;
 }
+
+/* helper function for soc15 and onwards to read bios from rom */
+bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
+                                    u8 *bios, u32 length_bytes)
+{
+       u32 *dw_ptr;
+       u32 i, length_dw;
+       u32 rom_index_offset;
+       u32 rom_data_offset;
+
+       if (bios =3D=3D NULL)
+               return false;
+       if (length_bytes =3D=3D 0)
+               return false;
+       /* APU vbios image is part of sbios image */
+       if (adev->flags & AMD_IS_APU)
+               return false;
+       if (!adev->smuio.funcs ||
+           !adev->smuio.funcs->get_rom_index_offset ||
+           !adev->smuio.funcs->get_rom_data_offset)
+               return false;
+
+       dw_ptr =3D (u32 *)bios;
+       length_dw =3D ALIGN(length_bytes, 4) / 4;
+
+       rom_index_offset =3D
+               adev->smuio.funcs->get_rom_index_offset(adev);
+       rom_data_offset =3D
+               adev->smuio.funcs->get_rom_data_offset(adev);
+
+       /* set rom index to 0 */
+       WREG32(rom_index_offset, 0);
+       /* read out the rom data */
+       for (i =3D 0; i < length_dw; i++)
+               dw_ptr[i] =3D RREG32(rom_data_offset);
+
+       return true;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 3ccd3b42196a..e52d1114501c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -358,38 +358,6 @@ static bool nv_read_disabled_bios(struct amdgpu_device=
 *adev)
         return false;
 }

-static bool nv_read_bios_from_rom(struct amdgpu_device *adev,
-                                 u8 *bios, u32 length_bytes)
-{
-       u32 *dw_ptr;
-       u32 i, length_dw;
-       u32 rom_index_offset, rom_data_offset;
-
-       if (bios =3D=3D NULL)
-               return false;
-       if (length_bytes =3D=3D 0)
-               return false;
-       /* APU vbios image is part of sbios image */
-       if (adev->flags & AMD_IS_APU)
-               return false;
-
-       dw_ptr =3D (u32 *)bios;
-       length_dw =3D ALIGN(length_bytes, 4) / 4;
-
-       rom_index_offset =3D
-               adev->smuio.funcs->get_rom_index_offset(adev);
-       rom_data_offset =3D
-               adev->smuio.funcs->get_rom_data_offset(adev);
-
-       /* set rom index to 0 */
-       WREG32(rom_index_offset, 0);
-       /* read out the rom data */
-       for (i =3D 0; i < length_dw; i++)
-               dw_ptr[i] =3D RREG32(rom_data_offset);
-
-       return true;
-}
-
 static struct soc15_allowed_register_entry nv_allowed_read_registers[] =3D=
 {
         { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS)},
         { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2)},
@@ -707,7 +675,7 @@ static int nv_update_umd_stable_pstate(struct amdgpu_de=
vice *adev,
 static const struct amdgpu_asic_funcs nv_asic_funcs =3D
 {
         .read_disabled_bios =3D &nv_read_disabled_bios,
-       .read_bios_from_rom =3D &nv_read_bios_from_rom,
+       .read_bios_from_rom =3D &amdgpu_soc15_read_bios_from_rom,
         .read_register =3D &nv_read_register,
         .reset =3D &nv_asic_reset,
         .reset_method =3D &nv_asic_reset_method,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 0fc1747e4a70..e5a1950fb862 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -375,39 +375,6 @@ static bool soc15_read_disabled_bios(struct amdgpu_dev=
ice *adev)
         return false;
 }

-static bool soc15_read_bios_from_rom(struct amdgpu_device *adev,
-                                    u8 *bios, u32 length_bytes)
-{
-       u32 *dw_ptr;
-       u32 i, length_dw;
-       uint32_t rom_index_offset;
-       uint32_t rom_data_offset;
-
-       if (bios =3D=3D NULL)
-               return false;
-       if (length_bytes =3D=3D 0)
-               return false;
-       /* APU vbios image is part of sbios image */
-       if (adev->flags & AMD_IS_APU)
-               return false;
-
-       dw_ptr =3D (u32 *)bios;
-       length_dw =3D ALIGN(length_bytes, 4) / 4;
-
-       rom_index_offset =3D
-               adev->smuio.funcs->get_rom_index_offset(adev);
-       rom_data_offset =3D
-               adev->smuio.funcs->get_rom_data_offset(adev);
-
-       /* set rom index to 0 */
-       WREG32(rom_index_offset, 0);
-       /* read out the rom data */
-       for (i =3D 0; i < length_dw; i++)
-               dw_ptr[i] =3D RREG32(rom_data_offset);
-
-       return true;
-}
-
 static struct soc15_allowed_register_entry soc15_allowed_read_registers[] =
=3D {
         { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS)},
         { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2)},
@@ -925,7 +892,7 @@ static void soc15_pre_asic_init(struct amdgpu_device *a=
dev)
 static const struct amdgpu_asic_funcs soc15_asic_funcs =3D
 {
         .read_disabled_bios =3D &soc15_read_disabled_bios,
-       .read_bios_from_rom =3D &soc15_read_bios_from_rom,
+       .read_bios_from_rom =3D &amdgpu_soc15_read_bios_from_rom,
         .read_register =3D &soc15_read_register,
         .reset =3D &soc15_asic_reset,
         .reset_method =3D &soc15_asic_reset_method,
@@ -947,7 +914,7 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
=3D
 static const struct amdgpu_asic_funcs vega20_asic_funcs =3D
 {
         .read_disabled_bios =3D &soc15_read_disabled_bios,
-       .read_bios_from_rom =3D &soc15_read_bios_from_rom,
+       .read_bios_from_rom =3D &amdgpu_soc15_read_bios_from_rom,
         .read_register =3D &soc15_read_register,
         .reset =3D &soc15_asic_reset,
         .reset_method =3D &soc15_asic_reset_method,
--
2.17.1


--_000_CO6PR12MB54735252E08C8C3BF086D184825A9CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Hawking Zhang &lt;Hawking.Zha=
ng@amd.com&gt;<br>
<b>Sent:</b> Thursday, January 20, 2022 7:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: switch to common helper to read bios fr=
om rom</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">create a common helper function for soc15 and onwa=
rds<br>
to read bios image from rom<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
Reviewed-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 38 +++++++++++++++++++++++=
+<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 34 +--------------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 37 ++---------------------<br>
&nbsp;4 files changed, 43 insertions(+), 69 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 8a7759147fb2..b2da840f4718 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -378,7 +378,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *ad=
ev,<br>
&nbsp; */<br>
&nbsp;bool amdgpu_get_bios(struct amdgpu_device *adev);<br>
&nbsp;bool amdgpu_read_bios(struct amdgpu_device *adev);<br>
-<br>
+bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *bios, u32=
 length_bytes);<br>
&nbsp;/*<br>
&nbsp; * Clocks<br>
&nbsp; */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c<br>
index ca0503d56e5c..a819828408fd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
@@ -476,3 +476,41 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;is_atom_fw =3D (a=
dev-&gt;asic_type &gt;=3D CHIP_VEGA10) ? true : false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
+<br>
+/* helper function for soc15 and onwards to read bios from rom */<br>
+bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *bios, u32=
 length_bytes)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *dw_ptr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 i, length_dw;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rom_index_offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rom_data_offset;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bios =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (length_bytes =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* APU vbios image is part of sbios i=
mage */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;smuio.funcs ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;smu=
io.funcs-&gt;get_rom_index_offset ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;smu=
io.funcs-&gt;get_rom_data_offset)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dw_ptr =3D (u32 *)bios;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; length_dw =3D ALIGN(length_bytes, 4) =
/ 4;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rom_index_offset =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;smuio.funcs-&gt;get_rom_index_offset(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rom_data_offset =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;smuio.funcs-&gt;get_rom_data_offset(adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set rom index to 0 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rom_index_offset, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* read out the rom data */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; length_dw; i++)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dw_ptr[i] =3D RREG32(rom_data_offset);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 3ccd3b42196a..e52d1114501c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -358,38 +358,6 @@ static bool nv_read_disabled_bios(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
-static bool nv_read_bios_from_rom(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *bios, u32 length_bytes)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *dw_ptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 i, length_dw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rom_index_offset, rom_data_offset=
;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bios =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (length_bytes =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* APU vbios image is part of sbios i=
mage */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dw_ptr =3D (u32 *)bios;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; length_dw =3D ALIGN(length_bytes, 4) =
/ 4;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rom_index_offset =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;smuio.funcs-&gt;get_rom_index_offset(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rom_data_offset =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;smuio.funcs-&gt;get_rom_data_offset(adev);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set rom index to 0 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rom_index_offset, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* read out the rom data */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; length_dw; i++)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dw_ptr[i] =3D RREG32(rom_data_offset);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
-}<br>
-<br>
&nbsp;static struct soc15_allowed_register_entry nv_allowed_read_registers[=
] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, m=
mGRBM_STATUS)},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, m=
mGRBM_STATUS2)},<br>
@@ -707,7 +675,7 @@ static int nv_update_umd_stable_pstate(struct amdgpu_de=
vice *adev,<br>
&nbsp;static const struct amdgpu_asic_funcs nv_asic_funcs =3D<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_disabled_bios =3D &a=
mp;nv_read_disabled_bios,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_bios_from_rom =3D &amp;nv_read_=
bios_from_rom,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_bios_from_rom =3D &amp;amdgpu_s=
oc15_read_bios_from_rom,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_register =3D &amp;nv=
_read_register,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D &amp;nv_asic_re=
set,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_method =3D &amp;nv_=
asic_reset_method,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 0fc1747e4a70..e5a1950fb862 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -375,39 +375,6 @@ static bool soc15_read_disabled_bios(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
-static bool soc15_read_bios_from_rom(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *bios, u32=
 length_bytes)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *dw_ptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 i, length_dw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rom_index_offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rom_data_offset;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bios =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (length_bytes =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* APU vbios image is part of sbios i=
mage */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dw_ptr =3D (u32 *)bios;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; length_dw =3D ALIGN(length_bytes, 4) =
/ 4;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rom_index_offset =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;smuio.funcs-&gt;get_rom_index_offset(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rom_data_offset =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;smuio.funcs-&gt;get_rom_data_offset(adev);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set rom index to 0 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(rom_index_offset, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* read out the rom data */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; length_dw; i++)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dw_ptr[i] =3D RREG32(rom_data_offset);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
-}<br>
-<br>
&nbsp;static struct soc15_allowed_register_entry soc15_allowed_read_registe=
rs[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, m=
mGRBM_STATUS)},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, m=
mGRBM_STATUS2)},<br>
@@ -925,7 +892,7 @@ static void soc15_pre_asic_init(struct amdgpu_device *a=
dev)<br>
&nbsp;static const struct amdgpu_asic_funcs soc15_asic_funcs =3D<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_disabled_bios =3D &a=
mp;soc15_read_disabled_bios,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_bios_from_rom =3D &amp;soc15_re=
ad_bios_from_rom,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_bios_from_rom =3D &amp;amdgpu_s=
oc15_read_bios_from_rom,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_register =3D &amp;so=
c15_read_register,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D &amp;soc15_asic=
_reset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_method =3D &amp;soc=
15_asic_reset_method,<br>
@@ -947,7 +914,7 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
=3D<br>
&nbsp;static const struct amdgpu_asic_funcs vega20_asic_funcs =3D<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_disabled_bios =3D &a=
mp;soc15_read_disabled_bios,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_bios_from_rom =3D &amp;soc15_re=
ad_bios_from_rom,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_bios_from_rom =3D &amp;amdgpu_s=
oc15_read_bios_from_rom,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_register =3D &amp;so=
c15_read_register,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D &amp;soc15_asic=
_reset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_method =3D &amp;soc=
15_asic_reset_method,<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB54735252E08C8C3BF086D184825A9CO6PR12MB5473namp_--
