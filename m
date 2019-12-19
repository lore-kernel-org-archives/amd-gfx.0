Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7319DC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F8F222C2
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pL+DAJ6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F8F222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054B189E2C;
	Thu, 19 Dec 2019 07:00:28 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700085.outbound.protection.outlook.com [40.107.70.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B09389E2C
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 07:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2BXsZ1xsxwELfFe2FNACaVkwIbFtu7ij+qyIXhIdsxFzd1CVlFOLdtrsTvQaWtkubJ1jMGFAgL1ts9mhPjrSsfCXHBKpI2DMkW53WZvCtlWxq6HfFqooCze5UwK12exaGRjBCWhgK5ApxZEDet/N5YceZ9BwhEGJbWd67phWHybY0or4feSqJNaaBT1uQbnUs3l1Z16id9DWiB+ObiieKo3CH619VOsyz39HlcP5ynlRsXaesiMKtgEK2EZtbgg9e6skrVVGHzuv+K7ZRlIWPreESeoSbFyxFVVD5F+bImn73GT76VusmaXVTQ0pR3ZoEyDcDGGF44vNnE/G/Jc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cScvAff2CQNEpVuM7AKodgIarljT51W5ON/3om79xWA=;
 b=oXeO811rwp2+BjitGLAhqHkpdVAAakKcpNCle+5BZ/0bPaGevvMlJjbmfzOSWMTE/L1ADZ50J2wEtMGYMlWlwJDLblljXGq9oEQDJRyFpV97qif72bGD1RnelP71EgxhhRHzensofJ7BQ4Dpr/jrmdZTTM+VbCMdZrcH/Tv29atY1z7g+bzxYhvNKC42Mtn4zi/turrybsh4qu1ZcZP70sKhyZjHe08YvEs1I8ZpdvfWPF1GilSsnsVcI0RjFH99223yoPSOUTT3ylYgAJQnIOEjXJw3X9jUWEsFi3Bpq8XOVXl1Tb4/4Udi9Rub/Cbec0F+tFnHhtNIAQW/rr9Ksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cScvAff2CQNEpVuM7AKodgIarljT51W5ON/3om79xWA=;
 b=pL+DAJ6MPFA6lMK+Xl+9pGqU9OtDeE+BqFnClAqIjtgeOWSxPgKm17aObfXM7ZqFdSE9rxJ36qoWMh9eJKPYyG0wWI98hp3ms7yf4Z3ipUxmu8IGcF7dX2fCtDmmGFymySLwCqQVAI4jWeUCKlYfEkgWoVWo9D/vmCzQioC4JmU=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3582.namprd12.prod.outlook.com (20.178.243.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 07:00:24 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 07:00:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Topic: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Index: AQHVtjfu88ZYtExvh06rRwZtBvyFy6fBB2TA
Date: Thu, 19 Dec 2019 07:00:24 +0000
Message-ID: <MN2PR12MB3344B54D7BABC30F323E0A9BE4520@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1576737930-20998-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1576737930-20998-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=eba057da-e1ea-4f37-afb0-000091213496;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-19T06:59:54Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 837b55b6-009b-487f-90f2-08d784511f4e
x-ms-traffictypediagnostic: MN2PR12MB3582:|MN2PR12MB3582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB35828C3CE1DA5B558DC2E1C6E4520@MN2PR12MB3582.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:28;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(13464003)(189003)(199004)(71200400001)(15650500001)(4326008)(52536014)(86362001)(478600001)(2906002)(110136005)(54906003)(5660300002)(33656002)(316002)(8676002)(81156014)(81166006)(53546011)(6506007)(186003)(26005)(8936002)(7696005)(55016002)(9686003)(66556008)(64756008)(66446008)(66476007)(66946007)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3582;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNpMowsBmd29hogKvPqrZxrf/vfjdHBj+CgncBxNqYcb56ZyKP0Ua28ufi+KFJkfjoyJ1ZCJgskj3dYXCZauxg9n+yrVRAanfukoIYAfUfRAdhBA9BinhABLlVY5am+QI2Tn4rSmKnctmgOLJIkbBhUD1c9aYTxk9HPfJYizRTI/ad8jSKp8f3KbILBnyJB/l+1dMkV9IKuQuMbBg17uz4qrAqWLevwP8tBW0xYR/sqzcjHepOUxOPtq0oOEqPBlLkItAiki8rtbipYqJjMapGzfTF9sNjXg+jfNLcQ2EI/kDJdENUZs+mgOOXTnoPHFFRGyffCsQ/LJlBuDXWUaAPm0Odf1MhrDLJPucyGYPp42YgJzzblDvaL8xkKcuik+LGqskE6Bw31F3kzIOAj6JjfA3tt11JlfVLlfOMQjRkhy+PS6vkpZm4+Fb/yB8GYTXVs5CXgLQNtWiwr4xdilCDK+rHlBZkNMHaFkDqBurxGufgAsmqcKZYCPrU4CSpis
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837b55b6-009b-487f-90f2-08d784511f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 07:00:24.7525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqojPvLdjK7v9GV5ZEjERRkB3aMouuJVLiLwXsgoetaDvosFXqiGa/z1817cXivn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3582
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Dai,
 Yuxian \(David\)" <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, December 19, 2019 2:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Huang, Ray <Ray.Huang@amd.com>;
> Dai, Yuxian (David) <Yuxian.Dai@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
> overrun message
> 
> SMU12 not support WORKLOAD_DEFAULT_BIT and
> WORKLOAD_PPLIB_POWER_SAVING_BIT.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 784903a3..f9a1817 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -550,14 +550,18 @@ static int renoir_set_power_profile_mode(struct
> smu_context *smu, long *input, u
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_workload_get_type(smu, smu-
> >power_profile_mode);
>  	if (workload_type < 0) {
> -		pr_err("Unsupported power profile mode %d on
> RENOIR\n",smu->power_profile_mode);
> +		/*
> +		 * TODO: If some case need switch to powersave/default
> power mode
> +		 * then can consider enter
> WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
> +		 */
> +		pr_err_once("Unsupported power profile mode %d on
> RENOIR\n",smu->power_profile_mode);
>  		return -EINVAL;
>  	}
> 
>  	ret = smu_send_smc_msg_with_param(smu,
> SMU_MSG_SetWorkloadMask,
>  				    1 << workload_type);
>  	if (ret) {
> -		pr_err("Fail to set workload type %d\n", workload_type);
> +		pr_err_once("Fail to set workload type %d\n", workload_type);
>  		return ret;
>  	}
> 
> --
> 2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
