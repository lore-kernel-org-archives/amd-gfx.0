Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFD2C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 06:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF94A10E11B;
	Tue,  2 Jan 2024 06:45:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FAF10E11B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 06:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFnUR4CmKqLq74VljdynRnTXDK/8MHK4Gl773xmh+P5RaMdXdMR0ZfHo+YZuUPUnZQRj6XlJphfx/7Gt6KAvf/SZAOEmz8mm+WlwHGw5Y1e0fI1vgWF+s7xZTangrhPt7xYn21nkvIzGksxdyIj29y/Wszh0I/uXZFhASg3PI4krShXsC08uMPVJOPKOSELxkabDfZ/+uAck5Rjswr5XacwGgIk8K4wLUrUt8Z4m/vYUI1eBPOaNTp/A7QFyymSbcy+CzgTQX81cPxopOcmdiwHLn/CDcvsApzfF4wvtRw7XDvma8xlsQOcHulcwJAbnzMUHS1u3M0rQ0K+Xh4R/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ulpSy2ZQZ4ElVxL/oy5zW16/p6sPb6JlNCC3+4FA7Q=;
 b=hlS/GzAeXkybwMsKnBEIlfzLwbXoob4crrZXku9Oq99Qg9DhjX8uMFR+QnS6zHJHtwxaLBaJb+RIM1CTqk0G1B4kd2erbXKPeVhPv/3/blJPXCjXs0UflnefaggBT87ksx58XnCrzrMHcfuYR6RDtAhUWlFi07S6KyCScTwQHTPibSvbFbkg4KmiQcoCn5Aw7l1q3he77sJSRuZp1vGas3OjHjg/JF0suqiJdqy8BdV2wSm0ua92V/oS0PMd+YdTO7gMAjm2FgxH0bx0YWG/bcNa5F3YDERE3xKjyJyb3OT1IAD2yoM1F7yR227kh3LkYxzY28WN/agmnyOONfDPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ulpSy2ZQZ4ElVxL/oy5zW16/p6sPb6JlNCC3+4FA7Q=;
 b=BcgfBqwNqfMt6gyr9imvvSwghkcXcM3QT6hUtg0sP5KU8WEawAE4NPqL2aY5mkeZ3PPDZ9S5LuGZ2eSjWNS1GhTcBTwbF4isDMCHMZc2bzWlW+mElQRhWmUwcsobELMJC4chKyYm9Mc+GnXrSvxFBENNOFpBJ7vV0wGpRUFAJtY=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 06:45:12 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::4a15:c24b:91e2:8ea2]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::4a15:c24b:91e2:8ea2%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 06:45:12 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors
Thread-Topic: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors
Thread-Index: AQHaPS35DVBrHRLktUuO5qaS7OYSWLDGEyzA
Date: Tue, 2 Jan 2024 06:45:12 +0000
Message-ID: <PH0PR12MB5404E107542E0272338B7D2DF661A@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
 <20240102034341.16321-4-Hawking.Zhang@amd.com>
In-Reply-To: <20240102034341.16321-4-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e5a43124-0c8b-428c-83d8-f9ce9122f86e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T06:41:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|MN2PR12MB4254:EE_
x-ms-office365-filtering-correlation-id: 4e4c93b1-aa11-40d1-c280-08dc0b5e5ec7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6lmmzW8dd4c1h0uFJ0cmyU9cquabNbmV7thXHvh000bmgBc99BeX1bwmWFqobn7aKvHUrKYhgoQo8C47bssEKS/7OrtsrWnQECw2K6opyCOIXyymo7NHU+74EuxkY4EF+RaxQCA+qfAQIOvufphOMFoZ4fj6ny6PL5eW3xxq3LxYDr6+SC6+Q8B2IhH1G0dRTobwvQaPKioW5joRfAc71YcQojEMf0F6ODP1drYclb6N7WOP9mVmo4YoVDf0M/zme6aEFiQND/WTztiJiyN926Er5uQ0aAR3GtHF7KYz/CFy5zeAk+g4vVmtjrXA+yTql8XutIwVsiWGT1ru+oZ8l3e7PpnPmvGbeJQCIPmWsxEJSAxqDxysYON7YTXs5A7wSGWKUtFvVMzDNj42CoH//0ySG/lwIev+5do7b+tYDU6LnRyWitG542DQwnR4Y2b5NZQ0Wj0E+dNr+VxMKuGmbwrwkDCLUPzJyu1dFbWLv0LpkNhtTAfrnrZ05rbRlPFw6INGKnZWP38z2KpPk99ij61xUeucxkg6gbLDY51yCw9CN7Aj6HRoWY+aSDxtFk+rqtcQxySZhki6zASuF94RkJbl/GGAUAQLkykyfRtJjap/ThcboWVBUIfM06n3kaGjBsA9DDYPgDIpcTOsLSHJkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(316002)(478600001)(8936002)(8676002)(4326008)(54906003)(52536014)(66476007)(110136005)(66556008)(6636002)(66946007)(64756008)(76116006)(66446008)(83380400001)(53546011)(71200400001)(7696005)(6506007)(9686003)(26005)(5660300002)(2906002)(41300700001)(33656002)(38070700009)(921011)(122000001)(38100700002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mePDnbHZRPuzgie66nD0USwGEv10v3O1KrrhhOs9AJ7AMeSbcrLZ16tBKTkl?=
 =?us-ascii?Q?mjt8z0FXQm5PtdnOAYiJaJK6AylfEZYBp3nO9zDrpI2WwnFYAoldCBjqCM3w?=
 =?us-ascii?Q?cAHAlU/4z9hZ0SwYficxKBQmsOZAwpE2ZfTsERUySIps1ZKf1vwIgK2Lzg7m?=
 =?us-ascii?Q?ySt+4DNpKI0VMtRFO9GdHdhcJIu5gu8CzZCPRC9OMdJbWrJSTo8umh7VPSSU?=
 =?us-ascii?Q?m0+fX2zGaUY83NVXi8CuqlDg3T78WN/m75h4L1g0/oWlIM3xMWmD5w+8azMD?=
 =?us-ascii?Q?pzD5kBLcFx/AunvkjU7Dm3L5pV7DRa7HGqlFijF1JbhH41XCJpzc9tPxRgHw?=
 =?us-ascii?Q?qw9vmesy78Faoa7IY/c/QFeIk/xHHZWBdYLhut4jUJyZNmLIs0e3YZWFdw/j?=
 =?us-ascii?Q?kbaq+wmPkDDo2ChlOG6dk92+XtgKXVwC2xScGLe+jjBxVYFJJmNiCmimccaS?=
 =?us-ascii?Q?7JV9lO9A0pMWbR5EoVEJwWJcjHD5S9frUMv5zfoL23xiHVlpEnW8RKmiE8Mr?=
 =?us-ascii?Q?kZKs5sAjuUK0UDSRaW4AgfTTFNrISOJovofxDrXMrtTXSRNBp6pyzMXX9jRx?=
 =?us-ascii?Q?YYDkXSguUFWobD6JBj6sQVim/oYi0q+Q3IV5AK5iWgm5OoTWnZ2YvYQgQPm3?=
 =?us-ascii?Q?wI34nqxuQ79jIBd8zAD/3/hTJVX/E54LGWdVuxkIWLz8e2VUvZkpxcBWjVjh?=
 =?us-ascii?Q?6EDMcDk6c+79eCd0DfknokhQf8pPkVP91HU/aXybE4xHkXb5pP7O4KJ5DFkR?=
 =?us-ascii?Q?kjsjeUbiLgDJbmx6SsVG6mwMwo1Zbkz/2l9LOxnYDglruBNEJs+lzfeniSc7?=
 =?us-ascii?Q?e8glcAUfgNDUIRMvWLvu3yREfm3F6bjHnIoN1PXtiqp21xhoxbXuEx5Miou/?=
 =?us-ascii?Q?NjJmTd3FUaIJcd66SAFQfh4dgzbqrcjwxI3hBglrWtw9KbxbLneKrata/Vcw?=
 =?us-ascii?Q?5rKkwsjX9hlfJrVo3ed0zox9OD73qHCk49wBTDpfyQXkGXMLQ+U64pG3qrOE?=
 =?us-ascii?Q?Z2RnP9jw5RI55fCuzvxhZhuD4lWbWwcJqG5X+ne+w8HQRkx0qH7lAb45vjl7?=
 =?us-ascii?Q?CC7NDqlvb9U0mqzvDfEWdxt+WVDs1k7vUkuKYlRlVWsK08KHvyJUNMg/l75H?=
 =?us-ascii?Q?7E2gJPvXmEjfn08WSSPcu2wOwB1Mw9vX1HX10JCoC3D6KIcOVFld3PEiH2NI?=
 =?us-ascii?Q?g6a4JcYoaGNTOIneOMMB6nkErdrqCJKyBaHt7FyfnmWuiBvmNie1ehzTo50f?=
 =?us-ascii?Q?83wAJbnMuEf0Qo/WGs16Z5HAxN42WzwHiituz5fcctNhHmBsZr5pJtKFrzXk?=
 =?us-ascii?Q?6q/rwFziymDczj5HMQAoAOIdAKBm/trOD/wqUW2NGFfpx1jVxDQTomfcWRXh?=
 =?us-ascii?Q?aeMDFutumPB0y09Ig/jg99p57wsj1N0NWY9DSgDIUoF+ugcDKCUXhwF7dqo6?=
 =?us-ascii?Q?AXorhxeBO0zwkJe6BaS0Q3i+hQy4mUlhUYVM/aK5v1ryhzxrchPK0E+QKL9i?=
 =?us-ascii?Q?rUUoBhLmHV/exi7WRmJGHzNpnsnJbU7jkOVRBwrr4F3NSUEp8Qst+pEpjKTC?=
 =?us-ascii?Q?hLrbJbCA2DCK7do1ev0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4c93b1-aa11-40d1-c280-08dc0b5e5ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 06:45:12.4247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9w3Q7jq4wweavYCq1Wx8baxHYc73B6pV8sNmKFWKyR1HKhrAoHAUGnV+52oEDuO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Tuesday, January 2, 2024 11:44 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le
> <Le.Ma@amd.com>
> Subject: [PATCH 3/5] drm/amdgpu: Add ras helper to query boot errors
>
> Add ras helper function to query boot time gpu errors.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 95
> +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |
> 15 +++-
>  3 files changed, 112 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 616b6c911767..db44ec857a31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1328,6 +1328,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>  #define WREG32_FIELD_OFFSET(reg, offset, field, val) \
>       WREG32(mm##reg + offset, (RREG32(mm##reg + offset) &
> ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
>
> +#define AMDGPU_SMN_TARGET_AID(x) ((u64)(x) << 32) #define
> +AMDGPU_SMN_CROSS_AID (1ULL << 34) #define AMDGPU_GET_REG_FIELD(x,
> h, l)
> +(((x) & GENMASK_ULL(h, l)) >> (l))
>  /*
>   * BIOS helpers.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 39399d0f2ce5..5f302b7693b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3764,3 +3764,98 @@ int amdgpu_ras_error_statistic_ce_count(struct
> ras_err_data *err_data,
>
>       return 0;
>  }
> +
> +#define mmMP0_SMN_C2PMSG_92  0x1609C
> +#define mmMP0_SMN_C2PMSG_126 0x160BE
> +static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device
> *adev,
> +                                              u32 instance, u32 boot_err=
or)
> +{
> +     u32 socket_id, aid_id, hbm_id;
> +     u32 reg_data;
> +     u64 reg_addr;
> +
> +     socket_id =3D AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
> +     aid_id =3D AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
> +     hbm_id =3D AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
> +
> +     if (instance)
> +             reg_addr =3D (mmMP0_SMN_C2PMSG_92 << 2) +
> +                        AMDGPU_SMN_TARGET_AID(instance) +
> +                        AMDGPU_SMN_CROSS_AID;
Hi Hawking,

We have asic function "aqua_vanjaram_encode_ext_smn_addressing" for this st=
uff, maybe it could also be re-used here.

Thanks.
> +     else
> +             reg_addr =3D (mmMP0_SMN_C2PMSG_92 << 2);
> +
> +     reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr);
> +     dev_err(adev->dev, "socket: %d, aid: %d, firmware boot failed, fw
> status is 0x%x\n",
> +             socket_id, aid_id, reg_data);
> +
> +     if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, memory
> training failed\n",
> +                      socket_id, aid_id, hbm_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_FW_LOAD(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, firmware load fai=
led
> at boot time\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, wafl link trainin=
g
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, xgmi link trainin=
g
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, usr cp link train=
ing
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, usr dp link train=
ing
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm
> memory test failed\n",
> +                      socket_id, aid_id, hbm_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm bist
> test failed\n",
> +                      socket_id, aid_id, hbm_id);
> +}
> +
> +static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
> +                                          u32 instance, u32 *boot_error)=
 {
> +     u32 reg_addr;
> +     u32 reg_data;
> +     int retry_loop;
> +
> +     if (instance)
> +             reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2) +
> +                        AMDGPU_SMN_TARGET_AID(instance) +
> +                        AMDGPU_SMN_CROSS_AID;
> +     else
> +             reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2);
> +
> +     for (retry_loop =3D 0; retry_loop < 1000; retry_loop++) {
> +             reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr=
);
> +             if (AMDGPU_RAS_GPU_ERR_BOOT_STATUS(reg_data)) {
> +                     *boot_error =3D reg_data;
> +                     return 0;
> +             }
> +             msleep(1);
> +     }
> +
> +     *boot_error =3D reg_data;
> +     return -ETIME;
> +}
> +
> +void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32
> +num_instances) {
> +     u32 boot_error =3D 0;
> +     u32 i;
> +
> +     for (i =3D 0; i < num_instances; i++) {
> +             if (amdgpu_ras_wait_for_boot_complete(adev, i, &boot_error)=
)
> +                     amdgpu_ras_boot_time_error_reporting(adev, i,
> boot_error);
> +     }
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 76fb85628716..5785b705c692 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -32,6 +32,19 @@
>
>  struct amdgpu_iv_entry;
>
> +#define AMDGPU_RAS_GPU_ERR_MEM_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 0, 0)
> +#define AMDGPU_RAS_GPU_ERR_FW_LOAD(x)
>       AMDGPU_GET_REG_FIELD(x, 1, 1)
> +#define AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 2, 2)
> +#define AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 3, 3)
> +#define AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 4, 4)
> +#define AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 5, 5)
> +#define AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(x)
>       AMDGPU_GET_REG_FIELD(x, 6, 6)
> +#define AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(x)
>       AMDGPU_GET_REG_FIELD(x, 7, 7)
> +#define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 10, 8)
> +#define AMDGPU_RAS_GPU_ERR_AID_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 12, 11)
> +#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 13, 13)
> +#define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)
>       AMDGPU_GET_REG_FIELD(x, 31, 31)
> +
>  #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS                (0x1 << 0)
>  /* position of instance value in sub_block_index of
>   * ta_ras_trigger_error_input, the sub block uses lower 12 bits @@ -818,=
5
> +831,5 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data
> *err_data,  int amdgpu_ras_error_statistic_ue_count(struct ras_err_data
> *err_data,
>               struct amdgpu_smuio_mcm_config_info *mcm_info,
>               struct ras_err_addr *err_addr, u64 count);
> -
> +void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32
> +num_instances);
>  #endif
> --
> 2.17.1

