Return-Path: <SRS0=SXnv=2V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B49C2D0C3
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2019 02:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C3B206CB
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2019 02:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GwlUPwJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C3B206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CC689FCA;
	Tue, 31 Dec 2019 02:58:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F6FE89FCA
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Dec 2019 02:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIqfaUtnvd8mzkcDYFVd2WVXYzCpgAFFw00o8NaDbEfxYdhZmRT0j+Mij9YLSIEg/VWSgCMdRBdpSAw6oPNgKkHiXBpcn9YwwxgzrG6JCaXOJ6WXbSm+TBB04NHWMVdumkV4w2VSRJHYYDqe0zv4v8eidbRicO4Y7Je7oGeAZKGJrH+Jr6wvnL57Sv2dr1blgPAUJCg6z96NTKOXbkHFwpbbZ7TzQ5T4T8BuZOe9XM+NpbX3CgmXd922rpcqRUYhgdp6+LblC0DcGHOOee5BJF1vArkzSJTE/1TCrh6YFX3kdybmD4WR/MoNFYxzmZrak+QvQWOBskx8+Ra7QgXCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMMBjlAjnVe4FArH7JFTUQoZcqHj0xR77BZdN4nSZTs=;
 b=k3KzvN3iY59Eg263h/wKSOTu3eYc9KDzq7aFw3upomksCJFjqAC3ESmWXLtqcPHbTenQHT3jtrCX+QDHrvzhzx3cWkkmi/8rJqLrzsLc2a4zfqmg1CV/kT44F+KmXpPvnczlcCIuuYTahLrgi8m4mqjQohu5ajBMTux7i2cjls/qhmrrkJP+pSd6SwCh7eFp0BSALqiLI56BaBabEWoUA6EKh5+znE3vAmSMkWOl78xPKW8J8AjY/czFBLmbZBtr1CHCpF3fD8eMa8EtLXwjJzoML0IDQ3jyjWKPg605Vp7MERSkogYhP8FMeZi+xCdVK7OT7TQaXwX++in2qYA7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMMBjlAjnVe4FArH7JFTUQoZcqHj0xR77BZdN4nSZTs=;
 b=GwlUPwJ3RTvoiuqDyNuphoEypffZwZB60N32dhMvFCOgg6miB4YuJuXbj0NgYettdPynlOPIbSqj8DSCA1eF4uoYkfWYkjtxha5QFLllO/GgItEUmygMPLupl7LnEa3sGwStQ+cckDwGTLaziSaxNaIhPZqRnhG0dZYi4IDJc0M=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Tue, 31 Dec 2019 02:58:20 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Tue, 31 Dec 2019
 02:58:20 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: allocate one piece of VRAM for all
 tables transferring
Thread-Topic: [PATCH 2/2] drm/amd/powerplay: allocate one piece of VRAM for
 all tables transferring
Thread-Index: AQHVvv7krqpSrw+EaEOKRrabGM3i1KfSy8UAgADCO2A=
Date: Tue, 31 Dec 2019 02:58:20 +0000
Message-ID: <MN2PR12MB3344DDC44BC4EF4D1286149EE4260@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191230104931.28260-1-evan.quan@amd.com>
 <20191230104931.28260-2-evan.quan@amd.com>
 <CADnq5_McMMHEShBoKoe+msb0Nj0rdCaeX5F3EO7iUXEomJ2m1A@mail.gmail.com>
In-Reply-To: <CADnq5_McMMHEShBoKoe+msb0Nj0rdCaeX5F3EO7iUXEomJ2m1A@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c64fde5a-ffce-4cba-b09a-0000c23e378d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-31T02:57:11Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31ab7cb4-9804-43d7-3429-08d78d9d4b1e
x-ms-traffictypediagnostic: MN2PR12MB3455:
x-microsoft-antispam-prvs: <MN2PR12MB345580516327238B05C6BB8FE4260@MN2PR12MB3455.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(13464003)(199004)(189003)(4326008)(8676002)(76116006)(478600001)(9686003)(52536014)(55016002)(8936002)(81166006)(5660300002)(81156014)(6916009)(316002)(45080400002)(33656002)(186003)(66946007)(66446008)(66556008)(6506007)(53546011)(71200400001)(30864003)(86362001)(64756008)(966005)(66476007)(26005)(2906002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3455;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJnpvBiU7mE3uJgos/ZebZuoflrBFp/3MUkNClNq1DxhwYLaoP/IMRIM5uPXf9/YrnpMI5Ede6pPVkX8Ip1Btp+qiTsl7QrS44NJUAYaUtZpGZjZ9yzL4Ut+2PlpD1/xAwkbkvUuFleruyP/LKyJPJrhXiHsAIB3FXhyDYJcEfWanJz7hMO6Ky69jh14du6fRlSy34fYVDwHIyEW1h8mzj4+7BIGVMfHpN1F7yPt/3IgcNgk3nD9HU1cCAiKfYKT5jPUxXGsd07+pkkjOrqKrA9LvdqVlr8aAJhUwi+a2skBgMTvjv5cMcBnG1VKtRtiDGqynqmFi/IFcrYCZdmqOC4Deur5R6gP6BIoeu5W8C4PIlm+BPdaL93cTouIcKHsVetNiWB7lcYOp3LEBYaibM+v2uTnavpicbw6X9ePnW9Pcuo0mN90SsSNPSRKlglT/K8Yh8Ahhu2NJRbYXZhXppQkZRETm5c/PN2Sdun1hJjAH0ezUNQ5+RqgE7yPVH3k1L7IKauPYTUfn9FMzJ6uWTTU0DT/Cf0tjJL77pU+7QJfaZMLROFpmab7aKvP50X7M52tt/shdIDuhkEQkkkoork3dRJLFw2x0Fzzn+CDZNo=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ab7cb4-9804-43d7-3429-08d78d9d4b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 02:58:20.4387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpDzy6GxBIgqw3eFq5laEmR9fJliliYub3HIBv1oA69GY/BONB9RlmI6DwNBNKcg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3455
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

Hi Alex,

Please check the new patch sets.
https://lists.freedesktop.org/archives/amd-gfx/2019-December/044352.html
https://lists.freedesktop.org/archives/amd-gfx/2019-December/044353.html

Regards,
Evan
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Monday, December 30, 2019 11:22 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 2/2] drm/amd/powerplay: allocate one piece of VRAM for
> all tables transferring
> 
> On Mon, Dec 30, 2019 at 5:50 AM Evan Quan <evan.quan@amd.com> wrote:
> >
> > Simplify the table transferring between driver and SMU and use less
> > VRAM.
> >
> > Change-Id: I3f9b54fd9b8c0bcaeb533fc1a07bb06050fefbd8
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 101 ++++++++++--------
> >  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |   2 +-
> >  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   3 +-
> >  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |   4 +
> >  drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |   4 +
> >  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |   4 +-
> >  drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |  10 +-
> >  drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |   4 +
> >  8 files changed, 73 insertions(+), 59 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > index c3cb1b8f43b5..bd3dbd1a0ad3 100644
> > --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > @@ -490,7 +490,7 @@ int smu_update_table(struct smu_context *smu,
> enum
> > smu_table_id table_index, int  {
> >         struct smu_table_context *smu_table = &smu->smu_table;
> >         struct amdgpu_device *adev = smu->adev;
> > -       struct smu_table *table = smu_table->driver_table;
> > +       struct smu_table *table = &smu_table->driver_table;
> >         int table_id = smu_table_get_index(smu, table_index);
> >         uint32_t table_size;
> >         int ret = 0;
> > @@ -941,24 +941,26 @@ static int smu_init_fb_allocations(struct
> smu_context *smu)
> >         struct amdgpu_device *adev = smu->adev;
> >         struct smu_table_context *smu_table = &smu->smu_table;
> >         struct smu_table *tables = smu_table->tables;
> > -       struct smu_table **driver_table = &(smu_table->driver_table);
> > +       struct smu_table *driver_table = &(smu_table->driver_table);
> >         uint32_t max_table_size = 0;
> > -       int ret, i, index = 0;
> > +       int ret, i;
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
> > +       /* VRAM allocation for driver table */
> >         for (i = 0; i < SMU_TABLE_COUNT; i++) {
> >                 if (tables[i].size == 0)
> >                         continue;
> > @@ -966,24 +968,29 @@ static int smu_init_fb_allocations(struct
> smu_context *smu)
> >                 if (i == SMU_TABLE_PMSTATUSLOG)
> >                         continue;
> >
> > -               if (max_table_size < tables[i].size) {
> > +               if (max_table_size < tables[i].size)
> >                         max_table_size = tables[i].size;
> > -                       index = i;
> > -               }
> >         }
> >
> > -       *driver_table = &tables[index];
> > -
> > -       return 0;
> > -failed:
> > -       while (--i >= 0) {
> > -               if (tables[i].size == 0)
> > -                       continue;
> > -               amdgpu_bo_free_kernel(&tables[i].bo,
> > -                                     &tables[i].mc_address,
> > -                                     &tables[i].cpu_addr);
> > -
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
> > +
> > + &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
> >         }
> > +
> >         return ret;
> 
> Shouldn't this change be merged into the previous patch?  Otherwise, we'll
> break I think.
> 
> >  }
> >
> > @@ -991,18 +998,19 @@ static int smu_fini_fb_allocations(struct
> > smu_context *smu)  {
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
> > +
> > + &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
> > +
> > +       amdgpu_bo_free_kernel(&driver_table->bo,
> > +                             &driver_table->mc_address,
> > +                             &driver_table->cpu_addr);
> >
> >         return 0;
> >  }
> > @@ -1913,26 +1921,25 @@ int smu_set_df_cstate(struct smu_context *smu,
> >
> >  int smu_write_watermarks_table(struct smu_context *smu)  {
> > -       int ret = 0;
> > -       struct smu_table_context *smu_table = &smu->smu_table;
> > -       struct smu_table *table = NULL;
> > +       void *watermarks_table = smu->smu_table.watermarks_table;
> >
> > -       table = &smu_table->tables[SMU_TABLE_WATERMARKS];
> > -
> > -       if (!table->cpu_addr)
> > +       if (!watermarks_table)
> >                 return -EINVAL;
> >
> > -       ret = smu_update_table(smu, SMU_TABLE_WATERMARKS, 0, table-
> >cpu_addr,
> > +       return smu_update_table(smu,
> > +                               SMU_TABLE_WATERMARKS,
> > +                               0,
> > +                               watermarks_table,
> >                                 true);
> > -
> > -       return ret;
> >  }
> >
> >  int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
> >                 struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
> >  {
> > -       struct smu_table *watermarks = &smu-
> >smu_table.tables[SMU_TABLE_WATERMARKS];
> > -       void *table = watermarks->cpu_addr;
> > +       void *table = smu->smu_table.watermarks_table;
> > +
> > +       if (!table)
> > +               return -EINVAL;
> >
> >         mutex_lock(&smu->mutex);
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > index e89965e5fdcb..064b5201a8a7 100644
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
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> > index ed193adc881c..121bf81eced5 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> > @@ -254,12 +254,13 @@ struct smu_table_context
> >         unsigned long                   metrics_time;
> >         void                            *metrics_table;
> >         void                            *clocks_table;
> > +       void                            *watermarks_table;
> 
> Can you split out the watermarks change as a separate patch or at
> least explain why you are changing how it's handled?
> 
> Alex
> 
> >
> >         void                            *max_sustainable_clocks;
> >         struct smu_bios_boot_up_values  boot_values;
> >         void                            *driver_pptable;
> >         struct smu_table                *tables;
> > -       struct smu_table                *driver_table;
> > +       struct smu_table                driver_table;
> >         struct smu_table                memory_pool;
> >         uint8_t                         thermal_controller_type;
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > index ed147dd51325..aa206bde619b 100644
> > --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > @@ -555,6 +555,10 @@ static int navi10_tables_init(struct smu_context
> *smu, struct smu_table *tables)
> >                 return -ENOMEM;
> >         smu_table->metrics_time = 0;
> >
> > +       smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t),
> GFP_KERNEL);
> > +       if (!smu_table->watermarks_table)
> > +               return -ENOMEM;
> > +
> >         return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> > index c4b5984c86d9..861e6410363b 100644
> > --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> > @@ -209,6 +209,10 @@ static int renoir_tables_init(struct smu_context
> *smu, struct smu_table *tables)
> >                 return -ENOMEM;
> >         smu_table->metrics_time = 0;
> >
> > +       smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t),
> GFP_KERNEL);
> > +       if (!smu_table->watermarks_table)
> > +               return -ENOMEM;
> > +
> >         return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> > index 79a63edcd7ba..962e97860fe8 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> > @@ -450,8 +450,10 @@ int smu_v11_0_fini_smc_tables(struct smu_context
> *smu)
> >
> >         kfree(smu_table->tables);
> >         kfree(smu_table->metrics_table);
> > +       kfree(smu_table->watermarks_table);
> >         smu_table->tables = NULL;
> >         smu_table->metrics_table = NULL;
> > +       smu_table->watermarks_table = NULL;
> >         smu_table->metrics_time = 0;
> >
> >         ret = smu_v11_0_fini_dpm_context(smu);
> > @@ -776,7 +778,7 @@ int smu_v11_0_set_min_dcef_deep_sleep(struct
> smu_context *smu)
> >
> >  int smu_v11_0_set_driver_table_location(struct smu_context *smu)
> >  {
> > -       struct smu_table *driver_table = smu->smu_table.driver_table;
> > +       struct smu_table *driver_table = &smu->smu_table.driver_table;
> >         int ret = 0;
> >
> >         if (driver_table->mc_address) {
> > diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> > index cd2be9fb2513..2b1ef9eb0db6 100644
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
> > @@ -517,7 +509,7 @@ int smu_v12_0_set_soft_freq_limited_range(struct
> smu_context *smu, enum smu_clk_
> >
> >  int smu_v12_0_set_driver_table_location(struct smu_context *smu)
> >  {
> > -       struct smu_table *driver_table = smu->smu_table.driver_table;
> > +       struct smu_table *driver_table = &smu->smu_table.driver_table;
> >         int ret = 0;
> >
> >         if (driver_table->mc_address) {
> > diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > index 12f97956058b..38febd5ca4da 100644
> > --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > @@ -338,6 +338,10 @@ static int vega20_tables_init(struct smu_context
> *smu, struct smu_table *tables)
> >                 return -ENOMEM;
> >         smu_table->metrics_time = 0;
> >
> > +       smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t),
> GFP_KERNEL);
> > +       if (!smu_table->watermarks_table)
> > +               return -ENOMEM;
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.24.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cdd3a4f9d66ba4e7085
> ba08d78d3c0c38%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> 133161355995859&amp;sdata=KYYcYqB%2Bd3vWoIHVYVSed8bXtqrfg1dWrlFT0
> QMFhRs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
