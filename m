Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9726EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 08:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D2510E401;
	Wed,  9 Aug 2023 08:44:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF03710E401
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 08:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCiFaXRqH8wNDCiD21OehQpGVA5216Tk8VPXONR0aPKAQzl0sjnFs8tK010FfF0zrbo74XbTWKPzSDuYaISsvmreQdS3Lw2fSdw8cFwu3ufEtnXt22gUMAs6Eojfntq5IhmJgVWLRpUUbRVoyVgE4+UkhBWg+6d0VvtmqeRbt2I0YZPOfnArVACkNao2pZik/Tog2rmfSSMkZQbEArHiRFw/9TiPZ60QDEfdaC1U/T/tNyiquJx0s14AEKzXKFk4sUqbGbvrEgSEX6e8AVFeGYYVxcXkGdM5tG+JW5aKD5i1rLiti/cMgFP8CyJS04LEz3aEkk5ac1uowqtlcrpjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49qZQbjynCfz4b3vXPHFCeWEb6p3xP0GkvHqVEkZ2aE=;
 b=htx+mz1a1cR/4oyxYYjinUgffCidYbt++qlLRZeDuVB5MspACheS9+RgOJsaQx1MvHLMtGtaCqkJM2x6SlgYli/bSGoDMC8R0JjkNdl6hSR6cm2yY7/DsfPn8BL85BSVmOt1AoHzHME8TRdQMUCLJDUmGNnkZHXB8BMGb67Z/3iblmMi26piiyUH4zZH5Ggj4tD2ugGYE2+FR1d4baFUHCEbTLI8hBHcDrM0Fb+HkM0Pr7ZTmaEqVmY/Kr6AMyUIuW1seqlUoSgWVMhk8NwURFG2SvKTzo3sNG13Q/kyqbKMdsB2xBV7CUeMKmYUdhB3dKOmd1wSx3FWUPky/XblnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49qZQbjynCfz4b3vXPHFCeWEb6p3xP0GkvHqVEkZ2aE=;
 b=exEOYsQDmivEye6eZM8q2D0lqSaVH5hWD+rr04O/cwQE+7DZP88I+bHhYSehNVP9LBiysS+WaEZ6US/Ru55+XgmyeCSV00Iq4tzGst5hnC1cZMH/s0ixr7QDqt7eilxF1u5A0ExKSpdADcN4D/rCkBUqBjpnu99+LZ/wa4xJJN4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Wed, 9 Aug 2023 08:44:39 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6652.022; Wed, 9 Aug 2023
 08:44:39 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add pcie usage callback to nbio
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add pcie usage callback to nbio
Thread-Index: AQHZypvRdxXz1iuCKEW1oHitRCThEK/hpcLA
Date: Wed, 9 Aug 2023 08:44:38 +0000
Message-ID: <DM5PR12MB246939BAB33EA08B271B2124F112A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230809083023.427025-1-asad.kamal@amd.com>
In-Reply-To: <20230809083023.427025-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7466d1e3-4969-4437-8325-cf123a661f16;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-09T08:42:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM6PR12MB4153:EE_
x-ms-office365-filtering-correlation-id: 4dda83d8-19d6-44e6-3918-08db98b4ddf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AETM6+hGqgZOI9B3lf8LykymzT3u9Q8nJNnwrDq5y1ZONQKjwuFa0QjDS6OyafG8vAsz8PoGpyqRPmmA5l+IBn/TKnBjsxF6B5iuGLNSRXQ+X71mryeeI5u+vbyWEky/5w4ZqKNVK9U4Vm2UoMIG3xwbzW3EAI63C40Dt9N06odiIQ1AQilYxRubks3DIDZ5q6ljIhM7SOjSQQtzv4aKqQxuGohIUX4nuN8JwyiTBZGJi3r3yrflre4LyI2gWnyRz42u+RcHXxWIPsdti4nm46WsS/2Z8blW/u7Oxg+BNE73M/HXPF5Dd5AtV/ttK0IhSM/sHH1C38t0+ioVV4H7ktDSwzmRRwbxY7SbYCy29WJDHQ7N6kGWb4gDbKUIwUUwZpwk5Mbjr2Nh7tVTl2VAiT+/VU5Q+uvR4yAR+xpq8KYNDebSkmvehFxHcMYdqLzsyhWbzyqIjuk+9Sa5WTxQDHqaFPGki7FaI1WHYFG22P+O2tI89O2A1yI9pAG/hVrI9z8YXVKURFBWVg0Q8oX4mYg5eGkQsP4OgbGo4CodtLK4sHgnykZ6ou4/E0R61WYPdmaxuLTtG18q/ciM2pxR0uC9RvhujdEX/mwZMlGRjq58eApxjSrtNEqXWJuc4/qO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(346002)(39860400002)(396003)(366004)(186006)(451199021)(1800799006)(110136005)(8676002)(41300700001)(4326008)(8936002)(52536014)(76116006)(54906003)(66556008)(66946007)(66476007)(66446008)(5660300002)(64756008)(316002)(38070700005)(55016003)(122000001)(2906002)(478600001)(7696005)(9686003)(83380400001)(86362001)(53546011)(6506007)(26005)(71200400001)(33656002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D/pEKHqh2RVL2jLzikAlqGLVt2IFcY5wl1Ur66TN8Qg+21AucCVlEpk2F4MZ?=
 =?us-ascii?Q?MsmnBgI/MYcyjkec/UqXXRoRjhdeJGKprxkc5O1Uk7o5T/fHzDPn4jsSMp/n?=
 =?us-ascii?Q?6vYvbMWL45Yuzfk2ShkziUIT+rY/PGzpUbdmkRY6qnBV/uDC5b4bBm6DsNoj?=
 =?us-ascii?Q?CZ5H/Y9fGYF4s9KT2SyCdUIyw8Z9KZAYDL9Ni7y6kBjFPq42LIpeKQyegu65?=
 =?us-ascii?Q?SeWzHxkmW6L8YJOZHFWuuoG1JwlG5ScYTvJ5JtsjDOUi4hs65pbVgnYpNshe?=
 =?us-ascii?Q?NPbxVjUa373wRzQ/Zvq7PdQOWCsrLHxjhl4ub3Qe7Rbtp/HyMDV2iVTiLqK4?=
 =?us-ascii?Q?BqJolBiFLXbkKhkr6xEEEoCMe9xvCRAGAyuCuJ8J88Fyb1BQ5hCA3wMCp6Md?=
 =?us-ascii?Q?8KCEx4S71iZbqwD0sG7U5+NNvOAe2KnVnH+lQrwfND4LZ73lMvK7UlUzR1+V?=
 =?us-ascii?Q?Sc47skdXiR1ccLJ0uw2+mvKbkT9KqBF22y9nAYHpUctIw4J5JFl0y9HWrKai?=
 =?us-ascii?Q?bSR8+ZT3dQF2wjOR8EB37kSmrJW2NXCu4/8QQIp20qswOdH7ZrnTRQRXzo+M?=
 =?us-ascii?Q?67u2ip0iq4ckTR7bcxUy4YJxA16WqUpxYN3PGA8VK20HDAiRc/EV7MEWRVzp?=
 =?us-ascii?Q?cjKWs8BLXTJJbHDAc2oa5rjt9IlTcSAF1RQX3D8f3QiHYAet/i8KpGcH36s7?=
 =?us-ascii?Q?IkT79BaKE7Q5grSUFqh6jFAqo9y9b+ff7S3GyKYsI1mFmW7o+Gr5XkutG27u?=
 =?us-ascii?Q?nH7Jx2jT6M++hPk6RbaGUBLZM27nmaMAPD44YlEpWNU9ZxrUxig99Lr+GFta?=
 =?us-ascii?Q?IHpaXr0i3Mgg93Ik56hyPLi1rzLuCcTHiGKGUUYkbrbZrxHcC+Ibste5830r?=
 =?us-ascii?Q?TPnEJxlw4lleoHLIjDnlZG0MIjy9b/XJX1qgG+reLDOR7ibV+gORc04WHTDA?=
 =?us-ascii?Q?sU5tQiuk9H10FVtV6j6OAmC0GKSX8VBYfBRJ7SPsFlPntC0GgiWo4+9nlC4w?=
 =?us-ascii?Q?jbCuS5D4B4Xirad9pV9V8bKoS9q4LtxfRn48FYnsHUHYh6V0u6gdH7YzAJbh?=
 =?us-ascii?Q?YDae6CzwtDjNa3f+6ASsROUCKLjUL4cl3fM1XSThN0fNMF1e2JiymR0Xc+bw?=
 =?us-ascii?Q?HqIoY3I/LcTstYYnzn3kAPhjQIGcaDV7JfkxgrwPG/j2h2nhyUBfrp62Z0wi?=
 =?us-ascii?Q?AEtdc070tOH4ptK1b5KlkZ5eOvK8x7+5C/Yoqb2K5a1cFHe0RIKhLbw3lWr/?=
 =?us-ascii?Q?ETYx9UIXAndtoG12TqGY0kphQ/5HCTvC3f3fpu6jlt7O0SR8QGcN0N1RvW5Z?=
 =?us-ascii?Q?0o1XeXW/p38iqByFBfOBp6cLpDSM4wFfOEv5AZ1zrkwLZRlIZjpvRGrtwCI1?=
 =?us-ascii?Q?WHDxZl7bx7Clz5AIYJ9tq2U9hjxYYGfQg1hpbJwgaFHh2eo4H7dPy67CLD32?=
 =?us-ascii?Q?oUGNNXBTarxJL6R7KHwSRA1Nes+Fw+KdmMhX/QzdUzalQZF2x/aaQRoQ+mi3?=
 =?us-ascii?Q?9Xsx61CE+IzrAqOM0OL3kNQGSLO9XZ7NfUQvDHk/swuhDpAd/5ejpUw5ge8y?=
 =?us-ascii?Q?TePMjsCZ9LmWGbvU6YI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dda83d8-19d6-44e6-3918-08db98b4ddf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 08:44:38.8030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwA91/ukGQhodyloDsNFAaJLsPa5QvA5L6vrMkh8GH5A7k3u3uuRrcpdfZgJZohl3GXoc6CmO4NQ5ChC/zv3nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Asad
> Kamal
> Sent: Wednesday, August 9, 2023 4:30 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Zhang,
> Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Add pcie usage callback to nbio
>
> Add a callback in nbio to get pcie usage
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 8 ++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h | 3 +++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> index a3bc00577a7c..f65903a41e6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -45,6 +45,14 @@ int amdgpu_nbio_ras_sw_init(struct amdgpu_device
> *adev)
>       return 0;
>  }
>
> +void amdgpu_nbio_get_pcie_usage(struct amdgpu_device *adev, uint64_t
> *count0,
> +                             uint64_t *count1)
> +{
> +     if (adev->nbio.funcs->get_pcie_usage)
> +             adev->nbio.funcs->get_pcie_usage(adev, count0, count1);
> +
> +}
> +
>  int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct
> ras_common_if *ras_block)  {
>       int r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> index 8ab8ae01f87c..39bf845c9cc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> @@ -99,6 +99,8 @@ struct amdgpu_nbio_funcs {
>       int (*get_compute_partition_mode)(struct amdgpu_device *adev);
>       u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
>                                        u32 *supp_modes);
> +     void (*get_pcie_usage)(struct amdgpu_device *adevi, uint64_t

A nit-pick. Use 'adev' instead of 'adevi' for better code consistency.

Regards,
Guchun

> *count0,
> +                                     uint64_t *count1);
>  };
>
>  struct amdgpu_nbio {
> @@ -111,5 +113,6 @@ struct amdgpu_nbio {  };
>
>  int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
> +void amdgpu_nbio_get_pcie_usage(struct amdgpu_device *adev, uint64_t
> +*count0, uint64_t *count1);
>  int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct
> ras_common_if *ras_block);  #endif
> --
> 2.34.1

