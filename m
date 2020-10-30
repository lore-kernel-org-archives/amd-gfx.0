Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBC9C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 14:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28AF20727
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 14:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IcdNApXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28AF20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C21E6EDC6;
	Fri, 30 Oct 2020 14:58:30 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760042.outbound.protection.outlook.com [40.107.76.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418AB6EDC6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 14:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDweFVUzsUpmuWXHUM28t/57AWFsOuHXVQjRpaKxjxFrI3pZSN/kpTG8jrhrFZD/566MRNJ74tIu44PHXAf3248eHOF5Oimp+a6BrQxKyzmFUHr7+OLgxm/FICfOw4FnQQRS99v2bNW5ov5Pz7ZT1UJmHWH0z62qYD5ybb9Fqd2pMxtjiidOeM0M6T5ta0eNME33OULDmgw4/kty/YAECU2Pb9RwHn9JopdwX8mDsT650q0S/aO7l83/PCg0l3sdq0nWKVxBAcZwhXyEgqhWlZssA4if5DhaXG7QArIPsXKdHT57JKRCvFwPXDp3Ineef+l+TQUt/5Sl1X984MZg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfTm4G17PTulmiySaAQaigTYpfg+MH4W20JvjuTkHkw=;
 b=BR4JqHGBf73pxyjUZzPP4AaEFxlm9x0LuS8uNUAJGoBJZdkVbUKkynkcnBEhEtOP6eH916a6ZnMWI2fnzXYRVtK5VS+A5FFZcB7TAQlIrHFIA4T4/NxaYcpnDGpCgtjoW0hLJqYNTkuwRwH3VWFiLBcXLGW7CxD0GvVXfKZ7hXhOdNaalG066YthhuvUOFhcWEbd6enRYfs0bYDH90WNA1X5GKoIt2E/oxVMlD8CeBSUuz9Fp5uRrx8M3jAXAjfVyGh2Y5XmKfECFUQvmZCLYA/Ggv4eel9x3t1q+tBkTMPHfjeu29zlExa8VRNRNi8trHc3vt9RmxHfm66XWD0+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfTm4G17PTulmiySaAQaigTYpfg+MH4W20JvjuTkHkw=;
 b=IcdNApXQFpzVr1IDkFoYdlkfglkvgyiz3TfcboLrEcq0AlP/O0xIfmf++HgNl57fhYWYgcitDEUGHt0XaU+BDWWEtFf8WS3VD1LkaQAnveUc875eotXVIgdfnvAeG7puPN2ao0ktleCqzvHtxjIt7fEvdAyGCqCLnPMCc+7nQCA=
Received: from CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 by CH2PR12MB3992.namprd12.prod.outlook.com (2603:10b6:610:29::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 30 Oct
 2020 14:58:25 +0000
Received: from CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::85be:93a4:6d6b:e7b0]) by CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::85be:93a4:6d6b:e7b0%9]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 14:58:25 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable gfxoff if VCN is busy
Thread-Topic: [PATCH] drm/amdgpu: disable gfxoff if VCN is busy
Thread-Index: AQHWrrEMx+60az50EEST8k6m6Yua4amwHX0AgAAfJ/A=
Date: Fri, 30 Oct 2020 14:58:25 +0000
Message-ID: <CH2PR12MB4326C0C598330DBD6ACF4C99EA150@CH2PR12MB4326.namprd12.prod.outlook.com>
References: <20201030113710.14291-1-Jiansong.Chen@amd.com>
 <2a04ca91-5999-bbc8-e9cd-7820b7868696@amd.com>
In-Reply-To: <2a04ca91-5999-bbc8-e9cd-7820b7868696@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=040ae907-40e7-4bc7-8787-3d6b74279c75;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-30T14:57:40Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.195.2.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b380d64c-067c-4ea2-7f3c-08d87ce440ec
x-ms-traffictypediagnostic: CH2PR12MB3992:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3992A2D7843EE5A5765601BBEA150@CH2PR12MB3992.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7GymtOozJmFfl+nXkukxGOINz3LIS/BpxMYGxzqj6LSK8PrVMQU5Y/sqOyLX/UkG+11fT9xkYr5SxH6sbJgi1FfUDolPm5Uprq//tnoklVcotVvhD/PaYUcHkXLXuXTZJuuXohnmJ6p1ms2D1nX03fQSZFqOuEkUK5kIjMoqkRyyVucaWKXUyzpkS/e2SwGtIBcf37jaCs2SosBAGPUppFWwn2go2Bfn7YMoRCiMTEi+v+L9npjIuwhe9CD62VU9iKZTDSG8bYXrHAMKQTlQkHKXcV7BN4wqoHQfEmhD84wstN5YNSx5hud3C51tLaT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(83380400001)(4001150100001)(71200400001)(9686003)(55016002)(478600001)(76116006)(5660300002)(4326008)(2906002)(8676002)(66946007)(7696005)(6506007)(53546011)(52536014)(186003)(66556008)(316002)(64756008)(66446008)(66476007)(110136005)(54906003)(26005)(86362001)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: e9JoFe4UHfnzN1foU4y6Bvlz9rOKC0Fj+Y2x7ErUYb2bqFuK+WF8NiNqthvtfFNdPGEkdL2cTJswWDSF5CBUxnz/cHk25ChFDpQ/IyGYceH7GscPAcgZAaOVEjQLR+9EjaGyfQlNuc4DoZ5ywAnnQ04Aj9AHyTDsD4IDga6Z9a7yNFq807z5i5XU59EEU22bYqVlVbrkWgOVl0z7V5RhuzLXt/ZBeEIlc9nmqdsm3ZM1IJjTFTFCGFRpwSz88tePkigjVEhrAgNBdttJiwOfCjMNl3XUz3Ze5j+kBZ+zMndSrR+uWD2HbpjUrEoQKIBjcSJ56bLR4aLQgNlBj/Znr2AYrldz6rTJZp74CnG1pyBYGmQeWY/5CA+0ckgUd3TTAf/g2INNAVX4tPseiiwcywcDavhuvTo0dIVg6v7Rj9dfu7Hjz6dRlNTOCRs4R3H5cxU9Oc296+k5+gw9yk0+HRfAVU7sdJRGui13UyfRZb9ux3FpIis6kvwP8wFfYyvWCkj70JXQPIG+uhvbTzzAioZpvoNVYTZVT8hLYMVL1s7EuLtZ1wdR+UHy3WDsMfVKDty83OwfekaU3aVoTDWwxhOHbJSmp1XAB/NXF4dGVQC5fp7KPp41Xr3pVjCc6fK6yGZizAQUdppfhoYoxUnZUw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b380d64c-067c-4ea2-7f3c-08d87ce440ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 14:58:25.5105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bLCXtOKePgApN7wErBauSERrtp5CZjpk4PuW31tWFtrM5tDflaK7M0b44SyufMedRcLkiP5WaUGTUA/IOt9mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3992
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi James,
Thanks for your input, v2 patch is sent out.

Regards,
Jiansong
-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Friday, October 30, 2020 9:06 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhu, James <James.Zhu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amdgpu: disable gfxoff if VCN is busy

Hi Jiansong

Pls check inline.

thanks!

James

On 2020-10-30 7:37 a.m., Jiansong Chen wrote:
> Toggle on/off gfxoff during video playback to fix gpu hang.
[JZ] It is a workaround, not a fix. Also Arcturus needn't this WA.
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: I5b938c446884268c2cda0801121a53da980e603a
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 277a8435dd06..444b89413232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -358,6 +358,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   }
>
>   if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
> +amdgpu_gfx_off_ctrl(adev, true);
>   amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>          AMD_PG_STATE_GATE);
>   } else {
> @@ -368,13 +369,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   struct amdgpu_device *adev = ring->adev;
> +bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
>
>   atomic_inc(&adev->vcn.total_submission_cnt);
> -cancel_delayed_work_sync(&adev->vcn.idle_work);
>
>   mutex_lock(&adev->vcn.vcn_pg_lock);
> -amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -       AMD_PG_STATE_UNGATE);
> +if (set_clocks) {
> +amdgpu_gfx_off_ctrl(adev, false);

[JZ] Move the above two lines before mutex_lock(&adev->vcn.vcn_pg_lock);

Since it may cause S3 test failure.

> +amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +AMD_PG_STATE_UNGATE);
> +}
>
>   if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG){
>   struct dpg_pause_state new_state;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
