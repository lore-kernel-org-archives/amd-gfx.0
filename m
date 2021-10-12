Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15639C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 15:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DB06103D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 15:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6DB06103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4597489CD3;
	Tue, 12 Oct 2021 15:35:49 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372D089CD3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 15:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvVgwhvYaSatrhP02fk1mJJ4XsPj8ikl4fwJhBXsDo2OWixPH49Cg3Xq4bHw5DGzJ5QYwKGRnmO2i+nmb172PuDuiFm90m0Gh0yaH9cFUZONSV89SYrM7pR7liikeDbZwvdPdfmgM1Krvcq064rlhUBNEzWaulAf66LHtzLiIXVS5pAEXksayPcFq10EIQAjVFiKkmWcawI3jjwHiTvcUb6TiPuOYbWBrQSEWA7OUbVf3YIjG1qdg8cpRSQCyLl77Kx9MvAeoB98vEnS/DOu4u8D7Je4lmk8jPg5HeRv1NsAieuw0O35eZFBwOXQ+1vmbKN+PzSwQDEx0gsJJan6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF5RlifMMMoZoeDYU4GAfCA1x5LejzYXqy9cnEikYbU=;
 b=EZ+kXj8fkwemnbgS9aw/aCgNaMf8pCKUkRve6FMT797j0Kb9MtUdyQJvj+I/LwUbSftEAkCNg7uozjFoIheyhgTokct8oyGjaC+Q4qI/c8AO2zWJw6rcToeEm8cM1cv4xDdZ+rajoXVGL6HWSYul/Wn6ixtwgkdqcNb9hAE+KBxNhKNLim2C3Q1jnDVtzxg/4n2es7TED/AvOvH4ZvNq2TTk2GDHEk3RY8h/MrPgGYvReD3W6aAvi9eQ5CEz0iHzAEIJ/z4a6dqRD+XsANhUSP1D2dbwujH3Y95bIoQPVsJNM2HbmpHqFLBqfbJ2bEvC4SdhXJYWcFoGzgyy6aP9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF5RlifMMMoZoeDYU4GAfCA1x5LejzYXqy9cnEikYbU=;
 b=UBjtvKuAp8QAnnwI4gLa6KmxM6rsuU4eJvBnMmOqOkXVfPoGeKdnLEXM6L2CedzfmXgkRKLTH61mqadrSxYvhtor2j8HSFwBM1dbDZpxVwzZQVExz5SJuvgZkMsYQHC2TyIl16NH+UAR6fRVKxcpDPyeLLSZiW1ytc/Z/fCZ8ZI=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 15:35:46 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f%7]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 15:35:46 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Fix RAS page retirement with mode2 reset
 on Aldebaran
Thread-Topic: [PATCH 2/2] drm/amdgpu: Fix RAS page retirement with mode2 reset
 on Aldebaran
Thread-Index: AQHXvxGdd6ETGcvR80CCYCnuCIktb6vOu8sAgADDXiA=
Date: Tue, 12 Oct 2021 15:35:46 +0000
Message-ID: <DM4PR12MB5263CF8C314A5B7092F6AF71EEB69@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20211012023343.23935-1-mukul.joshi@amd.com>
 <20211012023343.23935-2-mukul.joshi@amd.com>
 <DM6PR12MB465071A7F950599FA16CDA6EB0B69@DM6PR12MB4650.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB465071A7F950599FA16CDA6EB0B69@DM6PR12MB4650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-12T15:35:44Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02a6c8c0-601a-4192-d699-08d98d95f5d0
x-ms-traffictypediagnostic: DM4PR12MB5327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5327CEDA81055A6F4B19A519EEB69@DM4PR12MB5327.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jV9LADZSAD2PeoxGAFfmLEtylwRe26nfmoR1vt0SEDE+ZOKC2DPZ0mhBHqtmodz5vIbTkMrYE+30RApx+g+thuteZNHtleS87EbSTVuT0QpB3/6iQ7zfET/HCa/x73M63qJu230FfFYu5+zPi3Pw2QyjEORO3+w+0uVhNLtJp7S7r5e3ic+7+6DPglJhIJXeHONJsqF6JxwoG925KbWP8S3yfYvh1U4UR2BT0cn0Byyk7gPP+Rj8Xf8YNLGa6Jqb2gYgcP3YOe1c0chHQPqLZR2p3k+xI4F2lMfac390GKj81jOuBV0IdE+H1onJ/uE9GtdNaGWz/eEHG6OPndD91h5V8ZdTNhef7JI839gKPfZ4Z5uvbQMhViIDlpyGHPhn7o4SDAt1UqLqcQuZ1kiKgBYXK+qSMFXh5Rppqb9OzWXVixKgDcwv5DBm+kFS/EXvOJjXREFfABAKrMOZOXBeQa3wEbuUrpRyqIyEznOFL6NtocCZ4JDXOlc3BuNTQxCI3AyHeSAMCjFSOqOeJiw4WnzEAWUrYrVtQnuHcjK9R3R/O2pLGgmq2CHuBu5vEh0XdDTpH6P3Z18RkLppG32ud9UqMwq+GimfeDmIoZ87FR75i/a7HHyWow8q9qBCAYv7rohE48g3BBHrfI1Jq24EHyOsFL2llv7KsVpeEPr9Q9ROsmTKXK0r+gpUYBp+5qWLzYmIj0rsRcMK8MWFO7foog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5263.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(71200400001)(316002)(26005)(83380400001)(52536014)(66946007)(186003)(66446008)(66556008)(64756008)(66476007)(76116006)(110136005)(86362001)(2906002)(8936002)(7696005)(38100700002)(38070700005)(122000001)(9686003)(53546011)(6506007)(33656002)(5660300002)(55016002)(508600001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tvmxYJoNBhfbNhxfrGt5Qor6xlS7vaxV3nFDToahQVOp3LthdxywywvL71Qf?=
 =?us-ascii?Q?kvoDzWGSyZQgZe10TWLvXKHGjmnZ/zHzkxXL7w/nkUbbExbkFnuNZHieaq3O?=
 =?us-ascii?Q?Y3aPvMCY4Ffhwsersb2AvvV6zDCHVWyn+56MyIQzmc6xijXr5ikvel8J3Opb?=
 =?us-ascii?Q?LNa3HyNcJFBVsZyYL/BaZEJVziDsOsguFv2DiMSw5OZavb3QfRE3kthSmFBm?=
 =?us-ascii?Q?O4Axb5PbuujRdmUz0r7KRpxPdIu6Rcl/nPQ/jRBMQNvI6KZH7nkh5+9Lq1Sd?=
 =?us-ascii?Q?fKh4iFeP/l8rPetp1NY+jgZRiCa7avICTIoQQsFFFLdl3QmsV5Dh7UiyNMLE?=
 =?us-ascii?Q?xu08mx36TKlTWalVFu7IJoLTl01gP/nRP1lQRAVGbr8y5DGYpyKhDGgI1CIk?=
 =?us-ascii?Q?XqfweeOTzE1xfUCdBxN8xnOJmYFSJYI4AVgwjbGN7ylMfhRrqNBWQQMOXh8M?=
 =?us-ascii?Q?IQHKK4IRvy71GNLVTqYZlVkn5vQweMnzkNMeoWjpwFfOAgaZEXh++qdaWXuP?=
 =?us-ascii?Q?SEWT/MBfT19jpYDci0WucOnShL1rQ8ZsxAvQkc5owIVr+/Z6SGHwXIV/YeKG?=
 =?us-ascii?Q?+nXNl6pD+zWO5aWHjPDj+Tlc1U1NjRXke8dw6Nr1s7z6vlco0QYQUn++8Wrb?=
 =?us-ascii?Q?I9bMOP5wxw5KISToY2bCj4wGvU1V43AALbyiS5in8PNIhTn2LmPOLrjte4PF?=
 =?us-ascii?Q?81e4HS/kkHiRZ2T3BYsacu+esD2klgnCML4t4abonD/hler7vbdWyeZD8UNC?=
 =?us-ascii?Q?w432kM0GRERTLIuuiVl1H8cBUYhhQ2u22L99X673ih3bbiHi9MVrepplyyfh?=
 =?us-ascii?Q?3j2T2SzjFXMxC7CSlxjRvUNIZLj0+MCsGfaFRLtHZn0kgMQIyeu+wh2jcff7?=
 =?us-ascii?Q?GiV6F+sj8LMCJxpzdBm9vKUmKaTP6+O6KYManG+p91upVPZRsayEJvGHjhFM?=
 =?us-ascii?Q?5evFOA0wHAQMvF2iWnPebmapF1MkEFo/MGy1h+LY8VSOA5UBmykGnORW7tnY?=
 =?us-ascii?Q?j1JskdkUkojBo3KhrUzehwm56NnMZlx9zTaDGnlW6q4puALX4zAe379+p9VF?=
 =?us-ascii?Q?/SUIxJ8RGtKaYjryWGhjBp2u7Y8FZtmvrnUkOHMLSMwBNi0XA15y8k92oM6X?=
 =?us-ascii?Q?p/6+v3Z96GeFnESw0k7bo+vz623230jN+ak+u2gVE6w6Daosqdf9A8LbGNZ0?=
 =?us-ascii?Q?X8xdQpkesvk6mShe6LDyql1LdxlkcT1ZPOzyNQlOQH0wAIXiHjBALCqEfsJH?=
 =?us-ascii?Q?EzxwqCj+d8gQ7uF/LCTnLM8biq8hFGbDNOx0eC4Jg2E52I8bpLflWwks4U2O?=
 =?us-ascii?Q?5H5+dgTJm7zIIgR2mJhaCR3S?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5263CF8C314A5B7092F6AF71EEB69DM4PR12MB5263namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a6c8c0-601a-4192-d699-08d98d95f5d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 15:35:46.1780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YeqbedAu0gnKWosDXZdtltz4noa8d4cHCHJxAfvu98KgIKRPCretChbaQMbknLLAB6i5KEAQB1d9FRN1wndPvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5263CF8C314A5B7092F6AF71EEB69DM4PR12MB5263namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thanks Tao.
I will add a comment as you suggested before committing the change.

Regards,
Mukul

From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, October 11, 2021 11:55 PM
To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix RAS page retirement with mode2 res=
et on Aldebaran


[AMD Official Use Only]

The patch looks good for me, but it's better to add comment in amdgpu_regis=
ter_bad_pages_mca_notifier to explain why we need to reserve GPU info inste=
ad of using mgpu_info list, with this addressed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>

________________________________
From: Joshi, Mukul <Mukul.Joshi@amd.com<mailto:Mukul.Joshi@amd.com>>
Sent: Tuesday, October 12, 2021 10:33 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Clements, Joh=
n <John.Clements@amd.com<mailto:John.Clements@amd.com>>; Joshi, Mukul <Muku=
l.Joshi@amd.com<mailto:Mukul.Joshi@amd.com>>
Subject: [PATCH 2/2] drm/amdgpu: Fix RAS page retirement with mode2 reset o=
n Aldebaran

During mode2 reset, the GPU is temporarily removed from the
mgpu_info list. As a result, page retirement fails because it
cannot find the GPU in the GPU list.
To fix this, create our own list of GPUs that support MCE notifier
based page retirement and use that list to check if the UMC error
occurred on a GPU that supports MCE notifier based page retirement.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com<mailto:mukul.joshi@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index e8875351967e..e8d88c77eb46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -112,7 +112,12 @@ static bool amdgpu_ras_check_bad_page_unlock(struct am=
dgpu_ras *con,
 static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
                                 uint64_t addr);
 #ifdef CONFIG_X86_MCE_AMD
-static void amdgpu_register_bad_pages_mca_notifier(void);
+static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *a=
dev);
+struct mce_notifier_adev_list {
+       struct amdgpu_device *devs[MAX_GPU_INSTANCE];
+       int num_gpu;
+};
+static struct mce_notifier_adev_list mce_adev_list;
 #endif

 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool rea=
dy)
@@ -2108,7 +2113,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *ad=
ev)
 #ifdef CONFIG_X86_MCE_AMD
         if ((adev->asic_type =3D=3D CHIP_ALDEBARAN) &&
             (adev->gmc.xgmi.connected_to_cpu))
-               amdgpu_register_bad_pages_mca_notifier();
+               amdgpu_register_bad_pages_mca_notifier(adev);
 #endif
         return 0;

@@ -2605,24 +2610,18 @@ void amdgpu_release_ras_context(struct amdgpu_devic=
e *adev)
 #ifdef CONFIG_X86_MCE_AMD
 static struct amdgpu_device *find_adev(uint32_t node_id)
 {
-       struct amdgpu_gpu_instance *gpu_instance;
         int i;
         struct amdgpu_device *adev =3D NULL;

-       mutex_lock(&mgpu_info.mutex);
-
-       for (i =3D 0; i < mgpu_info.num_gpu; i++) {
-               gpu_instance =3D &(mgpu_info.gpu_ins[i]);
-               adev =3D gpu_instance->adev;
+       for (i =3D 0; i < mce_adev_list.num_gpu; i++) {
+               adev =3D mce_adev_list.devs[i];

-               if (adev->gmc.xgmi.connected_to_cpu &&
+               if (adev && adev->gmc.xgmi.connected_to_cpu &&
                     adev->gmc.xgmi.physical_node_id =3D=3D node_id)
                         break;
                 adev =3D NULL;
         }

-       mutex_unlock(&mgpu_info.mutex);
-
         return adev;
 }

@@ -2718,8 +2717,9 @@ static struct notifier_block amdgpu_bad_page_nb =3D {
         .priority       =3D MCE_PRIO_UC,
 };

-static void amdgpu_register_bad_pages_mca_notifier(void)
+static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *a=
dev)
 {
+       mce_adev_list.devs[mce_adev_list.num_gpu++] =3D adev;
         /*
          * Register the x86 notifier only once
          * with MCE subsystem.
--
2.33.0

--_000_DM4PR12MB5263CF8C314A5B7092F6AF71EEB69DM4PR12MB5263namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks Tao.<o:p></o:p></p>
<p class=3D"MsoNormal">I will add a comment as you suggested before committ=
ing the change.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Mukul<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt; <b=
r>
<b>Sent:</b> Monday, October 11, 2021 11:55 PM<br>
<b>To:</b> Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Clements, John &lt;John.Clements@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Fix RAS page retirement with mo=
de2 reset on Aldebaran<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">The pat=
ch looks good for me, but it's better to add comment in&nbsp;amdgpu_registe=
r_bad_pages_mca_notifier to explain why we need to reserve GPU info instead=
 of using mgpu_info list, with this addressed,
 the patch is:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black;backgrou=
nd:white">Reviewed-by: Tao Zhou &lt;</span><span style=3D"font-size:12.0pt;=
color:black"><a href=3D"mailto:tao.zhou1@amd.com" target=3D"_blank"><span s=
tyle=3D"background:white">tao.zhou1@amd.com</span></a><span style=3D"backgr=
ound:white">&gt;</span><o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Joshi, Mukul &lt;<a href=3D"mailto:Mukul.Joshi@amd.=
com">Mukul.Joshi@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, October 12, 2021 10:33 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@am=
d.com</a>&gt;; Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">=
John.Clements@amd.com</a>&gt;; Joshi, Mukul &lt;<a href=3D"mailto:Mukul.Jos=
hi@amd.com">Mukul.Joshi@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Fix RAS page retirement with mode2 =
reset on Aldebaran</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">During mode2 reset, t=
he GPU is temporarily removed from the<br>
mgpu_info list. As a result, page retirement fails because it<br>
cannot find the GPU in the GPU list.<br>
To fix this, create our own list of GPUs that support MCE notifier<br>
based page retirement and use that list to check if the UMC error<br>
occurred on a GPU that supports MCE notifier based page retirement.<br>
<br>
Signed-off-by: Mukul Joshi &lt;<a href=3D"mailto:mukul.joshi@amd.com">mukul=
.joshi@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 ++++++++++++------------=
<br>
&nbsp;1 file changed, 12 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index e8875351967e..e8d88c77eb46 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -112,7 +112,12 @@ static bool amdgpu_ras_check_bad_page_unlock(struct am=
dgpu_ras *con,<br>
&nbsp;static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr);<br>
&nbsp;#ifdef CONFIG_X86_MCE_AMD<br>
-static void amdgpu_register_bad_pages_mca_notifier(void);<br>
+static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *a=
dev);<br>
+struct mce_notifier_adev_list {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *devs[MAX_GPU_IN=
STANCE];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_gpu;<br>
+};<br>
+static struct mce_notifier_adev_list mce_adev_list;<br>
&nbsp;#endif<br>
&nbsp;<br>
&nbsp;void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, boo=
l ready)<br>
@@ -2108,7 +2113,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *ad=
ev)<br>
&nbsp;#ifdef CONFIG_X86_MCE_AMD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =
=3D=3D CHIP_ALDEBARAN) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;gmc.xgmi.connected_to_cpu))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_register_bad_pages_mca_notifier();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_register_bad_pages_mca_notifier(adev);<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
@@ -2605,24 +2610,18 @@ void amdgpu_release_ras_context(struct amdgpu_devic=
e *adev)<br>
&nbsp;#ifdef CONFIG_X86_MCE_AMD<br>
&nbsp;static struct amdgpu_device *find_adev(uint32_t node_id)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gpu_instance *gpu_insta=
nce;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgpu_info.mutex);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; mgpu_info.num_gp=
u; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gpu_instance =3D &amp;(mgpu_info.gpu_ins[i]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev =3D gpu_instance-&gt;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; mce_adev_list.nu=
m_gpu; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev =3D mce_adev_list.devs[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev &amp;&amp; adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.physical_no=
de_id =3D=3D node_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;mgpu_info.mutex);<b=
r>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2718,8 +2717,9 @@ static struct notifier_block amdgpu_bad_page_nb =3D {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .priority&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =3D MCE_PRIO_UC,<br>
&nbsp;};<br>
&nbsp;<br>
-static void amdgpu_register_bad_pages_mca_notifier(void)<br>
+static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *a=
dev)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mce_adev_list.devs[mce_adev_list.num_=
gpu++] =3D adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Register the x86 n=
otifier only once<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * with MCE subsystem=
.<br>
-- <br>
2.33.0<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5263CF8C314A5B7092F6AF71EEB69DM4PR12MB5263namp_--
