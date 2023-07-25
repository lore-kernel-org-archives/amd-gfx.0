Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FDFEB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 03:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5288010E101;
	Tue, 25 Jul 2023 03:01:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A0310E101
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 03:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbkVDY88BirkN7af+FyKyf6uJzvxETEcDC1cz/9qv33zHg3lMn40cmS29UsNg7xagOrVGJbmjEeuAxGW2GmZbAr85svYljJ7iAWAZc7p//kzIBVKD/nZK2CaKbV0MbPm2gEv/l7g8CKOIpQQdVPoLlgPA6HoEyCDNvQSSJElIBhLhiKZmhqA8ZUO479XjcibaJE0snqgj5xD1XgNyp9mezeh0OiQBqxYtrUPY98A6+6qDWlfVQHznG78CrCnRj+yMiUDAqvYKtxipu+g5cyXFMvWdypFzbGQ6c9K0ZjfLXdUv8uLsL0IulJ9brPV7BhmqB+X6FN3LJmAm2sezJg3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma25vOdkkrseXvlMVYhHsKl0JAbXZi6ZaTgjS5YBBAY=;
 b=oeXWSKJT1UviArVADNfEDIr3dWLbylWqbSQnR5Hnx/TXUFL0tR9lNMfWTs2UD62+PIE9M/pha4bdQKzAuDyTWDOw9ka2GJa0fQ54RfY4V211A6sq6ckm0DTK8YdNsmuZISaiEvKu9+7sH6YLoKT6pZHTMfNrkxXEzxI+F/m/ur4xYhyqpdYStxnSgFoK61DRQhCNDzX4UQO6+yc5KXPbw2RJyg4aGtQoEzz6qY+mrV+fHjkinSbdeTr//vuhcYT2UPJwNuge5dOalsf0a2aztAKMRoSRntkxAVrh7qgEjGIGpABL+uGrufFEFmr3ll4oxk0U4xvGDXl2RI4IDIYuQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma25vOdkkrseXvlMVYhHsKl0JAbXZi6ZaTgjS5YBBAY=;
 b=S3xLpCS5mdO/25uhL8zj+w8+TVt25WbsbmsgJs+89kLF3vKInJjOZULidNePccZ4OEHmgIQP46Mz3Tez8eEx75V+sYswizCzWQq4fmB7JGS51c60c60lLP84+JeB3BMjmsF51A0OhiIqYB2ccNk9cMlKXHfCoziWAQDaOdB7gwE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4561.namprd12.prod.outlook.com (2603:10b6:5:2ac::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Tue, 25 Jul 2023 03:01:03 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 03:01:03 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: add ih 6.1 support
Thread-Topic: [PATCH 2/3] drm/amdgpu: add ih 6.1 support
Thread-Index: AQHZvmo5SXfoJWqer0eCB/fBkf343K/JywFw
Date: Tue, 25 Jul 2023 03:01:03 +0000
Message-ID: <DM5PR12MB2469124C2BB6845CC4A03D04F103A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230724200513.764387-1-alexander.deucher@amd.com>
 <20230724200513.764387-2-alexander.deucher@amd.com>
In-Reply-To: <20230724200513.764387-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d1c3db3b-e9ff-465f-8d57-f8b1f3a6cbd0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-25T02:58:46Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM6PR12MB4561:EE_
x-ms-office365-filtering-correlation-id: 603b4a2f-410f-43ad-a6f7-08db8cbb61f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k44EqnAouJo6E4j1jmhRS/OI+qLFNGlN2yTSa3BHQsUGsEQDSCwBOvruBmJrwudy+LFHTwgOqsQiMEkxFVAAO6cdqKuQ3/G1gpDc4w4qc1K3fSCe4sz/+Pzb/KKpQSpNQmNhdfxkV9w6r43n8M5Yb4CKkokURM6IMv9rJoQf2jltWQVOnp0qqHBfzy/KgyIenrq2tg8/tlaNciTZS4/1omOVODJDL6Wl5SSjVtI1P8hVmL/CmHULpVDoaLkSFsRbkPSmk9q1nGy5t7LGpqccS1xezhj0oRex1e9WxiZIoVBPmPU4Cbip/PxQm0O7ZChiVrjaCizLVl/0gqi58jRwMQOYiwZqhY9bn7rRPwtuTMzdVnFIcRfrxdVsI+kPhgcvvKAz0fG1w5BDYhSCCebGhFbtGq2BqxRgK3LRO/7/OvnpMpoCVFXB8vWd0Dkh5UK4D2iwdIjyVaRmAhijVVeI1SCa/WtijpjCdsezYThWZQRkxuUidATK/geefC1DZ4C8uXnyqAAorjdyGymfxazrNreedOl4iIHCEAKfX4i7kCQc2Z3CMjlgpMzblILKhxU08HZBY/Yeiw966Oybq8eLYykrqlLa+ymnVxY5ZKcRc2fy/kERO+kKGyosvCfpPzij5bTloOWZZzyuY42pJ7EK0cdksoLjAkLy5nDYEsLWPg0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(5660300002)(8676002)(8936002)(76116006)(41300700001)(316002)(110136005)(478600001)(30864003)(2906002)(54906003)(7696005)(71200400001)(9686003)(6506007)(26005)(186003)(53546011)(64756008)(66556008)(4326008)(66946007)(66446008)(66476007)(38100700002)(83380400001)(66899021)(55016003)(52536014)(122000001)(33656002)(86362001)(38070700005)(21314003)(579004)(559001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HBHOBjz9+jBdpGIs51WUafR34Z/0WCH8nScm8ae8hJc8L3AYiBc8M+Asbz00?=
 =?us-ascii?Q?XVqr6woR3xthLfgfX9bx9LpwfmXg25D4LAXg2SmIbgBCioA54m17siyaWDTK?=
 =?us-ascii?Q?poMZfXbIKFmmaAiWNszSe1xRDA7xM8RutYVjuH46LRlrLs01WASFgrjafpiF?=
 =?us-ascii?Q?1paGSlKbCUq3gV7nVO4YBdQJpM1dxnssbe6aLJm2PYcfMJttmt792jQw1v8m?=
 =?us-ascii?Q?/stSidziwL1QOFVeyM/iQ8ySkU93hD4rLTa97CKIw0AdQ5zC5nqZSm/skZif?=
 =?us-ascii?Q?s3A+1/ZoLMvzci1MQ1EN6Ac4UjumAnv/DfQk0DKSwI3gIaVhfU2tiSnb/iMy?=
 =?us-ascii?Q?YwZm9jZEVmCJgPPZDi2uue9lXyddqnWefeK9ADqHl55qYHt3WNPYbXdXn5Sr?=
 =?us-ascii?Q?2PejpUsfoF3Vu2AV1pMIUSbFCXIQng1KB5SvMhE023Utu7Srslfq+8u5Z28c?=
 =?us-ascii?Q?t0STYeuLQqt7uj+mFf7GMARNDcV9TYtG0cDAnAm01473UpD4X/kGtCMLq/WU?=
 =?us-ascii?Q?SDvOKpG4pGXYYUFbQY1oYM0ow5GFYxhJOJSFiGQuG5b/H09N2MC42Ux2KMup?=
 =?us-ascii?Q?xUEykKCebJtF015cB7FlkDO+nK2vogiNGOxi7D8OJ8zMBQxsHjvD7xMI+W0X?=
 =?us-ascii?Q?QcFzHHQoGAkzC0MFDgBNDdpWZnKrCXzamRrKUj+QL/gMKmYDBdjxl/5Sx+VQ?=
 =?us-ascii?Q?WxC94+D2q7jn8QUUcEajykF7TsAX4Ew1yhdrllt9qKgCefNTcysMK0n8oLrq?=
 =?us-ascii?Q?w8yapKLF7d9rJ1PkkFwjNZgubEvqPWVEf98jhw4Be6RVnsfWXIAUuULUzjHh?=
 =?us-ascii?Q?QAVX6G0ubASMyDDvxeiNMjThNKMbdFTx7xMg/ELT1O4q5bKNAEvRzzMm6J54?=
 =?us-ascii?Q?goQPtnCLtE2wK4z0d+ZWw5hTPPCmFhAS5uNxyhPmWfnHea8yKSsAJZGxAJSL?=
 =?us-ascii?Q?3/WJQc5xmGD7YJquaj5H9d9frdn+5N7XDs3az5SxhaQeLzg7RN3qAKCCtwl7?=
 =?us-ascii?Q?GdjsOiE896QXGsi2Citpxv/3SGUVAOKx+M5o50hwj6zNlN5SDJf3CxCnj63Z?=
 =?us-ascii?Q?LOtryiecyQi8L+Ii20LFfe5PRa6IbXSRBRif+Yprbg+qY+EqThTkEsb3GghL?=
 =?us-ascii?Q?wjENZ+Pb5DJdAWugCIN8QXntBdH1mFaTmaKLI7VhzM10B+bXhmqos5S8VAyO?=
 =?us-ascii?Q?PUGYUyEfN23Xo6iJMQfhWKRHwnAYBRpXNXl9Ct122tnAob/kH/qQmalBk4Q8?=
 =?us-ascii?Q?wLRMM6+NyXrxeG0zxv+F5qQtywJ+2DpVVI5zj9pkMN4IikJ/8ak5ntbw3Kjq?=
 =?us-ascii?Q?F/N+fahtYFbDe52jmgbNxXYlrDyDF2WEiskcGxadM6zTECy72mUyW9hzX+Iu?=
 =?us-ascii?Q?uXocCtfIZ27XARLaKwisX2zJX1UF85QntV5OVsM1KfUNVZt69ZdWDxbYE13s?=
 =?us-ascii?Q?ptpvM+KKbe7wv15kOJyLuzBSiX90rIHl/bx7fP6ZQsC8X3w7PTWarroSv73Y?=
 =?us-ascii?Q?Njim5OEo8gPqf4cuIOPfkz8WxWGfYsFbAV72WxeXz+WGUgcOw+3ek+0H086J?=
 =?us-ascii?Q?SNmL9cDeS9rtri1z5Ro=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603b4a2f-410f-43ad-a6f7-08db8cbb61f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 03:01:03.3143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4//IZp+wa4KX4bXqfQqpYnxmyVTO2Y26cbVuTaG6Ky22s+nXrWFWD3m4sICL5QckKHUCz5zOVo+xWX2ydokCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4561
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Li,
 Ben" <Ben.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, July 25, 2023 4:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Ben
> <Ben.Li@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu: add ih 6.1 support
>
> From: benl <ben.li@amd.com>
>
> Add initial support for IH 6.1.
>
> Signed-off-by: benl <ben.li@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile  |   3 +-
>  drivers/gpu/drm/amd/amdgpu/ih_v6_1.c | 769
> +++++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/ih_v6_1.h
> |  28 +
>  3 files changed, 799 insertions(+), 1 deletion(-)  create mode 100644
> drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v6_1.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 29325981778a0..384b798a9bad1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -129,7 +129,8 @@ amdgpu-y +=3D \
>       vega10_ih.o \
>       vega20_ih.o \
>       navi10_ih.o \
> -     ih_v6_0.o
> +     ih_v6_0.o \
> +     ih_v6_1.o
>
>  # add PSP block
>  amdgpu-y +=3D \
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> new file mode 100644
> index 0000000000000..5795a66ccbc5d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> @@ -0,0 +1,769 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *

I guess the copyright year here should be 2023? Same for the new header fil=
e ih_v6_1.h if it's right.

Regards,
Guchun

> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <linux/pci.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_ih.h"
> +
> +#include "oss/osssys_6_1_0_offset.h"
> +#include "oss/osssys_6_1_0_sh_mask.h"
> +
> +#include "soc15_common.h"
> +#include "ih_v6_1.h"
> +
> +#define MAX_REARM_RETRY 10
> +
> +static void ih_v6_1_set_interrupt_funcs(struct amdgpu_device *adev);
> +
> +/**
> + * ih_v6_1_init_register_offset - Initialize register offset for ih
> +rings
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Initialize register offset ih rings (IH_V6_0).
> + */
> +static void ih_v6_1_init_register_offset(struct amdgpu_device *adev) {
> +     struct amdgpu_ih_regs *ih_regs;
> +
> +     /* ih ring 2 is removed
> +      * ih ring and ih ring 1 are available */
> +     if (adev->irq.ih.ring_size) {
> +             ih_regs =3D &adev->irq.ih.ih_regs;
> +             ih_regs->ih_rb_base =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_RB_BASE);
> +             ih_regs->ih_rb_base_hi =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_RB_BASE_HI);
> +             ih_regs->ih_rb_cntl =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_RB_CNTL);
> +             ih_regs->ih_rb_wptr =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_RB_WPTR);
> +             ih_regs->ih_rb_rptr =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_RB_RPTR);
> +             ih_regs->ih_doorbell_rptr =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_DOORBELL_RPTR);
> +             ih_regs->ih_rb_wptr_addr_lo =3D SOC15_REG_OFFSET(OSSSYS,
> 0, regIH_RB_WPTR_ADDR_LO);
> +             ih_regs->ih_rb_wptr_addr_hi =3D SOC15_REG_OFFSET(OSSSYS,
> 0, regIH_RB_WPTR_ADDR_HI);
> +             ih_regs->psp_reg_id =3D PSP_REG_IH_RB_CNTL;
> +     }
> +
> +     if (adev->irq.ih1.ring_size) {
> +             ih_regs =3D &adev->irq.ih1.ih_regs;
> +             ih_regs->ih_rb_base =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_RB_BASE_RING1);
> +             ih_regs->ih_rb_base_hi =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_RB_BASE_HI_RING1);
> +             ih_regs->ih_rb_cntl =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_RB_CNTL_RING1);
> +             ih_regs->ih_rb_wptr =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_RB_WPTR_RING1);
> +             ih_regs->ih_rb_rptr =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_RB_RPTR_RING1);
> +             ih_regs->ih_doorbell_rptr =3D SOC15_REG_OFFSET(OSSSYS, 0,
> regIH_DOORBELL_RPTR_RING1);
> +             ih_regs->psp_reg_id =3D PSP_REG_IH_RB_CNTL_RING1;
> +     }
> +}
> +
> +/**
> + * force_update_wptr_for_self_int - Force update the wptr for self
> +interrupt
> + *
> + * @adev: amdgpu_device pointer
> + * @threshold: threshold to trigger the wptr reporting
> + * @timeout: timeout to trigger the wptr reporting
> + * @enabled: Enable/disable timeout flush mechanism
> + *
> + * threshold input range: 0 ~ 15, default 0,
> + * real_threshold =3D 2^threshold
> + * timeout input range: 0 ~ 20, default 8,
> + * real_timeout =3D (2^timeout) * 1024 / (socclk_freq)
> + *
> + * Force update wptr for self interrupt ( >=3D SIENNA_CICHLID).
> + */
> +static void
> +force_update_wptr_for_self_int(struct amdgpu_device *adev,
> +                            u32 threshold, u32 timeout, bool enabled) {
> +     u32 ih_cntl, ih_rb_cntl;
> +
> +     ih_cntl =3D RREG32_SOC15(OSSSYS, 0, regIH_CNTL2);
> +     ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, regIH_RB_CNTL_RING1);
> +
> +     ih_cntl =3D REG_SET_FIELD(ih_cntl, IH_CNTL2,
> +                             SELF_IV_FORCE_WPTR_UPDATE_TIMEOUT,
> timeout);
> +     ih_cntl =3D REG_SET_FIELD(ih_cntl, IH_CNTL2,
> +                             SELF_IV_FORCE_WPTR_UPDATE_ENABLE,
> enabled);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
> +                                RB_USED_INT_THRESHOLD, threshold);
> +
> +     if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev))
> {
> +             if (psp_reg_program(&adev->psp,
> PSP_REG_IH_RB_CNTL_RING1, ih_rb_cntl))
> +                     return;
> +     } else {
> +             WREG32_SOC15(OSSSYS, 0, regIH_RB_CNTL_RING1,
> ih_rb_cntl);
> +     }
> +
> +     WREG32_SOC15(OSSSYS, 0, regIH_CNTL2, ih_cntl); }
> +
> +/**
> + * ih_v6_1_toggle_ring_interrupts - toggle the interrupt ring buffer
> + *
> + * @adev: amdgpu_device pointer
> + * @ih: amdgpu_ih_ring pointer
> + * @enable: true - enable the interrupts, false - disable the
> +interrupts
> + *
> + * Toggle the interrupt ring buffer (IH_V6_0)  */ static int
> +ih_v6_1_toggle_ring_interrupts(struct amdgpu_device *adev,
> +                                       struct amdgpu_ih_ring *ih,
> +                                       bool enable)
> +{
> +     struct amdgpu_ih_regs *ih_regs;
> +     uint32_t tmp;
> +
> +     ih_regs =3D &ih->ih_regs;
> +
> +     tmp =3D RREG32(ih_regs->ih_rb_cntl);
> +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 :
> 0));
> +     /* enable_intr field is only valid in ring0 */
> +     if (ih =3D=3D &adev->irq.ih)
> +             tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR,
> (enable ? 1 : 0));
> +
> +     if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev))
> {
> +             if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
> +                     return -ETIMEDOUT;
> +     } else {
> +             WREG32(ih_regs->ih_rb_cntl, tmp);
> +     }
> +
> +     if (enable) {
> +             ih->enabled =3D true;
> +     } else {
> +             /* set rptr, wptr to 0 */
> +             WREG32(ih_regs->ih_rb_rptr, 0);
> +             WREG32(ih_regs->ih_rb_wptr, 0);
> +             ih->enabled =3D false;
> +             ih->rptr =3D 0;
> +     }
> +
> +     return 0;
> +}
> +
> +/**
> + * ih_v6_1_toggle_interrupts - Toggle all the available interrupt ring
> +buffers
> + *
> + * @adev: amdgpu_device pointer
> + * @enable: enable or disable interrupt ring buffers
> + *
> + * Toggle all the available interrupt ring buffers (IH_V6_0).
> + */
> +static int ih_v6_1_toggle_interrupts(struct amdgpu_device *adev, bool
> +enable) {
> +     struct amdgpu_ih_ring *ih[] =3D {&adev->irq.ih, &adev->irq.ih1};
> +     int i;
> +     int r;
> +
> +     for (i =3D 0; i < ARRAY_SIZE(ih); i++) {
> +             if (ih[i]->ring_size) {
> +                     r =3D ih_v6_1_toggle_ring_interrupts(adev, ih[i],
> enable);
> +                     if (r)
> +                             return r;
> +             }
> +     }
> +
> +     return 0;
> +}
> +
> +static uint32_t ih_v6_1_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t
> +ih_rb_cntl) {
> +     int rb_bufsz =3D order_base_2(ih->ring_size / 4);
> +
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +                                MC_SPACE, ih->use_bus_addr ? 2 : 4);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +                                WPTR_OVERFLOW_CLEAR, 1);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +                                WPTR_OVERFLOW_ENABLE, 1);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_SIZE,
> rb_bufsz);
> +     /* Ring Buffer write pointer writeback. If enabled, IH_RB_WPTR
> register
> +      * value is written to memory
> +      */
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +                                WPTR_WRITEBACK_ENABLE, 1);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_SNOOP, 1);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_RO, 0);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_VMID, 0);
> +
> +     return ih_rb_cntl;
> +}
> +
> +static uint32_t ih_v6_1_doorbell_rptr(struct amdgpu_ih_ring *ih) {
> +     u32 ih_doorbell_rtpr =3D 0;
> +
> +     if (ih->use_doorbell) {
> +             ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,
> +                                              IH_DOORBELL_RPTR, OFFSET,
> +                                              ih->doorbell_index);
> +             ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,
> +                                              IH_DOORBELL_RPTR,
> +                                              ENABLE, 1);
> +     } else {
> +             ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,
> +                                              IH_DOORBELL_RPTR,
> +                                              ENABLE, 0);
> +     }
> +     return ih_doorbell_rtpr;
> +}
> +
> +/**
> + * ih_v6_1_enable_ring - enable an ih ring buffer
> + *
> + * @adev: amdgpu_device pointer
> + * @ih: amdgpu_ih_ring pointer
> + *
> + * Enable an ih ring buffer (IH_V6_0)
> + */
> +static int ih_v6_1_enable_ring(struct amdgpu_device *adev,
> +                                   struct amdgpu_ih_ring *ih)
> +{
> +     struct amdgpu_ih_regs *ih_regs;
> +     uint32_t tmp;
> +
> +     ih_regs =3D &ih->ih_regs;
> +
> +     /* Ring Buffer base. [39:8] of 40-bit address of the beginning of t=
he
> ring buffer*/
> +     WREG32(ih_regs->ih_rb_base, ih->gpu_addr >> 8);
> +     WREG32(ih_regs->ih_rb_base_hi, (ih->gpu_addr >> 40) & 0xff);
> +
> +     tmp =3D RREG32(ih_regs->ih_rb_cntl);
> +     tmp =3D ih_v6_1_rb_cntl(ih, tmp);
> +     if (ih =3D=3D &adev->irq.ih)
> +             tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL,
> RPTR_REARM, !!adev->irq.msi_enabled);
> +     if (ih =3D=3D &adev->irq.ih1) {
> +             tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL,
> WPTR_OVERFLOW_ENABLE, 0);
> +             tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL,
> RB_FULL_DRAIN_ENABLE, 1);
> +     }
> +
> +     if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev))
> {
> +             if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
> {
> +                     DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> +                     return -ETIMEDOUT;
> +             }
> +     } else {
> +             WREG32(ih_regs->ih_rb_cntl, tmp);
> +     }
> +
> +     if (ih =3D=3D &adev->irq.ih) {
> +             /* set the ih ring 0 writeback address whether it's enabled=
 or
> not */
> +             WREG32(ih_regs->ih_rb_wptr_addr_lo, lower_32_bits(ih-
> >wptr_addr));
> +             WREG32(ih_regs->ih_rb_wptr_addr_hi, upper_32_bits(ih-
> >wptr_addr) & 0xFFFF);
> +     }
> +
> +     /* set rptr, wptr to 0 */
> +     WREG32(ih_regs->ih_rb_wptr, 0);
> +     WREG32(ih_regs->ih_rb_rptr, 0);
> +
> +     WREG32(ih_regs->ih_doorbell_rptr, ih_v6_1_doorbell_rptr(ih));
> +
> +     return 0;
> +}
> +
> +/**
> + * ih_v6_1_irq_init - init and enable the interrupt ring
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Allocate a ring buffer for the interrupt controller,
> + * enable the RLC, disable interrupts, enable the IH
> + * ring buffer and enable it.
> + * Called at device load and reume.
> + * Returns 0 for success, errors for failure.
> + */
> +static int ih_v6_1_irq_init(struct amdgpu_device *adev) {
> +     struct amdgpu_ih_ring *ih[] =3D {&adev->irq.ih, &adev->irq.ih1};
> +     u32 ih_chicken;
> +     u32 tmp;
> +     int ret;
> +     int i;
> +
> +     /* disable irqs */
> +     ret =3D ih_v6_1_toggle_interrupts(adev, false);
> +     if (ret)
> +             return ret;
> +
> +     adev->nbio.funcs->ih_control(adev);
> +
> +     if (unlikely((adev->firmware.load_type =3D=3D
> AMDGPU_FW_LOAD_DIRECT) ||
> +                  (adev->firmware.load_type =3D=3D
> AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO))) {
> +             if (ih[0]->use_bus_addr) {
> +                     ih_chicken =3D RREG32_SOC15(OSSSYS, 0,
> regIH_CHICKEN);
> +                     ih_chicken =3D REG_SET_FIELD(ih_chicken,
> +                                     IH_CHICKEN,
> MC_SPACE_GPA_ENABLE, 1);
> +                     WREG32_SOC15(OSSSYS, 0, regIH_CHICKEN,
> ih_chicken);
> +             }
> +     }
> +
> +     for (i =3D 0; i < ARRAY_SIZE(ih); i++) {
> +             if (ih[i]->ring_size) {
> +                     ret =3D ih_v6_1_enable_ring(adev, ih[i]);
> +                     if (ret)
> +                             return ret;
> +             }
> +     }
> +
> +     /* update doorbell range for ih ring 0 */
> +     adev->nbio.funcs->ih_doorbell_range(adev, ih[0]->use_doorbell,
> +                                         ih[0]->doorbell_index);
> +
> +     tmp =3D RREG32_SOC15(OSSSYS, 0, regIH_STORM_CLIENT_LIST_CNTL);
> +     tmp =3D REG_SET_FIELD(tmp, IH_STORM_CLIENT_LIST_CNTL,
> +                         CLIENT18_IS_STORM_CLIENT, 1);
> +     WREG32_SOC15(OSSSYS, 0, regIH_STORM_CLIENT_LIST_CNTL, tmp);
> +
> +     tmp =3D RREG32_SOC15(OSSSYS, 0, regIH_INT_FLOOD_CNTL);
> +     tmp =3D REG_SET_FIELD(tmp, IH_INT_FLOOD_CNTL,
> FLOOD_CNTL_ENABLE, 1);
> +     WREG32_SOC15(OSSSYS, 0, regIH_INT_FLOOD_CNTL, tmp);
> +
> +     /* GC/MMHUB UTCL2 page fault interrupts are configured as
> +      * MSI storm capable interrupts by deafult. The delay is
> +      * used to avoid ISR being called too frequently
> +      * when page fault happens on several continuous page
> +      * and thus avoid MSI storm */
> +     tmp =3D RREG32_SOC15(OSSSYS, 0, regIH_MSI_STORM_CTRL);
> +     tmp =3D REG_SET_FIELD(tmp, IH_MSI_STORM_CTRL,
> +                         DELAY, 3);
> +     WREG32_SOC15(OSSSYS, 0, regIH_MSI_STORM_CTRL, tmp);
> +
> +     pci_set_master(adev->pdev);
> +
> +     /* enable interrupts */
> +     ret =3D ih_v6_1_toggle_interrupts(adev, true);
> +     if (ret)
> +             return ret;
> +     /* enable wptr force update for self int */
> +     force_update_wptr_for_self_int(adev, 0, 8, true);
> +
> +     if (adev->irq.ih_soft.ring_size)
> +             adev->irq.ih_soft.enabled =3D true;
> +
> +     return 0;
> +}
> +
> +/**
> + * ih_v6_1_irq_disable - disable interrupts
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Disable interrupts on the hw.
> + */
> +static void ih_v6_1_irq_disable(struct amdgpu_device *adev) {
> +     force_update_wptr_for_self_int(adev, 0, 8, false);
> +     ih_v6_1_toggle_interrupts(adev, false);
> +
> +     /* Wait and acknowledge irq */
> +     mdelay(1);
> +}
> +
> +/**
> + * ih_v6_1_get_wptr - get the IH ring buffer wptr
> + *
> + * @adev: amdgpu_device pointer
> + * @ih: amdgpu_ih_ring pointer
> + *
> + * Get the IH ring buffer wptr from either the register
> + * or the writeback memory buffer.  Also check for
> + * ring buffer overflow and deal with it.
> + * Returns the value of the wptr.
> + */
> +static u32 ih_v6_1_get_wptr(struct amdgpu_device *adev,
> +                           struct amdgpu_ih_ring *ih)
> +{
> +     u32 wptr, tmp;
> +     struct amdgpu_ih_regs *ih_regs;
> +
> +     wptr =3D le32_to_cpu(*ih->wptr_cpu);
> +     ih_regs =3D &ih->ih_regs;
> +
> +     if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> +             goto out;
> +
> +     wptr =3D RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
> +     if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> +             goto out;
> +     wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +
> +     /* When a ring buffer overflow happen start parsing interrupt
> +      * from the last not overwritten vector (wptr + 32). Hopefully
> +      * this should allow us to catch up.
> +      */
> +     tmp =3D (wptr + 32) & ih->ptr_mask;
> +     dev_warn(adev->dev, "IH ring buffer overflow "
> +              "(0x%08X, 0x%08X, 0x%08X)\n",
> +              wptr, ih->rptr, tmp);
> +     ih->rptr =3D tmp;
> +
> +     tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,
> 1);
> +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +out:
> +     return (wptr & ih->ptr_mask);
> +}
> +
> +/**
> + * ih_v6_1_irq_rearm - rearm IRQ if lost
> + *
> + * @adev: amdgpu_device pointer
> + * @ih: amdgpu_ih_ring pointer
> + *
> + */
> +static void ih_v6_1_irq_rearm(struct amdgpu_device *adev,
> +                            struct amdgpu_ih_ring *ih)
> +{
> +     uint32_t v =3D 0;
> +     uint32_t i =3D 0;
> +     struct amdgpu_ih_regs *ih_regs;
> +
> +     ih_regs =3D &ih->ih_regs;
> +
> +     /* Rearm IRQ / re-write doorbell if doorbell write is lost */
> +     for (i =3D 0; i < MAX_REARM_RETRY; i++) {
> +             v =3D RREG32_NO_KIQ(ih_regs->ih_rb_rptr);
> +             if ((v < ih->ring_size) && (v !=3D ih->rptr))
> +                     WDOORBELL32(ih->doorbell_index, ih->rptr);
> +             else
> +                     break;
> +     }
> +}
> +
> +/**
> + * ih_v6_1_set_rptr - set the IH ring buffer rptr
> + *
> + * @adev: amdgpu_device pointer
> + * @ih: amdgpu_ih_ring pointer
> + *
> + * Set the IH ring buffer rptr.
> + */
> +static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
> +                            struct amdgpu_ih_ring *ih)
> +{
> +     struct amdgpu_ih_regs *ih_regs;
> +
> +     if (ih->use_doorbell) {
> +             /* XXX check if swapping is necessary on BE */
> +             *ih->rptr_cpu =3D ih->rptr;
> +             WDOORBELL32(ih->doorbell_index, ih->rptr);
> +
> +             if (amdgpu_sriov_vf(adev))
> +                     ih_v6_1_irq_rearm(adev, ih);
> +     } else {
> +             ih_regs =3D &ih->ih_regs;
> +             WREG32(ih_regs->ih_rb_rptr, ih->rptr);
> +     }
> +}
> +
> +/**
> + * ih_v6_1_self_irq - dispatch work for ring 1
> + *
> + * @adev: amdgpu_device pointer
> + * @source: irq source
> + * @entry: IV with WPTR update
> + *
> + * Update the WPTR from the IV and schedule work to handle the entries.
> + */
> +static int ih_v6_1_self_irq(struct amdgpu_device *adev,
> +                           struct amdgpu_irq_src *source,
> +                           struct amdgpu_iv_entry *entry) {
> +     uint32_t wptr =3D cpu_to_le32(entry->src_data[0]);
> +
> +     switch (entry->ring_id) {
> +     case 1:
> +             *adev->irq.ih1.wptr_cpu =3D wptr;
> +             schedule_work(&adev->irq.ih1_work);
> +             break;
> +     default: break;
> +     }
> +     return 0;
> +}
> +
> +static const struct amdgpu_irq_src_funcs ih_v6_1_self_irq_funcs =3D {
> +     .process =3D ih_v6_1_self_irq,
> +};
> +
> +static void ih_v6_1_set_self_irq_funcs(struct amdgpu_device *adev) {
> +     adev->irq.self_irq.num_types =3D 0;
> +     adev->irq.self_irq.funcs =3D &ih_v6_1_self_irq_funcs; }
> +
> +static int ih_v6_1_early_init(void *handle) {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     ih_v6_1_set_interrupt_funcs(adev);
> +     ih_v6_1_set_self_irq_funcs(adev);
> +     return 0;
> +}
> +
> +static int ih_v6_1_sw_init(void *handle) {
> +     int r;
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     bool use_bus_addr;
> +
> +     r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
> +                           &adev->irq.self_irq);
> +
> +     if (r)
> +             return r;
> +
> +     /* use gpu virtual address for ih ring
> +      * until ih_checken is programmed to allow
> +      * use bus address for ih ring by psp bl */
> +     use_bus_addr =3D
> +             (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) ?
> false : true;
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024,
> use_bus_addr);
> +     if (r)
> +             return r;
> +
> +     adev->irq.ih.use_doorbell =3D true;
> +     adev->irq.ih.doorbell_index =3D adev->doorbell_index.ih << 1;
> +
> +     adev->irq.ih1.ring_size =3D 0;
> +     adev->irq.ih2.ring_size =3D 0;
> +
> +     /* initialize ih control register offset */
> +     ih_v6_1_init_register_offset(adev);
> +
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true=
);
> +     if (r)
> +             return r;
> +
> +     r =3D amdgpu_irq_init(adev);
> +
> +     return r;
> +}
> +
> +static int ih_v6_1_sw_fini(void *handle) {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     amdgpu_irq_fini_sw(adev);
> +
> +     return 0;
> +}
> +
> +static int ih_v6_1_hw_init(void *handle) {
> +     int r;
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     r =3D ih_v6_1_irq_init(adev);
> +     if (r)
> +             return r;
> +
> +     return 0;
> +}
> +
> +static int ih_v6_1_hw_fini(void *handle) {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     ih_v6_1_irq_disable(adev);
> +
> +     return 0;
> +}
> +
> +static int ih_v6_1_suspend(void *handle) {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     return ih_v6_1_hw_fini(adev);
> +}
> +
> +static int ih_v6_1_resume(void *handle) {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     return ih_v6_1_hw_init(adev);
> +}
> +
> +static bool ih_v6_1_is_idle(void *handle) {
> +     /* todo */
> +     return true;
> +}
> +
> +static int ih_v6_1_wait_for_idle(void *handle) {
> +     /* todo */
> +     return -ETIMEDOUT;
> +}
> +
> +static int ih_v6_1_soft_reset(void *handle) {
> +     /* todo */
> +     return 0;
> +}
> +
> +static void ih_v6_1_update_clockgating_state(struct amdgpu_device *adev,
> +                                            bool enable)
> +{
> +     uint32_t data, def, field_val;
> +
> +     if (adev->cg_flags & AMD_CG_SUPPORT_IH_CG) {
> +             def =3D data =3D RREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL);
> +             field_val =3D enable ? 0 : 1;
> +             data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  DBUS_MUX_CLK_SOFT_OVERRIDE,
> field_val);
> +             data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  OSSSYS_SHARE_CLK_SOFT_OVERRIDE,
> field_val);
> +             data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  LIMIT_SMN_CLK_SOFT_OVERRIDE,
> field_val);
> +             data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  DYN_CLK_SOFT_OVERRIDE, field_val);
> +             data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  REG_CLK_SOFT_OVERRIDE, field_val);
> +             if (def !=3D data)
> +                     WREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL, data);
> +     }
> +
> +     return;
> +}
> +
> +static int ih_v6_1_set_clockgating_state(void *handle,
> +                                        enum amd_clockgating_state state=
)
> {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     ih_v6_1_update_clockgating_state(adev,
> +                             state =3D=3D AMD_CG_STATE_GATE);
> +     return 0;
> +}
> +
> +static void ih_v6_1_update_ih_mem_power_gating(struct amdgpu_device
> *adev,
> +                                            bool enable)
> +{
> +     uint32_t ih_mem_pwr_cntl;
> +
> +     /* Disable ih sram power cntl before switch powergating mode */
> +     ih_mem_pwr_cntl =3D RREG32_SOC15(OSSSYS, 0,
> regIH_MEM_POWER_CTRL);
> +     ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +                                     IH_BUFFER_MEM_POWER_CTRL_EN,
> 0);
> +     WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL,
> ih_mem_pwr_cntl);
> +
> +     /* It is recommended to set mem powergating mode to DS mode */
> +     if (enable) {
> +             /* mem power mode */
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_BUFFER_MEM_POWER_LS_EN, 0);
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_BUFFER_MEM_POWER_DS_EN, 1);
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_BUFFER_MEM_POWER_SD_EN, 0);
> +             /* cam mem power mode */
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_RETRY_INT_CAM_MEM_POWER_LS_EN, 0);
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_RETRY_INT_CAM_MEM_POWER_DS_EN, 1);
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_RETRY_INT_CAM_MEM_POWER_SD_EN, 0);
> +             /* re-enable power cntl */
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_BUFFER_MEM_POWER_CTRL_EN, 1);
> +     } else {
> +             /* mem power mode */
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_BUFFER_MEM_POWER_LS_EN, 0);
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_BUFFER_MEM_POWER_DS_EN, 0);
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_BUFFER_MEM_POWER_SD_EN, 0);
> +             /* cam mem power mode */
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_RETRY_INT_CAM_MEM_POWER_LS_EN, 0);
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_RETRY_INT_CAM_MEM_POWER_DS_EN, 0);
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_RETRY_INT_CAM_MEM_POWER_SD_EN, 0);
> +             /* re-enable power cntl*/
> +             ih_mem_pwr_cntl =3D REG_SET_FIELD(ih_mem_pwr_cntl,
> IH_MEM_POWER_CTRL,
> +
>       IH_BUFFER_MEM_POWER_CTRL_EN, 1);
> +     }
> +
> +     WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL,
> ih_mem_pwr_cntl); }
> +
> +static int ih_v6_1_set_powergating_state(void *handle,
> +                                      enum amd_powergating_state state)
> {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     bool enable =3D (state =3D=3D AMD_PG_STATE_GATE);
> +
> +     if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
> +             ih_v6_1_update_ih_mem_power_gating(adev, enable);
> +
> +     return 0;
> +}
> +
> +static void ih_v6_1_get_clockgating_state(void *handle, u64 *flags) {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     if (!RREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL))
> +             *flags |=3D AMD_CG_SUPPORT_IH_CG;
> +
> +     return;
> +}
> +
> +static const struct amd_ip_funcs ih_v6_1_ip_funcs =3D {
> +     .name =3D "ih_v6_1",
> +     .early_init =3D ih_v6_1_early_init,
> +     .late_init =3D NULL,
> +     .sw_init =3D ih_v6_1_sw_init,
> +     .sw_fini =3D ih_v6_1_sw_fini,
> +     .hw_init =3D ih_v6_1_hw_init,
> +     .hw_fini =3D ih_v6_1_hw_fini,
> +     .suspend =3D ih_v6_1_suspend,
> +     .resume =3D ih_v6_1_resume,
> +     .is_idle =3D ih_v6_1_is_idle,
> +     .wait_for_idle =3D ih_v6_1_wait_for_idle,
> +     .soft_reset =3D ih_v6_1_soft_reset,
> +     .set_clockgating_state =3D ih_v6_1_set_clockgating_state,
> +     .set_powergating_state =3D ih_v6_1_set_powergating_state,
> +     .get_clockgating_state =3D ih_v6_1_get_clockgating_state, };
> +
> +static const struct amdgpu_ih_funcs ih_v6_1_funcs =3D {
> +     .get_wptr =3D ih_v6_1_get_wptr,
> +     .decode_iv =3D amdgpu_ih_decode_iv_helper,
> +     .decode_iv_ts =3D amdgpu_ih_decode_iv_ts_helper,
> +     .set_rptr =3D ih_v6_1_set_rptr
> +};
> +
> +static void ih_v6_1_set_interrupt_funcs(struct amdgpu_device *adev) {
> +     adev->irq.ih_funcs =3D &ih_v6_1_funcs;
> +}
> +
> +const struct amdgpu_ip_block_version ih_v6_1_ip_block =3D {
> +     .type =3D AMD_IP_BLOCK_TYPE_IH,
> +     .major =3D 6,
> +     .minor =3D 0,
> +     .rev =3D 0,
> +     .funcs =3D &ih_v6_1_ip_funcs,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.h
> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.h
> new file mode 100644
> index 0000000000000..c48930d394cff
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.h
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef __IH_V6_1_IH_H__
> +#define __IH_V6_1_IH_H__
> +
> +extern const struct amdgpu_ip_block_version ih_v6_1_ip_block;
> +
> +#endif
> --
> 2.41.0

