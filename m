Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B3C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBF2206E9
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gDtPCYJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBF2206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE9A89CC9;
	Fri,  3 Apr 2020 16:51:34 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750041.outbound.protection.outlook.com [40.107.75.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8940F89CC9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 16:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg7chtyxARt2H8hAZ9eV8NlSNV4V3fZeXaQEUblr8UR1hIU9hgUJNVzJ3c69wJ//1EupHK0DnXuBSzzvVw+k4YdynAd3GE+S+kG4STq4s+9HZdN8iJTITg0+bNFBK1XvqaYuvasvY0QTfhs0Xr9VCLRePYoqBz/qMh3OjwVV0YhSJCJB5Hv/dd5CYXiSCQexp4H4aG2NhJ6w2q9CR392gnDspnJWM+AfhE9VbFCU+pAMIMJc7o4FhNE0pv16cdIr+ksH9WAWVzV0VWZQZN+nJm8nPLMQAXXEsJucQOUcO3qo7ULClfFF+xUp+d/Cau7zNSQiHFjgBoCGU8Go+djm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc2pp0WN9Gz1gj1zN3lqlCyDbltJZtS0r5QogHQKmp8=;
 b=jAxJq+6xNjEEa/Y+rRCyz+XqgiK9FcUNFjxoccMVeHoUE3XD621m2cwjCN6NQPDlttLvxFKZSciTahsQABBh0fguAPk1JgjwidBUmJfRmslCkYt/35iBUfS4NI+FYi/EnTxRapob2fY0yJyWubS6MiKSO6f+4mDag4W2lzs0Ow0uTp9c8o3cLELr7J6B1p9dPI6KV1jclTYOHu66SNJe+VfVFQcfTHrR+Ylb8T4ySHEw3sh5QgC58XsN1nBs6AteNovr+MpEf30nYqeuiIf67eGCFUZQkHtJl3+5Kqgd+GdOO/0sQpi3BMf+KaxLedLXSYIkyUDvgUEAXJsF148A/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc2pp0WN9Gz1gj1zN3lqlCyDbltJZtS0r5QogHQKmp8=;
 b=gDtPCYJChEmXRwBRsdixoM7GTIGGWmf4QBi1fqy2STAVEs9OtrO328rkwjnqDsv/eJgoMgCVjLzrHyN3/NudMij9l+2veUho5ztKBwoIeb0juvVr08jMXNZzj6owNF09ginGCrrOu5YyjB9K0KCkwuPxCLvp09YvPvlv3IqyuFw=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2970.namprd12.prod.outlook.com (2603:10b6:5:3b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 3 Apr
 2020 16:51:31 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 16:51:31 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Re-enable FRU check for most models
Thread-Topic: [PATCH] drm/amdgpu: Re-enable FRU check for most models
Thread-Index: AQHWCdU5NahHNnMCvEGj9OxE7+2mjahnmFIAgAAAfdCAAAK0gIAAALWQ
Date: Fri, 3 Apr 2020 16:51:30 +0000
Message-ID: <DM6PR12MB3721C5419A2821E8BD60CA7485C70@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200403163035.19177-1-kent.russell@amd.com>
 <CADnq5_MXO7sGC4ThC=5xxxvOUTEo3c1d5h-zipQrC9UPaYg+kg@mail.gmail.com>
 <DM6PR12MB3721BF3638E93E8811A7500485C70@DM6PR12MB3721.namprd12.prod.outlook.com>
 <CADnq5_OGNr_kfpyxofh0oVWT5ma+kqCJiJoq9uWQuE5RngD_6w@mail.gmail.com>
In-Reply-To: <CADnq5_OGNr_kfpyxofh0oVWT5ma+kqCJiJoq9uWQuE5RngD_6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-03T16:51:28Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=467142fd-cbc2-4466-942e-00008e43c723;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-03T16:51:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a7aa9c0d-d6a1-4bc8-9be1-0000d1f41728
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-originating-ip: [2607:fea8:1c80:c44:d77:7581:235:8c68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bfe536d-d6d3-44f7-868b-08d7d7ef429b
x-ms-traffictypediagnostic: DM6PR12MB2970:
x-microsoft-antispam-prvs: <DM6PR12MB2970C0FBE63D73591F2F5ECC85C70@DM6PR12MB2970.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(81156014)(55016002)(4326008)(45080400002)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(316002)(478600001)(2906002)(966005)(33656002)(8936002)(86362001)(7696005)(52536014)(8676002)(81166006)(9686003)(5660300002)(53546011)(6506007)(6916009)(71200400001)(186003)(170073001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9o/iSX+uZqXiIZpw3z1jQQ8Af0pEYqaUqggHM3Xenjj/0ZfFy9Q8vTdMya5ZeVFTB+fur/etI03l6fziq+9j2Gn/QuOEP1jdtSjJ0mH/lyoSNOLSMPIeoQgX9zLUccjMoUE5iml+rcVTpt0weNnVmWoXoL09+YancNxmlIn+iNVenRBAHO3A+pavK7P0XCL0/roiT7BcAtAX8xXvqCL/FHv+Z1Huvq9WPKtqOk0Xyi8wfv6JMSe+B1pUJ5Rn0966tAJvZXoaDklxrGht8YAvYo9PBEyAgVZ5X4L1nSLgf0JaDZosrxC1Ownyzi+7OCtVYhXK1EDEyu1sFLM/trQrxmeiZSHtbk2+AJm2l1HOGTKhzgCm/vdwjz/9kCnnKyYtCpqoeJvbOg+jMGrB7m4aYbfRg0XXlO/kGIgVy1CMbt/Kj0XUIbrnGv7C4q0C4hynR4vKDcnSqD2mNjUhd3NFqEAbbXgBv/MKI6UUZuDJyLrR+FQCCj1urLAu7TpmMvYNtOayFYND8H0BhxMDa7OLZ9ONFOvalrqOjFOHMU/p07IJo6FBDycuGnGKB/g2ztBH
x-ms-exchange-antispam-messagedata: r4WnPSgpOC+z8B+nE2JJD2BCH1OyioRLM9nPncHEIc/NtVshRvujpPgL3OBP3m/xxM4q3g+rZWQqC2OJtRAnx+2I7CxqD+oGHMjkQisrv3S2N5GG5zSF8fC5MhTkg0w5A9AS/RCunR+QUFioc4rODfCrLB8aF4Z3kfBw6N4dEbuq0CzM0PJhaM+bSx2bE+XjnTEAWXTVQaNN2iuTryIFDQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfe536d-d6d3-44f7-868b-08d7d7ef429b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 16:51:30.9159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WONNrhsGbocx4dEJ2DktyQ3k1xSWcVdZcJ3Sv98ezZLm6jpbm/cVUI9FhXCMynaigWv9JXjQSrvBhKq96apvPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2970
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]



> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, April 3, 2020 12:48 PM
> To: Russell, Kent <Kent.Russell@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models
> 
> On Fri, Apr 3, 2020 at 12:41 PM Russell, Kent <Kent.Russell@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> >
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: Friday, April 3, 2020 12:36 PM
> > > To: Russell, Kent <Kent.Russell@amd.com>
> > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > > Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models
> > >
> > > On Fri, Apr 3, 2020 at 12:30 PM Kent Russell <kent.russell@amd.com>
> wrote:
> > > >
> > > > There are 2 VG20 SKUs that do not have the FRU on there, and
> > > > trying to read that will cause a hang. For now, check for the
> > > > gaming SKU until a proper fix can be implemented. This re-enables
> > > > serial number reporting for server cards
> > > >
> > > > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 16
> > > ++++++++++++++--
> > > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > > index bfe4259f9508..9582469a70cb 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > > > @@ -31,9 +31,21 @@
> > > >
> > > >  bool is_fru_eeprom_supported(struct amdgpu_device *adev)  {
> > > > -       /* TODO: Resolve supported ASIC type */
> > > > +       struct atom_context *atom_ctx =
> > > > + adev->mode_info.atom_context;
> > > >
> > > > -       return false;
> > > > +       if (!atom_ctx)
> > > > +               return false;
> > > > +
> > > > +       /* TODO: Gaming SKUs don't have the FRU EEPROM.
> > > > +        * Use this to address hangs on modprobe on gaming SKUs
> > > > +        * until a proper solution can be implemented
> > > > +        */
> > > > +       if (adev->asic_type == CHIP_VEGA20)
> > > > +               if (strnstr(atom_ctx->vbios_version, "D360",
> > > > +                               sizeof(atom_ctx->vbios_version)))
> > > > +                       return false;
> > > > +
> > > > +       return true;
> > >
> > > I think you want to default to false and only return true if it's a
> > > vega20 and it's the right vbios version otherwise we'll try to fetch
> > > the info on all asics.
> >
> > I was trying to go for the smallest list. There are 2 SKUs in all of VG20 that
> don't work, and none in Arcturus (and the FRU check is only for VG20+) , so I
> assumed that I could just cover the 2 bad cases. It's supported on Arcturus, and
> it's supported on server VG20, and we don't touch it at all on VG10-and-older.
> 
> Right, but if you return true by default, then the driver will try and fetch the
> FRU stuff from every asic right?
> 
> I would do something like:
> 
> if ((adev->asic_type == CHIP_VEGA20) ||
>    (adev->asic_type == CHIP_ARCTURUS) {
>   /* do whatever logic makes sense here to sort out these asics */
>     if (...)
>         return false;
>     else
>         return true;
> }
> 
> /* return false for everything else */
> return false;
> 
Ah good point! I'll do that now. 


> >
> >  Kent
> >
> >
> > >
> > > Alex
> > >
> > > >  }
> > > >
> > > >  int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t
> > > addrptr,
> > > > --
> > > > 2.17.1
> > > >
> > > > _______________________________________________
> > > > amd-gfx mailing list
> > > > amd-gfx@lists.freedesktop.org
> > > >
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > > sts.fr
> > > eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > >
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C0f2e5090b21b4807b
> > >
> 66808d7d7ed28f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> > >
> 37215285907421019&amp;sdata=yBc0%2FrNnnWgRBiJcAvav4JtvmoG0Tyhd6p
> > > X6gfFeW%2FU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
