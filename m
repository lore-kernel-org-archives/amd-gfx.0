Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1399C678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 06:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 412A110E372;
	Thu,  2 Mar 2023 06:34:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A727610E372
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 06:33:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXmP6q8EuQ/G0NLq/1YLIZLtueORv9kIUyFppNFkd23ysULmNVUAf9+FrnpQL12QWuNAWM+YMy4T7H80z825q9v5Yk8jC05rXc/FpApl0A4sn3SAhfWCmxaO03pVtL073NwoCw1+5E+C8BX0zziyz/8GPhCuj3DfZVa1mvN6sZ67iUfMRFUBdioZeHiGBgdKOXOtwisgX1ygQa/5x43Y5nGwkR7K7kxsvKA7jebi3MmzznbYJTJJwzSS11QQypFxFrCl0rsRFjXqbZUdOKDmxRsnGrqUBsidEdq6fmbGkN+3Mmg/HTLUlb6DGVbTkqaGdE8fgMk310p4or18qOPIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC9b8Nh3QZt8okwzeHpe+ykLsaKEnfSHAntCxrf9cfQ=;
 b=mJ1fn3pSgdAvSnzQy+/8YjjLrKwjKsnhlQHZjEOApUK2Dg7fCv7GD8SuzEyuX5AlGDNkcVwvbd7sU4S9E5r9WdM7SmXgcreOAmjR2U46T0F5SJRRhiii1ZPXj+uOM2vPOWSSJcw9AMIfN7830whkWNVFVta0B23Y+5BH2rEm0RwW1LB3I5sd301KkynwhnJx/+cf9oICqp/ozso65xyE0xtCpsooIZ7KnDaIFTem4dMJd9RGudOv/qhqUjU72CXi72ky43J+hZ8vBzGP2h7gv+xKm893uBErCpGVN93/xaI0UDEo8PgVrCY4Pq5rFH3SnkVPKTgYcRZ3YZ6LY5SXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC9b8Nh3QZt8okwzeHpe+ykLsaKEnfSHAntCxrf9cfQ=;
 b=hM1vnaRUdYTosj0TleJVzanecqD4ceRSqvzSTW/8mCViMB4EJs034oXkI0R7ycGt4TbiH7k+KTpyNhfZMmT69GfH/v1EujEnsz6w5j/TPyhevGkc7JDYnjTj8H19GxS+tzaJhoDMuli62+FimVYDp+5w2Sk+ntvEDuplPspyGfs=
Received: from CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 06:33:57 +0000
Received: from CH0PR12MB5251.namprd12.prod.outlook.com
 ([fe80::baa0:21cc:2e5f:4a77]) by CH0PR12MB5251.namprd12.prod.outlook.com
 ([fe80::baa0:21cc:2e5f:4a77%7]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 06:33:57 +0000
From: "Li, Lyndon" <Lyndon.Li@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix call trace warning and hang when removing
 amdgpu device
Thread-Topic: [PATCH] drm/amdgpu: Fix call trace warning and hang when
 removing amdgpu device
Thread-Index: AQHZTMN6otVOJL7cpUeiD/CkB7+R467m9gYAgAAKy0A=
Date: Thu, 2 Mar 2023 06:33:56 +0000
Message-ID: <CH0PR12MB525164038723025A9197F74DE8B29@CH0PR12MB5251.namprd12.prod.outlook.com>
References: <20230302045707.2299-1-Lyndon.Li@amd.com>
 <DM5PR12MB2469D48DA87D7CCC9AEF49B0F1B29@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469D48DA87D7CCC9AEF49B0F1B29@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5251:EE_|SJ2PR12MB8720:EE_
x-ms-office365-filtering-correlation-id: eb613dd3-33e4-4250-a9ab-08db1ae81999
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H6iib7E9W5HyY5T96U6k6eusQZx9UzOP6GUP4nFRa/rLKY8xaQ9gDSYS/UNT4XG2Kp4JSh9JVS8zMiaBlkEUC2v7z7e7R24kou+wufhqkjydoxqsn7HmISawPv4c4q4aQyT3+B0kwQYsdGClKBduL7B6EIScpuNEiUhPOzMK9wkhzGfgUVJ7Iflf2b6BCY0j0EQjFPwmuDsvwon1z2bchE8G9dOUHWgP32lqh+1+Q250nZK7S42y3sPxM20Ij31D5zwSo+AQ4H23BeCLfZoHlSlqherCoNXn56Gj5tT7bwki7c623rkAY9Acat6z9m7ZeIHPz66x1l1GOOsVlxXuIY0TDa+I6Dl+ujKYtOglT2dTlS20LdoU5ZDgxTzEPjINQ2Z5cLekxigdQA3jO9ja1yuk7aZBl8ZmjN/RANlVZHE6YR0eBWXaVE5qOedcDIhDBDV/BDUWSaeAmTo2qCw6I5rda/YEA06zlVVQcsn+n/OdmfqIFjlz5a1ej+wTuu64R8kylQfDt+j5o94VjVrXTf4p2gbWM3mRzFGnEywHwNL72o3OGpFH2MnNruVPr2ZoslkJ0FkOMwXMie8azilKCbXrP9Wwa60Z5hcFoaljV5ZwRKTE2KMHG5qkRuWVvsbSApmKXXf9Sh0xTSQSlRgDJq1cOjY+oCeZNTZ+Axspf2htugcHylSEt3KFPUCb9GGQDzgbSlmHmsFn4bxaMfXjaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5251.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199018)(83380400001)(66946007)(38100700002)(122000001)(5660300002)(478600001)(8936002)(71200400001)(33656002)(86362001)(55016003)(38070700005)(26005)(186003)(9686003)(53546011)(6506007)(8676002)(64756008)(66446008)(66476007)(66556008)(7696005)(2906002)(76116006)(52536014)(316002)(4326008)(41300700001)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CuAABKnECPvCwaB9aWNpl3NobFtme3RwtZdOnDqLMHFtPArUsTvazI9WqsP4?=
 =?us-ascii?Q?DivXdjk1Ttnv2pwZTaSf99FQZkn9HtKVrfDGQT5QY3g2IAmB11eGzav9x+ST?=
 =?us-ascii?Q?3hnPTtILXxnMHPU6eqWZGI+s4WtUrGw8+t6K0aD8vG2i/NqUIypFViQgqeFl?=
 =?us-ascii?Q?34LZP1t0EgtU5lboxfy0bvkHdziL/wSJfS8bAu/AhUj5s5H3lDUCxdAes4sj?=
 =?us-ascii?Q?V6m5Ns4Llf1DQ0aDCklfF4MrCSABciESiw/I9qW8Cci7nDz679pfobQSJx8U?=
 =?us-ascii?Q?KmdlQScCWXPy/uxijecakg2n5W5M8oRqk9Cv6g7V1TTeI3T41vArNRqbVzeK?=
 =?us-ascii?Q?/Vmz0hmZbSfGuhgqebT7OlmG/SJGzs4MQoWPTKX4OIioeja7tGzx/QKsws3e?=
 =?us-ascii?Q?8Xot6t2YKTs7mLR3t6JRlcFSAhTBpGlB0fhAKnAOnOcsp3fbnFN51/UUabSL?=
 =?us-ascii?Q?osVRr3sPje78eJGuBKlhii0KVbJa52dnRst2kmu5hrc7MfRe5/+b43yjfs2j?=
 =?us-ascii?Q?SuSS53YU7h0hZlnQuhEg3wyST/KwBtdrHy0KP0ihAhU7r8Rs4ShcqFyImuvq?=
 =?us-ascii?Q?X6MgVNzzH3yc0OnjEAoyHpY8oWHkuHmXkaPjk29Zv1ktniC3FIeWOE9Tz3Fc?=
 =?us-ascii?Q?azRPgUb/3TOrhvrLA9ISPqTdQknzoq4AcrtDEJyYvhT6bPvOSmUCIaHGAG9y?=
 =?us-ascii?Q?nZYyGdCql0fDBgoVT6WPLgKB9rD7+QE7BXl6e3vpqDEiNpWXOCqV5+olRb8g?=
 =?us-ascii?Q?xs7R3vexI3T6e6mzH7F9pqLrXMLTp22V4wW9oV0Y+9ZjQc7vQkGk8kU/EJz/?=
 =?us-ascii?Q?jOukT+pbKJvur2SCbWJ1n4Jmm/pZgWdCOinIV/jHm3Vc19e5Rdj4Zp7kaH8H?=
 =?us-ascii?Q?cfI7ZZkBZ/W5LXAwSj9SOwBBVn4acZdDjqzVZDRmbBCjXnWZ4cznVwrnmoUz?=
 =?us-ascii?Q?/LYU9KE6sBoxEieDT2ST5JkVV4tzg/2sEUrs35MvPmMuvIKdn0Np1HyLWf75?=
 =?us-ascii?Q?qEAraeiz+2Oz1yYLU19vAGat9PGqA5immQ2JHGH/Cfz2B2tAeP8vFZEVm/US?=
 =?us-ascii?Q?ZtND5iqqvCi083AjhyqnIDBp6Fm3JOks9i5AMcdFxAZzMCQQR1rOt1yCgbCp?=
 =?us-ascii?Q?xju4fQnidCFYNXvw9Vy+zKeqjmd0o/nVgouAjiypfJf/nx7MXxA9XYHhiu7t?=
 =?us-ascii?Q?H9UHNxmo1jg7a7gJkxIoBhkgx9lJ/B76+z3d6hZ5igPQ/uHhRXzhAkgLS+iD?=
 =?us-ascii?Q?53hlP2608BfuCkJgd04gWRFkfchcHuhBpl/eL4rGs3QLFo3fxuGpCz8T5uEp?=
 =?us-ascii?Q?Iwf1C4L7M60+jqR9zzd+e9ad3j9xfXdQaDKAxV6HSjTNLwo4QwFBa6vtOxis?=
 =?us-ascii?Q?2FNqCH4JxWA6t4+65ql+KhENVzwUTxMhVWpGnQXsPg2C8qE20DiVDw73IY53?=
 =?us-ascii?Q?jegIPGINyFxubqcGx3mSstKvQqocqJyBzOoIRaVnk4Yw8aEnlEI6qFePdaeu?=
 =?us-ascii?Q?jI1599BdE3G3jMLbqA+hNnlrwlRxjdyJzTZA9AhJUHVQVGX405qRJom94oAc?=
 =?us-ascii?Q?oIc4ei0WJ3HWu8POsjcuAg0nuK2a86IdesGE0fK6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5251.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb613dd3-33e4-4250-a9ab-08db1ae81999
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 06:33:56.6824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5zmN2cPWW7S4u6us16K0hHBi6P+OLEUbMek8nzXEL00qQ0gaUDEWbiYLs+IiYcZs6632ROkFIAD+z2JYuBo+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sorry, the code base was incorrect.
I just sent out a v2.

Regards,
Lyndon

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Thursday, March 2, 2023 1:28 PM
> To: Li, Lyndon <Lyndon.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Li, Lyndon
> <Lyndon.Li@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Fix call trace warning and hang when
> removing amdgpu device
>=20
> -	    adev->in_suspend || adev->ddev.unplugged)
>=20
> I don't think the code base is correct. Please double check it.
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: lyndonli <Lyndon.Li@amd.com>
> Sent: Thursday, March 2, 2023 12:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Xu,
> Feifei <Feifei.Xu@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix call trace warning and hang when
> removing amdgpu device
>=20
> On GPUs with RAS enabled, below call trace and hang are observed when
> shutting down device.
>=20
> v2: use DRM device unplugged flag instead of shutdown flag as the check t=
o
> prevent memory wipe in shutdown stage.
>=20
> [ +0.000000] RIP: 0010:amdgpu_vram_mgr_fini+0x18d/0x1c0 [amdgpu]
> [ +0.000001] PKRU: 55555554 [ +0.000001] Call Trace:
> [ +0.000001] <TASK>
> [ +0.000002] amdgpu_ttm_fini+0x140/0x1c0 [amdgpu] [ +0.000183]
> amdgpu_bo_fini+0x27/0xa0 [amdgpu] [ +0.000184]
> gmc_v11_0_sw_fini+0x2b/0x40 [amdgpu] [ +0.000163]
> amdgpu_device_fini_sw+0xb6/0x510 [amdgpu] [ +0.000152]
> amdgpu_driver_release_kms+0x16/0x30 [amdgpu] [ +0.000090]
> drm_dev_release+0x28/0x50 [drm] [ +0.000016]
> devm_drm_dev_init_release+0x38/0x60 [drm] [ +0.000011]
> devm_action_release+0x15/0x20 [ +0.000003] release_nodes+0x40/0xc0
> [ +0.000001] devres_release_all+0x9e/0xe0 [ +0.000001]
> device_unbind_cleanup+0x12/0x80 [ +0.000003]
> device_release_driver_internal+0xff/0x160
> [ +0.000001] driver_detach+0x4a/0x90
> [ +0.000001] bus_remove_driver+0x6c/0xf0 [ +0.000001]
> driver_unregister+0x31/0x50 [ +0.000001] pci_unregister_driver+0x40/0x90
> [ +0.000003] amdgpu_exit+0x15/0x120 [amdgpu]
>=20
> Signed-off-by: lyndonli <Lyndon.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index d50f8bfb9be9..5554ff22d724 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1314,7 +1314,7 @@ void amdgpu_bo_release_notify(struct
> ttm_buffer_object *bo)
>=20
>  	if (!bo->resource || bo->resource->mem_type !=3D TTM_PL_VRAM ||
>  	    !(abo->flags &
> AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE) ||
> -	    adev->in_suspend || adev->ddev.unplugged)
> +	    adev->in_suspend ||
> drm_dev_is_unplugged(adev_to_drm(adev)))
>  		return;
>=20
>  	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
> --
> 2.34.1

