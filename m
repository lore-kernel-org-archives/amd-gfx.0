Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482FAC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 11:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F11642075D
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 11:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="itVXiinE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11642075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882CF6E357;
	Tue, 11 Aug 2020 11:46:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC376E357
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 11:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDWakeVGO6ViBt8XX0j6cRTm/c1Yoky0h+jtKuW6X/pGLprxjOB/ya82ZEImJNulOXsox9SazRKxrRtQQgfk/ZdKth1d0hEiDBT80WtVBXCjGxGHKitXLTXLn1QRcwtR8iM0fqj4m8SpN+Fhr7vEJMkPUjt8Wa5YoggeQs4sSkic/wNU2hWWURzj3hOkzwuLb5Ej9FoDPVpNAtNE781UsWwvVmdUNbvB4YuxI9ijdefrCDTZq5TT5+vwrufjkqnDsmGshKFJ81UBz/fEg7dZEhwIeIpz6zZnuSU0CKW5iQ5lvb8AWP6SnFr2cs2jIx4IBcEZOKgsQ9QGsZ5sootPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpOX0Lc65eQNlsI3GlQ3cOKr9w3XsQ8A4KwHblLoQUE=;
 b=HAztnVv9aM5UL3kq2fAPoxE05tM33d96ERORtFopOFt4KGXvdgmgdKC5nN8NfInh0p4vVh/54SlAHOJLafUoX90uA4vWl9cC6JWzvhvhXv7sZckg2DQpk6XZwXSVgQr1wGGpHYMCUtlTWsAGPcZZcCtQ14drlIfnD4y4Fsaxp44tJyslKkIXwiJFDPfy+Chv1OpB7I14H/2qHJHZw2q7mHp97HIb1Vago1JflNZgT4mO1BO4yzt4MHWfnToRxz5iyzCyPN7jB32FdALFRUJGahQB8+chEKgOy4CfaH+6inM9gkgoN78xsovvAXmKX4rycHOwEcKCsFLbA94Wo2r/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpOX0Lc65eQNlsI3GlQ3cOKr9w3XsQ8A4KwHblLoQUE=;
 b=itVXiinEzL0OFcq5dqAs19mcJcMwhQTBHOUE3KL7lo5CPRchJ1iXbjQGrG/O0b3MRQWO1Iq8DNFZFoth9MHLG0gTG/4m+hcOfyAtvqsTlWC1RUDYWPlFHMm+UaKOqZ/WaaGGuoU36opxffBLpSDDnL1mYJoHHuqTHPwsAIl4koo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 11:46:03 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 11:46:03 +0000
Date: Tue, 11 Aug 2020 19:45:54 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: force raven as "dgpu" path
Message-ID: <20200811114554.GA2901283@hr-amd>
References: <20200807082545.2382890-1-ray.huang@amd.com>
 <0ae61c8f-970c-417b-0ae4-639ea1a95f9a@amd.com>
Content-Disposition: inline
In-Reply-To: <0ae61c8f-970c-417b-0ae4-639ea1a95f9a@amd.com>
X-ClientProxiedBy: HKAPR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:c8::13) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HKAPR03CA0008.apcprd03.prod.outlook.com (2603:1096:203:c8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.5 via Frontend Transport; Tue, 11 Aug 2020 11:46:01 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0e6975f-fd4d-49d8-6c73-08d83dec1f7e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB430202F70F8F23818B6F1AC5EC450@MN2PR12MB4302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNr/XMQbnDQdiCZF9Zf2EWRTg33FOv9NaiwiH7/c9Sq3m92b/Hxb62p/IRjRrVAt8kgXss0S61Yxuytm3IvaZm/s1DVMBdkhN1Xwnln0GOqVNWovYORPmEi/r3GCi8AcdNdMcIDdzFP92A+UuKgi7H3v1VhntMh+NViu3qb7UlDugJX+ocLoau1wHhgfgeu+G5LoSAeGpexGMZaJBmtOntpdzuHrgHh7mhvPaIEFuZ3/Uc7r+J9jkppWExjInKc1PPCkW/9//xgjxmGVhdBw86g/IO7wB2RawV2EhSFuOiNH6p89LBnRwMyBEe4J85/EFUhptOpwlflcjy5OnCEyHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(4326008)(1076003)(5660300002)(66556008)(86362001)(8676002)(8936002)(33716001)(6666004)(33656002)(66946007)(66476007)(83380400001)(6862004)(316002)(6636002)(2906002)(478600001)(6496006)(956004)(9686003)(26005)(186003)(16526019)(55016002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Yix5k6C/BPYMJSOA5KxvuXJ7XO5RI7qL+Di/8ntSCuBDCqpITS/7VOurpg6XGjKGfhs0aEn7Bfpq+ZoOg7kwFMzDnUlqxicYDOW+oJYorbFr9owcrmrqFRYwruFvToi0/5xSSLYMVow9Mz2ewsVtSo72KB5BnYhqYuU7lGCKn1JbpxubGzsW+U9Fj8OmeaSBgjrZvtDMLM9fqdo1t1vvXa/BUhKmD1lURpp0EwPKmjPk3nirc3J6b62BkEpplKVT/apYqsXT97dPhBxXUyq/uJ6hMs5Sbf6f1oJm6c1s4qVi/w6fD0rCWiUeCDfA9+vk6EpHfEpX2l7gjSX4DgrGKWucsWCG2J69tU3RGgI8y/QefpxGAUBqhw3L2m+qn5/GqG57eBZJm8+DAfLlmwKnubeg3dQyak17KzirAA470KmlBFHLw4EHaEeTsOJFhrjDvKRHZRa5rQRgUHS1h1LLCa2ikrMgKmK7ilRpTj114BmnwhPiQyLZxutzpbFh+4OPJg2Nv2exko8/xP9vbXFTQRIx3Sx8diYGC9dtdwE1ymoovsYZLDmwajjeWtLNwTKi/EUN7jp+USAqoZ+yrd/eJUvxNwUjalyJS6cUXuP5HyHp9RkaugM7seVxu5qRzQrXCPkVIm7BcXVVDm0DivqvwQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e6975f-fd4d-49d8-6c73-08d83dec1f7e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 11:46:02.9726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Al2UVAsh/TL/wN+nf1V5C3t5JSVgKB3FpGPmEQBHilvdhZyawcGLg6F+XjHnYw4kujfcTHAu8mi7M5vuR6NX0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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

On Fri, Aug 07, 2020 at 11:00:38PM +0800, Kuehling, Felix wrote:
> Am 2020-08-07 um 4:25 a.m. schrieb Huang Rui:
> > We still have a few iommu issues which need to address, so force raven
> > as "dgpu" path for the moment.
> >
> > Will enable IOMMUv2 since the issues are fixed.
> =

> Do you mean "_when_ the issues are fixed"?

Yes.
 =

> The current iommuv2 troubles aside, I think this change breaks existing
> user mode. The existing Thunk is not prepared to see Raven as a dGPU. So
> this is not something we want to do in an upstream Linux kernel change.

Do you mean it may break the thunk without setting "is_dgpu" flag in the
hsa_gfxip_table for raven?

> =

> I suggest using the ignore_crat module parameter for the workaround
> instead. You may need to duplicate the raven_device_info and pick the
> right one depending on whether it is a dGPU or an APU. The only
> difference would be the need_iommu_device option. If ignore_crat is set,
> you can support Raven as a dGPU and require a corresponding Thunk change
> that conditionally support Raven as a dGPU.
> =

> I think such a change would also be the right direction for supporting
> Raven more universally in the future. It can be extended to
> conditionally treat Raven as a dGPU automatically in some situations:
> =

>   * broken or missing CRAT table
>   * IOMMUv2 disabled
> =

> Those are all situations where the current driver is broken anyway (and
> always has been), so it would not be a kernel change that breaks
> existing user mode.

OK, I think I understand it. We should use a parameter/flag such as
ignore_crat or something else to inform the user mode which path we should
go, treat it as dgpu or apu. Then thunk can detect the flag from kernel to
know how to handle the case. Am I right?

> =

> In addition the Thunk could be changed to downgrade a Raven APU to dGPU
> (by splitting the APU node into a separate CPU and dGPU node) if other
> dGPUs are present in the systems to disable all the APU-specific code
> paths and allow all the GPUs to work together seamlessly with SVM.

Thanks! Let me look at the thunk again.

For now, based on your comments, I would like to update patch as:

- Modify the ignore_crat parameter as tristate: "use", "ignore", and
  "auto". Usually, by default is "auto =3D use", but in some special case
  such as iommu v2 broken or no iommu v2 support yet (Renoir), we have to
  set "auto =3D ignore". Then treat it as "dgpu". And if CRAT table is
  broken/missing, we will fall back to treat it as "dgpu" as well.

What do you think of it?

Thanks,
Ray

> =

> Regards,
> =A0 Felix
> =

> =

> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 6 ++++++
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_crat.c
> > index 6a250f8fcfb8..66d9f7280fe8 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -22,6 +22,7 @@
> >  =

> >  #include <linux/pci.h>
> >  #include <linux/acpi.h>
> > +#include <asm/processor.h>
> >  #include "kfd_crat.h"
> >  #include "kfd_priv.h"
> >  #include "kfd_topology.h"
> > @@ -781,6 +782,11 @@ int kfd_create_crat_image_acpi(void **crat_image, =
size_t *size)
> >  		return -ENODATA;
> >  	}
> >  =

> > +	/* Raven series will go with the fallback path to use virtual CRAT */
> > +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD &&
> > +	    boot_cpu_data.x86 =3D=3D 0x17)
> > +		return -ENODATA;
> > +
> >  	pcrat_image =3D kmemdup(crat_table, crat_table->length, GFP_KERNEL);
> >  	if (!pcrat_image)
> >  		return -ENOMEM;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_device.c
> > index d5e790f046b4..93179c928371 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -116,6 +116,7 @@ static const struct kfd_device_info carrizo_device_=
info =3D {
> >  	.num_xgmi_sdma_engines =3D 0,
> >  	.num_sdma_queues_per_engine =3D 2,
> >  };
> > +#endif
> >  =

> >  static const struct kfd_device_info raven_device_info =3D {
> >  	.asic_family =3D CHIP_RAVEN,
> > @@ -128,13 +129,12 @@ static const struct kfd_device_info raven_device_=
info =3D {
> >  	.num_of_watch_points =3D 4,
> >  	.mqd_size_aligned =3D MQD_SIZE_ALIGNED,
> >  	.supports_cwsr =3D true,
> > -	.needs_iommu_device =3D true,
> > +	.needs_iommu_device =3D false,
> >  	.needs_pci_atomics =3D true,
> >  	.num_sdma_engines =3D 1,
> >  	.num_xgmi_sdma_engines =3D 0,
> >  	.num_sdma_queues_per_engine =3D 2,
> >  };
> > -#endif
> >  =

> >  static const struct kfd_device_info hawaii_device_info =3D {
> >  	.asic_family =3D CHIP_HAWAII,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
