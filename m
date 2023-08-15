Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74891C001B0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 17:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0209610E267;
	Tue, 15 Aug 2023 17:43:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B31F10E256
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 17:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtFZ/iSc1i+7/GsdW1OtYJQOziAg3WxiXtxzha6gGZM+fljyGE0w6Lky17bGZVEZW6DNaF7a5YHtcV9lApNiXbfX8sL86Mwah3oHE9aip43XciQVKu9pUWlfglTFvo+WmH8H960ogou1C0eI4VDdUWKg0oBZlPCA2rZkgqjkQ49D8+oiXVO4j/kqMS/MUZTb5knO7pj7JoJIyGm6G0n+mrB4faxfBlHp2VzJCExT/XkbJJZtW1Gm1BMN/P+iMbM6+VtGgLJPp9dFcJkfNxOg/lyQywsHo8G7KFhnl5Smqjgb8lA+y+gqZ1XgXsrRmZyiCplPi+nOf1jqNBM5hHJSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzFxjZPkETkiIxxrU8J7SVP8XhzofgQDqcUOCDtUyAA=;
 b=LowMIVsziqNcbxX5/DIYd0vIWmxZNoB0WrhWp2q74qGgNy2TLi5C53JTLzAAzVamiMqS+CblzarzHKh53+JnNADb9GD9J2cltXNOJZgtTq/Gbmjkx2tG+3nLafXD2FQziVVY14Eqdmf0n5hZEvHI3wq43WenYUgdrAsd6UJ6uT2309VqkUikQOeOzN7ksmfc3xbx7B4LKK2qYcJRf0n2t6s+rvgUMjsyHeKe5mCym9EFpi2u0wWiaJ3Dw5yPe0OGUD6sV7OuZOU7SZ/dfWyk/mtmE9t46qeUl1Hboq8HFmRGIhlEcNGH7v9Coejzx2NpvEUEuZC9VUI1JCfqbX8KGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzFxjZPkETkiIxxrU8J7SVP8XhzofgQDqcUOCDtUyAA=;
 b=x2qIYN7q5IhjInHJelpslTH1qGWRYndkbQ4QUxPmllGo8j+FBr3Cute6pDVpc4uVj26isd7hpKPUJUatAK48tYp1wQvfMPM5JINH51rDHQru8gxAsf5lkOS5hjQcUaRfuhbyBYQIrO5AhDzKVNqDIopR2ifM4ttxVbQN4TE+dO0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 17:43:14 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 17:43:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC
 support
Thread-Topic: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC
 support
Thread-Index: AQHZz5BV0R3Vc/4D2EOYJAu28o3KF6/roGBA
Date: Tue, 15 Aug 2023 17:43:14 +0000
Message-ID: <BL1PR12MB514470FC4AD4C833397FBBFEF714A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <b737e90e-10f2-4ef4-b49a-2eba5f83afef@amd.com>
 <20230815155026.197131-1-bokun.zhang@amd.com>
In-Reply-To: <20230815155026.197131-1-bokun.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=559c8ee3-f297-4c48-a0ca-93c596831d27;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-15T17:41:50Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB5913:EE_
x-ms-office365-filtering-correlation-id: 0b800550-2c0a-4259-4bfd-08db9db71a08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p92KmTO68X3vqRCWfV8B0Nc8Ljx4E8NPRdXsmHz6aBBGlnuZ+vZBMR60vfateARkuo9Y2DuG01++M14l46A8LczWnA5yiBNNNvKQUJsjVRl+BJnid0YgXmhWeNgUc/S8bABnBcTllVccKjrc7Jkidg3XGLOLiIbDRMYObQEIw1Z/t5a6yE0U35xo+AxYwppBFDfZ6i4xBkuMOwTBRevERdUXw5yu0nECLJq8nDt6STE4nFHiejlO0Vu9NPMrlriYhBwZpbix8g7aFunf/IX8O78bYFfiz5by2xTOr3qOxn4IZ/Xc83+SZD8b8sPj1OQ88dVbIkLalJeetzesy29B5WJ3QKrrayFmuZZ0agW0h5ZzaZZQ8zEujN2VrpPrdixtfMI9coECr2E6C68j8FDH9NCLrqO5XkMopt/Kl8V0nLqQ+VKsRMekKILLr4VEyeTwG7Z6OzVxKeV3FRj1Gx17xhsRuJ21Olx2HKxLPtIVSn1qHEZWw37qFQJvYTQhUIcZR2KFw00SO3dUPfSAubo7Ovadt0AS/+Tk2ACUVTaAJ3GVOT8doGosn8JEE9qGk7w2bcyndorQTIqhEERhArv6uSTFA0JnvFYrG1WvPuSljq646d6H7PPR4KbyMFbm2dkQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(26005)(66556008)(110136005)(76116006)(33656002)(66946007)(316002)(66446008)(41300700001)(66476007)(4326008)(54906003)(86362001)(83380400001)(64756008)(8936002)(8676002)(71200400001)(5660300002)(2906002)(52536014)(38100700002)(15650500001)(55016003)(478600001)(38070700005)(122000001)(9686003)(53546011)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dU9kZrOOBAAmZ/yREiGjDF4beM1sLl0KOEI3LxYPavsG8Xfvf273H/tER8f3?=
 =?us-ascii?Q?e3lGwTOIr3Icx/XGOpGmkkCH24y7au9DkMQkNduOGXE+/Jv7JvR3BXOPgDPG?=
 =?us-ascii?Q?HzmSFZZtz7ezst1+x2gqrLoW+sjUo0J5H4wd2R/tlwHn8x5+K5vJ+ndR4Y7z?=
 =?us-ascii?Q?i5hcbfqO1GHe3sWmeWeRtMk5CAoat8oqtO7Vh0rG5AY0Q7t3/T7imQquw6dH?=
 =?us-ascii?Q?PIOOwhcD792y8+wnfjUC8DzXZMbEF6KN4Yf9PS54ZotLq+L6Vmw0yrGWIUrN?=
 =?us-ascii?Q?+3Btv0PHP5DpSbRm+ALRcI1+p9QTknnV83lV44BfMIBSOsR+AApTN3ddKuUF?=
 =?us-ascii?Q?5+Xfq4gtSQ098ulMTHgv64IhE3dGyJBv7k2ozXHPwyO1/RualiyxThQkxMLH?=
 =?us-ascii?Q?aCd36SLpJh5pARb1lA6o/QSHJZyM6Qstm1yZ9In03Ea02VyLHlcOimvD/s+8?=
 =?us-ascii?Q?XM/KTYXwIByYmJpB0xgIEDKblBi8bMBxnxtTsqLUv1B2LXk3NJUIQCaUkxa0?=
 =?us-ascii?Q?tt08gtOXFQg7Sssm/Sfo4UZDKKAE8gjCTGehtbYvne6D5SsJJ+DhUqFV7CLw?=
 =?us-ascii?Q?wj/ugvX9EznlO/ZFhpykThn8c52WS4nbZhiaQqWVCU4sYTHQYMGxpZe0oHZv?=
 =?us-ascii?Q?r8PVGGVDFJDFldN+LC0Nh3I/83z22N2CpX9jm+QCYD59xrBtpOXPxQUAVeV2?=
 =?us-ascii?Q?PDoJlbm8eDb7dZDWKYsuDU6hv26NafUUX+KwNfWRJdOF022TT1ivRMG6Dylf?=
 =?us-ascii?Q?A1PLYieA0G/5/JRxnpwBNVRXDKfcdM0CE7wL034+NmrJquxxSZhTEqtrSdo5?=
 =?us-ascii?Q?zzxHF4KPWzttFU9RsYLCYxSOvIOx7C7st1PFNqiaef62KibCXC7ezJA5CkXa?=
 =?us-ascii?Q?8KRYeryPjD8VSO+jHqJZSHcav4++yTDzKA2nqCgR7SE7OdSryAF6Ud3VdPDq?=
 =?us-ascii?Q?mt11P2Juw6UYNWcZoUjqkn7kykRM2Ev7JXohYXRToWMBQ7NhJWFbQ1mt+PL/?=
 =?us-ascii?Q?4+aQu2ZvBPLvlJRHK0ywxFk1bvE5kZXHWf8Fn2sNQ/zA7aTIXlLmKt+tEak0?=
 =?us-ascii?Q?S6oirik+dRq7BpMZjJbKIe0NN8VfHnEXmQeh5lsdP1lo+YtjLuGJc5+CJUEM?=
 =?us-ascii?Q?9EtX1lfRQZLMLjGTFymeTbhC1iRa8KH3DLovwtzVY7O/vMsP/GU306R9aBoC?=
 =?us-ascii?Q?o4PKnI+ADHvLCZ1SmUwBPjC0NBwvNhBtG0/+LSNvWZfaPHP5NfxNsv6EmFmz?=
 =?us-ascii?Q?ff7y/6gNILIkmOwCoYJeL1FU5N3E6O47MJxCYHe0ACT7LX4mVfbv5XpLcoD5?=
 =?us-ascii?Q?j6cf+caoqVdOc11VMFqgkk/PhmhCKotNOZXTQEWmvs4bMUvv5VI3I+z8t7kN?=
 =?us-ascii?Q?JA8Kgi4rYaOtlXPH1oRXmSAU6f4UMEduL+cRcYnhh6ezNLhUb6cHatAiNG3L?=
 =?us-ascii?Q?+VKa6S+hlWhystFXnicTlxiB2SPZ4m7yW6FAA//r3wHG/KplvbVN3UyyJRzp?=
 =?us-ascii?Q?a0rGq9G8Fs5EmKg2zI9pJMOZrhVZ+oR9jdRSUxr3QKQ2ptXkC5jyGEg2kOQz?=
 =?us-ascii?Q?dgjRdVNScnt7fp3pz+k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b800550-2c0a-4259-4bfd-08db9db71a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 17:43:14.3954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvRJ6DckTnfSQhbnn40exVVETvs8vBXJ0iBl7wX5NqzFJPfG4UkA0rmc+xcsu33j7OOamlFCnB3fQSyw5tlDVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun
> Zhang
> Sent: Tuesday, August 15, 2023 11:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Bokun <Bokun.Zhang@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC
> support
>
> - There is a DPM issue where if DC is not present,
>   FCLK will stay at low level.
>   We need to send a SMU message to configure the DPM
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                  | 6 ++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h              | 5 +++++
>  .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h   | 5
> ++++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h               | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c       | 7
> +++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h                | 1 +
>  6 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f005a90c35af..c65bebdbec11 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1410,6 +1410,12 @@ static int smu_smc_hw_setup(struct
> smu_context *smu)
>               return ret;
>       }
>
> +     if (!amdgpu_device_has_dc_support(adev)) {
> +             ret =3D smu_notify_no_dc(smu);
> +             if (ret)
> +                     dev_warn(adev->dev, "Failed to notify no dc support=
,
> driver may not reach best performance\n");
> +     }
> +
>       /*
>        * Set min deep sleep dce fclk with bootup value from vbios via
>        * SetMinDeepSleepDcefclk MSG.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 6e2069dcb6b9..c8fdc3d0aa25 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1356,6 +1356,11 @@ struct pptable_funcs {
>        * @init_pptable_microcode: Prepare the pptable microcode to upload
> via PSP
>        */
>       int (*init_pptable_microcode)(struct smu_context *smu);
> +
> +     /**
> +      * @notify_no_dal: Notify SMU that there is no display and SMU
> should control DPM

Fix the function name in the kernel doc comment here.  With that fixed, pat=
ch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +      */
> +     int (*notify_no_dc)(struct smu_context *smu);
>  };
>
>  typedef enum {
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
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 48b03524a52d..41412cf891a7 100644
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
> {
> @@ -2601,6 +2602,11 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct
> smu_context *smu,
>       return ret;
>  }
>
> +static int smu_v13_0_0_notify_no_dc(struct smu_context *smu)
> +{
> +     return smu_cmn_send_smc_msg(smu, SMU_MSG_DALNotPresent,
> NULL);
> +}
> +
>  static const struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {
>       .get_allowed_feature_mask =3D
> smu_v13_0_0_get_allowed_feature_mask,
>       .set_default_dpm_table =3D smu_v13_0_0_set_default_dpm_table,
> @@ -2680,6 +2686,7 @@ static const struct pptable_funcs
> smu_v13_0_0_ppt_funcs =3D {
>       .send_hbm_bad_channel_flag =3D
> smu_v13_0_0_send_bad_mem_channel_flag,
>       .gpo_control =3D smu_v13_0_gpo_control,
>       .get_ecc_info =3D smu_v13_0_0_get_ecc_info,
> +     .notify_no_dc =3D smu_v13_0_0_notify_no_dc,
>  };
>
>  void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> index bcc42abfc768..9b9a13fdcef8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -97,6 +97,7 @@
>  #define smu_get_default_config_table_settings(smu, config_table)
>       smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP,
> smu, config_table)
>  #define smu_set_config_table(smu, config_table)
>       smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
>  #define smu_init_pptable_microcode(smu)
>       smu_ppt_funcs(init_pptable_microcode, 0, smu)
> +#define smu_notify_no_dc(smu)
>       smu_ppt_funcs(notify_no_dc, 0, smu)
>
>  #endif
>  #endif
> --
> 2.25.1

