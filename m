Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED93C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 06:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11A7710E459;
	Wed, 26 Oct 2022 06:51:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A6610E459
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 06:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOZ2wmkBHKH26Fj3Fv+1SDkhPBIAA6GVkYd2zpf9rHeXNgma3bIHLHiHQpVkVr/x0QTeRM9Cv9MOFspGWi9oRFw6Oa+HgrTL42up+cc88r4hK7NR4YeOlRi9zOjNJTMd9AUTLIrLg2rgcsFA8wrGIGPSdkSumgIu4kaELbb1baKvMQosHYTZmihqrSsVUISMhPfE+kUf1WMnNUBxSFV861kuB6p1Yhc5n8UHXVG4+DM7g80Aqfnz9qN2ZARllTGkF2YCLWHXT2oWkeY85U9Xr88A8pK47qkPzgQi5J2KN39LjgBVztlFLo9dSuT6i39cnzGPF0eA+bxcy9f96Z8TqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+TtsAy3sDgc8c7K7fudY7dpRqarJ0cMc5QMUgM2sQ0=;
 b=dNbnbfwNlksZu4hx45S197dZIYRtqVc4YcNxI4E+7tlwgN/raKrhwTXs01kJAczSO8CxP3aEb3ZVjYdRX9XRKAQUSDEaMjQNjpMy4IR3xiPvNyU6I07DycLtq/iYEZM37laPnkWLGgW/OWNT3p6YbgcYei8/rLn6URBBRZtSDfybcQAovO0rA4cF98TD16BnvBytC1N2bNU7qV4dlslszabRZ1ec4PPww4KAR/YUxMgLgLTUqyCtFSJj8dX51p99uhrzrfkI73c+9SAwadGpJs0L/KSuQ041c/BVGfkWSoTUZt/tVbVHgS8MEC6u2YWukovAejZApCXdrej1Ik3oAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+TtsAy3sDgc8c7K7fudY7dpRqarJ0cMc5QMUgM2sQ0=;
 b=sdj6tgbC+WVaO/9pd8Q0pCUDHZ7+zQbHhSvRUC53ybYNjJeCTSuoTJQDABjP/GuzfDny9ChESdqOI9Aci93J4IWvHcknWMh2IqURkbDYFhojE/UqvLFhzTcP0ekXexNkR9dhUKg4DLi2jQyT636+J0tGAY9dYDzLmdDwuYpFs+4=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 26 Oct
 2022 06:51:23 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::d5cd:85d1:dfaf:7841]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::d5cd:85d1:dfaf:7841%6]) with mapi id 15.20.5723.033; Wed, 26 Oct 2022
 06:51:23 +0000
From: "Song, Asher" <Asher.Song@amd.com>
To: Yury Zhuravlev <stalkerg@gmail.com>, "Meng, Xiaohu" <Xiaohu.Meng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for
 vega10 properly"
Thread-Topic: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm
 for vega10 properly"
Thread-Index: AQHY34OXdPRUpS5WbUm+C9DJEVs2ja4f9i+AgAAnmzA=
Date: Wed, 26 Oct 2022 06:51:23 +0000
Message-ID: <DM4PR12MB513603C468CE9BA8DC933D118B309@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20221014041456.139813-1-Asher.Song@amd.com>
 <CANiD2e8PHA7u1qs8YkWkbbjxqB7JCnLNdR5OcHTH=dpfBWe7rg@mail.gmail.com>
In-Reply-To: <CANiD2e8PHA7u1qs8YkWkbbjxqB7JCnLNdR5OcHTH=dpfBWe7rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Xiaohu.Meng@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-26T06:51:20Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f452574f-b9df-431d-bc1f-e105c349f585;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5136:EE_|MW6PR12MB7086:EE_
x-ms-office365-filtering-correlation-id: d67ff647-3e87-4052-c9ef-08dab71e7ef6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wP4gycyPaDGsBMSaZfkAwgWGwMImkjopzF6x5DIQouux6Ir6D8AxF21YtVEzyaljpw/vEzUE0oxgrztNJcAds+ts3ayIgaK9TKKnh1YbQYQOFbflDcbIhmlCFZwvwHj3lQfXatTeY3P/Woy4yoyjzsXor03ZP5gxlZ6ADTh22gIqK82gFrRdkOG0U5T/d3Dif0TCDfDxi2fpBqWb6oa0cyQZw6dwMY8Cf7Hhv79QFXQK1PNHIM5r1my9uINAnFzhu51LbccPdCa5T/8QjpDF8SwCbNMFdtAgIllLEPWg21PhJG+Zn2cXHmYllz2Au+qYekAzPblwhXr/sfO5EMGTotlxvHQuxUgdlNRAY/g9wgPvoK2fuetQ2m6p+GLU+fP0J4zDJ+C5bjrI8tGldItxMP7OH1SfQ4Fp5vAL/f2PkTy0XFkLd7K4xbFw2pPF+eg5dhsyBz9anTw3h4Wsmmi5jVBTjN0c55rD3UDU+rlikCthekr2mapLi7RyrP+zARzulfEJlmhS6c0Jq63xNuOZTeEUrPO03G9hcSdKsvm/wStSIq93kDrtQxa5T44nzUHdoT5ydZsfUmYnPllZBsew0r+Xhl+sDCxL/Rcm9gAnSDmO7Wob6iX3FQ57guhIH3H8Qv26hfmBiA/XxCH5zIjE0et2De6FJ8wbPvoZPRVJj+lxVpIhN784VfH79IVnWItib3SzbKhy846sJUI7NkxGPqYsqecR7vlgdO6nCKo0/xFgFHsdAd3rOXWS7+Us1s8CU/TEXryaz6IR48LqE8NYDw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(2906002)(186003)(83380400001)(55016003)(86362001)(33656002)(8676002)(6506007)(7696005)(41300700001)(9686003)(53546011)(66476007)(66446008)(64756008)(4326008)(26005)(66556008)(38070700005)(316002)(110136005)(38100700002)(122000001)(76116006)(71200400001)(8936002)(54906003)(52536014)(478600001)(6636002)(66946007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R1TnrVC5NP1fSelCqVSNoPHJEQwrukxoioxGOJytQVahOWUQPmShWfIfdkc7?=
 =?us-ascii?Q?OsvMea77IJVCkV2ChsUjRaRzywR22SZjJYmF70bjKfW9B5H/so59CmMxj99T?=
 =?us-ascii?Q?TB/y9djnqIQ80p1EASv++rZfVDGnWaoVyp+F0CesvUpoyUfZVAYN3YIuKXnm?=
 =?us-ascii?Q?zHu8Le8NRWJoB3sEw3lU2kGnN0Q3Z9U51i5++N43eFwY7xEPL5wrmhbT6RgE?=
 =?us-ascii?Q?Xtuz8ZurUvKJE3QDqYBK6sXJf8LKmr9ZK8viJ/NbSbUVi0Blt+bQjaY9yjua?=
 =?us-ascii?Q?5OubuSvBpmfqNiIcl/XEtMGEvzh2cjhD+AxJqmQqFiaxVUbWvt2YWCX4DRll?=
 =?us-ascii?Q?UZ8Y4RLNiHEis1hU1P8dHegn+oHq5quRv8u3Ggi0LXwuTvxkSZOTbCnktSA4?=
 =?us-ascii?Q?emclRCH7+XDdGB3FmYvj73PEioxKKVLvCJELmKV5iqRwZv3JBtAifz+BAI/S?=
 =?us-ascii?Q?oQUGwAJiR73/D4ZjlQkrS62tlFMCpZLDUf0F46Z+lPNKA08jjlVfQTAdLzrD?=
 =?us-ascii?Q?Hb9cnwF5azsTU9FrtEb+m57a+rhb2i4xif8LfnU7Bh7w78zp4Wnlt9VoO95G?=
 =?us-ascii?Q?6+JkUi14X0IV3+5twNdkVYlxj3cPQ1KEvYJ71M6ytKZWIlJT3d2TwGtOvcE4?=
 =?us-ascii?Q?URH/cbrCinrrukYXmmwteDsRRghSN3E73BdU4fzviUCY/NI1IgZJj798fE+6?=
 =?us-ascii?Q?cGCg9KFkQQiK+WvRqbZSwRDmvHzfj09L2PH6INUdDQoIAQN7DA+8YqLNSxjK?=
 =?us-ascii?Q?vPVadTqZ5xbOQnqWpMWQ173iK4EHE8WthOfeDRXGWuI6C68pObOgkT/gXde2?=
 =?us-ascii?Q?ME0Cw/3HRb4Zt68fcT07U46JXd5bDjznE4G5xUKi2+Sjt0MuM0guB6eJ6zJw?=
 =?us-ascii?Q?JD5EQoYgQ8GJJQiCTmHa6j6Ef2nEsy+NnTqYas8CjKYfsU3jr+MrNuEw/++v?=
 =?us-ascii?Q?52iUUU2oI2x+KCQkyLwmDnWszsbeeuED9J9L2sYkCA5Kp0W/DTA9FVKvjru1?=
 =?us-ascii?Q?NvIGxL7uj1YFHuBWYO4W7dwU0HVkPRhaT9ii8MbhVx+6LDC/E4guXf8eCUJO?=
 =?us-ascii?Q?C8v83H76CiGWXC4KWzYWxQZn7XZu8JpKtrKKwr5t4yJoCqtkKuqKahD/QjtC?=
 =?us-ascii?Q?obF8YlZU09pOvXhuUq2LT8Bf1UcA+hw27saxapGELv/wKnRc444vedGtUURJ?=
 =?us-ascii?Q?NrJ4nqal6xS+7m3DdUppyorSAYRovRaZ1lObsQeKBsuzwZw7TeATqu9/Fw+q?=
 =?us-ascii?Q?K0PNfik2kmsychQzdD3PTksZuPc/YVyRVogm/qUuv5PG54dtjQX1H0+tQI5H?=
 =?us-ascii?Q?t34wNL7uzOEwcvqYrCEu9cQU2qH6e02t6ICOTQFLQ/omqozFNZXh21cQSnAs?=
 =?us-ascii?Q?6rkN46K+GsCdzOY8CkjUUn14QWdD9HCV9hvcRQ8tMW17rFxyExyIrmrwoEJu?=
 =?us-ascii?Q?iAbVL1h1Rxl+odUTLaiLyE4h46MGIUr7N0zD7e3b3jCwalu2Z/PEt9IR66TK?=
 =?us-ascii?Q?dZcrsbrcCs3fJVp8AApRzB5pJvsJUgPV53lomZsj/BY1ZTFCMLwGKrdXN7BQ?=
 =?us-ascii?Q?O01pmJpBID/knk54ANeUf/1X66QFLE2FuPBUX4bh?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB513603C468CE9BA8DC933D118B309DM4PR12MB5136namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67ff647-3e87-4052-c9ef-08dab71e7ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 06:51:23.2726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6XkQTNclrc9mQaWiMLGPXFM2FbdOh7B06XhwP1H9IbCcdcg+JqNnwsZ8g7AE/QH1ZVSneAfsxesFT3bsIzD1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB513603C468CE9BA8DC933D118B309DM4PR12MB5136namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

+@Meng, Xiaohu<mailto:Xiaohu.Meng@amd.com>

Hi Zhuravlev,

The information of test card is as following:
Lspci name: [AMD/ATI] Vega 10 [Radeon Instinct MI25 MxGPU] (rev 05)
Firmware: ATOM BIOS: 113-D0531800-C04

When run test scripts compute-rocm-*/utils/run_rsmitst.sh, the below test c=
ases fail.
[  FAILED  ] 4 tests, listed below:
[  FAILED  ] rsmitstReadOnly.TestOverdriveRead
[  FAILED  ] rsmitstReadWrite.FanReadWrite
[  FAILED  ] rsmitstReadWrite.TestOverdriveReadWrite
[  FAILED  ] rsmitstReadWrite.TestPowerCapReadWrite

Best Regards,
Asher
From: Yury Zhuravlev <stalkerg@gmail.com>
Sent: Wednesday, October 26, 2022 9:31 AM
To: Song, Asher <Asher.Song@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm =
for vega10 properly"

Hello,
Can you write here your card name and firmware version? Without this patch,=
 my fan sensors are broken, and it's sensitive to my pc case with water coo=
ling.
My card is:  Sapphire Pulse Radeon RX Vega 56  vd6546 SA
lspci name: [AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] (rev c3)
Firmware: ATOM BIOS: 113-376XL-UO2
This patch is 100% working correct on my machine, and I tested it last 2 mo=
nths.
Regards,

On Fri, Oct 14, 2022 at 1:15 PM Asher Song <Asher.Song@amd.com<mailto:Asher=
.Song@amd.com>> wrote:
This reverts commit fe01cb24b81c0091d7e5668874d51ce913e44a97.

Unfortunately, that commit causes fan monitors can't be read and written
properly.

Signed-off-by: Asher Song <Asher.Song@amd.com<mailto:Asher.Song@amd.com>>
---
 .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 190af79f3236..dad3e3741a4e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -67,21 +67,22 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr =
*hwmgr,
 int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
                uint32_t *speed)
 {
-       struct amdgpu_device *adev =3D hwmgr->adev;
-       uint32_t duty100, duty;
-       uint64_t tmp64;
+       uint32_t current_rpm;
+       uint32_t percent =3D 0;

-       duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
-                               CG_FDO_CTRL1, FMAX_DUTY100);
-       duty =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
-                               CG_THERMAL_STATUS, FDO_PWM_DUTY);
+       if (hwmgr->thermal_controller.fanInfo.bNoFan)
+               return 0;

-       if (!duty100)
-               return -EINVAL;
+       if (vega10_get_current_rpm(hwmgr, &current_rpm))
+               return -1;
+
+       if (hwmgr->thermal_controller.
+                       advanceFanControlParameters.usMaxFanRPM !=3D 0)
+               percent =3D current_rpm * 255 /
+                       hwmgr->thermal_controller.
+                       advanceFanControlParameters.usMaxFanRPM;

-       tmp64 =3D (uint64_t)duty * 255;
-       do_div(tmp64, duty100);
-       *speed =3D MIN((uint32_t)tmp64, 255);
+       *speed =3D MIN(percent, 255);

        return 0;
 }
--
2.25.1

--_000_DM4PR12MB513603C468CE9BA8DC933D118B309DM4PR12MB5136namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+<a id=3D"OWAAM2C3FD9A9EF544EB3A89BBBB72AF67D08" hre=
f=3D"mailto:Xiaohu.Meng@amd.com"><span style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;text-decoration:none">@Meng, Xiaohu</span></a><o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Zhuravlev,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The information of test card is as following:<o:p></=
o:p></p>
<p class=3D"MsoNormal">Lspci name: [AMD/ATI] Vega 10 [Radeon Instinct MI25 =
MxGPU] (rev 05)<o:p></o:p></p>
<p class=3D"MsoNormal">Firmware: ATOM BIOS: 113-D0531800-C04<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When run test scripts compute-rocm-*/utils/run_rsmit=
st.sh, the below test cases fail.
<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; FAILED&nbsp; ] 4 tests, listed below:<o:p></=
o:p></p>
<p class=3D"MsoNormal">[&nbsp; FAILED&nbsp; ] rsmitstReadOnly.TestOverdrive=
Read<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; FAILED&nbsp; ] rsmitstReadWrite.FanReadWrite=
<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; FAILED&nbsp; ] rsmitstReadWrite.TestOverdriv=
eReadWrite<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; FAILED&nbsp; ] rsmitstReadWrite.TestPowerCap=
ReadWrite<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Asher<o:p></o:p></p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Yury Zhuravlev &lt;stalkerg@gmail.com&g=
t; <br>
<b>Sent:</b> Wednesday, October 26, 2022 9:31 AM<br>
<b>To:</b> Song, Asher &lt;Asher.Song@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; amd-g=
fx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Revert &quot;drm/amdgpu: getting fa=
n speed pwm for vega10 properly&quot;<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Hello,<br>
Can you write here your card name and firmware version? Without this patch,=
 my fan sensors are broken, and it's sensitive to my pc case with water coo=
ling.<br>
My card is: &nbsp;Sapphire Pulse Radeon RX Vega 56 &nbsp;vd6546 SA<br>
lspci name: [AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] (rev c3)<br>
Firmware: ATOM BIOS: 113-376XL-UO2<br>
This patch is 100% working correct on my machine, and I tested it last 2 mo=
nths.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">On Fri, Oct 14, 2022 at 1:15 PM Asher Song &lt;<a hr=
ef=3D"mailto:Asher.Song@amd.com">Asher.Song@amd.com</a>&gt; wrote:<o:p></o:=
p></p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">This reverts commit f=
e01cb24b81c0091d7e5668874d51ce913e44a97.<br>
<br>
Unfortunately, that commit causes fan monitors can't be read and written<br=
>
properly.<br>
<br>
Signed-off-by: Asher Song &lt;<a href=3D"mailto:Asher.Song@amd.com" target=
=3D"_blank">Asher.Song@amd.com</a>&gt;<br>
---<br>
&nbsp;.../amd/pm/powerplay/hwmgr/vega10_thermal.c&nbsp; &nbsp;| 25 ++++++++=
++---------<br>
&nbsp;1 file changed, 13 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
index 190af79f3236..dad3e3741a4e 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
@@ -67,21 +67,22 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr =
*hwmgr,<br>
&nbsp;int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; uint32_t *speed)<br=
>
&nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;struct amdgpu_device *adev =3D hwmgr-&gt;adev;<=
br>
-&nbsp; &nbsp; &nbsp; &nbsp;uint32_t duty100, duty;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;uint64_t tmp64;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint32_t current_rpm;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;uint32_t percent =3D 0;<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, =
mmCG_FDO_CTRL1),<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;CG_FDO_CTRL1, FMAX_DUTY100);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;duty =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmC=
G_THERMAL_STATUS),<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;CG_THERMAL_STATUS, FDO_PWM_DUTY);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (hwmgr-&gt;thermal_controller.fanInfo.bNoFan=
)<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (!duty100)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EINVAL;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (vega10_get_current_rpm(hwmgr, &amp;current_=
rpm))<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -1;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (hwmgr-&gt;thermal_controller.<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;advanceFanControlParameters.usMaxFanRPM !=3D 0)<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;percent =3D current=
_rpm * 255 /<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;hwmgr-&gt;thermal_controller.<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;advanceFanControlParameters.usMaxFanRPM;<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;tmp64 =3D (uint64_t)duty * 255;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;do_div(tmp64, duty100);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;*speed =3D MIN((uint32_t)tmp64, 255);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;*speed =3D MIN(percent, 255);<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.25.1<o:p></o:p></p>
</blockquote>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB513603C468CE9BA8DC933D118B309DM4PR12MB5136namp_--
