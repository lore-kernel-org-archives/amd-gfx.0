Return-Path: <SRS0=sMqH=7L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC567C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 02:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BDE2075F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 02:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Sd3pSdTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BDE2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9946E856;
	Fri, 29 May 2020 02:59:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF23D6E235
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 02:59:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDWSTpUvrVVvF7XRxQJ8x/7VS3aDaiiklW0NeNDXxmtVyzgZ0cMhwWVCeg7NGPUT0J1a+/PmnrJ2MPy/jc5WdasREtEg97+SQK3MjVKh1J/1/kVfquQKfRawstiJU6ucFhwK6TjK18jn2uhJ9sF3etnfpGJSMMp6esTAI1WUOG89cZpcuARNWLGTrGs/BvfSnN9M3RoZT4Zupp4o7OIPP7FQFag6eyIuBTqoA6AE/vEsI8o5IwlKEi+oXORTnFiZq1endoYODkYBxGVhhzvnAf4Jib9OV9+LgeXwrhSgc0OtMjQgbSAWiVhkP0vkP+OJT1XeK9DBZ+f1VBG7iu1ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0O4DLsECMZ7AQkaBPvf7lXjQB/Vgu/WTWg/xyU2QeI=;
 b=Oo+My97EbquPsvp+Ld+rdX429+9rQMytjEHNC5FebkDDSML0aR+tTgtv6qqf2yPr6lmk54Ts8c5CtAixJtjOZgbJLZeKHXzcPJlJEjLqPOm2DUdOZYBT9GmPpfuhZLWXKaXk57qtg4xiXQBdhQ5ZruClbymf/SS4glwBsaUqnNgM1qKsYi20bDcP5lpPxlxZf/KiXYy14YBdxYjhVboU7OYDNXaoM2C6AtjVvYSDDlQXbXc67rAzDEnjmMCeInE99D3V+C4nWNFEYxgBpkv+KPbboD4V2Un3V1WlC5V4MGkLxLVketORkUlEjyDc9NSvLZPxdCVICD1DRDx0f3qM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0O4DLsECMZ7AQkaBPvf7lXjQB/Vgu/WTWg/xyU2QeI=;
 b=Sd3pSdTWxlMChWsrlH2kxiSdMkjNqPA4msZbq8cwuGzPqDs2dennjktQe3pDWcv/HtpvMClr+xd+uwEJsjciBaR7pNjuAvzn8LYbdSZeo+NHWVSv4WGUKD5Dx9WHpvzrq0iswraNBRi3aNoJq1Lg4DAccFDUJvWnVs25Bi7AzNU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Fri, 29 May 2020 02:59:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3021.030; Fri, 29 May 2020
 02:59:06 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: don't bail for in_suspend
Thread-Topic: [PATCH] drm/amdgpu/pm: don't bail for in_suspend
Thread-Index: AQHWNHmR6t5UYbRuJUitBrpgGP4ZS6i9ds0AgADqXGA=
Date: Fri, 29 May 2020 02:59:06 +0000
Message-ID: <DM6PR12MB2619135BFD78B0DA3E031CF9E48F0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200527225158.27756-1-alexander.deucher@amd.com>
 <CADnq5_PO-SFFSpz=V3JsGPqunAs+Na9pUwy22Bj+cX3N3Sv48A@mail.gmail.com>
In-Reply-To: <CADnq5_PO-SFFSpz=V3JsGPqunAs+Na9pUwy22Bj+cX3N3Sv48A@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e501d7c7-d16b-469c-b05d-0000f603193e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-29T02:58:41Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 822f502a-32c8-4104-889c-08d8037c408a
x-ms-traffictypediagnostic: DM6PR12MB4450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4450B99367330080A7AD261FE48F0@DM6PR12MB4450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ndp1w1PgF9Iv0rN9HsU0CMgZfEWYK6vdyzxEcqV0BgvJb7SJL5xahh80nXzRiidsJ9POoDI9L+0/zZW2JkQuLx3n/MMkXqnB/DKva2uK3QCELxGksG3zYnNCD0pnhwscIKFpqpIB8OQgS0/kaDDu6fTMgVKlSVYQ8qlgNoXCQzpdcbrNOIftoW+3Rh/Q4GPUDK+V2kN2a4wrqxeVW60yUR3XD+GuYo1zjPNc0WkMYfFxXAFvQ4vzy1nF7v64tBYqPPt+uaoprqIgxDBkDKyXwHhTVOtCANpIa0qnfnTn4L64tnfqY2l3rcQEzDLSEKxqSipd6TbOQrZIitZt79WDF0qVJ1Xend/TPD3vye3ZtKQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(83380400001)(5660300002)(33656002)(9686003)(55016002)(26005)(30864003)(71200400001)(66476007)(64756008)(76116006)(66556008)(52536014)(186003)(66946007)(66446008)(110136005)(8936002)(4326008)(53546011)(6506007)(7696005)(86362001)(316002)(2906002)(45080400002)(478600001)(966005)(8676002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: E6pOGilURzhsETUhARaszTPybSasON7xIlPuZxaLbks4U+kRWrULmrKmBpAOae2UZUCReR/CdbKRThF4pi0qIv0e5wHtCea3zCM2BnodCJx+w1bwmm590F1BaXjkoidoE8ySoU/N6Fv4k97Xda5bZkqAWpu+dM2/Xa69o+hewEW+YS1UtnPQEAzzhCOWlQlElamG5+ARbfRbZ9gxQ3vGeTbq9W9IvpNWqKx4Rbeuup5iWVn4sAnQPhurG4Ky2izCl8Vk6/hSVOwyQsWpVvLApB8rKBynAeXLcrZXGTwqZ+UPp0JZOvjiKNEnCcL98M3DFqCzn39ZrR1ggZQE3FEUhiMh05vdMLEF8V0HU25X0xAcnceM+ftPS13dtJw0xpvWuiveUV9wqzGjHu4rwOgiCFyelo3W/j+rh0wNSy/NCCVRQSkaP3eFthBxtHX/NJ54J8WcJ2aMyk6UnJ9qf9LZc65r5t/bu9acvlj7MsWfrYDwjo6cgMvox0UFNkRCpW7e
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822f502a-32c8-4104-889c-08d8037c408a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 02:59:06.4874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvsWaudNu+iLiMAUzA21nUBahyxA8a3Bsa7tK6bM9Y0py7IRTFeQRZCXC7w7XzFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, May 28, 2020 9:00 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/pm: don't bail for in_suspend

Ping?

On Wed, May 27, 2020 at 6:52 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Otherwise we disable sysfs/debugfs access with runtime pm.
>
> Fixes: f7c8d853b029df ("drm/amdgpu/pm: return an error during GPU
> reset or suspend")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 114
> ++++++++++++-------------
>  1 file changed, 57 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 808884aaf36d..775e389c9a13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -163,7 +163,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>         enum amd_pm_state_type pm;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -199,7 +199,7 @@
> static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>         enum amd_pm_state_type  state;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (strncmp("battery", buf, strlen("battery")) == 0) @@ -303,7
> +303,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>         enum amd_dpm_forced_level level = 0xff;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -343,7 +343,7 @@
> static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>         enum amd_dpm_forced_level current_level = 0xff;
>         int ret = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (strncmp("low", buf, strlen("low")) == 0) { @@ -445,7
> +445,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>         struct pp_states_info data;
>         int i, buf_len, ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -487,7 +487,7 @@
> static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>         enum amd_pm_state_type pm = 0;
>         int i = 0, ret = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -526,7 +526,7 @@
> static ssize_t amdgpu_get_pp_force_state(struct device *dev,
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = ddev->dev_private;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (adev->pp_force_state_enabled) @@ -546,7 +546,7 @@ static
> ssize_t amdgpu_set_pp_force_state(struct device *dev,
>         unsigned long idx;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (strlen(buf) == 1)
> @@ -604,7 +604,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>         char *table = NULL;
>         int size, ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -646,7 +646,7 @@
> static ssize_t amdgpu_set_pp_table(struct device *dev,
>         struct amdgpu_device *adev = ddev->dev_private;
>         int ret = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -751,7 +751,7 @@
> static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>         const char delimiter[3] = {' ', '\n', '\0'};
>         uint32_t type;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (count > 127)
> @@ -843,7 +843,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -895,7 +895,7 @@
> static ssize_t amdgpu_set_pp_features(struct device *dev,
>         uint64_t featuremask;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = kstrtou64(buf, 0, &featuremask); @@ -938,7 +938,7 @@
> static ssize_t amdgpu_get_pp_features(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -997,7 +997,7 @@
> static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -1063,7 +1063,7 @@
> static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
>         int ret;
>         uint32_t mask = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask); @@ -1097,7 +1097,7
> @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -1127,7 +1127,7 @@
> static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
>         uint32_t mask = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask); @@ -1161,7 +1161,7
> @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -1191,7 +1191,7 @@
> static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
>         int ret;
>         uint32_t mask = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask); @@ -1227,7 +1227,7
> @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -1257,7 +1257,7 @@
> static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
>         int ret;
>         uint32_t mask = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask); @@ -1293,7 +1293,7
> @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -1323,7 +1323,7 @@
> static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
>         int ret;
>         uint32_t mask = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask); @@ -1359,7 +1359,7
> @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -1389,7 +1389,7 @@
> static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
>         int ret;
>         uint32_t mask = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask); @@ -1425,7 +1425,7
> @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>         uint32_t value = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -1453,7 +1453,7 @@
> static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
>         int ret;
>         long int value;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = kstrtol(buf, 0, &value); @@ -1494,7 +1494,7 @@ static
> ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>         uint32_t value = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -1522,7 +1522,7 @@
> static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
>         int ret;
>         long int value;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = kstrtol(buf, 0, &value); @@ -1583,7 +1583,7 @@ static
> ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev); @@ -1621,7 +1621,7 @@
> static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>         long int profile_mode = 0;
>         const char delimiter[3] = {' ', '\n', '\0'};
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         tmp[0] = *(buf);
> @@ -1683,7 +1683,7 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
>         struct amdgpu_device *adev = ddev->dev_private;
>         int r, value, size = sizeof(value);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(ddev->dev); @@ -1719,7 +1719,7 @@
> static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
>         struct amdgpu_device *adev = ddev->dev_private;
>         int r, value, size = sizeof(value);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(ddev->dev); @@ -1760,7 +1760,7 @@
> static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>         uint64_t count0 = 0, count1 = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (adev->flags & AMD_IS_APU)
> @@ -1799,7 +1799,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = ddev->dev_private;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (adev->unique_id)
> @@ -1996,7 +1996,7 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
>         int channel = to_sensor_dev_attr(attr)->index;
>         int r, temp = 0, size = sizeof(temp);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (channel >= PP_TEMP_MAX)
> @@ -2130,7 +2130,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>         u32 pwm_mode = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2164,7 +2164,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>         int err, ret;
>         int value;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = kstrtoint(buf, 10, &value); @@ -2216,7 +2216,7 @@ static
> ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>         u32 value;
>         u32 pwm_mode;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2268,7 +2268,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>         int err;
>         u32 speed = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2301,7 +2301,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>         int err;
>         u32 speed = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2333,7 +2333,7 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
>         u32 size = sizeof(min_rpm);
>         int r;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2361,7 +2361,7 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
>         u32 size = sizeof(max_rpm);
>         int r;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2388,7 +2388,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>         int err;
>         u32 rpm = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2420,7 +2420,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>         u32 value;
>         u32 pwm_mode;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2469,7 +2469,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>         u32 pwm_mode = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2504,7 +2504,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>         int value;
>         u32 pwm_mode;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = kstrtoint(buf, 10, &value); @@ -2547,7 +2547,7 @@ static
> ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
>         u32 vddgfx;
>         int r, size = sizeof(vddgfx);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2582,7 +2582,7 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
>         u32 vddnb;
>         int r, size = sizeof(vddnb);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         /* only APUs have vddnb */
> @@ -2622,7 +2622,7 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
>         int r, size = sizeof(u32);
>         unsigned uw;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2661,7 +2661,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
>         ssize_t size;
>         int r;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2693,7 +2693,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
>         ssize_t size;
>         int r;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2726,7 +2726,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>         int err;
>         u32 value;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (amdgpu_sriov_vf(adev))
> @@ -2767,7 +2767,7 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
>         uint32_t sclk;
>         int r, size = sizeof(sclk);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2802,7 +2802,7 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
>         uint32_t mclk;
>         int r, size = sizeof(mclk);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -3665,7 +3665,7 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
>         u32 flags = 0;
>         int r;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(dev->dev);
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C97b6a87de2fd4bc7ed6308d803070c10%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637262676586697822&amp;sdata=8V2SIQumUqRoJX%2FFwH8%2FS9x6XEy3ykBFJHm%2B9%2Fa2kpg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
