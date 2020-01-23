Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B37C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 16:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552FF21734
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 16:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KQ+TuzhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552FF21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2813E6E051;
	Thu, 23 Jan 2020 16:58:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2079E6E051
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 16:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faLY3ufk0nQRz639mz1UafpZloqciyY8FqCVJhFjxUmVWDoIxp1cLFDAdu71kV5ds0jRX/BureW0lvpBRVTnYOP4gpT+RXmFNg4kBk6R3kzeGt95+ifGiYe6R0uhy2yy4pKDfLEKkK8k5LYrPbHAC/d3QL7oAjHZIO/2WYP2mxAPQ2N4OvbW952rShotGa2jCMDBGzLEAGPEALut00bpfMZPlc88tYiT3Pmvx9dxW/Mia7z+GLe5D0DiThTe000MNpJaWtCDAIZiOpuMPPIA7RwCJYhtNMmYF957TLN5WRjDqAjaKSEYNVr3wPCOaZYIGz8hktuBnq6BnKGqC69RCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I+okrjlTVFyrO62ZNuGDVYEmb2l5QUsL6tyn0hWtJY=;
 b=h9qjkwQfxmE2CGS7djKA78R1E+7FxS9q1dzLIfshaIZrjU9CCjV+PB1/LRr+HGFcBuJ3Q60eh1ve/V9+cGHpqnWh03XVKn5//9YR91WaVMO01Q6/jz/qUPqpJvOomJPcdRRLI2U6xLIrSJC5bMR/Xoik0wRtYGgkfjLDYIK3q6fS+UUg+dzTLuurHFhQofwWDTYMKDuSmbq+/BQHf/OVEFZeijxPyUqRUJPViBqh2KkNLIZaOdmiXS5L2nrq0AZ5VRw4JR8jlCITLMClZXhAdl+2Rsmfs0voPMpZ93OfrFfpX3aFGeWagZn4nMkQ6WZZAMHADKhUnGqY9MDDG8hf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I+okrjlTVFyrO62ZNuGDVYEmb2l5QUsL6tyn0hWtJY=;
 b=KQ+TuzhSKU+4/TDW7dvRizHO45tRSCcQd6Z5Pn3gzeQAJQgOe8Vh9m+mHDEBjpcC1sMG7x7ORVbQ3M0focXHELMxM0qxhYCFCbNPqTH7FHOlGSY1nWGW9QUZP6GPuGsrcR/p5jR1KRtjjck9zrQy+ZGesuFnYNASjkbsIe2PjFs=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1740.namprd12.prod.outlook.com (10.175.89.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 16:58:47 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 16:58:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove the experimental flag for renoir
Thread-Topic: [PATCH] drm/amdgpu: remove the experimental flag for renoir
Thread-Index: AQHV0UODDw2ueOQ1ukGd3ZgjZpT096f4bA+AgAAODvA=
Date: Thu, 23 Jan 2020 16:58:46 +0000
Message-ID: <DM5PR12MB1418ADA5BE23023163B62858FC0F0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200122164623.239931-1-alexander.deucher@amd.com>
 <CADnq5_N4_oaHNXHcXj79-O3d-y+v=ZrEhnJ=MhtfYm-5ixgzCw@mail.gmail.com>
In-Reply-To: <CADnq5_N4_oaHNXHcXj79-O3d-y+v=ZrEhnJ=MhtfYm-5ixgzCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-23T16:58:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f1e13554-1385-4ab7-a0b3-0000f860ee3c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-23T16:58:45Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9a3d039d-f246-4f12-98f0-0000679a0b7e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b823faa8-b52e-4c9b-64d6-08d7a025831f
x-ms-traffictypediagnostic: DM5PR12MB1740:|DM5PR12MB1740:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17409604303AFCFCADCCA44CFC0F0@DM5PR12MB1740.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(26005)(186003)(8936002)(66556008)(66476007)(6506007)(53546011)(66446008)(45080400002)(64756008)(478600001)(5660300002)(66946007)(76116006)(2906002)(316002)(7696005)(71200400001)(33656002)(55016002)(52536014)(966005)(8676002)(86362001)(9686003)(81156014)(4326008)(81166006)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1740;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFDZrt+NEP4Ksgj+wj5lH63eYrMcLdF+QQjA5y0mw2NDb/oo2KBYbeAPSdOYHyB/wCpT7AVeCah5ZKTolXDKbK/M3Q32Ycyyw5nc3FZkPQ9Mvb+8PGJ/igdu8UQ9JCsp+gFv/lZZtwwMes2Gk9AfICN66zdvheY1rbQX6Qg+WzbKlkjGZCavphCVUWKwkIjLiFrGwIWrYDqPj0H/rmDVsyYcS/bnGelNyGoewzPvJ0WiqZjfPCClNmCiBrJKi2q5dOWi6ch14KDajCk+vdpBxNIBEZHHaTuUsOiLqMB+eYIsVh1hXS7f/kcSkLaouZFhFGbo4jOKsmygkzJ8Pd7v9f3QpOty45caNBQ4yRFb1e+KwNZbTaxFJT+13lQiVJnFdLsWZB/LryS0MpJyMAugKeSEoENQxFVkH/A4EZHnDVeBLW5rUn7o9Qv1fb0hVD4SnKzRc1jgf7pA1FgShEtzbS/4bstCc8jI/YyDm54Lk4k=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b823faa8-b52e-4c9b-64d6-08d7a025831f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 16:58:46.9351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSIvGpI7EXFPGwkw39/XH20NELOrZZ02yrStOzgi+/tnpvakQQHTGKOnLRMmVzeULtWkyhfapVgYgZ8M0A62cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1740
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, January 24, 2020 00:08
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: remove the experimental flag for renoir

Ping?

Alex

On Wed, Jan 22, 2020 at 11:46 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Should work properly with the latest sbios on 5.5 and newer kernels.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 01a793a0cbf7..30a1e3ac21d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1004,7 +1004,7 @@ static const struct pci_device_id pciidlist[] = {
>         {0x1002, 0x734F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI14},
>
>         /* Renoir */
> -       {0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU|AMD_EXP_HW_SUPPORT},
> +       {0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
> + CHIP_RENOIR|AMD_IS_APU},
>
>         /* Navi12 */
>         {0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
> CHIP_NAVI12|AMD_EXP_HW_SUPPORT},
> --
> 2.24.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cbea189f0eb804f3964cf08d7a01e7897%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637153925050975234&amp;sdata=Q8GdcfxnoLYcUrZJfb%2FGDzKxyY5gknAu8KUFZ7Scwso%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
