Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015F7C47247
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 19:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38F62068E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 19:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DOy6j2fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38F62068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458E16E29E;
	Tue,  5 May 2020 19:35:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CB66E29E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 19:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+SYnnineGgnOqhpyvn8QL6R7aodahk7ZtIcyUwaJ6Ap3CVt7XeJzrpgha+WPauR8ZLutv6JfUvVxeWm7DnQKdRhexq6rklOvbwOSLw0qPjWVUYzBz6kKebuV71W4iXyKgvodvY1UHOdDIfgi+O81Yp/woVR3YBOknqtSBUUSNa6/AjppefvTxrfzxW/7wRH3D6ZMKruj4XneKHHAYmAPJY50gj9TgeQ/aFtxZj88qigyCkxC9Qrfpg7cpFuW+wDAbNJ+qqS+MKMf1eh6UduKbHj5Dixh5rTcHJK5ibC/tYaW6jqM14zi5JcnGdwUbyg+969pjzwhOl6vfMkPcHOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuUClQk7B866OOYENQ8OH+cyMHSDE6y3XYBKTgG5rd8=;
 b=Y6z6+IllWvXitVGN17mw8/dpC+DGOcYj9+Du18ZeQMrQgB5BxYhybljTaxbjSpJbmxOON+8/GrMWrL8aDYu7qUmXYzL1m0+mwOsiBNsey/VEyo7sr7/Yp6r2Uflrf8+xKImdkFuPrf6R6xGcWDeONYMRNFOwGoQs682E1NHizIE0+xsvXHHJHwDUU/WHYlHcux9qJOLWOXQwZDyb5AvR0l2Y9IJc/u/ePJJA8dFujkhYjNndo7PZ+hEsIXgfVsrdgAfeiT9/NvkiVqIFDDCw0E8uvXKjJD1JTfYpVE8XynLmc9268n2h0xUApgsh/Cw7P870h6qu54kcuWWM2de5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuUClQk7B866OOYENQ8OH+cyMHSDE6y3XYBKTgG5rd8=;
 b=DOy6j2fsEhuEp6CKHDGVtwNEAi/jHxYH/qTcmVRyamRZoT0NtQkFyYz5KpwaDkPDQVOuw7osBYeiXbsk1y83vjnNQs3kndOtVXnZuKWG4I+C5Nz+gNeP+9RD8Ed75LzW6Q3eo8fFfOt0sjaf1ivRsE7b2cgcrzter1MCl21c4kc=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3259.namprd12.prod.outlook.com (2603:10b6:5:180::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Tue, 5 May
 2020 19:34:59 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.2958.029; Tue, 5 May 2020
 19:34:59 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] Revert "Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2""
Thread-Topic: [PATCH] Revert "Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2""
Thread-Index: AQHWIw8CEQi4iI88sUqDsrL6T0ubRaiZ3lUAgAAD4fA=
Date: Tue, 5 May 2020 19:34:59 +0000
Message-ID: <DM6PR12MB3721C73969B8DDDA99736B8385A70@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200505185708.23373-1-kent.russell@amd.com>
 <CADnq5_P_syiaE0di4U8+Fd5nPv5bG32LnYAt2d977sDNM14z7w@mail.gmail.com>
In-Reply-To: <CADnq5_P_syiaE0di4U8+Fd5nPv5bG32LnYAt2d977sDNM14z7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-05T19:34:57Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1535d4ae-3cda-4c39-ba6c-0000e755b9fe;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-05T19:34:57Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 66c42e32-1502-46d8-8ae1-00009f1e8a54
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1ca0:aecb:89d3:2a74:6d44:185a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10d56c4f-b4a7-4049-5abb-08d7f12b6635
x-ms-traffictypediagnostic: DM6PR12MB3259:
x-microsoft-antispam-prvs: <DM6PR12MB32597CA9C249450A1D6261C085A70@DM6PR12MB3259.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqV4+9SMKry+YDZf6CbksjvL2zI+SVNqzlPM1hzha6KJY1VL1q5BvhHOy4Tzt1HbUtvVXYYz7f0l1mFR16ST/Ibigl39gWlHKup9XVN3Kzr3lcqR+e/+4TGvz8kRQ9lvV+1e/XQXyqWomWaFWYJd8UjqAV75yhQS+est0CyNM8b8JGWNLF/vNtcUTg0838+GNnhHs6Lq0PW8M4gkrLs6aceHig/n45UCgg+qNnPmVK0BqF5/yRbKArXHFUSKlWHLcJeysX2XstPeA36vZj8oHimn6ltN7jsXxosXTkLOrBSX2+grYtWAAnUJAzde7CkoudG5FfUZ0HE2tJ9JN+U3Ienbg3qdxwoKgSiO/ak5kuJKluxkm1SgJOpeQEimyzKKqRDh+UtX6ggXpGeNTcN7ccyt4V4j/TbmNNGu3Mv1cnFZhzUVdIHLIeLeEZLkRJnXWH1ncfXCnwK5lHefsXmqO9K7o+pwN1rx1IeJCdHkl3y1wu56hXn+xFE9w9UPLOhROQmx7tgBVZQwdECuPuRLPhwX2Lpx4+oqyrJSD7ZY73G0s6cQe67+4HcBLnTz38MSR1ioWt+N57zcTzHm2OPGzVfvgAqaxcbDv81JiVGT4jQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(33430700001)(2906002)(4326008)(478600001)(71200400001)(45080400002)(52536014)(966005)(6916009)(83080400001)(86362001)(316002)(186003)(33656002)(66556008)(64756008)(66476007)(9686003)(6506007)(53546011)(66946007)(8676002)(76116006)(55016002)(5660300002)(66446008)(33440700001)(8936002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 8UIZ9pMhO4Z8Ca+fN4b1Q2khAMnwOhO7ns2OzBCXQ54UFVa3b+BpTFZzQPF779JHvIleZ7+nUkT+eAreJZ/D3txhJiVO/yMD80h3FP/1+mH4IgMGMg+EDS7zAlvZgeBIwpWRj0cJQp4/IaQix+IMDDjvXLNCbTHGFKR3nB+H5WJBVxVtlU/c7q3UH3pO1/Pkkhme3udUoR+p32+n7fBXrlHXo4QalkW9TPQnfplrpqyVwssAlWeSDKflHtMSoPJRUUMcqAlpwOxPaItdBKQOfGK90nVQVwagCyqoZLNw0CRYsFtAhJv2ajIHkHOGqxT2vrF+h7kv8dcF2+SHjIvbHLtQ6XuBoOeaUmzZP/rCFvHDT0P/x22PA6z2VnCTyJfHMbWCfbD+oQ30C/bK0K9SVW7hs3PSoh5ZW5ClK6bIWETYNByr8v6BNOl8L+KfpjofEgZkA1HLi+cB6XhQpY0DtRzbhuKLWgqBVK3v2LMd9jkJuwb5WbyFp8fGW762l4gc8Hj2sc4Qyh7FpSG8+HBnTj1LvyXJARLG+1/v7tHixNSZMpGRIKJhRn3Q+H+r2Pe+GZY2mOnZvhD6aH6SdLeILq4NAKKoCrfMcNFJEZGr3y4L0eA+FivirF4wEv5PgVqfdzRUW0/kB13q8hmtNM7tLmEelRdAPF8ZX2Nb5l/MyYyUZVieMtFwoZ1yZIAqjiKH9dxnx/rjPHzRShFXVVxEQ/JHwDsEC06WWQSrIaQXXyU6D10aHzYEvq1SdAoTAGAlG3a8SIQtxMJbXgNdPl17vWnXX88Z/eD7e/8wdakQdw2kb+wKX/FlrjkEtD+INzPwQHO3DqB0ozbUbti/cMvLPDdOElQJlVttlqVSmID0XD0jxjXqiWSrRLvfrJKHKAKX
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d56c4f-b4a7-4049-5abb-08d7f12b6635
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 19:34:59.5605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6+poMTsSOKjhfqMMWqU9WM8jkhWJfiRDYJ5iPK9quA+1opa+PZXnZLImoNLSCV+H2JN1XcOv7lk5P7ayaVMbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3259
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

I will do that instead. Thanks for the recommendation!

 Kent

> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, May 5, 2020 3:20 PM
> To: Russell, Kent <Kent.Russell@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2""
> 
> On Tue, May 5, 2020 at 2:57 PM Kent Russell <kent.russell@amd.com> wrote:
> >
> > This reverts commit e71391880aa72709fac53f98d96a2d4e8875b9fa.
> >
> > The RAS issue at the base of this problem appears to have been
> > addressed
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > Change-Id: I338a985e19cae8e103bd44b0f238314e9460d396
> 
> Would probably be cleaner to just re-apply the original patch with an
> additional note in the commit than to revert the revert.  Either way:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
> > ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index caa38e7d502e..bf302c799832 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -255,6 +255,32 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >         uint32_t hi = ~0;
> >         uint64_t last;
> >
> > +
> > +#ifdef CONFIG_64BIT
> > +       last = min(pos + size, adev->gmc.visible_vram_size);
> > +       if (last > pos) {
> > +               void __iomem *addr = adev->mman.aper_base_kaddr + pos;
> > +               size_t count = last - pos;
> > +
> > +               if (write) {
> > +                       memcpy_toio(addr, buf, count);
> > +                       mb();
> > +                       amdgpu_asic_flush_hdp(adev, NULL);
> > +               } else {
> > +                       amdgpu_asic_invalidate_hdp(adev, NULL);
> > +                       mb();
> > +                       memcpy_fromio(buf, addr, count);
> > +               }
> > +
> > +               if (count == size)
> > +                       return;
> > +
> > +               pos += count;
> > +               buf += count / 4;
> > +               size -= count;
> > +       }
> > +#endif
> > +
> >         spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >         for (last = pos + size; pos < last; pos += 4) {
> >                 uint32_t tmp = pos >> 31;
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cke
> >
> nt.russell%40amd.com%7C95de921aa6dc453f4f8f08d7f12963e5%7C3dd8961f
> e488
> >
> 4e608e11a82d994e183d%7C0%7C0%7C637243032382055171&amp;sdata=B4
> 05lc1cG%
> > 2Bvgl36OKNnkgTBHHweB%2BizscB%2BJZxtilx8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
