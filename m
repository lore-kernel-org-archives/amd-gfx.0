Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB54CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 00:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8252E64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 00:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8252E64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 144896E83D;
	Fri, 19 Feb 2021 00:57:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 266786E83D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 00:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADMHFFnrzfoK5Pv5/N/leZfQdAjpBJC7eRsVInQIZ+BaROW0KJpyvh+JPnfQXGpg7pZlNm7AolvueCXt0tr9HYyLKMXIPK8EyrGmkIvKPaIOY6azEd6SsQwH6VbN+h2G5/COIRgse7C0ucudlTvxunYyyueawut481ZApqNZATsWlrLffO44sG8AQ1ky7E3XFKhs5IPs/PkApHYSsvVGmqGYcUtmmOsTSjTTuAkxRVU11uMjP9T1xb8VQQxXb8cNDkOJYlB3I2nDq0/3PQNLXtOtchVHq47azq+nr1d0iPtuYZYbpF1Q21+dDZmrx7Rb6Tz+nOLy1AfBvLy9sZIndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8503H6VpL3aagNh0zKjbpIVZ5KYyyh+XceZVAPUpOoQ=;
 b=XplccM3W43OJABIVIeLfJOZcpSQ2Kx4ygGNOEwKB6rPWEaU9rpshFMXt4Ab2aUNCvNh0DhFlfHUHRB5842wCZS/vnLH0hR/sBpu+ZBKs2gfzvqS5zyXL9k4INeVVyHkI9U5oiFdWsDEY5ok+tfn4KatOaBzuNsuBzDRr2cJvuvltCJdXbmWyzNBZV2YyOUy21RaSIUVcOOq6Q+uNxLttOb5dSfvlwM0deA/v76ZB+zJ4S8gp6uJEn48Vz15b0s6ka0mFnOfTbcoqYPR9SSbdDIXpUSyey5qTeu6gUbfBDA0RK9DsPpSr5QX0xLrMwe3aykD2Nq0uQb2LQBI/NqkfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8503H6VpL3aagNh0zKjbpIVZ5KYyyh+XceZVAPUpOoQ=;
 b=krlT8zzzfIwFJtxjRX/qH+BnjA2JfHS04Sd3nf5ocrpHPDWH9BmntuJgjvH3x5SPmkqd4VwBaPlTfDeuEP2BAlRilHJUQXrYcJyD/6ZDJUFi5bcu/AVjPL1el3O3qjTKXqFGxLmJ72uilfvEceTn0k/h1k2FJk+7Zs6p4DvsPiM=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4001.namprd12.prod.outlook.com (2603:10b6:a03:1ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 00:57:33 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6daf:7d00:b03b:8a16]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6daf:7d00:b03b:8a16%4]) with mapi id 15.20.3846.039; Fri, 19 Feb 2021
 00:57:33 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix shutdown with s0ix
Thread-Topic: [PATCH] drm/amdgpu: fix shutdown with s0ix
Thread-Index: AQHXBhkL5bJVrhr3g0KrWTdyeHzbkapepVwg
Date: Fri, 19 Feb 2021 00:57:32 +0000
Message-ID: <BYAPR12MB3238E2E495055E7D37EFD284FB849@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210218171054.3039369-1-alexander.deucher@amd.com>
In-Reply-To: <20210218171054.3039369-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d83544af-119d-4894-a47b-d032162e4725;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-19T00:47:20Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64065ab4-6e39-4d92-97e4-08d8d4715714
x-ms-traffictypediagnostic: BY5PR12MB4001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4001D3A77E7227785C7F0678FB849@BY5PR12MB4001.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Inbt7AH6pbCMvBOOTCeMGdQcqaPX7oR9YbNoCSVcyQPDGMXzT7jab0xaC8spMJoOXIwu9hF3Z5ZBhRKSo6d/TIU806kWX5KARA1FPk6trQhGE7b3eQH0mOw2jVI/BZQUkHpdim3nXgLsR/h/INwJ5NT2x1cbnOWRW2wXQ8TqdeC/dNSrfcBeMDN92B3KwgL19m7XxnZoC1xAPrbYY7KD0avOvujORnNNJRecTJi9CnVpJEWB1UW7O3uMwmlFcysQH1jP5gXst5EJA8bVFCOEZ5BTTAPW26+z+fvZ7lm5KhLFZu7sU8f4O2Wk4dhOBhfx/VSAXLQp+GcsD+nl0jN0uyiRnjuuh/cF8jbs2r0fJrjO5GL4EE1PRQDWiPiRetvm/atZiL9bqOVCh1Mtg/NfkwbqSGPj24vO1kCVzEuqq+hQEyev4iECe0o44fsIvxf2efH9kuSIXxdGYYMBgPzbiZmIKjGmHwXWmtr8IwLVqBl94gRHh1KbEw3jHdI36cf+afsdboRCRQqyz24bA8CymuGRNvIv9KSDq2IOh+/zC9b9RDlOFd1BTdaozgZ68seBSU8bv3u83LAhSZL9h41e80I1FscBIVD9prDul4f5UC6lpd4CsqD5Ei/BmwZPTW4dbbXZ1E3WZswDYQHqCo6aXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(45080400002)(66476007)(66946007)(71200400001)(4326008)(26005)(64756008)(7696005)(76116006)(186003)(66556008)(53546011)(83380400001)(5660300002)(55016002)(478600001)(316002)(33656002)(966005)(110136005)(9686003)(8936002)(86362001)(52536014)(6506007)(8676002)(66446008)(2906002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kdFmLHo6LN2ElZp1tEyGJM+KhXgzNUV6Q+42nNrHvMEBJ7FkHtynCk0XW9fu?=
 =?us-ascii?Q?nmchWYjDYehRO6fVW2r9cQQGapB70br8hGScrvWR8F8UYojq0G1AMq8J4ffN?=
 =?us-ascii?Q?f70URs3McqY/cnDLzlw/DER+/ik+W1E5IrTGqhzG/be01AFAVoBUu53HytNI?=
 =?us-ascii?Q?SL4P59TaL+ryMfUqDiTI0K2NzTELQ0Z1hS3jOO5vL+Vei8xcWdCSuHRAv5Li?=
 =?us-ascii?Q?63nq+Ki3nyN0VWHrt3dX12cuYbhSUniPQAmLlT0pu3cBW7ijucvLS9zOdco0?=
 =?us-ascii?Q?VuilZ66/uzweazVOqnMCdeXrJpeCATb9FoF4+Inill3TV3GYABlLJvWF6zPO?=
 =?us-ascii?Q?gjqqUXStYkdcA67CdpcRX40yGxI+cnCMTMIcAFOHZZ7rPi6QRW3dFanIR/xi?=
 =?us-ascii?Q?cPYN6fSMWcvwhsx1SdItv8Nc2iajjw0kh3aVvBHAYYnPEgI8Ru6ddeqisF9O?=
 =?us-ascii?Q?Wccj292xEKJaPOoDcNJXCwUHVcEmXjw+yJD5Eq3cOc8LKUSX6HWo3xzD0277?=
 =?us-ascii?Q?YyCCftJYsdBSzAVwN90gYl02ZVKZ5+ZEBJ07fBfcHnDKmxgPZQhkh86hNvsV?=
 =?us-ascii?Q?RVJA1nQRu8GYIYSeandPowEqbJyzKHB+Q1sVZPB6duP18hvUZwa38FOLhatU?=
 =?us-ascii?Q?BZ/v7gnQb/bl0tRHsCx0tOi+WSlprYWvqZdiAGEmH6Xz+Uy/e5KkBJYV/2Nk?=
 =?us-ascii?Q?affxZBTMmsF0lAcDlMXGC8IveMueLgy1PwA2NSmOT6FZBNIF/F3AO53FRixy?=
 =?us-ascii?Q?EVZOJY71j83UIVHvcRBk3Sgo2e38CMXZQt3D9b079GS7cK1t2YR7xdXcrXhJ?=
 =?us-ascii?Q?ef68cLnYcIrghWMzywix39plViO6LoSKJpKGxGtPQ6nMi3DLf916553jroG+?=
 =?us-ascii?Q?3RM/Dpd5HVT5rWG1TM/t64JybaQl6zqyLBjOi+Clki6nyk3M07tAiusumM1z?=
 =?us-ascii?Q?HGCx4PHBKJPtkGI7l+BjZwuwhQBsnSNUol25GT5/vuTt5oaaAsO4uG4yt2Af?=
 =?us-ascii?Q?FSw3okb2HZt/9NzHsgjtsHttm++G2pbncjz+qNbv85RiOYfaFKgI13uztU22?=
 =?us-ascii?Q?PChtt9lSZknQNUwjoJ0KOjtdt1g+bvYHFOzDud3y8pGXCLdGi5Gh8BI/F8m+?=
 =?us-ascii?Q?6yvtYKnGNW6sFAjFr9012duXaPLyTJLs2b3fIYxK/kQlfqeTZHvBWFS4Hbv6?=
 =?us-ascii?Q?Pqr54CQlNVkzAwkMKnQ3DzNMgLJCsqx09hs+M0a8lwgaIu0A8x05lnBNgvsY?=
 =?us-ascii?Q?5Ap6SlrhV6I/pYr6BBq9EdlRK9jWYctMnlaL/qgCWuM/cJe+eWpCqAF/1sCA?=
 =?us-ascii?Q?ujWuZcCCQZMvqr81csILz6Q7?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64065ab4-6e39-4d92-97e4-08d8d4715714
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 00:57:32.9036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKMzdMyWotz9BZ+2vRmTNf7AlUR46cNEqQM786mMk4rJsdyHt/AqsZsXbGakgUFI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4001
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks Alex fix, I also have drafted the fix locally for the poweroff and shutdown on the s0ix enablement.
Besides the shutdown opt fix for the reboot process and we also need a similarity for the poweroff opt.

So how about create a new combination flag for legacy PM poweroff() and shutdown() opt?

Thanks,
Prike
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, February 19, 2021 1:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: fix shutdown with s0ix
>
> For shutdown needs to be handled differently and s0ix.  Add a new flag to
> shutdown and use it to adjust behavior appropriately.
>
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1499&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C247
> 59f57e2644f26deaf08d8d4302cc3%7C3dd8961fe4884e608e11a82d994e183d
> %7C0%7C0%7C637492650673813454%7CUnknown%7CTWFpbGZsb3d8eyJWI
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> 000&amp;sdata=I0rH%2FFt2cs%2BdNwvNdqWKPE%2B3bOosUyBodViUsEwb
> 6tE%3D&amp;reserved=0
> Fixes: 628c36d7b238e2 ("drm/amdgpu: update amdgpu device
> suspend/resume sequence for s0i3 support")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index da258331e86b..7f5500d8e8f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1018,6 +1018,7 @@ struct amdgpu_device {
>  /* s3/s4 mask */
>  bool                            in_suspend;
>  boolin_hibernate;
> +boolin_shutdown;
>
>  atomic_t in_gpu_reset;
>  enum pp_mp1_state               mp1_state;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7052dc35d278..ecd0201050ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2678,7 +2678,8 @@ static int
> amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)  {
>  int i, r;
>
> -if (!amdgpu_acpi_is_s0ix_supported(adev) ||
> amdgpu_in_reset(adev)) {
> +if (adev->in_shutdown ||
> +    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
> {
>  amdgpu_device_set_pg_state(adev,
> AMD_PG_STATE_UNGATE);
>  amdgpu_device_set_cg_state(adev,
> AMD_CG_STATE_UNGATE);
>  }
> @@ -3741,7 +3742,8 @@ int amdgpu_device_suspend(struct drm_device
> *dev, bool fbcon)
>
>  amdgpu_fence_driver_suspend(adev);
>
> -if (!amdgpu_acpi_is_s0ix_supported(adev) ||
> amdgpu_in_reset(adev))
> +if (adev->in_shutdown ||
> +    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
>  r = amdgpu_device_ip_suspend_phase2(adev);
>  else
>  amdgpu_gfx_state_change_set(adev,
> sGpuChangeState_D3Entry); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2ddaa72437e3..b44358e8dc5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1265,6 +1265,7 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>  if (amdgpu_ras_intr_triggered())
>  return;
>
> +adev->in_shutdown = true;
>  /* if we are running in a VM, make sure the device
>   * torn down properly on reboot/shutdown.
>   * unfortunately we can't detect certain @@ -1274,6 +1275,7 @@
> amdgpu_pci_shutdown(struct pci_dev *pdev)
>  adev->mp1_state = PP_MP1_STATE_UNLOAD;
>  amdgpu_device_ip_suspend(adev);
>  adev->mp1_state = PP_MP1_STATE_NONE;
> +adev->in_shutdown = false;
>  }
>
>  static int amdgpu_pmops_prepare(struct device *dev)
> --
> 2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
