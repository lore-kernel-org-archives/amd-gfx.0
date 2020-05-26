Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D077C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 04:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D273207ED
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 04:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a7jaxS9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D273207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99AAD89D2F;
	Tue, 26 May 2020 04:35:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B9089D2F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 04:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asGkAGkmeL2biIj//tdTEM6VAD6BhcV4LfsUDdwz/3w8nqTLW5lyX/4v5INUyEpVMrrmZuavSjvb5Qe+HhO3jCE15rRlNYoTkxWLXWN9tf4tR8EBT04ZcCjI4tebYHlFrx92/x5eRfbCKVxrBylWH6T7D3vf1RROVwQif+3EAnyZnlmiXHofe4PMfxWiCPMKQ7EKp01OXy3crT6KVIVdAQ/IrF9tnxtU4xLN8UYj8Iox5uOX78bg1xHscOt5VMunfzWm+aZ02DFUuDTrHvd5FEP7lUdqASYuhkTHeq/o9gTuk2boTIahY2tKtlPnJmPUpBjzT7lPLMnlH8SRslGMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJxkPkvxVNEfzyvltro0ap8KzDtGA8iVIKo1S0kC2sQ=;
 b=UCMw/JByFQ7I71GCt2k5EtBlyOGZK8XzSLpNDaXZv5gqzFAx7JCAOZ52MZikRrZh23rlEZIF+w28pBMMHH4FwLUIfDmuG2ZBzq/NHEtnuLWOQ3pURHDdytQiPnFQIvy5eZiFXrt7hBiC4SQXodtJhOU/dwRNU3mSvyCuzf7J2bq3EXZEZEQ2mj5db1S08cVOtqa8zDoUfzDRG6Ee//kMhHZZ/yjgissV/ENJblXyb1be65AOyjYbii0oqvce4FuzZcjuqrrALVTjZdEAxxXkSO70fArUNbMSdpmf7cFhx5CvbUxEvIXo9ZauVisjy5/NmshVSPOwMpKkjHaJmRCpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJxkPkvxVNEfzyvltro0ap8KzDtGA8iVIKo1S0kC2sQ=;
 b=a7jaxS9DaMXizIj/QwBX9DCaPulDzlEZe25lhinUQvegVhH/qccv9naStUJRE6HJU291jL9H8DUn4oRPaip4VuH0r2dHGySsCUbraAI3uzs7zIAwmYuJgpfKM+TEOhn3g6KgQahxu9riSvZ1KgUPThms2i3a4EzVQJoUNJrqm0U=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1307.namprd12.prod.outlook.com (2603:10b6:3:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 04:35:04 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570%5]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 04:35:04 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Wan, Gavin" <Gavin.Wan@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Index: AQHWMGWfuC9q/juYjECdiIbRciubK6i0eJIAgAAIc4CABUwhoA==
Date: Tue, 26 May 2020 04:35:04 +0000
Message-ID: <DM5PR12MB1708EEBF8C63692DC3A1E75384B00@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200522181931.277182-1-Gavin.Wan@amd.com>
 <CADnq5_P3a9-_zaoZBGi1nrnUJ2HVYb4_UWpjxLn7+S9qSe5zpQ@mail.gmail.com>
 <DM6PR12MB41219812A4B209595F9DA352FCB40@DM6PR12MB4121.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB41219812A4B209595F9DA352FCB40@DM6PR12MB4121.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58208313-071c-4628-e705-08d8012e2933
x-ms-traffictypediagnostic: DM5PR12MB1307:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB130756F1246BB3F3790F0FB884B00@DM5PR12MB1307.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: edX4K7D7iC8Lq8VcMXI7Ji10C1v0pLhjOPBtcZI44Oo+2W7xagnGxqPReZJ43KMRhRadoCq4GRHDpPJbGr1uHYSLTgF0vO5QsomAA6v64mMB3qt0vOMvX1UAQXVsRo4DMYi8IzFUbi7bHiKtZucUnZ5W9NlqLq5fpfEkuZg1/n1zrYuecwBrNUd9GouNlmVwYdN1VO2TIs63AocvH1XvJSEZyKxbMH0YNU5vovns4vzwVNQHShDo932U43eqMbIYIoIXaV97Ah6Q1cbU8IEWoELTF9aGNr1zMbamdCumaHPkUEU2moD8qdwBJN3XNIpKt4ANDWM8rHPpln7smvDjxR2BUyBi8b/su3Tgc/4y1zgGhDql2yuGMbC3Ox/MUfAt0JBtDXuufwkklNXyM8S3fQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(71200400001)(4326008)(186003)(52536014)(86362001)(966005)(45080400002)(9686003)(66446008)(83080400001)(26005)(8676002)(8936002)(55016002)(66556008)(316002)(64756008)(7696005)(478600001)(66476007)(53546011)(110136005)(76116006)(5660300002)(6506007)(66946007)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Wx/h0pasba8cndRGIpn1P/PkpWJ5zyvaCWADJtLm+3geb47X1odHrD0X6vJuAHG/7PyQNJM46DSJjeBMsme1hVcHYX1ecu/GaMNpQD/iihhWJ8xAuIHithKm8OcVz15FDx3vub5dcRg0d0oOpEPB3t9XiKkA+TZZMobBykKl3bNGW8LwIQy4kL3fjOKeDkhhSpTyX0RzSHIc0hjj/5ZjBHvumAZgLEJGExska9JaLzLmbspi4Jz3+TwbgeR9/STcGpPhkIgQ3SRiZhGAlV/hQgfFH+OT/FPtTW15shGqyyiQx7OiF++YeJINDUl+owIN+XE6YgHXUUL5oThbryxiHzJvf1uMKImHUbwiwAirYYRnKKyo8DHW5i2Xr/nSgpqoNqqoXJyDDAU0zhVTXjzFgNlvFgO0CQRmZsHZVxH9taeZr0sFHDUAGyLUWEDkzlX13GJJ5maKKgEkDUuuMzIZ75I7/k5SGVbSVclnjFB05IBjjXznTY++sjFMw/9rlskf
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58208313-071c-4628-e705-08d8012e2933
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 04:35:04.2156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1IaF2qzJYt0LdMYSU+27HkSWSXylt174RBonMz2woknNbbRUBl9+e5LNF/O4wtxg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1307
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

This one looks better

You can put my RB 

Thanks 

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wan, Gavin
Sent: Saturday, May 23, 2020 3:41 AM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

HI Alex,

I fixed it as your suggestion.

Thanks,
Gavin

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Friday, May 22, 2020 3:11 PM
To: Wan, Gavin <Gavin.Wan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

On Fri, May 22, 2020 at 2:20 PM Gavin Wan <Gavin.Wan@amd.com> wrote:
>
> For SRIOV, since the CP_INT_CNTL_RING0 is programed on host side.
> The Guest should not program CP_INT_CNTL_RING0 again.
>
> Change-Id: Ic336fab3b23b8371c9e9e192182a3ba14a8db8e1
> Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index bd5dd4f64311..39275bf79448 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4558,6 +4558,9 @@ static void gfx_v10_0_constants_init(struct 
> amdgpu_device *adev)  static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
>                                                bool enable)  {
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +

This needs to be below the stack variable declarations or you'll get a warning.

Alex

>         u32 tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
>
>         tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, 
> CNTX_BUSY_INT_ENABLE,
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CGa
> vin.Wan%40amd.com%7C23c1770b248841c7032a08d7fe83d940%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637257714548695750&amp;sdata=PaWH5hLNb3N1Z
> lalw4GsjeeB46xzCVxXDWBROndcKsk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7Cc7ef193b2ceb418c3be608d7fe880de4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257732654114415&amp;sdata=2kIarekeuDY4gio%2F%2BKbQJsl8RbWrmPC9K1KnwopK5FM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
