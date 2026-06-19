Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B41CD98F2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 14:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7228C10E0D7;
	Fri, 19 Jun 2026 14:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EIes5a90";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2799C10E0D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 14:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otpjMOZ02YWIqGaK3FUWto+5jEZiJujCHdCdd1JoJopAx3wPNdLlVhSTa8V+u/ILFY99Op7+CnZoO6gI1K0atk53PCUgBOCRAs+RVfoMAfmAp5SpVZoT2Clqq7VGE/4qWuhEiu/aBbygOnNm1saiGEX4+jzqkvgFiADNsjPHZZOckgLPbpZQRfCEhAj1Kd2BEn666qheL7/EQD/x9+nSuHBdChQqx5YnfnRrLttI5mtm9gCjdxb5QV19eqGakxs2du+TEtvKgWp0RV8mCp2xEhJ8aSQWM+o5+1YDm1jbAUOA5DbmsiTnCW1UdAHnhzs0mKQrmipONavSMCLp1k5jPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0CcOz/ifD080rJjA55Ktnoiz4Hq2dh6KUfj+nTGydY=;
 b=LOMJaC9AfCQY+z4t3pJ6/QLNolGYsq4ntaF0BYZTp62C9+W4fSMRtfg7KJqBLe0cwayaovAJxUWTdx6uATUy2wkbkpvbc9a6BvLZjX4NajdHkLJCqRuSkKd7ltf/Gv1JxKGlq90yuG1yHAMuHq86Pp9gxNP7HBl4U1okYpPwwb+r1u6JWYeC3rRfZKviJqD4aAVD7gc0NQUUFTr0QDGIwu7nYM9+pp/CU44lHn3iwitjEqTgsMIYTggQeCRYQBVSopvg3asMf1S/2OaXgvaWOQ0DRX6x3MMeQ9Ku1X3qsqTPyn+TGMPL9PDNCm57JVG3fl7FlXNHvtPonzwue40JeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0CcOz/ifD080rJjA55Ktnoiz4Hq2dh6KUfj+nTGydY=;
 b=EIes5a90Gb58QLGYKsbAIElIUb7T9paCbioyiflBOx3YWKY1ouzWgsBfeUkNoloAJEg6eukFJ9DDNdPMFpx4W/LS+oNZN+C7jixpmD/yDVCPgKZ8OYgpsMXPyY2aw2fumj7eub5vGB0ZLIwSjMioDCxHOwrsMYVK1OAx4OQCvm4=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 14:07:08 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 14:07:08 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: bounds check ATOM IIO table parsing
Thread-Topic: [PATCH v2] drm/amdgpu: bounds check ATOM IIO table parsing
Thread-Index: AQHc/+4nyvmzH2u7g0mEBYRcw42sUbZF6fFA
Date: Fri, 19 Jun 2026 14:07:08 +0000
Message-ID: <DM4PR12MB5038396C101BEE745C1413188EE22@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260619131821.1173080-1-lijo.lazar@amd.com>
In-Reply-To: <20260619131821.1173080-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-19T14:07:02.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|SN7PR12MB6929:EE_
x-ms-office365-filtering-correlation-id: eb0ee8cc-7ba9-419b-4240-08dece0c0cc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|18002099003|22082099003|11063799006|6133799003|56012099006;
x-microsoft-antispam-message-info: lRa2VLUmCpXnGOm41QXo8HdV4n/36gb33/npM2CDd4hGIplSHGJkcBi0dQbZkg7Zor4FAdFFYiZzZ5tGVEsYK18DQhViBjhU5xpa2LRozHTfJD1UH2IczUAqS7/Zm4FITLPECFk8UsXkqfxaS/JNtbQ7K7927khgncBEgs+8iOt8tLzGYqY17vGkzhzlym+++bPC5Rk7YeVjgIcNqq0Vmmjyta2KHgpA4c6qSDrxC5L8MNGp9/glTikC9ZBHHdZ1K+FVlTVrZRgZeHtpxJQWUNIhCPjQVF6YqWaKGxkCkkVVOgcrTUbPdbRuN35lSoToUL47BXWYaucY2LStRoZmn/2i0d6u3BhRY4D5vn5FJi3pkKLBW4BuaNlSSactlRj3v1zrCN8dUFnBGc3mxnrqtMyMtZnqBHXVQZGak990f4XOAE6UMbPB1t8ot3aQEalYn7rR2g+RWY7SB9OE1ybr/g4M2M2nJUja0hTX6/3DGswj96XeeqkESNPs3OwKQMp8E4CvitHt2ftm+D2VBQ2xD/3hkndcvdEc8ij2RYsulAZwBCVRUtFP4Me6IxOP6OdJct1bxO8E5PWzSACEFGhaiN8W25BzZ0SwIodvgdem3Ux5Trv25SNOLF/nlX+4N9UgpyLDFkQWJy2QUx857zJaxxeJO8FvziMLLBiUMDChrDvBERvoxrKNKE4EssRewyJbKb4AIHDd9mFWl4p5qe4W64IGF5MZeNjtp4QuZCSpMaU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l/FRWJNwrutKt7RMtXzeUY2p7CVcSdE88dviEFOaNadwVGA4McLchr60lXuW?=
 =?us-ascii?Q?eq7AL1lD3NcdmeXJllnB3nDibeUREHwQODfGne0bJ9dcrFQiUd037jU0qCTH?=
 =?us-ascii?Q?HzICoy/2ZtXIUWyCHG0fF4gN3Gp3l2jmwuxyEJsMW1wj+TgaopB8VzhP3uyd?=
 =?us-ascii?Q?PddvB4TKelGyZu3b/bEC9c8ah4k2xu0ndfVk00Wc048q6q1oRlsrYNQkAIbh?=
 =?us-ascii?Q?XvYFN+Tym9LuB7Gc0GGXD2ju0iysXheFppLV/hDrRk8WGRSpbxoek/DOP9/w?=
 =?us-ascii?Q?WEPWc0aeZAOL4sLmTW7ikf7ykwkJmxG8HUHuZT9UjlvSgqflU99cX7bFqgeg?=
 =?us-ascii?Q?ywxy1LQmAJRtcB7N0gGhDDD0A/WKcHJyeNCq3CGYtPgreHBLe4/0B1GGHadA?=
 =?us-ascii?Q?29S3nU/GU9GiNYxBlYMm5jaA8r/LdKFXuaNrvWhWFWVU9w+Stg0j2BQp3YC8?=
 =?us-ascii?Q?7a5+UW0p3gZH91nSuTRzXJTvYyrrvLUHpe5j2zc4FECg9WBa0D9UJlNBpD/Y?=
 =?us-ascii?Q?Yk2a+7T2LNLYdQScsfWGxaRvEvaUbztZdEvtlRJfu0flJ9cmT+YtlOPEwDUX?=
 =?us-ascii?Q?HeZzutK9OJbO7nbscDXaVyH/LbTPTW7nzZuZCS4m4UNbxVYzHbNUSy6Q57X3?=
 =?us-ascii?Q?K9zqu+IghJH9n86pTvRUDdh2744z5zxRILS0PTRA3vYtAHfhue+UCebk/pfH?=
 =?us-ascii?Q?XeECGGTIK+N1BmHbRmzi4lKXDtmC9n1jgqeT0FA+bfSvkBUoznZwR5EBQ39Y?=
 =?us-ascii?Q?8LzMmVHQvjCmRK4SeYP5ebrjjlrbDnzXqT+zfk2Js39arPRx6UiPGkEfGO1X?=
 =?us-ascii?Q?6zyULtCrfQd6D5e2iRRcV4VQQGwVT1PUO9Og1EfpHhcR33aF5w7r28BvE6mp?=
 =?us-ascii?Q?gyZl/umF6+c/e6s8eWD5hjhxTXFAmHilqbw3VKlFf7kjpQS2m/NmKMjROV/5?=
 =?us-ascii?Q?nXaOQ0wvH2Vu0h1O+UxMBQ1aZ2WJVDsZfyscqV06iJBm9yvALwCtLssEQfn7?=
 =?us-ascii?Q?RATDRXO9HhYslUCrtPxq5AcEkhr2AQbnmFXYyMWGvcHBjShDLHuGDRgEZGdk?=
 =?us-ascii?Q?+dqSEiUwmsKxof+dhMoNTelIfwqWbZHqLjcwTIU8uGBfc1YqHNYWkYuzqOxP?=
 =?us-ascii?Q?4WI47LZwMnzgsMhKfKBH2gn7WC9OOfGgEOCRBx7+fJhfSxrHA+ukoTvEeh+F?=
 =?us-ascii?Q?5OfFeWw8jNzRj7ZivjMvpOwbnkvM15U2Tnx7+iEvf87I+xGJ8MYjGvcqIZWC?=
 =?us-ascii?Q?tsm0RdWtMfw5COSin91ABpWpzzPpjH6bKdktTddHfI1nJztTEd45YZECGg6N?=
 =?us-ascii?Q?yoCHBsOOipK1R5PZyUBG7hzsz4PMAgpDhnLEyjdm/SBz3A2BZvZraT+LPnXw?=
 =?us-ascii?Q?c80luFOIzL8xkr9xH7mY2EfDrzSc0LH5liAF3Pxe5HdGCq+CEwRC/OnDdko+?=
 =?us-ascii?Q?2eJHD7ydrP7WEbOT+5GLlR9U2+ucV47Cb5LgwGJ/+AmDd961EZibd4opNy+v?=
 =?us-ascii?Q?HXLDR/TNEXdNvCQ9Old50JEkrzv4uBBdnPu+X2tlfU8y8oJ0oSER1O45sS/n?=
 =?us-ascii?Q?weQBWkTDAMgKwBZLVaZZwqHl8T1tV9Y8TBDM9DzQCSla7G+eume66H8kt6ha?=
 =?us-ascii?Q?v60pluTRsT/8Fs+U4+q5dnbF1Rzl2A6WhIHtWijTb4B5F15Ej8RDb4a5ApBq?=
 =?us-ascii?Q?8wk+gCdlYLjDiHy+vDxoqzptC4U72DfDygbhLJMURTOyguho?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0ee8cc-7ba9-419b-4240-08dece0c0cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 14:07:08.1745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HoGkpl3rIQ0WiRlvYd699xEI67V4ZErILcolNX1Kg/FtfZj4pdnbsEsXH5UwDmnVwXgyFb1YW+GldzjuTdmnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, June 19, 2026 6:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Li, Candice <Candice.Li@=
amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Deucher=
, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: bounds check ATOM IIO table parsing

atom_index_iio() parsed the IIO bytecode without bounds checks, allowing ou=
t-of-bounds reads on a malformed VBIOS. Pass the BIOS size into
amdgpu_atom_parse() and bound the parse loops by it.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Code
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
v2: check bios size also before indexing offset (Asad)

 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c            | 25 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/atom.h            |  3 ++-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_atombios.c
index ca65e6ebdb25..a0c740bce310 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1923,7 +1923,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
        atom_card_info->pll_read =3D cail_pll_read;
        atom_card_info->pll_write =3D cail_pll_write;

-       adev->mode_info.atom_context =3D amdgpu_atom_parse(atom_card_info, =
adev->bios);
+       adev->mode_info.atom_context =3D amdgpu_atom_parse(atom_card_info,
+adev->bios, adev->bios_size);
        if (!adev->mode_info.atom_context) {
                amdgpu_atombios_fini(adev);
                return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c
index a40ce7555f28..0d5be1795972 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1327,11 +1327,25 @@ static void atom_index_iio(struct atom_context *ctx=
, int base)
        ctx->iio =3D kzalloc(2 * 256, GFP_KERNEL);
        if (!ctx->iio)
                return;
-       while (CU8(base) =3D=3D ATOM_IIO_START) {
-               ctx->iio[CU8(base + 1)] =3D base + 2;
+       while (base + 1 < ctx->bios_size && CU8(base) =3D=3D ATOM_IIO_START=
) {
+               uint8_t index =3D CU8(base + 1);
+               int start =3D base + 2;
                base +=3D 2;
-               while (CU8(base) !=3D ATOM_IIO_END)
-                       base +=3D atom_iio_len[CU8(base)];
+               while (base < ctx->bios_size && CU8(base) !=3D ATOM_IIO_END=
) {
+                       uint8_t op =3D CU8(base);
+
+                       /*
+                        * Unknown opcode: its length is unknown so the byt=
e
+                        * stream cannot be resynced reliably.
+                        */
+                       if (op >=3D ARRAY_SIZE(atom_iio_len))
+                               return;
+                       base +=3D atom_iio_len[op];
+               }
+               if (base >=3D ctx->bios_size)
+                       return;
+               /* Only index well-formed methods, others stay 0 */
+               ctx->iio[index] =3D start;
                base +=3D 3;
        }
 }
@@ -1553,7 +1567,7 @@ static inline void atom_print_vbios_info(struct atom_=
context *ctx)
                drm_info(ctx->card->dev, "ATOM BIOS: %s\n", vbios_info);  }

-struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
+struct atom_context *amdgpu_atom_parse(struct card_info *card, void
+*bios, uint32_t bios_size)
 {
        int base;
        struct atom_context *ctx =3D
@@ -1567,6 +1581,7 @@ struct atom_context *amdgpu_atom_parse(struct card_in=
fo *card, void *bios)

        ctx->card =3D card;
        ctx->bios =3D bios;
+       ctx->bios_size =3D bios_size;

        if (CU16(0) !=3D ATOM_BIOS_MAGIC) {
                pr_info("Invalid BIOS magic\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu=
/atom.h
index bb3d9eb7eb6b..4687c019cbe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -133,6 +133,7 @@ struct atom_context {
        struct card_info *card;
        struct mutex mutex;
        void *bios;
+       uint32_t bios_size;
        uint32_t cmd_table, data_table;
        uint16_t *iio;

@@ -160,7 +161,7 @@ struct atom_context {

 extern int amdgpu_atom_debug;

-struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)=
;
+struct atom_context *amdgpu_atom_parse(struct card_info *card, void
+*bios, uint32_t bios_size);
 int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_=
t *params, int params_size);  int amdgpu_atom_asic_init(struct atom_context=
 *ctx);  void amdgpu_atom_destroy(struct atom_context *ctx);
--
2.49.0

