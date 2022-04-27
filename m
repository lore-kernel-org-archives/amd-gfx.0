Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F1DC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 11:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2ED010F1BB;
	Wed, 27 Apr 2022 11:42:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA0C10F1AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 11:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxGHDFP7I8vQH3BlxUEo7cjbkvEiWO3XgwfP1MLm15akLNZJ1NzGauS8q7VTAjCpt8+PZ0+vmSdAk4FryjfKHhpZD+6a0EZl6gKnfr1Z4Tf5N3vCLRpkNDYJLnxV59XUrInysdLQ0Zw7a0u3SFdfGneh7DZsEZIdejckekwk3cd8zdOGTMFBQpT5miWdFOr3ncYICLCwCjqWoYViAqZ2pN8UHXNS32HyQiPCPSpZEdsOh0ROd8DGKr/d+1DiRF2HI/SRwCeoMDU7J2T0UsbVCcXKDiaa/ZTNBtg7YpnbpbKEhdozIeZiT4nRh0TgJg3BQ1SWbpBR4GhCFSHE/jB7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSHZEwcHYww8mwd1bLEfmDToH+A9zg/C+j4tHB85fnk=;
 b=aXCQMkdiy0Jy8IrSEILnfCNn2oblgOqTjoVmDPDLQEo8bgkp1gyLs7eLkevvppJMfk2uNUvO6/JYmHmRG8sIL1ythVC0xcNcFM8xzDgb0u4X8OtasYtsaYUM1bsyckbvU//l0VloDExd9g14XI+yUR+15B/QsBIV3mDS9PiDJH26XP8UEBl7+7176bu+tVymFoNS0KQx4+/9iQe23PhWvKsMeVWxlmoa42yiWh0F8zJEC7S6+X+soG6rn5Mj4bg12eD20AuvnKBdRWWqImKMskCOjkFidiERrYbDUU+PsZsYsNz7QC0H8JOxQc2zm075VGM/cI0j4qZhjWwB9+swwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSHZEwcHYww8mwd1bLEfmDToH+A9zg/C+j4tHB85fnk=;
 b=MbjQIk44xHfTxQODGxrVHOqb3yhGEXf67wg54T6vqzcq2ve9C+w7XwbV7I0cZ6jz36SwYXNfklE5kZUjgkzLIaSJuXQgzyPeZoLmE8uu0NMT0mDxCG/xcS+FZnkn2JrOxs2xWJcjlbZlX50z5C5DUbSZnmoiwce93M0C3Qftgbs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Wed, 27 Apr 2022 11:42:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8558:f9a2:7eec:cfa3]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8558:f9a2:7eec:cfa3%6]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 11:42:45 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
 cards(v2)
Thread-Topic: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
 cards(v2)
Thread-Index: AQHYWiFgpuVtR8lm70mQT8eUQCHsi60DowKA
Date: Wed, 27 Apr 2022 11:42:45 +0000
Message-ID: <DM6PR12MB2619F4B2E3CDA10FC4B93946E4FA9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220427102659.23579-1-guchun.chen@amd.com>
In-Reply-To: <20220427102659.23579-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-27T11:42:42Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9f80eed6-1e30-4e4f-9279-d1885bd63009;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90a054ac-a87c-442f-bdc9-08da28430c1c
x-ms-traffictypediagnostic: DM6PR12MB4810:EE_
x-microsoft-antispam-prvs: <DM6PR12MB48106CFD0DFF71DA61B2D41FE4FA9@DM6PR12MB4810.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWVxPM6J/Z+yPUMd6+EbJ6YPNsEWwkMNLZuB+LkWg+8DXnAcE+EwkuX9dgk+I9nMXEvvN87AohEfrhjEWSxGosBEns2aCx+hxrEMRnIGI74p9x0Qfpz0jKEZ/xA7bJ9HF+1WUf/PkmZ6M2NBg0wnUz8S/8Vn82NOMQ/NMGV9CdcvEgI/z0FyZzFNemwoxO/7xUZ4XDGeEZC87SUFa1b6o069iCFnXz/hwhJmvBLff/MZ1O2pWiJ7+sjQdB9jk0pFvpYhhwEN4HY3Z0WQ8A0V+ytEggIYjq6ISRQF6BPEuDbe9CSgMB/dCKeCSdI6ZXYdUrVdwwv+DqZyzGme/apPIrXs30hFw3k+6KevJDZfYTkfhKNApRuCXCgla049ZGVUdcnHTjVb0wDppLep7QnMHOrTQgahzls0TQ6dpVudLdPWcTszHC5Gfu48of+m3QV5YV2KU4fojFU6UEZuRJzQIE7288Z+p35uNhdcrgtRMZ4qjqX0dLJ+caKvPA0Zn/qq9GrYBbeyPdm5VBWe+tNfD4iEKCfKflcpoI39YsjGrEoamEZrEinO6nwNm2/YXBiCHEQPmeXIq+kdx3oORiPZ9/RE/23D9op2HIIH6acDPZRwamf6QEsJISRi73nmR47nLwfjyQoXekAQsAsQu83uFs3xAMA7vfwnlVrX/QFQaPa2r2nmXBsvCot2rdSS66Hm+UFZ9LRSDgZu3Kmgh8eTC+VLb34xmBwXoWuFd4Lylbg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(6506007)(508600001)(53546011)(71200400001)(76116006)(33656002)(83380400001)(2906002)(122000001)(86362001)(921005)(7696005)(38100700002)(38070700005)(6636002)(8676002)(66476007)(66446008)(316002)(186003)(66946007)(66556008)(64756008)(8936002)(5660300002)(9686003)(26005)(55016003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SN2DvmWr08uRYs35zM0trsfw1CurcQWqZ2QfAvcMxf8E6ZR65FN6S7w1Kggt?=
 =?us-ascii?Q?ftfucmquSDL8tu7cqyPplZUdtQ+qLKna82PPSnDCbKbRvX09U2s/itIf1cGu?=
 =?us-ascii?Q?MG/gZhusydVYnQWlor4DmvgXdIYDUiSguVdix/EY5qrFM6JKfkhp+bVNzuT7?=
 =?us-ascii?Q?YOQwe8kktEtPw8TFY6IX41d4DSV2HviVjUApMDentuZvW1/mdeJavyMkHjji?=
 =?us-ascii?Q?+TOljNTOXUd7BZMoJBzOc7jPKZheTQC2ZZTa7EviKndAm/Li6tKoogQHMtzp?=
 =?us-ascii?Q?BWfhtbNlDEH7iOzKB9PatJ1Xb7Onh9HR+PGKF5pE8tTT4P9GoRwdWMSm4aqh?=
 =?us-ascii?Q?3jhE1OfeaVMkaatyNS83Pd5wXmOaLBfcGCmlUosOuOs8UO25ytowluKv70PH?=
 =?us-ascii?Q?+nZclTcSQRfttvxhfLYbV7qORsxWndWDAz6yV5z1FwfdSP5wfAFmNI2nbRd7?=
 =?us-ascii?Q?N8SsVyH5rqmMglG1mrbieAlONLt2oRs0J6gYlqbKLvG+9drvOWCoX+0fReKK?=
 =?us-ascii?Q?Rig8TcBD7jvSHjmzaMuL/MPwI9iRXB8WOMUjp5q4m7K4EDAlbDprArJa66fT?=
 =?us-ascii?Q?7Fa2HsqV0Y9Pd+mEHg8MVW0CWuam3kOXQvKVO5ATS3jl+RDkhLKK2AyZNiG8?=
 =?us-ascii?Q?4oC/IXgYBC1TYGBIEfNLY8BxFdRQKCKkboCmh/vimbv4SxhwTybIlW0AdE7H?=
 =?us-ascii?Q?0t4ECQSvDA/sO8oE3rxeZmFliws/GvRNU+hhpgW0G+/KgQuccyVi+H/OmUOR?=
 =?us-ascii?Q?r3UtHKvojugs2WP6NPy4fKkDUa4yqllx8w+RVkr65eJlVz4rixPU8TCwp7DQ?=
 =?us-ascii?Q?W4UjDyCgqT3dZezglMDFP13gP0ACTwwRBbLIUoQgaS+kW8MwHk9GJ1pFTZCv?=
 =?us-ascii?Q?zjvT8MzGpwimkSmHnmJBDA3iTyF8ZQQgzBczGiHWtorAG3TebatvVxu+8GNw?=
 =?us-ascii?Q?AZPAMuUGhv9y1peGsHoVjRQ3t6NyO2kutnKklrFMpu05sJRRoHq1xi1oaak9?=
 =?us-ascii?Q?r+4DT0wrN9jYhvjgb84xKVlsn5ixzuso47a/nbnmc0rTWR+AF1DiCbAK7dxa?=
 =?us-ascii?Q?WcR84Y9zByUsCLg5YKtM8BbsKl8n0TWXrH8V9hHU/GwuQage4zCpTOKjYHCn?=
 =?us-ascii?Q?pLwTjumdlhZLziq0yDy7jh0HGSo/gADnH7yARhD/yt7Ffaf/qRlw6I824E50?=
 =?us-ascii?Q?CiScqG7U2xayGkNVYoijfK54Go+z2CGE3MM8Eyz0Y9EATDLWb/Da4V38GBUW?=
 =?us-ascii?Q?9Tc2JPAoqQR6iKMHwT6dLakWSOOS8Zf6ytwcJXAkTNC+Gj5XLCs18Bp5qP+u?=
 =?us-ascii?Q?vVJ1P2U23h+DUf+Xynxm3gxUG22gf+iPDWtN1E5XF5UySvl1k7rZAb3izUqB?=
 =?us-ascii?Q?EPFfzpvE66yPK+nZfL5ZNstYJ/3brQougMmFM06tjhyh+WYSod43Q+XQAgVG?=
 =?us-ascii?Q?0267Sa9dDN9zSDMZRKM+NqXGZ/1Zn51E/Do4ehdSKHLiX2B15BAXb+lz4Yf4?=
 =?us-ascii?Q?kl4sqwVdhNhOpdP8fuhyVc5m/opGaUCb87gJ8gfyS1MBL54V96qO7okSEIu8?=
 =?us-ascii?Q?fymPil9+Vd3qgDVBqDBLXpHqvjHkU93+aNbDy30AuIWP4asfYyVuBJ7v0V5Z?=
 =?us-ascii?Q?4nDiq7Vfdb1HXU94RNdl2pM6h75PTaVmldh5WMRLpwbPN3jU7J7dgRMtPFix?=
 =?us-ascii?Q?GqU8vfGc+CQKN4co7WAeZV7VUofStV3FknZGoVCJdWvUIWUf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a054ac-a87c-442f-bdc9-08da28430c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 11:42:45.7320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yq+H+yQg0IKpnc7wqC6UjZxBS2/V1ytzjDJ35P4n4E+w68bI5tL0n3UVlzHAUGIR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4810
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

[AMD Official Use Only - General]



> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Wednesday, April 27, 2022 6:27 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
> cards(v2)
>=20
> Disable runtime power management on several sienna cichlid
> cards, otherwise SMU will possibly fail to be resumed from
> runtime suspend. Will drop this after a clean solution between
> kernel driver and SMU FW is available.
>=20
> amdgpu 0000:63:00.0: amdgpu: GECC is enabled
> amdgpu 0000:63:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is
> not available
> amdgpu 0000:63:00.0: amdgpu: SMU is resuming...
> amdgpu 0000:63:00.0: amdgpu: SMU: I'm not done with your command:
> SMN_C2PMSG_66:0x0000000E SMN_C2PMSG_82:0x00000080
> amdgpu 0000:63:00.0: amdgpu: Failed to SetDriverDramAddr!
> amdgpu 0000:63:00.0: amdgpu: Failed to setup smc hw!
> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP
> block <smu> failed -62
> amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_resume failed (-62)
>=20
> v2: seperate to a function.
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 262938f0dfdb..1bf8ff71b6b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -43,6 +43,17 @@
>  #include "amdgpu_display.h"
>  #include "amdgpu_ras.h"
>=20
> +static void amdgpu_runtime_pm_quirk(struct amdgpu_device *adev)
> +{
> +	/*
> +	 * Add below quirk on several sienna_cichlid cards to disable
> +	 * runtime pm to fix EMI failures.
> +	 */
> +	if (((adev->pdev->device =3D=3D 0x73A1) && (adev->pdev->revision =3D=3D
> 0x00)) ||
> +	    ((adev->pdev->device =3D=3D 0x73BF) && (adev->pdev->revision =3D=3D
> 0xCF)))
> +		adev->runpm =3D false;
> +}
> +
[Quan, Evan] Better to move this to sienna_cichlid_check_bxco_support(). As=
 long as smu_baco->platform_support is set as false there,
the runpm will be disabled accordingly I think.

Either way the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

BR
Evan
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_gpu_instance *gpu_instance;
> @@ -180,6 +191,9 @@ int amdgpu_driver_load_kms(struct amdgpu_device
> *adev, unsigned long flags)
>  		 */
>  		if (adev->is_fw_fb)
>  			adev->runpm =3D false;
> +
> +		amdgpu_runtime_pm_quirk(adev);
> +
>  		if (adev->runpm)
>  			dev_info(adev->dev, "Using BACO for runtime
> pm\n");
>  	}
> --
> 2.17.1
