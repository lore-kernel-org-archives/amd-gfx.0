Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF845EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 20:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F15DC10E084;
	Tue, 18 Jul 2023 20:04:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31E710E084
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 20:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xai9x85K2CutEwykVMQJxiIOndczajwJj2WAsQhIBDdLA7K85j7N8I0yYEjHeH3OG3sfMsCii6zqPGjrivgXQv92s7TOM8fMIZXhLjUmYUQSfi5eD6tA/s3AOAdsEN3a5caVx0Pj8zBVUd5/khcafOc99gKkgl0X80QlwJW0L0qJneVyamHDMfaKsbblAKPxUfb5E3p2G3kTxBRBrvXT6saDle51XV+W13Ofc3TvQ1nCxTq6RxTC4XysAbmNPG/83LqLs4gm2qthElQj9NKh7dqie9dVVtwBK52+NWQ2eNKU74sDqTP6zeq91fc36ChC6z2T80GxSCUmnb63sEHPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T9rKKgU/1UUFn4Danruoe+dKUeDh0SXyYWkdXs9laM=;
 b=YeZlPWGqLcm6fn1g2ijFol36hfzO25QSN55J4WcNe+trthkwsV/plHLdnhcviLkVjZwgYOcV92tY6ECq4Q2B6FXN9yK0RDxQsK42YEn+aIXlLuLZ3Jt26HG1Qz2OPoAwO23X606m3IkguKIW6azRdyTrach5zLa8/2lgHglTivVqbB2ORCijZifLrzNeQZimhZtOoFOe2p9J5YpCFeJLGdmGMGYrd+P0AUSYcy+9oB+rjLUwjnpOOJYNRKmdhtFyq/nA3u8gHiA3mlAdinNZKkrPufqjJhvvLlGnTxNX3lSDBF9SOc2cDaczF0FqLxXR0xOoUwpEyyZFW/Pg0WAg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T9rKKgU/1UUFn4Danruoe+dKUeDh0SXyYWkdXs9laM=;
 b=PZRgIuERi3UqoQG/AzmCOjVLb86l0WPEhcviOO2MJ/WlAYlySn9Vi+YxI9egpxIg+wsx8cBO3bDRVth7xE9Q5rzfMqJhIItS4EBbGSX8IbQSTTLZaHPj0KiYRv61xQ6nyhkTIKW0MLOrXfAOjUo+pZIv+cP6aRhptZwHX/cXyy4=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB5014.namprd12.prod.outlook.com (2603:10b6:a03:1c4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 20:04:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 20:04:07 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Fix an error handling mistake in psp_sw_init()
Thread-Topic: [PATCH] drm/amd: Fix an error handling mistake in psp_sw_init()
Thread-Index: AQHZtbcAL92IgNN6JEuNFRJfXKZzvK+/+nwQ
Date: Tue, 18 Jul 2023 20:04:07 +0000
Message-ID: <MN0PR12MB61013749AE68692816B82F19E238A@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230713051459.74044-1-mario.limonciello@amd.com>
In-Reply-To: <20230713051459.74044-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=997a5984-4e47-4138-8193-6c3ea9f5023a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-18T20:03:52Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|BY5PR12MB5014:EE_
x-ms-office365-filtering-correlation-id: 25d431ae-d02e-4d03-c39f-08db87ca24ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: voOR2fqyhriQn55rj6VzS7IAG9wXeAtLvktr0RtxwUorvUzNNkmIglPKA6ZrnrAYv+anRDVDL4WYcpyg/tonpUYR68+oVtWHdCqvuSiy8omhxMBnPouwYREIjAfBa3mEjBB1KeBYCkQBQ4pr5+d7mArt2bVvQPPDQctZdm4i4p0vToKiQ7+ZCqQIXr+kjvoZJd77y6uDt9MBGt+OAbSDJohBDLwFG+XrBj1l7tyGwTSN+QvKu5pmiPF2oopliJ/fmbWMomVJU6/9zIS0W11ONSruSCxx45cLtu8vgrMU1vEPcMANcPXTR4kXHsyVF9EQhWMVvg8xCH/2TOt5ivIzZj4ScvYZ5cgK4BWncI0F2oEE27P9gNdIuC4mtaSj2TdXJD3ych/OPF4svGDymSOsKR0wWjuA3P760M7NRZFtGLeot0FY+bM6TsnN62FOQogWxgEfc4F55m2ZoIGjHJCwCiHuMaoqWjK7mr3wcjhstbk6Hbw5Lrf4+tTGA6l7M5IOlJmjeQrUdvawoB/xcI8IV2t3+Tdu6+wF8aB+xyxRpb7Y/kncVFYm+9BHyPR7quL0ABlqNkRE9QHMcNEdxzRHFAKhjgO0611K3axOwI/IfyeKJgSrME8KY0WVS4geENdd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(64756008)(478600001)(71200400001)(7696005)(9686003)(6506007)(186003)(53546011)(26005)(2906002)(6916009)(8936002)(66476007)(76116006)(66556008)(52536014)(66946007)(8676002)(5660300002)(316002)(66446008)(38100700002)(122000001)(41300700001)(86362001)(38070700005)(83380400001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DqQOSH6vyn1JBkbGAszHa5x1646PhgvLBlHenVxa2jnDrjr+0ZY7mcaAqgjd?=
 =?us-ascii?Q?5B86OD36GlJAjBFBgTsXzdw6INgY9lBbowX9gz7Tsfnl7BYTmaev7I04X1yH?=
 =?us-ascii?Q?nYrr72AbpdgGsKdoK3P7UNwrq7s/dbUEcukVSKyc86I8tMgty7ot2FHOenYg?=
 =?us-ascii?Q?E92UiN85HuSBCVSHoQ/6Hne9wy/PuS5YzQG/GXMP/lN1EYgrUsMmeFkbv3FW?=
 =?us-ascii?Q?HpR8EzI2PEqHTc2qnHZhAwn8kn9UjPn7WBx7igkNOEbdm8pyqN5lXgD7G+oq?=
 =?us-ascii?Q?0uf0HjGSSnpFkaO5Xl4HDTMLZSuvHW7XqS2HFN4UWqDG0FvhgFt/quiXzGI1?=
 =?us-ascii?Q?vqLxgd6amkv+uoE+zbRuXQ1+lPJIGO9OBuD8YzuxVVtBCwx/qE/W+q8CLJCz?=
 =?us-ascii?Q?uiJKLedgjo0WsqtoESTwHpCowi6ltz8PCVxwG8UaM5iM30/buSOCX6G3uX+Q?=
 =?us-ascii?Q?Ztz8Lec46K8JB9q2HNt/RdEX3/Hk+SekXhts5FRvuRA2BHYTvAGa+tMYvcc4?=
 =?us-ascii?Q?wqdlokWs2UshTJWR81lRZbXnGbhNQrBiVTPNKK2CQF8RyfPf5sMJ/gjILhb3?=
 =?us-ascii?Q?NXePN3kY8xqE/qFz+6euPlw8EQcyoMCpjtRGpcIWscMOYWiYGghpUHy1x8Wo?=
 =?us-ascii?Q?XWr+E6KRE0pRWPmItbdFvsOHxEqln5rmQPXl0HP+lKgLH/Ekdhhm44jVayp7?=
 =?us-ascii?Q?AHLUoF0k5v7YYwvk7GtwnhFSGg5whWCSMXjoQnt0kKyJC9ShFsUCtAR7coXg?=
 =?us-ascii?Q?g7yP6nS6k+6TA1zmSdVtB6Fu2UkS0vomBiHHYut0YUYg4i7djJpX6g35ixXJ?=
 =?us-ascii?Q?VapzGZXkXYw3rWmLjJReZrhxIsWFW+Cz2OCMO3nilx5J1l03TtBV1dEUNLsw?=
 =?us-ascii?Q?aKcp0DWlm092LTU5XBcMU3yMmqUJ8Joy1+sKlZXEqU9mmYlZg4iLmt+CCiaa?=
 =?us-ascii?Q?axR6LWjB9D36tZQOAThJaXdNgJfpejQb9W+Pv3w+B9vaMWj6/KYknnNa5EB+?=
 =?us-ascii?Q?gnjdv8m3+i21mLvSKlVXdbQnSqVgqYZlCYurTSoXLYuctZbqQwx1HTp6PO09?=
 =?us-ascii?Q?5cgz0t6moIGdvjjw88sBPMeExnBTNsewp+x5LgYL/VgFSRY8fIoXf7nhEKMi?=
 =?us-ascii?Q?ahgckTWUOT1GiUuv3XJogTMC1q4zAUrywZoZBkkN9BZO6T8hYu9POCiQuAh3?=
 =?us-ascii?Q?SYCsMEnk9ys8ANThIsBECgkHBWdMPM3DkySQmxDOEUh/zu6tFowanJfILXLy?=
 =?us-ascii?Q?Yb9FR5l6HqedlWC6mDjzWXAosWB8hulFAYbtnPusbaOGT4YkA92SG0Zkpkki?=
 =?us-ascii?Q?FCE9ua6yg2bvuMX4fUrJW4CdjjNTGik794PebhmzxEYuBzecnOk5Vv74xsnu?=
 =?us-ascii?Q?zQCbtcrsDBGw+9dJaADGRf/Ss12iEnbbjCvBF3ROHQ8L7M1dLhblX1CKO+OF?=
 =?us-ascii?Q?l1ott4U93Dso9IwgkPHgpEhdfyES6c2l6N5xtwcUFpEuSPYSfg/EQLKf0ZS4?=
 =?us-ascii?Q?yHzJb3ActH/lj8VecrcIO7qri2VQTm4xZH/QrOjSumwbbcv3pcRU+LQldGIO?=
 =?us-ascii?Q?Sk7SWl6urUbvytZk+jk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d431ae-d02e-4d03-c39f-08db87ca24ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 20:04:07.1103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJxyBJfLshowjrXAfJ0rBBKspZPGvnF4FWobkvBc9AduW52eXfloJgU+eyks9oB5JJSUneBENXPOhH7UTi89Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5014
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

[Public]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Thursday, July 13, 2023 00:15
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH] drm/amd: Fix an error handling mistake in psp_sw_init()
>
> If the second call to amdgpu_bo_create_kernel() fails, the memory
> allocated from the first call should be cleared.  If the third call
> fails, the memory from the second call should be cleared.
>
> Fixes: b95b5391684b ("drm/amdgpu/psp: move PSP memory alloc from
> hw_init to sw_init")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Ping on this one.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 1b4d5f04d968..6ffc1a640d2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -491,11 +491,11 @@ static int psp_sw_init(void *handle)
>       return 0;
>
>  failed2:
> -     amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> -                           &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
> -failed1:
>       amdgpu_bo_free_kernel(&psp->fence_buf_bo,
>                             &psp->fence_buf_mc_addr, &psp->fence_buf);
> +failed1:
> +     amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> +                           &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
>       return ret;
>  }
>
> --
> 2.34.1

