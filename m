Return-Path: <SRS0=XVZG=2T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ECCC2D0C0
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Dec 2019 06:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB08208C4
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Dec 2019 06:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oU0upPbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB08208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3496A89E3B;
	Sun, 29 Dec 2019 06:43:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB5189E3B
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Dec 2019 06:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLFSMSQcnJ9PGVyG7Cqn6jSDsNkValuXejGCASXuINaLvmj1jIxUMGI6cYWn5D3DmKf38SZpyenggsvXsWevPc9ItEOybMzSGGCEjz8JDLiiXT1vzCTGNQyIUHB5bTzk1uX1iKoDZaulsROnqvsByxQv1oqXD5oMAj80xuxYLvNPY9P3jjQ1+mc1brA1XE/2Y8ALXEhpd/zBdqfAvDCTuu5tbLuI6m6HGkZhrpxc/DLdog/SiN+XuFlN32gshG+byRYUEuTCJ1b/7jdTKfwJG7xdVV+neUgADNAiKDbZLXDVFDrWF2sWfx8Og50A9vMG5hjSFshRfia5Kt0uoehosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYjUZt2vP4OkI5tTRK7oc/jiuhw0tlciS9gxI+NvFKg=;
 b=PtoE7UAZdzv4BAbAyk2Mx3GlxbKm6GMOSazQi4KVlB+I6uJsgghLVuvWK2sAepaFczz7bYW7TaWrf05PZCpyU0TJXLEWHdNv7zHPjgJtiwshP1MRE3pWvPOmHTwEEQ/Isv+GNMnBpgLXOa2q/i3vM1Gs02RyXu9s8WGQui89m3fKXuIT/bY2DesDBSr0rxhahlJrQ+JBOXRJbCKn5SfDR0gNRccBSbq+YsG7H8LK9gLgJw7Ak0qwB7EpeeonHvbawXiSQ1N3iie57KvyYon/Ckb5jyO5nVSXR7q5SPAyGidBvVpKfozPCLyyYZzhF7a2Qbqx1ZiqEXe+CethzXgWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYjUZt2vP4OkI5tTRK7oc/jiuhw0tlciS9gxI+NvFKg=;
 b=oU0upPbjUMhbZwBnmtOAUEC4qofCEavtKtHHLh2pJ57UHkQbDiFuoeLEuAp9vRZc3ETy5yd0icd75JQrNtexD4tlrAhK9Alf0OXy7ejYbBrHFvkw8iXRisGNZntCwHEPQEWd+9oaxpqYh9cEEjM41vR25McXDih6FIYhu5cCpq8=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1455.namprd12.prod.outlook.com (10.172.56.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Sun, 29 Dec 2019 06:43:23 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::2d1b:f19e:cdc7:8b4c]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::2d1b:f19e:cdc7:8b4c%10]) with mapi id 15.20.2581.007; Sun, 29 Dec
 2019 06:43:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: handle mp1 state properly on suspend or
 device removal
Thread-Topic: [PATCH 1/2] drm/amdgpu: handle mp1 state properly on suspend or
 device removal
Thread-Index: AQHVu8QIQWStR++cak2FwzPMpvRjZKfQrYMw
Date: Sun, 29 Dec 2019 06:43:23 +0000
Message-ID: <MWHPR12MB13581836D6852083025FDD34F7240@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191226081041.8747-1-evan.quan@amd.com>
In-Reply-To: <20191226081041.8747-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-12-29T06:38:53Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ad5783af-14ab-4252-b282-0000f1bbbdb5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2019-12-29T06:45:32Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: b71b4d4a-f633-439e-932f-0000af79206f
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7274516f-66c9-494e-5bf3-08d78c2a6678
x-ms-traffictypediagnostic: MWHPR12MB1455:|MWHPR12MB1455:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1455BD0AE6E260DF70BB6AB5F7240@MWHPR12MB1455.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:65;
x-forefront-prvs: 0266491E90
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39840400004)(136003)(366004)(189003)(199004)(13464003)(76116006)(8936002)(8676002)(7696005)(66476007)(66446008)(66946007)(64756008)(66556008)(26005)(81166006)(81156014)(55016002)(86362001)(71200400001)(110136005)(5660300002)(15650500001)(186003)(316002)(52536014)(478600001)(9686003)(6506007)(53546011)(2906002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1455;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5BAYHOCnDksGqbfd+JOGUXUAvdW7y1hD4A76RYyZpxWJlx275AR2xiL5trc4kD5MvuDFN/rUx1FhIuSvGPIdAAj+2uPu0ehE4mT4Gm9ffe89s9NkFKGVlJtH3f2DcZSCDabQUezE6I2VlmDI6SvEICwq+42/CiH+Y03D/ihNxlNOfRpO/Amf6HTmEqTOJXAOu3QBCnMTxWRLuK82k5CYBRCOKm9iPovyholoZj9moPMry5a/nE4iPYD2C5PV/Y2prbTjnaauOwPMHVw5N9DwxRedWH5LwU/D4+/Uiwezi5tgdGfnWEuVxz1jku+cJhgti7mZ07o1CW7KQZqRcNzPZPqYeqU1INyeVbL2ruCksbk7QZSy1ht/lTjSPuIpeXEYRLTfWblN2OHZz4nJNWWvqGcwZGbwDfHtJqdlVN8R/pr+QQBKieJXrODavwaaEnYyNJo/emLiUqmOGWL+fAXLy9FevrBiPsRD1TSFGdAMsERowGLb2SMivWhCSMPj6Mb
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7274516f-66c9-494e-5bf3-08d78c2a6678
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2019 06:43:23.0863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpZ57pZIAhqtXpW2Ump4/1zi00XvTOutZw+1j2WwaGGFqoyLKo3huxAQvXYtVq/L6Zb6zYYxuTjND8zmh976EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1455
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Thursday, December 26, 2019 3:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: handle mp1 state properly on suspend or
> device removal
> 
> Set mp1 state properly for non gpu reset cases.
> 
> Change-Id: I2a007910da6b5e2d1f8915d17827621ebd2e8c59
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 16 ++++++++++++++--
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 13 +++++++++++++
>  3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d36245321cb0..739ff4e4e845 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1089,6 +1089,7 @@ static int amdgpu_device_check_arguments(struct
> amdgpu_device *adev)  static void amdgpu_switcheroo_set_state(struct
> pci_dev *pdev, enum vga_switcheroo_state state)  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = dev->dev_private;
>  	int r;
> 
>  	if (amdgpu_device_supports_boco(dev) && state ==
> VGA_SWITCHEROO_OFF) @@ -1112,7 +1113,9 @@ static void
> amdgpu_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
>  		pr_info("amdgpu: switched off\n");
>  		drm_kms_helper_poll_disable(dev);
>  		dev->switch_power_state =
> DRM_SWITCH_POWER_CHANGING;
> +		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
>  		amdgpu_device_suspend(dev, true);
> +		adev->mp1_state = PP_MP1_STATE_NONE;
>  		pci_save_state(dev->pdev);
>  		/* Shut down the device */
>  		pci_disable_device(dev->pdev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 61dc26515c7e..13278f1c1b14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1157,8 +1157,14 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
> static int amdgpu_pmops_suspend(struct device *dev)  {
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_dev->dev_private;
> +	int r;
> +
> +	adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
> +	r = amdgpu_device_suspend(drm_dev, true);
> +	adev->mp1_state = PP_MP1_STATE_NONE;
> 
> -	return amdgpu_device_suspend(drm_dev, true);
> +	return r;
>  }
> 
>  static int amdgpu_pmops_resume(struct device *dev) @@ -1198,8 +1204,14
> @@ static int amdgpu_pmops_thaw(struct device *dev)  static int
> amdgpu_pmops_poweroff(struct device *dev)  {
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_dev->dev_private;
> +	int r;
> +
> +	adev->mp1_state = PP_MP1_STATE_SHUTDOWN;

Should this be STATE_UNLOAD for poweroff?

> +	r = amdgpu_device_suspend(drm_dev, true);
> +	adev->mp1_state = PP_MP1_STATE_NONE;
> 
> -	return amdgpu_device_suspend(drm_dev, true);
> +	return r;
>  }
> 
>  static int amdgpu_pmops_restore(struct device *dev) diff --git
> a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index d07c4f2ccee7..4a7fb6b15635 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1370,6 +1370,18 @@ int smu_reset(struct smu_context *smu)
>  	return ret;
>  }
> 
> +void smu_late_fini(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct smu_context *smu = &adev->smu;
> +
> +	/*
> +	 * Put the mp1 in the right state.
> +	 * This gets called on driver unloading.
> +	 */
> +	smu_send_smc_msg(smu, SMU_MSG_PrepareMp1ForShutdown); }
> +

Do we need something similar for the powerplay code?  E.g., pp_late_fini()?  Also shouldn't this be adev->mp1_state or prepare for unload rather than hardcoding it to prepare for shutdown?

Alex

>  static int smu_suspend(void *handle)
>  {
>  	int ret;
> @@ -1931,6 +1943,7 @@ const struct amd_ip_funcs smu_ip_funcs = {
>  	.sw_fini = smu_sw_fini,
>  	.hw_init = smu_hw_init,
>  	.hw_fini = smu_hw_fini,
> +	.late_fini = smu_late_fini,
>  	.suspend = smu_suspend,
>  	.resume = smu_resume,
>  	.is_idle = NULL,
> --
> 2.24.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
