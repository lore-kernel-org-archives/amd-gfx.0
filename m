Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B00C5AC7C
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 08:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8809310F437;
	Fri,  7 Aug 2026 08:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R3j17WUU";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A9310F437
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 08:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJkeiDK/RsOVG1vj6E/ocpzKdDD98NvYA99i8TVnZppcJRofVL34GFiL722+9H9zII/FsfWQjoboVLSnFHXWxulGfrVB2jYWtqTBqVafCULMDuoEew/gsddfWoGi9AaaQ266nMiZ4m9coPAJJo8DCXZSPRnpqVDoVrjTW7mWznIJZWsD1VmV15RVdfD0Lon04Bxv1v6+c1T+esGDEsAbmv40DqW2PIb/TLpyz4FSd+EXznTYpfYXfc0qxM4JOcmb1inkf8lc1W4vjE0MnN1TDDhgYOod9vePkAhvblns1HVtSysbLBpzUolcDH1UWEX+yT7ke8ICKAuN8ynNz+xgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d/gAUigIVgmE9sKa39BT6DErpBxbZLEwkKGCZaW3Mc=;
 b=qfpjkQu6dtrlEZFcr3rlteINVLPUeQ0g3n1dgpklLmWQJ1j5RigrB0mOxBBcTsPjoXBVqwyE7P+BFVHr29gx5skQq7GC8K5JMwLTx5vB8rCJ78jIf7po0t+UelER/97YtdK9hC7ZnSSYJ6h29RQtDAAOBYhCFDTauR1BWEfmO7ZsK7Msl1MzzBsdvk7sikBpR93ozdVI4BnqxSGYoUF2Z+C/TzMWWqFCDD548kHSBlbOCatDdyGHqQYVynuzZiV9o/OfOkRozS+R2qGZXikF19hbVXwQ3SZ67hiJuLrh6InuoerqHMY2kb+ycLvm79LVq5WLy6jbJ6r9TTLdHD8HtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d/gAUigIVgmE9sKa39BT6DErpBxbZLEwkKGCZaW3Mc=;
 b=R3j17WUUjSIib3oZ2AqpXLQYY/cD2fdiIZq456XpSQClzogzqtLIWyJ5QLKoXXiO+C5DD5WaO3/TpUgU/ZoAShgNxRlw2VODL6x+H7oV4SJoPvMe/1pDdlJ73oIat17qrSQgrPmC1kijXM8fRsHmglmqZ1rotEtu5vNfhLXUq0k=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by SA3PR12MB9132.namprd12.prod.outlook.com
 (2603:10b6:806:394::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 08:50:55 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 08:50:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/ras: set pa base and lfb size for uniras
Thread-Topic: [PATCH 2/2] drm/amd/ras: set pa base and lfb size for uniras
Thread-Index: AQHdJjgd235P1Df+QUev5F5SG83fDLaSRxyQ
Date: Fri, 7 Aug 2026 08:50:55 +0000
Message-ID: <EAYPR12MB99915843401615506944BE8535FCD12@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260807064330.3070081-1-tao.zhou1@amd.com>
 <20260807064330.3070081-2-tao.zhou1@amd.com>
In-Reply-To: <20260807064330.3070081-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-07T08:50:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|SA3PR12MB9132:EE_
x-ms-office365-filtering-correlation-id: 6a033c3b-1c73-4d54-8449-08def460fe93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|3023799007|38070700021|10067099003;
x-microsoft-antispam-message-info: 1j1EXDqFh/t7EliSAx/Plimbo/OUc/bAjp3OOxq6AcqFzrLzqgS4HbRRqMZSSEgevc9r2tFMQUC1Tp+Dt66RyazxrjxbA76JOJi00oBIjY2StFML6SYwea8KTTsgQXXZ6k/mpKPa5sp53pIvB4zNgoifO+WtPe3GH8R8k/PyCpfkkKi0og4+W27ISaZ1s0mdRgoItavGlbL+wD1JvcV4IRyncsSWObIXKDKgvXA+Dti9WIOQyb5jmTf6gU/yERMRh1b8bhK3RxZtmJDQJSs8+pa98uiD0kabPbVjgQLF8duf8+ehanVFtfGhYnJkg9ErqiiLDP/yhZiZRg9NaJ1mXOxrXvlRHLPH+R/kxOJ2j2LSDmkID7dfGQqUNTrRqd7H8NpjUpWUJXfgVUqV9z6ieeq0CwWZ3S8vTdLPTyXwXr5Rjx83inb1DC0Uk++KpTIaITWmLduxWhfWQZIOukh9etjsBwDV8RAnwSj4jtmRWFFl9DpEf09CKn89YsR9r50AebuiVUkhAmfamMgiXNd1hy29DXwRudUtROYX8lsDq7Z8ZqOnb/V940ho8Wvi2bmU2VakZT2DKLzQoNymRxu/8oS2IrHRXN4YihQb6SX1PzvBgqyR/9anInCR/TcrVLM0XXYDcpjzrD2pW/Szpw8oawnL+GyEzA6vMEynsHbufwfSFyLXJDIj1D6i5mAssM2Kc7tFV0HVfLeFsaYDx64hogQscFwga5UPI8l48T32/l8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(3023799007)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DnrIiuK+NUIMFtYpWK8Xt3yN9BWI2obPrGcxR3OSuOpJI+JDvw0yIsUqwZuu?=
 =?us-ascii?Q?jz4DIhZaBIAq/hg3lifshBEZ7Cr+jyoN4eyADblzVbCn68JaRfNzfvKjkRiO?=
 =?us-ascii?Q?6PK2XqExIOnmWY8wjhhvM6+Znre9XBhF0VqMQ9Ft0ofdrC7IK1ekG5/MLBx5?=
 =?us-ascii?Q?QKKNhEizwabHDFYNhnhw+HAnnyc5CCJVuIB4wzBjq8QnixBRaDFaFFhoLi74?=
 =?us-ascii?Q?4iQKJoxRBBON4r+Vs+teKR14hMn9IsRGEOAkB3fHpIp93hxpU52+s3HhZpZu?=
 =?us-ascii?Q?CI/XOiiZ96G54RMcmd3YlR7kTWdt3oeTAcmO3AF/m2z0yQdZtL01atAslPhS?=
 =?us-ascii?Q?yKzGIJtg47gMdz2vZOc5RWf09oJBk0BSmCsjL1BrSpaNjbCbY2Iy6hmJYfoE?=
 =?us-ascii?Q?IKlDym+7+dc3TEJfTJTi4TOxTN/wVraNx7E2M+PKwIpmC5fYHzdzUXEq4sr9?=
 =?us-ascii?Q?40dKtMp3tdgwTHPyULS8XScfYpx+WD/6z+1RtEModBJ2XI6353tPhqfCj+sL?=
 =?us-ascii?Q?auN2vzpkeHyLc6c9SJRcLuLp9MNRIDd92fATUU5ySDoUul7AB9MNmUQ4yHFS?=
 =?us-ascii?Q?RyszX/lXsZB1I9S97E6lyv+x9uKaMEyOdR1aZpocClll93mKanv/upizuIgW?=
 =?us-ascii?Q?TYohTNJ5C61g67ENZYmGZHVfztpp2V922XX8S7SzgcosWdv6+ndINxJTuVBE?=
 =?us-ascii?Q?SKuHvtZAJ4Kphc+HhlLl6dQr5q8aRlCk1tcTm4XxTmU+fglQmkvQEtnKtI5v?=
 =?us-ascii?Q?rsP3Uaw2BGriUNVTJvGE/W8eTfbVsJDt1saJfyMQTfBOU8hCR+n2FWsSP6xl?=
 =?us-ascii?Q?t3C7agtwLE4B2QA9wcUU0IbMJ0OJz1qcUsBpYVtOhOdoWOq89n8lP67/8Jk0?=
 =?us-ascii?Q?PIKbNteUoeOogKfvujB4s/FxQPkHs+l+zebVrBaNRBfk1jFp/rZfrNXYHLKm?=
 =?us-ascii?Q?TLsuKbbBKjGLiV9hiCS+YmYqyiKfrM+4SfLtO/NwqRSaLZ1/EJVWbZ3cSQrE?=
 =?us-ascii?Q?Kfb645Rb6/ZnaG7O3zFZIhJhW68TojeazOd9wkJa4eWB/X1K7V2yaEd1Ol91?=
 =?us-ascii?Q?ou+8MUU7p+Zzvd8Zo+1syVJ3MVkdy0rBquqJJOzQ3kXVwS6faAWYiwUIUbaR?=
 =?us-ascii?Q?c97J0woOVP+IWS6Q9g1z4v7WdB8zU7N0G9Chv1ywVPN6sh+gLBNGbxRVm22e?=
 =?us-ascii?Q?HEccB8v9ut3waERTJVXKarETTt7G9QSMawAIzRDy5k/x75n8fTEf5vpI+hCE?=
 =?us-ascii?Q?qD7W4xyCrJzZOdtWrDhCpubofA8aTScJnTku8gRKUMPQrKgHfHYBcfu8jlI5?=
 =?us-ascii?Q?jfVI8fDfYo7PUO3FpenyyvSlfxWlJ1IWvuQ1lAyMhB1Gq6XFicvv+0yDVivN?=
 =?us-ascii?Q?gFA2WZtS0rMhxkjswmdC3oua28+mZg8XkhwcjTbvVozsNLJduuy7Z3twYX5+?=
 =?us-ascii?Q?cw5rdYb+GFqgtXNyGKPBwBXtjtwyfUpHK00lDgvJv6Liz7xtqkzi0Tcnckvm?=
 =?us-ascii?Q?obikN9ulErZug/nciaPTStshf+ZwYbo8TSIRg2CxLVNjMVPrlnpQ0CO0zmzZ?=
 =?us-ascii?Q?gxJou0OmxfeQzuSnlNxpjJtpaSq6qDVm4wQ40odi/JtGRWrPMvzlb7SJNDol?=
 =?us-ascii?Q?rjqsr1IsN95OTTKllIPKtpwB3AYPZbqEjxAjP8kHi0CRMFO5GP69HhV0c3cw?=
 =?us-ascii?Q?9I56luPT9l7W+kaw9eeabHdns+YfjZdIm0RMtSSQwFbbMeUh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a033c3b-1c73-4d54-8449-08def460fe93
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 08:50:55.7824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hG3aNofdAg186OS2v8nT1woqx8j/uEeRadkNkg82e2Um/Z0kyS6JtEFEBDOY+AaFjfXIqQcFTZfbNeg5Vxpnog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132
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

+       umc_cfg->pa_base =3D amdgpu_xgmi_get_relative_phy_addr(adev, 0x0ULL=
);

Can we use vram_base_offset

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Friday, August 7, 2026 2:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: set pa base and lfb size for uniras

Avoid hardcode, get the parameters from amdgpu.
For the algorithms of ras address conversion and die id calculation, not on=
ly pa, (pa + pa_base) is also needed.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |  4 ++++
 drivers/gpu/drm/amd/ras/core/ras_umc.c        |  7 +++++--
 drivers/gpu/drm/amd/ras/core/ras_umc.h        |  7 ++++++-
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c  | 20 ++++++++++++-------  dr=
ivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h  |  3 ---  .../gpu/drm/amd/ras/r=
as_mgr/amdgpu_ras_mgr.c  |  2 ++
 6 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/c=
ore/ras.h
index d61c977b07cf..e0ed6a3ce168 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -278,6 +278,10 @@ struct ras_psp_config {  struct ras_umc_config {
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
        if (ras_core->ras_umc.ip_func && ras_core->ras_umc.ip_func->get_die=
_id) {
-               die_id =3D ras_core->ras_umc.ip_func->get_die_id(record->ad=
dress,
-                       RAS_PFN_TO_ADDR(EEPROM_RECORD_UMC_ADDR_PFN(record))=
);
+               die_id =3D ras_core->ras_umc.ip_func->get_die_id(ras_core,
+                               record->address,
+                               RAS_PFN_TO_ADDR(EEPROM_RECORD_UMC_ADDR_PFN(=
record)));
        } else {
                RAS_DEV_ERR(ras_core->dev, "get_die_id is not supported!\n"=
);
                return -EOPNOTSUPP;
@@ -855,6 +856,8 @@ int ras_umc_hw_init(struct ras_core_context *ras_core)
                        ras_umc->umc_vram_type);
                return -ENODATA;
        }
+       ras_umc->pa_base =3D ras_core->config->umc_cfg.pa_base;
+       ras_umc->lfb_size =3D ras_core->config->umc_cfg.lfb_size;

        ras_umc->umc_ip_version =3D ras_core->config->umc_ip_version;
        ras_umc->ip_func =3D ras_umc_get_ip_func(ras_core, ras_umc->umc_ip_=
version); diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu=
/drm/amd/ras/core/ras_umc.h
index af76de70ddd1..13d715c8553f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -139,7 +139,8 @@ struct ras_umc_ip_func {
                uint32_t nps);
        uint64_t (*nps_pa_to_row_pa)(struct ras_core_context *ras_core,
                uint64_t pa, enum umc_memory_partition_mode nps, bool zero_=
pfn_ok);
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
                if (ch_inst >=3D UMC_V12_0_CHANNEL_INSTANCE_NUM || @@ -318,=
11 +320,11 @@ static int umc_v12_0_ma2pa(struct ras_core_context *ras_core,
                OFFSET_IN_256B_BLOCK(na);

        /* calc channel hash based on absolute address */
-       soc_pa +=3D socket_id * SOCKET_LFB_SIZE;
+       soc_pa +=3D pa_base;
        /* the umc channel bits are not original values, they are hashed */
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
        /* we only calculate die id for nps1 mode(save_nps =3D=3D ch_idx_v2=
 =3D=3D 0) */
        die +=3D (((pa >> 12) & 0x1ULL) ^
                        ((pa >> 20) & 0x1ULL) ^
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h b/drivers/gpu/drm=
/amd/ras/core/ras_umc_v12_0.h
index 268db10dc6b0..f6f7f827e06f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
@@ -300,9 +300,6 @@
 #define UMC_V12_0_TOTAL_CHANNEL_NUM \
        (UMC_V12_0_AID_NUM_MAX * UMC_V12_0_UMC_INSTANCE_NUM * UMC_V12_0_CHA=
NNEL_INSTANCE_NUM)

-/* one device has 192GB HBM */
-#define SOCKET_LFB_SIZE   0x3000000000ULL
-
 extern const struct ras_umc_ip_func ras_umc_func_v12_0;

 int ras_umc_get_badpage_count(struct ras_core_context *ras_core); diff --g=
it a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd=
/ras/ras_mgr/amdgpu_ras_mgr.c
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

