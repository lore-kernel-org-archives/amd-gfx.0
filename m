Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE3C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 06:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B552072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 06:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KYd4QNyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B552072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64F96E1A4;
	Thu,  4 Jun 2020 06:07:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2EFC6E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 06:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxDCNOAyRIuHiA9ERLmA1Ozpbpxlj8/7O+1DWkAtFAOMbGA36MmXtb+QYzrZ7nkHj909lWW/eK60OvVQb/kzhl09VluJn4WaKk7GMlr0aMy+EXgfm6bbQIQcAHLbCkgG2xpnDE6OQrGvwiijERnvTeqE47uJR+BHf41IYF2xQbldYgxWhYXewafZC8dFRMwZgdmWjOv2khJAMw0JsjtdSbtmHY8iw0VKcOBGrTZDj2BDbcV5ROEjNVuhHWJw54xfMx9zsqzCyMBnp+SvM2ktz7N6OiIgJaAvfEqUfTA+P3fLvVfwkhFpKcrRC3r7Hyef44F3r+E1pHrPYCmFLjtOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcjEHgtqLHX7AW6435g0h1URtOr93EomfgUKIZdih6w=;
 b=aTxSWsuWmWMk6dSZQKjAkTXtCOZwljdvzj7LNgUV4Ns/syc+m/sjyb6T5avvTkMkJCW2YbZrvO8dq/lQ/lsrtRIaMDKzvRoJdXCapxUXk6Pxy6bWjTWZVxc3o3DuVa334avCxWyf94VhfAoDsuYUl3v/4AyauhwgmIwrUnRbiSh4cLOT5OyoteTUV2VRXk7jcJUlCtfhqMNLx0V2zF+9XVnRl2oC1dTSet+ZLNZ8doRFXNiLBlre2270hHuXBeIqfp9qVRmY5qp78otqheS/QCxEKSGCFg5v0qHfkSndKepcj+qW3f6d8RR+Wj00l6/9uzLyLfcx+m76g5fcDhNKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcjEHgtqLHX7AW6435g0h1URtOr93EomfgUKIZdih6w=;
 b=KYd4QNyyj9/KnUrGgXjqnoE56YhW3+LuSrqX1QpbeOPyRG3xV7RWTDgZRy6OsK5G0K+DMdcrXJz2l5GQ5yCtwyWCZ34t+vdu8YFg28+6l5YQpBDFcf3OxdnNL4mvtdusObNtH3+l5oHvd41kZS0u3B62Bt5hZyGL9uo21RShtQE=
Received: from MWHPR12MB1837.namprd12.prod.outlook.com (2603:10b6:300:113::20)
 by MWHPR12MB1133.namprd12.prod.outlook.com (2603:10b6:300:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 06:07:11 +0000
Received: from MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::c142:31c5:738f:205c]) by MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::c142:31c5:738f:205c%9]) with mapi id 15.20.3045.024; Thu, 4 Jun 2020
 06:07:11 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: support reserve bad page for virt
Thread-Topic: [PATCH] drm/amdgpu: support reserve bad page for virt
Thread-Index: AQHWObChXEgcpkdsdkCXrEkMip8Jk6jH2luAgAAdYjA=
Date: Thu, 4 Jun 2020 06:07:10 +0000
Message-ID: <MWHPR12MB18376731743728D0F3B1FC569A890@MWHPR12MB1837.namprd12.prod.outlook.com>
References: <20200603140936.7356-1-Stanley.Yang@amd.com>
 <BYAPR12MB2888BC256609F5499F2A35ADB0890@BYAPR12MB2888.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB2888BC256609F5499F2A35ADB0890@BYAPR12MB2888.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-04T04:15:50Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=39c97454-3c63-4798-b585-0000eb0d6bd6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-04T06:07:08Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1452e7fc-8206-4789-8ea4-00008b0690c2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9986eb2d-864b-4264-445a-08d8084d851b
x-ms-traffictypediagnostic: MWHPR12MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1133C44457BF5CA65F6147329A890@MWHPR12MB1133.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FV0eKgpe6MHoAklY/fqKdUVyothHYjDI5T3RWgJgWlnBOZWKj4WA1hpvXv9sgN4frjlElE5zvLX7xKNsMMQJiNLFrModrF2+YQjMfRT5t2dyMEjrX7KwXpbn+z9HygFE6k5bE0XLz8W3c6zL5SYZXKBxVCRNgG8floc9VTYQVLe+VcjPde1BywI7h9uhgyzSmW3M+PRuos7tUSopOlxi8/jdgQJk1F4ZPMgYbyibaXqwHmgT6tZ4UqAyfTAUI1DVea7ABaGxJMOhy2uuqo5LsW7ZncUvVEC72Z1YPL+i1pYhYC3g13eMHPg5q9MkNhT3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1837.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(53546011)(478600001)(54906003)(30864003)(86362001)(316002)(110136005)(33656002)(76116006)(71200400001)(66946007)(64756008)(66476007)(66556008)(66446008)(52536014)(83380400001)(5660300002)(186003)(6506007)(26005)(4326008)(7696005)(8936002)(55016002)(2906002)(8676002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: luT/XPfqqkMCwqvUaC2plk0VRpd4WPRxsfbsiGHdzOIFGH8AoVqEtQAK1jNQIMrKlRx91xyjC6Rsi9dncXQiV+6Hnu9sdjEacsd7yZvJckG9IwtYH+5f+3gdThegKySFAS44gPUC8aF+1hn01qoy15K0sXsckA/pbkRedLtH1HTq30JlsmcoyzoUJEyATRhLYx9HBHpmljkIoqZNm5XqJZR8DAtkdGs+xbdks/BmK43bFTqodrDeXlriDFX6UYqurXAWa/GvU7pJB/4EKUAWqeP+QkjCVO1jhsrpJLDuUb5s7kGvHyY9gejVmfewTycpLr/pmHnfM8x22IGu/PBmGe2vARouO+annWX6YGX3uviuC5I6jD8YCYH5PO8ApYk8riyTZmoqrDcpWwrYQY9c6TYNSmEk0soQFfeThNSZeA+UBq4NEXi0aR+zcKhJpYg50FEOCEaicNrPOBGfj2dzekH427DpUbClMDe27eL2Du1VQuFNcFmTpQQ6npkd51oy
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9986eb2d-864b-4264-445a-08d8084d851b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 06:07:11.0376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOvkyYL2uV+yoe+XEudNDyvTOyc3GJQltgGNiPQDf+KpggH5gSbWeOSaauh9x/pJ8Z0861FuK6nZuqQbeIHY/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1133
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks tao, to call amdgpu_virt_init_err_handler_data In amdgpu_virt_add_bad_page once Is also a way, I will check whether has potential risk.
And I'll make distinguish the message from the one in bare mental RAS when reserved page failed.

Regards,
Stanley

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Thursday, June 4, 2020 12:16 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Clements,
> John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: support reserve bad page for virt
> 
> [AMD Public Use]
> 
> Two comments inline
> 
> > -----Original Message-----
> > From: Stanley.Yang <Stanley.Yang@amd.com>
> > Sent: 2020年6月3日 22:10
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun
> > <Guchun.Chen@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Clements,
> John
> > <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,
> Dennis
> > <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> > Subject: [PATCH] drm/amdgpu: support reserve bad page for virt
> >
> > Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> > Change-Id: Ia0ad9453ac3ac929f95c73cbee5b7a8fc42a9816
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   7 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 164
> > +++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  30 +++-
> >  3 files changed, 196 insertions(+), 5 deletions(-)  mode change
> > 100644 =>
> > 100755 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> >  mode change 100644 => 100755
> > drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index b633171281f8..e8986e007206 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2001,8 +2001,10 @@ static int amdgpu_device_ip_init(struct
> > amdgpu_device *adev)
> >  		}
> >  	}
> >
> > -	if (amdgpu_sriov_vf(adev))
> > +	if (amdgpu_sriov_vf(adev)) {
> > +		amdgpu_virt_init_err_handler_data(adev);
> 
> [Tao] It's can be also called in amdgpu_virt_add_bad_page once to avoid asic
> type check, but either way is OK for me.
> 
> >  		amdgpu_virt_init_data_exchange(adev);
> > +	}
> >
> >  	r = amdgpu_ib_pool_init(adev);
> >  	if (r) {
> > @@ -2306,6 +2308,9 @@ static int amdgpu_device_ip_fini(struct
> > amdgpu_device *adev)  {
> >  	int i, r;
> >
> > +	if (amdgpu_sriov_vf(adev))
> > +		amdgpu_release_virt_err_handler_data(adev);
> > +
> >  	amdgpu_ras_pre_fini(adev);
> >
> >  	if (adev->gmc.xgmi.num_physical_nodes > 1) diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > old mode 100644
> > new mode 100755
> > index f3b38c9e04ca..c1554562a2ce
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -26,6 +26,7 @@
> >  #include <drm/drm_drv.h>
> >
> >  #include "amdgpu.h"
> > +#include "amdgpu_ras.h"
> >
> >  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)  { @@ -
> > 255,12 +256,164 @@ int amdgpu_virt_fw_reserve_get_checksum(void
> *obj,
> >  	return ret;
> >  }
> >
> > +int amdgpu_virt_init_err_handler_data(struct amdgpu_device *adev) {
> > +	struct amdgpu_virt *virt = &adev->virt;
> > +	struct virt_ras_err_handler_data **data = &virt->virt_eh_data;
> > +	/* GPU will be marked bad on host if bp count more then 10,
> > +	 * so alloc 512 is enough.
> > +	 */
> > +	unsigned int align_space = 512;
> > +	void *bps = NULL;
> > +	struct amdgpu_bo **bps_bo = NULL;
> > +
> > +	*data = kmalloc(sizeof(struct virt_ras_err_handler_data),
> > GFP_KERNEL);
> > +	if (!*data)
> > +		return -ENOMEM;
> > +
> > +	bps = kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
> > +	bps_bo = kmalloc(align_space * sizeof((*data)->bps_bo),
> > GFP_KERNEL);
> > +
> > +	if (!bps || !bps_bo) {
> > +		kfree(bps);
> > +		kfree(bps_bo);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	(*data)->bps = bps;
> > +	(*data)->bps_bo = bps_bo;
> > +	(*data)->count = 0;
> > +	(*data)->last_reserved = 0;
> > +	return 0;
> > +}
> > +
> > +static void amdgpu_virt_release_bp(struct amdgpu_device *adev) {
> > +	struct amdgpu_virt *virt = &adev->virt;
> > +	struct virt_ras_err_handler_data *data = virt->virt_eh_data;
> > +	struct amdgpu_bo *bo;
> > +	int i;
> > +
> > +	if (!data)
> > +		return;
> > +
> > +	for (i = data->last_reserved - 1; i >= 0; i--) {
> > +		bo = data->bps_bo[i];
> > +		amdgpu_bo_free_kernel(&bo, NULL, NULL);
> > +		data->bps_bo[i] = bo;
> > +		data->last_reserved = i;
> > +	}
> > +}
> > +
> > +void amdgpu_release_virt_err_handler_data(struct amdgpu_device
> *adev)
> > {
> > +	struct amdgpu_virt *virt = &adev->virt;
> > +	struct virt_ras_err_handler_data *data = virt->virt_eh_data;
> > +
> > +	if (!data)
> > +		return;
> > +
> > +	amdgpu_virt_release_bp(adev);
> > +
> > +	kfree(data->bps);
> > +	kfree(data->bps_bo);
> > +	kfree(data);
> > +	virt->virt_eh_data = NULL;
> > +}
> > +
> > +static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
> > +		struct eeprom_table_record *bps, int pages) {
> > +	struct amdgpu_virt *virt = &adev->virt;
> > +	struct virt_ras_err_handler_data *data = virt->virt_eh_data;
> > +
> > +	if (!data)
> > +		return;
> > +
> > +	memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
> > +	data->count += pages;
> > +}
> > +
> > +static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev) {
> > +	struct amdgpu_virt *virt = &adev->virt;
> > +	struct virt_ras_err_handler_data *data = virt->virt_eh_data;
> > +	struct amdgpu_bo *bo = NULL;
> > +	uint64_t bp;
> > +	int i;
> > +
> > +	if (!data)
> > +		return;
> > +
> > +	for (i = data->last_reserved; i < data->count; i++) {
> > +		bp = data->bps[i].retired_page;
> > +
> > +		/* There are two cases of reserve error should be ignored:
> > +		 * 1) a ras bad page has been allocated (used by someone);
> > +		 * 2) a ras bad page has been reserved (duplicate error
> > injection
> > +		 *    for one page);
> > +		 */
> > +		if (amdgpu_bo_create_kernel_at(adev, bp <<
> > AMDGPU_GPU_PAGE_SHIFT,
> > +					       AMDGPU_GPU_PAGE_SIZE,
> > +					       AMDGPU_GEM_DOMAIN_VRAM,
> > +					       &bo, NULL))
> > +			DRM_WARN("RAS WARN: reserve vram for retired
> > page %llx fail\n", bp);
> 
> [Tao] It's better to distinguish the message from the one in bare mental RAS.
> 
> > +
> > +		data->bps_bo[i] = bo;
> > +		data->last_reserved = i + 1;
> > +		bo = NULL;
> > +	}
> > +}
> > +
> > +static bool amdgpu_virt_check_bad_page(struct amdgpu_device *adev,
> > +		uint64_t retired_page)
> > +{
> > +	struct amdgpu_virt *virt = &adev->virt;
> > +	struct virt_ras_err_handler_data *data = virt->virt_eh_data;
> > +	int i;
> > +
> > +	if (!data)
> > +		return true;
> > +
> > +	for (i = 0; i < data->count; i++)
> > +		if (retired_page == data->bps[i].retired_page)
> > +			return true;
> > +
> > +	return false;
> > +}
> > +
> > +static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
> > +		uint64_t bp_block_offset, uint32_t bp_block_size) {
> > +	struct eeprom_table_record bp;
> > +	uint64_t retired_page;
> > +	uint32_t bp_idx, bp_cnt;
> > +
> > +	if (bp_block_size) {
> > +		bp_cnt = bp_block_size / sizeof(uint64_t);
> > +		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
> > +			retired_page = *(uint64_t *)(adev-
> > >fw_vram_usage.va +
> > +					bp_block_offset + bp_idx *
> > sizeof(uint64_t));
> > +			bp.retired_page = retired_page;
> > +
> > +			if (amdgpu_virt_check_bad_page(adev,
> retired_page))
> > +				continue;
> > +
> > +			amdgpu_virt_ras_add_bps(adev, &bp, 1);
> > +
> > +			amdgpu_virt_ras_reserve_bps(adev);
> > +		}
> > +	}
> > +}
> > +
> >  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)  {
> >  	uint32_t pf2vf_size = 0;
> >  	uint32_t checksum = 0;
> >  	uint32_t checkval;
> >  	char *str;
> > +	uint64_t bp_block_offset = 0;
> > +	uint32_t bp_block_size = 0;
> >
> >  	adev->virt.fw_reserve.p_pf2vf = NULL;
> >  	adev->virt.fw_reserve.p_vf2pf = NULL; @@ -275,6 +428,17 @@ void
> > amdgpu_virt_init_data_exchange(struct
> > amdgpu_device *adev)
> >
> >  		/* pf2vf message must be in 4K */
> >  		if (pf2vf_size > 0 && pf2vf_size < 4096) {
> > +			if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
> > +				struct amdgim_pf2vf_info_v2 *pf2vf_v2 =
> > NULL;
> > +
> > +				pf2vf_v2 = (struct amdgim_pf2vf_info_v2
> > *)adev->virt.fw_reserve.p_pf2vf;
> > +				bp_block_offset = ((uint64_t)pf2vf_v2-
> > >bp_block_offset_L & 0xFFFFFFFF) |
> > +						((((uint64_t)pf2vf_v2-
> > >bp_block_offset_H) << 32) & 0xFFFFFFFF00000000);
> > +				bp_block_size = pf2vf_v2->bp_block_size;
> > +
> > +				amdgpu_virt_add_bad_page(adev,
> > bp_block_offset, bp_block_size);
> > +			}
> > +
> >  			checkval = amdgpu_virt_fw_reserve_get_checksum(
> >  				adev->virt.fw_reserve.p_pf2vf, pf2vf_size,
> >  				adev->virt.fw_reserve.checksum_key,
> > checksum); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > old mode 100644
> > new mode 100755
> > index b90e822cebd7..96d84f036e96
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > @@ -143,19 +143,27 @@ struct  amdgim_pf2vf_info_v2 {
> >  	uint32_t vce_enc_max_pixels_count;
> >  	/* 16x16 pixels/sec, codec independent */
> >  	uint32_t vce_enc_max_bandwidth;
> > +	/* Bad pages block position in BYTE */
> > +	uint32_t bp_block_offset_L;
> > +	uint32_t bp_block_offset_H;
> > +	/* Bad pages block size in BYTE */
> > +	uint32_t bp_block_size;
> >  	/* MEC FW position in kb from the start of VF visible frame buffer */
> > -	uint64_t mecfw_kboffset;
> > +	uint32_t mecfw_kboffset_L;
> > +	uint32_t mecfw_kboffset_H;
> >  	/* MEC FW size in KB */
> >  	uint32_t mecfw_ksize;
> >  	/* UVD FW position in kb from the start of VF visible frame buffer */
> > -	uint64_t uvdfw_kboffset;
> > +	uint32_t uvdfw_kboffset_L;
> > +	uint32_t uvdfw_kboffset_H;
> >  	/* UVD FW size in KB */
> >  	uint32_t uvdfw_ksize;
> >  	/* VCE FW position in kb from the start of VF visible frame buffer */
> > -	uint64_t vcefw_kboffset;
> > +	uint32_t vcefw_kboffset_L;
> > +	uint32_t vcefw_kboffset_H;
> >  	/* VCE FW size in KB */
> >  	uint32_t vcefw_ksize;
> > -	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256,
> 0,
> > 0, (9 + sizeof(struct
> > amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)), 3)];
> > +	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256,
> 0,
> > 0, (18 +
> > +sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)),
> > +0)];
> >  } __aligned(4);
> >
> >
> > @@ -254,6 +262,17 @@ typedef struct amdgim_vf2pf_info_v2
> > amdgim_vf2pf_info ;
> >  		} \
> >  	} while (0)
> >
> > +struct virt_ras_err_handler_data {
> > +	/* point to bad page records array */
> > +	struct eeprom_table_record *bps;
> > +	/* point to reserved bo array */
> > +	struct amdgpu_bo **bps_bo;
> > +	/* the count of entries */
> > +	int count;
> > +	/* last reserved entry's index + 1 */
> > +	int last_reserved;
> > +};
> > +
> >  /* GPU virtualization */
> >  struct amdgpu_virt {
> >  	uint32_t			caps;
> > @@ -272,6 +291,7 @@ struct amdgpu_virt {
> >  	uint32_t reg_access_mode;
> >  	int req_init_data_ver;
> >  	bool tdr_debug;
> > +	struct virt_ras_err_handler_data *virt_eh_data;
> >  };
> >
> >  #define amdgpu_sriov_enabled(adev) \
> > @@ -323,6 +343,8 @@ void amdgpu_virt_free_mm_table(struct
> > amdgpu_device *adev);  int amdgpu_virt_fw_reserve_get_checksum(void
> > *obj, unsigned long obj_size,
> >  					unsigned int key,
> >  					unsigned int chksum);
> > +void amdgpu_release_virt_err_handler_data(struct amdgpu_device
> > +*adev); int amdgpu_virt_init_err_handler_data(struct amdgpu_device
> > +*adev);
> >  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
> > void amdgpu_detect_virtualization(struct amdgpu_device *adev);
> >
> > --
> > 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
