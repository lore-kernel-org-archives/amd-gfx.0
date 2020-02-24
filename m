Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BECC38BE0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 18:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139C52080D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 18:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DleITDEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139C52080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31366E844;
	Mon, 24 Feb 2020 18:51:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A984B6E844
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 18:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM1dgA/nki9sXQH8T4YyOC2LYv7X/vYkLrIxEKQ5fst5ab+AbGqo6FWDyk+D040hROiZln8tAuDnUsAruiBEnlgF3U6xFB/GCDbDh/zJ7AUEyYjnEVWbPHB8k1oOMYLQ0lDIOh2YKhdq0X9BiGB/HlFG8HJDvYSLqhcD1S2dEFPrU+SlEgDEh7Lpx2jqbf3U/bKt/+x3M+fjkBlTGhCjuAqvMn9spQgn1NixBgcWavjhCMS3IFgb0gRuPDBYEdYl6/ZWOHF/mkaIXFeetRwdFcBYo14Ut8lKxiAPFN1hDwEGBVrgdnfX/JiX8dQsExMv+1ZyI/m9DJHcu8NHovltng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4L5Z/QuvPgIt4AlZT+WcI5ATpGdpspOix90vKlNJWM=;
 b=YH3B4XApNcuIlOW0yqpTj6lHHDQ1dmIdvfcMlSTlbHLAhnmGojf0mFbfDE35uQo5P/mByXRWxa2U2c3Gl9iDVzoAVZE0TiICdACr9sI0Ygjh6gpwadNqwngwjv/KTQAdx7pxPq1q981zSqh6SH0lS+gEKxwB11Yw2Zd4SEq0IiHLhXYyhvfVCZvhdx5Yha9vCnyMhX2SfrKITlUeZgF7RFpOQX4L0A7LPg/9ws131PHwAjIqJZIGufwea14mf+ym3kYmRYSOWmER7dhWr1pGYylBMTd+TocCv0bFo8raqXwSxpgAubcTFxdCLQM9q9dgbJDpaVbc5cWMf7SQXjzMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4L5Z/QuvPgIt4AlZT+WcI5ATpGdpspOix90vKlNJWM=;
 b=DleITDEr50YmE2dMQVo+dPemjaWuQGciGC0JtfxyQK/uzzq2pSffH0dIuHaMKxoutVzWk2kdLOd+0U9Zfh+YeanHvIRDgNcjRBuEmEpkWVaR/D3xObnF5huAu1dGPy564I9trUTEEmBJkGjENox2JYrVAGQUVYJs3Yu67UBvJlo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1916.namprd12.prod.outlook.com (2603:10b6:3:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 18:51:30 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2750.021; Mon, 24 Feb
 2020 18:51:30 +0000
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
To: "He, Jacob" <Jacob.He@amd.com>,
 "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200219101506.16779-1-jacob.he@amd.com>
 <e2fea4f5-0eea-75b5-9cd7-68b603629d8d@gmail.com>
 <MWHPR12MB1406B3418562F0692572C511B4130@MWHPR12MB1406.namprd12.prod.outlook.com>
 <MN2PR12MB337663C5CCF3D53744FD377D9B130@MN2PR12MB3376.namprd12.prod.outlook.com>
 <MN2PR12MB3376E699E0A85E8065D3E72D9B130@MN2PR12MB3376.namprd12.prod.outlook.com>
 <MWHPR12MB140699AA6711A7E6876C56E5B4130@MWHPR12MB1406.namprd12.prod.outlook.com>
 <e09919bf-f084-55ed-04a7-f52bec5b0be9@gmail.com>
 <CH2PR12MB3912AE29A4EBF30B5826CCC2F7120@CH2PR12MB3912.namprd12.prod.outlook.com>
 <1b15e97e-2a19-70dc-d9da-672e337e2d15@amd.com>
 <MWHPR12MB1406BBDF0726D961289869E8B4120@MWHPR12MB1406.namprd12.prod.outlook.com>
 <MN2PR12MB3376E7269CCC628EA0FCCB879BEC0@MN2PR12MB3376.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a1ffa641-5183-3bac-7c3a-9945bdb2f132@amd.com>
Date: Mon, 24 Feb 2020 19:51:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB3376E7269CCC628EA0FCCB879BEC0@MN2PR12MB3376.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:207:2::29) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR05CA0127.eurprd05.prod.outlook.com (2603:10a6:207:2::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Mon, 24 Feb 2020 18:51:28 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95c5c8f7-7f8b-4848-67c9-08d7b95a8f04
X-MS-TrafficTypeDiagnostic: DM5PR12MB1916:|DM5PR12MB1916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1916F47A695E265DAC34F93483EC0@DM5PR12MB1916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(316002)(6486002)(8936002)(186003)(16526019)(110136005)(2616005)(53546011)(66574012)(31686004)(6666004)(66946007)(66556008)(66476007)(66616009)(478600001)(5660300002)(86362001)(31696002)(52116002)(36756003)(2906002)(30864003)(8676002)(81156014)(966005)(45080400002)(81166006)(559001)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1916;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yco8Qkozudlo5BS+QLNDmy56UElYmELqpxY7/Y6SxRwDvjGRvrnO9AfUlqhHheCzgsJSCcKw/Dp6Yz1g8ZrecsrnRr4Z2JwR4Rysdm68Vpb9PjSrklVpdMK06Yu6r3jpbhgjCEqccEKCDcM4RinuwT4dK5mIf77vyawamInO+mYiiu8CRaHIWgIE/7Dbp9Ma/VUDeWz4SS9FLCtLkWeW+8YqaByC0FFuBBqwtPTBxtbc50TU/14+L50iMeWshq33lxyxt1pO1sbJkreKahzCrJIXl/2IqQrPweSACZH5+YfdU71e63uq6gMV1dvmRNsvEdQlnyugC7NAitno6jV83NHNQWHq/zjS45MwgR9T8fTxp4uct9cyeIMOoZsZsOGsOcgjEL48CXvD4eC67sqiktEF53P0xaznfLXfRTNqP4B7ESaWACg2ZT99ievpvMSqjoIgRExsZscx9r57x4d/D6fHpJXgYHK7uNZGv6WAAhLD6w0Vu9D2r8KEtJ5i+8y5lN2CUpIFOYUnPToUWm8SEA==
X-MS-Exchange-AntiSpam-MessageData: UdlsGm1u+41RufXsPo9SxvMk+xOA7r02GN745BoyAg0kS9iuzpYeuo62FWA/91HJFDNrrdQythX8SevDxjFsKK3aetpy1kN6AflUjeSI+JdlHIk6Kqe1meCeNP0EFsWr2y2QNewA/v8lJfB6Wr4bGMqOBDPTZOR296D0s0lfuZRVA3Ly6AWmc+AiLJdeyd7hXFcl8Qt1Xlo0RF4XpTAJRg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c5c8f7-7f8b-4848-67c9-08d7b95a8f04
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 18:51:29.8718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Go857dbwAFkhRkZo72Cq9eEnzd4wg4q8tMcsEcPpLZFrMryGZBuVOwTtK5Q85AWA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1916
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
Content-Type: multipart/mixed; boundary="===============0533862114=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0533862114==
Content-Type: multipart/alternative;
 boundary="------------120E17BCC0B10716B7B2DC27"
Content-Language: en-US

--------------120E17BCC0B10716B7B2DC27
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

> Leave the old spm_vmid there is not a problem because other new spm 
> enabled job will update it before it’s running and other spm disabled 
> job will not access spm_vmid register.
Do you have a high level description of how SPM works? For example would 
it be possible to cause a problem in another application if we leave the 
SPM VMID here and the VMID is reused?

Keep in mind that we need to guarantee process isolation, e.g. we can't 
allow anything bad to happen to another application if somebody is 
stupid enough to turn on SPM tracing without setting it up properly.

Regards,
Christian.

Am 24.02.20 um 09:06 schrieb He, Jacob:
>
> Ok, I’m glad that there is no uapi change needed.
>
> I checked the git log, and reserve_vmid was added for shader debugger, 
> not gpa. I’m fine to re-use it since the spm will not enabled for 
> shader debug in general. I’ll try to change my patch.
>
> BTW, “ring->funcs->setup_spm(ring, NULL)” to clear the vmid is not 
> gonna work since the job with spm enabled execution is not done yet. 
> Leave the old spm_vmid there is not a problem because other new spm 
> enabled job will update it before it’s running and other spm disabled 
> job will not access spm_vmid register.
>
> Thanks
>
> Jacob
>
> *From: *Zhou, David(ChunMing) <mailto:David1.Zhou@amd.com>
> *Sent: *Saturday, February 22, 2020 12:45 AM
> *To: *Koenig, Christian <mailto:Christian.Koenig@amd.com>; Deucher, 
> Alexander <mailto:Alexander.Deucher@amd.com>; Christian König 
> <mailto:ckoenig.leichtzumerken@gmail.com>; He, Jacob 
> <mailto:Jacob.He@amd.com>; amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>
> *Subject: *RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>
> [AMD Official Use Only - Internal Distribution Only]
>
> That’s fine to me.
>
> -David
>
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Friday, February 21, 2020 11:33 PM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com>; Christian König 
> <ckoenig.leichtzumerken@gmail.com>; Zhou, David(ChunMing) 
> <David1.Zhou@amd.com>; He, Jacob <Jacob.He@amd.com>; 
> amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>
> I would just do this as part of the vm_flush() callback on the ring.
>
> E.g. check if the VMID you want to flush is reserved and if yes enable 
> SPM.
>
> Maybe pass along a flag or something in the job to make things easier.
>
> Christian.
>
> Am 21.02.20 um 16:31 schrieb Deucher, Alexander:
>
>     [AMD Public Use]
>
>     We already have the RESERVE_VMID ioctl interface, can't we just
>     use that internally in the kernel to update the rlc register via
>     the ring when we schedule the relevant IB?  E.g., add a new ring
>     callback to set SPM state and then set it to the reserved vmid
>     before we schedule the ib, and then reset it to 0 after the IB in
>     amdgpu_ib_schedule().
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>
>     index 4b2342d11520..e0db9362c6ee 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>
>     @@ -185,6 +185,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring
>     *ring, unsigned num_ibs,
>
>             if (ring->funcs->insert_start)
>
>     ring->funcs->insert_start(ring);
>
>     +       if (ring->funcs->setup_spm)
>
>     + ring->funcs->setup_spm(ring, job);
>
>     +
>
>             if (job) {
>
>     r = amdgpu_vm_flush(ring, job, need_pipe_sync);
>
>     if (r) {
>
>     @@ -273,6 +276,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring
>     *ring, unsigned num_ibs,
>
>     return r;
>
>             }
>
>     +       if (ring->funcs->setup_spm)
>
>     + ring->funcs->setup_spm(ring, NULL);
>
>     +
>
>             if (ring->funcs->insert_end)
>
>     ring->funcs->insert_end(ring);
>
>     Alex
>
>     *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>     <mailto:amd-gfx-bounces@lists.freedesktop.org> on behalf of
>     Christian König <ckoenig.leichtzumerken@gmail.com>
>     <mailto:ckoenig.leichtzumerken@gmail.com>
>     *Sent:* Friday, February 21, 2020 5:28 AM
>     *To:* Zhou, David(ChunMing) <David1.Zhou@amd.com>
>     <mailto:David1.Zhou@amd.com>; He, Jacob <Jacob.He@amd.com>
>     <mailto:Jacob.He@amd.com>; Koenig, Christian
>     <Christian.Koenig@amd.com> <mailto:Christian.Koenig@amd.com>;
>     amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>     *Subject:* Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>
>     That would probably be a no-go, but we could enhance the kernel
>     driver to update the RLC_SPM_VMID register with the reserved VMID.
>
>     Handling that in userspace is most likely not working anyway,
>     since the RLC registers are usually not accessible by userspace.
>
>     Regards,
>     Christian.
>
>     Am 20.02.20 um 16:15 schrieb Zhou, David(ChunMing):
>
>         [AMD Official Use Only - Internal Distribution Only]
>
>         You can enhance amdgpu_vm_ioctl In amdgpu_vm.c to return vmid
>         to userspace.
>
>         -David
>
>         *From:* He, Jacob <Jacob.He@amd.com> <mailto:Jacob.He@amd.com>
>         *Sent:* Thursday, February 20, 2020 10:46 PM
>         *To:* Zhou, David(ChunMing) <David1.Zhou@amd.com>
>         <mailto:David1.Zhou@amd.com>; Koenig, Christian
>         <Christian.Koenig@amd.com> <mailto:Christian.Koenig@amd.com>;
>         amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         *Subject:* RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>
>         amdgpu_vm_reserve_vmid doesn’t return the reserved vmid back
>         to user space. There is no chance for user mode driver to
>         update RLC_SPM_VMID.
>
>         Thanks
>
>         Jacob
>
>         *From: *He, Jacob <mailto:Jacob.He@amd.com>
>         *Sent: *Thursday, February 20, 2020 6:20 PM
>         *To: *Zhou, David(ChunMing) <mailto:David1.Zhou@amd.com>;
>         Koenig, Christian <mailto:Christian.Koenig@amd.com>;
>         amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         *Subject: *RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>
>         Looks like amdgpu_vm_reserve_vmid could work, let me have a
>         try to update the RLC_SPM_VMID with pm4 packets in UMD.
>
>         Thanks
>
>         Jacob
>
>         *From: *Zhou, David(ChunMing) <mailto:David1.Zhou@amd.com>
>         *Sent: *Thursday, February 20, 2020 10:13 AM
>         *To: *Koenig, Christian <mailto:Christian.Koenig@amd.com>; He,
>         Jacob <mailto:Jacob.He@amd.com>; amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         *Subject: *RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>
>         [AMD Official Use Only - Internal Distribution Only]
>
>         Christian is right here, that will cause many problems for
>         simply using VMID in kernel.
>         We already have an pair interface for RGP, I think you can use
>         it instead of involving additional kernel change.
>         amdgpu_vm_reserve_vmid/ amdgpu_vm_unreserve_vmid.
>
>         -David
>
>         -----Original Message-----
>         From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>         <mailto:amd-gfx-bounces@lists.freedesktop.org>> On Behalf Of
>         Christian König
>         Sent: Wednesday, February 19, 2020 7:03 PM
>         To: He, Jacob <Jacob.He@amd.com <mailto:Jacob.He@amd.com>>;
>         amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
>
>         Am 19.02.20 um 11:15 schrieb Jacob He:
>         > [WHY]
>         > When SPM trace enabled, SPM_VMID should be updated with the
>         current
>         > vmid.
>         >
>         > [HOW]
>         > Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can
>         tell us
>         > which job should update SPM_VMID.
>         > Right before a job is submitted to GPU, set the SPM_VMID
>         accordingly.
>         >
>         > [Limitation]
>         > Running more than one SPM trace enabled processes
>         simultaneously is
>         > not supported.
>
>         Well there are multiple problems with that patch.
>
>         First of all you need to better describe what SPM tracing is
>         in the commit message.
>
>         Then the updating of mmRLC_SPM_MC_CNTL must be executed
>         asynchronously on the ring. Otherwise we might corrupt an
>         already executing SPM trace.
>
>         And you also need to make sure to disable the tracing again or
>         otherwise we run into a bunch of trouble when the VMID is reused.
>
>         You also need to make sure that IBs using the SPM trace are
>         serialized with each other, e.g. hack into amdgpu_ids.c file
>         and make sure that only one VMID at a time can have that
>         attribute.
>
>         Regards,
>         Christian.
>
>         >
>         > Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666
>         > Signed-off-by: Jacob He <jacob.he@amd.com
>         <mailto:jacob.he@amd.com>>
>         > ---
>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  7 +++++++
>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 10 +++++++---
>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  1 +
>         >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15 ++++++++++++++-
>         >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  3 ++-
>         >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  3 ++-
>         >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15 ++++++++++++++-
>         >   8 files changed, 48 insertions(+), 7 deletions(-)
>         >
>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>         > b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>         > index f9fa6e104fef..3f32c4db5232 100644
>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>         > @@ -113,6 +113,7 @@ static int amdgpu_cs_parser_init(struct
>         amdgpu_cs_parser *p, union drm_amdgpu_cs
>         >        uint32_t uf_offset = 0;
>         >        int i;
>         >        int ret;
>         > +     bool update_spm_vmid = false;
>         >
>         >        if (cs->in.num_chunks == 0)
>         >                return 0;
>         > @@ -221,6 +222,10 @@ static int amdgpu_cs_parser_init(struct
>         amdgpu_cs_parser *p, union drm_amdgpu_cs
>         >                case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
>         >                        break;
>         >
>         > +             case AMDGPU_CHUNK_ID_SPM_TRACE:
>         > +                     update_spm_vmid = true;
>         > +                     break;
>         > +
>         >                default:
>         >                        ret = -EINVAL;
>         >                        goto free_partial_kdata;
>         > @@ -231,6 +236,8 @@ static int amdgpu_cs_parser_init(struct
>         amdgpu_cs_parser *p, union drm_amdgpu_cs
>         >        if (ret)
>         >                goto free_all_kdata;
>         >
>         > +     p->job->need_update_spm_vmid = update_spm_vmid;
>         > +
>         >        if (p->ctx->vram_lost_counter !=
>         p->job->vram_lost_counter) {
>         >                ret = -ECANCELED;
>         >                goto free_all_kdata;
>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>         > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>         > index cae81914c821..36faab12b585 100644
>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>         > @@ -156,9 +156,13 @@ int amdgpu_ib_schedule(struct
>         amdgpu_ring *ring, unsigned num_ibs,
>         >                return -EINVAL;
>         >        }
>         >
>         > -     if (vm && !job->vmid) {
>         > -             dev_err(adev->dev, "VM IB without ID\n");
>         > -             return -EINVAL;
>         > +     if (vm) {
>         > +             if (!job->vmid) {
>         > +                     dev_err(adev->dev, "VM IB without ID\n");
>         > +                     return -EINVAL;
>         > +             } else if
>         (adev->gfx.rlc.funcs->update_spm_vmid &&
>         job->need_update_spm_vmid) {
>         > + adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
>         > +             }
>         >        }
>         >
>         >        alloc_size = ring->funcs->emit_frame_size + num_ibs *
>         diff --git
>         > a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>         > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>         > index 2e2110dddb76..4582536961c7 100644
>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>         > @@ -52,6 +52,7 @@ struct amdgpu_job {
>         >        bool                    vm_needs_flush;
>         >        uint64_t                vm_pd_addr;
>         >        unsigned                vmid;
>         > +     bool need_update_spm_vmid;
>         >        unsigned                pasid;
>         >        uint32_t                gds_base, gds_size;
>         >        uint32_t                gws_base, gws_size;
>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>         > b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>         > index d3d4707f2168..52509c254cbd 100644
>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>         > @@ -126,6 +126,7 @@ struct amdgpu_rlc_funcs {
>         >        void (*stop)(struct amdgpu_device *adev);
>         >        void (*reset)(struct amdgpu_device *adev);
>         >        void (*start)(struct amdgpu_device *adev);
>         > +     void (*update_spm_vmid)(struct amdgpu_device *adev,
>         unsigned vmid);
>         >   };
>         >
>         >   struct amdgpu_rlc {
>         > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>         > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>         > index 5e9fb0976c6c..91eb788d6229 100644
>         > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>         > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>         > @@ -4214,6 +4214,18 @@ static int
>         gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>         >        return 0;
>         >   }
>         >
>         > +static void gfx_v10_0_update_spm_vmid(struct amdgpu_device
>         *adev,
>         > +unsigned vmid) {
>         > +     u32 data;
>         > +
>         > +     data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
>         > +
>         > +     data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
>         > +     data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) <<
>         > +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
>         > +
>         > +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
>         > +
>         >   static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
>         >        .is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
>         >        .set_safe_mode = gfx_v10_0_set_safe_mode, @@ -4224,7
>         +4236,8 @@
>         > static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
>         >        .resume = gfx_v10_0_rlc_resume,
>         >        .stop = gfx_v10_0_rlc_stop,
>         >        .reset = gfx_v10_0_rlc_reset,
>         > -     .start = gfx_v10_0_rlc_start
>         > +     .start = gfx_v10_0_rlc_start,
>         > +     .update_spm_vmid = gfx_v10_0_update_spm_vmid
>         >   };
>         >
>         >   static int gfx_v10_0_set_powergating_state(void *handle,
>         diff --git
>         > a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>         > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>         > index 8f20a5dd44fe..b24fc55cf13a 100644
>         > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>         > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>         > @@ -4221,7 +4221,8 @@ static const struct amdgpu_rlc_funcs
>         gfx_v7_0_rlc_funcs = {
>         >        .resume = gfx_v7_0_rlc_resume,
>         >        .stop = gfx_v7_0_rlc_stop,
>         >        .reset = gfx_v7_0_rlc_reset,
>         > -     .start = gfx_v7_0_rlc_start
>         > +     .start = gfx_v7_0_rlc_start,
>         > +     .update_spm_vmid = NULL
>         >   };
>         >
>         >   static int gfx_v7_0_early_init(void *handle) diff --git
>         > a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>         > b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>         > index fa245973de12..66640d2b6b37 100644
>         > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>         > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>         > @@ -5600,7 +5600,8 @@ static const struct amdgpu_rlc_funcs
>         iceland_rlc_funcs = {
>         >        .resume = gfx_v8_0_rlc_resume,
>         >        .stop = gfx_v8_0_rlc_stop,
>         >        .reset = gfx_v8_0_rlc_reset,
>         > -     .start = gfx_v8_0_rlc_start
>         > +     .start = gfx_v8_0_rlc_start,
>         > +     .update_spm_vmid = NULL
>         >   };
>         >
>         >   static void gfx_v8_0_update_medium_grain_clock_gating(struct
>         > amdgpu_device *adev, diff --git
>         > a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>         > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>         > index 9b7ff783e9a5..df872f949f68 100644
>         > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>         > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>         > @@ -4704,6 +4704,18 @@ static int
>         gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>         >        return 0;
>         >   }
>         >
>         > +static void gfx_v9_0_update_spm_vmid(struct amdgpu_device
>         *adev,
>         > +unsigned vmid) {
>         > +     u32 data;
>         > +
>         > +     data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
>         > +
>         > +     data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
>         > +     data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) <<
>         > +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
>         > +
>         > +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
>         > +
>         >   static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
>         >        .is_rlc_enabled = gfx_v9_0_is_rlc_enabled,
>         >        .set_safe_mode = gfx_v9_0_set_safe_mode, @@ -4715,7
>         +4727,8 @@
>         > static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
>         >        .resume = gfx_v9_0_rlc_resume,
>         >        .stop = gfx_v9_0_rlc_stop,
>         >        .reset = gfx_v9_0_rlc_reset,
>         > -     .start = gfx_v9_0_rlc_start
>         > +     .start = gfx_v9_0_rlc_start,
>         > +     .update_spm_vmid = gfx_v9_0_update_spm_vmid
>         >   };
>         >
>         >   static int gfx_v9_0_set_powergating_state(void *handle,
>
>         _______________________________________________
>         amd-gfx mailing list
>         amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7C354be34ff18e4f424f6708d7b52b43b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637177069753914395&amp;sdata=9rSL4kgPJweuZ4EJpdqtqTxyCVGEkmsg6aUzbtvGFrs%3D&amp;reserved=0
>         <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Calexander.deucher%40amd.com%7Ce68811adba0647c651a308d7b6b8d4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178777321057824&sdata=uRP0wQyfVKk0QoGlWM36nbeOY67nIjfD6vou2A%2BybEc%3D&reserved=0>
>
>         _______________________________________________
>
>         amd-gfx mailing list
>
>         amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Calexander.deucher%40amd.com%7Ce68811adba0647c651a308d7b6b8d4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178777321067823&sdata=7o2j5dTvK%2B5Gihwd5IB%2Blp1Bi0ZOx%2B%2F%2Bmi8wpRh4NBs%3D&reserved=0>
>


--------------120E17BCC0B10716B7B2DC27
Content-Type: multipart/related;
 boundary="------------AE73600E85AEFDA185981951"

--------------AE73600E85AEFDA185981951
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite"><span style="font-size:10.0pt;color:black">Leave
          the old spm_vmid there is not a problem because other new spm
          enabled job will update it before it’s running and other spm
          disabled job will not access spm_vmid register.</span></blockquote>
      Do you have a high level description of how SPM works? For example
      would it be possible to cause a problem in another application if
      we leave the SPM VMID here and the VMID is reused?<br>
      <br>
      Keep in mind that we need to guarantee process isolation, e.g. we
      can't allow anything bad to happen to another application if
      somebody is stupid enough to turn on SPM tracing without setting
      it up properly.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 24.02.20 um 09:06 schrieb He, Jacob:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB3376E7269CCC628EA0FCCB879BEC0@MN2PR12MB3376.namprd12.prod.outlook.com">
      
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Bookman Old Style";
	panose-1:2 5 6 4 5 5 5 2 2 4;}
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
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";
	color:black;}
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
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style>
      <div class="WordSection1">
        <p class="MsoNormal"><span style="font-size:10.0pt">Ok, I’m glad
            that there is no uapi change needed.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:10.0pt">I checked
            the git log, and reserve_vmid was added for shader debugger,
            not gpa. I’m fine to re-use it since the spm will not
            enabled for shader debug in general. I’ll try to change my
            patch.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:10.0pt">BTW, “</span><span style="font-size:10.0pt;color:black">ring-&gt;funcs-&gt;setup_spm(ring,
            NULL)” to clear the vmid is not gonna work since the job
            with spm enabled execution is not done yet. Leave the old
            spm_vmid there is not a problem because other new spm
            enabled job will update it before it’s running and other spm
            disabled job will not access spm_vmid register.<o:p></o:p></span></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal"><span style="font-size:9.0pt;font-family:&quot;Bookman Old
            Style&quot;,serif">Thanks<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:9.0pt;font-family:&quot;Bookman Old
            Style&quot;,serif">Jacob<o:p></o:p></span></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div style="mso-element:para-border-div;border:none;border-top:solid
          #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
          <p class="MsoNormal" style="border:none;padding:0in"><b>From:
            </b><a href="mailto:David1.Zhou@amd.com" moz-do-not-send="true">Zhou, David(ChunMing)</a><br>
            <b>Sent: </b>Saturday, February 22, 2020 12:45 AM<br>
            <b>To: </b><a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Koenig, Christian</a>; <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
              Deucher, Alexander</a>; <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">Christian König</a>;
            <a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">He,
              Jacob</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
              amd-gfx@lists.freedesktop.org</a><br>
            <b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a chunk ID for
            spm trace</p>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="msipheader4d0fcdd7" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]</span></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">That’s fine to me.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">-David<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a> <br>
              <b>Sent:</b> Friday, February 21, 2020 11:33 PM<br>
              <b>To:</b> Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>; Zhou,
              David(ChunMing) <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou@amd.com">&lt;David1.Zhou@amd.com&gt;</a>; He, Jacob
              <a class="moz-txt-link-rfc2396E" href="mailto:Jacob.He@amd.com">&lt;Jacob.He@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: Add a chunk ID for
              spm trace<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><span style="color:black"><o:p>&nbsp;</o:p></span></p>
        <div>
          <p class="MsoNormal"><span style="color:black">I would just do
              this as part of the vm_flush() callback on the ring.<br>
              <br>
              E.g. check if the VMID you want to flush is reserved and
              if yes enable SPM.<br>
              <br>
              Maybe pass along a flag or something in the job to make
              things easier.<br>
              <br>
              Christian.<br>
              <br>
              Am 21.02.20 um 16:31 schrieb Deucher, Alexander:<o:p></o:p></span></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
              Public Use]<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="color:black"><o:p>&nbsp;</o:p></span></p>
          <div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;color:black">We already have
                  the RESERVE_VMID ioctl interface, can't we just use
                  that internally in the kernel to update the rlc
                  register via the ring when we schedule the relevant
                  IB?&nbsp; E.g., add a new ring callback to set SPM state
                  and then set it to the reserved vmid before we
                  schedule the ib, and then reset it to 0 after the IB
                  in amdgpu_ib_schedule().<o:p></o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;color:black">diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<o:p></o:p></span></p>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">index
                    4b2342d11520..e0db9362c6ee 100644<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&#43;&#43;&#43;
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">@@ -185,6
                    &#43;185,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring
                    *ring, unsigned num_ibs,<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp; &nbsp; &nbsp; &nbsp; if
                    (ring-&gt;funcs-&gt;insert_start)<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    ring-&gt;funcs-&gt;insert_start(ring);<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp;<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&#43; &nbsp; &nbsp; &nbsp; if
                    (ring-&gt;funcs-&gt;setup_spm)<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    ring-&gt;funcs-&gt;setup_spm(ring, job);<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&#43;<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp; &nbsp; &nbsp; &nbsp; if
                    (job) {<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    r = amdgpu_vm_flush(ring, job, need_pipe_sync);<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    if (r) {<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">@@ -273,6
                    &#43;276,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring
                    *ring, unsigned num_ibs,<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    return r;<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp; &nbsp; &nbsp; &nbsp; }<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp;<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&#43; &nbsp; &nbsp; &nbsp; if
                    (ring-&gt;funcs-&gt;setup_spm)<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    ring-&gt;funcs-&gt;setup_spm(ring, NULL);<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&#43;<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp; &nbsp; &nbsp; &nbsp; if
                    (ring-&gt;funcs-&gt;insert_end)<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    ring-&gt;funcs-&gt;insert_end(ring);<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;color:black">&nbsp;<o:p></o:p></span></p>
              </div>
              <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
            </div>
            <p class="MsoNormal" style="text-align:center" align="center"><span style="color:black"><img style="width:3.8472in;height:.0138in" id="Horizontal_x0020_Line_x0020_1" src="cid:part7.1EC7A836.AD45AF78@amd.com" class="" width="369" height="1" border="0"></span><span style="color:black"><o:p></o:p></span></p>
            <div id="divRplyFwdMsg">
              <p class="MsoNormal"><b><span style="color:black">From:</span></b><span style="color:black"> amd-gfx
                  <a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                  on behalf of Christian König
                  <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                  <b>Sent:</b> Friday, February 21, 2020 5:28 AM<br>
                  <b>To:</b> Zhou, David(ChunMing) <a href="mailto:David1.Zhou@amd.com" moz-do-not-send="true">&lt;David1.Zhou@amd.com&gt;</a>;
                  He, Jacob
                  <a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">&lt;Jacob.He@amd.com&gt;</a>;
                  Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                    &lt;Christian.Koenig@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                  <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdgpu: Add a chunk ID
                  for spm trace <o:p></o:p></span></p>
              <div>
                <p class="MsoNormal"><span style="color:black">&nbsp;<o:p></o:p></span></p>
              </div>
            </div>
            <div>
              <div>
                <p class="MsoNormal" style="background:white"><span style="color:black">That would probably be a no-go,
                    but we could enhance the kernel driver to update the
                    RLC_SPM_VMID register with the reserved VMID.<br>
                    <br>
                    Handling that in userspace is most likely not
                    working anyway, since the RLC registers are usually
                    not accessible by userspace.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    Am 20.02.20 um 16:15 schrieb Zhou, David(ChunMing):<o:p></o:p></span></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <div>
                  <p class="xmsipheader4d0fcdd7" style="margin:0in;margin-bottom:.0001pt;background:white">
                    <span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                      Official Use Only - Internal Distribution Only]</span></p>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <p class="xmsonormal" style="background:white">You can
                    enhance amdgpu_vm_ioctl In amdgpu_vm.c to return
                    vmid to userspace.
                  </p>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <p class="xmsonormal" style="background:white">-David</p>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <div>
                    <div style="border:none;border-top:solid #E1E1E1
                      1.0pt;padding:3.0pt 0in 0in 0in">
                      <p class="xmsonormal" style="background:white"><b>From:</b>
                        He, Jacob <a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">
                          &lt;Jacob.He@amd.com&gt;</a> <br>
                        <b>Sent:</b> Thursday, February 20, 2020 10:46
                        PM<br>
                        <b>To:</b> Zhou, David(ChunMing) <a href="mailto:David1.Zhou@amd.com" moz-do-not-send="true">&lt;David1.Zhou@amd.com&gt;</a>;
                        Koenig, Christian
                        <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                        <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                          amd-gfx@lists.freedesktop.org</a><br>
                        <b>Subject:</b> RE: [PATCH] drm/amdgpu: Add a
                        chunk ID for spm trace</p>
                    </div>
                  </div>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <p class="xmsonormal" style="background:white">amdgpu_vm_reserve_vmid
                    doesn’t return the reserved vmid back to user space.
                    There is no chance for user mode driver to update
                    RLC_SPM_VMID.</p>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <p class="xmsonormal" style="background:white">Thanks</p>
                  <p class="xmsonormal" style="background:white">Jacob</p>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="xmsonormal" style="background:white"><b>From:
                      </b><a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">He, Jacob</a><br>
                      <b>Sent: </b>Thursday, February 20, 2020 6:20 PM<br>
                      <b>To: </b><a href="mailto:David1.Zhou@amd.com" moz-do-not-send="true">Zhou, David(ChunMing)</a>;
                      <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                        Koenig, Christian</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                      <b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a
                      chunk ID for spm trace</p>
                  </div>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <p class="xmsonormal" style="background:white">Looks
                    like amdgpu_vm_reserve_vmid could work, let me have
                    a try to update the RLC_SPM_VMID with pm4 packets in
                    UMD.</p>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <p class="xmsonormal" style="background:white">Thanks</p>
                  <p class="xmsonormal" style="background:white">Jacob</p>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="xmsonormal" style="background:white"><b>From:
                      </b><a href="mailto:David1.Zhou@amd.com" moz-do-not-send="true">Zhou, David(ChunMing)</a><br>
                      <b>Sent: </b>Thursday, February 20, 2020 10:13 AM<br>
                      <b>To: </b><a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Koenig, Christian</a>; <a href="mailto:Jacob.He@amd.com" moz-do-not-send="true">
                        He, Jacob</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                      <b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a
                      chunk ID for spm trace</p>
                  </div>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <p class="xmsonormal" style="background:white">[AMD
                    Official Use Only - Internal Distribution Only]<br>
                    <br>
                    Christian is right here, that will cause many
                    problems for simply using VMID in kernel.<br>
                    We already have an pair interface for RGP, I think
                    you can use it instead of involving additional
                    kernel change.<br>
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
                    Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for
                    spm trace<br>
                    <br>
                    Am 19.02.20 um 11:15 schrieb Jacob He:<br>
                    &gt; [WHY]<br>
                    &gt; When SPM trace enabled, SPM_VMID should be
                    updated with the current <br>
                    &gt; vmid.<br>
                    &gt;<br>
                    &gt; [HOW]<br>
                    &gt; Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so
                    that UMD can tell us <br>
                    &gt; which job should update SPM_VMID.<br>
                    &gt; Right before a job is submitted to GPU, set the
                    SPM_VMID accordingly.<br>
                    &gt;<br>
                    &gt; [Limitation]<br>
                    &gt; Running more than one SPM trace enabled
                    processes simultaneously is <br>
                    &gt; not supported.<br>
                    <br>
                    Well there are multiple problems with that patch.<br>
                    <br>
                    First of all you need to better describe what SPM
                    tracing is in the commit message.<br>
                    <br>
                    Then the updating of mmRLC_SPM_MC_CNTL must be
                    executed asynchronously on the ring. Otherwise we
                    might corrupt an already executing SPM trace.<br>
                    <br>
                    And you also need to make sure to disable the
                    tracing again or otherwise we run into a bunch of
                    trouble when the VMID is reused.<br>
                    <br>
                    You also need to make sure that IBs using the SPM
                    trace are serialized with each other, e.g. hack into
                    amdgpu_ids.c file and make sure that only one VMID
                    at a time can have that attribute.<br>
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
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |&nbsp; 1
                    &#43;<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |&nbsp; 1
                    &#43;<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp; | 15
                    &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp;&nbsp; |&nbsp; 3
                    &#43;&#43;-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp; |&nbsp; 3
                    &#43;&#43;-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp; | 15
                    &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
                    &gt;&nbsp;&nbsp; 8 files changed, 48 insertions(&#43;), 7
                    deletions(-)<br>
                    &gt;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c <br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                    &gt; index f9fa6e104fef..3f32c4db5232 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                    &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                    &gt; @@ -113,6 &#43;113,7 @@ static int
                    amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
                    union drm_amdgpu_cs<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uf_offset = 0;<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool update_spm_vmid = false;<br>
                    &gt;&nbsp;&nbsp; <br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cs-&gt;in.num_chunks == 0)<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                    &gt; @@ -221,6 &#43;222,10 @@ static int
                    amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
                    union drm_amdgpu_cs<br>
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
                    amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
                    union drm_amdgpu_cs<br>
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
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c <br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                    &gt; index cae81914c821..36faab12b585 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                    &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                    &gt; @@ -156,9 &#43;156,13 @@ int
                    amdgpu_ib_schedule(struct amdgpu_ring *ring,
                    unsigned num_ibs,<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                    &gt;&nbsp;&nbsp; <br>
                    &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (vm &amp;&amp; !job-&gt;vmid) {<br>
                    &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;VM IB
                    without ID\n&quot;);<br>
                    &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (vm) {<br>
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!job-&gt;vmid) {<br>
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;VM
                    IB without ID\n&quot;);<br>
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if
                    (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid
                    &amp;&amp; job-&gt;need_update_spm_vmid) {<br>
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
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    need_update_spm_vmid;<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasid;<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_base,
                    gds_size;<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gws_base,
                    gws_size;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h <br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
                    &gt; index d3d4707f2168..52509c254cbd 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
                    &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
                    &gt; @@ -126,6 &#43;126,7 @@ struct amdgpu_rlc_funcs {<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*stop)(struct amdgpu_device
                    *adev);<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*reset)(struct amdgpu_device
                    *adev);<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*start)(struct amdgpu_device
                    *adev);<br>
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void (*update_spm_vmid)(struct
                    amdgpu_device *adev, unsigned vmid);<br>
                    &gt;&nbsp;&nbsp; };<br>
                    &gt;&nbsp;&nbsp; <br>
                    &gt;&nbsp;&nbsp; struct amdgpu_rlc {<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c <br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
                    &gt; index 5e9fb0976c6c..91eb788d6229 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
                    &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
                    &gt; @@ -4214,6 &#43;4214,18 @@ static int
                    gfx_v10_0_update_gfx_clock_gating(struct
                    amdgpu_device *adev,<br>
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
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL,
                    data); }<br>
                    &gt; &#43;<br>
                    &gt;&nbsp;&nbsp; static const struct amdgpu_rlc_funcs
                    gfx_v10_0_rlc_funcs = {<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlc_enabled =
                    gfx_v10_0_is_rlc_enabled,<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_safe_mode =
                    gfx_v10_0_set_safe_mode, @@ -4224,7 &#43;4236,8 @@ <br>
                    &gt; static const struct amdgpu_rlc_funcs
                    gfx_v10_0_rlc_funcs = {<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume = gfx_v10_0_rlc_resume,<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop = gfx_v10_0_rlc_stop,<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset = gfx_v10_0_rlc_reset,<br>
                    &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v10_0_rlc_start<br>
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v10_0_rlc_start,<br>
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =
                    gfx_v10_0_update_spm_vmid<br>
                    &gt;&nbsp;&nbsp; };<br>
                    &gt;&nbsp;&nbsp; <br>
                    &gt;&nbsp;&nbsp; static int
                    gfx_v10_0_set_powergating_state(void *handle, diff
                    --git <br>
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
                    &gt;&nbsp;&nbsp; static int gfx_v7_0_early_init(void *handle)
                    diff --git <br>
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
                    gfx_v9_0_update_gfx_clock_gating(struct
                    amdgpu_device *adev,<br>
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
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL,
                    data); }<br>
                    &gt; &#43;<br>
                    &gt;&nbsp;&nbsp; static const struct amdgpu_rlc_funcs
                    gfx_v9_0_rlc_funcs = {<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlc_enabled =
                    gfx_v9_0_is_rlc_enabled,<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_safe_mode = gfx_v9_0_set_safe_mode,
                    @@ -4715,7 &#43;4727,8 @@ <br>
                    &gt; static const struct amdgpu_rlc_funcs
                    gfx_v9_0_rlc_funcs = {<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume = gfx_v9_0_rlc_resume,<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop = gfx_v9_0_rlc_stop,<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset = gfx_v9_0_rlc_reset,<br>
                    &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v9_0_rlc_start<br>
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start = gfx_v9_0_rlc_start,<br>
                    &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =
                    gfx_v9_0_update_spm_vmid<br>
                    &gt;&nbsp;&nbsp; };<br>
                    &gt;&nbsp;&nbsp; <br>
                    &gt;&nbsp;&nbsp; static int
                    gfx_v9_0_set_powergating_state(void *handle,<br>
                    <br>
                    _______________________________________________<br>
                    amd-gfx mailing list<br>
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                    <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7Ce68811adba0647c651a308d7b6b8d4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178777321057824&amp;sdata=uRP0wQyfVKk0QoGlWM36nbeOY67nIjfD6vou2A%2BybEc%3D&amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7C354be34ff18e4f424f6708d7b52b43b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637177069753914395&amp;amp;sdata=9rSL4kgPJweuZ4EJpdqtqTxyCVGEkmsg6aUzbtvGFrs%3D&amp;amp;reserved=0</a></p>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                  <p class="xmsonormal" style="background:white">&nbsp;</p>
                </div>
                <p class="MsoNormal" style="margin-bottom:12.0pt;background:white"><span style="color:black"><o:p>&nbsp;</o:p></span></p>
                <pre style="background:white">_______________________________________________</pre>
                <pre style="background:white">amd-gfx mailing list</pre>
                <pre style="background:white"><a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a></pre>
                <pre style="background:white"><a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7Ce68811adba0647c651a308d7b6b8d4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178777321067823&amp;sdata=7o2j5dTvK%2B5Gihwd5IB%2Blp1Bi0ZOx%2B%2F%2Bmi8wpRh4NBs%3D&amp;reserved=0" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
              </blockquote>
              <p class="MsoNormal" style="background:white"><span style="color:black"><o:p>&nbsp;</o:p></span></p>
            </div>
          </div>
        </blockquote>
        <p class="MsoNormal"><span style="color:black"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="color:black"><o:p>&nbsp;</o:p></span></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------AE73600E85AEFDA185981951
Content-Type: image/png;
 name="516D749F0D1C4C40B3C5D1F556218906.png"
Content-Transfer-Encoding: base64
Content-ID: <part7.1EC7A836.AD45AF78@amd.com>
Content-Disposition: inline;
 filename="516D749F0D1C4C40B3C5D1F556218906.png"

iVBORw0KGgoAAAANSUhEUgAAAioAAAACCAYAAAB2UPfBAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAnSURBVFhH7dbBAAAACASw/KUiiOBgSqPHHnNY
9WQBAD4SFQDgqewBVse2S+U2s6cAAAAASUVORK5CYII=

--------------AE73600E85AEFDA185981951--

--------------120E17BCC0B10716B7B2DC27--

--===============0533862114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0533862114==--
