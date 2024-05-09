Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC66C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 12:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD26D10E3DA;
	Thu,  9 May 2024 12:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yupYhnsH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1294010E774
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 12:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJxbVk0A3foXMPhpWt87/BNP1zmmzxiJDqrIjGtBV8grQSsOSyQ1plyQcsPLlY/hKwPEOUuFNCg4tKXM1r7jOGYYaKvtU2hguCM0Oh4LMMzrF6EI7IH8ap66yf8QWwTf2yrPUD9p92zReFbR5USnctd9YIhkXi+AoQK45gGrIlcGta3a4szECIyGKVYxJksEMwJpgN3HqnkFsdSCIXA+0GIOiBqz1OnxO/C70WSIBhVec6gERL2JhdpF45LTHX1rlfNZcNtTsS7j9QFjEGUJ+8VsAJxHdeN4hGoTebu+pcyDn2KjsNevID7audxvvGeJ+lg8IsjH6AkiX3GgNpK3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCeWwJ+D+s4UhhwdWFDATqQVZmJ+ZDDtLVQgpmyK0y0=;
 b=lZXLEjDY52pQJEvoX0fY2ARfPhOajgVA0W90DMrbdPrzAbntMbiHlMoOYWbuhVRt0zWob59gljkaBeasesLyOm6Tm6LfTn90xEiZZIPqX620VGizKTFQaA6vjmlhufWvF5fYObEC3GbIsLP1tYxCa83DMTZrB1WQhYHmC9nrsltJ8TRzc9fOlS0J88eTLeS9Rfect/4YGm2xKdt2Ah8LVXiTBsMoeCIE9yr1fnanl0xsIsQlk7NsmQNympPBbi4/0BBqM0RWhwUIBV3MmITw+I9eYFr/mHNWXLbdOojKJ+odiNRZ+sEX83DxaewmWYIK1M3/TD+4pI0S+yNX+WETrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCeWwJ+D+s4UhhwdWFDATqQVZmJ+ZDDtLVQgpmyK0y0=;
 b=yupYhnsHP9PnCiSyWh/Mo91F9MN5FS67yxhf5vHowODl52JfvspjqhjYYUB5JEE42B4tKwFbQaNPoQk3v0FOp9PgPKbMNK4BcslpaG015ntPpYcfvuoYuKcbSSkqj6W9SK2gFFCn1igNhenqQZBrLXRWfZraqr8gOH2IZFOFUdQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 12:47:47 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 12:47:47 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix aldebaran pcie speed reporting
Thread-Topic: [PATCH] drm/amd/pm: Fix aldebaran pcie speed reporting
Thread-Index: AQHaoe8+CVwyaS9VpESLK0an1akwobGO2j8Q
Date: Thu, 9 May 2024 12:47:47 +0000
Message-ID: <PH7PR12MB5997AEB98F248BBCC321F0AF82E62@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240509085925.61641-1-lijo.lazar@amd.com>
In-Reply-To: <20240509085925.61641-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=52c8eb4f-f2e7-4e5e-b8bd-4aba6a3f642a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-09T12:47:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA3PR12MB9197:EE_
x-ms-office365-filtering-correlation-id: be2fc269-b134-4fc1-e09a-08dc70263ac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?+44sSHV7hajlgSyMwc7ZGlJgefNInsbtFJH9aXOdO16XHHi007evG+Zi7ij/?=
 =?us-ascii?Q?noIfHkixxWeujEdUXqBaKHSLD6pwUGLKi9Kn7bYeTAhZpwybLUEGRtBByF2Y?=
 =?us-ascii?Q?TofkH5vXNP0m8RLhMknBxK1r7RgHXI8ykd2TfVUh6Cm/5iM6QZueUUvXfcr3?=
 =?us-ascii?Q?nqJIhBVBji9vpEtQ/EsEn6BnjtFl+RCFS7/J3bOZqAb/PD+WOI/C/KW0uDlf?=
 =?us-ascii?Q?geJGcQY1wHtIJwPLuZLBV5dD3hJeqJSEanQP4E4HTm2Hgm54XIUfRr000IOL?=
 =?us-ascii?Q?yY2GAi6fVBHgwFSpIBQYI/MOBWI+9GWDfAZ9rZSwYoyiMcyy7iOLt+7yPECD?=
 =?us-ascii?Q?46iYCIe+/M56AcqqN9ntOo5Kpito+gb2oPxZSJC2cB5GMFMaAQqv7SQoWsD1?=
 =?us-ascii?Q?yr7WgywHlwag8RehMT1o8OQj1JVP6L+LtKPSSIOU1WSi1KJRe5/tMp9oRMRt?=
 =?us-ascii?Q?EeIVY1y1kzjLPJA/IbfleN4o5thLo7Di6AMg9LL/WXnyEmuIR8ZphVZZXvii?=
 =?us-ascii?Q?E7d79qHQqjavPPXKPui2LzaP9DD4CI3ZgCcMwvdUkMbHavZuY8MUxaculY6W?=
 =?us-ascii?Q?yHFYdkwttQ1rcmjJh3NknrLsl3QwUVpEdT+06l+5ZwiXomQrj7CAX/03aMkZ?=
 =?us-ascii?Q?1EfI4RSbeFt8HGxGAeCTHXY8YgMXUMGh/yhHptG4SRpUidWyvURuDnNkf+dS?=
 =?us-ascii?Q?YXpnEx9N3mRgHjyq7b/ANB4xxs4QAl4ncdXPvbNZIhcf0oN9Xh70N3OjtgW8?=
 =?us-ascii?Q?SjS1kf+9wBXMt3UmsgBNbnSsfdUMyG9U1JQE1H+P+pq4yq4+iu3qW5FrK/ml?=
 =?us-ascii?Q?IxbBJRqYi+WJNjAtkSthVplMoXTKGxVhfL8UEIJxI6IeH55TaSZgbvm18e/f?=
 =?us-ascii?Q?4CKNBU3DzpKEi8BUHtBHgn26NTuj6G8Shg8azgpShOl++HlOqnPMUuzaqgMi?=
 =?us-ascii?Q?x/vZ5PGBa+WITJkxCIoxssOoLmZVqrnI+beuN6CsMUua7gA30x7jEsJhOQyu?=
 =?us-ascii?Q?AwJy4QadK7i5vICsHNAhIDHQbW1crd0QuQfdyslIEIaAn4roX+ZlnwimYIvO?=
 =?us-ascii?Q?LGmEgJjcXTiEhcqBgD4nDZ62yx1oiTXS9jWVhhLWZML4raajilpuHvIt3RKk?=
 =?us-ascii?Q?p37mcMaOj/b48+Gf13AKgL9dunobbhiJZlR0KY8YyCwYLs8r1+6Y6QqhxePQ?=
 =?us-ascii?Q?IpVbMshdsSibNssGj81k9Q+6imBXmpTTaMXJq5rjWhIf5V5ReYFZwdBNYJmX?=
 =?us-ascii?Q?Ids79ZWLDH0OqGXMPcTT3cojjPDYJqb4jhGtkSvAMDhw6hIiTpwsEtuZNtjn?=
 =?us-ascii?Q?E9lTmuHubadArA7OHb4b3jTd91MBYCEZDULFW2/53M/X0g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jtJkW8EoW5urG0pyZfRJd2bWAiFKlYRhjl5AAiq2+vl9IZ+QCnWrQcE1GzDh?=
 =?us-ascii?Q?oDOmGFGuaT9BqNBZ82CEVFaJXkTBeQuvNQHeMtY9f68yqYaGfzfIOHF7xeJW?=
 =?us-ascii?Q?AZj3TY00f69b53/f1/HhWwOPljdy8fYekP+qupsunAzBJr3KT1stHLz785us?=
 =?us-ascii?Q?lHpFK7w04COQwFz07zPsSajbIFPZSOzMSBp28wd59XaTqCCHghU1hEIHTwzK?=
 =?us-ascii?Q?nAjW8SKOfawZ8m6jKpgvTihTicSsqSZyujhIvO9m1SHp/P0mb7kSeRSICePF?=
 =?us-ascii?Q?532+bc+tG6mXv6ivXdAOjPtMSR8QPmEV4u9fXKgUoQMEmM1IGJSfA2g7wGR4?=
 =?us-ascii?Q?Cpodk/vptWEmfcdPMe58WWxbAPcgjxmi5eNmKxx3U+EnFO7GjXRKhwF3XmLF?=
 =?us-ascii?Q?bNRBzUfTl70tlEM6/RZNWC2rMTQu2z8whMwRnFlrdZZumvb5qXXE6yDKXBxw?=
 =?us-ascii?Q?mACROUhS1rFTvAbzfSf5RPGyFWKQNJ4AAcowRGApTN1kxfyhv8ELx6p1Z8N3?=
 =?us-ascii?Q?WuzdltDKNLQY/wHmQv9J6RKs+YRPZTIzbwhbnZJpggSwHL4MoN/kD2cO1shL?=
 =?us-ascii?Q?cYjAc/+66pX51A5sjLt6157C/eM6SZwnZUxTAY8kdeAeHXysOHV7TeuDAxi8?=
 =?us-ascii?Q?8oHMaP1/lS2DMgdsnDKBgyCkin+3OZ1SEDTpijNq03Ap5kc4nD1UipJclFbG?=
 =?us-ascii?Q?BOJMW+cuQHXp+lkhzMPTxq4aKSXPALmGg5Ma7zSBjcJAswx+hI4U+R9O10J5?=
 =?us-ascii?Q?0yhHZ673qVQKGCfS0sOFFoCofUBqA8jGWpI5cT9W0+FyPyxzsTNnwcz3KoWc?=
 =?us-ascii?Q?JS0ygMaCG+/P+h9fNI7BQwYnwfp1na297ogQLRMmNIShLfhC9VQGmu158L1N?=
 =?us-ascii?Q?fc7gR6Dmv4Eqjz/kyNffmzG5RlNBwy7hXNat1R5Em1VJPjxrQ1JT4aFcEGqP?=
 =?us-ascii?Q?0Za+49KAXy2jYAaJqIK5aHg/krLS4rFRhrhkrZzhy9JwHpek07uSiAUIO9sH?=
 =?us-ascii?Q?V6iG2O+NH0JO1BXNlAZx/O81w+TfPMBo38rS1P2bcGyPnRsnIwSY0FePBzET?=
 =?us-ascii?Q?Kx8vEqZgOP431iXqvT4URLa6Hay751GCVrTwJ4JAhXDibWUCIZ51p1D++mkS?=
 =?us-ascii?Q?M/cVhda69lbvioQCFli9FRGeO32OIRXcRSWuwfocUR9GhcDeMJtSvbkOENPY?=
 =?us-ascii?Q?b8fH9ejVDWKuFQblxQ9bhZLPeE7/8KtgVx6wrvUQmZFFZvjDTG9aemmamwrw?=
 =?us-ascii?Q?MV4ZXMYM/QQxe9IiivzXheBVTajFLiLgYdWKV3tyMl8XfiMflrBhBXcxLWNP?=
 =?us-ascii?Q?/7q3eMNZtSgMjaUZN8/iG7GEm+IUBFvlvc42soNKxFyNdgobtkOukd9u66fO?=
 =?us-ascii?Q?qi/U74sF9WZv9m49zapTGgG6n7k2hJfWBexPiwgqG4RfPkmUJFJIjT3gvaoF?=
 =?us-ascii?Q?L0ry6rAi7Q/CSwB4YCaEAjh0MY7N8LoWTU3h4S+3nJtafg1SW/Gc0mroOlCK?=
 =?us-ascii?Q?c2EizO552ZdEJ9aFmZkYZl94pinW9VvsjcU0AvRTZN3CjXzcVLPMKCyjH9Uy?=
 =?us-ascii?Q?UbLhMU3Paj+XluStoDU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2fc269-b134-4fc1-e09a-08dc70263ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 12:47:47.6246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBBY0vwUNdBWal7PefOtTmUfwdBy7rbkWArpml0+wikIHQVbnbmz5IC0yDykBQaA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, May 9, 2024 4:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Fix aldebaran pcie speed reporting

Fix the field definitions for LC_CURRENT_DATA_RATE.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: c05d1c401572 ("drm/amd/swsmu: add aldebaran smu13 ip support")
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0fd25b72a40c..9c0445fa9f9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -79,8 +79,8 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L  #defin=
e PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
 #define smnPCIE_LC_SPEED_CNTL                  0x11140290
-#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000 -#define PCIE=
_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
+#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xE0 #define
+PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5

 #define ENABLE_IMU_ARG_GFXOFF_ENABLE           1

--
2.25.1

