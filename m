Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2381C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 09:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CC5208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 09:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jr96MpRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CC5208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D066E92B;
	Thu, 20 Aug 2020 09:39:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 402386E92B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 09:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIoh1e6OY0ZSAdAs06N2EVOBC365yjanZXedUTImo7lPkW+rqmp8i57n4njs34jbnJnU+QFm2kYnDuP92ZXbdOYmhoxmtlXOik3NfAUurs7JC6+2e/1nomFjsaOdb4rtMLirqQ8zzcy6sC57MK8uWe/0yHhKqLNtyI7MJJbWmSTIKEfEI75tPxEktvZ2DOgYklz20Tu6Xxw3Mmi1ddaqyMhEvWTMpWuecWl4k/ElrpfxV5s3NFYFbfy7Rne4KoJu6HtIwOvQVm9ZNoP5Agt/VCoQku4Fg0FSp+x2TiKKqvLn7mZjMIOL0xIGNt3Oesz8lJ9fbHIPI3KfV7hyp9KdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1XfBt8gs8yaRf12jZmGEBXqdroggdHlmskujDbMC10=;
 b=Vqw0nIUC3ybeR4ztLMwE+y3FkHKe64ODEWbNNqlSsg4zqeTGvEDCmfMCEwIKEYtvcUFrRg0Ysfdhe8e1ZxOxCnBXBw2OelOx2vAsD6O72r+cj/EAOcnJEBdHL0e2E3lDEmFCZRykWFolmseSxfhfYEArGB54xd89IeC03RHbhjBRwOklBr5DJ8b9++i2y6xCUND1jzZjgjXfowaPGYUDSiJNbVh3igcMY+W2p3eLUq8xGQCNSS1xyc9ABjG3w0UGmUoBPByarB4YI3nrSAkwJERjghtWCpYDN4yuaY0yezESDn9ZGoTVuUU2IXJQpvigNdbqkrjm5vnA9ayFpROSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1XfBt8gs8yaRf12jZmGEBXqdroggdHlmskujDbMC10=;
 b=Jr96MpRUUPWDDUaLIDljPDYI9pIKbBPxtoB6mp5LcVqTqbaAlgehiMHwtkJYO0Y3P+6imYlKCqO+8HG8CjxOj+Rh0BttOi2HhKW+9DLVeRPT7XxtnkfZrnGuxl5hTGGktVBfgJNB6tcwXTgB0sHWgDdz0kOR4nWXJ0WtcTNnDF0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by BL0PR12MB2451.namprd12.prod.outlook.com (2603:10b6:207:4e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Thu, 20 Aug
 2020 09:39:03 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 09:39:03 +0000
Date: Thu, 20 Aug 2020 17:38:54 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 2/3] drm/amdkfd: force raven as "dgpu" path (v3)
Message-ID: <20200820093854.GA298091@hr-amd>
References: <20200819110647.212404-1-ray.huang@amd.com>
 <20200819110647.212404-2-ray.huang@amd.com>
 <68a090dd-e929-94b2-4de2-b42f337882f9@amd.com>
 <20200819235617.GB215900@hr-amd>
 <e31242f8-78df-9b7f-5e5a-b57c1722d5c3@amd.com>
 <20200820003125.GD215900@hr-amd>
Content-Disposition: inline
In-Reply-To: <20200820003125.GD215900@hr-amd>
X-ClientProxiedBy: HK2PR04CA0056.apcprd04.prod.outlook.com
 (2603:1096:202:14::24) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR04CA0056.apcprd04.prod.outlook.com (2603:1096:202:14::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 09:39:01 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0554574b-e5a8-4649-cd2f-08d844ecdfb2
X-MS-TrafficTypeDiagnostic: BL0PR12MB2451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2451410C943B39F93CDA61D8EC5A0@BL0PR12MB2451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0vdRBZlFp/jtRGMFidS/4Q+CzTAZOEiY9VWF7aYtLl8nbuph4p393h3Uptr/8Q8LTMz9iL5TuLa7WnK+8W/ok/p6bL64eXRTgvTOARcF4yKGijxUFUpve18eLfTWOohNVfPycPGqZASP89nYyhzWCIlJXuSvOmEnpd83Z1uexxnJ2eH6ryz1PsF/tdBMbnBjANpWWnzJO8U5hYgtNmjrH4jLjU3vbyhYfYSW3qcJdJMNuyz9y0FeUUWc1BtYAFOsj+yhu2KIs+bSpC+4qWCwqIH7bVfPIZi1pNOqB9sJghCAcP9Ajury920NwQubXv3gZD60mK9hCU3RTqTyBR80Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(53546011)(6666004)(83380400001)(316002)(6862004)(86362001)(5660300002)(4326008)(8936002)(2906002)(8676002)(66556008)(16526019)(55016002)(52116002)(6496006)(6636002)(9686003)(66946007)(186003)(33656002)(66476007)(956004)(1076003)(33716001)(26005)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: P7frCEwVUNr2DbWwszIv5i3OOK5+SDV8QUuiPIJXZqyjpfy1Je3XQV3meu1Cossa/fFnu6eAgGcD+BQ+RSO0MHN5cz57p/T/huvi3qvDN6xelIfcsncpkbwhaCjplImkwWMYCOVF5T20r5OBQoaRCkMr30i+QJIx1gSng6d3pwK2lELHpK0TIrILdnG+MPg+USJs5shJlTMPlZH0lzk8Ed1E0hWXGWOxLjR6Jsg/5Fb0dsg0eNY6fX3z1RRstyMWojdwmsygWiofJDmPB8qovBwysWw4WgZKPzqVxg7IHUJIkCBBuTLhBFbXO8+I+6tEDCkIkK5sn+sRYBKjDcFCSHiFchHi3ZyA+uwaBrUArh2mLRMmMv+TOJMQehacv8Vmc5KJOb2gjCcWLHd//tEYhdjNbIVDu7fgzQnXcGtYKQ2wwxeJ9/7hHMHrOemtVK1rltCsX2UEMH//t+uIrj3988AXpq63iKWVMbwJGY28VEa0Ipe/bM6oHedZPU95w/fKdztgg53IBqE+nDYKLzH7TjXjzR0UHPH1530xfzrvedj4T4EMkzSYmufrM13rivj1jfPt7BI+nxXKOc+BxkkHaR5iTpEvC4y+IeMkWZIIO01enpv6q4iX1JLm440PtCV7xFu9xBDlJu2/atTPHPFiVw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0554574b-e5a8-4649-cd2f-08d844ecdfb2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:39:03.2660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRdY0jZkodSLlmlmQSZYzx2llSzBDFsCWA5x2aMSYDNHcwv9gcaL7FIrbRN/fd5Z4k/vtMjwyHTEA52Exe3lPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2451
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 20, 2020 at 08:31:25AM +0800, Huang Rui wrote:
> On Thu, Aug 20, 2020 at 08:18:57AM +0800, Kuehling, Felix wrote:
> > On 2020-08-19 7:56 p.m., Huang Rui wrote:
> > > On Wed, Aug 19, 2020 at 11:38:34PM +0800, Kuehling, Felix wrote:
> > >> Am 2020-08-19 um 7:06 a.m. schrieb Huang Rui:
> > >>> We still have a few iommu issues which need to address, so force raven
> > >>> as "dgpu" path for the moment.
> > >>>
> > >>> This is to add the fallback path to bypass IOMMU if IOMMU v2 is disabled
> > >>> or ACPI CRAT table not correct.
> > >>>
> > >>> v2: Use ignore_crat parameter to decide whether it will go with IOMMUv2.
> > >>> v3: Align with existed thunk, don't change the way of raven, only renoir
> > >>>      will use "dgpu" path by default.
> > >>>
> > >>> Signed-off-by: Huang Rui <ray.huang@amd.com>
> > >>> ---
> > >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  5 +++-
> > >>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 28 ++++++++++++++++++++++-
> > >>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   |  2 +-
> > >>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +-
> > >>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  1 +
> > >>>   5 files changed, 34 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > >>> index a9a4319c24ae..189f9d7e190d 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > >>> @@ -684,11 +684,14 @@ MODULE_PARM_DESC(debug_largebar,
> > >>>    * Ignore CRAT table during KFD initialization. By default, KFD uses the ACPI CRAT
> > >>>    * table to get information about AMD APUs. This option can serve as a workaround on
> > >>>    * systems with a broken CRAT table.
> > >>> + *
> > >>> + * Default is auto (according to asic type, iommu_v2, and crat table, to decide
> > >>> + * whehter use CRAT)
> > >>>    */
> > >>>   int ignore_crat;
> > >>>   module_param(ignore_crat, int, 0444);
> > >>>   MODULE_PARM_DESC(ignore_crat,
> > >>> -	"Ignore CRAT table during KFD initialization (0 = use CRAT (default), 1 = ignore CRAT)");
> > >>> +	"Ignore CRAT table during KFD initialization (0 = auto (default), 1 = ignore CRAT)");
> > >>>   
> > >>>   /**
> > >>>    * DOC: halt_if_hws_hang (int)
> > >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > >>> index 59557e3e206a..f8346d4402e2 100644
> > >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > >>> @@ -22,6 +22,7 @@
> > >>>   
> > >>>   #include <linux/pci.h>
> > >>>   #include <linux/acpi.h>
> > >>> +#include <asm/processor.h>
> > >>>   #include "kfd_crat.h"
> > >>>   #include "kfd_priv.h"
> > >>>   #include "kfd_topology.h"
> > >>> @@ -740,6 +741,30 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
> > >>>   	return 0;
> > >>>   }
> > >>>   
> > >>> +
> > >>> +#ifdef CONFIG_ACPI
> > >>> +static void kfd_setup_ignore_crat_option(void)
> > >>> +{
> > >>> +
> > >>> +	if (ignore_crat)
> > >>> +		return;
> > >>> +
> > >>> +#ifndef KFD_SUPPORT_IOMMU_V2
> > >>> +	ignore_crat = 1;
> > >>> +#else
> > >>> +	ignore_crat = 0;
> > >>> +#endif
> > >>> +
> > >>> +	/* Renoir use the fallback path to align with existed thunk */
> > >> Are you sure you need special code for Renoir here? For Renoir the
> > >> dev->device_info already treats it as a dGPU and always has.
> > > Renoir also is an APU, in other words, we might have got the correct CRAT
> > > table from SBIOS (the CRAT table in SBIOS for renoir is broken so far). If
> > > we had got CRAT table, the kfd would create an APU node. That's not
> > > expected.
> > 
> > kfd_assign_gpu will not assign a Renoir GPU as the APU from the CRAT 
> > table because gpu->device_info->needs_iommu_device is False for Renoir. 
> > So Renoir will always show up in the topology as its own discrete GPU node.
> > 
> > How does this work today? Renoir is already treated as a dGPU. But the 
> > CPU node info (/sys/class/kfd/kfd/topology/nodes/0/properties) from the 
> > CRAT table still shows GPU cores?
> > 
> 
> Yes, Renoir works well. In fact, I found the problem while I was enabling
> the dGPU path for raven before. Even I set needs_iommu_device as false in
> raven's device info. The kfd still creates the APU node. (in v1 patch)
> 
> Let me rollback to check it again.
> 

Hi Felix,

I double check it again. If Renoir's ACPI CRAT were good, we wouldn't
create virtual CRAT table for Renoir at this moement. Then the pure CPU
node is unable to be created. That conflicted with needs_iommu_device flag
(we hardcode needs_iommu_device as false for renoir). Then will break the
user mode driver. (please see below rocminfo)

rocminfo: /libhsakmt/src/topology.c:1079: topology_sysfs_get_node_props: Assertion `props->EngineId.ui32.Major' failed.

So we probably would better have a specific handling to make sure Renoir
with virtual CRAT.

Thanks,
Ray
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
