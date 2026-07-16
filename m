Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD567C43458
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 05:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE9A10E2D0;
	Thu, 16 Jul 2026 05:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cv7rPgns";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1062D10E2D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 05:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2Qdx8/LXSPq03yip9Ml/SlGcWiEc7bOAIZWY0icKJsfSe/CnrZeUZLbqbQnzbjvhh/Ds9UjqHtGFSJLLrCF7tqLKL5Z1f+c1AYthXfgNMSqdYjXYVe4GBchtbYiwf4xur4VxHlDCOIMogPannApFqpDuG4kEMPDnkFaQfJijjoj+zPUb2UJxW0EDcZa3zCoXHPLvSHdpASVnepKNIXSW4LA3NZ0bDzA0z3a0ReD5hfiptSa5S9fv+aKX1FRugkb2ktpZW/eNp07ea6mppHz3GjQY+/qIsvZgOrUAnUNIVthxo3bMPD0PRV3STeA3n+GHzW+r62NFTQ94PwGWXIEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=602oZFf/yVnF58MvfEAEmuAPcU4DUuVSiHj1wJJgHzE=;
 b=HguZSbY3YbQkHanqyMjAF2wxNuuh6cIw1mN/hpoF0dQ+XNPPMfyVGLAEPDb5+gtVXKdfw8tLpey8N09/tzB5G4iVmN37xjUv9iP3NhjL6A6qNUI9wTQWMo3q9Q7IOBcrDElnMATaC3htjPwLUAFosGUX4XSrWIacgiUu9mKlbUwAh7q2B5uUCJ0gTo9bz21j2tw7RKeYglVHTvIm7CvbXExQ8FgD3eUO6RTJWnhIAgGFJrdDsSuY0Hujs7KjZX46hdGFORLonrgElDeDSGTfCRH+OTdO6q4AiNBjzh4E/ql1JvA2Yt9LEoXAmS4BZc2jkdrRJ5WT21X8qqXvJ86xqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=602oZFf/yVnF58MvfEAEmuAPcU4DUuVSiHj1wJJgHzE=;
 b=cv7rPgnsG/WcysSWAVSaR0Ovosc5TwO7dPcVuMae/0WBw+UxwfCNTq9Qx/U2SPKBGfhNHi8k4BqRq17SXRxheX+ho7zlA5ewHDm5LgYf7fEKESxt/xlMr0qtDJouE1hEsXejGPg5K95J4VT6oNbzm8vs423M1O9s9pak8BoAM0M=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 05:26:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 05:26:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 3/5] drm/amd/ras: add support for old ras eeprom format
Thread-Topic: [PATCH 3/5] drm/amd/ras: add support for old ras eeprom format
Thread-Index: AQHdFC5EIiB8qTZRw0KELtuBpMgtirZvnuHQ
Date: Thu, 16 Jul 2026 05:26:38 +0000
Message-ID: <BN9PR12MB5257065FFB002883508EF7D8FCC72@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
 <20260715074734.2668631-3-tao.zhou1@amd.com>
In-Reply-To: <20260715074734.2668631-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-16T05:26:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA0PR12MB4448:EE_
x-ms-office365-filtering-correlation-id: 1bb1b07f-7611-4f9f-e40d-08dee2facfb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|4143699003|22082099003|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info: 7Xd0Yqvi/LNFVu9Uxw3vda4o0hi7UTy/PT1wYyz1B11sTPXmb4Btf0VV42NMbKMJis+ry8vvMeLrXnnDBdHrMY4u4ORijeVlMsF9H3kr20S5s+csowAYUz8y3n6Eh3AJ2yYxQJbXwPqc/Ky9gN5VWiZnwR8h7uwRiqrKNSbyRqH2uk7vwnzydrDmAsCMLLP0iaEqv0nf2KsVVIpBkj1Ip7tFm5psfetqUIm2WMQ0vj1O1W4l5geK+vKdrtBPg6ckt179cm4iyB7Nv/IL1/SKIxSZWCi5Wu+nVRycUxoEH/cV291169nr+YZycQ9gv7r6qCzUXqulQlUH+DzghMPtD1djfUrJwEiYYyovA2xevpHtZZ7QbY+5yZOEcl9Q0z6P+ApKwiqOgFStJI6hXzP2uSev3VKp1n2qnqHTHalrVD2jxbxmbnfORK2VKxDIhIHje6N7uGQZf5bBtyVu3z0W9f/b0yB61w2BBYQweXY4dStdJcYEqJuDPcTCTtU+sWHKu33FGDJvDORfP9O8PdQkpCFfk93CZhoUJQtMUmX5riguZRFUOsoN7S4tfdp0dwNkXR/TnnbAZSPVMq9mmEYW+9RqtlRlNXgN7mUblV1d3yYIay5oXZH9vlPKGTD3gYEVuWrIB0EhUgqXrjzGm/on3WIhjLiZqpLjk3RTvUkAXPhkdvtbcciePNrzS5QuNm+JaniPSzvWkVl9jpfdAQ9xg8+JporAEassHnzktP0JA+k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qSFTYNXPGSewkuDrQsc323j84+rRKOAZXe8v97Z0Wza/ZOKHsR0lfQk8E7q6?=
 =?us-ascii?Q?aYmsn+KNIRIqeIXOQwU+XEZvSpkRcWBrMsDrMhIgGLpEp15x7g9KS6E49zo/?=
 =?us-ascii?Q?JR6KRbrsQnAYcn/rqFbvqMV0eZuQJCZWOxnk6MWIQxu9WA+9RkRZg8MzCuGg?=
 =?us-ascii?Q?+enZ3ckG822ApNBbQ69J7UbBMQ+V36xOifcmgUICTOLO0ptWYqdsAqSGkro4?=
 =?us-ascii?Q?wMhE5C7ZmT6C1y4AU8SqInyUNp7pO4ZqwdEhJSjqlHGTudTOUbvEgu4/kpBI?=
 =?us-ascii?Q?VQZCEt4e6HPW6ljNmRwAmOkUIZGe4XYbq2vSHoig+O5NciqtjMf1taYTCsaw?=
 =?us-ascii?Q?IvvSE0CWn2sOiXrGRKNPMcCy/Pk5ssqkpt9ca6ItUoQa7C43FHnwOU8AF0hv?=
 =?us-ascii?Q?h44Eju/D4wFe9mIQ8k96PMq/06w+jUFPEcZzdLIsB8cjFrTR4LlQgoNNS8NE?=
 =?us-ascii?Q?jlThIoznbVDtNSb6h7RgChZNl7pRLt/Pd7CPlCPQKpoFHtem2GQlTi56jKX8?=
 =?us-ascii?Q?wDKDobsoa2c9T/xAvjnAripbbQbvtcWqXUplKwjuKt5h9sVuqEln7Qra3nop?=
 =?us-ascii?Q?ZXXpJwjoHxVp4CE4hrmihs73PrQXplfCv/QLURyvbhDGZnENBO0TeCOM3PVt?=
 =?us-ascii?Q?EdW+zYFWYuf8mfa7tGBrZYj7EsJldUucLklRappu1IxMFr30ToF7eQxKGovC?=
 =?us-ascii?Q?PGd+mjUiEEdObSNjxoG7OzlwKkM3p/yR0OzQzwLaVWYNa5qo5FsAEOZgQr8q?=
 =?us-ascii?Q?3LgRY0oOl005NkibVyIVMfW4vdroHuIOf82/hYh3dff5V8v/TL4STr1yHRme?=
 =?us-ascii?Q?ASxlsckEU1qw//6BIMUyKXIOMYiChgGH7rrwtT9H/SgGw+P6BTlprcNY03cD?=
 =?us-ascii?Q?W0g5qzf8ZD1YRHjXpnY8FSS4/nuePFyc51hWhJzQYhUx3u7m+i46uH3jUaAN?=
 =?us-ascii?Q?/kYpZvJrWnO3G6HAIgRjVyYsro8K6F7VRj20XZ653alWajOU/FF2btBIuUyC?=
 =?us-ascii?Q?7St5qS+q5V8RKRoVYjed/GfdhqrPqFZ5L/Qjz9qyfCVuA96N5SIxhwYM/iY5?=
 =?us-ascii?Q?mXmpYq08XD5FmcF4ceFqt1fo87kCh+fCc9QZ0hWlUWlGpxBVkTMOkA9HOSJJ?=
 =?us-ascii?Q?AEzHgWnVVkrodE5fcSVVcR6KtHXc9oH+up0zkdKQSqGZXGJkP63zwk7NO7HK?=
 =?us-ascii?Q?mpuiudIKJE6da+SH7XAb8Vcfs7/zMw3fdqCKJlB54ujvLRiP3zsl26fMjZpw?=
 =?us-ascii?Q?EFlJhLWlduaAhRQqQTQmaA26bzgcwjeq645FmkW2mgfffBkFfHy22zn3dd02?=
 =?us-ascii?Q?3fUkOM+75f2ffxWSaryncX69XARjmMwco5q2QyqcRpborVO0OJPdkICStARw?=
 =?us-ascii?Q?4w1aTnIYie7gQe8IMwDdXxT4n0zcydum20kkjUGWzbJWjgJtMq6hq/EWYGA9?=
 =?us-ascii?Q?uxRyNsvSuLjTbaW3+S6beRjiRcWfXGJELXNUZJsOF7jetIsQ13eNBA4VvJ1w?=
 =?us-ascii?Q?3FzVOeUBjX8QSo+uGIljY9kCv/uJW5IUnrn1NX06eE5qeJ+q8K3GMbjBv5x3?=
 =?us-ascii?Q?apzJ1MJW0lO/RdD8Guen6EHqRzIjVCVlIXMa67wPNVDkc4gIZpmzXF7QCZlL?=
 =?us-ascii?Q?Wz1u4KgpljD3N+tJHt3JyU8Zy1ZGeXsNbNFn9xmEYlKNH//Gt0GVWDJ+R0Z/?=
 =?us-ascii?Q?nCnnfc6f067Ewo6sWvVyOKpCy/kbNaHAEXwROatk/fthOJTl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb1b07f-7611-4f9f-e40d-08dee2facfb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 05:26:38.7205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yp5L0AeJB0XAAINLrkQEoeu0pEbrnZs5IKQ4sc3OXXKIy1rO/0tEvZqlPeyUbi36RplB1CRILAK0mgzCEUioPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, July 15, 2026 3:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/5] drm/amd/ras: add support for old ras eeprom format

Handler of some formats will be implemented in the future.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     | 17 ++++++++++
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   | 31 ++++++++++++++-----
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/am=
d/ras/rascore/ras_umc.h
index 71b6703193f5..5b9218ebf2ad 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -46,6 +46,23 @@
 #define UMC_ECC_NEW_DETECTED_TAG       0x1
 #define UMC_INV_MEM_PFN  (0xFFFFFFFFFFFFFFFF)

+/*
+ * a flag to indicate v2 of channel index stored in eeprom
+ *
+ * v1 (legacy way): store channel index within a umc instance in eeprom
+ *    range in UMC v12: 0 ~ 7
+ * v2: store global channel index in eeprom
+ *    range in UMC v12: 0 ~ 127
+ *
+ * NOTE: it's better to store it in eeprom_table_record.mem_channel,
+ * but there is only 8 bits in mem_channel, and the channel number may
+ * increase in the future, we decide to save it in
+ * eeprom_table_record.retired_page. retired_page is useless in v2,
+ * we depend on eeprom_table_record.address instead of retired_page in v2.
+ * Only 48 bits are saved on eeprom, use bit 47 here.
+ */
+#define UMC_CHANNEL_IDX_V2      BIT_ULL(47)
+
 /* three column bits and one row bit in MCA address flip
  * in bad page retirement
  */
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/=
drm/amd/ras/rascore/ras_umc_v12_0.c
index 809cbd846883..b8630aba9e64 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -459,16 +459,33 @@ static int convert_eeprom_record_to_nps_addr(struct r=
as_core_context *ras_core,  static int umc_v12_0_eeprom_record_to_nps_recor=
d(struct ras_core_context *ras_core,
                                struct eeprom_umc_record *record, uint32_t =
nps)  {
-       uint64_t pa =3D 0;
+       uint64_t ch_idx_v2, pa =3D 0;
+       uint32_t save_nps;
        int ret =3D 0;

-       if (nps =3D=3D EEPROM_RECORD_UMC_NPS_MODE(record) && !ras_fw_eeprom=
_supported(ras_core)) {
-               record->cur_nps_retired_row_pfn =3D EEPROM_RECORD_UMC_ADDR_=
PFN(record);
-       } else {
-               ret =3D convert_eeprom_record_to_nps_addr(ras_core,
+       save_nps =3D EEPROM_RECORD_UMC_NPS_MODE(record);
+       ch_idx_v2 =3D record->retired_row_pfn & UMC_CHANNEL_IDX_V2;
+
+       if (save_nps || ch_idx_v2) {
+               if ((nps =3D=3D save_nps) && !ras_fw_eeprom_supported(ras_c=
ore)) {
+                       record->cur_nps_retired_row_pfn =3D
+                               EEPROM_RECORD_UMC_ADDR_PFN(record);
+               } else {
+                       ret =3D convert_eeprom_record_to_nps_addr(ras_core,
                                record, &pa, nps);
-               if (!ret)
-                       record->cur_nps_retired_row_pfn =3D RAS_ADDR_TO_PFN=
(pa);
+                       if (!ret)
+                               record->cur_nps_retired_row_pfn =3D RAS_ADD=
R_TO_PFN(pa);
+               }
+       } else {
+               if (record->address =3D=3D 0) {
+                       /* for specific old eeprom data, mca address is not=
 stored,
+                        * calc it from pa
+                        */
+               } else {
+                       /* old eeprom data format, the scope of channel ind=
ex is
+                        * limited to umc instance
+                        */
+               }
        }

        record->cur_nps =3D nps;
--
2.34.1

