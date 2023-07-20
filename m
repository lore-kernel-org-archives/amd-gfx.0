Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A25BEB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 07:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C49710E588;
	Thu, 20 Jul 2023 07:37:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233D510E571
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 07:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+XPH5eR5Nk8EOcfUZO9MtysVUTfrIzF5WT6t+mj2oXf7VBXepYNAT748SoTZhMrMiI3ySQ+Ffo2S63W1CCR/QZmPHtg+F7AJBNKhRx/dU4OMg9dTpm7ckbs73Z+/albjwhvVaTWrlU8EjpBsia/jf+ZS7TlFMox8idKtIXArTUaY+cdQCLXlaRxPsYjLjdIjq5+XIlgJycsuzAtzlKIhoO0Pg0/2ndYE80AxkOoqExhpFVpr+j6rQjENkJw61rw/7Sv47Ho8MRf24VLHa2WnTeJQyqlBXqCj7kM/Wqim7fwxEhGXs4RtU9KG99qMQ4GbcZ20EU4Qliy5bPuvQPUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eocTDSydLbr7QS8igaDjhRGiewbs9BEA6E5mNrSJpJs=;
 b=hqZU7+atlmuH+24yYHJzAgjTw9/IXvU3duFSQIh61SK3YCDSHunphQGlS8tN6HPxi0lGMCxx4sc9aKDlb05GRjT7dEZT0Zo/ZDG+Z2Ft1A4AWxUWy4onabgicbyRRq4Fe8MuuHdgoTgu+56mvPbnRHJ2OX8JqHiLQtEIl7TpFbuiMbeqkAnVX6GKxnSUCp3gqhFAzULsffIUsq6lj41nRvxJ468BG9V8K9ul+pqS/hTRndmKLJr4c9zDeXwC8FGKl3FCTAjow3fKIwZpDsIqvGzOkEyboNnkaJEQzLGT5XBJOdjSscLbFYEq11lD/ChiaPRWSBhp/BK0s80/mI/ScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eocTDSydLbr7QS8igaDjhRGiewbs9BEA6E5mNrSJpJs=;
 b=bhMkhGI1vulBfm+3KdHGFVdbeS79Ql/cMDsjG8Tqydz9IEL8VW9C7MDrT6VE2qu1hIE0UcY0Kb7z1GO4R095794Jg5qa4jCy8iu1QqwxDsuDKL2MjKkXGiyrEs0Ok4O3Ubj875thwAj1MjrEbEnChCnB0N/FRMGLl9Q7PhM5ego=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 07:37:39 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::761d:1336:8dcc:b54a]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::761d:1336:8dcc:b54a%6]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 07:37:38 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: not update the same version ras ta
Thread-Topic: [PATCH 2/2] drm/amdgpu: not update the same version ras ta
Thread-Index: AQHZuj4/QBGxtr/Mx0+fm9paZ5kAnK/CROrQ
Date: Thu, 20 Jul 2023 07:37:38 +0000
Message-ID: <PH7PR12MB87962D96721FCDC365E2AC8FB03EA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230719123956.1163008-1-YiPeng.Chai@amd.com>
 <20230719123956.1163008-2-YiPeng.Chai@amd.com>
In-Reply-To: <20230719123956.1163008-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0b707937-66be-45e2-87fc-cff09e27fb5f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-20T07:35:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM6PR12MB4499:EE_
x-ms-office365-filtering-correlation-id: 03ae3c7d-fef3-4f35-1918-08db88f4319e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rBRoBAm1ScEeloTriHUzFryKduuxJVBxBhP24LWIFvOHA3KQL/U/HJIa4cQfl8OIru78+S0qyv2k8LTSQoAlA224gS738GjZXqaKWXgj/iuO2rVU8ucLua+ZyaMSN4OtslW/DWpKRCNcEz/MM18SJM7qEgQa9fUzM4MtbeO7ElLwKEWjO2koH1VEkkBn0fEzFEJ5uTZptrYjgtshd/K1MoFYVmYnHGqmGxLJ1EO48rDUEjUR3UYLBj1IxAtPzZArkelTHJvuWNsznaDHB9XpUKOs4TZTKtr6FuZbLZ6isT5oi8GMAZ2g6P6LC4n5NPgFocc4gk8IhTMaxB7bFAsVybrQscL/pDGO+Qv6+8iOj3MYQ6ILfS8vv/K/ZSc+kYyTODBY0RLR685MTBtfSNG3Yi8sffviHukVhZf9o72Th9CS8EnyD+1H4x1/4leipVrt6JyB1xoNcwmGBRKc7I5K8ZEYJvgBWe2VIPZ9Ic9Az56aS5B94qdizOta+5R/X0J0aT097IVn5JdnOijZIoZb7inS1m5Z3Bh/iUyFNmRR/M+FaHu4gXjX2A/TwU4XZ7Xu8pAOgoKQUO6cWJpteW28sJkvwvGKwBkT6a7q/F9Chi7C2Ne4EoZyboc3w8/Whub
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(2906002)(9686003)(38070700005)(71200400001)(86362001)(6506007)(53546011)(186003)(83380400001)(122000001)(38100700002)(26005)(55016003)(478600001)(7696005)(110136005)(33656002)(54906003)(66446008)(316002)(66556008)(41300700001)(66476007)(64756008)(4326008)(52536014)(8936002)(8676002)(5660300002)(15650500001)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gPMG+SXf2TIH0C+LlN6YFSGIhs0EFXkl0zgfjYWnk2G+uCNtLNMB1j3IKCjd?=
 =?us-ascii?Q?jToko96Uoa2TlPMUlHIE2cY7GKve5L3+8wwliGQ9ssl+tlAUHiiygEIxmRah?=
 =?us-ascii?Q?s6bo6s7cGUOPhssCNIHHjkLSlR6x7CItyEyo/y2qcJQZOuG3PbZAysLnOYL0?=
 =?us-ascii?Q?fcpxwxvB5L66Md0e0/YGoHKGmcNK/thHnISRWGukuNj2pCDp/edj81XqXsqn?=
 =?us-ascii?Q?/4FWMWwHyjWVMZ9fGTGLpdWkLSZ/jyHu15YJ3S5mWL+sDXMfmia2MlwwNxkE?=
 =?us-ascii?Q?gCzb4zNk7tujtf0Gkq4JS9s8NvKk0FO1RYRfwZ+DFVZmNGSuR3qr1TWc05UH?=
 =?us-ascii?Q?6BxrjEzA3yYeQfRpMba3P05hHhWSb3KPJ9vS8KsaC2HMBDGenP4urUkeVlmR?=
 =?us-ascii?Q?2tzygDh/5ocr/P+ycYnbnh5dnPPFrirT51t+ddhjE1z4NvBJoJcW2Yo8LRLI?=
 =?us-ascii?Q?iYSTZzCxOwLpn18RseYG2Ro7pSLYKT/5smhH/76nnX83cG+jw1qfZVjjEIOe?=
 =?us-ascii?Q?HYCA9XhTd6at0Uojeu+Y93ZSD732PPmE9mfUZjhEO6Usutx9EYBi2LMqbbmp?=
 =?us-ascii?Q?Vbn8CfSsQRgVs+J96PpFDrsAfq0lfp5ka0xMhLqi0Cyfn1bZiqT9E2J05Frl?=
 =?us-ascii?Q?XQLZijYhvLk5USps94L0NCNXHKYCvYYNMHvJ0vkE5KY/W4MKvR+A2CkoAMbF?=
 =?us-ascii?Q?fXvConf4dyZLV1v2s7uFr3OYFN/HJu/qkb42Kjtd8olGUw9lkg0qJF4A2K6k?=
 =?us-ascii?Q?H5Ei6mpzLaJ3mEJJ7N1yKowhqX3FH124PBTmWUqw7TXhHz+VK/I3jJi6l7YZ?=
 =?us-ascii?Q?a2Oe/J5gUxXlKvJXplpGpxKcOcvvRffXy7/5lY5hPr/4mzuIcW/a/NAuiQK1?=
 =?us-ascii?Q?/kpGwCuA4pwyH9/GWABHsj6qKLxbsp5HHaxOoOg7XqfokDioQtbXruyESphQ?=
 =?us-ascii?Q?RCKzn7ckSobFt2zU3PeJpDgI25zWieK4X4iyUQxe3xG5vTgQba++rGcB325P?=
 =?us-ascii?Q?oy4FVypKKEXoJYJfp95lz9qlsmpXKG5WDP7FUqOBJogi8y2ZyQWBcC4jP0l5?=
 =?us-ascii?Q?rotn6PwDIGQBnS1/yhU8ZfCx0O+ZchZTvI8p/0/ovotFFXl63pXVdua9OLnc?=
 =?us-ascii?Q?Wed8MSP7CFXRG3SOaMiqcJTHC8Grisoaa7LWCt2A0vd9m/SvVytfTdl5jljK?=
 =?us-ascii?Q?rBmc3I5Ey7FVssZN+pr3eha2LIpHRPx7gCLvplXnFhIqy3EFrpMm6T9xdHAL?=
 =?us-ascii?Q?SHKQXckkz43lJuApWZSzbI675QVs7Gp3FQaYlNpfoBPYPSTXBVv8hSJV48+r?=
 =?us-ascii?Q?sLhQurIYd1pR+4yXBI4iqM8x3BiAn458HlTCmk6MUHdIlUGB2SuTsL1aEsaG?=
 =?us-ascii?Q?R46aZUFv9TD9rtpZmvgAmTBfE5t+jIWbvbYyQuaaorKFPaQWf+87fplOrAuw?=
 =?us-ascii?Q?XSFrCNykke2iLqfb2jQpwAOYuLSRwrOppUaEbRpbyZ6P9JzRPu+PzHeDat3O?=
 =?us-ascii?Q?z8FlXKH4CfbsPIh3vCp5J9DsXPQZjRhj7vPo9Q9hX3633muYSHPnxQ72puvM?=
 =?us-ascii?Q?RAi3SHUCsqrlFau5A1I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ae3c7d-fef3-4f35-1918-08db88f4319e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 07:37:38.8349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98VRR6EacTcq86oSHxW1I/tiXs3DQWW8SsNAg8wZQFzMmMN3Ohzj9cEktwjL5chV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, July 19, 2023 8:40 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: not update the same version ras ta
>
> not update the same version ras ta.

[Tao] don't update ras ta with same version

>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> index 049d34fd5ba0..c27574239fde 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -120,6 +120,7 @@ static const struct file_operations
> ta_invoke_debugfs_fops =3D {
>   *   Transmit buffer:
>   *    - TA type (4bytes)
>   *    - TA bin length (4bytes)
> + *    - TA bin version (4bytes)

[Tao] the patch is fine for me, but since the bin structure is updated, do =
we need to consider backward compatibility?

>   *    - TA bin
>   *   Receive buffer:
>   *    - TA ID (4bytes)
> @@ -148,6 +149,7 @@ static ssize_t ta_if_load_debugfs_write(struct file *=
fp,
> const char *buf, size_t
>       uint8_t  *ta_bin    =3D NULL;
>       uint32_t copy_pos   =3D 0;
>       int      ret        =3D 0;
> +     uint32_t ta_version =3D 0;
>
>       struct amdgpu_device *adev    =3D (struct amdgpu_device *)file_inod=
e(fp)-
> >i_private;
>       struct psp_context   *psp     =3D &adev->psp;
> @@ -168,6 +170,12 @@ static ssize_t ta_if_load_debugfs_write(struct file =
*fp,
> const char *buf, size_t
>
>       copy_pos +=3D sizeof(uint32_t);
>
> +     ret =3D copy_from_user((void *)&ta_version, &buf[copy_pos],
> sizeof(uint32_t));
> +     if (ret)
> +             return -EFAULT;
> +
> +     copy_pos +=3D sizeof(uint32_t);
> +
>       ta_bin =3D kzalloc(ta_bin_len, GFP_KERNEL);
>       if (!ta_bin)
>               return -ENOMEM;
> @@ -185,6 +193,16 @@ static ssize_t ta_if_load_debugfs_write(struct file =
*fp,
> const char *buf, size_t
>               goto err_free_bin;
>       }
>
> +     if (ta_version =3D=3D context->bin_desc.fw_version) {
> +             dev_info(adev->dev,
> +                "new ta is same as running ta, running ta will not be
> updated!\n");
> +             if (copy_to_user((char *)buf, (void *)&context->session_id,
> sizeof(uint32_t)))
> +                     ret =3D -EFAULT;
> +             else
> +                     ret =3D len;
> +             goto err_free_bin;
> +     }
> +
>       /*
>        * Allocate TA shared buf in case shared buf was freed
>        * due to loading TA failed before.
> @@ -209,7 +227,7 @@ static ssize_t ta_if_load_debugfs_write(struct file *=
fp,
> const char *buf, size_t
>
>       /* Prepare TA context for TA initialization */
>       context->ta_type                     =3D ta_type;
> -     context->bin_desc.fw_version         =3D get_bin_version(ta_bin);
> +     context->bin_desc.fw_version         =3D ta_version;
>       context->bin_desc.size_bytes         =3D ta_bin_len;
>       context->bin_desc.start_addr         =3D ta_bin;
>
> --
> 2.34.1

