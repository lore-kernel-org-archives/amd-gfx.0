Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7128EC433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 08:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F64A2077D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 08:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ml2fqbij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F64A2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2E56E804;
	Wed, 22 Jul 2020 08:38:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0FA36E804
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 08:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St+Mqu7JbE/FQY47kKC3snBHRzebfNhjht5w22IMHO1afgKPdd3O40nzmH6W62NhdeIqJ2oLu33kD1jkBTWnfKOPEZ4WMtrdOHo0CjYQtit91Z/f0jyFBu4q2aqNAtn6dPlhjZD/RfEgbEvMGDvv51zQrv3577fkb/GHeYYKETB7CV+n1N31DCL+Eac/9oZ1Qw3suDh6OhrMg4rNxFDPG1hvKxhfL+aQJq+NNE9jyJFlqVOuOggJsTf5K/w0fUYTMVBLe47y6B+o6wp7VktBkBOJLwJaW0QxN5lQCBp6Z6gaiRICPdcBBWuc+L2kLHxN4ij4WgcnltbP6qBgeOfS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R466W185Xc0AqwG8RtNIafJxtncQDAqQWeszAp0S/f0=;
 b=WP26SEGvwM0DvcpRLi58RKBH3sR2/TaTLyeuqsToRChJl+nY2oG0yzXSbyiirfiy84dltsy1Xb+vzhJ64sC5DuTuRVrNekdLQL6okGx36hvAITM+J6vxXkkGVRaFqmsOuYrwivQo0Tk/DjrgLOraHxzgu9wOWEgYJG+0a2W2xzOeVvIT0qsPl7yOg1DPtGNiUwqHJbW/xrWkHNgoUdP5rJfEHKUCA0QUqXNTijVSlecA0kRvmR/xiVejCwWtN2G50HLGdDpMLlKwoU9xJ4hHqirHH2c1v1eZGFjluWheJq8j1+GgTWryQu/NEJG7WPJv/1W1eOG7gDqx7mMtrdtjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R466W185Xc0AqwG8RtNIafJxtncQDAqQWeszAp0S/f0=;
 b=ml2fqbijFHuzD47UVpk5JPjZz3CUsi6SLCtfw44sLKRNgWj2AwqhbQexWmbU1X3vn6fFDajY/6rmIzsy1+uedh7YypTU+Fx1A/STR7+5kYDljc9F55rpNZCtw4P9BT395udRu+RkfgGMtPbDXMgFcrfJdT55N1JDhsPhxXSExjk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB3694.namprd12.prod.outlook.com (2603:10b6:208:165::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Wed, 22 Jul
 2020 08:38:10 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3216.020; Wed, 22 Jul 2020
 08:38:04 +0000
Date: Wed, 22 Jul 2020 16:37:56 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 3/5] drm/amdgpu: add vmhub funcs helper
Message-ID: <20200722083756.GA1032920@hr-amd>
References: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
 <1595327359-120379-4-git-send-email-ray.huang@amd.com>
 <80dbf286-39f8-4db2-cda4-29e6db4fc3df@gmail.com>
Content-Disposition: inline
In-Reply-To: <80dbf286-39f8-4db2-cda4-29e6db4fc3df@gmail.com>
X-ClientProxiedBy: HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::16) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Wed, 22 Jul 2020 08:38:02 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dff2f2c3-81fe-4546-7caa-08d82e1a8ce1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3694:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3694183FA9894E902B649733EC790@MN2PR12MB3694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1SSX/73xVxKOOBxU3oOG1iM/wZJuCtqb8pJsGsTB97JAK4oFMBxn1znV4/N/Fv9q8qpYKLsl7L5onK4kUcWlAsx5ZgA0mp+6PnSfC9niFU2Z8EdNi5HY3JAuglyyqqcSAF2dNGWHdMxVb5h5X/pMjTBanmHkO97N0oMvZ5nQaunqSLd2hUJMLJWhLjAANztVmBwfx7EpFX4Ah2lyYmjNGBuOmrsoKbcmiam3y1OwPB1sFQM5jcXaA/P2CCPOELl4hsKXcn9HfNbFN6JFhTju57ELivCA3f3f6GcGYN8aw31u9d4a2dmZanXq1brAjXn8O2hGOTaJ+w7kJSbjjtYBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(19627235002)(4326008)(9686003)(55016002)(66946007)(6666004)(8676002)(1076003)(8936002)(33716001)(316002)(86362001)(6862004)(66476007)(66556008)(30864003)(26005)(2906002)(956004)(6496006)(6636002)(52116002)(16526019)(33656002)(186003)(83380400001)(478600001)(5660300002)(66574015);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YG43IbWsyK7KLAhgIkuDh/XlNvkEkeaXTjSxPLytr7rm5EHTB0eBDmtIeqvxkiEDenjyyZ96rOBabvM3bvXJBvSVVDH2qHO7DI7vp/M6C2XufXFpv7hCXTZOfMrV3Ucam3LhlxZaPN9yOPEolAnJzFZkZkwBCy1Eea/94NBsw2XCZqPpo1YgbXIehr0sciAAXznjMW7I2aw1lT+nRhWLmz2XY3FhPFR6MiAlMw/LD6A2SpLSkp2TCv22IuWeY04F9ECQ0sZFlHVwWue6BfF5dQzjrCU9VpacBqQoboZQqoHsLRB2+Y58Dl8Ff6nTtntaei52wlgxcp+KAvIuxKSWIVLPKpwvs0m+waRvDLiu2gQ0Ps12WVIp1nRBhge6uArliFs0AgZul0AdmRPs1B8xhfxruNVgATVbvy2mGqwtm8AUuiRwJmT3ukiY/h06igP2gVjVpV9hvvfLNWELqo7pGGFb9h4oXB5EFs4Ls5hzBZYnOKirV9T61QS6T4m7hsbh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff2f2c3-81fe-4546-7caa-08d82e1a8ce1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 08:38:04.4478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9mae19CkWRsGN9nAnTJ8Q1VUIDHlvIMAGjnctdLi8qVvIcaDDVtAe+zznAPBAoVq/YxXheuIqdVeP9u2xz1FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
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

On Wed, Jul 22, 2020 at 04:15:52PM +0800, Christian K=F6nig wrote:
> Am 21.07.20 um 12:29 schrieb Huang Rui:
> > This patch is to introduce vmhub funcs helper to add following callback
> > (print_l2_protection_fault_status). Each GC/MMHUB register specific pro=
gramming
> > should be in gfxhub/mmhub level.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 34 +++++++++++++++++++++++=
+++++++++
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 34 +++++++++++++++++++++++=
+++++++++
> >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 25 ++---------------------
> >   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 34 +++++++++++++++++++++++=
+++++++++
> >   5 files changed, 111 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.h
> > index 1785a0e..bbecd87 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > @@ -74,6 +74,11 @@ struct amdgpu_gmc_fault {
> >   /*
> >    * VMHUB structures, functions & helpers
> >    */
> > +struct amdgpu_vmhub_funcs {
> > +	void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
> > +						 uint32_t status);
> > +};
> > +
> >   struct amdgpu_vmhub {
> >   	uint32_t	ctx0_ptb_addr_lo32;
> >   	uint32_t	ctx0_ptb_addr_hi32;
> > @@ -94,6 +99,8 @@ struct amdgpu_vmhub {
> >   	uint32_t	eng_addr_distance; /* include LO32/HI32 */
> >   =

> >   	uint32_t	vm_cntx_cntl_vm_fault;
> > +
> > +	const struct amdgpu_vmhub_funcs *vmhub_funcs;
> >   };
> >   =

> >   /*
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm=
/amd/amdgpu/gfxhub_v2_0.c
> > index 993185f..14268ea 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> > @@ -31,6 +31,33 @@
> >   =

> >   #include "soc15_common.h"
> >   =

> > +static void
> > +gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *ade=
v,
> > +					     uint32_t status)
> > +{
> > +	dev_err(adev->dev,
> > +		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
> > +		status);
> > +	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, CID));
> > +	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> > +	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> > +	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
> > +	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
> > +	dev_err(adev->dev, "\t RW: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
> > +}
> > +
> >   u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
> >   {
> >   	u64 base =3D RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
> > @@ -360,6 +387,10 @@ void gfxhub_v2_0_set_fault_enable_default(struct a=
mdgpu_device *adev,
> >   	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
> >   }
> >   =

> > +static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs =3D {
> > +	.print_l2_protection_fault_status =3D gfxhub_v2_0_print_l2_protection=
_fault_status,
> > +};
> > +
> >   void gfxhub_v2_0_init(struct amdgpu_device *adev)
> >   {
> >   	struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB_0];
> > @@ -398,4 +429,7 @@ void gfxhub_v2_0_init(struct amdgpu_device *adev)
> >   		GCVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
> >   		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
> >   		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
> > +
> > +	if (hub->vmhub_funcs =3D=3D NULL)
> > +		hub->vmhub_funcs =3D &gfxhub_v2_0_vmhub_funcs;
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm=
/amd/amdgpu/gfxhub_v2_1.c
> > index 07cae64..45fbce7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> > @@ -31,6 +31,33 @@
> >   =

> >   #include "soc15_common.h"
> >   =

> > +static void
> > +gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device *ade=
v,
> > +					     uint32_t status)
> > +{
> > +	dev_err(adev->dev,
> > +		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
> > +		status);
> > +	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, CID));
> > +	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> > +	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> > +	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
> > +	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
> > +	dev_err(adev->dev, "\t RW: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
> > +}
> > +
> >   u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev)
> >   {
> >   	u64 base =3D RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
> > @@ -359,6 +386,10 @@ void gfxhub_v2_1_set_fault_enable_default(struct a=
mdgpu_device *adev,
> >   	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
> >   }
> >   =

> > +static const struct amdgpu_vmhub_funcs gfxhub_v2_1_vmhub_funcs =3D {
> > +	.print_l2_protection_fault_status =3D gfxhub_v2_1_print_l2_protection=
_fault_status,
> > +};
> > +
> >   void gfxhub_v2_1_init(struct amdgpu_device *adev)
> >   {
> >   	struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB_0];
> > @@ -397,6 +428,9 @@ void gfxhub_v2_1_init(struct amdgpu_device *adev)
> >   		GCVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
> >   		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
> >   		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
> > +
> > +	if (hub->vmhub_funcs =3D=3D NULL)
> > +		hub->vmhub_funcs =3D &gfxhub_v2_1_vmhub_funcs;
> >   }
> >   =

> >   int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v10_0.c
> > index e6c8526..8f35e13 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > @@ -121,29 +121,8 @@ static int gmc_v10_0_process_interrupt(struct amdg=
pu_device *adev,
> >   			task_info.task_name, task_info.pid);
> >   		dev_err(adev->dev, "  in page starting at address 0x%016llx from cl=
ient %d\n",
> >   			addr, entry->client_id);
> > -		if (!amdgpu_sriov_vf(adev)) {
> > -			dev_err(adev->dev,
> > -				"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
> > -				status);
> > -			dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> > -				REG_GET_FIELD(status,
> > -				GCVM_L2_PROTECTION_FAULT_STATUS, CID));
> > -			dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> > -				REG_GET_FIELD(status,
> > -				GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> > -			dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> > -				REG_GET_FIELD(status,
> > -				GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> > -			dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> > -				REG_GET_FIELD(status,
> > -				GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
> > -			dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> > -				REG_GET_FIELD(status,
> > -				GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
> > -			dev_err(adev->dev, "\t RW: 0x%lx\n",
> > -				REG_GET_FIELD(status,
> > -				GCVM_L2_PROTECTION_FAULT_STATUS, RW));
> > -		}
> > +		if (!amdgpu_sriov_vf(adev))
> > +			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
> >   	}
> >   =

> >   	return 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/=
amd/amdgpu/mmhub_v2_0.c
> > index 48134b9..fb634c1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> > @@ -36,6 +36,33 @@
> >   #define mmDAGB0_CNTL_MISC2_Sienna_Cichlid                       0x0070
> >   #define mmDAGB0_CNTL_MISC2_Sienna_Cichlid_BASE_IDX              0
> >   =

> > +static void
> > +mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
> > +					     uint32_t status)
> > +{
> > +	dev_err(adev->dev,
> > +		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
> > +		status);
> > +	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		MMVM_L2_PROTECTION_FAULT_STATUS, CID));
> > +	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> > +	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> > +	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
> > +	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
> > +	dev_err(adev->dev, "\t RW: 0x%lx\n",
> > +		REG_GET_FIELD(status,
> > +		MMVM_L2_PROTECTION_FAULT_STATUS, RW));
> > +}
> > +
> >   void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t=
 vmid,
> >   				uint64_t page_table_base)
> >   {
> > @@ -351,6 +378,10 @@ void mmhub_v2_0_set_fault_enable_default(struct am=
dgpu_device *adev, bool value)
> >   	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL, tmp);
> >   }
> >   =

> > +static const struct amdgpu_vmhub_funcs mmhub_v2_0_vmhub_funcs =3D {
> > +	.print_l2_protection_fault_status =3D mmhub_v2_0_print_l2_protection_=
fault_status,
> > +};
> > +
> >   void mmhub_v2_0_init(struct amdgpu_device *adev)
> >   {
> >   	struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_MMHUB_0];
> > @@ -389,6 +420,9 @@ void mmhub_v2_0_init(struct amdgpu_device *adev)
> >   		MMVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
> >   		MMVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
> >   		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
> > +
> > +	if (hub->vmhub_funcs =3D=3D NULL)
> > +		hub->vmhub_funcs =3D &mmhub_v2_0_vmhub_funcs;
> =

> Please assign that unconditionally here.
> =


Updated, thanks.

Ray

> Apart from that the series looks good to me as well.
> =

> Christian.
> =

> >   }
> >   =

> >   static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu=
_device *adev,
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
