Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E61606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d6hjydvZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA61D10E141;
	Thu, 29 Oct 2026 07:26:10 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EAD810E141
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 07:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yz3x/WMbGYOS+SVBTO5NQbzI1eGLnOymKVnezkDyo0HV0H3aMa84wCNUhxbxSEU7crgPu9bJRQEreaT6xvcdoNi2SzxeOhOO2Mh6BWFkW4IuW5jFo+0FDWKADqpGtfHWYRK58NYmPd2b2UUxOfSVZHkfErIpQtiUgTJV2XBkarwZbtvQizlk661DUS8YhEx6FuKaJ3+4tSpHCNtz26i0zl8gk8pEPQtTy4X5SO64KGdHjJtq1FAvYFBpBdG285UyODgyWVR0mQK+W0CanaI4XMce2utxRoYPhg4aIyZ0O6upaMeUzNLpQJV2aIYFkEyiLlyj7BRVPztOhrZ0ZqBgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlrQki8VN2t6tCscjE1T8gLswZID0t7nXkj2kBObvVg=;
 b=ArFif7llkRq+QM7JMMuzcOFQF/or3EMgq/U/L64q4saJ1G+p0zKTLj37YMeNiAXh3n0fJY4YeLEj8NAb3NApmRO65oVk2FRUvdV57TVr6FZmuyIaje+wOGUkjBd5bAQa2Zs/efjWEC0qzZEilMMU7BvDV3H/7MhMmcmHZBWgoUWTqhbg5m7bFcv6GnvD8uoZfoNzdFlqHvTkYWOUMEFaJWuhuKPJ6xn9el7m7rMf/D4fS5ntGeDSTRBAHta5CfKGDcqUyIw3PWifPm1VMRKbY39icgBji1k+TgfeuUFIX4esUahTHzVXFdJ9NQg9n25fN510h/jSR3nvLJ/Px3hIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlrQki8VN2t6tCscjE1T8gLswZID0t7nXkj2kBObvVg=;
 b=d6hjydvZpixXBli1Pr+cFWWR6Q/ajUOp7WakWO8C9dSnzL9PowqkTAlY/fjXVC8vqDv/djr07LCTn+QotdWceyUrSfHjtbTDzxfqX2QOzo1es2TGk9YwJhkRXDJWbXoSKF6jWIvBBK7ZDYSn3jP2wlvn942wcSmtME4iivYh928=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 07:26:00 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 07:26:00 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: populate unique ID for smu 13.0.7
Thread-Topic: [PATCH] drm/amd/pm: populate unique ID for smu 13.0.7
Thread-Index: AQHdZ1lSrWNbGKss2Eq/YpAaOTArULcUHq4A
Date: Thu, 29 Oct 2026 07:26:00 +0000
Message-ID: <MW4PR12MB68036F974B05EE2C4CA0EE2A8E6E2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20261029035501.2334248-1-kevin.wang@amd.com>
In-Reply-To: <20261029035501.2334248-1-kevin.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-29T07:25:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|SA3PR12MB9178:EE_
x-ms-office365-filtering-correlation-id: 052caa40-a887-439b-9a52-08df358de1b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006|261028144727099003|10067099003|261022105027099003|261021121427099003|261009223027099003|261026121527099003|261026140227099003|38070700021;
x-microsoft-antispam-message-info: 1MZ5uzRZACcTVgqyD62PWIjE+iuWTNWftnaOfcZ+o3N5qLNvXPrwnWXlWdGW/NWZV7VsEFoHKhOmO9iN78xC2hORhWStQtLFeOMtpjZqGMXw7uq3T15QWNcXvb8AAGaAiWUd9knD3A+ifYRCu4vYir23rgKYwZFWI9+hDtrfXutjFbyuWkAX6/KvjJZHFvuHvoFCh5gMZaESDijzaR5l/oSTscZ04tvXS7ARF0OjUbYt473UgKrek2Wfb+TDEjUQFfO8iRA42DSiZ/bvNNlfAL78QyBW+SxOofR3h+Hp0FqesRcbZ3uhtua37GP5hnw+J+QwjDAW5HoU3qq1uAppz607zU6I+EI1GAIxQE9XLAZrxGFE4AYhKBAey0XCsN1bFwkj4PjCUw4UyTdTT3rzZLhbjUvZv+/Ii9bZ9Z4zi17UNeQ1FAdaWfjCLJgHUZIBHFqmy8ux+BWStjy300cV4BI1t1ckwIcaTZMGx+Dz6b5+2fqhE/8gj8C2Bxy4fr/bFiMtB+LZpkO9j6zed5DrddcbbimVCDT6Bq41OhDtvZwpRYUyGUixH4VgZCr0nUEndAf0ieuxet2Sd/L7cMXfgUuPZjq/BM+ABQWJ+UU3XTNEIG7q+cV9NmiI0w4M3+jCD/xAMXk8REGMIX7kfpfYgFITBfstkcj0ox6+xpIsvxSKajpeY1LfD7CUcMqVdrjQ244/Ab5SKBipWxhatE6GAAFdNgVDWezeMvNb4HEtAXs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d64xzb4PefdZ7YcHeM9dmp0oTRzNRgnMJEvhqNuIyIJdHkMZPslM9QeLltHV?=
 =?us-ascii?Q?sACMd4P1PFji+bqqH4YAayhdsQ6eVPWRiBO8NAj/jx+sOF6KM7vZPZkAF2xj?=
 =?us-ascii?Q?vWli7eH4OpJqfEtkVm+29C/nk0wPUMVIazPdaZ5D+rNBbPDwjh0hv8T1dzXI?=
 =?us-ascii?Q?i9Td7tSnXIAWbjdWwqCzNK+/LvWqplGCFSrdz0OZxMEvjf9Ihp8Eixha8tDE?=
 =?us-ascii?Q?kF4jIHC7yEspRIVPjndeJ6H/YBLe+e/Cq5/Sq8A8iwT4wwQVlwCh45q4WFGP?=
 =?us-ascii?Q?Zjrd6lkgyltZ4TA9qa4itm/rs0yp9NAL4Sb5Mb4LSV7AUJ3CmFjN3sKyYjH+?=
 =?us-ascii?Q?909wu1GyssNPnkZrR3LwaD3RoydF+I6wZW4BDCRDz8UKV9Cxl8tISpRgdPh7?=
 =?us-ascii?Q?ClkeiSDl7lSHFt0uuOUzvWqhm988UPABib9EpMH4X+bnBkJ3zEMBf4WEDHFD?=
 =?us-ascii?Q?VkTyjz3/fU0geBw46JbGVYhXX0TDQMwZYIVs5aRVRX4IVmYlrdVYUCCwxFqx?=
 =?us-ascii?Q?WtaeG5rrgNzHmq+FsM9agkhoK6Ukbmir1wEWz5NUlIac5jydrpljkI/husK0?=
 =?us-ascii?Q?cHbNrEIsY2jqdGZTlSFikk7XiF/quaKstNeZeYToyFiW/U7l7WrGa8fphzRP?=
 =?us-ascii?Q?+vAAqHE0WzpJXeTrMriWKZ5MZ9I2To1HqIy2LH8+obq5hQsEAsV9CzzcWBLt?=
 =?us-ascii?Q?FGwp3IMCvk+hDWJkPVTS3xd4nQjsbJdWY5GqWESUFQbITC9ax0BAFfDanTb+?=
 =?us-ascii?Q?Ldftq4VnhInlb0I/MGY6YIAPrsgeOrzoET82In1tJnOJ2cPwuH+ld+9UgUBg?=
 =?us-ascii?Q?sS3tTXrI3qgWqu1V/XgtGhKURW89YN4j/FLeW2njcLc502qQTrFH7tYgKezA?=
 =?us-ascii?Q?KRuWdvUjVHtMTlMQZoBu6VlGK+mfiXdt6qzF7HezHjrDJTYqEmV+lJOV4TPE?=
 =?us-ascii?Q?sBHL0MEmOURmek8eXFklaXimgkbu0XlUwvRZTz1i9kz9Z5rfs2GXAeUL8z+u?=
 =?us-ascii?Q?rpsdhna/74+Hnnw3wWCtcQnSN2FthKv60lJL2J5sLgmLi4G3nf4tswjA8mXv?=
 =?us-ascii?Q?leOUnss7Djx4f7vxxvFLcapeDF/nxBtyuRp6pQRSS7YRAqrTt5BlbU1Kl5T7?=
 =?us-ascii?Q?XQDtdv5fhhdkSyqM27oZEiiry8xX1fjurKRqg7FjMQqZ3E2HDfriYSJlel7g?=
 =?us-ascii?Q?YeOWl3XXvJj7f94kMn8MjC2IgO2WKAYRdNhEA1ZF5RmgRplIoBDPISFluAO0?=
 =?us-ascii?Q?soQ20lqZGD6KUrCWbMeznqTIVE8kJ17Bmep4/KG0wBTPxh/PThDcsIfuHD9u?=
 =?us-ascii?Q?FVP+35dmEtq8AqtsaZmmpkDR0ktXgEU7kztTPR2IhAS6NThtrwX5JOpYJY2W?=
 =?us-ascii?Q?WcblTUAxfG/Tuimn3/ygtU9aibhqRVVtwpdVX/EoPjnUCLMTicBPaRopGI81?=
 =?us-ascii?Q?dqkA1upXM4ttuTkFLpxkYWPwtLTNFMlcFHC5voPhLe27odVL4HdWZLY9sCNM?=
 =?us-ascii?Q?LSIinccNBYlrkOfS8FBqAfyvAq2h5GBA5YT0BueKFSE//zpwXU+gH96Qjby9?=
 =?us-ascii?Q?zmjGFGq3vxhIJaBkJtSVBYUr3/f5DCY1IidIvXDBc3vOw616oiMqPu6uVWNR?=
 =?us-ascii?Q?0ifzdH6VPLOEMl08m8yanJTDpoTSstIjQQCgwM/ZEgVg8Nmwwl/H0RiEFhum?=
 =?us-ascii?Q?rtWoz6jblCZ7Q2zCv1lOuZK1cKKmQRHYQicqunkUTNzhGCOI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052caa40-a887-439b-9a52-08df358de1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 07:26:00.2917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OlqjgcBsdCE4OOqiO0nMrtbXeLQ6t9BunQ7pklOGxnej+PQT+gNKyd+G6SqoJZdg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Wang, Kevin <Kevin.Wang@amd.com>
Sent: Thursday, October 29, 2026 11:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: populate unique ID for smu 13.0.7

The smu 13.0.7 backend does not register get_unique_id, leaving
adev->unique_id at zero and KFD topology without the stable GPU
identifier consumed by HIP.

The failure is observed at:
    auto ierr =3D hipDeviceGetUuid(&uuid, 0);

Fixes: 113cc31dde66 ("drm/amd/pm: add SMU_13_0_7 ppt_funcs for SMU_13_0_7")
Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index f4543da0f72d..7d795f2c582f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2943,6 +2943,25 @@ static int smu_v13_0_7_mode1_reset(struct smu_contex=
t *smu)
    return ret;
 }

+static void smu_v13_0_7_get_unique_id(struct smu_context *smu) {
+       SmuMetricsExternal_t metrics_external;
+       SmuMetrics_t *metrics =3D &metrics_external.SmuMetrics;
+       struct amdgpu_device *adev =3D smu->adev;
+       u32 upper32 =3D 0, lower32 =3D 0;
+       int ret;
+
+       ret =3D smu_cmn_get_metrics_table(smu, &metrics_external, false);
+       if (ret)
+               goto out;
+
+       upper32 =3D metrics->PublicSerialNumberUpper;
+       lower32 =3D metrics->PublicSerialNumberLower;
+
+out:
+       adev->unique_id =3D ((u64)upper32 << 32) | lower32; }
+
 static void smu_v13_0_7_init_msg_ctl(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev; @@ -3026,6 +3045,7 @@ sta=
tic const struct pptable_funcs smu_v13_0_7_ppt_funcs =3D {
        .enable_uclk_shadow =3D smu_v13_0_enable_uclk_shadow,
        .set_wbrf_exclusion_ranges =3D smu_v13_0_set_wbrf_exclusion_ranges,
        .interrupt_work =3D smu_v13_0_interrupt_work,
+       .get_unique_id =3D smu_v13_0_7_get_unique_id,
 };

 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
--
2.55.0

