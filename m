Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DBBC35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4244B2073A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r0OSMei8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4244B2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3866F487;
	Fri, 21 Feb 2020 15:33:34 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700087.outbound.protection.outlook.com [40.107.70.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4B86F485
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 15:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC4kREibKm2zXkX+hrjtjwNdzcfvDe6ufbteJAdoeNrdP3fW7GTi7E9Mgl159Y6XapKnQOZEjPq4Lo3RGr4BfhQxjZ/JLdSFHZGjEAI0wmWNDvkQsEx3YsgFN7zJOfFICwre9SxrbURMihpqXGGAhUEK4EKbJAodMQzNrFOrOnyouXr4Xf/pm8R6M+1aYsTSc7nhKw3Z1H3YjmxZskRqtNG3LCJLVjkM9vRKFYvpR/MtqDWxYduiDuZpcXayoumJEZPcLvwyYVEfHdnXKRCd3vame+zJq+WeA6sLlikSUVBBBtjbex30z3B14REyMLy8v3lECtNoh3ZiqnOZQOn7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd96c6LSiQx5A7IiwGMzNyzh8GIuRKbrA7uc44qc7xI=;
 b=QP6U83hzPmq9WfUNiTofmhhYDLgg5lWL+4fWrW/X9Zx8hTCbrUSn+xU0QHxY13PetsQy8HwKUAzHeIEK7J4+4kqu/aAE5/mG+FwYCOIJOo2ui4iChzzlypsqGifiNPnapU642a9NLgkZr2KifvgENdkepxReeRhrxkNkAdy5f+vZOmWEem4kxLfdjSz+jg/HLsmuu+8dgYnpQCtTtcM+KWCNvEO/Nh53XeRbk6mjweEkqXbmzVIZAt/qBDb6oVHbDhH1joaF8Jw0poOT3ljQSS1mfz/tH4nYzC4xfBvaN6vGoyB5Qeb48YLutPP6VCF/StJfO9XSmdE8aOW40aMfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd96c6LSiQx5A7IiwGMzNyzh8GIuRKbrA7uc44qc7xI=;
 b=r0OSMei8XqYPUymBRK5UjSjfehMFipauZDz5kUjHA73+/jaIH+HDuo/2Ik6o1UGAI0ro8Mpk+pvlJWzcJs5FeLD7uhSy94FfPuArtL/VaQKmlr91FUWsLDjdAzXOltd3E1SPoo64aAvz3qzBleWyJ9hyPM9ohucUY1UhVCeqTRM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1865.namprd12.prod.outlook.com (10.175.87.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 21 Feb 2020 15:33:31 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2729.032; Fri, 21 Feb
 2020 15:33:30 +0000
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "He, Jacob"
 <Jacob.He@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200219101506.16779-1-jacob.he@amd.com>
 <e2fea4f5-0eea-75b5-9cd7-68b603629d8d@gmail.com>
 <MWHPR12MB1406B3418562F0692572C511B4130@MWHPR12MB1406.namprd12.prod.outlook.com>
 <MN2PR12MB337663C5CCF3D53744FD377D9B130@MN2PR12MB3376.namprd12.prod.outlook.com>
 <MN2PR12MB3376E699E0A85E8065D3E72D9B130@MN2PR12MB3376.namprd12.prod.outlook.com>
 <MWHPR12MB140699AA6711A7E6876C56E5B4130@MWHPR12MB1406.namprd12.prod.outlook.com>
 <e09919bf-f084-55ed-04a7-f52bec5b0be9@gmail.com>
 <CH2PR12MB3912AE29A4EBF30B5826CCC2F7120@CH2PR12MB3912.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1b15e97e-2a19-70dc-d9da-672e337e2d15@amd.com>
Date: Fri, 21 Feb 2020 16:33:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CH2PR12MB3912AE29A4EBF30B5826CCC2F7120@CH2PR12MB3912.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::15) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0028.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Fri, 21 Feb 2020 15:33:29 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77bd5431-ce7d-4818-9d4b-08d7b6e36750
X-MS-TrafficTypeDiagnostic: DM5PR12MB1865:|DM5PR12MB1865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18656F1BB4D4B46FA0B15E7183120@DM5PR12MB1865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(199004)(189003)(16526019)(186003)(19627235002)(36756003)(2906002)(966005)(31696002)(86362001)(8936002)(45080400002)(30864003)(316002)(2616005)(5660300002)(110136005)(6486002)(66574012)(53546011)(52116002)(6666004)(478600001)(19627405001)(66946007)(66556008)(66476007)(31686004)(8676002)(81166006)(81156014)(559001)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1865;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baLr6ph1iDrrcCT0tXis/AGAPjFTMGwx/A5hbFr1jLqcAyV0RoM2erHgt5dbJmJwbKCkNPSUNWOyv68s+uHjBrdKelOaaNVKK2Alij5zVlV1q2uGwBWdqugJFU2lSlxaBPbKxuXPj+xrfJc8KJncfuQitkOxiuCtIXT0HC+2Rzp90SQpcwNVt6ub3HjYbT9hGuwC5fZLZHpzCXc43DHFvzX7g+uu75zdxNpplmaBjI6Ze8TesuR1JDaYdf6RUl7sVdBYEBM25tgaz+D/+OIIEIe86bqg2ILnbZ8vGeP53mmVKcJ5ELfGKxcGBCIpCW1ujrSqaOogJOEDkEREo4ldb9MXIwmU+cqoOkBO3HzmCRViWlWGyjVnnAZk+cOBGo5S6olfFi4VpA9MP4Sgdr5NgI/yQGqC5bo7aAQ7CCPzbSuZ7QC2TXMmw3PL9+x1v21rUrnMAFck4MB968Pkl//biKW1D3mRPATPGJ0Z/fU7r/sEDu143ulDd31l9w+CrhzhjgOZzvqzD4Q2LTvwyLLaIA==
X-MS-Exchange-AntiSpam-MessageData: WH64fSeBKXw8s63Vl4Jy6fU36PQxYmCj/O0OfTjv7Q9Rq+VvVmtCqzYtiJdMdct3cqUB/TgLHijROTzJut3Ax74zPmYclLal+kPV2ow6yufRCKZbjGp14vtOFd0jMwdeLbqbLZithD2sRbUqm6bqArpApV5fmZ4yChEwJGMcvIoojV7O7Tfu9iUmtgDp2dd9NNFb4gQMITEKxwhFgiLDsQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bd5431-ce7d-4818-9d4b-08d7b6e36750
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 15:33:30.8480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYfMhEXAy/sZKRbpHoTLt8evHgyQaMb+WPlM2UD/nNqgTI5mYRQmPL3EQzKbBrsU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1865
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
Content-Type: multipart/mixed; boundary="===============2070955054=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2070955054==
Content-Type: multipart/alternative;
 boundary="------------D5C9C4A29AF98035ACE835EA"
Content-Language: en-US

--------------D5C9C4A29AF98035ACE835EA
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

I would just do this as part of the vm_flush() callback on the ring.

E.g. check if the VMID you want to flush is reserved and if yes enable SPM.

Maybe pass along a flag or something in the job to make things easier.

Christian.

Am 21.02.20 um 16:31 schrieb Deucher, Alexander:
>
> [AMD Public Use]
>
>
> We already have the RESERVE_VMID ioctl interface, can't we just use 
> that internally in the kernel to update the rlc register via the ring 
> when we schedule the relevant IB?  E.g., add a new ring callback to 
> set SPM state and then set it to the reserved vmid before we schedule 
> the ib, and then reset it to 0 after the IB in amdgpu_ib_schedule().
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 4b2342d11520..e0db9362c6ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -185,6 +185,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, 
> unsigned num_ibs,
>         if (ring->funcs->insert_start)
>                 ring->funcs->insert_start(ring);
>
> +       if (ring->funcs->setup_spm)
> +               ring->funcs->setup_spm(ring, job);
> +
>         if (job) {
>                 r = amdgpu_vm_flush(ring, job, need_pipe_sync);
>                 if (r) {
> @@ -273,6 +276,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, 
> unsigned num_ibs,
>                 return r;
>         }
>
> +       if (ring->funcs->setup_spm)
> +               ring->funcs->setup_spm(ring, NULL);
> +
>         if (ring->funcs->insert_end)
>                 ring->funcs->insert_end(ring);
>
>
>
> Alex
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Friday, February 21, 2020 5:28 AM
> *To:* Zhou, David(ChunMing) <David1.Zhou@amd.com>; He, Jacob 
> <Jacob.He@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
> That would probably be a no-go, but we could enhance the kernel driver 
> to update the RLC_SPM_VMID register with the reserved VMID.
>
> Handling that in userspace is most likely not working anyway, since 
> the RLC registers are usually not accessible by userspace.
>
> Regards,
> Christian.
>
> Am 20.02.20 um 16:15 schrieb Zhou, David(ChunMing):
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> You can enhance amdgpu_vm_ioctl In amdgpu_vm.c to return vmid to 
>> userspace.
>>
>> -David
>>
>> *From:* He, Jacob <Jacob.He@amd.com> <mailto:Jacob.He@amd.com>
>> *Sent:* Thursday, February 20, 2020 10:46 PM
>> *To:* Zhou, David(ChunMing) <David1.Zhou@amd.com> 
>> <mailto:David1.Zhou@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com> <mailto:Christian.Koenig@amd.com>; 
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> *Subject:* RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>>
>> amdgpu_vm_reserve_vmid doesn’t return the reserved vmid back to user 
>> space. There is no chance for user mode driver to update RLC_SPM_VMID.
>>
>> Thanks
>>
>> Jacob
>>
>> *From: *He, Jacob <mailto:Jacob.He@amd.com>
>> *Sent: *Thursday, February 20, 2020 6:20 PM
>> *To: *Zhou, David(ChunMing) <mailto:David1.Zhou@amd.com>; Koenig, 
>> Christian <mailto:Christian.Koenig@amd.com>; 
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> *Subject: *RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>>
>> Looks like amdgpu_vm_reserve_vmid could work, let me have a try to 
>> update the RLC_SPM_VMID with pm4 packets in UMD.
>>
>> Thanks
>>
>> Jacob
>>
>> *From: *Zhou, David(ChunMing) <mailto:David1.Zhou@amd.com>
>> *Sent: *Thursday, February 20, 2020 10:13 AM
>> *To: *Koenig, Christian <mailto:Christian.Koenig@amd.com>; He, Jacob 
>> <mailto:Jacob.He@amd.com>; amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org>
>> *Subject: *RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Christian is right here, that will cause many problems for simply 
>> using VMID in kernel.
>> We already have an pair interface for RGP, I think you can use it 
>> instead of involving additional kernel change.
>> amdgpu_vm_reserve_vmid/ amdgpu_vm_unreserve_vmid.
>>
>> -David
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org 
>> <mailto:amd-gfx-bounces@lists.freedesktop.org>> On Behalf Of 
>> Christian König
>> Sent: Wednesday, February 19, 2020 7:03 PM
>> To: He, Jacob <Jacob.He@amd.com <mailto:Jacob.He@amd.com>>; 
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>>
>> Am 19.02.20 um 11:15 schrieb Jacob He:
>> > [WHY]
>> > When SPM trace enabled, SPM_VMID should be updated with the current
>> > vmid.
>> >
>> > [HOW]
>> > Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can tell us
>> > which job should update SPM_VMID.
>> > Right before a job is submitted to GPU, set the SPM_VMID accordingly.
>> >
>> > [Limitation]
>> > Running more than one SPM trace enabled processes simultaneously is
>> > not supported.
>>
>> Well there are multiple problems with that patch.
>>
>> First of all you need to better describe what SPM tracing is in the 
>> commit message.
>>
>> Then the updating of mmRLC_SPM_MC_CNTL must be executed 
>> asynchronously on the ring. Otherwise we might corrupt an already 
>> executing SPM trace.
>>
>> And you also need to make sure to disable the tracing again or 
>> otherwise we run into a bunch of trouble when the VMID is reused.
>>
>> You also need to make sure that IBs using the SPM trace are 
>> serialized with each other, e.g. hack into amdgpu_ids.c file and make 
>> sure that only one VMID at a time can have that attribute.
>>
>> Regards,
>> Christian.
>>
>> >
>> > Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666
>> > Signed-off-by: Jacob He <jacob.he@amd.com <mailto:jacob.he@amd.com>>
>> > ---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  7 +++++++
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 10 +++++++---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  1 +
>> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15 ++++++++++++++-
>> >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  3 ++-
>> >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  3 ++-
>> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15 ++++++++++++++-
>> >   8 files changed, 48 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > index f9fa6e104fef..3f32c4db5232 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > @@ -113,6 +113,7 @@ static int amdgpu_cs_parser_init(struct 
>> amdgpu_cs_parser *p, union drm_amdgpu_cs
>> >        uint32_t uf_offset = 0;
>> >        int i;
>> >        int ret;
>> > +     bool update_spm_vmid = false;
>> >
>> >        if (cs->in.num_chunks == 0)
>> >                return 0;
>> > @@ -221,6 +222,10 @@ static int amdgpu_cs_parser_init(struct 
>> amdgpu_cs_parser *p, union drm_amdgpu_cs
>> >                case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
>> >                        break;
>> >
>> > +             case AMDGPU_CHUNK_ID_SPM_TRACE:
>> > +                     update_spm_vmid = true;
>> > +                     break;
>> > +
>> >                default:
>> >                        ret = -EINVAL;
>> >                        goto free_partial_kdata;
>> > @@ -231,6 +236,8 @@ static int amdgpu_cs_parser_init(struct 
>> amdgpu_cs_parser *p, union drm_amdgpu_cs
>> >        if (ret)
>> >                goto free_all_kdata;
>> >
>> > +     p->job->need_update_spm_vmid = update_spm_vmid;
>> > +
>> >        if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
>> >                ret = -ECANCELED;
>> >                goto free_all_kdata;
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> > index cae81914c821..36faab12b585 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> > @@ -156,9 +156,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring 
>> *ring, unsigned num_ibs,
>> >                return -EINVAL;
>> >        }
>> >
>> > -     if (vm && !job->vmid) {
>> > -             dev_err(adev->dev, "VM IB without ID\n");
>> > -             return -EINVAL;
>> > +     if (vm) {
>> > +             if (!job->vmid) {
>> > +                     dev_err(adev->dev, "VM IB without ID\n");
>> > +                     return -EINVAL;
>> > +             } else if (adev->gfx.rlc.funcs->update_spm_vmid && 
>> job->need_update_spm_vmid) {
>> > + adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
>> > +             }
>> >        }
>> >
>> >        alloc_size = ring->funcs->emit_frame_size + num_ibs * diff 
>> --git
>> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> > index 2e2110dddb76..4582536961c7 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> > @@ -52,6 +52,7 @@ struct amdgpu_job {
>> >        bool                    vm_needs_flush;
>> >        uint64_t                vm_pd_addr;
>> >        unsigned                vmid;
>> > +     bool                    need_update_spm_vmid;
>> >        unsigned                pasid;
>> >        uint32_t                gds_base, gds_size;
>> >        uint32_t                gws_base, gws_size;
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>> > index d3d4707f2168..52509c254cbd 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>> > @@ -126,6 +126,7 @@ struct amdgpu_rlc_funcs {
>> >        void (*stop)(struct amdgpu_device *adev);
>> >        void (*reset)(struct amdgpu_device *adev);
>> >        void (*start)(struct amdgpu_device *adev);
>> > +     void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned 
>> vmid);
>> >   };
>> >
>> >   struct amdgpu_rlc {
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> > index 5e9fb0976c6c..91eb788d6229 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> > @@ -4214,6 +4214,18 @@ static int 
>> gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>> >        return 0;
>> >   }
>> >
>> > +static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev,
>> > +unsigned vmid) {
>> > +     u32 data;
>> > +
>> > +     data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
>> > +
>> > +     data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
>> > +     data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) <<
>> > +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
>> > +
>> > +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
>> > +
>> >   static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
>> >        .is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
>> >        .set_safe_mode = gfx_v10_0_set_safe_mode, @@ -4224,7 +4236,8 @@
>> > static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
>> >        .resume = gfx_v10_0_rlc_resume,
>> >        .stop = gfx_v10_0_rlc_stop,
>> >        .reset = gfx_v10_0_rlc_reset,
>> > -     .start = gfx_v10_0_rlc_start
>> > +     .start = gfx_v10_0_rlc_start,
>> > +     .update_spm_vmid = gfx_v10_0_update_spm_vmid
>> >   };
>> >
>> >   static int gfx_v10_0_set_powergating_state(void *handle, diff --git
>> > a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> > index 8f20a5dd44fe..b24fc55cf13a 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> > @@ -4221,7 +4221,8 @@ static const struct amdgpu_rlc_funcs 
>> gfx_v7_0_rlc_funcs = {
>> >        .resume = gfx_v7_0_rlc_resume,
>> >        .stop = gfx_v7_0_rlc_stop,
>> >        .reset = gfx_v7_0_rlc_reset,
>> > -     .start = gfx_v7_0_rlc_start
>> > +     .start = gfx_v7_0_rlc_start,
>> > +     .update_spm_vmid = NULL
>> >   };
>> >
>> >   static int gfx_v7_0_early_init(void *handle) diff --git
>> > a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> > b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> > index fa245973de12..66640d2b6b37 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> > @@ -5600,7 +5600,8 @@ static const struct amdgpu_rlc_funcs 
>> iceland_rlc_funcs = {
>> >        .resume = gfx_v8_0_rlc_resume,
>> >        .stop = gfx_v8_0_rlc_stop,
>> >        .reset = gfx_v8_0_rlc_reset,
>> > -     .start = gfx_v8_0_rlc_start
>> > +     .start = gfx_v8_0_rlc_start,
>> > +     .update_spm_vmid = NULL
>> >   };
>> >
>> >   static void gfx_v8_0_update_medium_grain_clock_gating(struct
>> > amdgpu_device *adev, diff --git
>> > a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> > index 9b7ff783e9a5..df872f949f68 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> > @@ -4704,6 +4704,18 @@ static int 
>> gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>> >        return 0;
>> >   }
>> >
>> > +static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev,
>> > +unsigned vmid) {
>> > +     u32 data;
>> > +
>> > +     data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
>> > +
>> > +     data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
>> > +     data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) <<
>> > +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
>> > +
>> > +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
>> > +
>> >   static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
>> >        .is_rlc_enabled = gfx_v9_0_is_rlc_enabled,
>> >        .set_safe_mode = gfx_v9_0_set_safe_mode, @@ -4715,7 +4727,8 @@
>> > static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
>> >        .resume = gfx_v9_0_rlc_resume,
>> >        .stop = gfx_v9_0_rlc_stop,
>> >        .reset = gfx_v9_0_rlc_reset,
>> > -     .start = gfx_v9_0_rlc_start
>> > +     .start = gfx_v9_0_rlc_start,
>> > +     .update_spm_vmid = gfx_v9_0_update_spm_vmid
>> >   };
>> >
>> >   static int gfx_v9_0_set_powergating_state(void *handle,
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7C354be34ff18e4f424f6708d7b52b43b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637177069753914395&amp;sdata=9rSL4kgPJweuZ4EJpdqtqTxyCVGEkmsg6aUzbtvGFrs%3D&amp;reserved=0 
>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Calexander.deucher%40amd.com%7Ce68811adba0647c651a308d7b6b8d4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178777321057824&sdata=uRP0wQyfVKk0QoGlWM36nbeOY67nIjfD6vou2A%2BybEc%3D&reserved=0>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Calexander.deucher%40amd.com%7Ce68811adba0647c651a308d7b6b8d4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178777321067823&sdata=7o2j5dTvK%2B5Gihwd5IB%2Blp1Bi0ZOx%2B%2F%2Bmi8wpRh4NBs%3D&reserved=0>
>


--------------D5C9C4A29AF98035ACE835EA
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">I would just do this as part of the
      vm_flush() callback on the ring.<br>
      <br>
      E.g. check if the VMID you want to flush is reserved and if yes
      enable SPM.<br>
      <br>
      Maybe pass along a flag or something in the job to make things
      easier.<br>
      <br>
      Christian.<br>
      <br>
      Am 21.02.20 um 16:31 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite" cite="mid:CH2PR12MB3912AE29A4EBF30B5826CCC2F7120@CH2PR12MB3912.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" align="Left">
        [AMD Public Use]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          We already have the RESERVE_VMID ioctl interface, can't we
          just use that internally in the kernel to update the rlc
          register via the ring when we schedule the relevant IB?&nbsp; E.g.,
          add a new ring callback to set SPM state and then set it to
          the reserved vmid before we schedule the ib, and then reset it
          to 0 after the IB in amdgpu_ib_schedule().<br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
          </span>
          <div>index 4b2342d11520..e0db9362c6ee 100644<br>
          </div>
          <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
          </div>
          <div>&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
          </div>
          <div>@@ -185,6 &#43;185,9 @@ int amdgpu_ib_schedule(struct
            amdgpu_ring *ring, unsigned num_ibs,<br>
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; if (ring-&gt;funcs-&gt;insert_start)<br>
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ring-&gt;funcs-&gt;insert_start(ring);<br>
          </div>
          <div>&nbsp;<br>
          </div>
          <div>&#43; &nbsp; &nbsp; &nbsp; if (ring-&gt;funcs-&gt;setup_spm)<br>
          </div>
          <div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ring-&gt;funcs-&gt;setup_spm(ring, job);<br>
          </div>
          <div>&#43;<br>
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; if (job) {<br>
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r = amdgpu_vm_flush(ring, job,
            need_pipe_sync);<br>
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (r) {<br>
          </div>
          <div>@@ -273,6 &#43;276,9 @@ int amdgpu_ib_schedule(struct
            amdgpu_ring *ring, unsigned num_ibs,<br>
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return r;<br>
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; }<br>
          </div>
          <div>&nbsp;<br>
          </div>
          <div>&#43; &nbsp; &nbsp; &nbsp; if (ring-&gt;funcs-&gt;setup_spm)<br>
          </div>
          <div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ring-&gt;funcs-&gt;setup_spm(ring, NULL);<br>
          </div>
          <div>&#43;<br>
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; if (ring-&gt;funcs-&gt;insert_end)<br>
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ring-&gt;funcs-&gt;insert_end(ring);<br>
          </div>
          <div>&nbsp;<br>
          </div>
          <span></span><br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex<br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Friday, February 21, 2020 5:28 AM<br>
            <b>To:</b> Zhou, David(ChunMing)
            <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou@amd.com">&lt;David1.Zhou@amd.com&gt;</a>; He, Jacob
            <a class="moz-txt-link-rfc2396E" href="mailto:Jacob.He@amd.com">&lt;Jacob.He@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: Add a chunk ID for
            spm trace</font>
          <div>&nbsp;</div>
        </div>
        <div style="background-color:#FFFFFF">
          <div class="x_moz-cite-prefix">That would probably be a no-go,
            but we could enhance the kernel driver to update the
            RLC_SPM_VMID register with the reserved VMID.<br>
            <br>
            Handling that in userspace is most likely not working
            anyway, since the RLC registers are usually not accessible
            by userspace.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            Am 20.02.20 um 16:15 schrieb Zhou, David(ChunMing):<br>
          </div>
          <blockquote type="cite">
            <meta name="Generator" content="Microsoft Word 15 (filtered
              medium)">
            <style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:"Bookman Old Style"}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
p.x_msipheader4d0fcdd7, li.x_msipheader4d0fcdd7, div.x_msipheader4d0fcdd7
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle19
	{font-family:"Arial",sans-serif;
	color:#0078D7}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.25in 1.0in 1.25in}
div.x_WordSection1
	{}
-->
</style>
            <div class="x_WordSection1">
              <p class="x_msipheader4d0fcdd7" style="margin:0in;
                margin-bottom:.0001pt"><span style="font-size:10.0pt;
                  font-family:&quot;Arial&quot;,sans-serif;
                  color:#0078D7">[AMD Official Use Only - Internal
                  Distribution Only]</span></p>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal">You can enhance amdgpu_vm_ioctl In
                amdgpu_vm.c to return vmid to userspace.
              </p>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal">-David</p>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal">&nbsp;</p>
              <div>
                <div style="border:none; border-top:solid #E1E1E1 1.0pt;
                  padding:3.0pt 0in 0in 0in">
                  <p class="x_MsoNormal"><b>From:</b> He, Jacob <a class="x_moz-txt-link-rfc2396E" href="mailto:Jacob.He@amd.com" moz-do-not-send="true">
                      &lt;Jacob.He@amd.com&gt;</a> <br>
                    <b>Sent:</b> Thursday, February 20, 2020 10:46 PM<br>
                    <b>To:</b> Zhou, David(ChunMing) <a class="x_moz-txt-link-rfc2396E" href="mailto:David1.Zhou@amd.com" moz-do-not-send="true">
                      &lt;David1.Zhou@amd.com&gt;</a>; Koenig, Christian
                    <a class="x_moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                      &lt;Christian.Koenig@amd.com&gt;</a>; <a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                      amd-gfx@lists.freedesktop.org</a><br>
                    <b>Subject:</b> RE: [PATCH] drm/amdgpu: Add a chunk
                    ID for spm trace</p>
                </div>
              </div>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal">amdgpu_vm_reserve_vmid doesn’t
                return the reserved vmid back to user space. There is no
                chance for user mode driver to update RLC_SPM_VMID.</p>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal"><span style="">Thanks</span></p>
              <p class="x_MsoNormal"><span style="">Jacob</span></p>
              <p class="x_MsoNormal">&nbsp;</p>
              <div style="border:none; border-top:solid #E1E1E1 1.0pt;
                padding:3.0pt 0in 0in 0in">
                <p class="x_MsoNormal"><b>From: </b><a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">He, Jacob</a><br>
                  <b>Sent: </b>Thursday, February 20, 2020 6:20 PM<br>
                  <b>To: </b><a href="mailto:David1.Zhou@amd.com" moz-do-not-send="true">Zhou, David(ChunMing)</a>; <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                    Koenig, Christian</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                  <b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a chunk
                  ID for spm trace</p>
              </div>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal">Looks like amdgpu_vm_reserve_vmid
                could work, let me have a try to update the RLC_SPM_VMID
                with pm4 packets in UMD.</p>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal"><span style="">Thanks</span></p>
              <p class="x_MsoNormal"><span style="">Jacob</span></p>
              <p class="x_MsoNormal">&nbsp;</p>
              <div style="border:none; border-top:solid #E1E1E1 1.0pt;
                padding:3.0pt 0in 0in 0in">
                <p class="x_MsoNormal"><b>From: </b><a href="mailto:David1.Zhou@amd.com" moz-do-not-send="true">Zhou, David(ChunMing)</a><br>
                  <b>Sent: </b>Thursday, February 20, 2020 10:13 AM<br>
                  <b>To: </b><a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Koenig, Christian</a>; <a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">
                    He, Jacob</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                  <b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a chunk
                  ID for spm trace</p>
              </div>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal">[AMD Official Use Only - Internal
                Distribution Only]<br>
                <br>
                Christian is right here, that will cause many problems
                for simply using VMID in kernel.<br>
                We already have an pair interface for RGP, I think you
                can use it instead of involving additional kernel
                change.<br>
                amdgpu_vm_reserve_vmid/ amdgpu_vm_unreserve_vmid.<br>
                <br>
                -David<br>
                <br>
                -----Original Message-----<br>
                From: amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                On Behalf Of Christian König<br>
                Sent: Wednesday, February 19, 2020 7:03 PM<br>
                To: He, Jacob &lt;<a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">Jacob.He@amd.com</a>&gt;; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                  amd-gfx@lists.freedesktop.org</a><br>
                Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm
                trace<br>
                <br>
                Am 19.02.20 um 11:15 schrieb Jacob He:<br>
                &gt; [WHY]<br>
                &gt; When SPM trace enabled, SPM_VMID should be updated
                with the current <br>
                &gt; vmid.<br>
                &gt;<br>
                &gt; [HOW]<br>
                &gt; Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that
                UMD can tell us <br>
                &gt; which job should update SPM_VMID.<br>
                &gt; Right before a job is submitted to GPU, set the
                SPM_VMID accordingly.<br>
                &gt;<br>
                &gt; [Limitation]<br>
                &gt; Running more than one SPM trace enabled processes
                simultaneously is <br>
                &gt; not supported.<br>
                <br>
                Well there are multiple problems with that patch.<br>
                <br>
                First of all you need to better describe what SPM
                tracing is in the commit message.<br>
                <br>
                Then the updating of mmRLC_SPM_MC_CNTL must be executed
                asynchronously on the ring. Otherwise we might corrupt
                an already executing SPM trace.<br>
                <br>
                And you also need to make sure to disable the tracing
                again or otherwise we run into a bunch of trouble when
                the VMID is reused.<br>
                <br>
                You also need to make sure that IBs using the SPM trace
                are serialized with each other, e.g. hack into
                amdgpu_ids.c file and make sure that only one VMID at a
                time can have that attribute.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                &gt;<br>
                &gt; Change-Id:
                Ic932ef6ac9dbf244f03aaee90550e8ff3a675666<br>
                &gt; Signed-off-by: Jacob He &lt;<a href="mailto:jacob.he@amd.com" moz-do-not-send="true">jacob.he@amd.com</a>&gt;<br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&nbsp; |&nbsp; 7
                &#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c&nbsp; | 10
                &#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |&nbsp; 1 &#43;<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |&nbsp; 1 &#43;<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp; | 15
                &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp;&nbsp; |&nbsp; 3 &#43;&#43;-<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp; |&nbsp; 3 &#43;&#43;-<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp; | 15
                &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
                &gt;&nbsp;&nbsp; 8 files changed, 48 insertions(&#43;), 7 deletions(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
                <br>
                &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                &gt; index f9fa6e104fef..3f32c4db5232 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                &gt; @@ -113,6 &#43;113,7 @@ static int
                amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union
                drm_amdgpu_cs<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uf_offset = 0;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool update_spm_vmid = false;<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cs-&gt;in.num_chunks == 0)<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt; @@ -221,6 &#43;222,10 @@ static int
                amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union
                drm_amdgpu_cs<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case
                AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_CHUNK_ID_SPM_TRACE:<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_spm_vmid = true;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                &gt; &#43;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -EINVAL;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_partial_kdata;<br>
                &gt; @@ -231,6 &#43;236,8 @@ static int
                amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union
                drm_amdgpu_cs<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_all_kdata;<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;job-&gt;need_update_spm_vmid =
                update_spm_vmid;<br>
                &gt; &#43;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;ctx-&gt;vram_lost_counter !=
                p-&gt;job-&gt;vram_lost_counter) {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -ECANCELED;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_all_kdata;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
                <br>
                &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                &gt; index cae81914c821..36faab12b585 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                &gt; @@ -156,9 &#43;156,13 @@ int amdgpu_ib_schedule(struct
                amdgpu_ring *ring, unsigned num_ibs,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (vm &amp;&amp; !job-&gt;vmid) {<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;VM IB without
                ID\n&quot;);<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (vm) {<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!job-&gt;vmid) {<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;VM IB
                without ID\n&quot;);<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if
                (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid &amp;&amp;
                job-&gt;need_update_spm_vmid) {<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev,
                job-&gt;vmid);<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_size =
                ring-&gt;funcs-&gt;emit_frame_size &#43; num_ibs * diff
                --git <br>
                &gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h <br>
                &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
                &gt; index 2e2110dddb76..4582536961c7 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
                &gt; @@ -52,6 &#43;52,7 @@ struct amdgpu_job {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_needs_flush;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_pd_addr;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; need_update_spm_vmid;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasid;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_base, gds_size;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gws_base, gws_size;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h <br>
                &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
                &gt; index d3d4707f2168..52509c254cbd 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
                &gt; @@ -126,6 &#43;126,7 @@ struct amdgpu_rlc_funcs {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*stop)(struct amdgpu_device *adev);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*reset)(struct amdgpu_device *adev);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*start)(struct amdgpu_device *adev);<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void (*update_spm_vmid)(struct amdgpu_device
                *adev, unsigned vmid);<br>
                &gt;&nbsp;&nbsp; };<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp; struct amdgpu_rlc {<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
                <br>
                &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
                &gt; index 5e9fb0976c6c..91eb788d6229 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
                &gt; @@ -4214,6 &#43;4214,18 @@ static int
                gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device
                *adev,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&nbsp;&nbsp; }<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; &#43;static void gfx_v10_0_update_spm_vmid(struct
                amdgpu_device *adev, <br>
                &gt; &#43;unsigned vmid) {<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<br>
                &gt; &#43;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data = RREG32_SOC15(GC, 0,
                mmRLC_SPM_MC_CNTL);<br>
                &gt; &#43;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=
                ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data |= (vmid &amp;
                RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) &lt;&lt; <br>
                &gt; &#43;RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;<br>
                &gt; &#43;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
                }<br>
                &gt; &#43;<br>
                &gt;&nbsp;&nbsp; static const struct amdgpu_rlc_funcs
                gfx_v10_0_rlc_funcs = {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlc_enabled = gfx_v10_0_is_rlc_enabled,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_safe_mode = gfx_v10_0_set_safe_mode, @@
                -4224,7 &#43;4236,8 @@ <br>
                &gt; static const struct amdgpu_rlc_funcs
                gfx_v10_0_rlc_funcs = {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume = gfx_v10_0_rlc_resume,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop = gfx_v10_0_rlc_stop,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset = gfx_v10_0_rlc_reset,<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v10_0_rlc_start<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v10_0_rlc_start,<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid = gfx_v10_0_update_spm_vmid<br>
                &gt;&nbsp;&nbsp; };<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp; static int gfx_v10_0_set_powergating_state(void
                *handle, diff --git <br>
                &gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c <br>
                &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
                &gt; index 8f20a5dd44fe..b24fc55cf13a 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
                &gt; @@ -4221,7 &#43;4221,8 @@ static const struct
                amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume = gfx_v7_0_rlc_resume,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop = gfx_v7_0_rlc_stop,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset = gfx_v7_0_rlc_reset,<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v7_0_rlc_start<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v7_0_rlc_start,<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid = NULL<br>
                &gt;&nbsp;&nbsp; };<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp; static int gfx_v7_0_early_init(void *handle) diff
                --git <br>
                &gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c <br>
                &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                &gt; index fa245973de12..66640d2b6b37 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                &gt; @@ -5600,7 &#43;5600,8 @@ static const struct
                amdgpu_rlc_funcs iceland_rlc_funcs = {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume = gfx_v8_0_rlc_resume,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop = gfx_v8_0_rlc_stop,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset = gfx_v8_0_rlc_reset,<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v8_0_rlc_start<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v8_0_rlc_start,<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid = NULL<br>
                &gt;&nbsp;&nbsp; };<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp; static void
                gfx_v8_0_update_medium_grain_clock_gating(struct <br>
                &gt; amdgpu_device *adev, diff --git <br>
                &gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c <br>
                &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                &gt; index 9b7ff783e9a5..df872f949f68 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                &gt; @@ -4704,6 &#43;4704,18 @@ static int
                gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device
                *adev,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&nbsp;&nbsp; }<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; &#43;static void gfx_v9_0_update_spm_vmid(struct
                amdgpu_device *adev, <br>
                &gt; &#43;unsigned vmid) {<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<br>
                &gt; &#43;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data = RREG32_SOC15(GC, 0,
                mmRLC_SPM_MC_CNTL);<br>
                &gt; &#43;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=
                ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data |= (vmid &amp;
                RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) &lt;&lt; <br>
                &gt; &#43;RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;<br>
                &gt; &#43;<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
                }<br>
                &gt; &#43;<br>
                &gt;&nbsp;&nbsp; static const struct amdgpu_rlc_funcs
                gfx_v9_0_rlc_funcs = {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlc_enabled = gfx_v9_0_is_rlc_enabled,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_safe_mode = gfx_v9_0_set_safe_mode, @@
                -4715,7 &#43;4727,8 @@ <br>
                &gt; static const struct amdgpu_rlc_funcs
                gfx_v9_0_rlc_funcs = {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume = gfx_v9_0_rlc_resume,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop = gfx_v9_0_rlc_stop,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset = gfx_v9_0_rlc_reset,<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v9_0_rlc_start<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v9_0_rlc_start,<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid = gfx_v9_0_update_spm_vmid<br>
                &gt;&nbsp;&nbsp; };<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp; static int gfx_v9_0_set_powergating_state(void
                *handle,<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7Ce68811adba0647c651a308d7b6b8d4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178777321057824&amp;sdata=uRP0wQyfVKk0QoGlWM36nbeOY67nIjfD6vou2A%2BybEc%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="cY9Q1StrySjgQyNuykjUtxS1JLzrfVLkIovRQcnfV7fDZ0/2iAafEToQIJvt/jrJ45fz54&#43;8XGvjzEW2embpuvgeXD17jIH0VfYHf4xdeXKoMyCjbOZBDrqLqJUi5K8KlCszbXHNLsgFkiuoJF4rBc5se4VGIkWuQWuTEZjLL6s=" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7C354be34ff18e4f424f6708d7b52b43b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637177069753914395&amp;amp;sdata=9rSL4kgPJweuZ4EJpdqtqTxyCVGEkmsg6aUzbtvGFrs%3D&amp;amp;reserved=0</a></p>
              <p class="x_MsoNormal">&nbsp;</p>
              <p class="x_MsoNormal">&nbsp;</p>
            </div>
            <br>
            <fieldset class="x_mimeAttachmentHeader"></fieldset>
            <pre class="x_moz-quote-pre">_______________________________________________
amd-gfx mailing list
<a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="x_moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7Ce68811adba0647c651a308d7b6b8d4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178777321067823&amp;sdata=7o2j5dTvK%2B5Gihwd5IB%2Blp1Bi0ZOx%2B%2F%2Bmi8wpRh4NBs%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="JcXrswlnx3GRIuCJUYnhgs8pUGPw/Z3eyikzOTtkI8eo9s6vhu0mZsgjA1Ry&#43;GgdWuHihfNdYO0toOMIcwcw2cpk8cflGlY0Fw4U7dtTQfBgPmzxx7ZNfebGgb2Ac8OBl1ChEDsSt9DGBkX7T4TXFwVZNikMYrVNqB7tDS52l5c=" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
          </blockquote>
          <br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------D5C9C4A29AF98035ACE835EA--

--===============2070955054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2070955054==--
