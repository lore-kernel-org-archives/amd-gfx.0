Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACCCC3ABD7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 14:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A0610E5B4;
	Tue, 13 May 2025 14:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OXZ2c7P8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269AB10E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 14:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQaF1sVr6xeHnC1gY9qBfJPxtU31n0947ogT/fDLB8EEiIua1/MsPvkHNiIgXIPko3JIY5GPMtsl2mbHzS9MpnhtWK7DfpZkdpFu35Xj31SzzVgC+mZ3512CLDLshi74FrHEYskTZQpidoWPmB6a2wMd0e0Us+NUBKJmCvWf1s4brZA1vtrup63e77oLU8wymN/y7iTJp23Q/u4J8QWLeB/fdVCepj9ePZ4WpG22DzKofjtgYn9xsi7M3xbTJJECuz/VytCS2hJ4O6iLl9tXnZcZ9I4sUytWoGVQIQq4hAxzESaqUY5px4U8/RcuD7Q05i/ibHhzZ5AUT5yObIBVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6ENukFOfyuafrXn50anQjZjoQK5iWbozfY7C+ZiI18=;
 b=Tj8tOguNFwAIgxM8q89kOjdX5R7HesX8ddtFNq+gp3WLXjTs9bi6ePApjPqNGCOVjOtxdGcWOVMGjFnvovmfPXtSc24sCwrS69Kc+vgWNYO5OZZJoC5zZatCgpQs1AmDydzmmEWHIW+SY5LEZd9ImGxXItgJGygX0F8P8EQiEwRr2CnaHciCp1MwgFODuTBDeWvMQx+6TzKSf5oOKwHNKLE91F4jZJ74K/mA5Z1pl7cs0xtCgUByjbHLY6MZtTZFI9OBQAfbbRnFAuaZl53Qxef2mbBCeBFq+jXrehWD+sYMHCcv0cZ2cf3/CV3iUISvozZ5FjeZViPdRBKjZ4nJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6ENukFOfyuafrXn50anQjZjoQK5iWbozfY7C+ZiI18=;
 b=OXZ2c7P8znFju6NtV0jfZ3nsrR3cRpubv82YHrX7qQ6xnUAMrGGHvVo3Ix7D8sRd3gX0s4rBtWZ7RsaSpq7ziLqn9KMteDf2sE98/fE0GYItIMBPDiPommfEARRIENqlEdeZVCkVpFUedNaaYCCdaqkBMURaMWh60yDKytMntbo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 14:20:40 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 14:20:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/pm: Fill pldm version for SMU v13.0.6 SOCs
Thread-Topic: [PATCH 3/3] drm/amd/pm: Fill pldm version for SMU v13.0.6 SOCs
Thread-Index: AQHbw/lELCC81A0OOkaRmT+A7QIPM7PQnFjQ
Date: Tue, 13 May 2025 14:20:40 +0000
Message-ID: <BN9PR12MB5257039DB5AA65C70697E053FC96A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250513112139.88355-1-asad.kamal@amd.com>
 <20250513112139.88355-3-asad.kamal@amd.com>
In-Reply-To: <20250513112139.88355-3-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4e4f2446-393b-412f-9e05-5e6766d97a75;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-13T14:20:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB9063:EE_
x-ms-office365-filtering-correlation-id: 45d5431f-19ec-4c89-1185-08dd922956d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RL5M6l+nIibMf6DJyTqSmBOa6rVR8luHD1kEtm5gi1M9Fi0uXItTxqtQXGax?=
 =?us-ascii?Q?eNIaPhJzWqTSdg/+0/ZnK3zQar+Mg80wefgmLdxASX+89+5Qcxd3uPs2pxMW?=
 =?us-ascii?Q?VQp9rHhYsufEk1CU63upRaXJAIBe0tqxIKWanJev6DR7Zfjtkv7U/xRJKOet?=
 =?us-ascii?Q?p/1nq5k+NwX804nrTnCRsQRuEYo5TgzVQL1pyzy3tGyHx11yx+6WB8stp/q1?=
 =?us-ascii?Q?bd+zxAkDgdWvLGx3xk4Lw/xUW0LBUBtzOrN8rsXHh3EK+qD0v4C0TWJzLBrh?=
 =?us-ascii?Q?mQGxbiu1j0WnAyw06wWDs51H4BP2TzQDKIv71SQq5NGpFt/wp9QzBXVXXUSA?=
 =?us-ascii?Q?usjmMWMe20BeRpV5yWToxmsA2aUlVgzn+DanjBdDZHrpy0MK20y6uvRMLxdt?=
 =?us-ascii?Q?xh8h/+6uJCAMvOwisA8uxFLjHnk8hXydcGve2Fs4N6DG+AxHSG7VgjaQTEk/?=
 =?us-ascii?Q?2/LDfmszacX2iuvBgZ0zJ9+pQvgZcGPRZXjUgVhZy7Gy7O3dlZaWoY86Thj+?=
 =?us-ascii?Q?GYEtpFcp83YfeEApK19uCEWY0eyEZOrtV+ei1JPLm2rzKk5FJKgo9OO1L239?=
 =?us-ascii?Q?P3PKzdsrUHjLIqf5E/wjoBMjiKKQMJlfXWmZGFGiQTUUsT+AE7B1SJrj0Po8?=
 =?us-ascii?Q?jj4qv88Zuy1iWmEL7BevazXVm3IF+952ZUMkxwOEO7ft3rf9wLviCHlsGVTj?=
 =?us-ascii?Q?HHAaoA0aOdQqsR2wzf1lU1RpCtAOdtsF5285d5CQmVAFx1yEixheRjw1605X?=
 =?us-ascii?Q?Ow2hzYTd5LobP8lRw0Y7N/f6LI9nYbhGGLRB5QUupC9j6VUDr3Ptfp8nG3P4?=
 =?us-ascii?Q?cgYQDa/dP6jum8CFEKFj9ljMI1SkkkR8b/YK4RGEusAquLoEunc4wrF892KL?=
 =?us-ascii?Q?8zkB4WD5Iwgl+YxLltIzXJCiY4TxRH+FtyrlHgQCAonJHSBbkWtwrvXdy/hA?=
 =?us-ascii?Q?VBD6LdSTDTmgpG5yFUmb9fUJrBdog9uJMa59KOg0gAFfL5QWXYXQrrUv/oaW?=
 =?us-ascii?Q?9Ua1oN4zELAoEP73vtDPj5yAjzWSEvKPmdkm32KyHb//MR+uqRMoJT/AmCXU?=
 =?us-ascii?Q?8F2kXvUlFkxoYrySV3n2pJyznvl1Qbjnw8aaN0DccPLOJ7qXf1mPnH4AqSD/?=
 =?us-ascii?Q?ocnbj4tQRecQyrap04srgECu/3ZgUEYTreaGhWKrpoYPDIlzHHNAeuQMrpp7?=
 =?us-ascii?Q?ehE5IC8lBjU5vxDCYfHontnSsGNU4uB2bh6F+qyegC2ZMv7uR7gKpz6wkR6Y?=
 =?us-ascii?Q?5xLraxbhuTBqL2Kd1gXfD3eq4Rm3ihivd5uFXI6zDM3FwtvJPvL+t3+0ZeYC?=
 =?us-ascii?Q?a6+zX1e4YXsUh4M3FZDv9czmRPpNG0vKMGggPorhnsz/oX2qJb7sT88a2qGI?=
 =?us-ascii?Q?2O7WU2JLyFZtFw+pUZp3/IT7xvyCfbsTEW5n/FbLoUXIEUYqO6NOD3UH38ov?=
 =?us-ascii?Q?XKs82b+wrs6dtnQTHMAf8d6hpqSzt8+S16ATvMZ7tyj/G2oQuutYqw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vujJK4tLUC+vkYAhQGTYCokG88lmOm7TR3e8GD5BSWZGxgtV/+qxlAEe2WrM?=
 =?us-ascii?Q?NRVkkhPPdBerd9EeTXDt93+5RsF8+hEuoq/TOBm5fnWZEe2dKrNHkaXdViO6?=
 =?us-ascii?Q?TYJ/niuEHDPTxXK7rBP23xqmy6ufO6vQwJnt/tSii4J6O4rPpXKk94asfQ9p?=
 =?us-ascii?Q?oUFXk6tM5CJ7BskR+Y/4lTYR+dW8Wf0RRsgVgq4eAPYH7G5cvk3clk0W4GGT?=
 =?us-ascii?Q?/olROjSE7ymYp5kaxafRBycucr0aVLnTfYBqqpwLDcPwYtqXDjtX3XEAHnko?=
 =?us-ascii?Q?MKMfpnG4eIRsoDtdrkmKbO1pM5z17bTTj/qnF3n+YWghH1uT0UY9KIuPtIen?=
 =?us-ascii?Q?uAvrmvsASSLwUhbZRuKVd1a1jLoCbHmmRSLOrn8PUK7W9Tc9/+HNQgEFHNfA?=
 =?us-ascii?Q?4efAx/5hredukpP9V7deTDBpieW0KGtaTCVcZ7ewAyV+mT30URPSmfewitiq?=
 =?us-ascii?Q?NtfFwuDPy2K545oLP5/OdrOxPYT4CcULZpDW8toDA1kbe/DDm761CZ+1fdrV?=
 =?us-ascii?Q?p8UyFKZ8YjusCszmDFJYkCJQu4m9H1xhkILqsr62r4znFd1kDa72SVaEvlMz?=
 =?us-ascii?Q?nES6Jr0TWTNFdHh88ISoDl7JHrvClPtoUxDMrgHZEjkw6JdME9xscBUZtEH/?=
 =?us-ascii?Q?IUi2FmVbfFsdVFSSJbDUzacAhqmb6PECOkSzY4UUPuRjIyE2OdxgFpyNvBWe?=
 =?us-ascii?Q?fYlTDl3/GEeojwioFsJk8I8yvQo2SAn7VJNGuQvuCRG+j1LlCudpQCVzl3Wa?=
 =?us-ascii?Q?bBeRZBpVEAhPdkzfI+jypoP44Mmt4awjFUjp/SBGuz2GpTb3Ez8etNCiZSGt?=
 =?us-ascii?Q?OgWvxTEQb2nDgX3RfSVXiCXpR8yabwPqu5IK5vWDDOUEdTb/iROnr7lbIGnH?=
 =?us-ascii?Q?z9KDjVJAws31R9gJ2V+/NYxcyuR7za5v7Zx355Wqso2Eg4uB6VWXI0ncN/P4?=
 =?us-ascii?Q?29VM5oNbU9olhi0f9SDjibMsl6yEb8M7X+3KghBMxd9CYxgTXkNbEz0GYiPi?=
 =?us-ascii?Q?XRzXSWMuiEjmXaAOLjEBkS02X/hzhBOi1OpL+gU1Nwv0XfSLUVa0DlDKqY9w?=
 =?us-ascii?Q?QWST2+yDT6M2aBhdU4br2/WXKDwxMnF5r4QJhVHpjdXVU/z1IhXukO9+Fjom?=
 =?us-ascii?Q?XGFtwLUVi1+etOrDSelg1osnyKZ3TVc2kUjaxu78lqbXBHQppQ1hhWQo4CCN?=
 =?us-ascii?Q?oaSFgIS3VlytacSUGjHWpiC+yMqmOluEj7rFf4DWaEfWswoGXkM3Q1UA59ml?=
 =?us-ascii?Q?gN01prwy1GZcrWNtijRbMJNOdRlNmaU5vPrJQwN9IZYrwQ3sBYWmy2kvRqhl?=
 =?us-ascii?Q?geZi1WzxzCThuYGv4EcWxWDj1jPJsQydxrud9nh+G35fwfpMxCEYkcWcKfB2?=
 =?us-ascii?Q?B06QhBcdEQSe96WAK7+zF3DAmxuzLCuM4yPqDmn3b26+gsuEbU8ez8roUgbQ?=
 =?us-ascii?Q?KicxFsPQirFi3Z+suY73cJ6DcoRkdGOXdNnxHIKlWIV+l9A5s6Ho+bwZjVBZ?=
 =?us-ascii?Q?9jreDhRKjNx4FcJpv5RhGU4REnsTFoXLhhKzZrtp/dHcl0eYR2QuG94yIWSR?=
 =?us-ascii?Q?dHpu6R/GxOk7xObS4E0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d5431f-19ec-4c89-1185-08dd922956d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 14:20:40.3978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2PrtH1GWAIQAkiMKt3xy6z01DMaWt5m2u90PWoT/K63ymPiCyF7bjQK1N5EcGnXdWCaFiRNSx4Meb2LCl3M/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Tuesday, May 13, 2025 19:22
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Fill pldm version for SMU v13.0.6 SOCs

Fetch pldm version from static metrics table for SMU v13.0.6 SOCs

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 +++++++  drivers/=
gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7d4ff09be7e8..cd9ed3b5e9fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -396,6 +396,8 @@ static void smu_v13_0_6_init_caps(struct smu_context *s=
mu)
                        smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
                        smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
                }
+               if (fw_ver >=3D 0x00558000)
+                       smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
        }
        if (((pgm =3D=3D 7) && (fw_ver >=3D 0x7550700)) ||
            ((pgm =3D=3D 0) && (fw_ver >=3D 0x00557900)) || @@ -752,6 +754,=
11 @@ static void smu_v13_0_6_fill_static_metrics_table(struct smu_context =
*smu,
        }

        dpm_context->board_volt =3D static_metrics->InputTelemetryVoltageIn=
mV;
+
+       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(PLDM_VERSION)) &&
+           static_metrics->pldmVersion[0] !=3D 0xFFFFFFFF)
+               smu->adev->firmware.pldm_version =3D
+                       static_metrics->pldmVersion[0];
 }

 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu) diff --g=
it a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm=
/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 5313206ae4bb..6e7293d3f264 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -67,6 +67,7 @@ enum smu_v13_0_6_caps {
        SMU_CAP(STATIC_METRICS),
        SMU_CAP(HST_LIMIT_METRICS),
        SMU_CAP(BOARD_VOLTAGE),
+       SMU_CAP(PLDM_VERSION),
        SMU_CAP(ALL),
 };

--
2.46.0

