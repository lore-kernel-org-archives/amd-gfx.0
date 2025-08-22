Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8008CCA0EFA
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 01:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A33F10E309;
	Fri, 22 Aug 2025 01:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbF1A7oA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE2710E309
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 01:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAHxTLRuuleqBY0KWucY1GQ4MO1a7aI6FJT+ptmwy1PJe719+FoWSiIPvxXBsrCX8XIZs75eJG9TN9gZXocsauugMXr0Dj24S5azkr+vlFdMiVKuJqFEfs3GYCDmVV341ZaKCbNrw/bMDDdWm56TcSZj9jLFPDSwBE0MPoIZUoXBu0cJZr3KvwEAA0lVRLaop2X6a44735OPjBeKDaqny1RWYiXsq+P/nh8L9wTOHLU+LDbvdAhf53FVHTLEPwtpwe3puanh7/kHEamDw4g0RvSKAdaSD+tEyjG9AYEoH78JJDFsRsy8y75YmA/qYCCbg98AO7fGI3O9xWEJ2DDubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMG/VShRdFnLCG8MLbqlYJRu31cWANfSwp2gqZZBfwE=;
 b=iW4nVJ+dNE9czD+FqHF/Yr4uLGEWYf3/gLOCePDOyugYUQgwCn5LcjhcextdUKlJm1C1gL5QbxJimVBES3QUFZv/xjN9T4JCeHHfap6tyP4zSIW65JgNG2U+NuM6Dr7UhKraCZ25XKm2+tBPnusattNRz9ZyhQLj3y6LiTkefOkYNdZvC0bliHGXSjyaKekHYdHL22L86Gz6yFRniEFvVasTdi109NXLa/YwZ5U5csWrhPCwXHlONXHuV8PrNW0uC56pNn8DiAT8oGhfwXYz3Fo2nUSCJKi2fUY/PzgkvwPrxMsBztOIT9JE8zy2oJdSjEl/0TZXT0ZK3SViDieJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMG/VShRdFnLCG8MLbqlYJRu31cWANfSwp2gqZZBfwE=;
 b=wbF1A7oAhsWJgQOw4M9nFq5fJzpgvNCMv4jatHHSWUX71fl8Gw0Npw6tEQjD+nfHxBS8/Sen8sVBKRS/MbwKq6PTYHxqQh/YfgIk/xyIc/7/aNtuWst/75ANe17IicWJSecaZhGcCKlunxxWWDlE98iJozgagmLLgE1zCOcfMx8=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.29; Fri, 22 Aug 2025 01:47:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9031.018; Fri, 22 Aug 2025
 01:47:02 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Jiang, Sonny"
 <Sonny.Jiang@amd.com>
Subject: Re: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
Thread-Topic: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
Thread-Index: AQHcEX8hiFt5Ro2FE0OwWPErGcXiDbRtnjUAgABINoCAAAOONw==
Date: Fri, 22 Aug 2025 01:47:02 +0000
Message-ID: <DS0PR12MB780487C573AAAC43D04645B9973DA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250820030400.514460-1-Jesse.Zhang@amd.com>
 <20250820030400.514460-4-Jesse.Zhang@amd.com>
 <ce9c1f2f-86ba-4c64-9cc4-10261dee138d@amd.com>
 <DM4PR12MB5152CFF92E0C5A49F711DA04E33DA@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152CFF92E0C5A49F711DA04E33DA@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-22T01:46:08.5689039Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CY5PR12MB6372:EE_
x-ms-office365-filtering-correlation-id: adf3622e-416b-4c17-921a-08dde11dca6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RknMBOJVciM//Oi+Gqv09DpD/JHSsgBRoqE3bhs30iythcshL4i5Rd9lyJFL?=
 =?us-ascii?Q?CakIjJLi9oBrAJbAN0a5RRUCiHY1R6ksZq0tCm44RoiRVyTDijoATJZhJTB0?=
 =?us-ascii?Q?kVhEEixQHunX6VdnWtUAkYgqVdHETBWHU2tz0gAmie0NqcAnEOsHvOWIGde1?=
 =?us-ascii?Q?ay0qrpNEhSNmK7cfLkMLNJFbWh3QEddfmgqxx3BJYYtarHv84CXoCvGkJUoN?=
 =?us-ascii?Q?/nL6gOfau9wFXtu6J0uBZSLnkN7865yLTcoD/CaAzNhjV2ZoTtzZgqV8UXY6?=
 =?us-ascii?Q?BFDyoBRjwvX/Xsr7RFNf6tvaZXG/P3l6EAa8X1pv0YRklJiBNRV7QtFCdFpU?=
 =?us-ascii?Q?b7D+vTbFH7hPMpzvzbwEglCb00C/kjLgM4NrYTKhWkLuaSmhYH+Sa/ckS+19?=
 =?us-ascii?Q?vxuxVVuwuPvH2L6gc9DKX0jLnWgyq/jTelLPRN/CEkaJgYsZ7ElfY4dEamW7?=
 =?us-ascii?Q?5av2htRc3ISfYELtwGJzDechN9TTRpT25EZx0zV3szZE74fuLXcqpl1Z+ant?=
 =?us-ascii?Q?4tY8lBlykzX3Lzz5Z81dbkGniNEjqhdsl2x+x2dtBxMG4GgFKS1qeIHJd3kL?=
 =?us-ascii?Q?KCyopemsq8aiTNQsY9IBq3Poi1NnfU6qzilMyy1sFQOkNgKvmnfTe7RCETtc?=
 =?us-ascii?Q?crciVsbC+E6Ac+USBjgCStvUve0eqmiINNijnHT/BCrrsOcunXHduYXY0ESP?=
 =?us-ascii?Q?4l6e+Iyu+8WCQiL/zQ/WVxx6XUCengiEzHaM6l/xMWtcE2JTk7jWRLe51IrY?=
 =?us-ascii?Q?EAd/jDyPFu8WY+DD50VgmvN9Qgtg2DKPHEfmS8W0Ar0VdeIPHPg1l9EfCF27?=
 =?us-ascii?Q?ykeSzMHQQK3kaqJa0qkYwUuB5hDdq8khSCwBcMRPLiuUXpzwmttd6rguCgMl?=
 =?us-ascii?Q?Rdsn/J2BkCZWV+DodcxSRewbcTgKjUyVbQZiwEmDzPTrjv6BvrXHaC+TCtXc?=
 =?us-ascii?Q?N1rt83ngYvZ/JHoZh48GHGvBlK5rWd4X1pFdhkMqdKLQDAMsLjAelwY9oqTb?=
 =?us-ascii?Q?y9ceXxUj6nGKXR+BPq+8NDw3nk2S1u8S5pzGhuaPJv78rGp3aw1TaIp6o01L?=
 =?us-ascii?Q?9+QSg7LGRvRPzSyI/lNmEipt/u6AZsQdE9VwAwBTiApEnfqb9i8dE+UELC5k?=
 =?us-ascii?Q?jI0s91kOsmWUCyrVv2/eIQOyXLPuvi+uXqbGfRtFJyyAGgkiGimjN3qMRe+K?=
 =?us-ascii?Q?S+9qsDTF/vWrsWOaQQR29hAj2WdgM2Rfns2qb2LDluGa7uTOr80xlBeQ94xA?=
 =?us-ascii?Q?26r1M8sj1BtgJVG7h4AMoSfh4miktfbuB9KjFfK1LAw309Z7QLA57NN/LwAz?=
 =?us-ascii?Q?M+avA1JZQIhMk9LBYBuDyabbIF/iqVCnf86coJPNHscL35qNGbO2cTfyK61M?=
 =?us-ascii?Q?NGHnnptuB5+CYCqm6oUNq+RkR8CiS11IlPjkKt1F59mkgxdOOtvWb7djP35j?=
 =?us-ascii?Q?CG/uNB4BYwPPbvixZ9mHHKpxVhnQm12wM0dJqcPdPxTWopLzodrGQQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A5H78KZ/6cKT6QWYwFNetZ7DCLbPpQ7/en6GIEqUw70gfnx6eyKV1xJZxzns?=
 =?us-ascii?Q?M/icnmj0/BAF7liSl42ulOI/4Qwce49K6qLNFoFPTH2HzFjmSDMtpgl+eKkh?=
 =?us-ascii?Q?79edZ1WVn2SfaoGQRq04cANK13TEQxbmxWueXSo6RLfFBFbmuTP6xsyo24H9?=
 =?us-ascii?Q?6emnG4Ma8MqLn+PGSapWfJ3pgE2k/f5I+vMwFXAiwZeVHHHz2DKwpiPjtSYg?=
 =?us-ascii?Q?9Inv9Ccpwa5oKB1Zv1TG9Rx1taO/u7FyBkbh4qU6W8GigUz0VrL9cxprComW?=
 =?us-ascii?Q?0/0XXUdmUdiIfMXBZm3/dhVlysaND6wEhD8mDEHw4/iPB+A7dxZL8HUAaxg5?=
 =?us-ascii?Q?riE484+CxKQzj80IE7OIaYBOtU1JjjDWRZozvZdhGsXLWGEzMCAwwoGz8CZg?=
 =?us-ascii?Q?WXryh+L3MroNsYktpzht3SoTAV34FPOPikyv537xTbPs/I1q+CxN4Rpdn4y2?=
 =?us-ascii?Q?iAjrg/TsfSClgOX1ft8aaZK374Ni+83pmNfwQ9Ss4iJlTM8cmt23cxyZelwP?=
 =?us-ascii?Q?4zrSajrK5RrsDPEnf3KNJw9RbXwBKRRCt+rPfRgVFaS/AqHmK6rnBPuj4gZo?=
 =?us-ascii?Q?OMr0VJMYYsh+8sCuUPq4i54wpgCiOyctFkNqYOn81wAxahFXRsrP7DGTPCf1?=
 =?us-ascii?Q?U0vlYYKvhWLsYoXbfikGxC2EDcEx4M01CBuN116ZYHoBdB9GfkqDYlhYqiuj?=
 =?us-ascii?Q?18IQRhvXKvwmG03zurKJIRo++p1tzFuZ3Z++ityYWN4ezuji5uSnDb56xs4Z?=
 =?us-ascii?Q?7NzknZOTqe4NEUd2lJNhTnRI2Lh7ARnE7oI/2VADNv7dpqdPOjy3zC3ozjjQ?=
 =?us-ascii?Q?m3tTsYIjrKS9z0daoUeUC8Mn75zd/sr9CqN+DXIbO0jhiIkHxDlBWwZ3A0GU?=
 =?us-ascii?Q?lB17Gu2Hpnf+eqCTMhpNWcSeO8KuLE7yzHaB3mrYTIzCeQ+AA6CRfThXpJ5l?=
 =?us-ascii?Q?Shp+oNjXByHBZ0ptido3giWBi5mhcZTbiIhdq+WAMqMUPBiJl6Dd9n9CPEF8?=
 =?us-ascii?Q?dbE3M+wQNK69iBrDl0aPt8GpFBEVywsrfIrPoJhnS2ZHzbRD6MS1bzOPX5q6?=
 =?us-ascii?Q?JLB1KekxWiFbQP8LIbqtylyztsQVSam2F9pDdn6piIKfJxH01U+VHH3dR1ok?=
 =?us-ascii?Q?xxKpLNcQdlLDt6oviRssq3Lt3cCaRo4qAkxp6R+V22pkxnYBR+IHGatBA4TL?=
 =?us-ascii?Q?6uwMgtPI2Q8n0rMnjB2FWxm3V915L9s9wS+wDCmWXiWcjr9oAw8150Hhf2tc?=
 =?us-ascii?Q?Bk0e1J83O6rzOzzl2gGCuEV9FlhwSrrnz94XsolvF8+osWnaB37ZBpw/8aVA?=
 =?us-ascii?Q?66L+RU9PwjqtCuVHxnwa+u2bJls+MNHmGxHzOIAoB9GV+Wx8XlEufCBecnFn?=
 =?us-ascii?Q?0wyecgZ1doLGQiXw2ad+NPqNMuJGCfCCKAkuoXINZFlcjJCfWd1ferAgDL3D?=
 =?us-ascii?Q?Pl0NbcL0uYU8Pz7t+JJQ8s+xn9cm9qkiJqQkfZzNPbSwU4hbDnORIFM3Iqml?=
 =?us-ascii?Q?XV992cFlo5ZLgqxUyaDlM6+fpJsyDEPovPqHsiJi1zk0IkAKXRqZ0XvSvXRA?=
 =?us-ascii?Q?fGJVLjdV1VQ/tmyhztnCLvrCh2X6oW+QTLVTiY2f?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB780487C573AAAC43D04645B9973DADS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf3622e-416b-4c17-921a-08dde11dca6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 01:47:02.2862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWfZn76q2WzGtlkBvdaVVgM1DZin+lsyiU19tgNM83XMEVuW8MVl0fcYT+bgqn31
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
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

--_000_DS0PR12MB780487C573AAAC43D04645B9973DADS0PR12MB7804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Jesse,

As far as I know, program 5 IP version is 13.0.14. Probably you meant 13.0.=
12 is not ready.

Thanks,
Lijo
________________________________
From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Friday, August 22, 2025 7:03:05 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jian=
g@amd.com>
Subject: RE: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initializatio=
n

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, August 21, 2025 11:45 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jian=
g@amd.com>
Subject: Re: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initializatio=
n



On 8/20/2025 8:33 AM, Jesse.Zhang wrote:
> Update the conditions for setting the SMU vcn reset caps in the SMU
> v13.0.6 PPT initialization function. Specifically:
>
> - Add support for VCN reset capability for firmware versions 0x00558200 a=
nd
>   above when the program version is 0.
> - Add support for VCN reset capability for firmware versions 0x05551800 a=
nd
>   above when the program version is 5.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 627a8188d868..9306bfe808e4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -437,7 +437,9 @@ static void smu_v13_0_6_init_caps(struct smu_context =
*smu)
>           ((pgm =3D=3D 4) && (fw_ver >=3D 0x4557000)))
>               smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
>
> -     if ((pgm =3D=3D 4) && (fw_ver >=3D 0x04557100))
> +     if (((pgm =3D=3D 0) && (fw_ver >=3D 0x00558200)) ||
> +         ((pgm =3D=3D 4) && (fw_ver >=3D 0x04557100)) ||
> +         ((pgm =3D=3D 5) && (fw_ver >=3D 0x05551800)))

pgm =3D 5 should be under smu_v13_0_14_init_caps().
 No, Pgm 0, 4, and 5 are all 13.0.6.
13.0.14 is not ready yet and is being tested.

Thanks
Jesse

Thanks,
Lijo

>               smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));  }
>


--_000_DS0PR12MB780487C573AAAC43D04645B9973DADS0PR12MB7804namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Hi Jesse,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
As far as I know, program 5 IP version is 13.0.14. Probably you meant 13.0.=
12 is not ready.</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-signature" style=3D"font-family: Aptos, Aptos_=
MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-si=
ze: 12pt;" dir=3D"auto">
<div dir=3D"auto">Thanks,</div>
<div dir=3D"auto">Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Jesse(Jie) &lt=
;Jesse.Zhang@amd.com&gt;<br>
<b>Sent:</b> Friday, August 22, 2025 7:03:05 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;;=
 Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;<br>
<b>Subject:</b> RE: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initia=
lization</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
-----Original Message-----<br>
From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
Sent: Thursday, August 21, 2025 11:45 PM<br>
To: Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christian=
 &lt;Christian.Koenig@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;; Jiang,=
 Sonny &lt;Sonny.Jiang@amd.com&gt;<br>
Subject: Re: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initializatio=
n<br>
<br>
<br>
<br>
On 8/20/2025 8:33 AM, Jesse.Zhang wrote:<br>
&gt; Update the conditions for setting the SMU vcn reset caps in the SMU<br=
>
&gt; v13.0.6 PPT initialization function. Specifically:<br>
&gt;<br>
&gt; - Add support for VCN reset capability for firmware versions 0x0055820=
0 and<br>
&gt;&nbsp;&nbsp; above when the program version is 0.<br>
&gt; - Add support for VCN reset capability for firmware versions 0x0555180=
0 and<br>
&gt;&nbsp;&nbsp; above when the program version is 5.<br>
&gt;<br>
&gt; Signed-off-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
&gt; Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-<br=
>
&gt;&nbsp; 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
&gt; index 627a8188d868..9306bfe808e4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
&gt; @@ -437,7 +437,9 @@ static void smu_v13_0_6_init_caps(struct smu_conte=
xt *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((pgm =3D=
=3D 4) &amp;&amp; (fw_ver &gt;=3D 0x4557000)))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if ((pgm =3D=3D 4) &amp;&amp; (fw_ver &gt;=
=3D 0x04557100))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (((pgm =3D=3D 0) &amp;&amp; (fw_ver &gt;=
=3D 0x00558200)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((pgm =3D=3D 4) &amp=
;&amp; (fw_ver &gt;=3D 0x04557100)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((pgm =3D=3D 5) &amp=
;&amp; (fw_ver &gt;=3D 0x05551800)))<br>
<br>
pgm =3D 5 should be under smu_v13_0_14_init_caps().<br>
&nbsp;No, Pgm 0, 4, and 5 are all 13.0.6.<br>
13.0.14 is not ready yet and is being tested.<br>
<br>
Thanks<br>
Jesse<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));&nbsp; }<br>
&gt;<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB780487C573AAAC43D04645B9973DADS0PR12MB7804namp_--
