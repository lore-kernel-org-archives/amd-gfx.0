Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647C4C10F25
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 00:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317D92146E
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 00:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CG3t4/x/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317D92146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE3E6E5BD;
	Tue, 10 Mar 2020 00:05:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0F46E5BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 00:05:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3HxEMWqd/IbLED+XLjr+6T5rxbdySkgz+X7FywLcfTL311HTCuqI4K/qB4KoAe4Le7t4a3Cl607xqT45p787eqEAktUtiNCNNvNI3+kA7cr7y/Siuy0U9b1/80FAXitlR+oWIE3pf+u1BBltwO10sxY4bCVrf+73QhF2Bm+lVG/ni13JVc8pf/tIp2diDfUMRD+a1Fsr8LJOCSz0tmPyJ436XdPXZ7H14u43s6t9wKXWQDg/1n9q0dnnvIFtK/EXRsncnAqRN4B5RK+mSM9xUcbXKaVYuHL7QdafwpeDPbV74HAd4AHZ4MRZ1IRDea89MNC/6imygDjVBEiVe61DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pTKSuwc3JSyLexvMs9SMlGYoLV3Dxzo29wIv4PWGj0=;
 b=DybAC/MqmDtQdQTKqHdhIXOLiLjXGagE/ltPl8QVrTrzFlxh11rrDWmblTe4gOM2Msau3Cw7fBn7ZSu1md22r8o978bVRcyy6VNUzgZRHnJ50XbkIVOAPMdweXhWzZ1R7Nb8ol5S6MNtCUFxlsTeC/DqamaRUaavEaWvxG+s1QvmnUjH6QsK3K6ozwdg5bl3BlI1i+FP3OFUAjwVg2L0oAJPmCufwfHS1g8S+DhyF4bmXlKugxdE+lbUGvIryvtvGeg5dSvB0IX/SBkjBAC/2UaWTpuMrPRmO5/YYxRKb1xUxv1zn2Nv6mQm/a6evcv+NUqvOp4LNTRTj5lF7rnuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pTKSuwc3JSyLexvMs9SMlGYoLV3Dxzo29wIv4PWGj0=;
 b=CG3t4/x/muvRWeCmfSbW8tad4XnumUwsBIJz8omMkHEaoaO+eLzNXzUClPwN0FgIaafzEmJmSJZxxU06oBSMKl1Jb7nSDUG7LbbvSMeku12BHMbDhR0/sgwjFuOMewKD3Ak8xvXXf0QfBZ0Rnn0mNB4G/Tt5tl/T/I2nbrBBwlM=
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB3504.namprd12.prod.outlook.com (2603:10b6:208:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Tue, 10 Mar
 2020 00:05:32 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 00:05:32 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH 1/2] drm/amd/powerplay: fix pre-check condition for
 setting clock range
Thread-Topic: [PATCH 1/2] drm/amd/powerplay: fix pre-check condition for
 setting clock range
Thread-Index: AQHV8dCR4Fyuw7ccNkqWhAaOESlJDKhARJoAgAC2UCA=
Date: Tue, 10 Mar 2020 00:05:32 +0000
Message-ID: <MN2PR12MB3536F3235E54C55E4F109859FBFF0@MN2PR12MB3536.namprd12.prod.outlook.com>
References: <1583290538-30426-1-git-send-email-Prike.Liang@amd.com>
 <20200309131034.GA64875@google.com>
In-Reply-To: <20200309131034.GA64875@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0adf0d99-034f-47d3-bdfb-0000d0df301e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-10T00:03:06Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
x-originating-ip: [139.226.16.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 820daf1f-2a03-403f-1049-08d7c486c039
x-ms-traffictypediagnostic: MN2PR12MB3504:|MN2PR12MB3504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB350420E3FE8FB486DA890C99FBFF0@MN2PR12MB3504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(199004)(189003)(6506007)(8676002)(8936002)(53546011)(7696005)(6916009)(66556008)(81166006)(81156014)(66476007)(64756008)(86362001)(66446008)(66946007)(76116006)(26005)(33656002)(186003)(52536014)(5660300002)(2906002)(4326008)(9686003)(55016002)(54906003)(478600001)(316002)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3504;
 H:MN2PR12MB3536.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Afhr9gb6CbFrL7QBZRBG01YX5CXScsKMQthuYFPEzFYHCJdI3/nVPqZK4QZhCVnlwZCFVKIRT0epm+0x5ajLmIZ+1+y6wqakSJc1B7eXZ0rGIt1LGoXZhmmUPT7AfAyu1SHnAENab1Ahow79tRh9/vH80LN9psGWauuU2DPwGmnXAV2i7244hzx164IGIAdgErFHEbpujoknw6POmpi61uk1nphdJmfMpf6UQkQHt3Q1TfwuAFKNNdPU3tFseia/GrR9A+AB9DWvz6SiPbgCW8v723zoEPX0K70DPeyJf6l4y35V6UypytDi1X7w0woysm+UM9zbrYodUH5WvKTq/6WuazWqrRXj3J/NU7iTedYCzIPIjSsp4nv0IFXfmlULUiU48cLu4l0iVVvXtM/+QJw27ct9sUw3SpCpDopAkBh/3dwHyQLHyKccQqj9a+5q
x-ms-exchange-antispam-messagedata: bYctPYCiPZQKYZyHZjrCnE05G6WeSGfIyZWFn+qqbflJYELV/8DdzlFmAgfKn4lcIbdSP4Dh2lYGsp6gF4o+7uYwfOSQSmcv7ZFl3CBVDPM0SkFumZ4UmK+4Ip6BIG2VP14/wIvz5gWpO8tqM11Ycg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820daf1f-2a03-403f-1049-08d7c486c039
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 00:05:32.3552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDf/3x01MTwTvjSIXoVJUDU8Fok0cvL3riAIESiGJcLiumM1c13FfquEiF4rY7Bc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3504
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "linux-kernel@vger.org" <linux-kernel@vger.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, March 9, 2020 9:11 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>;
> Huang, Ray <Ray.Huang@amd.com>; linux-kernel@vger.org; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 1/2] drm/amd/powerplay: fix pre-check condition for
> setting clock range
> 
> On Wed, Mar 04, 2020 at 10:55:37AM +0800, Prike Liang wrote:
> > This fix will handle some MP1 FW issue like as mclk dpm table in
> > renoir has a reverse dpm clock layout and a zero frequency dpm level
> > as following case.
> >
> > cat pp_dpm_mclk
> > 0: 1200Mhz
> > 1: 1200Mhz
> > 2: 800Mhz
> > 3: 0Mhz
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
> > drivers/gpu/drm/amd/powerplay/smu_v12_0.c  | 3 ---
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > index e3398f9..d454493 100644
> > --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > @@ -214,7 +214,7 @@ int smu_set_soft_freq_range(struct smu_context
> > *smu, enum smu_clk_type clk_type,  {
> >  	int ret = 0;
> >
> > -	if (min <= 0 && max <= 0)
> > +	if (min < 0 && max < 0)
> 
> This change causes the following Coverity warning because min and max are
> both unsigned:
> 
> int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type
> clk_type,
>                             uint32_t min, uint32_t max)
> 
> >>>     CID 1460516:  Integer handling issues  (NO_EFFECT)
> >>>     This less-than-zero comparison of an unsigned value is never true.
> "min < 0U".
[Prike] Thanks and will fix the Coverity warning. 
> 225             if (min < 0 && max < 0)
> 226                     return -EINVAL;
> 
> >  		return -EINVAL;
> >
> >  	if (!smu_clk_dpm_is_enabled(smu, clk_type))
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
