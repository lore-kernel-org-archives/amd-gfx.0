Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED86C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 21:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF7C206F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 21:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zEREzg/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF7C206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 824ED6ECA7;
	Fri,  3 Apr 2020 21:02:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8D86ECA7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 21:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nceo/aqCa6+4DQrZpmGMOCmbuTIC1YFlzv4yezjociRjA2Wjt0a8XYDGy0dKyUDOdJB+LYR960tXB8YmqdZXVrl5gXausUXKfjaxWsvBsoyaN6E//dXru/MJ2tCGFUy74fWlFepHyf/cZkCQaGLzghFIIgulWtwZQNje9YknDDdJzIpjM+JUwA/VAVU138js+cAWx3VAce4LNiG2+BaaLDll8c5VYGqPcGci/nSDAJIoKMqdeqw6B6W7lNwlDcMk6Sc22AgZN6j72wpKCWmqYEeEJ9paic6iObUoXDVZKf/wbpoaNfgDYKE0BO+aVArnLMnJC+bWWnfut0GEHPI4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkOY9i2YAFqsPLteJqu/cMdzgZmtxqtYsBzRtIrhMVQ=;
 b=NU0w6hmXfv/VNV6ibMKtJH1+KxZ2KfwCkROZJdkafJ5Us/3+uaBTsDhkLWUdOStsHFPqeG/SHJ0BXZm/eJemJZ6ZmX9e0xb7x6I5SLcRqZT/d8T4/zLvC3pTcYTko8D9cRhly/bKc2/j5Xq1+pVTxIiNlYUAXLDuMQz4Jn58sBVTrOCPzE1G7GZbIEZ/2X5FbOnsLydf2pDzcFDExvrgoDdb2KJEC+7W+gKoPTqeGXvqMWAqBN/9+R++4bI60osfLOQ2zTYYsK77Bixz6ATQ0UsXP0G4lH56yN7IZr+aOC+wvPiVIZTOIcB8zvWFNoInhtMZVVxKO65Xh1kLzBWVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkOY9i2YAFqsPLteJqu/cMdzgZmtxqtYsBzRtIrhMVQ=;
 b=zEREzg/yMRLnJoHy8mfYYjaKfE8+1b7lEwnfZYRcNs75Hd2uLjjsThpU40aLxXvYq4/EliXRHL8nbL+UZ4ffcxGCQYvGU/4yAdA6JsvuqipYENbuKPR1D0FQx3d2z1JhEoaFQr3/LIZLpHf8UGyhTQjJk6BYLX273a9AlQoTX8M=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Fri, 3 Apr
 2020 21:02:38 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 21:02:38 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Re-enable FRU check for most models v3
Thread-Topic: [PATCH] drm/amdgpu: Re-enable FRU check for most models v3
Thread-Index: AQHWCdqWtVgaAXnXLEOEfrlL8qbIU6hn34cAgAACzuA=
Date: Fri, 3 Apr 2020 21:02:38 +0000
Message-ID: <DM6PR12MB3721A86D7E52F644CC97860E85C70@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200403170856.7397-1-kent.russell@amd.com>
 <CADnq5_NfjqeS0AaEom0sTMjs2cD8kzcaw3ZxXMVg8Er-f8676w@mail.gmail.com>
In-Reply-To: <CADnq5_NfjqeS0AaEom0sTMjs2cD8kzcaw3ZxXMVg8Er-f8676w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-03T21:02:36Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d8d784e0-047f-4ca9-9cec-000044595d70;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-03T21:02:36Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 1254e8e3-dd3f-4b60-89ad-000021815db3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-originating-ip: [2607:fea8:1c80:c44:d77:7581:235:8c68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: baa8efde-7d0a-4e6f-08ff-08d7d812576c
x-ms-traffictypediagnostic: DM6PR12MB3595:
x-microsoft-antispam-prvs: <DM6PR12MB359564386C64C41FCCA483AF85C70@DM6PR12MB3595.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(316002)(4326008)(55016002)(66556008)(71200400001)(7696005)(8936002)(6506007)(64756008)(66446008)(66476007)(66946007)(76116006)(53546011)(966005)(33656002)(81156014)(81166006)(5660300002)(9686003)(86362001)(52536014)(8676002)(45080400002)(478600001)(6916009)(2906002)(186003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0syGtMvG9TF1lic7Ok9OeWJ4Zh2OcAwT5HnbGaf1y5WAjXKaR1vjmyPLc5xAxC9Oq1Ne7oU3m0X6Ukxk6tURYdxw+WujQLkSkGwo1JKKdmRtBAQh/rYEc5Ws10NUuIobqCy5teeIigYmNCAh6zRAD5whUlkGxGBT4O+yMjtA7lFvUPIk/5Upp6CNFwla2H4+zA5fiUjROK2+MATr1+tdiT7bkdib0FqwupfCPvBQY4ar3k57FnO9y+5uN4yhZOSWX8Sb0V5HMP6Rmf4hDYlqEuNtluSZK8rjZAkzobrJcmCWk9fAyOg7d2s7hO0DvZd3q+V3wl7ur5It0G0XmNlA8hrrZm69KifUbHGyVrzKTP/6gjB4bTahC5laNcAwpj5DAHMQolO8/n7coRwPBH5bSE/5cLVT0LJCqA0ibjWIboynPUWKB5zIGhjI6IeqNbrz0ybRyzjy2ZgkU0CjY6NFFHHYobfceEKzNSxwipInBPQKqj50aL43Z/RP7prQudFj/1Hu8+GbmbE7ucHmuAaveA==
x-ms-exchange-antispam-messagedata: venrd2WB9sbiPyaNjkTbidqErVxtFlz2YEMBH9vtl31JEQKYm6S/UI1XOSNa89CFsdXuyd0diAidComiU1C/WlsMWW4ylbyJq96ku+G2j3f04TvyW7tL6FYfBj7315xJ+MtaSvPzB7c0l1A45xE7tcj18SHL6NKkahnFl9jk+J08XzuJ7AyvKiIkiVq4BOki6A3i5J0U0VQ5uOi2cBwYCA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa8efde-7d0a-4e6f-08ff-08d7d812576c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 21:02:38.2644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VpUoBa22tBjk4kzALtwp7CRCMZZx8ABvHVzc/p81mqXEzWLwWvQKxpEj+fe+ucSjYEspBA5hHi5opy9SOYcLKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
> Sent: Friday, April 3, 2020 4:51 PM
> To: Russell, Kent <Kent.Russell@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models v3
> 
> On Fri, Apr 3, 2020 at 1:09 PM Kent Russell <kent.russell@amd.com> wrote:
> >
> > There are 2 VG20 SKUs that do not have the FRU on there, and trying to
> > read that will cause a hang. For now, check for the gaming SKU until a
> > proper fix can be implemented. This re-enables serial number reporting
> > for server cards
> >
> > v2: Add ASIC check
> > v3: Don't default to true for pre-VG10
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > ---
> >  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 22
> +++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > index bfe4259f9508..508906177cad 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> > @@ -31,9 +31,27 @@
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
> > +       switch (adev->asic_type) {
> > +       case CHIP_VEGA20:
> > +               if (strnstr(atom_ctx->vbios_version, "D360",
> > +                               sizeof(atom_ctx->vbios_version)))
> > +                       return false;
> 
> Most skus are separated by pci revision ids.  Maybe it would be more
> reliable to check that than a vbios string?
I can look into that. This was really meant as a temporary workaround until we found the right way to poll the card altogether. I lifted this from John Clements' patch to isolate the D342 variant of Arcturus due to that whole EEPROM addressing thing. I'll see if I can find the revision IDs for those and see if they can be used instead. Maybe I can use that for John's D342 check as well.


> 
> Alex
> 
> 
> > +               return true;
> > +       case CHIP_ARCTURUS:
> > +               /* There are no gaming Arcturus SKUs */
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
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
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7Cd1d72c89825549c6f
> 06e08d7d810c83e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37215438899199940&amp;sdata=BnHE%2BT8D0j%2BHKD7s9J%2BXePsSYcXLG
> bEYkmawDv3GNbw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
