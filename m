Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D1C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 05:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85910207D5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 05:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lTbv2WVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85910207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 219196E83D;
	Fri,  5 Jun 2020 05:59:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655E86E83D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 05:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZz6/DXoqxViaSmAdNXme4Y+VxW4oAY67hnayTlcEtgp31O7k5te0F89wjeKVt3GHB+IUkc/0NV4PRSPOh4a57JNGvpYBn2fRhQnDLFg10ZBwHuVaPWyFEdI+RuGtg7AwxIrlt1nLlKLlB9deTDK3xKqrzKgb3OB8V+XUuBc3zKbuWVde1KH8O3g44F0HbuUAPoe2XIn+R52SFQySRGgC5nchd24ZzmJqxfFomA/Tait6kXTFuVqOL/QpFXPqg8FHhgrF2mmPMkAHAS7ZeZRy1PA/dAOAG89+hbLJJkMoEnMclku5WE8x1RQeHvYuPzH1vQAB4lVVXMuNdukpur1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c60zoC7XX3EHt19R5B9STmiLL+uoSoVZ9Vq6ZxKU6Gk=;
 b=Kawi8G7fV8/q1FK2KS5U8piTI0zi28INaZTCIWTfCZAbqrBlilX9mrwtS57q8L9DUPVOl1HX/o4SIVlWU0jOwbA8r9WL51N1NOzEUXuwdSFsEBigKrz1xZCgZsflAO2K4nJZQYZf3kh4eiDgA1y/ovTQSBktWN9xGXE8QCBJ+N3FC9PLqGXAj5/NIeEFlZcHMqTQG8EHaiGMKf4GYGRCRdWWVSeXR3F3+swDT9KKo6Ytptk4CDdGxtRJlsEdBsaf8b867PFOJxKpz45yDcb+s8SYLLT4nYj9IqtTO5pA/L2iZtAjhA2dE150upLDGZXl1rc+wmAudEe2UN3D4Ez2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c60zoC7XX3EHt19R5B9STmiLL+uoSoVZ9Vq6ZxKU6Gk=;
 b=lTbv2WVdGcBrparDdTPZ1PiTiotueuY/MJ2jbryAjRNfTduXmTqeCDQdTtrPx85U4Q9SawkhYx8Coj8h3/qyvL7Gl3K0tSIJ8wr49GJLWoMwjh+y0tGtcqhZCUGxholsz5XZFSB8m1woOQZBw/F2oSMCFqVVIzeLxpW2821RBrg=
Received: from MWHPR12MB1837.namprd12.prod.outlook.com (2603:10b6:300:113::20)
 by MWHPR12MB1693.namprd12.prod.outlook.com (2603:10b6:301:10::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 05:59:23 +0000
Received: from MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::c142:31c5:738f:205c]) by MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::c142:31c5:738f:205c%9]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 05:59:23 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V3] drm/amdgpu: support reserve bad page for virt
Thread-Topic: [PATCH V3] drm/amdgpu: support reserve bad page for virt
Thread-Index: AQHWOv2r5tNLuRruzUaLbSzk/V8C1ajJhhKg
Date: Fri, 5 Jun 2020 05:59:23 +0000
Message-ID: <MWHPR12MB1837C2CA485FF3D8D1A607099A860@MWHPR12MB1837.namprd12.prod.outlook.com>
References: <20200605055333.19933-1-Stanley.Yang@amd.com>
In-Reply-To: <20200605055333.19933-1-Stanley.Yang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-05T05:56:56Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d243b18c-6d03-4772-bde5-00004f652dab;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-05T05:59:13Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 1ed70369-2943-4d4b-b3e4-00001546f3f4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: [AMD Public Use]
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aba34332-62fb-43b1-cbba-08d8091598e0
x-ms-traffictypediagnostic: MWHPR12MB1693:
x-microsoft-antispam-prvs: <MWHPR12MB1693A64A7001FCD205903B8A9A860@MWHPR12MB1693.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RRW6TmZ8lya0vixBjl7LZKqGauXrqtneYGH1KGGLgeoKCgV3k8qQ5wkxCki5XgYJpOkA00V96yGSOk4GWJbjQ5tOCMGwD/x0Bm7+p+v21tdOtKhw8YxJ/+CXJODeu9ebaNj6AyXBLlj22e9l+0djBPIdFefzXL1whsM9uQIbRKeRaMGpmkKWZ9mYkYdaAXEKnk+WyeB7gNhhhgZT6mBzIkwoOYDLOEoBhkIwBwVVSMkhuL4/Z5unee9AUA0tri1ZTacuPUKm7PbXnWumqY++TpuPtpyHqpY8dEdV6c8qY9smIRPWzvddkJA1QdUoMdV7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1837.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(6916009)(86362001)(186003)(6506007)(478600001)(8676002)(83380400001)(66446008)(64756008)(66556008)(66476007)(8936002)(9686003)(66946007)(33656002)(55016002)(26005)(53546011)(2906002)(5660300002)(76116006)(52536014)(71200400001)(316002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qepYNEDlmRc8zbwKux8kCNREbsvcuGhEOpLvIp4npnUVDIorXUbics9cjdcxXUP5FAL0fEKjVjskoAnI+FhXhAy77V9mwgRnbk85377PjLI1qOMCfXLZYMrxl5i2fn7mZb+MH2VFhY7ORCtNIDN2fh+nPHuYo7SL4cgR5Jq1fEFdNrLghA/xfpGtxig8CpwS+6BOd2276VPXdvgduDZscqcXRP7PrnDJc5/wL4nrrIobSZCxndz40smXVEkN5TRscSO0G7vhbiwP/m+wPPNeRXJQ0eggmB9bOHGynRl4cJSoqzTxIgmuCsD6KsdJC0aRFyGzOhtN5gPxjFhsz3YNaZqEDzqmX7QqFpKzaI+yWwDHxiUsV7YjJ3D0pWE9Q2n0TAfhCS6NXvWXyF920kmLdJMeLLzkc92ZSYqgFouvszU+R8YcXXBsZlYzatq87BgTO/hHTfiSjluhAymTPAOpFWHGgViWdpyu81nWV2cDNuWz9ptKxDEQnmy694zba8jU
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba34332-62fb-43b1-cbba-08d8091598e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 05:59:23.3828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vki9yBJS7N82tQjsODF7QfCHmjC+qAKifC55O+gRwOzUMW7klc97UCpw1hUumEPT5o/Tk7t3WT9kaj81M9Hb2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1693
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

[AMD Official Use Only - Internal Distribution Only]

Please ignore this patch, will resend.

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Friday, June 5, 2020 1:54 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Clements,
> John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,
> Dennis <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH V3] drm/amdgpu: support reserve bad page for virt
> 
> Changed from V1:
> 	rename some functions name, only init ras error handler data for
> 	supported asic.
> 
> Changed from V2:
> 	fix poential memory leak.
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> Change-Id: Ia0ad9453ac3ac929f95c73cbee5b7a8fc42a9816
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 173
> +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  30 +++-
>  3 files changed, 202 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1df28b7bf22e..668ad0e35160 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2326,6 +2326,9 @@ static int amdgpu_device_ip_fini(struct
> amdgpu_device *adev)  {
>  	int i, r;
> 
> +	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
> +		amdgpu_virt_release_ras_err_handler_data(adev);
> +
>  	amdgpu_ras_pre_fini(adev);
> 
>  	if (adev->gmc.xgmi.num_physical_nodes > 1) diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index bab9286021a7..0891f27ba166 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -26,6 +26,7 @@
>  #include <drm/drm_drv.h>
> 
>  #include "amdgpu.h"
> +#include "amdgpu_ras.h"
> 
>  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)  { @@ -
> 255,12 +256,171 @@ int amdgpu_virt_fw_reserve_get_checksum(void *obj,
>  	return ret;
>  }
> 
> +static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device
> +*adev) {
> +	struct amdgpu_virt *virt = &adev->virt;
> +	struct amdgpu_virt_ras_err_handler_data **data = &virt-
> >virt_eh_data;
> +	/* GPU will be marked bad on host if bp count more then 10,
> +	 * so alloc 512 is enough.
> +	 */
> +	unsigned int align_space = 512;
> +	void *bps = NULL;
> +	struct amdgpu_bo **bps_bo = NULL;
> +
> +	*data = kmalloc(sizeof(struct amdgpu_virt_ras_err_handler_data),
> GFP_KERNEL);
> +	if (!*data)
> +		return -ENOMEM;
> +
> +	bps = kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
> +	bps_bo = kmalloc(align_space * sizeof((*data)->bps_bo),
> GFP_KERNEL);
> +
> +	if (!bps || !bps_bo) {
> +		kfree(bps);
> +		kfree(bps_bo);
> +		kfree(*data);
> +		return -ENOMEM;
> +	}
> +
> +	(*data)->bps = bps;
> +	(*data)->bps_bo = bps_bo;
> +	(*data)->count = 0;
> +	(*data)->last_reserved = 0;
> +
> +	virt->ras_init_done = true;
> +
> +	return 0;
> +}
> +
> +static void amdgpu_virt_ras_release_bp(struct amdgpu_device *adev) {
> +	struct amdgpu_virt *virt = &adev->virt;
> +	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
> +	struct amdgpu_bo *bo;
> +	int i;
> +
> +	if (!data)
> +		return;
> +
> +	for (i = data->last_reserved - 1; i >= 0; i--) {
> +		bo = data->bps_bo[i];
> +		amdgpu_bo_free_kernel(&bo, NULL, NULL);
> +		data->bps_bo[i] = bo;
> +		data->last_reserved = i;
> +	}
> +}
> +
> +void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device
> +*adev) {
> +	struct amdgpu_virt *virt = &adev->virt;
> +	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
> +
> +	virt->ras_init_done = false;
> +
> +	if (!data)
> +		return;
> +
> +	amdgpu_virt_ras_release_bp(adev);
> +
> +	kfree(data->bps);
> +	kfree(data->bps_bo);
> +	kfree(data);
> +	virt->virt_eh_data = NULL;
> +}
> +
> +static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
> +		struct eeprom_table_record *bps, int pages) {
> +	struct amdgpu_virt *virt = &adev->virt;
> +	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
> +
> +	if (!data)
> +		return;
> +
> +	memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
> +	data->count += pages;
> +}
> +
> +static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev) {
> +	struct amdgpu_virt *virt = &adev->virt;
> +	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
> +	struct amdgpu_bo *bo = NULL;
> +	uint64_t bp;
> +	int i;
> +
> +	if (!data)
> +		return;
> +
> +	for (i = data->last_reserved; i < data->count; i++) {
> +		bp = data->bps[i].retired_page;
> +
> +		/* There are two cases of reserve error should be ignored:
> +		 * 1) a ras bad page has been allocated (used by someone);
> +		 * 2) a ras bad page has been reserved (duplicate error
> injection
> +		 *    for one page);
> +		 */
> +		if (amdgpu_bo_create_kernel_at(adev, bp <<
> AMDGPU_GPU_PAGE_SHIFT,
> +					       AMDGPU_GPU_PAGE_SIZE,
> +					       AMDGPU_GEM_DOMAIN_VRAM,
> +					       &bo, NULL))
> +			DRM_DEBUG("RAS WARN: reserve vram for retired
> page %llx fail\n",
> +bp);
> +
> +		data->bps_bo[i] = bo;
> +		data->last_reserved = i + 1;
> +		bo = NULL;
> +	}
> +}
> +
> +static bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device
> *adev,
> +		uint64_t retired_page)
> +{
> +	struct amdgpu_virt *virt = &adev->virt;
> +	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
> +	int i;
> +
> +	if (!data)
> +		return true;
> +
> +	for (i = 0; i < data->count; i++)
> +		if (retired_page == data->bps[i].retired_page)
> +			return true;
> +
> +	return false;
> +}
> +
> +static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
> +		uint64_t bp_block_offset, uint32_t bp_block_size) {
> +	struct eeprom_table_record bp;
> +	uint64_t retired_page;
> +	uint32_t bp_idx, bp_cnt;
> +
> +	if (bp_block_size) {
> +		bp_cnt = bp_block_size / sizeof(uint64_t);
> +		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
> +			retired_page = *(uint64_t *)(adev-
> >fw_vram_usage.va +
> +					bp_block_offset + bp_idx *
> sizeof(uint64_t));
> +			bp.retired_page = retired_page;
> +
> +			if (amdgpu_virt_ras_check_bad_page(adev,
> retired_page))
> +				continue;
> +
> +			amdgpu_virt_ras_add_bps(adev, &bp, 1);
> +
> +			amdgpu_virt_ras_reserve_bps(adev);
> +		}
> +	}
> +}
> +
>  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)  {
>  	uint32_t pf2vf_size = 0;
>  	uint32_t checksum = 0;
>  	uint32_t checkval;
>  	char *str;
> +	uint64_t bp_block_offset = 0;
> +	uint32_t bp_block_size = 0;
> +	struct amdgim_pf2vf_info_v2 *pf2vf_v2 = NULL;
> 
>  	adev->virt.fw_reserve.p_pf2vf = NULL;
>  	adev->virt.fw_reserve.p_vf2pf = NULL;
> @@ -275,6 +435,19 @@ void amdgpu_virt_init_data_exchange(struct
> amdgpu_device *adev)
> 
>  		/* pf2vf message must be in 4K */
>  		if (pf2vf_size > 0 && pf2vf_size < 4096) {
> +			if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
> +				pf2vf_v2 = (struct amdgim_pf2vf_info_v2
> *)adev->virt.fw_reserve.p_pf2vf;
> +				bp_block_offset = ((uint64_t)pf2vf_v2-
> >bp_block_offset_L & 0xFFFFFFFF) |
> +						((((uint64_t)pf2vf_v2-
> >bp_block_offset_H) << 32) & 0xFFFFFFFF00000000);
> +				bp_block_size = pf2vf_v2->bp_block_size;
> +
> +				if (bp_block_size && !adev-
> >virt.ras_init_done)
> +
> 	amdgpu_virt_init_ras_err_handler_data(adev);
> +
> +				if (adev->virt.ras_init_done)
> +					amdgpu_virt_add_bad_page(adev,
> bp_block_offset, bp_block_size);
> +			}
> +
>  			checkval = amdgpu_virt_fw_reserve_get_checksum(
>  				adev->virt.fw_reserve.p_pf2vf, pf2vf_size,
>  				adev->virt.fw_reserve.checksum_key,
> checksum); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index b90e822cebd7..f826945989c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -143,19 +143,27 @@ struct  amdgim_pf2vf_info_v2 {
>  	uint32_t vce_enc_max_pixels_count;
>  	/* 16x16 pixels/sec, codec independent */
>  	uint32_t vce_enc_max_bandwidth;
> +	/* Bad pages block position in BYTE */
> +	uint32_t bp_block_offset_L;
> +	uint32_t bp_block_offset_H;
> +	/* Bad pages block size in BYTE */
> +	uint32_t bp_block_size;
>  	/* MEC FW position in kb from the start of VF visible frame buffer */
> -	uint64_t mecfw_kboffset;
> +	uint32_t mecfw_kboffset_L;
> +	uint32_t mecfw_kboffset_H;
>  	/* MEC FW size in KB */
>  	uint32_t mecfw_ksize;
>  	/* UVD FW position in kb from the start of VF visible frame buffer */
> -	uint64_t uvdfw_kboffset;
> +	uint32_t uvdfw_kboffset_L;
> +	uint32_t uvdfw_kboffset_H;
>  	/* UVD FW size in KB */
>  	uint32_t uvdfw_ksize;
>  	/* VCE FW position in kb from the start of VF visible frame buffer */
> -	uint64_t vcefw_kboffset;
> +	uint32_t vcefw_kboffset_L;
> +	uint32_t vcefw_kboffset_H;
>  	/* VCE FW size in KB */
>  	uint32_t vcefw_ksize;
> -	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256,
> 0, 0, (9 + sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)),
> 3)];
> +	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256,
> 0, 0, (18 +
> +sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)), 0)];
>  } __aligned(4);
> 
> 
> @@ -254,6 +262,17 @@ typedef struct amdgim_vf2pf_info_v2
> amdgim_vf2pf_info ;
>  		} \
>  	} while (0)
> 
> +struct amdgpu_virt_ras_err_handler_data {
> +	/* point to bad page records array */
> +	struct eeprom_table_record *bps;
> +	/* point to reserved bo array */
> +	struct amdgpu_bo **bps_bo;
> +	/* the count of entries */
> +	int count;
> +	/* last reserved entry's index + 1 */
> +	int last_reserved;
> +};
> +
>  /* GPU virtualization */
>  struct amdgpu_virt {
>  	uint32_t			caps;
> @@ -272,6 +291,8 @@ struct amdgpu_virt {
>  	uint32_t reg_access_mode;
>  	int req_init_data_ver;
>  	bool tdr_debug;
> +	struct amdgpu_virt_ras_err_handler_data *virt_eh_data;
> +	bool ras_init_done;
>  };
> 
>  #define amdgpu_sriov_enabled(adev) \
> @@ -323,6 +344,7 @@ void amdgpu_virt_free_mm_table(struct
> amdgpu_device *adev);  int amdgpu_virt_fw_reserve_get_checksum(void
> *obj, unsigned long obj_size,
>  					unsigned int key,
>  					unsigned int chksum);
> +void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device
> +*adev);
>  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);  void
> amdgpu_detect_virtualization(struct amdgpu_device *adev);
> 
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
