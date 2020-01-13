Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5BEC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 03:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61524206D7
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 03:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z8IKd/sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61524206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A81589B49;
	Mon, 13 Jan 2020 03:36:57 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690042.outbound.protection.outlook.com [40.107.69.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB9389B49
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 03:36:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdmmgC3wd3Z7OaL4C69ekSlQ3UbQ2F4CkAoizRVXxszp8I3drWxRj8J10WIbGZlcK9QmXPrRrb6he1ebyfgHp/sqJ5IkrkfTcaUF55cd/iLiCA6YmmJiTOIdzHMi3FP9Yo/E9G/wRCJSuEWFEvfckJbysGCt7r7gMyOUCq4js1aLdpUNDHMWFdQiVbnK98C5ya5/Bd3Y/4CuOJ63Ucn1lTOGfTaT93jWujWobxWtoAREWjlh+3H1R6a9FxVIgG5seYH10P02PKS1+MdZZ++7zWs5e8wr5AHVucCPDQfd7BXLswWYwAQ/AWUgN2NOqoT6SbAnhlDe2IXIOKNdeZ2KFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+XQXpJiCG6pEUHbKPHVoCKSNIczoza/GZsd0IBAk9o=;
 b=fNGj5SYNykI/ZtZMMn8/fZHpRxuZC0QBEyMwkMuaeVfA+Yhkc+tCTTPO8HXu6XFpd3r8tQdP4Ue5IWezfhe9NMLw9xHf8ob6+rQvQmjiqP7+RK/VLjvUXRTwapGb82lNTST+TbbE7IacIMB1o7sIVRWyHF92Di/Sw03BqBjmg2MAAqeQ1T5BXk++NNvClwanKIT77ji3jA25tJXSuIcniImTG5rw7acd0x5HtGrvJtOyAPxikjpl0MRIKmVN/K5ox/dwJBKnx3Be9BurR8Qfr5WQLfLobKu//sEQaXSaNMBVdo3yo9mIZ/eHHk0dGbXuuBF34gWFu4QvGEfUvvIoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+XQXpJiCG6pEUHbKPHVoCKSNIczoza/GZsd0IBAk9o=;
 b=Z8IKd/srMzNArdksWJHDut6qwlpC5MEuFnYGal713Vc4g56uj8Knt4y8/8Akgbllvh6gRQRqdG/sVQmu/aYi0zGL5JR/mepg6NONkuSvTBz7UlvmrU2EQsVp7RuyjYjgc3XLwdbiFOR1y1CYikLMuuwG5Kq8HHwq1iliLOlxcuQ=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3775.namprd12.prod.outlook.com (10.255.86.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Mon, 13 Jan 2020 03:36:54 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 03:36:54 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/debugfs: properly handle runtime pm
Thread-Topic: [PATCH 2/2] drm/amdgpu/debugfs: properly handle runtime pm
Thread-Index: AQHVyBAOSLSY800Yn0iI106Lk5rOIKfn9S0Q
Date: Mon, 13 Jan 2020 03:36:53 +0000
Message-ID: <MN2PR12MB334485E2C0463ED04F7A5720E4350@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200110234509.4195-1-alexander.deucher@amd.com>
 <20200110234509.4195-2-alexander.deucher@amd.com>
In-Reply-To: <20200110234509.4195-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=502cb9ed-d791-43ce-b01e-000086bf23cc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-13T03:36:35Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ced52213-8f8a-4297-57e0-08d797d9d564
x-ms-traffictypediagnostic: MN2PR12MB3775:|MN2PR12MB3775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3775E72A2F5BB120E0F1125FE4350@MN2PR12MB3775.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:369;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(45080400002)(5660300002)(30864003)(316002)(86362001)(110136005)(966005)(52536014)(4326008)(478600001)(55016002)(9686003)(33656002)(26005)(2906002)(186003)(6506007)(53546011)(81166006)(81156014)(66556008)(8676002)(76116006)(8936002)(66476007)(66946007)(64756008)(7696005)(71200400001)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3775;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JlRgTdE5qkiIJhWdoghy9+e6h7jDI9P2dO/kyJni+bpKbxaez4UyVq4+8Too2ozSZOxutwziLBSuEFZjWadZCM0hglFb+xUtxFw5Z7m2AYKbEMb/5DfIETmMk5FEM27MDUyWongCWnKxtP8XDB7KrfEucgag/xm1x1wdIyJGB2EpxvR3/wUEGZa3NougJE6nHD5kDMIvFOwDUUbWaYdAhFT6rKLbGe9dpgoSmHZsXKTtokFLjyg+2YndbPP/GTAkr94BRvoHNqIiLgIYk1kCsbr6E2q58PfyeGWUy/VSpdWOeU6AlIkL6N6n5EXB5Z6xWmZh+qxxDXfrmmSShlHnNTEa4kDR2BoH4j7B3Qu0hc/QBAO4foSyKwiXmA4J9ZS3TaynLj5+qzotUTIa7qAQnuVxi6kbxOul6Xga6tvGN+622Y0MrIlV0X8Y3Iniyf0vd3809JMssJ+McB4XyeOMtHRyZEyifItrJp2Iw5bwYHI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced52213-8f8a-4297-57e0-08d797d9d564
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 03:36:53.8286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSFVyAnDRFs45MSEsMuj8XBxtWPat7mbO2wqm3b3hWHB5Xj3mnuNWSvngdb83KsC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, January 11, 2020 7:45 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/debugfs: properly handle runtime pm
> 
> If driver debugfs files are accessed, power up the GPU when necessary.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 133
> ++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |   8 ++
>  2 files changed, 134 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 63343bb43049..f24ed9a1a3e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -26,6 +26,7 @@
>  #include <linux/kthread.h>
>  #include <linux/pci.h>
>  #include <linux/uaccess.h>
> +#include <linux/pm_runtime.h>
> 
>  #include <drm/drm_debugfs.h>
> 
> @@ -144,10 +145,17 @@ static int  amdgpu_debugfs_process_reg_op(bool
> read, struct file *f,
> 
>  	*pos &= (1UL << 22) - 1;
> 
> +	r = pm_runtime_get_sync(adev->ddev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	if (use_bank) {
>  		if ((sh_bank != 0xFFFFFFFF && sh_bank >= adev-
> >gfx.config.max_sh_per_se) ||
> -		    (se_bank != 0xFFFFFFFF && se_bank >= adev-
> >gfx.config.max_shader_engines))
> +		    (se_bank != 0xFFFFFFFF && se_bank >= adev-
> >gfx.config.max_shader_engines)) {
> +			pm_runtime_mark_last_busy(adev->ddev->dev);
> +			pm_runtime_put_autosuspend(adev->ddev->dev);
>  			return -EINVAL;
> +		}
>  		mutex_lock(&adev->grbm_idx_mutex);
>  		amdgpu_gfx_select_se_sh(adev, se_bank,
>  					sh_bank, instance_bank);
> @@ -193,6 +201,9 @@ static int  amdgpu_debugfs_process_reg_op(bool read,
> struct file *f,
>  	if (pm_pg_lock)
>  		mutex_unlock(&adev->pm.mutex);
> 
> +	pm_runtime_mark_last_busy(adev->ddev->dev);
> +	pm_runtime_put_autosuspend(adev->ddev->dev);
> +
>  	return result;
>  }
> 
> @@ -237,13 +248,20 @@ static ssize_t
> amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>  	if (size & 0x3 || *pos & 0x3)
>  		return -EINVAL;
> 
> +	r = pm_runtime_get_sync(adev->ddev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	while (size) {
>  		uint32_t value;
> 
>  		value = RREG32_PCIE(*pos >> 2);
>  		r = put_user(value, (uint32_t *)buf);
> -		if (r)
> +		if (r) {
> +			pm_runtime_mark_last_busy(adev->ddev->dev);
> +			pm_runtime_put_autosuspend(adev->ddev->dev);
>  			return r;
> +		}
> 
>  		result += 4;
>  		buf += 4;
> @@ -251,6 +269,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct
> file *f, char __user *buf,
>  		size -= 4;
>  	}
> 
> +	pm_runtime_mark_last_busy(adev->ddev->dev);
> +	pm_runtime_put_autosuspend(adev->ddev->dev);
> +
>  	return result;
>  }
> 
> @@ -276,12 +297,19 @@ static ssize_t
> amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>  	if (size & 0x3 || *pos & 0x3)
>  		return -EINVAL;
> 
> +	r = pm_runtime_get_sync(adev->ddev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	while (size) {
>  		uint32_t value;
> 
>  		r = get_user(value, (uint32_t *)buf);
> -		if (r)
> +		if (r) {
> +			pm_runtime_mark_last_busy(adev->ddev->dev);
> +			pm_runtime_put_autosuspend(adev->ddev->dev);
>  			return r;
> +		}
> 
>  		WREG32_PCIE(*pos >> 2, value);
> 
> @@ -291,6 +319,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct
> file *f, const char __user
>  		size -= 4;
>  	}
> 
> +	pm_runtime_mark_last_busy(adev->ddev->dev);
> +	pm_runtime_put_autosuspend(adev->ddev->dev);
> +
>  	return result;
>  }
> 
> @@ -316,13 +347,20 @@ static ssize_t
> amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>  	if (size & 0x3 || *pos & 0x3)
>  		return -EINVAL;
> 
> +	r = pm_runtime_get_sync(adev->ddev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	while (size) {
>  		uint32_t value;
> 
>  		value = RREG32_DIDT(*pos >> 2);
>  		r = put_user(value, (uint32_t *)buf);
> -		if (r)
> +		if (r) {
> +			pm_runtime_mark_last_busy(adev->ddev->dev);
> +			pm_runtime_put_autosuspend(adev->ddev->dev);
>  			return r;
> +		}
> 
>  		result += 4;
>  		buf += 4;
> @@ -330,6 +368,9 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct
> file *f, char __user *buf,
>  		size -= 4;
>  	}
> 
> +	pm_runtime_mark_last_busy(adev->ddev->dev);
> +	pm_runtime_put_autosuspend(adev->ddev->dev);
> +
>  	return result;
>  }
> 
> @@ -355,12 +396,19 @@ static ssize_t
> amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
>  	if (size & 0x3 || *pos & 0x3)
>  		return -EINVAL;
> 
> +	r = pm_runtime_get_sync(adev->ddev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	while (size) {
>  		uint32_t value;
> 
>  		r = get_user(value, (uint32_t *)buf);
> -		if (r)
> +		if (r) {
> +			pm_runtime_mark_last_busy(adev->ddev->dev);
> +			pm_runtime_put_autosuspend(adev->ddev->dev);
>  			return r;
> +		}
> 
>  		WREG32_DIDT(*pos >> 2, value);
> 
> @@ -370,6 +418,9 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct
> file *f, const char __user
>  		size -= 4;
>  	}
> 
> +	pm_runtime_mark_last_busy(adev->ddev->dev);
> +	pm_runtime_put_autosuspend(adev->ddev->dev);
> +
>  	return result;
>  }
> 
> @@ -395,13 +446,20 @@ static ssize_t
> amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>  	if (size & 0x3 || *pos & 0x3)
>  		return -EINVAL;
> 
> +	r = pm_runtime_get_sync(adev->ddev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	while (size) {
>  		uint32_t value;
> 
>  		value = RREG32_SMC(*pos);
>  		r = put_user(value, (uint32_t *)buf);
> -		if (r)
> +		if (r) {
> +			pm_runtime_mark_last_busy(adev->ddev->dev);
> +			pm_runtime_put_autosuspend(adev->ddev->dev);
>  			return r;
> +		}
> 
>  		result += 4;
>  		buf += 4;
> @@ -409,6 +467,9 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct
> file *f, char __user *buf,
>  		size -= 4;
>  	}
> 
> +	pm_runtime_mark_last_busy(adev->ddev->dev);
> +	pm_runtime_put_autosuspend(adev->ddev->dev);
> +
>  	return result;
>  }
> 
> @@ -434,12 +495,19 @@ static ssize_t
> amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>  	if (size & 0x3 || *pos & 0x3)
>  		return -EINVAL;
> 
> +	r = pm_runtime_get_sync(adev->ddev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	while (size) {
>  		uint32_t value;
> 
>  		r = get_user(value, (uint32_t *)buf);
> -		if (r)
> +		if (r) {
> +			pm_runtime_mark_last_busy(adev->ddev->dev);
> +			pm_runtime_put_autosuspend(adev->ddev->dev);
>  			return r;
> +		}
> 
>  		WREG32_SMC(*pos, value);
> 
> @@ -449,6 +517,9 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct
> file *f, const char __user *
>  		size -= 4;
>  	}
> 
> +	pm_runtime_mark_last_busy(adev->ddev->dev);
> +	pm_runtime_put_autosuspend(adev->ddev->dev);
> +
>  	return result;
>  }
> 
> @@ -572,7 +643,16 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file
> *f, char __user *buf,
>  	idx = *pos >> 2;
> 
>  	valuesize = sizeof(values);
> +
> +	r = pm_runtime_get_sync(adev->ddev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	r = amdgpu_dpm_read_sensor(adev, idx, &values[0], &valuesize);
> +
> +	pm_runtime_mark_last_busy(adev->ddev->dev);
> +	pm_runtime_put_autosuspend(adev->ddev->dev);
> +
>  	if (r)
>  		return r;
> 
> @@ -633,6 +713,10 @@ static ssize_t amdgpu_debugfs_wave_read(struct file
> *f, char __user *buf,
>  	wave = (*pos & GENMASK_ULL(36, 31)) >> 31;
>  	simd = (*pos & GENMASK_ULL(44, 37)) >> 37;
> 
> +	r = pm_runtime_get_sync(adev->ddev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	/* switch to the specific se/sh/cu */
>  	mutex_lock(&adev->grbm_idx_mutex);
>  	amdgpu_gfx_select_se_sh(adev, se, sh, cu); @@ -644,6 +728,9 @@
> static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
>  	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
>  	mutex_unlock(&adev->grbm_idx_mutex);
> 
> +	pm_runtime_mark_last_busy(adev->ddev->dev);
> +	pm_runtime_put_autosuspend(adev->ddev->dev);
> +
>  	if (!x)
>  		return -EINVAL;
> 
> @@ -711,6 +798,10 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f,
> char __user *buf,
>  	if (!data)
>  		return -ENOMEM;
> 
> +	r = pm_runtime_get_sync(adev->ddev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	/* switch to the specific se/sh/cu */
>  	mutex_lock(&adev->grbm_idx_mutex);
>  	amdgpu_gfx_select_se_sh(adev, se, sh, cu); @@ -726,6 +817,9 @@
> static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>  	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
>  	mutex_unlock(&adev->grbm_idx_mutex);
> 
> +	pm_runtime_mark_last_busy(adev->ddev->dev);
> +	pm_runtime_put_autosuspend(adev->ddev->dev);
> +
>  	while (size) {
>  		uint32_t value;
> 
> @@ -859,6 +953,10 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m,
> void *data)
>  	struct amdgpu_device *adev = dev->dev_private;
>  	int r = 0, i;
> 
> +	r = pm_runtime_get_sync(dev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	/* Avoid accidently unparking the sched thread during GPU reset */
>  	mutex_lock(&adev->lock_reset);
> 
> @@ -889,6 +987,9 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m,
> void *data)
> 
>  	mutex_unlock(&adev->lock_reset);
> 
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
> +
>  	return 0;
>  }
> 
> @@ -907,8 +1008,17 @@ static int amdgpu_debugfs_evict_vram(struct
> seq_file *m, void *data)
>  	struct drm_info_node *node = (struct drm_info_node *)m->private;
>  	struct drm_device *dev = node->minor->dev;
>  	struct amdgpu_device *adev = dev->dev_private;
> +	int r;
> +
> +	r = pm_runtime_get_sync(dev->dev);
> +	if (r < 0)
> +		return r;
> 
>  	seq_printf(m, "(%d)\n", amdgpu_bo_evict_vram(adev));
> +
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
> +
>  	return 0;
>  }
> 
> @@ -917,8 +1027,17 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file
> *m, void *data)
>  	struct drm_info_node *node = (struct drm_info_node *)m->private;
>  	struct drm_device *dev = node->minor->dev;
>  	struct amdgpu_device *adev = dev->dev_private;
> +	int r;
> +
> +	r = pm_runtime_get_sync(dev->dev);
> +	if (r < 0)
> +		return r;
> 
>  	seq_printf(m, "(%d)\n", ttm_bo_evict_mm(&adev->mman.bdev,
> TTM_PL_TT));
> +
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
> +
>  	return 0;
>  }
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index e9efee04ca23..3c01252b1e0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -741,10 +741,18 @@ static int amdgpu_debugfs_gpu_recover(struct
> seq_file *m, void *data)
>  	struct drm_info_node *node = (struct drm_info_node *) m->private;
>  	struct drm_device *dev = node->minor->dev;
>  	struct amdgpu_device *adev = dev->dev_private;
> +	int r;
> +
> +	r = pm_runtime_get_sync(dev->dev);
> +	if (r < 0)
> +		return 0;
> 
>  	seq_printf(m, "gpu recover\n");
>  	amdgpu_device_gpu_recover(adev, NULL);
> 
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
> +
>  	return 0;
>  }
> 
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C8e6ecdab282646758a
> de08d796272aa0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> 142967348327101&amp;sdata=KaUJb0eNiSNov6amPZ20oxPm6howvbmU093i2
> EAprO0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
