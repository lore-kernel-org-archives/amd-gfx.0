Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F283DC4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 10:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFC7225A9
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 10:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFC7225A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42916E150;
	Mon, 14 Dec 2020 10:13:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07AE6E150
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 10:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTbdm5Px9Se8IXlp3y45il8ImTWUfmKHgXqLLGKz15PRtfCBMfJKAd5MDEOBqlkq5ncpcnnvAEQiRP5WbCXL0jIbE4LiR8VVcaKINTLVoxno80KtwtCV+bDfIwWAQXZIHXyOdloaXZI/Cmzq4V64iD8RgFv8OydsEHWIZkQmN8MvL6971PGz/V7FEMabpHEABvHS/x0A6/goPeevjOeHJ5K3vomj22IBDB+bZSXs/WxY7zsnIe8YLQlGk5yfpqgxInIT51zBQoZ4+EhZZ0k0j7fLJ4mq81HqgzbfpXZhcEpxTY55iApyzeYVvFbZq68xA+5r7lbeleM6Vw/qpGHtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wwO1xEJOm3OnQwvkFv7iiq9Vd89XS9JAXzBLJEkGRU=;
 b=TWZy6NJMV0Xqvu0B9BLBQns5YGmiPMIJgh/HdjlP+Y1QSAQkvx4ojqSTEDNeSERo3DGA0qrcULb7+6i/oo/ZxwBl+QdXUjPBejXbVWHogLw5RL2kX08WvGZApyU1bREo4rVAqzkImihN7xls33m0pz2qHqVARkG5NujEuCAvRD26UilqbxfGDuOPsWBdrwNG4kMRCdKFCVBdVWdEY5kX3ZFbvAKe+rdeOfutDb2//+pe7PtX+obc9QOexJb45ND2L8EYDJxfYk7MbtXKZEynS93BOT9atfoTCfxjl8SGrS+Q11SKFY5khx+S0UTYTwm65LgYz9DfKU24dOMH3x8t3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wwO1xEJOm3OnQwvkFv7iiq9Vd89XS9JAXzBLJEkGRU=;
 b=0Otjyw3EukaeMpd1a/v3EIpmDLBkCtlxxW5n3flkXixNU3H+kzTjbwHVX8Bywlknr/v0U1esQLGyKTh4wN+QHGxjRCiUSJd/hqvYXAImdHhju/Hty4J8DJjQpaZVGb35ukhkgOdsFyNVHmMyvZFnD17Zt2JBuSevv7Isgnh8TH0=
Received: from BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Mon, 14 Dec
 2020 10:13:04 +0000
Received: from BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05]) by BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05%2]) with mapi id 15.20.3632.032; Mon, 14 Dec 2020
 10:13:04 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [v2] drm/amdgpu: skip vram operation for BAMACO runtime
Thread-Topic: [v2] drm/amdgpu: skip vram operation for BAMACO runtime
Thread-Index: AQHW0ewpYqDNPHxF7Uqzi7dztu/J2an2P40w
Date: Mon, 14 Dec 2020 10:13:04 +0000
Message-ID: <BL0PR12MB4913451620379BABACBACF5597C70@BL0PR12MB4913.namprd12.prod.outlook.com>
References: <20201214073744.160679-1-likun.gao@amd.com>
In-Reply-To: <20201214073744.160679-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-14T10:12:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=02718685-a0e1-4aa5-9a33-000050656de7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-14T10:11:40Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f85d402f-51b3-41cd-a9af-0000fb54c929
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-14T10:12:59Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f0f7a10f-2da3-4d06-9892-0000fc9ee3d9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cb92cbb-22b8-48be-9acd-08d8a018d88b
x-ms-traffictypediagnostic: MN2PR12MB4205:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42053573F57EE878C3AFC37F97C70@MN2PR12MB4205.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rfk0ELSq7yL3lbzIcHLd7oGDxcQ34aBTHkJjX1lKpRPM6BHPvrNPhCZPdQVuG5zb4c0uiqiImwWD7MpA7GtISPX5IXZ7k+/3ah6s8zdcVdr5q/7rtdNogTHtIAKI5fLiTUa0b8WHtGdA+GGeznSJ/kuGyRQRdXFpfkbwSES2Cj6Hfr7I5GN+4FZHOktUhb+8/qaSbcJYgM7R04doenQdT/btR/EJ7uNBaaOghXwiECgYZgYSjK8pzAw850wh/WOkFHmlWcI3LF4y8+p9ZgXUkWF1KkU6VndipFddVAOfvwl41goaD9lOW75QcjxhvFYZ5pPJIZX4iKf0uz3Ma/NUn4RgFdW01QDdHTCh3adZYJrmrgFz0jiYLURHmPmKeLxZ4JQoiduwu7nrmdp408r+zw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4913.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(83380400001)(55016002)(5660300002)(7696005)(76116006)(9686003)(30864003)(33656002)(45080400002)(71200400001)(8936002)(508600001)(2906002)(66476007)(110136005)(6506007)(8676002)(54906003)(4326008)(52536014)(66946007)(26005)(66556008)(86362001)(186003)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kBce/5IV4p6JCW8wHzRxYpZj7LDX1s+AmIo6Gqn1dwbzeN439ixclHzDXiFH?=
 =?us-ascii?Q?b3RESvKtwMQY1Jhtl0ws0epDqapsTf6QIgUgGcueCDgD1E1cLtfBwpWc/+7S?=
 =?us-ascii?Q?hU0iJpd761n5jxxCIKylMHvcVzpOO1c0ZC89UAdxBh8fuIFD+lVFXtjNvRoc?=
 =?us-ascii?Q?4/kTtqjCFEXMCqcHR8GqFSnPPK8El0YnHjq4uzLBRLXo1dpiVbM2Sa77r2oU?=
 =?us-ascii?Q?zo+DCMewzLqp4aFrCW6jkXfvdpBffIHNNfvH0bLE+lo1xkW1M1+iZpC843YR?=
 =?us-ascii?Q?TmdJ4whafSLJhMloSWXnwiOjmj99joXgpU9tUm6/Qrd5S8R2l6J4KuDXWgL7?=
 =?us-ascii?Q?axYkXPnXMGVvMqQdooHOvdCe4a66qjUTJzFLK18YbIRPH3Ly+lZtXZ9vzNvG?=
 =?us-ascii?Q?rOZurdj5gsdjB+3SVgzBfPC4jLa8THiPJjLfNnN9aGHsbvx2nG1/apaYSOYT?=
 =?us-ascii?Q?MvA5qZ807vceCTZ30JzK0hCjxnEX2Ge4cIo/g9P5/6pYNDgUk8vVSrWiodwW?=
 =?us-ascii?Q?9ay3CndHG6x2BIRoQprGTVP85rB+ftv9nm2dINH+88DZwIQPC/r9RHqTlJVd?=
 =?us-ascii?Q?Ts4ZmXCQLHFDWlPbOdsWggCTD9zMjQzPn5MkjNT47AfjCNT97VmNUUBiSDT9?=
 =?us-ascii?Q?7kFTup1z+ygicqbaMsqRQa8L25trJtGT2S4mjnpHr6+Bn85PFpKcIcTYrQvj?=
 =?us-ascii?Q?CeBjqVp6w3pL38N4CIfD+a8zGjJRsf2JEMSM6jq4m4lmVL15pOfO6qAXx6KI?=
 =?us-ascii?Q?1WJ0yLB64ZdxrxYnIvRljt+JWRORWGH64eLe0kL35qYnMMx1oAQrlTn22OHS?=
 =?us-ascii?Q?CEpJarhY1CeYBz4YI2V2l7WLtt52qKAxOyd0B6sGhR8EJCz2QImLP/rGmo95?=
 =?us-ascii?Q?MS6cjy4nGn9kHAy54lA2iR45pq6FL7LpQx1M2uP1B0nXWzssIPMQVRMjGcFQ?=
 =?us-ascii?Q?u2yQfSXIyMoWeV2z6u7Re5yTu/xTCPivwlCZDcf96UA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4913.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb92cbb-22b8-48be-9acd-08d8a018d88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 10:13:04.3710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2svsahprIz2vdd4UWyJKWu3EFmYm4n59w5nhUIBEWqToupDLTmhNmxHUb6ntsCjW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Likun
>Gao
>Sent: Monday, December 14, 2020 1:08 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gao, Likun
><Likun.Gao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang,
>Hawking <Hawking.Zhang@amd.com>
>Subject: [v2] drm/amdgpu: skip vram operation for BAMACO runtime
>
>[CAUTION: External Email]
>
>From: Likun Gao <Likun.Gao@amd.com>
>
>Skip vram related operation for bamaco rumtime suspend and resume as
>vram is alive when BAMACO.
>It can save about 32ms when suspend and about 15ms when resume.
>
>v2: add local adev variable for maco enablement which checked by device
>MACO support cap and runtime method parameter to have a mix of devices
>that support different runtime pm modes.
>
>Signed-off-by: Likun Gao <Likun.Gao@amd.com>
>Change-Id: I99cbaf720bfeecdc6682057b238d29c4e41cf155
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 72 +++++++++++--------
> .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  7 +-
> 4 files changed, 56 insertions(+), 33 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>index eed5410947e9..288c41e0b61f 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>@@ -1027,6 +1027,7 @@ struct amdgpu_device {
>        /* enable runtime pm on the device */
>        bool                            runpm;
>        bool                            in_runpm;
>+       bool                            runpm_maco_en;
>
>        bool                            pm_sysfs_en;
>        bool                            ucode_sysfs_en;

Isn't it better to move pm related variables to amdgpu_pm (at least going forward) instead of keeping too many in adev?

>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 0ec7c28c4d5a..0c608b903ec3 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -2464,7 +2464,8 @@ static int amdgpu_device_ip_late_init(struct
>amdgpu_device *adev)
>        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
>        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
>
>-       amdgpu_device_fill_reset_magic(adev);
>+       if (!adev->runpm_maco_en || !adev->in_runpm)
>+               amdgpu_device_fill_reset_magic(adev);
>        r = amdgpu_device_enable_mgpu_fan_boost();
>        if (r)
>@@ -3706,7 +3707,8 @@ int amdgpu_device_suspend(struct drm_device
>*dev, bool fbcon)
>        amdgpu_amdkfd_suspend(adev, !fbcon);
>
>        /* evict vram memory */
>-       amdgpu_bo_evict_vram(adev);
>+       if (!adev->runpm_maco_en || !adev->in_runpm)
>+               amdgpu_bo_evict_vram(adev);
>
>        amdgpu_fence_driver_suspend(adev);
>
>@@ -3718,7 +3720,8 @@ int amdgpu_device_suspend(struct drm_device
>*dev, bool fbcon)
>         * This second call to evict vram is to evict the gart page table
>         * using the CPU.
>         */
>-       amdgpu_bo_evict_vram(adev);
>+       if (!adev->runpm_maco_en || !adev->in_runpm)
>+               amdgpu_bo_evict_vram(adev);
>
>        return 0;
> }
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>index 523d22db094b..a198bc5d6a68 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>@@ -397,10 +397,12 @@ static int psp_tmr_init(struct psp_context *psp)
>                }
>        }
>
>-       pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
>-       ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE,
>+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
>+               pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
>+               ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
>+ PSP_TMR_SIZE,
>                                      AMDGPU_GEM_DOMAIN_VRAM,
>                                      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
>+       }
>
>        return ret;
> }
>@@ -504,8 +506,10 @@ static int psp_tmr_terminate(struct psp_context
>*psp)
>                return ret;
>
>        /* free TMR memory buffer */
>-       pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
>-       amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
>+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
>+               pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
>+               amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr,
>pptr);
>+       }
>
>        return 0;
> }
>@@ -795,9 +799,10 @@ int psp_xgmi_terminate(struct psp_context *psp)
>        psp->xgmi_context.initialized = 0;
>
>        /* free xgmi shared memory */
>-       amdgpu_bo_free_kernel(&psp->xgmi_context.xgmi_shared_bo,
>-                       &psp->xgmi_context.xgmi_shared_mc_addr,
>-                       &psp->xgmi_context.xgmi_shared_buf);
>+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
>+               amdgpu_bo_free_kernel(&psp->xgmi_context.xgmi_shared_bo,
>+                               &psp->xgmi_context.xgmi_shared_mc_addr,
>+                               &psp->xgmi_context.xgmi_shared_buf);
>
>        return 0;
> }
>@@ -812,7 +817,8 @@ int psp_xgmi_initialize(struct psp_context *psp)
>            !psp->adev->psp.ta_xgmi_start_addr)
>                return -ENOENT;
>
>-       if (!psp->xgmi_context.initialized) {
>+       if (!psp->xgmi_context.initialized &&
>+           (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
>                ret = psp_xgmi_init_shared_buf(psp);
>                if (ret)
>                        return ret;
>@@ -1122,9 +1128,10 @@ static int psp_ras_terminate(struct psp_context
>*psp)
>        psp->ras.ras_initialized = false;
>
>        /* free ras shared memory */
>-       amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
>-                       &psp->ras.ras_shared_mc_addr,
>-                       &psp->ras.ras_shared_buf);
>+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
>+               amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
>+                               &psp->ras.ras_shared_mc_addr,
>+                               &psp->ras.ras_shared_buf);
>
>        return 0;
> }
>@@ -1145,7 +1152,8 @@ static int psp_ras_initialize(struct psp_context *psp)
>                return 0;
>        }
>
>-       if (!psp->ras.ras_initialized) {
>+       if (!psp->ras.ras_initialized &&
>+           (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
>                ret = psp_ras_init_shared_buf(psp);
>                if (ret)
>                        return ret;
>@@ -1257,7 +1265,8 @@ static int psp_hdcp_initialize(struct psp_context
>*psp)
>                return 0;
>        }
>
>-       if (!psp->hdcp_context.hdcp_initialized) {
>+       if (!psp->hdcp_context.hdcp_initialized &&
>+           (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
>                ret = psp_hdcp_init_shared_buf(psp);
>                if (ret)
>                        return ret;
>@@ -1325,9 +1334,10 @@ static int psp_hdcp_terminate(struct psp_context
>*psp)
>        psp->hdcp_context.hdcp_initialized = false;
>
>        /* free hdcp shared memory */
>-       amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
>-                             &psp->hdcp_context.hdcp_shared_mc_addr,
>-                             &psp->hdcp_context.hdcp_shared_buf);
>+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
>+               amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
>+                                     &psp->hdcp_context.hdcp_shared_mc_addr,
>+
>+ &psp->hdcp_context.hdcp_shared_buf);
>
>        return 0;
> }
>@@ -1404,7 +1414,8 @@ static int psp_dtm_initialize(struct psp_context
>*psp)
>                return 0;
>        }
>
>-       if (!psp->dtm_context.dtm_initialized) {
>+       if (!psp->dtm_context.dtm_initialized &&
>+           (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
>                ret = psp_dtm_init_shared_buf(psp);
>                if (ret)
>                        return ret;
>@@ -1472,9 +1483,10 @@ static int psp_dtm_terminate(struct psp_context
>*psp)
>        psp->dtm_context.dtm_initialized = false;
>
>        /* free hdcp shared memory */
>-       amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
>-                             &psp->dtm_context.dtm_shared_mc_addr,
>-                             &psp->dtm_context.dtm_shared_buf);
>+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
>+               amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
>+                                     &psp->dtm_context.dtm_shared_mc_addr,
>+                                     &psp->dtm_context.dtm_shared_buf);
>
>        return 0;
> }
>@@ -1563,7 +1575,8 @@ static int psp_rap_initialize(struct psp_context *psp)
>                return 0;
>        }
>
>-       if (!psp->rap_context.rap_initialized) {
>+       if (!psp->rap_context.rap_initialized &&
>+           (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
>                ret = psp_rap_init_shared_buf(psp);
>                if (ret)
>                        return ret;
>@@ -1602,9 +1615,10 @@ static int psp_rap_terminate(struct psp_context
>*psp)
>        psp->rap_context.rap_initialized = false;
>
>        /* free rap shared memory */
>-       amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
>-                             &psp->rap_context.rap_shared_mc_addr,
>-                             &psp->rap_context.rap_shared_buf);
>+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
>+               amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
>+                                     &psp->rap_context.rap_shared_mc_addr,
>+                                     &psp->rap_context.rap_shared_buf);
>
>        return ret;
> }
>@@ -2261,10 +2275,12 @@ static int psp_resume(void *handle)
>
>        DRM_INFO("PSP is resuming...\n");
>
>-       ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
>-       if (ret) {
>-               DRM_ERROR("Failed to process memory training!\n");
>-               return ret;
>+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
>+               ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
>+               if (ret) {
>+                       DRM_ERROR("Failed to process memory training!\n");
>+                       return ret;
>+               }
>        }
>
>        mutex_lock(&adev->firmware.mutex);
>diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>index db0f2a476c23..fc8db9d69817 100644
>--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>@@ -302,9 +302,12 @@ static int
>sienna_cichlid_check_powerplay_table(struct smu_context *smu)
>                table_context->power_play_table;
>        struct smu_baco_context *smu_baco = &smu->smu_baco;
>
>-       if (powerplay_table->platform_caps &
>SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
>-           powerplay_table->platform_caps &
>SMU_11_0_7_PP_PLATFORM_CAP_MACO)
>+       if (powerplay_table->platform_caps &
>+ SMU_11_0_7_PP_PLATFORM_CAP_BACO) {
>                smu_baco->platform_support = true;
>+               if ((powerplay_table->platform_caps &
>SMU_11_0_7_PP_PLATFORM_CAP_MACO) &&
>+                   (amdgpu_runtime_pm == 2))
>+                       smu->adev->runpm_maco_en = true;
>+       }
>

Consider BOCO path also in runtime suspend flow. Also, variable may be named more generic like mem_alive (or similar) for any other suspend/resume that could retain vram - S0ix.

Thanks,
Lijo

>        table_context->thermal_controller_type =
>                powerplay_table->thermal_controller_type;
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C5d3ad5208b1e412a016
>808d8a0034a97%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63743
>5283286148631%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
>QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VmVF
>w6%2FGsbwRUzXHG26DUut7y8MceVib6M7t84mM7YQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
