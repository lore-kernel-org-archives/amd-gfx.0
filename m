Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9487CC52D7F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 08:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4452B10E433;
	Wed, 14 Aug 2024 08:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vn6Ork12";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B8610E433
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 08:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJsvfmI0NMzcDGiIvYQIa59G1mjm5Sg4TnKSxeHGze5AWvq12Lxoq9gSlJUKYzIS7+8+1+ec/EpaVOMq87mItO4YRbmq7JQnXvz8srNmbymjY+vAC/hvEkFn3Ook5YQn1tKlTvKmCXyd92Eoa7MOxJxAWdkwIgLz3xgi8qufH5PQLoQZ69Zp/2I6STn69gTKUUOAQmMlEasfOZOBF0Fmy7FuqCJAe8NFplosKODDjkDagrQDmLWzRpLAheGE0izfpnann8D7ox7I3jwGONXT5hL/dh4mFxdPEcPE0PBFWMM8AQP/I68Nh7MBBwGliB+CzzyOpFR0eP+ZH0oIVaEHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FL/fJYgc9nMQYoCeylBMVft22KjRuxXuTAHHpHoYq4=;
 b=nQfQ4UyUCnJ/PT0Q07OAmsXRath7Q8PeX49DF3M5aCHPis/iK/0LM5hsK/08wMnktMhR4Sr2Ng/Tn/OE71eF/cP0e+E2npBgMfL81K75WaQnMhLFTg36/Auj2ClBhfXThQQZvxREP3SepZsw19A8ipvxMsR7YN9iHjjyP4fWEqBHMt6JC7PKeGV7nuj443izPlkLjHKG7ni45UNJ8JuRsEu9dgRWpMruwIAMb5qpOGHDChAJ6pnz0IwHfmQ0mwSF7kS4vPVnlx6xhjO+qUNuenPXzxmmgUF0M2QnmF2ckuhfLCiLxucXTWkykhgpWEb7oNBTauR+A4abtEo0+1N2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FL/fJYgc9nMQYoCeylBMVft22KjRuxXuTAHHpHoYq4=;
 b=Vn6Ork12hdF+hhGGFUw00gNNkBF/W7QOFw/eRgX5v8wcRrJB2NDkYXLt8hYCPa/BmlBaisNRy1Uejc1kigA2kXGvfmc4AgQai9tWmTmZRANOYtZN+Ay25zBwSW+UDCGhwMpvnQYE0nokMNDAogkHw+82Fj+lVs5ZRAW23i8saW0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 08:59:22 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 08:59:22 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: ensure the connector is not null before
 using it
Thread-Topic: [PATCH 1/2] drm/amdgpu: ensure the connector is not null before
 using it
Thread-Index: AQHa6i71e2j74i8nPUKdGeVZlTuTjLImfB7A
Date: Wed, 14 Aug 2024 08:59:22 +0000
Message-ID: <DM4PR12MB5152D7B9324DA35F6BF68DBFE3872@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240809073425.54632-1-tim.huang@amd.com>
In-Reply-To: <20240809073425.54632-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=41e800b1-17b1-4f10-9032-fc72a451091f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-14T08:59:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ0PR12MB5664:EE_
x-ms-office365-filtering-correlation-id: 0a7a05c6-105a-4d23-43e9-08dcbc3f63bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KxbGk6Mvdmn0NRYGAFvFS+Ds0jcQnQ4D2hml9nLOOgf7eH8smL6mjLxGFuE8?=
 =?us-ascii?Q?q+nWnGC0I9l4v8HINgPBMTgQOlA0uZM56Nk3Nfay0hx9njvj0KRBByh1tVeB?=
 =?us-ascii?Q?XsP6ZyvM8THME2a2rFbdodQBwx3/NXLJ4yf18vBmIj81jHQoYY57cmhla5J+?=
 =?us-ascii?Q?BI4LV2f7IqnYN7D+Uqr2RjbYJQYVMRNY+EAsZGtshUHhlaOJUSNCAzthSHLB?=
 =?us-ascii?Q?UpPq8C6086BV/oXVdDqFYMyY6BQTOL8NoMryV84ZAsmTonyRA8EiZ1mHjz4A?=
 =?us-ascii?Q?1gTAwLSJp6IpU/0YzcIzK0jQBNIWAUct0+ZZMIpE606noUvUeO5IzUWC+PxM?=
 =?us-ascii?Q?LtIWv8QBZVo7WEV6+lSzIeravKBoDucbo1LNwXq3ILdiKdRc+Ti6Ol3Sf0wJ?=
 =?us-ascii?Q?uTTNNGT++GdNNZaVYwTN/XDoRrrWsfj/WiFLbFaocDNwkWTOiOqfWedI42Z4?=
 =?us-ascii?Q?7ArumR+H4Fdo3au8yRIRstYWriONZmNJFU2eveFh89n0NvVnkTazRyw9RSxh?=
 =?us-ascii?Q?YkNXScejBKWyDu414aU4XO2XcxFWJomVfqUGh3KWfP5Ut8Oe6buSpxoNpSkk?=
 =?us-ascii?Q?zr95FTKTd+U6vIT0u7AIZbRgpZCGP8HT5T/YCAHgCcDS5BoTpfwr4ucMrkDk?=
 =?us-ascii?Q?SaTSwzb9ta4YvovQ33xkY+GzjXxfIMEHY4l8Fyk84bOuOcVB/l0WE1fpxnEB?=
 =?us-ascii?Q?iXmKlG6yzKG+fkF6rFSjTk5YZu6ucQM2WbjGMa3s+1PXoyot4Hl1z2u7IDrH?=
 =?us-ascii?Q?oMgZYYnkVjF9e7jfAhu8bzEzM41WiAGVrTdSWkECdSzSNqbrglnB+u3bqGof?=
 =?us-ascii?Q?Q1UINRXu1yeEVkl/F9NslSl6kXEgUHNp//ZUy/ZxUQ3R8Y6fyEF6ce/KTkaP?=
 =?us-ascii?Q?NhMCHxbcrqlWSeLpY+8UO9cCbAs67BFeKt19erIbqGZP8V4M6MyNClStb/cV?=
 =?us-ascii?Q?Pq8Q3819eVKp4ZBk9nHdIi2L0Wa/TSjMAlQ1jHYM3GwvJcqh9qq9q+Uy/aEK?=
 =?us-ascii?Q?+rJNVhdYx6QeLpAEhu1OXH66lJxPoQ8zcvuaTO3xFoCtQuK2KfRRyF177DYS?=
 =?us-ascii?Q?BGP4qdH8WTjsS6GuJ8pVPg96oHl4fMTutYRrt1z0wtT/WJ/8+3NgHf8Cqk+K?=
 =?us-ascii?Q?q5p26e3gzuRMOSK9mgHAetCC66pBeiCWrI0/O8VyjFHtyYL7kicl6x3El50W?=
 =?us-ascii?Q?xf5A1GeKR0hupWQ8JGCd9EQpqYQZlG4kt3l2J4YjOb2rQC/ROeDeeLaW0bfC?=
 =?us-ascii?Q?oPjqT1zl8zZNbmSKtyqch7eNQZhpqXbiQ2nzbHnHc+ggXBrnRlm07W1aOK13?=
 =?us-ascii?Q?DF4DWlg7XVt8Zkzt4DutgYcdgSAvz5jALF/+qQTmyq5p5S88rbZMu9VerTuL?=
 =?us-ascii?Q?PBIjnRtLMf6OFRs3uCLHW+cJD4NoixhkHbUhGqrhpdRFL2ujGg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HG1+z55HOOEfOuxBOr04JzwtdR8aufj6nF37IRvbiKRVAu2WVJFc+mzwu6gu?=
 =?us-ascii?Q?9JVgcgiwuwqALonoiJsxlUxpxbkL6a7x2i17WHvh2CjT9s0uLFTKrIKX6Ckr?=
 =?us-ascii?Q?9mP9xm5IV88sY5CNDrf1+8TwDci0WpWy/ZBd7esdnGtAcblB4A7pc0q34A/S?=
 =?us-ascii?Q?lDCR01lj5k8rWGMfDFHVSVlwTouC5K6DHJgjz70dwki1XsZoqd01w1S88SgA?=
 =?us-ascii?Q?euOU9iHCe15IcTqtDbpVzdVRHodoG2RYm4mEHK0Autdn5o20J+JOdV2Ksqlp?=
 =?us-ascii?Q?o9AsmVYFAF/tLXSPWDBNhA8x8K5Izsyiy1K+edR4kyIzwvmaPOxBxE4Faas1?=
 =?us-ascii?Q?W5kjXYTsfuK0PX6Raqqqk7O4xcUWaL5KWLKrErKkShWK/xAMfZA81Xc7XNKU?=
 =?us-ascii?Q?k6xlC5RLLb1fTdxH2PW5nBQg7a0ZJDpgtYKuKdb/9ZTiRy2LCQw+chLu/79Y?=
 =?us-ascii?Q?yZgPiEgS+jdvAfLDa3yTStjKCWDCU5rwplDilxQD2n2aobXnsREn1kTzNhV0?=
 =?us-ascii?Q?9I+IwdaHI0/8pOJGnNlRd/mCaOI5lGrE3BG2s8czXb0Kw/0yfZrzGawxnHNz?=
 =?us-ascii?Q?nAeu7e1BQPz87ecWCPhU/dWy7S5DUWIXFvmzWj2O+9Oibv/gTBp7xOK4ggN1?=
 =?us-ascii?Q?8WG4whO2U9VIsP5btH+Xaj7hE+5Mg4CudiymnAufaHBYc1RIpudVqDwi2uxU?=
 =?us-ascii?Q?OuzbYMLAjlkGa4CysdBU3zh0rjX6LCz91RX3Y/WCxNpauRrHI1gFSfy2hRhZ?=
 =?us-ascii?Q?QOOR/axSkhDDksB7WMDVj+TaEM5kwR+XUUMLzz5kWS+KOyucisw1ihvoQ/6O?=
 =?us-ascii?Q?zzqniTldrkxkQFMHnBWRH3q6DghtrWNmj3Ce7NQO5knGvm+8wJDUiCexCM1N?=
 =?us-ascii?Q?2sHl1xOcA4v7vrfgDH9JzkqZuXcyntf8b0NfQsVL6B/bkoKLohhNqIC/1Hb9?=
 =?us-ascii?Q?13mZ/ZkpHcawGgQYLYXC3BMjxYKCch3Qjgnew3whxUqX45x/rtqboahaJMOs?=
 =?us-ascii?Q?sRlaoCRW6hZzmOSzxdo+vbvaU28Vg7jbSoqP0gvfqEznRTvHZK/zeGj+b5Lc?=
 =?us-ascii?Q?awdLl+IFXA1U3FqzO1XAkex+9muyctpgt2qdU8l7IvitAwvjgbhlAdRP/GWw?=
 =?us-ascii?Q?HLHpAy/Cquaz1cZxBbv79m/pYkLx/xgKxh6hmzdwzV8JE4w5CpQgLkK2Rtt6?=
 =?us-ascii?Q?pfY+Gi3PPMQ7eNh7rgmosUV2Nkdb2C0G3Ajo+Oqwaqc/aWf5aNs8k+wsIPWC?=
 =?us-ascii?Q?RteoffgJTaQRQ6S2+/WiERYno+tr0XYSDqRYycRi63gT/TzQav7kfwETlFZ8?=
 =?us-ascii?Q?HQfUZ91digc+5UxoO7J7AuO2IRMaNMei6isoOUsoHxQhMzdi+Kt5RHWPBz82?=
 =?us-ascii?Q?tvrmICdQBA5amA1zNY5JsEdQ3NBvKtCjnUK5AGq+MmhKcQWphLsWO7jHGJHC?=
 =?us-ascii?Q?tQJQSAyXp9ipggQIAqfq553CaYP7FrsqdOEWnj1lZNFDK0Fu2gTMXwNI5XEs?=
 =?us-ascii?Q?YFlYhzKLOaN1PLeW6YWZUR7looEz/YwZZpoWYM1Eu6CJZ9eJjiHJ8/y0ZkIn?=
 =?us-ascii?Q?yNhc1/J/jMvM6x/tvZw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7a05c6-105a-4d23-43e9-08dcbc3f63bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 08:59:22.1812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxD0P3Jlc+FptgIGCd5eD+7kerizR964MMf3WWN6yWI3OLiNKTY3aIqPDQzhps8GDk2b+Bzf56bvHRlUnSqESg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
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

This patch is
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Friday, August 9, 2024 3:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhou, Bob <=
Bob.Zhou@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: ensure the connector is not null before us=
ing it

This resolves the dereference null return value warning reported by Coverit=
y.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 092ec11258cd..046d4c4e0299 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1474,7 +1474,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct dr=
m_crtc *crtc,
                if ((!(mode->flags & DRM_MODE_FLAG_INTERLACE)) &&
                    ((amdgpu_encoder->underscan_type =3D=3D UNDERSCAN_ON) |=
|
                     ((amdgpu_encoder->underscan_type =3D=3D UNDERSCAN_AUTO=
) &&
-                     connector->display_info.is_hdmi &&
+                     connector && connector->display_info.is_hdmi &&
                      amdgpu_display_is_hdtv_mode(mode)))) {
                        if (amdgpu_encoder->underscan_hborder !=3D 0)
                                amdgpu_crtc->h_border =3D amdgpu_encoder->u=
nderscan_hborder;
--
2.43.0

