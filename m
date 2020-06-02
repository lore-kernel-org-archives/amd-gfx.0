Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA75C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 13:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C2D2074B
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 13:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VZxz4uG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C2D2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 150C36E3DA;
	Tue,  2 Jun 2020 13:56:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61D06E3DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 13:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERsMPZS5aesbEjg4McukC1FGVPgnwawrRtD04s1QsuwuTeGHNhAbZIuVB/jTdku5AFyYX7lhzY6LrYAUUhGzXMzGD1IB/7b53DS3wiPRgHRzcTx9TgawUVffDZZdtR0Oa7fSarBkZCquizk82QpLoKOeyHADtAphEyDYwwCLAflFvYcvE6iOQUAW6UD4JPgkN5FK21+PIv5xA126RSdVSaEjcg+MVjkteS3ICFyBftNWAgAqMyZlAAz5ZAsb44EjtHhpURiSzGkXRSi75pVVOg4RxQByT2qvp4pOkgOpd4ZyLV4i631x0B8VrijKEcaYC/Rg8lhtXdVm2RLtQg5hJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/42a5CRhUfHIJ3iauQu0k1gFtaoX8X5fLswiVRoqX84=;
 b=QY+f/1yekwxu6Lnz4Z0M8Xp4NhNOWbuEZLr2dOKiYpu9GNZJre5+0OKoCY1fO5F8QzkpW/jKeO7z6dljmHxrkIJKJOTU4/OHoSu7fwZjjfwyUvgXGQuks6zfPpc/GsTYd4di5NdvqRDfXFQ+XmoyIJG3hG4qkKb4uNXBJ39unXy7EstGvi8UdN+yA4E1UoVOJXSQdxtzUoHe1Ib2zIvtqQsjOsp3cXPJZqPod26GjtbX1cc1iXSvT9EsTubArVzYos4MxmEYZ446w7ErNNfbImJO+afgZE7UECAiurGfC07Ud/aWdsHprZl6qH0qhHxt+gyTVq2ICtLETxUsluK2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/42a5CRhUfHIJ3iauQu0k1gFtaoX8X5fLswiVRoqX84=;
 b=VZxz4uG/NlaFI2xQNdztQHYKgMcutoEU1IDqhzwmxtbEfCCGzVHKMGUXeKy1LXTwu38OdMBPuIaBaL3yJ1FsOb8bVb0yQWk/S22HYBun4GvPqLA5MtoOvGTkmqcEuTnbSjl1yGN7bwN5vJSOgdz9OQ+a6TxdRIk6SqNzJr3F+7Q=
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB4020.namprd12.prod.outlook.com (2603:10b6:a03:196::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Tue, 2 Jun
 2020 13:56:05 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 13:56:05 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: enable renoir discovery for gc info retrieved
Thread-Topic: [PATCH] drm/amdgpu: enable renoir discovery for gc info retrieved
Thread-Index: AQHWNWkvkTPgNWyIMEW4fjC/qp/jAKjEluzwgADDZ4CAAAPOIA==
Date: Tue, 2 Jun 2020 13:56:05 +0000
Message-ID: <BY5PR12MB43079E7A642EF6CAD9382393FB8B0@BY5PR12MB4307.namprd12.prod.outlook.com>
References: <1590722887-9333-1-git-send-email-Prike.Liang@amd.com>
 <BY5PR12MB430719B6351D4AD64215A7CBFB8B0@BY5PR12MB4307.namprd12.prod.outlook.com>
 <CADnq5_Nndacwux6UQMXBvBPOxLLGT-gnMHOjoHr1u-YGed696Q@mail.gmail.com>
In-Reply-To: <CADnq5_Nndacwux6UQMXBvBPOxLLGT-gnMHOjoHr1u-YGed696Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a228de3b-9abe-4f89-be2d-0000fc4c1f45;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-02T13:48:21Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.226.16.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 589be8ca-8066-4668-0fac-08d806fcb181
x-ms-traffictypediagnostic: BY5PR12MB4020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4020031CC83ED73AA6AF47A9FB8B0@BY5PR12MB4020.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nt4KPfARDoxhP7SM+PzamPkJffkm9YEnuICMRd8jD2QymSu9wro61HE+E2snxYXfDQbRDuknmr1MiQL+kFpeiL004iuwzK5s15Cy0DIdacqjXTJdW/qzgvg8v4nPpATAIZo++zL0sMXnqQY2lJ6jQ7lekwWORdr7+S6i180OPx3UDjwTFUQjMz0jXPV4ro8JEGKIrsdAfLaXbcE6C9Nk+9dUnmpq3kIHPAoNmKlYwf/Wca5F8l27AlRghxKQ71v4iqQmwFK3SOsXEGVFFmNjnkq09SZ3mulJ0FpMC6Qd7IQjKHZbNcnGrNziLQptppbxQqRk5OLK6Hn2AQtSR0q8+mwYfsV8Ytrmf8II0x6RrX9dwr+sC/YVW5clKUGImdtykgwn8VgpaB0hO07a7fCreQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(83380400001)(186003)(83080400001)(5660300002)(52536014)(2906002)(55016002)(86362001)(9686003)(478600001)(966005)(26005)(6916009)(316002)(4326008)(7696005)(54906003)(6506007)(53546011)(66946007)(66446008)(33656002)(45080400002)(66556008)(66476007)(76116006)(64756008)(8936002)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: GKJsOt1OLU8Mt7SycKWqRdyEdTcWKTxbHsMR+/3juz7WqPRS14sfKG2YnHonxMNFQ235JQFmtOslVVQklTzmiCsxOMZakjXg+ortU/822j9+7euVdon/xzINI2czP43q7gE0pD/72cZbU+0wrQHQwx2m3C3YnfNhJEf1DAJp6htVJmAn8xYVxZ8VUjDzmVzQKirnHE17ioERFNSU/Dbqj4x3wu4rpmcXrnpqmyHD7GJRt2dPzzKW+7zAmRj6G36pmEoIwO5jSzMCSvdpusFYYio5AlydTo3lZ4WV0gjiMLOFnoJB267iBBFgDF1UDUou76hKNF1dTP4D7AevM3VLrzbyY1fbSHUmEJsY2fiGpZLCqzttt/MB+Z6vz0FseJrzew3cCjO2fkTgTE3h0xRq3AhWC83w6AbM8gD9Hx4DgVA96Fpk7m/RK7yunLIqoVCXGB9k7HEBdsXSBC9pshmj/Ajk6t7YMJvyAOWTZL1kQKavIhn/MFfZ9GK2aRwIsEAz
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589be8ca-8066-4668-0fac-08d806fcb181
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 13:56:05.2127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Vxw2fofdwwN6kZj6o6BQ1dZHKPyGo7zlb0CNUOi94erkOCgX8pjRTg2xf23mwb/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4020
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ah not aware the enable patch before. But the already enable patch seems can't fallback to legacy gpuinfo FW load method when not support discovery and also may miss destroy the discovery_bin object when driver shut down.

Thanks,
Prike
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, June 2, 2020 9:35 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: enable renoir discovery for gc info
> retrieved
>
> On Mon, Jun 1, 2020 at 10:14 PM Liang, Prike <Prike.Liang@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > Ping...
>
> Already enabled:
> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.free
> desktop.org%2F~agd5f%2Flinux%2Fcommit%2F%3Fh%3Damd-staging-drm-
> next%26id%3De467ab869f5783cf93d4cf24c6ac647cc29d1fb5&amp;data=02%
> 7C01%7CPrike.Liang%40amd.com%7C5bcc45116bb042163cec08d806f9bd58
> %7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637267016987033
> 430&amp;sdata=KJ0xmSPXwlZ4LEfhAYoFzAwaWyx3laoLAsQccMM0pcs%3D&
> amp;reserved=0
>
> Alex
>
> >
> > Thanks,
> > > -----Original Message-----
> > > From: Liang, Prike <Prike.Liang@amd.com>
> > > Sent: Friday, May 29, 2020 11:28 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > > <Ray.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > > Subject: [PATCH] drm/amdgpu: enable renoir discovery for gc info
> > > retrieved
> > >
> > > Use ip discovery GC table instead of gpu info firmware for exporting
> > > gpu info to inquire interface.As Renoir discovery has same version
> > > with Navi1x therefore just enable it same way as Navi1x.
> > >
> > > Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23
> > > ++++++++++++++++++++---
> > >  1 file changed, 20 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index 2f0e8da..bff740ccd 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -1528,7 +1528,7 @@ static int
> > > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)  {
> > > const char *chip_name;  char fw_name[30]; -int err;
> > > +int err, r;
> > >  const struct gpu_info_firmware_header_v1_0 *hdr;
> > >
> > >  adev->firmware.gpu_info_fw = NULL;
> > > @@ -1578,6 +1578,23 @@ static int
> > > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
> > > chip_name = "arcturus";  break;  case CHIP_RENOIR:
> > > +if (amdgpu_discovery) {
> > > +/**
> > > + * For RENOIR series seems needn't reinitialize the reg base
> > > again as it already set during
> > > + * early init,if any concern here will need export
> > > amdgpu_discovery_init() for this case.
> > > + */
> > > +r = amdgpu_discovery_reg_base_init(adev);
> > > +if (r) {
> > > +DRM_WARN("failed to get ip discovery table,
> > > "
> > > +"fallback to get gpu info in legacy
> > > method\n");
> > > +goto legacy_gpuinfo;
> > > +}
> > > +
> > > +amdgpu_discovery_get_gfx_info(adev);
> > > +
> > > +return 0;
> > > +}
> > > +legacy_gpuinfo:
> > >  chip_name = "renoir";
> > >  break;
> > >  case CHIP_NAVI10:
> > > @@ -1617,7 +1634,7 @@ static int
> > > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)  (const
> > > struct gpu_info_firmware_v1_0 *)(adev-
> > > >firmware.gpu_info_fw->data +
> > >
> > > le32_to_cpu(hdr->header.ucode_array_offset_bytes));
> > >
> > > -if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
> > > +if (amdgpu_discovery && adev->asic_type >= CHIP_RENOIR
> > > && !r) {
> > >  amdgpu_discovery_get_gfx_info(adev);
> > >  goto parse_soc_bounding_box;
> > >  }
> > > @@ -3364,7 +3381,7 @@ void amdgpu_device_fini(struct
> amdgpu_device
> > > *adev)
> > >  sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);  if
> > > (IS_ENABLED(CONFIG_PERF_EVENTS))  amdgpu_pmu_fini(adev); -if
> > > (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
> > > +if (amdgpu_discovery && adev->asic_type >= CHIP_RENOIR)
> > >  amdgpu_discovery_fini(adev);
> > >  }
> > >
> > > --
> > > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7CPr
> >
> ike.Liang%40amd.com%7C5bcc45116bb042163cec08d806f9bd58%7C3dd896
> 1fe4884
> >
> e608e11a82d994e183d%7C0%7C0%7C637267016987033430&amp;sdata=R%
> 2F%2BY%2B
> >
> z%2BKHh09WazkQqS%2FbwH%2BeBM97%2Fx5hvqWAjUYEtM%3D&amp;res
> erved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
