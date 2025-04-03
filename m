Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDD5C3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 11:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C184810E222;
	Thu,  3 Apr 2025 11:13:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YkwnBz2p";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B3010E222
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 11:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqdDSsHWhfW2A0Dhakan5n/LgKOoOSyRgBKBIzt20+kyhtPRvDX9wKSTvkx+/R2bmyb7txwAHLhmYN3b3PUeNlLLaDtvWANWV3otoCbMRgM9x4rB72mVC94AoPuDpqc3vUEQXflfNTsiiESL5oD0/R/hUZklB0fX4GgRld6T2K4CTjQ1HBvTSHQX6rsYlu8TXI/cKlN+G1myLgaH9BZXpcRLQmdO1+XB+Mlsgq2ND9Utu5twHLW1x/bXMgU+BDdrFWdLytNmJdTMn+khfT909oDK5kRRTpF68J+2AdvUSPHPptO8rVtAEsgH+f+sEFjNvyOFd8M3wvHsS52vqDd31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8d/P57wRqc6QIlL3SY6u8coTh/oEVwmfO8VLDHKm5o=;
 b=B9VOFhnkZpwLfdIyVY8sXSzVKsZuwVYb5v70SFqg2fR1Dz/PU9HX/XSqU+NlWmtmvhneR5PLy4SFShwfLockbKHqinA3l3/pOATu/TSoSBaHebt3hUYapNraV3JFSiXuTNMp5aFaSZF3ESaNoa6gHEuS3likHR8SXazOIFWB7EyrxGNSxB6jcUpGYwNEnigSljESHcAaTIKf1FWqtCZ42xWddPMIJOl1eWgqf7E3XaV4PevwilS2EUhcqoAYLIm2SCX3XdmaP4YQfHnFQ99dDYZ2SvYNvCBlUgQowN/FDeQOVKE4vYr1z5epBHwkOotitEQzAhuPUBLBb52DM7gk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8d/P57wRqc6QIlL3SY6u8coTh/oEVwmfO8VLDHKm5o=;
 b=YkwnBz2p3xhd1fM3mVYqK1GrgreSizQOTZRiseq7vthllam/nSNukcvmfdKP9RL976cjbZuUoAkXVPZ19bz7KVPTIkLBV8n0Mr0juH2vIpOUwj0zh7es9yrqIgRWkd5shTMIUrNC/3goa9niousqfr+005Mk4aGt4LQzEJgwpnk=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 3 Apr
 2025 11:13:45 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eb1a:4c36:7d9d:6176]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eb1a:4c36:7d9d:6176%4]) with mapi id 15.20.8583.043; Thu, 3 Apr 2025
 11:13:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add loop bits for NPS2 RAS page retirement
Thread-Topic: [PATCH] drm/amdgpu: add loop bits for NPS2 RAS page retirement
Thread-Index: AQHbpGRvFx+yt+OxY0K+dJcE/M0TdLORyey9
Date: Thu, 3 Apr 2025 11:13:45 +0000
Message-ID: <BL1PR12MB5254BE1599635988908477D6FCAE2@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20250403064812.5003-1-tao.zhou1@amd.com>
In-Reply-To: <20250403064812.5003-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-03T11:12:57.4164139Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|DS0PR12MB9447:EE_
x-ms-office365-filtering-correlation-id: e2d33f2a-217d-4f1b-f6ac-08dd72a0999c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|38070700018|8096899003|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?1L1l7gnZfDFETaNmtM07WjKzQ/KX8llBirWHhcBvTvT0SdAEPpyO2TVkU9yY?=
 =?us-ascii?Q?uVOgKq9HHCsw9DxAq0T2vjT41uVrBgipw4Q60oim09yuhJ9XW+E7CUNwZwu2?=
 =?us-ascii?Q?1wojUyCaCC2/W1WEqKfoy+Z22Nzhw01eAc5EuXESnuqJGBGCoNt6iH/UJZOJ?=
 =?us-ascii?Q?NO0dvaKw+H7RR5u6KxrkHz9auaaOIEOkOh1h8Fr7OqWqLavmix1U/Io3Vkj3?=
 =?us-ascii?Q?YR2pvpPKsjp3UE7e6Yi6AwbJGIMuO8zzypY2Bnk9BE7aqCFILCNfQ1TKhR4y?=
 =?us-ascii?Q?cH9rNFqxC4BCQfTeM4L4QzeQPu/1Z4fGF+3SDlfMRSqBV0kfcZ/K1NME0HnC?=
 =?us-ascii?Q?4mJtSV7pKdr/ziWBa5T3ayfaPjww3VlqAcFp0IgIS9sVWw5vRFeG1uwKMPQp?=
 =?us-ascii?Q?jNTi6LKpp9lWMO5cbsm9e5QUBuQdweE1pfsXwGzKy5SKKquCKkqzdSEcAayR?=
 =?us-ascii?Q?jy4NvH90xQ6An8k0kihw65NAvSJgc1okgZRgifhedPllPaIfyuIerodO5Mpd?=
 =?us-ascii?Q?MdKqsmt6KT5o/32ZHcqeNNCLtVvdFrx5B0zO8GNCVC5/td72QvcIuiKz+mJL?=
 =?us-ascii?Q?s6XWyBDvWopi8Vu1VB6ZranZ6BKDRtjwvOOMt/l2eR7Z2nySm0LHcGhEObXW?=
 =?us-ascii?Q?/mlGYX83rnOYazdFnxhTzuOOVcb+3cirqfeA6aJrX5g+7gg6tGFnbxrOYMq0?=
 =?us-ascii?Q?8H7S0lzz7bkTuU6ahIs7g4ySBXb5eIJwjor1XHxVZD7ZXrs7vPHnDusSGoPu?=
 =?us-ascii?Q?gmBSQsosETUazlyxJiJLHsQUa7WljYxJHELekFOaM9f/UGQpAh+KNp+xbUgX?=
 =?us-ascii?Q?adJf4She0WrTxhmjDYvsTle7+03VgPQH4HRl/mVlePPMutTJeY80Wlp+ArRo?=
 =?us-ascii?Q?P/AIBX5KHsOXo03MOaFyEd43Kt/cn4zD46hYvnrQW7l3G3bmXkGZTww8UF+j?=
 =?us-ascii?Q?pBV+titFUmgmqz46lWGBYwDQoHNVOMLVx05JbSbzOVJk+KG+mNRz5z1mpa6t?=
 =?us-ascii?Q?RieNzYwNtF2RtTv+if6Zn98BjgCHZ7TasukA23CStpuFrPOYLKea01zz8yre?=
 =?us-ascii?Q?6BxcP6RXpDKWoyKK2mrGGiXbvJX28Da8Z7ExkWG8v+i6OK4lSjF4Z3cmfpZA?=
 =?us-ascii?Q?VLONug7oTOwI6EcIfBNnk5+1Ibx1zOqh/sKKSdRByDL0PqnowMd1qiPUa9mI?=
 =?us-ascii?Q?VE5ozMNAnkUmvPhNyPKbbiEWC1NUi1c4FeM0oC2HAhktO7CJRAyrCdr9Y/My?=
 =?us-ascii?Q?c7CEvnLtW42XRtos7hnTWpZzXPIp478il28GnhsPg6oyPSpmJdKxkXbWXjFx?=
 =?us-ascii?Q?eUfWOUVZko4FqCCz+mhPGXXJ8FLE2xrzT+zDHeb+bdnhi9tRVgxxRt4zfhrM?=
 =?us-ascii?Q?SlJw2J9D/x1joLl/J2wOP5Z3/GTys+ln09iKWWNHkNOG/1y1f5holfvzbhPg?=
 =?us-ascii?Q?fyYa2VYhWjuD3Llb89ADVqAN7WOylY6A?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i5Jk7kseEu10hc5RMsxOUZ5udIJnv/rGoNlznxnI/1DPyHPG1MI+DA6Y5SOd?=
 =?us-ascii?Q?/bcnAGddo9gXaOMRdpkccmk+/rMuAavbgllgKh/tIydPpfs34p4heH45Wqtu?=
 =?us-ascii?Q?98CTMyWgn0WRQlinyD3w3oM6NJeUe+T+23rM8rIGd8VzoAcQ0K2/FM9gQk1v?=
 =?us-ascii?Q?Cj+aGrp2n0jn8oUObR28yzBq7KNtvWUFvglQkanGoVkwgYPht5J32i0SEg22?=
 =?us-ascii?Q?3+szdrkJ43rOTddtUUZc7+LKscdW4WWZDGwmSFTRs+k4K5tFscv3/lzpRRPi?=
 =?us-ascii?Q?nPxFsjcDLJrhIm0Kd4/UqO86dTAbZU0toWHgCtw8Zx21WIAGg+NQeYmsckuv?=
 =?us-ascii?Q?OFEekgoSvS6dPsLoJ1kxoIT0KVgPLbtspaH51+hH7HmJjIq9zJdHYhyE6oRb?=
 =?us-ascii?Q?hcEUvx35hQCNZ8sYwG3Je6EDNUG/GCzzV6dAt41vYXqK3CMpv/6ysfdLtzai?=
 =?us-ascii?Q?Eg0cIJNb1MDNpCtYozb7evL/AkJ+OgPXSwdKpSZ3J8AoITw3baSQTjrd5ME3?=
 =?us-ascii?Q?zbuyiPvoHpvejpXZG3t/nX1LN2EdD82K00555muoC9VwWy8DdpGsMdn93SnC?=
 =?us-ascii?Q?JkCau/cXCX5cY86XGecJUEJzeqBmJG+bIRsLvz7E5KMfg+9HUMbKPUz9Gxwk?=
 =?us-ascii?Q?jbaNtRfm374KUrr9X0WLFc937wGo/nWpWYe1d9R1AlM1nM4ejqjEK2qByyZK?=
 =?us-ascii?Q?ENAGHt9dvy977f9KTE5TsfXQfhVryNvuhsaGbTgROrXagph+96C31EeWNwPC?=
 =?us-ascii?Q?ao7mmlEFT0nDG+gsxG9zSkOUWtIFth89k03oISKLC2cpDeAdAScGHy2RvP0w?=
 =?us-ascii?Q?2Gv/5TZN85KiPGofjGTTRJtXx8iBPJpRyIpoWEYPdlqDnoP+YmW2Hx7WSrPv?=
 =?us-ascii?Q?TBGx0BRGYjuxar00LsyvoUQYlVRKOguggfI2o+TIZP1S8epXBAgwkHBT+zfC?=
 =?us-ascii?Q?2LSV+qU9fWPaO5e7loMTU0WonNKMtd87Z/nQJA+1S6xalaoR/Nbo1T/mmLS9?=
 =?us-ascii?Q?uMN3PpOds3Ne6ryIiNE/Wm56msYKtd34HktihSkpAoT315OrBkYZh1NQk2in?=
 =?us-ascii?Q?6va1W4XbOQ2Yw6o0ViJ2s2L3vwrDAM1+IvH+retchXAA62dD6tSUehslI30d?=
 =?us-ascii?Q?MognQUAtkOGfW+/zbAf4TwFRXGwvGmx7+2y3eZAUIW+UPczNK8kL3opWwmtw?=
 =?us-ascii?Q?TrweF+DrwIkyolHrQ6QslwD6vLt92vD8TefRTEwyuJVkOqcU3oKu2qOuzyOS?=
 =?us-ascii?Q?nBAevtY3KmNjDAAsyg10kEiT2/QwddW0ivOvFExDD7qGcA0YaH6o2nV35zRB?=
 =?us-ascii?Q?E7E1p/db8Ujnh6cTgV8DEWNzDF7FRczFw5XMY9ePveal/FcgcH0ZNoW3Yqug?=
 =?us-ascii?Q?UWJAUHvvKgAnQVuq5srolLHO0yleF5Z7PFLr8c16OWW7B/oKBA4Olv9WNGKz?=
 =?us-ascii?Q?WhkcyKkqV6AcKSATld6iNvBfbAqZk1GOWCp66Rs6S40fgFn4MPFjqH5PFbAj?=
 =?us-ascii?Q?qW+o67v08Owz5xJjBScJmf8Oan8PTmICgm5yH9gFImvMopp75up4o3seeQJr?=
 =?us-ascii?Q?9Fywp/XOlXVIO0Gk+inkt2ZJ23ygmJlgTjqK7LcVYuQ5wKpvmMdrylppUSz8?=
 =?us-ascii?Q?F2sRDR8YhohNj/oi767SuNsQQ9O6aECHbtquhjXWLYQC?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5254BE1599635988908477D6FCAE2BL1PR12MB5254namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d33f2a-217d-4f1b-f6ac-08dd72a0999c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 11:13:45.3487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FHGQtY9Sqda0m9fZcm31obQmUiwAKWtLhD+fhvCFNlL2zgFe+xBoZ79DRgdA8bKSzvXzRDrjQFx4ZOWivnTaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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

--_000_BL1PR12MB5254BE1599635988908477D6FCAE2BL1PR12MB5254namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tao Zhou=
 <tao.zhou1@amd.com>
Sent: Thursday, April 3, 2025 2:48:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add loop bits for NPS2 RAS page retirement

Support NPS2 UMC RAS.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 0e404c074975..da00d6b3b6a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -220,6 +220,13 @@ static int umc_v12_0_convert_error_address(struct amdg=
pu_device *adev,
                 nps =3D adev->gmc.gmc_funcs->query_mem_partition_mode(adev=
);

         /* other nps modes are taken as nps1 */
+       if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE) {
+               loop_bits[0] =3D UMC_V12_0_PA_CH5_BIT;
+               loop_bits[1] =3D UMC_V12_0_PA_C2_BIT;
+               loop_bits[2] =3D UMC_V12_0_PA_B1_BIT;
+               loop_bits[3] =3D UMC_V12_0_PA_R12_BIT;
+       }
+
         if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE) {
                 loop_bits[0] =3D UMC_V12_0_PA_CH4_BIT;
                 loop_bits[1] =3D UMC_V12_0_PA_CH5_BIT;
@@ -517,6 +524,9 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_de=
vice *adev,

         if (adev->gmc.gmc_funcs->query_mem_partition_mode)
                 nps =3D adev->gmc.gmc_funcs->query_mem_partition_mode(adev=
);
+
+       if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
+               shift_bit =3D UMC_V12_0_PA_B1_BIT;
         if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE)
                 shift_bit =3D UMC_V12_0_PA_B0_BIT;

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.h
index 9298018d938f..056bbc038312 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -65,12 +65,14 @@
 /* row bits in SOC physical address */
 #define UMC_V12_0_PA_R0_BIT 22
 #define UMC_V12_0_PA_R11_BIT 33
+#define UMC_V12_0_PA_R12_BIT 34
 #define UMC_V12_0_PA_R13_BIT 35
 /* channel bit in SOC physical address */
 #define UMC_V12_0_PA_CH4_BIT 12
 #define UMC_V12_0_PA_CH5_BIT 13
 /* bank bit in SOC physical address */
 #define UMC_V12_0_PA_B0_BIT 19
+#define UMC_V12_0_PA_B1_BIT 20
 /* row bits in MCA address */
 #define UMC_V12_0_MA_R0_BIT 10

--
2.34.1


--_000_BL1PR12MB5254BE1599635988908477D6FCAE2BL1PR12MB5254namp_
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
<div>
<div dir=3D"ltr">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;&n=
bsp;</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Regards,</div>
<div dir=3D"ltr">Hawking</div>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-signature">Get <a href=3D"https://aka.ms/o0uke=
f">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tao Zhou &lt;tao.zhou1@amd.co=
m&gt;<br>
<b>Sent:</b> Thursday, April 3, 2025 2:48:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add loop bits for NPS2 RAS page retirem=
ent</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Support NPS2 UMC RAS.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 10 ++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |&nbsp; 2 ++<br>
&nbsp;2 files changed, 12 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c<br>
index 0e404c074975..da00d6b3b6a3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
@@ -220,6 +220,13 @@ static int umc_v12_0_convert_error_address(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; nps =3D adev-&gt;gmc.gmc_funcs-&gt;query_mem_partitio=
n_mode(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* other nps modes are tak=
en as nps1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nps =3D=3D AMDGPU_NPS2_PARTITION_=
MODE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; loop_bits[0] =3D UMC_V12_0_PA_CH5_BIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; loop_bits[1] =3D UMC_V12_0_PA_C2_BIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; loop_bits[2] =3D UMC_V12_0_PA_B1_BIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; loop_bits[3] =3D UMC_V12_0_PA_R12_BIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nps =3D=3D AMDGPU_NPS4=
_PARTITION_MODE) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; loop_bits[0] =3D UMC_V12_0_PA_CH4_BIT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; loop_bits[1] =3D UMC_V12_0_PA_CH5_BIT;<br>
@@ -517,6 +524,9 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_de=
vice *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.gmc_funcs=
-&gt;query_mem_partition_mode)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; nps =3D adev-&gt;gmc.gmc_funcs-&gt;query_mem_partitio=
n_mode(adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nps =3D=3D AMDGPU_NPS2_PARTITION_=
MODE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; shift_bit =3D UMC_V12_0_PA_B1_BIT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nps =3D=3D AMDGPU_NPS4=
_PARTITION_MODE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; shift_bit =3D UMC_V12_0_PA_B0_BIT;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.h<br>
index 9298018d938f..056bbc038312 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h<br>
@@ -65,12 +65,14 @@<br>
&nbsp;/* row bits in SOC physical address */<br>
&nbsp;#define UMC_V12_0_PA_R0_BIT 22<br>
&nbsp;#define UMC_V12_0_PA_R11_BIT 33<br>
+#define UMC_V12_0_PA_R12_BIT 34<br>
&nbsp;#define UMC_V12_0_PA_R13_BIT 35<br>
&nbsp;/* channel bit in SOC physical address */<br>
&nbsp;#define UMC_V12_0_PA_CH4_BIT 12<br>
&nbsp;#define UMC_V12_0_PA_CH5_BIT 13<br>
&nbsp;/* bank bit in SOC physical address */<br>
&nbsp;#define UMC_V12_0_PA_B0_BIT 19<br>
+#define UMC_V12_0_PA_B1_BIT 20<br>
&nbsp;/* row bits in MCA address */<br>
&nbsp;#define UMC_V12_0_MA_R0_BIT 10<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5254BE1599635988908477D6FCAE2BL1PR12MB5254namp_--
