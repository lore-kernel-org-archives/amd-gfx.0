Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC39C04FE1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 18:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF42010E070;
	Wed, 16 Aug 2023 18:11:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D0910E070
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 18:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTyNwQFC4yj2nKSufpd6IB5UCjYJzO0Hapx5knjyMTC6N/VX5X47Gc66nsWZ4MEu74ROj5caDibBu21X4bf1WkX5i0K1e0n0LrA6Nd1LdHerqXCyfp/bdeboS7ssE65dIs/QKRQ/sEsQtRBwaYI33UIHElVf5ULM49azQN/jkejnzXkmKwtQViNKIWtka5bTsXxFPADznP+Cc+7FBdV/D9a4zTW1PqYlAxASnRsX//Cu+78KmcDINb10ta9TFG2Me5IakjHAC3dRlBp2ES5HFLh8JHOubbS/AXpeTBl7rkTwMOD+83SBJ9SFDrOIwzT8uRHYY0iR2Yttujek78UDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BewYe2htCM+bE6HMSV4ShqiOfi3gHkxKkrnJzmJPodE=;
 b=DdkaCcUsDgPgGEp8gO00eW/dDDSn7miXS/DaLXq0AUusBvcy3zOVI4CQIqQhfuQxHwmOHT+4+kexx1f+i48/GlS7gCyfECx24p/aNa5HYX8SEeuHPYgZiGNXwEzWNxHqCCDiYgUpFwwfh0kvHqtlYylvbpOpxJwt8utr2iaMkEmfR5kHNlQdcV/+h57wXKoh+YxmjwNaenBLbIMxzmwxCc2wfNjZyLpN4dgnxDm8SjEQbCHaCFE9LJ8gzlp+CGMPJyVKEOvxKsEjQPidiKOwv63I3mG9heN4M0ya9q2OO7+wy/djRIn+WUa7QTM/Yd8F9sBo2BgnHpE5PwNGcMeaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BewYe2htCM+bE6HMSV4ShqiOfi3gHkxKkrnJzmJPodE=;
 b=ZL1S+gKgusGEUFt0vNnWI+x0kOBUfDk9M2HPfviffYKPJZFzdq1ADk8AoCv5MjllI7FrRt/Drq9W1zoxVc4cTll4Zy1/NtGrwtb2QQs+73L1AoWw9H51UHAzATt/DHWPdR2w571H5iQUKn1tNMNrE9LaHBtpX7jVrUjSNnhiSoQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 18:11:05 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 18:11:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu/pm: Add notification for no DC support
Thread-Topic: [PATCH v3] drm/amdgpu/pm: Add notification for no DC support
Thread-Index: AQHZ0GycAsHQIAQykUWZIDJFPSS7zK/tOJDA
Date: Wed, 16 Aug 2023 18:11:05 +0000
Message-ID: <BL1PR12MB514471A58BC4423CEB096CECF715A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <BYAPR12MB46147963E0CF9E1FC699CB079715A@BYAPR12MB4614.namprd12.prod.outlook.com>
 <20230816180712.102887-1-bokun.zhang@amd.com>
In-Reply-To: <20230816180712.102887-1-bokun.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=dbda611c-a224-4a11-9507-480d1e230be9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-16T18:08:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB5344:EE_
x-ms-office365-filtering-correlation-id: 22af4264-fc38-49c3-2891-08db9e842897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJAHanvhukCwBcK0vbK2QPHZ1GWmgPRROq4Hs9TDurjq41dAkQvdxIgS9qkp03wADfg+IeJxXY0XwLPfOGqXj1unOzZOyQGtffLOFOLCzf0mw73W5v1YBnov9IwHjkmA32CLGIhO8PtQzG1w+2SnJGNz6Xt/LdK/2v5o/rNGErwb/pEeTs8sylv85Clxy535OT8kvX56cX8hGX11dCODsFDLzZCKaMGxTxynmzKmSK8eULYYz4SpKvZDlL9gf96GZEc2+v5Al6jqXKgfLp+Un21D4PmllcB+L8iGWBg2qXRc9MXcXLDtsno+TpwgbDhP9PyFFZxGu6zaLYxB/8b4rSxQIkkILodasUzYUdx8ecQDM9+0EDsANoKXTWb6StDkXdGKauFbNuUlscnvtCvdY91F7RDFtKAGz/oYCTP6haIrQLsgR0+ptQ91U6/Lotjgv/x4uRFFK3KDAGFiH6HNSbKoI5RI/NweimmwbsVXn2y4BtBVYDXFO8F+P6fxdempn+xGOrd1s0UT6HoqYOHkfqU3yujGgdCNqdN77uJyhWXc0RIIIrDx2qhwhQ1iv5BxkqROmI63dMe+5lLx3odtjWzcccEzRPCf0CoV5E3ycSMLc3CAq/BznGxHTwe6bUlb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199024)(1800799009)(186009)(316002)(54906003)(76116006)(66946007)(64756008)(110136005)(66476007)(66556008)(66446008)(122000001)(41300700001)(52536014)(5660300002)(38070700005)(38100700002)(8676002)(4326008)(8936002)(2906002)(15650500001)(83380400001)(26005)(55016003)(478600001)(86362001)(53546011)(9686003)(33656002)(7696005)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7lN9Tbha90tGiqqT0+iduMCYwVPgs1tRCMh+HJ7aYFA7aQdVgAXrWWt03O3o?=
 =?us-ascii?Q?oqpyVME7CV8V2EIrp2HQsCgOhwWqcNE8xPrasQo4aJ+RpGxhLk3eq00Fq+yx?=
 =?us-ascii?Q?wuZf9AMq/s/SSMeKKoHCH+Nl53dNNEmysIPMq761c7UPPDcWDJnjzphCAcfB?=
 =?us-ascii?Q?ZWkxf6D0MrdEmmUfCmMz+PGBu4edqhYWXsj7RJB+nAcfFxYJc/KwA0dspAI2?=
 =?us-ascii?Q?5y/pD5o7UfrS0NK29pHib5yygJuDeGXjSGIQcmtT/Rh3fmsNuf1Va0OZNSag?=
 =?us-ascii?Q?e0+Hx/qRZg+DnMJIdxF4Fqr8eePQAb1BPdEZ1yku3RC/MSv2Kmz+v0C1Hjcc?=
 =?us-ascii?Q?81+U5dvLS+U7FfDuPC6eIy0+3o3x5JNaUpuR4rM++BtH6iaJcj7uTxahD2D6?=
 =?us-ascii?Q?9fONCthsWgFupe4RuRt9TIIuaGtJQnGiTsiDtWwTNlk9xpfZav8exsDjYaIF?=
 =?us-ascii?Q?Yl9MMcTxXhezo1a2x+tqkhPIGP59W7lRU5pGXlNXkbBtdpXLaDqoisUwIrZG?=
 =?us-ascii?Q?UYGqDvv356h6i17/X+zI3ofuLrvmNvEtwpySjEhcBidZswDyl7mfnNNaFKlC?=
 =?us-ascii?Q?zD1plVdusStgSMpaNw8CvyzSjglIF3ESxcTJZ65lxHt/wtHXhQhSDVKeIHnI?=
 =?us-ascii?Q?iH+B8BxBXaTrExaLhQ/Db7cnPKEcxTv5gJeDo3eKrKWgYISKF/gM2+5CJE8H?=
 =?us-ascii?Q?/i97IdGyoG+Z+mi6s/ZlWlLe/kEwNTx6SeKGq0xWouVrgjWfu+0+kHdlTL2D?=
 =?us-ascii?Q?PHs4gkOMj3h6NgH0Bd5MUJFlh/lYfWn3slyXB73HzvG31mmx46WENnn6gali?=
 =?us-ascii?Q?vyZgu/e3qVspjCncCRlJtKRecijTmwTfzAYPBsEf1UXAxSmCz8aeZDyGDB8z?=
 =?us-ascii?Q?ezFxoPSKFeODnv6CbfAXFFov1NFCr1fzi6K15Q204f9wrRqeEHT2Ll96jaab?=
 =?us-ascii?Q?dlNjdm8Snkz/VfYBPVbNwcQlgo1Ms0bb+rh1FKjC8CQv5fA9rnnTyhFd9UAF?=
 =?us-ascii?Q?rmUqF7MLt2RQ/h9e0dUrGzT2Um32/FwSfsi3NEenjiLFgZmt3ISYrgsTQO2j?=
 =?us-ascii?Q?f55B9CmaKG8FZNN9sUYpqbAAssvKdz4U0maqEPHEEgvlp0XL+U3YBHVyKkzB?=
 =?us-ascii?Q?OTdtBxKU3fjxVd+Khb4CAr9g9hbJS+P+dQ+4vKtaNrtU1gXIU2fCdNW+FDd7?=
 =?us-ascii?Q?bk8IHadPUL/AeLZUaslNvEycNTzZHl9kLkalxWwqLgecS03fko5lP1guGW/e?=
 =?us-ascii?Q?T9MRZ4lIytL+dxvBQd1HhzjHgw428hVZJJV6CDyuqU74sJGvJUUm16UblLmT?=
 =?us-ascii?Q?WDC2rsNiDwMqmxnFFtCS1fs4Ats4ZbsFcNUQVO1IWF964CHmr36ZxbL85uOo?=
 =?us-ascii?Q?7pQ8sR0pDFXbL9RiQg0cbrAyfcU8xhxhcdvvih1N0Sat0Wbs4S6/fg6AZvBC?=
 =?us-ascii?Q?XBf63zXmxxvroerNQCIVpZJWaBtF4kHU2sAF8ipowfDO5bveBgPfIjjRF1J4?=
 =?us-ascii?Q?o+wZw1FV3IQvtYkbzzxVDAfijftv2JOivQTsb3/xrc2aBMJNsJQ7yKdHeqnU?=
 =?us-ascii?Q?RYxe4fkiN+KBvB3f0a0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22af4264-fc38-49c3-2891-08db9e842897
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 18:11:05.6902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISHc5T/nq8kNh+DaOFMJhXN+aapbanPOSfncb8bAMMVLhV17qb0MQlt+/a6dx8jG8XQ51P7/hDR8YNS2jTDfjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun
> Zhang
> Sent: Wednesday, August 16, 2023 2:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Bokun <Bokun.Zhang@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH v3] drm/amdgpu/pm: Add notification for no DC support
>
> - There is a DPM issue where if DC is not present,
>   FCLK will stay at low level.
>   We need to send a SMU message to configure the DPM
>
> - Reuse smu_v13_0_notify_display_change() for this purpose
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h          |  5 +----
>  .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h   |  5 ++++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h           |  3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c         | 10 ++++------
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  2 ++
>  5 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 6e2069dcb6b9..a719ad9f7bd0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1043,10 +1043,7 @@ struct pptable_funcs {
>                                                  enum smu_feature_mask
> mask);
>
>       /**
> -      * @notify_display_change: Enable fast memory clock switching.
> -      *
> -      * Allows for fine grained memory clock switching but has more
> stringent
> -      * timing requirements.
> +      * @notify_display_change: General interface call to let SMU know
> +about DC change
>        */
>       int (*notify_display_change)(struct smu_context *smu);
>
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> index 10cff75b44d5..e2ee855c7748 100644
> ---
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> @@ -138,7 +138,10 @@
>  #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
>  #define PPSMC_MSG_SetPriorityDeltaGain           0x4B
>  #define PPSMC_MSG_AllowIHHostInterrupt           0x4C
> -#define PPSMC_Message_Count                      0x4D
> +
> +#define PPSMC_MSG_DALNotPresent                  0x4E
> +
> +#define PPSMC_Message_Count                      0x4F
>
>  //Debug Dump Message
>  #define DEBUGSMC_MSG_TestMessage                    0x1
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 297b70b9388f..f71fc99447f2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -245,7 +245,8 @@
>       __SMU_DUMMY_MAP(AllowGpo),      \
>       __SMU_DUMMY_MAP(Mode2Reset),    \
>       __SMU_DUMMY_MAP(RequestI2cTransaction), \
> -     __SMU_DUMMY_MAP(GetMetricsTable),
> +     __SMU_DUMMY_MAP(GetMetricsTable), \
> +     __SMU_DUMMY_MAP(DALNotPresent),
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)        SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 895cda8e6934..4b8842fc9574 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -838,12 +838,10 @@ int smu_v13_0_notify_display_change(struct
> smu_context *smu)  {
>       int ret =3D 0;
>
> -     if (!smu->pm_enabled)
> -             return ret;
> -
> -     if (smu_cmn_feature_is_enabled(smu,
> SMU_FEATURE_DPM_UCLK_BIT) &&
> -         smu->adev->gmc.vram_type =3D=3D AMDGPU_VRAM_TYPE_HBM)
> -             ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetUclkFastSwitch, 1, NULL);
> +     if (!amdgpu_device_has_dc_support(smu->adev))
> +     {

Kernel coding style checkers will complain about this.  Please move the { o=
nto the same line as the if statement or you can drop them altogether since=
 it's only a single line.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> +             ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_DALNotPresent, NULL);
> +     }
>
>       return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 48b03524a52d..d75f500b50ee 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -160,6 +160,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =3D
>       MSG_MAP(AllowGpo,                       PPSMC_MSG_SetGpoAllow,
> 0),
>       MSG_MAP(AllowIHHostInterrupt,
>       PPSMC_MSG_AllowIHHostInterrupt,       0),
>       MSG_MAP(ReenableAcDcInterrupt,
>       PPSMC_MSG_ReenableAcDcInterrupt,       0),
> +     MSG_MAP(DALNotPresent,
>       PPSMC_MSG_DALNotPresent,       0),
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] =3D
> { @@ -2680,6 +2681,7 @@ static const struct pptable_funcs
> smu_v13_0_0_ppt_funcs =3D {
>       .send_hbm_bad_channel_flag =3D
> smu_v13_0_0_send_bad_mem_channel_flag,
>       .gpo_control =3D smu_v13_0_gpo_control,
>       .get_ecc_info =3D smu_v13_0_0_get_ecc_info,
> +     .notify_display_change =3D smu_v13_0_notify_display_change,
>  };
>
>  void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
> --
> 2.25.1

