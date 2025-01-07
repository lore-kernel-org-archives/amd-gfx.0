Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342B5E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 10:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A238010E219;
	Tue,  7 Jan 2025 10:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GaIRRXkG";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61AEA10E219
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 10:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GohE1qJ5WFlKuabD1ECU95Owzwr4IdAfEmF0X5ToSTvu+mKqIQrmk4wfF/1jub+Mq7MKKsnSbSwuJULVadAddwOr6K9zd/W24WqmJUcaIeZ53fd/7U6crTppghmpiwCp1W2u22SHJOTkzug6OxlKvFfH/+WvPAepnIl+N5yMTepiX69V6Gnvs+zRJQ5hzorzYUk/+SXJdUlULOeuM51zJYt0TrNXYz6bljwEAsccSQF/OhoMCQYpoN85BQVN2fZUjfSLfelcdWD+z0fVFXrwAmNyr++/JxvbB9zi0LZWyq3G7v5dQx2B2f3tVWV06UzVykQMq+1HmeQ9qjyjr+GW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwkn/pG17Co6epo/5gpjR9hAgUAz5jr+EU/eE/Flrr4=;
 b=c5u7PHYPt6M1D7xBXh2igPO58E4RHnXujBM8BFSkAxx1OmHHb3rOlIZk4fj5Wjzf0KOEWsyMY2Wle9ou9kazrCjziJuLWkqRMJET95LFj+qOijU7jtvh30sK+1uauMhwL5ji0rZMUbefYTnhYH2wczs5taNfi+bmMO8YB7J3F92WVPgYF04yIsCRRr3YtMLPPlIaZ9vHGQ+F4Vb/RY3AjUbP4aX2rYQD/mxxRikoV4SVAr5R/YRhc6/xWICWub/4N9jJK2YhvVRnroBaH0t7bTD0RNLSAGDnLylzhallmj2mcp+q/WZG06DG8ckllwvRG+8+sokK6fKYKwBW8pg0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwkn/pG17Co6epo/5gpjR9hAgUAz5jr+EU/eE/Flrr4=;
 b=GaIRRXkG8fc9EObxYEQFhfUPexjskKkS+wyzKkauUQydKGGtDXfCqVkee1KYncX11TB7Pg4HRzYWPe1wD2z76OE28TVe9A8GrxrNovG+EmntRQJwcKA1y/LJTvX6QKKA5npikID+ynpPcQJ63i8HT+Prwh9i4BQhN0KL1KjP+sU=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 10:30:58 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::bcdd:c459:3f9:5bb4]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::bcdd:c459:3f9:5bb4%6]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 10:30:58 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fill the ucode bo during psp resume for SRIOV
Thread-Topic: [PATCH] drm/amdgpu: fill the ucode bo during psp resume for SRIOV
Thread-Index: AQHbYCkeNVN2Ji6GCE6VnXgJo3DA6bMLHg9Q
Date: Tue, 7 Jan 2025 10:30:58 +0000
Message-ID: <DM6PR12MB434025D1C3EB42DC7A2E17CDFA112@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20250106105228.2121987-1-Victor.Zhao@amd.com>
In-Reply-To: <20250106105228.2121987-1-Victor.Zhao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f81d0950-7dab-4f3b-a443-0d8468d63fc2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-07T10:30:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|MW6PR12MB8757:EE_
x-ms-office365-filtering-correlation-id: 9f99730d-bd20-49c5-6642-08dd2f066039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OT2qJO5cEYwkpDezBJuYieHE4hHYemCddPAvGu/ONouuSz+bBY+06LfjBRJx?=
 =?us-ascii?Q?Sv9VMXiNelawsL9LLZH4riVnhBWo4WF6BntJM0KqPYxSEoeFRvYqjRubr5R6?=
 =?us-ascii?Q?fsG0fe13JusCfmPb8G6xggrJUN5cUZOdM4kiVF9aoRsM/4bpog/cUhdkjKgO?=
 =?us-ascii?Q?EK4cWcE1XC/CG8t/sxgEB+fHmuPGSpPRCUNfsSaL34kKRtnvLhY1HtMtRWCt?=
 =?us-ascii?Q?QpTJsjR5hD6ac5n8SPpee8xc/OberDRmELoFebICPqhdyWlK25j9GIUY312m?=
 =?us-ascii?Q?EoHWZJrvG4WDC9H4QJRYCHIGyq+ZDSlqdAUU+iadvdepFMPRtox3mZpsFqoj?=
 =?us-ascii?Q?Az+tMuZQu9D0ObwR75+KSolad0uTehPwzQJ1z4Xt80OgM0XwQIklsYFGdtAu?=
 =?us-ascii?Q?sPL1ZbGVEfGcKCLCrrG8G0JCcPRrMgxuizGhFdwxvVsuhMuaUdXtjws00heZ?=
 =?us-ascii?Q?h3pu6m3ulfU/AzoT9GIk8lBfWnp0yvPuliobkbqi+Rmhv6cbf0w/+SYtMrkJ?=
 =?us-ascii?Q?+2uuEgeWXQtI9ceEW2HJt4sK/xZ5aFzSG9xjJRsCf8t3QnIDe4bGYDcoWdLh?=
 =?us-ascii?Q?DZ2KXcH5BlnJzNNhK0IRKL4eB5Crfbwkhp+q0iYh4HBQVkZ78IfS64n+PDEi?=
 =?us-ascii?Q?f9Em0MHF8P6RAZMGbl+U0OjieBNszG1+HcRF54AZV6cji06uY0+Nip4EEbn5?=
 =?us-ascii?Q?BAEk6DYYg6AKnGyt+uTXfyrH0yw4EZbCIqZw36bdpIQh/ajIUxhdwvXl2yQt?=
 =?us-ascii?Q?kj4HfSD1EiULlsN/G/A/cf2doTvuBMpDNjIX2pydEtl8FpiTVvBMU/m82txL?=
 =?us-ascii?Q?vpKP1JK59U6VlyKAmnmCkVJCQvqXvNbuhRgPQYeIYCYE2XqR3w9Sg2uJG5Ks?=
 =?us-ascii?Q?fASKbqk0lb/YCmykIG9tp477TTRg//RSJWPaUiSwUoKf+DA+YDYFKLh/EovV?=
 =?us-ascii?Q?e+Khjam4sCzkV0/5s1j8KIAK7C3GoAqkgKvL2i469AZg5fXAdyg6dOH7SFH4?=
 =?us-ascii?Q?Tc72pEgcuafgi6Ca7rLmWFd/U7sAJbEromgBCkv+c4LY49W40tY1xhuHJDyc?=
 =?us-ascii?Q?L2m8YhNCJRYRb7sO8eVpaBq8pRJJpLD7K1tbDiE4R3mdiglesVw8TvmtbFXL?=
 =?us-ascii?Q?gUkNs83NqeBs1Ah2S5uWapFLEas4/vDLKyRUFhd3ovdZ9xDaU5dOepv5Q83z?=
 =?us-ascii?Q?lf3f6JJ4ffiZBbHOYsHOJXQwUA4Vku/OtDlmgAFlNec/sSsl/BI2z5Ky/fqM?=
 =?us-ascii?Q?1WUPsg5xFNQhkisvxwZ8qqYdnaxZ1DUu4NKjzuIq4KjenE2BwcecRSNiWdwF?=
 =?us-ascii?Q?SVuNNtwE3metP2e3uzwwP0/vqjsWyuQpLIrlJPF4F6RyBrA9/bU8cUWWxdwS?=
 =?us-ascii?Q?M3gErY51lwBmGmqgQcfvZA2tv0TS2ZNKlzF9XapBiI/nEynK8i6nzstN6yhm?=
 =?us-ascii?Q?XsoiPblAjznyjwDJRGOxRXjuUmiLrUrN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zjKeCHNrFh4siIy4LMENycnkbZYnUNice0icwlbydwcrB7qbZ/0628FVn2mD?=
 =?us-ascii?Q?WQ4qAqii9sab82quy9r7cjFNA2oPf/fJUwz5G1KvStAUk2J02bR2uaVqS3rD?=
 =?us-ascii?Q?xKkRcDzRI3NE5wdu+gFbnheBRA1dmHDaOpe1zZ0JhiH275CbFVvNY/7jkhZq?=
 =?us-ascii?Q?Md3ppbt4GWc0YamdiC2PYOL2GDSysmbnatBlk2uZJQUuG4ukw3n7s7gSaljU?=
 =?us-ascii?Q?6SA7lOXpO4xfwhb5wZQtcFRnZHnqYjECBl49aB7KEmmsSqD8i2V75+AB2JtZ?=
 =?us-ascii?Q?5/01hPzDNCuezX92VF8D+7O//jNaYEVCw7+KNUI3SVUdzswv2cafFX8sVBzA?=
 =?us-ascii?Q?l076J/pAZ6wXdo+JCebAmVLSI+HqDUbw/G+tyiUb54PfWGd4tbT1uxOGrUYz?=
 =?us-ascii?Q?VU4cCHtG1icjcLPp/i8fpldPuL0A17UI6ZMe7spmYvoPn0j5whLXMHcPtAWv?=
 =?us-ascii?Q?cza30Fs9osglFW+v9Ya4fPWJMSWG5hiJp8KIQ74/FPjOKv5Ojy6yk582xRy4?=
 =?us-ascii?Q?gvR66H/hAlLzIXG5fi/Bk1yFoGs859t4cWRa7ZqTJggiGHJiPDtu36aEpmM0?=
 =?us-ascii?Q?bJwZ7tJtFUr7jwPYBcz6n0dGlmY5/7qwaocfbKclcjmA/JSB7CidBLoMOjRD?=
 =?us-ascii?Q?lUC/kNQlnhsruqT1twugiMniN8UHoxJZtAePiu6DFT/HnMNMiICy0vd1b8Pk?=
 =?us-ascii?Q?VGozPRrktnqarxB4u4bUzu1naHfI58Z6TVlhufdIQQ3KdGxHraK/ib6lhIkz?=
 =?us-ascii?Q?q1oT7o9TpuC4fTfQatZKN6/HVgHac6YL3AR1cNqHF8MwCa8zffISSAcUcWk4?=
 =?us-ascii?Q?K6vdr5YBptPpgIdVOeTScAgPJRt0kWGZNws+6FpSPjgOwlniXjDv0JcnLGsn?=
 =?us-ascii?Q?4FQvkr/njxU0+bwPsl3GxWlNSXB//FsoTMomz58FDyxnpk3cxGUIVKTTuSJv?=
 =?us-ascii?Q?DdnPHxAn0QeSx0OLRZNLO6GWBHYcE5jcKaEEY/six8FKM46A0PpHhCxjnoJR?=
 =?us-ascii?Q?2ylGheYrpw8ZAcf7zTMyNrr+6SoLzvURn0+mvr1toz1KQvoIdFDhDU3diFQY?=
 =?us-ascii?Q?MdhIFCmpidJ2Q7vpNx/magP7Xk/SfeWJO0CP6a8RGweiH8Wv1Wr2TBDmZ597?=
 =?us-ascii?Q?YjT54ndiXTg9VLtbXPYktz/NBEWfTl8eGT58MlCZ1CABNdTFC4avD9H+J8uM?=
 =?us-ascii?Q?1oOZInrBJ5YPCL4QSueTGrA4+C2CNgGYMPWdr2cXlTtQHh9z3sAjv8OMmwPG?=
 =?us-ascii?Q?J4H3KFf5A8oshqCTR/mXSnKdhLptjAmmEsYNWnUOPTrwCKpbmlsLSfqM++Pz?=
 =?us-ascii?Q?y7yPI7wRBMA0GEfikIAiXTPq1MtJd/LE8MDJxOfsKnqsg57fauPck2RUIEyO?=
 =?us-ascii?Q?LbIZRg7sr8iJuNCZ5toNfahuOkHJaIIQpguXTTVg8Sc0uM9Y1nVcGOSMwBS4?=
 =?us-ascii?Q?i1uxLZLTEl64Epn4yYYoSyxksp5fxKGI1/UHT4Dadgwq88nmdlDiT+E4MSTC?=
 =?us-ascii?Q?jJi4z2bj7J7M4niuMioIADwc6xI5EY0pn0B7i/Rnd08bQmVqnguuhM0MokL3?=
 =?us-ascii?Q?PR/+2WNXq9tmUgclpE0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f99730d-bd20-49c5-6642-08dd2f066039
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 10:30:58.6890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AaMH23+ZUDneBzyi6m5CVZXVBXgcK9p2r/GCGSNbIP+pupRJU6toF/gjgJgMMJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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

Ping..

-----Original Message-----
From: Victor Zhao <Victor.Zhao@amd.com>
Sent: Monday, January 6, 2025 6:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: fill the ucode bo during psp resume for SRIOV

refill the ucode bo during psp resume for SRIOV, otherwise ucode load will =
fail after VM hibernation and fb clean.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 010c038b33ab..97fdd93c3ae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3148,6 +3148,10 @@ static int psp_resume(struct amdgpu_ip_block *ip_blo=
ck)

        mutex_lock(&adev->firmware.mutex);

+       ret =3D amdgpu_ucode_init_bo(adev);
+       if (ret)
+               goto failed;
+
        ret =3D psp_hw_start(psp);
        if (ret)
                goto failed;
--
2.34.1

