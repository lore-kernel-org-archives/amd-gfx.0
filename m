Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5627C61DE2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 12:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1521F10E802;
	Mon, 31 Aug 2026 12:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IcyLG2a4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010004.outbound.protection.outlook.com
 [40.93.198.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17CFA10E802
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 12:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvCNKdN04wJk6HDCug5TGf4V8jKDyHVnqHLIoStkOunPNz1b1YcSywbTcIQo6JzAu47wYyj8hr7jlXs9EvnPDv6hKPjWuab6gyfxpVQRVHS1ZPYZ4BoSAswpLGFgUlNaxJ7GcqXIzmTeUFtGQWjLUE1iWvXmxyb5+IN9QtzB833yDblCq/K5ckoi3JgRtppSozUvDhqqTpwNV/M2WHze0/oG1apxcFk0lSo1czI/zf9zTZecE51+shvKNXQxBEFo4yebDXviNJwtV0eDTGF2uqmRvAlF/muwwb5fmNtHY0pI+TX+8gxAyy2o/NjDXeZEOI51zZdg3wHCH9WyYe2xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdpZJ43OWS9bOVmsOjHKzmolbbFD7fktuYTwgmuV4Ds=;
 b=Rw7Drbp62etadcPWk1J9wBtlZnAggefn7hAC8YlXW1+c6DnZmkOaPULWvjyosJE8pRPPA1qv4qhv178772AMmsJqn/xI5euOiYZJr7xo/CGOLlZyeGIxDbkO78M5N80fmXen/yctN4evasr+O1Jmru7/5twjGKlRTHliXYSzeagXrTpM+Nefh5d771GAbAKmxTXZes39cWimuatOIuXEIKui+P61FY453q6KXrULrkAP78xQZOFZIdpyOJux10Y/ZATd6mB/uHc6UsEyiRB18cw93xDD01YfGg1cmn6VcIBsvBuJRffgIRbB3FhqCx6zgeD4UNb0B7Nn4xdPX7zDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdpZJ43OWS9bOVmsOjHKzmolbbFD7fktuYTwgmuV4Ds=;
 b=IcyLG2a40fnQpMTE66RrwKWfh7fLtY7s8hjRc4qfn4UXY4Ne+HBJB4iLrFy3EBANfvp7J1HcQTj5idl4bcFiT81dVnHndcE4BmwqV7ph6gOjaMupBpgY0liaOeoiJLvGltrkP5ni/tC13tW4ep7vi9s6VV0Lx92MylRDVavrxD0=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by DM4PR12MB6327.namprd12.prod.outlook.com
 (2603:10b6:8:a2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:01:32 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::4c6e:70e3:2347:8cbf]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::4c6e:70e3:2347:8cbf%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:01:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Zhang, Horatio"
 <Hongkun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip IMU microcode request for GC 12.1
Thread-Topic: [PATCH] drm/amdgpu: skip IMU microcode request for GC 12.1
Thread-Index: AQHdOShkS3iNAOQKlEONc6nvQn7iIba4DccA
Date: Mon, 31 Aug 2026 12:01:31 +0000
Message-ID: <BN7PPFFF39339DD4F2C037469B49218FD43FCA92@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20260831090909.30544-1-hongkun.zhang@amd.com>
In-Reply-To: <20260831090909.30544-1-hongkun.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-31T11:58:33.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|DM4PR12MB6327:EE_
x-ms-office365-filtering-correlation-id: ed40a741-a3d9-49a3-b28f-08df075798b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: fKGsIewuz2ANr44SneNyUoqvTWkWG9/20hXatYMQ3r6eARJuSp9me+AIqIK3NxkKs4OL2ItJLWSyc1PSeiKJM/mi2x18FlogpIwB0+1jzASz3r9i4jYVsP72PbuLEr0uZwlwg431NE4UQAqkhm+u/AIsTDmv83P0kDybfVKL88S8T3BvVJUYUVyL5jsoM1MS01thRbRx4Ca7ixhMixcflHlUnnqHAXLmTRRwD1utfLaSKaXJDCzeKkqzuDBwhO4KURuISDOwaC51W6chTALPpdNCAGQ+kWhG399K5cFwmioL8L6O2fgCd0qClBQ7oF2ZnDalt4duzw7FV0b1fR9cr01X/KtQPTA9WGOGBfk0KevCRBX550Lf7tVpEVYoJmCi/W8BjQ37FCR+CMdDPLRvuf/DAXJF3GEhSjW44n1PZDlgjuaIaTf71uAPeLNngGKicEgBSeTzJPKVJmyQNNYzNMOIHWrctWsqdgciW/yFJqIko9tq9nY4wvwW6qsS+LQOfud9n5bOP28XyflCWzfVavt8a7CQOVPNmot4L2ToMM68Med03QXCygqTMdbUug2nHPW3wNFF3j4z5wTy+kIVZTcJPavGkDykWi6WwmJWk3lQEnJvvJ7aIftxK/5mVxvCrthwvscGdQiC+sdxmgBWjtqnRD0qx/hAH2uyqGFXhYGbUt+rS8m/+zDrfCaHf/Drh3D37yCJW/CwQjdPgBrHcb8KXOv/k/eLZWI7fn0YYK8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XQQiq2m2F28r7OgsVmbFfxOjRWLfrNkQbN+Nw+Ra7KxN8Xw/z6eGu7s1Z+X1?=
 =?us-ascii?Q?Ov9UzPNJQVf5D2/rivJ4FSNiwrrpwq6o+ylDulrWM6KL33jXndvGHi221LPG?=
 =?us-ascii?Q?Pph35ACCEEgoAUkTEwN77y+G+Y0JYn9svVHTH2rJ16g8RNgB2tt0WKZ3VNg6?=
 =?us-ascii?Q?lXLlcrpK11w9+8bF8RhxvB5RhsBH3ZokEAY29TglhA4NSbmKrEQ+ZpvLnpT7?=
 =?us-ascii?Q?2mif1K9JKkKmUpiubZx13iRRhvQdqKuU5uf4hHU6zAicCGWnN7Vy5c/ybL84?=
 =?us-ascii?Q?VHgJB2hMmIvlkeCsSQsn1SOxhh8kGUPL/eecDPS3rg5SxXYQX2yk5Opr26Wk?=
 =?us-ascii?Q?MHIhpM6iYGoQsDgzea/kz0Qwqd1DiMVWG100iGT7L3Y7mzzFiBYHEaiPkSNj?=
 =?us-ascii?Q?5xbKBUOg6sx8YniIE53jHg5f5YDH9uTgvxSxQeCEBua0sKgy+SCfrosFiqZy?=
 =?us-ascii?Q?eREJYe46Yv+oD/Jr4aNWu4V7XIkwDi7A4JH4JPUFi8xxNspXHu72Bep1xcLw?=
 =?us-ascii?Q?x+LqytcaqtouGllaJvcHn3y/b83QNGSlPIZBD5etVbQ23Csm1s8s1wCjvdZN?=
 =?us-ascii?Q?VeOoXgalz/NR5L7aS+ROw5Zy2AoMlkZpR9WDd6gl0sS/APCGUdZ9aiwFIQ1P?=
 =?us-ascii?Q?nC89KjUKPYDJPhwPSTsv3IbfEu5d00Yk2jR7L2gCO5GqMhPKBCoinUbIdI/9?=
 =?us-ascii?Q?mPBSbVvjRR6DdaPMSIKLU8SmKrcXdWQkxdKSMJ7yc7TnEsMKFhkikD77MYfz?=
 =?us-ascii?Q?ytQ3HvXJ0+WlkfVcZwdVuie0UQ7yZEo3HkVH4xvp7ZP/7LsEz0wZHsIa+xl6?=
 =?us-ascii?Q?pRS3AM/GXTVY/irm3dTtK2MiP6PmZmJmYPN60g4qm/ghNAwt61jP+8CEsWZi?=
 =?us-ascii?Q?3Qc081tjBAE5QTyYE6BrfyyKYVZoI42OiqK2b2OGvKDddVphgki65QRewVCQ?=
 =?us-ascii?Q?ujlYgK1x8J7g7HTf/g4pI6JTTT6tgOA6GmfxgfJP0udmTMvnHapHDhoTT2OU?=
 =?us-ascii?Q?qAnKN6JbMboEMv85y6vR5i/FCrxNSX3oVe1Gbwbs0plAoQypINBcv8Gvv4sj?=
 =?us-ascii?Q?gnAcUA71s1QlXDbNCp1qBUWn0T/5+SEIXICOhJ62Sh+KZ5y2aVY7ulygxOOu?=
 =?us-ascii?Q?yKJrGQxma2sV/xi71Z6LnmkLaqQ12P0zFWuiY5KqTceyxEpwKVfx0KplDqN/?=
 =?us-ascii?Q?s19Ti5VRKRNar7slJiVqO5YvxPGDc4cNZZJzKkvHIa6D7UyI/bSlqR4wb/Vq?=
 =?us-ascii?Q?i3+cPX97xExOGH5VdLsor3MjfReXmzn40Z2Q6KnY3S3K7J/tH4JXARxU9Mi0?=
 =?us-ascii?Q?FJDhCA4dsZnaIde7ZO9Q7tXs5scXIc7Y1VO0KLc0Lmq75rdYbx03bRQ7QNHl?=
 =?us-ascii?Q?P3Vao5ZFQR327x5GN8yRMijTA2KPdg6//vUsL5oM2a3g9RSGikTrVG0uzJyj?=
 =?us-ascii?Q?JmOYbH7MKEiigziNOExcp0//Dl2HnPgc1d6ChRlmXee/UiZw8bHg76rWS9lu?=
 =?us-ascii?Q?1f7pc0W+Z1MKSmQoAqWuMuNYsrRuBxsY+nZYVF28L4keoxu6qO0wrCdqOQgK?=
 =?us-ascii?Q?m6fplvXvusN9/PLd4tccmZoPVNTORoK2jXh49GwrAsGsDfVI67Ki34lhtKFu?=
 =?us-ascii?Q?xERsI7YZjDcPZz4pluPqD0IUQKQSJbqsg5R7iDWSUhU3ZLhUxWYwiSsgGLMe?=
 =?us-ascii?Q?itgOIDhbaej8qo3bSJZCZj2PfvU3kwbVtPVk+/TAiJsmZ8G7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed40a741-a3d9-49a3-b28f-08df075798b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 12:01:31.5121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pE+cDXwlndSK5Jc/rRhiibLde01/tAwR8cv5zmo6IIO7jSmFibz8hkVcEof7UoA92V3UI3eudTjx8/bgJN6g1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
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

Feel free to remove MODULE_FIRMWARE("amdgpu/gc_12_1_0_imu.bin");

With that fixed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Horatio Zhang <hongkun.zhang@amd.com>
Sent: Monday, August 31, 2026 5:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.=
com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: skip IMU microcode request for GC 12.1

vBIOS has the support of IMU firmware. Requesting it now fails and aborts G=
PU init:

  amdgpu 0001:01:00.0: early_init of IP block <gfx_v12_1> failed -19
  amdgpu 0001:01:00.0: Fatal error during GPU init

Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c
index 82ac39239d78..db06360873eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -581,7 +581,8 @@ static int gfx_v12_1_init_microcode(struct amdgpu_devic=
e *adev)
        adev->gfx.mec2_fw =3D NULL;

        if (adev->gfx.imu.funcs) {
-               if (adev->gfx.imu.funcs->init_microcode) {
+               if (adev->gfx.imu.funcs->init_microcode &&
+                   adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
                        err =3D adev->gfx.imu.funcs->init_microcode(adev);
                        if (err)
                                dev_err(adev->dev, "Failed to load imu firm=
ware!\n");
--
2.43.0

