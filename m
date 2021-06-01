Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090E7C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 08:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13C6601FA
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 08:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13C6601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FCDA6E8B4;
	Tue,  1 Jun 2021 08:13:24 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3390B6E8B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 08:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVod19mhLEfNYDWx5CTDQxHPSm9BxOkjnfzrKJFDV23qwyXbk+KgIahR8q2tt34rDv1sJv4rL/eSaUGJhLhOxyhhNGy4CNbLOI23Ks3jaERYfP2GWbScv2oS9jzbLdSSNnGTMYQYLNfP7kd9PzaaKkS9wEoTL11q/ITAYHNEt6uHhLTUKU3vyLM9liBjQ5vFoWVjRW6TRnJriF5SWIdRHEYGeNMRkzgF42KD+ASjknqepPRjPNbycVbrRz7o4RNRJAuaf9aRWx6kNoEITreSO8bpPv158Jiac6JDJVy2Qz2CE2ZDMumsglkpbxkThWgE8nu+AX5q2l/lYNgU6bmp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Idxkzj1uKiwTYHs6cwdEsc+3pUJtUklxN0RpfzJkLjc=;
 b=Gx5oz1fbgpuYg02uBQUC0X7QnLVenXVy5+/gfKcNVS/iizXsf3Q6Js+G5VKVUPJlwlxIFCoNHC7r6Cpe/Yhmx3lJ+mAKvVmpun/ztyedbrmda8ciWHCrD6w5oZQ1sdxhHpF88iWZPmUCe9z429g8K5M/pn9RT/afXDRjhKdnL0S2jx7wwLCbzkvyPM+78ZuO5SZNO3HBpzJsHWE+KIupr+kyhpW2KsbE/f6lzJuXxiy1yevbIPu/LkjnBJyTzYHF40hc/tM00e77iNQIQwS6JQkXJxD0f6iTd4YVNhm+8FMiCA8k6s9b57MY0psP+4YRJ2UdbQ2lauq/8cxQa4oS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Idxkzj1uKiwTYHs6cwdEsc+3pUJtUklxN0RpfzJkLjc=;
 b=LWHkTa0claxNawMn98EE466yVEHquNgRknFaLgXBZuFUNgSbpZprvKe9PH4Xzo6j+ZD2LJisxNc7/jofXS77OE4ThGHXhgECHSkf9oxfKlkEhlylz0UE7Gm44KGzkxQBH9sgATXC7bs21Bad77tx9Ko9c6UB23TVbaDnyr+DUqI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2506.namprd12.prod.outlook.com (2603:10b6:3:e7::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Tue, 1 Jun 2021 08:13:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 08:13:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable smart shift on dGPU (v5)
Thread-Topic: [PATCH] drm/amdgpu: enable smart shift on dGPU (v5)
Thread-Index: AQHXVhybQK+eHMJgt0GG3gMIvL4xu6r+z5Zw
Date: Tue, 1 Jun 2021 08:13:13 +0000
Message-ID: <DM6PR12MB2619A4679B240E9C097FE360E43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210530091929.30889-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20210530091929.30889-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-01T08:13:10Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c13fdb2e-8260-44f1-a5a8-4267daaec413;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5007179-07b7-4f57-8443-08d924d51a26
x-ms-traffictypediagnostic: DM5PR1201MB2506:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB25061982A44E77D895CC694AE43E9@DM5PR1201MB2506.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EonrUCwjefqF//4VLBzXXo+ZSL8P0WyGbN/1yXleZH4uHfyyx2FWEAXZfHw/839pnCJeGPruUW4O2lPjbAgnRGsqKN+WPnJCvSuPZExmQKaQ4mUCZlTjqsIbVBA6m4BC0zmDiZuDEaOC89ztpA3nYg0sLqSDXGEgQ9/1XILQnM0q70vhlb9ykAN3fHJG3IGnHAFqzZpRzn9b4ya/rGq6r5gAZvFHrwnQ6LkOPjxvrRkjrfk9sEWc1jig7IxDad2zMoUp8era+G8UKkg4GKJKEUpAJprlwyEj96hfX/YO1THGuAeVolcckKRVH7hJPKQAL7DzwInGAhH6JJckfxUwn0aQPg8mnuKl3VGadvT9vVmxx0r0gL1MIKr8krZj1MtsiW+q40XK4Mk8B4wUl7LnuqJbuJ7hc1QhIaTAM2woTAX6iiC6lQOPFVBYWP2KpZrQdBP9dN2+t/SjjjIlBEpwwYwPpeI/DhxNpwCLx595QJ4uDVy6hIMINIOsgTU69Ogc6pgu7SJ1iFAlmcE3uFGLp96cDBqljmkkoC1pNwJxWOs/iHIiT8u2FoFdAzMR/Hu3JZgJXoFzsju5+lTpnoQNCG747KS9bT1cw6s6DqJ0qYK9IfltZXBXdRxDCETL+wpmxZGJucSjJ7TN4CoP33OQjal+TbVJU4+57sEZjNi9T8/Ob0zbE8vxcpHJqaZCP37rGqc5rFVher1Ryqay4GhsX1kuYEgPqY5A2bktTeYK4q0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(55016002)(52536014)(966005)(8936002)(5660300002)(122000001)(86362001)(110136005)(4326008)(45080400002)(83380400001)(54906003)(316002)(33656002)(71200400001)(9686003)(76116006)(186003)(2906002)(38100700002)(26005)(53546011)(6506007)(66946007)(66476007)(64756008)(66446008)(7696005)(478600001)(8676002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x4yvTLbep8LMkCk2uPXni2X8cBLu8a/PivDkAbYTOZVmtAOt/+jmgMO8JrYJ?=
 =?us-ascii?Q?aIYYuIyA5MMcM/ewvSxERd7Y8kbooVdIGFtvcTgmvYQF1BuAjCuH7aLVQAJU?=
 =?us-ascii?Q?BWsnkP+haLxmtZCUesYtarRcLaqTG4BxSZ0McvZj+iSrGTv1BY0RIUbXHWUN?=
 =?us-ascii?Q?Zld2FLkvptwOPyRify9rJVK5nJxrLsizORV/2qlV4A731lMNgl+ed0/oigf8?=
 =?us-ascii?Q?kFSgnglTUbSa/g08Ua5jwyP/1wzQznXk+/MeCdYewx81GgXb3Medjoyb58ps?=
 =?us-ascii?Q?sQUrYa5pFj/JnnidfNLsSwYnnzur+bW/BmzfdGkWVugLiEftJmt5jKvVs2IX?=
 =?us-ascii?Q?AJvkzI9hgQt5e0iehj/hyKKEz/RN0Og2F3gtEj8yq/wOu903zsujXkivVid/?=
 =?us-ascii?Q?vzl4VLNxG42Do/JDx482DUIyIi09840ge0BjqRN9wEeGIBlBxGVqU+kUysOW?=
 =?us-ascii?Q?H1syfdXQfLm6O4iHTpVR/CXcYJPoJdpX8KWBsZd27faB586sU310121sku0b?=
 =?us-ascii?Q?xvJZu5zm46elppBWQTnx55D7dNCmPeJ1vX7Aag5GXuTN/RtHUh+jR/HvcuAs?=
 =?us-ascii?Q?FrGEa53QTseSL5R7kzvHq/2NPdVRqJJYmQnlgbhgeZ/zT1hLrhvu2tC6yXNk?=
 =?us-ascii?Q?Vn48x63hbffehxLqbfWrH/OHXJTRXFhDtL2IiCmtVf1Yyev+AhxgYl1kiLKX?=
 =?us-ascii?Q?y+4LOGo/gXg2bKRQlS36N3Po73L9B1S7XzH90pSvJkEZ8XfTo2F4EmKZrOUr?=
 =?us-ascii?Q?15zk9u8wwGQnCeVG3Mx2/tggSOhu3Ualcf+Vjqp2MJBodq+lPGEz6DCdExEB?=
 =?us-ascii?Q?Y/oqEoymMIeCAjGcFBXlySiUytaUnd9CTUUotQg3R6AgetRIZQND/11pvQda?=
 =?us-ascii?Q?XxePDYaBjOhN9soJiZ55K8A0fCg0wmFBGVxZ2xLg8FDb5BPb/8aJqQoLmhcJ?=
 =?us-ascii?Q?f6UOIdntN2uN7lrqDLSAX55ALNGhtcwz5/VGZAvi2SfM7Jlu2vM/n8BwYXrQ?=
 =?us-ascii?Q?z610cqi54kOkN5rOBcjO2PUzjXU6JtwbsQwG4DpdbsXbx4R4NS04gqIKr2pn?=
 =?us-ascii?Q?e0dlbiVo0fdqzRoG8Fru3dB19Cy9ELhShMJ5X8pEHOAxlfnN91uEJ8VkdNK1?=
 =?us-ascii?Q?aZrfxUjBeDp9R1iXCttslZTmaC7mjfuDOwskc9XIoxCZmW+xfv7yAk7Tieub?=
 =?us-ascii?Q?5oO9iekiFiyJ260EcDMlkoMEx8syedgGN1rb+bxcDmQwt8Vs+7rN4Z5Yg9BG?=
 =?us-ascii?Q?Pg90aAiSPBkg/mvOLbFmoiqYvoywmy1NV0Ti5k/AHcMw3FNnxDpe3SSs/f8K?=
 =?us-ascii?Q?Q53Pl80alBhS+Y2bQp5cYJew?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5007179-07b7-4f57-8443-08d924d51a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 08:13:13.3722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+uTmSREunjVqr1TAHUCbCiucAMeCNfj3+8UwS3ZyGfaAL0XON8HZci4Kek1B3or
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2506
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sundararaju,
 Sathishkumar" <Sathishkumar.Sundararaju@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Sathishkumar S
> Sent: Sunday, May 30, 2021 5:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sundararaju,
> Sathishkumar <Sathishkumar.Sundararaju@amd.com>; Sharma, Shashank
> <Shashank.Sharma@amd.com>
> Subject: [PATCH] drm/amdgpu: enable smart shift on dGPU (v5)
> 
> enable smart shift on dGPU if it is part of HG system and the platform
> supports ATCS method to handle power shift.
> 
> V2: avoid psc updates in baco enter and exit (Lijo)
>     fix alignment (Shashank)
> V3: rebased on unified ATCS handling. (Alex)
> V4: check for return value and warn on failed update (Shashank)
>     return 0 if device does not support smart shift.  (Lizo)
> V5: rebased on ATPX/ATCS structures global (Alex)
> 
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 18 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   | 49
> ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  6 +++
>  4 files changed, 97 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0ea2ed3a55f1..827533a543c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -130,6 +130,13 @@ struct amdgpu_mgpu_info
>  	bool				pending_reset;
>  };
> 
> +enum amdgpu_ss {
> +	AMDGPU_SS_DRV_LOAD,
> +	AMDGPU_SS_DEV_D0,
> +	AMDGPU_SS_DEV_D3,
> +	AMDGPU_SS_DRV_UNLOAD
> +};
> +
>  struct amdgpu_watchdog_timer
>  {
>  	bool timeout_fatal_disable;
> @@ -1267,6 +1274,7 @@ int amdgpu_device_mode1_reset(struct
> amdgpu_device *adev);  bool amdgpu_device_supports_atpx(struct
> drm_device *dev);  bool amdgpu_device_supports_px(struct drm_device
> *dev);  bool amdgpu_device_supports_boco(struct drm_device *dev);
> +bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
>  bool amdgpu_device_supports_baco(struct drm_device *dev);  bool
> amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>  				      struct amdgpu_device *peer_adev); @@ -
> 1339,6 +1347,13 @@ struct amdgpu_afmt_acr {  struct amdgpu_afmt_acr
> amdgpu_afmt_acr(uint32_t clock);
> 
>  /* amdgpu_acpi.c */
> +
> +/* ATCS Device/Driver State */
> +#define AMDGPU_ATCS_PSC_DEV_STATE_D0		0
> +#define AMDGPU_ATCS_PSC_DEV_STATE_D3_HOT	3
> +#define AMDGPU_ATCS_PSC_DRV_STATE_OPR		0
> +#define AMDGPU_ATCS_PSC_DRV_STATE_NOT_OPR	1
> +
>  #if defined(CONFIG_ACPI)
>  int amdgpu_acpi_init(struct amdgpu_device *adev);  void
> amdgpu_acpi_fini(struct amdgpu_device *adev); @@ -1348,6 +1363,7 @@
> int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
>  						u8 perf_req, bool advertise);
>  int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
>  				    u8 dev_state, bool drv_state);
> +int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum
> +amdgpu_ss ss_state);
>  int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
> 
>  void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps
> *caps); @@ -1361,6 +1377,8 @@ static inline void amdgpu_acpi_detect(void)
> { }  static inline bool amdgpu_acpi_is_power_shift_control_supported(void)
> { return false; }  static inline int amdgpu_acpi_power_shift_control(struct
> amdgpu_device *adev,
>  						  u8 dev_state, bool drv_state)
> { return 0; }
> +static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
> +						 enum amdgpu_ss ss_state)
> { return 0; }
>  #endif
> 
>  int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser, diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index b631316bfe5b..84a1b4bc9bb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -754,6 +754,55 @@ int amdgpu_acpi_power_shift_control(struct
> amdgpu_device *adev,
>  	return 0;
>  }
> 
> +/**
> + * amdgpu_acpi_smart_shift_update - update dGPU device state to SBIOS
> + *
> + * @dev: drm_device pointer
> + * @ss_state: current smart shift event
> + *
> + * returns 0 on success,
> + * otherwise return error number.
> + */
> +int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum
> +amdgpu_ss ss_state) {
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int r;
> +
> +	if (!amdgpu_device_supports_smart_shift(dev))
> +		return 0;
> +
> +	switch (ss_state) {
> +	/* SBIOS trigger "stop", "enable" and "start" at D0, Driver Operational.
> +	 * SBIOS trigger "stop" at D3, Driver Not Operational.
> +	 * SBIOS trigger "stop" and "disable" at D0, Driver NOT operational.
> +	 */
> +	case AMDGPU_SS_DRV_LOAD:
> +		r = amdgpu_acpi_power_shift_control(adev,
> +
> AMDGPU_ATCS_PSC_DEV_STATE_D0,
> +
> AMDGPU_ATCS_PSC_DRV_STATE_OPR);
> +		break;
> +	case AMDGPU_SS_DEV_D0:
> +		r = amdgpu_acpi_power_shift_control(adev,
> +
> AMDGPU_ATCS_PSC_DEV_STATE_D0,
> +
> AMDGPU_ATCS_PSC_DRV_STATE_OPR);
> +		break;
> +	case AMDGPU_SS_DEV_D3:
> +		r = amdgpu_acpi_power_shift_control(adev,
> +
> AMDGPU_ATCS_PSC_DEV_STATE_D3_HOT,
> +
> AMDGPU_ATCS_PSC_DRV_STATE_NOT_OPR);
> +		break;
> +	case AMDGPU_SS_DRV_UNLOAD:
> +		r = amdgpu_acpi_power_shift_control(adev,
> +
> AMDGPU_ATCS_PSC_DEV_STATE_D0,
> +
> AMDGPU_ATCS_PSC_DRV_STATE_NOT_OPR);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return r;
> +}
> +
>  /**
>   * amdgpu_acpi_event - handle notify events
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d1521e498e40..5c465db47aff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -263,6 +263,21 @@ bool amdgpu_device_supports_baco(struct
> drm_device *dev)
>  	return amdgpu_asic_supports_baco(adev);  }
> 
> +/**
> + * amdgpu_device_supports_smart_shift - Is the device dGPU with
> + * smart shift support
> + *
> + * @dev: drm_device pointer
> + *
> + * Returns true if the device is a dGPU with Smart Shift support,
> + * otherwise returns false.
> + */
> +bool amdgpu_device_supports_smart_shift(struct drm_device *dev) {
> +	return (amdgpu_device_supports_boco(dev) &&
> +		amdgpu_acpi_is_power_shift_control_supported());
> +}
> +
>  /*
>   * VRAM access helper functions
>   */
> @@ -3750,6 +3765,10 @@ int amdgpu_device_suspend(struct drm_device
> *dev, bool fbcon)
>  		return 0;
> 
>  	adev->in_suspend = true;
> +
> +	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D3))
> +		DRM_WARN("smart shift update failed\n");
> +
>  	drm_kms_helper_poll_disable(dev);
> 
>  	if (fbcon)
> @@ -3859,6 +3878,9 @@ int amdgpu_device_resume(struct drm_device
> *dev, bool fbcon)  #endif
>  	adev->in_suspend = false;
> 
> +	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
> +		DRM_WARN("smart shift update failed\n");
> +
>  	return 0;
>  }
> 
> @@ -4938,6 +4960,8 @@ int amdgpu_device_gpu_recover(struct
> amdgpu_device *adev,
>  			amdgpu_vf_error_put(tmp_adev,
> AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
>  		} else {
>  			dev_info(tmp_adev->dev, "GPU reset(%d)
> succeeded!\n", atomic_read(&tmp_adev->gpu_reset_counter));
> +			if
> (amdgpu_acpi_smart_shift_update(adev_to_drm(tmp_adev),
> AMDGPU_SS_DEV_D0))
> +				DRM_WARN("smart shift update failed\n");
>  		}
>  	}
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 524e4fe5efe8..c354ffa62483 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -91,6 +91,9 @@ void amdgpu_driver_unload_kms(struct drm_device
> *dev)
>  		pm_runtime_forbid(dev->dev);
>  	}
> 
> +	if (amdgpu_acpi_smart_shift_update(dev,
> AMDGPU_SS_DRV_UNLOAD))
> +		DRM_WARN("smart shift update failed\n");
> +
>  	amdgpu_acpi_fini(adev);
>  	amdgpu_device_fini(adev);
>  }
> @@ -214,6 +217,9 @@ int amdgpu_driver_load_kms(struct amdgpu_device
> *adev, unsigned long flags)
>  		pm_runtime_put_autosuspend(dev->dev);
>  	}
> 
> +	if (amdgpu_acpi_smart_shift_update(dev,
> AMDGPU_SS_DRV_LOAD))
> +		DRM_WARN("smart shift update failed\n");
> +
>  out:
>  	if (r) {
>  		/* balance pm_runtime_get_sync in
> amdgpu_driver_unload_kms */
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cb34e099047da486ff
> 38708d92433bd07%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7580626902184975%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> Jd22waXSR0n6h1FZvVubdij9G6UkQDLB2apshxBANxU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
