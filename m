Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02004C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 06:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC10510E144;
	Tue, 30 Jul 2024 06:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="27SI1pGY";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 012A210E144
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 06:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMKdVmGEU20pTImgPIW2O075T5kdHZQ2Ffz/lkggza/XPb8/oX/21STjf6Nwr9v5HNJLGYZ9eW07a2hCgGilEcqtlDjPv3smS6TZTH0PvArohzm9PsIe/cy0jU2+ES4Y8WRok3/E2Y8M0ow4027eVW46icXSjamg58VYXLH3RGdd+ZwwAPQkJLCcILSu/Yw/kW8d/1Dz27GNRuAQ9KZHDK2QzJ7cLd7czi5ObcOJg80b3DFpbpm3H+PnSS4uT/D8FrpfpFmVpqpxz76qV3YEcUF78hJdP0HBrBd0RaxJoUGpQ3MdcMBZtHVDZEfz9Bom5/uDEtgqNoVSuXFhSNQB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74JmnGlnhBrh56aPXfVfOZcwSeMOe/uC8x2cc0hDqog=;
 b=R/eDhc2vn9qBvyC4xg2OfrUiHQhUzDYrgZaj6NPKwnWcEnTmwwPrwyAvMtB8yubC/NIgz0pzXIH6HCjmQY2ooIyttfRrNqLGWyvWyZBZESje/y8PQCQSI+uWU8oqv3IE47/dC/S8HEwietJTBrNGtVncJKMAdyC1No0Y8R7IH2C9IlCyddYNVnLUqkdwPWLkVBL5FxK0jUox9NZKJzvw+0yVPpW16SnBaWRLLK9zcm7ZO/qy15z9XafT+A2OaTPYR66h0mF9s4uslRzHHnVl8XGjjnPOenY7s2JHFsCfzCzY8n9SGBmH7L/EKpUz88uK0CQDMoZVp1RyDxx8N/W6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74JmnGlnhBrh56aPXfVfOZcwSeMOe/uC8x2cc0hDqog=;
 b=27SI1pGYOZWfQIQX2oerrYqP5qczXhsGArX6pty7nXR9Iy1R7WER8GyqOGYZ65aCdMdRqwLPEsYXaJzFisTxS0FXejBup6oyArpgw+VjK0ZtJBJ/fHICuDEqjb5WL4ctHmxXCAraAVirJZIFhIuwzdfWRiVWgR7z29FGbvalbI0=
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 06:37:33 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 06:37:32 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Pelloux-Prayer@rtg-sunil-navi33.amd.com"
 <Pelloux-Prayer@rtg-sunil-navi33.amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add support of burst nop for gfx10
Thread-Topic: [PATCH] drm/amdgpu: add support of burst nop for gfx10
Thread-Index: AQHa4kBqV82Z5K+XGESR8qC+tLODtLIO0VVQ
Date: Tue, 30 Jul 2024 06:37:32 +0000
Message-ID: <PH7PR12MB5596ED4641F9CB4C5496F29893B02@PH7PR12MB5596.namprd12.prod.outlook.com>
References: <20240730052156.4135143-1-sunil.khatri@amd.com>
In-Reply-To: <20240730052156.4135143-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3a7b9b02-54c9-4a1a-9377-dc32a1317493;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-30T06:37:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5596:EE_|PH7PR12MB9068:EE_
x-ms-office365-filtering-correlation-id: bf5f2d56-33c4-4c64-d195-08dcb0621772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rEG08rBmvKqJq3bfHDkZ1Hdqdy8ioqYFJ8l5VKAr+JqGeU1HIf/U2L9tHwar?=
 =?us-ascii?Q?nlafe+QoF/CipYN2l19kU58Jtvl3d4gkEOZ1FR6ViYsm0Lb9Ihwzm/OY173m?=
 =?us-ascii?Q?mC3dCKknmJD4easHgGUOIhQEBx3mSSYfUtxJlhor3rnhrmhLVJQnByN8E3np?=
 =?us-ascii?Q?LNejEzHLzIx53znWx9zd2Wmu3g8Od2fcYsPWq0ptNrX1k5t5RVKCDTkgNDsd?=
 =?us-ascii?Q?5oY+xlQJHtIODe1+io3Fx1kQX6/AZYxG0umMLRgnIc5mBs6eKmbAhNXwMUZL?=
 =?us-ascii?Q?GrW0LA0l4VqHdUSgxBEbvHhvEfr9JQWGFGNIRHQYJUBBbFn4uoVwOJdOWxXM?=
 =?us-ascii?Q?fGK4IHLuczacBwVep72gIS6xGUIp6kbX3k0/FpYVgQp3TwyuF+kmsucC+nt4?=
 =?us-ascii?Q?HBrJB6iB9Utn8Xy7D3x/UmSEWFCynZImBwRWtB8rqRpFesQKtE7MW8TKP2Sa?=
 =?us-ascii?Q?uMUJ7JtkuNEzVWjthZYk0M/YUpIPzvIvzUOSWjiCMVXfKrRadZc+iWvUDua8?=
 =?us-ascii?Q?UzRNWFpjs3gzVev0xndgqCnyitX73Go+bPYi2BTenwHpbqOxtPsjdmLRKyAx?=
 =?us-ascii?Q?0F4YpuipyVgXiVgmj5FflPKcNBbGZKZ2hp2GOBUKR2+K1rmFnsVSHqdaqf8g?=
 =?us-ascii?Q?z8o8eXusOjSHdjdGtahP0riP4MJ1/vXB+7RKgd4Cu6LzmyQ4SSF9FWdBmAaD?=
 =?us-ascii?Q?f5kzYTZcwnFNWljxeikWEth53nvo7RjtFogp+9WWcvjk8Rm32ALI9PIwAeiR?=
 =?us-ascii?Q?p4I+8x+TO8ggQZi3DOlu6p3of1t3CxNDNOWBVuEWMSS7IW9dM7Hzgd56SuR5?=
 =?us-ascii?Q?HtAuXI58fFOg2Ttp1sIDQIN7u6uFL2oTAemuIw1tEZ+xPnAAp8ymX6iLqQ7q?=
 =?us-ascii?Q?rDa6VHGk4L3DelSfTfeCOxxTiIbr/2xc1AdCrsW6s2FyYocEHqpOOUZTrTqW?=
 =?us-ascii?Q?fICn4Dqp+4m2y2m5NhWWOjUZxMfSq3N7Sb6TrZeYlcCep5O9aAfmaHUUZQ+E?=
 =?us-ascii?Q?idpxSqZW7VGkbwC3Qgv2ZkuThQNdo1NzVRTzpF2Dw6Fs6bca0preQZAPNT3f?=
 =?us-ascii?Q?IOzY7+9g1vuUOxzr7HTHrwXnpVtHnKpuMtYROeuBsprii9o+OhEQsoCDnsFl?=
 =?us-ascii?Q?9ML+vCVyQg7f+oS31oTs3/G0roFxNf/61hE+maSxXh2+Vf/Yidu2Lq7gzwsH?=
 =?us-ascii?Q?nnn2tV99N3tys9fOFpj2oYuyXBztJ2eQ6GXWuuG7YMxcq5YGjuWEEABvb7Zg?=
 =?us-ascii?Q?0wPhSNA8+4lm+Q1F/fkKgpdKJ1caBx6cKm1SW+WfoSQbkvq24fpjJuaK1evg?=
 =?us-ascii?Q?fnEm8J539t6KIMzFtgjHJDfPttzc8Ditz8AcOMdU12NsypPlxIc9h8T9e4oF?=
 =?us-ascii?Q?v9dVFTTcJZFK8j4myr+MIVKLNqEsT5se0MAkE28iKsAVMTu00Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aofI4TCgLvpKoAiEs+b4WEPigIIKdlQUvsCRkaF3Xb29pDiyaGb2P+RkKb0L?=
 =?us-ascii?Q?nH5Yk1zQ0UxEZeT+fDOFrwnnb3577JftYkFgBqq9RAugDULrYHQtxQt3/jeG?=
 =?us-ascii?Q?OqPtHnvGaUGElbhFR1lKxeZt6XNe0RnctNpajSUP/DdnQJVHAAuAUEpMxFR0?=
 =?us-ascii?Q?zBaH5vFr/Xwv4P+kvLI33HiPhc6Cy4qb1xdFHxuT/NBixE0HF4GYxyo7U/cc?=
 =?us-ascii?Q?D5meLu8Xj4jyMmDG8ZxZxkeGrKSIZDkUEYTep1EoSRy8B0W+w57h9F32/k/S?=
 =?us-ascii?Q?suU2fsLQhOj2YYYHXBQMH14GIEtyPm6rxfwHBQuJbHTh0nHbnTDaHwSwGZz5?=
 =?us-ascii?Q?RK7KtJ5M229nK3xw5Z7Pfw/y4sxgDzzIn9su+3smZhD28PpLevn4wYiAmZ+D?=
 =?us-ascii?Q?VebrULUD6QWuGLv6XeqCV9hPAFXF+WREqVb50O+BLiPz1z8Bx0QYJWFSXYph?=
 =?us-ascii?Q?c+VtnCS70iiOCii+RZFPVKozVUXI0AvK/tl8pXnnop+VCE0dhpL3B3QslXz6?=
 =?us-ascii?Q?9F0ipbQc4nAuz2K2I04ljYTLQmijk8v2xNDTcThsyKW6qjhuGJNfPjK8MylS?=
 =?us-ascii?Q?0AY4z96iY619ACClR2TZB08qiKxRQ6l8MG3oQycfTQDuqbfP7Em71753X3sD?=
 =?us-ascii?Q?aqygdvjCkG/kFM8QuyMcJadpIRMKb+e5VpSfKqNVSQPaIk1VE9lbz3QW+SXi?=
 =?us-ascii?Q?EVjrHYOUwJZYjsY40yikwZf2O3FeuhiZAZkz77rcjJPWBHu3cepWORFjAcs0?=
 =?us-ascii?Q?JnD4wIxxnhHXaEO3HSL4plnr3AlnJJ4WVL951W0BrBrLsgL5b+uMkPYz5m0g?=
 =?us-ascii?Q?EEcVBDq8wkZqW136QJQflf901WSzshAS3RHhJtMYfhZDDUm7r1IcaJ3lp4a+?=
 =?us-ascii?Q?6xJNjFoWnwIwcqLBbCc9EANa1gRt8/dCalKPcBjhhN8hzYaIfpKF61/e1RYW?=
 =?us-ascii?Q?l/mXOtsvLH0Pv3qPGBSNu5rVB5kMAmT1uzNOQ/T556OT9QvGsBnOuV1U/jAD?=
 =?us-ascii?Q?kzgpDJjh1RV7XWV9gkMB8aPLgKzXTda2UmUiONEIuJ+Ea6vEnktcizXZ0fBM?=
 =?us-ascii?Q?Taa8B8PakXZIUHQjfVS+2u3KYEHjHy4cj0aoy7Jext669wsqXQrINRz3F+6S?=
 =?us-ascii?Q?6xirbneqc/3o4AUKvhX6f13IuQfkzzK2SVg+77C98Sa5DehF9OkYr5Rxqvkk?=
 =?us-ascii?Q?PhIWdg7dFZl84qozyS3aAoCQVJh/EGsqatUBp4wpUWP7B9qdTxRe63EOosni?=
 =?us-ascii?Q?Txalvh1ZopSlySddEUe5DPSK2Ii6L3/GvD03YLUK7hls1LWhf67N4mVPsHti?=
 =?us-ascii?Q?KyqjKylIdN50xGUUD39I5YFnguxxw4oConFldFHF46h0I3eLRhno1NUrsMUl?=
 =?us-ascii?Q?kNuDYe7Tq6Mw+BR+XTphuwhWONE46Td6FIn/HZBWo/iYapfPTCouFeXQZwBC?=
 =?us-ascii?Q?wu4vDmv9AEdWnIjzyJOo4eF4Xg+0Idz5e1j/HsxRBc7x+aloJo/ieOG9oba3?=
 =?us-ascii?Q?T32ZCeuu0IK3oGMsoIW72GXBAfEXvAphdWKS9KcBDlg1XUWmmzabTikoQS5G?=
 =?us-ascii?Q?S4SOhTbX975NfF67S0g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5f2d56-33c4-4c64-d195-08dcb0621772
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 06:37:32.6164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zWDL12GnIVMTnHzKVfjsTDnP2RS4IVH8XY1g1rBSnjVRBe4U2NC0fRcO2QPCy9Pn+q/AC7B4DVTu5hWh6jWaQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
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

Ignore. Will be pushing new patch set.

-----Original Message-----
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Tuesday, July 30, 2024 10:52 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-Prayer@rtg-suni=
l-navi33.amd.com; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@a=
md.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
Subject: [PATCH] drm/amdgpu: add support of burst nop for gfx10

Problem:
Till now we are adding NOP packet one by one i.e if we need N nop packets f=
or padding we are adding N NOP packets in the ring which does not use the H=
W efficiently.

Solution:
Use the data block of the NOP packet for NOP packets up to the max no of NO=
PS HW support. Using this HW would skip passing the information to CP and i=
t skips over N packets assuming NOP packets.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 853084a2ce7f..01f98e2401ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9397,6 +9397,22 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ri=
ng *ring)
        amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */  }

+static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring,
+uint32_t count) {
+       int i;
+
+       if (count =3D=3D 0 || count > 0x3fff) {
+               DRM_ERROR("Invalid NOP's pkt count\n");
+               return;
+       }
+
+       for (i =3D 0; i < count; i++)
+               if (count =3D=3D 1)
+                       amdgpu_ring_write(ring, ring->funcs->nop | PACKET3(=
PACKET3_NOP, count - 1));
+               else
+                       amdgpu_ring_write(ring, ring->funcs->nop); }
+
 static void gfx_v10_ip_print(void *handle, struct drm_printer *p)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle; @@ -=
9588,7 +9604,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_func=
s_gfx =3D {
        .emit_hdp_flush =3D gfx_v10_0_ring_emit_hdp_flush,
        .test_ring =3D gfx_v10_0_ring_test_ring,
        .test_ib =3D gfx_v10_0_ring_test_ib,
-       .insert_nop =3D amdgpu_ring_insert_nop,
+       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
        .pad_ib =3D amdgpu_ring_generic_pad_ib,
        .emit_switch_buffer =3D gfx_v10_0_ring_emit_sb,
        .emit_cntxcntl =3D gfx_v10_0_ring_emit_cntxcntl, @@ -9629,7 +9645,7=
 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute =3D =
{
        .emit_hdp_flush =3D gfx_v10_0_ring_emit_hdp_flush,
        .test_ring =3D gfx_v10_0_ring_test_ring,
        .test_ib =3D gfx_v10_0_ring_test_ib,
-       .insert_nop =3D amdgpu_ring_insert_nop,
+       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
        .pad_ib =3D amdgpu_ring_generic_pad_ib,
        .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
        .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait, @@ -9659,7 +9675,7=
 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq =3D {
        .emit_fence =3D gfx_v10_0_ring_emit_fence_kiq,
        .test_ring =3D gfx_v10_0_ring_test_ring,
        .test_ib =3D gfx_v10_0_ring_test_ib,
-       .insert_nop =3D amdgpu_ring_insert_nop,
+       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
        .pad_ib =3D amdgpu_ring_generic_pad_ib,
        .emit_rreg =3D gfx_v10_0_ring_emit_rreg,
        .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
--
2.34.1

