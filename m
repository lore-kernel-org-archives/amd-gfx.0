Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F3C2D0DE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 02:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1DC215A4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 02:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wA2ACni0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1DC215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3CD989740;
	Thu,  2 Jan 2020 02:22:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770051.outbound.protection.outlook.com [40.107.77.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABA589740
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 02:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcB4nb3Q8TFmiOaopxvcQZjOWR3NJswSCViPFeSZMJ72BeiSakOPG4envjmDveA1Gt35mFaJ2zJUesmRSfgApsAYktlESvSayPl/e3/DysYDUZeivv/xpud5D2UWh8EQXnDWeGj/3jiF2/VOvBs6NHTxqE0ysZfTUfRfCYlQMH6eyjyV9Axd5SzjG8YtFcYevwxbQ/iXJCCUmP3UQ/rdxqlZ5ORqVkTlCXW9f+ifFb/Wpu02UoQSAOrz/gwyR36Xxv/x+inRvHJ3lP0a8F1cWQANHQQVClEkEeqqD17+HeD3QbdZaSICY17fCZhxFibhy852DUyFGzNAl6sVpNJJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qp3reHyDTAXUf2vod08pYLHZJihhgugwzIS//v9f5Y=;
 b=A/+YlSL8s5bHoPFVXTjITyfbtPaxKwhOKeQNHVT1bYyANPHqZsSiAR6u2R79K5S25AZwyMZRtzA80oHi0miVsxPo0tBhYQg51apr0GdJJPwufBGcTegpZWzDikP5whaSLIJXyI3kN1PZm+VjyfpJGNF4sqPwXVgvZHo3//FMWeexQCkceZNxnK5l4wgVMW9PISuhHjkaeyop9pz0eUo/lFU8v+UfR5YcnnkKVUd0Or9VmMi3MsSM326bTmFc6KogQPHaYP7jn6Y/L15fkt0/Ll52PVWvYr3O7ea9YkQZnHZg8thq6roeMELMxFiVynol+tZ/bpK7EbVATVCpg8pW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qp3reHyDTAXUf2vod08pYLHZJihhgugwzIS//v9f5Y=;
 b=wA2ACni0uraJdIy33nh9v90Yestjcqb/SuqHeI113K59vysFu+W7dcD1X1shRO1wmXQnj5ySa8A+q1+UoMm3k7nZX59db0kAVRD616lQPe+SsDaimel4KFLqh4r3Jh5l9UylcscaRJUPOX/u3yflnbIeExHYxtg+USWJayrt0us=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3136.namprd12.prod.outlook.com (20.178.244.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 2 Jan 2020 02:22:48 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.010; Thu, 2 Jan 2020
 02:22:48 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: unified VRAM address for driver
 table interaction with SMU
Thread-Topic: [PATCH 2/2] drm/amd/powerplay: unified VRAM address for driver
 table interaction with SMU
Thread-Index: AQHVv4ToXaf8NvmfJk66+H1G9pCVEqfV3d4AgADIqFA=
Date: Thu, 2 Jan 2020 02:22:48 +0000
Message-ID: <MN2PR12MB334434BAC4A5335E195855FFE4200@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191231024856.3557-1-evan.quan@amd.com>
 <20191231024856.3557-2-evan.quan@amd.com>
 <CADnq5_MGp7Lj_W0=VMJ-Mz5J=aLTHVhWRdgrYmaW87f-RQmpUQ@mail.gmail.com>
In-Reply-To: <CADnq5_MGp7Lj_W0=VMJ-Mz5J=aLTHVhWRdgrYmaW87f-RQmpUQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=696e923e-7fd8-4610-a3a3-000052f49b75;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-02T02:17:30Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0508f63-3de6-47dd-5612-08d78f2aa926
x-ms-traffictypediagnostic: MN2PR12MB3136:|MN2PR12MB3136:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB313644B68C190686FA45D883E4200@MN2PR12MB3136.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(13464003)(199004)(189003)(5660300002)(4326008)(86362001)(81166006)(478600001)(45080400002)(53546011)(966005)(76116006)(66946007)(9686003)(71200400001)(316002)(6506007)(30864003)(6916009)(54906003)(66476007)(64756008)(52536014)(33656002)(66556008)(2906002)(7696005)(66446008)(19627235002)(186003)(55016002)(8676002)(8936002)(26005)(81156014)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3136;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDMpPl5KA6CZUTJiTrJk0CbVsVH+wFN6EH7CIMcTPdUinvGOsEr2AR7rCSTs6NtBXEIFa6RkH7py4ayfVCXO0FsWDiClVnrECxJIfbPErQAz151PBeS2Ifs2U7S0wlMNBgGsbujSI8zbBZ45uO3i+6iY8JEFhDS6VYjr80pZPEKg9qXKKokzFFDfd3Xqhv3FEAz/v7BGbcFy9vXthjdZDmqN+KYZ1ExG3o+9rLA5I7z6rWFvA4IqepJPJmnNPViYUZpXdeZB84FiXO5f5EOptT9hpi4D+Z/raEwjCj+DTFK8ce4+AMT/0QNR0TIw8JBsqO3cpKHKVV0Qor10OPJ+CXgUezI3J5nhuRhynX7gFjLVkc+ODCYV4wHjekDuB3Z7kFNAD7PRxUS2GweHHmGscgzapVtEEz+yfn5xcCNORijAUMAoqmsYCIY3PtibPILqlnaZBhXDepXxxSacYC0ohqkICqwCJX9epYLcw0KJNJR7A3M1yF8ut2OHjogfZgBVIkDihTal51tdHsdCgtRjJHEIk+chSMmRjtM4MWIcGX0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0508f63-3de6-47dd-5612-08d78f2aa926
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 02:22:48.2716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/YG9vIQyU2WBN/lE/buiMcgL1+sEgJrrJaXNOYySfwQA0JpwRLi+L1+i6He6UDS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3136
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



> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, January 1, 2020 10:19 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 2/2] drm/amd/powerplay: unified VRAM address for driver
> table interaction with SMU
> 
> On Mon, Dec 30, 2019 at 9:49 PM Evan Quan <evan.quan@amd.com> wrote:
> >
> > By this, we can avoid to pass in the VRAM address on every table
> > transferring. That puts extra unnecessary traffics on SMU on
> > some cases(e.g. polling the amdgpu_pm_info sysfs interface).
> >
> > Change-Id: Ifb74d9cd89790b301e88d472b29cdb9b0365b65a
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 98 ++++++++++++-------
> >  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  3 +-
> >  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +
> >  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +
> >  drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +
> >  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  1 +
> >  drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  1 +
> >  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 +
> >  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 18 ++++
> >  drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 26 +++--
> >  drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  1 +
> >  11 files changed, 109 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > index 09e16183a769..290976f5f6c2 100644
> > --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > @@ -490,26 +490,19 @@ int smu_update_table(struct smu_context *smu,
> enum smu_table_id table_index, int
> >  {
> >         struct smu_table_context *smu_table = &smu->smu_table;
> >         struct amdgpu_device *adev = smu->adev;
> > -       struct smu_table *table = NULL;
> > -       int ret = 0;
> > +       struct smu_table *table = &smu_table->driver_table;
> >         int table_id = smu_table_get_index(smu, table_index);
> > +       uint32_t table_size;
> > +       int ret = 0;
> >
> >         if (!table_data || table_id >= SMU_TABLE_COUNT || table_id < 0)
> >                 return -EINVAL;
> >
> > -       table = &smu_table->tables[table_index];
> > +       table_size = smu_table->tables[table_index].size;
> >
> >         if (drv2smu)
> > -               memcpy(table->cpu_addr, table_data, table->size);
> > +               memcpy(table->cpu_addr, table_data, table_size);
> >
> > -       ret = smu_send_smc_msg_with_param(smu,
> SMU_MSG_SetDriverDramAddrHigh,
> > -                                         upper_32_bits(table->mc_address));
> > -       if (ret)
> > -               return ret;
> > -       ret = smu_send_smc_msg_with_param(smu,
> SMU_MSG_SetDriverDramAddrLow,
> > -                                         lower_32_bits(table->mc_address));
> > -       if (ret)
> > -               return ret;
> >         ret = smu_send_smc_msg_with_param(smu, drv2smu ?
> >                                           SMU_MSG_TransferTableDram2Smu :
> >                                           SMU_MSG_TransferTableSmu2Dram,
> > @@ -521,7 +514,7 @@ int smu_update_table(struct smu_context *smu,
> enum smu_table_id table_index, int
> >         adev->nbio.funcs->hdp_flush(adev, NULL);
> >
> >         if (!drv2smu)
> > -               memcpy(table_data, table->cpu_addr, table->size);
> > +               memcpy(table_data, table->cpu_addr, table_size);
> >
> >         return ret;
> >  }
> > @@ -948,32 +941,56 @@ static int smu_init_fb_allocations(struct
> smu_context *smu)
> >         struct amdgpu_device *adev = smu->adev;
> >         struct smu_table_context *smu_table = &smu->smu_table;
> >         struct smu_table *tables = smu_table->tables;
> > +       struct smu_table *driver_table = &(smu_table->driver_table);
> > +       uint32_t max_table_size = 0;
> >         int ret, i;
> >
> > -       for (i = 0; i < SMU_TABLE_COUNT; i++) {
> > -               if (tables[i].size == 0)
> > -                       continue;
> > +       /* VRAM allocation for tool table */
> > +       if (tables[SMU_TABLE_PMSTATUSLOG].size) {
> >                 ret = amdgpu_bo_create_kernel(adev,
> > -                                             tables[i].size,
> > -                                             tables[i].align,
> > -                                             tables[i].domain,
> > -                                             &tables[i].bo,
> > -                                             &tables[i].mc_address,
> > -                                             &tables[i].cpu_addr);
> > -               if (ret)
> > -                       goto failed;
> > +                                             tables[SMU_TABLE_PMSTATUSLOG].size,
> > +                                             tables[SMU_TABLE_PMSTATUSLOG].align,
> > +                                             tables[SMU_TABLE_PMSTATUSLOG].domain,
> > +                                             &tables[SMU_TABLE_PMSTATUSLOG].bo,
> > +
> &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
> > +                                             &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
> > +               if (ret) {
> > +                       pr_err("VRAM allocation for tool table failed!\n");
> > +                       return ret;
> > +               }
> >         }
> >
> > -       return 0;
> > -failed:
> > -       while (--i >= 0) {
> > +       /* VRAM allocation for driver table */
> > +       for (i = 0; i < SMU_TABLE_COUNT; i++) {
> >                 if (tables[i].size == 0)
> >                         continue;
> > -               amdgpu_bo_free_kernel(&tables[i].bo,
> > -                                     &tables[i].mc_address,
> > -                                     &tables[i].cpu_addr);
> >
> > +               if (i == SMU_TABLE_PMSTATUSLOG)
> > +                       continue;
> > +
> > +               if (max_table_size < tables[i].size)
> > +                       max_table_size = tables[i].size;
> > +       }
> 
> It would probably be good to document somewhere that the table bo
> allocation is just a staging buffer for uploading and downloading
> tables from the SMU.  The SMU actually stores the active tables in
> SRAM.  That confused me at first when reviewing this patch.
> 
> > +
> > +       driver_table->size = max_table_size;
> > +       driver_table->align = PAGE_SIZE;
> > +       driver_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
> > +
> > +       ret = amdgpu_bo_create_kernel(adev,
> > +                                     driver_table->size,
> > +                                     driver_table->align,
> > +                                     driver_table->domain,
> > +                                     &driver_table->bo,
> > +                                     &driver_table->mc_address,
> > +                                     &driver_table->cpu_addr);
> > +       if (ret) {
> > +               pr_err("VRAM allocation for driver table failed!\n");
> > +               if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
> > +
> amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
> > +
> &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
> > +                                             &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
> >         }
> > +
> >         return ret;
> >  }
> >
> > @@ -981,18 +998,19 @@ static int smu_fini_fb_allocations(struct
> smu_context *smu)
> >  {
> >         struct smu_table_context *smu_table = &smu->smu_table;
> >         struct smu_table *tables = smu_table->tables;
> > -       uint32_t i = 0;
> > +       struct smu_table *driver_table = &(smu_table->driver_table);
> >
> >         if (!tables)
> >                 return 0;
> >
> > -       for (i = 0; i < SMU_TABLE_COUNT; i++) {
> > -               if (tables[i].size == 0)
> > -                       continue;
> > -               amdgpu_bo_free_kernel(&tables[i].bo,
> > -                                     &tables[i].mc_address,
> > -                                     &tables[i].cpu_addr);
> > -       }
> > +       if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
> > +               amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
> > +                                     &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
> > +                                     &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
> > +
> > +       amdgpu_bo_free_kernel(&driver_table->bo,
> > +                             &driver_table->mc_address,
> > +                             &driver_table->cpu_addr);
> >
> >         return 0;
> >  }
> > @@ -1063,6 +1081,10 @@ static int smu_smc_table_hw_init(struct
> smu_context *smu,
> >
> >         /* smu_dump_pptable(smu); */
> >
> > +       ret = smu_set_driver_table_location(smu);
> > +       if (ret)
> > +               return ret;
> > +
> >         /*
> >          * Copy pptable bo in the vram to smc with SMU MSGs such as
> >          * SetDriverDramAddr and TransferTableDram2Smu.
> > diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > index 50b317f4b1e6..064b5201a8a7 100644
> > --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > @@ -2022,7 +2022,7 @@ static int arcturus_i2c_eeprom_read_data(struct
> i2c_adapter *control,
> >         SwI2cRequest_t req;
> >         struct amdgpu_device *adev = to_amdgpu_device(control);
> >         struct smu_table_context *smu_table = &adev->smu.smu_table;
> > -       struct smu_table *table = &smu_table-
> >tables[SMU_TABLE_I2C_COMMANDS];
> > +       struct smu_table *table = &smu_table->driver_table;
> >
> >         memset(&req, 0, sizeof(req));
> >         arcturus_fill_eeprom_i2c_req(&req, false, address, numbytes, data);
> > @@ -2261,6 +2261,7 @@ static const struct pptable_funcs
> arcturus_ppt_funcs = {
> >         .check_fw_version = smu_v11_0_check_fw_version,
> >         .write_pptable = smu_v11_0_write_pptable,
> >         .set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
> > +       .set_driver_table_location = smu_v11_0_set_driver_table_location,
> >         .set_tool_table_location = smu_v11_0_set_tool_table_location,
> >         .notify_memory_pool_location =
> smu_v11_0_notify_memory_pool_location,
> >         .system_features_control = smu_v11_0_system_features_control,
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> > index 30da8328d1bc..121bf81eced5 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> > @@ -260,6 +260,7 @@ struct smu_table_context
> >         struct smu_bios_boot_up_values  boot_values;
> >         void                            *driver_pptable;
> >         struct smu_table                *tables;
> > +       struct smu_table                driver_table;
> 
> This would be a good place to document that the driver table is just a
> staging buffer for uploading/downloading content from the SMU.  Can
> you check that we properly lock the staging buffer in all the call
> paths that interact with SMU?  If we do that, I think we can clean up
> and simplify a lot of the other locking we have already.
[Quan, Evan] Will document that in V2. This table is used for transfer
Pptable/watermarktable/metrics table/activity monitor table from SMU.
And as I confirmed, all of them already have proper lock protection on their call path.
So, there is no need to add new lock protection around this.
> 
> >         struct smu_table                memory_pool;
> >         uint8_t                         thermal_controller_type;
> >
> > @@ -498,6 +499,7 @@ struct pptable_funcs {
> >         int (*set_gfx_cgpg)(struct smu_context *smu, bool enable);
> >         int (*write_pptable)(struct smu_context *smu);
> >         int (*set_min_dcef_deep_sleep)(struct smu_context *smu);
> > +       int (*set_driver_table_location)(struct smu_context *smu);
> >         int (*set_tool_table_location)(struct smu_context *smu);
> >         int (*notify_memory_pool_location)(struct smu_context *smu);
> >         int (*set_last_dcef_min_deep_sleep_clk)(struct smu_context *smu);
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> > index db3f78676aeb..662989296174 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> > @@ -170,6 +170,8 @@ int smu_v11_0_write_pptable(struct smu_context
> *smu);
> >
> >  int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu);
> >
> > +int smu_v11_0_set_driver_table_location(struct smu_context *smu);
> > +
> >  int smu_v11_0_set_tool_table_location(struct smu_context *smu);
> >
> >  int smu_v11_0_notify_memory_pool_location(struct smu_context *smu);
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> > index 3f1cd06e273c..d79e54b5ebf6 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> > @@ -90,4 +90,6 @@ int smu_v12_0_mode2_reset(struct smu_context *smu);
> >  int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum
> smu_clk_type clk_type,
> >                             uint32_t min, uint32_t max);
> >
> > +int smu_v12_0_set_driver_table_location(struct smu_context *smu);
> > +
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > index 3387f3243a01..aa206bde619b 100644
> > --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > @@ -2120,6 +2120,7 @@ static const struct pptable_funcs navi10_ppt_funcs
> = {
> >         .check_fw_version = smu_v11_0_check_fw_version,
> >         .write_pptable = smu_v11_0_write_pptable,
> >         .set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
> > +       .set_driver_table_location = smu_v11_0_set_driver_table_location,
> >         .set_tool_table_location = smu_v11_0_set_tool_table_location,
> >         .notify_memory_pool_location =
> smu_v11_0_notify_memory_pool_location,
> >         .system_features_control = smu_v11_0_system_features_control,
> > diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> > index 506cc6bf4bc0..861e6410363b 100644
> > --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> > @@ -920,6 +920,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
> >         .get_dpm_ultimate_freq = smu_v12_0_get_dpm_ultimate_freq,
> >         .mode2_reset = smu_v12_0_mode2_reset,
> >         .set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
> > +       .set_driver_table_location = smu_v12_0_set_driver_table_location,
> >  };
> >
> >  void renoir_set_ppt_funcs(struct smu_context *smu)
> > diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> > index 77864e4236c4..783319ec8bf9 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> > +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> > @@ -61,6 +61,8 @@
> >         ((smu)->ppt_funcs->write_pptable ? (smu)->ppt_funcs-
> >write_pptable((smu)) : 0)
> >  #define smu_set_min_dcef_deep_sleep(smu) \
> >         ((smu)->ppt_funcs->set_min_dcef_deep_sleep ? (smu)->ppt_funcs-
> >set_min_dcef_deep_sleep((smu)) : 0)
> > +#define smu_set_driver_table_location(smu) \
> > +       ((smu)->ppt_funcs->set_driver_table_location ? (smu)->ppt_funcs-
> >set_driver_table_location((smu)) : 0)
> >  #define smu_set_tool_table_location(smu) \
> >         ((smu)->ppt_funcs->set_tool_table_location ? (smu)->ppt_funcs-
> >set_tool_table_location((smu)) : 0)
> >  #define smu_notify_memory_pool_location(smu) \
> > diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> > index 6fb93eb6ab39..e804f9854027 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> > @@ -776,6 +776,24 @@ int smu_v11_0_set_min_dcef_deep_sleep(struct
> smu_context *smu)
> >         return smu_v11_0_set_deep_sleep_dcefclk(smu, table_context-
> >boot_values.dcefclk / 100);
> >  }
> >
> > +int smu_v11_0_set_driver_table_location(struct smu_context *smu)
> > +{
> > +       struct smu_table *driver_table = &smu->smu_table.driver_table;
> > +       int ret = 0;
> > +
> > +       if (driver_table->mc_address) {
> > +               ret = smu_send_smc_msg_with_param(smu,
> > +                               SMU_MSG_SetDriverDramAddrHigh,
> > +                               upper_32_bits(driver_table->mc_address));
> > +               if (!ret)
> > +                       ret = smu_send_smc_msg_with_param(smu,
> > +                               SMU_MSG_SetDriverDramAddrLow,
> > +                               lower_32_bits(driver_table->mc_address));
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  int smu_v11_0_set_tool_table_location(struct smu_context *smu)
> >  {
> >         int ret = 0;
> > diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> > index 2ac7f2f231b6..2b1ef9eb0db6 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> > @@ -318,14 +318,6 @@ int smu_v12_0_fini_smc_tables(struct smu_context
> *smu)
> >  int smu_v12_0_populate_smc_tables(struct smu_context *smu)
> >  {
> >         struct smu_table_context *smu_table = &smu->smu_table;
> > -       struct smu_table *table = NULL;
> > -
> > -       table = &smu_table->tables[SMU_TABLE_DPMCLOCKS];
> > -       if (!table)
> > -               return -EINVAL;
> > -
> > -       if (!table->cpu_addr)
> > -               return -EINVAL;
> >
> >         return smu_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table-
> >clocks_table, false);
> >  }
> > @@ -514,3 +506,21 @@ int smu_v12_0_set_soft_freq_limited_range(struct
> smu_context *smu, enum smu_clk_
> >
> >         return ret;
> >  }
> > +
> > +int smu_v12_0_set_driver_table_location(struct smu_context *smu)
> > +{
> > +       struct smu_table *driver_table = &smu->smu_table.driver_table;
> > +       int ret = 0;
> > +
> > +       if (driver_table->mc_address) {
> > +               ret = smu_send_smc_msg_with_param(smu,
> > +                               SMU_MSG_SetDriverDramAddrHigh,
> > +                               upper_32_bits(driver_table->mc_address));
> > +               if (!ret)
> > +                       ret = smu_send_smc_msg_with_param(smu,
> > +                               SMU_MSG_SetDriverDramAddrLow,
> > +                               lower_32_bits(driver_table->mc_address));
> > +       }
> > +
> > +       return ret;
> > +}
> > diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > index 27bdcdeb08d9..38febd5ca4da 100644
> > --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > @@ -3236,6 +3236,7 @@ static const struct pptable_funcs vega20_ppt_funcs
> = {
> >         .check_fw_version = smu_v11_0_check_fw_version,
> >         .write_pptable = smu_v11_0_write_pptable,
> >         .set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
> > +       .set_driver_table_location = smu_v11_0_set_driver_table_location,
> >         .set_tool_table_location = smu_v11_0_set_tool_table_location,
> >         .notify_memory_pool_location =
> smu_v11_0_notify_memory_pool_location,
> >         .system_features_control = smu_v11_0_system_features_control,
> > --
> > 2.24.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C34dab91ed73e4a29eb
> c908d78ec59e4b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> 134851738870652&amp;sdata=6cuhBgRmvJbiCa1ESdszyxb%2BAsuJwC%2FPO3
> Ccm%2B5fE%2Bg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
