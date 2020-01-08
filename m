Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6B3C33C9B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 05:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA67206DA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 05:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BqW2ZGa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA67206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F396E174;
	Wed,  8 Jan 2020 05:42:53 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750040.outbound.protection.outlook.com [40.107.75.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 081EE6E162
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 05:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAz9ZkHwcCISBCsuPCoz0l6YPmXPb2oTKZLh0jTdbT/oWy6t8mxorxwk7XXRnCsaHWSO+8jfaBzwa8yH7hZzWZ+lv2KxpvctXaTKcrfncPIKLv8ZHrQOLo5zIus/SZHZXHrO+wtiPnPBzo2TyULya2YlHMv+UUdG5a1zd8+t0A6KAcLGGwYXe+g9uIHpTX8tjDGVtyIahUE/bvlaSUB4qEtHeEQSvGzIcwpxZoHIcsDc9x33fKbCToJgbZnJ4YV7kakc6+U69HCjXedfcPSPBwz784D+N7ziXpNAulV2VqB1iG3Hmhtoz6xHSOUe80I+gL/OKfgiM2rq/SCBRdfrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEJFq6E+gTpDPIdCje5BsbPABCt6h5HhnaecgcDmEIc=;
 b=GEWk1UlZDyNHOIIxVwWmDnn1jmDN/FjkNcknn8cfTXmmdBtX+N/t0p8vRLK15htJRbwDae2kTQeaWuQxG7aTICT7escIxOnxtGz4CM58q9fBfO8cXuv1c/HYGWst2XYK5qe/gGOAK6U05L5FSJVXBOgMZbuZ13IQYumNn8j+IzrFUmx1XX403GyUWEfmrH/2ECyBHKkEb9Y8OyinbZ0C7iCu8H+xNg6wyl9/tVmI61HKL/tqAiYQEcO7OCgr3mjbVyapGyU5/Ilyc4QdfWhgeZsV+35YOhw+p2r+GAjAMRIT6t+kXUN64v9xoPHBPFBbexCyyxZZ1g6PwGy6X0kj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEJFq6E+gTpDPIdCje5BsbPABCt6h5HhnaecgcDmEIc=;
 b=BqW2ZGa1rS+1T56XRCV1NEvuibp1Bz/5FgP1bI7AWDvH96JmLiCth0rcgHDdxKVmfRnbfImlVIcLw6b5/LFRbXE7U65xRDqtsG7Q6kmpIR1gMRHxTthImJoOwGaVgmUj6SlW44hdWFOSIahR4YJ2AMdrtJp7WUrxmt2+w9M3DiI=
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB2926.namprd12.prod.outlook.com (20.179.84.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Wed, 8 Jan 2020 05:42:45 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c52d:5a67:be50:c4dc]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c52d:5a67:be50:c4dc%4]) with mapi id 15.20.2623.008; Wed, 8 Jan 2020
 05:42:45 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
Thread-Topic: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
Thread-Index: AQHVxZ9kJbZcIrU5VUCe5XxDZZ23jKfgEOJggAAEwoCAACnQAA==
Date: Wed, 8 Jan 2020 05:42:45 +0000
Message-ID: <MN2PR12MB383889C46ED30B87372DA51EF03E0@MN2PR12MB3838.namprd12.prod.outlook.com>
References: <20200107211320.1820393-1-alexander.deucher@amd.com>
 <20200107211320.1820393-2-alexander.deucher@amd.com>
 <MN2PR12MB38381D98F744CDEFA02BCEC4F03E0@MN2PR12MB3838.namprd12.prod.outlook.com>
 <CH2PR12MB391278FB16F067821B998F95F73E0@CH2PR12MB3912.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB391278FB16F067821B998F95F73E0@CH2PR12MB3912.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=41952cfb-a966-45ce-846f-000061bdb87f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-08T02:48:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57372e95-c215-444e-48f1-08d793fd9673
x-ms-traffictypediagnostic: MN2PR12MB2926:|MN2PR12MB2926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2926DF52516546DD0D5D5A75F03E0@MN2PR12MB2926.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(366004)(189003)(199004)(13464003)(66946007)(498600001)(64756008)(66556008)(26005)(66476007)(66446008)(5660300002)(966005)(7696005)(45080400002)(52536014)(186003)(8936002)(53546011)(81166006)(81156014)(2906002)(9686003)(6506007)(8676002)(71200400001)(55016002)(33656002)(86362001)(110136005)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2926;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jD+HvEBDNT4f2hdyOwOFpWGEfRsE7x6uwEEd1baO+vaKHPAC5PI+fNdmxX0Ga9v0akhUpB+ZoiXux2un+IvyoR+mZ5Dgz1LX9AbuMcH8bQ748Ruvx5ru6/6qzNP8QYSi7bc65ExsneuBCsZwImU18ErNNAzYf0j/5Ovh5Lu7LqQ4sr4DXlELI0gwJG3u2oODn0OZb/eK5TT/2JH1aD4RkfzwdIaD19mprDUljiXO/XY32JvPA2si1IVBT4hDj7PITKxmvWnl6sonwlz7wLd1ZwcVwROsToKFlWuHqKbLJg/vL9bpf6BUuuo76nbrU0GIMcl5GNop4XYIqzbu5obNfVik/PSJFGYhJBiEw9V8rloY0cNnkw5HYyPYcBwTEjx5efNYzjGNSfXA/fyiy/wJWrH0qzXVdr40Jgtg8NYWkXpTClnqt3zOCOplDh9kYmugjxlRmILGieyD7CU3yKHo+089yUS6R5SnsMuuLmN84/EAPXe8n8fp9rzd1No5B3C7TK8QMru/LAgee4hIBigdeY2vbbTjYYXl+e9V6FWOs945kwlvP+e0BpskQUgCtNhYpOJCSrtqCOJYCFQ+rg+6wIp/2bR9x5hX28o+Qnp32jcaitQA/FurHZk+Q86haHUoCPcFXmRAbba15z7G31byRQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57372e95-c215-444e-48f1-08d793fd9673
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 05:42:45.5191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IICvT9/6VhKiIAO2rKotObZNX19RoMDgld3HRQAmcHz/2GGW7+cn+ICb1ZDO8gH8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2926
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

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Wednesday, January 8, 2020 11:05 AM
> To: Liu, Aaron <Aaron.Liu@amd.com>; Alex Deucher
> <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
> 
> [AMD Official Use Only - Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Liu, Aaron <Aaron.Liu@amd.com>
> > Sent: Tuesday, January 7, 2020 9:48 PM
> > To: Alex Deucher <alexdeucher@gmail.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: RE: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
> >
> > Reviewed & Tested-by: Aaron Liu <aaron.liu@amd.com>
> >
> 
> Did you test with limited vram?  E.g, set the carve out to 32 or 64 MB so the
> driver actually uses gart for display?
> 
Hi Alex,
If I lower the UMA size to 64M.(UMA default is 512M)
For Renoir and with [PATCH 2/2], white screen appears and ubuntu desktop cannot boot up successfully.
For Raven, no matter with or without [PATCH 1/2], the system can bootup normally.

> Thanks,
> 
> Alex
> 
> > BR,
> > Aaron Liu
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Alex Deucher
> > > Sent: Wednesday, January 8, 2020 5:13 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Subject: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
> > >
> > > Everything is in place so go ahead and enable this for renoir.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >
> > > I don't have a renoir board handy.  Can someone test this?
> > >
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 1 +
> > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > index 6d520a3eec40..318605ca9bc3 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > @@ -519,6 +519,7 @@ uint32_t
> > amdgpu_display_supported_domains(struct
> > > amdgpu_device *adev,
> > >  		switch (adev->asic_type) {
> > >  		case CHIP_CARRIZO:
> > >  		case CHIP_STONEY:
> > > +		case CHIP_RENOIR:
> > >  			domain |= AMDGPU_GEM_DOMAIN_GTT;
> > >  			break;
> > >  		case CHIP_RAVEN:
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index 05118c8860f9..3be7ab0ce9e3 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -909,6 +909,7 @@ static int amdgpu_dm_init(struct amdgpu_device
> > > *adev)
> > >  	switch (adev->asic_type) {
> > >  	case CHIP_CARRIZO:
> > >  	case CHIP_STONEY:
> > > +	case CHIP_RENOIR:
> > >  		init_data.flags.gpu_vm_support = true;
> > >  		break;
> > >  	case CHIP_RAVEN:
> > > --
> > > 2.24.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > > st
> > > s.f
> > > reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > >
> >
> gfx&amp;data=02%7C01%7Caaron.liu%40amd.com%7Cd9cdd08e60a942e97c
> > >
> 6a08d793b67ea1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> > >
> >
> 37140284454500549&amp;sdata=TGuS5qqX8siW1sxWUZtQggnk4P2RPjxUiLk
> > > dvS1Fcog%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
