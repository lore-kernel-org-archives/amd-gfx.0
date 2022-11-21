Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDA3C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 02:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2883610E115;
	Mon, 21 Nov 2022 02:29:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F1410E115
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 02:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay54bf+K+8L7h8rrXDZbZh5QYgVa8OvvpsvvViSqWV8KHYZi3KI4JjMyqhU8Cdj3xNNw4SRuWXvGgT7Osbfz5NNzSfLu5EBL8hst4Litetlkxiy6mrFwrYpxx9zIz4KO9ENVHgr+fy2Ps0AhhxpqeCFKTY3YWwt+u7GYOshgjVczoZL9U8hOGarKk4MflqcUqOaWnOOHwL2LWs2SIm5qoj8boMZbkR9XnJmoCTuyCHpd5DotT1cAdF1UoW2nzX7HzEmRtOhhcRGohfvP9c6z+l+tfWK+AYBzehT+PybXjsFCZFbrbDWdzM29fyjOg+DvLZ6oZqtJpcxBw/iBSPfIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFbVudoRqbnYx9jpfnZfKPB3PS1kxYS7KowGzfpO4Sc=;
 b=CszJlty6sxIzG9JK7GtNdUDOV72umCFFnqQYd0teNl46eUoLyEfhBboczjh0b/fkkUt72S4pogCm+yCWry3bgB1Y+tYBmlYTTTsmn03+jLL0jcLWMU/BYLbKCjZoPSXyY/OL02f8SwMcMp4b2NNiWD0yCFiRZAS7TO1n5/Rd0KYUWEWg3bI/2tzz5buv5LLzDwQ3r2pDSjek0e9bUrm8oMKCkavyORhp4AEBaVWC6j3kjpsKuo4jqOOO5wS0teGRgQFSnaV0nuMWturnE4Ma6uLYr22MEH3JKt8cKqS/ShwT+yK7zPjWKHyNTu5mmOOKv6++qYCy7ljn9pUff8vKVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFbVudoRqbnYx9jpfnZfKPB3PS1kxYS7KowGzfpO4Sc=;
 b=LVFJstFplhDXXpBVvI5u/gPNIk6fqW3kf+aKTrPUiRRPeVIq5mzaXREAFm64MPatbu9SbuMKOGolMddkDQcK2qiik8wX/9cMfOxvd41vUMvegSxwUW/WodUtSm2sbLXoyUubjb9nxLjlVLfcyyfCUKLJafx5UProNqWaOMP0POc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.9; Mon, 21 Nov 2022 02:28:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a%3]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 02:28:59 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Li, Lyndon" <Lyndon.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: update driver if header for smu_13_0_7
Thread-Topic: [PATCH 1/2] drm/amd/pm: update driver if header for smu_13_0_7
Thread-Index: AQHY/Uqt4QZRFvGBuESn2Bbo3Mfm/65Iptfg
Date: Mon, 21 Nov 2022 02:28:59 +0000
Message-ID: <DM6PR12MB2619C4CEA4ECD5A4D0DE8A60E40A9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221121014253.2101022-1-Lyndon.Li@amd.com>
In-Reply-To: <20221121014253.2101022-1-Lyndon.Li@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-21T02:28:56Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c13b5f64-e641-4394-8a3e-2152451049a8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DS7PR12MB6141:EE_
x-ms-office365-filtering-correlation-id: 8fef8534-8777-4b6a-9870-08dacb6825bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHXe/Xcwfh5x+R5puFFakSSMVHR4bK+gB7cA2UNHNRhO45Wo0lbtUvfOd3mYqGJrU82WnWGVZ/+c+KRJeVs3EybR6kAVSjZMZRU3rJp16uiJ8TKFoIGuX8ePmC0rc1+2itrGvrrEVJ65Gitx9PtSRtNvrf51sBsiq0C8W0iZ1gfEVr9PuyeZFeH3UZlsWNC3DLzosWRa4v5TKRel5uxKqscq3MIOEveHNQIjA0xyLi3EgOO2vDl3Ae2trEo3Nfga91dQ+PVRjwImokJbCMdQ09QOzGO64jqaCJmxUeN/YcosnoRRIbwxzSPwwjG1gMzOJamMoI3uDD1XPpTXwLrhfJdPOLpL6DKvOMjxK6et/Mxlt6RnU89un6K3YWaD1M/eh2tnP06FwG2ilm4QNH30vW6zD5mVanpYdJhPxyx1b6W2GpFXhIv2UI4WEJvFQdvn1otTCrHSYhcdZj2MzGxilR9WhYnoxnjMQv81tEWydRYPJQxy/+INuIuShRD5+xMNl8n/2jzUtLSljLOrCWES+1tdQAzsr5DtXtaoEqExe1kZZgjyr0ZlIGcLXG8fN7Lr/9WxHDSKrIGrlfUihkorr0O8c3lwP2lDctmm16akEjZ4qSapFt0FPBz59RY7l9WDB3GwrYtBtK0Fdeg57ywx0TKlxV+Sr/bztUiUuFR4Vq14M/E9K87NRYiyBqdceeVFZl2WAJlRfLbBRj6u3i9mAQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(2906002)(55016003)(86362001)(76116006)(66556008)(66446008)(66476007)(66946007)(41300700001)(33656002)(122000001)(6506007)(38100700002)(53546011)(54906003)(4326008)(83380400001)(38070700005)(7696005)(110136005)(8936002)(5660300002)(186003)(64756008)(71200400001)(8676002)(15650500001)(19627235002)(316002)(26005)(9686003)(478600001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yIgSyzxWL6J2rPFQkjkkn9hLGmvlk7A/uHVJ+xlyRQYxA7kPRp9xKz9ONCHR?=
 =?us-ascii?Q?JKa801UXGJeXBprWyJJbY875X0tl6yQyBjfP+zqzX8szhs3+OIXlsgrvt3si?=
 =?us-ascii?Q?7CTRSF8Hw5uHNcjqhEfSSGI3Xm5/DfZqVglUfmp+JlzQlxchJYP3gIFFKa+E?=
 =?us-ascii?Q?WNFVsCGrlrg7PHwKpYcinyY+14wZMAZdjuw1liPs8Mms3pap17xf/h5KXEdh?=
 =?us-ascii?Q?oqPWuzcThNhVhwgu18oT2kqbBPWu0GCCDFMbNot+odgAZIN+uFNm5qsoyiG8?=
 =?us-ascii?Q?FAizsz/QyV5LQpTwiOh8r0WPPUUnJdo04WcmGOQ0SnXh7nsU8uLQ9z4do3+d?=
 =?us-ascii?Q?Gh2/NwtDu/HS412Fn7LiZeQGlw3VIkneEuOZcllywbTAI/Q9c6FZKwYqFGh0?=
 =?us-ascii?Q?r/dmVHS4LBXN4LcWMDFG0FBr3+Ecp1HY2ZQvAQAIJs3vWT6rjfBv5ixRrC6N?=
 =?us-ascii?Q?pbzGLd6RY25A5Dd67AuE/nVQ+H+oe9IjrpigQnwZDlBgA6ZDlMZtXz183vEH?=
 =?us-ascii?Q?Iefu+5BsQtS4jocPFYRXTc9gzUJP1ncOComVUdt7xL4eKnuspH7yY1QIv319?=
 =?us-ascii?Q?kFDJIkDsEoEInVNIicPaq1b5jxxVfbLY3crXjPNxjStH/2EFpVQc2UuH2oZ2?=
 =?us-ascii?Q?CIXYQ97+4aLdiosRALlTb5AAWsMoH3Nf9VMijeqVKykiO6aiYWjmqacOmTnz?=
 =?us-ascii?Q?eljR4Jly9O7AK1MYm2WA44ZM+zz+SoUNlWgQlEHeHeVMbWTXGWZ92FJn+kdu?=
 =?us-ascii?Q?b9/mG8o9wZNPRSVUqEOy5/3N6y0VQv7kbSGEctb34kWVINUNHUPPQvz1IwWZ?=
 =?us-ascii?Q?E2ogvLuDwEjHLGOYld9jrxvVaek0/U3E4JCM3TkUY3iRHickGePtyU3B1yVw?=
 =?us-ascii?Q?Cz6NkXipiV+PZeSWAztOJYW08ErL+Rl5JXi/LADmmGX5zKw4bybCwH4SSAPT?=
 =?us-ascii?Q?6dw8VFAssR5d5URXjNVZOi/HfBVzRO8metNdcmZKvg/qDRJj+wOnFpQbgv9I?=
 =?us-ascii?Q?gJxJUNiKln+byFYjiC4TzdYBWCz3YhnhMUIwOEV20nmiNVzYOJj6XRRsO/hQ?=
 =?us-ascii?Q?EKpLZXgtcVRWEuRhY6X75GL5B6scGQOI421Vt1zqHqNMMrYYxQFYI3vOu1yz?=
 =?us-ascii?Q?NgmNv3gb6l5s6ZbXRIdoEj/DuBUy6u8fKZsT1J7+Gn2XzKYVbc4dLtQBUrg1?=
 =?us-ascii?Q?KI1EOiATG0VM8CGJq9ENB0YxUElFoL6l3KFrECHoA2uMPP1YQbPA3c296vEf?=
 =?us-ascii?Q?+HOgt0KogPKLAqh33Q9Ic9x+pyjLf2kxtOn/nc4knpVbpohPKUATAx5cmUON?=
 =?us-ascii?Q?zLAOCd0iQN/GXde71ibE40bFqye+P4aXVv90VtmkAVIk3Z09D5uP9z2EcN7d?=
 =?us-ascii?Q?SYEaSuZesrtxUnIgH/Sx7FQxODSofR0PvX2R1oQAdBfE00JYGgf+xFTMQSIJ?=
 =?us-ascii?Q?AAWzEPHrkVHOObkZT2hDe32RE90L335J+sKPtSRGSRc1mgwP6vYSH3N75Cff?=
 =?us-ascii?Q?zjJoPkxP6uW00cvM/IlLEApycQwGFkJeNpBN9vTGlHtojxi0EQ0hbuhDHh//?=
 =?us-ascii?Q?mbUA7vpA9z5x3U4TVSU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fef8534-8777-4b6a-9870-08dacb6825bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 02:28:59.5810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjbzues1Qlzm27ranaCH9HDWAwtgaTllUR8x2x7lGUoZXWigRpqi0wfrjb6Ohm1y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>,
 "enneth.feng@amd.com" <enneth.feng@amd.com>, "Li, Lyndon" <Lyndon.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: lyndonli <Lyndon.Li@amd.com>
> Sent: Monday, November 21, 2022 9:43 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: enneth.feng@amd.com; Xu, Feifei <Feifei.Xu@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
> Subject: [PATCH 1/2] drm/amd/pm: update driver if header for smu_13_0_7
>=20
> update driver if header for smu_13_0_7
>=20
> Signed-off-by: lyndonli <Lyndon.Li@amd.com>
> ---
>  .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     | 117 ++++++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   2 +-
>  2 files changed, 81 insertions(+), 38 deletions(-)
>=20
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7
> .h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7
> .h
> index 25c08f963f49..efb270cee1e0 100644
> ---
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7
> .h
> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7
> .h
> @@ -25,10 +25,10 @@
>=20
>  // *** IMPORTANT ***
>  // PMFW TEAM: Always increment the interface version on any change to
> this file
> -#define SMU13_DRIVER_IF_VERSION  0x2C
> +#define SMU13_DRIVER_IF_VERSION  0x35
>=20
>  //Increment this version if SkuTable_t or BoardTable_t change
> -#define PPTABLE_VERSION 0x20
> +#define PPTABLE_VERSION 0x27
>=20
>  #define NUM_GFXCLK_DPM_LEVELS    16
>  #define NUM_SOCCLK_DPM_LEVELS    8
> @@ -96,7 +96,7 @@
>  #define FEATURE_MEM_TEMP_READ_BIT             47
>  #define FEATURE_ATHUB_MMHUB_PG_BIT            48
>  #define FEATURE_SOC_PCC_BIT                   49
> -#define FEATURE_SPARE_50_BIT                  50
> +#define FEATURE_EDC_PWRBRK_BIT                50
>  #define FEATURE_SPARE_51_BIT                  51
>  #define FEATURE_SPARE_52_BIT                  52
>  #define FEATURE_SPARE_53_BIT                  53
> @@ -282,15 +282,15 @@ typedef enum {
>  } I2cControllerPort_e;
>=20
>  typedef enum {
> -  I2C_CONTROLLER_NAME_VR_GFX =3D 0,
> -  I2C_CONTROLLER_NAME_VR_SOC,
> -  I2C_CONTROLLER_NAME_VR_VMEMP,
> -  I2C_CONTROLLER_NAME_VR_VDDIO,
> -  I2C_CONTROLLER_NAME_LIQUID0,
> -  I2C_CONTROLLER_NAME_LIQUID1,
> -  I2C_CONTROLLER_NAME_PLX,
> -  I2C_CONTROLLER_NAME_OTHER,
> -  I2C_CONTROLLER_NAME_COUNT,
> +	I2C_CONTROLLER_NAME_VR_GFX =3D 0,
> +	I2C_CONTROLLER_NAME_VR_SOC,
> +	I2C_CONTROLLER_NAME_VR_VMEMP,
> +	I2C_CONTROLLER_NAME_VR_VDDIO,
> +	I2C_CONTROLLER_NAME_LIQUID0,
> +	I2C_CONTROLLER_NAME_LIQUID1,
> +	I2C_CONTROLLER_NAME_PLX,
> +	I2C_CONTROLLER_NAME_FAN_INTAKE,
> +	I2C_CONTROLLER_NAME_COUNT,
>  } I2cControllerName_e;
>=20
>  typedef enum {
> @@ -302,6 +302,7 @@ typedef enum {
>    I2C_CONTROLLER_THROTTLER_LIQUID0,
>    I2C_CONTROLLER_THROTTLER_LIQUID1,
>    I2C_CONTROLLER_THROTTLER_PLX,
> +  I2C_CONTROLLER_THROTTLER_FAN_INTAKE,
>    I2C_CONTROLLER_THROTTLER_INA3221,
>    I2C_CONTROLLER_THROTTLER_COUNT,
>  } I2cControllerThrottler_e;
> @@ -309,8 +310,9 @@ typedef enum {
>  typedef enum {
>    I2C_CONTROLLER_PROTOCOL_VR_XPDE132G5,
>    I2C_CONTROLLER_PROTOCOL_VR_IR35217,
> -  I2C_CONTROLLER_PROTOCOL_TMP_TMP102A,
> +  I2C_CONTROLLER_PROTOCOL_TMP_MAX31875,
>    I2C_CONTROLLER_PROTOCOL_INA3221,
> +  I2C_CONTROLLER_PROTOCOL_TMP_MAX6604,
>    I2C_CONTROLLER_PROTOCOL_COUNT,
>  } I2cControllerProtocol_e;
>=20
> @@ -690,6 +692,9 @@ typedef struct {
>  #define PP_OD_FEATURE_UCLK_BIT      8
>  #define PP_OD_FEATURE_ZERO_FAN_BIT      9
>  #define PP_OD_FEATURE_TEMPERATURE_BIT 10
> +#define PP_OD_FEATURE_POWER_FEATURE_CTRL_BIT 11
> +#define PP_OD_FEATURE_ASIC_TDC_BIT 12
> +#define PP_OD_FEATURE_COUNT 13
>=20
>  typedef enum {
>    PP_OD_POWER_FEATURE_ALWAYS_ENABLED,
> @@ -697,6 +702,11 @@ typedef enum {
>    PP_OD_POWER_FEATURE_ALWAYS_DISABLED,
>  } PP_OD_POWER_FEATURE_e;
>=20
> +typedef enum {
> +  FAN_MODE_AUTO =3D 0,
> +  FAN_MODE_MANUAL_LINEAR,
> +} FanMode_e;
> +
>  typedef struct {
>    uint32_t FeatureCtrlMask;
>=20
> @@ -708,8 +718,8 @@ typedef struct {
>    uint8_t                RuntimePwrSavingFeaturesCtrl;
>=20
>    //Frequency changes
> -  int16_t               GfxclkFmin;           // MHz
> -  int16_t               GfxclkFmax;           // MHz
> +  int16_t                GfxclkFmin;           // MHz
> +  int16_t                GfxclkFmax;           // MHz
>    uint16_t               UclkFmin;             // MHz
>    uint16_t               UclkFmax;             // MHz
>=20
> @@ -730,7 +740,12 @@ typedef struct {
>    uint8_t                MaxOpTemp;
>    uint8_t                Padding[4];
>=20
> -  uint32_t               Spare[12];
> +  uint16_t               GfxVoltageFullCtrlMode;
> +  uint16_t               GfxclkFullCtrlMode;
> +  uint16_t               UclkFullCtrlMode;
> +  int16_t                AsicTdc;
> +
> +  uint32_t               Spare[10];
>    uint32_t               MmHubPadding[8]; // SMU internal use. Adding he=
re
> instead of external as a workaround
>  } OverDriveTable_t;
>=20
> @@ -748,8 +763,8 @@ typedef struct {
>    uint8_t                IdlePwrSavingFeaturesCtrl;
>    uint8_t                RuntimePwrSavingFeaturesCtrl;
>=20
> -  uint16_t               GfxclkFmin;           // MHz
> -  uint16_t               GfxclkFmax;           // MHz
> +  int16_t                GfxclkFmin;           // MHz
> +  int16_t                GfxclkFmax;           // MHz
>    uint16_t               UclkFmin;             // MHz
>    uint16_t               UclkFmax;             // MHz
>=20
> @@ -769,7 +784,12 @@ typedef struct {
>    uint8_t                MaxOpTemp;
>    uint8_t                Padding[4];
>=20
> -  uint32_t               Spare[12];
> +  uint16_t               GfxVoltageFullCtrlMode;
> +  uint16_t               GfxclkFullCtrlMode;
> +  uint16_t               UclkFullCtrlMode;
> +  int16_t                AsicTdc;
> +
> +  uint32_t               Spare[10];
>=20
>  } OverDriveLimits_t;
>=20
> @@ -903,7 +923,8 @@ typedef struct {
>    uint16_t  FanStartTempMin;
>    uint16_t  FanStartTempMax;
>=20
> -  uint32_t Spare[12];
> +  uint16_t  PowerMinPpt0[POWER_SOURCE_COUNT];
> +  uint32_t  Spare[11];
>=20
>  } MsgLimits_t;
>=20
> @@ -1086,11 +1107,13 @@ typedef struct {
>    uint32_t        GfxoffSpare[15];
>=20
>    // GFX GPO
> -  float           DfllBtcMasterScalerM;
> +  uint32_t        DfllBtcMasterScalerM;
>    int32_t         DfllBtcMasterScalerB;
> -  float           DfllBtcSlaveScalerM;
> +  uint32_t        DfllBtcSlaveScalerM;
>    int32_t         DfllBtcSlaveScalerB;
> -  uint32_t        GfxGpoSpare[12];
> +  uint32_t        DfllPccAsWaitCtrl; //GDFLL_AS_WAIT_CTRL_PCC register v=
alue
> to be passed to RLC msg
> +  uint32_t        DfllPccAsStepCtrl; //GDFLL_AS_STEP_CTRL_PCC register v=
alue
> to be passed to RLC msg
> +  uint32_t        GfxGpoSpare[10];
>=20
>    // GFX DCS
>=20
> @@ -1106,7 +1129,10 @@ typedef struct {
>    uint16_t        DcsTimeout;           //This is the amount of time SMU=
 FW waits
> for RLC to put GFX into GFXOFF before reverting to the fallback mechanism
> of throttling GFXCLK to Fmin.
>=20
>=20
> -  uint32_t        DcsSpare[16];
> +  uint32_t        DcsSpare[14];
> +
> +  // UCLK section
> +  uint16_t     ShadowFreqTableUclk[NUM_UCLK_DPM_LEVELS];     // In MHz
>=20
>    // UCLK section
>    uint8_t      UseStrobeModeOptimizations; //Set to indicate that FW sho=
uld
> use strobe mode optimizations
> @@ -1163,13 +1189,14 @@ typedef struct {
>    uint16_t IntakeTempHighIntakeAcousticLimit;
>    uint16_t IntakeTempAcouticLimitReleaseRate;
>=20
> -  uint16_t FanStalledTempLimitOffset;
> +  int16_t FanAbnormalTempLimitOffset;
>    uint16_t FanStalledTriggerRpm;
> -  uint16_t FanAbnormalTriggerRpm;
> -  uint16_t FanPadding;
> -
> -  uint32_t     FanSpare[14];
> +  uint16_t FanAbnormalTriggerRpmCoeff;
> +  uint16_t FanAbnormalDetectionEnable;
>=20
> +  uint8_t      FanIntakeSensorSupport;
> +  uint8_t      FanIntakePadding[3];
> +  uint32_t     FanSpare[13];
>    // SECTION: VDD_GFX AVFS
>=20
>    uint8_t      OverrideGfxAvfsFuses;
> @@ -1238,8 +1265,22 @@ typedef struct {
>    // SECTION: Advanced Options
>    uint32_t          DebugOverrides;
>=20
> +  // Section: Total Board Power idle vs active coefficients
> +  uint8_t     TotalBoardPowerSupport;
> +  uint8_t     TotalBoardPowerPadding[3];
> +
> +  int16_t     TotalIdleBoardPowerM;
> +  int16_t     TotalIdleBoardPowerB;
> +  int16_t     TotalBoardPowerM;
> +  int16_t     TotalBoardPowerB;
> +
> +  //PMFW-11158
[Quan, Evan] Please drop this internal link reference.=20
Other than that, the series is Reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
> +  QuadraticInt_t qFeffCoeffGameClock[POWER_SOURCE_COUNT];
> +  QuadraticInt_t qFeffCoeffBaseClock[POWER_SOURCE_COUNT];
> +  QuadraticInt_t qFeffCoeffBoostClock[POWER_SOURCE_COUNT];
> +
>    // SECTION: Sku Reserved
> -  uint32_t         Spare[64];
> +  uint32_t         Spare[43];
>=20
>    // Padding for MMHUB - do not modify this
>    uint32_t     MmHubPadding[8];
> @@ -1304,7 +1345,8 @@ typedef struct {
>    // SECTION: Clock Spread Spectrum
>=20
>    // UCLK Spread Spectrum
> -  uint16_t     UclkSpreadPadding;
> +  uint8_t      UclkTrainingModeSpreadPercent; // Q4.4
> +  uint8_t      UclkSpreadPadding;
>    uint16_t     UclkSpreadFreq;      // kHz
>=20
>    // UCLK Spread Spectrum
> @@ -1317,11 +1359,7 @@ typedef struct {
>=20
>    // Section: Memory Config
>    uint8_t      DramWidth; // Width of interface to the channel for each =
DRAM
> module. See DRAM_BIT_WIDTH_TYPE_e
> -  uint8_t      PaddingMem1[3];
> -
> -  // Section: Total Board Power
> -  uint16_t     TotalBoardPower;     //Only needed for TCP Estimated case=
,
> where TCP =3D TGP+Total Board Power
> -  uint16_t     BoardPowerPadding;
> +  uint8_t      PaddingMem1[7];
>=20
>    // SECTION: UMC feature flags
>    uint8_t      HsrEnabled;
> @@ -1423,8 +1461,11 @@ typedef struct {
>    uint16_t Vcn1ActivityPercentage  ;
>=20
>    uint32_t EnergyAccumulator;
> -  uint16_t AverageSocketPower    ;
> +  uint16_t AverageSocketPower;
> +  uint16_t AverageTotalBoardPower;
> +
>    uint16_t AvgTemperature[TEMP_COUNT];
> +  uint16_t AvgTemperatureFanIntake;
>=20
>    uint8_t  PcieRate               ;
>    uint8_t  PcieWidth              ;
> @@ -1592,5 +1633,7 @@ typedef struct {
>  #define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
>  #define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
>  #define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
> +#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
> +#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
>=20
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index b7f4569aff2a..865d6358918d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -31,7 +31,7 @@
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32
> -#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2C
> +#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x35
>  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_10 0x1D
>=20
>  #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
> --
> 2.25.1
