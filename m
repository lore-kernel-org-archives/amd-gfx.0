Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E46C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 08:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C35B10E126;
	Tue,  2 Jan 2024 08:52:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44AD210E126
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 08:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ehwg8Aq2ZUGrvmur7jTNQPiu4l+yK7NPXz6mIP66/ObL87UMa9hTSSWxOaO9VClzNkPLy4TVGAlFovUzbAO6c6Naa0uKrmTZE0AaG1rMquADv7H3TJtczsPUulIt748iGsPqrtAF0ff+Wfaf2vJQymFQVgFA3ldVbdn3Xj1M0FQHkI+ywiER2vRnaYmslYdiVP9xF5eobQi0H+mEDpwFw1Ajc4q7txGAbEf8WDocSwqpZGyh7tPCUTSYeHhLMqZYJY6jnkASR/xtDtjq7UjSbnFbZt0wIo3NEs6WtYbFyAfZaaJVal+Xe7qrgrjTr4TgF20XYVrGfI0o+Twc7DwnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNp4LqUvsmmm/Bi7m0ZpIvXhM/0WyFPXB1qtxU9UiHs=;
 b=LBH8hJNKP6sMp6SopJzpPWFDUDR5IGwxzBs66xYW/lNBFrsDD66X/cnwgFTg48KDEWJPpOybDtvVJuy/LmgoDuCCh/KopaODDUipzMIw2TSPRNi55vjVnPO6/61HZAv7EKTZghL1FoS+uIVOTguS0Yh6JVH1hsh3aJlBIpa6T+m7Ylqvq63pM8plrW9a15gTr/AYDkvJi4DwoCtcEoqLfLooDOITCIMJxgMMae8ta28+xQXQb+9f6tAZDu9zp+ErLFwElLFwXeK2NwuJ95HQUMgImd5gUiIg2pz+iPjSQIDqv5lIUQxiGOT7x8+lyMqfylCbuCNkPxlvL6+zIbSzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNp4LqUvsmmm/Bi7m0ZpIvXhM/0WyFPXB1qtxU9UiHs=;
 b=qaBgt7p1G7e8CYq9TDRJFshpPleerKci67o9lco3zcRmjrIF57Pw5iRq+kQlfRz800PbQOslrZ5cgpfPneTTP9bQTqUbNrEw+2z3l7ZlBxtzxkPMNgZ6lQi0hWKe4d16PqWaXXBILEvfTo8rTje0+j8hQEXWOArYbbowlkvKSDw=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:52:45 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:52:44 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Replace DRM_* with dev_* in amdgpu_psp.c
Thread-Topic: [PATCH 3/3] drm/amdgpu: Replace DRM_* with dev_* in amdgpu_psp.c
Thread-Index: AQHaPS4zECNOoJ02Fk+Gbf2FZIYXm7DGN6XA
Date: Tue, 2 Jan 2024 08:52:44 +0000
Message-ID: <PH7PR12MB87966AC11787B9A690887DCAB061A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240102034508.16426-1-Hawking.Zhang@amd.com>
 <20240102034508.16426-3-Hawking.Zhang@amd.com>
In-Reply-To: <20240102034508.16426-3-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d8500a30-9936-46a6-a471-1f70ddd22d9c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T08:52:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS0PR12MB8248:EE_
x-ms-office365-filtering-correlation-id: 68751e40-8a81-44c4-3ebf-08dc0b702fef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QAx+OZfAJF3DZI7OVjHiSPfJOMPHLEwXx7Xg31tUM6mR7lHR4dPwAg7m+wGF2c2t0Ad4tkkbgonwNE5V7nCGdKp3kt1fhArLKimwZ5T3YjelUsdz5mdfujDe4HXqV3DvVOJxvlvnCogBSA6cmFqOMR1nB6aZSu7FrVBl6J09duaBpM07GUu2YHNh2IztnI9xk41kbylH03k4xV9rBkWnk+O/eq3BadFiFWWyfpY4A34juX2GfE7LE5TkxoI+wUbcefR9/NqxqPQ5IUNwJrvh1pML/Yq41pgoVb4whgqu/a4Ed18Qw5v4tgthaAgJjhm5EQ/clrhIxLmVML8mNcLrlA36TLUHCBEuH/t0O61GtwBz09lmtAghqzQ7bukwnQXR9ZwPXyhcLb0MtlZUv2Cx6IWed0aKRhNGPw8dcDAcQ5omTlccIxlBGO6xS8N6brYwhOL0zxpaoKUBIIXITKB+hqCKE1+4sFy4BBUzVxU6I09TI3e/naSlZVs+gSXGBrRNyP8nifeak3H3jB6dweqOMo5KOZNrS8Y9WKtlV1XeAsJgC4l7ZozqpuoafyYoDpFNfx5SatyclwHY7fDx8TnEdeae+x8sUUoJA+B7jYgNsQrJLx3HHsStJweiK1wIODqP0lXHv2B1gvLWHGQh7shOpVUGrRLm3XkXUaYUyLQdbOoQCFqfDb6nSf9dGVlsGN7h
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(55016003)(6506007)(7696005)(9686003)(71200400001)(53546011)(921011)(478600001)(86362001)(38100700002)(38070700009)(33656002)(30864003)(41300700001)(2906002)(26005)(122000001)(52536014)(66476007)(64756008)(66446008)(110136005)(66946007)(4326008)(316002)(54906003)(66556008)(6636002)(76116006)(83380400001)(5660300002)(8676002)(8936002)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WuYEdFZ9JE+sKcxdr2BxmqnGCTyhqWi+w5vnEAR0HzY3Xq9X31gMQK2y6vx+?=
 =?us-ascii?Q?9HKOrnNe77n/dfCcMxCmcVySybvPbowGvTew9J9l7AZhMFiCdAlBv66uWOEd?=
 =?us-ascii?Q?eN80pSnNB9EqP4Ld2rfiEoI+VH3d0zW8zHUe4Q82FiWjRDcKbxEhs38qke5Y?=
 =?us-ascii?Q?8bag2Nhgjqg4J17R3TR/4OyFwEjNHYHpceWiLqo1AlGnPhtYq/I8GkZKyZ19?=
 =?us-ascii?Q?m/bxVMPIBkqEswFwKCufaH1vM7xrUM+2XQj4sWS70+Tl+n2beGtBgmQ4BkFa?=
 =?us-ascii?Q?yruM51b1LaMyuNrsYm/+1S2EfUOGuEiZCnBtIUXnxnWWc8yQnmzI1ev9PYYH?=
 =?us-ascii?Q?YrX/gclCaC5RXAwIOtrVO4begIxEi/7xEc0XR8DIfO7T+OisM3N8FQhYDZgH?=
 =?us-ascii?Q?wnWrO243K6oRpZzvih+8t43MNlp8s3rcvhAI40MhzSEyzu6hXJ7tGwa7wLtU?=
 =?us-ascii?Q?7DpsAhCHzwpvQ3omee0Iei8KlawwRd9N9wCFi9k7SNGSyZUXhWLDM9AzRdSk?=
 =?us-ascii?Q?sxMqlRvrrXVnVQiTH7SPPuPhW/sYViH2Z4lzYCF+p4jNXx0VMyBRuleZVYHn?=
 =?us-ascii?Q?0AxYJAsVowKT6DM8E6vGte1cgeBKIBPDTD9wzeeSurzRkvprs12bdXu/IscO?=
 =?us-ascii?Q?oVPGB4WuzxilMEr4GeVZPBLMMvy0kI0RvF3a7iPq9CafB7NP/fZ4YXMQVFTp?=
 =?us-ascii?Q?RH+ilIVCNO98aaeLi4FSytb9jJz5If+NnwahBbR47NDUviOtiwmq+x6kGsPd?=
 =?us-ascii?Q?T9NUsTafKhR1CR3pDAkIaQYUKdqs0A4GSpZF9hPMCS9QJaGzNXYceKjNBlUT?=
 =?us-ascii?Q?fwBshI9Ku8RX1BNQLAhJHI1P/WpfqeqXUj0MHfldVnGOLjnONSknTJsg8+9d?=
 =?us-ascii?Q?oHJQSa9rHkaxt8rLUoqQ5Hfp8L2NIL3GntO6bmfjp53njH8jExBHUXUijQRE?=
 =?us-ascii?Q?zhEy5Skx4gxMS60M6D95PK6S+iz9B2TbClviKmCS7CuCiP/+a3uTLPd7X2xy?=
 =?us-ascii?Q?6qIuXBIOPWQnRheQdNoeE7pO/Dem8gcGEgzQgmH1O1eUShXn9KgVClweAXrM?=
 =?us-ascii?Q?sO7f1vi4My9OYQ3Jsxxzd/c/jxZyEANMjRERT4aGZYpi42vEW+NrqTtAqthy?=
 =?us-ascii?Q?OfYtGwrWAYBLUv52PF6pXFo65xRx1idCgLwSkinCze61SeWVL8kB+nwMAkE5?=
 =?us-ascii?Q?W6GxCs/Ui61Es/HG3//4bIB4xxZ8MFwU3phwJbF6Ko02HQTNZlDRsfJJ9PlL?=
 =?us-ascii?Q?wwc5x4skTr/pk1jVX7i7ZkaqphfzTR79UJVkXcMIMaH+kqf/kWsXupwe7YYI?=
 =?us-ascii?Q?DdAQKmsT8Bj9MY68do5XNoQHOmDOzvzpB3f1xk98hrT/k7/Q/vbHqlpARjJP?=
 =?us-ascii?Q?Rx2Vucoeu5F3rwoZHJhtcwt4sfSPQ9OEURaN3W+RXg1u28RZIFIBZi8v7K7Z?=
 =?us-ascii?Q?BGbXZD5/+jMgIohzmcPBzm7nSCKDlRi4fmnmkmEdvzuCayFaiOeiAEoOpPxp?=
 =?us-ascii?Q?7tpCH46SPLe8ZcMvCV+VX48j3wyyCtDWk8oz8x42SHbg5b1zGF97DOvgXuiF?=
 =?us-ascii?Q?72DKm/ui2NwoQh88chs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68751e40-8a81-44c4-3ebf-08dc0b702fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 08:52:44.7938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPvfUkqPL6aozyhTtQJWcQ3coAdFv3CKNxQU3XWkeQsp/N+52Hmmp+QrQQLdA7X2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawkin=
g
> Zhang
> Sent: Tuesday, January 2, 2024 11:45 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le
> <Le.Ma@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Replace DRM_* with dev_* in amdgpu_psp.c
>
> So kernel message has the device pcie bdf information, which helps issue
> debugging especially in multiple GPU system.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 144 ++++++++++++------------
>  1 file changed, 75 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 8a3847d3041f..0d871479ff34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -291,21 +291,22 @@ static int psp_memory_training_init(struct psp_cont=
ext
> *psp)
>       struct psp_memory_training_context *ctx =3D &psp->mem_train_ctx;
>
>       if (ctx->init !=3D PSP_MEM_TRAIN_RESERVE_SUCCESS) {
> -             DRM_DEBUG("memory training is not supported!\n");
> +             dev_dbg(psp->adev->dev, "memory training is not
> supported!\n");
>               return 0;
>       }
>
>       ctx->sys_cache =3D kzalloc(ctx->train_data_size, GFP_KERNEL);
>       if (ctx->sys_cache =3D=3D NULL) {
> -             DRM_ERROR("alloc mem_train_ctx.sys_cache failed!\n");
> +             dev_err(psp->adev->dev, "alloc mem_train_ctx.sys_cache
> failed!\n");
>               ret =3D -ENOMEM;
>               goto Err_out;
>       }
>
> -
>       DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_trai=
n
> _data_offset:%llx.\n",
> -               ctx->train_data_size,
> -               ctx->p2c_train_data_offset,
> -               ctx->c2p_train_data_offset);
> +     dev_dbg(psp->adev->dev,
> +
>       "train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_off=
set:
> %llx.\n",
> +             ctx->train_data_size,
> +             ctx->p2c_train_data_offset,
> +             ctx->c2p_train_data_offset);
>       ctx->init =3D PSP_MEM_TRAIN_INIT_SUCCESS;
>       return 0;
>
> @@ -407,7 +408,7 @@ static int psp_sw_init(void *handle)
>
>       psp->cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
>       if (!psp->cmd) {
> -             DRM_ERROR("Failed to allocate memory to command
> buffer!\n");
> +             dev_err(adev->dev, "Failed to allocate memory to command
> buffer!\n");
>               ret =3D -ENOMEM;
>       }
>
> @@ -454,13 +455,13 @@ static int psp_sw_init(void *handle)
>       if (mem_training_ctx->enable_mem_training) {
>               ret =3D psp_memory_training_init(psp);
>               if (ret) {
> -                     DRM_ERROR("Failed to initialize memory training!\n"=
);
> +                     dev_err(adev->dev, "Failed to initialize memory
> training!\n");
>                       return ret;
>               }
>
>               ret =3D psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
>               if (ret) {
> -                     DRM_ERROR("Failed to process memory training!\n");
> +                     dev_err(adev->dev, "Failed to process memory
> training!\n");
>                       return ret;
>               }
>       }
> @@ -675,9 +676,11 @@ psp_cmd_submit_buf(struct psp_context *psp,
>        */
>       if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout)
> && !ras_intr) {
>               if (ucode)
> -                     DRM_WARN("failed to load ucode %s(0x%X) ",
> -                               amdgpu_ucode_name(ucode->ucode_id),
> ucode->ucode_id);
> -             DRM_WARN("psp gfx command %s(0x%X) failed and response
> status is (0x%X)\n",
> +                     dev_warn(psp->adev->dev,
> +                              "failed to load ucode %s(0x%X) ",
> +                              amdgpu_ucode_name(ucode->ucode_id),
> ucode->ucode_id);
> +             dev_warn(psp->adev->dev,
> +                      "psp gfx command %s(0x%X) failed and response stat=
us
> is (0x%X)\n",
>                        psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id),
> psp->cmd_buf_mem->cmd_id,
>                        psp->cmd_buf_mem->resp.status);
>               /* If any firmware (including CAP) load fails under SRIOV, =
it
> should @@ -807,7 +810,7 @@ static int psp_tmr_init(struct psp_context *ps=
p)
>           psp->fw_pri_buf) {
>               ret =3D psp_load_toc(psp, &tmr_size);
>               if (ret) {
> -                     DRM_ERROR("Failed to load toc\n");
> +                     dev_err(psp->adev->dev, "Failed to load toc\n");
>                       return ret;
>               }
>       }
> @@ -855,7 +858,7 @@ static int psp_tmr_load(struct psp_context *psp)
>
>       psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
>       if (psp->tmr_bo)
> -             DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
> +             dev_info(psp->adev->dev, "reserve 0x%lx from 0x%llx for PSP
> TMR\n",
>                        amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
>
>       ret =3D psp_cmd_submit_buf(psp, NULL, cmd, @@ -1113,7 +1116,7 @@
> int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
>       psp_prep_reg_prog_cmd_buf(cmd, reg, value);
>       ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
>       if (ret)
> -             DRM_ERROR("PSP failed to program reg id %d", reg);
> +             dev_err(psp->adev->dev, "PSP failed to program reg id %d\n"=
,
> reg);
>
>       release_psp_cmd_buf(psp);
>
> @@ -1526,22 +1529,22 @@ static void psp_ras_ta_check_status(struct
> psp_context *psp)
>       switch (ras_cmd->ras_status) {
>       case TA_RAS_STATUS__ERROR_UNSUPPORTED_IP:
>               dev_warn(psp->adev->dev,
> -                             "RAS WARNING: cmd failed due to unsupported
> ip\n");
> +                      "RAS WARNING: cmd failed due to unsupported ip\n")=
;
>               break;
>       case TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ:
>               dev_warn(psp->adev->dev,
> -                             "RAS WARNING: cmd failed due to unsupported
> error injection\n");
> +                      "RAS WARNING: cmd failed due to unsupported error
> injection\n");
>               break;
>       case TA_RAS_STATUS__SUCCESS:
>               break;
>       case TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED:
>               if (ras_cmd->cmd_id =3D=3D
> TA_RAS_COMMAND__TRIGGER_ERROR)
>                       dev_warn(psp->adev->dev,
> -                                     "RAS WARNING: Inject error to criti=
cal
> region is not allowed\n");
> +                              "RAS WARNING: Inject error to critical reg=
ion is
> not allowed\n");
>               break;
>       default:
>               dev_warn(psp->adev->dev,
> -                             "RAS WARNING: ras status =3D 0x%X\n", ras_c=
md-
> >ras_status);
> +                      "RAS WARNING: ras status =3D 0x%X\n", ras_cmd-
> >ras_status);
>               break;
>       }
>  }
> @@ -1565,7 +1568,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_=
t
> ta_cmd_id)
>               return ret;
>
>       if (ras_cmd->if_version > RAS_TA_HOST_IF_VER) {
> -             DRM_WARN("RAS: Unsupported Interface");
> +             dev_warn(psp->adev->dev, "RAS: Unsupported Interface\n");
>               return -EINVAL;
>       }
>
> @@ -1715,7 +1718,7 @@ int psp_ras_initialize(struct psp_context *psp)
>               psp->ras_context.context.initialized =3D true;
>       else {
>               if (ras_cmd->ras_status)
> -                     dev_warn(psp->adev->dev, "RAS Init Status: 0x%X\n",
> ras_cmd->ras_status);
> +                     dev_warn(adev->dev, "RAS Init Status: 0x%X\n",
> ras_cmd->ras_status);
>
>               /* fail to load RAS TA */
>               psp->ras_context.context.initialized =3D false; @@ -2148,7
> +2151,7 @@ static int psp_hw_start(struct psp_context *psp)
>                   (psp->funcs->bootloader_load_kdb !=3D NULL)) {
>                       ret =3D psp_bootloader_load_kdb(psp);
>                       if (ret) {
> -                             DRM_ERROR("PSP load kdb failed!\n");
> +                             dev_err(adev->dev, "PSP load kdb failed!\n"=
);
>                               return ret;
>                       }
>               }
> @@ -2157,7 +2160,7 @@ static int psp_hw_start(struct psp_context *psp)
>                   (psp->funcs->bootloader_load_spl !=3D NULL)) {
>                       ret =3D psp_bootloader_load_spl(psp);
>                       if (ret) {
> -                             DRM_ERROR("PSP load spl failed!\n");
> +                             dev_err(adev->dev, "PSP load spl failed!\n"=
);
>                               return ret;
>                       }
>               }
> @@ -2166,7 +2169,7 @@ static int psp_hw_start(struct psp_context *psp)
>                   (psp->funcs->bootloader_load_sysdrv !=3D NULL)) {
>                       ret =3D psp_bootloader_load_sysdrv(psp);
>                       if (ret) {
> -                             DRM_ERROR("PSP load sys drv failed!\n");
> +                             dev_err(adev->dev, "PSP load sys drv failed=
!\n");
>                               return ret;
>                       }
>               }
> @@ -2175,7 +2178,7 @@ static int psp_hw_start(struct psp_context *psp)
>                   (psp->funcs->bootloader_load_soc_drv !=3D NULL)) {
>                       ret =3D psp_bootloader_load_soc_drv(psp);
>                       if (ret) {
> -                             DRM_ERROR("PSP load soc drv failed!\n");
> +                             dev_err(adev->dev, "PSP load soc drv
> failed!\n");
>                               return ret;
>                       }
>               }
> @@ -2184,7 +2187,7 @@ static int psp_hw_start(struct psp_context *psp)
>                   (psp->funcs->bootloader_load_intf_drv !=3D NULL)) {
>                       ret =3D psp_bootloader_load_intf_drv(psp);
>                       if (ret) {
> -                             DRM_ERROR("PSP load intf drv failed!\n");
> +                             dev_err(adev->dev, "PSP load intf drv
> failed!\n");
>                               return ret;
>                       }
>               }
> @@ -2193,7 +2196,7 @@ static int psp_hw_start(struct psp_context *psp)
>                   (psp->funcs->bootloader_load_dbg_drv !=3D NULL)) {
>                       ret =3D psp_bootloader_load_dbg_drv(psp);
>                       if (ret) {
> -                             DRM_ERROR("PSP load dbg drv failed!\n");
> +                             dev_err(adev->dev, "PSP load dbg drv
> failed!\n");
>                               return ret;
>                       }
>               }
> @@ -2202,7 +2205,7 @@ static int psp_hw_start(struct psp_context *psp)
>                   (psp->funcs->bootloader_load_ras_drv !=3D NULL)) {
>                       ret =3D psp_bootloader_load_ras_drv(psp);
>                       if (ret) {
> -                             DRM_ERROR("PSP load ras_drv failed!\n");
> +                             dev_err(adev->dev, "PSP load ras_drv
> failed!\n");
>                               return ret;
>                       }
>               }
> @@ -2211,7 +2214,7 @@ static int psp_hw_start(struct psp_context *psp)
>                   (psp->funcs->bootloader_load_sos !=3D NULL)) {
>                       ret =3D psp_bootloader_load_sos(psp);
>                       if (ret) {
> -                             DRM_ERROR("PSP load sos failed!\n");
> +                             dev_err(adev->dev, "PSP load sos failed!\n"=
);
>                               return ret;
>                       }
>               }
> @@ -2219,7 +2222,7 @@ static int psp_hw_start(struct psp_context *psp)
>
>       ret =3D psp_ring_create(psp, PSP_RING_TYPE__KM);
>       if (ret) {
> -             DRM_ERROR("PSP create ring failed!\n");
> +             dev_err(adev->dev, "PSP create ring failed!\n");
>               return ret;
>       }
>
> @@ -2229,7 +2232,7 @@ static int psp_hw_start(struct psp_context *psp)
>       if (!psp_boottime_tmr(psp)) {
>               ret =3D psp_tmr_init(psp);
>               if (ret) {
> -                     DRM_ERROR("PSP tmr init failed!\n");
> +                     dev_err(adev->dev, "PSP tmr init failed!\n");
>                       return ret;
>               }
>       }
> @@ -2248,7 +2251,7 @@ static int psp_hw_start(struct psp_context *psp)
>
>       ret =3D psp_tmr_load(psp);
>       if (ret) {
> -             DRM_ERROR("PSP load tmr failed!\n");
> +             dev_err(adev->dev, "PSP load tmr failed!\n");
>               return ret;
>       }
>
> @@ -2516,7 +2519,8 @@ static void psp_print_fw_hdr(struct psp_context *ps=
p,
>       }
>  }
>
> -static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucod=
e,
> +static int psp_prep_load_ip_fw_cmd_buf(struct psp_context *psp,
> +                                    struct amdgpu_firmware_info *ucode,
>                                      struct psp_gfx_cmd_resp *cmd)  {
>       int ret;
> @@ -2529,7 +2533,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct
> amdgpu_firmware_info *ucode,
>
>       ret =3D psp_get_fw_type(ucode, &cmd->cmd.cmd_load_ip_fw.fw_type);
>       if (ret)
> -             DRM_ERROR("Unknown firmware type\n");
> +             dev_err(psp->adev->dev, "Unknown firmware type\n");
>
>       return ret;
>  }
> @@ -2540,7 +2544,7 @@ int psp_execute_ip_fw_load(struct psp_context *psp,
>       int ret =3D 0;
>       struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
>
> -     ret =3D psp_prep_load_ip_fw_cmd_buf(ucode, cmd);
> +     ret =3D psp_prep_load_ip_fw_cmd_buf(psp, ucode, cmd);
>       if (!ret) {
>               ret =3D psp_cmd_submit_buf(psp, ucode, cmd,
>                                        psp->fence_buf_mc_addr);
> @@ -2599,13 +2603,13 @@ static int psp_load_smu_fw(struct psp_context
> *psp)
>             amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 2)))) {
>               ret =3D amdgpu_dpm_set_mp1_state(adev,
> PP_MP1_STATE_UNLOAD);
>               if (ret)
> -                     DRM_WARN("Failed to set MP1 state prepare for
> reload\n");
> +                     dev_err(adev->dev, "Failed to set MP1 state prepare=
 for
> reload\n");
>       }
>
>       ret =3D psp_execute_ip_fw_load(psp, ucode);
>
>       if (ret)
> -             DRM_ERROR("PSP load smu failed!\n");
> +             dev_err(adev->dev, "PSP load smu failed!\n");
>
>       return ret;
>  }
> @@ -2710,7 +2714,7 @@ static int psp_load_non_psp_fw(struct psp_context
> *psp)
>                   adev->virt.autoload_ucode_id : AMDGPU_UCODE_ID_RLC_G))
> {
>                       ret =3D psp_rlc_autoload_start(psp);
>                       if (ret) {
> -                             DRM_ERROR("Failed to start rlc autoload\n")=
;
> +                             dev_err(adev->dev, "Failed to start rlc
> autoload\n");
>                               return ret;
>                       }
>               }
> @@ -2732,7 +2736,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
>
>               ret =3D psp_ring_init(psp, PSP_RING_TYPE__KM);
>               if (ret) {
> -                     DRM_ERROR("PSP ring init failed!\n");
> +                     dev_err(adev->dev, "PSP ring init failed!\n");
>                       goto failed;
>               }
>       }
> @@ -2747,13 +2751,13 @@ static int psp_load_fw(struct amdgpu_device *adev=
)
>
>       ret =3D psp_asd_initialize(psp);
>       if (ret) {
> -             DRM_ERROR("PSP load asd failed!\n");
> +             dev_err(adev->dev, "PSP load asd failed!\n");
>               goto failed1;
>       }
>
>       ret =3D psp_rl_load(adev);
>       if (ret) {
> -             DRM_ERROR("PSP load RL failed!\n");
> +             dev_err(adev->dev, "PSP load RL failed!\n");
>               goto failed1;
>       }
>
> @@ -2773,7 +2777,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
>               ret =3D psp_ras_initialize(psp);
>               if (ret)
>                       dev_err(psp->adev->dev,
> -                                     "RAS: Failed to initialize RAS\n");
> +                             "RAS: Failed to initialize RAS\n");
>
>               ret =3D psp_hdcp_initialize(psp);
>               if (ret)
> @@ -2826,7 +2830,7 @@ static int psp_hw_init(void *handle)
>
>       ret =3D psp_load_fw(adev);
>       if (ret) {
> -             DRM_ERROR("PSP firmware loading failed\n");
> +             dev_err(adev->dev, "PSP firmware loading failed\n");
>               goto failed;
>       }
>
> @@ -2873,7 +2877,7 @@ static int psp_suspend(void *handle)
>           psp->xgmi_context.context.initialized) {
>               ret =3D psp_xgmi_terminate(psp);
>               if (ret) {
> -                     DRM_ERROR("Failed to terminate xgmi ta\n");
> +                     dev_err(adev->dev, "Failed to terminate xgmi ta\n")=
;
>                       goto out;
>               }
>       }
> @@ -2881,46 +2885,46 @@ static int psp_suspend(void *handle)
>       if (psp->ta_fw) {
>               ret =3D psp_ras_terminate(psp);
>               if (ret) {
> -                     DRM_ERROR("Failed to terminate ras ta\n");
> +                     dev_err(adev->dev, "Failed to terminate ras ta\n");
>                       goto out;
>               }
>               ret =3D psp_hdcp_terminate(psp);
>               if (ret) {
> -                     DRM_ERROR("Failed to terminate hdcp ta\n");
> +                     dev_err(adev->dev, "Failed to terminate hdcp ta\n")=
;
>                       goto out;
>               }
>               ret =3D psp_dtm_terminate(psp);
>               if (ret) {
> -                     DRM_ERROR("Failed to terminate dtm ta\n");
> +                     dev_err(adev->dev, "Failed to terminate dtm ta\n");
>                       goto out;
>               }
>               ret =3D psp_rap_terminate(psp);
>               if (ret) {
> -                     DRM_ERROR("Failed to terminate rap ta\n");
> +                     dev_err(adev->dev, "Failed to terminate rap ta\n");
>                       goto out;
>               }
>               ret =3D psp_securedisplay_terminate(psp);
>               if (ret) {
> -                     DRM_ERROR("Failed to terminate securedisplay ta\n")=
;
> +                     dev_err(adev->dev, "Failed to terminate securedispl=
ay
> ta\n");
>                       goto out;
>               }
>       }
>
>       ret =3D psp_asd_terminate(psp);
>       if (ret) {
> -             DRM_ERROR("Failed to terminate asd\n");
> +             dev_err(adev->dev, "Failed to terminate asd\n");
>               goto out;
>       }
>
>       ret =3D psp_tmr_terminate(psp);
>       if (ret) {
> -             DRM_ERROR("Failed to terminate tmr\n");
> +             dev_err(adev->dev, "Failed to terminate tmr\n");
>               goto out;
>       }
>
>       ret =3D psp_ring_stop(psp, PSP_RING_TYPE__KM);
>       if (ret)
> -             DRM_ERROR("PSP ring stop failed\n");
> +             dev_err(adev->dev, "PSP ring stop failed\n");
>
>  out:
>       return ret;
> @@ -2932,12 +2936,12 @@ static int psp_resume(void *handle)
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>       struct psp_context *psp =3D &adev->psp;
>
> -     DRM_INFO("PSP is resuming...\n");
> +     dev_info(adev->dev, "PSP is resuming...\n");
>
>       if (psp->mem_train_ctx.enable_mem_training) {
>               ret =3D psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
>               if (ret) {
> -                     DRM_ERROR("Failed to process memory training!\n");
> +                     dev_err(adev->dev, "Failed to process memory
> training!\n");
>                       return ret;
>               }
>       }
> @@ -2954,7 +2958,7 @@ static int psp_resume(void *handle)
>
>       ret =3D psp_asd_initialize(psp);
>       if (ret) {
> -             DRM_ERROR("PSP load asd failed!\n");
> +             dev_err(adev->dev, "PSP load asd failed!\n");
>               goto failed;
>       }
>
> @@ -2978,7 +2982,7 @@ static int psp_resume(void *handle)
>               ret =3D psp_ras_initialize(psp);
>               if (ret)
>                       dev_err(psp->adev->dev,
> -                                     "RAS: Failed to initialize RAS\n");
> +                             "RAS: Failed to initialize RAS\n");
>
>               ret =3D psp_hdcp_initialize(psp);
>               if (ret)
> @@ -3006,7 +3010,7 @@ static int psp_resume(void *handle)
>       return 0;
>
>  failed:
> -     DRM_ERROR("PSP resume failed\n");
> +     dev_err(adev->dev, "PSP resume failed\n");
>       mutex_unlock(&adev->firmware.mutex);
>       return ret;
>  }
> @@ -3067,9 +3071,11 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>               write_frame =3D ring_buffer_start + (psp_write_ptr_reg /
> rb_frame_size_dw);
>       /* Check invalid write_frame ptr address */
>       if ((write_frame < ring_buffer_start) || (ring_buffer_end < write_f=
rame)) {
> -             DRM_ERROR("ring_buffer_start =3D %p; ring_buffer_end =3D %p=
;
> write_frame =3D %p\n",
> -                       ring_buffer_start, ring_buffer_end, write_frame);
> -             DRM_ERROR("write_frame is pointing to address out of
> bounds\n");
> +             dev_err(adev->dev,
> +                     "ring_buffer_start =3D %p; ring_buffer_end =3D %p;
> write_frame =3D %p\n",
> +                     ring_buffer_start, ring_buffer_end, write_frame);
> +             dev_err(adev->dev,
> +                     "write_frame is pointing to address out of bounds\n=
");
>               return -EINVAL;
>       }
>
> @@ -3595,7 +3601,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct
> device *dev,
>       int ret;
>
>       if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized=
) {
> -             DRM_INFO("PSP block is not ready yet.");
> +             dev_info(adev->dev, "PSP block is not ready yet\n.");
>               return -EBUSY;
>       }
>
> @@ -3604,7 +3610,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct
> device *dev,
>       mutex_unlock(&adev->psp.mutex);
>
>       if (ret) {
> -             DRM_ERROR("Failed to read USBC PD FW, err =3D %d", ret);
> +             dev_err(adev->dev, "Failed to read USBC PD FW, err =3D %d\n=
",
> ret);
>               return ret;
>       }
>
> @@ -3626,7 +3632,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct
> device *dev,
>       void *fw_pri_cpu_addr;
>
>       if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized=
) {
> -             DRM_INFO("PSP block is not ready yet.");
> +             dev_err(adev->dev, "PSP block is not ready yet.");
>               return -EBUSY;
>       }
>
> @@ -3659,7 +3665,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct
> device *dev,
>       release_firmware(usbc_pd_fw);
>  fail:
>       if (ret) {
> -             DRM_ERROR("Failed to load USBC PD FW, err =3D %d", ret);
> +             dev_err(adev->dev, "Failed to load USBC PD FW, err =3D %d",=
 ret);
>               count =3D ret;
>       }
>
> @@ -3706,7 +3712,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file
> *filp, struct kobject *kobj,
>
>       /* Safeguard against memory drain */
>       if (adev->psp.vbflash_image_size > AMD_VBIOS_FILE_MAX_SIZE_B) {
> -             dev_err(adev->dev, "File size cannot exceed %u",
> AMD_VBIOS_FILE_MAX_SIZE_B);
> +             dev_err(adev->dev, "File size cannot exceed %u\n",
> +AMD_VBIOS_FILE_MAX_SIZE_B);
>               kvfree(adev->psp.vbflash_tmp_buf);
>               adev->psp.vbflash_tmp_buf =3D NULL;
>               adev->psp.vbflash_image_size =3D 0;
> @@ -3725,7 +3731,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file
> *filp, struct kobject *kobj,
>       adev->psp.vbflash_image_size +=3D count;
>       mutex_unlock(&adev->psp.mutex);
>
> -     dev_dbg(adev->dev, "IFWI staged for update");
> +     dev_dbg(adev->dev, "IFWI staged for update\n");
>
>       return count;
>  }
> @@ -3745,7 +3751,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file
> *filp, struct kobject *kobj,
>       if (adev->psp.vbflash_image_size =3D=3D 0)
>               return -EINVAL;
>
> -     dev_dbg(adev->dev, "PSP IFWI flash process initiated");
> +     dev_dbg(adev->dev, "PSP IFWI flash process initiated\n");
>
>       ret =3D amdgpu_bo_create_kernel(adev, adev->psp.vbflash_image_size,
>                                       AMDGPU_GPU_PAGE_SIZE,
> @@ -3770,11 +3776,11 @@ static ssize_t amdgpu_psp_vbflash_read(struct fil=
e
> *filp, struct kobject *kobj,
>       adev->psp.vbflash_image_size =3D 0;
>
>       if (ret) {
> -             dev_err(adev->dev, "Failed to load IFWI, err =3D %d", ret);
> +             dev_err(adev->dev, "Failed to load IFWI, err =3D %d\n", ret=
);
>               return ret;
>       }
>
> -     dev_dbg(adev->dev, "PSP IFWI flash process done");
> +     dev_dbg(adev->dev, "PSP IFWI flash process done\n");
>       return 0;
>  }
>
> --
> 2.17.1

