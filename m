Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8673FC2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 18:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FB120575
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 18:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q9o8Vzx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FB120575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC4D16E519;
	Tue, 14 Apr 2020 18:31:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58696E519
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 18:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaIJg3bny6IBqoLSFjRLvw+chWG0QNvLdjC51WBH1UjqhNZzdKzBeDZtv126IMWfxsVVMumlpDJjhXI+2YN13P/PgljyCM+xT5gNT4bjwb7oVcLLG8ou4dmhseygVAAliS8DpkMyM1o5G0wiGHI8RPKaAwTWV18AbjbzPgtG7PG0Q5+1+5GhhxNV4cBTayoSWqJEGAMW1nK/GkIussCX930eXvOMPHXOQ0nNc4PCn5qZEgqbIjZfDTof13NrJFFOvsOd5NSXE2/4fesIxOrnLhkd1g8+QiNJe8eZ6aXmPaRxoHqJ3W03SjOpZEWs1PAbNg1N1t56Lg3zCxVUbOwfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aDe4o9RY0Ha5lgi9kqP+sZLfYynEFMFAlHr6xPTWjU=;
 b=XRFzEGsNz2sZgmaDFzCXvfpUvCH1NvDZRSwF66YFc9Jg9rJZo9xeaw/LOTKsxkDewHR9H0AGONkofKUmp+ixtrfxHPwtWgp20BDTc57C/Q3rxnIloXpyyGPS0dcLljhQ6S9mJNhZC+R5YqDBn0WRyqg9m3Uv+Pu4vHkDWA1SJQbkkumKkdYxeokn0x18Qu0VeJ+fnHfwh13hlbo6UwH2IR++1ofYQwIDBkkfU4kbschRNRy80LGYubdENT2OWiGq7SqoS5K1jWu0iY2/9El897H/BqfSs+IvcQRBji+2NKu+bj07hBtt9PCBsmpOVG457akGTUMG0Z6mOYgVllxvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aDe4o9RY0Ha5lgi9kqP+sZLfYynEFMFAlHr6xPTWjU=;
 b=Q9o8Vzx5c0vUNaH0tw3pR41SGXS2G+bKSMdQXmAA+H70mkUxQVBZZEbc5Ecs6IcoY1TyTsIVqg7G90GVz6J+SbKKeYeFS+nFFhiySaM6MUcYc0iBIEtSzEqe4N7nowR/myKyx7ONKiQWE5yYJSJtmuOi3MlmooZ2LsyTSihFXE8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2384.namprd12.prod.outlook.com (2603:10b6:802:25::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 18:31:54 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 18:31:54 +0000
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20200413182026.2561-1-kent.russell@amd.com>
 <85fcb568-b0d8-b6c9-4e62-3866aa2da0c9@gmail.com>
 <DM6PR12MB3721FDB775B65C22B91D564585DA0@DM6PR12MB3721.namprd12.prod.outlook.com>
 <MN2PR12MB4488C1D9BF9C0A693860B1C1F7DA0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <146d9570-724e-423d-931e-24c96821aaae@email.android.com>
 <MN2PR12MB451836BC6F9C0F002EE1C3D685DA0@MN2PR12MB4518.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e69b430e-f4e3-c4a0-82f0-dae527cccf3d@amd.com>
Date: Tue, 14 Apr 2020 14:31:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <MN2PR12MB451836BC6F9C0F002EE1C3D685DA0@MN2PR12MB4518.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::48) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YQBPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:1::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Tue, 14 Apr 2020 18:31:53 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 992b4211-cfcb-4a67-06f4-08d7e0a21b4e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:|SN1PR12MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23844D1C8E56251C645197C692DA0@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39850400004)(366004)(86362001)(6486002)(110136005)(31686004)(186003)(45080400002)(53546011)(478600001)(36756003)(26005)(16526019)(966005)(66574012)(4326008)(54906003)(81156014)(31696002)(66476007)(66556008)(44832011)(33964004)(16576012)(316002)(2906002)(6636002)(956004)(66946007)(8936002)(2616005)(8676002)(5660300002)(30864003)(52116002)(559001)(579004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+gRZv/hJ0fjcmj+wR2gqXqnZOoqV3zkAhDTtq639q5xrNPJQM41CWGMuzbxLoUl1jrZTJDYtWUuhrV0dD3kyfI6sgpID+RGgVyoQCZajDH/U9CmNxLvyW0jpy5OwpizLOKYWRKu2GbjaLCdYzWK0WJuFA1QVA5ihGLmXDO0FLPHkor8R8Hr/WEdHCFQeXh6RS5TY3o1DWKhondUVqoKiRm20nmhg4oPYi+oyMeEAEoKSBpvMAK8KqLEbjoNiuWKHjq50IvqC8NbY5N/jVN7rC+AMrxPAm0W82cdV5U1m01k8wMMYXa55F5IMva0wNrm7yY39IYxpy6YVYPFRJm5xTyzQkG2vjP7ZFM+7tcmk0FwKBXFz2b6uBKbKszopp3btWfRL+MwML06v/Gd0u371xP0MOuhPK8WrDWro8H0e0WhjFoMotiLfhyeKewbDi5ohP21XKt7jvTERShcdxTiBBz0Nq1uq2MfZaiuOGHx0hQ=
X-MS-Exchange-AntiSpam-MessageData: X+GAcPywatULo9GPdNTaZqNBEaUxEQRE6yZPmxHl7v8XOtGeyKi88mJgJ/b0LxUwzo8Vk/4Dr14P1tBKfX2jYGBMlzfuZdixZc+TVnfrJqqFYNjU/6uCHiqJVkzeNHIo8si6tmjsAk7IPPfh/7Zi7w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992b4211-cfcb-4a67-06f4-08d7e0a21b4e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 18:31:54.6654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL1nlX/M+FDdEPgvhZ/XtX0YHsRFvdjARvfmprKnuzly7i/0g5NuiwTj8XPhaHsHXouv9OXHsImZmM5dZ3m/wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
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
Content-Type: multipart/mixed; boundary="===============0375679975=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0375679975==
Content-Type: multipart/alternative;
 boundary="------------3EF3B952633FF988AB53BD84"
Content-Language: en-US

--------------3EF3B952633FF988AB53BD84
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

I wouldn't call it premature. Revert is a usual practice when there is a
serious regression that isn't fully understood or root-caused. As far as
I can tell, the problem has been reproduced on multiple systems,
different GPUs, and clearly regressed to Christian's commit. I think
that justifies reverting it for now.

I agree with Christian that a general HDP memory access problem causing
RAS errors would potentially cause problems in other tests as well. For
example common operations like GART table updates, and GPUVM page table
updates and PCIe peer2peer accesses in ROCm applications use HDP. But
we're not seeing obvious problems from those. So we need to understand
what's special about this test. I asked questions to that effect on our
other email thread.

Regards,
  Felix

Am 2020-04-14 um 10:51 a.m. schrieb Kim, Jonathan:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>  
>
> I think it’s premature to push this revert.
>
>  
>
> With more testing, I’m getting failures from different tests or
> sometimes none at all on my machine.
>
>  
>
> Kent, let’s continue the discussion on the original thread.
>
>  
>
> Thanks,
>
>  
>
> Jon
>
>  
>
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Tuesday, April 14, 2020 10:47 AM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Cc:* Russell, Kent <Kent.Russell@amd.com>;
> amd-gfx@lists.freedesktop.org; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> *Subject:* Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
>  
>
> That's exactly my concern as well.
>
>  
>
> This looks a bit like the test creates erroneous data somehow, but
> there doesn't seems to be a RAS check in the MM data path.
>
>  
>
> And now that we use the BAR path it goes up in flames.
>
>  
>
> I just don't see how we can create erroneous data in a test case?
>
>  
>
> Christian.
>
>  
>
> Am 14.04.2020 16:35 schrieb "Deucher, Alexander"
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>:
>
>     [AMD Public Use]
>
>      
>
>     If this causes an issue, any access to vram via the BAR could
>     cause an issue.
>
>      
>
>     Alex
>
>     ------------------------------------------------------------------------
>
>     *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>     <mailto:amd-gfx-bounces@lists.freedesktop.org>> on behalf of
>     Russell, Kent <Kent.Russell@amd.com <mailto:Kent.Russell@amd.com>>
>     *Sent:* Tuesday, April 14, 2020 10:19 AM
>     *To:* Koenig, Christian <Christian.Koenig@amd.com
>     <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
>     *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com
>     <mailto:Felix.Kuehling@amd.com>>; Kim, Jonathan
>     <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
>     *Subject:* RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible
>     in amdgpu_device_vram_access v2"
>
>      
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     On VG20 or MI100, as soon as we run the subtest, we get the dmesg
>     output below, and then the kernel ends up hanging. I don't know
>     enough about the test itself to know why this is occurring, but
>     Jon Kim and Felix were discussing it on a separate thread when the
>     issue was first reported, so they can hopefully provide some
>     additional information.
>
>      Kent
>
>     > -----Original Message-----
>     > From: Christian König <ckoenig.leichtzumerken@gmail.com
>     <mailto:ckoenig.leichtzumerken@gmail.com>>
>     > Sent: Tuesday, April 14, 2020 9:52 AM
>     > To: Russell, Kent <Kent.Russell@amd.com
>     <mailto:Kent.Russell@amd.com>>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     > Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
>     > amdgpu_device_vram_access v2"
>     >
>     > Am 13.04.20 um 20:20 schrieb Kent Russell:
>     > > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
>     > > The original patch causes a RAS event and subsequent kernel
>     hard-hang
>     > > when running the KFDMemoryTest.PtraceAccessInvisibleVram on
>     VG20 and
>     > > Arcturus
>     > >
>     > > dmesg output at hang time:
>     > > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
>     > > amdgpu 0000:67:00.0: GPU reset begin!
>     > > Evicting PASID 0x8000 queues
>     > > Started evicting pasid 0x8000
>     > > qcm fence wait loop timeout expired
>     > > The cp might be in an unrecoverable state due to an unsuccessful
>     > > queues preemption Failed to evict process queues Failed to suspend
>     > > process 0x8000 Finished evicting pasid 0x8000 Started
>     restoring pasid
>     > > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state
>     may lost
>     > > due to RAS ERREVENT_ATHUB_INTERRUPT
>     > > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
>     > > amdgpu: [powerplay] Failed to set soft min gfxclk !
>     > > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
>     > > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
>     > > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable
>     all smu
>     > features!
>     > > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all
>     smu features!
>     > > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
>     > > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend
>     of IP
>     > > block <powerplay> failed -5
>     >
>     > Do you have more information on what's going wrong here since
>     this is a really
>     > important patch for KFD debugging.
>     >
>     > >
>     > > Signed-off-by: Kent Russell <kent.russell@amd.com
>     <mailto:kent.russell@amd.com>>
>     >
>     > Reviewed-by: Christian König <christian.koenig@amd.com
>     <mailto:christian.koenig@amd.com>>
>     >
>     > > ---
>     > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>     ----------------------
>     > >   1 file changed, 26 deletions(-)
>     > >
>     > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > index cf5d6e585634..a3f997f84020 100644
>     > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
>     > amdgpu_device *adev, loff_t pos,
>     > >      uint32_t hi = ~0;
>     > >      uint64_t last;
>     > >
>     > > -
>     > > -#ifdef CONFIG_64BIT
>     > > -   last = min(pos + size, adev->gmc.visible_vram_size);
>     > > -   if (last > pos) {
>     > > -           void __iomem *addr = adev->mman.aper_base_kaddr + pos;
>     > > -           size_t count = last - pos;
>     > > -
>     > > -           if (write) {
>     > > -                   memcpy_toio(addr, buf, count);
>     > > -                   mb();
>     > > -                   amdgpu_asic_flush_hdp(adev, NULL);
>     > > -           } else {
>     > > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
>     > > -                   mb();
>     > > -                   memcpy_fromio(buf, addr, count);
>     > > -           }
>     > > -
>     > > -           if (count == size)
>     > > -                   return;
>     > > -
>     > > -           pos += count;
>     > > -           buf += count / 4;
>     > > -           size -= count;
>     > > -   }
>     > > -#endif
>     > > -
>     > >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
>     > >      for (last = pos + size; pos < last; pos += 4) {
>     > >              uint32_t tmp = pos >> 31;
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=0
>
>  
>
>  
>
> Am 14.04.2020 16:35 schrieb "Deucher, Alexander"
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>:
>
>     [AMD Public Use]
>
>      
>
>     If this causes an issue, any access to vram via the BAR could
>     cause an issue.
>
>      
>
>     Alex
>
>     ------------------------------------------------------------------------
>
>     *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>     <mailto:amd-gfx-bounces@lists.freedesktop.org>> on behalf of
>     Russell, Kent <Kent.Russell@amd.com <mailto:Kent.Russell@amd.com>>
>     *Sent:* Tuesday, April 14, 2020 10:19 AM
>     *To:* Koenig, Christian <Christian.Koenig@amd.com
>     <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
>     *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com
>     <mailto:Felix.Kuehling@amd.com>>; Kim, Jonathan
>     <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
>     *Subject:* RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible
>     in amdgpu_device_vram_access v2"
>
>      
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     On VG20 or MI100, as soon as we run the subtest, we get the dmesg
>     output below, and then the kernel ends up hanging. I don't know
>     enough about the test itself to know why this is occurring, but
>     Jon Kim and Felix were discussing it on a separate thread when the
>     issue was first reported, so they can hopefully provide some
>     additional information.
>
>      Kent
>
>     > -----Original Message-----
>     > From: Christian König <ckoenig.leichtzumerken@gmail.com
>     <mailto:ckoenig.leichtzumerken@gmail.com>>
>     > Sent: Tuesday, April 14, 2020 9:52 AM
>     > To: Russell, Kent <Kent.Russell@amd.com
>     <mailto:Kent.Russell@amd.com>>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     > Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
>     > amdgpu_device_vram_access v2"
>     >
>     > Am 13.04.20 um 20:20 schrieb Kent Russell:
>     > > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
>     > > The original patch causes a RAS event and subsequent kernel
>     hard-hang
>     > > when running the KFDMemoryTest.PtraceAccessInvisibleVram on
>     VG20 and
>     > > Arcturus
>     > >
>     > > dmesg output at hang time:
>     > > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
>     > > amdgpu 0000:67:00.0: GPU reset begin!
>     > > Evicting PASID 0x8000 queues
>     > > Started evicting pasid 0x8000
>     > > qcm fence wait loop timeout expired
>     > > The cp might be in an unrecoverable state due to an unsuccessful
>     > > queues preemption Failed to evict process queues Failed to suspend
>     > > process 0x8000 Finished evicting pasid 0x8000 Started
>     restoring pasid
>     > > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state
>     may lost
>     > > due to RAS ERREVENT_ATHUB_INTERRUPT
>     > > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
>     > > amdgpu: [powerplay] Failed to set soft min gfxclk !
>     > > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
>     > > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
>     > > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable
>     all smu
>     > features!
>     > > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all
>     smu features!
>     > > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
>     > > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend
>     of IP
>     > > block <powerplay> failed -5
>     >
>     > Do you have more information on what's going wrong here since
>     this is a really
>     > important patch for KFD debugging.
>     >
>     > >
>     > > Signed-off-by: Kent Russell <kent.russell@amd.com
>     <mailto:kent.russell@amd.com>>
>     >
>     > Reviewed-by: Christian König <christian.koenig@amd.com
>     <mailto:christian.koenig@amd.com>>
>     >
>     > > ---
>     > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>     ----------------------
>     > >   1 file changed, 26 deletions(-)
>     > >
>     > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > index cf5d6e585634..a3f997f84020 100644
>     > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
>     > amdgpu_device *adev, loff_t pos,
>     > >      uint32_t hi = ~0;
>     > >      uint64_t last;
>     > >
>     > > -
>     > > -#ifdef CONFIG_64BIT
>     > > -   last = min(pos + size, adev->gmc.visible_vram_size);
>     > > -   if (last > pos) {
>     > > -           void __iomem *addr = adev->mman.aper_base_kaddr + pos;
>     > > -           size_t count = last - pos;
>     > > -
>     > > -           if (write) {
>     > > -                   memcpy_toio(addr, buf, count);
>     > > -                   mb();
>     > > -                   amdgpu_asic_flush_hdp(adev, NULL);
>     > > -           } else {
>     > > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
>     > > -                   mb();
>     > > -                   memcpy_fromio(buf, addr, count);
>     > > -           }
>     > > -
>     > > -           if (count == size)
>     > > -                   return;
>     > > -
>     > > -           pos += count;
>     > > -           buf += count / 4;
>     > > -           size -= count;
>     > > -   }
>     > > -#endif
>     > > -
>     > >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
>     > >      for (last = pos + size; pos < last; pos += 4) {
>     > >              uint32_t tmp = pos >> 31;
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=0
>
>  
>
>  
>
> Am 14.04.2020 16:35 schrieb "Deucher, Alexander"
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>:
>
>     [AMD Public Use]
>
>      
>
>     If this causes an issue, any access to vram via the BAR could
>     cause an issue.
>
>      
>
>     Alex
>
>     ------------------------------------------------------------------------
>
>     *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>     <mailto:amd-gfx-bounces@lists.freedesktop.org>> on behalf of
>     Russell, Kent <Kent.Russell@amd.com <mailto:Kent.Russell@amd.com>>
>     *Sent:* Tuesday, April 14, 2020 10:19 AM
>     *To:* Koenig, Christian <Christian.Koenig@amd.com
>     <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
>     *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com
>     <mailto:Felix.Kuehling@amd.com>>; Kim, Jonathan
>     <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
>     *Subject:* RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible
>     in amdgpu_device_vram_access v2"
>
>      
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     On VG20 or MI100, as soon as we run the subtest, we get the dmesg
>     output below, and then the kernel ends up hanging. I don't know
>     enough about the test itself to know why this is occurring, but
>     Jon Kim and Felix were discussing it on a separate thread when the
>     issue was first reported, so they can hopefully provide some
>     additional information.
>
>      Kent
>
>     > -----Original Message-----
>     > From: Christian König <ckoenig.leichtzumerken@gmail.com
>     <mailto:ckoenig.leichtzumerken@gmail.com>>
>     > Sent: Tuesday, April 14, 2020 9:52 AM
>     > To: Russell, Kent <Kent.Russell@amd.com
>     <mailto:Kent.Russell@amd.com>>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     > Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
>     > amdgpu_device_vram_access v2"
>     >
>     > Am 13.04.20 um 20:20 schrieb Kent Russell:
>     > > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
>     > > The original patch causes a RAS event and subsequent kernel
>     hard-hang
>     > > when running the KFDMemoryTest.PtraceAccessInvisibleVram on
>     VG20 and
>     > > Arcturus
>     > >
>     > > dmesg output at hang time:
>     > > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
>     > > amdgpu 0000:67:00.0: GPU reset begin!
>     > > Evicting PASID 0x8000 queues
>     > > Started evicting pasid 0x8000
>     > > qcm fence wait loop timeout expired
>     > > The cp might be in an unrecoverable state due to an unsuccessful
>     > > queues preemption Failed to evict process queues Failed to suspend
>     > > process 0x8000 Finished evicting pasid 0x8000 Started
>     restoring pasid
>     > > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state
>     may lost
>     > > due to RAS ERREVENT_ATHUB_INTERRUPT
>     > > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
>     > > amdgpu: [powerplay] Failed to set soft min gfxclk !
>     > > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
>     > > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
>     > > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable
>     all smu
>     > features!
>     > > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all
>     smu features!
>     > > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
>     > > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend
>     of IP
>     > > block <powerplay> failed -5
>     >
>     > Do you have more information on what's going wrong here since
>     this is a really
>     > important patch for KFD debugging.
>     >
>     > >
>     > > Signed-off-by: Kent Russell <kent.russell@amd.com
>     <mailto:kent.russell@amd.com>>
>     >
>     > Reviewed-by: Christian König <christian.koenig@amd.com
>     <mailto:christian.koenig@amd.com>>
>     >
>     > > ---
>     > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>     ----------------------
>     > >   1 file changed, 26 deletions(-)
>     > >
>     > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > index cf5d6e585634..a3f997f84020 100644
>     > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
>     > amdgpu_device *adev, loff_t pos,
>     > >      uint32_t hi = ~0;
>     > >      uint64_t last;
>     > >
>     > > -
>     > > -#ifdef CONFIG_64BIT
>     > > -   last = min(pos + size, adev->gmc.visible_vram_size);
>     > > -   if (last > pos) {
>     > > -           void __iomem *addr = adev->mman.aper_base_kaddr + pos;
>     > > -           size_t count = last - pos;
>     > > -
>     > > -           if (write) {
>     > > -                   memcpy_toio(addr, buf, count);
>     > > -                   mb();
>     > > -                   amdgpu_asic_flush_hdp(adev, NULL);
>     > > -           } else {
>     > > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
>     > > -                   mb();
>     > > -                   memcpy_fromio(buf, addr, count);
>     > > -           }
>     > > -
>     > > -           if (count == size)
>     > > -                   return;
>     > > -
>     > > -           pos += count;
>     > > -           buf += count / 4;
>     > > -           size -= count;
>     > > -   }
>     > > -#endif
>     > > -
>     > >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
>     > >      for (last = pos + size; pos < last; pos += 4) {
>     > >              uint32_t tmp = pos >> 31;
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=0
>
>  
>
>  
>
> Am 14.04.2020 16:35 schrieb "Deucher, Alexander"
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>:
>
>     [AMD Public Use]
>
>      
>
>     If this causes an issue, any access to vram via the BAR could
>     cause an issue.
>
>      
>
>     Alex
>
>     ------------------------------------------------------------------------
>
>     *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>     <mailto:amd-gfx-bounces@lists.freedesktop.org>> on behalf of
>     Russell, Kent <Kent.Russell@amd.com <mailto:Kent.Russell@amd.com>>
>     *Sent:* Tuesday, April 14, 2020 10:19 AM
>     *To:* Koenig, Christian <Christian.Koenig@amd.com
>     <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
>     *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com
>     <mailto:Felix.Kuehling@amd.com>>; Kim, Jonathan
>     <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
>     *Subject:* RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible
>     in amdgpu_device_vram_access v2"
>
>      
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     On VG20 or MI100, as soon as we run the subtest, we get the dmesg
>     output below, and then the kernel ends up hanging. I don't know
>     enough about the test itself to know why this is occurring, but
>     Jon Kim and Felix were discussing it on a separate thread when the
>     issue was first reported, so they can hopefully provide some
>     additional information.
>
>      Kent
>
>     > -----Original Message-----
>     > From: Christian König <ckoenig.leichtzumerken@gmail.com
>     <mailto:ckoenig.leichtzumerken@gmail.com>>
>     > Sent: Tuesday, April 14, 2020 9:52 AM
>     > To: Russell, Kent <Kent.Russell@amd.com
>     <mailto:Kent.Russell@amd.com>>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     > Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
>     > amdgpu_device_vram_access v2"
>     >
>     > Am 13.04.20 um 20:20 schrieb Kent Russell:
>     > > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
>     > > The original patch causes a RAS event and subsequent kernel
>     hard-hang
>     > > when running the KFDMemoryTest.PtraceAccessInvisibleVram on
>     VG20 and
>     > > Arcturus
>     > >
>     > > dmesg output at hang time:
>     > > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
>     > > amdgpu 0000:67:00.0: GPU reset begin!
>     > > Evicting PASID 0x8000 queues
>     > > Started evicting pasid 0x8000
>     > > qcm fence wait loop timeout expired
>     > > The cp might be in an unrecoverable state due to an unsuccessful
>     > > queues preemption Failed to evict process queues Failed to suspend
>     > > process 0x8000 Finished evicting pasid 0x8000 Started
>     restoring pasid
>     > > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state
>     may lost
>     > > due to RAS ERREVENT_ATHUB_INTERRUPT
>     > > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
>     > > amdgpu: [powerplay] Failed to set soft min gfxclk !
>     > > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
>     > > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
>     > > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable
>     all smu
>     > features!
>     > > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all
>     smu features!
>     > > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
>     > > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend
>     of IP
>     > > block <powerplay> failed -5
>     >
>     > Do you have more information on what's going wrong here since
>     this is a really
>     > important patch for KFD debugging.
>     >
>     > >
>     > > Signed-off-by: Kent Russell <kent.russell@amd.com
>     <mailto:kent.russell@amd.com>>
>     >
>     > Reviewed-by: Christian König <christian.koenig@amd.com
>     <mailto:christian.koenig@amd.com>>
>     >
>     > > ---
>     > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>     ----------------------
>     > >   1 file changed, 26 deletions(-)
>     > >
>     > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > index cf5d6e585634..a3f997f84020 100644
>     > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
>     > amdgpu_device *adev, loff_t pos,
>     > >      uint32_t hi = ~0;
>     > >      uint64_t last;
>     > >
>     > > -
>     > > -#ifdef CONFIG_64BIT
>     > > -   last = min(pos + size, adev->gmc.visible_vram_size);
>     > > -   if (last > pos) {
>     > > -           void __iomem *addr = adev->mman.aper_base_kaddr + pos;
>     > > -           size_t count = last - pos;
>     > > -
>     > > -           if (write) {
>     > > -                   memcpy_toio(addr, buf, count);
>     > > -                   mb();
>     > > -                   amdgpu_asic_flush_hdp(adev, NULL);
>     > > -           } else {
>     > > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
>     > > -                   mb();
>     > > -                   memcpy_fromio(buf, addr, count);
>     > > -           }
>     > > -
>     > > -           if (count == size)
>     > > -                   return;
>     > > -
>     > > -           pos += count;
>     > > -           buf += count / 4;
>     > > -           size -= count;
>     > > -   }
>     > > -#endif
>     > > -
>     > >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
>     > >      for (last = pos + size; pos < last; pos += 4) {
>     > >              uint32_t tmp = pos >> 31;
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=0
>
>  
>
>  
>
> Am 14.04.2020 16:35 schrieb "Deucher, Alexander"
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>:
>
> [AMD Public Use]
>
>  
>
> If this causes an issue, any access to vram via the BAR could cause an
> issue.
>
>  
>
> Alex
>
> ------------------------------------------------------------------------
>
> *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org
> <mailto:amd-gfx-bounces@lists.freedesktop.org>> on behalf of Russell,
> Kent <Kent.Russell@amd.com <mailto:Kent.Russell@amd.com>>
> *Sent:* Tuesday, April 14, 2020 10:19 AM
> *To:* Koenig, Christian <Christian.Koenig@amd.com
> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org>>
> *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com
> <mailto:Felix.Kuehling@amd.com>>; Kim, Jonathan <Jonathan.Kim@amd.com
> <mailto:Jonathan.Kim@amd.com>>
> *Subject:* RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
>  
>
> [AMD Official Use Only - Internal Distribution Only]
>
> On VG20 or MI100, as soon as we run the subtest, we get the dmesg
> output below, and then the kernel ends up hanging. I don't know enough
> about the test itself to know why this is occurring, but Jon Kim and
> Felix were discussing it on a separate thread when the issue was first
> reported, so they can hopefully provide some additional information.
>
>  Kent
>
> > -----Original Message-----
> > From: Christian König <ckoenig.leichtzumerken@gmail.com
> <mailto:ckoenig.leichtzumerken@gmail.com>>
> > Sent: Tuesday, April 14, 2020 9:52 AM
> > To: Russell, Kent <Kent.Russell@amd.com
> <mailto:Kent.Russell@amd.com>>; amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org>
> > Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> > amdgpu_device_vram_access v2"
> >
> > Am 13.04.20 um 20:20 schrieb Kent Russell:
> > > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > > The original patch causes a RAS event and subsequent kernel hard-hang
> > > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > > Arcturus
> > >
> > > dmesg output at hang time:
> > > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > > amdgpu 0000:67:00.0: GPU reset begin!
> > > Evicting PASID 0x8000 queues
> > > Started evicting pasid 0x8000
> > > qcm fence wait loop timeout expired
> > > The cp might be in an unrecoverable state due to an unsuccessful
> > > queues preemption Failed to evict process queues Failed to suspend
> > > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > > due to RAS ERREVENT_ATHUB_INTERRUPT
> > > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> > features!
> > > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu
> features!
> > > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > > block <powerplay> failed -5
> >
> > Do you have more information on what's going wrong here since this
> is a really
> > important patch for KFD debugging.
> >
> > >
> > > Signed-off-by: Kent Russell <kent.russell@amd.com
> <mailto:kent.russell@amd.com>>
> >
> > Reviewed-by: Christian König <christian.koenig@amd.com
> <mailto:christian.koenig@amd.com>>
> >
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
> ----------------------
> > >   1 file changed, 26 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index cf5d6e585634..a3f997f84020 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> > amdgpu_device *adev, loff_t pos,
> > >      uint32_t hi = ~0;
> > >      uint64_t last;
> > >
> > > -
> > > -#ifdef CONFIG_64BIT
> > > -   last = min(pos + size, adev->gmc.visible_vram_size);
> > > -   if (last > pos) {
> > > -           void __iomem *addr = adev->mman.aper_base_kaddr + pos;
> > > -           size_t count = last - pos;
> > > -
> > > -           if (write) {
> > > -                   memcpy_toio(addr, buf, count);
> > > -                   mb();
> > > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > > -           } else {
> > > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > > -                   mb();
> > > -                   memcpy_fromio(buf, addr, count);
> > > -           }
> > > -
> > > -           if (count == size)
> > > -                   return;
> > > -
> > > -           pos += count;
> > > -           buf += count / 4;
> > > -           size -= count;
> > > -   }
> > > -#endif
> > > -
> > >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> > >      for (last = pos + size; pos < last; pos += 4) {
> > >              uint32_t tmp = pos >> 31;
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=0
>

--------------3EF3B952633FF988AB53BD84
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>I wouldn't call it premature. Revert is a usual practice when
      there is a serious regression that isn't fully understood or
      root-caused. As far as I can tell, the problem has been reproduced
      on multiple systems, different GPUs, and clearly regressed to
      Christian's commit. I think that justifies reverting it for now.<br>
    </p>
    <p>I agree with Christian that a general HDP memory access problem
      causing RAS errors would potentially cause problems in other tests
      as well. For example common operations like GART table updates,
      and GPUVM page table updates and PCIe peer2peer accesses in ROCm
      applications use HDP. But we're not seeing obvious problems from
      those. So we need to understand what's special about this test. I
      asked questions to that effect on our other email thread.</p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <div class="moz-cite-prefix">Am 2020-04-14 um 10:51 a.m. schrieb
      Kim, Jonathan:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB451836BC6F9C0F002EE1C3D685DA0@MN2PR12MB4518.namprd12.prod.outlook.com">
      
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
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
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
        <p class="MsoNormal">I think it’s premature to push this revert.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">With more testing, I’m getting failures
          from different tests or sometimes none at all on my machine.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Kent, let’s continue the discussion on the
          original thread.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Thanks,<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Jon<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a> <br>
              <b>Sent:</b> Tuesday, April 14, 2020 10:47 AM<br>
              <b>To:</b> Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
              <b>Cc:</b> Russell, Kent <a class="moz-txt-link-rfc2396E" href="mailto:Kent.Russell@amd.com">&lt;Kent.Russell@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Kuehling, Felix
              <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Kim, Jonathan
              <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the
              BAR if possible in amdgpu_device_vram_access v2&quot;<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div>
            <div>
              <div>
                <div>
                  <p class="MsoNormal">That's exactly my concern as
                    well. <o:p></o:p></p>
                  <div>
                    <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal">This looks a bit like the test
                      creates erroneous data somehow, but there doesn't
                      seems to be a RAS check in the MM data path.<o:p></o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal">And now that we use the BAR
                      path it goes up in flames.<o:p></o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal">I just don't see how we can
                      create erroneous data in a test case?<o:p></o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal">Christian.<o:p></o:p></p>
                  </div>
                </div>
                <div>
                  <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                  <div>
                    <p class="MsoNormal">Am 14.04.2020 16:35 schrieb
                      &quot;Deucher, Alexander&quot; &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
                    <blockquote style="border:none;border-left:solid
                      #CCCCCC 1.0pt;padding:0in 0in 0in
6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-bottom:5.0pt">
                      <div>
                        <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
                            Public Use]<o:p></o:p></span></p>
                        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                        <div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;color:black">If
                                this causes an issue, any access to vram
                                via the BAR could cause an issue.<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
                          </div>
                          <div class="MsoNormal" style="text-align:center" align="center">
                            <hr width="98%" size="2" align="center">
                          </div>
                          <div>
                            <p class="MsoNormal"><b><span style="color:black">From:</span></b><span style="color:black"> amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                                on behalf of Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;<br>
                                <b>Sent:</b> Tuesday, April 14, 2020
                                10:19 AM<br>
                                <b>To:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                                <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                                &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                                <b>Cc:</b> Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                                Kim, Jonathan &lt;<a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">Jonathan.Kim@amd.com</a>&gt;<br>
                                <b>Subject:</b> RE: [PATCH] Revert
                                &quot;drm/amdgpu: use the BAR if possible in
                                amdgpu_device_vram_access v2&quot;</span>
                              <o:p></o:p></p>
                            <div>
                              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                            </div>
                          </div>
                          <div>
                            <div>
                              <p class="MsoNormal">[AMD Official Use
                                Only - Internal Distribution Only]<br>
                                <br>
                                On VG20 or MI100, as soon as we run the
                                subtest, we get the dmesg output below,
                                and then the kernel ends up hanging. I
                                don't know enough about the test itself
                                to know why this is occurring, but Jon
                                Kim and Felix were discussing it on a
                                separate thread when the issue was first
                                reported, so they can hopefully provide
                                some additional information.<br>
                                <br>
                                &nbsp;Kent<br>
                                <br>
                                &gt; -----Original Message-----<br>
                                &gt; From: Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                                &gt; Sent: Tuesday, April 14, 2020 9:52
                                AM<br>
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
                                &gt; &gt; The original patch causes a
                                RAS event and subsequent kernel
                                hard-hang<br>
                                &gt; &gt; when running the
                                KFDMemoryTest.PtraceAccessInvisibleVram
                                on VG20 and<br>
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
                                unrecoverable state due to an
                                unsuccessful<br>
                                &gt; &gt; queues preemption Failed to
                                evict process queues Failed to suspend<br>
                                &gt; &gt; process 0x8000 Finished
                                evicting pasid 0x8000 Started restoring
                                pasid<br>
                                &gt; &gt; 0x8000 Finished restoring
                                pasid 0x8000 [drm] UVD VCPU state may
                                lost<br>
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
                                [DisableAllSMUFeatures] Failed to
                                disable all smu<br>
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
                                &gt; &gt; Signed-off-by: Kent Russell
                                &lt;<a href="mailto:kent.russell@amd.com" moz-do-not-send="true">kent.russell@amd.com</a>&gt;<br>
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
                                &gt; &gt; index
                                cf5d6e585634..a3f997f84020 100644<br>
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
                                &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void __iomem *addr
                                = adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
                                &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count =
                                last - pos;<br>
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
                                &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last = pos &#43; size;
                                pos &lt; last; pos &#43;= 4) {<br>
                                &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp =
                                pos &gt;&gt; 31;<br>
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
                  <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                </div>
              </div>
              <div>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                <div>
                  <p class="MsoNormal">Am 14.04.2020 16:35 schrieb
                    &quot;Deucher, Alexander&quot; &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
                  <blockquote style="border:none;border-left:solid
                    #CCCCCC 1.0pt;padding:0in 0in 0in
6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-bottom:5.0pt">
                    <div>
                      <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
                          Public Use]<o:p></o:p></span></p>
                      <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                      <div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;color:black">If
                              this causes an issue, any access to vram
                              via the BAR could cause an issue.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
                        </div>
                        <div class="MsoNormal" style="text-align:center" align="center">
                          <hr width="98%" size="2" align="center">
                        </div>
                        <div>
                          <p class="MsoNormal"><b><span style="color:black">From:</span></b><span style="color:black"> amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
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
                              amdgpu_device_vram_access v2&quot;</span>
                            <o:p></o:p></p>
                          <div>
                            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                          </div>
                        </div>
                        <div>
                          <div>
                            <p class="MsoNormal">[AMD Official Use Only
                              - Internal Distribution Only]<br>
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
                </div>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              </div>
            </div>
            <div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal">Am 14.04.2020 16:35 schrieb
                  &quot;Deucher, Alexander&quot; &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
                <blockquote style="border:none;border-left:solid #CCCCCC
                  1.0pt;padding:0in 0in 0in
6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-bottom:5.0pt">
                  <div>
                    <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
                        Public Use]<o:p></o:p></span></p>
                    <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                    <div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;color:black">If this
                            causes an issue, any access to vram via the
                            BAR could cause an issue.<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span style="font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
                      </div>
                      <div class="MsoNormal" style="text-align:center" align="center">
                        <hr width="98%" size="2" align="center">
                      </div>
                      <div>
                        <p class="MsoNormal"><b><span style="color:black">From:</span></b><span style="color:black"> amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
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
                            amdgpu_device_vram_access v2&quot;</span>
                          <o:p></o:p></p>
                        <div>
                          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                        </div>
                      </div>
                      <div>
                        <div>
                          <p class="MsoNormal">[AMD Official Use Only -
                            Internal Distribution Only]<br>
                            <br>
                            On VG20 or MI100, as soon as we run the
                            subtest, we get the dmesg output below, and
                            then the kernel ends up hanging. I don't
                            know enough about the test itself to know
                            why this is occurring, but Jon Kim and Felix
                            were discussing it on a separate thread when
                            the issue was first reported, so they can
                            hopefully provide some additional
                            information.<br>
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
                            &gt; &gt; queues preemption Failed to evict
                            process queues Failed to suspend<br>
                            &gt; &gt; process 0x8000 Finished evicting
                            pasid 0x8000 Started restoring pasid<br>
                            &gt; &gt; 0x8000 Finished restoring pasid
                            0x8000 [drm] UVD VCPU state may lost<br>
                            &gt; &gt; due to RAS
                            ERREVENT_ATHUB_INTERRUPT<br>
                            &gt; &gt; amdgpu: [powerplay] Failed to send
                            message 0x26, response 0x0<br>
                            &gt; &gt; amdgpu: [powerplay] Failed to set
                            soft min gfxclk !<br>
                            &gt; &gt; amdgpu: [powerplay] Failed to
                            upload DPM Bootup Levels!<br>
                            &gt; &gt; amdgpu: [powerplay] Failed to send
                            message 0x7, response 0x0<br>
                            &gt; &gt; amdgpu: [powerplay]
                            [DisableAllSMUFeatures] Failed to disable
                            all smu<br>
                            &gt; features!<br>
                            &gt; &gt; amdgpu: [powerplay]
                            [DisableDpmTasks] Failed to disable all smu
                            features!<br>
                            &gt; &gt; amdgpu: [powerplay] [PowerOffAsic]
                            Failed to disable DPM!<br>
                            &gt; &gt;
                            [drm:amdgpu_device_ip_suspend_phase2
                            [amdgpu]] *ERROR* suspend of IP<br>
                            &gt; &gt; block &lt;powerplay&gt; failed -5<br>
                            &gt; <br>
                            &gt; Do you have more information on what's
                            going wrong here since this is a really<br>
                            &gt; important patch for KFD debugging.<br>
                            &gt; <br>
                            &gt; &gt;<br>
                            &gt; &gt; Signed-off-by: Kent Russell &lt;<a href="mailto:kent.russell@amd.com" moz-do-not-send="true">kent.russell@amd.com</a>&gt;<br>
                            &gt; <br>
                            &gt; Reviewed-by: Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                            &gt; <br>
                            &gt; &gt; ---<br>
                            &gt; &gt;&nbsp;&nbsp;
                            drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |
                            26 ----------------------<br>
                            &gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
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
                            &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count = last -
                            pos;<br>
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
              </div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            </div>
          </div>
          <div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <div>
              <p class="MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher,
                Alexander&quot; &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
              <blockquote style="border:none;border-left:solid #CCCCCC
                1.0pt;padding:0in 0in 0in
6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-bottom:5.0pt">
                <div>
                  <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
                      Public Use]<o:p></o:p></span></p>
                  <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                  <div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;color:black">If this
                          causes an issue, any access to vram via the
                          BAR could cause an issue.<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span style="font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
                    </div>
                    <div class="MsoNormal" style="text-align:center" align="center">
                      <hr width="98%" size="2" align="center">
                    </div>
                    <div>
                      <p class="MsoNormal"><b><span style="color:black">From:</span></b><span style="color:black"> amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                          on behalf of Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;<br>
                          <b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
                          <b>To:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                          &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                          <b>Cc:</b> Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                          Kim, Jonathan &lt;<a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">Jonathan.Kim@amd.com</a>&gt;<br>
                          <b>Subject:</b> RE: [PATCH] Revert
                          &quot;drm/amdgpu: use the BAR if possible in
                          amdgpu_device_vram_access v2&quot;</span>
                        <o:p></o:p></p>
                      <div>
                        <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                      </div>
                    </div>
                    <div>
                      <div>
                        <p class="MsoNormal">[AMD Official Use Only -
                          Internal Distribution Only]<br>
                          <br>
                          On VG20 or MI100, as soon as we run the
                          subtest, we get the dmesg output below, and
                          then the kernel ends up hanging. I don't know
                          enough about the test itself to know why this
                          is occurring, but Jon Kim and Felix were
                          discussing it on a separate thread when the
                          issue was first reported, so they can
                          hopefully provide some additional information.<br>
                          <br>
                          &nbsp;Kent<br>
                          <br>
                          &gt; -----Original Message-----<br>
                          &gt; From: Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                          &gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
                          &gt; To: Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;;
                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                          &gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu:
                          use the BAR if possible in<br>
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
                          &gt; &gt; qcm fence wait loop timeout expired<br>
                          &gt; &gt; The cp might be in an unrecoverable
                          state due to an unsuccessful<br>
                          &gt; &gt; queues preemption Failed to evict
                          process queues Failed to suspend<br>
                          &gt; &gt; process 0x8000 Finished evicting
                          pasid 0x8000 Started restoring pasid<br>
                          &gt; &gt; 0x8000 Finished restoring pasid
                          0x8000 [drm] UVD VCPU state may lost<br>
                          &gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
                          &gt; &gt; amdgpu: [powerplay] Failed to send
                          message 0x26, response 0x0<br>
                          &gt; &gt; amdgpu: [powerplay] Failed to set
                          soft min gfxclk !<br>
                          &gt; &gt; amdgpu: [powerplay] Failed to upload
                          DPM Bootup Levels!<br>
                          &gt; &gt; amdgpu: [powerplay] Failed to send
                          message 0x7, response 0x0<br>
                          &gt; &gt; amdgpu: [powerplay]
                          [DisableAllSMUFeatures] Failed to disable all
                          smu<br>
                          &gt; features!<br>
                          &gt; &gt; amdgpu: [powerplay]
                          [DisableDpmTasks] Failed to disable all smu
                          features!<br>
                          &gt; &gt; amdgpu: [powerplay] [PowerOffAsic]
                          Failed to disable DPM!<br>
                          &gt; &gt; [drm:amdgpu_device_ip_suspend_phase2
                          [amdgpu]] *ERROR* suspend of IP<br>
                          &gt; &gt; block &lt;powerplay&gt; failed -5<br>
                          &gt; <br>
                          &gt; Do you have more information on what's
                          going wrong here since this is a really<br>
                          &gt; important patch for KFD debugging.<br>
                          &gt; <br>
                          &gt; &gt;<br>
                          &gt; &gt; Signed-off-by: Kent Russell &lt;<a href="mailto:kent.russell@amd.com" moz-do-not-send="true">kent.russell@amd.com</a>&gt;<br>
                          &gt; <br>
                          &gt; Reviewed-by: Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                          &gt; <br>
                          &gt; &gt; ---<br>
                          &gt; &gt;&nbsp;&nbsp;
                          drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |
                          26 ----------------------<br>
                          &gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
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
                          &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count = last -
                          pos;<br>
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
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          </div>
        </div>
        <div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div>
            <p class="MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher,
              Alexander&quot; &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
          </div>
        </div>
        <div>
          <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
              Public Use]<o:p></o:p></span></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;color:black">If this causes an
                  issue, any access to vram via the BAR could cause an
                  issue.<o:p></o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
            </div>
            <div class="MsoNormal" style="text-align:center" align="center">
              <hr width="98%" size="2" align="center">
            </div>
            <div id="divRplyFwdMsg">
              <p class="MsoNormal"><b><span style="color:black">From:</span></b><span style="color:black"> amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                  on behalf of Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;<br>
                  <b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
                  <b>To:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                  <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                  &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                  <b>Cc:</b> Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                  Kim, Jonathan &lt;<a href="mailto:Jonathan.Kim@amd.com" moz-do-not-send="true">Jonathan.Kim@amd.com</a>&gt;<br>
                  <b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use
                  the BAR if possible in amdgpu_device_vram_access v2&quot;</span>
                <o:p></o:p></p>
              <div>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              </div>
            </div>
            <div>
              <div>
                <p class="MsoNormal">[AMD Official Use Only - Internal
                  Distribution Only]<br>
                  <br>
                  On VG20 or MI100, as soon as we run the subtest, we
                  get the dmesg output below, and then the kernel ends
                  up hanging. I don't know enough about the test itself
                  to know why this is occurring, but Jon Kim and Felix
                  were discussing it on a separate thread when the issue
                  was first reported, so they can hopefully provide some
                  additional information.<br>
                  <br>
                  &nbsp;Kent<br>
                  <br>
                  &gt; -----Original Message-----<br>
                  &gt; From: Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                  &gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
                  &gt; To: Russell, Kent &lt;<a href="mailto:Kent.Russell@amd.com" moz-do-not-send="true">Kent.Russell@amd.com</a>&gt;;
                  <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                  &gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the
                  BAR if possible in<br>
                  &gt; amdgpu_device_vram_access v2&quot;<br>
                  &gt; <br>
                  &gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
                  &gt; &gt; This reverts commit
                  c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
                  &gt; &gt; The original patch causes a RAS event and
                  subsequent kernel hard-hang<br>
                  &gt; &gt; when running the
                  KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and<br>
                  &gt; &gt; Arcturus<br>
                  &gt; &gt;<br>
                  &gt; &gt; dmesg output at hang time:<br>
                  &gt; &gt; [drm] RAS event of type
                  ERREVENT_ATHUB_INTERRUPT detected!<br>
                  &gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
                  &gt; &gt; Evicting PASID 0x8000 queues<br>
                  &gt; &gt; Started evicting pasid 0x8000<br>
                  &gt; &gt; qcm fence wait loop timeout expired<br>
                  &gt; &gt; The cp might be in an unrecoverable state
                  due to an unsuccessful<br>
                  &gt; &gt; queues preemption Failed to evict process
                  queues Failed to suspend<br>
                  &gt; &gt; process 0x8000 Finished evicting pasid
                  0x8000 Started restoring pasid<br>
                  &gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm]
                  UVD VCPU state may lost<br>
                  &gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
                  &gt; &gt; amdgpu: [powerplay] Failed to send message
                  0x26, response 0x0<br>
                  &gt; &gt; amdgpu: [powerplay] Failed to set soft min
                  gfxclk !<br>
                  &gt; &gt; amdgpu: [powerplay] Failed to upload DPM
                  Bootup Levels!<br>
                  &gt; &gt; amdgpu: [powerplay] Failed to send message
                  0x7, response 0x0<br>
                  &gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures]
                  Failed to disable all smu<br>
                  &gt; features!<br>
                  &gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed
                  to disable all smu features!<br>
                  &gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to
                  disable DPM!<br>
                  &gt; &gt; [drm:amdgpu_device_ip_suspend_phase2
                  [amdgpu]] *ERROR* suspend of IP<br>
                  &gt; &gt; block &lt;powerplay&gt; failed -5<br>
                  &gt; <br>
                  &gt; Do you have more information on what's going
                  wrong here since this is a really<br>
                  &gt; important patch for KFD debugging.<br>
                  &gt; <br>
                  &gt; &gt;<br>
                  &gt; &gt; Signed-off-by: Kent Russell &lt;<a href="mailto:kent.russell@amd.com" moz-do-not-send="true">kent.russell@amd.com</a>&gt;<br>
                  &gt; <br>
                  &gt; Reviewed-by: Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                  &gt; <br>
                  &gt; &gt; ---<br>
                  &gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                  | 26 ----------------------<br>
                  &gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
                  &gt; &gt;<br>
                  &gt; &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                  &gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
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
                  &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count = last - pos;<br>
                  &gt; &gt; -<br>
                  &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write) {<br>
                  &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf,
                  count);<br>
                  &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
                  &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  amdgpu_asic_flush_hdp(adev, NULL);<br>
                  &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                  &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  amdgpu_asic_invalidate_hdp(adev, NULL);<br>
                  &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
                  &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr,
                  count);<br>
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
                  spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock, flags);<br>
                  &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last = pos &#43; size; pos &lt; last;
                  pos &#43;= 4) {<br>
                  &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp = pos &gt;&gt; 31;<br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                  <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=0</a><o:p></o:p></p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------3EF3B952633FF988AB53BD84--

--===============0375679975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0375679975==--
