Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B64606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ze5iUUN5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FA910E1B4;
	Thu, 22 Oct 2026 03:05:56 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C13310E1B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 03:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=md6QN4glPeRoFxU27XPYEpsKqf1VkgMbDDs9X+LOCW1/CHUAwi0OaYjk48wmKZNPsV51JeGuAZEH6C5mN2Lfczh+t8BVco1X9nMkew27W5GLEAvaRXFho71uYmi8zN7BBF1HmkBrvcirNyxSv854GIs1q6j0bnC6m54nv7WVfBrQ5FatcJW9nX+VSmFG9dEi0pvoOIbVikxat4u5MQvmkEWIx77FJuZ+nqz0/YDPkYObxWolIp14S2/fG3US60j//c8zQUHqLM+ap8tj0K8OddvymVah2WbU9KsjcGCR1SV5Si4ww7Jx05dJ1ntkCbxPfMDSj2c5GyqyxL8MMUCruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn++RvaWbRcFesjOT6RH07xlwO4EbgDR7i30gJsv134=;
 b=Bi22XPxogTVVi4QPiPTuUyat/gGru0cMnnOAH+28xQuSslpLAMBD9NW3B8dCtWt8Hmwrzvzj/hUijS+UhZoZaluRL9b/CIHzAu7ky8ykMCtxSVlY6OAUKDQnP0B0Y+//sBbNhWGSdEaflHyWwOzP0Q4bb01H5Ix4xR+NB4D1dnYWfXe2/idEp+K4MLqjKM+C4M5mlzymE8Ea3T0O6AzuejpbdJnjfWofiHFM5uu4kHG4/BMXAcYvqfdTy3VaC9YDFmgm7VqO9F/4NIfM95wAbz7cz+1aSq4ni9XgFn88e/IiZyZ1X1Rn1KRfmTjS0rlwf19yvtqdi12KwTfCL+ambg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn++RvaWbRcFesjOT6RH07xlwO4EbgDR7i30gJsv134=;
 b=ze5iUUN5creqXicjSsY6XYluLwARxn4oHQIQadGRllroyq15nChO6GXLesmFPq0soUgKpyYGFIhJ0pVIEcf2JahMV76kdlWs9WlUEMVp5MzAHDtIl6T9X2kos1u7AwaqdRsXF+sFvO0y1Ryxq3I1B/Ohv/poBIeBugTpZ95B00U=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by MW4PR12MB7483.namprd12.prod.outlook.com
 (2603:10b6:303:212::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 03:05:46 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 03:05:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/ras: Select EEPROM ops based on PSP IP version
Thread-Topic: [PATCH] drm/amdgpu/ras: Select EEPROM ops based on PSP IP version
Thread-Index: AQHdYc+DUmUivGEH5EWDZQyfc5OvVbcI4LKQ
Date: Thu, 22 Oct 2026 03:05:46 +0000
Message-ID: <BN7PPFFF39339DDC3A369E563097AB9D976FC652@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20261022024557.272114-1-cesun102@amd.com>
In-Reply-To: <20261022024557.272114-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-22T03:05:14.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|MW4PR12MB7483:EE_
x-ms-office365-filtering-correlation-id: 30a63c7b-fa12-498e-28c8-08df2fe95e16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261021123027099003|56012099006|38070700021|11063799006|261009223027099003|10067099003|18002099003|22082099003|261021121427099003;
x-microsoft-antispam-message-info: j0WcPIkznvWawzgXIgmbXbrykhg+jM3ktJU7nYM3joF1G7O5iq5r292sX3UO49fHu6VxRIPDlMWCNm42I2M8HB1J/20NpA1R3jBPTuLvh9YKc45BZnOVJ2W37cICrvHHBHo575VWLxOkjeKPugFxN+lFhjfl3mIgbyMt9kW4zbSrrOYwuS4w3js/3Q31XxTnoigwJt2MQTex+wCIOolQwUB2UMRIdgdcnVJm8Ctr1RwZ4lfSyio91uNLdV7/+cDda/XkWcwqKmn2gCQ5ejJJHfwtpNej2BViUS804E4yTvZijKJpnOLcMKPVuHEpRME/npbw83OiO0Zn3p636kraWPgzg1gplOI4np4PI2vqNsZVrsBZ/3xAaOYkZAJY9HGwC5lzL0e+HQshWjdmf6qxfbnu+7Nhpj/FyWvgLy5lE86I8wX9GouvAvQH53Y4KRqD+yvkYlbiHebYeCAnCYkvwG4j68D8UtMhTbkbjYQ+evpnhbVAl9qQyZALCA8lrIYyTy3QJYmliw9PdsFRqwyUvvwrK5XKh1Ir60Q4zW7ahn64RSEOiYLgzPue+umn2XFhYDM+F6g5bAjPoZDRr0sV14IWkbgkOj2gk1JQHMEn0soAgALtMI/uP036WuCegGTddwxXNtPttCuDuN9ZXGSJ9NlpaUfTtWhFSHvQD+vUrId6VVH5BNWjrCFm2eF48sUY9fzIlgcwcicB4cvSHJGeojLDr3aK7huHGLDQbuzHY1s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261021123027099003)(56012099006)(38070700021)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OsJHSbnG7bc+ZZBrw/6r4LWyZebvqtlgWDLMBHdxYC0eOl/ipKQfMioswcNU?=
 =?us-ascii?Q?gxDE7TZqxi4Am8ND5iHbbj/yECBcx4wIB//wavjoWF9lGsTFPCxyttfewWuO?=
 =?us-ascii?Q?goDzwPBuurlAme49kDUrPR6JQ7ygapDdwXyQ+JPEIe5Z2hywNUmClHM3EKGy?=
 =?us-ascii?Q?nzx5vyFhxFHeIzRk7kLUVoGuwt6niBsPCrWhN2hd+fYe/I/Eb66aTE/YI05s?=
 =?us-ascii?Q?Ib4HSF+VM8a9iNImzIFUyqksdXc/pPcb9dzHYW8k9sdh+krIX5oKF9ii1MGc?=
 =?us-ascii?Q?sxuH+jkgkd3F92WfteXDZ7D3uwg3t4stEBObaVRAnOShhV42sbtHhvhvZ29p?=
 =?us-ascii?Q?p8Uv+3GsX6ebuRoY2zSBN7klOWozA2G+LvEdshVDEHEAlgWtlm7d223rSvKt?=
 =?us-ascii?Q?b63WZ/rJn29CnvPuUya9ra86EeTcu457rkEdKm5ckCvZ0cJWZeBaaOdeStPJ?=
 =?us-ascii?Q?PHjmYCWUSU6L8J+6PsCIj14eNAFP479mdz8FHzh9mobsP03hOe2gFTcYovyt?=
 =?us-ascii?Q?7lfDBHZsuo+OXWSQ/qExJ3z0rsvRm4/oTBy5mb7OkmXH4zf5HPJ/AeJByLrh?=
 =?us-ascii?Q?7V5n0OVUUeSXlqgEVmN5ajtgY41Sttosao2jSyi5quoNSSEUlVx0ushTvSzw?=
 =?us-ascii?Q?I0pVL6i/YT4XBfVP2y8wuH33nyTd17SSPhPnQFfqxAyH0U8LJy4YMtpLgWr6?=
 =?us-ascii?Q?CZcp8CXl4tJaeSLnYIr3H9mJTeEQ/03z8nCObhTau6WDAwhkTc9TslsuGNbo?=
 =?us-ascii?Q?VRdR+z1b8Cr4wh3D0sHGcByjP/OmI/jV9gbnJBSZpF6j4n/JB89/6GIq2Rfq?=
 =?us-ascii?Q?s1fokdx0fsUZDzDP9pugwFS86l+/CxzuWLtq4LXlSaDMZxVsqBzPSEOl0TBO?=
 =?us-ascii?Q?FCOO0eyWqzwcYwVVz6pCDq32766WAzAVfNAewC09kFvEib45ufMqdqHp9GW2?=
 =?us-ascii?Q?3LEg3WjZUoiGBLUbvxbTe1OEvMd/kPek4i7r9as4NhFqxIAXoVWH1NzCFD6E?=
 =?us-ascii?Q?JUip0fiKTi01wcTWsxQcwrik0RvxsATkBfJoBX4LtPDkF86wXk4CZVMpk3Se?=
 =?us-ascii?Q?8EhlF8odNB8BgRH4fpzdH4551wqSR4MlqLO8+5omwy0q2m2bOM3+TBOv/oaO?=
 =?us-ascii?Q?x3ObKagfl8YzEIGKUIPZEgqqRxRHAAk64Ah2SdcjP/0a4EeUTRUOdqXoSKWA?=
 =?us-ascii?Q?+sVPV+ArWxrlzblDuDZcqT6yFzObDv2+uLiz300b+ZvXZPR+Dzc/JoU5G93t?=
 =?us-ascii?Q?oor0JJit0m8Tbvtliq96niYc4JRGTxkRNisAQR5TyOgGTx405uOnO9FeVxQI?=
 =?us-ascii?Q?usavKGsb15nx4iBfKJ/ZwiqHTme+kfCbCZegWjmSn/ntyX3aAHfydgELnuBu?=
 =?us-ascii?Q?zUYdRiDyLJkPI3PaRXKFF9CtKWY60IWo7fz3NTqjgOHKxho3YD7Adxnu08VU?=
 =?us-ascii?Q?bNN5vpP8EdWR7JdqmJ7vJCxlRt9Sv6GfB1WJ+R8Vyl3aLcNKI54UMSl9W4ec?=
 =?us-ascii?Q?VkEnxiaosklR+o5mXtfAfO34O1xPUWcxZYcZJQChgqMTv5azaFZxbD5x1uKj?=
 =?us-ascii?Q?13mXtWnvxTClivVLm/glqcogzG7ieRw742aQT4C3W9uFNb+UUOoU7UT5zSk8?=
 =?us-ascii?Q?5hT4cuzr3XN4dJTZfSos3e4ACI4ad8toqdKImkzQ/QqXb9SwVwmGPo/8ECTx?=
 =?us-ascii?Q?qVA6M4LLCYBW2wC1VhqRKqAHXW2oEn7USyhzEReNZPolgOL1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a63c7b-fa12-498e-28c8-08df2fe95e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 03:05:46.1853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRrt4QcY1skb1SAiIVZtBO6FgpEmiJ5LB2krhqSF1K1JwnofLlf58EXmLP8ZO14imsNiY2rJpYtljsEeDl9DgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Thursday, October 22, 2026 10:46 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu/ras: Select EEPROM ops based on PSP IP version

Replace RAS EEPROM feature-status checking with PSP IP version based EEPROM=
 ops selection. Determine FW/DRV EEPROM support according to the PSP IP ver=
sion instead of querying RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 24 ++++++-------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/dr=
m/amd/ras/core/ras_eeprom_mgr.c
index c6869b4ef598..0531ff35a299 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -26,7 +26,6 @@
 #include "ras.h"
 #include "eeprom.h"
 #include "eeprom_fw.h"
-#include "ras_mp1.h"

 static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)  { @@=
 -37,34 +36,25 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip=
_func(
                                struct ras_core_context *ras_core, uint32_t=
 ip_version)  {
        struct ras_eeprom_mgr *mgr =3D &ras_core->eeprom_mgr;
-       int ret =3D 0;
-       u32 status =3D 0;
-
-       ret =3D ras_mp1_check_feature_status(ras_core, RAS_CORE_FW_FEATURE_=
BIT__RAS_EEPROM, &status);
-       if (ret)
-               RAS_DEV_ERR(ras_core->dev, "Check RAS EEPROM feature failed=
, ret=3D%d", ret);

        switch (ip_version) {
        case IP_VERSION(13, 0, 6):
        case IP_VERSION(13, 0, 12):
        case IP_VERSION(13, 0, 14):
                mgr->eeprom_early_init_service_supported =3D false;
-               break;
+               return &ras_drv_eeprom_ops;
+       case IP_VERSION(13, 0, 15):
        case IP_VERSION(15, 0, 8):
                mgr->eeprom_early_init_service_supported =3D true;
-               break;
+               mgr->fw_record_enabled =3D true;
+               return &ras_fw_eeprom_ops;
        default:
                RAS_DEV_ERR(ras_core->dev,
                        "EEPROM(MP1) ip version(0x%x) is not supported!\n",=
 ip_version);
-               return NULL;
+               break;
        }

-       if (status) {
-               mgr->fw_record_enabled =3D true;
-               return &ras_fw_eeprom_ops;
-       } else {
-               return &ras_drv_eeprom_ops;
-       }
+       return NULL;
 }

 int ras_eeprom_mgr_sw_init(struct ras_core_context *ras_core) @@ -96,7 +86=
,7 @@ int ras_eeprom_mgr_sw_init(struct ras_core_context *ras_core)
        mgr->ras_err_threshold =3D param_cfg.eeprom_record_threshold_count;
        mgr->work_mode_over_thresh =3D param_cfg.work_mode_over_thresh;
        mgr->eeprom_ip_version =3D param_cfg.eeprom_ip_version;
-       mgr->eeprom_ops =3D ras_eeprom_mgr_get_ip_func(ras_core, mgr->eepro=
m_ip_version);
+       mgr->eeprom_ops =3D ras_eeprom_mgr_get_ip_func(ras_core,
+ras_core->config->psp_ip_version);
        if (!mgr->eeprom_ops)
                return -ENODEV;

--
2.34.1

