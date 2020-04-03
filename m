Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2796DC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAE0206F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lrhv//Ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAE0206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4806E169;
	Fri,  3 Apr 2020 16:41:33 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700059.outbound.protection.outlook.com [40.107.70.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4456E169
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 16:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX2FJ/l4aYC5wk+q9zI0My2R8LMeT0RVcNKEpymAQE61/3is0oHacV6UKEzpCvcWGiyVhPQdyQfS+X9iG55zUNyLVEFX4SfB7PnYNQE2DsEr+OIRJLOcF9rUYZt0GXOBIn4s8hATqwq7ex8Dm1D249CVxbkjpvuq4830ehDCFNjPWPmA6uD2I/x/HFKei5s+3avNTNc3k900lVWkQvqBjBl2ZuOtlRHrCJcKhG0tc6XMnu84QcJ8m+d7gu4W00KRB3xh8Y6HjQl7warqkVt1lkz3xSVIdS5pIA48opEFRmzC4cmcJ1YMZv5T2FuwjiWOPvxiX/suO4JYf9NecNU1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB18yO3z+PCldj441ehi/08pxH2oBSKzfChZ4uZpH6I=;
 b=J4/ptONtA+IAeGnF++8u69xsyY6waH2ul/B8d6IWOMS5/XfsfP57quIrd8SskX5DuSKw/hvqwGHBVnJDDRQzC5PIscw0j6hc8GeQKhkcj4xawc1RZIor77yb2iq6JM8p+1vh5/4OMn06yxzPg+Xz0Ev0SwvwoeswZN1y6qD1cw8YIWe5XY862vIFpLeCGurGobIMgMkEuLnzHBYz3T5MyIjOlL+ao2U919AFUYKKXkb3P4saLLLXicFTxPAqsN4cQTtl4bSTpboLgNh6LJx0jN+InQTK/WR8tBHO7Ncc60ua5Ca3Tj63kZ4T7AcRHcLo3Ef8WX8/V5JXOqiiMt/hRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB18yO3z+PCldj441ehi/08pxH2oBSKzfChZ4uZpH6I=;
 b=lrhv//Ma36OdZ7PowtRFE3cbluFHfck0G07AzCbiNOLp9754+uXzj4AeopWKzWvEUyxtrANQvq2HWSEIZbT00pQewkGsMA+SRbXwGT4lnr4sW57DydbC23eBjQyE5obHuTJ0jESQO6fK58yHGgRvxdCFPRSp4vAgc5WWxoxMWdE=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 3 Apr
 2020 16:41:30 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 16:41:30 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Re-enable FRU check for most models
Thread-Topic: [PATCH] drm/amdgpu: Re-enable FRU check for most models
Thread-Index: AQHWCdU5NahHNnMCvEGj9OxE7+2mjahnmFIAgAAAfdA=
Date: Fri, 3 Apr 2020 16:41:29 +0000
Message-ID: <DM6PR12MB3721BF3638E93E8811A7500485C70@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200403163035.19177-1-kent.russell@amd.com>
 <CADnq5_MXO7sGC4ThC=5xxxvOUTEo3c1d5h-zipQrC9UPaYg+kg@mail.gmail.com>
In-Reply-To: <CADnq5_MXO7sGC4ThC=5xxxvOUTEo3c1d5h-zipQrC9UPaYg+kg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-03T16:41:27Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=33dec6b8-3092-410b-b03b-0000c23bcac1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-03T16:41:27Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 13a71d5c-3894-426a-9ac2-0000b78bf5e5
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-originating-ip: [2607:fea8:1c80:c44:d77:7581:235:8c68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0e155d1-8000-458a-94fe-08d7d7eddc74
x-ms-traffictypediagnostic: DM6PR12MB2682:
x-microsoft-antispam-prvs: <DM6PR12MB26826114029CD5F89A9FD4AF85C70@DM6PR12MB2682.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(6916009)(66446008)(2906002)(8676002)(55016002)(81166006)(966005)(478600001)(9686003)(86362001)(76116006)(8936002)(53546011)(7696005)(81156014)(4326008)(6506007)(52536014)(33656002)(66556008)(71200400001)(316002)(45080400002)(186003)(5660300002)(66476007)(64756008)(66946007)(170073001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNzgXoLoTHkw1t9cXh3udFwWDmiIMlH9XtFy81DZT+XlHqziEhkm0HQaCHgwyh+tdOL3BqIbKORbpMNyDhTHNxVDad50ovllGazr3I9sXS6YoYf+2FkSJx1A7qgo8DDDlo4Qh+ZkBhn+xW3D7CFQqt7Gc9YZ9WKIf2JXJU+WpdvQFjiUVHc9tcSyfye8rIbu+hP7cqV/s5UlMcYicHKhp37OzEEd3SDCWh4aJHQySFKw7hbGN4za6wpwkPAdpndpXH/ps3x9E4mMbkfhqW8kooEJKKp2soYUj5WIC/K0B1aFhEu4VdDVrbx0lJuXudRBfWu4jxAylCwwMM1tYi3werUFtd9OW8D1x41YR8WnaY0s4YQ6ttENdOIhujBhqlH6Cr7Z+YVXMJeMJvJPm9DTRQazbHJnhByZGDWkYBCu/n+8CGQ4FjQR3ZeLnQZON3f1tsc34bryUPM9Sca6vdvA9r9VT2PNNLnzOABXKdq9k3ghTnUIs55wt3aihjGo0MrT/ig4irJl2NiXA7najRG+DQ/ylKaq6WiwOWhgjMkiyguV77NEPJbwxfAr7QfxbUTn
x-ms-exchange-antispam-messagedata: uCnxIhWTwTy65ey3b0+1FO++ATmhN/sk6PBlamHBmUzSSW4lMgJtNCfApk0+s5BAYCN0dtX/YcbLuCYJY1pyDo6SR0vNOv0TnJ3RXCXigfPMrdCmGRw4M6ofhkAQXRoSST3y31UGBM4x3b6GXZGAJt1efHSu6NAbfXmL1yVQmDDR1E25D+3wGkKiMbsji62Ln7C7x33xMFWDHT7i36RIOQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e155d1-8000-458a-94fe-08d7d7eddc74
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 16:41:30.0034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y7dFloxG+EOamJ1n/m+6fUP3eiHia7i8qwKFRzBEoC/mm6oxLS/W9dJzm2WpLYs+M6K3+CIHEEknNBQShpwQ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
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
> Sent: Friday, April 3, 2020 12:36 PM
> To: Russell, Kent <Kent.Russell@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models
> 
> On Fri, Apr 3, 2020 at 12:30 PM Kent Russell <kent.russell@amd.com> wrote:
> >
> > There are 2 VG20 SKUs that do not have the FRU on there, and trying to
> > read that will cause a hang. For now, check for the gaming SKU until a
> > proper fix can be implemented. This re-enables serial number reporting
> > for server cards
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 16
> ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > index bfe4259f9508..9582469a70cb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > @@ -31,9 +31,21 @@
> >
> >  bool is_fru_eeprom_supported(struct amdgpu_device *adev)  {
> > -       /* TODO: Resolve supported ASIC type */
> > +       struct atom_context *atom_ctx = adev->mode_info.atom_context;
> >
> > -       return false;
> > +       if (!atom_ctx)
> > +               return false;
> > +
> > +       /* TODO: Gaming SKUs don't have the FRU EEPROM.
> > +        * Use this to address hangs on modprobe on gaming SKUs
> > +        * until a proper solution can be implemented
> > +        */
> > +       if (adev->asic_type == CHIP_VEGA20)
> > +               if (strnstr(atom_ctx->vbios_version, "D360",
> > +                               sizeof(atom_ctx->vbios_version)))
> > +                       return false;
> > +
> > +       return true;
> 
> I think you want to default to false and only return true if it's a
> vega20 and it's the right vbios version otherwise we'll try to fetch
> the info on all asics.

I was trying to go for the smallest list. There are 2 SKUs in all of VG20 that don't work, and none in Arcturus (and the FRU check is only for VG20+) , so I assumed that I could just cover the 2 bad cases. It's supported on Arcturus, and it's supported on server VG20, and we don't touch it at all on VG10-and-older.
 
 Kent


> 
> Alex
> 
> >  }
> >
> >  int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t
> addrptr,
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C0f2e5090b21b4807b
> 66808d7d7ed28f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37215285907421019&amp;sdata=yBc0%2FrNnnWgRBiJcAvav4JtvmoG0Tyhd6p
> X6gfFeW%2FU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
