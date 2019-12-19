Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A47C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FAB2146E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XGpbvuSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FAB2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 404536E0E8;
	Thu, 19 Dec 2019 07:29:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5E96E0E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 07:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eORd0vrxFOwyq061lYbLHOzVqXsSsdo4kpdJXFGVNcVyWj8OwojcOHQJt72OxMVPwvGPVODbNnQlZsUi0RumtTJZnYYkiOaf2iwx+gdQ3q9z7f2O1z7ZLBx0o1vGf/AGikj8H1SKKalg42Cu6qRn83tWPBWe7oLqNWpaUhOkUP/9rmi509UrVWvdgKnfdReDb8PjoRkUjaNbumc163wqqtMDgoYVI7DWsaqNZIBtod+bce2humb+gr3akkQ+h/3GvcmF2Wl8GK4J/KwqQZ2ot8UpZZTUI96fzafHwpBIVrJFzYP9IlWlYsvi94oM9AaaRWwOI53xLWgo2r3INSLL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9nut6Qv0QxSWjlnb+MJgX57GT2O9GQj0dnbOmfYlKc=;
 b=V06MUa3dOIBxiG2ItN47hxLagm5f0QVT+e4BRONunyoouqeQmeU8ICLdJp+wv/7MCTC2LeGMZXvELiAKK9Et+X5ZR9SL7Qow0W2SQf4fw44T4OidKh0L8NPBF1BPftMSkoopzSR5r6h30aGYZSg1eNBd5m87IqEkmhfXMHO5pBmRwU7pbx7vRw7kwLxIDre+x9Hpq2B7ZKOuKwea1M26qu1971HZ4nhMKrb79KT2sJhSSSnv3oaprzSVFRFBgS42oi5Gh70o8W6gNdT2OMz1U9lhgO0UbZ4koL2vGSarqR1iLfw+R20yiq5C5NQ5EYKG1s6W+w0JCt6UhelllT+ACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9nut6Qv0QxSWjlnb+MJgX57GT2O9GQj0dnbOmfYlKc=;
 b=XGpbvuSsFRwj4GimBB+AjrnyUv0HTgBKsJNt3yiGCWaBeOp2WwoMPH8z42it3Gvbiq8E8kuqop82azrpcxwCbOg834QK/vOF5ghRk4FpcvQKu3wbIQIWiVD9DJeBxQizOolat4v/0ffQaFh04VlA8zZpfSZE/kppN/4KQIvpsSU=
Received: from BYAPR12MB3525.namprd12.prod.outlook.com (20.179.94.90) by
 BYAPR12MB3478.namprd12.prod.outlook.com (20.178.196.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 07:28:57 +0000
Received: from BYAPR12MB3525.namprd12.prod.outlook.com
 ([fe80::c930:bfdb:2507:b97f]) by BYAPR12MB3525.namprd12.prod.outlook.com
 ([fe80::c930:bfdb:2507:b97f%3]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 07:28:56 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "Dai, Yuxian (David)"
 <Yuxian.Dai@amd.com>, "Cai, Land" <Chuntian.Cai@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Topic: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Index: AQHVtjft3IM66jz+iEuHPdgCb79bbqfBCJgAgAADgwCAAAHnEA==
Date: Thu, 19 Dec 2019 07:28:56 +0000
Message-ID: <BYAPR12MB3525FBCD8EB0D17B6B994236FB520@BYAPR12MB3525.namprd12.prod.outlook.com>
References: <1576737930-20998-1-git-send-email-Prike.Liang@amd.com>
 <MN2PR12MB37434D66DE4F972A1C29C8268D520@MN2PR12MB3743.namprd12.prod.outlook.com>
 <MN2PR12MB33090EA9087D882E30D957CCEC520@MN2PR12MB3309.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33090EA9087D882E30D957CCEC520@MN2PR12MB3309.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Chuntian.Cai@amd.com
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-19T07:28:52Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e0038290-e3ce-48f7-b9bf-0000e9053039
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 262432a8-c1d2-4400-12af-08d784551b6e
x-ms-traffictypediagnostic: BYAPR12MB3478:|BYAPR12MB3478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34780BDB4C92D0AED0A6122CFB520@BYAPR12MB3478.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:267;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(13464003)(189003)(199004)(186003)(15650500001)(71200400001)(2906002)(26005)(478600001)(52536014)(4326008)(6636002)(5660300002)(8936002)(81166006)(81156014)(8676002)(6506007)(53546011)(66476007)(55016002)(54906003)(86362001)(33656002)(7696005)(9686003)(316002)(110136005)(76116006)(66446008)(66946007)(64756008)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3478;
 H:BYAPR12MB3525.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C69ys6VJYgaWarBcTEfAWZZ5dL4EhHXJk5pbNC41KHRd7nd0lllX484YT32wBi4w4URK7mq+R1K0wIfdKd0h1+pjdXronkGoZ6jhaDVitIT0Uaml/e/N+7lTB8SZi/JE7SyXsOsJyVDOvM+28HShV2I209fP1wF//mgXt2Pm+8YucLf4nonVIcCLFreCGHQt8E8zck1ar4W7DLYRnSpguvqzEJ7BEHagD1wR5g2UKqoEz/WMxXwfJrHt22e7BPMpYZjb84Go6dafBgGJLM9CsB4U3TgQRepLVxiPe9QG3zjeCEDNH/Vx4qSVkJ9kKqdCsVJUS/T+O6IbUggXolbSJHiqRmzUNZ4K2l1dO7/KSRb1GuA5AffjSP5zTri6DDc4tkf61tF2uN+4sP55dNoFkf3HCoLtd2QDhLzNm3RrX0bnheqcxHBBX8AyQupLqxjPXxFBaLBSlfh/8CFl22X1NFzZ4+5A+Hv7ltghA90tbkdEsQV3YLq55comn6N5DiFp
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262432a8-c1d2-4400-12af-08d784551b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 07:28:56.2170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBzxZ70UvBivKfL/FoxzeQUo4bnHsAObYD+bgZbTbBIIE2Nwski9UagUwe7HI1lI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3478
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
[Prike]  Yes, from SMU FW guy @Cai, Land  SMU12 not support default and 
power saving mode now.  As the patch TODO item said we can consider switch to
compute/customer profile mode for power saving if needed. 
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
