Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1F8C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 16:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AFE2146E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 16:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eOcgmW0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AFE2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16B86E384;
	Thu, 19 Dec 2019 16:59:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770051.outbound.protection.outlook.com [40.107.77.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFF96E384
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 16:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3YZBtWqRY4k86Ifg12i9cYWyT8lr+3q6Yt90ceqwrRZ2imRwUWhrnKqTxbAfGj50rR8bqdlCxQYMJC39E0T0OdqlLvGdt3SdsK/qoNoa162DIMsE00GvchuzQRUYG9fsh4qykoUQvF9VM/xg43Lcj79O+aP3z4g7CwsIphnevNWf5Hay9Y/0QYr/SUI1PKVCWAX6wK06qErFvWAUDkKqme3D8DBToyWymSfGi3by6RgAM00amkzhDaZwuP4kJmceWu+JVW72XDc7itxtxSVAiMpQQy+AhpVo/vVSR0byrPCrxeg5m0qM4zvQKY0Ae4AArboural/y+JgPHv38i5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z09086K2GWnwO3r+1rTbzelHoDaiGkx5DyLCdsmTQH4=;
 b=dIvpuVNrkWebDi7F1LFjXLRcVOgvGYqH5Y+ai1+QZq0PLGHs3C4AzTfHstzfNODInIHuUutEW05j2KGg9iMzUZaj6bvz+famZPKD9/cA+KXGYPhULWm7ARi523FFwFNSFTvQeTPXDtJwKXSAJTmII1kJQ3BS5VacW8B0iBfSivdf0JxR9lwze2P0RYGyi3HWVEnk3djfH4zEdgJU4MhF7REr4HIaIHkC6yLcNFDnXehaP1JAUJkASfkKo/cz3xyHMVOyoTHAIvXhfY+R5HC+N/UcnB5oOtjlde7uJr2z3Gh1Hg7J/qhFOpQ4vbsJDexZjrhWk7cmsNd5kUSAiqPzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z09086K2GWnwO3r+1rTbzelHoDaiGkx5DyLCdsmTQH4=;
 b=eOcgmW0IFzrsceFoUFo9YkxVBAaLGE1V1cjXfyt6QLucyci6dlIay12rGhpMI0fRPSc76i/yBmKnODsMba8s9uQF7uU+cZXwI/H5JT/iJeoDTMUMDprcoS/ye08W2ax9UyEbMtNVkIC2nr6yHTKLrcBwn0/IALg+XHX5iFmlyQ0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
Received: from DM6PR12MB3241.namprd12.prod.outlook.com (20.179.105.153) by
 DM6PR12MB2969.namprd12.prod.outlook.com (20.178.29.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 16:59:22 +0000
Received: from DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10]) by DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10%5]) with mapi id 15.20.2559.016; Thu, 19 Dec 2019
 16:59:22 +0000
Subject: Re: [PATCwH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
 <1576577994-12874-2-git-send-email-Monk.Liu@amd.com>
 <b4117c49-7107-6ded-a5e0-9fd7ea69e9dc@amd.com>
 <MN2PR12MB3933E586A9792FC3901F460184520@MN2PR12MB3933.namprd12.prod.outlook.com>
 <MN2PR12MB39334EA3BB4AB52FDC37A97084520@MN2PR12MB3933.namprd12.prod.outlook.com>
 <DM6PR12MB3241F577F9502E7C7189B9CDF4520@DM6PR12MB3241.namprd12.prod.outlook.com>
 <MN2PR12MB393372385EF083A4654A28FD84520@MN2PR12MB3933.namprd12.prod.outlook.com>
 <DM6PR12MB32410F2E41C7AC550FCAB829F4520@DM6PR12MB3241.namprd12.prod.outlook.com>
From: shaoyunl <shaoyun.liu@amd.com>
Message-ID: <e348a6ff-803a-a061-f348-a076470b63b9@amd.com>
Date: Thu, 19 Dec 2019 11:59:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <DM6PR12MB32410F2E41C7AC550FCAB829F4520@DM6PR12MB3241.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::18) To DM6PR12MB3241.namprd12.prod.outlook.com
 (2603:10b6:5:186::25)
MIME-Version: 1.0
Received: from [10.1.38.28] (165.204.55.250) by
 YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::18) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Thu, 19 Dec 2019 16:59:22 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d430b0c3-03a2-46ee-4ccc-08d784a4cba2
X-MS-TrafficTypeDiagnostic: DM6PR12MB2969:|DM6PR12MB2969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2969EBC6C37032AC0DFA853AF4520@DM6PR12MB2969.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0256C18696
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(39850400004)(396003)(189003)(199004)(13464003)(51914003)(31686004)(26005)(8936002)(2616005)(52116002)(30864003)(81166006)(81156014)(6486002)(36756003)(186003)(16526019)(53546011)(66616009)(66476007)(66556008)(66946007)(956004)(4001150100001)(45080400002)(86362001)(31696002)(16576012)(19627235002)(110136005)(478600001)(966005)(2906002)(8676002)(316002)(5660300002)(43062003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2969;
 H:DM6PR12MB3241.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DkE6FJoyzbM6pUoBGij+lMa0IsWBDzIeiyBXL8JzaReLCV88LCWObpGc/jT90CoUlM61q5PXXYT6GG6RsAbNc4lMZvwqqT6Fgr4Jpai1TzSuHa+WITfKIfnS3DpzXQ7+yexkd2Wenh5GaYe53ZudbjEdO/DeF68RdlsoEKGa6iuzcJKu/LgeyHwGKUsL2N26nDC3piysLOBCyJJiQ++0CcLqpCNv/P1oLC5ZaMsxOEe8Dj1aBuAk7h/pMDWiRSEhowAaO+V1bEg5lMapTwSbFYUL9+UKY051jlCKttgxawGZJPlQYKj5ur7/JTpisDNVJOnkzM8Sql07VjrEJPIjYyS9ZhL/A1iCPyBXG3TRqgAiIVxyMjNtKLi8YgRhvReh7EoB1C40NGGnkL7PcCGKJikO2jJSa78czeAf94a5Bc98iO+BttMWXmrYM8A3z106Hfu33buqfYlTEJTWBklh/TbKoK1/38pp0AezShv9V+BNlyJmDr2Tw+3dA+9wMuQDndxZpRyWNKOVd+hJ6i/9nQ8H2BBoEmndYdnUIFvybQY+nsgYXL6bdMlhk8lsh8+U8XEx3aPuaH8agvK035hobg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d430b0c3-03a2-46ee-4ccc-08d784a4cba2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 16:59:22.4257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ujf2uCWoyAwRir4KIvv2ndNoLzt91JIZbUIjKJzfBi2bnaa0WvD2mO1BiqvuNQxjXuIApxnPJQRP2jxt/s9Huw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2969
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
Content-Type: multipart/mixed; boundary="===============1632313188=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1632313188==
Content-Type: multipart/alternative;
 boundary="------------FEB15B9FE436DD2571E18528"
Content-Language: en-US

--------------FEB15B9FE436DD2571E18528
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

After check the code , in KFD side , should be simple just add the check 
in stop_cpsch code . For kiq, there is no return for WREG32 , so no easy 
way to check the return value . Maybe we can add kiq_status in struct 
amdgpu_kiq  to indicate the kiq is hang or not ,  in hdq_destroy 
function check this  kiq_status after acquire_queue , finish the destroy 
function is kiq is hang for SRIOV only .

Any comments ?


shaoyun.liu


On 2019-12-19 9:51 a.m., Liu, Shaoyun wrote:

> I see, thanks for the detail information.
> Normally when CP is hang, the hiq access to unmap the queue will 
> failed before driver call to the hqd_destroy. I think driver should 
> add the code to check the return value  and directly finish the 
> pre_reset in this case . If the hiq does not hang but kiq hang. We can 
> use the same logic in hqd_destroy function,  return in first access 
> failure instead go further.  With this change we probably can move the 
> pre_reset function back to normal .
> Felix, do you have any concerns or comments for the change.
>
> Regards
> Shaoyun.liu
> ------------------------------------------------------------------------
> *From:* Liu, Monk <Monk.Liu@amd.com>
> *Sent:* December 19, 2019 1:13:24 AM
> *To:* Liu, Shaoyun <Shaoyun.Liu@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Subject:* RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR 
> of SRIOV
>
> >>> I would like to check why we need a special sequences for sriov on 
> this pre_reset. If possible, make it the same as bare metal mode 
> sounds better solution.
>
> Because before VF FLR calling function would lead to register access 
> through KIQ,  which will not complete because KIQ/GFX already hang by 
> that time
>
> >>> I don't remember any register access by amdkfd_pre_reset call,   
> please let me know if this assumption is wrong .
>
> Please check “void pm_uninit(struct packet_manager *pm)” which is 
> invoked inside of amdkfd_pre_reset() :
>
> It will call uninitialized() in kfd_kernel_queue.c file
>
> And then go to the path of “kq->mqd_mgr->destroy_mqd(…)”
>
> And finally it calls “static int kgd_hqd_destroy(…)” in 
> amdgpu_amdkfd_gfx_v10.c
>
> 539 {
>
> 540     struct amdgpu_device *adev = get_amdgpu_device(kgd);
>
> 541     enum hqd_dequeue_request_type type;
>
> 542     unsigned long end_jiffies;
>
> 543     uint32_t temp;
>
> 544     struct v10_compute_mqd *m = get_mqd(mqd);
>
> 545
>
> 546 #if 0
>
> 547     unsigned long flags;
>
> 548     int retry;
>
> 549 #endif
>
> 550
>
> 551     acquire_queue(kgd, pipe_id, queue_id); //this introduce 
> register access via KIQ
>
> 552
>
> 553     if (m->cp_hqd_vmid == 0)
>
> 554         WREG32_FIELD15(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0); 
> //this introduce register access via KIQ
>
> 555
>
> 556     switch (reset_type) {
>
> 557     case KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN:
>
> 558         type = DRAIN_PIPE;
>
> 559         break;
>
> 560     case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
>
> 561         type = RESET_WAVES;
>
> 562         break;
>
> 563     default:
>
> 564         type = DRAIN_PIPE;
>
> 565         break;
>
> 566     }
>
> 624     WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), 
> type); //this introduce register access via KIQ
>
> 625
>
> 626     end_jiffies = (utimeout * HZ / 1000) + jiffies;
>
> 627     while (true) {
>
> 628         temp = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE)); 
> //this introduce register access via KIQ
>
> 629         if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
>
> 630             break;
>
> 631         if (time_after(jiffies, end_jiffies)) {
>
> 632             pr_err("cp queue preemption time out.\n");
>
> 633             release_queue(kgd);
>
> 634             return -ETIME;
>
> 635         }
>
> 636         usleep_range(500, 1000);
>
> 637     }
>
> 638
>
> 639     release_queue(kgd);
>
> 640     return 0;
>
> If we use the sequence from bare-metal, all above highlighted register 
> access will not work because KIQ/GFX already died by that time which 
> means the amdkfd_pre_reset() is actually  not working as expected.
>
> _____________________________________
>
> Monk Liu|GPU Virtualization Team |AMD
>
> sig-cloud-gpu
>
> *From:* Liu, Shaoyun <Shaoyun.Liu@amd.com>
> *Sent:* Thursday, December 19, 2019 12:30 PM
> *To:* Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR 
> of SRIOV
>
> I don't remember any register access by amdkfd_pre_reset call,   
> please let me know if this assumption is wrong .
> This function will use hiq to access CP, in case CP already hang, we 
> might not able to get the response from hw and will got a timeout. I 
> think kfd internal should handle this. Felix already have some 
> comments on that.
> I would like to check why we need a special sequences for sriov on 
> this pre_reset. If possible, make it the same as bare metal mode 
> sounds better solution.
>
> Regards
> Shaoyun.liu
>
> ------------------------------------------------------------------------
>
> *From:*Liu, Monk <Monk.Liu@amd.com <mailto:Monk.Liu@amd.com>>
> *Sent:* December 18, 2019 10:52:47 PM
> *To:* Liu, Shaoyun <Shaoyun.Liu@amd.com <mailto:Shaoyun.Liu@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> 
> <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
> *Subject:* RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR 
> of SRIOV
>
> Oh, by the way
>
> >>> Do we know the root cause why this function would ruin MEC ?
>
> Only we call this function right after VF FLR will ruin MEC and lead 
> to following KIQ ring test fail , and on bare-metal it is called 
> before gpu rest , so that's why on bare-metal we don't have this issue
>
> But the reason we cannot call it before VF FLR on SRIOV case was 
> already stated in this thread
>
> Thanks
> _____________________________________
> Monk Liu|GPU Virtualization Team |AMD
>
>
> -----Original Message-----
> From: Liu, Monk
> Sent: Thursday, December 19, 2019 11:49 AM
> To: shaoyunl <shaoyun.liu@amd.com <mailto:shaoyun.liu@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> Subject: RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of 
> SRIOV
>
> Hi Shaoyun
>
> >>> Do we know the root cause why this function would ruin MEC ? From 
> the logic, I think this function should be called before FLR since we 
> need to disable the user queue submission first.
> Right now I don't know which detail step lead to KIQ ring test fail, I 
> totally agree with you that this func should be called before VF FLR, 
> but we cannot do it and the reason is described in The comment:
>
> > if we do pre_reset() before VF FLR, it would go KIQ way to do register
> > access and stuck there, because KIQ probably won't work by that time
> > (e.g. you already made GFX hang)
>
>
> >>> I remembered the function should use hiq to communicate with HW , 
> shouldn't use kiq to access HW registerm,  has this been changed ?
> Tis function use WREG32/RREG32 to do register access, like all other 
> functions in KMD,  and WREG32/RREG32 will let KIQ to do the register 
> access If we are under dynamic SRIOV  mode (means we are SRIOV VF and 
> isn't under full exclusive mode)
>
> You see that if you call this func before EVENT_5 (event 5 triggers VF 
> FLR) then it will run under dynamic mode and KIQ will handle the 
> register access, which is not an option Since ME/MEC probably already 
> hang ( if we are testing quark on gfx/compute rings)
>
> Do you have a good suggestion ?
>
> thanks
> _____________________________________
> Monk Liu|GPU Virtualization Team |AMD
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org 
> <mailto:amd-gfx-bounces@lists.freedesktop.org>> On Behalf Of shaoyunl
> Sent: Tuesday, December 17, 2019 11:38 PM
> To: amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of 
> SRIOV
>
> I think amdkfd side depends on this call to stop the user queue, 
> without this call, the user queue can submit to HW during the reset 
> which could cause hang again ...
> Do we know the root cause why this function would ruin MEC ? From the 
> logic, I think this function should be called before FLR since we need 
> to disable the user queue submission first.
> I remembered the function should use hiq to communicate with HW , 
> shouldn't use kiq to access HW registerm,  has this been changed ?
>
>
> Regards
> shaoyun.liu
>
>
> On 2019-12-17 5:19 a.m., Monk Liu wrote:
> > issues:
> > MEC is ruined by the amdkfd_pre_reset after VF FLR done
> >
> > fix:
> > amdkfd_pre_reset() would ruin MEC after hypervisor finished the VF
> > FLR, the correct sequence is do amdkfd_pre_reset before VF FLR but
> > there is a limitation to block this sequence:
> > if we do pre_reset() before VF FLR, it would go KIQ way to do register
> > access and stuck there, because KIQ probably won't work by that time
> > (e.g. you already made GFX hang)
> >
> > so the best way right now is to simply remove it.
> >
> > Signed-off-by: Monk Liu <Monk.Liu@amd.com <mailto:Monk.Liu@amd.com>>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 605cef6..ae962b9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3672,8 +3672,6 @@ static int amdgpu_device_reset_sriov(struct 
> amdgpu_device *adev,
> >        if (r)
> >                return r;
> >
> > -     amdgpu_amdkfd_pre_reset(adev);
> > -
> >        /* Resume IP prior to SMC */
> >        r = amdgpu_device_ip_reinit_early_sriov(adev);
> >        if (r)
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7Cee9c811452634fc2739808d7830718f6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637121938885721447&amp;sdata=FiqkgiUX8k5rD%2F%2FiJQU2cF1MGExO8yXEzYOoBtpdfYU%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7CShaoyun.Liu%40amd.com%7Cff429b9d30b24af8955508d78492e8bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637123639048992279&sdata=38z3sISWX26bZPplKeHvD0xIPCRbPAW%2BgKv2cXqetXc%3D&reserved=0>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CShaoyun.Liu%40amd.com%7Cff429b9d30b24af8955508d78492e8bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637123639049012267&amp;sdata=se3rrEVIDZa677riVu5MAf95y%2BxndiDw5BULScsxFBc%3D&amp;reserved=0

--------------FEB15B9FE436DD2571E18528
Content-Type: multipart/related;
 boundary="------------130CDA6F2568317A49D3EB92"

--------------130CDA6F2568317A49D3EB92
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>After check the code , in KFD side , should be simple just add
      the check in stop_cpsch code . For kiq, there is no return for
      WREG32 , so no easy way to check the return value . Maybe we can
      add kiq_status in struct amdgpu_kiq&nbsp; to indicate the kiq is hang
      or not ,&nbsp; in hdq_destroy function check this&nbsp; kiq_status after
      acquire_queue , finish the destroy function is kiq is hang for
      SRIOV only . <br>
    </p>
    <p> Any comments ? <br>
    </p>
    <p><br>
    </p>
    <p>shaoyun.liu<br>
    </p>
    <p><br>
    </p>
    <p>On 2019-12-19 9:51 a.m., Liu, Shaoyun wrote:<br>
    </p>
    <blockquote type="cite" cite="mid:DM6PR12MB32410F2E41C7AC550FCAB829F4520@DM6PR12MB3241.namprd12.prod.outlook.com">
      
      I see, thanks for the detail information.<br>
      Normally when CP is hang, the hiq access to unmap the queue will
      failed before driver call to the hqd_destroy. I think driver
      should add the code to check the return value&nbsp; and directly finish
      the pre_reset in this case . If the hiq does not hang but kiq
      hang. We can use the same logic in hqd_destroy function,&nbsp; return
      in first access failure instead go further.&nbsp; With this change we
      probably can move the pre_reset function back to normal .
      <br>
      Felix, do you have any concerns or comments for the change.<br>
      <br>
      Regards<br>
      Shaoyun.liu<br>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Liu,
          Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a><br>
          <b>Sent:</b> December 19, 2019 1:13:24 AM<br>
          <b>To:</b> Liu, Shaoyun <a class="moz-txt-link-rfc2396E" href="mailto:Shaoyun.Liu@amd.com">&lt;Shaoyun.Liu@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
          <b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test
          fail in TDR of SRIOV</font>
        <div>&nbsp;</div>
      </div>
      <style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:DengXian}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.x_MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
p.x_msonormal0, li.x_msonormal0, div.x_msonormal0
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle19
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.25in 1.0in 1.25in}
div.x_WordSection1
	{}
-->
</style>
      <div link="blue" vlink="purple" lang="EN-US">
        <div class="x_WordSection1">
          <p class="x_MsoNormal">&gt;&gt;&gt; I would like to check why
            we need a special sequences for sriov on this pre_reset. If
            possible, make it the same as bare metal mode sounds better
            solution.</p>
          <p class="x_MsoNormal">&nbsp;</p>
          <p class="x_MsoNormal">Because before VF FLR calling function
            would lead to register access through KIQ, &nbsp;which will not
            complete because KIQ/GFX already hang by that time</p>
          <p class="x_MsoNormal">&nbsp;</p>
          <p class="x_MsoNormal">&gt;&gt;&gt; I don't remember any
            register access by amdkfd_pre_reset call,&nbsp;&nbsp; please let me
            know if this assumption is wrong .</p>
          <p class="x_MsoNormal">&nbsp;</p>
          <p class="x_MsoNormal">Please check “void pm_uninit(struct
            packet_manager *pm)” which is invoked inside of
            amdkfd_pre_reset() :
          </p>
          <p class="x_MsoNormal">&nbsp;</p>
          <p class="x_MsoNormal">It will call uninitialized() in
            kfd_kernel_queue.c file</p>
          <p class="x_MsoNormal">&nbsp;</p>
          <p class="x_MsoNormal">And then go to the path of
            “kq-&gt;mqd_mgr-&gt;destroy_mqd(…)”</p>
          <p class="x_MsoNormal">&nbsp;</p>
          <p class="x_MsoNormal">And finally it calls “static int <span style="background:yellow">
              kgd_hqd_destroy</span>(…)” in amdgpu_amdkfd_gfx_v10.c</p>
          <p class="x_MsoNormal">&nbsp;</p>
          <p class="x_MsoNormal">&nbsp;</p>
          <p class="x_MsoNormal">539 {</p>
          <p class="x_MsoNormal">540&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
            get_amdgpu_device(kgd);</p>
          <p class="x_MsoNormal">541&nbsp;&nbsp;&nbsp;&nbsp; enum hqd_dequeue_request_type
            type;</p>
          <p class="x_MsoNormal">542&nbsp;&nbsp;&nbsp;&nbsp; unsigned long end_jiffies;</p>
          <p class="x_MsoNormal">543&nbsp;&nbsp;&nbsp;&nbsp; uint32_t temp;</p>
          <p class="x_MsoNormal">544&nbsp;&nbsp;&nbsp;&nbsp; struct v10_compute_mqd *m =
            get_mqd(mqd);</p>
          <p class="x_MsoNormal">545</p>
          <p class="x_MsoNormal">546 #if 0</p>
          <p class="x_MsoNormal">547&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;</p>
          <p class="x_MsoNormal">548&nbsp;&nbsp;&nbsp;&nbsp; int retry;</p>
          <p class="x_MsoNormal">549 #endif</p>
          <p class="x_MsoNormal">550</p>
          <p class="x_MsoNormal">551&nbsp;&nbsp;&nbsp;&nbsp; acquire_queue(kgd, pipe_id,
            queue_id); <span style="background:yellow">
              //this introduce register access via KIQ</span></p>
          <p class="x_MsoNormal">552</p>
          <p class="x_MsoNormal">553&nbsp;&nbsp;&nbsp;&nbsp; if (m-&gt;cp_hqd_vmid == 0)</p>
          <p class="x_MsoNormal">554&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(GC, 0,
            RLC_CP_SCHEDULERS, scheduler1, 0);
            <span style="background:yellow">//this introduce register
              access via KIQ</span></p>
          <p class="x_MsoNormal">555</p>
          <p class="x_MsoNormal">556&nbsp;&nbsp;&nbsp;&nbsp; switch (reset_type) {</p>
          <p class="x_MsoNormal">557&nbsp;&nbsp;&nbsp;&nbsp; case
            KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN:</p>
          <p class="x_MsoNormal">558&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type = DRAIN_PIPE;</p>
          <p class="x_MsoNormal">559&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</p>
          <p class="x_MsoNormal">560&nbsp;&nbsp;&nbsp;&nbsp; case
            KFD_PREEMPT_TYPE_WAVEFRONT_RESET:</p>
          <p class="x_MsoNormal">561&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type = RESET_WAVES;</p>
          <p class="x_MsoNormal">562&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</p>
          <p class="x_MsoNormal">563&nbsp;&nbsp;&nbsp;&nbsp; default:</p>
          <p class="x_MsoNormal">564&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type = DRAIN_PIPE;</p>
          <p class="x_MsoNormal">565&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</p>
          <p class="x_MsoNormal">566&nbsp;&nbsp;&nbsp;&nbsp; }</p>
          <p class="x_MsoNormal">624&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0,
            mmCP_HQD_DEQUEUE_REQUEST), type);
            <span style="background:yellow">//this introduce register
              access via KIQ</span></p>
          <p class="x_MsoNormal">625</p>
          <p class="x_MsoNormal">626&nbsp;&nbsp;&nbsp;&nbsp; end_jiffies = (utimeout * HZ /
            1000) &#43; jiffies;</p>
          <p class="x_MsoNormal">627&nbsp;&nbsp;&nbsp;&nbsp; while (true) {</p>
          <p class="x_MsoNormal">628&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =
            RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
            <span style="background:yellow">//this introduce register
              access via KIQ</span></p>
          <p class="x_MsoNormal">629&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(temp &amp;
            CP_HQD_ACTIVE__ACTIVE_MASK))</p>
          <p class="x_MsoNormal">630&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</p>
          <p class="x_MsoNormal">631&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies,
            end_jiffies)) {</p>
          <p class="x_MsoNormal">632&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;cp queue
            preemption time out.\n&quot;);</p>
          <p class="x_MsoNormal">633&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_queue(kgd);</p>
          <p class="x_MsoNormal">634&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIME;</p>
          <p class="x_MsoNormal">635&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
          <p class="x_MsoNormal">636&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usleep_range(500, 1000);</p>
          <p class="x_MsoNormal">637&nbsp;&nbsp;&nbsp;&nbsp; }</p>
          <p class="x_MsoNormal">638</p>
          <p class="x_MsoNormal">639&nbsp;&nbsp;&nbsp;&nbsp; release_queue(kgd);</p>
          <p class="x_MsoNormal">640&nbsp;&nbsp;&nbsp;&nbsp; return 0;</p>
          <p class="x_MsoNormal">&nbsp;</p>
          <p class="x_MsoNormal">If we use the sequence from bare-metal,
            all above <span style="background:yellow">
              highlighted</span> register access will not work because
            KIQ/GFX already died by that time which means the
            amdkfd_pre_reset() is actually&nbsp; not working as expected.</p>
          <p class="x_MsoNormal">&nbsp;</p>
          <div>
            <p class="x_MsoNormal">_____________________________________</p>
            <p class="x_MsoNormal"><span style="font-size:12.0pt;
                color:black; background:white">Monk Liu|GPU
                Virtualization Team |</span><span style="font-size:12.0pt; color:#C82613; border:none
                windowtext 1.0pt; padding:0in; background:white">AMD</span></p>
            <p class="x_MsoNormal"><img id="x_Picture_x0020_1" alt="sig-cloud-gpu" style="width:.8333in;
                height:.8333in" data-outlook-trace="F:1|T:1" src="cid:part1.23715BFA.C2802CFE@amd.com" class="" width="80" height="80"></p>
          </div>
          <p class="x_MsoNormal">&nbsp;</p>
          <div>
            <div style="border:none; border-top:solid #E1E1E1 1.0pt;
              padding:3.0pt 0in 0in 0in">
              <p class="x_MsoNormal"><b>From:</b> Liu, Shaoyun
                <a class="moz-txt-link-rfc2396E" href="mailto:Shaoyun.Liu@amd.com">&lt;Shaoyun.Liu@amd.com&gt;</a> <br>
                <b>Sent:</b> Thursday, December 19, 2019 12:30 PM<br>
                <b>To:</b> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring
                test fail in TDR of SRIOV</p>
            </div>
          </div>
          <p class="x_MsoNormal">&nbsp;</p>
          <p class="x_MsoNormal">I don't remember any register access by
            amdkfd_pre_reset call,&nbsp;&nbsp; please let me know if this
            assumption is wrong .
            <br>
            This function will use hiq to access CP, in case CP already
            hang, we might not able to get the response from hw and will
            got a timeout. I think kfd internal should handle this.
            Felix already have some comments on that.
            <br>
            I would like to check why we need a special sequences for
            sriov on this pre_reset. If possible, make it the same as
            bare metal mode sounds better solution.
            <br>
            <br>
            Regards<br>
            Shaoyun.liu</p>
          <div class="x_MsoNormal" style="text-align:center" align="center">
            <hr width="98%" size="3" align="center">
          </div>
          <div id="x_divRplyFwdMsg">
            <p class="x_MsoNormal"><b><span style="color:black">From:</span></b><span style="color:black"> Liu, Monk &lt;<a href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">Monk.Liu@amd.com</a>&gt;<br>
                <b>Sent:</b> December 18, 2019 10:52:47 PM<br>
                <b>To:</b> Liu, Shaoyun &lt;<a href="mailto:Shaoyun.Liu@amd.com" moz-do-not-send="true">Shaoyun.Liu@amd.com</a>&gt;;
                <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                <b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring
                test fail in TDR of SRIOV</span>
            </p>
            <div>
              <p class="x_MsoNormal">&nbsp;</p>
            </div>
          </div>
          <div>
            <div>
              <p class="x_MsoNormal">Oh, by the way<br>
                <br>
                &gt;&gt;&gt; Do we know the root cause why this function
                would ruin MEC ?<br>
                <br>
                Only we call this function right after VF FLR will ruin
                MEC and lead to following KIQ ring test fail , and on
                bare-metal it is called before gpu rest , so that's why
                on bare-metal we don't have this issue
                <br>
                <br>
                But the reason we cannot call it before VF FLR on SRIOV
                case was already stated in this thread
                <br>
                <br>
                Thanks<br>
                _____________________________________<br>
                Monk Liu|GPU Virtualization Team |AMD<br>
                <br>
                <br>
                -----Original Message-----<br>
                From: Liu, Monk <br>
                Sent: Thursday, December 19, 2019 11:49 AM<br>
                To: shaoyunl &lt;<a href="mailto:shaoyun.liu@amd.com" moz-do-not-send="true">shaoyun.liu@amd.com</a>&gt;; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                  amd-gfx@lists.freedesktop.org</a><br>
                Subject: RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test
                fail in TDR of SRIOV<br>
                <br>
                Hi Shaoyun<br>
                <br>
                &gt;&gt;&gt; Do we know the root cause why this function
                would ruin MEC ? From the logic, I think this function
                should be called before FLR since we need to disable the
                user queue submission first.<br>
                Right now I don't know which detail step lead to KIQ
                ring test fail, I totally agree with you that this func
                should be called before VF FLR, but we cannot do it and
                the reason is described in The comment:<br>
                <br>
                &gt; if we do pre_reset() before VF FLR, it would go KIQ
                way to do register <br>
                &gt; access and stuck there, because KIQ probably won't
                work by that time <br>
                &gt; (e.g. you already made GFX hang)<br>
                <br>
                <br>
                &gt;&gt;&gt; I remembered the function should use hiq to
                communicate with HW , shouldn't use kiq to access HW
                registerm,&nbsp; has this been changed ?<br>
                Tis function use WREG32/RREG32 to do register access,
                like all other functions in KMD,&nbsp; and WREG32/RREG32 will
                let KIQ to do the register access If we are under
                dynamic SRIOV&nbsp; mode (means we are SRIOV VF and isn't
                under full exclusive mode)<br>
                <br>
                You see that if you call this func before EVENT_5 (event
                5 triggers VF FLR) then it will run under dynamic mode
                and KIQ will handle the register access, which is not an
                option Since ME/MEC probably already hang ( if we are
                testing quark on gfx/compute rings)<br>
                <br>
                Do you have a good suggestion ?<br>
                <br>
                thanks<br>
                _____________________________________<br>
                Monk Liu|GPU Virtualization Team |AMD<br>
                <br>
                <br>
                -----Original Message-----<br>
                From: amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                On Behalf Of shaoyunl<br>
                Sent: Tuesday, December 17, 2019 11:38 PM<br>
                To: <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                Subject: Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring test
                fail in TDR of SRIOV<br>
                <br>
                I think amdkfd side depends on this call to stop the
                user queue, without this call, the user queue can submit
                to HW during the reset which could cause hang again ...<br>
                Do we know the root cause why this function would ruin
                MEC ? From the logic, I think this function should be
                called before FLR since we need to disable the user
                queue submission first.<br>
                I remembered the function should use hiq to communicate
                with HW , shouldn't use kiq to access HW registerm,&nbsp; has
                this been changed ?<br>
                <br>
                <br>
                Regards<br>
                shaoyun.liu<br>
                <br>
                <br>
                On 2019-12-17 5:19 a.m., Monk Liu wrote:<br>
                &gt; issues:<br>
                &gt; MEC is ruined by the amdkfd_pre_reset after VF FLR
                done<br>
                &gt;<br>
                &gt; fix:<br>
                &gt; amdkfd_pre_reset() would ruin MEC after hypervisor
                finished the VF <br>
                &gt; FLR, the correct sequence is do amdkfd_pre_reset
                before VF FLR but <br>
                &gt; there is a limitation to block this sequence:<br>
                &gt; if we do pre_reset() before VF FLR, it would go KIQ
                way to do register <br>
                &gt; access and stuck there, because KIQ probably won't
                work by that time <br>
                &gt; (e.g. you already made GFX hang)<br>
                &gt;<br>
                &gt; so the best way right now is to simply remove it.<br>
                &gt;<br>
                &gt; Signed-off-by: Monk Liu &lt;<a href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">Monk.Liu@amd.com</a>&gt;<br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --<br>
                &gt;&nbsp;&nbsp; 1 file changed, 2 deletions(-)<br>
                &gt;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; index 605cef6..ae962b9 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; @@ -3672,8 &#43;3672,6 @@ static int
                amdgpu_device_reset_sriov(struct amdgpu_device *adev,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_pre_reset(adev);<br>
                &gt; -<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resume IP prior to SMC */<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                amdgpu_device_ip_reinit_early_sriov(adev);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CShaoyun.Liu%40amd.com%7Cff429b9d30b24af8955508d78492e8bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637123639048992279&amp;sdata=38z3sISWX26bZPplKeHvD0xIPCRbPAW%2BgKv2cXqetXc%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="fJjiWFKlD22S65DZzKzYfWPzvbk6szqEbARbO2cHpufzWepvYwZUK8/RfuhYscLVYP0/3E5byFt54ohYSkKrbBwnDazDf2rzjOxnlZFN/Y&#43;Qe1uahIq4uneyCNMCvWijSFpqjwkgpvx&#43;irf/BA&#43;w1/RQX5MzXTTfoyKCf8pD4os=" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cmonk.liu%40amd.com%7Cee9c811452634fc2739808d7830718f6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637121938885721447&amp;amp;sdata=FiqkgiUX8k5rD%2F%2FiJQU2cF1MGExO8yXEzYOoBtpdfYU%3D&amp;amp;reserved=0</a></p>
            </div>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7CShaoyun.Liu%40amd.com%7Cff429b9d30b24af8955508d78492e8bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637123639049012267&amp;amp;sdata=se3rrEVIDZa677riVu5MAf95y%2BxndiDw5BULScsxFBc%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7CShaoyun.Liu%40amd.com%7Cff429b9d30b24af8955508d78492e8bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637123639049012267&amp;amp;sdata=se3rrEVIDZa677riVu5MAf95y%2BxndiDw5BULScsxFBc%3D&amp;amp;reserved=0</a>
</pre>
    </blockquote>
  </body>
</html>

--------------130CDA6F2568317A49D3EB92
Content-Type: image/png;
 name="image001.png"
Content-Transfer-Encoding: base64
Content-ID: <part1.23715BFA.C2802CFE@amd.com>
Content-Disposition: inline;
 filename="image001.png"

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

--------------130CDA6F2568317A49D3EB92--

--------------FEB15B9FE436DD2571E18528--

--===============1632313188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1632313188==--
