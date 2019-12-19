Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503EFC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D4A21D7D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KAPYY8JB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D4A21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B80B36EAB9;
	Thu, 19 Dec 2019 07:46:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770047.outbound.protection.outlook.com [40.107.77.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47086EAB9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 07:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBxjtx4cu7QBYyiVjFdxEKtAvM/07YyEwwOraPt9mwBn1S+VLjofvGvKurUysaIBDzZKA6l1yKLu0Ah/9hQhCSrtWdXBWqTKQYYbfr3WNR9MFwzguxeI4JykCTUF/gm0ZCZBeGct9T6bPtaik2q45p2B4dX7502E1VNxVKXUvgcquOnMpv2lMEKL5QiB2cDLfzo2OMX5NpZAljovdXMw6jUI0S4kD4r8gHoSlvwDdeZpqNHZ2XgffgnGaUUlnqk5WdqdqywxBur6e5hHF4USUCPhHwVfcr1Y/Ak/v+J8HTf7wyOYEbvE8EOXpCvHQa1CRSmeg3Eatm5BGB6scavSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AkmJn+0iSrTHqVpNhl0evly0mZFC7ZeyIKhnqkoFf4=;
 b=REzZW8fQ1dpUrgxJD2DtV21vkJVAld9QbLA0HEKDEUGgc3p+xa9qpR9izO83CHqdCyfUMd33Z3HulFYcCcadt63NDOB/2inevSsgxIccsGXjMUGBYQeYEznMOBpixSnXyaVa3LL2R6uyh4IFHvVcgEC4Wc4xRvLhZ5QcuJuQjiIYYuXbzcYlh6WGtBf/v+XxJy3vZS/vOZb0o9+8fGeDbMclNQ4RZOjJ/Q1SOaZ/76vBRodKG/ahdgFz44rJniaq6pB/MQRHWfBiM0evIgtLILpZuAMsRGzh4+kmTqiLqJK35v4WtNAyaEYY+jCkep18c8rdz4HP60ZSLVs0WjZ38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AkmJn+0iSrTHqVpNhl0evly0mZFC7ZeyIKhnqkoFf4=;
 b=KAPYY8JB5gC+V2ledPhWRQpRvRgOmzPyNYzT+PVIflp0Cu78dQO10INkSMI1lxBS+OoRNH2s3z9HnOEeR4nerDvq5YPgetHoPncbCBnLZfwAcxMxajIzZZoLePcF/7qFUIZyj7Tp+mpBsRomsT3gLyePxe9nzqul65/vqQQG8b0=
Received: from BYAPR12MB3525.namprd12.prod.outlook.com (20.179.94.90) by
 BYAPR12MB3160.namprd12.prod.outlook.com (20.179.92.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Thu, 19 Dec 2019 07:46:05 +0000
Received: from BYAPR12MB3525.namprd12.prod.outlook.com
 ([fe80::c930:bfdb:2507:b97f]) by BYAPR12MB3525.namprd12.prod.outlook.com
 ([fe80::c930:bfdb:2507:b97f%3]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 07:46:05 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Topic: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Index: AQHVtjft3IM66jz+iEuHPdgCb79bbqfBCJgAgAADgwCAAAYigIAAAWig
Date: Thu, 19 Dec 2019 07:46:05 +0000
Message-ID: <BYAPR12MB35255B9BC5F789157A1C3C76FB520@BYAPR12MB3525.namprd12.prod.outlook.com>
References: <1576737930-20998-1-git-send-email-Prike.Liang@amd.com>
 <MN2PR12MB37434D66DE4F972A1C29C8268D520@MN2PR12MB3743.namprd12.prod.outlook.com>
 <MN2PR12MB33090EA9087D882E30D957CCEC520@MN2PR12MB3309.namprd12.prod.outlook.com>
 <MN2PR12MB374353EA92C06E93147F07D08D520@MN2PR12MB3743.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB374353EA92C06E93147F07D08D520@MN2PR12MB3743.namprd12.prod.outlook.com>
Accept-Language: en-US
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-19T07:46:02Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 011a6d17-321c-4986-b567-000078ca482f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2cd2304-4d50-4cbb-744c-08d7845780e9
x-ms-traffictypediagnostic: BYAPR12MB3160:|BYAPR12MB3160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3160183ADB7E48D63C90ADA6FB520@BYAPR12MB3160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:316;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(13464003)(66556008)(86362001)(316002)(478600001)(66946007)(6506007)(64756008)(52536014)(66446008)(15650500001)(76116006)(2906002)(186003)(6636002)(26005)(81166006)(8676002)(33656002)(8936002)(7696005)(81156014)(66476007)(55016002)(54906003)(71200400001)(9686003)(5660300002)(110136005)(53546011)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3160;
 H:BYAPR12MB3525.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VOMUfvYCDi1mfVadCuiM/mAacGNAQSDZ0gm5gjIaa8MibdkCASkEhCOFWA60jyOxPUlkOZshfqiu/D9B90GelYPD8OirQrTZSIv4aGWuAMzzZ02GpRRFXwDCj+gr1ZMybq2Uci10mpfIsV0cttbwuVSTRqQQeB9Madl99qQeHoS8RafnVdpxbSrAj6MO5+5KifpAIHVxqmUfrNq1zsbV89QyvVsr3tGyI+yuu3U/10BrBuKd1tJIvO5ASApkzOppHaTKfdHwKlSTW+2hNsZrxCuxptw5zccdNaTO6gKZyP6VaBkUcZkqIAJbNLmErdnroOLw0193EYwBIN2FoOc0GbnOQgy9v+kG9c1Mv0weyRt5Gpho03lIufzXX4N8tVAB3Oa1rf90jCzQcft6HSpcxMuab20w1xGHSSbwWjOiW28cP8HDGXnHYspyrJABG+R86cQFiLC7WXYvsU+X1dfO2c1+xCowNo3KvZOTs96VO6CgrnTBOoqWenrwSasxnRIM
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cd2304-4d50-4cbb-744c-08d7845780e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 07:46:05.3700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqgnbhHuy/8HOYyBzk89kqzHml7S+wPtvBcvhY6PGAk92TuhLO0zMYYdmdQT6ttg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3160
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

[AMD Official Use Only - Internal Distribution Only]



> -----Original Message-----
> From: Dai, Yuxian (David) <Yuxian.Dai@amd.com>
> Sent: Thursday, December 19, 2019 3:39 PM
> To: Huang, Ray <Ray.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>
> Subject: RE: [PATCH] drm/amd/powerplay: suppress nonsupport profile
> mode overrun message
> 
> As Ray point out.  We should  set the SMU_MSG_SetWorkloadMask with
> specified value  to indicate unsupported.
> But  the current a value with system error value: "-EINVAL"
> The firmware maybe response with unexpected action to driver.
[Prike] If get nonsupport profile mode will exit and not issue any you mentioned error value. 
> 
> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Thursday, December 19, 2019 3:17 PM
> To: Dai, Yuxian (David) <Yuxian.Dai@amd.com>
> Cc: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org;
> Quan, Evan <Evan.Quan@amd.com>
> Subject: Re: [PATCH] drm/amd/powerplay: suppress nonsupport profile
> mode overrun message
> 
> [AMD Official Use Only - Internal Distribution Only]
> 
> On Thu, Dec 19, 2019 at 03:04:12PM +0800, Dai, Yuxian (David) wrote:
> > For we don't support the mode, so shouldn't print the error message, or
> regard as a error.
> > For log message, the error is high level .maybe change from "error"  to
> "warning" , it will be much better.
> >
> >
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Thursday, December 19, 2019 2:46 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Quan, Evan <Evan.Quan@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>;
> > Dai, Yuxian (David) <Yuxian.Dai@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>
> > Subject: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
> > overrun message
> >
> > SMU12 not support WORKLOAD_DEFAULT_BIT and
> WORKLOAD_PPLIB_POWER_SAVING_BIT.
> >
> 
> Probably smu firmware doesn't expose the feature mask to driver. Can you
> confirmware with smu firmware guy whehter this feature is really disabled or
> not in SMU12. If that, in my view, issue the message
> SMU_MSG_SetWorkloadMask with an unsupported state, it doesn't make
> sense.
> 
> Just work around this with one time warnning is not a good solution.
> 
> Thanks,
> Ray
> 
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> > b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> > index 784903a3..f9a1817 100644
> > --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> > @@ -550,14 +550,18 @@ static int renoir_set_power_profile_mode(struct
> smu_context *smu, long *input, u
> >  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >  	workload_type = smu_workload_get_type(smu, smu-
> >power_profile_mode);
> >  	if (workload_type < 0) {
> > -		pr_err("Unsupported power profile mode %d on
> RENOIR\n",smu->power_profile_mode);
> > +		/*
> > +		 * TODO: If some case need switch to powersave/default
> power mode
> > +		 * then can consider enter
> WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
> > +		 */
> > +		pr_err_once("Unsupported power profile mode %d on
> > +RENOIR\n",smu->power_profile_mode);
> >  		return -EINVAL;
> >  	}
> >
> >  	ret = smu_send_smc_msg_with_param(smu,
> SMU_MSG_SetWorkloadMask,
> >  				    1 << workload_type);
> >  	if (ret) {
> > -		pr_err("Fail to set workload type %d\n", workload_type);
> > +		pr_err_once("Fail to set workload type %d\n",
> workload_type);
> >  		return ret;
> >  	}
> >
> > --
> > 2.7.4
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
