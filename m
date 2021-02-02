Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34781C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 02:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F0264ECB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 02:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F0264ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593C66E5B6;
	Tue,  2 Feb 2021 02:21:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBA26E5B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 02:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhUO/9e+X5glAHTkNS+KWYioUccSj6lwojQ9BidXa2B6Z3NZTT7Jn1UFcvjAfWqwaLPkCvFB/vBDXfBNOUzWftJN8aBTxuI/yb5QZkQzUg3EptxrhsAiGoC8VbgysuSnJV8NFjKCKuaIIlyIW0ejo4keAXGOwmoHvXpenw188Lo8tKbksZv/gkqNLHqp1xblDS+ZfGtOBmwii1KhJW1n+S1KAI6e1QfHnVKeK1g/gQ8MfBH+yWo8IuwWtqnou/vD3PPevhH/fOQbRQ97lqiMljQsGQoS6oD3CMJqq1qPJepd0Wa2IiwNQk8g7U2P8S0shR/J8L/LRuQHooEGJgAdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQfaVEKymGRxF4mkLyz1GJZPADU4laf8xoLVyQ3Qvto=;
 b=Lw8FHaDfaYJTrBwJAPOaqYfgBly9AGGM4To+gEIghjuHfXRFSkLyviTiUkIcKDn39bAh2gCf2G4SkjipZi6KSc2jPIAiOETEK0Z2RCDT7P7WsVJEXsPOnrvRRe/L0SR8wI17ngFUPqLytAqg9aR0gZy4m+GMPB9Q5i+qLgVupz4pAWwPDaGJ/ydOcgWMTn8Q8XTN6y/BEpzShtPCM9uXctjkirTvscbAme2z8/O7uExYPDW1QSYeCbGjQ3L16lpa8d8bMeFWmCSFemiUPob+Krc1uRYsEw3OpT6XlubrUnPZBU8m7SkTpgfSxkyPpXtV2qWP5TZ2nW3g80aQJ80ROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQfaVEKymGRxF4mkLyz1GJZPADU4laf8xoLVyQ3Qvto=;
 b=dWGtRxwa6FBmytDNaxrGMC6wtKMQFLJ5wkWiXA5Ndnjsze/wAQIjeBKavVKk3RiI1fhKgo6k/mS4CAomy2ERD8kh8rKsuectpBHt52B8TQoMHOFUlak9zyIcnEhskhK2H5x0iVhZEtF9+1Krl32MzuCGi1dJvGXN3IbVqkjVZCc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1456.namprd12.prod.outlook.com (2603:10b6:301:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 02:21:26 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 02:21:26 +0000
Date: Tue, 2 Feb 2021 10:21:17 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: fix null pointer panic while free buffer in
 kfd
Message-ID: <20210202022117.GA3158722@hr-amd>
References: <20210201103916.3153820-1-ray.huang@amd.com>
 <1e721947-02e4-2fdf-42d0-e00fbb5a2856@amd.com>
Content-Disposition: inline
In-Reply-To: <1e721947-02e4-2fdf-42d0-e00fbb5a2856@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK0PR01CA0067.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Tue, 2 Feb 2021 02:21:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd00425d-b33e-4332-1402-08d8c7213df7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB14562D51DACE7CE7480B21A6ECB59@MWHPR12MB1456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJMczE134AvTQbWrufpyVcUlr07KG1rCZSOwgwpeZdl56YO8FE1C+/dSzlKDvJLAIyDnS8fd8vrDuoSQik8VRQtzBv/6cHtOn1V22jQtFYTdlbqQZ9cjIDThi1nX4nshkC3umE8vzO/6lOo4BgO7uMXcNIcs8XnyLgir3A03PVksBapi7xS2bPo3JYeiBuKXwoJIXz6e0VORPs7fX7P/mjApSEW1DggzzP3w/Z/HuCGz3jK82fyEEcZRWcmKqPzMrYqSjDB3o4iBXpyy5TNnk4tluLtbT5CTApJLl+n+bo9ZcPrnL0bv2WtQdDaXD/b7g6hhAL7wdWIQtN/Ihg9NF+X7yZMplLh/ANJNzMGvxiu7YfglHmak/YicdxIk/j/SQTOQvTxKzQrI9Wmmuo099cEiUluZycirzCbDJ08SphXkryBrQqtX0bLOczS+joNwrLXyWu41ou5Ftn2oFUK/w/DAe/iI+qTOYxGUeQrTe2HLRqoI5sm+88bCy77Y340LZJ4UrgqUJyEpMSL0R599uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(4326008)(6862004)(5660300002)(8936002)(83380400001)(86362001)(2906002)(54906003)(6636002)(6666004)(33656002)(6496006)(66946007)(186003)(66556008)(16526019)(1076003)(316002)(66476007)(55016002)(26005)(8676002)(9686003)(956004)(478600001)(33716001)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?Hf8/uUyoYeNepHSdpq7ImGsBxtUx3FonloDC2RdviVTaYwMAFOzWhTV0X8?=
 =?iso-8859-1?Q?hsW4uIE8+6oCg2h4hf7ajyc3GLNBezZ8DQiBBJTzumHMBmGTp3v1O7aMiO?=
 =?iso-8859-1?Q?WZr5Ldqxsf9+Azgsj90Gd847o/J5mTZfSOLj9iL3Cng5d5tNyJ6dge0aeh?=
 =?iso-8859-1?Q?sVeS6wKuv0/tC8P77zMGTf1WCv989oml2zI2XIPyPQOJhEqkObPIK1Ncjl?=
 =?iso-8859-1?Q?h+YhsqaU59MciKDPduELViIQZFZENmrI033DbOVz8cTTW1FG2CSNlMGROg?=
 =?iso-8859-1?Q?Ys9f5imzcBouR8k3b6358m5RHaIC7tMIYIN8TEIk2sEhWuOYhxIiabTKwo?=
 =?iso-8859-1?Q?iNLbGpgkzZJRHV0OCDbKhMyvfp1fuOCjY52N6bHScWVOFUqss0mHD/jDXF?=
 =?iso-8859-1?Q?trfDw4fm57mJ6uJqhB0HEGwzf+BD9h7xXBYlT/X4wjbhvfvvZkP5bbErZi?=
 =?iso-8859-1?Q?1QIpqT9xO2HX9ckrY+Teefj/qvQ+czHVDR5KsZjAzDVdqv0gldQY+W3ksE?=
 =?iso-8859-1?Q?dmj0ntyZU7OIUZgkvPNlTUns9X4145vFs6KHK24xuoDCKVxesyhqgRPPa/?=
 =?iso-8859-1?Q?6yNx1y0GiuID7nRth44j11m5D3EWdpkb2eMlNPsQem+1mAj8ioUX66LJgA?=
 =?iso-8859-1?Q?jkXvevAdpwlzHx9eVJjZ8gj6iQFW8Vkj1IPq737ABNK+LYauxV8pIlxRvS?=
 =?iso-8859-1?Q?jPcPZBQ7EsO8lFl89NsVVMzODeiquYkcNNMl5TGzJbQrHg1S2gb/MxRoa0?=
 =?iso-8859-1?Q?/g3O/EHTX1JqT08DBWWJujvNyGUauaDyx2sM3LKc0w5PauhptvzkKkNrjc?=
 =?iso-8859-1?Q?ty0qXi5dfG638wxe9uHIa0v+FainU819hAp0W0Z2tBzNRffheEb/Dq8OmK?=
 =?iso-8859-1?Q?OWkYch16IJv0KvIJD8YA5knoNyjYvultg54DxkWuAq6tg+FC/ezGNs8rO9?=
 =?iso-8859-1?Q?N1m0d9VCjvxiX4nIyoXNuvE0blov2hmYjbhnJaDjR7e3fS1uMQ/e9/c0uG?=
 =?iso-8859-1?Q?IYu8wTvQ0JVm4w/+Ti9sOJjmHq5ZkVxwDPo+r07+qHY92nnBFssIFkYISY?=
 =?iso-8859-1?Q?tcHCm8HqV8Z0485ngEzQuPYAfVHtG7JiHsnA/3WIyRgJeXpcXiLzzlJsdT?=
 =?iso-8859-1?Q?FToBIYDQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd00425d-b33e-4332-1402-08d8c7213df7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 02:21:26.5873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atDH6sZt4nl8fvcmDFXmgPOcLjDFYzLVZmulTfINgJgsomhFN06fFRlHihny6dMQPCn/r1w/b5yZuNMI7bD2rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1456
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhu,
 Changfeng" <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 01, 2021 at 10:25:36PM +0800, Kuehling, Felix wrote:
> Thank you for catching this. I haven't had a chance to try out Alex's
> rebased branch myself yet. I think this needs a
> =

> =A0=A0=A0 Fixes: 246cb7e49a70 ("drm/amdgpu: Introduce GEM object function=
s")
> =

> With that fixed, the patch is
> =

> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> =

> The fix also needs to go upstream as KFD seems to be very broken without =
it.

Thanks, will add the description and push into 5.11 drm-next. =


Ray

> =

> Regards,
> =A0 Felix
> =

> Am 2021-02-01 um 5:39 a.m. schrieb Huang Rui:
> > In drm_gem_object_free, it will call funcs of drm buffer obj. So
> > kfd_alloc should use amdgpu_gem_object_create instead of
> > amdgpu_bo_create to initialize the funcs as amdgpu_gem_object_funcs.
> >
> > [  396.231390] amdgpu: Release VA 0x7f76b4ada000 - 0x7f76b4add000
> > [  396.231394] amdgpu:   remove VA 0x7f76b4ada000 - 0x7f76b4add000 in e=
ntry 0000000085c24a47
> > [  396.231408] BUG: kernel NULL pointer dereference, address: 000000000=
0000000
> > [  396.231445] #PF: supervisor read access in kernel mode
> > [  396.231466] #PF: error_code(0x0000) - not-present page
> > [  396.231484] PGD 0 P4D 0
> > [  396.231495] Oops: 0000 [#1] SMP NOPTI
> > [  396.231509] CPU: 7 PID: 1352 Comm: clinfo Tainted: G           OE   =
  5.11.0-rc2-custom #1
> > [  396.231537] Hardware name: AMD Celadon-RN/Celadon-RN, BIOS WCD0401N_=
Weekly_20_04_0 04/01/2020
> > [  396.231563] RIP: 0010:drm_gem_object_free+0xc/0x22 [drm]
> > [  396.231606] Code: eb ec 48 89 c3 eb e7 0f 1f 44 00 00 55 48 89 e5 48=
 8b bf 00 06 00 00 e8 72 0d 01 00 5d c3 0f 1f 44 00 00 48 8b 87 40 01 00 00=
 <48> 8b 00 48 85 c0 74 0b 55 48 89 e5 e8 54 37 7c db 5d c3 0f 0b c3
> > [  396.231666] RSP: 0018:ffffb4704177fcf8 EFLAGS: 00010246
> > [  396.231686] RAX: 0000000000000000 RBX: ffff993a0d0cc400 RCX: 0000000=
000003113
> > [  396.231711] RDX: 0000000000000001 RSI: e9cda7a5d0791c6d RDI: ffff993=
a333a9058
> > [  396.231736] RBP: ffffb4704177fdd0 R08: ffff993a03855858 R09: 0000000=
000000000
> > [  396.231761] R10: ffff993a0d1f7158 R11: 0000000000000001 R12: 0000000=
000000000
> > [  396.231785] R13: ffff993a0d0cc428 R14: 0000000000003000 R15: ffffb47=
04177fde0
> > [  396.231811] FS:  00007f76b5730740(0000) GS:ffff993b275c0000(0000) kn=
lGS:0000000000000000
> > [  396.231840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  396.231860] CR2: 0000000000000000 CR3: 000000016d2e2000 CR4: 0000000=
000350ee0
> > [  396.231885] Call Trace:
> > [  396.231897]  ? amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x24c/0x25f [a=
mdgpu]
> > [  396.232056]  ? __dynamic_dev_dbg+0xcd/0x100
> > [  396.232076]  kfd_ioctl_free_memory_of_gpu+0x91/0x102 [amdgpu]
> > [  396.232214]  kfd_ioctl+0x211/0x35b [amdgpu]
> > [  396.232341]  ? kfd_ioctl_get_queue_wave_state+0x52/0x52 [amdgpu]
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >
> > This patch is to fix the issue on latest 5.11-rc2 based amd-staging-drm=
-next.
> >
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 0849b68e784f..ac0a432a9bf7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/sched/task.h>
> >  =

> >  #include "amdgpu_object.h"
> > +#include "amdgpu_gem.h"
> >  #include "amdgpu_vm.h"
> >  #include "amdgpu_amdkfd.h"
> >  #include "amdgpu_dma_buf.h"
> > @@ -1152,7 +1153,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
> >  	struct sg_table *sg =3D NULL;
> >  	uint64_t user_addr =3D 0;
> >  	struct amdgpu_bo *bo;
> > -	struct amdgpu_bo_param bp;
> > +	struct drm_gem_object *gobj;
> >  	u32 domain, alloc_domain;
> >  	u64 alloc_flags;
> >  	int ret;
> > @@ -1220,19 +1221,14 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
> >  	pr_debug("\tcreate BO VA 0x%llx size 0x%llx domain %s\n",
> >  			va, size, domain_string(alloc_domain));
> >  =

> > -	memset(&bp, 0, sizeof(bp));
> > -	bp.size =3D size;
> > -	bp.byte_align =3D 1;
> > -	bp.domain =3D alloc_domain;
> > -	bp.flags =3D alloc_flags;
> > -	bp.type =3D bo_type;
> > -	bp.resv =3D NULL;
> > -	ret =3D amdgpu_bo_create(adev, &bp, &bo);
> > +	ret =3D amdgpu_gem_object_create(adev, size, 1, alloc_domain, alloc_f=
lags,
> > +				       bo_type, NULL, &gobj);
> >  	if (ret) {
> >  		pr_debug("Failed to create BO on domain %s. ret %d\n",
> > -				domain_string(alloc_domain), ret);
> > +			 domain_string(alloc_domain), ret);
> >  		goto err_bo_create;
> >  	}
> > +	bo =3D gem_to_amdgpu_bo(gobj);
> >  	if (bo_type =3D=3D ttm_bo_type_sg) {
> >  		bo->tbo.sg =3D sg;
> >  		bo->tbo.ttm->sg =3D sg;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
