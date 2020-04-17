Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9FEC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 07:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4707D208E4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 07:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n9FoHuRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4707D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A809C6E286;
	Fri, 17 Apr 2020 07:46:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361A46E286
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 07:46:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyxxH5hcGUrKcoRY2EDu7uZ8eDRUSmd/V4zyJuSt1QDIDBh8hsKwWcBGB0/NCob/8gPzVVQUFt0xvvfMQRIB3Tv5r2lrJng5K1D2hIVt70OEZEHBfjf2B6PONflioy0CUS19uMdQiazndbKE741rYX0gFLuP961CPhv3yeS0oTiaw3EHunQ4+/QbH8o616jfk8yncIn0iD7+LUV3Z5eQBW8iw9OSK29j97zFGHPYvE2xQCKLH3DtJpujAPShLJoDKaEoHTvpYktMpEfyZz4NgT/89XOMKeckFxLc0y/nOwsd7eQ6Y+NONV9rvu+j5mgxKm1Q7jYEC5qoMJX17rTnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIBY3hXbazISwsLEF1VELH+zgTMUuVP4UPEucMXZ0GE=;
 b=ZLmq7jaW932lrb7eaQv0r7vHMR+EVe54O9tlRoyXMOU7N8HBJEpWYFIg7I1Ae4+T6Qh7vJKsfzWR7Wg80TijWscSGd0Z279W9sajew3+VZ9vr/q6rQ/FOakTEPIYcO+NgShSTQObeGwbKxKChix7ODELg0sTTO6LHxCPwsIkvsAR3sAYJqSyfWXxOTpsYpQY16sMrsLUynnVkIsvwmZZtc5ECTLzK27domFI2qqArXGR569Ny/ZeU6hxsjIIvYwMb4OVIrcb2gX3390+Rdm3zJUdFPQJNupwu29MCivsvwMaETV49vg4fk/zIXZbWun8piMougvNee5UYLRSP8fjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIBY3hXbazISwsLEF1VELH+zgTMUuVP4UPEucMXZ0GE=;
 b=n9FoHuRFToFhAhzUH3bqn0+YgDVunH90efIx+eSvpUWGQknDfsqv3GGVAv0mUsbtZgFYdnFmdNG14nRgbpcgC7MQ5iYi4U/FMIR+pr+MeWfOEYLWLkVCxJ/GegRlRIIU/0XKy+U2jy6ytVyscuPWylIgRjIcAFAON6oCgimVeDc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 07:46:14 +0000
Received: from MN2PR12MB4408.namprd12.prod.outlook.com
 ([fe80::cc36:ee17:c768:8427]) by MN2PR12MB4408.namprd12.prod.outlook.com
 ([fe80::cc36:ee17:c768:8427%6]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 07:46:14 +0000
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20200413182026.2561-1-kent.russell@amd.com>
 <85fcb568-b0d8-b6c9-4e62-3866aa2da0c9@gmail.com>
 <DM6PR12MB3721FDB775B65C22B91D564585DA0@DM6PR12MB3721.namprd12.prod.outlook.com>
 <MN2PR12MB4488C1D9BF9C0A693860B1C1F7DA0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <146d9570-724e-423d-931e-24c96821aaae@email.android.com>
 <MN2PR12MB451836BC6F9C0F002EE1C3D685DA0@MN2PR12MB4518.namprd12.prod.outlook.com>
 <e69b430e-f4e3-c4a0-82f0-dae527cccf3d@amd.com>
 <MN2PR12MB4518A3D9746674DA688AD34885DA0@MN2PR12MB4518.namprd12.prod.outlook.com>
 <f99378af-9352-9d85-57d6-d4980484ce12@amd.com>
 <MN2PR12MB4518963F186CF8528A620A7D85DB0@MN2PR12MB4518.namprd12.prod.outlook.com>
 <ff3cbf9d-0c8b-b7c5-2077-01c3d48ff09c@amd.com>
 <SN1PR12MB2414C7A4F1A0133BB0AE3A4492DB0@SN1PR12MB2414.namprd12.prod.outlook.com>
 <MN2PR12MB45181F2428A410E2DD157DE085D80@MN2PR12MB4518.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6228fddc-de6f-b8d2-22b2-e1f93dfe87b9@amd.com>
Date: Fri, 17 Apr 2020 09:46:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB45181F2428A410E2DD157DE085D80@MN2PR12MB4518.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0059.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::39) To MN2PR12MB4408.namprd12.prod.outlook.com
 (2603:10b6:208:26c::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Fri, 17 Apr 2020 07:46:12 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de459be6-5a17-446b-056f-08d7e2a3674b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4472:|MN2PR12MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4472D4751FE1A54A9D4F57F383D90@MN2PR12MB4472.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4408.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(2616005)(4326008)(30864003)(53546011)(86362001)(52116002)(31696002)(6486002)(45080400002)(186003)(16526019)(2906002)(316002)(966005)(6666004)(54906003)(31686004)(36756003)(8676002)(33964004)(6636002)(5660300002)(81156014)(66556008)(66476007)(8936002)(66946007)(66574012)(110136005)(478600001)(579004)(559001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDA87fCd3yYbLibWUgHk+7n54FFSxUCPox/Incr0gx6RnSt02rQ1fV+q9ddRWEEABeiR3uszlmd4NUnoXAsdI9nbov4c6NM7V+ZAyvH/BBHQhKRzAJXIquv6/Ek1UIICMnSZOZfr1P/PRcElurQ3iPSrtaXeJ1riT3TVm7C9FHvW0uHeUwHaCZeV0MU1I2ntRcjzzYG3crLq83YBR6h6NwqWMg2xOiNbHOLrkWCcHkTEBPBZSrGhYC6vnmGUHkEZDuqDqSxAHhfbfCrwIG1IRiPx/g7N8+iqn5HxVPJJh0c+lEZzKOFe1C2sztT7xmNanQ9PCtN2G+OwpC2JQumWySL63MxlSkk4MKmYZrHiAnz9pwb5yZ3UQVB6nnUC+59VSEOz7pvIzng/v/Jri5ZEAPfv4bc23A3+U6YW8Cm1X1HeKpml05wlGP6eRvvepraTRFIhuBsWhaWKmJsKaHVTgh4baLraiGcQXtKTUrkUmLI=
X-MS-Exchange-AntiSpam-MessageData: Fm4BF6xJskukBSK5zeGQR04b9w/ZoX1DQP2KXSdfn+XQ7e0tooFX3Yld/pxtMuNXkxLQ8VVp8hAzvdZ+xlcG9It8Lgfplxv8bgx0zyApi2LovTtgHCRSBBkgzOHNAHM96Tc+M/HPTvnaSi8XrUU6Y2TwPyDTwBfpe0Qu9usovJu/2k9o8n/ztB6Dtu7gBDM+9X1mGDpHtX+WrTFv4CJJDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de459be6-5a17-446b-056f-08d7e2a3674b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 07:46:14.2744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apBp4KsCkFsxX426gXnfmMlkLQsTBuwXkODuS3nmuCfyk1ODUxGSjEJ2sMkrxCe0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0445819173=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0445819173==
Content-Type: multipart/alternative;
 boundary="------------C11D4B19F8344DD689278FD9"
Content-Language: en-US

--------------C11D4B19F8344DD689278FD9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Why do you think that 3efed000 and befed000 are misaligned addresses?

And see amdgpu_ttm_access_memory(), misaligned accesses are always 
routed to the MM path.

Regards,
Christian.

Am 16.04.20 um 18:08 schrieb Kim, Jonathan:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Felix,
>
> You’re probably right.
>
> Passing Vega20 system:
>
> [   56.683273] amdgpu: [vram dbg] addr         3e7ffff8, val         
> deadbeef
>
> [   56.683349] amdgpu: [vram dbg] addr         3efed000, val         
> cafebabe <- potential misalign access
>
> Failing Vega20 system:
>
> [Apr16 12:00] amdgpu: [vram dbg] addr         be7ffff8, val         
> deadbeef
>
> [  +0.000082] amdgpu: [vram dbg] addr         befed000, val         
> ffffffff <- potential misalign access
>
> Thanks,
>
> Jon
>
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Wednesday, April 15, 2020 11:02 AM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Kim, Jonathan 
> <Jonathan.Kim@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> *Cc:* Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in 
> amdgpu_device_vram_access v2"
>
> [AMD Official Use Only - Internal Distribution Only]
>
> The test does not access outside of the allocated memory. But it 
> deliberately crosses a boundary where memory can be allocated 
> non-contiguously. This is meant to catch problems where the access 
> function doesn't handle non-contiguous VRAM allocations correctly. 
> However, the way that VRAM allocation has been optimized, I expect 
> that most allocations are contiguous nowadays. However, the more 
> interesting aspect of the test is, that it performs misaligned memory 
> accesses. The MMIO method of accessing VRAM explicitly handles 
> misaligned accesses and breaks them down into dword aligned accesses 
> with proper masking and shifting.
>
> Could the unaligned nature of the memory access have something to do 
> with hitting RAS errors? That's something unique to this test that we 
> wouldn't see on a normal page table update or memory eviction.
>
> Regards,
>   Felix
>
> ------------------------------------------------------------------------
>
> *From:*Koenig, Christian <Christian.Koenig@amd.com 
> <mailto:Christian.Koenig@amd.com>>
> *Sent:* Wednesday, April 15, 2020 6:58 AM
> *To:* Kim, Jonathan <Jonathan.Kim@amd.com 
> <mailto:Jonathan.Kim@amd.com>>; Kuehling, Felix 
> <Felix.Kuehling@amd.com <mailto:Felix.Kuehling@amd.com>>; Deucher, 
> Alexander <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
> *Cc:* Russell, Kent <Kent.Russell@amd.com 
> <mailto:Kent.Russell@amd.com>>; amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>
> *Subject:* Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in 
> amdgpu_device_vram_access v2"
>
>     To elaborate on the PTRACE test, we PEEK 2 DWORDs inside thunk
>     allocated mapped memory and 2 DWORDS outside that boundary (it’s
>     only about 4MB to the boundary). Then we POKE to swap the DWORD
>     positions across the boundary.  The RAS event on the single
>     failing machine happens on the out of boundary PEEK.
>
>
> Well when you access outside of an allocated buffer I would expect 
> that we never get as far as even touching the hardware because the 
> kernel should block the access with an -EPERM or -EFAULT. So sounds 
> like I'm not understanding something correctly here.
>
> Apart from that I completely agree that we need to sort out any other 
> RAS event first to make sure that the system is simply not failing 
> randomly.
>
> Regards,
> Christian.
>
> Am 15.04.20 um 11:49 schrieb Kim, Jonathan:
>
>     [AMD Public Use]
>
>     Hi Christian,
>
>     That could potentially be it.  With additional testing, 2 of 3
>     Vega20 machines never hit error over BAR access with the PTRACE
>     test.  3 of 3 machines (from the same pool) always hit error with
>     CWSR.
>
>     To elaborate on the PTRACE test, we PEEK 2 DWORDs inside thunk
>     allocated mapped memory and 2 DWORDS outside that boundary (it’s
>     only about 4MB to the boundary). Then we POKE to swap the DWORD
>     positions across the boundary.  The RAS event on the single
>     failing machine happens on the out of boundary PEEK.
>
>     Felix mentioned we don’t hit errors over general HDP access but
>     that may not true.  An Arcturus failure sys logs posted (which
>     wasn’t tested by me) shows someone launched rocm bandwidth test,
>     hit a VM fault and a RAS event ensued during evictions (I can
>     point the internal ticket or log snippet offline if interested). 
>     Whether the RAS event is BAR access triggered or the result of HW
>     instability is beyond me since I don’t have access to the machine.
>
>     Thanks,
>
>     Jon
>
>     *From:* Koenig, Christian <Christian.Koenig@amd.com>
>     <mailto:Christian.Koenig@amd.com>
>     *Sent:* Wednesday, April 15, 2020 4:11 AM
>     *To:* Kim, Jonathan <Jonathan.Kim@amd.com>
>     <mailto:Jonathan.Kim@amd.com>; Kuehling, Felix
>     <Felix.Kuehling@amd.com> <mailto:Felix.Kuehling@amd.com>; Deucher,
>     Alexander <Alexander.Deucher@amd.com>
>     <mailto:Alexander.Deucher@amd.com>
>     *Cc:* Russell, Kent <Kent.Russell@amd.com>
>     <mailto:Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     *Subject:* Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible
>     in amdgpu_device_vram_access v2"
>
>     Hi Jon,
>
>         Also cwsr tests fail on Vega20 with or without the revert with
>         the same RAS error.
>
>
>     That sounds like the system/setup has a more general problem.
>
>     Could it be that we are seeing RAS errors because there really is
>     some hardware failure, but with the MM path we don't trigger a RAS
>     interrupt?
>
>     Thanks,
>     Christian.
>
>     Am 14.04.20 um 22:30 schrieb Kim, Jonathan:
>
>         [AMD Official Use Only - Internal Distribution Only]
>
>         If we’re passing the test on the revert, then the only thing
>         that’s different is we’re not invalidating HDP and doing a
>         copy to host anymore in amdgpu_device_vram_access since the
>         function is still called in ttm access_memory with BAR.
>
>         Also cwsr tests fail on Vega20 with or without the revert with
>         the same RAS error.
>
>         Thanks,
>
>         Jon
>
>         *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
>         <mailto:Felix.Kuehling@amd.com>
>         *Sent:* Tuesday, April 14, 2020 2:32 PM
>         *To:* Kim, Jonathan <Jonathan.Kim@amd.com>
>         <mailto:Jonathan.Kim@amd.com>; Koenig, Christian
>         <Christian.Koenig@amd.com> <mailto:Christian.Koenig@amd.com>;
>         Deucher, Alexander <Alexander.Deucher@amd.com>
>         <mailto:Alexander.Deucher@amd.com>
>         *Cc:* Russell, Kent <Kent.Russell@amd.com>
>         <mailto:Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         *Subject:* Re: [PATCH] Revert "drm/amdgpu: use the BAR if
>         possible in amdgpu_device_vram_access v2"
>
>         I wouldn't call it premature. Revert is a usual practice when
>         there is a serious regression that isn't fully understood or
>         root-caused. As far as I can tell, the problem has been
>         reproduced on multiple systems, different GPUs, and clearly
>         regressed to Christian's commit. I think that justifies
>         reverting it for now.
>
>         I agree with Christian that a general HDP memory access
>         problem causing RAS errors would potentially cause problems in
>         other tests as well. For example common operations like GART
>         table updates, and GPUVM page table updates and PCIe peer2peer
>         accesses in ROCm applications use HDP. But we're not seeing
>         obvious problems from those. So we need to understand what's
>         special about this test. I asked questions to that effect on
>         our other email thread.
>
>         Regards,
>           Felix
>
>         Am 2020-04-14 um 10:51 a.m. schrieb Kim, Jonathan:
>
>             [AMD Official Use Only - Internal Distribution Only]
>
>             I think it’s premature to push this revert.
>
>             With more testing, I’m getting failures from different
>             tests or sometimes none at all on my machine.
>
>             Kent, let’s continue the discussion on the original thread.
>
>             Thanks,
>
>             Jon
>
>             *From:* Koenig, Christian <Christian.Koenig@amd.com>
>             <mailto:Christian.Koenig@amd.com>
>             *Sent:* Tuesday, April 14, 2020 10:47 AM
>             *To:* Deucher, Alexander <Alexander.Deucher@amd.com>
>             <mailto:Alexander.Deucher@amd.com>
>             *Cc:* Russell, Kent <Kent.Russell@amd.com>
>             <mailto:Kent.Russell@amd.com>;
>             amd-gfx@lists.freedesktop.org
>             <mailto:amd-gfx@lists.freedesktop.org>; Kuehling, Felix
>             <Felix.Kuehling@amd.com> <mailto:Felix.Kuehling@amd.com>;
>             Kim, Jonathan <Jonathan.Kim@amd.com>
>             <mailto:Jonathan.Kim@amd.com>
>             *Subject:* Re: [PATCH] Revert "drm/amdgpu: use the BAR if
>             possible in amdgpu_device_vram_access v2"
>
>             That's exactly my concern as well.
>
>             This looks a bit like the test creates erroneous data
>             somehow, but there doesn't seems to be a RAS check in the
>             MM data path.
>
>             And now that we use the BAR path it goes up in flames.
>
>             I just don't see how we can create erroneous data in a
>             test case?
>
>             Christian.
>
>             Am 14.04.2020 16:35 schrieb "Deucher, Alexander"
>             <Alexander.Deucher@amd.com
>             <mailto:Alexander.Deucher@amd.com>>:
>
>                 [AMD Public Use]
>
>                 If this causes an issue, any access to vram via the
>                 BAR could cause an issue.
>
>                 Alex
>
>                 ------------------------------------------------------------------------
>
>                 *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>                 <mailto:amd-gfx-bounces@lists.freedesktop.org>> on
>                 behalf of Russell, Kent <Kent.Russell@amd.com
>                 <mailto:Kent.Russell@amd.com>>
>                 *Sent:* Tuesday, April 14, 2020 10:19 AM
>                 *To:* Koenig, Christian <Christian.Koenig@amd.com
>                 <mailto:Christian.Koenig@amd.com>>;
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 <amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>>
>                 *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com
>                 <mailto:Felix.Kuehling@amd.com>>; Kim, Jonathan
>                 <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
>                 *Subject:* RE: [PATCH] Revert "drm/amdgpu: use the BAR
>                 if possible in amdgpu_device_vram_access v2"
>
>                 [AMD Official Use Only - Internal Distribution Only]
>
>                 On VG20 or MI100, as soon as we run the subtest, we
>                 get the dmesg output below, and then the kernel ends
>                 up hanging. I don't know enough about the test itself
>                 to know why this is occurring, but Jon Kim and Felix
>                 were discussing it on a separate thread when the issue
>                 was first reported, so they can hopefully provide some
>                 additional information.
>
>                  Kent
>
>                 > -----Original Message-----
>                 > From: Christian König
>                 <ckoenig.leichtzumerken@gmail.com
>                 <mailto:ckoenig.leichtzumerken@gmail.com>>
>                 > Sent: Tuesday, April 14, 2020 9:52 AM
>                 > To: Russell, Kent <Kent.Russell@amd.com
>                 <mailto:Kent.Russell@amd.com>>;
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 > Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR
>                 if possible in
>                 > amdgpu_device_vram_access v2"
>                 >
>                 > Am 13.04.20 um 20:20 schrieb Kent Russell:
>                 > > This reverts commit
>                 c12b84d6e0d70f1185e6daddfd12afb671791b6e.
>                 > > The original patch causes a RAS event and
>                 subsequent kernel hard-hang
>                 > > when running the
>                 KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
>                 > > Arcturus
>                 > >
>                 > > dmesg output at hang time:
>                 > > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT
>                 detected!
>                 > > amdgpu 0000:67:00.0: GPU reset begin!
>                 > > Evicting PASID 0x8000 queues
>                 > > Started evicting pasid 0x8000
>                 > > qcm fence wait loop timeout expired
>                 > > The cp might be in an unrecoverable state due to
>                 an unsuccessful
>                 > > queues preemption Failed to evict process queues
>                 Failed to suspend
>                 > > process 0x8000 Finished evicting pasid 0x8000
>                 Started restoring pasid
>                 > > 0x8000 Finished restoring pasid 0x8000 [drm] UVD
>                 VCPU state may lost
>                 > > due to RAS ERREVENT_ATHUB_INTERRUPT
>                 > > amdgpu: [powerplay] Failed to send message 0x26,
>                 response 0x0
>                 > > amdgpu: [powerplay] Failed to set soft min gfxclk !
>                 > > amdgpu: [powerplay] Failed to upload DPM Bootup
>                 Levels!
>                 > > amdgpu: [powerplay] Failed to send message 0x7,
>                 response 0x0
>                 > > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed
>                 to disable all smu
>                 > features!
>                 > > amdgpu: [powerplay] [DisableDpmTasks] Failed to
>                 disable all smu features!
>                 > > amdgpu: [powerplay] [PowerOffAsic] Failed to
>                 disable DPM!
>                 > > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]]
>                 *ERROR* suspend of IP
>                 > > block <powerplay> failed -5
>                 >
>                 > Do you have more information on what's going wrong
>                 here since this is a really
>                 > important patch for KFD debugging.
>                 >
>                 > >
>                 > > Signed-off-by: Kent Russell <kent.russell@amd.com
>                 <mailto:kent.russell@amd.com>>
>                 >
>                 > Reviewed-by: Christian König
>                 <christian.koenig@amd.com
>                 <mailto:christian.koenig@amd.com>>
>                 >
>                 > > ---
>                 > > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>                 ----------------------
>                 > >   1 file changed, 26 deletions(-)
>                 > >
>                 > > diff --git
>                 a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > index cf5d6e585634..a3f997f84020 100644
>                 > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > @@ -254,32 +254,6 @@ void
>                 amdgpu_device_vram_access(struct
>                 > amdgpu_device *adev, loff_t pos,
>                 > >      uint32_t hi = ~0;
>                 > >      uint64_t last;
>                 > >
>                 > > -
>                 > > -#ifdef CONFIG_64BIT
>                 > > -   last = min(pos + size,
>                 adev->gmc.visible_vram_size);
>                 > > -   if (last > pos) {
>                 > > -           void __iomem *addr =
>                 adev->mman.aper_base_kaddr + pos;
>                 > > -           size_t count = last - pos;
>                 > > -
>                 > > -           if (write) {
>                 > > - memcpy_toio(addr, buf, count);
>                 > > -                   mb();
>                 > > - amdgpu_asic_flush_hdp(adev, NULL);
>                 > > -           } else {
>                 > > - amdgpu_asic_invalidate_hdp(adev, NULL);
>                 > > -                   mb();
>                 > > - memcpy_fromio(buf, addr, count);
>                 > > -           }
>                 > > -
>                 > > -           if (count == size)
>                 > > -                   return;
>                 > > -
>                 > > -           pos += count;
>                 > > -           buf += count / 4;
>                 > > -           size -= count;
>                 > > -   }
>                 > > -#endif
>                 > > -
>                 > > spin_lock_irqsave(&adev->mmio_idx_lock, flags);
>                 > >      for (last = pos + size; pos < last; pos += 4) {
>                 > > uint32_t tmp = pos >> 31;
>                 _______________________________________________
>                 amd-gfx mailing list
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=0
>
>             Am 14.04.2020 16:35 schrieb "Deucher, Alexander"
>             <Alexander.Deucher@amd.com
>             <mailto:Alexander.Deucher@amd.com>>:
>
>                 [AMD Public Use]
>
>                 If this causes an issue, any access to vram via the
>                 BAR could cause an issue.
>
>                 Alex
>
>                 ------------------------------------------------------------------------
>
>                 *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>                 <mailto:amd-gfx-bounces@lists.freedesktop.org>> on
>                 behalf of Russell, Kent <Kent.Russell@amd.com
>                 <mailto:Kent.Russell@amd.com>>
>                 *Sent:* Tuesday, April 14, 2020 10:19 AM
>                 *To:* Koenig, Christian <Christian.Koenig@amd.com
>                 <mailto:Christian.Koenig@amd.com>>;
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 <amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>>
>                 *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com
>                 <mailto:Felix.Kuehling@amd.com>>; Kim, Jonathan
>                 <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
>                 *Subject:* RE: [PATCH] Revert "drm/amdgpu: use the BAR
>                 if possible in amdgpu_device_vram_access v2"
>
>                 [AMD Official Use Only - Internal Distribution Only]
>
>                 On VG20 or MI100, as soon as we run the subtest, we
>                 get the dmesg output below, and then the kernel ends
>                 up hanging. I don't know enough about the test itself
>                 to know why this is occurring, but Jon Kim and Felix
>                 were discussing it on a separate thread when the issue
>                 was first reported, so they can hopefully provide some
>                 additional information.
>
>                  Kent
>
>                 > -----Original Message-----
>                 > From: Christian König
>                 <ckoenig.leichtzumerken@gmail.com
>                 <mailto:ckoenig.leichtzumerken@gmail.com>>
>                 > Sent: Tuesday, April 14, 2020 9:52 AM
>                 > To: Russell, Kent <Kent.Russell@amd.com
>                 <mailto:Kent.Russell@amd.com>>;
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 > Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR
>                 if possible in
>                 > amdgpu_device_vram_access v2"
>                 >
>                 > Am 13.04.20 um 20:20 schrieb Kent Russell:
>                 > > This reverts commit
>                 c12b84d6e0d70f1185e6daddfd12afb671791b6e.
>                 > > The original patch causes a RAS event and
>                 subsequent kernel hard-hang
>                 > > when running the
>                 KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
>                 > > Arcturus
>                 > >
>                 > > dmesg output at hang time:
>                 > > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT
>                 detected!
>                 > > amdgpu 0000:67:00.0: GPU reset begin!
>                 > > Evicting PASID 0x8000 queues
>                 > > Started evicting pasid 0x8000
>                 > > qcm fence wait loop timeout expired
>                 > > The cp might be in an unrecoverable state due to
>                 an unsuccessful
>                 > > queues preemption Failed to evict process queues
>                 Failed to suspend
>                 > > process 0x8000 Finished evicting pasid 0x8000
>                 Started restoring pasid
>                 > > 0x8000 Finished restoring pasid 0x8000 [drm] UVD
>                 VCPU state may lost
>                 > > due to RAS ERREVENT_ATHUB_INTERRUPT
>                 > > amdgpu: [powerplay] Failed to send message 0x26,
>                 response 0x0
>                 > > amdgpu: [powerplay] Failed to set soft min gfxclk !
>                 > > amdgpu: [powerplay] Failed to upload DPM Bootup
>                 Levels!
>                 > > amdgpu: [powerplay] Failed to send message 0x7,
>                 response 0x0
>                 > > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed
>                 to disable all smu
>                 > features!
>                 > > amdgpu: [powerplay] [DisableDpmTasks] Failed to
>                 disable all smu features!
>                 > > amdgpu: [powerplay] [PowerOffAsic] Failed to
>                 disable DPM!
>                 > > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]]
>                 *ERROR* suspend of IP
>                 > > block <powerplay> failed -5
>                 >
>                 > Do you have more information on what's going wrong
>                 here since this is a really
>                 > important patch for KFD debugging.
>                 >
>                 > >
>                 > > Signed-off-by: Kent Russell <kent.russell@amd.com
>                 <mailto:kent.russell@amd.com>>
>                 >
>                 > Reviewed-by: Christian König
>                 <christian.koenig@amd.com
>                 <mailto:christian.koenig@amd.com>>
>                 >
>                 > > ---
>                 > > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>                 ----------------------
>                 > >   1 file changed, 26 deletions(-)
>                 > >
>                 > > diff --git
>                 a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > index cf5d6e585634..a3f997f84020 100644
>                 > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > @@ -254,32 +254,6 @@ void
>                 amdgpu_device_vram_access(struct
>                 > amdgpu_device *adev, loff_t pos,
>                 > >      uint32_t hi = ~0;
>                 > >      uint64_t last;
>                 > >
>                 > > -
>                 > > -#ifdef CONFIG_64BIT
>                 > > -   last = min(pos + size,
>                 adev->gmc.visible_vram_size);
>                 > > -   if (last > pos) {
>                 > > -           void __iomem *addr =
>                 adev->mman.aper_base_kaddr + pos;
>                 > > -           size_t count = last - pos;
>                 > > -
>                 > > -           if (write) {
>                 > > - memcpy_toio(addr, buf, count);
>                 > > - mb();
>                 > > - amdgpu_asic_flush_hdp(adev, NULL);
>                 > > -           } else {
>                 > > - amdgpu_asic_invalidate_hdp(adev, NULL);
>                 > > - mb();
>                 > > - memcpy_fromio(buf, addr, count);
>                 > > -           }
>                 > > -
>                 > > -           if (count == size)
>                 > > - return;
>                 > > -
>                 > > -           pos += count;
>                 > > -           buf += count / 4;
>                 > > -           size -= count;
>                 > > -   }
>                 > > -#endif
>                 > > -
>                 > > spin_lock_irqsave(&adev->mmio_idx_lock, flags);
>                 > >      for (last = pos + size; pos < last; pos += 4) {
>                 > > uint32_t tmp = pos >> 31;
>                 _______________________________________________
>                 amd-gfx mailing list
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=0
>
>             Am 14.04.2020 16:35 schrieb "Deucher, Alexander"
>             <Alexander.Deucher@amd.com
>             <mailto:Alexander.Deucher@amd.com>>:
>
>                 [AMD Public Use]
>
>                 If this causes an issue, any access to vram via the
>                 BAR could cause an issue.
>
>                 Alex
>
>                 ------------------------------------------------------------------------
>
>                 *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>                 <mailto:amd-gfx-bounces@lists.freedesktop.org>> on
>                 behalf of Russell, Kent <Kent.Russell@amd.com
>                 <mailto:Kent.Russell@amd.com>>
>                 *Sent:* Tuesday, April 14, 2020 10:19 AM
>                 *To:* Koenig, Christian <Christian.Koenig@amd.com
>                 <mailto:Christian.Koenig@amd.com>>;
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 <amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>>
>                 *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com
>                 <mailto:Felix.Kuehling@amd.com>>; Kim, Jonathan
>                 <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
>                 *Subject:* RE: [PATCH] Revert "drm/amdgpu: use the BAR
>                 if possible in amdgpu_device_vram_access v2"
>
>                 [AMD Official Use Only - Internal Distribution Only]
>
>                 On VG20 or MI100, as soon as we run the subtest, we
>                 get the dmesg output below, and then the kernel ends
>                 up hanging. I don't know enough about the test itself
>                 to know why this is occurring, but Jon Kim and Felix
>                 were discussing it on a separate thread when the issue
>                 was first reported, so they can hopefully provide some
>                 additional information.
>
>                  Kent
>
>                 > -----Original Message-----
>                 > From: Christian König
>                 <ckoenig.leichtzumerken@gmail.com
>                 <mailto:ckoenig.leichtzumerken@gmail.com>>
>                 > Sent: Tuesday, April 14, 2020 9:52 AM
>                 > To: Russell, Kent <Kent.Russell@amd.com
>                 <mailto:Kent.Russell@amd.com>>;
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 > Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR
>                 if possible in
>                 > amdgpu_device_vram_access v2"
>                 >
>                 > Am 13.04.20 um 20:20 schrieb Kent Russell:
>                 > > This reverts commit
>                 c12b84d6e0d70f1185e6daddfd12afb671791b6e.
>                 > > The original patch causes a RAS event and
>                 subsequent kernel hard-hang
>                 > > when running the
>                 KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
>                 > > Arcturus
>                 > >
>                 > > dmesg output at hang time:
>                 > > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT
>                 detected!
>                 > > amdgpu 0000:67:00.0: GPU reset begin!
>                 > > Evicting PASID 0x8000 queues
>                 > > Started evicting pasid 0x8000
>                 > > qcm fence wait loop timeout expired
>                 > > The cp might be in an unrecoverable state due to
>                 an unsuccessful
>                 > > queues preemption Failed to evict process queues
>                 Failed to suspend
>                 > > process 0x8000 Finished evicting pasid 0x8000
>                 Started restoring pasid
>                 > > 0x8000 Finished restoring pasid 0x8000 [drm] UVD
>                 VCPU state may lost
>                 > > due to RAS ERREVENT_ATHUB_INTERRUPT
>                 > > amdgpu: [powerplay] Failed to send message 0x26,
>                 response 0x0
>                 > > amdgpu: [powerplay] Failed to set soft min gfxclk !
>                 > > amdgpu: [powerplay] Failed to upload DPM Bootup
>                 Levels!
>                 > > amdgpu: [powerplay] Failed to send message 0x7,
>                 response 0x0
>                 > > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed
>                 to disable all smu
>                 > features!
>                 > > amdgpu: [powerplay] [DisableDpmTasks] Failed to
>                 disable all smu features!
>                 > > amdgpu: [powerplay] [PowerOffAsic] Failed to
>                 disable DPM!
>                 > > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]]
>                 *ERROR* suspend of IP
>                 > > block <powerplay> failed -5
>                 >
>                 > Do you have more information on what's going wrong
>                 here since this is a really
>                 > important patch for KFD debugging.
>                 >
>                 > >
>                 > > Signed-off-by: Kent Russell <kent.russell@amd.com
>                 <mailto:kent.russell@amd.com>>
>                 >
>                 > Reviewed-by: Christian König
>                 <christian.koenig@amd.com
>                 <mailto:christian.koenig@amd.com>>
>                 >
>                 > > ---
>                 > > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>                 ----------------------
>                 > >   1 file changed, 26 deletions(-)
>                 > >
>                 > > diff --git
>                 a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > index cf5d6e585634..a3f997f84020 100644
>                 > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > @@ -254,32 +254,6 @@ void
>                 amdgpu_device_vram_access(struct
>                 > amdgpu_device *adev, loff_t pos,
>                 > >      uint32_t hi = ~0;
>                 > >      uint64_t last;
>                 > >
>                 > > -
>                 > > -#ifdef CONFIG_64BIT
>                 > > -   last = min(pos + size,
>                 adev->gmc.visible_vram_size);
>                 > > -   if (last > pos) {
>                 > > -           void __iomem *addr =
>                 adev->mman.aper_base_kaddr + pos;
>                 > > -           size_t count = last - pos;
>                 > > -
>                 > > -           if (write) {
>                 > > - memcpy_toio(addr, buf, count);
>                 > > - mb();
>                 > > - amdgpu_asic_flush_hdp(adev, NULL);
>                 > > -           } else {
>                 > > - amdgpu_asic_invalidate_hdp(adev, NULL);
>                 > > - mb();
>                 > > - memcpy_fromio(buf, addr, count);
>                 > > -           }
>                 > > -
>                 > > -           if (count == size)
>                 > > - return;
>                 > > -
>                 > > -           pos += count;
>                 > > -           buf += count / 4;
>                 > > -           size -= count;
>                 > > -   }
>                 > > -#endif
>                 > > -
>                 > > spin_lock_irqsave(&adev->mmio_idx_lock, flags);
>                 > >      for (last = pos + size; pos < last; pos += 4) {
>                 > >              uint32_t tmp = pos >> 31;
>                 _______________________________________________
>                 amd-gfx mailing list
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=0
>
>             Am 14.04.2020 16:35 schrieb "Deucher, Alexander"
>             <Alexander.Deucher@amd.com
>             <mailto:Alexander.Deucher@amd.com>>:
>
>                 [AMD Public Use]
>
>                 If this causes an issue, any access to vram via the
>                 BAR could cause an issue.
>
>                 Alex
>
>                 ------------------------------------------------------------------------
>
>                 *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>                 <mailto:amd-gfx-bounces@lists.freedesktop.org>> on
>                 behalf of Russell, Kent <Kent.Russell@amd.com
>                 <mailto:Kent.Russell@amd.com>>
>                 *Sent:* Tuesday, April 14, 2020 10:19 AM
>                 *To:* Koenig, Christian <Christian.Koenig@amd.com
>                 <mailto:Christian.Koenig@amd.com>>;
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 <amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>>
>                 *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com
>                 <mailto:Felix.Kuehling@amd.com>>; Kim, Jonathan
>                 <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
>                 *Subject:* RE: [PATCH] Revert "drm/amdgpu: use the BAR
>                 if possible in amdgpu_device_vram_access v2"
>
>                 [AMD Official Use Only - Internal Distribution Only]
>
>                 On VG20 or MI100, as soon as we run the subtest, we
>                 get the dmesg output below, and then the kernel ends
>                 up hanging. I don't know enough about the test itself
>                 to know why this is occurring, but Jon Kim and Felix
>                 were discussing it on a separate thread when the issue
>                 was first reported, so they can hopefully provide some
>                 additional information.
>
>                  Kent
>
>                 > -----Original Message-----
>                 > From: Christian König
>                 <ckoenig.leichtzumerken@gmail.com
>                 <mailto:ckoenig.leichtzumerken@gmail.com>>
>                 > Sent: Tuesday, April 14, 2020 9:52 AM
>                 > To: Russell, Kent <Kent.Russell@amd.com
>                 <mailto:Kent.Russell@amd.com>>;
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 > Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR
>                 if possible in
>                 > amdgpu_device_vram_access v2"
>                 >
>                 > Am 13.04.20 um 20:20 schrieb Kent Russell:
>                 > > This reverts commit
>                 c12b84d6e0d70f1185e6daddfd12afb671791b6e.
>                 > > The original patch causes a RAS event and
>                 subsequent kernel hard-hang
>                 > > when running the
>                 KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
>                 > > Arcturus
>                 > >
>                 > > dmesg output at hang time:
>                 > > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT
>                 detected!
>                 > > amdgpu 0000:67:00.0: GPU reset begin!
>                 > > Evicting PASID 0x8000 queues
>                 > > Started evicting pasid 0x8000
>                 > > qcm fence wait loop timeout expired
>                 > > The cp might be in an unrecoverable state due to
>                 an unsuccessful
>                 > > queues preemption Failed to evict process queues
>                 Failed to suspend
>                 > > process 0x8000 Finished evicting pasid 0x8000
>                 Started restoring pasid
>                 > > 0x8000 Finished restoring pasid 0x8000 [drm] UVD
>                 VCPU state may lost
>                 > > due to RAS ERREVENT_ATHUB_INTERRUPT
>                 > > amdgpu: [powerplay] Failed to send message 0x26,
>                 response 0x0
>                 > > amdgpu: [powerplay] Failed to set soft min gfxclk !
>                 > > amdgpu: [powerplay] Failed to upload DPM Bootup
>                 Levels!
>                 > > amdgpu: [powerplay] Failed to send message 0x7,
>                 response 0x0
>                 > > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed
>                 to disable all smu
>                 > features!
>                 > > amdgpu: [powerplay] [DisableDpmTasks] Failed to
>                 disable all smu features!
>                 > > amdgpu: [powerplay] [PowerOffAsic] Failed to
>                 disable DPM!
>                 > > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]]
>                 *ERROR* suspend of IP
>                 > > block <powerplay> failed -5
>                 >
>                 > Do you have more information on what's going wrong
>                 here since this is a really
>                 > important patch for KFD debugging.
>                 >
>                 > >
>                 > > Signed-off-by: Kent Russell <kent.russell@amd.com
>                 <mailto:kent.russell@amd.com>>
>                 >
>                 > Reviewed-by: Christian König
>                 <christian.koenig@amd.com
>                 <mailto:christian.koenig@amd.com>>
>                 >
>                 > > ---
>                 > > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>                 ----------------------
>                 > >   1 file changed, 26 deletions(-)
>                 > >
>                 > > diff --git
>                 a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > index cf5d6e585634..a3f997f84020 100644
>                 > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>                 > > @@ -254,32 +254,6 @@ void
>                 amdgpu_device_vram_access(struct
>                 > amdgpu_device *adev, loff_t pos,
>                 > >      uint32_t hi = ~0;
>                 > >      uint64_t last;
>                 > >
>                 > > -
>                 > > -#ifdef CONFIG_64BIT
>                 > > -   last = min(pos + size,
>                 adev->gmc.visible_vram_size);
>                 > > -   if (last > pos) {
>                 > > -           void __iomem *addr =
>                 adev->mman.aper_base_kaddr + pos;
>                 > > -           size_t count = last - pos;
>                 > > -
>                 > > -           if (write) {
>                 > > - memcpy_toio(addr, buf, count);
>                 > > - mb();
>                 > > - amdgpu_asic_flush_hdp(adev, NULL);
>                 > > -           } else {
>                 > > - amdgpu_asic_invalidate_hdp(adev, NULL);
>                 > > - mb();
>                 > > - memcpy_fromio(buf, addr, count);
>                 > > -           }
>                 > > -
>                 > > -           if (count == size)
>                 > > - return;
>                 > > -
>                 > > -           pos += count;
>                 > > -           buf += count / 4;
>                 > > -           size -= count;
>                 > > -   }
>                 > > -#endif
>                 > > -
>                 > > spin_lock_irqsave(&adev->mmio_idx_lock, flags);
>                 > >      for (last = pos + size; pos < last; pos += 4) {
>                 > >              uint32_t tmp = pos >> 31;
>                 _______________________________________________
>                 amd-gfx mailing list
>                 amd-gfx@lists.freedesktop.org
>                 <mailto:amd-gfx@lists.freedesktop.org>
>                 https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=0
>
>             Am 14.04.2020 16:35 schrieb "Deucher, Alexander"
>             <Alexander.Deucher@amd.com
>             <mailto:Alexander.Deucher@amd.com>>:
>
>             [AMD Public Use]
>
>             If this causes an issue, any access to vram via the BAR
>             could cause an issue.
>
>             Alex
>
>             ------------------------------------------------------------------------
>
>             *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>             <mailto:amd-gfx-bounces@lists.freedesktop.org>> on behalf
>             of Russell, Kent <Kent.Russell@amd.com
>             <mailto:Kent.Russell@amd.com>>
>             *Sent:* Tuesday, April 14, 2020 10:19 AM
>             *To:* Koenig, Christian <Christian.Koenig@amd.com
>             <mailto:Christian.Koenig@amd.com>>;
>             amd-gfx@lists.freedesktop.org
>             <mailto:amd-gfx@lists.freedesktop.org>
>             <amd-gfx@lists.freedesktop.org
>             <mailto:amd-gfx@lists.freedesktop.org>>
>             *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com
>             <mailto:Felix.Kuehling@amd.com>>; Kim, Jonathan
>             <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
>             *Subject:* RE: [PATCH] Revert "drm/amdgpu: use the BAR if
>             possible in amdgpu_device_vram_access v2"
>
>             [AMD Official Use Only - Internal Distribution Only]
>
>             On VG20 or MI100, as soon as we run the subtest, we get
>             the dmesg output below, and then the kernel ends up
>             hanging. I don't know enough about the test itself to know
>             why this is occurring, but Jon Kim and Felix were
>             discussing it on a separate thread when the issue was
>             first reported, so they can hopefully provide some
>             additional information.
>
>              Kent
>
>             > -----Original Message-----
>             > From: Christian König <ckoenig.leichtzumerken@gmail.com
>             <mailto:ckoenig.leichtzumerken@gmail.com>>
>             > Sent: Tuesday, April 14, 2020 9:52 AM
>             > To: Russell, Kent <Kent.Russell@amd.com
>             <mailto:Kent.Russell@amd.com>>;
>             amd-gfx@lists.freedesktop.org
>             <mailto:amd-gfx@lists.freedesktop.org>
>             > Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if
>             possible in
>             > amdgpu_device_vram_access v2"
>             >
>             > Am 13.04.20 um 20:20 schrieb Kent Russell:
>             > > This reverts commit
>             c12b84d6e0d70f1185e6daddfd12afb671791b6e.
>             > > The original patch causes a RAS event and subsequent
>             kernel hard-hang
>             > > when running the
>             KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
>             > > Arcturus
>             > >
>             > > dmesg output at hang time:
>             > > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
>             > > amdgpu 0000:67:00.0: GPU reset begin!
>             > > Evicting PASID 0x8000 queues
>             > > Started evicting pasid 0x8000
>             > > qcm fence wait loop timeout expired
>             > > The cp might be in an unrecoverable state due to an
>             unsuccessful
>             > > queues preemption Failed to evict process queues
>             Failed to suspend
>             > > process 0x8000 Finished evicting pasid 0x8000 Started
>             restoring pasid
>             > > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU
>             state may lost
>             > > due to RAS ERREVENT_ATHUB_INTERRUPT
>             > > amdgpu: [powerplay] Failed to send message 0x26,
>             response 0x0
>             > > amdgpu: [powerplay] Failed to set soft min gfxclk !
>             > > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
>             > > amdgpu: [powerplay] Failed to send message 0x7,
>             response 0x0
>             > > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to
>             disable all smu
>             > features!
>             > > amdgpu: [powerplay] [DisableDpmTasks] Failed to
>             disable all smu features!
>             > > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
>             > > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR*
>             suspend of IP
>             > > block <powerplay> failed -5
>             >
>             > Do you have more information on what's going wrong here
>             since this is a really
>             > important patch for KFD debugging.
>             >
>             > >
>             > > Signed-off-by: Kent Russell <kent.russell@amd.com
>             <mailto:kent.russell@amd.com>>
>             >
>             > Reviewed-by: Christian König <christian.koenig@amd.com
>             <mailto:christian.koenig@amd.com>>
>             >
>             > > ---
>             > > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>             ----------------------
>             > >   1 file changed, 26 deletions(-)
>             > >
>             > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             > > index cf5d6e585634..a3f997f84020 100644
>             > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             > > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
>             > amdgpu_device *adev, loff_t pos,
>             > >      uint32_t hi = ~0;
>             > >      uint64_t last;
>             > >
>             > > -
>             > > -#ifdef CONFIG_64BIT
>             > > -   last = min(pos + size, adev->gmc.visible_vram_size);
>             > > -   if (last > pos) {
>             > > -           void __iomem *addr =
>             adev->mman.aper_base_kaddr + pos;
>             > > -           size_t count = last - pos;
>             > > -
>             > > -           if (write) {
>             > > - memcpy_toio(addr, buf, count);
>             > > -                   mb();
>             > > - amdgpu_asic_flush_hdp(adev, NULL);
>             > > -           } else {
>             > > - amdgpu_asic_invalidate_hdp(adev, NULL);
>             > > -                   mb();
>             > > - memcpy_fromio(buf, addr, count);
>             > > -           }
>             > > -
>             > > -           if (count == size)
>             > > -                   return;
>             > > -
>             > > -           pos += count;
>             > > -           buf += count / 4;
>             > > -           size -= count;
>             > > -   }
>             > > -#endif
>             > > -
>             > > spin_lock_irqsave(&adev->mmio_idx_lock, flags);
>             > >      for (last = pos + size; pos < last; pos += 4) {
>             > >              uint32_t tmp = pos >> 31;
>             _______________________________________________
>             amd-gfx mailing list
>             amd-gfx@lists.freedesktop.org
>             <mailto:amd-gfx@lists.freedesktop.org>
>             https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=0
>


--------------C11D4B19F8344DD689278FD9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Why do you think that 3efed000 and
      befed000 are misaligned addresses?<br>
      <br>
      And see amdgpu_ttm_access_memory(), misaligned accesses are always
      routed to the MM path.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 16.04.20 um 18:08 schrieb Kim, Jonathan:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB45181F2428A410E2DD157DE085D80@MN2PR12MB4518.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style><!--
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
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.xmsipheader4d0fcdd7, li.xmsipheader4d0fcdd7, div.xmsipheader4d0fcdd7
	{mso-style-name:x_msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.xmsipheader87abd423, li.xmsipheader87abd423, div.xmsipheader87abd423
	{mso-style-name:x_msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle23
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheader4d0fcdd7" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Hi Felix,<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">You’re probably right.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Passing Vega20 system:<o:p></o:p></p>
        <p class="MsoNormal">[&nbsp;&nbsp; 56.683273] amdgpu: [vram dbg]
          addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3e7ffff8, val&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deadbeef<o:p></o:p></p>
        <p class="MsoNormal">[&nbsp;&nbsp; 56.683349] amdgpu: [vram dbg]
          addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3efed000, val&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cafebabe &lt;- potential
          misalign access<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Failing Vega20 system:<o:p></o:p></p>
        <p class="MsoNormal">[Apr16 12:00] amdgpu: [vram dbg]
          addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; be7ffff8, val&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deadbeef<o:p></o:p></p>
        <p class="MsoNormal">[&nbsp; &#43;0.000082] amdgpu: [vram dbg]
          addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; befed000, val&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ffffffff &lt;- potential
          misalign access<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Thanks,<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Jon<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Kuehling, Felix
              <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a> <br>
              <b>Sent:</b> Wednesday, April 15, 2020 11:02 AM<br>
              <b>To:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Kim, Jonathan
              <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a>; Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
              <b>Cc:</b> Russell, Kent <a class="moz-txt-link-rfc2396E" href="mailto:Kent.Russell@amd.com">&lt;Kent.Russell@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the
              BAR if possible in amdgpu_device_vram_access v2&quot;<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]<o:p></o:p></span></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black">The test does not
                access outside of the allocated memory. But it
                deliberately crosses a boundary where memory can be
                allocated non-contiguously. This is meant to catch
                problems where the access function doesn't handle
                non-contiguous VRAM allocations correctly. However, the
                way that VRAM allocation has been optimized, I expect
                that most allocations are contiguous nowadays. However,
                the more interesting aspect of the test is, that it
                performs misaligned memory accesses. The MMIO method of
                accessing VRAM explicitly handles misaligned accesses
                and breaks them down into dword aligned accesses with
                proper masking and shifting.<o:p></o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black">Could the unaligned
                nature of the memory access have something to do with
                hitting RAS errors? That's something unique to this test
                that we wouldn't see on a normal page table update or
                memory eviction.<o:p></o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black">Regards,<br>
                &nbsp; Felix<o:p></o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
          </div>
          <div class="MsoNormal" style="text-align:center" align="center">
            <hr width="98%" size="2" align="center">
          </div>
          <div id="divRplyFwdMsg">
            <p class="MsoNormal"><b><span style="color:black">From:</span></b><span style="color:black"> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;<br>
                <b>Sent:</b> Wednesday, April 15, 2020 6:58 AM<br>
                <b>To:</b> Kim, Jonathan &lt;<a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">Jonathan.Kim@amd.com</a>&gt;;
                Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;<br>
                <b>Cc:</b> Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;;
                <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                <b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the
                BAR if possible in amdgpu_device_vram_access v2&quot;</span>
              <o:p></o:p></p>
            <div>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            </div>
          </div>
          <div>
            <div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="xmsonormal" style="background:white">To
                  elaborate on the PTRACE test, we PEEK 2 DWORDs inside
                  thunk allocated mapped memory and 2 DWORDS outside
                  that boundary (it’s only about 4MB to the boundary).&nbsp;
                  Then we POKE to swap the DWORD positions across the
                  boundary.&nbsp; The RAS event on the single failing machine
                  happens on the out of boundary PEEK.<o:p></o:p></p>
              </blockquote>
              <p class="MsoNormal" style="background:white"><span style="color:black"><br>
                  Well when you access outside of an allocated buffer I
                  would expect that we never get as far as even touching
                  the hardware because the kernel should block the
                  access with an -EPERM or -EFAULT. So sounds like I'm
                  not understanding something correctly here.<br>
                  <br>
                  Apart from that I completely agree that we need to
                  sort out any other RAS event first to make sure that
                  the system is simply not failing randomly.<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  Am 15.04.20 um 11:49 schrieb Kim, Jonathan:</span><o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <div>
                <p class="xmsipheader87abd423" style="margin:0in;margin-bottom:.0001pt;background:white">
                  <span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
                    Public Use]</span><o:p></o:p></p>
                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                <p class="xmsonormal" style="background:white">Hi
                  Christian,<o:p></o:p></p>
                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                <p class="xmsonormal" style="background:white">That
                  could potentially be it. &nbsp;With additional testing, 2
                  of 3 Vega20 machines never hit error over BAR access
                  with the PTRACE test.&nbsp; 3 of 3 machines (from the same
                  pool) always hit error with CWSR.<o:p></o:p></p>
                <p class="xmsonormal" style="background:white">To
                  elaborate on the PTRACE test, we PEEK 2 DWORDs inside
                  thunk allocated mapped memory and 2 DWORDS outside
                  that boundary (it’s only about 4MB to the boundary).&nbsp;
                  Then we POKE to swap the DWORD positions across the
                  boundary.&nbsp; The RAS event on the single failing machine
                  happens on the out of boundary PEEK.<o:p></o:p></p>
                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                <p class="xmsonormal" style="background:white">Felix
                  mentioned we don’t hit errors over general HDP access
                  but that may not true.&nbsp; An Arcturus failure sys logs
                  posted (which wasn’t tested by me) shows someone
                  launched rocm bandwidth test, hit a VM fault and a RAS
                  event ensued during evictions (I can point the
                  internal ticket or log snippet offline if
                  interested).&nbsp; Whether the RAS event is BAR access
                  triggered or the result of HW instability is beyond me
                  since I don’t have access to the machine.<o:p></o:p></p>
                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                <p class="xmsonormal" style="background:white">Thanks,<o:p></o:p></p>
                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                <p class="xmsonormal" style="background:white">Jon<o:p></o:p></p>
                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="xmsonormal" style="background:white"><b>From:</b>
                      Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                        &lt;Christian.Koenig@amd.com&gt;</a> <br>
                      <b>Sent:</b> Wednesday, April 15, 2020 4:11 AM<br>
                      <b>To:</b> Kim, Jonathan <a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">&lt;Jonathan.Kim@amd.com&gt;</a>;
                      Kuehling, Felix
                      <a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                      Deucher, Alexander
                      <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                      <b>Cc:</b> Russell, Kent <a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">&lt;Kent.Russell@amd.com&gt;</a>;
                      <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                      <b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu:
                      use the BAR if possible in
                      amdgpu_device_vram_access v2&quot;<o:p></o:p></p>
                  </div>
                </div>
                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                <div>
                  <p class="xmsonormal" style="margin-bottom:12.0pt;background:white">Hi
                    Jon,<o:p></o:p></p>
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p class="xmsonormal" style="background:white">Also
                      cwsr tests fail on Vega20 with or without the
                      revert with the same RAS error.<o:p></o:p></p>
                  </blockquote>
                  <p class="xmsonormal" style="background:white"><br>
                    That sounds like the system/setup has a more general
                    problem.<br>
                    <br>
                    Could it be that we are seeing RAS errors because
                    there really is some hardware failure, but with the
                    MM path we don't trigger a RAS interrupt?<br>
                    <br>
                    Thanks,<br>
                    Christian.<br>
                    <br>
                    Am 14.04.20 um 22:30 schrieb Kim, Jonathan:<o:p></o:p></p>
                </div>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p class="xmsipheader4d0fcdd7" style="margin:0in;margin-bottom:.0001pt;background:white">
                    <span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                      Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
                  <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                  <p class="xmsonormal" style="background:white">If
                    we’re passing the test on the revert, then the only
                    thing that’s different is we’re not invalidating HDP
                    and doing a copy to host anymore in
                    amdgpu_device_vram_access since the function is
                    still called in ttm access_memory with BAR.<o:p></o:p></p>
                  <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                  <p class="xmsonormal" style="background:white">Also
                    cwsr tests fail on Vega20 with or without the revert
                    with the same RAS error.<o:p></o:p></p>
                  <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                  <p class="xmsonormal" style="background:white">Thanks,<o:p></o:p></p>
                  <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                  <p class="xmsonormal" style="background:white">Jon<o:p></o:p></p>
                  <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                  <div>
                    <div style="border:none;border-top:solid #E1E1E1
                      1.0pt;padding:3.0pt 0in 0in 0in">
                      <p class="xmsonormal" style="background:white"><b>From:</b>
                        Kuehling, Felix <a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">
                          &lt;Felix.Kuehling@amd.com&gt;</a> <br>
                        <b>Sent:</b> Tuesday, April 14, 2020 2:32 PM<br>
                        <b>To:</b> Kim, Jonathan <a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">&lt;Jonathan.Kim@amd.com&gt;</a>;
                        Koenig, Christian
                        <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                        Deucher, Alexander
                        <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                        <b>Cc:</b> Russell, Kent <a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">&lt;Kent.Russell@amd.com&gt;</a>;
                        <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                        <b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu:
                        use the BAR if possible in
                        amdgpu_device_vram_access v2&quot;<o:p></o:p></p>
                    </div>
                  </div>
                  <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                  <p style="background:white"><span style="color:black">I
                      wouldn't call it premature. Revert is a usual
                      practice when there is a serious regression that
                      isn't fully understood or root-caused. As far as I
                      can tell, the problem has been reproduced on
                      multiple systems, different GPUs, and clearly
                      regressed to Christian's commit. I think that
                      justifies reverting it for now.</span><o:p></o:p></p>
                  <p style="background:white"><span style="color:black">I
                      agree with Christian that a general HDP memory
                      access problem causing RAS errors would
                      potentially cause problems in other tests as well.
                      For example common operations like GART table
                      updates, and GPUVM page table updates and PCIe
                      peer2peer accesses in ROCm applications use HDP.
                      But we're not seeing obvious problems from those.
                      So we need to understand what's special about this
                      test. I asked questions to that effect on our
                      other email thread.</span><o:p></o:p></p>
                  <p style="background:white"><span style="color:black">Regards,<br>
                      &nbsp; Felix</span><o:p></o:p></p>
                  <div>
                    <p class="xmsonormal" style="background:white">Am
                      2020-04-14 um 10:51 a.m. schrieb Kim, Jonathan:<o:p></o:p></p>
                  </div>
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p class="xmsipheader4d0fcdd7" style="margin:0in;margin-bottom:.0001pt;background:white">
                      <span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                        Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
                    <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                    <p class="xmsonormal" style="background:white">I
                      think it’s premature to push this revert.<o:p></o:p></p>
                    <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                    <p class="xmsonormal" style="background:white">With
                      more testing, I’m getting failures from different
                      tests or sometimes none at all on my machine.<o:p></o:p></p>
                    <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                    <p class="xmsonormal" style="background:white">Kent,
                      let’s continue the discussion on the original
                      thread.<o:p></o:p></p>
                    <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                    <p class="xmsonormal" style="background:white">Thanks,<o:p></o:p></p>
                    <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                    <p class="xmsonormal" style="background:white">Jon<o:p></o:p></p>
                    <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                    <div>
                      <div style="border:none;border-top:solid #E1E1E1
                        1.0pt;padding:3.0pt 0in 0in 0in">
                        <p class="xmsonormal" style="background:white"><b>From:</b>
                          Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                            &lt;Christian.Koenig@amd.com&gt;</a> <br>
                          <b>Sent:</b> Tuesday, April 14, 2020 10:47 AM<br>
                          <b>To:</b> Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                          <b>Cc:</b> Russell, Kent <a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">&lt;Kent.Russell@amd.com&gt;</a>;
                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                          Kuehling, Felix
                          <a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                          Kim, Jonathan
                          <a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">&lt;Jonathan.Kim@amd.com&gt;</a><br>
                          <b>Subject:</b> Re: [PATCH] Revert
                          &quot;drm/amdgpu: use the BAR if possible in
                          amdgpu_device_vram_access v2&quot;<o:p></o:p></p>
                      </div>
                    </div>
                    <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                    <div>
                      <div>
                        <div>
                          <div>
                            <div>
                              <p class="xmsonormal" style="background:white">That's exactly
                                my concern as well.
                                <o:p></o:p></p>
                              <div>
                                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                              </div>
                              <div>
                                <p class="xmsonormal" style="background:white">This looks a
                                  bit like the test creates erroneous
                                  data somehow, but there doesn't seems
                                  to be a RAS check in the MM data path.<o:p></o:p></p>
                              </div>
                              <div>
                                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                              </div>
                              <div>
                                <p class="xmsonormal" style="background:white">And now that
                                  we use the BAR path it goes up in
                                  flames.<o:p></o:p></p>
                              </div>
                              <div>
                                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                              </div>
                              <div>
                                <p class="xmsonormal" style="background:white">I just don't
                                  see how we can create erroneous data
                                  in a test case?<o:p></o:p></p>
                              </div>
                              <div>
                                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                              </div>
                              <div>
                                <p class="xmsonormal" style="background:white">Christian.<o:p></o:p></p>
                              </div>
                            </div>
                            <div>
                              <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                              <div>
                                <p class="xmsonormal" style="background:white">Am 14.04.2020
                                  16:35 schrieb &quot;Deucher, Alexander&quot;
                                  &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
                                <blockquote style="border:none;border-left:solid
                                  #CCCCCC 1.0pt;padding:0in 0in 0in
6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-bottom:5.0pt">
                                  <div>
                                    <p style="margin:15.0pt;background:white"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
                                        Public Use]</span><o:p></o:p></p>
                                    <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                                    <div>
                                      <div>
                                        <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">If
                                            this causes an issue, any
                                            access to vram via the BAR
                                            could cause an issue.</span><o:p></o:p></p>
                                      </div>
                                      <div>
                                        <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">&nbsp;</span><o:p></o:p></p>
                                      </div>
                                      <div>
                                        <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">Alex</span><o:p></o:p></p>
                                      </div>
                                      <div class="MsoNormal" style="text-align:center;background:white" align="center">
                                        <span style="color:black">
                                          <hr width="98%" size="2" align="center">
                                        </span></div>
                                      <div>
                                        <p class="xmsonormal" style="background:white"><b>From:</b>
                                          amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                                          on behalf of Russell, Kent
                                          &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;<br>
                                          <b>Sent:</b> Tuesday, April
                                          14, 2020 10:19 AM<br>
                                          <b>To:</b> Koenig, Christian
                                          &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                                          &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                                          <b>Cc:</b> Kuehling, Felix
                                          &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                                          Kim, Jonathan &lt;<a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">Jonathan.Kim@amd.com</a>&gt;<br>
                                          <b>Subject:</b> RE: [PATCH]
                                          Revert &quot;drm/amdgpu: use the
                                          BAR if possible in
                                          amdgpu_device_vram_access v2&quot;
                                          <o:p></o:p></p>
                                        <div>
                                          <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                                        </div>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="xmsonormal" style="background:white">[AMD
                                            Official Use Only - Internal
                                            Distribution Only]<br>
                                            <br>
                                            On VG20 or MI100, as soon as
                                            we run the subtest, we get
                                            the dmesg output below, and
                                            then the kernel ends up
                                            hanging. I don't know enough
                                            about the test itself to
                                            know why this is occurring,
                                            but Jon Kim and Felix were
                                            discussing it on a separate
                                            thread when the issue was
                                            first reported, so they can
                                            hopefully provide some
                                            additional information.<br>
                                            <br>
                                            &nbsp;Kent<br>
                                            <br>
                                            &gt; -----Original
                                            Message-----<br>
                                            &gt; From: Christian König
                                            &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                                            &gt; Sent: Tuesday, April
                                            14, 2020 9:52 AM<br>
                                            &gt; To: Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;;
                                            <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                                            &gt; Subject: Re: [PATCH]
                                            Revert &quot;drm/amdgpu: use the
                                            BAR if possible in<br>
                                            &gt;
                                            amdgpu_device_vram_access
                                            v2&quot;<br>
                                            &gt; <br>
                                            &gt; Am 13.04.20 um 20:20
                                            schrieb Kent Russell:<br>
                                            &gt; &gt; This reverts
                                            commit
                                            c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
                                            &gt; &gt; The original patch
                                            causes a RAS event and
                                            subsequent kernel hard-hang<br>
                                            &gt; &gt; when running the
                                            KFDMemoryTest.PtraceAccessInvisibleVram
                                            on VG20 and<br>
                                            &gt; &gt; Arcturus<br>
                                            &gt; &gt;<br>
                                            &gt; &gt; dmesg output at
                                            hang time:<br>
                                            &gt; &gt; [drm] RAS event of
                                            type
                                            ERREVENT_ATHUB_INTERRUPT
                                            detected!<br>
                                            &gt; &gt; amdgpu
                                            0000:67:00.0: GPU reset
                                            begin!<br>
                                            &gt; &gt; Evicting PASID
                                            0x8000 queues<br>
                                            &gt; &gt; Started evicting
                                            pasid 0x8000<br>
                                            &gt; &gt; qcm fence wait
                                            loop timeout expired<br>
                                            &gt; &gt; The cp might be in
                                            an unrecoverable state due
                                            to an unsuccessful<br>
                                            &gt; &gt; queues preemption
                                            Failed to evict process
                                            queues Failed to suspend<br>
                                            &gt; &gt; process 0x8000
                                            Finished evicting pasid
                                            0x8000 Started restoring
                                            pasid<br>
                                            &gt; &gt; 0x8000 Finished
                                            restoring pasid 0x8000 [drm]
                                            UVD VCPU state may lost<br>
                                            &gt; &gt; due to RAS
                                            ERREVENT_ATHUB_INTERRUPT<br>
                                            &gt; &gt; amdgpu:
                                            [powerplay] Failed to send
                                            message 0x26, response 0x0<br>
                                            &gt; &gt; amdgpu:
                                            [powerplay] Failed to set
                                            soft min gfxclk !<br>
                                            &gt; &gt; amdgpu:
                                            [powerplay] Failed to upload
                                            DPM Bootup Levels!<br>
                                            &gt; &gt; amdgpu:
                                            [powerplay] Failed to send
                                            message 0x7, response 0x0<br>
                                            &gt; &gt; amdgpu:
                                            [powerplay]
                                            [DisableAllSMUFeatures]
                                            Failed to disable all smu<br>
                                            &gt; features!<br>
                                            &gt; &gt; amdgpu:
                                            [powerplay]
                                            [DisableDpmTasks] Failed to
                                            disable all smu features!<br>
                                            &gt; &gt; amdgpu:
                                            [powerplay] [PowerOffAsic]
                                            Failed to disable DPM!<br>
                                            &gt; &gt;
                                            [drm:amdgpu_device_ip_suspend_phase2
                                            [amdgpu]] *ERROR* suspend of
                                            IP<br>
                                            &gt; &gt; block
                                            &lt;powerplay&gt; failed -5<br>
                                            &gt; <br>
                                            &gt; Do you have more
                                            information on what's going
                                            wrong here since this is a
                                            really<br>
                                            &gt; important patch for KFD
                                            debugging.<br>
                                            &gt; <br>
                                            &gt; &gt;<br>
                                            &gt; &gt; Signed-off-by:
                                            Kent Russell &lt;<a href="mailto:kent.russell@amd.com" moz-do-not-send="true">kent.russell@amd.com</a>&gt;<br>
                                            &gt; <br>
                                            &gt; Reviewed-by: Christian
                                            König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                                            &gt; <br>
                                            &gt; &gt; ---<br>
                                            &gt; &gt;&nbsp;&nbsp;
                                            drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                                            | 26 ----------------------<br>
                                            &gt; &gt;&nbsp;&nbsp; 1 file changed,
                                            26 deletions(-)<br>
                                            &gt; &gt;<br>
                                            &gt; &gt; diff --git
                                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                            &gt; &gt;
                                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                            &gt; &gt; index
                                            cf5d6e585634..a3f997f84020
                                            100644<br>
                                            &gt; &gt; ---
                                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                            &gt; &gt; &#43;&#43;&#43;
                                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                            &gt; &gt; @@ -254,32 &#43;254,6
                                            @@ void
                                            amdgpu_device_vram_access(struct<br>
                                            &gt; amdgpu_device *adev,
                                            loff_t pos,<br>
                                            &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =
                                            ~0;<br>
                                            &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t
                                            last;<br>
                                            &gt; &gt;<br>
                                            &gt; &gt; -<br>
                                            &gt; &gt; -#ifdef
                                            CONFIG_64BIT<br>
                                            &gt; &gt; -&nbsp;&nbsp; last = min(pos
                                            &#43; size,
                                            adev-&gt;gmc.visible_vram_size);<br>
                                            &gt; &gt; -&nbsp;&nbsp; if (last &gt;
                                            pos) {<br>
                                            &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void
                                            __iomem *addr =
                                            adev-&gt;mman.aper_base_kaddr
                                            &#43; pos;<br>
                                            &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t
                                            count = last - pos;<br>
                                            &gt; &gt; -<br>
                                            &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                                            (write) {<br>
                                            &gt; &gt;
                                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            memcpy_toio(addr, buf,
                                            count);<br>
                                            &gt; &gt;
                                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
                                            &gt; &gt;
                                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            amdgpu_asic_flush_hdp(adev,
                                            NULL);<br>
                                            &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else
                                            {<br>
                                            &gt; &gt;
                                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            amdgpu_asic_invalidate_hdp(adev,
                                            NULL);<br>
                                            &gt; &gt;
                                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
                                            &gt; &gt;
                                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            memcpy_fromio(buf, addr,
                                            count);<br>
                                            &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                                            &gt; &gt; -<br>
                                            &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                                            (count == size)<br>
                                            &gt; &gt;
                                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
                                            &gt; &gt; -<br>
                                            &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos &#43;=
                                            count;<br>
                                            &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf &#43;=
                                            count / 4;<br>
                                            &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size
                                            -= count;<br>
                                            &gt; &gt; -&nbsp;&nbsp; }<br>
                                            &gt; &gt; -#endif<br>
                                            &gt; &gt; -<br>
                                            &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock,
                                            flags);<br>
                                            &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =
                                            pos &#43; size; pos &lt; last;
                                            pos &#43;= 4) {<br>
                                            &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            uint32_t tmp = pos &gt;&gt;
                                            31;<br>
_______________________________________________<br>
                                            amd-gfx mailing list<br>
                                            <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                                            <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0</a><o:p></o:p></p>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </blockquote>
                              </div>
                              <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                            </div>
                          </div>
                          <div>
                            <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                            <div>
                              <p class="xmsonormal" style="background:white">Am 14.04.2020
                                16:35 schrieb &quot;Deucher, Alexander&quot; &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
                              <blockquote style="border:none;border-left:solid
                                #CCCCCC 1.0pt;padding:0in 0in 0in
6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-bottom:5.0pt">
                                <div>
                                  <p style="margin:15.0pt;background:white"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
                                      Public Use]</span><o:p></o:p></p>
                                  <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                                  <div>
                                    <div>
                                      <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">If
                                          this causes an issue, any
                                          access to vram via the BAR
                                          could cause an issue.</span><o:p></o:p></p>
                                    </div>
                                    <div>
                                      <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">&nbsp;</span><o:p></o:p></p>
                                    </div>
                                    <div>
                                      <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">Alex</span><o:p></o:p></p>
                                    </div>
                                    <div class="MsoNormal" style="text-align:center;background:white" align="center">
                                      <span style="color:black">
                                        <hr width="98%" size="2" align="center">
                                      </span></div>
                                    <div>
                                      <p class="xmsonormal" style="background:white"><b>From:</b>
                                        amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                                        on behalf of Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;<br>
                                        <b>Sent:</b> Tuesday, April 14,
                                        2020 10:19 AM<br>
                                        <b>To:</b> Koenig, Christian
                                        &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                                        <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                                        &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                                        <b>Cc:</b> Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                                        Kim, Jonathan &lt;<a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">Jonathan.Kim@amd.com</a>&gt;<br>
                                        <b>Subject:</b> RE: [PATCH]
                                        Revert &quot;drm/amdgpu: use the BAR
                                        if possible in
                                        amdgpu_device_vram_access v2&quot;
                                        <o:p></o:p></p>
                                      <div>
                                        <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                                      </div>
                                    </div>
                                    <div>
                                      <div>
                                        <p class="xmsonormal" style="background:white">[AMD
                                          Official Use Only - Internal
                                          Distribution Only]<br>
                                          <br>
                                          On VG20 or MI100, as soon as
                                          we run the subtest, we get the
                                          dmesg output below, and then
                                          the kernel ends up hanging. I
                                          don't know enough about the
                                          test itself to know why this
                                          is occurring, but Jon Kim and
                                          Felix were discussing it on a
                                          separate thread when the issue
                                          was first reported, so they
                                          can hopefully provide some
                                          additional information.<br>
                                          <br>
                                          &nbsp;Kent<br>
                                          <br>
                                          &gt; -----Original
                                          Message-----<br>
                                          &gt; From: Christian König
                                          &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                                          &gt; Sent: Tuesday, April 14,
                                          2020 9:52 AM<br>
                                          &gt; To: Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;;
                                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                                          &gt; Subject: Re: [PATCH]
                                          Revert &quot;drm/amdgpu: use the
                                          BAR if possible in<br>
                                          &gt; amdgpu_device_vram_access
                                          v2&quot;<br>
                                          &gt; <br>
                                          &gt; Am 13.04.20 um 20:20
                                          schrieb Kent Russell:<br>
                                          &gt; &gt; This reverts commit
c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
                                          &gt; &gt; The original patch
                                          causes a RAS event and
                                          subsequent kernel hard-hang<br>
                                          &gt; &gt; when running the
                                          KFDMemoryTest.PtraceAccessInvisibleVram
                                          on VG20 and<br>
                                          &gt; &gt; Arcturus<br>
                                          &gt; &gt;<br>
                                          &gt; &gt; dmesg output at hang
                                          time:<br>
                                          &gt; &gt; [drm] RAS event of
                                          type ERREVENT_ATHUB_INTERRUPT
                                          detected!<br>
                                          &gt; &gt; amdgpu 0000:67:00.0:
                                          GPU reset begin!<br>
                                          &gt; &gt; Evicting PASID
                                          0x8000 queues<br>
                                          &gt; &gt; Started evicting
                                          pasid 0x8000<br>
                                          &gt; &gt; qcm fence wait loop
                                          timeout expired<br>
                                          &gt; &gt; The cp might be in
                                          an unrecoverable state due to
                                          an unsuccessful<br>
                                          &gt; &gt; queues preemption
                                          Failed to evict process queues
                                          Failed to suspend<br>
                                          &gt; &gt; process 0x8000
                                          Finished evicting pasid 0x8000
                                          Started restoring pasid<br>
                                          &gt; &gt; 0x8000 Finished
                                          restoring pasid 0x8000 [drm]
                                          UVD VCPU state may lost<br>
                                          &gt; &gt; due to RAS
                                          ERREVENT_ATHUB_INTERRUPT<br>
                                          &gt; &gt; amdgpu: [powerplay]
                                          Failed to send message 0x26,
                                          response 0x0<br>
                                          &gt; &gt; amdgpu: [powerplay]
                                          Failed to set soft min gfxclk
                                          !<br>
                                          &gt; &gt; amdgpu: [powerplay]
                                          Failed to upload DPM Bootup
                                          Levels!<br>
                                          &gt; &gt; amdgpu: [powerplay]
                                          Failed to send message 0x7,
                                          response 0x0<br>
                                          &gt; &gt; amdgpu: [powerplay]
                                          [DisableAllSMUFeatures] Failed
                                          to disable all smu<br>
                                          &gt; features!<br>
                                          &gt; &gt; amdgpu: [powerplay]
                                          [DisableDpmTasks] Failed to
                                          disable all smu features!<br>
                                          &gt; &gt; amdgpu: [powerplay]
                                          [PowerOffAsic] Failed to
                                          disable DPM!<br>
                                          &gt; &gt;
                                          [drm:amdgpu_device_ip_suspend_phase2
                                          [amdgpu]] *ERROR* suspend of
                                          IP<br>
                                          &gt; &gt; block
                                          &lt;powerplay&gt; failed -5<br>
                                          &gt; <br>
                                          &gt; Do you have more
                                          information on what's going
                                          wrong here since this is a
                                          really<br>
                                          &gt; important patch for KFD
                                          debugging.<br>
                                          &gt; <br>
                                          &gt; &gt;<br>
                                          &gt; &gt; Signed-off-by: Kent
                                          Russell &lt;<a href="mailto:kent.russell@amd.com" moz-do-not-send="true">kent.russell@amd.com</a>&gt;<br>
                                          &gt; <br>
                                          &gt; Reviewed-by: Christian
                                          König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                                          &gt; <br>
                                          &gt; &gt; ---<br>
                                          &gt; &gt;&nbsp;&nbsp;
                                          drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                                          | 26 ----------------------<br>
                                          &gt; &gt;&nbsp;&nbsp; 1 file changed, 26
                                          deletions(-)<br>
                                          &gt; &gt;<br>
                                          &gt; &gt; diff --git
                                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                          &gt; &gt;
                                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                          &gt; &gt; index
                                          cf5d6e585634..a3f997f84020
                                          100644<br>
                                          &gt; &gt; ---
                                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                          &gt; &gt; &#43;&#43;&#43;
                                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                          &gt; &gt; @@ -254,32 &#43;254,6 @@
                                          void
                                          amdgpu_device_vram_access(struct<br>
                                          &gt; amdgpu_device *adev,
                                          loff_t pos,<br>
                                          &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =
                                          ~0;<br>
                                          &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
                                          &gt; &gt;<br>
                                          &gt; &gt; -<br>
                                          &gt; &gt; -#ifdef CONFIG_64BIT<br>
                                          &gt; &gt; -&nbsp;&nbsp; last = min(pos &#43;
                                          size,
                                          adev-&gt;gmc.visible_vram_size);<br>
                                          &gt; &gt; -&nbsp;&nbsp; if (last &gt;
                                          pos) {<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void
                                          __iomem *addr =
                                          adev-&gt;mman.aper_base_kaddr
                                          &#43; pos;<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t
                                          count = last - pos;<br>
                                          &gt; &gt; -<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                                          (write) {<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          memcpy_toio(addr, buf, count);<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          mb();<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          amdgpu_asic_flush_hdp(adev,
                                          NULL);<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
amdgpu_asic_invalidate_hdp(adev, NULL);<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          mb();<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          memcpy_fromio(buf, addr,
                                          count);<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                                          &gt; &gt; -<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                                          (count == size)<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          return;<br>
                                          &gt; &gt; -<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos &#43;=
                                          count;<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf &#43;=
                                          count / 4;<br>
                                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size -=
                                          count;<br>
                                          &gt; &gt; -&nbsp;&nbsp; }<br>
                                          &gt; &gt; -#endif<br>
                                          &gt; &gt; -<br>
                                          &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock,
                                          flags);<br>
                                          &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last = pos
                                          &#43; size; pos &lt; last; pos &#43;=
                                          4) {<br>
                                          &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          uint32_t tmp = pos &gt;&gt;
                                          31;<br>
_______________________________________________<br>
                                          amd-gfx mailing list<br>
                                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                                          <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0</a><o:p></o:p></p>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </blockquote>
                            </div>
                            <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                          </div>
                        </div>
                        <div>
                          <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                          <div>
                            <p class="xmsonormal" style="background:white">Am 14.04.2020
                              16:35 schrieb &quot;Deucher, Alexander&quot; &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
                            <blockquote style="border:none;border-left:solid
                              #CCCCCC 1.0pt;padding:0in 0in 0in
6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-bottom:5.0pt">
                              <div>
                                <p style="margin:15.0pt;background:white"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
                                    Public Use]</span><o:p></o:p></p>
                                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                                <div>
                                  <div>
                                    <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">If this
                                        causes an issue, any access to
                                        vram via the BAR could cause an
                                        issue.</span><o:p></o:p></p>
                                  </div>
                                  <div>
                                    <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">&nbsp;</span><o:p></o:p></p>
                                  </div>
                                  <div>
                                    <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">Alex</span><o:p></o:p></p>
                                  </div>
                                  <div class="MsoNormal" style="text-align:center;background:white" align="center">
                                    <span style="color:black">
                                      <hr width="98%" size="2" align="center">
                                    </span></div>
                                  <div>
                                    <p class="xmsonormal" style="background:white"><b>From:</b>
                                      amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                                      on behalf of Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;<br>
                                      <b>Sent:</b> Tuesday, April 14,
                                      2020 10:19 AM<br>
                                      <b>To:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                                      <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                                      &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                                      <b>Cc:</b> Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                                      Kim, Jonathan &lt;<a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">Jonathan.Kim@amd.com</a>&gt;<br>
                                      <b>Subject:</b> RE: [PATCH] Revert
                                      &quot;drm/amdgpu: use the BAR if
                                      possible in
                                      amdgpu_device_vram_access v2&quot;
                                      <o:p></o:p></p>
                                    <div>
                                      <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                                    </div>
                                  </div>
                                  <div>
                                    <div>
                                      <p class="xmsonormal" style="background:white">[AMD
                                        Official Use Only - Internal
                                        Distribution Only]<br>
                                        <br>
                                        On VG20 or MI100, as soon as we
                                        run the subtest, we get the
                                        dmesg output below, and then the
                                        kernel ends up hanging. I don't
                                        know enough about the test
                                        itself to know why this is
                                        occurring, but Jon Kim and Felix
                                        were discussing it on a separate
                                        thread when the issue was first
                                        reported, so they can hopefully
                                        provide some additional
                                        information.<br>
                                        <br>
                                        &nbsp;Kent<br>
                                        <br>
                                        &gt; -----Original Message-----<br>
                                        &gt; From: Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                                        &gt; Sent: Tuesday, April 14,
                                        2020 9:52 AM<br>
                                        &gt; To: Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;;
                                        <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                                        &gt; Subject: Re: [PATCH] Revert
                                        &quot;drm/amdgpu: use the BAR if
                                        possible in<br>
                                        &gt; amdgpu_device_vram_access
                                        v2&quot;<br>
                                        &gt; <br>
                                        &gt; Am 13.04.20 um 20:20
                                        schrieb Kent Russell:<br>
                                        &gt; &gt; This reverts commit
                                        c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
                                        &gt; &gt; The original patch
                                        causes a RAS event and
                                        subsequent kernel hard-hang<br>
                                        &gt; &gt; when running the
                                        KFDMemoryTest.PtraceAccessInvisibleVram
                                        on VG20 and<br>
                                        &gt; &gt; Arcturus<br>
                                        &gt; &gt;<br>
                                        &gt; &gt; dmesg output at hang
                                        time:<br>
                                        &gt; &gt; [drm] RAS event of
                                        type ERREVENT_ATHUB_INTERRUPT
                                        detected!<br>
                                        &gt; &gt; amdgpu 0000:67:00.0:
                                        GPU reset begin!<br>
                                        &gt; &gt; Evicting PASID 0x8000
                                        queues<br>
                                        &gt; &gt; Started evicting pasid
                                        0x8000<br>
                                        &gt; &gt; qcm fence wait loop
                                        timeout expired<br>
                                        &gt; &gt; The cp might be in an
                                        unrecoverable state due to an
                                        unsuccessful<br>
                                        &gt; &gt; queues preemption
                                        Failed to evict process queues
                                        Failed to suspend<br>
                                        &gt; &gt; process 0x8000
                                        Finished evicting pasid 0x8000
                                        Started restoring pasid<br>
                                        &gt; &gt; 0x8000 Finished
                                        restoring pasid 0x8000 [drm] UVD
                                        VCPU state may lost<br>
                                        &gt; &gt; due to RAS
                                        ERREVENT_ATHUB_INTERRUPT<br>
                                        &gt; &gt; amdgpu: [powerplay]
                                        Failed to send message 0x26,
                                        response 0x0<br>
                                        &gt; &gt; amdgpu: [powerplay]
                                        Failed to set soft min gfxclk !<br>
                                        &gt; &gt; amdgpu: [powerplay]
                                        Failed to upload DPM Bootup
                                        Levels!<br>
                                        &gt; &gt; amdgpu: [powerplay]
                                        Failed to send message 0x7,
                                        response 0x0<br>
                                        &gt; &gt; amdgpu: [powerplay]
                                        [DisableAllSMUFeatures] Failed
                                        to disable all smu<br>
                                        &gt; features!<br>
                                        &gt; &gt; amdgpu: [powerplay]
                                        [DisableDpmTasks] Failed to
                                        disable all smu features!<br>
                                        &gt; &gt; amdgpu: [powerplay]
                                        [PowerOffAsic] Failed to disable
                                        DPM!<br>
                                        &gt; &gt;
                                        [drm:amdgpu_device_ip_suspend_phase2
                                        [amdgpu]] *ERROR* suspend of IP<br>
                                        &gt; &gt; block
                                        &lt;powerplay&gt; failed -5<br>
                                        &gt; <br>
                                        &gt; Do you have more
                                        information on what's going
                                        wrong here since this is a
                                        really<br>
                                        &gt; important patch for KFD
                                        debugging.<br>
                                        &gt; <br>
                                        &gt; &gt;<br>
                                        &gt; &gt; Signed-off-by: Kent
                                        Russell &lt;<a href="mailto:kent.russell@amd.com" moz-do-not-send="true">kent.russell@amd.com</a>&gt;<br>
                                        &gt; <br>
                                        &gt; Reviewed-by: Christian
                                        König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                                        &gt; <br>
                                        &gt; &gt; ---<br>
                                        &gt; &gt;&nbsp;&nbsp;
                                        drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                                        | 26 ----------------------<br>
                                        &gt; &gt;&nbsp;&nbsp; 1 file changed, 26
                                        deletions(-)<br>
                                        &gt; &gt;<br>
                                        &gt; &gt; diff --git
                                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                        &gt; &gt;
                                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                        &gt; &gt; index
                                        cf5d6e585634..a3f997f84020
                                        100644<br>
                                        &gt; &gt; ---
                                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                        &gt; &gt; &#43;&#43;&#43;
                                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                        &gt; &gt; @@ -254,32 &#43;254,6 @@
                                        void
                                        amdgpu_device_vram_access(struct<br>
                                        &gt; amdgpu_device *adev, loff_t
                                        pos,<br>
                                        &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi = ~0;<br>
                                        &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
                                        &gt; &gt;<br>
                                        &gt; &gt; -<br>
                                        &gt; &gt; -#ifdef CONFIG_64BIT<br>
                                        &gt; &gt; -&nbsp;&nbsp; last = min(pos &#43;
                                        size,
                                        adev-&gt;gmc.visible_vram_size);<br>
                                        &gt; &gt; -&nbsp;&nbsp; if (last &gt; pos)
                                        {<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void
                                        __iomem *addr =
                                        adev-&gt;mman.aper_base_kaddr &#43;
                                        pos;<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t
                                        count = last - pos;<br>
                                        &gt; &gt; -<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write)
                                        {<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        memcpy_toio(addr, buf, count);<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        mb();<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        amdgpu_asic_flush_hdp(adev,
                                        NULL);<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        amdgpu_asic_invalidate_hdp(adev,
                                        NULL);<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        mb();<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        memcpy_fromio(buf, addr, count);<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                                        &gt; &gt; -<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (count
                                        == size)<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        return;<br>
                                        &gt; &gt; -<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos &#43;=
                                        count;<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf &#43;=
                                        count / 4;<br>
                                        &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size -=
                                        count;<br>
                                        &gt; &gt; -&nbsp;&nbsp; }<br>
                                        &gt; &gt; -#endif<br>
                                        &gt; &gt; -<br>
                                        &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock,
                                        flags);<br>
                                        &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last = pos &#43;
                                        size; pos &lt; last; pos &#43;= 4) {<br>
                                        &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
                                        tmp = pos &gt;&gt; 31;<br>
_______________________________________________<br>
                                        amd-gfx mailing list<br>
                                        <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                                        <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0</a><o:p></o:p></p>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </blockquote>
                          </div>
                          <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                        </div>
                      </div>
                      <div>
                        <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                        <div>
                          <p class="xmsonormal" style="background:white">Am
                            14.04.2020 16:35 schrieb &quot;Deucher,
                            Alexander&quot; &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
                          <blockquote style="border:none;border-left:solid #CCCCCC
                            1.0pt;padding:0in 0in 0in
6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-bottom:5.0pt">
                            <div>
                              <p style="margin:15.0pt;background:white"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
                                  Public Use]</span><o:p></o:p></p>
                              <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                              <div>
                                <div>
                                  <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">If this
                                      causes an issue, any access to
                                      vram via the BAR could cause an
                                      issue.</span><o:p></o:p></p>
                                </div>
                                <div>
                                  <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">&nbsp;</span><o:p></o:p></p>
                                </div>
                                <div>
                                  <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">Alex</span><o:p></o:p></p>
                                </div>
                                <div class="MsoNormal" style="text-align:center;background:white" align="center">
                                  <span style="color:black">
                                    <hr width="98%" size="2" align="center">
                                  </span></div>
                                <div>
                                  <p class="xmsonormal" style="background:white"><b>From:</b>
                                    amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                                    on behalf of Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;<br>
                                    <b>Sent:</b> Tuesday, April 14, 2020
                                    10:19 AM<br>
                                    <b>To:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                                    &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                                    <b>Cc:</b> Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                                    Kim, Jonathan &lt;<a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">Jonathan.Kim@amd.com</a>&gt;<br>
                                    <b>Subject:</b> RE: [PATCH] Revert
                                    &quot;drm/amdgpu: use the BAR if possible
                                    in amdgpu_device_vram_access v2&quot;
                                    <o:p></o:p></p>
                                  <div>
                                    <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                                  </div>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal" style="background:white">[AMD
                                      Official Use Only - Internal
                                      Distribution Only]<br>
                                      <br>
                                      On VG20 or MI100, as soon as we
                                      run the subtest, we get the dmesg
                                      output below, and then the kernel
                                      ends up hanging. I don't know
                                      enough about the test itself to
                                      know why this is occurring, but
                                      Jon Kim and Felix were discussing
                                      it on a separate thread when the
                                      issue was first reported, so they
                                      can hopefully provide some
                                      additional information.<br>
                                      <br>
                                      &nbsp;Kent<br>
                                      <br>
                                      &gt; -----Original Message-----<br>
                                      &gt; From: Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                                      &gt; Sent: Tuesday, April 14, 2020
                                      9:52 AM<br>
                                      &gt; To: Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;;
                                      <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                                      &gt; Subject: Re: [PATCH] Revert
                                      &quot;drm/amdgpu: use the BAR if
                                      possible in<br>
                                      &gt; amdgpu_device_vram_access v2&quot;<br>
                                      &gt; <br>
                                      &gt; Am 13.04.20 um 20:20 schrieb
                                      Kent Russell:<br>
                                      &gt; &gt; This reverts commit
                                      c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
                                      &gt; &gt; The original patch
                                      causes a RAS event and subsequent
                                      kernel hard-hang<br>
                                      &gt; &gt; when running the
                                      KFDMemoryTest.PtraceAccessInvisibleVram
                                      on VG20 and<br>
                                      &gt; &gt; Arcturus<br>
                                      &gt; &gt;<br>
                                      &gt; &gt; dmesg output at hang
                                      time:<br>
                                      &gt; &gt; [drm] RAS event of type
                                      ERREVENT_ATHUB_INTERRUPT detected!<br>
                                      &gt; &gt; amdgpu 0000:67:00.0: GPU
                                      reset begin!<br>
                                      &gt; &gt; Evicting PASID 0x8000
                                      queues<br>
                                      &gt; &gt; Started evicting pasid
                                      0x8000<br>
                                      &gt; &gt; qcm fence wait loop
                                      timeout expired<br>
                                      &gt; &gt; The cp might be in an
                                      unrecoverable state due to an
                                      unsuccessful<br>
                                      &gt; &gt; queues preemption Failed
                                      to evict process queues Failed to
                                      suspend<br>
                                      &gt; &gt; process 0x8000 Finished
                                      evicting pasid 0x8000 Started
                                      restoring pasid<br>
                                      &gt; &gt; 0x8000 Finished
                                      restoring pasid 0x8000 [drm] UVD
                                      VCPU state may lost<br>
                                      &gt; &gt; due to RAS
                                      ERREVENT_ATHUB_INTERRUPT<br>
                                      &gt; &gt; amdgpu: [powerplay]
                                      Failed to send message 0x26,
                                      response 0x0<br>
                                      &gt; &gt; amdgpu: [powerplay]
                                      Failed to set soft min gfxclk !<br>
                                      &gt; &gt; amdgpu: [powerplay]
                                      Failed to upload DPM Bootup
                                      Levels!<br>
                                      &gt; &gt; amdgpu: [powerplay]
                                      Failed to send message 0x7,
                                      response 0x0<br>
                                      &gt; &gt; amdgpu: [powerplay]
                                      [DisableAllSMUFeatures] Failed to
                                      disable all smu<br>
                                      &gt; features!<br>
                                      &gt; &gt; amdgpu: [powerplay]
                                      [DisableDpmTasks] Failed to
                                      disable all smu features!<br>
                                      &gt; &gt; amdgpu: [powerplay]
                                      [PowerOffAsic] Failed to disable
                                      DPM!<br>
                                      &gt; &gt;
                                      [drm:amdgpu_device_ip_suspend_phase2
                                      [amdgpu]] *ERROR* suspend of IP<br>
                                      &gt; &gt; block &lt;powerplay&gt;
                                      failed -5<br>
                                      &gt; <br>
                                      &gt; Do you have more information
                                      on what's going wrong here since
                                      this is a really<br>
                                      &gt; important patch for KFD
                                      debugging.<br>
                                      &gt; <br>
                                      &gt; &gt;<br>
                                      &gt; &gt; Signed-off-by: Kent
                                      Russell &lt;<a href="mailto:kent.russell@amd.com" moz-do-not-send="true">kent.russell@amd.com</a>&gt;<br>
                                      &gt; <br>
                                      &gt; Reviewed-by: Christian König
                                      &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                                      &gt; <br>
                                      &gt; &gt; ---<br>
                                      &gt; &gt;&nbsp;&nbsp;
                                      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                                      | 26 ----------------------<br>
                                      &gt; &gt;&nbsp;&nbsp; 1 file changed, 26
                                      deletions(-)<br>
                                      &gt; &gt;<br>
                                      &gt; &gt; diff --git
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                      &gt; &gt;
                                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                      &gt; &gt; index
                                      cf5d6e585634..a3f997f84020 100644<br>
                                      &gt; &gt; ---
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                      &gt; &gt; &#43;&#43;&#43;
                                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                      &gt; &gt; @@ -254,32 &#43;254,6 @@
                                      void
                                      amdgpu_device_vram_access(struct<br>
                                      &gt; amdgpu_device *adev, loff_t
                                      pos,<br>
                                      &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi = ~0;<br>
                                      &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
                                      &gt; &gt;<br>
                                      &gt; &gt; -<br>
                                      &gt; &gt; -#ifdef CONFIG_64BIT<br>
                                      &gt; &gt; -&nbsp;&nbsp; last = min(pos &#43;
                                      size,
                                      adev-&gt;gmc.visible_vram_size);<br>
                                      &gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void __iomem
                                      *addr =
                                      adev-&gt;mman.aper_base_kaddr &#43;
                                      pos;<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count
                                      = last - pos;<br>
                                      &gt; &gt; -<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write) {<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      memcpy_toio(addr, buf, count);<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      mb();<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      amdgpu_asic_flush_hdp(adev, NULL);<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      amdgpu_asic_invalidate_hdp(adev,
                                      NULL);<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      mb();<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      memcpy_fromio(buf, addr, count);<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                                      &gt; &gt; -<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (count ==
                                      size)<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      return;<br>
                                      &gt; &gt; -<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos &#43;=
                                      count;<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf &#43;= count
                                      / 4;<br>
                                      &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size -=
                                      count;<br>
                                      &gt; &gt; -&nbsp;&nbsp; }<br>
                                      &gt; &gt; -#endif<br>
                                      &gt; &gt; -<br>
                                      &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock,
                                      flags);<br>
                                      &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last = pos &#43;
                                      size; pos &lt; last; pos &#43;= 4) {<br>
                                      &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
                                      tmp = pos &gt;&gt; 31;<br>
_______________________________________________<br>
                                      amd-gfx mailing list<br>
                                      <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                                      <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0</a><o:p></o:p></p>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </blockquote>
                        </div>
                        <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                      </div>
                    </div>
                    <div>
                      <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                      <div>
                        <p class="xmsonormal" style="background:white">Am
                          14.04.2020 16:35 schrieb &quot;Deucher, Alexander&quot;
                          &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
                      </div>
                    </div>
                    <div>
                      <p style="margin:15.0pt;background:white"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
                          Public Use]</span><o:p></o:p></p>
                      <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                      <div>
                        <div>
                          <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">If this causes an
                              issue, any access to vram via the BAR
                              could cause an issue.</span><o:p></o:p></p>
                        </div>
                        <div>
                          <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">&nbsp;</span><o:p></o:p></p>
                        </div>
                        <div>
                          <p class="xmsonormal" style="background:white"><span style="font-size:12.0pt">Alex</span><o:p></o:p></p>
                        </div>
                        <div class="MsoNormal" style="text-align:center;background:white" align="center">
                          <span style="color:black">
                            <hr width="98%" size="2" align="center">
                          </span></div>
                        <div id="x_divRplyFwdMsg">
                          <p class="xmsonormal" style="background:white"><b>From:</b>
                            amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                            on behalf of Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;<br>
                            <b>Sent:</b> Tuesday, April 14, 2020 10:19
                            AM<br>
                            <b>To:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                            <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                            &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                            <b>Cc:</b> Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                            Kim, Jonathan &lt;<a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">Jonathan.Kim@amd.com</a>&gt;<br>
                            <b>Subject:</b> RE: [PATCH] Revert
                            &quot;drm/amdgpu: use the BAR if possible in
                            amdgpu_device_vram_access v2&quot;
                            <o:p></o:p></p>
                          <div>
                            <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
                          </div>
                        </div>
                        <div>
                          <div>
                            <p class="xmsonormal" style="background:white">[AMD Official Use
                              Only - Internal Distribution Only]<br>
                              <br>
                              On VG20 or MI100, as soon as we run the
                              subtest, we get the dmesg output below,
                              and then the kernel ends up hanging. I
                              don't know enough about the test itself to
                              know why this is occurring, but Jon Kim
                              and Felix were discussing it on a separate
                              thread when the issue was first reported,
                              so they can hopefully provide some
                              additional information.<br>
                              <br>
                              &nbsp;Kent<br>
                              <br>
                              &gt; -----Original Message-----<br>
                              &gt; From: Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                              &gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
                              &gt; To: Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;;
                              <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                              &gt; Subject: Re: [PATCH] Revert
                              &quot;drm/amdgpu: use the BAR if possible in<br>
                              &gt; amdgpu_device_vram_access v2&quot;<br>
                              &gt; <br>
                              &gt; Am 13.04.20 um 20:20 schrieb Kent
                              Russell:<br>
                              &gt; &gt; This reverts commit
                              c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
                              &gt; &gt; The original patch causes a RAS
                              event and subsequent kernel hard-hang<br>
                              &gt; &gt; when running the
                              KFDMemoryTest.PtraceAccessInvisibleVram on
                              VG20 and<br>
                              &gt; &gt; Arcturus<br>
                              &gt; &gt;<br>
                              &gt; &gt; dmesg output at hang time:<br>
                              &gt; &gt; [drm] RAS event of type
                              ERREVENT_ATHUB_INTERRUPT detected!<br>
                              &gt; &gt; amdgpu 0000:67:00.0: GPU reset
                              begin!<br>
                              &gt; &gt; Evicting PASID 0x8000 queues<br>
                              &gt; &gt; Started evicting pasid 0x8000<br>
                              &gt; &gt; qcm fence wait loop timeout
                              expired<br>
                              &gt; &gt; The cp might be in an
                              unrecoverable state due to an unsuccessful<br>
                              &gt; &gt; queues preemption Failed to
                              evict process queues Failed to suspend<br>
                              &gt; &gt; process 0x8000 Finished evicting
                              pasid 0x8000 Started restoring pasid<br>
                              &gt; &gt; 0x8000 Finished restoring pasid
                              0x8000 [drm] UVD VCPU state may lost<br>
                              &gt; &gt; due to RAS
                              ERREVENT_ATHUB_INTERRUPT<br>
                              &gt; &gt; amdgpu: [powerplay] Failed to
                              send message 0x26, response 0x0<br>
                              &gt; &gt; amdgpu: [powerplay] Failed to
                              set soft min gfxclk !<br>
                              &gt; &gt; amdgpu: [powerplay] Failed to
                              upload DPM Bootup Levels!<br>
                              &gt; &gt; amdgpu: [powerplay] Failed to
                              send message 0x7, response 0x0<br>
                              &gt; &gt; amdgpu: [powerplay]
                              [DisableAllSMUFeatures] Failed to disable
                              all smu<br>
                              &gt; features!<br>
                              &gt; &gt; amdgpu: [powerplay]
                              [DisableDpmTasks] Failed to disable all
                              smu features!<br>
                              &gt; &gt; amdgpu: [powerplay]
                              [PowerOffAsic] Failed to disable DPM!<br>
                              &gt; &gt;
                              [drm:amdgpu_device_ip_suspend_phase2
                              [amdgpu]] *ERROR* suspend of IP<br>
                              &gt; &gt; block &lt;powerplay&gt; failed
                              -5<br>
                              &gt; <br>
                              &gt; Do you have more information on
                              what's going wrong here since this is a
                              really<br>
                              &gt; important patch for KFD debugging.<br>
                              &gt; <br>
                              &gt; &gt;<br>
                              &gt; &gt; Signed-off-by: Kent Russell &lt;<a href="mailto:kent.russell@amd.com" moz-do-not-send="true">kent.russell@amd.com</a>&gt;<br>
                              &gt; <br>
                              &gt; Reviewed-by: Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                              &gt; <br>
                              &gt; &gt; ---<br>
                              &gt; &gt;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                              | 26 ----------------------<br>
                              &gt; &gt;&nbsp;&nbsp; 1 file changed, 26
                              deletions(-)<br>
                              &gt; &gt;<br>
                              &gt; &gt; diff --git
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                              &gt; &gt;
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                              &gt; &gt; index cf5d6e585634..a3f997f84020
                              100644<br>
                              &gt; &gt; ---
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                              &gt; &gt; &#43;&#43;&#43;
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                              &gt; &gt; @@ -254,32 &#43;254,6 @@ void
                              amdgpu_device_vram_access(struct<br>
                              &gt; amdgpu_device *adev, loff_t pos,<br>
                              &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi = ~0;<br>
                              &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
                              &gt; &gt;<br>
                              &gt; &gt; -<br>
                              &gt; &gt; -#ifdef CONFIG_64BIT<br>
                              &gt; &gt; -&nbsp;&nbsp; last = min(pos &#43; size,
                              adev-&gt;gmc.visible_vram_size);<br>
                              &gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void __iomem *addr =
                              adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count = last
                              - pos;<br>
                              &gt; &gt; -<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write) {<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              memcpy_toio(addr, buf, count);<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              amdgpu_asic_flush_hdp(adev, NULL);<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              amdgpu_asic_invalidate_hdp(adev, NULL);<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              memcpy_fromio(buf, addr, count);<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                              &gt; &gt; -<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (count == size)<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
                              &gt; &gt; -<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos &#43;= count;<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf &#43;= count / 4;<br>
                              &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size -= count;<br>
                              &gt; &gt; -&nbsp;&nbsp; }<br>
                              &gt; &gt; -#endif<br>
                              &gt; &gt; -<br>
                              &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock,
                              flags);<br>
                              &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last = pos &#43; size; pos
                              &lt; last; pos &#43;= 4) {<br>
                              &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp = pos
                              &gt;&gt; 31;<br>
_______________________________________________<br>
                              amd-gfx mailing list<br>
                              <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                              <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0</a><o:p></o:p></p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </blockquote>
                </blockquote>
                <p class="xmsonormal" style="background:white">&nbsp;<o:p></o:p></p>
              </div>
            </blockquote>
            <p class="MsoNormal" style="background:white"><o:p>&nbsp;</o:p></p>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------C11D4B19F8344DD689278FD9--

--===============0445819173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0445819173==--
