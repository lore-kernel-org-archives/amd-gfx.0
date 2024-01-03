Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A69FC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9953B10E084;
	Wed,  3 Jan 2024 08:11:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87FA10E084
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkKXETPlsP6b/Mbo8lWn/iP5m9WDKGGuP0jDINuWgB/Kr6BPmuhKQLWfgiY+nyzNsiHQbNSTMgIPM2Ms7etIdjnu63wvTUWk55tYstLss6leT37DPLJjYpnlgeAevG4mVbwXqSXqKnoPTbIVhJHRNaxFb93W55tkqUMn/xYyrHThggRXB9WbY4jWJCYiMqzSTA+vq1+3eDgCfwF7AZiamhiuEaSdTQVxm5zemDKS2pvGicrcYYDY3HmOeneJ3xKJ6fFnID8yZz5UZ82kTdyfcYz0Z7g6eBWno+EyQw7LmmEcfT8pqFuq0vtIzwI0VVmxmhmUzPw36E4Kk9sAP6Cx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Oo50e+lPrpit/DitcgnVgsCftKo65880zmxIN1QWQ0=;
 b=brdK6AIxALNZqBbzL5c89uAxlMn3Y2vBkSh7cX6oJwihrjviEVCOhRblvNzlH8nBhd2wsJE0LqGm4XyXGGVXS3Qx5z2Ses8jo652+r6D5I02MHOX4Z8f9zo8fyj1yY1iTwgXuaAC54bTjqD4rJ1AOFrtL6J0WIdhplyALsCCtX0hVkMGcLn8JtKqpfKD2vwFaSnXEigoCclkabuhuPKIIDenYmzMk9N/eKcjETnvC6AgLtgpYjvmuKMoQew1W7RwHotrWHRNF8b/dYiyOSUvqFJyzPFZX8gHdHCjr+fSyr98IIsXVFq+/4rpSHeGr3aSiDjpH91px92MQm34vnIDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Oo50e+lPrpit/DitcgnVgsCftKo65880zmxIN1QWQ0=;
 b=SvfuvEDlRDb9MbjYcAdxS1MqLXQfR/LMGfTv3bXJqoJMqNV/QQlWTZWtFi4bUx1YoHinwhgiyguynBl2ywocndi4gzaLMp7xh9GKsA2hiP5j6ysRyvT/aVkNBLgtKpGgWcTzmNMDY1DZCm3+oWt0FZngLHUwr+hH4xmcTH4Jy4U=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 08:11:06 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 08:11:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: add param to specify fw bo location for
 front-door loading
Thread-Topic: [PATCH 1/1] drm/amdgpu: add param to specify fw bo location for
 front-door loading
Thread-Index: AQHaPhvJ3ZNOOZH0PUizbYKqjrXoi7DHvBvA
Date: Wed, 3 Jan 2024 08:11:05 +0000
Message-ID: <BN9PR12MB5257290ADF88068F0F8DBE2FFC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240103080632.7365-1-le.ma@amd.com>
In-Reply-To: <20240103080632.7365-1-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a9089c0f-d02e-4598-a1a4-3e170fe5f2e4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T08:09:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ1PR12MB6314:EE_
x-ms-office365-filtering-correlation-id: 400be30b-a5f2-4d94-ec50-08dc0c3388e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /+1iGVV+D4EwTPDTeqITiLVpNu5AKMGXksVBtkosUylBhTbZMuQ1KEOKJE+cBqb0jS5YiwTRcVa15VsuFVGITPZTdupQB1x6aJyOAXW22LLBJME+KeL5IW31XaOBAzPpbX66tMJ6W2D70bmfEU4g5kzKsvXM83rSbuPM0y+Y1IhK8yrBbcfBNNrl0cEOv9q5x2YBzQyvWQfLGOox0jG/HlCAp1HOr300nVPXKqTGrrbMF7f68dWJspsUs1XOKMN7E7UaeSuvg/TFKlUfzfaZ1q9mb9roYXMUzGIyYNaifDjOwlEky2XREMIyt51hBRpw6s4i443Xe2FC2hLhfqvfSFMiz+ZkcN8XefjwoNTReaOwDL1Oi5zlLroLuYlwol/UFLwDe0qqjngmO9yXedZ7y+SAM0VC3SkxA921gONLtfLhf7tmMX1eHUw7c7M/OHm+zxaDiKFdfJGRIMAkyUN9U5DXalXEjm+XQ/vV1f5vX2DjxJ6DA4GxOKw+jjpTcuJPMezdAB7sfVplbpQH0+lXIg4ntZFBvqisjjLQ4l72QecUXyNb1QWO/hqS9VTBg0v4os9a8zPQFeLb1qkFEYbchHz4760faJXCIL7WqwXX+wTIPnnqDSx9XaUtIIRLHtli
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(83380400001)(38100700002)(122000001)(52536014)(110136005)(41300700001)(8936002)(316002)(8676002)(5660300002)(71200400001)(2906002)(4326008)(478600001)(66446008)(53546011)(66946007)(6506007)(7696005)(64756008)(76116006)(66556008)(9686003)(66476007)(38070700009)(86362001)(55016003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KYvvF1E5xYoeT2dLlka5jrch+HAzssTpzDF3nU6bNtzEI+3pzoAogjZ9Zl7G?=
 =?us-ascii?Q?M/3RIr8OlnDzlTfgqSZHHI9p4DqcOaRegZtaEX8K3bLO9UTRDLntU+po+vS8?=
 =?us-ascii?Q?ryCDwqYrKgmyKyyhgpn2yU0Z4SNsyrHRuyEUkIBvKuKNM/57w8layhUKV2Pj?=
 =?us-ascii?Q?mXDtfcqjooop0HN3GW5WUB/ecSsrwiLf/iCukbmJuYpKhbeKFQlbM01XVHNW?=
 =?us-ascii?Q?to2wk/f37yXiNxH1b4d4V5yHpvOn14MGcUB53leRlloH9HoLQ8rxJKjGWQp2?=
 =?us-ascii?Q?At7A86aMxW66Q+sybCLBC7KNBIe2SmntTPW7k1PdoDfyNOKNzFKtb7NJjyNY?=
 =?us-ascii?Q?6NUd6Ol855E54GZG1QHpI+ssy5ElPabptcKdkNGc+LbyGrZp8UX8iPOisocB?=
 =?us-ascii?Q?f+jQ9FV89le2TuYxvEM7+jgKKuHLWAa4Gcdzu9yPf9gsy01+mqrhojiiJoSj?=
 =?us-ascii?Q?gqCyOPQ4T+LotnqzyW0rcQmn4FiJSEP/qET/DqUXU+ap/aaF7gzFATIvWdD7?=
 =?us-ascii?Q?zUjFrziuXBhpbaZ/OurBzF2ZF5Hg2TB7gLNn5x11RKzWrNG/66v89loLsVUz?=
 =?us-ascii?Q?4jMA4K3RdLe7da3RMVNpeDEJOL+8tVjt6Ir6Exll8FQ7P4j14lzlq+TsYbHt?=
 =?us-ascii?Q?iF9lhL0XSk2dm6+v3Fxq9Y+ygQas3hw7ouJb4AMk1LFYOQ5VDj/kRWE/wrYm?=
 =?us-ascii?Q?leOz/yXqbKWiR0SnX7mfOazmxJ/tS2RsWUc/ZnBAz3T8HGFzADqEsDiZtCZ+?=
 =?us-ascii?Q?+7ugoqJu26ETZZCaNB/K2//FfRxoB6DiQnkMRKWi1Bzjcj0KoenTvAOU8SHM?=
 =?us-ascii?Q?oB/iQjFbE9hWeJe6wzkI4v++eTQgq0k4ENRkV7B0oJrdDAu59oBJLjEn7FR5?=
 =?us-ascii?Q?OaNB4RQhiMvo6j6L6+idyYTQaa8ODckCxWmhRhmwEul3tZslJ2oPs7QSUnKy?=
 =?us-ascii?Q?9/dKUrqg/n6dw+ydlHs8MsBZYdWerj92MGLTynKpRSWBZdHExb1xV6pZyfy7?=
 =?us-ascii?Q?IVEwIjCV4wQTw9Y++TaQCFX+C3qOBOMwo841Gr1YjJEBW2OaPrfYHBqLrOf1?=
 =?us-ascii?Q?gcu9eO+SFDdQIlzllkgnL1rhswv7sfqtK3tXhGJT7coyh0FEcDSHecp6BM4F?=
 =?us-ascii?Q?QU0esSCNo2mMkSsvdI/CIDAuHVWsVLRnX6krOkBu3zAgUnGKpSW0ryWYJXfQ?=
 =?us-ascii?Q?WYCRUb7ljNNBArZDxnEwwiipJzf/tIzo4dlZScWwnxRGc+sq7CTJP2RFvgQ8?=
 =?us-ascii?Q?uUKBcGLJO555hF2BAc9LlgDgqpdOI8VNO1vPbFKYnh4wfOrWqrdd8RwPor2o?=
 =?us-ascii?Q?Vf+4P/VRwccosdL6+UcJK3AptKGAlc6sXsIMCU3WfZjm8q0HqkZ52Lt12oAL?=
 =?us-ascii?Q?vdwZFk5zlqya0vyYiNvBS1LzlC0RH+mgGOixHmpvgxKj8MYY/nLXvlLFA30n?=
 =?us-ascii?Q?vr8bakOAcgnqmhTcN2zOvl00NjrNHKKEviymFuzLtAjAFamKqVcuu3kpsVkQ?=
 =?us-ascii?Q?QiRsmpbbzpyrmG3wzn45pXBfN31h4fnZ07TEg5sWa/eej0MyzdwoipQZlCHh?=
 =?us-ascii?Q?6JAtNXZl0r/ApyxvChIG4k7QxWhxz9x8pkMk3glg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400be30b-a5f2-4d94-ec50-08dc0c3388e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 08:11:05.9106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycgSt+Hzj0vNFpI7d+c4WbgfIlC59ErYuu2iWPQUHeFD0U1r3PJaUHd5U8s6MFxMrCWOCvZXpEdWC/rYQ7q9cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Ma, Le <Le.Ma@amd.com>
Sent: Wednesday, January 3, 2024 16:07
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>
Subject: [PATCH 1/1] drm/amdgpu: add param to specify fw bo location for fr=
ont-door loading

This param can help isolating data path issues on new systems in early phas=
e.

Change-Id: I0a972dd74fe2aad6b56628cea32ad72dcd17e283
Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 616b6c911767..9da14436a373 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -254,6 +254,8 @@ extern int amdgpu_agp;

 extern int amdgpu_wbrf;

+extern int fw_bo_location;
+
 #define AMDGPU_VM_MAX_NUM_CTX                  4096
 #define AMDGPU_SG_THRESHOLD                    (256*1024*1024)
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS         3000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 880137774b4e..852cec98ff26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -210,6 +210,7 @@ int amdgpu_seamless =3D -1; /* auto */  uint amdgpu_deb=
ug_mask;  int amdgpu_agp =3D -1; /* auto */  int amdgpu_wbrf =3D -1;
+int fw_bo_location =3D -1;

 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work=
);

@@ -989,6 +990,10 @@ MODULE_PARM_DESC(wbrf,
        "Enable Wifi RFI interference mitigation (0 =3D disabled, 1 =3D ena=
bled, -1 =3D auto(default)");  module_param_named(wbrf, amdgpu_wbrf, int, 0=
444);

+MODULE_PARM_DESC(fw_bo_location,
+       "location to put firmware bo for frontdoor loading (-1 =3D auto
+(default), 0 =3D on ram, 1 =3D on vram"); module_param(fw_bo_location, int=
,
+0644);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 1bf975b8d083..2addbdf88394 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -466,7 +466,7 @@ static int psp_sw_init(void *handle)
        }

        ret =3D amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-                                     amdgpu_sriov_vf(adev) ?
+                                     (amdgpu_sriov_vf(adev) || fw_bo_locat=
ion =3D=3D 1) ?
                                      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_D=
OMAIN_GTT,
                                      &psp->fw_pri_bo,
                                      &psp->fw_pri_mc_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index b14127429f30..1f67914568f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1062,7 +1062,8 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev=
)  {
        if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_DIRECT) {
                amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_=
SIZE,
-                       amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AM=
DGPU_GEM_DOMAIN_GTT,
+                       (amdgpu_sriov_vf(adev) || fw_bo_location =3D=3D 1) =
?
+                       AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
                        &adev->firmware.fw_buf,
                        &adev->firmware.fw_buf_mc,
                        &adev->firmware.fw_buf_ptr);
--
2.38.1

