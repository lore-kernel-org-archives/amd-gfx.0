Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C26C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 13:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6582B60EE2
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 13:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6582B60EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A3B6E0F4;
	Wed, 11 Aug 2021 13:19:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454546E0F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 13:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kez8kVNTJ1AbptHC67Kj3Ik12qnRcf32Eq66+DMROvFm5+0zEUrfyJrjrE7mZMXAVzpobHm4ea2KB/P0GRPRtOHDKlPjlpITWCleVfWPOCs8xHP2TBXUkUN3vtF84AC4h+tLnZlga/M9E26icV+g95iZXzEGl4cD9NpSlZDrz/QTrO/g0qDZfoNTMyhw8OAIWXAAA4Qv/ftTjDU75/7BcqUwTox9UWt6asDXvCigafZYiWckB7un8X+WI+fcHfhXaoUq03WfnHp/MICdZ35RpGZfyu/DFSE55RoakG20Dk8yDkYpZgjIY9CESqVoUAWj/TN1ORc1HHHaWZhEessUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhvg87hiB0sxJ08lA7XYWQpGWUb6wjoVi6xQuiwzfQg=;
 b=ixfaAor7I+FPKTHMMHageKCTz4iGncvFuPtqwZbKQxngz3ptBkgZ4pt21CRv7dx5TyMEKTnQpys8yLJut+PZ3E7iS3oFbSYpGN06ZXqL30OmuUiGk7k6ZPSJIJa9e90MbxzEbTlCQl5awcMQj36uIqLbf0UPF1fDcgMdubVVquJdR0zcwauV8mv5yyjYdlsAekgANQ74ov9LKb9UpbnCiisDS0rDnaPzolygcUk7KbaW3ZVOojhUvKaTYq5fQ7BFOQmII67edV1TfAIGUju0XCOuu3oNXN2uc3tGXO/scxig5ESMUi7vjX7whjA3c/OcyTrQB+T1Emc3aZZkU4+AQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhvg87hiB0sxJ08lA7XYWQpGWUb6wjoVi6xQuiwzfQg=;
 b=MVQx+mnA2sBDul3OQHunhVcF+DQiv8SiLqJSQE9tZeUO5kHw9lZnRlQnuUjFVeVsLRHbrpPywXn4pGt6JMGnu+R4GH56qHL4ZrNbc/VlHRvit9ypfHikuCel3YKbI4CqOuD+iZSILZinfTTGcKzZvH8fZoSSQfcOx8waYPUdQKY=
Received: from BN0PR04CA0191.namprd04.prod.outlook.com (2603:10b6:408:e9::16)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 11 Aug
 2021 13:19:12 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::63) by BN0PR04CA0191.outlook.office365.com
 (2603:10b6:408:e9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Wed, 11 Aug 2021 13:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Wed, 11 Aug 2021 13:19:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 08:19:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 08:19:11 -0500
Received: from wayne-dev (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 08:19:10 -0500
Date: Wed, 11 Aug 2021 21:19:04 +0800
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liu, Monk" <Monk.Liu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Jack Zhang <Jack.Zhang1@amd.com>, Jack Zhang
 <Jack.Zhang7@hotmail.com>
Subject: Re: [PATCH v4] drm/amd/amdgpu embed hw_fence into amdgpu_job
Message-ID: <20210811131904.kvasihg7omrfzfhk@wayne-dev>
References: <20210810032253.102933-1-Jingwen.Chen2@amd.com>
 <8f46a024-da65-f6ca-5904-ea07f98ffe39@amd.com>
 <DM5PR12MB24696109BB41D8DEDD43A5C2F1F89@DM5PR12MB2469.namprd12.prod.outlook.com>
 <DM5PR12MB246930FD789D2EEEC011935BF1F89@DM5PR12MB2469.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM5PR12MB246930FD789D2EEEC011935BF1F89@DM5PR12MB2469.namprd12.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cebc25b-4f98-4bdb-9e5b-08d95cca9c47
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4130E993606099B35F0BD595B7F89@BY5PR12MB4130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:295;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5l6Fh7lttsnUVwYM34uSvzByWfp5EuBSzf0kdqeWpsDgIFvZFDnsOzVBGDZFwzDpvUqOcMqMfhW+VZCIXL8fcSEkKqTLG1QdkBcdDKldCNmTZuixJA93JiAQdzeb4/mDFiVAxZmNl7yViOngZt7EOJoRGP6vr4Q08CwpjnpmB6btOy0b7alxyuNgGSS3BJqTyWI8KS4/i6zTKtICoIr5f1fMF1uUdYyfiE1VMEgl7lIY+t057Ti1YhuKP/0/HYZFX9E6QfUrQ+KFmDofer4vF2M4IGgPkTEVLtpnqJy40IOAScT9YrNmXSkLrOSXqsUlSbzLnWPtaUfpsQkpK7U5YHOsFvws8l5KBEpGSinM9aQjt7a19Xdc2Tmh38LtoI0rtmNoiNUoFGKL3LoYqU2qXoI2NF/bBtIWj/zswsf7KZnxxc24ycW7kjT5IV7jVlMzT9s7lq/E6SJ+hoOXKxj/ZKanZVABJGO1TnrGRsPz4cC9JLfyjmt+vExOQNIIcWm0WDHHeFYsvySJDmBDbzZWKzU/9ysoQd4mzUcDrAbcbf+ZM/40Ax5tLrF0xVGaiO1/WFgt80jdF23pddZ137Ulo87SPIOBzJojWa39JtEfr9V8l3jUp7yvmB6GIPy3yWr1zJrhj4NxljRyb2Ocb88dmkRi/N3WxQGeMNn3x5g0oAT3qT+C9K7SVk291BUXHRuyG8+2auEPwFIu7JPaAlCdXTFynZ0OTgn2XW/QgLiJ5pq1wPjrkHsq4ssHAsxHhvv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(86362001)(82310400003)(32650700002)(83380400001)(81166007)(34020700004)(186003)(356005)(336012)(4326008)(70586007)(70206006)(5660300002)(1076003)(426003)(53546011)(8936002)(508600001)(8676002)(30864003)(316002)(33716001)(55016002)(9686003)(6666004)(2906002)(45080400002)(54906003)(110136005)(26005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 13:19:12.4284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cebc25b-4f98-4bdb-9e5b-08d95cca9c47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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

Hi Guchun

Sorry to cause this fail. already submit a v5 patch to fix this.

On Wed Aug 11, 2021 at 05:26:52PM +0800, Chen, Guchun wrote:
> [Public]
> 
> Attach the error log.
> 
> [   99.534964] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> [   99.535531] amdgpu: SRAT table not found
> [   99.535532] amdgpu: Virtual CRAT table created for GPU
> [   99.536695] amdgpu: Topology: Add dGPU node [0x73a3:0x1002]
> [   99.536697] kfd kfd: amdgpu: added device 1002:73a3
> [   99.536717] amdgpu 0000:03:00.0: amdgpu: SE 4, SH per SE 2, CU per SH 10, active_cu_number 60
> [   99.536904] BUG: kernel NULL pointer dereference, address: 0000000000000048
> [   99.536906] #PF: supervisor read access in kernel mode
> [   99.536907] #PF: error_code(0x0000) - not-present page
> [   99.536908] PGD 0 P4D 0
> [   99.536910] Oops: 0000 [#1] SMP PTI
> [   99.536911] CPU: 8 PID: 2282 Comm: sdma0 Not tainted 5.13.0-guchchen #1
> [   99.536913] Hardware name: System manufacturer System Product Name/TUF Z370-PLUS GAMING II, BIOS 0411 09/21/2018
> [   99.536914] RIP: 0010:amdgpu_fence_enable_signaling+0x15/0x40 [amdgpu]
> [   99.537023] [drm] Unknown EDID CEA parser results
> [   99.537044] Code: 00 e9 4f 55 ab ed 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 81 7f 08 20 c7 b1 c0 74 02 31 ff 48 8b 7f 40 <48> 8b 47 48 48 85 c0 74 06 b8 01 00 00 00 c3 48 8b 35 95 9c e5 ee
> [   99.537046] RSP: 0018:ffffb50b01dcfe58 EFLAGS: 00010046
> [   99.537047] RAX: ffffffffc07adcc0 RBX: ffff9bd53c3f4d90 RCX: 0000000000000017
> [   99.537048] RDX: 0000000000000001 RSI: ffff9bd53c3f4c58 RDI: 0000000000000000
> [   99.537049] RBP: ffff9bd53c3f4c00 R08: 0000000000000000 R09: 000000000000b918
> [   99.537050] R10: 0000000000000001 R11: 0000000000000074 R12: ffffffffc06e4d10
> [   99.537050] R13: 0000000000000246 R14: ffff9bd53b60b9a0 R15: ffff9bd53c3f4d90
> [   99.537051] FS:  0000000000000000(0000) GS:ffff9bd826c00000(0000) knlGS:0000000000000000
> [   99.537052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   99.537053] CR2: 0000000000000048 CR3: 000000021360a005 CR4: 00000000003706e0
> [   99.537054] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   99.537055] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   99.537056] Call Trace:
> [   99.537057]  __dma_fence_enable_signaling+0x3c/0xa0
> [   99.537060]  dma_fence_add_callback+0x39/0xa0
> [   99.537062]  drm_sched_main+0x1aa/0x390 [gpu_sched]
> [   99.537065]  ? wait_woken+0x80/0x80
> [   99.537068]  ? drm_sched_get_cleanup_job+0x120/0x120 [gpu_sched]
> [   99.537070]  kthread+0x117/0x130
> [   99.537071]  ? kthread_park+0x90/0x9
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Guchun
> Sent: Wednesday, August 11, 2021 5:24 PM
> To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Jack Zhang <Jack.Zhang1@amd.com>; Jack Zhang <Jack.Zhang7@hotmail.com>
> Subject: RE: [PATCH v4] drm/amd/amdgpu embed hw_fence into amdgpu_job
> 
> [Public]
> 
> Hi Jingwen,
> 
> Your patch has caused amdgpu driver load failure on all ASICs. Please revert it first and come up with a proper fix.
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Andrey Grodzovsky
> Sent: Wednesday, August 11, 2021 12:41 AM
> To: Chen, JingWen <JingWen.Chen2@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Jack Zhang <Jack.Zhang1@amd.com>; Jack Zhang <Jack.Zhang7@hotmail.com>
> Subject: Re: [PATCH v4] drm/amd/amdgpu embed hw_fence into amdgpu_job
> 
> Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> 
> Andrey
> 
> On 2021-08-09 11:22 p.m., Jingwen Chen wrote:
> > From: Jack Zhang <Jack.Zhang1@amd.com>
> >
> > Why: Previously hw fence is alloced separately with job.
> > It caused historical lifetime issues and corner cases.
> > The ideal situation is to take fence to manage both job and fence's 
> > lifetime, and simplify the design of gpu-scheduler.
> >
> > How:
> > We propose to embed hw_fence into amdgpu_job.
> > 1. We cover the normal job submission by this method.
> > 2. For ib_test, and submit without a parent job keep the legacy way to 
> > create a hw fence separately.
> > v2:
> > use AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT to show that the fence is 
> > embeded in a job.
> > v3:
> > remove redundant variable ring in amdgpu_job
> > v4:
> > add tdr sequence support for this feature. Add a job_run_counter to 
> > indicate whether this job is a resubmit job.
> >
> > Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> > Signed-off-by: Jack Zhang <Jack.Zhang7@hotmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  1 -
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 12 +++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 73 ++++++++++++++++-----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 39 +++++++----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  6 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  5 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
> >   9 files changed, 108 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > index 7b46ba551cb2..3003ee1c9487 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -714,7 +714,6 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
> >   	ret = dma_fence_wait(f, false);
> >   
> >   err_ib_sched:
> > -	dma_fence_put(f);
> >   	amdgpu_job_free(job);
> >   err:
> >   	return ret;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index 536005bff24a..277128846dd1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1414,7 +1414,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
> >   			continue;
> >   		}
> >   		job = to_amdgpu_job(s_job);
> > -		if (preempted && job->fence == fence)
> > +		if (preempted && (&job->hw_fence) == fence)
> >   			/* mark the job as preempted */
> >   			job->preemption_status |= AMDGPU_IB_PREEMPTED;
> >   	}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 9e53ff851496..ade2fa07a50a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4447,7 +4447,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
> >   int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> >   				 struct amdgpu_reset_context *reset_context)
> >   {
> > -	int i, r = 0;
> > +	int i, j, r = 0;
> >   	struct amdgpu_job *job = NULL;
> >   	bool need_full_reset =
> >   		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags); @@
> > -4471,6 +4471,16 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> >   		if (!ring || !ring->sched.thread)
> >   			continue;
> >   
> > +		/*clear job fence from fence drv to avoid force_completion
> > +		 *leave NULL and vm flush fence in fence drv */
> > +		for (j = 0; j <= ring->fence_drv.num_fences_mask; j ++) {
> > +			struct dma_fence *old,**ptr;
> > +			ptr = &ring->fence_drv.fences[j];
> > +			old = rcu_dereference_protected(*ptr, 1);
> > +			if (old && test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &old->flags)) {
> > +				RCU_INIT_POINTER(*ptr, NULL);
> > +			}
> > +		}
> >   		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
> >   		amdgpu_fence_driver_force_completion(ring);
> >   	}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > index 7495911516c2..a8302e324110 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -129,30 +129,50 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
> >    *
> >    * @ring: ring the fence is associated with
> >    * @f: resulting fence object
> > + * @job: job the fence is embeded in
> >    * @flags: flags to pass into the subordinate .emit_fence() call
> >    *
> >    * Emits a fence command on the requested ring (all asics).
> >    * Returns 0 on success, -ENOMEM on failure.
> >    */
> > -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> > +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, 
> > +struct amdgpu_job *job,
> >   		      unsigned flags)
> >   {
> >   	struct amdgpu_device *adev = ring->adev;
> > -	struct amdgpu_fence *fence;
> > +	struct dma_fence *fence;
> > +	struct amdgpu_fence *am_fence;
> >   	struct dma_fence __rcu **ptr;
> >   	uint32_t seq;
> >   	int r;
> >   
> > -	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
> > -	if (fence == NULL)
> > -		return -ENOMEM;
> > +	if (job == NULL) {
> > +		/* create a sperate hw fence */
> > +		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
> > +		if (am_fence == NULL)
> > +			return -ENOMEM;
> > +		fence = &am_fence->base;
> > +		am_fence->ring = ring;
> > +	} else {
> > +		/* take use of job-embedded fence */
> > +		fence = &job->hw_fence;
> > +	}
> >   
> >   	seq = ++ring->fence_drv.sync_seq;
> > -	fence->ring = ring;
> > -	dma_fence_init(&fence->base, &amdgpu_fence_ops,
> > -		       &ring->fence_drv.lock,
> > -		       adev->fence_context + ring->idx,
> > -		       seq);
> > +	if (job != NULL && job->job_run_counter) {
> > +		/* reinit seq for resubmitted jobs */
> > +		fence->seqno = seq;
> > +	} else {
> > +		dma_fence_init(fence, &amdgpu_fence_ops,
> > +				&ring->fence_drv.lock,
> > +				adev->fence_context + ring->idx,
> > +				seq);
> > +	}
> > +
> > +	if (job != NULL) {
> > +		/* mark this fence has a parent job */
> > +		set_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &fence->flags);
> > +	}
> > +
> >   	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> >   			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> >   	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
> > @@ -175,9 +195,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> >   	/* This function can't be called concurrently anyway, otherwise
> >   	 * emitting the fence would mess up the hardware ring buffer.
> >   	 */
> > -	rcu_assign_pointer(*ptr, dma_fence_get(&fence->base));
> > +	rcu_assign_pointer(*ptr, dma_fence_get(fence));
> >   
> > -	*f = &fence->base;
> > +	*f = fence;
> >   
> >   	return 0;
> >   }
> > @@ -621,8 +641,16 @@ static const char 
> > *amdgpu_fence_get_driver_name(struct dma_fence *fence)
> >   
> >   static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
> >   {
> > -	struct amdgpu_fence *fence = to_amdgpu_fence(f);
> > -	return (const char *)fence->ring->name;
> > +	struct amdgpu_ring *ring;
> > +
> > +	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
> > +		struct amdgpu_job *job = container_of(f, struct amdgpu_job, 
> > +hw_fence);
> > +
> > +		ring = to_amdgpu_ring(job->base.sched);
> > +	} else {
> > +		ring = to_amdgpu_fence(f)->ring;
> > +	}
> > +	return (const char *)ring->name;
> >   }
> >   
> >   /**
> > @@ -656,8 +684,20 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
> >   static void amdgpu_fence_free(struct rcu_head *rcu)
> >   {
> >   	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> > -	struct amdgpu_fence *fence = to_amdgpu_fence(f);
> > -	kmem_cache_free(amdgpu_fence_slab, fence);
> > +
> > +	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
> > +	/* free job if fence has a parent job */
> > +		struct amdgpu_job *job;
> > +
> > +		job = container_of(f, struct amdgpu_job, hw_fence);
> > +		kfree(job);
> > +	} else {
> > +	/* free fence_slab if it's separated fence*/
> > +		struct amdgpu_fence *fence;
> > +
> > +		fence = to_amdgpu_fence(f);
> > +		kmem_cache_free(amdgpu_fence_slab, fence);
> > +	}
> >   }
> >   
> >   /**
> > @@ -680,6 +720,7 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
> >   	.release = amdgpu_fence_release,
> >   };
> >   
> > +
> >   /*
> >    * Fence debugfs
> >    */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > index ec65ab0ddf89..c076a6b9a5a2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -262,7 +262,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> >   				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
> >   	}
> >   
> > -	r = amdgpu_fence_emit(ring, f, fence_flags);
> > +	r = amdgpu_fence_emit(ring, f, job, fence_flags);
> >   	if (r) {
> >   		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
> >   		if (job && job->vmid)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > index d33e6d97cc89..7da9c1855bd0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -127,11 +127,16 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
> >   {
> >   	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
> >   	struct dma_fence *f;
> > +	struct dma_fence *hw_fence;
> >   	unsigned i;
> >   
> > -	/* use sched fence if available */
> > -	f = job->base.s_fence ? &job->base.s_fence->finished : job->fence;
> > +	if (job->hw_fence.ops == NULL)
> > +		hw_fence = job->external_hw_fence;
> > +	else
> > +		hw_fence = &job->hw_fence;
> >   
> > +	/* use sched fence if available */
> > +	f = job->base.s_fence ? &job->base.s_fence->finished : hw_fence;
> >   	for (i = 0; i < job->num_ibs; ++i)
> >   		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
> >   }
> > @@ -142,20 +147,27 @@ static void amdgpu_job_free_cb(struct 
> > drm_sched_job *s_job)
> >   
> >   	drm_sched_job_cleanup(s_job);
> >   
> > -	dma_fence_put(job->fence);
> >   	amdgpu_sync_free(&job->sync);
> >   	amdgpu_sync_free(&job->sched_sync);
> > -	kfree(job);
> > +
> > +    /* only put the hw fence if has embedded fence */
> > +	if (job->hw_fence.ops != NULL)
> > +		dma_fence_put(&job->hw_fence);
> > +	else
> > +		kfree(job);
> >   }
> >   
> >   void amdgpu_job_free(struct amdgpu_job *job)
> >   {
> >   	amdgpu_job_free_resources(job);
> > -
> > -	dma_fence_put(job->fence);
> >   	amdgpu_sync_free(&job->sync);
> >   	amdgpu_sync_free(&job->sched_sync);
> > -	kfree(job);
> > +
> > +	/* only put the hw fence if has embedded fence */
> > +	if (job->hw_fence.ops != NULL)
> > +		dma_fence_put(&job->hw_fence);
> > +	else
> > +		kfree(job);
> >   }
> >   
> >   int amdgpu_job_submit(struct amdgpu_job *job, struct 
> > drm_sched_entity *entity, @@ -184,11 +196,14 @@ int 
> > amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring 
> > *ring,
> >   
> >   	job->base.sched = &ring->sched;
> >   	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, NULL, fence);
> > -	job->fence = dma_fence_get(*fence);
> > +	/* record external_hw_fence for direct submit */
> > +	job->external_hw_fence = dma_fence_get(*fence);
> >   	if (r)
> >   		return r;
> >   
> >   	amdgpu_job_free(job);
> > +	dma_fence_put(*fence);
> > +
> >   	return 0;
> >   }
> >   
> > @@ -246,10 +261,12 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
> >   		if (r)
> >   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
> >   	}
> > -	/* if gpu reset, hw fence will be replaced here */
> > -	dma_fence_put(job->fence);
> > -	job->fence = dma_fence_get(fence);
> >   
> > +	if (!job->job_run_counter)
> > +		dma_fence_get(fence);
> > +	else if (finished->error < 0)
> > +		dma_fence_put(&job->hw_fence);
> > +	job->job_run_counter ++;
> >   	amdgpu_job_free_resources(job);
> >   
> >   	fence = r ? ERR_PTR(r) : fence;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > index 81caac9b958a..9e65730193b8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > @@ -46,7 +46,8 @@ struct amdgpu_job {
> >   	struct amdgpu_sync	sync;
> >   	struct amdgpu_sync	sched_sync;
> >   	struct amdgpu_ib	*ibs;
> > -	struct dma_fence	*fence; /* the hw fence */
> > +	struct dma_fence	hw_fence;
> > +	struct dma_fence	*external_hw_fence;
> >   	uint32_t		preamble_status;
> >   	uint32_t                preemption_status;
> >   	uint32_t		num_ibs;
> > @@ -62,6 +63,9 @@ struct amdgpu_job {
> >   	/* user fence handling */
> >   	uint64_t		uf_addr;
> >   	uint64_t		uf_sequence;
> > +
> > +	/* job_run_counter >= 1 means a resubmit job */
> > +	uint32_t		job_run_counter;
> >   };
> >   
> >   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs, 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 9c11ced4312c..03d4b29a76d6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -48,6 +48,9 @@
> >   #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
> >   #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> >   
> > +/* fence flag bit to indicate the face is embeded in job*/
> > +#define AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT		(DMA_FENCE_FLAG_USER_BITS + 1)
> > +
> >   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring,
> > sched)
> >   
> >   #define AMDGPU_IB_POOL_SIZE	(1024 * 1024)
> > @@ -118,7 +121,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> >   int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev); -int 
> > amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
> > +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence 
> > +**fence, struct amdgpu_job *job,
> >   		      unsigned flags);
> >   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
> >   			      uint32_t timeout);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index 2a88ed5d983b..2af8860d74cc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1218,7 +1218,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> >   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
> >   
> >   	if (vm_flush_needed || pasid_mapping_needed) {
> > -		r = amdgpu_fence_emit(ring, &fence, 0);
> > +		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
> >   		if (r)
> >   			return r;
> >   	}
