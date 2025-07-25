Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCA3C87FD1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 07:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25C610E44C;
	Fri, 25 Jul 2025 07:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pKj4JU3N";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400BE10E3EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 02:25:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJX6qGM5JLtT32rSbuQlYtdRn9PGVFtjm8Il72Jgkuw0PC5DViB44dA6yBfRsP3tlXzL8MhZVKMQKcxq54dCtaMWoY6oJpdmcbNCFx5aPMPpD/lHGfGuExvzP0cNgQ9D8JP9wREJx69jO/uSSDpbKf4b6iPiwRnKLosErSOdFHlDBXvuwAoBcfaKXQ8wT+9ZKoLYs/TxSVwRNpWMLFRExrdeaEuyJCZSem511jgpLM3KCi8jNQS5k98k9j0CPZYlH8mp9uvhGD/d+KGEddl/4PnBk7pnsn8dhSxJYwBVEWJwwysMjNxxTGsUsBT1ifIm899l2BjWxzJgV/rLGJdU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypDUOREIwP3h6wNSp5gBEiWpIMM7L5jpBk22p7CIGrI=;
 b=bPJaHzNEjM87y7s7fj5IDpwU9Y7HEwk0Ql7HtSsN9cov+PsTvjFm+9kv5jauoIG5H8k1XM4LZJfeyTGCuuCPATyjZg0cCehYZVZZOxfVVID1jkGvoMunQggB7x8gdhcRhsTvcHUPSEJ13tJuhcitGbVktyJ40KAAAQ1f/bWk9OdH5FVHc8N34077Iy1MOWY2WZQxuOoUNJ7YN427aPTAjI8xeC4iyZ0KDHg0XYH8X45e1xvB/l/2+VOc7Ggwvd0mLoHta55xYuQCaQIytpjfc4iHBa/nt8qKH3/TfxRjMtnpp8bqAj/j13rIARFclvQtlBxRuuCBkauMkyQMttb+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypDUOREIwP3h6wNSp5gBEiWpIMM7L5jpBk22p7CIGrI=;
 b=pKj4JU3NKa19S72XcaasSKZ5xgt5pOsz1vy2GFqZcmgB7li3DTC1nCfaMCB9jlzzHQRi9tvvi3hs7wcF3Vp+qoMtGk/usmh5KooTrDYCdvC1tzWvhsmr5oOX+RIsfNGZ12VUBJ5eis4bSEg80rFRinj91XGNejim/yiO4b8xv/U=
Received: from PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 02:25:26 +0000
Received: from PH7PR12MB6934.namprd12.prod.outlook.com
 ([fe80::81c:7e78:f745:d2b4]) by PH7PR12MB6934.namprd12.prod.outlook.com
 ([fe80::81c:7e78:f745:d2b4%4]) with mapi id 15.20.8901.024; Fri, 25 Jul 2025
 02:25:26 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: brahma_sw_dev <brahma_sw_dev@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Gui, Jack"
 <Jack.Gui@amd.com>
Subject: [PATCH] drm/amdgpu: add kicker fws loading for gfx12/smu14/psp14
Thread-Topic: [PATCH] drm/amdgpu: add kicker fws loading for gfx12/smu14/psp14
Thread-Index: AQHb7KDtSJpmtK+KvE+NPl/aLYAV0bQhf1WQgCC96FA=
Date: Fri, 25 Jul 2025 02:25:26 +0000
Message-ID: <PH7PR12MB693439C86AAB18BC5B49B7A3E959A@PH7PR12MB6934.namprd12.prod.outlook.com>
References: <20250704050043.5631-1-Frank.Min@amd.com>
 <SN7PR12MB6932C1DC44F417E46ADBB1E7E942A@SN7PR12MB6932.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB6932C1DC44F417E46ADBB1E7E942A@SN7PR12MB6932.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-04T06:24:28.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6934:EE_|DS7PR12MB6239:EE_
x-ms-office365-filtering-correlation-id: c8ebc1fa-5012-4fd3-8acd-08ddcb22845d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yEO6+iGW0ICZyRajSkUtawIk5W2wQ6skZmqQwXKkaFMCFkmWRnsoyN3jdYxi?=
 =?us-ascii?Q?P2yyvzVaZoWWnLnUOxKwpabPISlSEXAiqkgvHLaKRgNbVVghi60UJFUFsqkm?=
 =?us-ascii?Q?KSSvThtHVqh3x86fdutt+AeTZXVZUTt75bkDxk9XldyzaM7Nlhey0bgaVcQd?=
 =?us-ascii?Q?cwFq8/9lzG8XIPrVaLdl/okb3m1uwY+teBfvqWt9gdb2Md6sdyR0zuX6WbsC?=
 =?us-ascii?Q?vUARUsMNy36dtFvnC+MQHCtk9MZegXpH91XAgf9lVBmfD1w78nrOk1jn/ltB?=
 =?us-ascii?Q?jOeOHG4EScb10qqUPKIFiz2gamckyXKn7j9aQ5KwH18x7EwdWmCWwnqHl49n?=
 =?us-ascii?Q?dcAqZDWYNrJnScaCo9FQNcp0p2801k2YzEFOg0y2FolFWnQaYJtip+WXGjsE?=
 =?us-ascii?Q?fQdt3r/Q+3d9JTM+ker9qqrzcsins1mIzNrLtH+cvz3Ix6SZEsZ3minhO1Vz?=
 =?us-ascii?Q?xzpAvA4c4f/Fz0JODbgFUAKqjlhUKkyDP9u+XQSoRbb37yRn+NRQqdvueQ+K?=
 =?us-ascii?Q?v9IP8EGH0j3acUIPxNUnjwsgRI2gtLiqII9EQqc3jApAwsu2kYN6OKcVVr9G?=
 =?us-ascii?Q?Sye6RKji6GvkeUpn6uqlwbtERMZVir07FMh4j9bUhE1+JxIffu7spy4YvhvY?=
 =?us-ascii?Q?1pgloc5WTxgSnZTgC6F4MiaCrnpnKYhukIh2gq6+/PpgESEUop3dwyF5Zk5s?=
 =?us-ascii?Q?gz4RdPMMNEWhN4nJgzmEEJj5gddP0oDNBSt8CThLCMUAl5DxsrcY5Xla/sNe?=
 =?us-ascii?Q?o3EByTJbmRJPy+jkRvv5zWU2TiXnAhHTrx+ZCgcKO8iSBtJG3BMzvRWOkh40?=
 =?us-ascii?Q?DiAJYhWTi9v24KIbP3rGYP3tW7u8o1SIpPeTPZSgHEmijx32l/2XLuIegSCo?=
 =?us-ascii?Q?pBsIj+u3QgBs9kFsdHVWUd4RFWoh7x0x215JU8Wj32gHqhH9B4aQ3NNnsqE1?=
 =?us-ascii?Q?FvzAqayFj+Yh0cfHRxw7gQQvinqxOvv/zh7BrE2YZwO3eIrv/7CMp2klDPMA?=
 =?us-ascii?Q?7dgVzpQ0zaTsf8aii+gMtZddwpuxvvKrwaIAeoRCQYE3Ei6SVwoiCcPgvb/x?=
 =?us-ascii?Q?6uMLLxpPcMXEgxLQ/1Jjmizy6PfE1fYDBrgZNz6pAEIbR5RDZ6Hbilf8YGUm?=
 =?us-ascii?Q?j0sKq+qKicklF4UGdMHlr8DnhLZWWbHodbHp8WzXIkqe0rCrJD6yFjrNYmg6?=
 =?us-ascii?Q?oKVd3EXTR/5Ta1FIj3F94PUahEnGDoLD6rnY9fp+nj2JUcsLANzjv8VSfZO2?=
 =?us-ascii?Q?FgO6QIcLGsTRk3nf+23Yg5kDGZ2+TUOaoFbXr0nHXasl3dJDmwxnQVsMwaIf?=
 =?us-ascii?Q?33DFw+Rv6HUpHKbUQFVClQy1a4p8XDLTW/d6Gk+NpWaTdBq/XE0N+9kn01L2?=
 =?us-ascii?Q?5K4CDYPoltqZFfP0cULdTcbW/ByLkpJBTrFxFFZkP+Nc0q0SgsGNYHb5/kwu?=
 =?us-ascii?Q?EJtDslQGFptCBHW4oQULq+JhN2/OAieWCffQ4ukHjjMIl2SvnokZFg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6934.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u7/DHfOjlCP0lstMqseMAq9iNqbn/niTGegRqAGlHeC2lmm1qkvkHJHvNkhq?=
 =?us-ascii?Q?Oo1RAtF0B6Tl0LEiIrNLWHejvdg6u8NwWUXE5IUZao2Ovsz3OQWdEJOtrGM3?=
 =?us-ascii?Q?a0dFxECJcUZ1nj2uRXotamIfs9AkBd6SVLOIxYzQy1yZNFSAh9RRpn+0BJYN?=
 =?us-ascii?Q?Xk8e3KhfhLDOEPIv4UZDoqF/SzYM+Yu/VCW2u/Ew0axf5iKnPDl4S8jOrzw9?=
 =?us-ascii?Q?za6TY7lMjc8N/QlG9dTiDmk4Dgzs5eaaW5bGOboSsTHn+ymwGq5cCP8L5YvI?=
 =?us-ascii?Q?k4MGYrnZ2EhXJ+/7Bqwsa2zRd0MFxTh1RKcl4lKk2Vjgez44VXEADSPJMMv6?=
 =?us-ascii?Q?Vlgcsk1uGiOPXIV06SrikwoIp4+8uKPyZBaCh5lVlTJDAN6Jq3c+kf/GO7fF?=
 =?us-ascii?Q?fy04rWX0vfb/1rRQvU27qYp7XeIUYRdWCO/ggpciwY3zLfcJe0veqOGMABq1?=
 =?us-ascii?Q?Lkq2LvkLzzorYRIi4h08rutDYEt4WEM3f/EzuBJywKQMw9h7BpcLKiFW84o+?=
 =?us-ascii?Q?RHkMwivvlHxHgyPYHtCF4so40kACPxZh1mqz4jf78BN4wtSCP1yBBfEMojrJ?=
 =?us-ascii?Q?tV9XZdAW7Gz2FVwWY2H0um094QxyOTU7sRoFrPogz310Ut+NX/Y05A0oJEUM?=
 =?us-ascii?Q?8WJLF6pDdKwPe0+Pn1recNnuY2ZT3MO7eNpz+qS+vCjceBmthnUzQF5Q/BxI?=
 =?us-ascii?Q?OH2/8DlhgWhYRWTisc0pdx21lrr5vx0S2PdmFk/exrMqqb/6KDVG9RuO3bv6?=
 =?us-ascii?Q?/l3VbB3gAZtenjws4Ta5en8WybgmXeTQ9wd3y3aAGRP0GnjaeohutLfqP1LI?=
 =?us-ascii?Q?i3i+fEss//tDmg1WMy+iaJrGY5zC9BHv80KLGD0wU29nYs4pVEQSjOYoYuFW?=
 =?us-ascii?Q?gsy2hET/w0ugs3sYbsJEyCjQbXv7RUf4AFpZU4ZkequmKFNuo3CiZB2PSCyT?=
 =?us-ascii?Q?fIggbaq0tjYosmMWF0ul2Go9fMTweF8gKTKK3qYPsdW21IPr578ev5mSiJ0K?=
 =?us-ascii?Q?A8i8DMioQxnckxpaGhxz3iAHT6G3+GGEPAaa+HdsI1d290V5uQXO0ierB1Ik?=
 =?us-ascii?Q?JQM2kE9XlFJ6A3uI7zM6++C0XgXFHCV7ZH3501/jooDvJowUwvwu/ANbfBw8?=
 =?us-ascii?Q?XgFg6jw++1O3XSx1OFqatwNy5rde8J6CF6TPSfHRUBDW6e7uDJhZqmJXd2cC?=
 =?us-ascii?Q?FfhfBVME20lYVe1tofE0+Cp9E74HAZex51Cqb4yDw8Ba5FDl0ttREJj7HTYg?=
 =?us-ascii?Q?GpOVO4mZkrB4TMcLS+VXis9XtJuxcJK3TFT69TSMykGWGf7Tj1TQaOGBiFuY?=
 =?us-ascii?Q?quB3XVtsBbuPmtJ+xYkGKf4YBUEmzsKEc93Pp3FlaDSADUJJlg5V9UXZbNgc?=
 =?us-ascii?Q?159qvtmvaU2H6cPHDDu0LKmZbfML5jGkYDd+cI7nKvCFwNm8VxcGTlAljO85?=
 =?us-ascii?Q?tFwpDdsTgXqTrJ/lKqPGL99EcKhm2SNRQ/I+rbwS8UQ2En3pVCS6S6kmmGFE?=
 =?us-ascii?Q?3ZCMZgsZ4aArclIgXoMmYqHozgnKn1dL3zgCiUaNWY23Ciw6rTznYJmdvDla?=
 =?us-ascii?Q?fY8knbSz/I/XzKDCI/E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6934.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ebc1fa-5012-4fd3-8acd-08ddcb22845d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 02:25:26.5972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikZ0cB3AL08tz0PPaYHomSmT0kwfzlMlG48jW72vY0TaWvARXzx2+A5zENZXzR74
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
X-Mailman-Approved-At: Fri, 25 Jul 2025 07:24:45 +0000
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

From: Frank Min <Frank.Min@amd.com>

1. Add kicker firmwares loading for gfx12/smu14/psp14

2. Register additional MODULE_FIRMWARE entries for kicker fws
   - gc_12_0_1_rlc_kicker.bin
   - gc_12_0_1_imu_kicker.bin
   - psp_14_0_3_sos_kicker.bin
   - psp_14_0_3_ta_kicker.bin
   - smu_14_0_3_kicker.bin

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         | 14 ++++++++++----
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c         | 11 ++++++++---
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c         |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 11 ++++++++---
 5 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index a0b50a8ac9c4..e96f24e9ad57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -32,6 +32,7 @@

 static const struct kicker_device kicker_device_list[] =3D {
        {0x744B, 0x00},
+       {0x7551, 0xC8}
 };

 static void amdgpu_ucode_print_common_hdr(const struct common_firmware_hea=
der *hdr) diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu=
/drm/amd/amdgpu/gfx_v12_0.c
index e4fc42470cf3..de77674df7aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -79,6 +79,7 @@ MODULE_FIRMWARE("amdgpu/gc_12_0_1_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_12_0_1_rlc_kicker.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_toc.bin");

 static const struct amdgpu_hwip_reg_entry gc_reg_list_12_0[] =3D { @@ -586=
,7 +587,7 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu_device *=
adev, const char *

 static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)  {
-       char ucode_prefix[15];
+       char ucode_prefix[30];
        int err;
        const struct rlc_firmware_header_v2_0 *rlc_hdr;
        uint16_t version_major;
@@ -613,9 +614,14 @@ static int gfx_v12_0_init_microcode(struct amdgpu_devi=
ce *adev)
        amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_ME_P0_ST=
ACK);

        if (!amdgpu_sriov_vf(adev)) {
-               err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
-                                          AMDGPU_UCODE_REQUIRED,
-                                          "amdgpu/%s_rlc.bin", ucode_prefi=
x);
+               if(amdgpu_is_kicker_fw(adev))
+                       err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_f=
w,
+                                                  AMDGPU_UCODE_REQUIRED,
+                                                  "amdgpu/%s_rlc_kicker.bi=
n", ucode_prefix);
+               else
+                       err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_f=
w,
+                                                  AMDGPU_UCODE_REQUIRED,
+                                                  "amdgpu/%s_rlc.bin", uco=
de_prefix);
                if (err)
                        goto out;
                rlc_hdr =3D (const struct rlc_firmware_header_v2_0 *)adev->=
gfx.rlc_fw->data; diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/dri=
vers/gpu/drm/amd/amdgpu/imu_v12_0.c
index df898dbb746e..d9a05d1c60ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -34,12 +34,13 @@

 MODULE_FIRMWARE("amdgpu/gc_12_0_0_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_12_0_1_imu_kicker.bin");

 #define TRANSFER_RAM_MASK      0x001c0000

 static int imu_v12_0_init_microcode(struct amdgpu_device *adev)  {
-       char ucode_prefix[15];
+       char ucode_prefix[30];
        int err;
        const struct imu_firmware_header_v1_0 *imu_hdr;
        struct amdgpu_firmware_info *info =3D NULL; @@ -47,8 +48,12 @@ stat=
ic int imu_v12_0_init_microcode(struct amdgpu_device *adev)
        DRM_DEBUG("\n");

        amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(=
ucode_prefix));
-       err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_=
REQUIRED,
-                                  "amdgpu/%s_imu.bin", ucode_prefix);
+       if (amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_imu_kicker.bin", ucod=
e_prefix);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_imu.bin", ucode_prefi=
x);
        if (err)
                goto out;

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v14_0.c
index 36ef4a72ad1d..38dfc5c19f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -34,7 +34,9 @@
 MODULE_FIRMWARE("amdgpu/psp_14_0_2_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_2_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_3_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_3_sos_kicker.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_3_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_3_ta_kicker.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_5_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_5_ta.bin");

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 76c1adda83db..f9b0938c57ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -62,13 +62,14 @@ const int decoded_link_width[8] =3D {0, 1, 2, 4, 8, 12,=
 16, 32};

 MODULE_FIRMWARE("amdgpu/smu_14_0_2.bin");
 MODULE_FIRMWARE("amdgpu/smu_14_0_3.bin");
+MODULE_FIRMWARE("amdgpu/smu_14_0_3_kicker.bin");

 #define ENABLE_IMU_ARG_GFXOFF_ENABLE           1

 int smu_v14_0_init_microcode(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
-       char ucode_prefix[15];
+       char ucode_prefix[30];
        int err =3D 0;
        const struct smc_firmware_header_v1_0 *hdr;
        const struct common_firmware_header *header; @@ -79,8 +80,12 @@ int=
 smu_v14_0_init_microcode(struct smu_context *smu)
                return 0;

        amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof=
(ucode_prefix));
-       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUI=
RED,
-                                  "amdgpu/%s.bin", ucode_prefix);
+       if (amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCO=
DE_REQUIRED,
+                                          "amdgpu/%s_kicker.bin", ucode_pr=
efix);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCO=
DE_REQUIRED,
+                                          "amdgpu/%s.bin", ucode_prefix);
        if (err)
                goto out;

--
2.43.0

