Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371B7C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097932146E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OnKVno7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097932146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A972B6EAB9;
	Thu, 19 Dec 2019 07:38:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8AB26EAB9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 07:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rlr+8FheEmA1er94TyyVBXRIygYj1xMmxu+D92ow2C390hR5hxXVcgCXRxss2Nk82KQfTOdrY1iH3ZtNBn3dRju8TvxtBtzw7x9EQzPC0JP54jK5L5T+2ZcHmwZNdd4CuUnEhAc+zapZAaeuqXvsggcgNtTjiDSQEHH1IWH1V0jZO6WWcdjRDlkr5tMluDc9F8D3kAa7FBOwsQ9uNVbw64VRrICNG7JngOhZFa/nuWwjUtCtVUmrtSwuEuPUTIlArWKUBJNzagrt8BIzfZLSjggb6NYS6/ldzzrAPUEdLiGVsZSYTw4MaaIngxznrfJPLwqYkoTaHRfFYAOB9kFn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJqrk3Bg/v638b5x62tVABEpdtELNOPR4koqsTR+JLI=;
 b=n1p1FV/4BXfpW+rY2LtpfIsnpdAhpRHwfAoPVSnCZsMkTg0X+9SmAFCAbxfyLKj+eGzXMuKAOqlspXcjQ6/9ecxmz3lBuB9P1+E66r1Ta4y4tLCkp9jAI9x33w4NAY8qP657CI0+9wFIMnCFhq7gdA0uNYKyvX4D+zKBc716Pam10W+RjJNQZTYIfdyZuvoMSFNWXPqkBz+CYgt+48vcuTkM81yxZWgvZjLqMYqNrK7N9SUis/uybxVsPOZUdTWiuD5TI7kBsyD7g7v91fp6yGerwXpcBCJfJle0hrWP7jZgCvWCT+o9KC5XkoWMtyET6C9MF27nuCIv/aSiPrm0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJqrk3Bg/v638b5x62tVABEpdtELNOPR4koqsTR+JLI=;
 b=OnKVno7I8RxT5+9X1Gy3DogLMYiTKUiQU8qTTpFNh71+/q3kKDI9GDnBrhfTDjFU0IKGo2ZNGdZTczfF+xRuJ7nvuQvPztTVsJoMm04yE4CREmGstFt5whFfuKnjpuhNJgM7952sTYY1dAbwyPaNSzz5159Ew0Y+UAI2msaPeJg=
Received: from MN2PR12MB3743.namprd12.prod.outlook.com (10.255.237.225) by
 MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 19 Dec 2019 07:38:44 +0000
Received: from MN2PR12MB3743.namprd12.prod.outlook.com
 ([fe80::196b:de4b:eb11:ea6e]) by MN2PR12MB3743.namprd12.prod.outlook.com
 ([fe80::196b:de4b:eb11:ea6e%7]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 07:38:44 +0000
From: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Topic: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Index: AQHVtjfu8eZyTfiNzECEhKO7WVBCAKfBBrRQgAAFZwCAAARBkA==
Date: Thu, 19 Dec 2019 07:38:43 +0000
Message-ID: <MN2PR12MB374353EA92C06E93147F07D08D520@MN2PR12MB3743.namprd12.prod.outlook.com>
References: <1576737930-20998-1-git-send-email-Prike.Liang@amd.com>
 <MN2PR12MB37434D66DE4F972A1C29C8268D520@MN2PR12MB3743.namprd12.prod.outlook.com>
 <MN2PR12MB33090EA9087D882E30D957CCEC520@MN2PR12MB3309.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33090EA9087D882E30D957CCEC520@MN2PR12MB3309.namprd12.prod.outlook.com>
Accept-Language: en-AS, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-19T07:16:38Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bd59e76f-2715-4983-97c8-0000df5d4662;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuxian.Dai@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 019c25ad-40f2-4236-aa4f-08d7845679d8
x-ms-traffictypediagnostic: MN2PR12MB4285:|MN2PR12MB4285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42857D61192CBBB273F27F588D520@MN2PR12MB4285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:267;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(13464003)(5660300002)(66446008)(71200400001)(64756008)(316002)(110136005)(53546011)(33656002)(6506007)(66476007)(66556008)(76116006)(66946007)(55016002)(86362001)(54906003)(7696005)(8936002)(15650500001)(6636002)(9686003)(81166006)(81156014)(8676002)(478600001)(186003)(26005)(2906002)(52536014)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4285;
 H:MN2PR12MB3743.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pdvfFscEu5hdwrXyBLoviCqiZ7LmRhyqRDBzC0yr9ZGfY88U3ohhtOaxhFKLQ9phz+En6Xt7ErghqzoDLWqFJB0s5VlrMoDV/RA7sCuycJ6uFhsqpKYdBVAUvJAgq8zDjFT9P7yT2gvnOyMGZE3HxIqFNHOQ6v7u0lyksh5dN2VmpvuTKE+xcyEI269FV042xox/RDP+IcplNeft9CePU7xNKM3pJFAFCuBWNwCH0rJHFvG5c6BCeFaFsKB/Y6vMOzjOWJaEKrF2nZuM7fRcEz0jq3N/bTA22By/GsmHq+kLM6f7xe9LB3DPLRgdNU4jWuBXFLrZcUPV3abfG4MeZOJhGVW84e2vhUet2zKxdzFuLjtWKczs7az54cfERue/buyOnzHt1Jdxn7kp+dYONyS62QUxdIeMYpeeQ7ph+bopigq+vbBX4/60/bXSkfqqz+4CtlWfGyLcXmEX5ynJ4/jct3izsEymWLvAZaukm9kf8o9pJn4KpWdKkeQKf90r
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019c25ad-40f2-4236-aa4f-08d7845679d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 07:38:44.0202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8vzh03Bd9VWOBdbTjneYgM5Cf1KsVuURhHvcS4ORK+FO2TrEZyY79mLJkMtQ2f6q7TwKX/8SaD1YM0QJehKmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As Ray point out.  We should  set the SMU_MSG_SetWorkloadMask with specified value  to indicate unsupported. 
But  the current a value with system error value: "-EINVAL" 
The firmware maybe response with unexpected action to driver. 

-----Original Message-----
From: Huang, Ray <Ray.Huang@amd.com> 
Sent: Thursday, December 19, 2019 3:17 PM
To: Dai, Yuxian (David) <Yuxian.Dai@amd.com>
Cc: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode overrun message

[AMD Official Use Only - Internal Distribution Only]

On Thu, Dec 19, 2019 at 03:04:12PM +0800, Dai, Yuxian (David) wrote:
> For we don't support the mode, so shouldn't print the error message, or regard as a error.
> For log message, the error is high level .maybe change from "error"  to "warning" , it will be much better.
>  
> 
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
> SMU12 not support WORKLOAD_DEFAULT_BIT and WORKLOAD_PPLIB_POWER_SAVING_BIT.
> 

Probably smu firmware doesn't expose the feature mask to driver. Can you confirmware with smu firmware guy whehter this feature is really disabled or not in SMU12. If that, in my view, issue the message SMU_MSG_SetWorkloadMask with an unsupported state, it doesn't make sense.

Just work around this with one time warnning is not a good solution.

Thanks,
Ray

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
> @@ -550,14 +550,18 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_workload_get_type(smu, smu->power_profile_mode);
>  	if (workload_type < 0) {
> -		pr_err("Unsupported power profile mode %d on RENOIR\n",smu->power_profile_mode);
> +		/*
> +		 * TODO: If some case need switch to powersave/default power mode
> +		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
> +		 */
> +		pr_err_once("Unsupported power profile mode %d on 
> +RENOIR\n",smu->power_profile_mode);
>  		return -EINVAL;
>  	}
>  
>  	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>  				    1 << workload_type);
>  	if (ret) {
> -		pr_err("Fail to set workload type %d\n", workload_type);
> +		pr_err_once("Fail to set workload type %d\n", workload_type);
>  		return ret;
>  	}
>  
> --
> 2.7.4
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
