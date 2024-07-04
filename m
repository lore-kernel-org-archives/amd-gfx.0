Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B22BC30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 10:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C241710EA7C;
	Thu,  4 Jul 2024 10:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rvTR59QY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21D910EA7C
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 10:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUrZW/jUUQ2FDq+IjLz213iqM/u8SwOXUXj1Rz9xYmEgowvNYsEXVdUnYSADLF4mxI4uozN5IMfqFtMSst7VWKqDE/sN26iCsEXla+uXIU8i5YSF8sPF4QPqbDC1w2bwAKC8UzskhPomP296nZ9Liwa++FF+q6SoaER4MLc/UtmK307g3fUDRhiesdINvtw1bbFGw7QLzlEdM5VGzSVYc4WS08H94PFW79306Wkmz3HaIPQbLeJpdTKJ2JKCoSDRJafXpVGyVcaa8gYDwYEFiQZFgFd6dLc0bV3IlSHhIXqwJiEyXwGRG9vCNPYYBl32yj0eTl9jLD4gjdAVRhj5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oo8cZVWkSEmDKo0K+9f0oMacTLSXVQGcsPwErP27jiQ=;
 b=PR15bHKHxAET8PxpzZWhMb9GqOP1ky6Z5T/Z314Caj9I4W1zt9OxLtx9b/iDK+42zvzH6GzFwzq0ilhRTOvgBZgjG1zixc4hKdrU2BLEUD2+gx2FU7/pjRvYyFnQY0kxPqanqtOtsYeSCDP1jaigbQuooEhey01lNDKNVZ8f4uLQeA+/Y8NcN30anIrckX8egMliT6uKna4lZbOJmRf3jTOD866RWKaKkIeTWCUE8uwW9PMfpGb9IPKnQLQbAM8QKFnN96zyhVU8We+t41NrY4W3zxn2sT0I6h+HYUkKO50pEWboqmQQbYvQbeEXfdqJLX0j3prB6ZtAsZH18PfDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo8cZVWkSEmDKo0K+9f0oMacTLSXVQGcsPwErP27jiQ=;
 b=rvTR59QY4k44CKUCEdo+9it2qINu4TQIS/ux3pkTKsgUoD+3ac5sH3C4eRTNReBsIbQdSMXDlRUcG1Q/QTVYrYzy072dDugHmSkFMJCakLW+9FLU2kPbzJp37m1F96wWu9mj1g1XmSBl9jLbB+uFcfbdN6VNSnwjUDs1Ur3TOto=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 10:21:04 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%2]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 10:21:04 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>, "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Jamadar, Saleemkhan"
 <Saleemkhan.Jamadar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: enable dpg for vcn and jpeg on GC 11_5_2
Thread-Topic: [PATCH] drm/amdgpu: enable dpg for vcn and jpeg on GC 11_5_2
Thread-Index: AQHazfs6ENKBSGbasUWULvmN/Pn12bHmW67G
Date: Thu, 4 Jul 2024 10:21:03 +0000
Message-ID: <CH3PR12MB8074755C2101F02731362AD0F6DE2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240704101436.2303041-1-saleemkhan.jamadar@amd.com>
In-Reply-To: <20240704101436.2303041-1-saleemkhan.jamadar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-04T10:20:40.8729620Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|MN2PR12MB4391:EE_
x-ms-office365-filtering-correlation-id: b423c952-4721-44d9-7e77-08dc9c130284
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?K0LPncDXdK6SmG2I49qL00TUVMNZ5imBjL+asqzqOWfQgC2//imfAmWoto3a?=
 =?us-ascii?Q?09GBsuoJ9MWrDv8n+uhWMBO5YEiMYMYyYjDPycq0x4ETI/GXTb0b68gopN3J?=
 =?us-ascii?Q?bQ8y124dyzW3Nr/yurHIbsiIqf5L4Uq51oCTYFr/XnoqPUXPrO40CkDJuC8J?=
 =?us-ascii?Q?3MQDqydFk1WJ/OrVQy1YQAX7kcq/oMvIB2w0QTRHdzZqHBoOZMaVCkCg08G0?=
 =?us-ascii?Q?sN1gcrOqdsy3Peo809omIJNDZcyCcoVLWgYf9lyn5AHYIQdcDIc0WZRWcSB7?=
 =?us-ascii?Q?gA4dguwxPJzTuqCVnoQywLcj4D2OIJ9kgoLlAsWHe51tQdeji8FqVzwyqwyt?=
 =?us-ascii?Q?fj96jPfBMo1kTK/xWE4HH2Hc15aBi2LdyW1QTbSEkkoR5+zpW0lXnuq7L/Oo?=
 =?us-ascii?Q?xiR88BJ0GsQ3cGhleuscViM/aTJ+MNYZUGc+4dwjuG7eOw4dzwUnWO5J873u?=
 =?us-ascii?Q?0XPVzwSmtUCr+ZB/JYIGgkFUeJMKoe1JjDQdYQulcamVPzuEM3YrM1MIdZ+i?=
 =?us-ascii?Q?6b5eCIh0vESRu2k7bsu+PtCPsy6Eu4SWP3/wRKP0uClwtb4fZttsfaPpsju0?=
 =?us-ascii?Q?sX6Ed4vCvz4CEDO6OQigjdEK3Qou/5l+Q7qD7AMGQawxGQIkxcLDxzbqkIrQ?=
 =?us-ascii?Q?mIU9MRu/QSZo4QWjv4xiQHZ2/ydNewhtaftzMGa5pFkqzxpeYNcMnaCV/T4h?=
 =?us-ascii?Q?NCsOkAAM7xmOd3b7A/AYg6BxnPSa6ee04aIil3mJQV2e7Q7s4ZI6P/A6wL8L?=
 =?us-ascii?Q?rtfR9OH7mFDd5DCXaK2AKQGqy/RccMH96eaapkstFBerskUMXgiir32NyvO7?=
 =?us-ascii?Q?31b70O8up4LF16/Wz+Oux/+WES2MJreNG8JrqQcegjWorLnZpFSnriEyVv4+?=
 =?us-ascii?Q?+NfZC0YWw7v26h6gZPEG2Cm1VP/foL4uU3twrme4R+OkMy74maaFfFjs2VzV?=
 =?us-ascii?Q?LcID3Dh8eI4bszZALcCJ0wPDlwaBdRYLjXt8x68s/+FUI/6m/LZ2L03/4NRq?=
 =?us-ascii?Q?9ql0zjBd+Vqlcaj0WXddsRMgvw70Zz1+0z5VODFRrSYByg278k9dLEDGel74?=
 =?us-ascii?Q?uIm2QI0p2X4OUrHFwr6UmM5AHV5Sw9Iwv7QxC+9gQ/JhkeqFbZZB9eqBzn9k?=
 =?us-ascii?Q?uqyNWGO2ymjsMb3cXHbtNRrw8YQmlL3mUQRWvpltoY433AQRTOY8p+N3dV6f?=
 =?us-ascii?Q?iQZDTt4gTnJwVu9nhtMlD7Wset0yR55ZiFfbYwdCYjbGX3Y4kJU0m8ghHxfi?=
 =?us-ascii?Q?ZlwvBiTYclRqkcS4dXekDlk4H/Xx6Ac/GZ1594/sCxhCaZrorghRl4dmxUXg?=
 =?us-ascii?Q?xHeIY5LRMqWxdpamgDLeiuGpd+e6Vb7EwYAinq84ULFcWG05bnnY3sgm1l4d?=
 =?us-ascii?Q?+5gX5N4R+8WOzcKAq+k2jLPtsKCDSRZ20GHWSOs+XJ0vWrJO/5XA1IXaPgvd?=
 =?us-ascii?Q?QHvDl3LyGG4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xJaNaD0Iealrvn9FQyqrr+O4e8slQz4snRhwhscVij//oI7fAwyhN1iPhl+0?=
 =?us-ascii?Q?ASw+dgPPST9wHI0JxBlEwsTdKRxLVL7ZBZHlLGaWpiQF8w8DUt0pmAVBIE2z?=
 =?us-ascii?Q?p4or55EcS0q1EUDxAlCZcKtX+lwJI6OeACMKJOFnflJU928WFTDh1lDbYiWW?=
 =?us-ascii?Q?NnpFxcj2rl8fazn47l4xUo9wfj2PS0Bd5ODGR7UOFZpVW7fxRV5tKoAHxMyj?=
 =?us-ascii?Q?t9+rc15GftClUf7oXERgoluJX6mM77rZP2CXv6ZHcxzx8JH9H/CHRGBjbDG/?=
 =?us-ascii?Q?pIsGqsrvKJE8itAOBHTUK4cCHejo4dET8aSbShLDAH3qZhGJTnyvz9/JtKmR?=
 =?us-ascii?Q?jzlnC3CCXn2RhKvXgcOAn+oXTVmx1q44mIshuCya+UcVSqf/KQW8cbUEfV/D?=
 =?us-ascii?Q?qqMriH9+YkCoXcOyGjjPLTKciLy1JvQ0MPhre+X7B5FOA6n6EGlwleUDyZz6?=
 =?us-ascii?Q?O7dYcg+rkM+F0+rTIUA64FFbD6fYmUtoywIWs4NcxCWIWnN3D2HW0wM1YkqN?=
 =?us-ascii?Q?lX9qGDPlo8pn4ZtZ1GIxbbyxBNQYgRX5EZp1nDbGzzkIUl8aYrn3eq7Z99k4?=
 =?us-ascii?Q?ieG6Alc0RWAIbC5sU+FAFnZWc5kMx0Eg5DSp4VGCQJe/ICMCdE6H1rdgWq9y?=
 =?us-ascii?Q?OX6igFA7FLqX63aaPdJs/SAbFlEMlyEaRUG5Kge1YB07QChLUZBqL2TkYRrB?=
 =?us-ascii?Q?qD4XN1YlBzydybdGOqoOp0toHhdlnEkd+zVQO/lYw2Fp7gxTmXUIQahrzmU+?=
 =?us-ascii?Q?02QMM+0mCrOP65Jjssd3QeTnK4Y+22OX0Y1Gj0qXAxjB5i8XzsHoytrO8XYh?=
 =?us-ascii?Q?wZGiISzUNzpwmlVEW0Rt1VeUv7OdJKTN6Ye/qC5aCmvuBKVrrZeI9IoD9HFR?=
 =?us-ascii?Q?3f6NXlzjhOoP8Ixbn/s2pPtR+LcmZXvdL0yRKRtt6yczcrnglff0mekKybuO?=
 =?us-ascii?Q?2fB4oUjRzQt0cVSW4uYKLACE49ZJAJhsbfGsfAKvtPZKkrSC7FdH31wUxx0a?=
 =?us-ascii?Q?dI8b/t5BEPl0DDnBNes4wDu7KDy6LJlwWuxKLtern2rBhJKa6wWeIhk1Sumu?=
 =?us-ascii?Q?y49k/vMSiqcStXBjnxzvPk8RwyVLRAgK+QVvLEECNDwz5SjG6o3E6n/t4aj3?=
 =?us-ascii?Q?59RlGFQwXacB0/y0VcjsntfPZUwrAUj8wsfTY9OQ52Spg8Pe6omCTPCe+443?=
 =?us-ascii?Q?3ced19hk7Y4yzUquh8A/j3DR56VNbT6E5rNRw/spbqa1iJJagBn6cQcli7c3?=
 =?us-ascii?Q?OpdrWeAjoQjMRPQedRf+9IlLxuLd6P5GZ0fX9woHerZ8h0S+iP7XNMCfZ6iM?=
 =?us-ascii?Q?pgFxTV/xoVy+j8NbNTbIAJVYXuRuKThElv5B9t+LzMxqnKl2poNZDFYQAcVP?=
 =?us-ascii?Q?YkL/b8ub2AJOwSsp6qbLp3jrzHPKiPnwVE4bmtTKGd369tbJ3ACAlH0UiIWO?=
 =?us-ascii?Q?1fDgA9RZES6JbvRq6s1BIQVH/+Uj+Yrz1GoiqQmj1bBx0PJGHp7xkXNujQTl?=
 =?us-ascii?Q?d51Q9AKhoxusB8M3TyRbVQNVIDymSuMxMsiKxn1bnt0pKKgG17sOfAcw2Rze?=
 =?us-ascii?Q?BCRb41nzWUHKhjyULbTocH16mlStFH676Ci/8mYA?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8074755C2101F02731362AD0F6DE2CH3PR12MB8074namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b423c952-4721-44d9-7e77-08dc9c130284
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 10:21:03.9719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJXm/LlCjyH2voQFjQPDOAtdiHo7qSIRjIGMalurTWLgXoGSomKGmM9JgwQoNP1rBYN8FXJ3Iq4Y0SE1hMD/eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
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

--_000_CH3PR12MB8074755C2101F02731362AD0F6DE2CH3PR12MB8074namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

This patch is,

Reviewed-by: Tim Huang <tim.huang@amd.com<mailto:tim.huang@amd.com>>

Tim
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Saleemkh=
an Jamadar <saleemkhan.jamadar@amd.com>
Sent: Thursday, July 4, 2024 6:14:36 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Jamadar,=
 Saleemkhan <Saleemkhan.Jamadar@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Sunda=
raraju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>; Gopalakrishnan, Ve=
erabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Deucher, Alexande=
r <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable dpg for vcn and jpeg on GC 11_5_2

DPG mode is enabled for vcn and jpeg on VCN v4_0_5

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 6cc86d13f32a..d30ad7d56def 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -774,7 +774,9 @@ static int soc21_common_early_init(void *handle)
                         AMD_CG_SUPPORT_IH_CG |
                         AMD_CG_SUPPORT_BIF_MGCG |
                         AMD_CG_SUPPORT_BIF_LS;
-               adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
+               adev->pg_flags =3D AMD_PG_SUPPORT_VCN_DPG |
+                       AMD_PG_SUPPORT_VCN |
+                       AMD_PG_SUPPORT_JPEG_DPG |
                         AMD_PG_SUPPORT_JPEG |
                         AMD_PG_SUPPORT_GFX_PG;
                 adev->external_rev_id =3D adev->rev_id + 0x40;
--
2.25.1


--_000_CH3PR12MB8074755C2101F02731362AD0F6DE2CH3PR12MB8074namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto"><span style=3D"font-family:-apple-system, HelveticaNeue;f=
ont-size:14.6667px;display:inline !important">This patch is,</span><br styl=
e=3D"font-family:-apple-system, HelveticaNeue;font-size:14.6667px">
<br style=3D"font-family:-apple-system, HelveticaNeue;font-size:14.6667px">
<span style=3D"font-family:-apple-system, HelveticaNeue;font-size:14.6667px=
;display:inline !important">Reviewed-by:&nbsp;Tim Huang &lt;</span><a href=
=3D"mailto:tim.huang@amd.com" class=3D"ms-outlook-linkify" style=3D"font-fa=
mily: -apple-system, HelveticaNeue; font-size: 14.6667px; color: rgb(0, 120=
, 212);">tim.huang@amd.com</a><span style=3D"font-family:-apple-system, Hel=
veticaNeue;font-size:14.6667px;display:inline !important">&gt;</span><br>
</div>
<div><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Tim</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Saleemkhan Jamadar &lt;saleem=
khan.jamadar@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 4, 2024 6:14:36 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Jamadar, Saleemkhan &lt;Saleemkhan.Jamadar@amd.com&gt;; Liu, Leo &lt;L=
eo.Liu@amd.com&gt;; Sundararaju, Sathishkumar &lt;Sathishkumar.Sundararaju@=
amd.com&gt;; Gopalakrishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakr=
ishnan@amd.com&gt;;
 Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable dpg for vcn and jpeg on GC 11_5_=
2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">DPG mode is enabled for vcn and jpeg on VCN v4_0_5=
<br>
<br>
Signed-off-by: Saleemkhan Jamadar &lt;saleemkhan.jamadar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-<br>
&nbsp;1 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index 6cc86d13f32a..d30ad7d56def 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -774,7 +774,9 @@ static int soc21_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_IH_CG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_BIF_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_BIF_LS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pg_flags =3D AMD_PG_SUPPORT_VCN |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pg_flags =3D AMD_PG_SUPPORT_VCN_DPG |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_V=
CN |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_J=
PEG_DPG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_JPEG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_GFX_PG;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0x40;<=
br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH3PR12MB8074755C2101F02731362AD0F6DE2CH3PR12MB8074namp_--
