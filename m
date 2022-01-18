Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8DCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 02:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D98A1128B0;
	Tue, 18 Jan 2022 02:14:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA0E71128AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 02:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKhZrUnX3AdVvt6KAHG6V+KzgsAa+sIMMf9NyYSJSDUpSU1OAH5rzwu8CKu9ktjno7jpUZ9Px8ZudgaJRXmLby/xU5eRF6XBicRe+65zRtcwIzW57kmeppTR6+wLDGmbZI0uYJ80vzqGECM5AVPMF7UWfWi9gqrFYpYpghUGE56gPk/bnViYyiQhPX3HAYtFjI1TS1mR9jGHA71fCzBPqIgSEMUUAI8XyEzvvCjBn1Yv+Fs7Fefp/+5EZqALgGKGPdSV8nGi6EVEJJ9W4y6byL/IfvXizy0fQSQOrtiLCLzAFkoy3+mhDL5YJVD3zSINMOVnwht0frZ3PnZGDBfqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5j2WK08gbJdNAhOL0RKiR3JmztnDv1sFzzTpWt0Sesc=;
 b=HuXQ4RWiYkCyXNV7kNs1dUWbHoVotN6HoFq8Uxq49oZ7KrEBsz0e1B1HXButZ+VdoaSu9uV2W/zlLYE2FYSuq1WZwUrxhvh+5KF7SQxXQf1istpYiW/ZDktBHPG8FFLyibdWqkOYLhIWYNcfHVrSBKoy/97bfBbsSdLdz+CI/nSivo9WegqBX+qRXBbm/Yi97O0c1gEsHht+fyii1NeUutBTOLsFOk3rPj5tc8yTJPDPYE8Y99S86Fct/acXHsiQbEAB76LzzC9ul7ndT88X9QHsxjYIzpWPMMWzi420izIlL5vpgIFP3c+5K5pLKIw6J9Cx7fok/kRBxq8Fwj7WqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j2WK08gbJdNAhOL0RKiR3JmztnDv1sFzzTpWt0Sesc=;
 b=tuNwXcUa0aFZGuqYh9UQMJvtLJvK4KNY2q9tAJr2ahusjJR0WHAcO+7tG/DMsWhI8BYmBExuWhqb4mO18ga6qu9NRVbGDCr0HW+SDxiuHeSkLwO5Dq8/LBxIgwEGBPZutIZmwUZ578y902JGLe717uOakmZanpSS7mQH4jgmgD0=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by SA0PR12MB4589.namprd12.prod.outlook.com (2603:10b6:806:92::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 18 Jan
 2022 02:14:02 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 02:14:02 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Nikolic, Marina" <Marina.Nikolic@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Enable sysfs required by rocm-smi tool for
 One VF mode
Thread-Topic: [PATCH] drm/amd/pm: Enable sysfs required by rocm-smi tool for
 One VF mode
Thread-Index: AQHYC75l5r5BdVVkxk2FMHIKObuz36xoCnyA
Date: Tue, 18 Jan 2022 02:14:02 +0000
Message-ID: <CO6PR12MB5473AF4CF5C4E860D79DCC7482589@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220117162153.30906-1-Marina.Nikolic@amd.com>
In-Reply-To: <20220117162153.30906-1-Marina.Nikolic@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-18T02:14:01.782Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f94d7db5-660d-416c-60f0-08d9da283258
x-ms-traffictypediagnostic: SA0PR12MB4589:EE_
x-microsoft-antispam-prvs: <SA0PR12MB458977B8945DD2FE218D96CB82589@SA0PR12MB4589.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LGOzDCh6gFPcd2GQCf2x39ZCpkKYl9FZPPZCO1nyNUknlw4ILE6CodK1bi+xI6XntOPMEq39uDc+fgnwIxkrH8R8TGUG5s4q+0tNQjlPo9xxky+LakI+I/qtkp+iyW3nO1ydMws51y9AyU3Wwkg62GoljFMiWr15MJd4YGc+uDoOH0pqpksRYqM3pgsnRy+WRWDOcNcZIYkVPuPex9GUIICkBlTeJPSgdCu0QlO37ba/Va96JfRTCNKsxojF9rCRmrWgkrQAZPwW5I81kdspuRWys9MxiTRRZoCJ6T8jX+gyVq4QgZCbqsAPoL5bx/kKjY/pH6hd2CqQQg2Ab3hyzPy3YHyMR2Js6jh8pLcUmarPBh9Hv+Zxht1h4jPvG9uj3RNajujmqO2aNZR5AlPO7QrQYSzoij56yLPRpLn/A0HPhjkwOKA8sUUjkydWxQwvxXNe8MUFe3juNBbhdzFgKyKqGxkipmQE2vbRtqWk9LNVRAZ6a5a0RpRLTr3fxWWlbVkrY8jPSvRCeLsSkvac8nSNz0/7/lle0Cka9FV9OIdMWOePv/GGWqPLjMLo8ueXrqefGq1AdJ0jrqxmHGWCvrbDq36RPCcHLEpC1d6FbLEHUKTVW57/CxSx6xMLBGr+FeU1F3kZVdW1OuEx+TXl6UOdExllon7RF9vWv3jzRUxwmeBs1mvLxWxaAYXGGKCCDhaYX3r9iL6tuEq3dnxV1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(7696005)(54906003)(76116006)(66946007)(66476007)(91956017)(66446008)(53546011)(186003)(316002)(8936002)(64756008)(6506007)(508600001)(83380400001)(122000001)(38070700005)(19627405001)(4326008)(8676002)(26005)(9686003)(38100700002)(86362001)(5660300002)(2906002)(71200400001)(110136005)(33656002)(52536014)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?86fWUUef8hlxkhvnb6mLbLzghjnC70/B4gMgHX/dZR5Lbvq+z3cfMroYGE?=
 =?iso-8859-1?Q?NUR8x13UYWdnSEPtIM0V57lj2a7I0x91rV3Fwv8GHpfIAV3DLgKEGGZwdj?=
 =?iso-8859-1?Q?JjCcRqA+7Ox10El5UAPe25hrUSc4KFg5HHYc/RPCDY0E4DFW+YsIgxj02T?=
 =?iso-8859-1?Q?8d8IvfExpeHSdSVJKdbpqIBspJNPA3eGSgOvk+t7KMUPIjXb7wI4rglD51?=
 =?iso-8859-1?Q?SV6hLyrvkMXbz3KPn8JmTuANsRkbZT1bghcv5dtXI3K7VWim448qzHRgSm?=
 =?iso-8859-1?Q?6g3PfFPYzwbIc9nac10cuhF87jTnMxURQYARyzbQVODvWJrWVgRptvtMx8?=
 =?iso-8859-1?Q?ncrqAx8nuA6cR9vpRyYEmHSqmJrDgmd/TrtPDfdmpOgcWM3EVFXXej/Mkg?=
 =?iso-8859-1?Q?Ejkgd4vZ+XfK5eEFlw7dUOdB0tg7wT2aNdfa1/SKeGeggNDtHpnYrBB1py?=
 =?iso-8859-1?Q?bE2vG3IygA45g7q1kRO/uhjbECSjQatbyqpLOCFhLvgpf66ga2WSi4KdEA?=
 =?iso-8859-1?Q?3vANbwhggMa+FAfVuEPf5OiNrYzsx8nkGW6dtGkGTtSAoYL98u+wWgblMU?=
 =?iso-8859-1?Q?ND6cYJx7xjb0xAujpEw3xqDsUTMt9RZ6dE2yM7dB1+qS+IZs5uFpyolyKw?=
 =?iso-8859-1?Q?35rwolhSkSDWRx/WzidLaBTsb1eoMKbilJmyF8RgYM2SaI6DqaoBO6Wrmo?=
 =?iso-8859-1?Q?vFKxKpOWi9FE/qQNzNZF7lScTsK38N+Y12zLL7jOuxjZ4wot/mmkgPJIop?=
 =?iso-8859-1?Q?CZKYiW8ldQHTEiwsUI4JK10p+QXLKvuYjpYbH8WlR9s380ancqFsNvcsLB?=
 =?iso-8859-1?Q?8dt4VX3bEot8NJ88nu6PwIVmx3GiAdURhq90kZ8YkRxjBpFIDcX0lz9ROH?=
 =?iso-8859-1?Q?1bGCk1mv/+YIWq3Ym+zx2gn8siVZMFU3w3RX3T/rShOjdsISzHENRA1Idj?=
 =?iso-8859-1?Q?AK8NPe3Aw+x0/IMWfBrPubX6J5EhHPF5VY4X+4VUC5f9D4LbynHBXTghX2?=
 =?iso-8859-1?Q?/nk6cXdG4NvcPSvPW1UALXJ84q2lHslTAyhgBwV69cDp/1apwU+RV04en9?=
 =?iso-8859-1?Q?VrfaPPLELLyI04AvhfBkaJJikD2gMm5UcMUfSw+M3PPjTseUiE0dAKeKbJ?=
 =?iso-8859-1?Q?LcxFqqfvcj2kiB+9tVfTKBGouAF9MfW3XqsgmSEgQViP81HE7OAL5nlinI?=
 =?iso-8859-1?Q?H0DnP59UcrS+j8hCTwsDEDQNgTzn7uzMRur5taFylu4LLX2md+m1NeA9jR?=
 =?iso-8859-1?Q?IN8RzFkac+5t2uRMBhxgXVka2lO0vMBZNtmaWT1Cs+Zpd+tcKtF+PLmMur?=
 =?iso-8859-1?Q?w/kElVeCUc3uyE87ZaZmecZiRr+FQAdhLdAKKTLcrW7wrX8sG5JX/cqUKn?=
 =?iso-8859-1?Q?AzPPh/Q6oZTSMb8AMO+pHCxJ+KI/pKnv1XmuVCK0N/oySI2VWAQPg+I7GH?=
 =?iso-8859-1?Q?AcNNfa6JcNrTCxYaj/AWN+aVMZhCpj/0QvsBDsWFiOFD4ZNNYgi8bVZB7P?=
 =?iso-8859-1?Q?AAC70/6z5WZecCnC4S+Gfi8G0SEk1M+XuDFfVgYf2vq55B6L0QNOphOwzO?=
 =?iso-8859-1?Q?ngSyPon2mldYrRBEVUlOGshYh/Ij7TeVORiliboKIIXqMAIAV+qvrBQiRM?=
 =?iso-8859-1?Q?3yBmUIcUULU2U=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473AF4CF5C4E860D79DCC7482589CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94d7db5-660d-416c-60f0-08d9da283258
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 02:14:02.6585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/Z7kGkAD0lbEAV4sI7oSDwqL30RUWL09sV1Miwnq7XrE5T7LYg0R2JWCY65w9TG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4589
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
 Nikola" <Nikola.Veljkovic@amd.com>, "Kitchen, Greg" <Greg.Kitchen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB5473AF4CF5C4E860D79DCC7482589CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Kevin Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Marina N=
ikolic <Marina.Nikolic@amd.com>
Sent: Tuesday, January 18, 2022 12:21 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com>; Veljkovic, Nikola <Nikola.Vel=
jkovic@amd.com>; Nikolic, Marina <Marina.Nikolic@amd.com>; Kitchen, Greg <G=
reg.Kitchen@amd.com>
Subject: [PATCH] drm/amd/pm: Enable sysfs required by rocm-smi tool for One=
 VF mode

Enable power level, power limit and fan speed
information retrieval in one VF mode.
This is required so that tool ROCM-SMI
can provide this information to users.
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c              | 17 ++---------------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |  2 +-
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 1b03ad7a21ad..bb7d03cd814c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1903,8 +1903,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {
         AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,                              AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,                              AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,                              AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,                           ATT=
R_FLAG_BASIC),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,                              ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,                           ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,                               AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,                               AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,                    AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -3152,19 +3152,6 @@ static umode_t hwmon_attributes_visible(struct kobje=
ct *kobj,
         if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
                 return 0;

-       /* there is no fan under pp one vf mode */
-       if (amdgpu_sriov_is_pp_one_vf(adev) &&
-           (attr =3D=3D &sensor_dev_attr_pwm1.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_pwm1_max.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_pwm1_min.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_fan1_input.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_fan1_min.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_fan1_max.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_fan1_target.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_fan1_enable.dev_attr.attr))
-               return 0;
-
         /* Skip fan attributes if fan is not present */
         if (adev->pm.no_fan && (attr =3D=3D &sensor_dev_attr_pwm1.dev_attr=
.attr ||
             attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 4e37cd8025ed..7ea0427f65d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -134,7 +134,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_messa=
ge_map[SMU_MSG_MAX_COUNT]
         MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnl=
oad,         1),
         MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,    =
             0),
         MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff, =
             0),
-       MSG_MAP(GetPptLimit,                    PPSMC_MSG_GetPptLimit,     =
            0),
+       MSG_MAP(GetPptLimit,                    PPSMC_MSG_GetPptLimit,     =
            1),
         MSG_MAP(GetDcModeMaxDpmFreq,            PPSMC_MSG_GetDcModeMaxDpmF=
req,         1),
         MSG_MAP(ExitBaco,                       PPSMC_MSG_ExitBaco,       =
             0),
         MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,     =
             0),
--
2.20.1


--_000_CO6PR12MB5473AF4CF5C4E860D79DCC7482589CO6PR12MB5473namp_
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
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Marina Nikolic &lt;Marina.Nik=
olic@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 18, 2022 12:21 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Mitrovic, Milan &lt;Milan.Mitrovic@amd.com&gt;; Veljkovic, Nikol=
a &lt;Nikola.Veljkovic@amd.com&gt;; Nikolic, Marina &lt;Marina.Nikolic@amd.=
com&gt;; Kitchen, Greg &lt;Greg.Kitchen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Enable sysfs required by rocm-smi tool =
for One VF mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Enable power level, power limit and fan speed<br>
information retrieval in one VF mode.<br>
This is required so that tool ROCM-SMI<br>
can provide this information to users.<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 17 ++---------------<br>
&nbsp;.../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |&nbsp; 2 +-<br>
&nbsp;2 files changed, 3 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 1b03ad7a21ad..bb7d03cd814c 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -1903,8 +1903,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_d=
pm_fclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_d=
pm_vclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_d=
pm_dclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ATTR_FLAG_BASIC),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_s=
clk_od,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_m=
clk_od,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_p=
ower_profile_mode,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|A=
TTR_FLAG_ONEVF),<br>
@@ -3152,19 +3152,6 @@ static umode_t hwmon_attributes_visible(struct kobje=
ct *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
&amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* there is no fan under pp one vf mo=
de */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_is_pp_one_vf(adev) &=
amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (attr =3D=3D =
&amp;sensor_dev_attr_pwm1.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_pwm1_enable.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_pwm1_max.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_pwm1_min.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_fan1_input.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_fan1_min.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_fan1_max.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_fan1_target.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_fan1_enable.dev_attr.attr))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Skip fan attributes if =
fan is not present */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.no_fan &am=
p;&amp; (attr =3D=3D &amp;sensor_dev_attr_pwm1.dev_attr.attr ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at=
tr =3D=3D &amp;sensor_dev_attr_pwm1_enable.dev_attr.attr ||<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index 4e37cd8025ed..7ea0427f65d3 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -134,7 +134,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_messa=
ge_map[SMU_MSG_MAX_COUNT]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PrepareMp1ForUnloa=
d,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_=
MSG_PrepareMp1ForUnload,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1)=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(AllowGfxOff,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_AllowGfxOff,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DisallowGfxOff,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; PPSMC_MSG_DisallowGfxOff,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetPptLimit,&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetPptLimit,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetPptLimit,&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetPptLimit,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetDcModeMaxDpmFre=
q,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_=
MSG_GetDcModeMaxDpmFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1)=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ExitBaco,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_ExitBaco,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerUpVcn,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PowerUpVcn,&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0),<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473AF4CF5C4E860D79DCC7482589CO6PR12MB5473namp_--
