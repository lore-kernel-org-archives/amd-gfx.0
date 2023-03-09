Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B7CC64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 11:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB2C10E7F5;
	Thu,  9 Mar 2023 11:41:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 533D310E7F5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 11:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP9YINnSwt61uxa5A/dsbzLbA7R2pgit6//iW03Nkh/PwbZ7W/rmPjxx4SCMy5mvOOUL6/7GtE4/8/8/POvJAzEXdovHN9vkd4KJZ743eT/Qncr0x7ri6mr2CJSOgw+8wD65JHiFqZv3sq+o2xVX3Q/BYQ8d7hzBlOFOOz85agGI2MnyVcPYlaSLjnTFgBaOr0z/uSNPpnaZCZ5P7IcW4+7+w6n33kI0E9+Of5yNk3Z1kk62AA94l39zLdFGfoCxemcRB/9m1FkwG4XuobIRaWuYvaBH/GlqOMuqevqOf32NmSHG+adl7KESOxcNnkkbpu3rGp+xfduUh0lyb6GXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCdNl340dhVeIp+7gYUjhWYlQPXnJiqw6PVYwz75lIQ=;
 b=ByoENO481E0CmPPVKWnnWHrNf0W0iVJAiZASYh+Y2zEavYbPfwWbSsTFSE9nIXnByf1PRSY0U4WovYGnBx5eDxhnAI3akdiQIHCJiw3ZFYGt/cvEYEMsU9y8EWS/SbxNLONFSgefx9Qv2QLpkAfgTzxGnFX0N/+yohRVH7COjq4xGFt8lN79aRfImkYYcI8E9CSzh0IdF0mdm3RAFUXQfcOoBIQmPBkqldQ696aV8olT/DGQoS1A8CvCILRGpCUzF7ouBdej0/jgecmMoYWtbgeo25fYwwvdsr0CAsO+RQFMGH6CUAfGkl8mw8MBEDkKhnjvMemoPSUMKPsikqop2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCdNl340dhVeIp+7gYUjhWYlQPXnJiqw6PVYwz75lIQ=;
 b=25UKd6Xjw+nNKlFI8EyvGnseiOgjWFnxiYjk41uQFpl8Aj7E+D7aUGZnyVRTtXx1V8iFT58ZRQUHKj/0RWhzrMBY9SBFhRGRyqdcQaBAlWeMx2qZDtPAiNXsZ1EDQK5asKjEnjymO7YvQqZsb1+EUb/Q6edce3grROZ9f2AQMWk=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 11:41:27 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::e4c7:294b:cbb7:3c60]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::e4c7:294b:cbb7:3c60%5]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 11:41:27 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Remove unavailable temperature params
Thread-Topic: [PATCH] drm/amd/pm: Remove unavailable temperature params
Thread-Index: AQHZUmzX69wunIepIE6xiVvQ4cw1da7yUkzm
Date: Thu, 9 Mar 2023 11:41:27 +0000
Message-ID: <PH7PR12MB59973C30A448D7C02A26D08E82B59@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230309095153.2304598-1-lijo.lazar@amd.com>
In-Reply-To: <20230309095153.2304598-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-09T11:41:26.823Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB7274:EE_
x-ms-office365-filtering-correlation-id: d6b6a81a-9788-4ba1-f105-08db209337d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wAFT8mOAstp/jSxv2uZds/5rF/hCuvNFkS7NsOo6r3MhP/rza0gF1Zey+OBFEzMa3wTtTS+izfVJ1z/CW9CyrcXhObceARDny+LYCRgelHQsRGH2PgetWkrRgQ0JI+cP92p8qjh9h2YvL/jNhxgOm6xKmztDZOR+CwdPnvWpuc91EMEc2r+kd8Tu6L7l51ZWaYnDxgePwh2xV6i21b0f5OU4rI9Bk84rt5O1TGSybmwW8MNxAl+7Gj3vwZln87FfwX9f/ZLiH4WdT/cPQ5ChLhuTbabOIFiOW5qioQAKSZlVIHTXinQO2XmAjEIDYHDFBX3ZbiM4ostItrKOiQpMmQNNFNdRZa6lcCBlYPz4hoLLzwusMigSlWvWRKLHEwwrlr80vSnbQ6royZtLS9tEEfF22cViUN8S+/xpDQRA6AYZm/vLzJ2p6g02KLz2AtYZARRALTM1+IE8bNr+7xOvJoZwSfWK9wppfAoFzflNt0Noi/+sIWOghPhtwD4XmHEkPI9d6f/i4DWlfnOf0uTeh7bn/AP1G6oO2S2d16CtDhGRhIWTj/IcYvV7m0WlhXZVUMG0WLXrfP7gExHoWpN2Br6/1B8iRsy6exDWdiAqnFohZf1FPk1yAe+M5gwid+Y7hcm6iXoJDluxssDebcSNUbzwJw4XWbUq8yP4aCJZC5MoOONc9KCN2T7QoeYOSlEalyM/9ChB5TnYd1Gkg/OhNs0aDXkwPwNoNgY0iTkISvs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199018)(19627405001)(64756008)(5660300002)(52536014)(38070700005)(4326008)(8676002)(76116006)(8936002)(41300700001)(6506007)(66946007)(2906002)(86362001)(38100700002)(66446008)(122000001)(66476007)(66556008)(33656002)(54906003)(478600001)(91956017)(55016003)(110136005)(26005)(316002)(7696005)(71200400001)(83380400001)(9686003)(53546011)(186003)(131093003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CeLyMdJHL+2Ftj7jnCVsy2pJn2v8gS9sCSPkGQICCdlYyOVJCCIed85Dfe?=
 =?iso-8859-1?Q?luod4Yg2IC6tdPDdI+Y8lpTE7UKaGf/tcWuTbcCpKnUf/e+0KNXFee+Mb3?=
 =?iso-8859-1?Q?2U9C147Tp7AWu1pRJb5y1QeE6vrmODDIeAVjte0dOxDiANqme8lp91cRbo?=
 =?iso-8859-1?Q?w4jXRjoj6AS4orCS3mzOic9lv3Zzto9FWFk4zwi0ZuhA2I+YLnHLBcUhMf?=
 =?iso-8859-1?Q?vByOhdYbKKUg3vwWhA+iHH35/9oseVshnPHpotNPpzNMu30akkYj7Z7Yd0?=
 =?iso-8859-1?Q?TFAkED81+qJAb7UFxV2Osviq8TJ7aLk6sdUHBKm2Iu5EByYcf0JC5lIf18?=
 =?iso-8859-1?Q?9VV802zx1cCw2aUu+gvl0Kl3ra68jSzOv0FrOZj3nxQ2PAcBJ+leJhOug4?=
 =?iso-8859-1?Q?oIsMUHbxytSMXpdIsJeKAc3cBUasiDb5aRJ/jV5il3AJpAwQ3HlJcgWwPd?=
 =?iso-8859-1?Q?p36GllwVz/ryX2cnpqZnd+nOWQxBlL/LWMcFEIqvbRE1HXlro2dfsKFYh3?=
 =?iso-8859-1?Q?w52wUf8/xYeUw89FRFEobNa7ysOQSY/u5BGdV0wNmm7UYpu4V0HEBsOY9X?=
 =?iso-8859-1?Q?HwurD3GFxpUNq1PM+mkH2y65qpd8ieQyop/hyIBlUhQ5UK6XKWo7wQJAlc?=
 =?iso-8859-1?Q?EtqHpEEcwdMlujrVEEAU/AEPCARyJyvWPeGEsWEJF2q3S4bujk1M+5DV8r?=
 =?iso-8859-1?Q?1K+/cVetlWUvrhgzS6nP38rw3qMSc3X2K9uGRNww3HmHqoHcuKm3rZ8hZQ?=
 =?iso-8859-1?Q?reZvfUq5VPDBeJsv/wn5T/eKtFRRZqr+L8fGEeWVSNQLgQngFbamtFsNcb?=
 =?iso-8859-1?Q?0bZwF4p1ZHN1IpdMgjsCZkRk2k+gKbqv9dxUnSDwFB1cpEuheTslZwf+ue?=
 =?iso-8859-1?Q?45YZxmjVB55xNxBW1rDU7KRrxlb5COq0LnL2YSE1TuzPtOa0dJlQlkcg28?=
 =?iso-8859-1?Q?IsWog+piyGXuA9TaPwMFmCbidTJmMQIZtdEqRzYOLpMSLHUc4V9ZplQQ/i?=
 =?iso-8859-1?Q?ex3mCYiexPsxWgNL+FXljzHxyXWc6+qavZsYULBVPuMIxD2upH7E1wv4Oq?=
 =?iso-8859-1?Q?NMyETbkfp00MOuuxN8ej7VFTSA2TarnGIQYGDeJcXvWm64PRn9kgCKHSra?=
 =?iso-8859-1?Q?lgkY80qWwYEqHkQbjHOH+AhAxAs8y7NA/yW9fzYBBLFqAu5vgNIudGRiCA?=
 =?iso-8859-1?Q?BwJjacr1lQKLy6VuN9TOEEoJvpBl3g8/yM/DQ2pmX9h1p6lAPQvxvxRNIN?=
 =?iso-8859-1?Q?npC/qvm/+b9GY4DKUwIpWC6a4DmGk8Kd80nRlhbpfIf5vynoiDU29x8XyL?=
 =?iso-8859-1?Q?CUEPaCT0/TRjEz4hFGd5+1+t7EcQ+hrYvHuuem1ULaZg+Fa9mdFUlML00E?=
 =?iso-8859-1?Q?h7cOOL0Nv0uRviMoTUHKqNr/EMd+3YHQ1EwtxlSp2OhjDkqBxyPtif1KvN?=
 =?iso-8859-1?Q?iENi6Cu0Y2gislKR+nYoQx9/lUiLjuwukTo0IouVKCuNWxfQBOQPK4VR8i?=
 =?iso-8859-1?Q?5qqyZNmBnvRkYMZQEyJAk9xytYMFHlJ0Cnop1HTuPDqi9quNY/D28V0HnK?=
 =?iso-8859-1?Q?qYe65LsPZG5ol+/KnU1HORsU9VSpvgQ5tggQVW0eHU5rgWpLbOwiyfT9Jk?=
 =?iso-8859-1?Q?FbjjmnmxOLW1E=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB59973C30A448D7C02A26D08E82B59PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b6a81a-9788-4ba1-f105-08db209337d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 11:41:27.1677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7h4+CdhNXroCOpfBJGzcbb47SibeIu62qgJ0I9ohTNRniyU18rfwW3JR+5l+tkl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB59973C30A448D7C02A26D08E82B59PH7PR12MB5997namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

we'd better to add other patches to avoid create HWMON node file "temp_inpu=
tX" when smu doesn't support sensor type of AMDGPU_PP_SENSOR_EDGE_TEMP.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lijo Laz=
ar <lijo.lazar@amd.com>
Sent: Thursday, March 9, 2023 5:51 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Remove unavailable temperature params

Temperature limits are not available for SMU v13.0.6. Also, edge
temperature is not tracked. Remove logic associated with those.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 43 -------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 862859bfb9e1..54d36df1306f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -82,12 +82,6 @@

 #define smnPCIE_ESM_CTRL 0x111003D0

-static const struct smu_temperature_range smu_v13_0_6_thermal_policy[] =3D=
 {
-       { -273150, 99000, 99000, -273150, 99000, 99000, -273150, 99000, 990=
00 },
-       { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,
-         120000 },
-};
-
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_M=
AX_COUNT] =3D {
         MSG_MAP(TestMessage,                         PPSMC_MSG_TestMessage=
,                      0),
         MSG_MAP(GetSmuVersion,                       PPSMC_MSG_GetSmuVersi=
on,                    1),
@@ -701,9 +695,6 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_=
context *smu,
         case METRICS_AVERAGE_SOCKETPOWER:
                 *value =3D SMUQ10_TO_UINT(metrics->SocketPower) << 8;
                 break;
-       case METRICS_TEMPERATURE_EDGE:
-               *value =3D 0;
-               break;
         case METRICS_TEMPERATURE_HOTSPOT:
                 *value =3D SMUQ10_TO_UINT(metrics->MaxSocketTemperature);
                 break;
@@ -1127,33 +1118,6 @@ static int smu_v13_0_6_force_clk_levels(struct smu_c=
ontext *smu,
         return ret;
 }

-static int
-smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
-                                         struct smu_temperature_range *ran=
ge)
-{
-       uint8_t software_shutdown_temp;
-       uint8_t hotspotlimit;
-       uint8_t memlimit;
-
-       if (!range)
-               return -EINVAL;
-
-       /* TODO: Find a way to get temperature limits */
-       memcpy(range, &smu_v13_0_6_thermal_policy[0],
-              sizeof(struct smu_temperature_range));
-
-       range->hotspot_crit_max =3D
-               hotspotlimit * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       range->hotspot_emergency_max =3D (hotspotlimit + CTF_OFFSET_HOTSPOT=
) *
-                                      SMU_TEMPERATURE_UNITS_PER_CENTIGRADE=
S;
-       range->mem_crit_max =3D memlimit * SMU_TEMPERATURE_UNITS_PER_CENTIG=
RADES;
-       range->mem_emergency_max =3D (memlimit + CTF_OFFSET_MEM) *
-                                  SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       range->software_shutdown_temp =3D software_shutdown_temp;
-
-       return 0;
-}
-
 static int smu_v13_0_6_get_current_activity_percent(struct smu_context *sm=
u,
                                                     enum amd_pp_sensors se=
nsor,
                                                     uint32_t *value)
@@ -1204,10 +1168,6 @@ static int smu_v13_0_6_thermal_get_temperature(struc=
t smu_context *smu,
                 ret =3D smu_v13_0_6_get_smu_metrics_data(
                         smu, METRICS_TEMPERATURE_HOTSPOT, value);
                 break;
-       case AMDGPU_PP_SENSOR_EDGE_TEMP:
-               ret =3D smu_v13_0_6_get_smu_metrics_data(
-                       smu, METRICS_TEMPERATURE_EDGE, value);
-               break;
         case AMDGPU_PP_SENSOR_MEM_TEMP:
                 ret =3D smu_v13_0_6_get_smu_metrics_data(
                         smu, METRICS_TEMPERATURE_MEM, value);
@@ -1244,7 +1204,6 @@ static int smu_v13_0_6_read_sensor(struct smu_context=
 *smu,
                 *size =3D 4;
                 break;
         case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-       case AMDGPU_PP_SENSOR_EDGE_TEMP:
         case AMDGPU_PP_SENSOR_MEM_TEMP:
                 ret =3D smu_v13_0_6_thermal_get_temperature(smu, sensor,
                                                           (uint32_t *)data=
);
@@ -2048,8 +2007,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_fun=
cs =3D {
         /* dpm/clk tables */
         .set_default_dpm_table =3D smu_v13_0_6_set_default_dpm_table,
         .populate_umd_state_clk =3D smu_v13_0_6_populate_umd_state_clk,
-       .get_thermal_temperature_range =3D
-               smu_v13_0_6_get_thermal_temperature_range,
         .print_clk_levels =3D smu_v13_0_6_print_clk_levels,
         .force_clk_levels =3D smu_v13_0_6_force_clk_levels,
         .read_sensor =3D smu_v13_0_6_read_sensor,
--
2.25.1


--_000_PH7PR12MB59973C30A448D7C02A26D08E82B59PH7PR12MB5997namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
we'd better to add other patches to avoid create HWMON node file &quot;temp=
_inputX&quot; when smu doesn't support sensor type of&nbsp;<span style=3D"f=
ont-family:&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, =
-apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans=
-serif;font-size:14.6667px;background-color:rgb(255, 255, 255);display:inli=
ne !important" class=3D"ContentPasted0">AMDGPU_PP_SENSOR_EDGE_TEMP.</span><=
/div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"font-family:&quot;Segoe UI Web (West European)&quot;, &quot;=
Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica =
Neue&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255, 255, 2=
55);display:inline !important" class=3D"ContentPasted0"><br>
</span></div>
<div style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" c=
lass=3D"elementToProof">
<font face=3D"Segoe UI Web (West European), Segoe UI, -apple-system, BlinkM=
acSystemFont, Roboto, Helvetica Neue, sans-serif"><span style=3D"font-size:=
 14.6667px;">Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</span></=
font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"font-family:&quot;Segoe UI Web (West European)&quot;, &quot;=
Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica =
Neue&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255, 255, 2=
55);display:inline !important" class=3D"ContentPasted0"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"font-family:&quot;Segoe UI Web (West European)&quot;, &quot;=
Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica =
Neue&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255, 255, 2=
55);display:inline !important" class=3D"ContentPasted0">Best Regards,</span=
></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"font-family:&quot;Segoe UI Web (West European)&quot;, &quot;=
Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica =
Neue&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255, 255, 2=
55);display:inline !important" class=3D"ContentPasted0">Kevin</span></div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lijo Lazar &lt;lijo.lazar@amd=
.com&gt;<br>
<b>Sent:</b> Thursday, March 9, 2023 5:51 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Remove unavailable temperature params</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Temperature limits are not available for SMU v13.0=
.6. Also, edge<br>
temperature is not tracked. Remove logic associated with those.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c&nbsp; | 43 -------------=
------<br>
&nbsp;1 file changed, 43 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
index 862859bfb9e1..54d36df1306f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
@@ -82,12 +82,6 @@<br>
&nbsp;<br>
&nbsp;#define smnPCIE_ESM_CTRL 0x111003D0<br>
&nbsp;<br>
-static const struct smu_temperature_range smu_v13_0_6_thermal_policy[] =3D=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { -273150, 99000, 99000, -273150, 990=
00, 99000, -273150, 99000, 99000 },<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 120000, 120000, 120000, 120000, 120=
000, 120000, 120000, 120000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 120000 },<br>
-};<br>
-<br>
&nbsp;static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_=
MSG_MAX_COUNT] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TestMessage,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_T=
estMessage,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSmuVersion,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetSmuVersi=
on,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
@@ -701,9 +695,6 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_=
context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_AVERAGE_SOCKE=
TPOWER:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;SocketPower) &l=
t;&lt; 8;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_TEMPERATURE_EDGE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *value =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_TEMPERATURE_H=
OTSPOT:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *value =3D SMUQ10_TO_UINT(metrics-&gt;MaxSocketTemper=
ature);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -1127,33 +1118,6 @@ static int smu_v13_0_6_force_clk_levels(struct smu_c=
ontext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int<br>
-smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct smu_temperature_range *range)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t software_shutdown_temp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t hotspotlimit;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t memlimit;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: Find a way to get temperatur=
e limits */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(range, &amp;smu_v13_0_6_therma=
l_policy[0],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(struct smu_temperature_range));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_crit_max =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hotspotlimit * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_emergency_max =3D (=
hotspotlimit + CTF_OFFSET_HOTSPOT) *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=
MU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_crit_max =3D memlimit *=
 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_emergency_max =3D (meml=
imit + CTF_OFFSET_MEM) *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TEMPERATURE_UNITS_PER=
_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;software_shutdown_temp =3D =
software_shutdown_temp;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int smu_v13_0_6_get_current_activity_percent(struct smu_contex=
t *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; enum amd_pp_sensors sensor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t *value)<br>
@@ -1204,10 +1168,6 @@ static int smu_v13_0_6_thermal_get_temperature(struc=
t smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_6_get_smu_metrics_data(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu, =
METRICS_TEMPERATURE_HOTSPOT, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_EDGE_TEMP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v13_0_6_get_smu_metrics_data(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu, METRICS_TEM=
PERATURE_EDGE, value);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_MEM_=
TEMP:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_6_get_smu_metrics_data(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu, =
METRICS_TEMPERATURE_MEM, value);<br>
@@ -1244,7 +1204,6 @@ static int smu_v13_0_6_read_sensor(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *size =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_HOTS=
POT_TEMP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_EDGE_TEMP:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_MEM_=
TEMP:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_6_thermal_get_temperature(smu, sens=
or,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t *)data);<br>
@@ -2048,8 +2007,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* dpm/clk tables */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D=
 smu_v13_0_6_set_default_dpm_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .populate_umd_state_clk =
=3D smu_v13_0_6_populate_umd_state_clk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_thermal_temperature_range =3D<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_6_get_thermal_temperature_range,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clk_levels =3D smu_=
v13_0_6_print_clk_levels,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clk_levels =3D smu_=
v13_0_6_force_clk_levels,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D smu_v13_0=
_6_read_sensor,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB59973C30A448D7C02A26D08E82B59PH7PR12MB5997namp_--
