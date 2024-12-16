Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB75E7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 08:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A1910E3E0;
	Mon, 16 Dec 2024 08:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lSsLvMSS";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36CA10E3E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 08:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBZmDS/cnl5su6J0ho1JB6KFdnGvxEVaWBmoQd3BK2QxaPeA4wqmUDEjfy3HdjLtS1K1NEu3KEPYgW/WL9C8m9mjEFHNnyf6NMEcYeDjmZpGrvICLQ16omEoI8on8UcGeKzJMTw23KnMLjO0Kw2M/ZAafwAi6azb0DeF1vkTi4cgvGhgfAnN4bjo6IE5aE+98ZnZZnCOcFIAQqilRTSsFMf2793XCUO28lytq+OEGe9b77Cmie2K0Tteu22/q7wI/gWllCkAXduYbWYW7FJKcrgudSpPmeTW5yj+LPco7ESUoqlbZ/pGhGwcbaJqsjMXUH+XZvF1kz+owOl8JF/K5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT11/iYtUvH6NK3jQNXvi2bO2VtvVkOTXizXXG5zfe4=;
 b=kdenVu82clZiKZXasnQNQucp2EvyFmiJUGu7WB7l3HLB6F0wzmtD/y2AbGUhz3uLiBYrwYpWvjOxsImhuLR7Nlun7OwDxqekXNm07Ujk6dhxt1A5U/9gk/9MOjf/Lcpmt4/fISFEyAWK+ld+afSovqP3ALNrPk7wRVaM7MBujfjJvIjMArrRP9gvel2wVXeVUbZl3aXESDeGulnsxCGCS0BZUe/ZmMkkqEcH+NxM2CNFcTv3WoNpYoaWlMsIlTA04UM68o9sdTBFAfCA0HdKaJTu+s9czZs3QRABbKPQ53vrzqJ08mh3gjiwb8W4QEITNj/AErNNJbwW2fO0A9emAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT11/iYtUvH6NK3jQNXvi2bO2VtvVkOTXizXXG5zfe4=;
 b=lSsLvMSSY9SCIpw52XfQu9eO43JKgVspK7wHmWYFXFMPZeRrle+nRWgsDGAXHWJh/gu7/AyGjlOw+mF/5iaw8S4nVdrCRPcItTtGVFjTMIJxiS2TnMr20g+AR1ESC6FW3dNdtrcUUc2kWQU6DA77rOcng38mcIx7qkspPmFcxLM=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Mon, 16 Dec
 2024 08:28:35 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.8230.010; Mon, 16 Dec 2024
 08:28:34 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue for different asic
Thread-Topic: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue for different
 asic
Thread-Index: AQHbTVPzDlTkCqFvZ025vTjmsZnrnLLoi06w
Date: Mon, 16 Dec 2024 08:28:34 +0000
Message-ID: <CH3PR12MB807402223D2E84970D6D33B0F63B2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241213114059.3170033-1-jesse.zhang@amd.com>
 <20241213114059.3170033-3-jesse.zhang@amd.com>
In-Reply-To: <20241213114059.3170033-3-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4b98fd41-79d4-4dfb-88c4-d8e4d6701b06;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-16T08:17:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB7444:EE_
x-ms-office365-filtering-correlation-id: 79a4026e-1f6e-427f-bbca-08dd1daba17d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GvzwmjpsGnsGNWmRvL3hR6Ga9Xt/F/PMqjHk65cCgsSSC5srZQ16/48lX8Yo?=
 =?us-ascii?Q?4FkQrISg9NhNFi5NVKPGnkJmfn0ZHNYIdYrtYaQvp8d9XBjHEn7cMVYIcKz2?=
 =?us-ascii?Q?dM4pWrAnL347DRZqhOVeIDZ6/0+6H+GRKxhYj2ceYmaya851tjmmqbX5XKXA?=
 =?us-ascii?Q?7WbRjMqL23T7zsY6z3hHU5hSS+qtXlrRcyQXjHH7XL8Jp3NCVkGiFeLIsoMF?=
 =?us-ascii?Q?WQw13XGnCMNPCt4xGm3gmQMHWxYKKBcbQXywpewXodhgqjpketisZG57RYez?=
 =?us-ascii?Q?Ox64MFj8y7buaTBis3OKpAXmSHuzTqmyrK5r0kWoMUXXxnnr7ifuZSHi0/Yx?=
 =?us-ascii?Q?rk3E7sNxwM2XHA6IWCCHcu8XGetA/7crQzGTgMogAF20dYPHCfpV3XWjRKz0?=
 =?us-ascii?Q?Nzam9rOkN20m923ZwwLtuR4WsmgJP5LSjYsRjq3AxvOY4WRQCX6vTCERhEdv?=
 =?us-ascii?Q?+05RbzhI89ejf7DWyT/Fsv3YFANhopv//tc5LCxm9MNYbpeDo+MYFThzu6P6?=
 =?us-ascii?Q?Z3sGsERNlSWiVg4Mr/O6uLakkqQX0Wg1FYr282Nflyu+aCahNCdrKlQeSRT0?=
 =?us-ascii?Q?OjI6HR7Pr6rWqrn1zm2azUPH0khvLON9mm1PBc35jEATRrF4jJa9xScTLF7T?=
 =?us-ascii?Q?EkVmPYGxUrwq5mwPIr58yM5v06UItW9W7Fnj0HPyPwMAzm4W/+0TbjQMjhTt?=
 =?us-ascii?Q?6pCiXpTzOkZRt7DhGubcRuqFRSZvgPYcZqDic40plxndC85YKiUyrxK5wHUo?=
 =?us-ascii?Q?VEJRfAzIyiAD7vhLiYC1z3gqBKBZCoI4JHgwpJhA9mWSw4jYc9CxkmQW5LVR?=
 =?us-ascii?Q?zqkD/c7XNIxzfCIKxFH9zqayhn8JCbaVrPUvh5ANlzH/p8FOTfBTlRjrADmP?=
 =?us-ascii?Q?ikYbUTjpDirRjOjWreTspPcMe7/D47QFMQOtUruVRPBiLVRGJ9mvQ3UChCgF?=
 =?us-ascii?Q?CCG2roIeRBCQK7JKzV3mvbOWCdJT+F0hWm5/k9w4MiXwbfOyo0ndDeMwUyex?=
 =?us-ascii?Q?/TsI03O33+m6eZZC8o5xlO2z1uIrv8saHE2qVR18YiFXVFzPUEef2Qrk+g86?=
 =?us-ascii?Q?Umqej5NXaZQAMz0nUQxcwIjkMDCS5ckoqhchw24Jttlff8IrSAO9kQ0joeZ4?=
 =?us-ascii?Q?hP9yiJS/gLSqhqDRX7CQElajsSF3b+R4I9cqH4GIbn0uXBVWDGOhewo1jOJe?=
 =?us-ascii?Q?j5TPxl1shdOs+8rrHRD25J/kRnF3f2grd5FaSYJEsFfGIyRhlI/M4bcNV+34?=
 =?us-ascii?Q?2Bx5nusB7W9sH982rPG+Z83IZG8vLAtntnHNmrEI5rfAoDf/IcTBqRX9KHnc?=
 =?us-ascii?Q?Jv5L0x+9P8taasHvBFsfitMXspTdUKqwOU1xBJv3B0pA2pKQvOiLYCoqpHEp?=
 =?us-ascii?Q?e0GCrEYZaw45Qn9oLS+HVMjNEf6fIENEJUlabtK4SswhiRvHB4u0u0Tf/3Ws?=
 =?us-ascii?Q?BBjcl0QVcupd3FbmNzA8Pa02MEkOxdqS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KdAjlB1thMFEPdrLzVyk4ztHyUMcudDTlvBnpL9TycgdvkJf9PVKLWI3uJLp?=
 =?us-ascii?Q?X9sX2FjQWO4r50XL6JlnFE8JKGD8qFMtDf4P9uiIhPZYVYcqDcIwC7yAmq4L?=
 =?us-ascii?Q?cmmhBvuYLazr4cdIMViRAnj/ee6lPGJCkOJGunaMv551X9qwRPDXWV5iJEAR?=
 =?us-ascii?Q?sleNebNhWa/gnJGUrdtWFzyErI54n4ItpGEvQELVgCNDdGmLPaGVCCh4mnEH?=
 =?us-ascii?Q?QjfLnTutOWLrCzHv/4lJfLpwvtXN9oEPJuoSFo49JCtWhLFohXBTgb/EjSxh?=
 =?us-ascii?Q?kuYuXzMfjazZgctfZvQXJ24TnyHdNnv9puR6wOH6oSwe3NXU7+1fFdBP2IDc?=
 =?us-ascii?Q?9gMVPXTAthatKvezpOEAZYabHqqzi6Uw2Ih06gqM28dj7g3wKjUdLg1pgwGY?=
 =?us-ascii?Q?VMra7iBIFQCZpeaDGias/1yAKKUJIc7sbNh60UYLW+EAQS1eWUrMdfZlDeBQ?=
 =?us-ascii?Q?n8Y0EN1UQnvDMc2hD215Bm0fTOZV+Gcfzbq0ysQqlM65M6rSwrrMW19Q3PA6?=
 =?us-ascii?Q?27rkycjvSywl8ciOm7Lyc5XNGSvYkVAnCtg05E519ek2ML0gbC79CESjU45E?=
 =?us-ascii?Q?fYABlXwQXMQKmOD7RZ31z8njOzf3SvPAcpyedEHjnHxG2KUTGeZ3Q+Xg7HWS?=
 =?us-ascii?Q?tVZZQSezPvlx6h4OqI8PtFBQ6iqrEImi1qI0AMvveZ0bDHYDtOqEbMOB0CyI?=
 =?us-ascii?Q?EHdLWGMVO7Z75Z1ZLCe1K5qFgAv9Iqyqz4cIyHN/yqwEM9aOscXy+8U6Ui7D?=
 =?us-ascii?Q?UO0wal0Xy0WAnm0T4+oBkEylUy4p2Aesmc2wXaEOB4Bg3I7nbDCtpAVRBlw2?=
 =?us-ascii?Q?1+HbfDZZy51lzy02qQoydZDphGDWySkyd7eK3yo2VOWOPGpUUiF6R8vAeFQx?=
 =?us-ascii?Q?k7K7SMO/DwMYW+khcRjpqxHryyNn1DZ2FNs3UGcCvSMaa95jde9eW7EB/NeA?=
 =?us-ascii?Q?x0jWaEEkH/1glx1rCiHoOQ/y11yRuuWvsCe8wOnuUD76dShEKX1LFl60OXAQ?=
 =?us-ascii?Q?tavWZio05fK2uavqoJQv3YrRM4jW8lVXmQ36m4guI0r0DNnUnBHBp24sQN1l?=
 =?us-ascii?Q?vOvIKj1ddEn30Zu1nXpdhG164DCtTmFkndV5cAjfFOmOH33bg7XMpVzLLDq6?=
 =?us-ascii?Q?E7Ejku4wsi00XDLDVprC3HFjwbMFUfvl71y+ptAUSOJ3jbvoDlZHZaD8Ni8p?=
 =?us-ascii?Q?zP2tqy72tqukqZnzLZ+Ybj7ASJZyH7MulXadLdegBqxpUZasprCVVyKjs5fM?=
 =?us-ascii?Q?aNtoUid9owgjjjFxS1PJeaqZpCpCQWTlcvO0JUzIVq8vNEftPgZIsHLCKxAD?=
 =?us-ascii?Q?CAHsBx+SsQszutru0mMqPqxs9cm1WD3FB+Ye8Qwm7FovNtQHhFdsO7dGO+7q?=
 =?us-ascii?Q?kbA24FfBRTCYbNhi+gYiM5fykvhyXONhhDCOCuzc4DpkKCS9nMUN0PLZa+jk?=
 =?us-ascii?Q?tOc4YsTf5sRD18GVFHfbolr/cHKYKSLQ0OchBAwmaPwKtmcaGDalgixwPIq0?=
 =?us-ascii?Q?iG0n/+1cNt7m06Vl83NoMPN6/9lRbmRzMMH+Z8Bp6ZwfCLGtTE7RMmdPxOnG?=
 =?us-ascii?Q?eKxbeaB7kXJP3tj7bb0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a4026e-1f6e-427f-bbca-08dd1daba17d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 08:28:34.1886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JundymkG1PEVjweXHienbTgwgKxZ6p1sZaWeF8xSA5PdPGE+TIO4HUxAfwut24gXry+qLDX1On57ezEiLq4hPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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

Hi Jesse,

> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Friday, December 13, 2024 7:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Huang,
> Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue for different
> asic

Here missed a "reset" for the subject?
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> Implement sdma queue reset by SMU_MSG_ResetSDMA2.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 28
> ++++++++++++++-----
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 9222e7a777a6..e57d83099f4c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2724,14 +2724,28 @@ static int smu_v13_0_6_reset_sdma(struct
> smu_context *smu, uint32_t inst_mask)
>       struct amdgpu_device *adev =3D smu->adev;
>       int ret =3D 0;
>
> -     /* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and
> above */
> -     if ((adev->flags & AMD_IS_APU) ||
> -         amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D IP_VERSION(13, 0, 6) =
||
> -         smu->smc_fw_version < 0x00557900)
> -             return 0;
> +     switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
> +     case IP_VERSION(13, 0, 6):
> +             if (((smu->smc_fw_version > 0x07550763) &&
> +                 (smu->smc_fw_version < 0x080000000)) ||
> +                 ((smu->smc_fw_version > 0x00557700) &&
> +                 (smu->smc_fw_version < 0x01000000)))

Just curious why there're two ranges, Are they intended for two different A=
SICs?

Tim
> +                     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +                             SMU_MSG_ResetSDMA, inst_mask, NULL);
> +             else if ((adev->flags & AMD_IS_APU) &&
> +                     (smu->smc_fw_version > 0x4556e6c))
> +                     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +                                   SMU_MSG_ResetSDMA2, inst_mask, NULL);
> +             break;
> +     case IP_VERSION(13, 0, 14):
> +             if (smu->smc_fw_version > 0x05550f00)
> +                     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +                                   SMU_MSG_ResetSDMA2, inst_mask, NULL);
> +             break;
> +     default:
> +             break;
> +     }
>
> -     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> -                                           SMU_MSG_ResetSDMA, inst_mask,=
 NULL);
>       if (ret)
>               dev_err(smu->adev->dev,
>                       "failed to send ResetSDMA event with mask 0x%x\n",
> --
> 2.25.1

