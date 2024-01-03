Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EA3C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 09:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891A410E1E1;
	Wed,  3 Jan 2024 09:46:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E1710E1E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 09:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDju/FLPgBAphEcayvsQ2DqZJnSPZPHp5wiStXCOfO26tZGVbk3A+LHXuKxAiVzJmJqIpoFfCnJfGk1QmT83HHmD1bwguTnVMQpZtlJ0kJQPnyZcJRZwRbeuRw62gRUiWfOXgIao40dzvs43mdoYlwQDE+yEZJqMk9O6cp2LLeb63LcUPDlYv4fTipnDvI9GUYBPftSy9FpqvaXSeE6Uv4Rl74z8/54TFzhilufsmERNSyfr0U+BpghM3g/PZlS74AR5MyCE+1WGnPyB7czauvx9QdqOkwh2eKmjBgEptiV58dgLyJRNX52jjGMimgc5o7WOkZydYSuaH4jIAuhA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dopm6d77xh8n4V4DvadVFArwmol05SjlBXznh0Trqts=;
 b=LX7wBW89hGJxup7ZMhNyaPRelZAw8tPL+M7KgE2yM5b9hkrNAfQyDHuNoso+aJQPcHnFyj7r2U8bsUc9fzS9y79wkLjLbCNCbvlGlFSbhhhKewQLCcUjehJw+ElFWsDT7Wgks3LOmCcop1WgpCG6bCer+suROaGpjnJsmTuoggnhx++FVjz1tRK7xlSc0cEVFnd7O9mXqAvPLMbr71jXuXSb+9TMGupO2T1mZgIOx3+2zkW8k/PxZXHh8VqOrTmcY7xewbnIoNuWr8UfDzOvg5E932QWPQS4Uo5N7/GzdbMaG7Bx33K6u/8HWvkWdqwB10jTh+8vfaj37L3ixz0bqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dopm6d77xh8n4V4DvadVFArwmol05SjlBXznh0Trqts=;
 b=CCjR0+Nu10wlnQKoRlOp+UpZFyPFFCF2tQtjuOFdExWzcmtDBZiwG/XVLahN+VqeaO85qXta1hT339q1Swr79LbOREeEngKX/RMvsp/WBeD9iIOvGdVve3O/rsRXzvO38XHY0274SIKoFpn07226u2GTdxbsHrGgI0m/gReKYX8=
Received: from PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 09:46:00 +0000
Received: from PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::8377:6ff0:2025:652a]) by PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::8377:6ff0:2025:652a%4]) with mapi id 15.20.7135.019; Wed, 3 Jan 2024
 09:46:00 +0000
From: "Zhang, Morris" <Shiwu.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH v2 3/5] drm/amdgpu: Add ras helper to query boot errors v2
Thread-Topic: [PATCH v2 3/5] drm/amdgpu: Add ras helper to query boot errors v2
Thread-Index: AQHaPYUumiWMGx+ClUqZuNxLdSzrD7DH1gKw
Date: Wed, 3 Jan 2024 09:46:00 +0000
Message-ID: <PH0PR12MB8773045911B6497C32A91BE8F960A@PH0PR12MB8773.namprd12.prod.outlook.com>
References: <20240102140742.23917-1-Hawking.Zhang@amd.com>
 <20240102140742.23917-8-Hawking.Zhang@amd.com>
In-Reply-To: <20240102140742.23917-8-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7bf99cd7-1676-4010-85da-f02eeb8f8abf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T09:37:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB8773:EE_|SA3PR12MB7973:EE_
x-ms-office365-filtering-correlation-id: fbae93fa-f3cc-4a60-e822-08dc0c40cb05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdialpCR6i5mBZbWxbAni4FzjGmywiqMlT+CFiSHk8nYG902qF2XVSc97eOH5U4Iwb0XoTNxVPhrH25YAxF6CCONEelxdP/nJyygKz78emnE+DbBuODtKhnbxgRSLlpfPnKq3ybdFzyE/41oneVjnX/gP/5DkOCLO291BN9APBIcU3KtPQ8Cs6QOePMbDb03CxJFRErk1FWvT4Rq9+OhrTQfvttkVZTA3EyDuP1X5vFMQoSVlsrCwSr4S/eMbK0D8MIV6SW8YAnxDm+/4ZuwfhCszF39uzDHVdOeErg1zSub8idyWmtRQXkADBHBxfbGxop9Zt959uw2L08QZWibcIlSQR9MpTTnq2brXypSCMC/sK0b/QuTIx7xoRRTe2skXgR0CEf7eqf3IVhBi8vyt7O7i/Tht8i9sJyAfBUh8GvCQeWKW/7Q1Pglq1uaN+CiWJe7op8BthqsZ3PxriitTRoO6gDK5J0eP1WySsH7eBdr7Dj7Tp/UjvBVzKEOzpyN0hofnGUVjMMjY6wqYD0IV1Z4uODkRcv7/q4F4ay39dVJE/xGX4VmBr3hI91DTbqILH9Ryt1f21Vwl8lAhUnCW0rL8eDwMJjleLDyVPa+uPQsCCVCnLPoXn7tAmQLJu1oRzNrReAnz9fh4fsj+xyk7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB8773.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(71200400001)(122000001)(66556008)(921011)(38100700002)(83380400001)(76116006)(110136005)(66946007)(66476007)(64756008)(316002)(66446008)(54906003)(6636002)(478600001)(86362001)(33656002)(55016003)(5660300002)(2906002)(52536014)(8936002)(4326008)(8676002)(38070700009)(7696005)(9686003)(53546011)(6506007)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pCN8K8MbcuIjQMTGTPD70Ps9SfZnGR6qYQLuMbp5QITVtYpFZkikupbAfcYh?=
 =?us-ascii?Q?nN7SwZ78TOSF6DSmzS7yPDeDBcmeSecjP2Dzh5GwY98caBMSBU9QkLTWpZdt?=
 =?us-ascii?Q?QugLmi9A/0pnvNyVtB45vX0iSOSpNgXAEwm8F5Iy9Th9pmB8G3jHKpf3LAlf?=
 =?us-ascii?Q?wn16yF5Vq+T+/bb7ctSm/xgjZu5s8qoMzJHhXwDggxpPcjksYTvAfGE6eraa?=
 =?us-ascii?Q?4Qj4lLmf6t4gd0buEKhCFBHf29ZOiMsYmcOaM+LuCWRLhPnw0zVfiykEKVoA?=
 =?us-ascii?Q?d6lP54tGajR4gz5S46ksQh1S/PT7QlReV0+TnxidmJPlEtfVRZJ4BdD9nas1?=
 =?us-ascii?Q?yFbNk+2iafFRgUCG5hQ0IyEJf0CKH7uw7cJ6NTdNEU2ijmq1SAXyYawtmjoK?=
 =?us-ascii?Q?W5gIp/pv797YE6cs8eqt1IsW8HogI/rkp2mD5wtiLE/otR/vctTQmLQeWNyP?=
 =?us-ascii?Q?NDVNQ+rJgrOUxY6Q+5vcJcRqNUkkgBqSQE0qjNCCjYOrhsVpUl0TBdqP8OZd?=
 =?us-ascii?Q?SahoXZ7W9A5zNwUie/fewhFtU+7kyDkbm0E36kRVBDquOtuY9DH8p2HAq0pz?=
 =?us-ascii?Q?mH4tL9R3wkhb/7wHB9CBfsEAz3W7tXOW1upUe9xUpJxlT2IAvfPZgPyXFztG?=
 =?us-ascii?Q?olLcqYcuiTj/m2zEBm7FIsjCmJlmChMEJap5tNVkZIZS63hQYZMHR+zSr6vC?=
 =?us-ascii?Q?kGI+SbJBJTlV8NuIos2t//ehxa6AdkLNVdDne2uijPAQefwn9IMPZIPadvAj?=
 =?us-ascii?Q?a2BZzRFnWXwPpitdYWYRMsZ6v16QRAhs8cJjhwOlgsq0xM5KsBpzBqTr+dEh?=
 =?us-ascii?Q?kiu/dRCdA+efBAKoPBmsKIlfc+rCHdM8V4UHg9nGgk3/sxyW1uUtGp6plsBh?=
 =?us-ascii?Q?Lt5eFTLO3dJ0p2jNOCk737o/eDv5pyf18eIdRuGVFGG/5Q1sLhgIZ2thMNbD?=
 =?us-ascii?Q?b9AK93XdgetF7aobPGc3wAcHXeatmy3k+z/ts2j3S348CDZLZUswyhIOQyCG?=
 =?us-ascii?Q?25Y+uODL3HYUxSOyrYAnriBpo5NPcthXIOzFtYWn09tSaCfSxRGGIVdcVKqZ?=
 =?us-ascii?Q?5j3nvyoaBQ+It9u23n28QdKwEzquXzuMS1mMouCZsAibOZcnx0kw8n3aWBov?=
 =?us-ascii?Q?kDbtnDGB+HUh8OLVufHQmyJky3DtFhMBvj07SCLYXarsNV+PyiIJ7k0pDk0e?=
 =?us-ascii?Q?T/gsHeer0qZNSWz9nN0+IeWo9ThGcnnSfMc1TIVwg1thGki2oclLy1Py0hGB?=
 =?us-ascii?Q?fy8lrHizbUuO8sVZ2S0OyRnCbErimA4LqPDd5sEXv9/nCbAWMKG2RnxVHCL7?=
 =?us-ascii?Q?5DwP99fXPeB4E9Rzj+V2N9YY3NWEWBAnqSrSwPfaWEEYPEIXePC9aad1KFF2?=
 =?us-ascii?Q?cDMOjGanVq6XYt5xFHLQiJyMRrwfpCd6+v4wDF0aqG4j7gQ/SD3QTOO0iPlw?=
 =?us-ascii?Q?+FELj4mAJKUd4ChN6pimDdPzOHuyNAhlmGisMAQYEvAKhQxIKHY72wbqLp96?=
 =?us-ascii?Q?M+hYCsHCc6zqIEdVUccf3ObD4tden9bVKLB0z/BQ5y7eQSwion9vSqOVukAW?=
 =?us-ascii?Q?BVsH1Dgh/JgxS0K50JE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbae93fa-f3cc-4a60-e822-08dc0c40cb05
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 09:46:00.2914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgEMdpqLejnxm6k1W6NuJtyDaK6h0O52n9njKhLmwQTfSvrulJzxP2uTRFVAvlFn16hR0t+iin228ebIOePuUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

--Brs,
Morris Zhang
MLSE Linux  ML SRDC
Ext. 25147

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawkin=
g
> Zhang
> Sent: Tuesday, January 2, 2024 10:08 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le
> <Le.Ma@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH v2 3/5] drm/amdgpu: Add ras helper to query boot errors v=
2
>
> Add ras helper function to query boot time gpu errors.
> v2: use aqua_vanjaram smn addressing pattern
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 95
> +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |
> 15 +++-
>  3 files changed, 110 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 616b6c911767..cd91533d641c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1328,6 +1328,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>  #define WREG32_FIELD_OFFSET(reg, offset, field, val) \
>       WREG32(mm##reg + offset, (RREG32(mm##reg + offset) &
> ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
>
> +#define AMDGPU_GET_REG_FIELD(x, h, l) (((x) & GENMASK_ULL(h, l)) >>
> +(l))
>  /*
>   * BIOS helpers.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index fc42fb6ee191..a901b00d4949 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3763,3 +3763,98 @@ int amdgpu_ras_error_statistic_ce_count(struct
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
> +     /* The pattern for smn addressing in other SOC could be different f=
rom
> +      * the one for aqua_vanjaram. We should revisit the code if the pat=
tern
> +      * is changed. In such case, replace the aqua_vanjaram implementati=
on
> +      * with more common helper */
> +     reg_addr =3D (mmMP0_SMN_C2PMSG_92 << 2) +
> +                aqua_vanjaram_encode_ext_smn_addressing(instance);
> +
> +     reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr);
> +     dev_err(adev->dev, "socket: %d, aid: %d, firmware boot failed, fw s=
tatus
> is 0x%x\n",
> +             socket_id, aid_id, reg_data);
> +
> +     if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, memory
> training failed\n",
> +                      socket_id, aid_id, hbm_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_FW_LOAD(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, firmware load fai=
led at
> boot time\n",
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
> +     /* The pattern for smn addressing in other SOC could be different f=
rom
> +      * the one for aqua_vanjaram. We should revisit the code if the pat=
tern
> +      * is changed. In such case, replace the aqua_vanjaram implementati=
on
> +      * with more common helper */
> +     reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2) +
> +                aqua_vanjaram_encode_ext_smn_addressing(instance);
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
I suppose we need to check the boot_error value returned to report them in =
case that before timeout an error happens, right?

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

