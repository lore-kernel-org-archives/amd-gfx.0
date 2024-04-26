Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83526C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 03:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE7610F6ED;
	Fri, 26 Apr 2024 03:14:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d31kSb3N";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0DC10F6ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 03:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyNHCAZZPy3a5/Sk+JHVcUQmCjWKkYDFr6xywBthcEci5RN6SnE6TDwlejKonU1ECRAMy8i2TBNI/1Whx1TDnVK79TTiX8BlIWVIfDXXqjeo4suXKXI89uK3ASEXUME/CXY2L7y0Dj+Dz11uGs59QjosDOW1gXJ79M+46KAZuGKwbZmjEiwDoI5EYqmu2NAw4YRI/QfAdzHuSozFaQv0BOXTMj5afcxQUQ1C3oSOgmKpiiFhCNZ//f3jQwfc3Jb9OaO2xeEWZqS4MEkCKJlQh0dvd2DU2wm4WlJnR5zdW/6MeJ6btFC+mWXZUdnsk/9X8UCxVjzn0dpGdfTrc99unA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nbipbioeDNNpxt5q/4Ro8c3sszRSvApVKvqmBlOBMU=;
 b=ZvfE9LLqOhOdHY6dCMzWw3/VBkER86l0TjU3Ouuc4vA+iUup4DDOSf3w05ZWhNPedspA6dgYnLoI4qbJTHspkliRU1Mdy0oxocAJNpUvgvCRG3vhr6NjeO/JE4iRuYXGKzqETZHWkFO1yZ/E3GVvF3f/mBCL/CT8SYctkwy6VqegyLo7RQfRmjKdC2AEfupHWmsqsaz2E1t4+y9c86yTUnAIq7if0Y3A0yZM+96Wtt7dsmOFNtj5URwnNXSQIM7qQ+YIb0isGjvAbzoLmiqzaxx7/0DN+ET0y2hQlp0V/jbR93la/bCRy7o5b4HsljgU5wG4EsksZ55DdMsv4USJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nbipbioeDNNpxt5q/4Ro8c3sszRSvApVKvqmBlOBMU=;
 b=d31kSb3N9VEQ0QNQCQE89KT7lC3hC8JzTLunuc8XE7gQk6AOnB1b+4p4HDxlX8Y0iU70cfcIR37Qsbj8CcUIrPY94xfh7U8FFo/wIbCkL4wHR2JQtBmE1rxT7s7RIbYOXVObSLNLA2I+4S+lpj+gmOka1AHtqe6PQ5h70Qo7Xhg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 03:14:41 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 03:14:41 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add ACA error query support for umc_v12_0
Thread-Topic: [PATCH] drm/amdgpu: add ACA error query support for umc_v12_0
Thread-Index: AQHakHTV2pXqs3bmf0COMNAnzGEourF57lcw
Date: Fri, 26 Apr 2024 03:14:41 +0000
Message-ID: <PH7PR12MB879669EA5B060D239933FFA5B0162@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240417031003.1251031-1-kevinyang.wang@amd.com>
In-Reply-To: <20240417031003.1251031-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0b21567b-f021-4069-bfe6-d32304055f1e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-26T03:12:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB8177:EE_
x-ms-office365-filtering-correlation-id: 77c85bb5-473e-4c8f-ff22-08dc659f03d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?tBbS44UCuyLBdvhEbc1cXufoc04KansRIkkHvtFBWIFQzodZBDVG7s+lPZZZ?=
 =?us-ascii?Q?0ojuGI3vwIEw3mcK1zHQAGPScrBk+L9VcwNWF2DvYSgUcOJ2eRAef6ucAfcN?=
 =?us-ascii?Q?+u7yXOGohR+iNVui2+I/TjxayUSuPgFrp6ixCiRQrjclZjB8kPQ99U+ieB5E?=
 =?us-ascii?Q?zz+nlpdY+TZjRjXp5M+LaHqDaJpfh3esMwnQ4xfvi1+ulbw0qchqfHcXeQh9?=
 =?us-ascii?Q?0S33lgB9k9YNAKdGgFKjD7RjBOxxI5wBheziofX+KUJ9slscuqVbSJWgjSjp?=
 =?us-ascii?Q?2TSShofH/VYZgpU1eebLEaoc/Pbl1vidLGa0CdhJIjhAIUjPCrKp2qeeaVFu?=
 =?us-ascii?Q?B1G6GNtkDVMVrdRcdl8ttE1I6SUCL+bhPcypVbA0Fx7eNQZ2np3GRl/DJm81?=
 =?us-ascii?Q?B8oAvDjXrXkkkfTjB5Jz+0fbZDDJ4CEEhfOIjF3GVDSs7/lPmI5QOZVgnxYZ?=
 =?us-ascii?Q?tCTGkwsBsDZmftebdieyTQRLfscwDAUo15RoZTkiwX2QxdBIdw1+oBPSqqK/?=
 =?us-ascii?Q?fpkJT+1PZDc+ljI4dajOV0LcR6nkU8y8BHBhInX4m/oWoHMEAOWu5qnKXbAY?=
 =?us-ascii?Q?/gNEzjjWvjW6HrgM9IvsbyAXjJhRESUFCFFTq0CgSS7VqSDdH7ClpC5f5Ujp?=
 =?us-ascii?Q?Ari5Ly31Ji5mN37HvCMvmehlG+ojV6AgN3O21FmVl/F+B1i7SzULuLv0Js/W?=
 =?us-ascii?Q?Wq2bi20eeYn2LbAU+UjwILyKTnWfXrqUV9kkYXgs4+iTvm3uf9EtMDap2oUP?=
 =?us-ascii?Q?BbvtW2M+iwbWGU5RjqUQPaSXXly9gpfWsiqFmTGhaIT2MVGR+86p8TdVRe8b?=
 =?us-ascii?Q?mFSISmKo+Ks3hrGWq02ymARxwJzQvE8QV/49FlYybpdG5ywxfqXHC12Jb/uW?=
 =?us-ascii?Q?qE2+jk8/Cw81p2aNM+koBmuf1HAsz0uaBB1Qsl47UAju7cb2QNzuv4k7D/0V?=
 =?us-ascii?Q?9prrPriVH3piXogvQz8T76AjycJ1ynXHIkw/m9QkSbLSwkdMygfyHffOKxLb?=
 =?us-ascii?Q?BmuCr5V1iO1Kl2QbKASzTGs72asuAOtcjruXVhTnBTOFEtLqeF4tmRvccS8M?=
 =?us-ascii?Q?GOg/6N2axfmIMcJAOqN/5uPGIy0pTtuJ5dp+BVrA/I0+S0NxlP7fD31f9oQU?=
 =?us-ascii?Q?tbpCbsEqEv0G0qOiwFEI+UG+QGucyOa2Ogf+OzOxpQWoz8kzEdhryqsDkINK?=
 =?us-ascii?Q?rGzYy8or6g3icft2rDA93RgSMcuCLZxKdzFLKEoC3khV0dfnJg7DONRZXQhr?=
 =?us-ascii?Q?0ECcJWiRnbxekDRpPTZ8ZPOHvnEjoXGLS580792PmyC6wufREfZ83uhEaPUD?=
 =?us-ascii?Q?hwl14LwdTXvwOdhjQKHMvdaKz8Go7/ppHGgXGMafGkzF1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fpOhFNxNxXkl5kz/tNincOZdXHqRRGJT7CUaCi4jqRsidaVcuTomWcF6x9+K?=
 =?us-ascii?Q?p2Cp1Cy91elNmewd291iDmcU9iKKGGvWw/wHC83tFkyPgmaya21GAQCp1Efb?=
 =?us-ascii?Q?Dg0sWb6a0mk34H+4KanvHiwu6HXLp4PsnnSkYPWYRmPC7cL5yY+XxCC6Jwgz?=
 =?us-ascii?Q?+Z01r54c1LlrhtxX4aqgzFeIOw+R4uaFcjaRQwPPJ1aBOCehOAj6Jwko+c2i?=
 =?us-ascii?Q?REqhtzy5EnkCw6zJo29oR24pS3UL9v3QTifb1ArDIMzOqbxDnO/eCPOm4oAS?=
 =?us-ascii?Q?mHcdVxUGhJLDJSKgmQDKkLUsFCYhmCrbgMqy6pt1E2F5d5Hn/Eq2n2oDweLm?=
 =?us-ascii?Q?o9xugaDDAFQBRIFpobAwrASLtuILkZg4mTpGaOsju2i10MU9oPB7pbrs2MUJ?=
 =?us-ascii?Q?luFlJb47lqL0bhvEdj2hz9dIfURbBktPHPijGC6L0+3dYdUm0RclJuUwX7Ak?=
 =?us-ascii?Q?ftqoMzfYDYj68FW2gDNPvkWigU4PXznMXx7SYmb2avlQ8b38KczOwqNs9YUL?=
 =?us-ascii?Q?rKB9JQ/G77T0o2V1rpoOcdaWf2JV+tS7Z6oiFZNDM9PtxbImkwPGHX/AoabH?=
 =?us-ascii?Q?ymEVfIPecfZf54nqkkKAnVcafuvnxJTHsqpFiGlVMQWGmaNORwm1t8MYf1TR?=
 =?us-ascii?Q?66jXf/wQsGf8Wac9vBfn/q93eHOI3j11QhA8crYxzbBCqTkMeyjnyruCU+Dm?=
 =?us-ascii?Q?oIPAbNMCt8eka9FlOCpkDwPm8B2NRpHOgDfiWFrZttjkmQrLFpgU2dMQhq9Y?=
 =?us-ascii?Q?UaYWYW8Ev85Z0l7HTIf2gkyseMXT8tN9cCo+MWN+t11MMOR6V7rvpQLn4h9u?=
 =?us-ascii?Q?MS2+5EoVEfO5F4WVTEDBwbJhXnw9SaCIpwCcs32sRWAZttFWLAcis+Y+vYfu?=
 =?us-ascii?Q?aLdOVRnXOx/5eVZvWtxvb4ryvKvOmYcC7iW5vyTi3oWs8HBlz5g428VzNomE?=
 =?us-ascii?Q?lz5chp8W3tCpU+n55B/2T/7/Iv4tj9aB/MevLXS0cIPstGSXjwgQiv8pwpLh?=
 =?us-ascii?Q?oAsdyMfb5xR5ycgJzJphcuCT9/fWRdf0HRIJUMc9rnXS8lH3NqOXCuB0k/4O?=
 =?us-ascii?Q?UbB5XT/XfiFe4mLgYedqZeuMrDmf7eMwfYkxEzLnWQ8H/qKVSHnUFNB0Tkzj?=
 =?us-ascii?Q?33v848stcIb0Xw/3iAk7NrSA32LYOeVHugMLwPQ/qnLIGkIF1tAqHNBLdKi6?=
 =?us-ascii?Q?jNgbbgcjmuPovSdQxknB+8EXWScWGkxBOiVXbhUX9962WUInxCxxv0sNC7LQ?=
 =?us-ascii?Q?Lj1yJvZlpMdfGZYARie0zI7P9J1VNBPItVL0LiTmsg9qiO+ZhAu2tQ08fHgA?=
 =?us-ascii?Q?WvnDZhc0BVrrwxApF7/EPJJ6dIi0p6+UQ3rQutCMxdtVLKQKrJn78EcH54Rn?=
 =?us-ascii?Q?GQNiuPo4b8uB8I3G7uY3y5LJXQrgZO/ao/HhKtw2q4UMlIrCXWle5ak3xoZ+?=
 =?us-ascii?Q?UatOFVYXfGgnxS3caAKY5UorNTq04IIqT9+uCo/8ss+frOjgvMeNx7UOuym8?=
 =?us-ascii?Q?kna2s8KYbvquqfla7BEeRaZGp01Xq2PRVUmy1ZhwvlZ+xv76PayxdalGao94?=
 =?us-ascii?Q?I5UO+RxwbbtgHHmCPsE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c85bb5-473e-4c8f-ff22-08dc659f03d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 03:14:41.7973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MIJEyD4XdQHOgq2qPy44YVMdPbE0/cGBhuOrGldYkTBtbZpz2M8D55WBuI/StmM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
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
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, April 17, 2024 11:10 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: add ACA error query support for umc_v12_0
>
> add ACA error query support for umc_v12_0.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  6 +++---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 ++++
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 18 ++++++++++++++----
>  3 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 352ce16a0963..46b7f0c5cd8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1268,9 +1268,9 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device
> *adev, enum amdgpu_ras_block blk)
>       return 0;
>  }
>
> -static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enu=
m
> amdgpu_ras_block blk,
> -                                      enum aca_error_type type, struct
> ras_err_data *err_data,
> -                                      struct ras_query_context *qctx)
> +int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum
> amdgpu_ras_block blk,
> +                               enum aca_error_type type, struct ras_err_=
data
> *err_data,
> +                               struct ras_query_context *qctx)
>  {
>       struct ras_manager *obj;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 8d26989c75c8..487548879c49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -898,6 +898,10 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device
> *adev, enum amdgpu_ras_block blk)  ssize_t amdgpu_ras_aca_sysfs_read(stru=
ct
> device *dev, struct device_attribute *attr,
>                                 struct aca_handle *handle, char *buf, voi=
d
> *data);
>
> +int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum
> amdgpu_ras_block blk,
> +                               enum aca_error_type type, struct ras_err_=
data
> *err_data,
> +                               struct ras_query_context *qctx);

[Tao] is it used in this patch?

> +
>  void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info,
>                       struct ras_err_addr *err_addr);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index f69871902233..9f2c46814a4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -317,16 +317,26 @@ static int umc_v12_0_err_cnt_init_per_channel(struc=
t
> amdgpu_device *adev,  static void
> umc_v12_0_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
>                                       void *ras_error_status)
>  {
> +     struct ras_err_data *err_data =3D (struct ras_err_data
> +*)ras_error_status;
>       struct ras_query_context qctx;
>
>       memset(&qctx, 0, sizeof(qctx));
>       qctx.event_id =3D amdgpu_ras_acquire_event_id(adev,
> amdgpu_ras_intr_triggered() ?
>                                                   RAS_EVENT_TYPE_ISR :
> RAS_EVENT_TYPE_INVALID);
>
> -     amdgpu_mca_smu_log_ras_error(adev,
> -             AMDGPU_RAS_BLOCK__UMC,
> AMDGPU_MCA_ERROR_TYPE_CE, ras_error_status, &qctx);
> -     amdgpu_mca_smu_log_ras_error(adev,
> -             AMDGPU_RAS_BLOCK__UMC,
> AMDGPU_MCA_ERROR_TYPE_UE, ras_error_status, &qctx);
> +     if (amdgpu_aca_is_enabled(adev)) {
> +             amdgpu_aca_get_error_data(adev,
> AMDGPU_RAS_BLOCK__UMC, ACA_ERROR_TYPE_CE,
> +                                       err_data, &qctx);
> +             amdgpu_aca_get_error_data(adev,
> AMDGPU_RAS_BLOCK__UMC, ACA_ERROR_TYPE_UE,
> +                                       err_data, &qctx);
> +             amdgpu_aca_get_error_data(adev,
> AMDGPU_RAS_BLOCK__UMC, ACA_ERROR_TYPE_DEFERRED,
> +                                       err_data, &qctx);
> +     } else {
> +             amdgpu_mca_smu_log_ras_error(adev,
> AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_CE,
> +                                          err_data, &qctx);
> +             amdgpu_mca_smu_log_ras_error(adev,
> AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_UE,
> +                                          err_data, &qctx);
> +     }
>  }
>
>  static void umc_v12_0_ecc_info_query_ras_error_address(struct
> amdgpu_device *adev,
> --
> 2.34.1

