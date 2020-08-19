Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDE3C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 03:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5782065F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 03:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a7JLIdbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5782065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4871B89DA2;
	Wed, 19 Aug 2020 03:09:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F4889DA2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 03:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMf/U5J5r0K3IIzLnY6jQuTx32CbWOOtU0xXJLLgtNvAhC+ZwCn6kMqkEd2QHXmS1dr8MNYhigPjiTRHR7SEKY+Ds5Fqy7BHJ2Jp3eENiidsxmshua2hFHbTdJG9hwq70SJhjw+TjqTlMEsc1+MnV7QGctXp49Ghiz6iSQ9crFthO1wlgPm7C36bxlQ0DDo45vqjgZnuq+V6Q/v7WUDipiQOvMIpaULgFHN2cjTWwKkBl3z7NU/MVALO568zXHy5Kb2lqqohVu4IVS2ZUw3G7P1rcjgCqQYvt1aDmBEACS4bKgUH3vyncdudh83cuWHPVcCDKs7Eo/if5q0YH2OBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbTnbS4atSsBKDfrkPBwxYOCJU0XCDPVqMR62hGvKPU=;
 b=KR+czQsr4aQIdlUgBEvP//QJfyFe1Uw8j9MAsdf866UKDkFGqYGq+PnYfjol3b1YNrn7nYsOxoylDm4vdetmV2pG956AL9YtZCpaWF4JCXxs0tOTqLxqG2by36+wIx9l2y5ojkjvFdejfRTTmlRbezFEdYWPcSj0onnV4KIxyhhcHVbWFZiV5076rGJyFELuPi2ve7am1QmMR8z7uuU2+Nx2YZWhcOpTOPxfrBvK19dMybSpuaa9jrXVFgx+oDgn1ouPjbhCIZqug28ApDliddmM1GIBcDSKGy2oigtF2h05X/uEK8ebcAOcATkn/g1C200wvwZEqAnqITpQ/KXm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbTnbS4atSsBKDfrkPBwxYOCJU0XCDPVqMR62hGvKPU=;
 b=a7JLIdbm/++KKjQF/dZhmWFczxJcbnSZrJ2eLnpb3Op2meLUPcUunqcZmS9AUz4IGd/uweEOfAVAXtPm1c1n6FoMgVYVfhLLjh8ApvXzNhlavkOviipVlwUb383ywku3rVH6pdDCqz53a2phrmbjAc4nwDUbDxRjGbvgfYltVwA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 03:09:20 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 03:09:20 +0000
Date: Wed, 19 Aug 2020 11:09:11 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2 2/3] drm/amdkfd: abstract the iommu device checking
 with ignore_crat
Message-ID: <20200819030911.GB181724@hr-amd>
References: <20200818130932.180114-1-ray.huang@amd.com>
 <20200818130932.180114-2-ray.huang@amd.com>
 <672f71d5-12fb-dd7a-b369-d6646b8a7905@amd.com>
Content-Disposition: inline
In-Reply-To: <672f71d5-12fb-dd7a-b369-d6646b8a7905@amd.com>
X-ClientProxiedBy: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR03CA0050.apcprd03.prod.outlook.com (2603:1096:202:17::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.10 via Frontend Transport; Wed, 19 Aug 2020 03:09:18 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c84f605-09c9-449b-fffd-08d843ed43b9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4126706F70DD2DC2E3A92934EC5D0@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ygrnIDEsIKSXE5duGgTXy6YCPcmcZULt/38iAFcLCZ65GPragpVvARrEs2R3Y19AJkVhVmWXGwdsLdOGmOq8GTAls5Kfdt85Sh+xZgly8KQg/Evc5nie2mOzYNv835CWOXhKbQIoBprBUXdfLigqfXB4jN0pYne4j+/9AYt/eW9x8l4OLkw5WwG2F2N5QxmIM4ClIzCZkI4UEQm9bn8FuBce5wCFHNRKI6iLN4Z1dA06Fr8N6xvNBOQ6tkUKFh3qZwj3QipqAooExWRY196KGc8pcFmgGfn2YohY+EZfgmO5OIRixtXxUeKspwLtJc7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(16526019)(6636002)(83380400001)(956004)(52116002)(6862004)(4326008)(6496006)(186003)(26005)(55016002)(86362001)(6666004)(5660300002)(316002)(2906002)(33716001)(478600001)(8676002)(66476007)(8936002)(66556008)(1076003)(33656002)(9686003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: e/YRJeKpDbvgnfK5L752xbIxfOwL4r7CRkLzZEhR+qBg2rnp1cg5nURYDXDohYvk/wWTgjKwxkmojVU7Dd+CiQM9r7xiN90Ibism8xqvRnEXhvP6moh0ciwZj2NuYRZ7Au6XTb+EBUWz9tyHwc8Mo5BGp+BSImtRYf9AoUn+wplTlRi3YIWBv9wzLgH2KXV7lYUizp5VVM0pq+ryPdttlk/4cAMVHjvnCNZMZor7Vit8IvLm5S7XvyTqqHNPvpgzWNKXqBmyXVFjHB0SV0m7IhtGziDbGDBaGTOoK6eSlhphymGEVEZk63CH0NHvrIrjR6HbwV2dTC51/bx4woiureyeW8E6BwGeSJk7jKfdLQppmOpRm7Qa68/UhjwBAFc7s0aN3lhhdd3GRmodYrepToL0sbvxcniG2GOzJI0AX+hPylSaW9Up7p8WoZBEjdsnk8JAynqnIXblMFYboEAO80dlQhMR7IwFvkeDVcblOGjNwgB6DsfA0RIYc4JGV8fr4OrF5WXrdfyo108rIiHVlb4G4xRhcJXifW199FCio7glTfQqSiMiKT3pNxD/f/ZIawmxYobAd/YghOb8DyDWp9ZXczYmeulW6/y5/Krh4sbOilWXNlgeuV34eixCUPuJydjgketV5auQWm1/vLpP/Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c84f605-09c9-449b-fffd-08d843ed43b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 03:09:19.9806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lqr49QEQHKtRIvyqPggbq633Z8H/jbwav5rcDVNYk+9Ws/1fhswelDCS8F6nA3UuzI28TH8hGqAPAB/fKYeBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 18, 2020 at 11:11:48PM +0800, Kuehling, Felix wrote:
> I'd recommend making this the first change in the series. Make
> 'drm/amdkfd: force raven as "dgpu" path' the second patch. That way it
> only needs to change one place.
> =


Yes, right.

> A few more comments inline.
> =

> =

> Am 2020-08-18 um 9:09 a.m. schrieb Huang Rui:
> > It's better to use inline function to wrap the iommu checking.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c                |  4 ++--
> >  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c   |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c           |  4 ++--
> >  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c                 | 10 +++++-----
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  8 ++++++++
> >  drivers/gpu/drm/amd/amdkfd/kfd_topology.c              |  6 +++---
> >  7 files changed, 22 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_chardev.c
> > index 20ef754dc62e..0598a1682854 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -1258,7 +1258,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
> >  		return true;
> >  	}
> >  =

> > -	if (dev->device_info->needs_iommu_device && !ignore_crat)
> > +	if (kfd_go_iommu_v2(dev->device_info))
> >  		return false;
> >  =

> >  	amdgpu_amdkfd_get_local_mem_info(dev->kgd, &mem_info);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_dbgdev.c
> > index 0c4161ac4102..04103273f52b 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> > @@ -309,7 +309,7 @@ static int dbgdev_address_watch_nodiq(struct kfd_db=
gdev *dbgdev,
> >  	for (i =3D 0; i < adw_info->num_watch_points; i++) {
> >  		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
> >  				&cntl, i, pdd->qpd.vmid,
> > -				dbgdev->dev->device_info->needs_iommu_device && !ignore_crat);
> > +				kfd_go_iommu_v2(dbgdev->dev->device_info));
> >  =

> >  		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
> >  		pr_debug("\t\t%20s %08x\n", "register index :", i);
> > @@ -399,7 +399,7 @@ static int dbgdev_address_watch_diq(struct kfd_dbgd=
ev *dbgdev,
> >  	for (i =3D 0; i < adw_info->num_watch_points; i++) {
> >  		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
> >  				&cntl, i, vmid,
> > -				dbgdev->dev->device_info->needs_iommu_device && !ignore_crat);
> > +				kfd_go_iommu_v2(dbgdev->dev->device_info));
> >  =

> >  		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
> >  		pr_debug("\t\t%20s %08x\n", "register index :", i);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b=
/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> > index 48b86bdbb680..70cede08e555 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> > @@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager =
*dqm,
> >  				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> >  					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
> >  		if (amdgpu_noretry &&
> > -		    !(dqm->dev->device_info->needs_iommu_device && !ignore_crat))
> > +		    !(kfd_go_iommu_v2(dqm->dev->device_info)))
> >  			qpd->sh_mem_config |=3D
> >  				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> >  =

> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_flat_memory.c
> > index 6044d36bceb6..fe7e31014289 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > @@ -321,7 +321,7 @@ static void kfd_init_apertures_vi(struct kfd_proces=
s_device *pdd, uint8_t id)
> >  	pdd->lds_base =3D MAKE_LDS_APP_BASE_VI();
> >  	pdd->lds_limit =3D MAKE_LDS_APP_LIMIT(pdd->lds_base);
> >  =

> > -	if (!(pdd->dev->device_info->needs_iommu_device && !ignore_crat)) {
> > +	if (!kfd_go_iommu_v2(pdd->dev->device_info)) {
> >  		/* dGPUs: SVM aperture starting at 0
> >  		 * with small reserved space for kernel.
> >  		 * Set them to CANONICAL addresses.
> > @@ -423,7 +423,7 @@ int kfd_init_apertures(struct kfd_process *process)
> >  				return -EINVAL;
> >  			}
> >  =

> > -			if (!(dev->device_info->needs_iommu_device && !ignore_crat)) {
> > +			if (!kfd_go_iommu_v2(dev->device_info)) {
> >  				/* dGPUs: the reserved space for kernel
> >  				 * before SVM
> >  				 */
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_iommu.c
> > index c767b524bea4..ea05446572e1 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> > @@ -41,7 +41,7 @@ int kfd_iommu_check_device(struct kfd_dev *kfd)
> >  	struct amd_iommu_device_info iommu_info;
> >  	int err;
> >  =

> > -	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
> > +	if (!kfd_go_iommu_v2(kfd->device_info))
> >  		return -ENODEV;
> >  =

> >  	iommu_info.flags =3D 0;
> > @@ -63,7 +63,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
> >  	unsigned int pasid_limit;
> >  	int err;
> >  =

> > -	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
> > +	if (!kfd_go_iommu_v2(kfd->device_info))
> >  		return 0;
> >  =

> >  	iommu_info.flags =3D 0;
> > @@ -109,7 +109,7 @@ int kfd_iommu_bind_process_to_device(struct kfd_pro=
cess_device *pdd)
> >  	struct kfd_process *p =3D pdd->process;
> >  	int err;
> >  =

> > -	if (!(dev->device_info->needs_iommu_device && !ignore_crat) || pdd->b=
ound =3D=3D PDD_BOUND)
> > +	if (!kfd_go_iommu_v2(dev->device_info) || pdd->bound =3D=3D PDD_BOUND)
> >  		return 0;
> >  =

> >  	if (unlikely(pdd->bound =3D=3D PDD_BOUND_SUSPENDED)) {
> > @@ -284,7 +284,7 @@ static void kfd_unbind_processes_from_device(struct=
 kfd_dev *kfd)
> >   */
> >  void kfd_iommu_suspend(struct kfd_dev *kfd)
> >  {
> > -	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
> > +	if (!kfd_go_iommu_v2(kfd->device_info))
> >  		return;
> >  =

> >  	kfd_unbind_processes_from_device(kfd);
> > @@ -304,7 +304,7 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
> >  	unsigned int pasid_limit;
> >  	int err;
> >  =

> > -	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
> > +	if (!kfd_go_iommu_v2(kfd->device_info))
> >  		return 0;
> >  =

> >  	pasid_limit =3D kfd_get_pasid_limit();
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index 60243798cce2..5087b23ccdb2 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -1232,6 +1232,14 @@ static inline int kfd_devcgroup_check_permission=
(struct kfd_dev *kfd)
> >  #endif
> >  }
> >  =

> > +static inline bool kfd_go_iommu_v2(const struct kfd_device_info *info)
> =

> I'd prefer a different function name: kfd_device_use_iommu_v2.
> =

> Then make the parameter const struct kfd_device *dev.
> =

> > +{
> > +	if (!info)
> > +		return false;
> > +
> > +	return info->needs_iommu_device && !ignore_crat;
> > +}
> =

> If you need a NULL check, you could still write it in a more compact way
> (I like inline functions to be one-liners):
> =

> =A0=A0=A0 return !ignore_crat && dev && dev->device_info->needs_iommu_dev=
ice;
> =

> If you make this the first patch in the series, remove the !ignore_crat
> part. That would be added in the second change.

That's fine. It looks better, thanks. I will update it in V2.


Thanks,
Ray

> =

> Regards,
> =A0 Felix
> =

> =

> > +
> >  /* Debugfs */
> >  #if defined(CONFIG_DEBUG_FS)
> >  =

> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_topology.c
> > index ad8139594b6f..e6f03867e0ed 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > @@ -545,7 +545,7 @@ static ssize_t node_show(struct kobject *kobj, stru=
ct attribute *attr,
> >  		 * If the ASIC is APU except Kaveri, set local memory size
> >  		 * to 0 to disable local memory support
> >  		 */
> > -		if (!(dev->gpu->device_info->needs_iommu_device && !ignore_crat)
> > +		if (!kfd_go_iommu_v2(dev->gpu->device_info)
> >  			|| dev->gpu->device_info->asic_family =3D=3D CHIP_KAVERI) {
> >  			amdgpu_amdkfd_get_local_mem_info(dev->gpu->kgd,
> >  				&local_mem_info);
> > @@ -1198,7 +1198,7 @@ static struct kfd_topology_device *kfd_assign_gpu=
(struct kfd_dev *gpu)
> >  		/* Discrete GPUs need their own topology device list
> >  		 * entries. Don't assign them to CPU/APU nodes.
> >  		 */
> > -		if (!(gpu->device_info->needs_iommu_device && !ignore_crat) &&
> > +		if (!kfd_go_iommu_v2(gpu->device_info) &&
> >  		    dev->node_props.cpu_cores_count)
> >  			continue;
> >  =

> > @@ -1453,7 +1453,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
> >  	* Overwrite ATS capability according to needs_iommu_device to fix
> >  	* potential missing corresponding bit in CRAT of BIOS.
> >  	*/
> > -	if (dev->gpu->device_info->needs_iommu_device && !ignore_crat)
> > +	if (kfd_go_iommu_v2(dev->gpu->device_info))
> >  		dev->node_props.capability |=3D HSA_CAP_ATS_PRESENT;
> >  	else
> >  		dev->node_props.capability &=3D ~HSA_CAP_ATS_PRESENT;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
