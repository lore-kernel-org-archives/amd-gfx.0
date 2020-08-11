Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4306C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 20:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E4020771
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 20:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RT24G/o2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E4020771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 192036E83F;
	Tue, 11 Aug 2020 20:11:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146B46E83F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 20:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I54ydjeGabF6jCBZZe2dDEh3KIqvIVShfLgoq/TpxFnBFe6dua+K6FEZzVyGXxtq4liGblTVMm3iI2UaXvGy9LvGA5jpneivf4Tp1etSIUFxEwni/iCFoOpt/8z9qr5W0GBuBM13dBPtEyzVe4U1j2ZWzIOT/nk/GC0XcnPPDA0qvY26tSczUmZZqVoJ8W0Y71zW/WHT5hdwYm8llQhO0+MSFqJK7sutmMoBoDn/PA/2Q4eg/z3OBAaGnHXqHS6cM58OJtzzYKh+lX+A6aPGTRRnBCnNuZKyRRDuanGil5qN8DwU5EkoUfsGzSc3Yz0jM17LLzsRFZbObfeKTwlBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy8O0yXWg9TsJdbOYom950EPi5RmQ4055A5FY14hero=;
 b=CIq/GR3NWo0Qlv586f64Q2VjlYFQLavxxNzmIBsd88XEqcnaG8Z3ZB1CqqWSd17+LefCDVz4beCafPjQdPgT793PdUkoY6sVfDWJ1GYKAs1UpvibuEaBRMbeQrUnPW+ZCc9/r4xBwfjKGYY0NLB8xXLpCjKWJoUS2+s+j7T3ESN0UhBWNN8iBRcP9hBuV7cfUuKi6lrMDoEMBnVNYSYC7dDYcGPCWX4qmDY9T5xgiPP2R76bUL0AZ2ZTSdafpyoK+H8KdCUmwTYLNCCka08/q0AIitjjKztTTeXWovfNWUXHY0eVWW4o3ravMNKSAHI2lJA3NzVUSosnQHz84LBEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy8O0yXWg9TsJdbOYom950EPi5RmQ4055A5FY14hero=;
 b=RT24G/o26e3Jbpchmp4V87FE693zH48o7LBv4YFtxVjfklE5KsYPB0DwmO7iJCli6xONSBpy51R96yUo8d65kVx9hJ5l40Fdcw0elG2C1RLe+Sh1i8DeHi22UgBIUe3WYUboNkppgszczWv0lsUqatHjyBWLyG28cP77p1USYZE=
Received: from DM5PR12MB1643.namprd12.prod.outlook.com (2603:10b6:4:11::8) by
 DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Tue, 11 Aug 2020 20:11:10 +0000
Received: from DM5PR12MB1643.namprd12.prod.outlook.com
 ([fe80::8e5:a542:5281:d341]) by DM5PR12MB1643.namprd12.prod.outlook.com
 ([fe80::8e5:a542:5281:d341%12]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 20:11:10 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Use function pointer for some mmhub functions
Thread-Topic: [PATCH] drm/amdgpu: Use function pointer for some mmhub functions
Thread-Index: AQHWcAf1LY5aAgWxXUqWqfBeypV6T6kzQfeAgAAU6KA=
Date: Tue, 11 Aug 2020 20:11:10 +0000
Message-ID: <DM5PR12MB164356E5862C91D14C2BDCD580450@DM5PR12MB1643.namprd12.prod.outlook.com>
References: <1597168244-4395-1-git-send-email-Oak.Zeng@amd.com>
 <CADnq5_P42Bza8o+Ed9fF+XHLsrT9md4ZpLkYhdFR8LNV5G5AAg@mail.gmail.com>
In-Reply-To: <CADnq5_P42Bza8o+Ed9fF+XHLsrT9md4ZpLkYhdFR8LNV5G5AAg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d7a9d88a-8971-47e2-99e1-071d3c38ca24;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-11T20:10:33Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3c20:b12:8da2:c1cf:927:ecfc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cbb3fb7c-010e-4479-5881-08d83e32b076
x-ms-traffictypediagnostic: DM6PR12MB4385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4385F79437D14A7CF9F5B5ED80450@DM6PR12MB4385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+Daw/vl7KFoN/6e41U1wzTPhw4JON6bvhbNpHvSCE/3Bef9Vg8UabNaoIGQ0gUVjZ5XjvSLFim8k+6R2JXJuaFtRLPXrRM937fUABfdM8HIVmb9R/r8J8HWCTqxOKz4JJs2fn14HUHPl3TiY0A5QOowzyaqE4te00c+x0iXyf7lnupbJRFR/oxsIOpSu/dL+wJDGS1V6kOJYvOmedm8gEg9YGvMzz959bv0VilmzlgMX8iMYd8LUhGkPHW5vKnPgOjQ+e7uqVEHb2w/KFStkfN11v0AfACjYdKbwHKR0EyEdeeZSJ1JA8+4aHXoV9j265joPHTpoVqNy1LhIIZya3sUvDBX6wpi43v7AJGvCKEl/zW9lgcyEe2YkLk/T1Dan+NeffMAjZeJVbGbpWdeQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1643.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(83080400001)(45080400002)(71200400001)(186003)(7696005)(6506007)(4326008)(30864003)(86362001)(53546011)(66446008)(5660300002)(8676002)(8936002)(55016002)(64756008)(76116006)(66556008)(2906002)(478600001)(6916009)(66476007)(52536014)(33656002)(966005)(54906003)(9686003)(83380400001)(316002)(66946007)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: oZelNM494l1gQ+hRyPwuRW5LYvQH8Ii9a/LEu/RgAY3iDo1kVG3rtlA0PFEiOVPODXiZV6kvOyXKA+ZdmVAe6vC+UCdusjOM59YmDJKAFAJD9F8dDT9ikh0ZFqxul83xdgE7mTPRBCSpAP4xKw1c18GcA7BYooPJIlSNDs9ZhdevGgW+YPFoKt4yMjIsTK+WB/GUfhIxt3bM03GBsDih8Kg4RrLGcn34xruWVSM10nks3OA2iNlCyYV1XVqqPnO88uhxuLMv+i7txjVzcaPPf6gqKMHbG+oQWnpMmUOLCL6waiWozQRD1VNHJDa+xDbhdkXZD+EhH39ikMzBkQyGDdjdLXL2l1bNzwJpc/pmSxhOMkbMBXqEwrQpbwlYfCtXIRWizvehuSI75UbxiY8NeuXiLSbWrH0BwW4zAioN5j3oeXZFoqfAJxrokV4ZCHtdAzb3JhsKGdlo/e9SLvBECqttUsGP2+ZCQz8C/gOkGt5bokB+4GfbYUGp3a9Jtyzu8exi/A4e10Mwv7t+3SOXubG3mOkD5cujldoPPFhJl1RG3KuQKIPYhibQqdRLWpeddFYor/T5skQ3oAWN0/gTO1Q75eq/JotaB2icHMB4rcxX0X2EjWzL9EnZzSdbNdEXSN0p5cc6JdDgc7M1nYMDzb3pZcd72EG25lR7ZgmerXR7xywL+qRUmoWcwSBq1PpH7FMtyznuHQiK5WCgHZxqPA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1643.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb3fb7c-010e-4479-5881-08d83e32b076
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 20:11:10.1108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKa9m9yDfGdRD37d//BrOe9n15pFsB2K2d9wNGTnhAWX9l7huVaFRWUlJlQ+KK54
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Alex, Yes I saw the same clean up for gfxhub. Will do it when I get a chance.

Regards,
Oak

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, August 11, 2020 2:56 PM
To: Zeng, Oak <Oak.Zeng@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Use function pointer for some mmhub functions

On Tue, Aug 11, 2020 at 1:50 PM Oak Zeng <Oak.Zeng@amd.com> wrote:
>
> Add more function pointers to amdgpu_mmhub_funcs. ASIC specific
> implementation of most mmhub functions are called from a general
> function pointer, instead of calling different function for different
> ASIC. Simplify the code by deleting duplicate functions
>
> Change-Id: I65ba660c69b74c7e779190c4f92e9d7138f7c7d4
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    | 21 ++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |  4 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          | 13 ++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             | 13 +++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              | 48 ++++++----------------
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            | 27 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h            | 14 -------
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            | 25 +++++++----
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h            | 11 +----
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            | 24 +++++++----
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h            | 12 ------
>  12 files changed, 94 insertions(+), 121 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 6529cac..b914434 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -284,22 +284,6 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
>         return 0;
>  }
>
> -static void kgd_set_vm_context_page_table_base(struct kgd_dev *kgd, uint32_t vmid,
> -               uint64_t page_table_base)
> -{
> -       struct amdgpu_device *adev = get_amdgpu_device(kgd);
> -
> -       if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
> -               pr_err("trying to set page table base for wrong VMID %u\n",
> -                      vmid);
> -               return;
> -       }
> -
> -       mmhub_v9_4_setup_vm_pt_regs(adev, vmid, page_table_base);
> -
> -       gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);
> -}
> -
>  const struct kfd2kgd_calls arcturus_kfd2kgd = {
>         .program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>         .set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -318,7 +302,8 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
>         .wave_control_execute = kgd_gfx_v9_wave_control_execute,
>         .address_watch_get_offset = kgd_gfx_v9_address_watch_get_offset,
>         .get_atc_vmid_pasid_mapping_info =
> -                       kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
> -       .set_vm_context_page_table_base = kgd_set_vm_context_page_table_base,
> +                               kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
> +       .set_vm_context_page_table_base =
> +
> + kgd_gfx_v9_set_vm_context_page_table_base,
>         .get_hive_id = amdgpu_amdkfd_get_hive_id,  }; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 032d3c8..7e11625 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -679,7 +679,7 @@ uint32_t kgd_gfx_v9_address_watch_get_offset(struct kgd_dev *kgd,
>         return 0;
>  }
>
> -static void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev
> *kgd,
> +void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev *kgd,
>                         uint32_t vmid, uint64_t page_table_base)  {
>         struct amdgpu_device *adev = get_amdgpu_device(kgd); @@ -690,7
> +690,7 @@ static void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev *kgd,
>                 return;
>         }
>
> -       mmhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);
> +       adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid,
> + page_table_base);
>
>         gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index aedf67d..f098e88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -60,3 +60,6 @@ uint32_t kgd_gfx_v9_address_watch_get_offset(struct
> kgd_dev *kgd,
>
>  bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
>                                         uint8_t vmid, uint16_t
> *p_pasid);
> +
> +void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev *kgd,
> +                       uint32_t vmid, uint64_t page_table_base);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
> index e89fb35..0c43d7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
> @@ -27,6 +27,19 @@ struct amdgpu_mmhub_funcs {
>         void (*query_ras_error_count)(struct amdgpu_device *adev,
>                                         void *ras_error_status);
>         void (*reset_ras_error_count)(struct amdgpu_device *adev);
> +       u64 (*get_fb_location)(struct amdgpu_device *adev);
> +       void (*init)(struct amdgpu_device *adev);
> +       int (*gart_enable)(struct amdgpu_device *adev);
> +       void (*set_fault_enable_default)(struct amdgpu_device *adev,
> +                       bool value);
> +       void (*gart_disable)(struct amdgpu_device *adev);
> +       int (*set_clockgating)(struct amdgpu_device *adev,
> +                              enum amd_clockgating_state state);
> +       void (*get_clockgating)(struct amdgpu_device *adev, u32 *flags);
> +       void (*setup_vm_pt_regs)(struct amdgpu_device *adev, uint32_t vmid,
> +                               uint64_t page_table_base);
> +       void (*update_power_gating)(struct amdgpu_device *adev,
> +                                bool enable);
>  };
>
>  struct amdgpu_mmhub {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index f0f50e7..526fd1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -631,6 +631,7 @@ static int gmc_v10_0_early_init(void *handle)  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> +       adev->mmhub.funcs = &mmhub_v2_0_funcs;

Maybe add a gmc_v10_set_mmhub_funcs() function for consistency with other families?  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Also, it looks like gfxhub could use a similar clean up.  Care to take a look at that as well?

Thanks,

Alex


>         gmc_v10_0_set_gmc_funcs(adev);
>         gmc_v10_0_set_irq_funcs(adev);
>         gmc_v10_0_set_umc_funcs(adev); @@ -775,7 +776,7 @@ static int
> gmc_v10_0_sw_init(void *handle)
>         else
>                 gfxhub_v2_0_init(adev);
>
> -       mmhub_v2_0_init(adev);
> +       adev->mmhub.funcs->init(adev);
>
>         spin_lock_init(&adev->gmc.invalidate_lock);
>
> @@ -944,7 +945,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>         if (r)
>                 return r;
>
> -       r = mmhub_v2_0_gart_enable(adev);
> +       r = adev->mmhub.funcs->gart_enable(adev);
>         if (r)
>                 return r;
>
> @@ -966,7 +967,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>                 gfxhub_v2_1_set_fault_enable_default(adev, value);
>         else
>                 gfxhub_v2_0_set_fault_enable_default(adev, value);
> -       mmhub_v2_0_set_fault_enable_default(adev, value);
> +       adev->mmhub.funcs->set_fault_enable_default(adev, value);
>         gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB_0, 0);
>         gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB_0, 0);
>
> @@ -1011,7 +1012,7 @@ static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
>                 gfxhub_v2_1_gart_disable(adev);
>         else
>                 gfxhub_v2_0_gart_disable(adev);
> -       mmhub_v2_0_gart_disable(adev);
> +       adev->mmhub.funcs->gart_disable(adev);
>         amdgpu_gart_table_vram_unpin(adev);
>  }
>
> @@ -1078,7 +1079,7 @@ static int gmc_v10_0_set_clockgating_state(void *handle,
>         int r;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       r = mmhub_v2_0_set_clockgating(adev, state);
> +       r = adev->mmhub.funcs->set_clockgating(adev, state);
>         if (r)
>                 return r;
>
> @@ -1093,7 +1094,7 @@ static void gmc_v10_0_get_clockgating_state(void
> *handle, u32 *flags)  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       mmhub_v2_0_get_clockgating(adev, flags);
> +       adev->mmhub.funcs->get_clockgating(adev, flags);
>
>         if (adev->asic_type == CHIP_SIENNA_CICHLID ||
>             adev->asic_type == CHIP_NAVY_FLOUNDER) diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 65488dd..773ee11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -908,13 +908,11 @@ static void gmc_v9_0_set_umc_funcs(struct
> amdgpu_device *adev)  static void gmc_v9_0_set_mmhub_funcs(struct
> amdgpu_device *adev)  {
>         switch (adev->asic_type) {
> -       case CHIP_VEGA20:
> -               adev->mmhub.funcs = &mmhub_v1_0_funcs;
> -               break;
>         case CHIP_ARCTURUS:
>                 adev->mmhub.funcs = &mmhub_v9_4_funcs;
>                 break;
>         default:
> +               adev->mmhub.funcs = &mmhub_v1_0_funcs;
>                 break;
>         }
>  }
> @@ -980,10 +978,8 @@ static void gmc_v9_0_vram_gtt_location(struct
> amdgpu_device *adev,  {
>         u64 base = 0;
>
> -       if (adev->asic_type == CHIP_ARCTURUS)
> -               base = mmhub_v9_4_get_fb_location(adev);
> -       else if (!amdgpu_sriov_vf(adev))
> -               base = mmhub_v1_0_get_fb_location(adev);
> +       if (!amdgpu_sriov_vf(adev))
> +               base = adev->mmhub.funcs->get_fb_location(adev);
>
>         /* add the xgmi offset of the physical node */
>         base += adev->gmc.xgmi.physical_node_id *
> adev->gmc.xgmi.node_segment_size; @@ -1083,10 +1079,8 @@ static int gmc_v9_0_sw_init(void *handle)
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         gfxhub_v1_0_init(adev);
> -       if (adev->asic_type == CHIP_ARCTURUS)
> -               mmhub_v9_4_init(adev);
> -       else
> -               mmhub_v1_0_init(adev);
> +
> +       adev->mmhub.funcs->init(adev);
>
>         spin_lock_init(&adev->gmc.invalidate_lock);
>
> @@ -1313,10 +1307,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>         if (r)
>                 return r;
>
> -       if (adev->asic_type == CHIP_ARCTURUS)
> -               r = mmhub_v9_4_gart_enable(adev);
> -       else
> -               r = mmhub_v1_0_gart_enable(adev);
> +       r = adev->mmhub.funcs->gart_enable(adev);
>         if (r)
>                 return r;
>
> @@ -1351,11 +1342,10 @@ static int gmc_v9_0_hw_init(void *handle)
>                                                 golden_settings_vega10_hdp,
>
> ARRAY_SIZE(golden_settings_vega10_hdp));
>
> +       if (adev->mmhub.funcs->update_power_gating)
> +               adev->mmhub.funcs->update_power_gating(adev, true);
> +
>         switch (adev->asic_type) {
> -       case CHIP_RAVEN:
> -               /* TODO for renoir */
> -               mmhub_v1_0_update_power_gating(adev, true);
> -               break;
>         case CHIP_ARCTURUS:
>                 WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC, 1);
>                 break;
> @@ -1381,10 +1371,7 @@ static int gmc_v9_0_hw_init(void *handle)
>
>         if (!amdgpu_sriov_vf(adev)) {
>                 gfxhub_v1_0_set_fault_enable_default(adev, value);
> -               if (adev->asic_type == CHIP_ARCTURUS)
> -                       mmhub_v9_4_set_fault_enable_default(adev, value);
> -               else
> -                       mmhub_v1_0_set_fault_enable_default(adev, value);
> +               adev->mmhub.funcs->set_fault_enable_default(adev,
> + value);
>         }
>         for (i = 0; i < adev->num_vmhubs; ++i)
>                 gmc_v9_0_flush_gpu_tlb(adev, 0, i, 0); @@ -1421,10
> +1408,7 @@ static void gmc_v9_0_save_registers(struct amdgpu_device
> *adev)  static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
> {
>         gfxhub_v1_0_gart_disable(adev);
> -       if (adev->asic_type == CHIP_ARCTURUS)
> -               mmhub_v9_4_gart_disable(adev);
> -       else
> -               mmhub_v1_0_gart_disable(adev);
> +       adev->mmhub.funcs->gart_disable(adev);
>         amdgpu_gart_table_vram_unpin(adev);
>  }
>
> @@ -1497,10 +1481,7 @@ static int gmc_v9_0_set_clockgating_state(void
> *handle,  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       if (adev->asic_type == CHIP_ARCTURUS)
> -               mmhub_v9_4_set_clockgating(adev, state);
> -       else
> -               mmhub_v1_0_set_clockgating(adev, state);
> +       adev->mmhub.funcs->set_clockgating(adev, state);
>
>         athub_v1_0_set_clockgating(adev, state);
>
> @@ -1511,10 +1492,7 @@ static void gmc_v9_0_get_clockgating_state(void
> *handle, u32 *flags)  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       if (adev->asic_type == CHIP_ARCTURUS)
> -               mmhub_v9_4_get_clockgating(adev, flags);
> -       else
> -               mmhub_v1_0_get_clockgating(adev, flags);
> +       adev->mmhub.funcs->get_clockgating(adev, flags);
>
>         athub_v1_0_get_clockgating(adev, flags);  } diff --git
> a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index dffcb93..e24d6e5 100755
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -34,7 +34,7 @@
>  #define mmDAGB0_CNTL_MISC2_RV 0x008f
>  #define mmDAGB0_CNTL_MISC2_RV_BASE_IDX 0
>
> -u64 mmhub_v1_0_get_fb_location(struct amdgpu_device *adev)
> +static u64 mmhub_v1_0_get_fb_location(struct amdgpu_device *adev)
>  {
>         u64 base = RREG32_SOC15(MMHUB, 0, mmMC_VM_FB_LOCATION_BASE);
>         u64 top = RREG32_SOC15(MMHUB, 0, mmMC_VM_FB_LOCATION_TOP); @@
> -51,7 +51,7 @@ u64 mmhub_v1_0_get_fb_location(struct amdgpu_device *adev)
>         return base;
>  }
>
> -void mmhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t
> vmid,
> +static void mmhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev,
> +uint32_t vmid,
>                                 uint64_t page_table_base)  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0]; @@
> -297,7 +297,7 @@ static void mmhub_v1_0_program_invalidation(struct amdgpu_device *adev)
>         }
>  }
>
> -void mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
> +static void mmhub_v1_0_update_power_gating(struct amdgpu_device
> +*adev,
>                                 bool enable)  {
>         if (amdgpu_sriov_vf(adev))
> @@ -310,7 +310,7 @@ void mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
>         }
>  }
>
> -int mmhub_v1_0_gart_enable(struct amdgpu_device *adev)
> +static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev)
>  {
>         if (amdgpu_sriov_vf(adev)) {
>                 /*
> @@ -338,7 +338,7 @@ int mmhub_v1_0_gart_enable(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -void mmhub_v1_0_gart_disable(struct amdgpu_device *adev)
> +static void mmhub_v1_0_gart_disable(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
>         u32 tmp;
> @@ -373,7 +373,7 @@ void mmhub_v1_0_gart_disable(struct amdgpu_device *adev)
>   * @adev: amdgpu_device pointer
>   * @value: true redirects VM faults to the default page
>   */
> -void mmhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
> bool value)
> +static void mmhub_v1_0_set_fault_enable_default(struct amdgpu_device
> +*adev, bool value)
>  {
>         u32 tmp;
>
> @@ -415,7 +415,7 @@ void mmhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev, bool value)
>         WREG32_SOC15(MMHUB, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);  }
>
> -void mmhub_v1_0_init(struct amdgpu_device *adev)
> +static void mmhub_v1_0_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
>
> @@ -525,7 +525,7 @@ static void mmhub_v1_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
>                 WREG32_SOC15(MMHUB, 0, mmATC_L2_MISC_CG, data);  }
>
> -int mmhub_v1_0_set_clockgating(struct amdgpu_device *adev,
> +static int mmhub_v1_0_set_clockgating(struct amdgpu_device *adev,
>                                enum amd_clockgating_state state)  {
>         if (amdgpu_sriov_vf(adev))
> @@ -549,7 +549,7 @@ int mmhub_v1_0_set_clockgating(struct amdgpu_device *adev,
>         return 0;
>  }
>
> -void mmhub_v1_0_get_clockgating(struct amdgpu_device *adev, u32
> *flags)
> +static void mmhub_v1_0_get_clockgating(struct amdgpu_device *adev,
> +u32 *flags)
>  {
>         int data, data1;
>
> @@ -781,4 +781,13 @@ const struct amdgpu_mmhub_funcs mmhub_v1_0_funcs = {
>         .ras_late_init = amdgpu_mmhub_ras_late_init,
>         .query_ras_error_count = mmhub_v1_0_query_ras_error_count,
>         .reset_ras_error_count = mmhub_v1_0_reset_ras_error_count,
> +       .get_fb_location = mmhub_v1_0_get_fb_location,
> +       .init = mmhub_v1_0_init,
> +       .gart_enable = mmhub_v1_0_gart_enable,
> +       .set_fault_enable_default = mmhub_v1_0_set_fault_enable_default,
> +       .gart_disable = mmhub_v1_0_gart_disable,
> +       .set_clockgating = mmhub_v1_0_set_clockgating,
> +       .get_clockgating = mmhub_v1_0_get_clockgating,
> +       .setup_vm_pt_regs = mmhub_v1_0_setup_vm_pt_regs,
> +       .update_power_gating = mmhub_v1_0_update_power_gating,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
> index c43319e..d77f5b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
> @@ -25,18 +25,4 @@
>
>  extern const struct amdgpu_mmhub_funcs mmhub_v1_0_funcs;
>
> -u64 mmhub_v1_0_get_fb_location(struct amdgpu_device *adev); -int
> mmhub_v1_0_gart_enable(struct amdgpu_device *adev); -void
> mmhub_v1_0_gart_disable(struct amdgpu_device *adev); -void
> mmhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
> -                                        bool value);
> -void mmhub_v1_0_init(struct amdgpu_device *adev); -int
> mmhub_v1_0_set_clockgating(struct amdgpu_device *adev,
> -                              enum amd_clockgating_state state);
> -void mmhub_v1_0_get_clockgating(struct amdgpu_device *adev, u32
> *flags); -void mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
> -                                bool enable);
> -void mmhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
> -                               uint64_t page_table_base);
> -
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index 8acb3b6..5baf899 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -83,7 +83,7 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
>                 MMVM_L2_PROTECTION_FAULT_STATUS, RW));  }
>
> -void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t
> vmid,
> +static void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev,
> +uint32_t vmid,
>                                 uint64_t page_table_base)  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0]; @@
> -327,7 +327,7 @@ static void mmhub_v2_0_program_invalidation(struct amdgpu_device *adev)
>         }
>  }
>
> -int mmhub_v2_0_gart_enable(struct amdgpu_device *adev)
> +static int mmhub_v2_0_gart_enable(struct amdgpu_device *adev)
>  {
>         /* GART Enable. */
>         mmhub_v2_0_init_gart_aperture_regs(adev);
> @@ -343,7 +343,7 @@ int mmhub_v2_0_gart_enable(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
> +static void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
>         u32 tmp;
> @@ -374,7 +374,7 @@ void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
>   * @adev: amdgpu_device pointer
>   * @value: true redirects VM faults to the default page
>   */
> -void mmhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
> bool value)
> +static void mmhub_v2_0_set_fault_enable_default(struct amdgpu_device
> +*adev, bool value)
>  {
>         u32 tmp;
>
> @@ -422,7 +422,7 @@ static const struct amdgpu_vmhub_funcs mmhub_v2_0_vmhub_funcs = {
>         .get_invalidate_req = mmhub_v2_0_get_invalidate_req,  };
>
> -void mmhub_v2_0_init(struct amdgpu_device *adev)
> +static void mmhub_v2_0_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
>
> @@ -552,7 +552,7 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
>         }
>  }
>
> -int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
> +static int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
>                                enum amd_clockgating_state state)  {
>         if (amdgpu_sriov_vf(adev))
> @@ -576,7 +576,7 @@ int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
>         return 0;
>  }
>
> -void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32
> *flags)
> +static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev,
> +u32 *flags)
>  {
>         int data, data1;
>
> @@ -609,3 +609,14 @@ void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>         if (data & MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK)
>                 *flags |= AMD_CG_SUPPORT_MC_LS;  }
> +
> +const struct amdgpu_mmhub_funcs mmhub_v2_0_funcs = {
> +       .ras_late_init = amdgpu_mmhub_ras_late_init,
> +       .init = mmhub_v2_0_init,
> +       .gart_enable = mmhub_v2_0_gart_enable,
> +       .set_fault_enable_default = mmhub_v2_0_set_fault_enable_default,
> +       .gart_disable = mmhub_v2_0_gart_disable,
> +       .set_clockgating = mmhub_v2_0_set_clockgating,
> +       .get_clockgating = mmhub_v2_0_get_clockgating,
> +       .setup_vm_pt_regs = mmhub_v2_0_setup_vm_pt_regs, };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h
> index 3ea4344..f80f461 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h
> @@ -23,15 +23,6 @@
>  #ifndef __MMHUB_V2_0_H__
>  #define __MMHUB_V2_0_H__
>
> -int mmhub_v2_0_gart_enable(struct amdgpu_device *adev); -void
> mmhub_v2_0_gart_disable(struct amdgpu_device *adev); -void
> mmhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
> -                                        bool value);
> -void mmhub_v2_0_init(struct amdgpu_device *adev); -int
> mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
> -                              enum amd_clockgating_state state);
> -void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32
> *flags); -void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
> -                               uint64_t page_table_base);
> +extern const struct amdgpu_mmhub_funcs mmhub_v2_0_funcs;
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index 9979f54..6c6ad52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -36,7 +36,7 @@
>  #define MMHUB_NUM_INSTANCES                    2
>  #define MMHUB_INSTANCE_REGISTER_OFFSET         0x3000
>
> -u64 mmhub_v9_4_get_fb_location(struct amdgpu_device *adev)
> +static u64 mmhub_v9_4_get_fb_location(struct amdgpu_device *adev)
>  {
>         /* The base should be same b/t 2 mmhubs on Acrturus. Read one here. */
>         u64 base = RREG32_SOC15(MMHUB, 0,
> mmVMSHAREDVC0_MC_VM_FB_LOCATION_BASE);
> @@ -97,7 +97,7 @@ static void mmhub_v9_4_init_gart_aperture_regs(struct amdgpu_device *adev,
>                             (u32)(adev->gmc.gart_end >> 44));  }
>
> -void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t
> vmid,
> +static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev,
> +uint32_t vmid,
>                                 uint64_t page_table_base)  {
>         int i;
> @@ -375,7 +375,7 @@ static void mmhub_v9_4_program_invalidation(struct amdgpu_device *adev,
>         }
>  }
>
> -int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
> +static int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
>  {
>         int i;
>
> @@ -397,7 +397,7 @@ int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -void mmhub_v9_4_gart_disable(struct amdgpu_device *adev)
> +static void mmhub_v9_4_gart_disable(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
>         u32 tmp;
> @@ -442,7 +442,7 @@ void mmhub_v9_4_gart_disable(struct amdgpu_device *adev)
>   * @adev: amdgpu_device pointer
>   * @value: true redirects VM faults to the default page
>   */
> -void mmhub_v9_4_set_fault_enable_default(struct amdgpu_device *adev,
> bool value)
> +static void mmhub_v9_4_set_fault_enable_default(struct amdgpu_device
> +*adev, bool value)
>  {
>         u32 tmp;
>         int i;
> @@ -500,7 +500,7 @@ void mmhub_v9_4_set_fault_enable_default(struct amdgpu_device *adev, bool value)
>         }
>  }
>
> -void mmhub_v9_4_init(struct amdgpu_device *adev)
> +static void mmhub_v9_4_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub[MMHUB_NUM_INSTANCES] =
>                 {&adev->vmhub[AMDGPU_MMHUB_0],
> &adev->vmhub[AMDGPU_MMHUB_1]}; @@ -630,7 +630,7 @@ static void mmhub_v9_4_update_medium_grain_light_sleep(struct amdgpu_device *ade
>         }
>  }
>
> -int mmhub_v9_4_set_clockgating(struct amdgpu_device *adev,
> +static int mmhub_v9_4_set_clockgating(struct amdgpu_device *adev,
>                                enum amd_clockgating_state state)  {
>         if (amdgpu_sriov_vf(adev))
> @@ -650,7 +650,7 @@ int mmhub_v9_4_set_clockgating(struct amdgpu_device *adev,
>         return 0;
>  }
>
> -void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u32
> *flags)
> +static void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev,
> +u32 *flags)
>  {
>         int data, data1;
>
> @@ -1628,4 +1628,12 @@ const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
>         .ras_late_init = amdgpu_mmhub_ras_late_init,
>         .query_ras_error_count = mmhub_v9_4_query_ras_error_count,
>         .reset_ras_error_count = mmhub_v9_4_reset_ras_error_count,
> +       .get_fb_location = mmhub_v9_4_get_fb_location,
> +       .init = mmhub_v9_4_init,
> +       .gart_enable = mmhub_v9_4_gart_enable,
> +       .set_fault_enable_default = mmhub_v9_4_set_fault_enable_default,
> +       .gart_disable = mmhub_v9_4_gart_disable,
> +       .set_clockgating = mmhub_v9_4_set_clockgating,
> +       .get_clockgating = mmhub_v9_4_get_clockgating,
> +       .setup_vm_pt_regs = mmhub_v9_4_setup_vm_pt_regs,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
> index 1b97977..92404a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
> @@ -25,16 +25,4 @@
>
>  extern const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs;
>
> -u64 mmhub_v9_4_get_fb_location(struct amdgpu_device *adev); -int
> mmhub_v9_4_gart_enable(struct amdgpu_device *adev); -void
> mmhub_v9_4_gart_disable(struct amdgpu_device *adev); -void
> mmhub_v9_4_set_fault_enable_default(struct amdgpu_device *adev,
> -                                        bool value);
> -void mmhub_v9_4_init(struct amdgpu_device *adev); -int
> mmhub_v9_4_set_clockgating(struct amdgpu_device *adev,
> -                              enum amd_clockgating_state state);
> -void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u32
> *flags); -void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
> -                               uint64_t page_table_base);
> -
>  #endif
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7COa
> k.Zeng%40amd.com%7C3bb6298f39da48c8232508d83e282df4%7C3dd8961fe4884e60
> 8e11a82d994e183d%7C0%7C0%7C637327689578164149&amp;sdata=swa5nabOEJ7bSf
> 8Z3Hkx6kOI%2BHGLNsPySkUyjoRCKGU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
