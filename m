Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C349DC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 14:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F1812AAFD;
	Thu,  9 Jun 2022 14:43:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108AD12AAF3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 14:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh8F1OFGyQpCI8A0KbufHTNfZzOFPwDxMpPhurmkOMuu24uobcS58120r/VyDKFOSFBGrCK4ORPbEyLmi8L4DmbuWtLlMyZhNP01znMDxtonN1uqnG76eE4hwXish/wknqrCa0oG5/AYmOc5q2PWn5b5WCp7YlRRKH7fxbMYt1CMQSopaSpNW4ZOKsX4O8no/pMw/fesw6cZ9f19+KcToTZOrxQ8SB7VxOrZc4uMY6rtDPTbmGY9Q5hLFAK+7mwhZfUyzCFFhflKPWZDI5lz8zTFtbF1ACl1Hkrw7ZR68IIsul4CLTtrIJal83XjNtGuQJL7LbV9FVkAmvJzin9mag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgoupK9yaDF2T7Ub4yamNCBb3HSrgqeWwzm37QEjW4E=;
 b=hlSgWQHkbl1Iu8YSc2DLJHgr3SFdFloGwBcEHL5eM3zorHefLh6TU9albtGb94yVlNlsjoJY0C8PS4YN3nRiIO8gfsVwwC4Zcvh0spOWwqYdGGTonE5lE6JjagvCucaEuqXNXgO02sOW6e4brTUFje6ygEMVt8iEWsi4WDpyo5rCaFatncJ7LNjgiX++lDCYkZJIU3otu6W2uYgBBZ4bCsofgq2VPmvW9mvCZxhUolpYAhPVKgaN2FPJCwNzen5jxpD6MElCe3GCZpv0rB3vNyzITDt2f88tdyF0s7KrZp334c6ksKLvhNgViqmknrHzrMdv2xElIFIWXXPKnec30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgoupK9yaDF2T7Ub4yamNCBb3HSrgqeWwzm37QEjW4E=;
 b=1OGPZT8HdPV8f91JJUHWDrmF7sWWFEFs9f6aoYX/QZ20do9fYWirGclwzVoPTHoL3Fo2JvvWZEg8QKqDz0p8EPxjcwYKizpKr38UeVKH2lZ5zzARa3bNmQEEtsAqBC14JdDsYk5WR9UaxR82js9nBmdICX9km837KRTy7omhpnY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:42:56 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%6]) with mapi id 15.20.5332.014; Thu, 9 Jun 2022
 14:42:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue for
 smu13
Thread-Topic: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue
 for smu13
Thread-Index: AQHYe/TINNUaqhBk2EylXTdg8t0uY61HJm+J
Date: Thu, 9 Jun 2022 14:42:55 +0000
Message-ID: <BL1PR12MB5144182D6A555FC666D98BE3F7A79@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220609113255.2124596-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220609113255.2124596-1-KevinYang.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-09T14:42:55.507Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 497f18f5-4556-4a2e-01d8-08da4a265746
x-ms-traffictypediagnostic: DS0PR12MB6413:EE_
x-microsoft-antispam-prvs: <DS0PR12MB6413236CC87458EB768FE893F7A79@DS0PR12MB6413.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ACzXVWEC+ycMSpJW/PYV3IrxF2YsmTrxxEpRjdRUoAsvJox7mEgHN1aqsys/0wUZ1q9KNwYcpo/hvMwBn4ox3HDuH4AE8GxUPzHJfjK+oIMzegWXGeTCu0+b1PRfF+TOROyz3RBgfJQmVtIlF5lQt+TDHKbD57/egcUb5vswNOeA8PeuqvcHY+eDNdr/IYz7G2gBS2erdPzVYQL0TgyPhzpB9sDCikasFXIX8cXJ9yYwPBmHJZO2DDjzNXKAdvCuflCMqf+rj1LtcBw4F+GcAcG7BHLfVuqlpwqolQ4Uybg1Qq52DE2XOpFO0TuaaivwZob2nlllzlmaWHuntKD6SpGIxltHce12zZgOclZKDHKUjGnLKDL7zHGvufz9CH+RXSJVfbiHL046bwUrkT28BqbswWIPXO8hdKoR4mlZTQGdxl+Qeoy9hjifQEFBJi0X4G9GlXeUJxE7ZIGky/fRCIMWZOA+skXHJanbe7V8cVq9nkhnCpgf8ep3iSO8u13jCCLhQ+TwX+hMCveu3ps/MdqBsUA8/La1A6E/FjONwqdtcDhNXCqxQFECbVczmVvdsrIAbKgElcG12cfoIfOb4bE1ck8F+0d6TY9QHZBnyNg8CPBj5yhh9WQ1pU2Yn5d7rWWBq0fUmRZISR38p1IOERaOn9GFqnMYeK15QCuIcGuBBmcFsQRhgzq7ZUtopsibkCqQdH4NE4KZW1iTBo5R7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(52536014)(19627405001)(26005)(38070700005)(64756008)(76116006)(66476007)(8936002)(110136005)(54906003)(508600001)(71200400001)(9686003)(38100700002)(5660300002)(53546011)(66556008)(66946007)(316002)(33656002)(6506007)(86362001)(2906002)(4326008)(8676002)(186003)(7696005)(83380400001)(55016003)(66446008)(19627235002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HtnhLPC53S26hYyocBWby44m8ba/fPFsLMO/Is49tPpTczmq41U5Z3qlXuAD?=
 =?us-ascii?Q?wAb4L69ecPqARBW2c2lQnxoH+XdiPOzok1gVfpCR8goI5UMSh9hujxmSvPDj?=
 =?us-ascii?Q?eRd/0ahmpe7ZDFPtXcStOk6e68wWg9qNq64Dwnjc0B0SQTvjQM+jhvwODW08?=
 =?us-ascii?Q?CYYUT07VLSsgmdh+aq2Tm7JNv9wB/7v34nT+2gMRuaAaiU0kng7Di7lnYGKE?=
 =?us-ascii?Q?esoe4n6ZMDGID3MVLpHmvoqT13rdEvCILH2s3h1hQ26Q85g0Ru0aIkYZPYrn?=
 =?us-ascii?Q?ofTpchse9IUNkJCGzVbmgsHfN1LWPExtyZGIYSgqTEDTcrlUTukp0LiK4WXu?=
 =?us-ascii?Q?o0N7/hkrM8orUWH7Lz2UeBbS5eQD4+c5ZHYu90E5y7/bxMxhneh8NJq9bldU?=
 =?us-ascii?Q?miWf1VufptOkfI0CWlKG64Dghnqq+rUANoVykgAY2ysbBZ8dHP81x74DSA3q?=
 =?us-ascii?Q?Aw78g7nvVjlNEi6nwditvLPTBFPp/JwLrOzujSLuN7ddqG2uXOFl7P3BnEtb?=
 =?us-ascii?Q?fVFJe8JhNGrk9QvAzUjAa0NuroQFdlfcnFgIbANKT2xeUrmKBcFgErPkRhJU?=
 =?us-ascii?Q?LuuBVcc1xi2xgZaAHCJREoljoC395YMZYc16Ruf4AFlbmdQfUF9dUo11s1tZ?=
 =?us-ascii?Q?cvsBa9r84th0CzrA/+n8MXxbiS8LiBZ7JoWDUvcIVz+HG3UHH/2el0/8Ikhh?=
 =?us-ascii?Q?+g9mwTADQfMC4FMcafLkQ2Ox4X6GgbETqp/61xCcv3/fKPbKxvTGPCFzGJJm?=
 =?us-ascii?Q?U0BAuEAc23xwd04nlRLJVfjx7t2xdxPzfcqhqZ9Ej+9Tg5Lm/Vu2IIautGJ0?=
 =?us-ascii?Q?hrPbU0HJ/YTEE8Q78x10dd56/u+1bdyrJSnrzu2if8J50FB2BNminnagX1mf?=
 =?us-ascii?Q?joAO3oKDxzMnbhTMbTmKKEiAZ0HPJKh3ak8wvMyBr0NZuQjI7iPiCQN3Lax6?=
 =?us-ascii?Q?k2r3hSrQCtAf0N1wjcsrTKlyLDxpY7eHwgqi0137tdGlMOIq9AoDz2mt9Sil?=
 =?us-ascii?Q?ZjhJIRgnM47W7TAJKfv0oI768sBho+0rg9OCGyyijCZTlPUcBx5csX9rUlkd?=
 =?us-ascii?Q?ZmDmLmV5rq5ukcIBFeAe/KdlCzDTVk3xlXAdDOB4zIQeN8HWfz0aYvmCY8rB?=
 =?us-ascii?Q?6rzAuo/1IxVziyvDezU2Mj8FQjgZBvDSZP0txVaim0iYuzsz44qk49iJ0VRU?=
 =?us-ascii?Q?wknSYSQsrh+voBTkZ82T44f/vH5qXPBFGNk9ZKxTweiLbkewVU9QA73XoEYO?=
 =?us-ascii?Q?bh79iR4hdHjXvCm6Fn/9p2z4Ad4ZG/7GbnasvhyG3hj4ry14313f9FTo6mcK?=
 =?us-ascii?Q?B4DlW0fRSgOq/Kr4i6/OG+7uUlAARzTftovti7gouIsjC/L+4aLOHP7jSuJv?=
 =?us-ascii?Q?nwsLmMZSqDNcCJrQi3B6FLHMgUJRpjcFtpuNGdvaqt0ghYndhVjnR3qX3MTM?=
 =?us-ascii?Q?PuASZy1i2e2C+V4PEcYdWH1UodAVBOBJFQm/ht8hiTcZqwjgbCgRX+KuoIcm?=
 =?us-ascii?Q?ACiV+yku8jBl3+hmyMZEEEouHt1gtaHojobUfBYAWK27AzTGl2h8asrMjeUd?=
 =?us-ascii?Q?L584dl9uWGzZEB9E/lzqsuhNKC3lWlHZldnrrbKZoV08isyByqhA5MVxdcdG?=
 =?us-ascii?Q?B0PXLgDV/kG+SJAtAo1UzQkPxR3vUNVEl2WuINwPuXWOm5EcJX33ODTVeoET?=
 =?us-ascii?Q?iLZy1/E3S8dqIQjsLpfvqZ8Z3s5RX4+ePDCHtlvT4jP8DKlJUvSEy7Tw46dM?=
 =?us-ascii?Q?iE1xSprqbw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144182D6A555FC666D98BE3F7A79BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497f18f5-4556-4a2e-01d8-08da4a265746
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 14:42:55.9452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0N+plZ1kleiqbe7ejVl6BR3Pexfi8CCE66BBbPH6ULpC0O0H3vC6KBatu3bI+6uyt6XZQd3MItY+J+1XKx8DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144182D6A555FC666D98BE3F7A79BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yang Wan=
g <KevinYang.Wang@amd.com>
Sent: Thursday, June 9, 2022 7:32 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: fix driver reload SMC firmware fail issue for =
smu13

issue calltrace:
[  402.773695] [drm] failed to load ucode SMC(0x2C)
[  402.773754] [drm] psp gfx command LOAD_IP_FW(0x6) failed and response st=
atus is (0x0)
[  402.773762] [drm:psp_load_smu_fw [amdgpu]] *ERROR* PSP load smu failed!
[  402.966758] [drm:psp_v13_0_ring_destroy [amdgpu]] *ERROR* Fail to stop p=
sp ring
[  402.966949] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware loading fail=
ed                                                                         =
                                                                           =
               [  402.967116] [drm:amdgpu_device_fw_loading [amdgpu]] *ERRO=
R* hw_init of IP block <psp> failed -22
[  402.967252] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_init failed
[  402.967255] amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init

if not reset mp1 state during kernel driver unload, it will cause psp
load pmfw fail at the second time.

add PPSMC_MSG_PrepareMp1ForUnload support for smu_v13_0_0/smu_v13_0_7

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 8 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index f57710790b8c..14ebc35d9cf0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -66,6 +66,8 @@ static int smu_set_fan_control_mode(void *handle, u32 val=
ue);
 static int smu_set_power_limit(void *handle, uint32_t limit);
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
+static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
+

 static int smu_sys_get_pp_feature_mask(void *handle,
                                        char *buf)
@@ -1414,6 +1416,12 @@ static int smu_disable_dpms(struct smu_context *smu)
         switch (adev->ip_versions[MP1_HWIP][0]) {
         case IP_VERSION(13, 0, 0):
         case IP_VERSION(13, 0, 7):
+               ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+               if (ret) {
+                       dev_err(adev->dev, "Fail set mp1 state to UNLOAD !\=
n");
+                       return ret;
+               }
+
                 return 0;
         default:
                 break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 26fb72a588e7..fda89e309b07 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_=
map[SMU_MSG_MAX_COUNT] =3D
         MSG_MAP(GetPptLimit,                    PPSMC_MSG_GetPptLimit,    =
             0),
         MSG_MAP(NotifyPowerSource,              PPSMC_MSG_NotifyPowerSourc=
e,           0),
         MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,     =
             0),
+       MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnlo=
ad,         0),
 };

 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] =3D {
@@ -1662,6 +1663,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {
         .baco_exit =3D smu_v13_0_baco_exit,
         .mode1_reset_is_support =3D smu_v13_0_0_is_mode1_reset_supported,
         .mode1_reset =3D smu_v13_0_mode1_reset,
+       .set_mp1_state =3D smu_cmn_set_mp1_state,
 };

 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index a92ab3266091..185058637f7d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -116,6 +116,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_=
map[SMU_MSG_MAX_COUNT] =3D
         MSG_MAP(DramLogSetDramSize,             PPSMC_MSG_DramLogSetDramSi=
ze,          0),
         MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,    =
             0),
         MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff, =
             0),
+       MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnlo=
ad,         0),
 };

 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] =3D {
@@ -1647,6 +1648,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {
         .baco_set_state =3D smu_v13_0_7_baco_set_state,
         .baco_enter =3D smu_v13_0_7_baco_enter,
         .baco_exit =3D smu_v13_0_baco_exit,
+       .set_mp1_state =3D smu_cmn_set_mp1_state,
 };

 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
--
2.25.1


--_000_BL1PR12MB5144182D6A555FC666D98BE3F7A79BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yang Wang &lt;KevinYang.Wang@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, June 9, 2022 7:32 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Wang, Yang(Kevin) &l=
t;KevinYang.Wang@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH] drm/amd/pm: fix driver reload SMC firmware fail iss=
ue for smu13</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">issue calltrace:<br>
[&nbsp; 402.773695] [drm] failed to load ucode SMC(0x2C)<br>
[&nbsp; 402.773754] [drm] psp gfx command LOAD_IP_FW(0x6) failed and respon=
se status is (0x0)<br>
[&nbsp; 402.773762] [drm:psp_load_smu_fw [amdgpu]] *ERROR* PSP load smu fai=
led!<br>
[&nbsp; 402.966758] [drm:psp_v13_0_ring_destroy [amdgpu]] *ERROR* Fail to s=
top psp ring<br>
[&nbsp; 402.966949] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware loading=
 failed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; [&nbsp; 402.967116] [drm:amdgpu_device_fw_loading
 [amdgpu]] *ERROR* hw_init of IP block &lt;psp&gt; failed -22<br>
[&nbsp; 402.967252] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_init fail=
ed<br>
[&nbsp; 402.967255] amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU ini=
t<br>
<br>
if not reset mp1 state during kernel driver unload, it will cause psp<br>
load pmfw fail at the second time.<br>
<br>
add PPSMC_MSG_PrepareMp1ForUnload support for smu_v13_0_0/smu_v13_0_7<br>
<br>
Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 8 ++++++++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++<br>
&nbsp;3 files changed, 12 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index f57710790b8c..14ebc35d9cf0 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -66,6 +66,8 @@ static int smu_set_fan_control_mode(void *handle, u32 val=
ue);<br>
&nbsp;static int smu_set_power_limit(void *handle, uint32_t limit);<br>
&nbsp;static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);<br>
&nbsp;static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);<b=
r>
+static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);<b=
r>
+<br>
&nbsp;<br>
&nbsp;static int smu_sys_get_pp_feature_mask(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; char *buf)<br>
@@ -1414,6 +1416,12 @@ static int smu_disable_dpms(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[MP1_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 7):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Fail set mp1 state to UNLOAD !\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index 26fb72a588e7..fda89e309b07 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_=
map[SMU_MSG_MAX_COUNT] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetPptLimit,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetPptLimit,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(NotifyPowerSource,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PPSMC_MSG_NotifyPowerSource,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(Mode1Reset,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Mode1Reset,&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PrepareMp1ForUnload,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Prepare=
Mp1ForUnload,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] =3D=
 {<br>
@@ -1662,6 +1663,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_exit =3D smu_v13_0_b=
aco_exit,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset_is_support =
=3D smu_v13_0_0_is_mode1_reset_supported,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset =3D smu_v13_0=
_mode1_reset,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D smu_cmn_set_mp1_st=
ate,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index a92ab3266091..185058637f7d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -116,6 +116,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_=
map[SMU_MSG_MAX_COUNT] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramSize=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P=
PSMC_MSG_DramLogSetDramSize,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(AllowGfxOff,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_AllowGfxOff,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DisallowGfxOff,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; PPSMC_MSG_DisallowGfxOff,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PrepareMp1ForUnload,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Prepare=
Mp1ForUnload,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] =3D=
 {<br>
@@ -1647,6 +1648,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v1=
3_0_7_baco_set_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v13_0_=
7_baco_enter,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_exit =3D smu_v13_0_b=
aco_exit,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D smu_cmn_set_mp1_st=
ate,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144182D6A555FC666D98BE3F7A79BL1PR12MB5144namp_--
