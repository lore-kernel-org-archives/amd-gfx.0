Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A390CDB470
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 08:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C344510E04A;
	Wed, 24 Jun 2026 08:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X4hiQG01";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3A410E04A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 08:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sm+DiBMk+WxVbeR8T3bgB09hoHHar+JxVva0IfY9ULb6uS0hIGMa7EzJqb8UuXmea+KX1HdZOF9N5kt4iYWAyd6NqXpgapWz4oZ59fnnrlFT/VWjIuZ1Tla8Q1dYzkkkEalxnH+aIJCyCqr67+GVkg+ro65NW6cA7ZcyQ5mC+rWVbsuK0J9bCrthkV4ou08WAFc+Bbb4NR2eWOFJhD6ciWif3ETkoV0vHHrLjUgocDwHw1QRhKdy4+LPdlNQ6zCTSJAKXFWJZgeZrqkpxpI0cZLyZIdfZQiIivpjYX5CJ0lLdFU+SAj7Fg7QkD0Pr8B3ClWOePfdNM5sp59L52Re4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUBlEV0omvQlJA9udwHCnO+HRilLfkBGkv/dYrC/EVw=;
 b=DNL6ED9otHSVxKOjbTkej3av8E3V5B9c+FwHb7FTZfes0p3hYgO9EcTQSzLddU2GuK1YMDw7Eo8dojDPi7XD9xc3vMbWBfklZymjeyotK9mN2rumdgFb/GpjnYqfB5HEb/Mo/89VPI0jVcOyG0fPNf+XDYbZ0Me4Qff+eU1tEqpX5RVh3tKcEYjTJv41ZC4rKa819zJ2sqZCxLHbR7YiTQbniMVPqWc1cepdGSRCiK70RZbzXth1juVEDzbppmYq01HAB6QWECWYjmqi7osL5myeV5+Qb8IHz18tkgzTKP7N1rC5QiGmAgBWQW5PP9VxEqkkCallb8uHJm64XjBm4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUBlEV0omvQlJA9udwHCnO+HRilLfkBGkv/dYrC/EVw=;
 b=X4hiQG01u0G2u76Z76wb9rPhGAqCKJoNeVG/4pJZeTZU1/wqzWy7EvGn210UX/+srtAGhIaCHbADuzOyRh5xVoqeuBO1SGHwhDmDqnUVWxPxic83oRWSG0Xblpc8V77qeucBRESvAJrzDvaymEvuN79N8RfVrRPSreTs1VUHzds=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PPF12042BF6F.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 08:21:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0159.014; Wed, 24 Jun 2026
 08:21:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu/pm: add pp_entries_max() helper
Thread-Topic: [PATCH 1/5] drm/amdgpu/pm: add pp_entries_max() helper
Thread-Index: AQHdA6TvkYdYRPGQdke2MJgDi2CeNrZNXXPQ
Date: Wed, 24 Jun 2026 08:21:11 +0000
Message-ID: <BN9PR12MB5257F29C8017B32FD067C066FCED2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260624064414.144468-1-asad.kamal@amd.com>
In-Reply-To: <20260624064414.144468-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-24T08:20:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PPF12042BF6F:EE_
x-ms-office365-filtering-correlation-id: bf80608c-d4c2-422f-21d7-08ded1c98d26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: mlACQS4iBfeLm2wpIAsgv96D4VUF1nsR1ubcY/JOBfmBAgb/qsIitGgLk4nAdlgcZjPdwYNKdyXkdqncX8mo8NIuT5P12X24xgov6D3NSQNvC8BbFIvCxgPxheocIWi3IPlwwalh3GvAxjkCl80HcKbdPJor2V7fPazhV/HqsUE3eKzKcpwaW/7iBQcwnPS9nRKLB4v+C+nvvgN3tpPytEaJLlBHmD5dKlBYAybUaiVVzStjunP7SNiErH0VgMQwD1Q+ZBqJAjV1UpydbZSClDt9Jnu+zhhQI/eyngB1OO4J8RkY+3Uxf2vTJAADDeqZ9L0W8T2oKRb+kfCGBgm0yupNHNjo1QqU49KrfFiaoxk9FxHeFNnnCnJsgOPCGkfzCMSh/EbHQn8khH/xDF/jurCVAJIhtQw5CzpLVrRrEGRoQeF0gzdZJ/lc4m4e86DFtxAT1efu0b+IiisSQoi/L/hVX/8EoUHaBid1NHda2CS/2lzOPXfukF2rSVA1VthJKns8GSY/XEygEOwwPFM+PjDd86V40dOVL5gpLcHvd0IPLQlEzJCNIbki4WBoFRrXwgc8lJ8GNjvu6yQ0dNWDY90xOYrhIhIqZD4MfSrnLuSHvAkDUY9uD6F1xXcwMaS7uUpKlxdakoQO5RelCogDEZWG1RwUR4mxmIfm5fZ0jNsl3ASne/zLezjRUo3A1Zn25XDr/H/xxQ48f0hKn+1N/t1BEk+O0tDjPhwCkD2JSBg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oUwi15ExuEdGA2O1RMa5gazJv0m7yJZcFz6TiQd5frZaYFx7NvfmxOGZraAx?=
 =?us-ascii?Q?CV3GJOJFvoDPfRAlmeD5QCcL3WbjROO9KAiUz+Az3e/jNpFywTTbUBC2hxGb?=
 =?us-ascii?Q?HhqHLNL8PPM3IfAkqz34XTq7ctPV+u/Y32EiIdvWMz15tUs7Q1zr48AvgBoZ?=
 =?us-ascii?Q?Z1AKrkJm2It38weQtBQAHOCcBD0bB25K7P1AK4UQDSwoYI4QbRFpxa3E3U4y?=
 =?us-ascii?Q?fDDIOvVG6exVe8HUVTvmEFpkF3IKzrqNI8HEUz2LccuZAgv/lJT/uAALqG1E?=
 =?us-ascii?Q?8bpRySQoIXx6ZPiBzjpijZogSA2YE5QkpUoAd23mbcQymrEqeO1hTc0qHIL+?=
 =?us-ascii?Q?Dn5/tBqxMacXOwH33DyTWzkPNVYRB62FyLMbXeveSY/ay9mpJdRLX7C3r0Lh?=
 =?us-ascii?Q?GLnksd5r3mGAyrpfWgwTuHV7ZtWoNSHh+NcRq+oey8lbJ6nlRaVMSXOBpDmS?=
 =?us-ascii?Q?xKgwjPTABBzbVZAsnymifrW9DIgV6ZM7EJAHoRMkW0KklQrSCZyuTDylGiMm?=
 =?us-ascii?Q?+k9+RKgPyCcpqZ98jRGHh8m44tXvzuZnUDxJq5REcgMOQ5Qv9MWnVhfP9F8y?=
 =?us-ascii?Q?7RaQxiqAq+dAw29ayL4Q7YBSvR2AJVN0flbrprjjGzDAySOccQPHIKRSdNZO?=
 =?us-ascii?Q?jWNCm6vp6f2VJ4bjLVeUeZxXnQT33ywrJXuSs5NJMCiKo/Rv4lNIP2iXBwyh?=
 =?us-ascii?Q?EAsIcXBBXY0NGGGdhq5BD765Ss8F+jhOgEpPIIc0FwraC4pRKB/xfQTvnq0S?=
 =?us-ascii?Q?d811LoVLNQCJquo+1dZSVzoThOjBhrttgde/ck5eEDA9igCl/xsf4o1zzWwX?=
 =?us-ascii?Q?JqK4lWPy0EiQvdK6SWxGp1Kf9UkO5DmFdrDptwLff34bAz3qn276ZFPMWo75?=
 =?us-ascii?Q?rUU4QyCA+CLbd1yy+kwPAP4KLzDFWCRUf95XOwA5JvW4L26+QtEVETi9sQ9Y?=
 =?us-ascii?Q?V9oj1GfH/aqS78iihilF5Lz9XFBUPsONRD40HA+fw7kyUFhRdYoxhr00UIYS?=
 =?us-ascii?Q?Ar18RTwPjI97U4nBzRdUkpMIZADg1mRIRotiHf+uMwiFKaY+1eQpHiS7tLnS?=
 =?us-ascii?Q?4NtGZHiZkDy6vxQP316ne1PIChKFGEDLuFXaBBx5Ibg/Fe+YxgR9t5WK/vw8?=
 =?us-ascii?Q?lGMGZ/08PhUfzLo/WCvJOdj3DmBIo/Oya+TWbZmBEwjqoF9bb8gkA8l0iHWG?=
 =?us-ascii?Q?5ZC7evIKGp1BdtVbBQ0Ti94PGHNDBerHNfBIZBtG+V6Mna5yhaaFVDXABjFX?=
 =?us-ascii?Q?jb+M1yaUHjsgXalDUopGUsNN3naIY59biSWYnN4hJE+lt9HLUNL8nQZWDAff?=
 =?us-ascii?Q?hRfDEr/GSH1X2fjBs4hR+DUTnQXUxjXv5exU+HOAGGfeYvWgwNtOXdqdAtUL?=
 =?us-ascii?Q?9qEeCmwp6FFh8+Ow2GYKP2h9okL348mfrsszGtrZGtyRQrq9fGa3mQDp5tyo?=
 =?us-ascii?Q?3hIZmbW44ZmWNaErm93AEbUd0Tr8Sq9GuGgGe/LEx1U6kg/RHFJHByDJWcft?=
 =?us-ascii?Q?DNRYO6Kk6iWac5sx7AC6UWeV4Mn+gkE8u8rwxF4ZtFLi6DGEvBGX4X3wxEit?=
 =?us-ascii?Q?YwEpkl8nL1i21uT0en7MZCSm73Y9T8LU4TVV/yCxN5AnQgPX2uJPiw1Ypk/B?=
 =?us-ascii?Q?lH4vjnNT0qFh26/f426E3WJNzef4ZRqHgvLRUMMZDTXqPF4VLQOfm8aOEdbr?=
 =?us-ascii?Q?x6zKIc9E+/1UVHgOU4m4jqcClwu6vTAgHGMM4KjpCcwVoCB7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf80608c-d4c2-422f-21d7-08ded1c98d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 08:21:11.9765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ik1ytFlcMIZ0AJK5VYS0QCvVbloo2xH4Luk1VMmOSbLCUkcJcX3X2TFEYELNMBj6iIEuJSjNkVt7W2aoF5GX8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Wednesday, June 24, 2026 2:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/pm: add pp_entries_max() helper

Add a static inline that returns the maximum safe record count for a PowerP=
lay sub-table, bounded by the lesser of soft_pp_table_size and
adev->bios_size. Uses adev->bios directly to avoid a dependency on
struct atom_context. Subsequent patches use it to clamp ucNumEntries.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm=
/amd/pm/powerplay/inc/hwmgr.h
index ca71efaa1656..7ebc1344023f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -829,4 +829,21 @@ int smu8_init_function_pointers(struct pp_hwmgr *hwmgr=
);  int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);  int vega20_hwmgr_init(s=
truct pp_hwmgr *hwmgr);

+static inline uint32_t pp_entries_max(const struct pp_hwmgr *hwmgr,
+                                     const void *sub_table,
+                                     size_t hdr_size, size_t rec_size) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)hwmgr->adev;
+       const char *bios_end =3D (const char *)adev->bios + adev->bios_size=
;
+       const char *pp_end   =3D (const char *)hwmgr->soft_pp_table
+                              + hwmgr->soft_pp_table_size;
+       const char *entries  =3D (const char *)sub_table + hdr_size;
+
+       if (pp_end > bios_end)
+               return 0;
+       if (!rec_size || entries >=3D pp_end)
+               return 0;
+       return (uint32_t)((pp_end - entries) / rec_size); }
+
 #endif /* _HWMGR_H_ */
--
2.46.0

