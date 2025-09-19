Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FA9CAC5A5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 04:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1F9A10E0B5;
	Fri, 19 Sep 2025 04:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="daKAR/3r";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28FF810E0B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 04:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDAVgjjTzRLWMWYiOOxImCnEK1FiKerqw1nfGJs00Qd/F2ly7+HsyOqQUgnTWG2PJ06ivFH+a1lCbqi8PpC2V2N7jj4O+LhdPYiuo5UYIC7oGbzC8j7VcjJeImcUJv09t4NLWPs+3JkJ7ohFxtA0ScY2lCWHMpYWeTbszyNNu37kx3PTgIuK5N7+uzUPQT62I42/eIN48KszKGQSZaCmg9wQhN15RCmXgiTtdkk9aj0o719UKUcL53lSMsU0Dn2I0CQCe1/biBGXBlUCyM+phskZagNhFsZprQOXGpFLgIsFBTxx5O2rpwvai/xI2mqKdrjZyPRPaMhoakXWHzHqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBOnxo+rJy2bCKxt5c7s5E1Lzhk99AKWAfWJtEUixsk=;
 b=V9FAdReYFo9sWFMjjvumPQzb23rX4UNTxb202r4k/rjfnIABwRKh9N8jhJk6ucaY2C9Z4qg6/2REDRnoEi0mPqLi0zQ2Ivz656ycChWze60/wesCllNm/TLFIxCGy7UzeANR6KdlpbY6jg1jJLxTL/XejvlBBVK38oeMAo4Py1o6SEmVxTaJ95tk6hYOZE4LQxYuwcOLECzX54vUdvn1SPzmOREWKjIVk5XASzUi5Wnobq+bzyb6P+c9xzUcUvFvTXBYoIveEo11ZUnvLKX04MTZYxqYQfh1cY13FTKWDPv6pMn52vewBHyeurMrhjXx9vVa9gDG4dRbGZyXh2GItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBOnxo+rJy2bCKxt5c7s5E1Lzhk99AKWAfWJtEUixsk=;
 b=daKAR/3rD2m600mo2kTiT/ONEBxRBjIOOJ+/kN1E38DGD7FcNE70RhsX3sc7d4YLBIwiB+vHweVZXFSNoQ5xWTBEuhjR0X5kpAT9zyL1zfPMIJz6p+tQSdXUpkOnHbT2AKw1Wz5iLQ7580rYeXCAnUJJJdt4XrbmJ+d9gOGF2j8=
Received: from CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 by BN5PR12MB9487.namprd12.prod.outlook.com (2603:10b6:408:2aa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 19 Sep
 2025 04:03:47 +0000
Received: from CY8PR12MB8339.namprd12.prod.outlook.com
 ([fe80::e269:bb1f:4872:538f]) by CY8PR12MB8339.namprd12.prod.outlook.com
 ([fe80::e269:bb1f:4872:538f%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 04:03:47 +0000
From: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: place the smu 13.0.0 pptable header into the
 correct folder
Thread-Topic: [PATCH] drm/amd/pm: place the smu 13.0.0 pptable header into the
 correct folder
Thread-Index: AQHcKQdxvuiKlDp4pU6gGYMTZMLpk7SZ4hFA
Date: Fri, 19 Sep 2025 04:03:47 +0000
Message-ID: <CY8PR12MB8339EDB0793C39F3A374CF36FD11A@CY8PR12MB8339.namprd12.prod.outlook.com>
References: <20250919014657.2699900-1-kevinyang.wang@amd.com>
In-Reply-To: <20250919014657.2699900-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-19T04:01:23.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8339:EE_|BN5PR12MB9487:EE_
x-ms-office365-filtering-correlation-id: 30b67647-7fa4-49d2-ad6f-08ddf73188c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Sn9KSNQ6qYEgc0wbpPL+5/d3987A8KJgMeCiMj1WIErsrVE9VG0onlX2MHRO?=
 =?us-ascii?Q?nujHk7bKN8G5D8B1Ud4iACrcgybsx9apDvY/TZK9mmfbopUYLTrhGcB6jAuF?=
 =?us-ascii?Q?5SbK+t52AwRXTZy9xjFC+V8rRplmwpSGlElIc5wnx0MC2LvZlRHTjHrB71jn?=
 =?us-ascii?Q?1aPJzAu1xJGh5JFKlGdzHjSv7FdagqrJ2biXs/YZ5jlPZmfngQ0u0Twie3n3?=
 =?us-ascii?Q?S2YwLXcr7cWW90GZEBKhphonEGScxMF7gO6Zebhd8/ohBsmmZxBCun4oKxuh?=
 =?us-ascii?Q?5T5bYy9xsq7frqyWIdP9KW5Fxt5jvLRJnmVpgnbPQTzXePpqL1R0yzvJjHt8?=
 =?us-ascii?Q?E8Id6B5XxTUWJ5/kzYH9Fg8FwTe6AedZNuWcq9f0dzg40ceAwycz4fwSf3n7?=
 =?us-ascii?Q?raAjEmkb/DFa18KluJ0e1UZ4bJlpFM8dYwJpIl6COwZLuGp260awfb0RD3kW?=
 =?us-ascii?Q?8UXuBHIuQXCH+W50uQmVXQIILnW+mLIifVEUtZx+rZWxYtF4jXL7Ehl5jT/Z?=
 =?us-ascii?Q?4EDm83U0eRG2irraDz/V12TzZaz5fsD3y5NyAMN1qcFgYPYEuMg6oZGpABo6?=
 =?us-ascii?Q?ged9HswcDr7/R8fxyQdUC/2sa01xKbfxbAZzDBqnared65el18VQwEj4M2pp?=
 =?us-ascii?Q?f0b6JG2igSrIJ5Mtocnmq/njdpaIR2dHTtLVsHZYpIT9nnzOlwkQno2mVZzU?=
 =?us-ascii?Q?LZ1zzY1Yv1svdo9WsGyXWE3J71RQ+8Tli/EekAuGH9o72UQEyDfBr+ZESNnV?=
 =?us-ascii?Q?eTM/sHW5a5R98zcirnj++6/2FJ+dvv9pttFpywVnOidiR0CKRDwStnZj0a1O?=
 =?us-ascii?Q?IPvZ7Jp0kLfoOI8bEE1OWsYY+JsKytjoQ8LW+H7GTOOkdHydzBF40UFeAsQU?=
 =?us-ascii?Q?1yXUMHuHpz38GIRlHt2I/aVZ6D6rLHmulYuKBDu4h+ssUL92/nvD4KXtnyeZ?=
 =?us-ascii?Q?adQ9QakN2kGev4MkVulkExWYssUo6GPlzGdrLMVkeJsD65qIiOttwWXgKXUD?=
 =?us-ascii?Q?bKNmZOP/PxSdpf7iC0nGmAfkR2ERDkJKoNxZgTB3hchYVSIMkbBplgW71LUK?=
 =?us-ascii?Q?UCNuK3Lyiu6KdvtvCn/1x9g6Z7iEHN8EjqqSDq9AOc926EoKG5qbyqp1nvlx?=
 =?us-ascii?Q?2rdVnMyXFRYuICSidmKQ4dyf5cl7qP8usJ1WF2e/SUc5hNXvWcuM67raBfap?=
 =?us-ascii?Q?EqpHq0tk3V5ZEuOHio8BVE+3qJ2zlzuAw+ksWsquRtCy7ifnhjyMgoSJxU7b?=
 =?us-ascii?Q?xXgJzevFbmi73BEeCPjghQoywDCgkG+vNADwSLqfeEMEuOHZihLU0x1k+4ID?=
 =?us-ascii?Q?R0PBmcCth5rkE4AyYOdLbNZyg67RKpNnu2nERA6HETXLVlcf/+g1Zj1aGOwm?=
 =?us-ascii?Q?JFSl77PjmVy5q3Rgci1gg/np6PbvzYwilJA8q5MEwPcaN1u/wtZjPVS95h6B?=
 =?us-ascii?Q?DVMQQv1f2EQ8s4yhO1fPofeq7yGzeJWdrrNhFO6yphmRCxCXsHDfhMtXuBGH?=
 =?us-ascii?Q?Hs2M6510x4QICps=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8339.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o/mNT+Uu3mZqBjohqJ0tl59vAWGhalAZ260l2c3Le0BDO0qYVxnuBpZFoeiO?=
 =?us-ascii?Q?0/cQCNqCKPYvKXHkKdghTuCxRtYImzHZdJYHIlGdQBKUcD/bpf3DBhhB/PVF?=
 =?us-ascii?Q?Ggu5oGTCfpQ4/6wueSe6GDnNS75diz4aIhh8W1pVH70qyoI40WLyAT1mxv1i?=
 =?us-ascii?Q?sp3ew2nfU04PrgSsxbpbdCuM9UgsxWNNol/1sM1ZySjr/J8PRZQmapya0hyE?=
 =?us-ascii?Q?m3mwVRGLzz40YtLhkEyeFM944VAAgd2iUzhiFKemXNwh2q8w0Y6+MCAYbh4L?=
 =?us-ascii?Q?A2LxQhYmkNjoHmkD/BMw9WxiuLGdw3Ua7AZIieuW8SNo8BYgtNSGb4ErBDmF?=
 =?us-ascii?Q?mFITV+zCmLcxguKK2aanOneM3CsPPRBjTmFuxEP2R6+f/0RbUJO/EmWjqRLR?=
 =?us-ascii?Q?6+XZ+UjBmwZQuqbA91Ot8E9BexBP9BZ1tnwXqJxqLfCdDTpyiK87F05c6v9t?=
 =?us-ascii?Q?Jg13hwxjm1W7NmARjpCeF7d4E/VkxNRupK3kDPjswCWHGPVgKjwajyvdLarF?=
 =?us-ascii?Q?cQQeTor18BTmuqlZkY0qDLzHkQ7tTFb91wYftRArzq/ETFHUxoGQ+nES5IN5?=
 =?us-ascii?Q?sECUYOR0b2yYrNJefos5rrVK1sz8BUC/RTgbbkuVOkZ/XBMz0LXsWhlovxP6?=
 =?us-ascii?Q?OvqisAxpUReSvkmypHIWyOvg4ogcBlNaNLQX8NfMeReAPHjF5nuFexN7S3e7?=
 =?us-ascii?Q?ceF+xZAwDLrRvG/M6b1AzaerxxqiC5ocDm2A5Da8X7B8sLkgaWRAXXH6Cgm3?=
 =?us-ascii?Q?giZ87Kuqv6KNECWSaHUAxK57Kjtr3nqu9VIgOrqwtPo1l2lB29K2UmEK+Wgb?=
 =?us-ascii?Q?ns/plT6zZy0inwpZFVqzyzCsgezMgPTkgS7xraxKC2iwThrBatexgAOcU4rn?=
 =?us-ascii?Q?IumAqP4MjdLgPpISR71LAK0+1r/WpT5p3ny6H67jKVttOpOt4uOvze/g8Uy9?=
 =?us-ascii?Q?sSLbR2BNkH4FkhHILMu2HQIuou8ToozbfJwbjCpe61DgdQ4M48VKpYrpR4vp?=
 =?us-ascii?Q?3RZ/sO22ADoV/1ylbX+hc3s+IFOXoxHdvVIyekkaCFeEsR+PB1dDYxXeAFMR?=
 =?us-ascii?Q?8vm3Vpxqa4xLXpMBh2R75P+Gyxnu7wiA8if7+AsxxplpaWJ/jajHCq3Vu+ln?=
 =?us-ascii?Q?aK9qsRxQX0e6/cqyeUD3yYNP556YIslbLjOaRc/bKcP7lHC/eUcHRPJEEiB2?=
 =?us-ascii?Q?BZeQETug9wtNyh8Kn2KkLdIq/AsZsY7eZNPPO6EJu1pzvadbd/BwOzLJZwTM?=
 =?us-ascii?Q?15ieeQvOBwCJvBz0YAIXfyrl7CVDSHKRQsLxMwGcjMI8W0fB4KonND+G1MA4?=
 =?us-ascii?Q?HYr39443ye03gRKQn7RoHRqT3xupviUFPVNGCT2SsoUnJhCdkF7adskD2CjJ?=
 =?us-ascii?Q?a4txuLo5yp+H0M92jskFxjnl+JRevLbhAMW7fHVsc6wVBp/iZiKYLTtd4KSs?=
 =?us-ascii?Q?F/PPeu2KR84RFjqT12LjtbwO9tAp7I4AA2+HBXEZHlpnUAtlhA7jUf6iCfNQ?=
 =?us-ascii?Q?KP8wG2cNJuoTDlFplhwVQArYNQX3UXu7dqOU9GRCx8iQhUE0xZ8AbFBKWr2f?=
 =?us-ascii?Q?fcHMojKo09zphFph5C0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b67647-7fa4-49d2-ad6f-08ddf73188c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 04:03:47.6492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZ4VFOKalnxQQIr8e6jFxMeUpT8v67qxjS9Jee57rosCYBghiZ9gRreO/gOv1KTrWSg727PQy3Fsnvt03ofa5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9487
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

Reviewed-by:Mangesh.Gadre@amd.com

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wa=
ng
>Sent: Friday, September 19, 2025 7:17 AM
>To: amd-gfx@lists.freedesktop.org
>Subject: [PATCH] drm/amd/pm: place the smu 13.0.0 pptable header into the =
correct
>folder
>
>Place the smu 13.0.0 pptable header in the correct folder
>
>Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>---
> drivers/gpu/drm/amd/pm/{ =3D> swsmu}/inc/smu_v13_0_0_pptable.h | 0
> 1 file changed, 0 insertions(+), 0 deletions(-)  rename drivers/gpu/drm/a=
md/pm/{ =3D>
>swsmu}/inc/smu_v13_0_0_pptable.h (100%)
>
>diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
>b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_0_pptable.h
>similarity index 100%
>rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
>rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_0_pptable.h
>--
>2.34.1

