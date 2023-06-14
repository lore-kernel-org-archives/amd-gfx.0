Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38759EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 03:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C72F710E09C;
	Wed, 14 Jun 2023 03:42:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B6810E09C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 03:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE3MUnM8nF/hdHABMv3hy7EtuRv0cgoBhBLLBvFfEwcJfC6pEEfrl6M0/JWNVn1b65AVb4Bk4qAwlXeppL9eiWPmbLOGwUjORQcmGDQ4L/rmFb0ietta+Ua5OIprLcW90RjAg2QW/haz1lSQOQg+BAmBHC6Rv8bJfdoXo3TOy1xgcn6qj6tPApe9M58dOdXenm9ZXYOEx03uMgxDBJUJfwqcxcZgMXFUbRPHwTa4Wd18munMy2qsOA/AStP6yfpocRl1jjTQrvknel26VLZf6+y0K+VIEc2qEd6ArjLP2V73qwxV5c1wVCyyazuD0O1XXvswIg/06XmKSXTP+VdW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Sw0ezLAtp2h9nGWcvab0cRlq8az9uWV3FNUw/p0aw4=;
 b=Oa6CwNtREe/pKNjzzsp33OzUW6XnVtfmeGFOJSH85B/CiV7JW4ilAtSD6YSkJXy2PshHMqkXeMLzkYNdKUvTR9FUObqy8GsRrYSvWu6wT6ikGb61bKX+/QFA/2kALA5EUP/0g3LQhW6IlkjQZUiCwuoUVouMuZXjec5gn38AVR63agEy+BCLxDzQr3Vrh2wa268jbndcrhzQV5v0zub0kEuu64cTskhQbX8FNbH3CgYYcjywGTc6udMCfKSSJB2gQdtUIa4nQzkUf3io5ypANYn4MxvLg5ckh9hZ4Qp02liJyolNOzW1z6QnhTMnERmPdmFK3e3tRP1oUGzoUl/kNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Sw0ezLAtp2h9nGWcvab0cRlq8az9uWV3FNUw/p0aw4=;
 b=tdk98Z9IK4Hmrp3blcAVUE8k3OEwA94WyOZlVUxaiYmIsqmHtD7HjXrcsolBZC1UWPJaWqQuhUaQ3DOzwEoTVgsmqbezxM+j6TrWGvOgF+H47Gt/R2JdxyHlDgiCf75eCM6j1wexMqLbjMYo+48XTRlvAfxFcvin63qn8Jpq6sQ=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Wed, 14 Jun
 2023 03:42:35 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::ed91:e0f1:49d2:1af1]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::ed91:e0f1:49d2:1af1%4]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 03:42:35 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface
Thread-Topic: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface
Thread-Index: AQHZneVlVxoYqTPFM0aXLCb8TONHhq+JqJuA
Date: Wed, 14 Jun 2023 03:42:35 +0000
Message-ID: <PH0PR12MB5404F95DC60B27EB8D6C6CB7F65AA@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20230613105354.1561876-1-lijo.lazar@amd.com>
 <20230613105354.1561876-3-lijo.lazar@amd.com>
In-Reply-To: <20230613105354.1561876-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d97deaef-6d3d-4e51-99a3-5f1e00ffc589;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-14T03:42:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|CY5PR12MB6478:EE_
x-ms-office365-filtering-correlation-id: b1ddf000-3e78-4928-c8a3-08db6c89646f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3IX+I0NbiNNG9h9FWiG44zzoNmp7ABPmXZY5GwxXLnzW42UBXtLsgl1+j2gJVnIcdxtopKLmlCCczbt59EJFkR9NOkIWX08JsB6yviM2fab3g2OapiWPV4YlvKZ3rVq1uCidyI1irk7toy0BOjMLVp1EMArqrhLDf9g6yF8iispk+lASjecaUwfsmzk/1ZGuzBkxdu8pWehXbAw2Lhqr1UbRRHWjqox1Xof+z8zW81lb71NKq466IWemexEgvkdNluRXsYJrOZodSup7NQqLycQmfJpuhNKLWLWwJJlHXTEwv+hc6UWehLSowY0thEVsTw1+aj0Ws0Cig8SLEZnjT77mXSsR2cm0kOTDogxwCs2gVzJDcJW9x83yv+zydeOqz5fVW5br+oA1xlA6usxfkJWVaZgnrMwFymwMgNCNiP2eth2uz2TKMFoIiUiQgVqzqO5qJgRTuztIr+DpvAW8+7T4IolQzee8aw8KXR9wtzitN4RHC/klHViJ4AMwQ9rIZIo1K1xttnKe4l+F607XjIPbdhxkrlROcFr3HvQWVb0SOQ7oukU5kiZRyGwgjfxPifcovu/atuVLsn3J0YXFbqNjt4ebtKqERIGAAkmtAIul/9eBpq9p299Im6sk/Aty
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(316002)(7696005)(41300700001)(186003)(83380400001)(38070700005)(86362001)(26005)(53546011)(2906002)(33656002)(55016003)(9686003)(122000001)(38100700002)(6506007)(52536014)(5660300002)(8936002)(54906003)(8676002)(64756008)(76116006)(66946007)(66476007)(478600001)(110136005)(66556008)(66446008)(4326008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YHCJI+oENNAhcFzCrKaxmWFQ8dnJxmKqBPPfIbqGDHk6sFj5TAjKTlooNWp0?=
 =?us-ascii?Q?0hxf0qv70vt7K+IEJ2wfpIv4gH9pqnqvlgmmDQRR192vi6fdB/4DlIVqS2Yc?=
 =?us-ascii?Q?ILVN3Zn1SgXz6QQHddbLyW/VKzIH6P2wAL8nZL3iHLPKqiMCjVG5z8BRCM1H?=
 =?us-ascii?Q?r3l8n/YlTlfiPEkZyxtejBcp4vWCSn0g1w3e+wT8B/0yhEgC9p801CXnE5Aw?=
 =?us-ascii?Q?KYPUgjS6vzSXuKvTk34R4s7/GvWPGydRi0zWpMI5fHVYTJME14Uq5Q+50B1l?=
 =?us-ascii?Q?6WvNwi+Bf20zGJq+B6WJwu6F3V5SmQj10WbC67+Rw54lMJwzDdip9S3Q21VJ?=
 =?us-ascii?Q?MtS8kNMJTA+lV06tcKKLNt6B/z+Lfwrykd/961V+iAnfDbGs37YqCveICKa4?=
 =?us-ascii?Q?rJpIUt4C0ehOEuUYV1jbuRxdUn5XjedsLCsHlpxz8dIV0c1drFeEplIMyFO2?=
 =?us-ascii?Q?worXU8SOAWm16C+NyDA8iiyr3IlGZqwohbklhHHkN+MmS9zGYx+tyxnqjZvx?=
 =?us-ascii?Q?RT0BpBZj4oxcOPjovgkzQWC6QqphUPiW4XmJfa4hv/1UCSXNB0l3iBz7uC5v?=
 =?us-ascii?Q?0IFGsQN3ifBGsmCnFeZjJE0rKaI+FN/PzGEaclvj4tk7pmjh4S/lS78MOnHe?=
 =?us-ascii?Q?YIfCfsPqcSyf3yME2BPLkeq21X902CHIebC00zun3eDjBRKTUR5rZJoWvC4s?=
 =?us-ascii?Q?aCG/lQsvY77+5Pwo9EYRa63pGs4hzPNthsdhMSnwaZaNZVVzm/7Dmo46AS6Z?=
 =?us-ascii?Q?C8IUujGKyGiEuVxsqnSO/gFdMlxsEfSxdSPTwgL9W0cWZEk04tJ/CF8Vpn+k?=
 =?us-ascii?Q?QV43PRlbWUec2DP1ZNoZeXdcPbsgXyrD0ipoUjKZWzPjnOrPkLZjc35jJGON?=
 =?us-ascii?Q?mKHV+ST0Wmq3a9LDOVkjWHkSRHhVWTJD2b9W4VtHaZ3Z7fhs9nGZyeITGEbp?=
 =?us-ascii?Q?el3F16UsY2EAPNdEx0TKRcBAzMm5Yncm0MjNOQ93SdwPG9sQD6CYQeOOe8cQ?=
 =?us-ascii?Q?/mB90L/G+PdN37OClKt4Q8ZSlPkqBAWfZN3vBfDg7FdtGg9A5s3ZWUhzKc2N?=
 =?us-ascii?Q?FSsoekvtVj7cQFoxqqJUHaHI7NO811OFw9pEwxn3eKermZf+jlnpLc3sammS?=
 =?us-ascii?Q?NTa7qFOtkMqL8iSj+dMONB8OouTLWawFNH2zOl1AwjI9DYVgd3RKSfNIQgmm?=
 =?us-ascii?Q?/vXRl5iX527KrHcs353FSKCuJhUa4+li9QwvitScvIilFBbJDeqgrdRYr+0Z?=
 =?us-ascii?Q?AGI/2eVZYRYltFHgBd01vmBMw9L4Jbbt8tuptUqFfx3WPW1649Rqd2mGYojK?=
 =?us-ascii?Q?ec5go0V9eFRT6i4DK0rb+se7UJ0IzvufbMi3JORcsCjAuT/Ce9VkxkKErV67?=
 =?us-ascii?Q?VOwcVjQstMNBjtuyNKi0SgGH5V3I/8SYst9/5tZ486BE1Zc8Njn2ulUWrOas?=
 =?us-ascii?Q?vuylItrkMNu7y0uQ6PU09rJ1FfJ0srlNB0e4wZ3sysh1QTCR1tdF9E5Hs8KX?=
 =?us-ascii?Q?HzAoo3CAX80XYTwh4CQal9PCa6Vo5p9CDt+9v9tcNWpnOoR6cgLP/hEqRneU?=
 =?us-ascii?Q?0PccWbrfMnFlfZZNpt0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ddf000-3e78-4928-c8a3-08db6c89646f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 03:42:35.4388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCx84QPJgdKGL6CLKOTV4nGQIX1BOAzYb33KYoqa9IRabT+LrXNeO+GD3evuzmio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, June 13, 2023 6:54 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma,
> Le <Le.Ma@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface
>
> Set compute partition mode interface in NBIO is no longer used. Remove th=
e
> only implementation from NBIO v7.9
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  2 --
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 14 --------------
>  2 files changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> index 095aecfb201e..8ab8ae01f87c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> @@ -99,8 +99,6 @@ struct amdgpu_nbio_funcs {
>       int (*get_compute_partition_mode)(struct amdgpu_device *adev);
>       u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
>                                        u32 *supp_modes);
> -     void (*set_compute_partition_mode)(struct amdgpu_device *adev,
> -                                        enum amdgpu_gfx_partition mode);
>  };
>
>  struct amdgpu_nbio {
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> index b033935d6749..cd1a02d30420 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> @@ -393,19 +393,6 @@ static int
> nbio_v7_9_get_compute_partition_mode(struct amdgpu_device *adev)
>       return px;
>  }
>
> -static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device
> *adev,
> -                                     enum amdgpu_gfx_partition mode)
> -{
> -     u32 tmp;
> -
> -     /* SPX=3D0, DPX=3D1, TPX=3D2, QPX=3D3, CPX=3D4 */
> -     tmp =3D RREG32_SOC15(NBIO, 0,
> regBIF_BX_PF0_PARTITION_COMPUTE_STATUS);
> -     tmp =3D REG_SET_FIELD(tmp,
> BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
> -                         PARTITION_MODE, mode);
> -
> -     WREG32_SOC15(NBIO, 0,
> regBIF_BX_PF0_PARTITION_COMPUTE_STATUS, tmp);
> -}
> -
>  static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device
> *adev,
>                                              u32 *supp_modes)
>  {
> @@ -461,7 +448,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs =3D {
>       .ih_control =3D nbio_v7_9_ih_control,
>       .remap_hdp_registers =3D nbio_v7_9_remap_hdp_registers,
>       .get_compute_partition_mode =3D
> nbio_v7_9_get_compute_partition_mode,
> -     .set_compute_partition_mode =3D
> nbio_v7_9_set_compute_partition_mode,
>       .get_memory_partition_mode =3D
> nbio_v7_9_get_memory_partition_mode,
>       .init_registers =3D nbio_v7_9_init_registers,  };
> --
> 2.25.1

