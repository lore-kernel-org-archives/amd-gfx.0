Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5D6CA9ECF
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 02:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4349110E0C4;
	Mon, 12 Oct 2026 02:00:43 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B3B10E0C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 02:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpBQUrbdAUguFj76l+H0D7bwJHe+P2tOe/A7jEk8UuLZtITic/tArgXeUALjMH6RnZj7ZkeeRomrzNNZs/g28g9WC+fkPq5KxWpbVMtEXp+qpDgcAinGKNdl/69xLpE3dai42cDdp0PGrPllRh/bHt7sJVo1oGNYXWgCl0c4Im5LSS4ilYH+W9/twLgwo/wPUJRVv5lP6XuHBmgq2IyRIo/SURtHaAdWE5l6tk+82KSt9398l4Ajnk0Kvo/T95BTjtqscOdSSib3aW2CXvEBTb5OujskJwloxV8TmWt8AgV5fVlafZKrzAcEaC6zZezr5EPcOEar0lYBpXlmZPOpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FBZN4NFx0QsG5xOmdOhXKtiA/f7GeGDkeckrU+Ef14=;
 b=XamSAVTluYcLYJcyiC2X8vH3RIyxVe9qoqStRIwOZZET4HeMmbevDxZfZwshIeVPc61oyAc/IMKHvDrICiVFcyjuWjLvuLX+VLD4+J3cry9PKqO7JYxMk4mZBEt/uyKEmW2Ie2uRZ55xCY3G3SOqU+pLUIxKECTfv7Ev/bNjmesyX76ffsGbbdSLsfdqMzv8TMzvgLvwDgEBY44c4U/A8Mw9GaI3GkPFM/+w15jI4Y/6bDZtyinaBQMPoVj7U78EYa05zfwznTz0KYt6tXbKAvATFkzdfKH3M7cydAQ0g0k4nqZQ2P3XGoTjQj4XpPejxRb6DXUgx5BC4q2nmIsIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FBZN4NFx0QsG5xOmdOhXKtiA/f7GeGDkeckrU+Ef14=;
 b=nrkSppRYXRy3bma1yRzCjO8IjEEcqkFMi1Gpf71XJpCntjQWGXyO40EWm9JG9EfE2MMnHN/Ooehly9a3qaob+9ZgGKCAh9ezh/QV5iQd37U6G30H3j8Htj5BHbBsq14vu3rTM8tusK0rpVvcaU+rpIWlzYssfdXZq61KzjhTY5A=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by MW3PR12MB4425.namprd12.prod.outlook.com
 (2603:10b6:303:5e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 02:00:33 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:00:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH v3] drm/amd/ras: Use MP1 feature status to select
 fw-managed EEPROM
Thread-Topic: [PATCH v3] drm/amd/ras: Use MP1 feature status to select
 fw-managed EEPROM
Thread-Index: AQHdWeq8gTOHsY4MA0unwQVUmyyNXbb5JvRg
Date: Mon, 12 Oct 2026 02:00:32 +0000
Message-ID: <BN7PPFFF39339DD2D9ED47D5524EBE2B0E0FC9F2@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <56d3bbcf940024032faf81b5bf0732e9a45db483.1791769175.git.cesun102@amd.com>
In-Reply-To: <56d3bbcf940024032faf81b5bf0732e9a45db483.1791769175.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-12T02:00:02.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|MW3PR12MB4425:EE_
x-ms-office365-filtering-correlation-id: 375e3c25-e770-4efa-5627-08df28049981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: rLVtBq7a4i7ZHqssgKFuHGQ0Dlo+wcEIH9lOkya/m03QaZmGvno43dvHsQ6OntlOKuvU6TgypnbBruTa/wjZOSAJ+NhtqWMzB1u8sowD4ffCgKOtD+58meyx3thyHwTrR798mx9cQY+p++USE34hqNxYVTW2MgBZGMssBlU5C1XRgQo65huF3/Ke0GruINZqR5ciqSl/YolXSQxYXPmHjV4R73L5b11xs622WhwXvgasoNXpJ9s2WhX59/XoBY8FOkibAZ+Unm/AtF2nkhQoNw3ZfrQZH2+NGr3Tl2qmQ/tGG2/sLE2dHMchnFUzsObR/RgB/lrAD1HZ64/0iKOiYBplWeRG0TSPxcAWnYq5bZkevHCEUWGi8qC9pRB8tRxy1HrUfufiTYdFcZmxoy78LHRhIl39s9Skt7csaUeKVUZv+Km1hsyZ08tk5ZfcOM20iBVUKlAaLrVt8/9eHuCZSjPPIpNAAsnkZCCR05cyitfwnFp9GQgEOupPf+RA5qyTZKF8Qce7pOmP0SJJ3goFCNb0Zbdl+HTPOyrREbPE/5xz78ChGPdm7PtG/3NMHy+gEtx9r+F2ROVkw+odz7Mc9Nury7QDMg+jvk0/EQmWYjczd+2Os/LVl89ZEKKE6GJPSiYGB8BzDMXWNA+WGVnZTxhu5qPhdyeuNVtJqUgBW9dSjMtw3+eDbW6B59pzezkaBI53C4i+3JygRp9px7iNYzplOchu/rkMCy4sm1ZXWlI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eVub8YgI3+J/R1GN5gPDFuTywzkRzlCujA5gfxj58rdoR8QHmvtBMLplD4Q0?=
 =?us-ascii?Q?cnv0mJ3kFse+1cntX6mxl9ARaeoD41n7CiE8NyhmigbIrgLuJ4dTGuDBexV3?=
 =?us-ascii?Q?Cw/wHJJpndKHFd2kAMeOAV0HdQSApH/1V2HYOiqs0NmnR4nQ1/u8Bg8rCpBe?=
 =?us-ascii?Q?zAmC8+7p0X1bgywU6RIzwHhGYGJurRQnIQQpQTTe7xaiiHgoT9a4NQFwXwJp?=
 =?us-ascii?Q?O6RdidXSoHWVbJEOhkX1hV3HGq2MQU0jLk7t1HR6rBDZ60g7BLjs/tZPAmpe?=
 =?us-ascii?Q?rFO5aFoj6FIHREqBYcl1HHirSdM3qh68iHUwJUvYa6Q/UaJQsn8Q4fL7yna7?=
 =?us-ascii?Q?Wi/zqi6T1QB+GQNJ3SmQX/ZW+iVuU/ZgSLucPNMTOySnvSgnOFBOA6TVKFdh?=
 =?us-ascii?Q?YWcngxRyAyGNCWauF01vc2jLhxkt4nyXDGRVJJk2TRwe8D1tAGSuUYCR8cC9?=
 =?us-ascii?Q?t8qHC9SDxC7vMtYN/t6jXO2CbqbgUF4EkL+SwByLeYbRoaT6RoWfVtkqpe88?=
 =?us-ascii?Q?PTOn8TCXEO22+ncc65uaEwtPtBTrfQoDePH4jbSugOnuYCSbBaKdtnOm1w9H?=
 =?us-ascii?Q?LN6pNAX4Z/FMmLqYsNSPB+SEYvR9T42rsOasBA1anTvO9/v5N0o1MVgeMYsV?=
 =?us-ascii?Q?noPL04c4LCSw/gQgI06ViVkYU+qjBTAeVqqs4lkoSzMJkZHYLSEyI681Cbal?=
 =?us-ascii?Q?B6NykU3BNwnZI6MfOhGYY2MzMQCij/3qcZNT3cYeGkdDEwEW1Ob+QoREOf3m?=
 =?us-ascii?Q?Mhc3nIGEGrw8MNa7lEOqU5Fj2ldQFMv3I6i0j5ZQrDeFLwHFxsbZvdo0t4ha?=
 =?us-ascii?Q?otuBfik6G5geEgTvf1DJQciB24Qi3jn577BUYG2f5wHmH1unXPF4qUtmPc8N?=
 =?us-ascii?Q?Tew6Or0KAU6WDOO1HL9IvF9rCkbSTjrmd34rSoOW4QX+bBrEN+h9xICSDFCA?=
 =?us-ascii?Q?sCbsh6Q9GRL2Jadl6bZIQ+BFVfSBtd1Y+te7xaka2HPkuFQPEgsNXFPrgPyN?=
 =?us-ascii?Q?u2iJgyxy84AYZJCiJuF/dXSC/J3X9QVvoEuzHlOlRb0Y5DT6cJ+CNV795a7l?=
 =?us-ascii?Q?UcwCFrF7quiPiYNOZ8RmtJ3wIEkoL05h+AVSNTKGsAjDuv0BH8ASRdFi+8ez?=
 =?us-ascii?Q?2J5vCNXr37IVHqDAs1EHBFRTdvIhiTUqRcfaLD8vn1tKUTLuiQKKF8kBQoYZ?=
 =?us-ascii?Q?12i3DTr1ua6TVwu6U9Ps/L2IVH8VtBsIjbWdearXdXxOfEHU+00wIlLg6LnH?=
 =?us-ascii?Q?+wcm1FdyRgmArj7ynn59bsUdtrAIHHcChpjlHFTVtaJ7QYoX2sZTc5Ep3eag?=
 =?us-ascii?Q?g8biUTP05OlVcau2BSU1i6Fi+e9aveAhnFimPmST2xyMNcrW1xPNyi2Kr6KO?=
 =?us-ascii?Q?UqQDtN9saYOhsKLXo7bs5i9Sn+udP89Wb2Gb5WIFJU+dS1iVQBPKGKJrEAJs?=
 =?us-ascii?Q?xgabow+5CDL9RTAGGjcGkFv1LhhVLWrocuoO27lAbFhIJasaP/fFI7h44yxc?=
 =?us-ascii?Q?MNK6gvzNDAgdlo59Np8icbqxgJ5NPLQt/pBt8K4TpDQzYd5+CXN5YROZZcwy?=
 =?us-ascii?Q?MkVY4tZsKmJk0uvEjVOMBn1o/A/hh6WxrhsKI1n8Oy402vRKaSgDCl3VTIEj?=
 =?us-ascii?Q?c7bSGRuDWrBhydLZWispwtoXx5FOZ8nbl+GQh1/V2JfYkVjg1JqV3BZHIkHB?=
 =?us-ascii?Q?vWEWlteFMueCyBAoqtFLt6olgRf9YAd2F1Ja4uFyeVRgDipY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375e3c25-e770-4efa-5627-08df28049981
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 02:00:33.0002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44a/GjAnJ3SWfenVWUNEQmzhNRnDA0kvUpH9KcvMf+iynG51rSjsfZx7/gmeyBmWA26vuwAa5prki5c7OvYXeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Monday, October 12, 2026 9:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH v3] drm/amd/ras: Use MP1 feature status to select fw-manage=
d EEPROM

Read the feature status of RAS_CORE_FW_FEATURE_BIT_RAS_EEPROM
to determine whether to use firmware-managed EEPROM.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |  2 +-
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 23 ++++++++++++++-----
 2 files changed, 18 insertions(+), 7 deletions(-)

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
index fe0e35357af1..e1b70dd7b819 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -26,6 +26,7 @@
 #include "ras.h"
 #include "eeprom.h"
 #include "eeprom_fw.h"
+#include "ras_mp1.h"

 static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)  { @@=
 -36,25 +37,35 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip=
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
+       case IP_VERSION(13, 0, 14):
        case IP_VERSION(13, 0, 15):
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

