Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12595C5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 08:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA4C10E3F3;
	Fri,  7 Aug 2026 08:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kQEQ0Tka";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D712610E3F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 08:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veoUGWAKBnb7MqrykUQIHipPAjLS3C03YuBQfZtDQKe3wPAgRywe80A84kfRm0mzn3MWM02580lzH1sKmAmwBTN/chefTrHuXBXzD8RbVg4ctT6Vx+EgOR7aLCReO64BTCdG7a0U7T07UiuWmfiGfpgO8dPYrfZVYGdubTaSaPs8dEDQPfOiR+J6FWVTsHOSwNWebyJ4zpjgu+g9HQgPX0CCg+VmGyPNVxcondMjal55vuFYMuoVYDSV+FD5CeUxMP5HW1Y0LjgvXqne7Fl59iUpnE94Vkh3wJZcBHIUBV5j/lJ66NATdHfORFXhaP/jo8TaZDEbHybIT1CC6eeZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjzDdOgfZ2lo54iwnQCA7f7cRPmRcsaXzcBwGbkI+3c=;
 b=OarXQVWwKJ7bnsel1zREfA085AgROF57sg8lXe7kRYrNzgE/KTfjMZRteIiwLsSj8KkkV1f+9iWSy+YeaoUsZ1tPLkFsDwsuOFjWBLd1H0+sik+xndAOdTgohNSJfMh+TWebxIKG3WdjC/EOqkgVf1RjQzHYkbciSIKBnEBS/7V/whbAhepLMKyqnUpyow2RUHhKMUPz7v4IE8sxt2P9K6zl7cBnC8FXHDGs6Xsr3lehErE5OGIEFopjxYC9QZQQM3W0654ApDAisGu0/eRIitlhDD29ILkJj5nrDkkVEWLIHEzz8+taogq4V6NwE61X+P6qOrTb+0XdLdGdkQsXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjzDdOgfZ2lo54iwnQCA7f7cRPmRcsaXzcBwGbkI+3c=;
 b=kQEQ0Tkab+cKWx2QRECKOfndLrHdD+fpY0rQtTAZ+Txs/HRqQ16CndmW+wQF7muEyGVGJSMl5eiuUeK5JxLSbC5ASppn1ZoJFq2pv3ZhCG1rgRNcHwTTwnyjrMwcEE6DyUNIO4pVFXfkCa1tnhooQsm6kSW5pCR5GIs+RiL7L9E=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by SA0PR12MB7001.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 08:28:46 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 08:28:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: update xgmi_get_relative_phy_addr to
 cover single socket case
Thread-Topic: [PATCH 1/2] drm/amdgpu: update xgmi_get_relative_phy_addr to
 cover single socket case
Thread-Index: AQHdJjgbNhJWA7/JFkqGjnAIBj6kW7aSQHFw
Date: Fri, 7 Aug 2026 08:28:46 +0000
Message-ID: <EAYPR12MB999158E3E80368DECD21043639FCD12@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260807064330.3070081-1-tao.zhou1@amd.com>
In-Reply-To: <20260807064330.3070081-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-07T08:26:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|SA0PR12MB7001:EE_
x-ms-office365-filtering-correlation-id: 0c20f6e3-98f2-4bba-9f98-08def45de648
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: vzuD3r9HNSkox0VzuOj4HkqrDFrGnjtQavcaB1ew6sbm6ynSmNAbNODdss4l8P4M1T0xR7vaqrSqb2QdMGZ0UzS/Iy9wgdukTjPK2TRhZL8TKtgNLxLlmqZ3J059bdWQsRAjNjsCkWBdWsGCpNXMrKLUr0lHp20Imi/oVJR1BrM/Q+jgP5ZDjxf1YqJX9woq3z23xV69Zh/rrEew6KigYs+XQDSYK23KGDFlqNbGucnIyKwuMxCnq3oPIFrBYDopcB712PH8zO87HBHsnMTtfQjaUi39CMbOHi5fiqt4bJiO3jMapPv2TNi3zsjAWhVAaZX3+v1TGysz6FCqS++KEUrZDsluzF144b/JXo8ni95WvxOw6fjwAFoPck93u0qWqWQn7aCrKNWglq6pwxz3UeqrKar5KLdLskjAsDTZahChXeptHSbUr+gDq9d84Gb+ZEUkR8T0cRzgpDkn2+vCqUVwJdMX+yWqTaVICrpMQaK08HY8If1xOrR9rM0wUK4SDyg6J5I4RQLfd6pJMbJkOE8d8Me+A7zkEHJZJQK9QNAvKhLwkXcbFr9W7i3W3sJvfOxPYCAlC+HO3ncB7phFK42EJqjuVRiT6eixVgSFJ0dUinbdu4JDgJRINrpTn7unwnzFiWg9oTKIyHlb1SrHwigYmyNvPXcnOPCs8p0drK7cayriYeuKtDr7NCxgV1E/owOxlKU6XkVzz4LZ43FjmyuyDrR49vq04d0u96zlQC0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y1fyLZ8f8MBB7rGg28psJGVNtmpyuaqulrlYkXOSoxkiBIzZFb+52BsQbZHB?=
 =?us-ascii?Q?GovciNAG5Dp9gfRuZ/xx0HyDTTLyP4aC2VFon5Rg8qgZKdn9g6NMqTEImjmm?=
 =?us-ascii?Q?7T+pUeqDFyauHfDhq/S9jHelwanTzZzCNGkjElVQaJkv2zstIxoFYhItYopO?=
 =?us-ascii?Q?Aokw6GnDtC6ELzDcpgE76X9471H7KFJFkK9TD7VqqwcFDlbHyIxyYD1DO4S6?=
 =?us-ascii?Q?uA/mQxQ/LX2CZ9fvzpdHRnFMVGTfympi6eherk1ED/GYkq5daA19QueJIFzB?=
 =?us-ascii?Q?PeKoQRDYqUfwS0ZOsZodGHPdNGHL6NwnfHwm8bknqwogot8Q88X/8l2PqT6P?=
 =?us-ascii?Q?EdkeCKlmCmgjXPXQgFSlLn+oecyYqbSzhWmkTcxpVInQGyvtVqUbc6JaPU7x?=
 =?us-ascii?Q?KZhvuB6zlUKtjl868uB4s1qun17RFbGPr7dzGM2pTAaoyEBfmXm7pU96wQQY?=
 =?us-ascii?Q?D3MJboEJr+W0KUv6kLhahc+RHIauTABUIGz4zXQ/bb7St5k6h3g+SBx/05QA?=
 =?us-ascii?Q?im7GoiJoGClYT/LTz/W7i1n995MxE3BiL02ylTlUuT2oy1meAlkqkhW1FQ1z?=
 =?us-ascii?Q?F177az3eIaEBRkeAF5cgBBkYLOx/u4D5Y/6PHMOXIogmEvZ2Ety4qvwJxwv+?=
 =?us-ascii?Q?lXdo/I9T3BSglzpnEFC8h8RcT0q6aTJGwmU3i8BqB5bgf6Ava9XSpDX/9IXC?=
 =?us-ascii?Q?BAnYLQiJzWVnSbDHK9rfEAaHwzd13mIXnikIVCwQ4ajHELtmgkGM2k9FUKtH?=
 =?us-ascii?Q?wZiUO44KIOJLWYEX/95zT0ihAdTZslVSm4l6BSpoLybyzmoWJNF+3L50OCuk?=
 =?us-ascii?Q?VkUdK0soNP51m/1qDZTZ5Q10tSNpq4jHAr70ObCTiyaUwOVgca2Y9SezUUhs?=
 =?us-ascii?Q?j9LZCek6e7gMfqRe+bVuq3L7wqhnaumxv/rkOSzqZAe97CbmXlwcYTaJKd0a?=
 =?us-ascii?Q?jNwd7OxgI+XgM/yWbz4a/V0Ww3sCesbwWeYja1ob6LalCMoLjIsOQdl+VBW1?=
 =?us-ascii?Q?hhHbaKM/uXpRrvopNNiepPfOu+wt1z8enijYaXLJphXnKuJj78aeXgwMCTOu?=
 =?us-ascii?Q?OM8IiuUF+granRpYMvzRS8ucxH6fGiLk5iRkCVcKIwmUOG2lNKr6W3Dv19K6?=
 =?us-ascii?Q?Jx1RCapIwO127HLWpw2foXnzQKrBWS9KRFJYi1JgL6/637gWrJyl8T6Ojx5g?=
 =?us-ascii?Q?zVwZlbiut+8/KfIYCo8roPe+LLT/MSXey3rcWZiWRtVvy81KTNiQgo6rmDaE?=
 =?us-ascii?Q?LYv4yHLPAJL7lZ/lMqarU5zcual7Pl9p+rK006VxQCKRszJhowYlbxUKkUJ4?=
 =?us-ascii?Q?hlHCxmO/cMmSQ/BJmXpgLC6UoqP6fSk1XSe+8hkzcZYs32LzLinH9KuUAsW+?=
 =?us-ascii?Q?sKOW703CPtyp+jEe6K1igDnQYzJRmKqhxvXGmwWBHVEZ59NNGcV7wiJ4K0cx?=
 =?us-ascii?Q?koyJRbWwp2dESMgO8e283S1DgbxXB+vP7L8bLflqlWSfwFPPvDOUvTIZWJNA?=
 =?us-ascii?Q?rlXBW9Db1Zxoij+XxhwBtLIR5EEVnHaDMy7XElK8Ns5KBoPf3A42KpFNrlvj?=
 =?us-ascii?Q?c8O0co+mL5BpFvKuzRWgOUQi/zzVe20lGSwNOonPsG8UnfzKfG1hTZPcFbac?=
 =?us-ascii?Q?rZTwWNpVhYIwvleX/jXikVGBV/V05+yXxRccK5XJ7/J5GX69xmTiuHos+Dsh?=
 =?us-ascii?Q?0MAx1q4IGDTQeg/WRkaEV15kX3WztS7ac4DZ+bx9+HWvK+96?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c20f6e3-98f2-4bba-9f98-08def45de648
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 08:28:46.5677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIrCA0qW8vsvvQEXulO1glTBsK6VV+xHvtvC1I9h7THOD+4bR9hdrh0WBcVNqSNFtJ6/WeM5bNmZNIsQbiYPUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
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

AMD General

Shouldn't amdgpu_xgmi_get_relative_phy_addr only be invoked on multi-socket=
 platforms?

I'm trying to understand why this function is needed even on single-socket =
platforms.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Friday, August 7, 2026 2:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update xgmi_get_relative_phy_addr to cover=
 single socket case

For single socket, the xgmi offset for memory address is 0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index c180c35e3622..9df32785f365 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1249,7 +1249,11 @@ uint64_t amdgpu_xgmi_get_relative_phy_addr(struct am=
dgpu_device *adev,
                                           uint64_t addr)
 {
        struct amdgpu_xgmi *xgmi =3D &adev->gmc.xgmi;
-       return (addr + xgmi->physical_node_id * xgmi->node_segment_size);
+
+       if (xgmi->num_physical_nodes > 1)
+               return (addr + xgmi->physical_node_id * xgmi->node_segment_=
size);
+       else
+               return addr;
 }

 static void pcs_clear_status(struct amdgpu_device *adev, uint32_t pcs_stat=
us_reg)
--
2.34.1

