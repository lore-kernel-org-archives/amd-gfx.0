Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B595C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 01:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5732310E33A;
	Tue, 18 Jan 2022 01:43:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5272E10E33A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 01:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhFg7xO3REumJEvbFvVmkqPjHTnoEscFq7ukHnv7rK9TOYExXvK7uVoWNtu4Uhx8j4105X5GfLyRfDStRaxOG2319LiLsTS18nwLZBZvp/DXQh1XmYTeJUX6ejy2flm4uQse/e5KJPt2c+ulVEiPzzZFbNfYmSTMGj2CuxhPgrse99zBRMUIa7Q1AIhkNwa5dJKIfZQgvUXMKdGp7Dqjlx+V9qYqDjdIMG9TNYx1JEKyngeDZ7beQsFHTx5crmJ0A9TLtc3B6iiOgxroJ6miBP/3RqxEoW3R6rWz79X5A6k8FugJlE4xCGwPCVMUBZlW30hzzKrVgowaNzC+2H7pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PGvDpSLcdrU5Y0XFPbzYhtmjspXj6g/WK/xRHC4hBc=;
 b=Obpx8XtMA2o1w0TKwIw2wXHJc9tMp+W8Tv8VaGQ+vaBObPtQSlfWo4Vp03z95S1EQy4H3tIPGHwzRSe8lHPQIpVab4tOX7J+RVW3tcTMxdRLq7ov6W8KzyiB7yxoNTitb5t8Ckge8XKUodmEjkwnU21RNKuJCdt6QH9EZiTP4ubLG4wxpY6rCZ1AfQ29TYvECK8YCDqon2mqHUxPP3Dg3OtZVhJAdPofYUq4biuLLP8+aYJQcCPCpMv8y0JJrryljDZJQZWitc5UlmxTqipBD5s/r5YOA8Xcgn1CiTG7goZW3cOQe2EVjLZOYGENI3ZWHPuFzeWNval9rUDRA/v6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PGvDpSLcdrU5Y0XFPbzYhtmjspXj6g/WK/xRHC4hBc=;
 b=iyYWOFEWCAG54rZDJlcD0xSCCmJV/VwwYuXyemUA2O915limT9laPxYENvd/itTB8sp9Yze1RGQI6Pn8pWawEPlB8aSNOIgQLpZVO5dDtEkTjKoXFGwaWPD8NErVZlzRUKehzGwODKp1e/pPXqmXAP2Vp9h0UKJHlvucXbSkSwM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BYAPR12MB3477.namprd12.prod.outlook.com (2603:10b6:a03:ac::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Tue, 18 Jan 2022 01:43:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 01:43:16 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Nikolic, Marina" <Marina.Nikolic@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Enable sysfs required by rocm-smi tool for
 One VF mode
Thread-Topic: [PATCH] drm/amd/pm: Enable sysfs required by rocm-smi tool for
 One VF mode
Thread-Index: AQHYC75lyqV9CZaiiEyuOF3W+ELo76xoAehQ
Date: Tue, 18 Jan 2022 01:43:16 +0000
Message-ID: <DM6PR12MB261967BFC8AB1CB35ED052C6E4589@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220117162153.30906-1-Marina.Nikolic@amd.com>
In-Reply-To: <20220117162153.30906-1-Marina.Nikolic@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-18T01:43:13Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2182eb60-c2ac-4f04-8e03-f2fbc1991526;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dd4f13a-8c4b-4758-0653-08d9da23e5d6
x-ms-traffictypediagnostic: BYAPR12MB3477:EE_
x-microsoft-antispam-prvs: <BYAPR12MB347780BAAACC75FC09E9A9FEE4589@BYAPR12MB3477.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWXsNB8bj5oIFc0M42lMOSoSkxMRenwlbbq5ACHLbq3qLbLu/Lwbsw3QY9gBKeFfzKCM2X4Ckco5q9UR7mfxd9GkVZaTcbs0Hd9sKbYxfX1TffaSoZ0ifkywUpyhk68NgUK0oPiYFJ18MQYpsh4UjvSAnmLqi45TLMmob8sc5AVe1arPB5fFu/VP94LeRgOjdEriG228QBwqGTocznKswhXCePNPF5hnGUEhslsrdVypRfGRV3dqYXeSe101L6eRdJoJ2QWzoL59BnKZKTR/Cjp/qqJG/ohi1zXD0LK+8ljsQIKzz5sv5aeeRq9mUXVxYxIa45dYWWmoTfBlR8PDJFYFIohpCOtiyYCywD3HZyvIzZwqwbbUl/l/9EgwoPcP7tV9oN/wQy8I8etwX48o5LOIpcTQbX4uerR+MBkC+fpDTAkoPavl24eaxwT0j17BStJX08ibKupnbLB3fhRAoP25O3jLjnpHlNIcHkfkTEszERbf96Fsq1AqziFeQZxszFMJbnPfBzNXBgL27mnEd4jI2aPcrizSR4fI4yUulbqsrjcYa0X1TURgAuCjIfoxbY6OgX5ONl+GJVaWtL9HNg3j5khf5Rn3FTu+iu5pvTLvWVDXLpOiQcwiKVHtDFINA13VQA6aKQGVViNiishg2VeOjKsLu61lC3xkFbVlkUfuQIYtWEqZW5sjRclfV4iKhuMs7NxZ44owOk6OrNQ4Kg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(71200400001)(8676002)(38100700002)(6506007)(8936002)(53546011)(83380400001)(26005)(64756008)(66556008)(66446008)(66476007)(110136005)(52536014)(7696005)(2906002)(86362001)(5660300002)(76116006)(508600001)(4326008)(66946007)(55016003)(33656002)(38070700005)(186003)(54906003)(316002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GMkVSZ8KvdsVuHDi7Av2L421d/J9FL8xd5rAyRDi3YphJz4vYyqTYVyQBemd?=
 =?us-ascii?Q?gf2flv1L3M8VyAdodw41TqJkBf3pFwPq2/Qd+0y1O4oFXp1a29TnUISnaPKU?=
 =?us-ascii?Q?salkIFk+XkoZjago1mZq0rwuMOCMZgtJAI8iA/OyyNr2F/vtk5ql3Rn0J5p5?=
 =?us-ascii?Q?T3X3qqTvP2ywzSRJ1jeZi5LKpigZ9KRqN2CYAhbxjimrtUo5XPs+c9r3Lajd?=
 =?us-ascii?Q?NCtOpmZbO+rGZ4DLMhMpgMpxvRLcgKxWf/OJYUIUPLiIT+gNr7KFDZiU1LmX?=
 =?us-ascii?Q?Grz0EbbdcEj+Fc/KOCYKSzPIihSHHwPzbkbJ3Uihfvxl5IHPSGBdR0at1ODt?=
 =?us-ascii?Q?5mCC7RTMG8W/rd1Cc1ixNSF6fdZtVMyOhnWNGHSGax0FHqXrr9Jk01DjSI+Z?=
 =?us-ascii?Q?xj67v2os0Q42qsKOsOtcstwimKlWrROPCxqGGe/oQSb5dxb/V1QHxfTdIca1?=
 =?us-ascii?Q?QmFEQ7H/iiPS5OJo4Cszv+ZDv2aBgt2VmvGvoua7cqbKRcI1Ld3m0ukGO9g8?=
 =?us-ascii?Q?XHMs3odpKMTD6KKN29+xn4dHnpNBs05zl+0APksc1Pb7Gzsb+PvnhXGAAz4X?=
 =?us-ascii?Q?J7mZhZYA06tsvDQy8ho3GfBNwO4zDBAOCDGTMzeHoZIUTKJrFC0dG/9gGpX2?=
 =?us-ascii?Q?Qk/dMB3VBsJdwRu3wfymdNY0minXlnLpjYDTStziUyyyHzaOKkdAqavmNgLy?=
 =?us-ascii?Q?P1YY2mzfp41opocTCArbTZ5UUziG87kcusAibh9jU3cJ6b+KMbRxBP49Eq4e?=
 =?us-ascii?Q?jBAyQdCSz1Zr2O1UBdcbVEttHoDy244AxLYP6S283iLXcUZjpgMeYtdk0wdC?=
 =?us-ascii?Q?7qSyTm4wuWjYE5WLhrN2Od83r3wOD3tl5IIYoA6L45NHS1GmNpfml+rsyC2x?=
 =?us-ascii?Q?1AVL59VAPxMVLNr1ooehh/3R/JKRFeM+Gu0yy4OCV+VG7ZO9Rf9WoS+NdvPb?=
 =?us-ascii?Q?nAKk48JlOdDy5e1NMQKOoInYGB8zhPFuGklgdm2fIj+BcnbvOobER+Zjxa2g?=
 =?us-ascii?Q?H4G5ZbzWj83cHztgNfdqqoJv+tiy1ACCxmS507ShFZ/OGshN663dGjcj20yf?=
 =?us-ascii?Q?qxd08aEF04ByidUc6pgDcNRXeTFhctVw5p9njT/lZb2mae7TEC/mRJkpbwWJ?=
 =?us-ascii?Q?biuc8rcudgFnm+hYnCYJZaxwmhQWdSBLM4RCiHGDI0Op00MLlNvRQQG6Fxwc?=
 =?us-ascii?Q?fHaLZX7NBTi1aQYslAxf4Ho4JtgDPlBAQ9WxoNwrLdBp1TYv1cdZXM4MnkwM?=
 =?us-ascii?Q?VsbHuzDDF7Ir3J9w8+yWWA5TwfrSoYZvkkU5ot+g5/7cp0pa4aRBkB0Dqb/H?=
 =?us-ascii?Q?y9uhsssPlh9Qsvfx96ud0pZRrI/cTRR+RpAPDUzVR3Ge7osTrEfbUICMAtss?=
 =?us-ascii?Q?+r9Lmqom16NLn3GN3/zijhGYSokdymH7WrOPg3KN57Mt9fwkHuifPJLXEuiI?=
 =?us-ascii?Q?Jj+9EhmQ4sIhRW3LuNk9iHmo7J4/3DtxVJDsaJX3IFammOXGkG8xD1vRW/jt?=
 =?us-ascii?Q?x7jED0Gi30iQuIaNES32ga/xTA+LgwPQeG5X/5Id5JKifIjMElpT5PfZ68G8?=
 =?us-ascii?Q?8dOmjKBKoktKrkkAzn0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd4f13a-8c4b-4758-0653-08d9da23e5d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 01:43:16.2324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLcwg1P5IFNA0qOa7u27jR3aTu2qBjjbQNrgDftHZQtk/gVDPOHPvLQXCbpDGOrG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3477
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
Cc: "Mitrovic, Milan" <Milan.Mitrovic@amd.com>, "Veljkovic,
 Nikola" <Nikola.Veljkovic@amd.com>, "Kitchen, Greg" <Greg.Kitchen@amd.com>,
 "Nikolic, Marina" <Marina.Nikolic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Marina Nikolic
> Sent: Tuesday, January 18, 2022 12:22 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Veljkovic, Nikola
> <Nikola.Veljkovic@amd.com>; Nikolic, Marina <Marina.Nikolic@amd.com>;
> Kitchen, Greg <Greg.Kitchen@amd.com>
> Subject: [PATCH] drm/amd/pm: Enable sysfs required by rocm-smi tool for
> One VF mode
>=20
> Enable power level, power limit and fan speed
> information retrieval in one VF mode.
> This is required so that tool ROCM-SMI
> can provide this information to users.
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c              | 17 ++---------------
>  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |  2 +-
>  2 files changed, 3 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 1b03ad7a21ad..bb7d03cd814c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1903,8 +1903,8 @@ static struct amdgpu_device_attr
> amdgpu_device_attrs[] =3D {
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,
> 		ATTR_FLAG_BASIC),
> -	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,
> 	ATTR_FLAG_BASIC),
> +	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,
> 		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,
> 	ATTR_FLAG_BASIC),
>  	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,
> 	ATTR_FLAG_BASIC),
>  	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,
> 		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> @@ -3152,19 +3152,6 @@ static umode_t hwmon_attributes_visible(struct
> kobject *kobj,
>  	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>  		return 0;
>=20
> -	/* there is no fan under pp one vf mode */
> -	if (amdgpu_sriov_is_pp_one_vf(adev) &&
> -	    (attr =3D=3D &sensor_dev_attr_pwm1.dev_attr.attr ||
> -	     attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
> -	     attr =3D=3D &sensor_dev_attr_pwm1_max.dev_attr.attr ||
> -	     attr =3D=3D &sensor_dev_attr_pwm1_min.dev_attr.attr ||
> -	     attr =3D=3D &sensor_dev_attr_fan1_input.dev_attr.attr ||
> -	     attr =3D=3D &sensor_dev_attr_fan1_min.dev_attr.attr ||
> -	     attr =3D=3D &sensor_dev_attr_fan1_max.dev_attr.attr ||
> -	     attr =3D=3D &sensor_dev_attr_fan1_target.dev_attr.attr ||
> -	     attr =3D=3D &sensor_dev_attr_fan1_enable.dev_attr.attr))
> -		return 0;
> -
>  	/* Skip fan attributes if fan is not present */
>  	if (adev->pm.no_fan && (attr =3D=3D
> &sensor_dev_attr_pwm1.dev_attr.attr ||
>  	    attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 4e37cd8025ed..7ea0427f65d3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -134,7 +134,7 @@ static struct cmn2asic_msg_mapping
> sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
>  	MSG_MAP(PrepareMp1ForUnload,
> 	PPSMC_MSG_PrepareMp1ForUnload,         1),
>  	MSG_MAP(AllowGfxOff,
> 	PPSMC_MSG_AllowGfxOff,                 0),
>  	MSG_MAP(DisallowGfxOff,
> 	PPSMC_MSG_DisallowGfxOff,              0),
> -	MSG_MAP(GetPptLimit,
> 	PPSMC_MSG_GetPptLimit,                 0),
> +	MSG_MAP(GetPptLimit,
> 	PPSMC_MSG_GetPptLimit,                 1),
>  	MSG_MAP(GetDcModeMaxDpmFreq,
> 	PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
>  	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,
> 0),
>  	MSG_MAP(PowerUpVcn,
> 	PPSMC_MSG_PowerUpVcn,                  0),
> --
> 2.20.1
