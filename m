Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F694C36010
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 13:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B90310E2DE;
	Tue,  1 Apr 2025 13:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FwlnBT0e";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B3610E2DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 13:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJo3AWHZz73n2YsX1PB7v5SKSje8HW7QERd43jCxjwAz5reyQGKVE1NDB8VZQGAYZOUieJfNAkPmNO1wiX8HEsUe7rMGFg7g/tJO6BzdqSaOjr+6Yonu83rb8U+COi7OO5bF3+NK9s6M61jEzCKABq6OivbeGc/ZIAteBA6SAjXwRjRKCjR4enOvc7fzAVuOp2ZMIbsK/Uq3wSI7xmz9KODqf91x6Vnqqufq7nNr/zE6mSRa8+QhFPHczV59HDSzYPP84l7T8jhEGeROto2Mze75LkGX08CnrZvxA87lzGR9S026kpwVDWzwf7EUxRVXKJUqiWRW8ORcHVgomnRvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTEVCy+OjCwyPHBNNWEOTeNFYa24I8k8wl8mkfUtyGc=;
 b=I0O7Y/sXN4VAxSUFzaE8h0IDJNrUvNKrXwFC/5gtUZgeZ1b4oNi1jDGDpbzGgkzw9/pT+ZrEL9H3LObnAha0lKaV293lN42qtXwEs5VsQKKtp+fgy/et3QSXWcRHPs5O6uYkM+8ObgMRZeLo8nIENgaH91cDqXMDAB+Sdn8y3AmMtR5EXVX1CuFIXkHIncWm+O3BKlMhnwC7dncA0ztwCRTJfyzoIo4sO+EJszvoKrZFRdSefjE+DuoSvmEZgpwXL3ba34EpVFxlD19MzDEIcyO5HKySoQZhFjMCjObYZZXiDgt3/rxwH5EQr/TODZHsg8hwuJ6jkmj4EZJDGzf4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTEVCy+OjCwyPHBNNWEOTeNFYa24I8k8wl8mkfUtyGc=;
 b=FwlnBT0e8/wWYtlArET5FSzAGMAb2A5iEnmXikExCenXkVhCaGe6pKftKFfImj0jk28PGAzbiw/bIN0a5tDPI6NeFi538ZGkbP1fWio+bubP00qTafPKIhmIUNKSKiWtddrPIuj3vZcMQtWE3kCo8FDJsQL4NFxk+Kx8F9GU9ko=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Tue, 1 Apr
 2025 13:08:05 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%3]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 13:08:05 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix xgmi v6.4.1 link status reporting
Thread-Topic: [PATCH] drm/amdgpu: Fix xgmi v6.4.1 link status reporting
Thread-Index: AQHboviylt8G3CLwa0KY1h52S9J2kLOOyC8g
Date: Tue, 1 Apr 2025 13:08:05 +0000
Message-ID: <DS7PR12MB60712CA1613AB06E1B63EC8E8EAC2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250401112435.461473-1-lijo.lazar@amd.com>
In-Reply-To: <20250401112435.461473-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=14f424c4-94d8-40ee-8532-c4b93f459aa8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-01T13:07:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MN2PR12MB4437:EE_
x-ms-office365-filtering-correlation-id: 58ca129e-b579-44a1-08f4-08dd711e3ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3PelmcJOOeOe5zTHWP0b3o3spka9sLQ2WbXFYLlHzDlh/i8IXmIKIJ0BtBLM?=
 =?us-ascii?Q?M1Jdvy4RiDG+tTrp64YOR7NkWDUusfZLKk+39YiFgthTYu1rTflTo60Zxlii?=
 =?us-ascii?Q?aLogCGx4KuICCyKQtjPBBSt0ICCUTrRWNj1MrZBGR+XEnfowqoL+4csNWgww?=
 =?us-ascii?Q?wGqsIbA886omvbD+ofSFDkEjV1YrKecA1GdXfT8Fn/YhVVhT5WZCP4/6jKQ6?=
 =?us-ascii?Q?BMbTn7M3lrMFz4JupcVRcM0TQKzTyQIFT4pToEcg29s3GI2xpw3gXTxHh5h1?=
 =?us-ascii?Q?cw2dlDvMS33GNaWvfmgJkw3hjQf2tu6by/pkgUoCguM+UEUN2Xe+PlUFbOKr?=
 =?us-ascii?Q?/THqO4cDoMf9Dgo7CSqo1EB06FyN1h0xcPmQkPx8nLhobIl3BbD4sI1tJPNW?=
 =?us-ascii?Q?X/uJH41M1O5dh4nVbSZe085sIweCJmZOU3IndAelGxrwQCpQLzQaEOBPe8VP?=
 =?us-ascii?Q?oJe6ZxY4ufNLNfgHNvhaCtLYzRfGz8dnJ3/KdoDm0eRpCKnrS2EkjCGLzWBa?=
 =?us-ascii?Q?FiBjeLtd+yPRn1Cp175S2Qjk+a8yfdqERzcqdufSLzGiVV7b6r+4nURTHm4u?=
 =?us-ascii?Q?aVHaheqCYsReJJTRajU0D8lgt0+7JgkCyLpMSjXezwWye1zje5Je3ClEZoX7?=
 =?us-ascii?Q?b1md8pJtmwizPJ6CrDVz21V457w54kCe0X2UyToVuQavNrS5wTe2n9FS9+rk?=
 =?us-ascii?Q?y5SI2QquaSuRho0+Fw/43pCIIg6+SxOBBr/SwxA04xSv7VUC3lqdsfIT1w+6?=
 =?us-ascii?Q?wUdvYc4cg8f8I9ml7vbsfgFIN/QOMqkrzmKo/otXGrASKDyM4iw1Fxm001L0?=
 =?us-ascii?Q?I2uOwXBohMNimG5+2Zo5xEr8uNQgxtgG8wbIQSdtjemZXllPJU8FaGrTzWUa?=
 =?us-ascii?Q?CnaJGZQ25HUNC0NOanhN40pClapUSfnGIaeb90GOcTl/gojCYV9jRpdvdtoJ?=
 =?us-ascii?Q?jdV2RG6f6vLhkaOSXmOEZlygW8S6SvGhj47k+BKSxEV13Pf3ajqTChpXxq0G?=
 =?us-ascii?Q?xA37kNmW7OnYY2rB/vtP0ogTXW4kdlobAvGWDpXMV/tuwZZaiOQbeYmQBeEl?=
 =?us-ascii?Q?erRHX+XZTRenbL9eWYKtBbERLReg1Vth/8k/FGZJTkC+YkvLnLL878oYfz4/?=
 =?us-ascii?Q?jlQPLRaH5tZhXRjZ6NQK75xxxRmTwsWEsnwuMGgSAPdyXEIZbcpbp3nPnB/T?=
 =?us-ascii?Q?XC76LsXPq0f2asjr5nTZTud4YVJYzIUBSyUcrfdFkHWGybVzDIq9eTjljbpr?=
 =?us-ascii?Q?ffzsOvgbteFlRLXJ1tonJ8CAumce9mGX/fFW70TVIDrwt4Rg5WFDaR0KSmE2?=
 =?us-ascii?Q?oSeJ6IaQJS1BcxK5UfEsG+TESupUaE+BOpbpoifaTISZ2GzeMIsZWgCseslX?=
 =?us-ascii?Q?do+L+/HXtG2ZGWQI11ooCdaEGnHoRuG0zTkfqVgGAbOPwaa5cBLpk3wOQqL3?=
 =?us-ascii?Q?VIeNcUi4nuT62/O8t9dSjyrTml9SnarL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xfuDDqvDRu7zzInQfIlbay/hnCEA7IJkSoOBo5iZkp3Wv2KtmknpzRcGgzce?=
 =?us-ascii?Q?cw7xdf03lokoyGP7qpdHOmW7GprJVxxqm/cuvsXYKxSA/DZF9O8BDigKu8wF?=
 =?us-ascii?Q?uKuQN+wJ4/fq0eELxkoglLq9IJyhA7fcpTxKfnuhz4Pi+xfoGL36nPVtZ2Xk?=
 =?us-ascii?Q?JGI3WKf0RQjYdIeGHzPpmyCXfPjWVobpren/BjQDqW2mtqO+C0Pr4gMpbzWQ?=
 =?us-ascii?Q?vf1DwzioPrnDR0iVKk6vjW/cJUmphCzz9vd6MFI3yirmwlCUEZj62LQreHgk?=
 =?us-ascii?Q?jR6Ej6czTNHJRpKeQdc8neXIZZC5JifVYDc7YMixpxunvdAwenRtwDaekNlC?=
 =?us-ascii?Q?Xx0m1OMYSJmbypbPNf0bni4VFKBWcCclYWkfVfhxjm500xglofF9+IEtDGHy?=
 =?us-ascii?Q?DqCcQGbj+/ERDtfBmSlWo0yFkepLIPL3P7J54jn2w0O+GBkbUfR5Vvxu0BbM?=
 =?us-ascii?Q?f3jzjfR/nOik6fTY+FaPMcF87hUyl3STSw7yeMcMGpEOjzhzv3FPaTh241Xk?=
 =?us-ascii?Q?tZJGDMyjvaBKca06mzRaScaDD0jO4wynXe0SEWDH3XBOgSyEpao+IhrrBsZW?=
 =?us-ascii?Q?4Jam4HX2BnRTUNgppDH8ALO7EkeKJz5yXB444WjhqS7hgQOazFwh2/slDXK2?=
 =?us-ascii?Q?qagNB1smOM8lzf7F+m55OHTuZPzYS4g6K3dIDR6ERdinh03A13bsaE3rfuRu?=
 =?us-ascii?Q?btgoxoKMVi1iRAuMhAdZb5+QdU/KjSGhitqwYGMWFhfB1CASCg0APQ5W0htO?=
 =?us-ascii?Q?s17gSKPqVZOFNrhc3faaLWzYFF9PvjZW4IGzQiRIP2BYaxvWdG3gqWuPuExR?=
 =?us-ascii?Q?U14SLgRFlslrdh+b0wTxBoRsxt80bR/j0gGe6RoHdqtYIj+5x2gViyI5yCfx?=
 =?us-ascii?Q?pnzUjsT1iXoVQhqTujhsVAS3nx33vUhGYiDz04KrRiraLDeViTmjdDH+AWNm?=
 =?us-ascii?Q?EKOhFS3obY9QtFd6TvntO9k72Zc+m/Pu2TQcMvH//c6gGGQhFsL0mZgOOlnR?=
 =?us-ascii?Q?Bo/pMi0YdqtbYwFXLmILEpCUXcCxG2msqHZVATOuureUJyyajECeqmKIQEaz?=
 =?us-ascii?Q?OqrMQfm+8XBx8Mmjc1/jB3QCx7dXAGOV6L6UQq/scHdDL5oMuJFjqIS30S7n?=
 =?us-ascii?Q?U9Jk3EQpkqAMWQ76E0iq52qXN2crv5r3uOykBNnXjEpi/BcwAaTytZ7FQN9B?=
 =?us-ascii?Q?XSWPpBIWn8tUiNcig0kSxNwhN8dl412tZnBgTy7pxFSt3MBV6jqAVlgDYP//?=
 =?us-ascii?Q?Y7j1Ts0Z60OETR4iL3PhK2AkhO40f0VbziQLjAkrcWEPb6bx9VcJ8k+CVP9n?=
 =?us-ascii?Q?mg8kdrLs175PX1N1oZZQ/bGqqtBFwUgvEAKg7YMgjhHrQ7iXVb9W2ri0/DGO?=
 =?us-ascii?Q?PuQz+tC9EVhFutSd+cv2NRjnkYheQHLhKDuDX6pqds5CSlbE8Si5sQwdCQpc?=
 =?us-ascii?Q?MuSbZnHGa22/+UvJPOOkpGNMfY7D2I9xcFn9Q1uQyuN5vwV7E0Npb/0MOePV?=
 =?us-ascii?Q?QiSF00LO2LRQ9sr3WrfjGsPaXB5KviMaQQtTxTpEwwfYkdJQGpWTzlilZth5?=
 =?us-ascii?Q?Tz8jExM4sWBiJAulSDw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ca129e-b579-44a1-08f4-08dd711e3ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 13:08:05.7169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8cwMLH4rcHSN/9brEuW/dNbtMZothM8gGjMKfZWNE29TK9aDL5aJZJTCCSk1KbMOEW1ct8qDOVlZ9Mw4w+FHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, April 1, 2025 4:55 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Fix xgmi v6.4.1 link status reporting

Use the right register offsets for getting link status.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 477424472bbe..95231de26cb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -296,15 +296,27 @@ static const struct amdgpu_pcs_ras_field xgmi3x16_pcs=
_ras_fields[] =3D {

 static u32 xgmi_v6_4_get_link_status(struct amdgpu_device *adev, int globa=
l_link_num)  {
-       const u32 smnpcs_xgmi3x16_pcs_state_hist1 =3D 0x11a00070;
-       const int xgmi_inst =3D 2;
-       u32 link_inst;
+       const u32 smn_xgmi_6_4_pcs_state_hist1[2] =3D { 0x11a00070, 0x11b00=
070 };
+       const u32 smn_xgmi_6_4_1_pcs_state_hist1[2] =3D { 0x11b00070,
+                                                       0x12100070 };
+       u32 i, n;
        u64 addr;

-       link_inst =3D global_link_num % xgmi_inst;
+       switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+       case IP_VERSION(6, 4, 0):
+               n =3D ARRAY_SIZE(smn_xgmi_6_4_pcs_state_hist1);
+               addr =3D smn_xgmi_6_4_pcs_state_hist1[global_link_num % n];
+               break;
+       case IP_VERSION(6, 4, 1):
+               n =3D ARRAY_SIZE(smn_xgmi_6_4_1_pcs_state_hist1);
+               addr =3D smn_xgmi_6_4_1_pcs_state_hist1[global_link_num % n=
];
+               break;
+       default:
+               return U32_MAX;
+       }

-       addr =3D (smnpcs_xgmi3x16_pcs_state_hist1 | (link_inst << 20)) +
-               adev->asic_funcs->encode_ext_smn_addressing(global_link_num=
 / xgmi_inst);
+       i =3D global_link_num / n;
+       addr +=3D adev->asic_funcs->encode_ext_smn_addressing(i);

        return RREG32_PCIE_EXT(addr);
 }
--
2.25.1

