Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42C9CC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 07:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7485B112664;
	Fri, 16 Oct 2026 07:48:12 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC863112629
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 07:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQIxX0QVHUW/YCokFSQqbwK3Hc0i8oPHEl9WDsrnnGHCA93c/hwtuLZWpGeMRwgyjNiswJqGHXF9I1WFNyoErewSrjj8FTJeRlmlFFVJXlmSkAhL4m9rZCDIrtu75/hWNqJVQMnnFHC2T6Hv56kgrLzg9W2906Uxwz31Lq7rRM/BrURsP5RykYV8vb1JWdK+zyyJuOGcnF4gSX2/MQFcsroAsMH4RmzgVb8hkSlgR7OjgTeoNOfogVpbo3UN3RNoAOXwcz0dH3KM6OJPQ8oRe7tDNzyCLUIV7YIGP8+zkMlPXR5QFL2yF/wyTxzrO1ufz8P0tERhmDWZkUCxYjQ3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUzAmpBTFtXhCnVyBIO7rohinOq1PxraqsNwjmzVRuo=;
 b=W31MT+0YsING+goviWO88dJmhrTbIBgR8h045od2xZWkXm7hetLGmr8uLTOAOk8hCZZtfN/ex026kh6BDvH8WDHVLq+ldmFl9SntCUBKFML+4r73tUIMrXiZrc7FSz443/AmdV533vqCN7uDCUHPqNxGTbeN/3JAdF2sOljFTjPAmWhWA76rjPlNafxNASrxlQJejRCpwQKuUxIyWr6E47+VCAtNyScr8XVmxjwZ0/hzY+BsGvpaSQfYTukchgSO36uPjFr2Cz61I5dQbbWOcR3UhmIIkfGNoihaU12VEiYBODssTvHuARBOl0WWbRyZTn6YJIS1HRIxjslNOjxk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUzAmpBTFtXhCnVyBIO7rohinOq1PxraqsNwjmzVRuo=;
 b=zXApsNCM3PVkVADfsvyed+U7ww8CslM36OrXhhqmqpLftJkru+cxD4X93CBisnjbn13gMok6aX5+2hLgevrMx8nI2pVXoeXl78JrIws29vqOlIdvkjlnU43q6vMKLiXLqEKU3JOHBKuAcbNQr55NUNYX6SafBmUAT7PvIwVvOvk=
Received: from PHXPR12MB999255.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::12) by CH2PR12MB4120.namprd12.prod.outlook.com
 (2603:10b6:610:7b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:48:02 +0000
Received: from PHXPR12MB999255.namprd12.prod.outlook.com
 ([fe80::4045:7ee8:a423:d926]) by PHXPR12MB999255.namprd12.prod.outlook.com
 ([fe80::4045:7ee8:a423:d926%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 07:47:56 +0000
From: "Wang, Kevin" <Kevin.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm:restate all customized OD features on every
 table upload for smu 13.0.0/smu 14.0.2
Thread-Topic: [PATCH] drm/amd/pm:restate all customized OD features on every
 table upload for smu 13.0.0/smu 14.0.2
Thread-Index: AQHdXT9RoIQQY5L5xUWelvZ02gWp6bb/yivQ
Date: Fri, 16 Oct 2026 07:47:56 +0000
Message-ID: <PHXPR12MB99925553E42B83BFA3AF53F9BF939B2@PHXPR12MB999255.namprd12.prod.outlook.com>
References: <20261016072351.2479189-1-kenneth.feng@amd.com>
In-Reply-To: <20261016072351.2479189-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-16T07:45:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PHXPR12MB999255:EE_|CH2PR12MB4120:EE_
x-ms-office365-filtering-correlation-id: 98381785-7391-45f6-d43e-08df2b59cae4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: 1QQHCeC8KD8ia1upbYwboxC7NqGvaJIqpxp2YrRWjqiCMfNmh3nUYgVaQYwMgYQQdjoRtgxdnKO8oeTqirbuOS60S0qObiNW5PQqPVOZtuoar7uARpGrJd9KDhcmzpwdyxD2w7bOQVWy9szySzw24/O6ctMANDmtmLN0ye8StbIiqGEyHnF3lJf1vWg/faghXxlAXA5uwlySjUyhm31f95IXua7brY/uCN7EqQb8rC1EWBhJvaBiWcfATkFDiNF4h5Hnt84ZoBhavKTT8vEP6IeGWH66LR8sr985bk5SGRjMZbrqQ6ysUR+y+17KXR+Xz0aMsqH9tlCvsrh63nMp1ahYHn3I5dXB5LgM/BOpseOx+2L50po8T9T9xUKWoO1hh5PICPVElqqE8kLYsMpcdPsdyYAxP5f/AeVQ30R8RuiUqRGyZ59WVDTXKD3+WPNvBt5M5penoUy084gZnFdq7oAwbM030Cr8dfzDQ9/uRTU5NTnjjv2IpMKUyortlP1eP7+TmTS8XygLStSdG8H4rXk/dYNKEu206/kbGwFnrD3zuCmymf+xop50hMNum82Ljm1Ynf+KBFwZ9B5HDCtDenI3UXh8fTSsagVnrlL/wjj/YNAlWQ5+lqiwC+K38+bEXgy8mU5g4biBgtIEDOb5Ivj37DX1YMwPJaC1LVGTD2k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999255.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l1suJt4CEw18S6swZ9yOIpMx5bo3aCGv5XdZzeNOqmb0m7TxPQNoFLnNT3eX?=
 =?us-ascii?Q?bRRn/NTAPsQ0tFIaAFxF0VyujsUOEk918D50o7wNt6mjYHD9c/30PPmXqBOn?=
 =?us-ascii?Q?55mGEBcB9I4/xwAJANcLELYeHiByAtOd3pMkhDJPdYur9C3Ipqa6pjPMWmXW?=
 =?us-ascii?Q?Df/mui1qYwsodrOEKhFeYql8+Ynq/g4mkmHnvuJxc/Hxz6qUJHiE3CbB3/Mo?=
 =?us-ascii?Q?4gn3ZUjJQrxr+i+xS1wfeU7COMixGZlp39h7T9PFmLdrdDMcbCttu6OgDRsM?=
 =?us-ascii?Q?w7ofEK8vaYSJVekCicIRQdj8+T9ZYyIWYNc7+Aikb4L7oD6ku+lcFbvvQ/7t?=
 =?us-ascii?Q?YngrouXjZ3onP2Jpi/+cD+TgCadDNm4TDIxBbY2BXdhZdn0zaZlpy7aV+P88?=
 =?us-ascii?Q?GGBWI97HEujIvA9OIjnA7c6TwbXcVukInAMIpJPy5vxNmtSjCFW8zhWeLyLJ?=
 =?us-ascii?Q?X3XhS/o1ubYqnCfNljxCIwxUWEWkTa0nz4LFzMlgfiYSpSTGmMn5es9i91Kr?=
 =?us-ascii?Q?GFoeUHFkY8XfyZ+1WJsxxjd7cVHRAJQU4GKZNWYRQ6J6SSKPv8hplNYxXgZ1?=
 =?us-ascii?Q?3ZHR8GieuLc018Hr0gaMKgNspvOEcyNREtQjfm0YWwguxlRbx7QMhD/J0Dzt?=
 =?us-ascii?Q?JS7Q9At4GOm8DhvRzRAsEZt3xlnqnjXOa4luFpDoQZc8E9M0fcCehs+XawuB?=
 =?us-ascii?Q?VziB6IwCLDrR5PWnHkuxmzpyMLcY3eK+UatqdOIAt/ni2BSZXL1BGenNr5ZL?=
 =?us-ascii?Q?TM1kmDEa5JMBNm0bM02sgmJW4BrOuayVbzFLR0C6c/WBDakP/lB3yuKyv1p7?=
 =?us-ascii?Q?t8tPeplyfQrEZORWVsBuYAZZvZf3uZ24VhptcqlgUwuRyA2STBHt2cTrviBu?=
 =?us-ascii?Q?ZM1oY68TnZoxxR+M66oEQKGSb9I0BPBJWVOLrN2dNoFZ8J1294bKcuxf++zG?=
 =?us-ascii?Q?1Z08FZJl6IemZ8/QT9kTyzsz0wAQf9Z1+fEYLvvwY3zFm6g34LECIhf1wa27?=
 =?us-ascii?Q?YM4Ver6fCNtJS4A+jQHdsmAhzrWRnkMSQSnFJ64Hzg9kIUppBZREawY2raMo?=
 =?us-ascii?Q?ofBTQwdg837s2fdmZSSHcGcJripc6kQajq7OKkCqgO54lTTN9nYriYuVgR1F?=
 =?us-ascii?Q?onr08WkUHNJYJHw45YQntxkTNtnFc37XMVWGvzuGOjzOIKTKxYzWB8H4T8Jr?=
 =?us-ascii?Q?WQrui1paIu9fZmq7Y56VhmZbQOfAaWWK6An3EhvEXe5Ut331TkYrvamUfcxk?=
 =?us-ascii?Q?gVNF8BrchbARHcXukgIui9DDqPAy8xZ0PZo1J1c2zJWhFer7oj0qysXDtso9?=
 =?us-ascii?Q?wOdcDFxcxBzIazFKJYjbBphsabBItQLMW4hqR90zy938mCg2G+8koo1p8iPE?=
 =?us-ascii?Q?gxpK2N0cNlb2PI58cPNIyEX9q3laRMZrobeG9dW9Hn4W+VR7qzZDqnyGtzJc?=
 =?us-ascii?Q?6TI/i3pS7UmqGkAtTVtUDXyDNf7f1QwmOlUdNcoZAlsCOc0huZ4JB7wtmXkr?=
 =?us-ascii?Q?qAOolku0wZJBnHl+99IDLNkRseWeP7g4MPvIfnqCgUvgr6toUUBDk8xCxZHN?=
 =?us-ascii?Q?aVHI5/IPE8rzb09EnqJUrgdqp46LURkcaPebiP89JEx2q652DVFUaII/aAhh?=
 =?us-ascii?Q?Aymzd86E/yIalOu8s/HwUNuInLGGLTq/tgkv0nYTxtUnsmnyOSv1HjzTAsDB?=
 =?us-ascii?Q?jJfz7dwAjWmIXVsmAtu5HXhcSY0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999255.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98381785-7391-45f6-d43e-08df2b59cae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 07:47:56.5750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZ67aeM7D1gS3Zaq+5RrOysT7+NclbO78qKz4Q4IG/IGgRgbNNqGRO86nnI1TTDL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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

> -----Original Message-----
> From: Kenneth Feng <kenneth.feng@amd.com>
> Sent: Friday, October 16, 2026 3:24 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wang, Kevin <Kevin.Wang@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/pm:restate all customized OD features on every
> table upload for smu 13.0.0/smu 14.0.2
>
> PMFW interprets OverDriveTable.FeatureCtrlMask as the complete set of
> overdrive features that are currently overridden, not as a delta describi=
ng the
> operation at hand. On import it resets every feature whose bit is clear b=
ack to
> its default value - for the VF curve that means zeroing
> VoltageOffsetPerZoneBoundary[] outright.
>
> The driver assumed the opposite. smu_v14_0_2_od_edit_dpm_table() clears
> the mask after a successful commit, so a subsequent above-default
> power1_cap write goes through smu_v14_0_2_set_ppt_limit() and uploads a
> table carrying only PP_OD_FEATURE_PPT_BIT. PMFW then drops the user's
> voltage offset and reverts to the stock V/F curve, while the driver's cac=
hed
> user table still reports the offset through pp_od_clk_voltage.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5935
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2
> +  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 35 +++++++----------
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 32 +++++++---------
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 38 +++++++++++-----
> ---
>  4 files changed, 52 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index f516d0d3bb92..9d47d2ab1b49 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -433,6 +433,8 @@ struct smu_table_context {
>       void                            *boot_overdrive_table;
>       void                            *user_overdrive_table;
>
> +     uint32_t                        user_od_feature_mask;
> +
>       struct smu_driver_table driver_tables[SMU_DRIVER_TABLE_COUNT];
>  };
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 6beafabf1306..468aaeb79ffb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1569,7 +1569,6 @@ static int smu_v13_0_0_od_edit_dpm_table(struct
> smu_context *smu,
>       struct amdgpu_device *adev =3D smu->adev;
>       uint32_t offset_of_voltageoffset;
>       int32_t minimum, maximum;
> -     uint32_t feature_ctrlmask;
>       int i, ret =3D 0;
>
>       switch (type) {
> @@ -1891,21 +1890,16 @@ static int
> smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>                       if (ret)
>                               return ret;
>               } else {
> -                     feature_ctrlmask =3D od_table-
> >OverDriveTable.FeatureCtrlMask;
>                       memcpy(od_table,
>                      table_context->boot_overdrive_table,
>                      sizeof(OverDriveTableExternal_t));
> -                     od_table->OverDriveTable.FeatureCtrlMask =3D
> feature_ctrlmask;
> +                     od_table->OverDriveTable.FeatureCtrlMask =3D 0;
> +                     table_context->user_od_feature_mask =3D 0;
>               }
>               fallthrough;
>       case PP_OD_COMMIT_DPM_TABLE:
> -             /*
> -              * The member below instructs PMFW the settings focused in
> -              * this single operation.
> -              * `uint32_t FeatureCtrlMask;`
> -              * It does not contain actual informations about user's cus=
tom
> -              * settings. Thus we do not cache it.
> -              */
> +             table_context->user_od_feature_mask =3D
> +                     od_table->OverDriveTable.FeatureCtrlMask;
>               offset_of_voltageoffset =3D offsetof(OverDriveTable_t,
> VoltageOffsetPerZoneBoundary);
>               if (memcmp((u8 *)od_table + offset_of_voltageoffset,
>                          table_context->user_overdrive_table +
> offset_of_voltageoffset, @@ -1918,7 +1912,6 @@ static int
> smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>                               return ret;
>                       }
>
> -                     od_table->OverDriveTable.FeatureCtrlMask =3D 0;
>                       memcpy(table_context->user_overdrive_table +
> offset_of_voltageoffset,
>                              (u8 *)od_table + offset_of_voltageoffset,
>                              sizeof(OverDriveTableExternal_t) -
> offset_of_voltageoffset); @@ -2201,6 +2194,7 @@ static int
> smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
>                      boot_od_table,
>                      sizeof(OverDriveTableExternal_t));
>               smu->user_dpm_profile.user_od =3D false;
> +             smu->smu_table.user_od_feature_mask =3D 0;
>       } else if (smu->user_dpm_profile.user_od) {
>               memcpy(&user_od_table_bak,
>                      user_od_table,
> @@ -2250,12 +2244,8 @@ static int
> smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
>       OverDriveTableExternal_t *od_table =3D table_context-
> >overdrive_table;
>       OverDriveTableExternal_t *user_od_table =3D table_context-
> >user_overdrive_table;
>       int res;
> -
> -     user_od_table->OverDriveTable.FeatureCtrlMask =3D
> BIT(PP_OD_FEATURE_GFXCLK_BIT) |
> -
>       BIT(PP_OD_FEATURE_UCLK_BIT) |
> -
>       BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
> -
>       BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
> -
>       BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
> +     user_od_table->OverDriveTable.FeatureCtrlMask =3D
> +             table_context->user_od_feature_mask;
>       res =3D smu_v13_0_0_upload_overdrive_table(smu, user_od_table);
>       user_od_table->OverDriveTable.FeatureCtrlMask =3D 0;
>       if (res =3D=3D 0)
> @@ -3069,8 +3059,10 @@ static int smu_v13_0_0_set_ppt_limit(struct
> smu_context *smu,
>
>               if (current_od_table.OverDriveTable.Ppt) {
>                       od_table->OverDriveTable.Ppt =3D 0;
> -                     od_table->OverDriveTable.FeatureCtrlMask |=3D 1U <<
> PP_OD_FEATURE_PPT_BIT;
> -
> +                     table_context->user_od_feature_mask &=3D
> +                             ~(1U << PP_OD_FEATURE_PPT_BIT);
> +                     od_table->OverDriveTable.FeatureCtrlMask =3D
> +                             table_context->user_od_feature_mask;
>                       ret =3D smu_v13_0_0_upload_overdrive_table(smu,
> od_table);
>                       if (ret) {
>                               dev_err(smu->adev->dev, "Failed to upload
> overdrive table!\n"); @@ -3084,8 +3076,9 @@ static int
> smu_v13_0_0_set_ppt_limit(struct smu_context *smu,
>                       return ret;
>
>               od_table->OverDriveTable.Ppt =3D (limit * 100) / msg_limit =
-
> 100;
> -             od_table->OverDriveTable.FeatureCtrlMask |=3D 1U <<
> PP_OD_FEATURE_PPT_BIT;
> -
> +             table_context->user_od_feature_mask |=3D 1U <<
> PP_OD_FEATURE_PPT_BIT;
> +             od_table->OverDriveTable.FeatureCtrlMask =3D
> +                     table_context->user_od_feature_mask;
>               ret =3D smu_v13_0_0_upload_overdrive_table(smu, od_table);
>               if (ret) {
>                 dev_err(smu->adev->dev, "Failed to upload overdrive
> table!\n"); diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 414fb436d88f..b96152d3920f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1578,7 +1578,6 @@ static int smu_v13_0_7_od_edit_dpm_table(struct
> smu_context *smu,
>       struct amdgpu_device *adev =3D smu->adev;
>       uint32_t offset_of_voltageoffset;
>       int32_t minimum, maximum;
> -     uint32_t feature_ctrlmask;
>       int i, ret =3D 0;
>
>       switch (type) {
> @@ -1900,22 +1899,17 @@ static int
> smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>                       if (ret)
>                               return ret;
>               } else {
> -                     feature_ctrlmask =3D od_table-
> >OverDriveTable.FeatureCtrlMask;
>                       memcpy(od_table,
>                                       table_context->boot_overdrive_table=
,
>                                       sizeof(OverDriveTableExternal_t));
> -                     od_table->OverDriveTable.FeatureCtrlMask =3D
> feature_ctrlmask;
> +                     od_table->OverDriveTable.FeatureCtrlMask =3D 0;
> +                     table_context->user_od_feature_mask =3D 0;
>               }
>               fallthrough;
>
>       case PP_OD_COMMIT_DPM_TABLE:
> -             /*
> -              * The member below instructs PMFW the settings focused in
> -              * this single operation.
> -              * `uint32_t FeatureCtrlMask;`
> -              * It does not contain actual informations about user's cus=
tom
> -              * settings. Thus we do not cache it.
> -              */
> +             table_context->user_od_feature_mask =3D
> +                     od_table->OverDriveTable.FeatureCtrlMask;
>               offset_of_voltageoffset =3D offsetof(OverDriveTable_t,
> VoltageOffsetPerZoneBoundary);
>               if (memcmp((u8 *)od_table + offset_of_voltageoffset,
>                          table_context->user_overdrive_table +
> offset_of_voltageoffset, @@ -1928,7 +1922,6 @@ static int
> smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>                               return ret;
>                       }
>
> -                     od_table->OverDriveTable.FeatureCtrlMask =3D 0;
>                       memcpy(table_context->user_overdrive_table +
> offset_of_voltageoffset,
>                              (u8 *)od_table + offset_of_voltageoffset,
>                              sizeof(OverDriveTableExternal_t) -
> offset_of_voltageoffset); @@ -2203,6 +2196,7 @@ static int
> smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
>                      boot_od_table,
>                      sizeof(OverDriveTableExternal_t));
>               smu->user_dpm_profile.user_od =3D false;
> +             smu->smu_table.user_od_feature_mask =3D 0;
>       } else if (smu->user_dpm_profile.user_od) {
>               memcpy(&user_od_table_bak,
>                      user_od_table,
> @@ -2253,11 +2247,8 @@ static int
> smu_v13_0_7_restore_user_od_settings(struct smu_context *smu)
>       OverDriveTableExternal_t *user_od_table =3D table_context-
> >user_overdrive_table;
>       int res;
>
> -     user_od_table->OverDriveTable.FeatureCtrlMask =3D
> BIT(PP_OD_FEATURE_GFXCLK_BIT) |
> -
>       BIT(PP_OD_FEATURE_UCLK_BIT) |
> -
>       BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
> -
>       BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
> -
>       BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
> +     user_od_table->OverDriveTable.FeatureCtrlMask =3D
> +             table_context->user_od_feature_mask;
>       res =3D smu_v13_0_7_upload_overdrive_table(smu, user_od_table);
>       user_od_table->OverDriveTable.FeatureCtrlMask =3D 0;
>       if (res =3D=3D 0)
> @@ -2719,7 +2710,10 @@ static int smu_v13_0_7_set_ppt_limit(struct
> smu_context *smu,
>
>               if (current_od_table.OverDriveTable.Ppt) {
>                       od_table->OverDriveTable.Ppt =3D 0;
> -                     od_table->OverDriveTable.FeatureCtrlMask |=3D 1U <<
> PP_OD_FEATURE_PPT_BIT;
> +                     table_context->user_od_feature_mask &=3D
> +                             ~(1U << PP_OD_FEATURE_PPT_BIT);
> +                     od_table->OverDriveTable.FeatureCtrlMask =3D
> +                             table_context->user_od_feature_mask;
>
>                       ret =3D smu_v13_0_7_upload_overdrive_table(smu,
> od_table);
>                       if (ret) {
> @@ -2734,7 +2728,9 @@ static int smu_v13_0_7_set_ppt_limit(struct
> smu_context *smu,
>                       return ret;
>
>               od_table->OverDriveTable.Ppt =3D (limit * 100) / msg_limit =
-
> 100;
> -             od_table->OverDriveTable.FeatureCtrlMask |=3D 1U <<
> PP_OD_FEATURE_PPT_BIT;
> +             table_context->user_od_feature_mask |=3D 1U <<
> PP_OD_FEATURE_PPT_BIT;
> +             od_table->OverDriveTable.FeatureCtrlMask =3D
> +                     table_context->user_od_feature_mask;
>
>               ret =3D smu_v13_0_7_upload_overdrive_table(smu, od_table);
>               if (ret) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 33f93f6d90af..c4dfa66c723b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -2385,6 +2385,7 @@ static int
> smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
>                      boot_od_table,
>                      sizeof(OverDriveTableExternal_t));
>               smu->user_dpm_profile.user_od =3D false;
> +             smu->smu_table.user_od_feature_mask =3D 0;
>       } else if (smu->user_dpm_profile.user_od) {
>               memcpy(&user_od_table_bak,
>                      user_od_table,
> @@ -2433,11 +2434,8 @@ static int
> smu_v14_0_2_restore_user_od_settings(struct smu_context *smu)
>       OverDriveTableExternal_t *user_od_table =3D table_context-
> >user_overdrive_table;
>       int res;
>
> -     user_od_table->OverDriveTable.FeatureCtrlMask =3D
> BIT(PP_OD_FEATURE_GFXCLK_BIT) |
> -
>       BIT(PP_OD_FEATURE_UCLK_BIT) |
> -
>       BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
> -
>       BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
> -
>       BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
> +     user_od_table->OverDriveTable.FeatureCtrlMask =3D
> +             table_context->user_od_feature_mask;
>       res =3D smu_v14_0_2_upload_overdrive_table(smu, user_od_table);

I think there is a risk here, the power1_cap and pp_od_clk_voltage shared t=
he same od staging table.

Best Regars,
Kevin
>       user_od_table->OverDriveTable.FeatureCtrlMask =3D 0;
>       if (res =3D=3D 0)
> @@ -2522,7 +2520,6 @@ static int smu_v14_0_2_od_edit_dpm_table(struct
> smu_context *smu,
>       struct amdgpu_device *adev =3D smu->adev;
>       uint32_t offset_of_voltageoffset;
>       int32_t minimum, maximum;
> -     uint32_t feature_ctrlmask;
>       int i, ret =3D 0;
>
>       switch (type) {
> @@ -2811,21 +2808,26 @@ static int
> smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
>                       if (ret)
>                               return ret;
>               } else {
> -                     feature_ctrlmask =3D od_table-
> >OverDriveTable.FeatureCtrlMask;
>                       memcpy(od_table,
>                      table_context->boot_overdrive_table,
>                      sizeof(OverDriveTableExternal_t));
> -                     od_table->OverDriveTable.FeatureCtrlMask =3D
> feature_ctrlmask;
> +                     od_table->OverDriveTable.FeatureCtrlMask =3D 0;
> +                     table_context->user_od_feature_mask =3D 0;
>               }
>               fallthrough;
>       case PP_OD_COMMIT_DPM_TABLE:
>               /*
> -              * The member below instructs PMFW the settings focused in
> -              * this single operation.
> -              * `uint32_t FeatureCtrlMask;`
> -              * It does not contain actual informations about user's cus=
tom
> -              * settings. Thus we do not cache it.
> +              * PMFW interprets FeatureCtrlMask as the complete set of
> OD
> +              * features that are currently overridden, not as a delta
> +              * describing this single operation. Any feature whose bit =
is
> +              * clear gets reset to its default on import. od_table's ma=
sk
> +              * has accumulated every feature the user touched since the
> +              * last full restore, so record it and keep restating it on
> +              * subsequent uploads.
>                */
> +             table_context->user_od_feature_mask =3D
> +                     od_table->OverDriveTable.FeatureCtrlMask;
> +
>               offset_of_voltageoffset =3D offsetof(OverDriveTable_t,
> VoltageOffsetPerZoneBoundary);
>               if (memcmp((u8 *)od_table + offset_of_voltageoffset,
>                          table_context->user_overdrive_table +
> offset_of_voltageoffset, @@ -2838,7 +2840,6 @@ static int
> smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
>                               return ret;
>                       }
>
> -                     od_table->OverDriveTable.FeatureCtrlMask =3D 0;
>                       memcpy(table_context->user_overdrive_table +
> offset_of_voltageoffset,
>                              (u8 *)od_table + offset_of_voltageoffset,
>                              sizeof(OverDriveTableExternal_t) -
> offset_of_voltageoffset); @@ -2882,7 +2883,10 @@ static int
> smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
>
>               if (current_od_table.OverDriveTable.Ppt) {
>                       od_table->OverDriveTable.Ppt =3D 0;
> -                     od_table->OverDriveTable.FeatureCtrlMask |=3D 1U <<
> PP_OD_FEATURE_PPT_BIT;
> +                     table_context->user_od_feature_mask &=3D
> +                             ~(1U << PP_OD_FEATURE_PPT_BIT);
> +                     od_table->OverDriveTable.FeatureCtrlMask =3D
> +                             table_context->user_od_feature_mask;
Please check upload table return value first, before copy user od feature m=
ask to FeatureCtrlMask.

With that fixed, the patch is

Reviewed-by: Kevin Wang <kevin.wang@amd.com>

Best Regards,
Kevin
>
>                       ret =3D smu_v14_0_2_upload_overdrive_table(smu,
> od_table);
>                       if (ret) {
> @@ -2897,7 +2901,9 @@ static int smu_v14_0_2_set_ppt_limit(struct
> smu_context *smu,
>                       return ret;
>
>               od_table->OverDriveTable.Ppt =3D (limit * 100) / msg_limit =
-
> 100;
> -             od_table->OverDriveTable.FeatureCtrlMask |=3D 1U <<
> PP_OD_FEATURE_PPT_BIT;
> +             table_context->user_od_feature_mask |=3D 1U <<
> PP_OD_FEATURE_PPT_BIT;
> +             od_table->OverDriveTable.FeatureCtrlMask =3D
> +                     table_context->user_od_feature_mask;
>
>               ret =3D smu_v14_0_2_upload_overdrive_table(smu, od_table);
>               if (ret) {
> --
> 2.43.0

