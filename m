Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE85CA9EBD
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Oct 2026 14:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1BD310E021;
	Sun, 11 Oct 2026 14:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fp3N2feP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE0510E021
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Oct 2026 14:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcU2FfUyl/eucK0g++Rr3pOsBw2yppQ4WD8azImjPk6/VoppN+8IE8lw65vrXKZQpQNoufE5O1g5nWk1u7DKbLbZeOzPtcwk9+KwrzW2QIOJMfRuVu0gkZ24O0pLZ3Wkb4WFtSxhbaTRNKLb22vGHM7qrUjdUqNl3liZWFgJNElDnA5ik14+l8V1EgQgx7DeduZ40aJBPpUpoz4iXd6sajpOjNcf7lLwKOwxbetGOl3QD4eoKg5NGvoEWxCM8icY1x/KD5MOOC5ZadiWcbGDi17mad0pDWZCVdBY7NX2ylqlJcmHnyVDKCtjimZTfPTCvy9xnEbTIKbAitxkNeLetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR4wr9mUOUhYWkI5poXMd6I4bvMfsOvUqUly27tlBXk=;
 b=tPNmlP0BevIRwH71irxBGFrdczzC4QNEOGUtHidwPFmAM05J5d+Cqs7VmUub1ApIS0UJPrESZrCRE7/KBCP3YLs4+dLedHbfDCYtf4Mctx4BdlvivHQVsz219jC16p18pxZruIpQgOnMvkRXyOD9D+AfDCgnYEp+wW34enZdFap7wQxIz/QGruWRK61ReourrGTJDD7lKFQ2sG0HvKmTbK0XIIwvDCS0DodAdsPfueauI+lD+w1pX2MsPKxj9K91BkwaKtDcsqq2ds2y43op5VRZCMOzQUwZIWuoCvHaro/Tt6soNbTNEOwkQxHSYrXQ5DpSnO1hIDoTOZBqUGxeMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR4wr9mUOUhYWkI5poXMd6I4bvMfsOvUqUly27tlBXk=;
 b=Fp3N2fePFEGaOmPIZyZcWaLsUSYIFnzjTGlQCnvQK6wCvIgzgY7fmlmrPK79UFQWv+c9vhc/RlHsTlXf+4paY8xkEXn47ZyszydENPeMIOvJrcp9KtZvAk4OY8NL4w99iqGbzlyWpijvX3EsxMXiBKvjWXuyuz4c4HDQlrd8SOo=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by IA0PR12MB8278.namprd12.prod.outlook.com
 (2603:10b6:208:3dc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sun, 11 Oct
 2026 14:57:44 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 14:57:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amd/ras: Use MP1 feature status to select
 fw-managed EEPROM
Thread-Topic: [PATCH v2 1/2] drm/amd/ras: Use MP1 feature status to select
 fw-managed EEPROM
Thread-Index: AQHdWStKo2jPBaacMEG2WMERK/ba4bb4bWqg
Date: Sun, 11 Oct 2026 14:57:44 +0000
Message-ID: <BN7PPFFF39339DD20B115CB61A2962AFAA0FC902@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <cover.1791686882.git.cesun102@amd.com>
 <1fbc1515d6cd8f36bb3f60b498b3fbdf6e7b4760.1791686882.git.cesun102@amd.com>
In-Reply-To: <1fbc1515d6cd8f36bb3f60b498b3fbdf6e7b4760.1791686882.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-11T14:50:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|IA0PR12MB8278:EE_
x-ms-office365-filtering-correlation-id: 130b1ca2-d00b-4ad3-04c2-08df27a80163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|261009223027099003;
x-microsoft-antispam-message-info: pxW7a952qbZXarIAHCRp9StMBNuIiKTmSI5QsucZqHd32S6U8vSF2ZFdpB84blgkk7idJ7zfS4Z8QGQIh4YgBaNIEQ1vLd/qJRXUF073qsEua+t1vBtHY8ylen2f8g2lU8pCCnyd7x9l42mCVV8MDiYV6KhUmrIQVLtSjm/0Lc281E6/yDPpTcZ3ihYJxfrp8idNGXR9lo6AOiVRnHIo8HHZVQTNxH+0YKpjiWHIUVbSSk6PBbGMwo7LUN6dIaqwgqm3wdaSw2UZswpBxxP4kB5zNsSPOhizz6fAoLZF4vCwV6GM4dC4fgkBM5B9qy5zd9rf9hfjZmKFnfweBkMPzsyncY7nQQf67/VdRd3xutJtH4HhzhSKRXn28Baf7IrEo8gYeRWLFsAdlnu+DO9dTVyTOkutSVrkJwBH4tUnlZC+44EuCezJGwaVAiJ9GU269a6VXbaw+HYOpmBDt2yyrszs+wqWit+iRFUyTfdtupDXiwYK/8wKokt6q/MFo6q7rfLVfhQo8c7RCothCKWcuungPfpK8Idz9A/VebELF++nhbB1nUm83Tc7o2f+aYTFRSxUBv7Ua1uGLHiNE/qWg/o9LYBvMG1+kfn8o7RSuCzlC90fivWuBM6iI996KfeHtUHndC72kWaXInqm21lGltTE9FrqjQztd3qA4GEnf+U7VYcP54b7zE2ht1Xc9C8D8ZcSTspJy+BsLHZnww9ogsSeHecZMwfDZM9qIcRRCMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KO9qd7qE3xtPTAaJWPapqDA2qTz0Dlzantb00gXegGGhtpTQx5NjkEDyuYsn?=
 =?us-ascii?Q?PrYLFMVdAcDXZqM1BO7+J+Yl2IgBZQhV8XgeCZmVBMSlP7ENfP2LF0EyIs5N?=
 =?us-ascii?Q?LuDS5xMyZH1JmlZuHCwt1I7WJOZR0dN33pgt3jZoLBRb33Q/Ekj8roKTMscx?=
 =?us-ascii?Q?35YK6TT5K+1OpxLq3Er111WLlwmzwpp5OgECgc85jpPUqAUhy2wfayO9w6Zq?=
 =?us-ascii?Q?iCIxd2RKl1/9u5HBjHVg3F/NR6JhbYQPQ4g+RHunz9ZOnEn/QJDDha7C0GuK?=
 =?us-ascii?Q?faPirEa10dyf5RYK3SznTZHNCRSRXGlcxphBuzNw2bsGtwHkuOlJsF4MI1QB?=
 =?us-ascii?Q?YlRPp8rx5/R/YCnN3SGIGyLJlN5J6dYs7dlH+RK0OHiZx+es86w5eeRaVlip?=
 =?us-ascii?Q?FgGelBVhFn6uhyQd3SwuvKkth7zlaP09yGagD+tRYeZ4TCP2fBeQqPb8hSrp?=
 =?us-ascii?Q?CALxUwwgHRI3L4Ug6mPT+4h4OGYBxLZK7KgfWkaYhabXSbKE7guFis5/JUER?=
 =?us-ascii?Q?MzOhrcrkXW0x6ulpBIA0hDER/D1H2U8+LZm0jUf7bE6L/AcRNlbXY1z8YbS6?=
 =?us-ascii?Q?qHmTy+wALVPN98Xr6m4z4EUnDgm+0o+0xBynOe5S8apo0J36s5wwgSj3FRDG?=
 =?us-ascii?Q?rzv9oirQN6y2h8HSwvUTcZS41Ijgyz5tf+9XUl7VP6XD6YiRpvCI/4jxzFKo?=
 =?us-ascii?Q?qcv2z/zvS9wuTYvZzgd0x8vex8y48DzA3scbd5GvJSBsCs5pdgB/3MpflKrl?=
 =?us-ascii?Q?dsiUxmNI0z5Cj68jzJZ/kUv/oDuIwGddF6mtcQAF3i/EK3KxMI8LQDxNghZM?=
 =?us-ascii?Q?N8ADDGKPGeUbG+W0foKDp8bN9NFZucRELtot6NpIchw6hTGiWXoMyzbrztQo?=
 =?us-ascii?Q?ncxB3I/FHI9UEow7ccC8dsGdc5Utxw8VP2Gg9g9NvLRRC2yWHnBRMhP4XmVj?=
 =?us-ascii?Q?Kn/b4IWKwGGbeUbIsuz9iHbStJwhCu7r7uPC0nv7qZEPNdzJvo9eF0MtmvIr?=
 =?us-ascii?Q?GooQidnqnjqP4ttxB9mpmVTYpcqh3A54EBlw2gSq4Yjm4aBbMxBCf6qIA4Lb?=
 =?us-ascii?Q?2wiE2INtzhmshZqk4vYkUI7fXObI4l0A9zvesUiG7nlqVljuL8piLX9ACDQy?=
 =?us-ascii?Q?a5DBtGO+Ij31HELDJCYwrJHfhm7boAMrQzjCWH05dAtTqcKAk2DKiHLzjcqH?=
 =?us-ascii?Q?2heTkHe+RO66kaRPOqcjQql8L/A7PnssZhVlzL4kZ2HOUFHgRMndy5Xu7klN?=
 =?us-ascii?Q?xu6/KNFAj5dr6Oo0K8eQJwsK1i0pWOSkUrPszBFkcYEgtXrRTDnpbdS/XYrA?=
 =?us-ascii?Q?P9bJl9+kjcTuMpdiQHaswn0HmIg1lUeQUSzvxAbtapZeRvUVnEDApbc/azfW?=
 =?us-ascii?Q?BnCfDDlraMbITGY4aEBMaIqZjKHM9AXmnAops9t0KPq/ujnNuRDrqyJpl7cO?=
 =?us-ascii?Q?+v6yruX+SX9vRuu4RDnWHZMgxkVCgfQ+uSTNb3gZD5ZQZcQGebBs2nfDjFh7?=
 =?us-ascii?Q?ZU8T/r4a06vhsuBxdHaQg9gkp7JdcgNg9I1WQOibFsUGyCNvfpMCO8sFaBXV?=
 =?us-ascii?Q?NEbM8iaW5Uqmka1Sh9X4u+jbW/DelD4BRwRwUvVQLBve4giAjuOA6XXNLw2Q?=
 =?us-ascii?Q?MRtbH6DysPtNgVgILyOGrtOl3K+gGBNu5DXsAt+WeMZ/7Z4+sWISlNV3yFx0?=
 =?us-ascii?Q?+thYow7UQCzNgxWCme3lU1mN5eP88yQTNUIG1VdKVr/WtjAW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130b1ca2-d00b-4ad3-04c2-08df27a80163
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 14:57:44.0566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyiEaKdFopSS1HYb/tB2PWDEbApqhy9FrJYX56wDuq+QTV4QRKU773MoE/+JMu5FxhZqDRzahH/B+OuEwigGLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
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

-       case IP_VERSION(13, 0, 14):
        case IP_VERSION(13, 0, 12):
-       case IP_VERSION(13, 0, 15):
+       case IP_VERSION(13, 0, 14):

Both v13_0_12 and v13_0_15 can rely on the PMFW feature bits to determine w=
hether the feature is supported, correct? If so, why is only v13_0_15 remov=
ed?

Additionally, since v13_0_15 has been removed from the switch statement, co=
uld this cause a NULL pointer to be returned before the feature status repo=
rted by PMFW is checked?

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce Sun
Sent: Sunday, October 11, 2026 10:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH v2 1/2] drm/amd/ras: Use MP1 feature status to select fw-ma=
naged EEPROM

Read the feature status of RAS_CORE_FW_FEATURE_BIT_RAS_EEPROM
to determine whether to use firmware-managed EEPROM.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |  2 +-
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 24 +++++++++++++------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/c=
ore/ras.h
index 73e3960c7c8e..1b724aa23594 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -60,7 +60,7 @@ enum ras_gpu_health_status {  };

 enum ras_core_fw_feature_flags {
-       RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM =3D BIT_ULL(0),
+       RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM =3D 0,
 };

 enum ras_block_id {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/dr=
m/amd/ras/core/ras_eeprom_mgr.c
index fe0e35357af1..c6869b4ef598 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -26,6 +26,7 @@
 #include "ras.h"
 #include "eeprom.h"
 #include "eeprom_fw.h"
+#include "ras_mp1.h"

 static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)  { @@=
 -36,25 +37,34 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip=
_func(
                                struct ras_core_context *ras_core, uint32_t=
 ip_version)  {
        struct ras_eeprom_mgr *mgr =3D &ras_core->eeprom_mgr;
+       int ret =3D 0;
+       u32 status =3D 0;
+
+       ret =3D ras_mp1_check_feature_status(ras_core, RAS_CORE_FW_FEATURE_=
BIT__RAS_EEPROM, &status);
+       if (ret)
+               RAS_DEV_ERR(ras_core->dev, "Check RAS EEPROM feature failed=
, ret=3D%d",
+ret);

        switch (ip_version) {
        case IP_VERSION(13, 0, 6):
-       case IP_VERSION(13, 0, 14):
        case IP_VERSION(13, 0, 12):
-       case IP_VERSION(13, 0, 15):
+       case IP_VERSION(13, 0, 14):
                mgr->eeprom_early_init_service_supported =3D false;
-               return &ras_drv_eeprom_ops;
+               break;
        case IP_VERSION(15, 0, 8):
                mgr->eeprom_early_init_service_supported =3D true;
-               mgr->fw_record_enabled =3D true;
-               return &ras_fw_eeprom_ops;
+               break;
        default:
                RAS_DEV_ERR(ras_core->dev,
                        "EEPROM(MP1) ip version(0x%x) is not supported!\n",=
 ip_version);
-               break;
+               return NULL;
        }

-       return NULL;
+       if (status) {
+               mgr->fw_record_enabled =3D true;
+               return &ras_fw_eeprom_ops;
+       } else {
+               return &ras_drv_eeprom_ops;
+       }
 }

 int ras_eeprom_mgr_sw_init(struct ras_core_context *ras_core)
--
2.34.1

