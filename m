Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C96BC0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 10:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E50F10E921;
	Thu, 30 Jan 2025 10:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TVbr65M+";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389F510E921
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 10:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITMTgoYeT2/nqaasOqNd2xKi26b2FZnpPl7Wgh8QtQOe9slzyJlNeiMkAHWHk4yVU9PSlccNl1VncSUHb2AX5dZtl4OCIdRmyx4phpSfX7ptOe8hB4h3JmJe8ZjJCOQrRc96yLywyu7Us1vUNNKT0mufnHB0mpBITmVKrd+YOdvboqWV1n8eSnpH62o4t8Lxzzbp0zpHa0KHWnEOhOBOQQrbTzxE2JJd/uD2jEy7ZB/UT8d4f6hTpyINLMlKW/fqKqDhxFOWDgWmFRWjDrjsZx/frXLfNgc2Q1zoWRotbuLBy+mh+xU8p4Pz0+IfSEgjd+AtZEYVckjycDq6kXB/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwodDasJC17dDfYcbGD5LqbYzuaxyb3IzZ0/xs7z2ts=;
 b=gXedUQM6jyU1wx8QlwIjtbbv4PLAvXoZVUTlJiyeww6fC4hmuMx0QKNJqxxkLd1/NVfL+auISrzOCq4R/gNSWMu9jpqlphO/p8FC3j9FhUi+Vxk65zvFa63ch9qBwKwC5Y9bd1Csvbc6aETxnnjpYbhLo+EH2Fiv14UNWq9E7/E6KSiWLKcmlEc+oCH+mNIOoIelflUbZNZSEF3ByJOmLNxlpKWNn5sjRN1yqFBQfwLGnW0Z+o/WlNlGUPGIJ/LYg6leh1uCVmA03wHEmOMRgDutup9OvqTuOxMa6UNbjGBP7atzbmv2+eOMURnOE+ZTe9giT+CiY1fb+yRNAr8awQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwodDasJC17dDfYcbGD5LqbYzuaxyb3IzZ0/xs7z2ts=;
 b=TVbr65M+m4vNHeKmpd1pvBZQ+3fTkwjIpzSMcShXzx6QZCxxjsu62tKR1ljhimar3KC3elvrn3HbP47NqWm5zjUV8zY3FRFUl9gvLHFRJt0NqLaGix5GabD2VpvUjz90ZueVyEgE9d82fVA5phhAUSMUBbg+asSW4FqHg0iej9o=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 10:09:57 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%7]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 10:09:57 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Use one level table if dpm not enabled
Thread-Topic: [PATCH] drm/amd/pm: Use one level table if dpm not enabled
Thread-Index: AQHbcvguuo8TNjUluki6p23Ty52mMbMvGDuA
Date: Thu, 30 Jan 2025 10:09:57 +0000
Message-ID: <DS7PR12MB60715A99018D8BF0B4DF0E0B8EE92@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250130092000.1759194-1-lijo.lazar@amd.com>
In-Reply-To: <20250130092000.1759194-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=caf0421c-166b-4764-950b-09ed34fe3938;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-30T10:09:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|BY5PR12MB4100:EE_
x-ms-office365-filtering-correlation-id: 3a050460-7007-463b-4ffd-08dd41163fdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/kJAJmT+dEecxICtBOg836UmvMhWPntNuPr+VcpX3Wb5F80oM8Ok4Okq4J2n?=
 =?us-ascii?Q?o/2JMenhJKNzeV3CHtdDaRgSqysb8ifMsnPy+q4tWl0Hl85ut5ZLOHLd9dLq?=
 =?us-ascii?Q?LlJvP0v244AKWTwrUKmdfcvqp67DxPJqOQhoYHe4cU70mxwZNvYqOV61JHfg?=
 =?us-ascii?Q?dPe6Y5+Hd0vXXGUHoj7QKLgCXPyg4+ecnrcr+9+G0VfPNBa9JwpW5Lc+vBg1?=
 =?us-ascii?Q?tO6iHa0u0WIlwlR0L07xOM+CWuxwIDRgQ3Y02n1NfhQ1M7ngnnus9GCeQJva?=
 =?us-ascii?Q?7zdf7F6YBHPudtnuGpnma3ezWuwYkGyQx4MpsKha2+WG+KrjoiqqrEJv3sh0?=
 =?us-ascii?Q?h5nxw/JsNEgBvF3RLjgDz/mitZDp3fmEqZ1g/epqihnVrTl0wfXg7ZLDHLs1?=
 =?us-ascii?Q?Vh6Dt7KEVfw0pjguQrsQFyDkiNFDi2DTdN3mE1xTlsk8SDbu5m+Camgbadv4?=
 =?us-ascii?Q?ts49W9/uslwk9rdndsqNPuaGfllX+ya1Jbs9EKsF3As4wlo0RERC0apksgYS?=
 =?us-ascii?Q?7cq9psMQl3JH8gXXZRyJ9dSQDUM4xJS8eG8//D5uWeZQEKriqE6RO+Qqa2G1?=
 =?us-ascii?Q?kMnu3zMZ3TSpp4BECOnGizwEkBtzRazNDpl5Z3yhjAdaz8EqRtApWEX0eu/w?=
 =?us-ascii?Q?4Oy1An7sDP9zTH7ZUa9RrzMjkrCPdUlx7aTjRUbpzB6RMC2HU2trEMgdLdA2?=
 =?us-ascii?Q?cCHqF3XXOnU+vshguqHNFZ+Q7w/AhiXVCaRuPwduKVM4Wasv7Ay0TR6S3y4c?=
 =?us-ascii?Q?cgsymNlq3E6p3xBfcIYzObn9U2H/jUYAridcTfTyDicicYx9cYjVVZSWb5uC?=
 =?us-ascii?Q?Ge8ynIgbvkqJ0DpXjOEY/ma/zhryzqwZaZL7Ufj2U+xdHtyatm/CZK9K8wfo?=
 =?us-ascii?Q?F0AEwXuWu9rU9K97C3gYueBp4+PPF8Ucoj7bVZhF8BJSwdHPjt3oIMlxEtRb?=
 =?us-ascii?Q?DWOqIcsTCr9UQYOrSm/dS1MCJRVdGSEwEZ2PGrt5yZIkGt3p5c6xI4qWgzll?=
 =?us-ascii?Q?LxfL9IW2BA7HgA25jcac/+XyTczHLVV60hJ3Hr7JxOqwrBXIj2qyYfvZHk2h?=
 =?us-ascii?Q?dprm3JCTYasWjsciv+E/4zVrGIq2cDoPfPwmRwQLrBJwEoiAwNZSNeMLAFHG?=
 =?us-ascii?Q?ASuZmRkdbxEXPaQRm2IGVHj1OznNQ9upiwZ9bladBL/KdIkMCr3sP947Y2oB?=
 =?us-ascii?Q?lMKPdoDgPZch5s8+MsHNwaV6GRJl0ZK5h55Yy24564umDNI0Kie6YsbYZFwV?=
 =?us-ascii?Q?5lFkbvVf8aslxRvRmwSOUla0heSuLhoGHUdW2v+EJcFSdSUTUvY2GeHa63uP?=
 =?us-ascii?Q?5Lx3oTgk3ptnVW/wfEDsuSPJsTyujz0AWTVVlLtjhp0oYG1vQnBI0IWfPR+q?=
 =?us-ascii?Q?0LPKmcJvMN966wCSsFW+Q+48UGZBp32jcWQjDoLwDEMx1sJMjIzfO78a1OTR?=
 =?us-ascii?Q?dg3MSL+HS+dY6687WHLNLsG2O3tAB3X/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0ETTzsaDaE0zfBgGw4Z4MPhlGbFmOuYbWMTicWm0k8lGO3ujAVYCKsJeDuWr?=
 =?us-ascii?Q?3Juvi9N0XJZcenwk2vpdK4/Oqq7nRMfSjeIEpoMRMi6rmsXPJowIi5K83UPk?=
 =?us-ascii?Q?ONi7FuQK0WliO1Vi1adYFDoKzzSVjuoLdj4BBcSAFCvxDAg/7QS9ZcUjsEOT?=
 =?us-ascii?Q?1N3duX+ftPYHOQ6Dngz9jQWNRIUiSCTC36j5v8FwSbL+NYdkjCsgGyNKAxwX?=
 =?us-ascii?Q?3xh4jOVKkhk0wxu9Z6bdLpn7YP0cVjhAT8g39tkHXheqXdXGBOhFHbtj+WYm?=
 =?us-ascii?Q?5H4kUDWmuMBhLeD79/Z1bsDE9O/d0QXmoZNQ4WQmzKASG4+4wwjhGATHz+h3?=
 =?us-ascii?Q?2Wkrb8zUC60+QZD3JPHbhbuRdma50hNgHMGWhjrCXUeDdQIGY1KfhgpK18rS?=
 =?us-ascii?Q?Q8mKa2bb4fpwAHhTog/Nk1SsoE3A7b7Iu1xa1WxICyYVfadkIOhSfveuDqGo?=
 =?us-ascii?Q?mhbTwDXuAz05iAQ+/FKutjSt0VV7U5+RIo2Bkyye6sawHLNAs+AvsIE8Twfb?=
 =?us-ascii?Q?D33Xwb+M1ComvszbprphS7HhsczL504gZChcj1ohOCA2N3tTg1rgvfoKs1aj?=
 =?us-ascii?Q?lYd3rfJ1fqEJz5pJmubY18OWOUI9P2K8uxRkPM4REJ3CrdeQMxkH/NVwAVs7?=
 =?us-ascii?Q?YM4Uu3kf9lzISKlvsZzCVxX3ZEcvmT/gD1ruMUImOk/CaGPyXenCw3XC+XqI?=
 =?us-ascii?Q?USTe9s2gjYyM6ZFAke4sIkS1ECADmtwUdvxwPRS3HL+rEyROUmPAAcnoknQn?=
 =?us-ascii?Q?XG0ifB3N8GcSdLgTDels9i9MQRI3oral7k+MG+XIfqy47xjZSQW82eaLSy01?=
 =?us-ascii?Q?K2Ff3207COcyVC9hmSDiqnSZI9P6c2tarrsNPTShAY2vKNwNvIP1/kIoI9qO?=
 =?us-ascii?Q?a/FmZdd9hCMd0+JQtzzxVyg2q+tc5ALaXuKiwES3ZATewlWdYEcK7k5dpU/h?=
 =?us-ascii?Q?Act3JCRW9KByWK3aWhcWMoPbyBYj6ehh9AUvmIVBnCNXVvfP0Nc1/Jmbtuy6?=
 =?us-ascii?Q?/CxcqPwO8vTpmvghKgr0xakxRsFu5AmKg1RxOpnNIV5nKvZRW7lE2Cf0dPA+?=
 =?us-ascii?Q?3fr3A7hbwo/L4JH3j3dgbfx/8gP/Wtj3nYJTkg/aJfVzsathDRy5szoehc2P?=
 =?us-ascii?Q?z/nsmh/pTe4xcFMecHrMMySv87eXyY77eP/fyfZnRJSDOzNl4OJJElbZiiVF?=
 =?us-ascii?Q?gicZAqoH9ctRzuCbFK1VZxrI2aXCDrzFA23NL7uIsgpamfsK2s2yXcW6JX7N?=
 =?us-ascii?Q?qrxttobwu5adfViJv9gurxjSi9M8Y6EkZnlT5FCLWzcIG6934R6l2oRlyGCe?=
 =?us-ascii?Q?bWvxz/66soHBkxvoCYaPfyqos5UezReYZwksdzrUYyUbzroYV1ZCZzgiD94J?=
 =?us-ascii?Q?+g1hLI9m9ant4W7424QprWcmdbCy6nFEmaF5QbH37IfOg9LgIaf4QF/gvpxk?=
 =?us-ascii?Q?unRetK5LsAfklIgg3IfWtB12+TvbzZBLfgCjsmz/9q+kiTctGP5pjElrBKZB?=
 =?us-ascii?Q?FnuHJQK3lvXOff/lHz7pXej3yPsANRwT98IRDpFbSwgOGKvCEbZuP9QYzawq?=
 =?us-ascii?Q?KUy8FQWkwtRnpuVLv6w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a050460-7007-463b-4ffd-08dd41163fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 10:09:57.2471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9VQVJ/22bVFvCKBy7+M72UcQ3qLJy3b2BI5h8vnE36Ggwu7MVZQkizQ5r0HIKvFZpvvlX2bOrIQCiXJ8Y5JKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, January 30, 2025 2:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Use one level table if dpm not enabled

For SMU v13.0.6 variants, if dpm is disabled for a clock, fill current freq=
uency as the only level in frequency table. Also, drop Lclk table as it is =
not used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index de533076e157..7f0b4cc1141b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -279,6 +279,20 @@ struct PPTable_t {
                                   sizeof(MetricsTableV1_t),\
                                   sizeof(MetricsTableV2_t)))

+#define METRICS_CURR_FREQ_F0(clk) \
+       SMUQ10_ROUND(GET_METRIC_FIELD(clk##Frequency, version)) #define
+METRICS_CURR_FREQ_F1(clk) \
+       SMUQ10_ROUND(GET_METRIC_FIELD(clk##Frequency, version)[0])
+
+#define INIT_FREQ_TABLE(type, clk, levels, f)                           \
+       if (!smu_cmn_clk_dpm_is_enabled(smu, type))                     \
+               pptable->clk##FrequencyTable[0] =3D f(clk);               \
+       else                                                            \
+               for (i =3D 0; i < levels; i++)                            \
+                       pptable->clk##FrequencyTable[i] =3D SMUQ10_ROUND( \
+                               GET_METRIC_FIELD(clk##FrequencyTable,   \
+                                                version)[i]);
+
 struct smu_v13_0_6_dpm_map {
        enum smu_clk_type clk_type;
        uint32_t feature_num;
@@ -806,20 +820,11 @@ static int smu_v13_0_6_setup_driver_pptable(struct sm=
u_context *smu)
                pptable->MinGfxclkFrequency =3D
                        SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency, v=
ersion));

-               for (i =3D 0; i < 4; ++i) {
-                       pptable->FclkFrequencyTable[i] =3D
-                               SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequency=
Table, version)[i]);
-                       pptable->UclkFrequencyTable[i] =3D
-                               SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency=
Table, version)[i]);
-                       pptable->SocclkFrequencyTable[i] =3D SMUQ10_ROUND(
-                               GET_METRIC_FIELD(SocclkFrequencyTable, vers=
ion)[i]);
-                       pptable->VclkFrequencyTable[i] =3D
-                               SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency=
Table, version)[i]);
-                       pptable->DclkFrequencyTable[i] =3D
-                               SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency=
Table, version)[i]);
-                       pptable->LclkFrequencyTable[i] =3D
-                               SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequency=
Table, version)[i]);
-               }
+               INIT_FREQ_TABLE(SMU_FCLK, Fclk, 4, METRICS_CURR_FREQ_F0);
+               INIT_FREQ_TABLE(SMU_UCLK, Uclk, 4, METRICS_CURR_FREQ_F0);
+               INIT_FREQ_TABLE(SMU_SOCCLK, Socclk, 4, METRICS_CURR_FREQ_F1=
);
+               INIT_FREQ_TABLE(SMU_VCLK, Vclk, 4, METRICS_CURR_FREQ_F1);
+               INIT_FREQ_TABLE(SMU_DCLK, Dclk, 4, METRICS_CURR_FREQ_F1);

                /* use AID0 serial number by default */
                pptable->PublicSerialNumber_AID =3D
--
2.25.1

