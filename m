Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E713C4345F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 06:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB23112F0B;
	Mon,  6 May 2024 06:20:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O2FyRZh3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9749112F07
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 06:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPs97P9xz7mmEvLV5KClOm2po2YzE3cQzONinb5w8BwEgYE3/iDR3+chYBVX1CaE21Q11pfKg15Xinv5OMoF/59hJbzGg3/1rnyakWdd3+pR4CdoNKM54dpWyWPzuhd5V6AfAW66ydVxtq0oN6AzE6naHN1ISQmn2rT4IemcGW2eWnoeWFaHJ5FT7ynFHURXRlDX3K6xiv40rVIYbkCtahxVvMDtceyCx+3kO5cLFN+eeTyS92VIR8lYpt0LxOplS7coHJ20822hh4Eh/hAac5iMZ01UAti0YMhEwyTNEgwrpr9JQr+8MmcanKOvVmyx7NqKYwkBMWJqe5mgZERcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhMwT4N3u1SVnTdcmZI2osk6hjm8mvOMrQpMwK3KG6E=;
 b=KOcK9FL69+cSzZlrERK8nxCYmM/vuwteDUbT7Tdi3Lynd0tuHF6BIXmLupd9Vp51pKQZ0DUQTTGzOGGsekJSrYXi7/2oh+f+s9RoQ8tRhQEOmKPSLH/JT/xnvBQJL+Lm6xytBZ5KEdz59VbAqk1Ft1uo08YhtwTV2DJuqIedHLiZQPmRqCaA7P3SO3/NyCRtKpkPaMnTZrflJhRHUV1xGB877bf6jQnnogNm/Qq+Qu7J6WwemnXiO1PMZbECRYAkPHctGDDU5nUN8BU9pJ73+cUQDOzou/OKxuGRLvpr5gdEtCJ3d3dDn5ndVKRjuRcqkdLUVcmKYFVJ1JjLBaICHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhMwT4N3u1SVnTdcmZI2osk6hjm8mvOMrQpMwK3KG6E=;
 b=O2FyRZh36os8z5zuUwejlZfG0x/teHD4NggU8chXI/scx5UhZS3q3nd6jDQwn/LMnXCbcq1l6w/I32fgkznmydhwEQqdDH5+CvFFNA+HG7QbAJO+GtwCRR6GYN+AnT+Xem8M/bg/mod8REtYeSPL1jbMcTs1zv6j/0FY0AeqOEI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Mon, 6 May
 2024 06:20:42 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 06:20:42 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix the uninitialized scalar variable warning
Thread-Topic: [PATCH] drm/amd/pm: fix the uninitialized scalar variable warning
Thread-Index: AQHams4G5SsZjRq1ekqMesLxfqONSrGJxLSA
Date: Mon, 6 May 2024 06:20:42 +0000
Message-ID: <DM4PR12MB5152552FB7146E739B57EBA7E31C2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240430071411.2107891-1-jesse.zhang@amd.com>
In-Reply-To: <20240430071411.2107891-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c10bbdca-c93f-4f05-8f1f-f98e80003857;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-06T06:18:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SN7PR12MB7788:EE_
x-ms-office365-filtering-correlation-id: 19ff12ec-c4ce-4ccd-3cd2-08dc6d94a837
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?oOvkOSFB24rOSFsJbUKm/6bOr1QdAZO/qQU6kGAoqXcl5rS8sLK2+0B4L1jk?=
 =?us-ascii?Q?SGuu0+Ih3xoHfODr246aIy6Z+TPw/nbm2WKjOV81phn4ZxvVrPHVKOihL6GE?=
 =?us-ascii?Q?k4vCitMFdBR310gwVmfG6lNJBvp7k0nDpEFq9wPT9TE69GI5Q24Zy1c9h1Ed?=
 =?us-ascii?Q?zqzZbmfM3RyfyS5BjyY3t5JWjeL9nAxmB1D9+xDNcf254IQ3qFMamLM+WTTQ?=
 =?us-ascii?Q?8eD1hpT/CeeV+fR03JtDJR+VL4VgPkd4Z1DWmJ4fupr428JRUOedZfc7Xh+r?=
 =?us-ascii?Q?N12FOibYMJSEHZuH9t7rSvvFn6IkjcLK8BMJ43HZqAr1VP6mtkj8NbogmnDi?=
 =?us-ascii?Q?FRH8lhe8Caf0vE0AM144Jblnb+Sk7mwtFFXoaHRZIGcITqowmOn2XeS+HmFq?=
 =?us-ascii?Q?Q8XWqyIiUgLvwyyp9XlK2sUXwJmu7iDhlfsmmIp7aXDc6yeCeZn9Nyvn0D/g?=
 =?us-ascii?Q?56IKD9xqARzelX4trD+kDpnAzgI7SKVd61AapSv5+lhhHZSwUZfGX8TOJOpx?=
 =?us-ascii?Q?DAdQKNfNM4OrEAk0Iyht1/DdCek5nRAPMWNjTvJxj1rPWzPkWvMcR7MTasIX?=
 =?us-ascii?Q?gHmo201ku5CrlaURZ2L1PiYWth5Qiq6Gbs3SUbfdtkIQ2PHg2DZU8CQo7Oe+?=
 =?us-ascii?Q?/C+GopepE8mitNharTcKOAG3jxyQeXjwgoBht4GNMRZ9OLk+Dg/uf0DP/VwC?=
 =?us-ascii?Q?WDqN32wx4gP684utlxUiNheF+lxsGC7Q7tF5Jp5YdyoptXlb9lXJ23sRZHCz?=
 =?us-ascii?Q?32dfyhMtyybMgjaBi/Rfm/2iULkCHV5Q3F5Vz3IeC51xM25CpdM8LnYHD21T?=
 =?us-ascii?Q?tb8XqjJEstAKHKU7wC9u9bjxCIujfaDHOgr+PI3rZld7qt+MmrZVS0wbKH4d?=
 =?us-ascii?Q?OzqLpq7E2fep5KWtlFNjpNCCHdrHk/AxocBpPIs0WAq9dBfNp+LfErlSXZnv?=
 =?us-ascii?Q?68Qut6Aw3mx+FScl/O4c2Nz91n7+JVEtZB9z93CR7Ak5hCLex2gLrYRhTSy/?=
 =?us-ascii?Q?Kua7aoNNbzafwl+bUJzaqA5eZDNnfeK5AzJbvPYjqQH23tXXs7Th6feEnTAc?=
 =?us-ascii?Q?LB3zOik8uJ0AWqd5xdwjVSWuAEVGozabzQ6ZxPzDk9u/hViSA4XBLHU0HCKb?=
 =?us-ascii?Q?xm8WOl6091/o+mpIDFUFYJGcE9SBuaWE6v4bSmwXUu8Txecjk7iT4iYlVJfJ?=
 =?us-ascii?Q?F9y0XZrjYElvMPb29SZXQLt1ioIwsqc0jwjrmrjG/I3LcPqKntKzGr4mP5pG?=
 =?us-ascii?Q?Kt1eUo1l5Ggt0OWnnPNA6vQvbVkXLsr0sjsj/YKCzio/KdObyJxBwVXnWQIN?=
 =?us-ascii?Q?G29Vy0/b+5AHX4nKf4CLEDgwI0vNzp3lMe49dpGdwTc3Pw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W3+qgEAk3Fmx1Xa4MoCbsCJA25oXtoIGOJsy/IwsN2P4+6OzPNAUXguUvd8P?=
 =?us-ascii?Q?FcijhCwseDkAsH1D7uoZjOPyhQ4P602sYx428tV06+ecgA1dh5bG8zOPJx7k?=
 =?us-ascii?Q?VydCP6g/l78DYkj7b+GBMNjauvH7lTXf4C6EGDg33GlCGYhuxvA6GJ3o66Fq?=
 =?us-ascii?Q?kJ6i5YVPvN3p2J/wSvS0e2ZUv1NH2d1iiyGhoosq/uGptiz0Z4mclVk3bUgu?=
 =?us-ascii?Q?uTVzehyznO6pAVq/9CtcXynRpvPgF2O+xlVEg2IzctTbNXuPF2PgIRdfqlc6?=
 =?us-ascii?Q?vUArFAIRj32VW/NiuFF3lr+E+uSgy/yddMOIym6bqX3ORpSBoA+gDgJrZop4?=
 =?us-ascii?Q?IKW5JpQwPbjXW+pwscwTMIO+5VAQzmqneZR5YxkIBYsm9E+7QPejYjqIPJtE?=
 =?us-ascii?Q?ZPcAAwznE3sSSCJEfZtWfDps83jzX54EDQpUmMmSx+TM8na3F/uVyzq9ESCm?=
 =?us-ascii?Q?tSuvONADLkSIe727ht6hqtZdDMcpPcZNniHZ7o3ivx6tydJ59LIZtI+YTz5c?=
 =?us-ascii?Q?DSqdLNGE8SxnRk/s+qX08ppSflncswXpWoa7FR29XY9OI3u3WmxYuf2yNy+i?=
 =?us-ascii?Q?TuvBZdoagcLaqnf9ea5jCCEqLEomuRSAkhh6fWM5d7NhjBnXHKOJO34+ajPG?=
 =?us-ascii?Q?KJ1cfYCQbBvSPwag0x1TQvJPfgW7z7Gmj7fRFp8TEaxhfld8FpRBIWHo+RZP?=
 =?us-ascii?Q?bEq1gqHc0mDTRoSbU9iHa12cOiHPPsZzh3LDtJnn2/bt+SBmLZA0twPcUibi?=
 =?us-ascii?Q?HMzJeer05MWzww9/cAjZeF0f0+eP+ce024iZuNJrwEPa9kU+um2RIxTernWn?=
 =?us-ascii?Q?fYFR+bHdngolcdDNjI/2liIk7iJ2fBHin/KJlUk0kK0OwBBgRFO7Lhg+I1ax?=
 =?us-ascii?Q?pXLgst4KOry8/siyIlzu/1qV5Im93ZzB2sgbDAqjMWK50bFCYc1zilszdukH?=
 =?us-ascii?Q?YB3j2d0SDUn46rrpS896dokl7Rhhj/G3F8mwDe36B8N1sgldd+ze6xV+qGmz?=
 =?us-ascii?Q?rQgnuk9g3P0QfSxTDvgI3wbhdRbLu1uCCDqeXFTktC+GIp3VRaf26ZEshO+k?=
 =?us-ascii?Q?ClZPiOmyJBc+jH0GSBgWgjJ+Sp5x6J4YEG+yT1nYNN3qImEBrEUhc2vLf2A7?=
 =?us-ascii?Q?AcJovhDcabNDUmAIdP/eiQ3C6RgOqSIH3vMlkKa+lgfBVitBcMDML+c2xc4J?=
 =?us-ascii?Q?OKKkZ0gNQ86+Z+zjc7mlbdyYmTzIJIP/Mgpk8fJEiZheIreXXXnsKq3OTrsd?=
 =?us-ascii?Q?2elg31bBIaZrkumm/ZI736a0oONpMMndcleHe/awBiKLGr+WbI351QoOTHPb?=
 =?us-ascii?Q?95Jldk1Wdwqh1oeiKMnMGGhCGXiZ5Xs+9+n6DMCu1L/xcgWAX2w0PscXxSqn?=
 =?us-ascii?Q?R3d95/lUyQ/p58RS8h/Pr31wSQTR29L9CQxuHg2ojj7mEZUuWZwZJKlzqXpA?=
 =?us-ascii?Q?NDe2eaHXVqzKL2QWaTu25PNfspi5yUfWYzlfbPOWklbDH8uru1BKlftW9p0r?=
 =?us-ascii?Q?ytBBck6rzJra13NRnuCDeVxQS4bIymdPaK98RGHf0DQjTeIRUYNuaFVKk7u1?=
 =?us-ascii?Q?dfqegyxEntxCPyanQh8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ff12ec-c4ce-4ccd-3cd2-08dc6d94a837
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 06:20:42.3994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kUn79ZHBQMYTQ5OboaNgGf08qh6e1Qm6RTNvfDgosj39y3eldNWhowwm2tYxeVYU8em8lrO0v/3kXEqFdLEKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
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

[AMD Official Use Only - General]

Ping ...

-----Original Message-----
From: Jesse Zhang <jesse.zhang@amd.com>
Sent: Tuesday, April 30, 2024 3:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: fix the uninitialized scalar variable warning

Fix warning for using uninitialized values sclk_mask, mclk_mask and soc_mas=
k.
v2:Set default variable to UMD PSTATE(Tim Huang)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 8908bbb3ff1f..36a49cfc22e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -835,10 +835,20 @@ static int renoir_force_clk_levels(struct smu_context=
 *smu,
                ret =3D renoir_get_dpm_clk_limited(smu, clk_type, soft_max_=
level, &max_freq);
                if (ret)
                        return ret;
-               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSof=
tMaxSocclkByFreq, max_freq, NULL);
+                /* =3D  0: min_freq
+                 * =3D  1: UMD_PSTATE_CLK
+                 * >=3D 2: max_freq
+                 */
+               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSof=
tMaxSocclkByFreq,
+                                                       soft_max_level =3D=
=3D 0 ? min_freq :
+                                                       soft_max_level =3D=
=3D 1 ? RENOIR_UMD_PSTATE_SOCCLK : max_freq,
+                                                       NULL);
                if (ret)
                        return ret;
-               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHar=
dMinSocclkByFreq, min_freq, NULL);
+               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHar=
dMinSocclkByFreq,
+                                                       soft_min_level =3D=
=3D 0 ? min_freq :
+                                                       soft_min_level =3D=
=3D 1 ? RENOIR_UMD_PSTATE_SOCCLK : max_freq,
+                                                       NULL);
                if (ret)
                        return ret;
                break;
@@ -850,10 +860,21 @@ static int renoir_force_clk_levels(struct smu_context=
 *smu,
                ret =3D renoir_get_dpm_clk_limited(smu, clk_type, soft_max_=
level, &max_freq);
                if (ret)
                        return ret;
-               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSof=
tMaxFclkByFreq, max_freq, NULL);
+               /* mclk levels are in reverse order
+                * =3D  0: max_freq
+                * =3D  1: UMD_PSTATE_CLK
+                * >=3D 2: min_freq
+                */
+               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSof=
tMaxFclkByFreq,
+                                                       soft_max_level >=3D=
 2 ? min_freq :
+                                                       soft_max_level =3D=
=3D 1 ? RENOIR_UMD_PSTATE_FCLK : max_freq,
+                                                       NULL);
                if (ret)
                        return ret;
-               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHar=
dMinFclkByFreq, min_freq, NULL);
+               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHar=
dMinFclkByFreq,
+                                                       soft_min_level >=3D=
 2  ? min_freq :
+                                                       soft_min_level =3D=
=3D 1 ? RENOIR_UMD_PSTATE_SOCCLK : max_freq,
+                                                       NULL);
                if (ret)
                        return ret;
                break;
@@ -932,7 +953,8 @@ static int renoir_set_performance_level(struct smu_cont=
ext *smu,
                                        enum amd_dpm_forced_level level)
 {
        int ret =3D 0;
-       uint32_t sclk_mask, mclk_mask, soc_mask;
+       /* default mask is UMD PSTATE CLK */
+       uint32_t sclk_mask =3D 1, mclk_mask =3D 1, soc_mask =3D 1;

        switch (level) {
        case AMD_DPM_FORCED_LEVEL_HIGH:
--
2.25.1

