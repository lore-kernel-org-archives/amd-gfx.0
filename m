Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614CCC5475B
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 08:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73C310E6AA;
	Thu, 14 Mar 2024 08:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="20JS6NHm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2366F10E6AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 08:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8G/R/Wy9kfPg3r36DEi0JGlYKxVUjWX4esardKGmqKDZEUNosUcvcym5OqkmIC9F90WvyjX+32rWwOrcW8QpkNzBUngM9wqDgtN2Rcur6aiV+jEY0K0CUHwEgTrj3DY8/CMwsxQE+WcCz2RFM3bgkoJ2dk6TQIoBBX9bX3odT0qeFrvErcul3BhAB9Rhq7iha4NqFlHTWSDANxQAddSH7g8tMTaA5Zw/rKx/wcuNPxXfSPO9hj8aiTdS5IHJwizZ8yBFByfKkKfV6/1L+/7mhtjMj1i739f/cnUkhm6uzgClSvLgpF5ePSjYW37xo5mCPxHduMwdJJb/Ksd8vuAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4bmKLqqO18nhhP7cGYMZs+P5BRp5fnUyeipMZ16UPk=;
 b=DDdgRWabk7aR8meBR1SS6O71+0oNVAIhFjlkFmSM2ZPm9lMiJ1bPSlj3NIBk9G+uJgJje2eRT2ClTho11gloKOFwyviZNMRY4JDRGQa2yf7C7iWD3GNrq7OvIZxJGlTwbU5KPcshohgnmZLFGPdcRsksMtR785D0cxJR94AKjjmGk69ihAcvW7s5jP5jZsJuD8nTQUgf2n7N+ppqHOM2TYfE5FW5020dUaMJpuSZ3FXXzrkHHO1uNSwu2Mrb85BSH1Ubu/iVY5pNTnuFRmcpVu/ibVKDdecXCA42x8Ilwc5O/7FtcME807atqkHg/elckAVVMAH3oGk5r//shyx7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4bmKLqqO18nhhP7cGYMZs+P5BRp5fnUyeipMZ16UPk=;
 b=20JS6NHmuWV/LYB3osLm68Kf5K8hYEL1ui2ljCStADe2TnB+FLvc2rtk64JW++EuaGekER7SdnhfN0ta1lIkzV6sMgql6OtIXSE6vKPAirihLX2xxNlBP/NsbuG8MC2/+3VQkht2hgH8tLX5pMCgdPajIQSI7vFtKFq+KwbpqXI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 08:48:33 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b%6]) with mapi id 15.20.7362.036; Thu, 14 Mar 2024
 08:48:33 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add ras event id support
Thread-Topic: [PATCH] drm/amdgpu: add ras event id support
Thread-Index: AQHadedoHXuXsAsQDk+8LUvT2nROX7E27PaQ
Date: Thu, 14 Mar 2024 08:48:33 +0000
Message-ID: <PH7PR12MB879604640BCC62136BD6AFBBB0292@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240314081228.3538091-1-kevinyang.wang@amd.com>
In-Reply-To: <20240314081228.3538091-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9bdb2ad5-2b16-477a-9093-0a7f852f7590;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-14T08:48:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW4PR12MB6706:EE_
x-ms-office365-filtering-correlation-id: f5108a5e-5448-415d-ad1a-08dc440387ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BcsWVUuGrak+epr+/2NZarWLf6dVrDOBj73PxgY3BuzywDms7xoF7ivEZrgMNHmmcrj91xYmciOsvycRpuoeRRIoJrG9u1QTBpcwdlHHqI5TPPK9ho/RtlwCkSpttq4lrt+DiREvv9VedssEsH6EEi426MAmBr5J5sOpyZgdOmUsnLLY3lbr7tAevMbQUI1rC2wTil5dte+z/5Rj2s3shbtrZ5AWA5nk0OOEcBhmP6vkqne8EL0o709gCmXxX+wYhrdb5aA/8eBIRf66uMUqq+v1b6g8tCrlwtMRvGLIe9kZNwTb9TX8wFyYey2P5637dLPoyRnAxHhC6Kdveyx6PebHCK0HVmNgAcVdUMB1BowJ8EzQGvNLT7RFHlD8wSS8z58DjG9B5/LFraGGFchvDB/EEGDkChw+A141e/VRNRF9Em1C4MKvEJ/0UYLzvxlpK3LPl1PvxQ+jpe272HOMxqf/E9PZVhUyf530Gxi7a51IDlIg6jyftdhILG5MkVsfq4uFBp2+0eIHACsrtO0aGsKib+4xu8GaaiO9vVcFMbwWIKbmySqcPnWk/nH8BjUDLMpr9vdh+yV9KIpX4epAfE9LKOS54uSravY8b54hTSZgproEGdqcsKU3MWtbtp17AwGjOhAZ3HsFn/753lt8UZNHjYKofvue7IhKAk8P87sNgNPNY1WmW0ZSMVmIvriX02r+cQkWXa9GU+tvRVmcAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JAGirikgkwswME0lkBb0jOiOvURCvq5w7oVXdGy04FpC5TcPPxwCiEvptABJ?=
 =?us-ascii?Q?27YdKD+kvc1U9O98zotmtZCdRF8Br4fbvu0YABD5TWgBiNKNoxcm1LB/D0tC?=
 =?us-ascii?Q?TZowCD4IF+7yVmwg22dZgWcCzV9YC6IujpPPTzT3nY3gN9aNe2K7If+JATHP?=
 =?us-ascii?Q?T895eves0gC8ZWfs/HXWWPviBA8st8PENtCFbk/rI2p4/vJHyK7zHdt3GoXl?=
 =?us-ascii?Q?XvktssePYPMy9QfmHYHzWjVoMIw9Ck/RVLSk5T4eytciM6t5bI9quD3MUSQr?=
 =?us-ascii?Q?a+IcKp97r00Pmm+nK7RgkbhM7sWO3uVZHJYHcR671RwuROTEXhjfZCfI1nrr?=
 =?us-ascii?Q?7lSlNotwMNYEHXqM9VX+5ZGDAVzf5amda9OWvnCO8SER8Fs00WxKj+9RMGI8?=
 =?us-ascii?Q?jUt1loiIJe9BJzoh0w/1IxKiiJD9LOWVZxXgddM6AnvrdXGFFkkge3sxfIlp?=
 =?us-ascii?Q?TpNk42bRQV1Bal656B9BPFRhlmXYk2VH9Rl+Z+o+XTYYD3p8ChPICB6S3Anq?=
 =?us-ascii?Q?g2ID6GfKT44emLt1ACXp6IJOla59CbOGhZ4ff99yKvC2G78guieXu8zEPS3J?=
 =?us-ascii?Q?Ayki7tSiO2/6gEe1DNoW1B3BYyof3iBpPtyawZYAKcECjjdw7+Od7fcKVeKb?=
 =?us-ascii?Q?HTER49wCoYcaLX/8xxDycyGPFVV5BaXSfz632BsVxV8APqqlNOmwn2HyxWgy?=
 =?us-ascii?Q?5a5T3pEjvFrgxdRr8CkwkHPIxY8WocFEkjWD1z68aLtjChpXE9ruljAJ0GLm?=
 =?us-ascii?Q?ZRmbgDAunp9JFOVhUoLDORhQjszHLSNMdJU8Akq1kiEZ+zVeT9YHYZXTSOjo?=
 =?us-ascii?Q?6/7CdzeH1pfbDsSmxz9fES9jRf+s92MuFQLsg85UYgTPJAuAeQWjaIi5slHF?=
 =?us-ascii?Q?jUcOPLa+p+7TjwGecfuCRt+BIpkpQFh9Ly7buPdZa7fEuRtTefXflwz8nn2+?=
 =?us-ascii?Q?f3i8vsjLTdqZ4+OhJr2uffpvIg964467Q2lNX/vY3LAEc/WA+zm9MD5D22R/?=
 =?us-ascii?Q?cVwJSucU59kY55CdUoQ9Mx3Y63+bAXLL3N9GD+NYko8xFW2j7CDHJ1cybHy3?=
 =?us-ascii?Q?03T5a+tMqk4ZVjt8XzX8g7bDbm38rfcXAkpLyiZPVJwFHo1OKr9YGQ5tsLru?=
 =?us-ascii?Q?9GqYAOgXkxqpcFUoI3zBqAwUzU/tvUQ4d4UQ49Vw3xpqvOZtCWkcGCw5LxHM?=
 =?us-ascii?Q?UJ9RfEiB3pDU0BGdKbCVeHhsdt4NLlC7jARDBTSI+wkurCCgWSvJdiqpEJJt?=
 =?us-ascii?Q?TB3cbPKdwNKp9H9FybS40+obUuLS5RwMptBMCLMh0TM8c/Peu50j4ncKsj3Q?=
 =?us-ascii?Q?wWO0PTnXTw1Z4FEPTwhUbhB+pDVzf7G60nPtJYpRlx2qyHOSFAuMK3AT9TMW?=
 =?us-ascii?Q?crCDV7ZKenBpYKaBXvpqvUodGK7sPNLZp/bowBkgxHgLCn1KOzFxeWgnxN12?=
 =?us-ascii?Q?o8iU5xwNt5eaEM8qmIA4vpMaRJcqpJO9ptzTylKB1Ej5aC8oxx+bEwxBv4wn?=
 =?us-ascii?Q?fQcpODqYEKW5KHw69cxPLQi9LUAzsxH+fWUh36mE/NvUYd+0tULw/PIoaRVD?=
 =?us-ascii?Q?Tau3zQyIf0m9rczUXEU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5108a5e-5448-415d-ad1a-08dc440387ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 08:48:33.1956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 877J2k77Ke6oeaScrgN/OITjh/xmMqdSVRj0v6ojs7rWMVYbn6fKBCipEeJDlvRG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang
> Wang
> Sent: Thursday, March 14, 2024 4:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: add ras event id support
>
> add amdgpu ras event id support to better distinguish different error inf=
ormation
> sources in dmesg logs.
>
> the following log will be identify by event id:
> {event_id} interrupt to inform RAS event {event_id} ACA logs {event_id} e=
rrors
> statistic since from current injection/error query {event_id} errors stat=
istic since
> from gpu load
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c  |  32 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h  |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 203 +++++++++++++++--------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  30 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |   1 +
>  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c   |  10 +-
>  6 files changed, 191 insertions(+), 88 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> index 24ad4b97177b..0734490347db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -210,22 +210,26 @@ int amdgpu_mca_smu_set_debug_mode(struct
> amdgpu_device *adev, bool enable)
>       return -EOPNOTSUPP;
>  }
>
> -static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev,
> int idx, struct mca_bank_entry *entry)
> +static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev,
> int idx, struct mca_bank_entry *entry,
> +                                      struct ras_query_context *qctx)
>  {
> -     dev_info(adev->dev, HW_ERR "Accelerator Check Architecture events
> logged\n");
> -     dev_info(adev->dev, HW_ERR "aca entry[%02d].STATUS=3D0x%016llx\n",
> -              idx, entry->regs[MCA_REG_IDX_STATUS]);
> -     dev_info(adev->dev, HW_ERR "aca entry[%02d].ADDR=3D0x%016llx\n",
> -              idx, entry->regs[MCA_REG_IDX_ADDR]);
> -     dev_info(adev->dev, HW_ERR "aca entry[%02d].MISC0=3D0x%016llx\n",
> -              idx, entry->regs[MCA_REG_IDX_MISC0]);
> -     dev_info(adev->dev, HW_ERR "aca entry[%02d].IPID=3D0x%016llx\n",
> -              idx, entry->regs[MCA_REG_IDX_IPID]);
> -     dev_info(adev->dev, HW_ERR "aca entry[%02d].SYND=3D0x%016llx\n",
> -              idx, entry->regs[MCA_REG_IDX_SYND]);
> +     u64 event_id =3D qctx->event_id;
> +
> +     RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check
> Architecture events logged\n");
> +     RAS_EVENT_LOG(adev, event_id, HW_ERR "aca
> entry[%02d].STATUS=3D0x%016llx\n",
> +                   idx, entry->regs[MCA_REG_IDX_STATUS]);
> +     RAS_EVENT_LOG(adev, event_id, HW_ERR "aca
> entry[%02d].ADDR=3D0x%016llx\n",
> +                   idx, entry->regs[MCA_REG_IDX_ADDR]);
> +     RAS_EVENT_LOG(adev, event_id, HW_ERR "aca
> entry[%02d].MISC0=3D0x%016llx\n",
> +                   idx, entry->regs[MCA_REG_IDX_MISC0]);
> +     RAS_EVENT_LOG(adev, event_id, HW_ERR "aca
> entry[%02d].IPID=3D0x%016llx\n",
> +                   idx, entry->regs[MCA_REG_IDX_IPID]);
> +     RAS_EVENT_LOG(adev, event_id, HW_ERR "aca
> entry[%02d].SYND=3D0x%016llx\n",
> +                   idx, entry->regs[MCA_REG_IDX_SYND]);
>  }
>
> -int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum
> amdgpu_ras_block blk, enum amdgpu_mca_error_type type, struct ras_err_dat=
a
> *err_data)
> +int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum
> amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
> +                              struct ras_err_data *err_data, struct
> ras_query_context *qctx)
>  {
>       struct amdgpu_smuio_mcm_config_info mcm_info;
>       struct ras_err_addr err_addr =3D {0};
> @@ -244,7 +248,7 @@ int amdgpu_mca_smu_log_ras_error(struct
> amdgpu_device *adev, enum amdgpu_ras_blo
>       list_for_each_entry(node, &mca_set.list, node) {
>               entry =3D &node->entry;
>
> -             amdgpu_mca_smu_mca_bank_dump(adev, i++, entry);
> +             amdgpu_mca_smu_mca_bank_dump(adev, i++, entry, qctx);
>
>               count =3D 0;
>               ret =3D amdgpu_mca_smu_parse_mca_error_count(adev, blk, typ=
e,
> entry, &count); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> index b964110ed1e0..e5bf07ce3451 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> @@ -169,6 +169,7 @@ void amdgpu_mca_smu_debugfs_init(struct
> amdgpu_device *adev, struct dentry *root  void
> amdgpu_mca_bank_set_init(struct mca_bank_set *mca_set);  int
> amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct
> mca_bank_entry *entry);  void amdgpu_mca_bank_set_release(struct
> mca_bank_set *mca_set); -int amdgpu_mca_smu_log_ras_error(struct
> amdgpu_device *adev, enum amdgpu_ras_block blk, enum
> amdgpu_mca_error_type type, struct ras_err_data *err_data);
> +int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum
> amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
> +                              struct ras_err_data *err_data, struct
> ras_query_context *qctx);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8ebab6f22e5a..ef87f107c942 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1045,6 +1045,7 @@ static void amdgpu_ras_get_ecc_info(struct
> amdgpu_device *adev, struct ras_err_d  static void
> amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
>                                             struct ras_manager *ras_mgr,
>                                             struct ras_err_data *err_data=
,
> +                                           struct ras_query_context *qct=
x,
>                                             const char *blk_name,
>                                             bool is_ue,
>                                             bool is_de)
> @@ -1052,27 +1053,28 @@ static void
> amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
>       struct amdgpu_smuio_mcm_config_info *mcm_info;
>       struct ras_err_node *err_node;
>       struct ras_err_info *err_info;
> +     u64 event_id =3D qctx->event_id;
>
>       if (is_ue) {
>               for_each_ras_error(err_node, err_data) {
>                       err_info =3D &err_node->err_info;
>                       mcm_info =3D &err_info->mcm_info;
>                       if (err_info->ue_count) {
> -                             dev_info(adev->dev, "socket: %d, die: %d, "
> -                                      "%lld new uncorrectable hardware
> errors detected in %s block\n",
> -                                      mcm_info->socket_id,
> -                                      mcm_info->die_id,
> -                                      err_info->ue_count,
> -                                      blk_name);
> +                             RAS_EVENT_LOG(adev, event_id, "socket: %d,
> die: %d, "
> +                                           "%lld new uncorrectable hardw=
are
> errors detected in %s block\n",
> +                                           mcm_info->socket_id,
> +                                           mcm_info->die_id,
> +                                           err_info->ue_count,
> +                                           blk_name);
>                       }
>               }
>
>               for_each_ras_error(err_node, &ras_mgr->err_data) {
>                       err_info =3D &err_node->err_info;
>                       mcm_info =3D &err_info->mcm_info;
> -                     dev_info(adev->dev, "socket: %d, die: %d, "
> -                              "%lld uncorrectable hardware errors detect=
ed
> in total in %s block\n",
> -                              mcm_info->socket_id, mcm_info->die_id,
> err_info->ue_count, blk_name);
> +                     RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d,=
 "
> +                                   "%lld uncorrectable hardware errors
> detected in total in %s block\n",
> +                                   mcm_info->socket_id, mcm_info->die_id=
,
> err_info->ue_count,
> +blk_name);
>               }
>
>       } else {
> @@ -1081,44 +1083,44 @@ static void
> amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
>                               err_info =3D &err_node->err_info;
>                               mcm_info =3D &err_info->mcm_info;
>                               if (err_info->de_count) {
> -                                     dev_info(adev->dev, "socket: %d,
> die: %d, "
> -                                             "%lld new deferred hardware
> errors detected in %s block\n",
> -                                             mcm_info->socket_id,
> -                                             mcm_info->die_id,
> -                                             err_info->de_count,
> -                                             blk_name);
> +                                     RAS_EVENT_LOG(adev, event_id,
> "socket: %d, die: %d, "
> +                                                   "%lld new deferred
> hardware errors detected in %s block\n",
> +                                                   mcm_info->socket_id,
> +                                                   mcm_info->die_id,
> +                                                   err_info->de_count,
> +                                                   blk_name);
>                               }
>                       }
>
>                       for_each_ras_error(err_node, &ras_mgr->err_data) {
>                               err_info =3D &err_node->err_info;
>                               mcm_info =3D &err_info->mcm_info;
> -                             dev_info(adev->dev, "socket: %d, die: %d, "
> -                                     "%lld deferred hardware errors
> detected in total in %s block\n",
> -                                     mcm_info->socket_id, mcm_info-
> >die_id,
> -                                     err_info->de_count, blk_name);
> +                             RAS_EVENT_LOG(adev, event_id, "socket: %d,
> die: %d, "
> +                                           "%lld deferred hardware error=
s
> detected in total in %s block\n",
> +                                           mcm_info->socket_id, mcm_info=
-
> >die_id,
> +                                           err_info->de_count, blk_name)=
;
>                       }
>               } else {
>                       for_each_ras_error(err_node, err_data) {
>                               err_info =3D &err_node->err_info;
>                               mcm_info =3D &err_info->mcm_info;
>                               if (err_info->ce_count) {
> -                                     dev_info(adev->dev, "socket: %d,
> die: %d, "
> -                                             "%lld new correctable
> hardware errors detected in %s block\n",
> -                                             mcm_info->socket_id,
> -                                             mcm_info->die_id,
> -                                             err_info->ce_count,
> -                                             blk_name);
> +                                     RAS_EVENT_LOG(adev, event_id,
> "socket: %d, die: %d, "
> +                                                   "%lld new correctable
> hardware errors detected in %s block\n",
> +                                                   mcm_info->socket_id,
> +                                                   mcm_info->die_id,
> +                                                   err_info->ce_count,
> +                                                   blk_name);
>                               }
>                       }
>
>                       for_each_ras_error(err_node, &ras_mgr->err_data) {
>                               err_info =3D &err_node->err_info;
>                               mcm_info =3D &err_info->mcm_info;
> -                             dev_info(adev->dev, "socket: %d, die: %d, "
> -                                     "%lld correctable hardware errors
> detected in total in %s block\n",
> -                                     mcm_info->socket_id, mcm_info-
> >die_id,
> -                                     err_info->ce_count, blk_name);
> +                             RAS_EVENT_LOG(adev, event_id, "socket: %d,
> die: %d, "
> +                                           "%lld correctable hardware er=
rors
> detected in total in %s block\n",
> +                                           mcm_info->socket_id, mcm_info=
-
> >die_id,
> +                                           err_info->ce_count, blk_name)=
;
>                       }
>               }
>       }
> @@ -1131,77 +1133,79 @@ static inline bool err_data_has_source_info(struc=
t
> ras_err_data *data)
>
>  static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
>                                            struct ras_query_if *query_if,
> -                                          struct ras_err_data *err_data)
> +                                          struct ras_err_data *err_data,
> +                                          struct ras_query_context *qctx=
)
>  {
>       struct ras_manager *ras_mgr =3D amdgpu_ras_find_obj(adev, &query_if=
-
> >head);
>       const char *blk_name =3D get_ras_block_str(&query_if->head);
> +     u64 event_id =3D qctx->event_id;
>
>       if (err_data->ce_count) {
>               if (err_data_has_source_info(err_data)) {
> -                     amdgpu_ras_error_print_error_data(adev, ras_mgr,
> err_data,
> +                     amdgpu_ras_error_print_error_data(adev, ras_mgr,
> err_data, qctx,
>                                                         blk_name, false,
> false);
>               } else if (!adev->aid_mask &&
>                          adev->smuio.funcs &&
>                          adev->smuio.funcs->get_socket_id &&
>                          adev->smuio.funcs->get_die_id) {
> -                     dev_info(adev->dev, "socket: %d, die: %d "
> -                              "%ld correctable hardware errors "
> -                              "detected in %s block\n",
> -                              adev->smuio.funcs->get_socket_id(adev),
> -                              adev->smuio.funcs->get_die_id(adev),
> -                              ras_mgr->err_data.ce_count,
> -                              blk_name);
> +                     RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d =
"
> +                                   "%ld correctable hardware errors "
> +                                   "detected in %s block\n",
> +                                   adev->smuio.funcs->get_socket_id(adev=
),
> +                                   adev->smuio.funcs->get_die_id(adev),
> +                                   ras_mgr->err_data.ce_count,
> +                                   blk_name);
>               } else {
> -                     dev_info(adev->dev, "%ld correctable hardware error=
s "
> -                              "detected in %s block\n",
> -                              ras_mgr->err_data.ce_count,
> -                              blk_name);
> +                     RAS_EVENT_LOG(adev, event_id, "%ld correctable
> hardware errors "
> +                                   "detected in %s block\n",
> +                                   ras_mgr->err_data.ce_count,
> +                                   blk_name);
>               }
>       }
>
>       if (err_data->ue_count) {
>               if (err_data_has_source_info(err_data)) {
> -                     amdgpu_ras_error_print_error_data(adev, ras_mgr,
> err_data,
> +                     amdgpu_ras_error_print_error_data(adev, ras_mgr,
> err_data, qctx,
>                                                         blk_name, true,
> false);
>               } else if (!adev->aid_mask &&
>                          adev->smuio.funcs &&
>                          adev->smuio.funcs->get_socket_id &&
>                          adev->smuio.funcs->get_die_id) {
> -                     dev_info(adev->dev, "socket: %d, die: %d "
> -                              "%ld uncorrectable hardware errors "
> -                              "detected in %s block\n",
> -                              adev->smuio.funcs->get_socket_id(adev),
> -                              adev->smuio.funcs->get_die_id(adev),
> -                              ras_mgr->err_data.ue_count,
> -                              blk_name);
> +                     RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d =
"
> +                                   "%ld uncorrectable hardware errors "
> +                                   "detected in %s block\n",
> +                                   adev->smuio.funcs->get_socket_id(adev=
),
> +                                   adev->smuio.funcs->get_die_id(adev),
> +                                   ras_mgr->err_data.ue_count,
> +                                   blk_name);
>               } else {
> -                     dev_info(adev->dev, "%ld uncorrectable hardware err=
ors
> "
> -                              "detected in %s block\n",
> -                              ras_mgr->err_data.ue_count,
> -                              blk_name);
> +                     RAS_EVENT_LOG(adev, event_id, "%ld uncorrectable
> hardware errors "
> +                                   "detected in %s block\n",
> +                                   ras_mgr->err_data.ue_count,
> +                                   blk_name);
>               }
>       }
>
>       if (err_data->de_count) {
>               if (err_data_has_source_info(err_data)) {
> -                     amdgpu_ras_error_print_error_data(adev, ras_mgr,
> err_data,
> +                     amdgpu_ras_error_print_error_data(adev, ras_mgr,
> err_data, qctx,
>                                                         blk_name, false,
> true);
>               } else if (!adev->aid_mask &&
>                          adev->smuio.funcs &&
>                          adev->smuio.funcs->get_socket_id &&
>                          adev->smuio.funcs->get_die_id) {
> -                     dev_info(adev->dev, "socket: %d, die: %d "
> -                              "%ld deferred hardware errors "
> -                              "detected in %s block\n",
> -                              adev->smuio.funcs->get_socket_id(adev),
> -                              adev->smuio.funcs->get_die_id(adev),
> -                              ras_mgr->err_data.de_count,
> -                              blk_name);
> +                     RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d =
"
> +                                   "%ld deferred hardware errors "
> +                                   "detected in %s block\n",
> +                                   adev->smuio.funcs->get_socket_id(adev=
),
> +                                   adev->smuio.funcs->get_die_id(adev),
> +                                   ras_mgr->err_data.de_count,
> +                                   blk_name);
>               } else {
> -                     dev_info(adev->dev, "%ld deferred hardware errors "
> -                              "detected in %s block\n",
> -                              ras_mgr->err_data.de_count,
> -                              blk_name);
> +                     RAS_EVENT_LOG(adev, event_id, "%ld deferred
> hardware errors "
> +                                   "detected in %s block\n",
> +                                   ras_mgr->err_data.de_count,
> +                                   blk_name);
>               }
>       }
>  }
> @@ -1294,6 +1298,7 @@ ssize_t amdgpu_ras_aca_sysfs_read(struct device
> *dev, struct device_attribute *a  static int
> amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
>                                               struct ras_query_if *info,
>                                               struct ras_err_data *err_da=
ta,
> +                                             struct ras_query_context
> *qctx,
>                                               unsigned int
> error_query_mode)
>  {
>       enum amdgpu_ras_block blk =3D info ? info->head.block :
> AMDGPU_RAS_BLOCK_COUNT; @@ -1338,8 +1343,8 @@ static int
> amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
>                               return ret;
>               } else {
>                       /* FIXME: add code to check return value later */
> -                     amdgpu_mca_smu_log_ras_error(adev, blk,
> AMDGPU_MCA_ERROR_TYPE_UE, err_data);
> -                     amdgpu_mca_smu_log_ras_error(adev, blk,
> AMDGPU_MCA_ERROR_TYPE_CE, err_data);
> +                     amdgpu_mca_smu_log_ras_error(adev, blk,
> AMDGPU_MCA_ERROR_TYPE_UE, err_data, qctx);
> +                     amdgpu_mca_smu_log_ras_error(adev, blk,
> AMDGPU_MCA_ERROR_TYPE_CE,
> +err_data, qctx);
>               }
>       }
>
> @@ -1351,6 +1356,7 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev, struct ras_query_i  {
>       struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
>       struct ras_err_data err_data;
> +     struct ras_query_context qctx;
>       unsigned int error_query_mode;
>       int ret;
>
> @@ -1364,8 +1370,12 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev, struct ras_query_i
>       if (!amdgpu_ras_get_error_query_mode(adev, &error_query_mode))
>               return -EINVAL;
>
> +     memset(&qctx, 0, sizeof(qctx));
> +     qctx.event_id =3D amdgpu_ras_acquire_event_id(adev,
> amdgpu_ras_intr_triggered() ?
> +                                                RAS_EVENT_TYPE_ISR :
> RAS_EVENT_TYPE_INVALID);
>       ret =3D amdgpu_ras_query_error_status_helper(adev, info,
>                                                  &err_data,
> +                                                &qctx,
>                                                  error_query_mode);
>       if (ret)
>               goto out_fini_err_data;
> @@ -1376,7 +1386,7 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev, struct ras_query_i
>       info->ce_count =3D obj->err_data.ce_count;
>       info->de_count =3D obj->err_data.de_count;
>
> -     amdgpu_ras_error_generate_report(adev, info, &err_data);
> +     amdgpu_ras_error_generate_report(adev, info, &err_data, &qctx);
>
>  out_fini_err_data:
>       amdgpu_ras_error_data_fini(&err_data);
> @@ -3036,6 +3046,31 @@ static int amdgpu_get_ras_schema(struct
> amdgpu_device *adev)
>                       AMDGPU_RAS_ERROR__PARITY;
>  }
>
> +static void ras_event_mgr_init(struct ras_event_manager *mgr) {
> +     int i;
> +
> +     for (i =3D 0; i < ARRAY_SIZE(mgr->seqnos); i++)
> +             atomic64_set(&mgr->seqnos[i], 0);
> +}
> +
> +static void amdgpu_ras_event_mgr_init(struct amdgpu_device *adev) {
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +     struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);
> +
> +     ras->event_mgr =3D hive ? &hive->event_mgr : &ras->__event_mgr;
> +
> +     /* init event manager with node 0 on xgmi system */
> +     if (!amdgpu_in_reset(adev)) {
> +             if (!hive || adev->gmc.xgmi.node_id =3D=3D 0)
> +                     ras_event_mgr_init(ras->event_mgr);
> +     }
> +
> +     if (hive)
> +             amdgpu_put_xgmi_hive(hive);
> +}
> +
>  int amdgpu_ras_init(struct amdgpu_device *adev)  {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev); @@ -3356,6
> +3391,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
>       if (amdgpu_sriov_vf(adev))
>               return 0;
>
> +     amdgpu_ras_event_mgr_init(adev);
> +
>       if (amdgpu_aca_is_enabled(adev)) {
>               if (amdgpu_in_reset(adev))
>                       r =3D amdgpu_aca_reset(adev);
> @@ -3472,13 +3509,37 @@ void amdgpu_ras_set_fed(struct amdgpu_device
> *adev, bool status)
>               atomic_set(&ras->fed, !!status);
>  }
>
> +bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id) {
> +     return !(id & BIT_ULL(63));
> +}
> +
> +u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum
> +ras_event_type type) {
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +     u64 id;
> +
> +     switch (type) {
> +     case RAS_EVENT_TYPE_ISR:
> +             id =3D (u64)atomic64_read(&ras->event_mgr->seqnos[type]);
> +             break;
> +     case RAS_EVENT_TYPE_INVALID:
> +     default:
> +             id =3D BIT_ULL(63) | 0ULL;
> +             break;
> +     }
> +
> +     return id;
> +}
> +
>  void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)  {
>       if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) =3D=3D 0) {
>               struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +             u64 event_id =3D
> +(u64)atomic64_inc_return(&ras->event_mgr->seqnos[RAS_EVENT_TYPE_ISR]);
>
> -             dev_info(adev->dev, "uncorrectable hardware error"
> -                     "(ERREVENT_ATHUB_INTERRUPT) detected!\n");
> +             RAS_EVENT_LOG(adev, event_id, "uncorrectable hardware
> error"
> +                           "(ERREVENT_ATHUB_INTERRUPT) detected!\n");
>
>               ras->gpu_reset_flags |=3D
> AMDGPU_RAS_GPU_RESET_MODE1_RESET;
>               amdgpu_ras_reset_gpu(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index e0f8ce9d8440..64788ae7d85d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -64,6 +64,14 @@ struct amdgpu_iv_entry;
>  /* The high three bits indicates socketid */  #define
> AMDGPU_RAS_GET_FEATURES(val)  ((val) &
> ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
>
> +#define RAS_EVENT_LOG(adev, id, fmt, ...)                            \
> +do {                                                                 \
> +     if (amdgpu_ras_event_id_is_valid((adev), (id)))                 \
> +         dev_info((adev)->dev, "{%llu}" fmt, (id), ##__VA_ARGS__);   \
> +     else                                                            \
> +         dev_info((adev)->dev, fmt, ##__VA_ARGS__);                  \
> +} while (0)
> +
>  enum amdgpu_ras_block {
>       AMDGPU_RAS_BLOCK__UMC =3D 0,
>       AMDGPU_RAS_BLOCK__SDMA,
> @@ -419,6 +427,21 @@ struct umc_ecc_info {
>       int record_ce_addr_supported;
>  };
>
> +enum ras_event_type {
> +     RAS_EVENT_TYPE_INVALID =3D -1,
> +     RAS_EVENT_TYPE_ISR =3D 0,
> +     RAS_EVENT_TYPE_COUNT,
> +};
> +
> +struct ras_event_manager {
> +     atomic64_t seqnos[RAS_EVENT_TYPE_COUNT]; };
> +
> +struct ras_query_context {
> +     enum ras_event_type type;
> +     u64 event_id;
> +};
> +
>  struct amdgpu_ras {
>       /* ras infrastructure */
>       /* for ras itself. */
> @@ -479,6 +502,11 @@ struct amdgpu_ras {
>       atomic_t page_retirement_req_cnt;
>       /* Fatal error detected flag */
>       atomic_t fed;
> +
> +     /* RAS event manager */
> +     struct ras_event_manager __event_mgr;
> +     struct ras_event_manager *event_mgr;
> +
>  };
>
>  struct ras_fs_data {
> @@ -879,4 +907,6 @@ void amdgpu_ras_del_mca_err_addr(struct ras_err_info
> *err_info,  void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool stat=
us);
> bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
>
> +bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id);
> +u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum
> +ras_event_type type);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 1592c63b3099..a3bfc16de6d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -44,6 +44,7 @@ struct amdgpu_hive_info {
>
>       struct amdgpu_reset_domain *reset_domain;
>       atomic_t ras_recovery;
> +     struct ras_event_manager event_mgr;
>  };
>
>  struct amdgpu_pcs_ras_field {
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 77af4e25ff46..4a02e1f041da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -404,10 +404,16 @@ static int umc_v12_0_err_cnt_init_per_channel(struc=
t
> amdgpu_device *adev,  static void
> umc_v12_0_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
>                                       void *ras_error_status)
>  {
> +     struct ras_query_context qctx;
> +
> +     memset(&qctx, 0, sizeof(qctx));
> +     qctx.event_id =3D amdgpu_ras_acquire_event_id(adev,
> amdgpu_ras_intr_triggered() ?
> +                                                 RAS_EVENT_TYPE_ISR :
> RAS_EVENT_TYPE_INVALID);
> +
>       amdgpu_mca_smu_log_ras_error(adev,
> -             AMDGPU_RAS_BLOCK__UMC,
> AMDGPU_MCA_ERROR_TYPE_CE, ras_error_status);
> +             AMDGPU_RAS_BLOCK__UMC,
> AMDGPU_MCA_ERROR_TYPE_CE, ras_error_status,
> +&qctx);
>       amdgpu_mca_smu_log_ras_error(adev,
> -             AMDGPU_RAS_BLOCK__UMC,
> AMDGPU_MCA_ERROR_TYPE_UE, ras_error_status);
> +             AMDGPU_RAS_BLOCK__UMC,
> AMDGPU_MCA_ERROR_TYPE_UE, ras_error_status,
> +&qctx);
>  }
>
>  static void umc_v12_0_ecc_info_query_ras_error_address(struct
> amdgpu_device *adev,
> --
> 2.34.1

