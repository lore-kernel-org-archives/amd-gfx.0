Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2824DC5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 08:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11EF10E194;
	Mon, 10 Aug 2026 08:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E/iaxQes";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013065.outbound.protection.outlook.com
 [40.93.196.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F198010E194
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 08:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZW+Pw6rn+HrRrywxP/0fmcnlKgkVXq2umyUqlYLcZ5H8Lqkl0j69Hu/TPSX26kpKaiRMwgx9hpUXQZng73z6o5tpVVKfp5Zb+cRLSb5DaWBLSGq0MACO1Rd5mO+1nQUT7kvJ8es6rB5PBrCGme0Nd7a1WMyNyReo3ygTTOa1n8RfHXQ51Nny/37REbzI69Pr3eb1Ccqhi3QNixWp/5u9IHojCSktsRzkMCZWZiaVPn+NXSHfHuM7f4ZQqg38AsdrHbhc6jcBSERBa93Q5/X1Jmp/OlKD/Tgsovx5hg/TUikO6aPY154+CRYedQ79YXgnCqXlWVzlNRynoDxsM3xQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11ad0jNEPpia7dd1OsQTPvmsOW5lb9iz5U2tVDyjTUE=;
 b=zKNS5oIUdKn9rc3mAG3PGoMj2MW3qStdJ1HqhwH2femvd4C7s0v64hyn+4c3zrW8xq6gV3w/zXJXyt2q8yCK3wzkTntRAaQ35sVQvWn3Z32rwaZwHvzw7xeccP4xG4uTWk2HoO234V48SM5ltNcLS/Snb5dk+nwLduh7DBiJ2uxMjgqCbdhi/BouJKNzbqc3ozCo4m9Ws/WeVXl4q7hfO6xBQG9vjls/hf29/liRiAhk6DTGgRuQYJZk/9+izRbKubgZZuFxaO3QvD+eAdctGlWirBEXNAwetKr796bdd6NTpacPoOMtwSOaQgo19sU8gZLrP9DpQIIBmsHENNK95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11ad0jNEPpia7dd1OsQTPvmsOW5lb9iz5U2tVDyjTUE=;
 b=E/iaxQes1ZqnnvwTgMpPFRso/GgpCea2oFhv6zf1ALeYw0SHkM17r1Hv3Ta8MaPdSIAcAcS6zsLHw55b0IP1TjGMe1JyHW9ySDkHVmDQU7FgXUGBKPVdYfHalzntkHHhh19Nk1SKqWjf73S9WU9yd2ii/oKu/fRn9ErQvcTHiG0=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by MW5PR12MB5598.namprd12.prod.outlook.com
 (2603:10b6:303:193::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:17:26 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:17:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amd/ras: set pa base and lfb size for uniras
Thread-Topic: [PATCH] drm/amd/ras: set pa base and lfb size for uniras
Thread-Index: AQHdKJS2IKPERYqKoEujSN1WTz9f0LaW8ALA
Date: Mon, 10 Aug 2026 08:17:26 +0000
Message-ID: <EAYPR12MB999158EC6D8B5BA193E963C026FCDE2@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260810065121.3123094-1-tao.zhou1@amd.com>
In-Reply-To: <20260810065121.3123094-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-10T08:16:46.2951124Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|MW5PR12MB5598:EE_
x-ms-office365-filtering-correlation-id: c566120b-a1da-4c9c-5312-08def6b7d02a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|3023799007|38070700021|8096899003|22082099003|18002099003;
x-microsoft-antispam-message-info: ABXX1aIt57gAMLB2karXMaxPBEs2Zm4YW6SweqHyW39nk6QAXp0gFOmDJMtHqZ0HbDHxbyj2/9xNWdhe/qE9TLqUgzivJKhxcPpxQZb1H9ZziDjx20PqC6jaoz/I7FdBWV29PFeD56sUl2jQPpV7cWFAhbu+Da19HsZLb9buiPmx7a6egAcaJHi62Kdzddz+5opq+8gbSf232ydX+j51FT7c93V7srUBBIOrblIdKn3qwIajfHBV3UenOym834OWsB3SRNlpQWda+6lMa00uiy5kV2zt0Y35OqfZhNxVuey8cvVDJoPUmd6hOr50mQsk8scJaFR1th4DAEOW4LCe9hrrbN9rAa4rbtsLKPVeyGY70VCozWiWw5jvNncUwc22wTNPiySX98xwFbQgmBjITlnQ9O/qBsmO8m/dI5iPNCyBEQsZB4Nt6iX02+g/1usgNMYqgklI4k8DZSAbBz3Ibe+Ti/HPqNDHzX9XMw5SnNC6CnGp/bnSi+a+EsGRy/nSKzwoTb3zn2LOxU1JUfOA+zs5uaxxTQs6dhYsGgDF8RG1ialg/xai32tGd9fM379QwmvMlgillzWRPHIDY5j42Lmw91G7NiGC3b1JglT+murejDpOC0lGrfQ3HQykwc/c0YqPJcofI4YW0sua7ZrGJxyNwNw6P26Mkkq6m/zlPBBbHMJ8vOPHP/pbDB7DLp1whfpnjmf/iN8BlqQDSuWQeiJfjDA1HDqCXn1gll4010k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(3023799007)(38070700021)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uUFOWu5I1jGZcyqMHCWJWQTcBskAhiN52VzR9dyWyrawLXioa2mA60ahsLmf?=
 =?us-ascii?Q?gefmlI0cRvRp+Oo6/CKVFe20REQ+4yxfLXU0s6C9az1E6aB4GVnXT9rpnQxT?=
 =?us-ascii?Q?3Omr8R/mW5EnB/zyffiuAAdaqpPRXh7aDzYQjcVsaHwZXCrxmA1oB8Z/XQQd?=
 =?us-ascii?Q?sY0Bs4PMOqD/r1JdcntPOtH2KEFB08JKtONHYglGGutdCkmuhYktw8mdKghi?=
 =?us-ascii?Q?5E2KpOkMq39ADm6mU8eZbhFpKVWBt8muMfodY/KddnQu/emHT8JZLXbzOVV1?=
 =?us-ascii?Q?xSWgDYlcE/GcTHWJu+gT+BDNiz2MbrM8j0Da1Jn7Zm110KcWAtH21LrzXeGJ?=
 =?us-ascii?Q?Cp9i6MTL+hHucJgVbJBykbiURul1K+Kej+WwiP4dLZMjON3+nFtKCd0FGR+c?=
 =?us-ascii?Q?qhbaEMajGTcEbJMt6OUtj/xVGd/XSpolz5C1XbziQw+7KpMOH/3GLwRhUMRl?=
 =?us-ascii?Q?tEjN6zq0Ag0apMtQHwFIYK1zd3UfL/H5mhKQHRsHoKbQwNUIpCpXfbwcEJ1P?=
 =?us-ascii?Q?oGlqKWOpTtUzWbaUDQlqIB+SmbV5Axaw0Cj2aUTabsG6X2hDXt0GKpqHGBSX?=
 =?us-ascii?Q?/RH2Jqhvn73ZI31P0nnopJjDx2tCoLr4vdn2Goz4LkxKosJMRPku5r2/binp?=
 =?us-ascii?Q?uH1ds8/+Kdosdv1ug77REaK0ler091+Acv/HStD9cEEjboe1Z+h6Y7Oay7LT?=
 =?us-ascii?Q?xOi96J3/jHhUZ+D0rnDYohO3tj9tk9Au/HGcWPhcR3zqrDD/wcnrWmepNhVm?=
 =?us-ascii?Q?QDdpYTBcSxPICxubIPrU0pwwdhkTE5gX3sPhjWCFzeMkbzUrws+leyeE2wrq?=
 =?us-ascii?Q?rxe2ONMqELYZK7F6wh2o7GSyHX3G6csR4v2x2Rd4468L30qK7eVzfWupVfuh?=
 =?us-ascii?Q?XWxeMtIEjlALa8LgV6ucVIWQ8+8v6xSfl3/OGsJl/78sv8OOUDYw1vdR1n7S?=
 =?us-ascii?Q?i2iExKOv+mlYchJydcby4uMN5jei7w2vPmCMYDFh4fu6cP1tYIvIxgWxutxJ?=
 =?us-ascii?Q?cZRtbDmZbhtHf5WvuYLXIOfFOmW3/0wckBTICyCUw+R+RnlkfrZMJESsHLhQ?=
 =?us-ascii?Q?VHaCbtiBrAulPSKb3ffgTyUB5sM6G2Wy7LcNHfzMOtrq2YgrQWaLrFCzB9PZ?=
 =?us-ascii?Q?z0I9Ut3pcWMHqrlUxg9Q3Fndz145vR+RSS5tBboXFw8O9S91M717RR8E9/0G?=
 =?us-ascii?Q?U0RMy613cwZ8lJtBS1MUirF2K7Mu+IejdUjgALGpp+fokbPejwFSxuDrnI3O?=
 =?us-ascii?Q?o2mPr+FFvarHDrnMCMEpNYukxqL1wF/082jVtCBxWm3H5D1euLc/cxvLufWA?=
 =?us-ascii?Q?FjdFE+KkJaXamupL88e1jyxJhirCA4BcXS3DgkWCVdj7QZPV8fdgo9uGgbZm?=
 =?us-ascii?Q?xu2l9c0wiFXhh+2o/rSIJjFtj7kBZH3UoujLF9t1i/gSPdAtTAWmlhCnUjjO?=
 =?us-ascii?Q?Tms8CbABLApPFcNkRR2TolV8GzYeZuubqOW+y9GoBTNYfoG3nIXKc9h+N8Et?=
 =?us-ascii?Q?acgbt9xl6xStiyBMYCH09xD2eu6bbfkeuRudwu5ACz/LFuf1wtiC9bo2yQwd?=
 =?us-ascii?Q?0xa+7HyIcUO6Ygds5f21dvbIdWdLUdfD6wGTbGFQIF7DpFmmPNLy3F8qGDbK?=
 =?us-ascii?Q?3GnwUtIxXX/LFpCMCuq1MVt3OYDzKv2P5+H4NV/c2Xv2Wfevn4m1ih+qW0oV?=
 =?us-ascii?Q?n6/kRRMr0lrV1TWsJBRH/LdLhqqyS4+rrvOhx7nNYzGAWV5wgnvIbOkBUCYI?=
 =?us-ascii?Q?QHChHWYhTyKB5nSqFF6cgsSbIKEiOmSbzlhR3DBtMTLUdtetwILZChqz4MX3?=
x-ms-exchange-antispam-messagedata-1: FczZvS3bz8FGBw==
Content-Type: multipart/alternative;
 boundary="_000_EAYPR12MB999158EC6D8B5BA193E963C026FCDE2EAYPR12MB999158_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c566120b-a1da-4c9c-5312-08def6b7d02a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 08:17:26.4949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8q6yl5/XU48uuMjKjmNAEb29f5exEoNxpQJrVz7hkYoWOVQOAsnxeAUNTlj8XcT1JNsAe7z5TrVOw/6tgAH+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
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

--_000_EAYPR12MB999158EC6D8B5BA193E963C026FCDE2EAYPR12MB999158_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tao Zhou=
 <tao.zhou1@amd.com>
Sent: Monday, 10 August 2026 14:51:21
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/ras: set pa base and lfb size for uniras

Avoid hardcode, get the parameters from amdgpu.
For the algorithms of ras address conversion and die id calculation,
not only pa, (pa + pa_base) is also needed.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |  4 ++++
 drivers/gpu/drm/amd/ras/core/ras_umc.c        |  7 +++++--
 drivers/gpu/drm/amd/ras/core/ras_umc.h        |  7 ++++++-
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c  | 20 ++++++++++++-------
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h  |  3 ---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  2 ++
 6 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/c=
ore/ras.h
index d61c977b07cf..e0ed6a3ce168 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -278,6 +278,10 @@ struct ras_psp_config {
 struct ras_umc_config {
         uint32_t umc_vram_type;
         uint32_t num_umc;
+       /* socket xgmi offset, base address of umc physical address */
+       uint64_t pa_base;
+       /* local frame buffer size */
+       uint64_t lfb_size;
 };

 struct ras_eeprom_config {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/r=
as/core/ras_umc.c
index 95a98b411fc7..2dc1c0b6ac49 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -411,8 +411,9 @@ static int ras_umc_eeprom_rec2nps_addr_legacy(struct ra=
s_core_context *ras_core,
          * only ever existed on NPS1 systems)
          */
         if (ras_core->ras_umc.ip_func && ras_core->ras_umc.ip_func->get_di=
e_id) {
-               die_id =3D ras_core->ras_umc.ip_func->get_die_id(record->ad=
dress,
-                       RAS_PFN_TO_ADDR(EEPROM_RECORD_UMC_ADDR_PFN(record))=
);
+               die_id =3D ras_core->ras_umc.ip_func->get_die_id(ras_core,
+                               record->address,
+                               RAS_PFN_TO_ADDR(EEPROM_RECORD_UMC_ADDR_PFN(=
record)));
         } else {
                 RAS_DEV_ERR(ras_core->dev, "get_die_id is not supported!\n=
");
                 return -EOPNOTSUPP;
@@ -855,6 +856,8 @@ int ras_umc_hw_init(struct ras_core_context *ras_core)
                         ras_umc->umc_vram_type);
                 return -ENODATA;
         }
+       ras_umc->pa_base =3D ras_core->config->umc_cfg.pa_base;
+       ras_umc->lfb_size =3D ras_core->config->umc_cfg.lfb_size;

         ras_umc->umc_ip_version =3D ras_core->config->umc_ip_version;
         ras_umc->ip_func =3D ras_umc_get_ip_func(ras_core, ras_umc->umc_ip=
_version);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/r=
as/core/ras_umc.h
index af76de70ddd1..13d715c8553f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -139,7 +139,8 @@ struct ras_umc_ip_func {
                 uint32_t nps);
         uint64_t (*nps_pa_to_row_pa)(struct ras_core_context *ras_core,
                 uint64_t pa, enum umc_memory_partition_mode nps, bool zero=
_pfn_ok);
-       uint32_t (*get_die_id)(uint64_t mca_addr, uint64_t pa);
+       uint32_t (*get_die_id)(struct ras_core_context *ras_core,
+               uint64_t mca_addr, uint64_t pa);
 };

 struct eeprom_store_record {
@@ -168,6 +169,10 @@ struct ras_umc {
         u32 umc_ip_version;
         u32 umc_vram_type;
         u32 num_umc;
+       /* socket xgmi offset, base address of umc physical address */
+       u64 pa_base;
+       /* local frame buffer size */
+       u64 lfb_size;
         const struct ras_umc_ip_func *ip_func;
         struct radix_tree_root root;
         struct mutex  tree_lock;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c b/drivers/gpu/drm=
/amd/ras/core/ras_umc_v12_0.c
index ccdbc5c4bab1..4bf993325a3f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
@@ -243,6 +243,8 @@ static int umc_v12_0_ma2pa(struct ras_core_context *ras=
_core,
         uint32_t socket_id =3D addr_in->socket_id;
         uint32_t channel_index;
         uint64_t err_addr =3D addr_in->err_addr;
+       uint64_t pa_base =3D ras_core->ras_umc.pa_base;
+       uint64_t lfb_size =3D ras_core->ras_umc.lfb_size;

         if (node_inst !=3D UMC_INV_AID_NODE) {
                 if (ch_inst >=3D UMC_V12_0_CHANNEL_INSTANCE_NUM ||
@@ -318,11 +320,11 @@ static int umc_v12_0_ma2pa(struct ras_core_context *r=
as_core,
                 OFFSET_IN_256B_BLOCK(na);

         /* calc channel hash based on absolute address */
-       soc_pa +=3D socket_id * SOCKET_LFB_SIZE;
+       soc_pa +=3D pa_base;
         /* the umc channel bits are not original values, they are hashed *=
/
         UMC_V12_0_SET_CHANNEL_HASH(channel_index, soc_pa);
         /* restore pa */
-       soc_pa -=3D socket_id * SOCKET_LFB_SIZE;
+       soc_pa -=3D pa_base;

         /* get some channel bits from na_nps directly and
          * add nps section offset
@@ -330,16 +332,16 @@ static int umc_v12_0_ma2pa(struct ras_core_context *r=
as_core,
         if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS2) {
                 soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_CH5_BIT);
                 soc_pa |=3D ((na_nps & 0x100) << 5);
-               soc_pa +=3D (node_inst >> 1) * (SOCKET_LFB_SIZE >> 1);
+               soc_pa +=3D (node_inst >> 1) * (lfb_size >> 1);
         } else if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS4) {
                 soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_CH4_BIT);
                 soc_pa |=3D ((na_nps & 0x300) << 4);
-               soc_pa +=3D node_inst * (SOCKET_LFB_SIZE >> 2);
+               soc_pa +=3D node_inst * (lfb_size >> 2);
         } else if (nps =3D=3D UMC_MEMORY_PARTITION_MODE_NPS8) {
                 soc_pa &=3D ~(0x7ULL << UMC_V12_0_PA_CH4_BIT);
                 soc_pa |=3D ((na_nps & 0x700) << 4);
-               soc_pa +=3D node_inst * (SOCKET_LFB_SIZE >> 2) +
-                       (channel_index >> 4) * (SOCKET_LFB_SIZE >> 3);
+               soc_pa +=3D node_inst * (lfb_size >> 2) +
+                       (channel_index >> 4) * (lfb_size >> 3);
         }

         addr_out->pa =3D soc_pa;
@@ -496,10 +498,14 @@ static void umc_v12_0_mca_ipid_parse(struct ras_core_=
context *ras_core, uint64_t
  * umc number: 16
  * hbm type: UMC_VRAM_TYPE_HBM
  */
-static uint32_t umc_v12_0_get_die_id(uint64_t mca_addr, uint64_t pa)
+static uint32_t umc_v12_0_get_die_id(struct ras_core_context *ras_core,
+               uint64_t mca_addr, uint64_t pa)
 {
         uint32_t die =3D 0;

+       /* use absolute PA */
+       pa +=3D ras_core->ras_umc.pa_base;
+
         /* we only calculate die id for nps1 mode(save_nps =3D=3D ch_idx_v=
2 =3D=3D 0) */
         die +=3D (((pa >> 12) & 0x1ULL) ^
                         ((pa >> 20) & 0x1ULL) ^
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h b/drivers/gpu/drm=
/amd/ras/core/ras_umc_v12_0.h
index 268db10dc6b0..f6f7f827e06f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
@@ -300,9 +300,6 @@
 #define UMC_V12_0_TOTAL_CHANNEL_NUM \
         (UMC_V12_0_AID_NUM_MAX * UMC_V12_0_UMC_INSTANCE_NUM * UMC_V12_0_CH=
ANNEL_INSTANCE_NUM)

-/* one device has 192GB HBM */
-#define SOCKET_LFB_SIZE   0x3000000000ULL
-
 extern const struct ras_umc_ip_func ras_umc_func_v12_0;

 int ras_umc_get_badpage_count(struct ras_core_context *ras_core);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index c55288c2df9a..c58fa0ef8a80 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -285,6 +285,8 @@ static int amdgpu_ras_mgr_init_umc_config(struct amdgpu=
_device *adev,

         umc_cfg->umc_vram_type =3D adev->gmc.vram_type;
         umc_cfg->num_umc =3D adev->gmc.num_umc;
+       umc_cfg->lfb_size =3D adev->gmc.xgmi.node_segment_size;
+       umc_cfg->pa_base =3D amdgpu_xgmi_get_relative_phy_addr(adev, 0x0ULL=
);

         return 0;
 }
--
2.34.1


--_000_EAYPR12MB999158EC6D8B5BA193E963C026FCDE2EAYPR12MB999158_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
Hawking</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, =
-apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" id=
=3D"ms-outlook-mobile-signature" dir=3D"auto">
<span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robo=
to, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Ge=
t
</span><a href=3D"https://aka.ms/o0ukef" style=3D"font-family: Aptos, Aptos=
_MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-s=
ize: 12pt;">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tao Zhou &lt;tao.zhou1@amd.co=
m&gt;<br>
<b>Sent:</b> Monday, 10 August 2026 14:51:21<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/ras: set pa base and lfb size for uniras</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Avoid hardcode, get the parameters from amdgpu.<br=
>
For the algorithms of ras address conversion and die id calculation,<br>
not only pa, (pa + pa_base) is also needed.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/ras/core/ras.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 ++++<br>
&nbsp;drivers/gpu/drm/amd/ras/core/ras_umc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 7 +++++--<br>
&nbsp;drivers/gpu/drm/amd/ras/core/ras_umc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 7 ++++++-<br>
&nbsp;drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c&nbsp; | 20 ++++++++++++-=
------<br>
&nbsp;drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h&nbsp; |&nbsp; 3 ---<br>
&nbsp;.../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c&nbsp; |&nbsp; 2 ++<br>
&nbsp;6 files changed, 30 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/c=
ore/ras.h<br>
index d61c977b07cf..e0ed6a3ce168 100644<br>
--- a/drivers/gpu/drm/amd/ras/core/ras.h<br>
+++ b/drivers/gpu/drm/amd/ras/core/ras.h<br>
@@ -278,6 +278,10 @@ struct ras_psp_config {<br>
&nbsp;struct ras_umc_config {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_vram_type;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_umc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* socket xgmi offset, base address o=
f umc physical address */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pa_base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* local frame buffer size */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t lfb_size;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct ras_eeprom_config {<br>
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/r=
as/core/ras_umc.c<br>
index 95a98b411fc7..2dc1c0b6ac49 100644<br>
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c<br>
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c<br>
@@ -411,8 +411,9 @@ static int ras_umc_eeprom_rec2nps_addr_legacy(struct ra=
s_core_context *ras_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * only ever existed =
on NPS1 systems)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras_core-&gt;ras_umc.i=
p_func &amp;&amp; ras_core-&gt;ras_umc.ip_func-&gt;get_die_id) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; die_id =3D ras_core-&gt;ras_umc.ip_func-&gt;get_die_id(record-&g=
t;address,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RAS_PFN_TO_ADDR(=
EEPROM_RECORD_UMC_ADDR_PFN(record)));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; die_id =3D ras_core-&gt;ras_umc.ip_func-&gt;get_die_id(ras_core,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record-&gt;address,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RAS_PFN_TO_ADDR(EEPROM_RECORD_UMC_ADDR_PFN(=
record)));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RAS_DEV_ERR(ras_core-&gt;dev, &quot;get_die_id is not=
 supported!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
@@ -855,6 +856,8 @@ int ras_umc_hw_init(struct ras_core_context *ras_core)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_u=
mc-&gt;umc_vram_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENODATA;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_umc-&gt;pa_base =3D ras_core-&gt;=
config-&gt;umc_cfg.pa_base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_umc-&gt;lfb_size =3D ras_core-&gt=
;config-&gt;umc_cfg.lfb_size;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_umc-&gt;umc_ip_version=
 =3D ras_core-&gt;config-&gt;umc_ip_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_umc-&gt;ip_func =3D ra=
s_umc_get_ip_func(ras_core, ras_umc-&gt;umc_ip_version);<br>
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/r=
as/core/ras_umc.h<br>
index af76de70ddd1..13d715c8553f 100644<br>
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h<br>
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h<br>
@@ -139,7 +139,8 @@ struct ras_umc_ip_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t nps);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t (*nps_pa_to_row_p=
a)(struct ras_core_context *ras_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint64_t pa, enum umc_memory_partition_mode nps, bool=
 zero_pfn_ok);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*get_die_id)(uint64_t mca_a=
ddr, uint64_t pa);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*get_die_id)(struct ras_cor=
e_context *ras_core,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t mca_addr, uint64_t pa);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct eeprom_store_record {<br>
@@ -168,6 +169,10 @@ struct ras_umc {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 umc_ip_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 umc_vram_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 num_umc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* socket xgmi offset, base address o=
f umc physical address */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 pa_base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* local frame buffer size */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 lfb_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct ras_umc_ip_fu=
nc *ip_func;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct radix_tree_root roo=
t;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp; tree_lo=
ck;<br>
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c b/drivers/gpu/drm=
/amd/ras/core/ras_umc_v12_0.c<br>
index ccdbc5c4bab1..4bf993325a3f 100644<br>
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c<br>
@@ -243,6 +243,8 @@ static int umc_v12_0_ma2pa(struct ras_core_context *ras=
_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t socket_id =3D add=
r_in-&gt;socket_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t channel_index;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t err_addr =3D addr=
_in-&gt;err_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pa_base =3D ras_core-&gt;ras=
_umc.pa_base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t lfb_size =3D ras_core-&gt;ra=
s_umc.lfb_size;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (node_inst !=3D UMC_INV=
_AID_NODE) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ch_inst &gt;=3D UMC_V12_0_CHANNEL_INSTANCE_NUM ||=
<br>
@@ -318,11 +320,11 @@ static int umc_v12_0_ma2pa(struct ras_core_context *r=
as_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; OFFSET_IN_256B_BLOCK(na);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* calc channel hash based=
 on absolute address */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_pa +=3D socket_id * SOCKET_LFB_SI=
ZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_pa +=3D pa_base;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the umc channel bits ar=
e not original values, they are hashed */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UMC_V12_0_SET_CHANNEL_HASH=
(channel_index, soc_pa);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* restore pa */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_pa -=3D socket_id * SOCKET_LFB_SI=
ZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_pa -=3D pa_base;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get some channel bits f=
rom na_nps directly and<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * add nps section of=
fset<br>
@@ -330,16 +332,16 @@ static int umc_v12_0_ma2pa(struct ras_core_context *r=
as_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nps =3D=3D UMC_MEMORY_=
PARTITION_MODE_NPS2) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc_pa &amp;=3D ~(0x1ULL &lt;&lt; UMC_V12_0_PA_CH5_BI=
T);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc_pa |=3D ((na_nps &amp; 0x100) &lt;&lt; 5);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; soc_pa +=3D (node_inst &gt;&gt; 1) * (SOCKET_LFB_SIZE &gt;&gt; 1=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; soc_pa +=3D (node_inst &gt;&gt; 1) * (lfb_size &gt;&gt; 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (nps =3D=3D UMC_=
MEMORY_PARTITION_MODE_NPS4) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc_pa &amp;=3D ~(0x3ULL &lt;&lt; UMC_V12_0_PA_CH4_BI=
T);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc_pa |=3D ((na_nps &amp; 0x300) &lt;&lt; 4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; soc_pa +=3D node_inst * (SOCKET_LFB_SIZE &gt;&gt; 2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; soc_pa +=3D node_inst * (lfb_size &gt;&gt; 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (nps =3D=3D UMC_=
MEMORY_PARTITION_MODE_NPS8) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc_pa &amp;=3D ~(0x7ULL &lt;&lt; UMC_V12_0_PA_CH4_BI=
T);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc_pa |=3D ((na_nps &amp; 0x700) &lt;&lt; 4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; soc_pa +=3D node_inst * (SOCKET_LFB_SIZE &gt;&gt; 2) +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (channel_index &=
gt;&gt; 4) * (SOCKET_LFB_SIZE &gt;&gt; 3);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; soc_pa +=3D node_inst * (lfb_size &gt;&gt; 2) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (channel_index &=
gt;&gt; 4) * (lfb_size &gt;&gt; 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr_out-&gt;pa =3D soc_pa=
;<br>
@@ -496,10 +498,14 @@ static void umc_v12_0_mca_ipid_parse(struct ras_core_=
context *ras_core, uint64_t<br>
&nbsp; * umc number: 16<br>
&nbsp; * hbm type: UMC_VRAM_TYPE_HBM<br>
&nbsp; */<br>
-static uint32_t umc_v12_0_get_die_id(uint64_t mca_addr, uint64_t pa)<br>
+static uint32_t umc_v12_0_get_die_id(struct ras_core_context *ras_core,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t mca_addr, uint64_t pa)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t die =3D 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* use absolute PA */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pa +=3D ras_core-&gt;ras_umc.pa_base;=
<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* we only calculate die i=
d for nps1 mode(save_nps =3D=3D ch_idx_v2 =3D=3D 0) */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; die +=3D (((pa &gt;&gt; 12=
) &amp; 0x1ULL) ^<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((pa =
&gt;&gt; 20) &amp; 0x1ULL) ^<br>
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h b/drivers/gpu/drm=
/amd/ras/core/ras_umc_v12_0.h<br>
index 268db10dc6b0..f6f7f827e06f 100644<br>
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h<br>
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h<br>
@@ -300,9 +300,6 @@<br>
&nbsp;#define UMC_V12_0_TOTAL_CHANNEL_NUM \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (UMC_V12_0_AID_NUM_MAX * U=
MC_V12_0_UMC_INSTANCE_NUM * UMC_V12_0_CHANNEL_INSTANCE_NUM)<br>
&nbsp;<br>
-/* one device has 192GB HBM */<br>
-#define SOCKET_LFB_SIZE&nbsp;&nbsp; 0x3000000000ULL<br>
-<br>
&nbsp;extern const struct ras_umc_ip_func ras_umc_func_v12_0;<br>
&nbsp;<br>
&nbsp;int ras_umc_get_badpage_count(struct ras_core_context *ras_core);<br>
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c<br>
index c55288c2df9a..c58fa0ef8a80 100644<br>
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c<br>
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c<br>
@@ -285,6 +285,8 @@ static int amdgpu_ras_mgr_init_umc_config(struct amdgpu=
_device *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_cfg-&gt;umc_vram_type =
=3D adev-&gt;gmc.vram_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_cfg-&gt;num_umc =3D ad=
ev-&gt;gmc.num_umc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_cfg-&gt;lfb_size =3D adev-&gt;gmc=
.xgmi.node_segment_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_cfg-&gt;pa_base =3D amdgpu_xgmi_g=
et_relative_phy_addr(adev, 0x0ULL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_EAYPR12MB999158EC6D8B5BA193E963C026FCDE2EAYPR12MB999158_--
