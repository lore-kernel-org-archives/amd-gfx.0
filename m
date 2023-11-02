Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AA4C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 08:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DB310E822;
	Thu,  2 Nov 2023 08:04:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EFB10E822
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 08:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBkskG/Op+b98QYB+7OoYzn9zAS7Uf4bo6PgJU4YPA1hvlfElN2aZsWQSC5Eg08UZnPLIV1pbvBttrX2Ff2iNVFwcb4SPmqrj/RmVEHJktiYTh/OuBIGc07q7O4Ib6WQ0UBHVTI9QnOzhJ7wufu/EGrVZlfiiFsUIiRRW3gU/BVMbZFxOTquM+C36hdOG1W+bwYbJaXLTBfqOhksdSLplkbh+nnohl1Q1galLDtiCgBBNEd8G9gw0bDsId1mVEYkzsDLBv6ceRyt/qVdENhX46HKCDUFduCHyfBO2HS8VLNMYy8Q5n0qkcnXNOtPNt4DMZHPVcz1Nw/zY0dFSQaOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFTEKAeGAXlPv/9eqkZDMpbOXA2tp0OZCj7GVZ1HCPM=;
 b=Z9WJR7kqrrefeJ6UjvuxbknnZ/1Ie/GMwHVntoOzdyGG3oB14Dx9IV3Ydtj4drP6DlLBb3OfvdTfYK5YUJI/3cZGfoz04BmQviST0LL1rSbVn2mofmU4qagP96rvUB1nL5x+ozW03c7NPUmAU1S1wECgczZI+L+jms+oL4OpEcL5bB0nAdl68g1SKalKl/sdpvFHbgE45ZA0s+guiTsJHfCKy0wXo+uqqHUWKSlJckpIP+H5ITeK06Bc4XqEQpzy+c6V5IP29kV2aKhSQWViHtB47p0MfdIV+KLgJM2p/yoKjUc9m6a/o3jZivoXOmMw1A+xEa1ANCKI17qq10z+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFTEKAeGAXlPv/9eqkZDMpbOXA2tp0OZCj7GVZ1HCPM=;
 b=v2/bMB9DkExcBBmZlAbAYibnSAXt7Hkjrio8yzaQ6weaFONv2rnGnyxT296iTe51VyuOi5ZimE4UC9jlkoR5tEPRUfMBG7xAXs+dZXebDWOmfeWhsiEuwjvNqewbV6bZPhdr6wCatXA2VGmdqlevqDJgezRuHvr9dw1hmwYsN4g=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 08:04:35 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b%7]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 08:04:35 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm:Fix return vlaue and drop redundant param
Thread-Topic: [PATCH] drm/amd/pm:Fix return vlaue and drop redundant param
Thread-Index: AQHaDWKRlPgy+uRgtEGZgaJKD1HdpLBmq5Dg
Date: Thu, 2 Nov 2023 08:04:35 +0000
Message-ID: <DM4PR12MB5165BAF3F7F92F0CE95426918EA6A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231102075916.2701221-1-Jun.Ma2@amd.com>
In-Reply-To: <20231102075916.2701221-1-Jun.Ma2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d2a2d98c-ae9a-4639-9628-65077edb2ea0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-02T08:04:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|PH0PR12MB7813:EE_
x-ms-office365-filtering-correlation-id: e064ed73-4ca3-4f6d-b50f-08dbdb7a5a6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KLMbjMKUN9JMMECn4S2lrskqbS2Q7DJAzmKnDUhTk3+/dVftmWwIDtcYETNvRzkGTY7jgx8U8qpyYFLGVqPJPwqhhLKI0AWXDZpRFz8vL9FDsis7ZxOyW9P+6Z8SfhQmh3JhXJd8GXs5vkGF0lZqWXQGURiitDkhO9Gu3Rqp1rKZE9S0pN7wv2L5XXL1ZIgGJzP7/DBaGUxmD+u/hqUb3+aT2HaJF54O8pnWOf69iAn0Cn1IuNqFBcb3U2YW9iT7B0c2m2xHsOVUrS+etw7FwvYrRlniWFPqO52vpFdPqfKrDFO4KNNN79X3hTarDwpWe1RMKE4N7APCFbl22wEpxM2NjT0ya9xKhQlj7K46h/hIyMtv/YYgI3TFdZJGrNPBAejd58uA0kWE5r9a2+7tzxFx4UaWuoW48+b/tNQmNnpuM2GczLd+uW/momn2j/cTyaOT3zVW+SXofkAvRg6rAxcGWDUuf709TtQrLrsJYDCDAE90ol/QQ9tx8CdbeQGT2Pg5jrz77xW7htgfa1I1ZW47GyjYrYrF5glG1yWtiPr7tk74LmZEMqVXZgJobh7bhtBuH7m/JE/DdtHZNKpisvy5cRYm8SYD1aqSaALDBBaCo0yuxloCGZinUxH2rFWV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(122000001)(9686003)(26005)(38070700009)(478600001)(5660300002)(52536014)(8676002)(8936002)(33656002)(41300700001)(2906002)(30864003)(86362001)(66556008)(66946007)(64756008)(66446008)(66476007)(6636002)(316002)(76116006)(110136005)(71200400001)(53546011)(6506007)(7696005)(38100700002)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?26pz5twAh+oeGwsEAOkjXCojnG+kV80NZW7di/HTvsX0t8UjTX9H4nOpDxBr?=
 =?us-ascii?Q?3v0IoFB/Wdh8GHXDD6UKZizxrdFztzvSQhvDBYq5VsK0ldN4oBRailhoLzNy?=
 =?us-ascii?Q?i6VqaieJ1quTTe8g1VVswBU/49uEwqCHe+ZZUchnE3ZvOQrpPDS7Gbh0zeyN?=
 =?us-ascii?Q?UHztE29jRojuZTdwcxfmt840SdSvdt9SGAOIwEV0BueWDgLBzHUUHac/p80y?=
 =?us-ascii?Q?6x0gcY2GqUEJuOqo1CH+n1aF1wgJFiV0Omn20bipdcIRiWgnCncPK2ebm8+5?=
 =?us-ascii?Q?IHv4dsrf9vc5UejAUy3Lozlbz6+NMN3HR0xLm0iyNd9kLCpClGKFRA6UPSY7?=
 =?us-ascii?Q?xe90eGNezpprGkBQixCS0i+knhLF+Gq6TmBF30P1l7ytoXT25ukN4sy/aLAh?=
 =?us-ascii?Q?IDQ+T9pHEhzyJjl5V+H/0GNl3Ql3B/smnsahaoKQkMRUwdPLXi2WWjXQEPpT?=
 =?us-ascii?Q?9yaPvwdRy2xPnKLgBlhuuFqc2CqiGSYRsQEtyqSMAcVwBIKJv/j9mm34J++j?=
 =?us-ascii?Q?Dv91odEU2LcWSRDk6f/OiFZsjx7M3EaCe5Bakoh8y+NuL0ISMWEB8Bx2LLS5?=
 =?us-ascii?Q?POfAbx3zeoGATKWdbrLm/8K9kgdlNPFqB5JRFKmyIe8IwcsSB9ds/o6wsojJ?=
 =?us-ascii?Q?nEoHLfdE7Q0bCQ+kENFXKEwoIaKpo27dbges+bGqEPjtcoD+PCYXD9CulWoC?=
 =?us-ascii?Q?o18hVEQyE4/X65sz4dNBBmJ9AG79HeNW0EexjcLU92atObq4FXWQUcnGxN2U?=
 =?us-ascii?Q?tK+5LbszqYjciL4smgfjPmV3Yk00rtdCIFlI9jDPm0Ca5ywtLuOh7MSCxzLa?=
 =?us-ascii?Q?I7zPEMkqTPl6+XO0qxoCIm8yPUvnDlALxXFFDKNwt8nZds5ToWuK1vMo2hw7?=
 =?us-ascii?Q?UM75y/5+mxhEMOaibTPGbTXSpgZ4DMrfsRTa0cjqRy24/RZ9vnlOzZAo9Wzd?=
 =?us-ascii?Q?J/a9i+7YAGUPrwfZV3FJU6TfHkqKP1gP819Gi/ToZwO442km6Ry+kMPUSfsg?=
 =?us-ascii?Q?4R2l/UppKzKrxamX5wp3yl+Yk+Dwrs29taTEIjyKfAptc7C1LQljbhc1+Gku?=
 =?us-ascii?Q?8Ea2fWzj1aGaW8dit6VIWR9v5R9o0OGBkUzVCD/8fCHXifFWrlASnyaMFquS?=
 =?us-ascii?Q?QIH8EH9F7xbAUDluBeOrxv5dCG2Zp8m4Cm8BQ+pvQXT+hEZnDuE1fsg9osDO?=
 =?us-ascii?Q?O8kgRfROC3pgX31z6hSyJnEEVETRRkBv88qU+t7a4WVt77DH1RX341w2FhXT?=
 =?us-ascii?Q?tEuKpiRn9X2z9jvBs80XRz7CRDO3uychN3vcQ9J2cZDckoIExsPAmM1pzfac?=
 =?us-ascii?Q?zXbGpGDq14DF8O6JW72B8HI+YFOs9x5waErLIzyyNpYyJAOpnpsZB+QaVafo?=
 =?us-ascii?Q?yQ87h45hnJixcEMF67gH6/MdehrbZU3LPkZdd8maZzNg1jq94sxGAE4x7+h5?=
 =?us-ascii?Q?oNaDnOcp3O2rbN2sCM6GhJUPL2w611BhEgC8LviWyAaSix/M7XSGfomWiaMj?=
 =?us-ascii?Q?uwSKrmZ0JQzwL829cwXek85XV/6atA/29JqEjYdjwWWNYNxMHCUso4kSpO3Y?=
 =?us-ascii?Q?Dlq7rJv459MCKpIuaLc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e064ed73-4ca3-4f6d-b50f-08dbdb7a5a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 08:04:35.2386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Vz9tEg5ZpS1sHPQKoJQiO3jQPF4mis8i39OWNFBhLP0ouqh7iS+GG9CJpfNc4Pr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
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

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Thursday, November 2, 2023 3:59 PM
To: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; De=
ucher, Alexander <Alexander.Deucher@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amd/pm:Fix return vlaue and drop redundant param

Fix the return value and drop redundant parameter of get_asic_baco_capabili=
ty function to simplify the code

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h       |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                  |  8 +++-----
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c     | 11 ++++-------
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c   |  7 +++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h   |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c   |  9 ++++-----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h   |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c |  9 ++++-----  drive=
rs/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h         |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 12 +++++-------
 11 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 3201808c2dd8..60e6b82077e8 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -421,7 +421,7 @@ struct amd_pm_funcs {
        int (*set_hard_min_dcefclk_by_freq)(void *handle, uint32_t clock);
        int (*set_hard_min_fclk_by_freq)(void *handle, uint32_t clock);
        int (*set_min_deep_sleep_dcefclk)(void *handle, uint32_t clock);
-       int (*get_asic_baco_capability)(void *handle, bool *cap);
+       bool (*get_asic_baco_capability)(void *handle);
        int (*get_asic_baco_state)(void *handle, int *state);
        int (*set_asic_baco_state)(void *handle, int state);
        int (*get_ppfeature_status)(void *handle, char *buf); diff --git a/=
drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index acf3527fff2d..24fd036a15c0 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -185,8 +185,7 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device =
*adev)  {
        const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
        void *pp_handle =3D adev->powerplay.pp_handle;
-       bool baco_cap;
-       int ret =3D 0;
+       bool ret;

        if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
                return false;
@@ -204,12 +203,11 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_devic=
e *adev)

        mutex_lock(&adev->pm.mutex);

-       ret =3D pp_funcs->get_asic_baco_capability(pp_handle,
-                                                &baco_cap);
+       ret =3D pp_funcs->get_asic_baco_capability(pp_handle);

        mutex_unlock(&adev->pm.mutex);

-       return ret ? false : baco_cap;
+       return ret;
 }

 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev) diff --git a/driver=
s/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerpl=
ay/amd_powerplay.c
index 9e4f8a4104a3..e82c2b2fffb5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1368,21 +1368,18 @@ static int pp_set_active_display_count(void *handle=
, uint32_t count)
        return phm_set_active_display_count(hwmgr, count);  }

-static int pp_get_asic_baco_capability(void *handle, bool *cap)
+static bool pp_get_asic_baco_capability(void *handle)
 {
        struct pp_hwmgr *hwmgr =3D handle;

-       *cap =3D false;
        if (!hwmgr)
-               return -EINVAL;
+               return false;

        if (!(hwmgr->not_vf && amdgpu_dpm) ||
                !hwmgr->hwmgr_func->get_asic_baco_capability)
-               return 0;
+               return false;

-       hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
-
-       return 0;
+       return hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr);
 }

 static int pp_get_asic_baco_state(void *handle, int *state) diff --git a/d=
rivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c b/drivers/gpu/drm/amd/pm/=
powerplay/hwmgr/smu7_baco.c
index 044cda005aed..e8a9471c1898 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
@@ -33,21 +33,20 @@
 #include "smu/smu_7_1_2_d.h"
 #include "smu/smu_7_1_2_sh_mask.h"

-int smu7_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap)
+bool smu7_baco_get_capability(struct pp_hwmgr *hwmgr)
 {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)(hwmgr->adev=
);
        uint32_t reg;

-       *cap =3D false;
        if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_P=
latformCaps_BACO))
                return 0;

        reg =3D RREG32(mmCC_BIF_BX_FUSESTRAP0);

        if (reg & CC_BIF_BX_FUSESTRAP0__STRAP_BIF_PX_CAPABLE_MASK)
-               *cap =3D true;
+               return true;

-       return 0;
+       return false;
 }

 int smu7_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state) di=
ff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h b/drivers/gpu=
/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
index be0d98abb536..73a773f4ce2e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"

-extern int smu7_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap);
+extern bool smu7_baco_get_capability(struct pp_hwmgr *hwmgr);
 extern int smu7_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *st=
ate);  extern int smu7_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STA=
TE state);

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c b/drivers/g=
pu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
index de0a37f7c632..c66ef9741535 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
@@ -28,14 +28,13 @@
 #include "vega10_inc.h"
 #include "smu9_baco.h"

-int smu9_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap)
+bool smu9_baco_get_capability(struct pp_hwmgr *hwmgr)
 {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)(hwmgr->adev=
);
        uint32_t reg, data;

-       *cap =3D false;
        if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_P=
latformCaps_BACO))
-               return 0;
+               return false;

        WREG32(0x12074, 0xFFF0003B);
        data =3D RREG32(0x12075);
@@ -44,10 +43,10 @@ int smu9_baco_get_capability(struct pp_hwmgr *hwmgr, bo=
ol *cap)
                reg =3D RREG32_SOC15(NBIF, 0, mmRCC_BIF_STRAP0);

                if (reg & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK)
-                       *cap =3D true;
+                       return true;
        }

-       return 0;
+       return false;
 }

 int smu9_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state) di=
ff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h b/drivers/gpu=
/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
index 84e90f801ac3..9ff7c2ea1b58 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"

-extern int smu9_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap);
+extern bool smu9_baco_get_capability(struct pp_hwmgr *hwmgr);
 extern int smu9_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *st=
ate);

 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index 994c0d374bfa..dad4c80aee58 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -36,23 +36,22 @@ static const struct soc15_baco_cmd_entry clean_baco_tbl=
[] =3D {
        {CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_7), 0, 0, 0, 0}=
,  };

-int vega20_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap)
+bool vega20_baco_get_capability(struct pp_hwmgr *hwmgr)
 {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)(hwmgr->adev=
);
        uint32_t reg;

-       *cap =3D false;
        if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_P=
latformCaps_BACO))
-               return 0;
+               return false;

        if (((RREG32(0x17569) & 0x20000000) >> 29) =3D=3D 0x1) {
                reg =3D RREG32_SOC15(NBIF, 0, mmRCC_BIF_STRAP0);

                if (reg & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK)
-                       *cap =3D true;
+                       return true;
        }

-       return 0;
+       return false;
 }

 int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state) =
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
index f06471e712dc..bdad9c915631 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"

-extern int vega20_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap);
+extern bool vega20_baco_get_capability(struct pp_hwmgr *hwmgr);
 extern int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *=
state);  extern int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO=
_STATE state);  extern int vega20_baco_apply_vdci_flush_workaround(struct p=
p_hwmgr *hwmgr); diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h =
b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 81650727a5de..6f536159df4d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -351,7 +351,7 @@ struct pp_hwmgr_func {
        int (*set_hard_min_fclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t c=
lock);
        int (*set_hard_min_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t=
 clock);
        int (*set_soft_max_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t=
 clock);
-       int (*get_asic_baco_capability)(struct pp_hwmgr *hwmgr, bool *cap);
+       bool (*get_asic_baco_capability)(struct pp_hwmgr *hwmgr);
        int (*get_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE =
*state);
        int (*set_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE =
state);
        int (*get_ppfeature_status)(struct pp_hwmgr *hwmgr, char *buf); dif=
f --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/p=
m/swsmu/amdgpu_smu.c
index 23b00eddc1af..82be473a3fc3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3004,19 +3004,17 @@ static int smu_set_xgmi_pstate(void *handle,
        return ret;
 }

-static int smu_get_baco_capability(void *handle, bool *cap)
+static bool smu_get_baco_capability(void *handle)
 {
        struct smu_context *smu =3D handle;

-       *cap =3D false;
-
        if (!smu->pm_enabled)
-               return 0;
+               return false;

-       if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
-               *cap =3D smu->ppt_funcs->baco_is_support(smu);
+       if (!smu->ppt_funcs || !smu->ppt_funcs->baco_is_support)
+               return false;

-       return 0;
+       return smu->ppt_funcs->baco_is_support(smu);
 }

 static int smu_baco_set_state(void *handle, int state)
--
2.34.1

