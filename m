Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA72CCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 04:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D6910E370;
	Mon, 13 Oct 2025 04:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wW64/RjU";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010037.outbound.protection.outlook.com
 [52.101.193.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E0B10E370
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 04:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oE5M5ijWFYZCfWWxOhc/hLivofJe3ib8X0b4xSn5N+7a2KNXbuDsUqx3DI4lAgkgHA147L0g8BjDKjHc6ONvIYQq3DKxxbxmO2gyGcImpKFOCg3aK8bTB9pyJVq9iri79F+VG8Q6IqHX0HWpi/sKFGrogYqDX7F7wBxcbsL9c/sEaHl70Wx7lIM9zLZKp96JgrdXLq7ajdcGSzsNVfWwCiJl4QpB8ATqXYjEVKkanh53preLzo1MhFTdUhUnw+Zb5u8NcdZyed1/LINfayVnme4MLPFLR8Ofbg60gJVFz3uIKxWjo62pXvXR8dS7yGUBXfxfrgNsvchfBJawzLWNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ2BHQh0EAIvVEw8ifRYfH+4MQa4mG3YzZgmUd6oFs4=;
 b=xl8Cls2rfSH37wMwrWd4r5B7gcuYxmuSfVkvr8ZFYBPuypAdLFZD62jTRTjiWbdhnARYXYj5MnLYJ3ZMTug5tiGq6RgZfh9w6xULpC+kbbdelyXe2SzqJ6LH/pgWrrdTOTJUVc4OPOA0IFAeGbgO+9wZWbqjNi2Kfc8yjgpwBbG3K8nkTVMJ9a2o4Pyqzi8HFFyJltpPQv8hGeoF0CYfAgkSvI9kM+O04cKgppiYFc6DQUCkE2kRLHzh3sWXFaHUl6hRbIyVhbHHnS5eoruHzRyWQIIEmA+FQ8d4iHu/cvzauCzar5+v2LuWWZq1l7fPSmH+tuiwjkwpenIX5bb55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ2BHQh0EAIvVEw8ifRYfH+4MQa4mG3YzZgmUd6oFs4=;
 b=wW64/RjUCVj9Z1oxQujF4B7veBwMrQ+Und1dM9tu2eGNRNbgMLwS+I1ScjVz0Btj0Dtc8pq4LVlL0satlu6dQDpu813YSmZtQZhNupfsqGqX0Cbloe2DuSK6qJk+n3AuazzpBgx9Dmz3y0TUvfqsVFzhxq28mmS+J45Wu9qCQLU=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 04:57:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 04:57:54 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>
Subject: RE: [PATCH v3 2/6] drm/amdgpu: Add SRIOV crit_region_version support
Thread-Topic: [PATCH v3 2/6] drm/amdgpu: Add SRIOV crit_region_version support
Thread-Index: AQHcOhaM3G7WgP7FFkWWY4jsrTl9h7S/h12g
Date: Mon, 13 Oct 2025 04:57:54 +0000
Message-ID: <DS0PR12MB7804CB04F0C4907A4626737E97EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251010184849.9701-1-yunru.pan@amd.com>
 <20251010184849.9701-2-yunru.pan@amd.com>
In-Reply-To: <20251010184849.9701-2-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T04:56:56.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|DS7PR12MB5837:EE_
x-ms-office365-filtering-correlation-id: 15490bb9-282c-4f6f-30da-08de0a1511cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?l+qfWfrkZssLkbxRxbJc46ivrGYM0U0b7Nfs5WvqkodyL208aLJESxmH4KLg?=
 =?us-ascii?Q?HuRmda0mjKIsXyX/2R509UIM5v7f92a/nu73svrWC8v6agr5Ls1sRGi4Yi1l?=
 =?us-ascii?Q?iPaGBOhlfUBW0UYabH4BLUmgDzTcYYZNSRmWhHzHCOCznCBdj1JupSoVC2Pr?=
 =?us-ascii?Q?83YXUKcHrlzJhs8f1B50dMc4Jgot4Gu4YbEZwcHB/h6YHlTzW+4sv4YogTMe?=
 =?us-ascii?Q?qk8Umu3R0+XsNFLH+7DC1StatJl3EbbXo/6mCcPrLAHO0vlkAbgNx2BuSrea?=
 =?us-ascii?Q?pBlqGqUrAX/FMFHWX1oUcIHYx7l+JUpTa4s7UYck0QkelYP9i/1eAQb6WTZD?=
 =?us-ascii?Q?/ZCz+wJD5tAxur+eY8JhWjWD2Ph7QPG0TNCahIfqVY7sL0qC//sXaelF3J30?=
 =?us-ascii?Q?Y74rui+/KCaVoiIezK6OwfvIgasP/ErN2C2jW4OlsN5PdEXdM+KaB50WPAFF?=
 =?us-ascii?Q?IA57E58EHmOFnRisekalmXpSyxjSY7G7XOF5Fm+9VuTTtdSzMRIlXpg/p0cq?=
 =?us-ascii?Q?rwRrPUup++zEwRYlgnTGwXy22yPTB6GhZ6dwr+LXn4TjE9pajNejp3W9IING?=
 =?us-ascii?Q?awj+sGy53D/vqVHQlrVhAHt+4hxQni+o5vUurUGdRhDjhilPG1w5n5Vlrf2j?=
 =?us-ascii?Q?nOFGF2tzLl8juGfPNSPj0JxDmdDhwpsWR3rf1pb4ibwKGxv2q7eDZfXi4yhf?=
 =?us-ascii?Q?kZoZ/TwzqxypQfnWkdlzrpPvitoJTJ29cs2Difjz7modkyUZdOqmWxEneteX?=
 =?us-ascii?Q?/oD3b+bC+TQQRmDgSnghRLbE0DuG4GOO/+YhM6s1jzpkUH3xgMxOL0xpdAK6?=
 =?us-ascii?Q?c+jh0lG5hXkzrRj6UXuXgMPsa+Z2lY6RZ+xuVFx7La6VcK/3Njo6be94KZSb?=
 =?us-ascii?Q?5FewQW9qOofZV7Uk3l1SQrec4DN0DqIvQY0j/+iqMnynZnloC6n5u6y8G0cD?=
 =?us-ascii?Q?46axbrUsikMNYI+L7Cv02SxrQUCCEZwmPn5IOvNUz6v5s06kNDxZlCytWf60?=
 =?us-ascii?Q?KiGLxiJ94PQm8ay9bJlq0YbR3cRSJTbS1nk7ijHhV4HBqn7GLGYaWUHr+GIU?=
 =?us-ascii?Q?2Bz3MYsVjYYq+F2+pcfiWzk9EYBXQaU7GTNM7sa8mNRaDfY9k497sQv4R3hq?=
 =?us-ascii?Q?BdNbPgijZKxOu8CgbDdynVwQFgWOC2eM2oB3Urif7+fk3LbGbWJMPXGMt1eD?=
 =?us-ascii?Q?JpP2IJntJrbW7YJ2E2qDVxqGBbk1kgRz2Fq99LDtej42pZqawtGT/xrICGUl?=
 =?us-ascii?Q?2HVzhtA4o6BCTo+XNWmVapBNtAhaVM7jpMYPPo7GjQOdZ79ZL5yg5vKyHNoq?=
 =?us-ascii?Q?5OTimcsRSftG8pAy24QXaNLocoQu8oBzp57wjVTtBIsfqC1fAP9vKSZV7jbP?=
 =?us-ascii?Q?Hv7pRsLBAyAvy9IVNqlvIGFMQdIlGVNydWnJ6TQOlEx5hFCJv5TuOyED9Bva?=
 =?us-ascii?Q?oZNeRVH6DvYCu2Q9e+gja6unbFIQLsGiJFJW4ATB6Dr0kKpeDnLNhMJvEyYq?=
 =?us-ascii?Q?m0JbAnsiGPxvNGSVuUTfnyOxDJ9a6gLmD2LJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O+JCO1Wg35G9FbyyKiCu9p2u458cjpuTp72nvwK7CxtqvKbQ3MRZDxIrCS59?=
 =?us-ascii?Q?5NZF4gzvXWZSfWe4uiJYA/cQBbaNUq/e95uahbLWDOJtN5woZgVtrRUA9z+J?=
 =?us-ascii?Q?lUfZLA4WWXgjfkZcMlY9sWJigCPl9R6YyEBiwOBTe6jkD7Nrczq1Qgu273XU?=
 =?us-ascii?Q?W8N1FKXWYHIau4nS+LP3FZJWvc1FP5yFL+61N2ohH2APJ82DDExLn1VAJIjq?=
 =?us-ascii?Q?zlWrfJqwG3VzYOGMKQ5JPZGFAVzwty8kFn3PIM3Ha2PsvrDuVlikYDEqlp50?=
 =?us-ascii?Q?n9ai0KdXsW77qq5mSHTWhD9X1dqpcNd9DbCg/Jr/0Efq3phU1XZJ+hmuCByW?=
 =?us-ascii?Q?SNxMSm6T8S0AtxYn9DXV0NOgJcNf6tGsj2yWaOHkcGXNpHEqQaYxUlaSjaG2?=
 =?us-ascii?Q?9jk2CnSrMHUM7NaDLg+FxuV8SVnkKFwe9CD3xD7nUG7k0gN6ycMepPmUn5o0?=
 =?us-ascii?Q?74kvPsc/eLLXMFepgw69wPXR1bfT4wFfeCFL8uoNgDQfMiY1AKTqeVZrjoKD?=
 =?us-ascii?Q?tbZUCV82OSe315LswNbSAIJf/VwzVmN3ECDPP8X64CFvaokdkDrkOCcY7/3+?=
 =?us-ascii?Q?ksXhq5Ol1PG6RfhBgD+vqq7wMDKsgKe5NaaJAMVz5XzUvv1EiBktvBs4tHzx?=
 =?us-ascii?Q?zHx0pLR+LsIwQwSMiwxG5qVf8MzGU9/mwNUtfZMoAQCUgcQm3Zcbuhlw45oj?=
 =?us-ascii?Q?LgDE8xjsI6oM+K+//GFa5CD/DSbKyYbpMcGy/w2uCbZaG82tWIB4cqobEwP3?=
 =?us-ascii?Q?Vc293ARHpbsJtBOg+0MldaAt6DB7uLGW/Cxs+0lsVenhpe3tLZQCFkafywsN?=
 =?us-ascii?Q?WVv3dUp5TG95fVgcLLOVN8lqvIXOiJgdXLsaB9t+IquTqStyVoe3Wk4KV/GV?=
 =?us-ascii?Q?gq2VUbgCiN+C+/1T87ndaKAF10Ir3269uDO189i/y41nv/pdGqHAFYtIzc8L?=
 =?us-ascii?Q?7PFeGcy9J+kTMhnci6FUBJErGXaUQtosE0weaKSo1X9ZW3hRmEliU1GUFFm5?=
 =?us-ascii?Q?0ICLwbU4SsMQjHBJt+06h5tkDUsTMvu9Csrmol+mt3UUx8IZS7j0IWA/8dRy?=
 =?us-ascii?Q?ClrM6lZssmYLQyP/izxC7KlxYqh4whIl1ZaoBq4/T/e5WSf1eETHKLwVtGOB?=
 =?us-ascii?Q?PYpsX/AxQSRWWjlj1IwdQfArCNh2x0qslcq/VeHlFrVIPBsze/yPSfhCbGW3?=
 =?us-ascii?Q?LSZUvwXDaYCnvW4ycUuHzsnvtPGWWgqPhrVTGjrj+xmDxIHXrMTmyPGCk0+U?=
 =?us-ascii?Q?NXOUszF+Qr571WIOKPMNCa3S1yWcTjop7ZFWuOpyS/uULli1LzECWPRa8ton?=
 =?us-ascii?Q?9n+Gx+TBE60dLICToJEjhWKMxMui9sVkG5ezlIWNe/Vh3G3HlHTtOROdpUDA?=
 =?us-ascii?Q?O1k4FLLRAkuzvV0X/DWEnMkh5pM6DtsSsCvqSUe/CQwCdexsF0S5VJiBShem?=
 =?us-ascii?Q?HvGZiut2zabxpWRI04fJOP5uUbZArS1FMS6nQqwki2+oFJjFN54CVdyjIsUZ?=
 =?us-ascii?Q?UO6AANmJJgmHJl9F60Osm9VNtPgnDBf2WDuMflB1yju6cNZxvyvmy5amSIAC?=
 =?us-ascii?Q?7QsOhmhOSf4kUOvYPgM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15490bb9-282c-4f6f-30da-08de0a1511cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 04:57:54.2110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPlcAnTWT/69xGoNrZAxI04DKehAikAgpAxP1XJSUQ5ZcOtvynUTkY5/FC1ZDiMF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
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

>-----Original Message-----
>From: Pan, Ellen <Yunru.Pan@amd.com>
>Sent: Saturday, October 11, 2025 12:19 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Chan, Hing
>Pong <Jeffrey.Chan@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
>Subject: [PATCH v3 2/6] drm/amdgpu: Add SRIOV crit_region_version support
>
>1. Added enum amd_sriov_crit_region_version to support multi versions 2.
>Added logic in SRIOV mailbox to regonize crit_region version during
>   req_gpu_init_data
>
>Signed-off-by: Ellen Pan <yunru.pan@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  3 ++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  8 +++++++
> drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 +++++
> drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c       | 23 ++++++++++++++-------
> 4 files changed, 31 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>index e95adf0407a0..3a6b0e1084d7 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>@@ -150,7 +150,8 @@ void amdgpu_virt_request_init_data(struct
>amdgpu_device *adev)
>               virt->ops->req_init_data(adev);
>
>       if (adev->virt.req_init_data_ver > 0)
>-              DRM_INFO("host supports REQ_INIT_DATA handshake\n");
>+              DRM_INFO("host supports REQ_INIT_DATA handshake of
>critical_region_version %d\n",
>+                               adev->virt.req_init_data_ver);
[lijo]

Please use dev_info here.

Thanks,
Lijo

>       else
>               DRM_WARN("host doesn't support REQ_INIT_DATA
>handshake\n");  } diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>index d1172c8e58c4..36247a160aa6 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>@@ -262,6 +262,11 @@ struct amdgpu_virt_ras {
>
> DECLARE_ATTR_CAP_CLASS(amdgpu_virt, AMDGPU_VIRT_CAPS_LIST);
>
>+struct amdgpu_virt_region {
>+      uint32_t offset;
>+      uint32_t size_kb;
>+};
>+
> /* GPU virtualization */
> struct amdgpu_virt {
>       uint32_t                        caps;
>@@ -289,6 +294,9 @@ struct amdgpu_virt {
>       bool ras_init_done;
>       uint32_t reg_access;
>
>+      /* dynamic(v2) critical regions */
>+      struct amdgpu_virt_region init_data_header;
>+
>       /* vf2pf message */
>       struct delayed_work vf2pf_work;
>       uint32_t vf2pf_update_interval_ms;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>index 3b35154e2df6..b53caab5b706 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>@@ -65,6 +65,11 @@
>       (AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 +
>AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1 + \
>        AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
>
>+enum amd_sriov_crit_region_version {
>+      GPU_CRIT_REGION_V1 =3D 1,
>+      GPU_CRIT_REGION_V2 =3D 2,
>+};
>+
> /*
>  * PF2VF history log:
>  * v1 defined in amdgim
>diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>index e5282a5d05d9..cd5b2f07edb8 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>@@ -222,12 +222,20 @@ static int
>xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
>                               adev->virt.req_init_data_ver =3D 0;
>               } else {
>                       if (req =3D=3D IDH_REQ_GPU_INIT_DATA) {
>-                              adev->virt.req_init_data_ver =3D
>-
>       RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1);
>-
>-                              /* assume V1 in case host doesn't set versi=
on
>number */
>-                              if (adev->virt.req_init_data_ver < 1)
>-                                      adev->virt.req_init_data_ver =3D 1;
>+                              switch
>(RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1)) {
>+                              case GPU_CRIT_REGION_V2:
>+                                      adev->virt.req_init_data_ver =3D
>GPU_CRIT_REGION_V2;
>+                                      adev->virt.init_data_header.offset =
=3D
>+
>       RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
>+                                      adev->virt.init_data_header.size_kb=
 =3D
>+
>       RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW3);
>+                                      break;
>+                              default:
>+                                      adev->virt.req_init_data_ver =3D
>GPU_CRIT_REGION_V1;
>+                                      adev->virt.init_data_header.offset =
=3D -1;
>+                                      adev->virt.init_data_header.size_kb=
 =3D
>0;
>+                                      break;
>+                              }
>                       }
>               }
>
>@@ -285,7 +293,8 @@ static int xgpu_nv_release_full_gpu_access(struct
>amdgpu_device *adev,
>
> static int xgpu_nv_request_init_data(struct amdgpu_device *adev)  {
>-      return xgpu_nv_send_access_requests(adev,
>IDH_REQ_GPU_INIT_DATA);
>+      return xgpu_nv_send_access_requests_with_param(adev,
>IDH_REQ_GPU_INIT_DATA,
>+                      0, GPU_CRIT_REGION_V2, 0);
> }
>
> static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,
>--
>2.34.1

