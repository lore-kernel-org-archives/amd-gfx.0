Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AF6C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 02:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCBA20706
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 02:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xZuKN71P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCBA20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB4586E0EE;
	Tue, 25 Aug 2020 02:44:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AABAB6E0EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 02:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1/2l3q0rHnBXItolBUZJ296ncqfjlD+sI34CEUsJkGbYm7gKv/DYiB5KDSiG6mtMsFdfFGCvkJLxHRve8WdeZbh1xDVSgwu4wKV3i2sh/EoqkN18EVacoBDX7KUy1YLCRmv+a2EQc2tjIEp8tyjI8o7YMc5U3ovqPhgRd+1YrdtSSl9iP7HNRB/LVJYihGup0Hs198XIKQFaWHhBjPE6R2Jo6l5hQQmiHuklQ9yFQARrQH8OlViy/HXuUIDNkd4wF2VKBYlTzngWNudmXOJy3/P4B440b7sSLjby+dlNwQ94lsI+W/l4yd6YyNWcsCcwMtub5fmxf3t3u4bSGSj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS9gUcBLGf13VJruZhQ9bhW2pnOyQva7KF7vVI6qI90=;
 b=HWM3vaLLT8oj3AOQNgDOP2NApCkLW0Dn2qSN9iWxFTp+VwjLRclslbFZvxfMQRC22HBeT6g8Jxa/eLcs4TDaq9mPZvB4N4nvs8CRXJTTzQ+LxGFjUNva3C2JzdMHAdnfAfWWqJa+XjQ4unoy4W8sovCI+uoYCX0M7ubzbxpZw54r6Vds9DRqNWlPDjUujNmR7N+BikS0d3xp9f1QDd3V+MeBYb+RIe3TTkVmsn71Y2WgvKaecr9RadMM2518ubR7JRPREzBwF4r0VrOe8u6sVfMwM7iOZmc5aB7ZdiEgVc+47Qhu47EMBeQHWQom7roHWctxee6vNn91JKvPe/MVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS9gUcBLGf13VJruZhQ9bhW2pnOyQva7KF7vVI6qI90=;
 b=xZuKN71Pz1eXfRfaZDHtjQD7wGXnNqVIk57G1FTF8OI4F439s/pfldpdRRbWJXrpkFPSQRr+jSsORiFDt1gVHq0ZyhiZWiDJe2qK0FgkEt9z5YKuO+v6zB85O3XnYyncO6gGDg9ZkxD02Cj4F2rhpP5G0rWzCZDcvkpKkkpY5pw=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 02:44:48 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 02:44:48 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V3 1/1] drm/amdkfd: fix set kfd node ras properties value
Thread-Topic: [PATCH V3 1/1] drm/amdkfd: fix set kfd node ras properties value
Thread-Index: AQHWegILK6RpFD1Zb0mqRvJZfcrY5alHRGDAgADMcACAAA4bIA==
Date: Tue, 25 Aug 2020 02:44:48 +0000
Message-ID: <CY4PR12MB128766D293D46E47ED496F85F1570@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200824103337.2334-1-Stanley.Yang@amd.com>
 <CY4PR12MB12874D472FCF81CDA273C6EBF1560@CY4PR12MB1287.namprd12.prod.outlook.com>
 <CY4PR12MB1382B957E583417E8616C6FD9A570@CY4PR12MB1382.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1382B957E583417E8616C6FD9A570@CY4PR12MB1382.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-24T13:41:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=47137895-6c98-4248-bf0f-00006bf8384b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-25T02:44:46Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: dd46ae4f-ef94-4c8f-8430-0000b4b63fbb
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f6145f8-040a-45e5-ca44-08d848a0d53f
x-ms-traffictypediagnostic: CY4PR12MB1285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1285C186A1410FDC6768DB12F1570@CY4PR12MB1285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K5iSCMVwS3JF+5H8Fl8bLQ5CcOk2DG/Y+5PZxWOoLsFgsNK3zZKA4TvNmU7P1JvbgyHHo6PVUQblqHjVS7sjvgN3pVqA2sjyVbOH7RB9luDtC+U7XdkGxmcfX0sMn0eu+vMXtfhCV1bzVk/q75TZIDRpXw2FmK8sGvUChsvp5w+1xBKzEVprMdX2fDPhGBHzw2rjeUz7RzGSBekOciO8Kpiwfwm18A/xSiIWtIARuVvQMoWmyv9TcqJdppvAwBP4380ziJglQ/vGV456K1Dm8U7cwUVMuHAadp55Re18dQWrPotw0f2cI/McgoVeBPMj5gwcU0Dhbe1b4LMqWbRIXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(64756008)(66946007)(66476007)(2906002)(6506007)(66556008)(66446008)(53546011)(76116006)(110136005)(8676002)(52536014)(5660300002)(26005)(54906003)(8936002)(478600001)(186003)(86362001)(316002)(55016002)(7696005)(4326008)(33656002)(71200400001)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ei2ypScMAnBKIArvA/uYHa2QhYTFG3NCkyerx3ZP2pG/811IDo5WNw6YjEON0Jxj1ZV4CYDH7g3oWE4dp8XMn9SDZOAWajaycl288wKVQCFIBaNBqkhQW7nZaiosewEcqd7WtfWOd58bTZ/Vtg008hNLsCo7ICsGZoO9dPhEqzu0WNXd7Kzqs99Avz94Zy/yktXIzDhLLOsbwlor0MZw6zu0ACxyAbjq8Q5EKbLsEcG3Yp8X35M/0PMLPjX1DLqPyM4ksHS9UzAE1kWUaDbe3tyfajx6bPlp66Il9nbczyclAryVJmYk1WbQmS6Ruq/PgrPSXWTkuaLoQ7+9uZU3XMJBq4HuPaxXBi5qBQMMinDJHFv2GcIOk9FO+k6Anw6Gc8XY53F8ZZoWyXquy2JIfBbhD36dBqeUtkp6tNOCQlJPt4i6GQqBelU3Lr5cTLhyqgMB+GVVoCGrhwQCSePHLYmLXqcO+nm+rwqk4/4DEbXQ937xLviAYHpZKHKx3cN8VwoSTaxvKDOkS2TzryUxfu9n5Wxj+d+TvKnU+62gxzl1EItlI3exKvsKk28VwfgHi/+puxOE9gZRtlCOjrGkgqouX1WWlL447JlcZzPTdR508VKPX4h4WElRxgeICzh2l0TjBlrQ6AQKBzutzmmieQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6145f8-040a-45e5-ca44-08d848a0d53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 02:44:48.0370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rvnx/Xs/DUi+vTsVyc/3l3NVwEl/S9dcesO0gB4kJEUSWYNqXDC3Dgw8LADr5zQntmoDHjdmEEw4B3VautqkqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Tye, Tony" <Tony.Tye@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

amd-gfx-bounces distribution list is not correct. Simply correct to amd-gfx DL in mail TO line.

Regards,
Guchun

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com> 
Sent: Tuesday, August 25, 2020 9:53 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx-bounces@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Tye, Tony <Tony.Tye@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Li, Dennis <Dennis.Li@amd.com>
Subject: RE: [PATCH V3 1/1] drm/amdkfd: fix set kfd node ras properties value

[AMD Public Use]

Hi Guchun,

Thanks, I will fix typos and push it to branch.

Regards,
Stanley
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, August 24, 2020 9:48 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx- 
> bounces@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Tye, Tony 
> <Tony.Tye@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Li, 
> Dennis <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH V3 1/1] drm/amdkfd: fix set kfd node ras 
> properties value
> 
> [AMD Public Use]
> 
> Three comments inline.
> 
> With these comments fixed, the patch is:
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Monday, August 24, 2020 6:34 PM
> To: amd-gfx-bounces@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Tye, Tony 
> <Tony.Tye@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Chen, 
> Guchun <Guchun.Chen@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Yang, 
> Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH V3 1/1] drm/amdkfd: fix set kfd node ras properties 
> value
> 
> The ctx->features are new RAS implementation which is only available 
> for
> Vega20 and onwards, it is not available for vega10, vega10 should 
> follow legacy ECC implementation.
> 
> Changed from V1:
>     wrap function to initialize kfd node properties
> 
> Changed from V2:
>     remove wrap funcion, remove SRMA ECC check
> 
> [Guchun]Spelling typos, not funcion or SRMA. Moreover, it should be 
> more concise by 'remove wrap function and SDMA SRAM ECC check'
> 
> Change-Id: I1e3ff899bf066611fe5775e67104ce2e0bf8b7d0
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c   | 16 ++++++++-------
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 24 
> +++++++++++------------
>  3 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1f9d97f61aa5..573e2712df35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -986,6 +986,7 @@ struct amdgpu_device {
> 
>  	atomic_t			throttling_logging_enabled;
>  	struct ratelimit_state		throttling_logging_rs;
> +	uint32_t			ras_features;
>  };
> 
>  static inline struct amdgpu_device *amdgpu_ttm_adev(struct 
> ttm_bo_device *bdev) diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index cd1403f83dcf..d462244863f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1974,7 +1974,8 @@ static void amdgpu_ras_check_supported(struct 
> amdgpu_device *adev,
>  	*supported = 0;
> 
>  	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
> -	    (adev->asic_type != CHIP_VEGA20   &&
> +	    (adev->asic_type != CHIP_VEGA10 &&
> +	     adev->asic_type != CHIP_VEGA20 &&
>  	     adev->asic_type != CHIP_ARCTURUS &&
>  	     adev->asic_type != CHIP_SIENNA_CICHLID)) [Guchun]I suggest 
> moving all ASIC check into one static function. This will benefit 
> later modification if user adds more ASICs to support RAS, and it's 
> indeed more readable.
> 
>  		return;
> @@ -1998,6 +1999,7 @@ static void amdgpu_ras_check_supported(struct 
> amdgpu_device *adev,
> 
>  	*supported = amdgpu_ras_enable == 0 ?
>  			0 : *hw_supported & amdgpu_ras_mask;
> +	adev->ras_features = *supported;
>  }
> 
>  int amdgpu_ras_init(struct amdgpu_device *adev) @@ -2020,9 +2022,9 @@ 
> int amdgpu_ras_init(struct amdgpu_device *adev)
> 
>  	amdgpu_ras_check_supported(adev, &con->hw_supported,
>  			&con->supported);
> -	if (!con->hw_supported) {
> +	if (!con->hw_supported || (adev->asic_type == CHIP_VEGA10)) {
>  		r = 0;
> -		goto err_out;
> +		goto release_con;
>  	}
> 
>  	con->features = 0;
> @@ -2033,25 +2035,25 @@ int amdgpu_ras_init(struct amdgpu_device
> *adev)
>  	if (adev->nbio.funcs->init_ras_controller_interrupt) {
>  		r = adev->nbio.funcs->init_ras_controller_interrupt(adev);
>  		if (r)
> -			goto err_out;
> +			goto release_con;
>  	}
> 
>  	if (adev->nbio.funcs->init_ras_err_event_athub_interrupt) {
>  		r = adev->nbio.funcs-
> >init_ras_err_event_athub_interrupt(adev);
>  		if (r)
> -			goto err_out;
> +			goto release_con;
>  	}
> 
>  	if (amdgpu_ras_fs_init(adev)) {
>  		r = -EINVAL;
> -		goto err_out;
> +		goto release_con;
>  	}
> 
>  	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
>  			"hardware ability[%x] ras_mask[%x]\n",
>  			con->hw_supported, con->supported);
>  	return 0;
> -err_out:
> +release_con:
>  	amdgpu_ras_set_context(adev, NULL);
>  	kfree(con);
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index f185f6cbc05c..0ba960a17ead 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1239,7 +1239,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  	void *crat_image = NULL;
>  	size_t image_size = 0;
>  	int proximity_domain;
> -	struct amdgpu_ras *ctx;
> +	struct amdgpu_device *adev;
> 
>  	INIT_LIST_HEAD(&temp_topology_device_list);
> 
> @@ -1404,19 +1404,17 @@ int kfd_topology_add_device(struct kfd_dev
> *gpu)
>  		dev->node_props.max_waves_per_simd = 10;
>  	}
> 
> -	ctx = amdgpu_ras_get_context((struct amdgpu_device *)(dev->gpu-
> >kgd));
> -	if (ctx) {
> -		/* kfd only concerns sram ecc on GFX/SDMA and HBM ecc on
> UMC */
> -		dev->node_props.capability |=
> -			(((ctx->features &
> BIT(AMDGPU_RAS_BLOCK__SDMA)) != 0) ||
> -			 ((ctx->features &
> BIT(AMDGPU_RAS_BLOCK__GFX)) != 0)) ?
> -			HSA_CAP_SRAM_EDCSUPPORTED : 0;
> -		dev->node_props.capability |= ((ctx->features &
> BIT(AMDGPU_RAS_BLOCK__UMC)) != 0) ?
> -			HSA_CAP_MEM_EDCSUPPORTED : 0;
> -
> -		dev->node_props.capability |= (ctx->features != 0) ?
> +	adev = (struct amdgpu_device *)(dev->gpu->kgd);
> +	/* kfd only concerns sram ecc on GFX/SDMA and HBM ecc on UMC
> */
> [Guchun]Modify comment to drop SDMA.
> 
> +	dev->node_props.capability |=
> +		((adev->ras_features &
> BIT(AMDGPU_RAS_BLOCK__GFX)) != 0) ?
> +		HSA_CAP_SRAM_EDCSUPPORTED : 0;
> +	dev->node_props.capability |= ((adev->ras_features &
> BIT(AMDGPU_RAS_BLOCK__UMC)) != 0) ?
> +		HSA_CAP_MEM_EDCSUPPORTED : 0;
> +
> +	if (adev->asic_type != CHIP_VEGA10)
> +		dev->node_props.capability |= (adev->ras_features != 0) ?
>  			HSA_CAP_RASEVENTNOTIFY : 0;
> -	}
> 
>  	kfd_debug_print_topology();
> 
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
