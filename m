Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1685C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 07:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D472010E580;
	Wed, 24 May 2023 07:35:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0ADD10E580
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 07:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntY/L0pzgDjSiVtbp1ozbLcmQt84vllClwGj9j5FRSd6zNNWbxs/Jc/N+5b4q3I+kyjA0ZOlpwSXz1UM8VNVKp5tbsivWZI8LAfnsWA84+a0zdEIzKUrQmFuze+t6yM/DYXmBwxX5xuCkSOFj8xaYH6I98A066wjg0oAXhYP0pdJBNP0uNPuHTmlbcxigaqzNQfoUx8morW1lxquf4kxlyzzfiMI04DsQT98MfCCa7qqPwVstUJ2hDGPZm3J/H5UycNUIwesuKfsSu0Sfy4nutdSR9EjmBbRCE/l0n2HJltC/fRqtL8nikV9TaA9XRf/of/4WTXbv/A42css7oglVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB4Hfx7qdO5SEFC+WXzSu3hSt3NGUISIyHcyU9ejaEc=;
 b=GPXFF8AeMA3YrFidoTqEpPraMJyFHzgZxh4ftL3c6+YQBpb3jXDvVwbmaV8SoqpvxluYQnm/KoTNuLfYR1mydpm0pcs6UlmLFCEjqBmAD32DGV2QEaV4lMjrMBeS9S5Kw48Kz9mhzRrVrqCHUpC4CzhFsDnPMzS6HX/ycfEIClURlUTNzvHdAghANH+czhreiDz3cOWcgAXIfTp8jjhGSEAIZiQoCEDPRguPRXq1gVJ526QMp/Nz7TpEvR2zC8tebrWTz1u+caZ6kI2yIrSNFNGI/jjXMisEiBdSx2CWAMC+pT7s6dg8V3fIodwmhoVCWVoMNWIER2caDg6QCwWrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB4Hfx7qdO5SEFC+WXzSu3hSt3NGUISIyHcyU9ejaEc=;
 b=2kP4xS26ocr4CnE/P/X2jAQh/VyRQnnX6iAZ4Wo696WNUMcC8MdAf+66bbuTPqosJ1BSs6vKiJtCfHhAainNQVYqVD6eQ8+m05YMJD4xxM2xp/S1Se8iWsvDY5ksoJ/U2YfkIA9tng2kcxPB65PbgYUApNLEcXFQsGxaGf6ycx0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH0PR12MB5170.namprd12.prod.outlook.com (2603:10b6:610:b9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15; Wed, 24 May 2023 07:35:35 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 07:35:35 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Zhenneng Li <lizhenneng@kylinos.cn>
Subject: RE: [PATCH v4] drm/amdgpu: resove reboot exception for si oland
Thread-Topic: [PATCH v4] drm/amdgpu: resove reboot exception for si oland
Thread-Index: AQHZjgUJ2ACcfzJy7kC35X40xk3Gua9pCF0Q
Date: Wed, 24 May 2023 07:35:34 +0000
Message-ID: <DM5PR12MB2469C1A31CBF52EDDE01BED3F1419@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230524055959.327329-1-lizhenneng@kylinos.cn>
 <20230524055959.327329-2-lizhenneng@kylinos.cn>
In-Reply-To: <20230524055959.327329-2-lizhenneng@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7be903e6-59cc-444b-b775-d97f849227ad;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-24T07:35:14Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CH0PR12MB5170:EE_
x-ms-office365-filtering-correlation-id: 75ab8d7d-7c02-4807-db00-08db5c297620
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UoyuzvsbGjUA0+1GK5Xab/dRAZish72F5Lti8jaWz8MMQS844L7gz08IXewU8vwdNo36IHe1MZYebw8Vcvln+/qtOwTKWnKy2q+jnZooEPpR7uQ5LEipiBHFcEsxU4QtluCFByLTL9eesbc8Pdy+VIZlcOIUnP92NMq8t3PMwiulE2+JhKlADxYLW4M8b881i1wG01n+iiQnq1ibaVgqzbLlCXc8rzLdGcXQcPqWiVW3iLI/JKrtj5rFJjpSQbDgp7/tUSQw4U6ghexsL68Vrm4UaXSzFNFAbFBthTe5qgIRZ0HzUIT8VAc7qffZXCbIoQseULRLVBaUFBHL6p/Nd0CXExq2uPLo2c5QjQU2fjXm/IRYjRgCfTTIpFeULrdAR6mPmfK41rVk9Bc/shzG+M8MkBhfh1YzVkPkUkFCtQu9qiPWreHiIBdHIhYYqqVfIR2jx1l8BJNPqS7ZPVBytdlFdbpwrPi0tJaAJ3Rdtx+ktuvTRPAsmSCU/wT87ZqgDKFLKF+MlappDVIgKjJFi0MzCtWicPq233AKmXHgPS9MCwnpGT0MP5GExRyqgo2vDWXnZqQxrnLbnFYBhNGcVIDsZe2gITbz0xfeY3ekPjQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(478600001)(7696005)(71200400001)(54906003)(53546011)(26005)(9686003)(6506007)(66476007)(186003)(66946007)(76116006)(64756008)(66446008)(66556008)(6916009)(4326008)(33656002)(5660300002)(52536014)(41300700001)(38070700005)(86362001)(55016003)(38100700002)(2906002)(8676002)(8936002)(316002)(66574015)(122000001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hhYBTDykHFYFtIJ9gwJdWbnfNUJaBUc+EhoiTl2c0fGbZpaDllXrkRHPVkA5?=
 =?us-ascii?Q?gYe/lVutEapW58CNSdVFBOrB8K+8KKFXPtR41+RmtbE/0pMTilD3q3IwVUlp?=
 =?us-ascii?Q?wdk93GQtQXGAsChees4E5IcKA7PND/nfgifIeG5n04bLCHOGOL5+E7z1eQwU?=
 =?us-ascii?Q?35gB2IXzVOVeGuqyMevYwM5urcCUbIKqFmPfkeU3LzrfkC4qJsliLcMRQSUM?=
 =?us-ascii?Q?OE2Do/e4sNXop6p2sXXU3t3LkkP/VB+j3Z8PKPeGKbGtgHudajC8ve1Bfnj5?=
 =?us-ascii?Q?c1arZ97GvVw2vrDEet/kGJk+Ss/wTsSvju8xCiuSQHS/uFGrZ1d7zmHk2max?=
 =?us-ascii?Q?1Rea0OIVig4zKogwXTzE7zeHGVTeX8zQjJjrNISmr0r39kMah3h7u5VtF9V2?=
 =?us-ascii?Q?ayDjw+78WsqKpfhcWTIiq97jUmxWaUcNuYJAYGfSVa2hpLEhawQj+QTP6z57?=
 =?us-ascii?Q?UgOQWf3hUp7Ig828aqlKrAblTng/IGVI5pz4bIcqi0sJQe9lpq5ObzpTjT28?=
 =?us-ascii?Q?mYt/5jEhR9RJyN6e41QFH0BpidsuHVWT7n+bzpNIEgterTWjZK9Cy2WgMBnF?=
 =?us-ascii?Q?6U96BNJQURvrKbVmpAtk2pMjj32zFADoUoS6bf4tvAqFVh+Cp49SCxn8IwUk?=
 =?us-ascii?Q?OX/YLKQERrocUEy2orSIVs85mXUEvnzOQjEmpYAl5675WeluecWbJ25eYftE?=
 =?us-ascii?Q?5HPPVZ0NpkLJHaZCJ0eDjBGDADAFKB9q8Ljg/9ORQG+4j4o9VO+ecY6ks1Li?=
 =?us-ascii?Q?QXe4EZJyGpgcRGifr0IKCpIEb0bOV+RV4kOEG/79hO+SmM4dqOcMTdwn4LIP?=
 =?us-ascii?Q?S/Vi73a/s0CXggttvr63rz1ajhNSgA0NRY2ik+pmA7oJhoKlIciGxPCp1waw?=
 =?us-ascii?Q?t7dVTIK4NqyrTE/fTeYAzxojrnNjojNTp7tBUy6+kpa2kts6oKSHkLS5oel5?=
 =?us-ascii?Q?xdpdsUcAVdnuHYkLdRVYpb1l1TnmjTHT7vJj7Kek9EZYkq9YRWZqRou34Ik8?=
 =?us-ascii?Q?eG75Xm+xoeeLQILxcQ4tKjSRQcPAdEBBwoa8pjte3S2pPIFDUL1MznBcW8n7?=
 =?us-ascii?Q?RA8khx/xD34iBs2BycKNPVs7MotW7nzlkfAPr5ZT4+CIlvw3L2UVKFBiKivX?=
 =?us-ascii?Q?C/SRixZ5w/13pXQSANHDTYW6hRU2xQ016dsRhr53pG62rBLhNf6/sJh6gTmd?=
 =?us-ascii?Q?RPFs3e1Das9Si+dDLlHqkNAr7TbcvA1p6+nHy6lWZjJ8HrNG/cai++kQRvDn?=
 =?us-ascii?Q?Q4StNJshiFEydX8lDyis1K/D/d0fG5C8a+AEQpfos5EAC/59Vdc+xWWZ3H4D?=
 =?us-ascii?Q?j7nvHEqa5A9bLbZWn0CV12I+JzF5yaubMOdgAd4PCP73ueD/v5yOj4uKrsmH?=
 =?us-ascii?Q?/8p1qF6vI42WIy833aPxF4uIWK+DtQ2xst9HwrgE8q6xNttSDPsG9d8kt6gp?=
 =?us-ascii?Q?DQFRmR6xaHGmTqrRT59udoEkc8JFeyeUK/Qi4cIXyNmK5EECO9ywmoyL9Ozi?=
 =?us-ascii?Q?vty7G9dfhUOV20RvdznOTP+RIATPX2b9TUkoYwPQcdl4rZ87pCxg/osO3j3E?=
 =?us-ascii?Q?56vuGCNEmzP0f/iZNUE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ab8d7d-7c02-4807-db00-08db5c297620
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:35:34.7947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBHnqo70KR52DzvG7XRlR3COL7mfEyf/rI4+1NYgkjSpksvm1CFkbhp9wf8zmpSiEmloT1z9kV/xaNo51lE4ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5170
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Applied by modifying the subject a bit to " drm/amd/pm: resolve reboot exce=
ption for si oland". Thanks.

Regards,
Guchun

> -----Original Message-----
> From: Zhenneng Li <lizhenneng@kylinos.cn>
> Sent: Wednesday, May 24, 2023 2:00 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-
> gfx@lists.freedesktop.org; Zhenneng Li <lizhenneng@kylinos.cn>
> Subject: [PATCH v4] drm/amdgpu: resove reboot exception for si oland
>
> During reboot test on arm64 platform, it may failure on boot.
>
> The error message are as follows:
> [    1.706570][ 3] [  T273] [drm:si_thermal_enable_alert [amdgpu]] *ERROR=
*
> Could not enable thermal interrupts.
> [    1.716547][ 3] [  T273] [drm:amdgpu_device_ip_late_init [amdgpu]]
> *ERROR* late_init of IP block <si_dpm> failed -22
> [    1.727064][ 3] [  T273] amdgpu 0000:02:00.0: amdgpu_device_ip_late_in=
it
> failed
> [    1.734367][ 3] [  T273] amdgpu 0000:02:00.0: Fatal error during GPU i=
nit
>
> Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index d6d9e3b1b2c0..ca9bce895dbe 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7626,18 +7626,6 @@ static int si_dpm_process_interrupt(struct
> amdgpu_device *adev,
>
>  static int si_dpm_late_init(void *handle)  {
> -     int ret;
> -     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -     if (!adev->pm.dpm_enabled)
> -             return 0;
> -
> -     ret =3D si_set_temperature_range(adev);
> -     if (ret)
> -             return ret;
> -#if 0 //TODO ?
> -     si_dpm_powergate_uvd(adev, true);
> -#endif
>       return 0;
>  }
>
> --
> 2.25.1
>
>
> No virus found
>               Checked by Hillstone Network AntiVirus
