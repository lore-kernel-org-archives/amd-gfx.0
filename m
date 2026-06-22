Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE55CCDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 07:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E92810E498;
	Mon, 22 Jun 2026 07:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x5DNMoK0";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010025.outbound.protection.outlook.com
 [40.93.198.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C952B10E498
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 07:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yH+CunYo1naFw+SHbn62cdOe34IOG8WTM195IbQYO+EYTpwrcVkEkxnCmdbKw0J93yy3eOJU+G1AxNp5oLKJ9ZvzPAxn4Z61PUnXvDdcz3UnPEXl0qEsruT00HQTKfA4Kz2Tc26XgBlDB3d5KhXOnB6uS9/K0wEhcukroJnRFt7GFWo4wvfdOl2j5C3S5jjpopliwStQ/gIE7EnUzkJb5c7qhXoIbkv9fZEEmjXrFM5OGt++3NNJp+up6vcBodGGTO0n7RiLYKliDsPijx6X0Acx96oDmn+Q6PbQwihi40WusSZ+h2GkpB6t1k0nGWZQMtMnNuYbglIJmc3QbQXgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjuKekAvsL+L+vdBS0a4L0caKHLnKYjatpLLrsJ16Mk=;
 b=wjdDfOi9rz7I3GS15CJWHjWSGfhM+f/mQ0YTVhDcSwLT067qPcHnkQSqk7dIM04NXRvRGTUkBIJfj1vH6Y26dnhquDPYuJLEov37ep3r6EUfSyFxEzwsDjPRRZHeTWh1g5Sea7BR/kIQUI/BTMY6YTOOj14+4jKW80CEr3H2I8kNfC9/7UiH4J7bICSBDsSNQH9IBGXGezFBQic6TGDvFgBEdudW8eV64GPNO/hhRuAklEdN0wvNLVKjjnlLh0Fp8IMGmiNd3Azbc+6WDgGb3XKDdT5k9LXbtoOafGiiUtnCZAa1YQzQjdI6uXNDBHKJ08ZZjkEAiyD5KLfVyBLXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjuKekAvsL+L+vdBS0a4L0caKHLnKYjatpLLrsJ16Mk=;
 b=x5DNMoK037NqrwQ9JfIN8k70fhazdH9tZeSP+SyB47cmn+9OcMRds0KRwVhhukiik2p17nuNxOjq21YcXTYikGZ/v+/dWbCgDVsfl9AhLUGUkkkkjMiWg77YxrKNPSTv9uUDpoFFLkdTw24gcrL7J901wg0FzKjYJhyWWRoHf2I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN7PPF34483F4BA.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 07:51:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 07:51:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
Subject: RE: [PATCH v1 1/2] drm/amd/ras: add set_debug_mode function for uniras
Thread-Topic: [PATCH v1 1/2] drm/amd/ras: add set_debug_mode function for
 uniras
Thread-Index: AQHdAgKsPjPV7+Zdqk+efL6C5oZ8FbZKM76g
Date: Mon, 22 Jun 2026 07:51:56 +0000
Message-ID: <BN9PR12MB5257AB1AD7FC9FF16D51891FFCEF2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <cover.1782103766.git.cesun102@amd.com>
 <eea07a6f8d3a846baeea3e6d27f4d3d092fc643f.1782103766.git.cesun102@amd.com>
In-Reply-To: <eea07a6f8d3a846baeea3e6d27f4d3d092fc643f.1782103766.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T07:51:07.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BN7PPF34483F4BA:EE_
x-ms-office365-filtering-correlation-id: a8cb620d-5091-4a2c-6ca1-08ded0332226
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|56012099006|4143699003|11063799006|38070700021|6133799003;
x-microsoft-antispam-message-info: 1YYbdxdJSvo3tH6+U8ILTUWj6xDCgkw6TuWygHd0baXk9I3ZNqTzcSgnwSYDmNIMK1TNAFB7PF9MEQVmEXWlqG7t6/QJpL1MEDSvDFWbMMIePjl+5/svmDKZYzr/02Uq27NCnHui0ngAJzw8Jb9fiMJ1HuVNbUBz280zHVuVQC3q9e8ObXgJaXabbOsukddT6Tu4TMDwYaf0kWcCsZ0MoBOgFn11NCUHVbQuh2tkc4kJXlw5H7soBwDj/miJapVcbLGa9a7BwTENuvLUBNU3H3uVQSQdfZmu7r/0gnZqWmKDRy5tCRqVdG1UaKrdIiuvJ4O/HMM3q4ugnJORJHO80x13yN+PGvA0XHYthJHpC5Cbx+YUCKZ7oG/Gws5i0vjqqN4TPa6EQwHjNOlHAnp4AYenfAy9oo8Hz7S4VB9QUzr95GXv6ZGfu2066fz4HLWsb0RYd9aJpizWbm8qi0Rni2SPgBOWAv8FQvoLfXWuToQvKGw8SDXNkySvGLQ6/wInevdys03HTbifi2DcvL97kSLNsaymzCFC6kn2Bc0rBBBizSejUlPKxDLihZgN57UMKqkG0w3tdhKjvGXm5+HfZP7VnJQaV1V8UqqOwhLgBpebEn2OGeSFtgnDFUPsurt8MqzebA6CNFl07+Wo87IyHWSodVJom+hKRbGuMu3y/sH7i1ql+bS+G8+Oq3g41I2aOucfmCyxBUzDm4niQ8G1BU5MIHrRe0xzV064uxg5m6o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(38070700021)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XgN4HmDwchtN1rhcIGr9J/xDV4KswlSg7YPmJmECeVar+4QnbpInEz/fTowC?=
 =?us-ascii?Q?oYWMg/RiZ0pEJ2VfFsCmkr69AZ81qtqYp+djBrECGgk/n18puEze3Ca8F77f?=
 =?us-ascii?Q?s5k9I5crZx3CaGWfvDR0XmpgI0Lsa3gJ1IK0g0Zzon/FvOr7lKhMQoAC88r5?=
 =?us-ascii?Q?u5EgGEpmUC5vwOQCoIY0IuWmAZnXLHwIVeVtt6qt30jRIp9uqqJaCSaw9qdt?=
 =?us-ascii?Q?T8EBnhUtIDOV63gYuxRZh/WF/f7rvkl6Hx0FAUirLWKS39UQ2oiZM9ykm+iM?=
 =?us-ascii?Q?7Uux6X/HrR4KXwYX9/74bfNGV6O0VhC5Ad6p1LdeSo+T7gohYUckT4TNfmAh?=
 =?us-ascii?Q?WrtaVBDxTsYntKxxCTbFYfLFcpW3S34jYq5Jzlf0PNzQzWi+R7CRDbSWtphb?=
 =?us-ascii?Q?VTyr29VSO4GpCzFWpzYxyVKzh7ODdVvYfzL8iNeHNbjJvxuKlVJNshNVtoDT?=
 =?us-ascii?Q?ODGBe3extyimxua30GBghoZzHfgwtKIEW7AnvQXtHEaivAil6ciXCZ3FdS+8?=
 =?us-ascii?Q?1bbRKgjfLoTySBkqRcUJbuH/TioFNSxNTr2iY5hEkCNGU+uhvHUNo4Bq7tRw?=
 =?us-ascii?Q?Dhbdczo1luLyQHHvsvcA27WHVd3kTswSXYkJSLT9ktOMfF3gsjgyeHcuWxTw?=
 =?us-ascii?Q?IFboNJeTKOQVZ2MlNtZ41oul8HH4EdA2F9HZ/2cRWf9irSE5KmDd6ZQcvCc7?=
 =?us-ascii?Q?rinwVRoac32N1cxgrJyh8yNoXBNJt/jtMBzNa+D8eKxlFZyisiWj7YEI74JD?=
 =?us-ascii?Q?DzIR2MmVc9HZ/qaOr0+cIDAYBLM5D9JC5thY8x2GIwKTpGgld4Il6yT9F4kE?=
 =?us-ascii?Q?wYrXPDrSuNPfPo16NuieC/i4JssUs7P8/1omPzS3mg77Q6Fgmp/hx3XYShg1?=
 =?us-ascii?Q?8NxXj2FRzwceHRPEtsfyipfJTFvlJQ5vr3Zok6GYroH42EZzKnV/+IIGJtEC?=
 =?us-ascii?Q?NcRsY1w58/quK6wO2j/H3+5ntZBFCOxhPl//e7lePwqztitU/9oJBeptufmh?=
 =?us-ascii?Q?B5TrhpYOQbiIfSJgDKVHoVl+T2XfiJlLrXxrm3JDvdVQZ3lr4bw5Jfwupavi?=
 =?us-ascii?Q?QH3amD4UHbTg200SrknN7OsGSmk4Nm+E5vn58tLeLDpcqHC4yVAy8tsAYajY?=
 =?us-ascii?Q?oZJil2zyqWuzY8ovfWDOz2HSrT5wGUly1zMaEXboO1wy+hade6gvy86MshHd?=
 =?us-ascii?Q?6CtI8ThkEJrlhgMIKGoWzZC086j5dNlH6gZhb8LdXo5N/8EWkLWP3E929jcA?=
 =?us-ascii?Q?04Qp5Q05qrhuu7nhYYtU3EpLjYWN9fH93KvKsiW3n4hKg5MjXro3JO7MKIMM?=
 =?us-ascii?Q?6hvHBTAJPyVSX5k4Cz4rTuMbZla77dgr5UrElhIhnT+p/bgRlCW7Qvy20hX3?=
 =?us-ascii?Q?IQvCgq0LqVDh2TfnXlgLAWtvslqnL7OFaTF9e/deAHh8Hbnm6Zt89KjdjKqU?=
 =?us-ascii?Q?B0bq3LCp8bTWrHbIZDpDHjaZnAnbUVrALbu7Q1WORz+BqixqOVytRqEbRY39?=
 =?us-ascii?Q?1Oc5vnbUHsIisJmWaA+BHFk8e1Hi6HZ9DQaXDnvrXr2mwI2sXujz7YPozFQ8?=
 =?us-ascii?Q?X61NkxpbTZO6LAPv/9/GFonneauYDfbSsIm/esmNadOG/yk4Uw8AwQwLfSuf?=
 =?us-ascii?Q?tWzoxwlcy9MqyCP6gw+JZarecqt7Fa8q8ilqX+gr5/WXNFIPHGecLPkkct5A?=
 =?us-ascii?Q?zK/S5KlpUBRaQ1jzB8GMZOCTCXPZGi6KCWeUD1uDBg2jA89e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cb620d-5091-4a2c-6ca1-08ded0332226
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 07:51:56.7810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pb+rDy3EEUEoudihKdkpQ8SCR+C3Yig4h3lCHVx0qnjAOf1h185BjDXIxpVdBSjtO0cSw5ct8CUuaZHtOF4mjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF34483F4BA
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

+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool
+enable) {
+       struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
+
+       return mp1->ip_func->set_debug_mode(ras_core, enable); }
+

Please check the availability of set_debug_mode call as it is not a mandato=
ry function for all generations

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce Sun
Sent: Monday, June 22, 2026 12:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH v1 1/2] drm/amd/ras: add set_debug_mode function for uniras

add set_debug_mode function for uniras

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 10 ++++++++++  drivers/=
gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h |  1 +
 .../drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c   | 14 ++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras.h            |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c       |  5 +++++
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.c        | 16 +++++++++++++++-
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.h        |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c  | 13 +++++++++++++
 8 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index f627a97797ed..2ce7b88544c3 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -773,3 +773,13 @@ int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct am=
dgpu_device *adev,
        return ras_core_convert_soc_pa_to_cur_nps_pages(ras_mgr->ras_core,
                        addr, nps_page_addr, max_page_count);  }
+
+int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool
+enable) {
+       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
+
+       if (!ras_mgr || !ras_mgr->ras_core || !ras_mgr->ras_is_ready)
+               return false;
+
+       return ras_core_set_debug_mode(ras_mgr->ras_core, enable); }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 4f44a917d48b..a757ec15125e 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -84,4 +84,5 @@ int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);=
  int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);  int amdgpu_ra=
s_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
                uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_c=
ount);
+int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool
+enable);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drive=
rs/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
index 2098f24d4940..ee59184f7eee 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
@@ -24,6 +24,7 @@
 #include "amdgpu_smu.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_ras_mp1_v13_0.h"
+#include "smu13_driver_if_v13_0_6.h"

 #define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
 #define RAS_MP1_MSG_McaBankCeDumpDW       0x3B
@@ -131,10 +132,23 @@ static int mp1_v13_0_get_ras_enabled_mask(struct ras_=
core_context *ras_core,
        return ret;
 }

+static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core,
+bool enable) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
+       int ret;
+       u32 smu_msg =3D SMU_MSG_ClearMcaOnRead;
+
+       ret =3D amdgpu_smu_ras_send_msg(adev, smu_msg,
+                                     enable ? 0 : ClearMcaOnRead_UE_FLAG_M=
ASK | ClearMcaOnRead_CE_POLL_MASK,
+                                     NULL);
+       return ret;
+}
+
 const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 =3D {
        .mp1_get_valid_bank_count =3D mp1_v13_0_get_valid_bank_count,
        .mp1_dump_valid_bank =3D mp1_v13_0_dump_valid_bank,
        .mp1_send_eeprom_msg =3D mp1_v13_0_eeprom_send_msg,
        .mp1_get_ras_enabled_mask =3D mp1_v13_0_get_ras_enabled_mask,
+       .mp1_set_debug_mode =3D mp1_v13_0_set_debug_mode,
 };

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ra=
s/rascore/ras.h
index 5869bad978b0..371d1061d8f4 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -167,6 +167,7 @@ struct ras_mp1_sys_func {
                        enum ras_fw_eeprom_cmd index, uint32_t param, uint3=
2_t *read_arg);
        int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
                        uint64_t *enabled_mask);
+       int (*mp1_set_debug_mode)(struct ras_core_context *ras_core, bool
+enable);
 };

 struct ras_eeprom_sys_func {
@@ -400,4 +401,6 @@ int ras_core_get_device_system_info(struct ras_core_con=
text *ras_core,  int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_co=
re_context *ras_core,
                uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages);  =
int ras_core_check_address_sanity(struct ras_core_context *ras_core, uint64=
_t addr);
+
+int ras_core_set_debug_mode(struct ras_core_context *ras_core,bool
+enable);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/a=
md/ras/rascore/ras_core.c
index 61d100b074b9..08e17a83ad5b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -151,6 +151,11 @@ bool ras_core_gpu_is_rma(struct ras_core_context *ras_=
core)
        return ras_core->is_rma;
 }

+int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool
+enable) {
+       return ras_mp1_set_debug_mode(ras_core, enable); }
+
 static int ras_core_seqno_fifo_write(struct ras_core_context *ras_core,
                enum ras_seqno_fifo fifo_type, uint64_t seqno)  { diff --gi=
t a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c b/drivers/gpu/drm/amd/ras/ras=
core/ras_mp1.c
index f3321df85021..15b605a23aa5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
@@ -59,9 +59,17 @@ int ras_mp1_dump_bank(struct ras_core_context *ras_core,
        return mp1->ip_func->dump_valid_bank(ras_core, type, idx, reg_idx, =
val);  }

+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool
+enable) {
+       struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
+
+       return mp1->ip_func->set_debug_mode(ras_core, enable); }
+
 int ras_mp1_hw_init(struct ras_core_context *ras_core)  {
        struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
+       int ret =3D 0;

        mp1->mp1_ip_version =3D ras_core->config->mp1_ip_version;
        mp1->sys_func =3D ras_core->config->mp1_cfg.mp1_sys_fn;
@@ -71,8 +79,14 @@ int ras_mp1_hw_init(struct ras_core_context *ras_core)
        }

        mp1->ip_func =3D ras_mp1_get_ip_funcs(ras_core, mp1->mp1_ip_version=
);
+       if (!mp1->ip_func)
+               return -EINVAL;
+
+       ret =3D ras_mp1_set_debug_mode(ras_core, false);
+       if (ret)
+               return -EINVAL;

-       return mp1->ip_func ? RAS_CORE_OK : -EINVAL;
+       return ret;
 }

 int ras_mp1_hw_fini(struct ras_core_context *ras_core) diff --git a/driver=
s/gpu/drm/amd/ras/rascore/ras_mp1.h b/drivers/gpu/drm/amd/ras/rascore/ras_m=
p1.h
index de1d08286f41..0b618f6b8b9e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
@@ -31,6 +31,7 @@ struct ras_mp1_ip_func {
                        enum ras_err_type type, u32 *count);
        int (*dump_valid_bank)(struct ras_core_context *ras_core,
                enum ras_err_type type, u32 idx, u32 reg_idx, u64 *val);
+       int (*set_debug_mode)(struct ras_core_context *ras_core,bool enable=
);
 };

 struct ras_mp1 {
@@ -47,4 +48,6 @@ int ras_mp1_get_bank_count(struct ras_core_context *ras_c=
ore,

 int ras_mp1_dump_bank(struct ras_core_context *ras_core,
                u32 ecc_type, u32 idx, u32 reg_idx, u64 *val);
+
+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool
+enable);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c b/drivers/gpu/=
drm/amd/ras/rascore/ras_mp1_v13_0.c
index 310d39fc816b..1fcfc1995ad3 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
@@ -99,7 +99,20 @@ static int mp1_v13_0_dump_bank(struct ras_core_context *=
ras_core,
        return sys_func->mp1_dump_valid_bank(ras_core, msg, idx, reg_idx, v=
al);  }

+static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core,
+bool enable) {
+       struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
+       const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
+
+       if (!sys_func || !sys_func->mp1_set_debug_mode)
+               return -RAS_CORE_NOT_SUPPORTED;
+
+       return sys_func->mp1_set_debug_mode(ras_core, enable); }
+
+
 const struct ras_mp1_ip_func mp1_ras_func_v13_0 =3D {
        .get_valid_bank_count =3D mp1_v13_0_get_bank_count,
        .dump_valid_bank =3D mp1_v13_0_dump_bank,
+       .set_debug_mode =3D mp1_v13_0_set_debug_mode,
 };
--
2.34.1

