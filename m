Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1576ECA0EED
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 07:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E5210E3F3;
	Mon, 25 Aug 2025 07:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1llhedr4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648C910E3F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 07:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+YqBwTIxlUM9tbxQTHN3fgT+TnL2+XlMiHpgJzPK2Z5ujK+PPScOoegpSLxHc0PYIrbUoLbQXJH+a5MRRVl1ykWSqLLe/Bf+5OFnbgM9wEON+0Yhv6y18XlGQNU40pkX2uYve6US8xkNPwzPdsRe2p4S1jMRIS+6oIV2rLpkwCYTiE0XRsD1Y0taPOdt9nDQlmpXmmMj+h2ZqKyRxVoXHKvMVoVVQfqzakSLKd22cDr9M0VY6AcmAya3+Uw/3QamzuRU69QUfKldLeTpmKE/Hse6HhxnIvz0i/DgcEu4hf4aZ9NsWsatJ+N81ix0yfs2fMrHVClcHNbGdLUGmrLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssuFssxrkJhF9S6hU6tdIfrIP+zk116DcZ9h3xZu09Q=;
 b=JDKT9XnfysWCDokPJG8TcUOSflp+feT/p15SIE3znMbF7ZWat6xsy6W4LeTr4PrzvyAnB74u64x4KQhSYRwPVeiI+2xcjxwdfHphG4RtT9H42zCkl0BWklGzAgLNbvaJRXfDfF3ZCfIsyrqaGQdsxIHhNRRRXOm8HYZPyGNVJem9yms3oMgUtcNp0wAh2J3RMt8YGTda0zbMWl1KI7n/egW/eGOAnwH7f5hEXzQF9yR0c6iUw9Fsa2totk5rkyyHPHlrRZrPCnvmeUD7hh4ZKEItEOtcxg/Vr2hC2pMslXUsMOi3DHgV3M6Bfs2LI38TDH2pflNYWcF+Vq+TnDqNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssuFssxrkJhF9S6hU6tdIfrIP+zk116DcZ9h3xZu09Q=;
 b=1llhedr45u2sBY/lvGroWRw0Pa6ZkuqMDYIhUl99Q8DDFFpiFDi7nudXK5kM2FU+hfw8/LBbln1Mdn3xE62cq0wK+gYllyxx8A9ziRQRUViZ1CmT77acCRbREttO6CzZSETdhglJM8Rr7RfV9RGdYJYZzNwv+rpOoCb4Rj1rfKw=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 07:43:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 07:43:04 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix shift-out-of-bounds in
 amdgpu_debugfs_jpeg_sched_mask_set
Thread-Topic: [PATCH] drm/amdgpu: fix shift-out-of-bounds in
 amdgpu_debugfs_jpeg_sched_mask_set
Thread-Index: AQHcFV5HIxPiYAIiaEayjBU6Tn5qBrRy++IA
Date: Mon, 25 Aug 2025 07:43:04 +0000
Message-ID: <DS0PR12MB78048A6E4E726C97DB534629973EA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250825011903.1382954-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250825011903.1382954-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-25T07:39:03.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|MN2PR12MB4238:EE_
x-ms-office365-filtering-correlation-id: ba09081a-2288-4db7-413f-08dde3ab068b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NuKhcfO28CufSnaoENY2cmHFKACdcy5v3HcgSkFNTyhI5kvSJEbOI+iqaBF1?=
 =?us-ascii?Q?FA/nDEPCVBvOiIyijqZ8iwhFLADSk63hlMHRgywxb5+f5tzGDgJHYQGWR5J8?=
 =?us-ascii?Q?P9CyLxjGkHXCBjkcFJo4hrmVfKH6z6zrpQKzuYatZXTbR5r6RcUCMlpKEY9g?=
 =?us-ascii?Q?eQB+TLd6RQ+nLEwLs2lNztjn2gM3Gt/gskdT6dnRQKwESucqso05UpXXtQFK?=
 =?us-ascii?Q?LUsu+8ruO1DkU3JnB3PYkAIsCmXYd7v25jymDZjuF6z/rV0Bl5+yzuCkdOb0?=
 =?us-ascii?Q?YEKhrjFeKNgTW3apC53JV0G93v2lRjiIrGLS16c2RCd4FDz8rAPUxXv6KdUF?=
 =?us-ascii?Q?L2WioKm3RdhdkWncIe1n8ze1wcKkOmRCwGx9VjGtXaCwjQRa9CSglhLvmOjb?=
 =?us-ascii?Q?SejDfFkkFibfJkLDeJa83W4y+t5LTpMxLBaz2V0P/08/WgGeUg1r2JXYkoKK?=
 =?us-ascii?Q?HPLpA/RhAYGrvt2RMWpcWwy0+/AJpWAjucFNbzDVKAe+tXvGbl+xqi0ew5TT?=
 =?us-ascii?Q?jFZlzZ3apiBckD6pkrbHVB39yHOONCPAeq+rZCzkmzlyvUPGs4aB90iCTVXL?=
 =?us-ascii?Q?FUptFdbGvCpg533jLu8Ge4f59u2PrcpxPvASx+YUvb7ACHKt8ZUS2877nA2F?=
 =?us-ascii?Q?2A3J81XwN2ySpKUp7gx0lDVn42CCt0KEy8QRQWRF/VEETBT4zx3eeVxgJnDI?=
 =?us-ascii?Q?oFCOmLrHChBK1VqoX+uUAoxehd+8OQzJ6yKvjtXcorG4kNsd7OlkPDan0HZ7?=
 =?us-ascii?Q?/5mUdUUTXsQNns65b/x5J4poqCk9HSBAXWH7x2TTEKQGl/xiSsIGMHAe7zt1?=
 =?us-ascii?Q?bUmK5hF1mgdZrQTJIhOBK38emJ5QUiJ4puboHAwr7Goh2PcFQ9sPeFnX8f6C?=
 =?us-ascii?Q?uTZQR0vjhSX6xW++owBB+btisMDFFsdEhmwIY+mJeshsQ/eELnogS26oa1BG?=
 =?us-ascii?Q?3vpfcz7jZN2lo4MXHomGmjpksLZqdRlSxzRuMBSD9WCoFc1kak/N3jc/Jmti?=
 =?us-ascii?Q?aGtvfYPFL49TO857ZNydBEn0xNzR5cawf7elNkEW7j8qWotY3rqMKCB4aqBp?=
 =?us-ascii?Q?PkXfbcCxr2Zzqc27zjMv9OiRfNv5XsglrsNDVZd70MbdtlVg4XTunZmHTguK?=
 =?us-ascii?Q?MAzMc15GEYa5Dtrje52ooGUEGR5qQA6JYF7qWs62hVH8xfR8vau6rbjEjbPK?=
 =?us-ascii?Q?zXgCB89SFRKTDIHUNKR2f9n7MOYwa+rPlZBIMcRsmP/jFZRhudypQECalydu?=
 =?us-ascii?Q?Y/p+CTXNi0Q+ZZEb5vBD5i0ni0u7H96JeNAr0IWth/L4YP4FaSnXW0HO2a5u?=
 =?us-ascii?Q?/nqLGG/Qw69fyapE9NK2aiM1L9xrM+OrN0lv7S5QTiUpjGN51FXGvGUHIscR?=
 =?us-ascii?Q?Iy9jBxezoZTtYBBJe8dGB1pdqCbN4KMxb9N4uvjZdpGR9ninoG7UiTk21Hz8?=
 =?us-ascii?Q?NFsIABU8laFlwL3H3VEbGZmFIqIt4Uu2bXCXteJI3otqK0Ta7t40Yg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nWcX5BzEy3oGd/F2O+UKWFUyZALazlqIxCzptLe5V/7g7IxlyZOaLlCwoYI2?=
 =?us-ascii?Q?Gn4PU3X6BZDoRrqjHqO+7Ca4yRGBxdE+aW/wZy06WDPFLFAHXhWpm/ReNNR+?=
 =?us-ascii?Q?gd2H5Wwlwj/jTwJrrBtQRZAaQpQ+dVmid8EDyQ0PC2/Rx3i75YpgoeEmUQNA?=
 =?us-ascii?Q?+TnS6zkKnrOo8KWDbQMkwG1JgDNpZVga/4plx0Dzf9EtFKP0Xu1inhPbhI95?=
 =?us-ascii?Q?1sfwvLOz0DQPIFrKaJrpO63oZJh7Leww7ms7l0pagjayPGRX/tedM3DcBsE2?=
 =?us-ascii?Q?MiHs7b8EAwkwEFMEouarRCjmeVYXesXxeIBimlp9EnS9vniVpIczFM7qqQKe?=
 =?us-ascii?Q?uTetal9wbY/SNd/2sfrGk5Jx5S6KWxtC4f1qexHvP+M4jq2nKEb2mj3+JXiA?=
 =?us-ascii?Q?uu6F0DiwftdIJQY11f21Nr/WCUiLizuKp/7qCoTa10DVU2ZN21Vd48TajnpL?=
 =?us-ascii?Q?5FHK1yejGlr8Qr2n24G4mSW2DymCi62i6FvjGENPgUPlFdM/q9wue07l0t95?=
 =?us-ascii?Q?uAFBSua+XBmokY9x5kikjTXeWhhjpZQRt+wylhQnx9LUaK+NMMMa92aG0E+H?=
 =?us-ascii?Q?VsunKBeqk+ZHBaHUusWrsYgJIphUuv5RDN5nXyUjw1USqxXyPGcnH8+gXJ45?=
 =?us-ascii?Q?yhv1rC1j7+U57p6fv19gdLKwc2nIRwU29yZa2MQNYDLkrLIg9uvFA0gEHOyB?=
 =?us-ascii?Q?3Lbzutq0mVWYDwt/nPc2M21vHckERoxgOnyCISvQgo3WJI6Kqz3QCyhQGLpl?=
 =?us-ascii?Q?H5wq5zT+FPxemwH8PPSAbKMUyNw+LhUEAJvSbl2DS5GnMp5vc2sp4OQDyD+A?=
 =?us-ascii?Q?qNKd/Knlwg0FsxG+zhSCencoLXetBTx50qQ1JRKzb2VWKz7ov5HpAbOyhfPa?=
 =?us-ascii?Q?aXUAdVDnm1gTH9bZ4Pi/QbnLD8YHM744IfsGxmSty/vgqUwq95n357C7S0p2?=
 =?us-ascii?Q?9bSStMtZR6sfbzEdwRRVZyEzygehVQCM4XKUiX2YaRokrwR8ICYc76wT6ID4?=
 =?us-ascii?Q?oha7GnyhWsVV7qfZYKGGlAe6rrJEw43M7UZNboht4MJoTxcHxWtrIJa/yp9/?=
 =?us-ascii?Q?XXu/6XBC7H7ZhXWtluY8SX/bSK+VXnuRvcRdWR7aBGRs1WZWPdE4azQ4ev+3?=
 =?us-ascii?Q?COT/JAviGgk7TBdvzu8y9KpcBeWaKDYHycBpM8nU1x1V0DvcWcs1HRDcDVRk?=
 =?us-ascii?Q?9bULbW3l3dAxzOe8sUoaRqlcsMpwPWWlJ+w+/BShqU4x3c66vmKyULwWFe8m?=
 =?us-ascii?Q?Iskdhsg4/zOQL53q6NTrs7+k6X8sd8FLVrp0GczNJ2Bo9jsdKH0t0F5PRXKW?=
 =?us-ascii?Q?nTQxzzdvBKJaJAKevR2lvGIbO1FHQJVO7kBJXFRaYtvRBPss6MMKJOKYHoqK?=
 =?us-ascii?Q?0qfEyYxjS/AZ4hmmSfARusyVucXJwkBcBlg/S2VDAwgRYafbr6eDoFb0uDle?=
 =?us-ascii?Q?Wnceye3iHyCu+PvW4mQJhoXPZ1rmIihtb07a6jh1GSvrNhjCNTNhmZvFD/wc?=
 =?us-ascii?Q?yA0wdZ/QC/kb//fNiyyxypBh6R51o9kpEPwaW4QD3Lwxh7pczBQvHJ8MfvsW?=
 =?us-ascii?Q?T3IQBv1tmKZl0wcspos=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba09081a-2288-4db7-413f-08dde3ab068b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 07:43:04.4842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYTRnVSQXz0HpMw9y3pJg+KppyPHWgHJsROx4SfLZUyFg5TkLefV2LqHY+/1MnnW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

You may use BIT_ULL. That aside,

        Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse.Zh=
ang
Sent: Monday, August 25, 2025 6:46 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix shift-out-of-bounds in amdgpu_debugfs_jpeg=
_sched_mask_set

Fix a UBSAN shift-out-of-bounds warning in amdgpu_debugfs_jpeg_sched_mask_s=
et
when the shift exponent reaches or exceeds 32 bits. The issue occurred beca=
use a 32-bit integer '1' was being shifted by up to 32 bits, which is undef=
ined behavior.

Replace '1' with '1ULL' to ensure 64-bit arithmetic, matching the u64 type =
of 'val' and preventing the shift overflow. This is consistent with the exi=
sting mask calculation that already uses 1ULL.

The error manifested as:
UBSAN: shift-out-of-bounds in drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c:373:=
17
shift exponent 32 is too large for 32-bit type 'int'

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_jpeg.c
index 5d5e9ee83a5d..2c84f69b5bc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -370,7 +370,8 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void *dat=
a, u64 val)
        for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
                for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
                        ring =3D &adev->jpeg.inst[i].ring_dec[j];
-                       if (val & (1 << ((i * adev->jpeg.num_jpeg_rings) + =
j)))
+                       dev_info(adev->dev, "%s[%d] num_jpeg_rings:0x%x ###=
# \n",__func__,__LINE__, adev->jpeg.num_jpeg_rings);
+                       if (val & (1ULL << ((i * adev->jpeg.num_jpeg_rings)=
 + j)))
                                ring->sched.ready =3D true;
                        else
                                ring->sched.ready =3D false;
--
2.49.0

