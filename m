Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F69EC2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 06:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF6F10E1FB;
	Tue,  9 Jul 2024 06:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z1IUWG67";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C3C10E1FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 06:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+0NPKDHxh5BkjZrB9oKjy8QpBe2OUIKA/t4EQS73k/o3ZVnrjnM+R47Hy+hxCOtIg4I8steEOROewXQqCRO33fNL7oPQOWvJgbiMI63AgYYks18LFcVklUFwxB2YJu+XFKQZ5n7sOkMfYSN8nxR4VtMFaBjwqyX28m01+EuklNI7QjiKRrpFxjREvMG7IMwTlrP+UZNNOfQlR08LgfBHn8LKcQd1ovzZ3SCEIFLPngs7JDyMgmBX1HY1wz3n67D1QE+T2QQ4BNb5VABgSz+WSbeKcjkXyGj4QLw0ulpSpzO2Zr6TR0MCBy821Ag0TsSA8kW9r7IhOCz85ZBD89VIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4vnZ6weYf1X1UYCHvMIZWjs8FppM+Jtccuru1ifvTE=;
 b=ZHpik2WjMuk5cAvph/DobLMGWdABSFnAAvniBTufdL4luHieqmn0hxlzKC8UG0J3Sjp5zUZV6bvOsp58plqvosboG+f8d5W9bazxqeR5eNcHT+ERYV7JkIarLodtDE47msppmXNiXMKh5wsgSxrwbvNJVRswOeDS0dgIDAFtPonoMBCkiOoBjJ0G1dkQbAxaqPqEPobPIduE+uIJyzDaT6uHKVvAsfCiI/3RUSAi9GORuSPwes9zmaPYlG2x1kG+X2wdS+8FqlwZgoXJUvWrv6cDhJ5/tL4sJNfrcn++x/FYZ1a9MoiA00nrDGs0qu06+DWQtDQQuf27JkgOu6eDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4vnZ6weYf1X1UYCHvMIZWjs8FppM+Jtccuru1ifvTE=;
 b=Z1IUWG67t0MyCYYDqZ5jju39XHXstJErZ052XpMvIk8rGPMWNYRWg0hC3QiiuoN2SGX6zXkdPuZKn6+TQnJEKcLpmrRJO6Mml92SJSk/NPU4b8koRgdqsUU5hN2lO0BPdg723cNQDNpFA/gWmbvyyz1Iy3m3pRJ8lGu9YlhYvvI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 06:13:00 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:12:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2 2/2] drm/amdgpu: timely save bad pages to eeprom after
 gpu ras reset is completed
Thread-Topic: [PATCH V2 2/2] drm/amdgpu: timely save bad pages to eeprom after
 gpu ras reset is completed
Thread-Index: AQHa0cTKYo0iEAiQxkODzTVRvlE+wbHt6oWQ
Date: Tue, 9 Jul 2024 06:12:59 +0000
Message-ID: <PH7PR12MB8796D1C2F2422DE649490389B0DB2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240709055606.53567-1-YiPeng.Chai@amd.com>
 <20240709055606.53567-2-YiPeng.Chai@amd.com>
In-Reply-To: <20240709055606.53567-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=21cadbd0-f181-405c-9f22-65c0e1882731;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-09T06:12:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA0PR12MB8374:EE_
x-ms-office365-filtering-correlation-id: 6544b636-2463-4f8f-fd23-08dc9fde2ef7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KpHaIQT/PKI7oOa2S3PAYRXrgW0hs30cgATSFr2A+AxmXCqskokvI2Ng4yMW?=
 =?us-ascii?Q?RHQSsYbxc+/AFOp/2Ua3x5wYlvW0Z666zR2WPowV77VeYiplXUCGMm5zL8/Q?=
 =?us-ascii?Q?ILaFF6NVq0IwC1/KlRScfPvAP9as59YiAHCZ32ScY4XOCmMxFws16RKNCh3y?=
 =?us-ascii?Q?OAmGqEzixjIcm+ZfPTaXG6Vpg3hAFJmQU6Csk+R3sK5Y1+3QELTr5rAsF7gZ?=
 =?us-ascii?Q?AheSwzzWxpmqB9uaf3FbbPB3bbrtmatru/VijhlfGrjo/+4/ujAGQO1FGcYQ?=
 =?us-ascii?Q?MOaXMznpuUxr4WWKBKjBd/RTOFwuZJpGuvLTzFCsHb1InqzAkr/u29XnDXJ1?=
 =?us-ascii?Q?6JXgIZVq9yvR7LEfiKYTeVT2kWq59Pzq0nxLdGTJhsgX75+s723UZJym8vtx?=
 =?us-ascii?Q?0Jb4v3TomI7C1G9X6iwrgVLqBi6u8bv191ylLk7vlQ6PA1Btgn9WAsU53nJ6?=
 =?us-ascii?Q?B9CPAVy9GUeN73ZfEfmN6p1/VqJCsVfr/66Kwfj68XBF+IxgtT5gUM8NYXb8?=
 =?us-ascii?Q?bkR6ZdMHk9C/M9CyLWnA5tkcuZWwKLB7IAjrwVGsl8FmfVMqEC8uwKxtmc/f?=
 =?us-ascii?Q?u79qSZAX2zVaNGoTszGeRnKOYmc9heZ0eFVuUpT4OsBXtpc35bMAkE5QFwjQ?=
 =?us-ascii?Q?O59soglMHTsN14kv2m5HQuoq/Vt4Q+LgBPFd+iXrDZFcu8bqVuHKVF3dJ9U0?=
 =?us-ascii?Q?GQGTbHlrIHiE2znepXI3AIiTrSTjHQVYDEh7+5Q8X3Kt9zbKuN+cbGIwmJ9O?=
 =?us-ascii?Q?nkEfmM3dFNE4BeN0bUVVMxtf32UFR/4Rl2cUcl+pXEXD557p+pzSZMoaQRYK?=
 =?us-ascii?Q?sjuncVkG7KSjdc5dbsUPvbMSEkDFuMiFZiJ4rZh7yLf1peRt6tIroz+O7eu9?=
 =?us-ascii?Q?SrJ00RETFuDfHn/V3WE4x/vIrsUp3+XCiF3GSydyLU16F3ThoH5aNPdTh2t/?=
 =?us-ascii?Q?DrmV7k5fBgGZNvuSLR3qhfnOCyd2QkzXUmza+DA6z+lMPPS65/C0JaRaXRi2?=
 =?us-ascii?Q?qq8a45vLWFQNw/526YMOhxiKqm+en0M7EBOKJwKleRAn52UFVOqkDks4g7Xz?=
 =?us-ascii?Q?eQMlB/aLL1ykNCOv26eJDegfV7pD6wjHcP/jw/LBEz0iyN7r4mBKYIyl2xEt?=
 =?us-ascii?Q?7mKOvQ4PtgQP3FspNdMGR3xJT+VabVKDwYQxsOI2eEvIN/GmOPG2Dzxvv6xg?=
 =?us-ascii?Q?n/1AddbPVJIhTzbnQ/9SMKoRYqygwY9YBClonmF6TVdFGk6XDMqfc2n8iaHj?=
 =?us-ascii?Q?gzau0RJZDMw959rpmPZgZt1Z8hO/UY5kzg8Y8APuPjqcoIEM5LHSagB1WL/v?=
 =?us-ascii?Q?Rf49FiZ2P4rOm42YTthLlj7VYrgZjd8aBzDdi7MPzLZ4b0/SH9UhYlmg/5rp?=
 =?us-ascii?Q?UV+HvZZnlnsyqMTjnhRbEMX3vZWFtZx5El+KLnjOZ7zW4RS44w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rrtt2kW6eKiBJyORAmgiKKfHqqFuc5pxVGH6kpsEHMZLNN1hB671EJac1JNZ?=
 =?us-ascii?Q?31VUXyEStTebWTv/5YWJ7zcOBhFG5MX0bY/qDHLgyFOsezOJSQ0bI20t7Zch?=
 =?us-ascii?Q?vDyjCkG+CxaaVYPvkhe3b1+eatCkSlKrJxNAi0k9Mq8Ln4Cp5PC8kBIvMd6A?=
 =?us-ascii?Q?VQIR0odb8WY35CrrF9RYucrK0SGdGj8iRxpmDv2BDCxsCtLhqfMqxrC8n017?=
 =?us-ascii?Q?qyhxCSm1bmyM25FbbR2tI218YRX+StflguDwf2VUG7oKpesxhx9GfftDSKqN?=
 =?us-ascii?Q?cnjoBfKyURN/qpwnrx+uG4Es/59E3V+mNl9b6wAtm85QVVQLkiLyFKdbWFPE?=
 =?us-ascii?Q?Onfn75QOZc2R+bNyMpc/cpQOC9NGH+pjBOYQp+PmSVVEyIcykdKGnIqxmcju?=
 =?us-ascii?Q?uJj7QUhqiiFnC32cq3Y58XOVNV3GkDdaCfSd2wHI3PQCeaYWq2hH5RKQKv33?=
 =?us-ascii?Q?lvpoWvvcldQ3zWePBof6BAUXlcoYuVs9mlHj7t5s9WGQbD17YtxucNEu4IDU?=
 =?us-ascii?Q?s4CY6hgqYBFVwUwj9kzYir4gb+565ESo3B7BledJ2iI05FJssM7A9GfpjbiK?=
 =?us-ascii?Q?WgW9K5WMYM3PZECnAtrWHgf3KcAxECGqCtqpyFeM46Hql7JMNLILYuLS4SYN?=
 =?us-ascii?Q?6gwYuw7CLdYxr0qK4/BC3Axns5mevwuDH+VDkpws9QhnbRUuv0Dk5XKvzuqq?=
 =?us-ascii?Q?CMSlNhor7YMfkXHw4hHkmCtjzPjhifYwu+kkI35rGxAiZp2WeCvGmEbsiezi?=
 =?us-ascii?Q?oiewBXWOo/EHt98aQXBhltTEbK2YmKCHdW8Ff7VLc0YYEuShkKq7suBE2BFE?=
 =?us-ascii?Q?kZAsT3b6icP9E0qLtJCgIDv9aTZMu90m4TK4kboHeK7xsaS04xZ2h3lFkjLL?=
 =?us-ascii?Q?ffXYCleyQ8vE8qtDPs8ex81sU0ojEK7APmAh6aC5fEdEs0eKGZ8BcfBkDSSc?=
 =?us-ascii?Q?VAXbK2d0shzaKzsZY/oQOa1G22mQd2IcZGEHo+8x75JoYMtzNWTLnwbumrhs?=
 =?us-ascii?Q?M7SQJa7TjjjEUwm+IYvIUHTUhJb6MF6viGsBlwDEVMXyzJb8QDAuaf757AM2?=
 =?us-ascii?Q?+s6UT6O2vzQ1tHsZ4TYcWgQmnvGxKFjz1gLU/GxcZwmemnRqHGsnIPOur6Yd?=
 =?us-ascii?Q?gx/NYs/nW3LQmlYymG8wF6GkDiX0XkhfmoSTMCYkX4EvgOQEh1rWQSLBiZQU?=
 =?us-ascii?Q?J3b7VVvlIFUa8Ns5rHPKdXJ6zHoW22HT4FICYOp72ZvXW2VPUHG837r860hD?=
 =?us-ascii?Q?gPNT+SG/q2D10CaUzamrMvfR+jf/POcOFYIV9ZdiMen78RbZjzfRjEXXh96t?=
 =?us-ascii?Q?WwljXjl0u+WPDda1Lw0b7EDmcn6yvLBrpPZ7FherTWRfQ/YBWHNzGtlRfUUc?=
 =?us-ascii?Q?k0CNmBukfGSnPtdlCD9zi7vAVNwyVx7GdJ2r8uJFr8GxDt3zoIJhZa9RmQV4?=
 =?us-ascii?Q?auEVWsAR4SozJLelYtbX6LysHN6AwYpOaMsLvkMziPJQ7tUwduJaZ8GKWiO5?=
 =?us-ascii?Q?A1BXrKeknyce6IHLWKa90iqJ/deF0sfMaYCi6DzgHXVAZwvPraHyn0eiBtw2?=
 =?us-ascii?Q?3R1L2WddazA7zxIaoAk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6544b636-2463-4f8f-fd23-08dc9fde2ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:12:59.9060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FO662VuthuuTAzfrANgERXkWewOB855PH4P4ZpvhdJ2Lb2xNm6hBc10xkyjV1s5X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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

[AMD Official Use Only - AMD Internal Distribution Only]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, July 9, 2024 1:56 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 2/2] drm/amdgpu: timely save bad pages to eeprom after=
 gpu
> ras reset is completed
>
> The problem case is as follows:
> 1. GPU A triggers a gpu ras reset, and GPU A drives
>    GPU B to also perform a gpu ras reset.
> 2. After gpu B ras reset started, gpu B queried a DE
>    data. Since the DE data was queried in the ras reset
>    thread instead of the page retirement thread, bad
>    page retirement work would not be triggered. Then
>    even if all gpu resets are completed, the bad pages
>    will be cached in RAM until GPU B's bad page retirement
>    work is triggered again and then saved to eeprom.
>
> This patch can save the bad pages to eeprom in time after gpu ras reset i=
s
> completed.
>
> v2:
>   1. Add the above description to code comments.
>   2. Reuse existing function.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index d923151af752..34226ae010c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2864,8 +2864,12 @@ static void amdgpu_ras_do_page_retirement(struct
> work_struct *work)
>       struct ras_err_data err_data;
>       unsigned long err_cnt;
>
> -     if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
> +     /* If gpu reset is ongoing, delay retiring the bad pages */
> +     if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) {
> +             amdgpu_ras_schedule_retirement_dwork(con,
> +                             AMDGPU_RAS_RETIRE_PAGE_INTERVAL * 3);
>               return;
> +     }
>
>       amdgpu_ras_error_data_init(&err_data);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 0faa21d8a7b4..9dbb13adb661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -29,6 +29,7 @@
>  #include "mp/mp_13_0_6_sh_mask.h"
>
>  #define MAX_ECC_NUM_PER_RETIREMENT  32
> +#define DELAYED_TIME_FOR_GPU_RESET  1000  //ms
>
>  static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *ad=
ev,
>                                           uint32_t node_inst,
> @@ -568,6 +569,23 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>
>       con->umc_ecc_log.de_queried_count++;
>
> +     /* The problem case is as follows:
> +      * 1. GPU A triggers a gpu ras reset, and GPU A drives
> +      *    GPU B to also perform a gpu ras reset.
> +      * 2. After gpu B ras reset started, gpu B queried a DE
> +      *    data. Since the DE data was queried in the ras reset
> +      *    thread instead of the page retirement thread, bad
> +      *    page retirement work would not be triggered. Then
> +      *    even if all gpu resets are completed, the bad pages
> +      *    will be cached in RAM until GPU B's bad page retirement
> +      *    work is triggered again and then saved to eeprom.
> +      * Trigger delayed work to save the bad pages to eeprom in time
> +      * after gpu ras reset is completed.
> +      */
> +     if (amdgpu_ras_in_recovery(adev))
> +             schedule_delayed_work(&con->page_retirement_dwork,
> +                     msecs_to_jiffies(DELAYED_TIME_FOR_GPU_RESET));
> +
>       return 0;
>  }
>
> --
> 2.34.1

