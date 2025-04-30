Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5263C369DC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 09:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E92089070;
	Wed, 30 Apr 2025 09:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hTpZtw5Y";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D27B89070
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 09:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUykeEFxQwp/42jeFWrXaLA2WaouJvZxWjLFozBnGyql+mvR52VoBSkdwUgI5U2d8+ceOdywFOEuMMeBqJM96W+c3bZtldc48JioQWu02AaSW+KpDz3dbYprw2v765OYFKs6F1E1Hn2PDLW0kazitdlwK/Y5wzgNFPS+izH+wAyjuZ6Dt0ez1P/NRM+aO1ey+pTxYiKVWUj5FEQzIuOLUY5jqrcPAROBbzgwLQxqkFnr1YjUGcYZp8bKtFiNs/c87GGnFZR1GECNhCcNGH/7IDBR0pgjXhQQboDczTLqmrHpzS2J4ttJiwhHDs+YnCPU7To1oobGn4uRAdDkeRQ3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5bY4K87YAxTWVZsjExsjtWuTAchCoUlnAE4UMwNCO4=;
 b=m7RgXpQDgXV0x5tnHrD/bwWwlhI3y1kTtKQImn4vzjPqLospP4Vl7iEnwNOWPgFCqvIafI5UN3bUl1+dhxrx7OOfPXkZA9wy9uMN+sqRqiNOSTI+ukPl8apwz4i21IqVr41/DBjpn+ee3zRB4MnlJLiEf4KhK1+0sqMO7FY1NCJ4TGz60VnJxYU6jYYnJkX7ZSrxXmZUDNvaUE1c+agG8lAd2o/tstjgO9jrYoBTgRNVgc9hgiELqzHyAngAz2BM3mwC1JeMvApimFYLPiQIBJEDPPDxEOfi6kE/0n4sh1De0n4liftP6oQ2fk4DI0+9GPrmXlf66y+gyD5wuqR8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5bY4K87YAxTWVZsjExsjtWuTAchCoUlnAE4UMwNCO4=;
 b=hTpZtw5Yal7fIzKjACVwKMT+9z8lYUztkDLNoX8yJnF3dV8YS1ENEjqFG3LL+hqygmtpUrOuPmtKW8f8RyexCC3Rr0y3FSUkjsz5iGkwTQ57+dcWplAsbDRgZFpW3bS6CYv2OA9kYO5B9lSDTXvt8Xbv40AhjwAD8fC/E30Vlwg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 09:17:14 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 09:17:14 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 7/7] drm/amdgpu: set vram type for GC 9.5.0
Thread-Topic: [PATCH 7/7] drm/amdgpu: set vram type for GC 9.5.0
Thread-Index: AQHbuamOvDsZGn3fgkqqsuWB7v2oC7O77c1A
Date: Wed, 30 Apr 2025 09:17:14 +0000
Message-ID: <BN9PR12MB52572D59351ED50A0C894D47FC832@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250430082550.60109-1-tao.zhou1@amd.com>
 <20250430082550.60109-7-tao.zhou1@amd.com>
In-Reply-To: <20250430082550.60109-7-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=daba74e4-06bb-4b54-ad05-7fb5f2b9ce63;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-30T09:16:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS4PR12MB9659:EE_
x-ms-office365-filtering-correlation-id: c068f555-cbd4-4fe6-e0c4-08dd87c7cc14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OLSfj/+ACpyMMZirmFYetpdNWgtsAtMbxRx3NElLgxwadxqrrQIB/Jlyrbas?=
 =?us-ascii?Q?XXrueSORixvFXyQ+mJSt4ec40xMad8BsEQKjnIRYgh7/XJJER8d+64r8yvwC?=
 =?us-ascii?Q?OqG+64tBS9HWkGeLeZFZIj6dLUgYyatUijOvPAbE2qGwSkhtd96CLVSkU7p4?=
 =?us-ascii?Q?spUKTl2fXCFZbYwx6klh934BraZl2rt8ZFGJ6d6jAmJpSTSXyECiRK/FVmPz?=
 =?us-ascii?Q?m1a05WtMpOJyCf5Sby/lvPxdUoizk/PI9GyJQ1cc5eKdWz5ElZu8vtGb1zgt?=
 =?us-ascii?Q?CdUezcxiSX8PmFjYRMoIH2ajEVjefO+d2ZyTyz64cLXb4rkCMu3TWtExk6TT?=
 =?us-ascii?Q?TGQBuEHNmfakxkxCHxMq8qEsCdmnZ9OU3m957ZdKmW7wwpz/D3cdvEWsjO+3?=
 =?us-ascii?Q?NNHYvimDk6Ax5TcrQPq2E40wkoImPby5aMnfPNL7MVytY7NpfOH+9FYZkPqb?=
 =?us-ascii?Q?SWjWN7gXLqapv62gyzaIp6xejmPI5O2muAPg0rXpVE/c25aP10QMqTup97NE?=
 =?us-ascii?Q?04TLEwe9qaCMjtIBPx41PwOYToygETHrrj4tq+3Ze4auCnPi5NZB81PYAY/x?=
 =?us-ascii?Q?biPV8HbOjcIbOazSqZAJgBWp1uBZbBwzXWSTlfuJwt2SeR7qfYB2GJ/wMWtP?=
 =?us-ascii?Q?xht5aZawayHp3D89knUqK3Ez9sHyWKRc5FO82TY8oM4QJILnbDTts3cxzXC7?=
 =?us-ascii?Q?WyGAdzSeWoj29tDXS2PLkKWI9x5L8EFoBVCzPssae6BbloEDIKcEyk0w7ECQ?=
 =?us-ascii?Q?+xMOMYgpQuFmdeq7FjbURoJj9mbXeNRgqBPIh5bs6FUgDdHO/D4VIofdoXYL?=
 =?us-ascii?Q?xk9VeUuEWpv5vWovgEp/liFOxcISsNXNM1vUJyGqmUjyQ9CCkNdkdajgiISw?=
 =?us-ascii?Q?aaff66WmB/cF1a6mBe7DFvwJds7BJV35gUHtXNJharKR9I79HQD9NLVr1Mlz?=
 =?us-ascii?Q?+Uh/u9tdHpN4XDAPg4rh1NRF70isIANwP9VODu22Dfodv+PRmFA9fxo0S8Or?=
 =?us-ascii?Q?cVhVlSvGsIIQWah/wxw5cvmzupJI1o6CGcSD7rUwMTF2enoWnJVVS8wz2QMw?=
 =?us-ascii?Q?K93u9i+H94ZZAwwH5L2zfrn9MwsII2+5OQGIq+Co8/MzwNduV1WmiscT4RcZ?=
 =?us-ascii?Q?cZONkpcBPGRY8t3bC7QQxDNbmh4ZRJVvIEh45+mB8GfA1lEtiu7LNKshY0R5?=
 =?us-ascii?Q?F6M26wui7RiFwmOyM0LxJnt36FjqoTLkDUyUL/wPvwrh4me1v5dBsxrzhzGq?=
 =?us-ascii?Q?FldQ5n07BAUwHRw3Tg5mawI8RtqPeCmUbkfhb2eXJW/wboAygBhWVgS2DTxY?=
 =?us-ascii?Q?fM5Fp7iFoTVFDYOHS4ahm8rRF/vvfGwhnepSUWVLqYnMh9p7P3h5vZ+OzGTj?=
 =?us-ascii?Q?4Qe3EWYv3NuqkdcEdv8wXrwf7I2x11SmYbiSUeIHVuLQVWDhN/BgO8BoydXt?=
 =?us-ascii?Q?GIQM8j+Gqngl8ywSJGQGh2c6hICBGji5UGlmTk9evL1jvZSP0x0KnJayuXnF?=
 =?us-ascii?Q?a5DORC+gGsf0gCA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O+x2cMRRgf/jE9F0vR7KucpWix5WTMfJ1UT2Z6iFqkxZ1j97GaJ38fFuYTVG?=
 =?us-ascii?Q?cbkLB074LFAjr9BMg6+6yhCfm7ElmJFLkMdH3le0KgSNasW0HVTupBmr+ca+?=
 =?us-ascii?Q?p/XEgjCBYpToEJl3tGt6T79iYxzcrhxaBYPrfw0cY3ITlumlziiHiVpJHbMY?=
 =?us-ascii?Q?VKIQUT8dKoWClzu+hO25E4NGkwyismfAQus6Ekq5RM9IolRBXFCDMLp5ZCEf?=
 =?us-ascii?Q?bPFuUEcgjpa+6aDYTdh4DSROTQXTAH0y8BuHDZr0wsvHoPzNMuFBCw0Zq8hN?=
 =?us-ascii?Q?YfnG/vxR7d0B8+OaZAwU5T81Wb164f6jQzivtxQq//tCoOe1g9Qw8/J8DDqt?=
 =?us-ascii?Q?c9LcBttBwtPA7sGiLPVmK62wAZBWpB4A/wdVeanfMUVXJTDJoNYSSsx+h5Wu?=
 =?us-ascii?Q?Ofti8JagwkTn0hlw9JwDH1ppKu9E3hG8ItbCgiPJSZ3rzLwszYyz62HqF4NU?=
 =?us-ascii?Q?3QUPW1P6/jJZ6VYnExX8LyrmmuS3TRJTfHSOjh96QXXENjvyJrvf/+suU1S9?=
 =?us-ascii?Q?7JsODS+IY0UzKFdZ+HBha5tpp7riyoBYkL2ch9bsye0/QrEDnw3ovTEU63NC?=
 =?us-ascii?Q?yJq9sZz3Oly9pIE4Qr53jjPGGEXsGdI2e+7afrObpw8NwLnmWIT2SU3TSNnj?=
 =?us-ascii?Q?lYcjTDJ3CTvBfAJhwi42xpzlzfLjFO4GOGbDzH6u1dGXF06cybSqIuXQP/H/?=
 =?us-ascii?Q?mjhtE4r4hnXFJyfpDrcJn5Tzt8wWM22GdxTnOYRYuQ3NO1jlwXBx+FkvcNfd?=
 =?us-ascii?Q?zYbl7bPoayEtSPWaKP+kB0NScJdWvECZMpFD3Pxaj0PtXDFt4gpG4CaHuEpo?=
 =?us-ascii?Q?kohXFTJHq3QWRLvImFnRA9EH9NDjJHtD2ydmjx6ZWO95jm4/FgvLMBpCd7U4?=
 =?us-ascii?Q?Ni17UWBf1LbgpD9qTIbeoSJNRyJbpdvbMWprhZ5GvKl7PNJpTHIFtGpUMiJ/?=
 =?us-ascii?Q?Mo8hNhOjzejMLtgyaGLoFye7HOyP2X5wLwTWjY7wqD4uv90r77Zs6XJCQFj/?=
 =?us-ascii?Q?hCGc5oOyNdbaO3tN80ibi02Na6dC8s/ox1R41fBNOgZ4VH3Sd5k85JfltKY8?=
 =?us-ascii?Q?1w1/TCdi2hnPQMQZHbN1zwvaQpFYx8L28VDqmGfa8t9oLkTxsonvtPZONGK1?=
 =?us-ascii?Q?lMsCI2a9de/sR00vsgYOerommMfnbQbc1iSkUPuZgtGLpsV7WMyQfqs8MbCT?=
 =?us-ascii?Q?g1EW0U5wrIGTfnVeJSoqPLD/gONFyguS3qfv/YvNaJMVW8lc7N0Ka1AeBraI?=
 =?us-ascii?Q?jbz3f8rV0rvceqNQgu0GLV3MI2e0XFtOl9bkE4Ctumah0du52DWTglpxql6/?=
 =?us-ascii?Q?/kmxJQP16xIIthCMK9yXAahm0Hc2y8yTHnbBQRMfjQRu829+DvEjQcThgWu1?=
 =?us-ascii?Q?mKigAleS5AatFs1Pr1xCV4ekvZ1QewqP3/5Ij5EWcGvuAw+7jlzkcNIA05qz?=
 =?us-ascii?Q?GWvnjCf7ZA3PwZ3iMfsuUGiVcDhVW1nkLGtQ/bfj9b37sR0Jn4YIatSz/fsK?=
 =?us-ascii?Q?2JTOynZ+DvhR73SeybTmsldwrhom1RGI1A5IM75h50Q5fXAJlMJDlFTknjtb?=
 =?us-ascii?Q?PKrr52BucyMYBAmCavQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c068f555-cbd4-4fe6-e0c4-08dd87c7cc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 09:17:14.8028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMlluj2Z61T7NJAwTJqoVv35x76YO1eFcvrxB6H6gI5pE8PrJpL5PuHbNozXEeTGLv5Ulkz+AySciBjLu261Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659
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

"vendor" is not needed at this stage.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, April 30, 2025 16:26
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: set vram type for GC 9.5.0

Set vram type and vendor so we can take different actions per the type.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 464015fc2012..ac21197bf0de 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -64,6 +64,7 @@

 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
+#include "atom.h"

 /* add these here since we already include dce12 headers and these are for=
 DCN */
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                             =
                             0x055d
@@ -2075,6 +2076,11 @@ static void gmc_v9_4_3_init_vram_info(struct amdgpu_=
device *adev)  {
        adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;
        adev->gmc.vram_width =3D 128 * 64;
+
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))=
 {
+               adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;
+               adev->gmc.vram_vendor =3D SAMSUNG;
+       }
 }

 static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
--
2.34.1

