Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE8DC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 09:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E54BB11BA69;
	Thu, 30 May 2024 09:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CJPfNCEr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8266B11BA68
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 09:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8RvfcY4eJo15W8GJEAsgz/GUQVgKwwoOHsy32wL2Z04K6Cyflw30MlY9rzlVDgUH1MueuyB5Qy/cyA9gn1VsWRzsH7V8trjIvOiCrTr6qTJ2BVxCx5tV0J5Sfve/S8c24hAhXDtU6BF9b5P38dBCj9iSbgKi8iAZrHLkk5lColmExO3dQNGjc4Tu7rKZGWbfEKGNTo3HF4hlAqVARfLmw3Dg4pIzn7dd69WEp2ttfbYaV9vJdoXISZQ532vLM5rJSsDlYeeSU2wAufPGRefL3mD/wu+EczAe8gh27/uK9+/qNHTHKM/WTBEMHZf7eRssckQlNOCmSoz9m4Uep3f/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGHXZ19krLLKL9WA+aqss7Vc+OsT1Lojsbli+MEL+A8=;
 b=YyMsfeuMjgD9m3/TWAOclcIcUfLf+sa3ODJQKxoAjKU24ai6jWYbsK92LWgsaiggMUO8EXvl7l/rznXoKsFAR1YY++P3AQSt8/iKgf1zTtNuUjEPZTIwJJhQGGXcXYDyJ9ITujq6MMTxLRun80trD3fwxvr88vwtOZBF4GFkLYpoGMoMs8+IlwusGVg2+RbVnZ/Bp08fGKMs/SGP7kfWTz2bHGbo2615GTFQ21WQT0U0E/OqOmBOhrGcWsTrQuEUiKydhE6I1xmRKx9YckhU5+AQWjhMt0+taTAwQyvWkRQgJdClS2/3dpGMOstbSYtDmcnkVGHFdGCFqNppInyKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGHXZ19krLLKL9WA+aqss7Vc+OsT1Lojsbli+MEL+A8=;
 b=CJPfNCErMOZt9SqUzmO9QlXeMP4AtbqdfzF0nKZOwDv2mIW6suOG3STagHgm1E6LC5qzaEVJgehd6MHvS3ZskP/K9h2L1J2bKJUbYbBqX3jg5PHr8BWy8GGnix7gOr9wkZz18gb5XxES9RlJsdygQXjfZGCkJ2GPwwUvj4VWaK0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 09:16:48 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:16:48 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update programming for boot error reporting
Thread-Topic: [PATCH] drm/amdgpu: Update programming for boot error reporting
Thread-Index: AQHasm0fYJ1U4nAHJkmLVVUh6lY/I7Gvfurg
Date: Thu, 30 May 2024 09:16:48 +0000
Message-ID: <PH7PR12MB879631D9C2691C3A95B7F4F9B0F32@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240530084058.8512-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240530084058.8512-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=787ed9b0-35a6-4b01-b0e4-731de02b013f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-30T09:15:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ2PR12MB8738:EE_
x-ms-office365-filtering-correlation-id: caaa10ae-a7b2-4483-7e56-08dc80893c08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?gQF4rai7ize6JoAhZDvR/2w9YApnugTq92L+JOuAAMGWscL74Wo+V9d50y/d?=
 =?us-ascii?Q?yE5iw8tRY2mdF5fgmDUwxFQuytukK+HTKI7uCbPEhK1imRA7JY+mJ4gWipFe?=
 =?us-ascii?Q?IMWRNteMzRdSucfhTBnHGuQHK+4wugLMjluW3pPL9LnMLi6ISIaKQLmwDPEz?=
 =?us-ascii?Q?hIYw3SgWZ+98n0r/Q1S4CsHG2SbPKkT3wZmUQoV+44zAmhTrKPKqLhehe6KA?=
 =?us-ascii?Q?fUg6TsyKDUkS27wHrMVK5T66mEZAQcSxQSf/EnhT/SaAA1LaiwYtLaid8zxk?=
 =?us-ascii?Q?X4KLJgeKU+qTqCw5gMUDMJH3nOPlGsDOfvQrzPZfEQFgCFZzfeBVJ4K/TZtU?=
 =?us-ascii?Q?stES4kB+pMJ0x8YqApWleoQV5JsJxyLBpqhK0scXeLXPRPwyWsp84dukm1uw?=
 =?us-ascii?Q?nhXvBhHqULl8d50hLxYAM3r8loa/WCl26TUv0K1ewBe+slzyn9kAdafyGk5t?=
 =?us-ascii?Q?bAIOdedbjAdKQkyjEbiEZAmSPJxLBZBq4qYkJ81z4U584gVk6YUteS3isCse?=
 =?us-ascii?Q?4H6LyNk1Kj9uNpqb2dtzX6BIIn50VlKfoqUjMqC2rTum3/a+oqnA+Jr2xhVj?=
 =?us-ascii?Q?MI+X5eZGyoTNy1YV8NgTWv/C+c87WLnBeORSIAt3aG42G5uxB3jVCj6E+kpe?=
 =?us-ascii?Q?mBl9s9yRRdisUVS8yvkk5PlMFdJQRKbBhu/NcoE9eS21E+6/Y86ZVXOLsRD3?=
 =?us-ascii?Q?qj9uwyVE9cx+DilAEN4sH3dY7rruBGC7aJcEi2LLNFOJifYOzSoIzwO9Icuy?=
 =?us-ascii?Q?R3jrUVaRGjru9KyjJCQhwM+dJGEQ88Q8ipRtmfB9wzpKpzcl8jLMGyCs1nPv?=
 =?us-ascii?Q?FjwWKt9f8byOZ6g4cXT+eaIuPInJCRjDD3kNXpT/AbA530cB4lTscMxsWx0A?=
 =?us-ascii?Q?6ozsdmqWNQrSU+7u67MJ8jPWn/7fLnkeim0GXSvl+FVZrgG0ngPPcokNaIfR?=
 =?us-ascii?Q?gyPE/t3CSLX6Wmkg81MFATizUagsAIkB/Y55+OcGSVnlzVeups9HhaWHoS//?=
 =?us-ascii?Q?+2JStSaP16z8i/8GHwnfLtFwQPeKOnBJ4vMOq8O/lBm5Cixt1vzO79g7IdFa?=
 =?us-ascii?Q?OffMyBWQ3gppSRpTi0M+GuI7bv/aUiMkevPISUcA70Us7annZ5BKWKNBZP5u?=
 =?us-ascii?Q?JaD64w3EGHG7b3dikampWfcRFBWw036rXnDjvgHkaPLxHSimqxFmN1Mj67bz?=
 =?us-ascii?Q?+czcqorJFenANqvtr1dzRUs3JZ+W0nYSNGIYDEbWo87wx93ejlkeyDORceaT?=
 =?us-ascii?Q?XObRz6EfHQxJmX9udpxvLSlAfBh7O/i+evbd3mvtn4WeBfLJcx2seAKT2z3N?=
 =?us-ascii?Q?Ysrf4ngUUHlSZgB48s6b2eDdx/Z5Ay8E+JaE+aJVtFVQpg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KB7pe+QsqF+ePZ5vepRFRC3Q8kcsXSk98SV1p5JzptLiSOW4nHTxsJp8nUSd?=
 =?us-ascii?Q?4/mZ43HmN11/j+djFZfe2cG22RbQxCdK5x3+pS4ICZzzvJKL1pAk6gMRwlQv?=
 =?us-ascii?Q?N/87HNSfvsz/tjfclTG+M+dMGDPf6yyeAeDw/qd59UKKR/H56CLgFxRMt07P?=
 =?us-ascii?Q?+NuF14JhjLXH2cfy209y/kTkxaZlT0mtL/0zTi1xoo7aouRwdaZygANEAv4B?=
 =?us-ascii?Q?GzSdO5JeC+Xzl4I8MaL91oKAKH7IjJX8kWC0VzBXAXWWY/gOtdKRgG0g40JA?=
 =?us-ascii?Q?Zhw4PEiohkSbJhs3kE9H3MJJGS8IuBo/IQYetmGTKdzfv9/LOH0GFd0SCLf6?=
 =?us-ascii?Q?N4DtptP4DtbpgIL4XUBkIBz7cgFA6V0bMnSgucQt7AJ+xCTsYUwp4LdqFNx4?=
 =?us-ascii?Q?C1XThXQk1uvR2o9SfWR1pZp9TcZWDrl/EOdrFsIYtZYGgjNt3SEK3f01LWGe?=
 =?us-ascii?Q?nFuREcA+9wtEotEKtIgVd45b6Iz9pviOcLNoipROPmXEZsdcz2PJxXBs/3Pu?=
 =?us-ascii?Q?r1VbY1S8QoNnVe2kFmpcusn0Io0t7BLeNvvd4uyRiDn+uLuphyHZgKZjXatw?=
 =?us-ascii?Q?84jIRfpnkC7RqROgx/b0YHefFJLRhVNiYY9C5Fb0/JOSXsvUoW4w0mARGJxW?=
 =?us-ascii?Q?F1nHy6wnxsF18T9zDayfPIMUTPwcV3FJ78fT2xuzclWB16ODkwkQhNXRHIl4?=
 =?us-ascii?Q?OfWc9lwGTAiwDjNS4VCmvlvm8zH8QGSFKxCaRjm8euWIC9PlNV+p39O2WOW8?=
 =?us-ascii?Q?sS8+C/iYcPLR4hVkg6vH/aYR+MHu2dQDkXZ0TJvBS9FwLU+tQHv1ygeKAkZP?=
 =?us-ascii?Q?ksxTUJzzRrkRSdEspik7+eH8dHTnCWLQ5H98YA05wgYmyF7Tbr4Ed3kCYJV/?=
 =?us-ascii?Q?GsAZhdfjr6/274ZfJjgIS5ReWsWfSi8j+SQNRqDsodNRAuwe2xi+2pS3L7dZ?=
 =?us-ascii?Q?nWXS4lfEh/n4LW+52K6hNOEDOCb29fEjjIb4/x4FVfidGuZHAACw1XRXRxFV?=
 =?us-ascii?Q?ae5lDq/vSlCW84WXIBTLbbPguijsRBb2qvQ7EGNIYsf9Y+Ij8k6eZuXFXZ8l?=
 =?us-ascii?Q?rc24mE71EEjWINg6eWAwKMiVfZsqkP7JCfFBY9m9pkJWgx69Qc/Lu9I8KI1I?=
 =?us-ascii?Q?st7KULI9QXmy+SblsI1T2tO6toaRuVb97+Z3jjiH//045iu0qeS8fPlocESK?=
 =?us-ascii?Q?he0Nn+uHhwG6LlypA1imwWbMsHxalQ4egfmybvbSxklM/M0qnFXXCcHK7ABC?=
 =?us-ascii?Q?I/z9JLIoWefNWM1BXOZEQRc8e3IwY+fr8DAxmRUzL7hdOtML/UYbZzCG2C5j?=
 =?us-ascii?Q?OZuyadb4wfq2uWI7t39+gdfh+JIEZbaZF1yNDZcjuI2BARTSTNshhSqRi7Xv?=
 =?us-ascii?Q?biv4p7oQQuHTJN/lMrq2NGBVh7GvDJVyBTl0J8L5vz69+k9gTFPtRRvzPZ89?=
 =?us-ascii?Q?pZi+2oLwOwpnBxbAetmA+SJy90QN0e4eI4H5emgYq2bYm3jL6KvcATrsSwg5?=
 =?us-ascii?Q?46KGQu6Suxde5UDXBSTdjYiRKdeyLQvDZ3SYqjpUZA8xrOSrIKgFPWPeZkm0?=
 =?us-ascii?Q?1xEuMPkZE62mX6Vxfo8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caaa10ae-a7b2-4483-7e56-08dc80893c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 09:16:48.5359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+qMzpmULR3xSRw/wqL6djXskhy/cq/2XCl5RpReH7JLZyn7g+q+o1YExRTDsi3t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

One more question, do we need to consider the compatible with old FW?

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Thursday, May 30, 2024 4:41 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Update programming for boot error reporting
>
> AMDGPU_RAS_GPU_ERR_BOOT_STATUS field is no longer valid.
> The polling sequence is also simplifed according to the latest firmware c=
hange.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 99 +++++++++++--------------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 +-
>  2 files changed, 46 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index eedf2b613ac2..2c338d39cd45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4416,64 +4416,74 @@ int amdgpu_ras_error_statistic_de_count(struct
> ras_err_data *err_data,
>  #define mmMP0_SMN_C2PMSG_92  0x1609C
>  #define mmMP0_SMN_C2PMSG_126 0x160BE
>  static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device
> *adev,
> -                                              u32 instance, u32 boot_err=
or)
> +                                              u32 instance)
>  {
>       u32 socket_id, aid_id, hbm_id;
> -     u32 reg_data;
> +     u32 fw_status;
> +     u32 boot_error;
>       u64 reg_addr;
>
> -     socket_id =3D AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
> -     aid_id =3D AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
> -     hbm_id =3D AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
> -
>       /* The pattern for smn addressing in other SOC could be different f=
rom
>        * the one for aqua_vanjaram. We should revisit the code if the pat=
tern
>        * is changed. In such case, replace the aqua_vanjaram implementati=
on
>        * with more common helper */
>       reg_addr =3D (mmMP0_SMN_C2PMSG_92 << 2) +
>                  aqua_vanjaram_encode_ext_smn_addressing(instance);
> +     fw_status =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr);
> +
> +     reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2) +
> +                aqua_vanjaram_encode_ext_smn_addressing(instance);
> +     boot_error =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr);
>
> -     reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr);
> -     dev_err(adev->dev, "socket: %d, aid: %d, firmware boot failed, fw s=
tatus
> is 0x%x\n",
> -             socket_id, aid_id, reg_data);
> +     socket_id =3D AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
> +     aid_id =3D AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
> +     hbm_id =3D AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
>
>       if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
> -             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, memory
> training failed\n",
> -                      socket_id, aid_id, hbm_id);
> +             dev_info(adev->dev,
> +                      "socket: %d, aid: %d, hbm: %d, fw_status: 0x%x,
> memory training failed\n",
> +                      socket_id, aid_id, hbm_id, fw_status);
>
>       if (AMDGPU_RAS_GPU_ERR_FW_LOAD(boot_error))
> -             dev_info(adev->dev, "socket: %d, aid: %d, firmware load fai=
led at
> boot time\n",
> -                      socket_id, aid_id);
> +             dev_info(adev->dev,
> +                      "socket: %d, aid: %d, fw_status: 0x%x, firmware lo=
ad
> failed at boot time\n",
> +                      socket_id, aid_id, fw_status);
>
>       if (AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(boot_error))
> -             dev_info(adev->dev, "socket: %d, aid: %d, wafl link trainin=
g
> failed\n",
> -                      socket_id, aid_id);
> +             dev_info(adev->dev,
> +                      "socket: %d, aid: %d, fw_status: 0x%x, wafl link t=
raining
> failed\n",
> +                      socket_id, aid_id, fw_status);
>
>       if (AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(boot_error))
> -             dev_info(adev->dev, "socket: %d, aid: %d, xgmi link trainin=
g
> failed\n",
> -                      socket_id, aid_id);
> +             dev_info(adev->dev,
> +                      "socket: %d, aid: %d, fw_status: 0x%x, xgmi link t=
raining
> failed\n",
> +                      socket_id, aid_id, fw_status);
>
>       if (AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(boot_error))
> -             dev_info(adev->dev, "socket: %d, aid: %d, usr cp link train=
ing
> failed\n",
> -                      socket_id, aid_id);
> +             dev_info(adev->dev,
> +                      "socket: %d, aid: %d, fw_status: 0x%x, usr cp link
> training failed\n",
> +                      socket_id, aid_id, fw_status);
>
>       if (AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(boot_error))
> -             dev_info(adev->dev, "socket: %d, aid: %d, usr dp link train=
ing
> failed\n",
> -                      socket_id, aid_id);
> +             dev_info(adev->dev,
> +                      "socket: %d, aid: %d, fw_status: 0x%x, usr dp link
> training failed\n",
> +                      socket_id, aid_id, fw_status);
>
>       if (AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(boot_error))
> -             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm
> memory test failed\n",
> -                      socket_id, aid_id, hbm_id);
> +             dev_info(adev->dev,
> +                      "socket: %d, aid: %d, hbm: %d, fw_status: 0x%x, hb=
m
> memory test failed\n",
> +                      socket_id, aid_id, hbm_id, fw_status);
>
>       if (AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(boot_error))
> -             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm bist
> test failed\n",
> -                      socket_id, aid_id, hbm_id);
> +             dev_info(adev->dev,
> +                      "socket: %d, aid: %d, hbm: %d, fw_status: 0x%x, hb=
m
> bist test failed\n",
> +                      socket_id, aid_id, hbm_id, fw_status);
>  }
>
> -static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
> -                                          u32 instance, u32 *boot_error)
> +static bool amdgpu_ras_boot_error_detected(struct amdgpu_device *adev,
> +                                        u32 instance)
>  {
> -     u32 reg_addr;
> +     u64 reg_addr;
>       u32 reg_data;
>       int retry_loop;
>
> @@ -4482,41 +4492,22 @@ static int
> amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
>
>       for (retry_loop =3D 0; retry_loop <
> AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT; retry_loop++) {
>               reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr=
);
> -             if ((reg_data & AMDGPU_RAS_BOOT_STATUS_MASK) =3D=3D
> AMDGPU_RAS_BOOT_STEADY_STATUS) {
> -                     *boot_error =3D AMDGPU_RAS_BOOT_SUCEESS;
> -                     return 0;
> -             }
> -             msleep(1);
> -     }
> -
> -     /* The pattern for smn addressing in other SOC could be different f=
rom
> -      * the one for aqua_vanjaram. We should revisit the code if the pat=
tern
> -      * is changed. In such case, replace the aqua_vanjaram implementati=
on
> -      * with more common helper */
> -     reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2) +
> -                aqua_vanjaram_encode_ext_smn_addressing(instance);
> -
> -     for (retry_loop =3D 0; retry_loop <
> AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT; retry_loop++) {
> -             reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr=
);
> -             if (AMDGPU_RAS_GPU_ERR_BOOT_STATUS(reg_data)) {
> -                     *boot_error =3D reg_data;
> -                     return 0;
> -             }
> -             msleep(1);
> +             if ((reg_data & AMDGPU_RAS_BOOT_STATUS_MASK) =3D=3D
> AMDGPU_RAS_BOOT_STEADY_STATUS)
> +                     return false;
> +             else
> +                     msleep(1);
>       }
>
> -     *boot_error =3D reg_data;
> -     return -ETIME;
> +     return true;
>  }
>
>  void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32
> num_instances)  {
> -     u32 boot_error =3D 0;
>       u32 i;
>
>       for (i =3D 0; i < num_instances; i++) {
> -             if (amdgpu_ras_wait_for_boot_complete(adev, i, &boot_error)=
)
> -                     amdgpu_ras_boot_time_error_reporting(adev, i,
> boot_error);
> +             if (amdgpu_ras_boot_error_detected(adev, i))
> +                     amdgpu_ras_boot_time_error_reporting(adev, i);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 7021c4a66fb5..d0a125743d3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -47,12 +47,10 @@ struct amdgpu_iv_entry;
>  #define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 10, 8)
>  #define AMDGPU_RAS_GPU_ERR_AID_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 12, 11)
>  #define AMDGPU_RAS_GPU_ERR_HBM_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 14, 13)
> -#define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)
>       AMDGPU_GET_REG_FIELD(x, 31, 31)
>
> -#define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT 1000
> +#define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT 100
>  #define AMDGPU_RAS_BOOT_STEADY_STATUS                0xBA
>  #define AMDGPU_RAS_BOOT_STATUS_MASK          0xFF
> -#define AMDGPU_RAS_BOOT_SUCEESS                      0x80000000
>
>  #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS                (0x1 << 0)
>  /* position of instance value in sub_block_index of
> --
> 2.17.1

