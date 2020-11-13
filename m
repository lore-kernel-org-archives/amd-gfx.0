Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8478C388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7824C20A8B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DgkGEiwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7824C20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C0636E3CE;
	Fri, 13 Nov 2020 06:42:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4731B6E3CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 06:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSW2qv9e3a0+t+Fnd1Z9npewA1fmSj6Ms8ppAsxV3stZXz0labyq+Vxq60inm8o5x5cF3Tb8RW7ZQqLsbeuIkiVnxdWbD8rK7YXRt7JLJjXubi+DWSQQU5/aQaoJ98R0ZlkLvi22vMRV+lQANkFsShlHEZBxvrFpu+hC6Rij6HJd4Q0foYP4Q8+VSGGx/+uvDaJ70NuHb2YvIN9ngwwgQDp3cG3K2xZ6Kvm8GuFcGuyQiUlrJUQPY7rhTQJiwV0flDi8ORwZN74JPl0m21/+vBBwAPAhtkhZvQrn8aR8IodxZoO6F5qzIoRInN8/dTBwT8rI3foLgZta9ipUxnp4/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwyFQOF4BTiNcLd6N49jl5Xr4+oVLXbgZmI95CLaZa4=;
 b=Ilmy4+DyLAYFrEBaXhCxVHdMgU0J1D/AGvgWsk3whqm5zyI8md/ahC78qmvyD9WOGpj2XNYRiGOHNbNoCcrX/GlewEIqBN78LYvWZxmNfAJXBykumJCazFwyVi/G8RDnHyD6bUdeQ3Sl3dAJUS8J8yWloCYV2pXcEw3BKD4Oy9JA38Kek50Nsvp2oa14Fcq0gagqMwxpGA+JMLUC77WrVOo1eJmL6BhaN/x8oeZ+gEIkbVvkW3MDV3e6RS5u4Xjx33j0sZq4EUjhJoGDprFjyWK0+SmjvbKjUpRYnKzRocYldrpanNvXKRqojkq49Go3qOqmJpU+LFVhLiQ/aacx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwyFQOF4BTiNcLd6N49jl5Xr4+oVLXbgZmI95CLaZa4=;
 b=DgkGEiwUGmjgYpCJbl8j+yEMPiTBQs3th6jiOA/OhPtywvs2wtD7iPGaMvBEkdNGqykmQEWvTdQ2IPPhNeZxmltSacLhFxIp7h2eqesTmItHK37tpCaLUxskQqD25eHhWHTghUrTCZL/NLlY5HUs0UaO+RqpkNV0mteEysJ3FYE=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 06:42:26 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 06:42:26 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: fix reset support for s0i3 enablement
Thread-Topic: [PATCH 4/5] drm/amdgpu: fix reset support for s0i3 enablement
Thread-Index: AQHWuMJjj+xFRQ/dN06js9QouV8+vanE6N6AgAC0bAA=
Date: Fri, 13 Nov 2020 06:42:25 +0000
Message-ID: <BYAPR12MB3238A2AE026F196CA676A49EFBE60@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
 <1605164796-22215-4-git-send-email-Prike.Liang@amd.com>
 <CADnq5_P3NAVn2znhsgwfm=9PdUyfC+0+3EH0VPHXw-KeASMOiQ@mail.gmail.com>
In-Reply-To: <CADnq5_P3NAVn2znhsgwfm=9PdUyfC+0+3EH0VPHXw-KeASMOiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=94fa379b-e58d-459d-a307-219d1333c2c7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-13T06:37:07Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b193211-be02-4486-baf6-08d8879f4898
x-ms-traffictypediagnostic: BYAPR12MB2981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29812A3B0FB8332BBD7DDEBBFBE60@BYAPR12MB2981.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IozkQM6b553NEVq+uQVA4VD2xotkWj9n06eScPt/3TMVqlwR454hEtKd1EQzgq1mO5Nab/hB9MTRxGSS0l+6ANPfJt6g1whuo2STB09VmPJ2f3uQP588qLI+S8DmsdUygCfaHwT5PkwVnNxHZwwQsJvHVMIjvys/qg0kWFK8ZYN1nIXGM56tOY/Fa/yCsBiF/Lf5QhAAl663rSQuU4Nu55a0WoGLs/LzHiyNU7BCCB+7evj+5/nxTTNWHlPvn96UZMmIjDZdKrRwg5j0BM8PyNfWxtSnAbTehuScm7hRbBw3mLGodlbrneSN9/zvIsC8/dH+ipxUdBcvuUkXyUK6u06T9Ect52TfJAQPWmcRkTaq+gDIVUK7ePnZlrhGZXSoTuLFmoIfqCPmZGu9N/+moQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(8936002)(55016002)(53546011)(6506007)(5660300002)(52536014)(45080400002)(83380400001)(478600001)(966005)(71200400001)(8676002)(66946007)(66476007)(64756008)(66446008)(66556008)(86362001)(7696005)(76116006)(2906002)(6916009)(186003)(9686003)(4326008)(33656002)(54906003)(316002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RXTJeCICRoYRlGGf2arXmLHEIO9QZ6ll/ycouJqaPD8W8D4bIFboFX6ZFmzg6V9pTfv38ISz43OtYFCPP8Ao5JOsIZotfY+hJCXficpxK4dy6sHDvc6egtJDQdu5F3YekPwgZCTF0C7WLQTX8HgHqHG/S8ovWmS/gVynxaPnMXfS1XZIx9R65cxjlUAVffkIAM9Qy36bL9QtF7AvtMUlouFSk0yRNGsxiltj3KtntUbhfddMvKE5ALOgOHVg6LUCtzPhfrMB66Q9OskxqfivtRso+WyQyXnKJPsbry4VXoIWH+jPrAi99cQlw1lznsT+EF6DcfAnDzMBiBfs1wXZzsH3eQM/Z49euP0rt+nYVVGfVN5062q7JKov0ZhQ2XgIYqocLvz1WnF8apgMuwlcgZhqinBDeCQlGt4a2WVnYkrUqahA0VlvsibZN7kv7oagAZs8bDV+7RirSrTGE84LR2QRJk48YcGGH4SFw4n2tOhsQLlkPWbhVcVlN7dL2B+L7zS63pHj7a+eLkOgD5dAdEa5gopc48Se27wnXKPJZbVWGAWYQpJ0JNZMp4TQwZiOZEMMCWTJcWQZuBSejkpeQPbHZ1Irz+pT+VfVaTJs3BCOSHr4RWfLE7gGTAyxE3VOYy1WG1iD6xeYCPjVBOIIMDhGJkelr8ewoSzQMF6QCvpmPBADeHBgjuzxcVQgmpyycWw76ofY4fj6NPxBIpRJuSZZiDGVRXW2fs+jH+iiVBL36d9UUYSpKe0DProsz7faoeH5LZF22ZwaWxRuZ2s4vrHshu7EhoKldUUJiQjEZKPZZhxYmojfwo+fx3tKuWaA2hC8GvnBozBb6tOVxzczNrbAwZyYZaxgwoO7ye3Xr6jtPbaq9IuvI7XQqzCCumyQUVZLvj2tnfVRebpaY1dJ3g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b193211-be02-4486-baf6-08d8879f4898
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 06:42:25.8545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utP6cJEJrZvp1xMpvyGGSUdFUk/qhqXVIxuzze5+XF2KtyryxQfZlgVVXPzU5BHj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, November 13, 2020 3:51 AM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: Re: [PATCH 4/5] drm/amdgpu: fix reset support for s0i3 enablement
>
> On Thu, Nov 12, 2020 at 2:06 AM Prike Liang <Prike.Liang@amd.com> wrote:
> >
> > update amdgpu device suspend sequence for gpu reset during s0i3 enable.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>
> Maybe squash this one into patch 3?
>
> Alex
>
[Prike]  Yes, this patch only handle the GPU reset base on the s0i3 enablement and will merge to patch3.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf6a1b9..2f60b70 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2650,7 +2650,7 @@ static int
> > amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)  {
> >         int i, r;
> >
> > -       if (!amdgpu_acpi_is_s0ix_supported()) {
> > +       if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev))
> > + {
> >                 amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> >                 amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> >         }
> > @@ -3708,7 +3708,7 @@ int amdgpu_device_suspend(struct drm_device
> > *dev, bool fbcon)
> >
> >         amdgpu_fence_driver_suspend(adev);
> >
> > -       if (!amdgpu_acpi_is_s0ix_supported())
> > +       if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev))
> >                 r = amdgpu_device_ip_suspend_phase2(adev);
> >         else
> >                 amdgpu_gfx_state_change_set(adev,
> > sGpuChangeState_D3Entry);
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPr
> >
> ike.Liang%40amd.com%7C59713bd6a49b4b094d8b08d887445bac%7C3dd89
> 61fe4884
> >
> e608e11a82d994e183d%7C0%7C0%7C637408074951136062%7CUnknown%7
> CTWFpbGZsb
> >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%
> >
> 7C2000&amp;sdata=Z%2FaCe7d5aGY2HHlc7iTRny%2B2DJl8jPv3QDSa2ad%2F
> zPk%3D&
> > amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
