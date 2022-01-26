Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F0EC2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 15:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D2F10E6E3;
	Wed, 26 Jan 2022 15:08:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F81410E6E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 15:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZbYy+9Klehgtdntj4/TrV3rZzARzzgO0oLWj6UefES6SF1cwfuVusCdwWQjXtO3UcGjOlD9nOfuzDNdT/hg4sXhwwvlQ7jWs4B1jlqaQZRRUcWcTvo1OQEFfT66lRamAX2hFdlxtQQt0dJqBKD006NV4bZN8ocS8MfEULiBXeknAHRoLGzj+NmG4vENXHjUdybAVnhaFIVYARLZGP7DK3ThmzSVFy3pkYidnRqgV8k9r7AKNewKN7c0UEWd8AaCULHrnwWeff4hVLclrMgN3kUEkvJABh49rFfG8vNccWeChIV2rNZpwvuQbN+LS5D38lb/qjMAFokmXVudo6Mr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3atWeMKNFf7eF/gxhpuW37epDnvkIfkmHw+LSfKLJFY=;
 b=Gxmkm3OFMJauOWhOVjWGNCvX8D+Q1KXIDnvUH5I8J8YxxAEJZ16PF5S+pL0IL8tauxiL9TPzjSRDuamUww500w/7TsfOZz8/YldF4XQcQWA74vR7872UONT9hDubCYcaVZ/A3IntI0lQHrXg40ec1hrQvgTszJMvjHq9GqPQOzCFopIuNK8mRcz8OeVxSY6YO7wHpJQaM9PMHfFhryIcDhOjiP1B+2crSDYNvR0AO+tG1ZMuWuMAa/3nxtoDYHC7aKohS3yJ078bx5qwpUsgDHoyVIc3S+0yk7/Mu4awZ/k70WKoW3d7ei6/LGFlN0qAHC0WLyTcNa35cj1z2iKhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3atWeMKNFf7eF/gxhpuW37epDnvkIfkmHw+LSfKLJFY=;
 b=td3KqzGaUEq2FaZq7Neb2eaQTfEs3N8kiG9CUr7SM7O2uVwqMOM3vVk8ey/5jz/JU4FvTgRBS878cUywS5MaTPc3ARF1AwJAiCj/jNtTtrU578tVzirlbynMwQ6s2GsmqMlhUU5/Zmga/6+/4et18Z/mChCrOTa/eVDlnJyi3TU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1920.namprd12.prod.outlook.com (2603:10b6:300:10e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Wed, 26 Jan
 2022 15:08:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 15:08:03 +0000
Message-ID: <c7a7d79c-c59e-51ed-07fc-22d9b57c1271@amd.com>
Date: Wed, 26 Jan 2022 10:08:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
Content-Language: en-US
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220125100321.450194-1-tianci.yin@amd.com>
 <SJ0PR12MB54888020E0D600D546BAC634825F9@SJ0PR12MB5488.namprd12.prod.outlook.com>
 <b5fab406-062f-1fdb-832b-1ba0249e1e10@amd.com>
 <DM4PR12MB52949E3762DF92C8C747ED8A95209@DM4PR12MB5294.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM4PR12MB52949E3762DF92C8C747ED8A95209@DM4PR12MB5294.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fffdc5ec-37cf-47c7-5273-08d9e0dda5ec
X-MS-TrafficTypeDiagnostic: MWHPR12MB1920:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB19208076448DB711874363B492209@MWHPR12MB1920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XR7jhUq5lN8rjZ/kWWONc5YTSTNAFjDk2GmqNOWKbNG07gntd1qH2yAaaff6xyVnI8CAnrgenLOqDZYjO6tSj1CKIcelafyjgcnFjFMK6fPFBy3IUnRMJyAUrqOjxglwAnZyDfMbPMNY1+8shKfSusLylq9esDmqd9BgwPjCWvrlQHJwpTaTJbr6Lb1Jr4wJDcQ8Ay1/JXzbOihHLWCb1I9XcQUsJJPyNYMBE6psecSslzW8O2qBpT0ZqQX1gmSDXfYM+2MC2csnzagNdmsbinsGXGIeeXee1sNnDeb6sgFrTCQ6xzMPE1M8MllDotiCNtZhrW0x1aLBopAs6mo+T8UQX/vbWCmtENq9FwshB8Q/w9XR2M1gT2r/kfx9PonFprpz70RVuW/km0vntJKDpMrx0+AFy+VAq6rNHxJ6riwW5CfA9iSSOkINK84LRkEzieeNoI8wsMSpGgh0EQbjNlSMwdE2LizLyeC44a+qKSY5Vt4sy2iChALvvAPHRl3jx7mOg0JrZ3elzNuEygu9iBq7GE3Xz1R95vw6pQaRK5vvjlCOSB5aZiiggiA455YldGmlF1D1qeobNLXa9wo9A7rtECZjC7ZYeYNIFzVLa2HOhiyggMkPAPg0arjb6H3t4DLgJauXOJxnkVltNjTWjG4Pnlz2UBNbmGDF2InyfMkoGqSa/KVitVXzFNAwVcpSd5mJcCL3nYxVP5GlT3B3XVBPObBu52oznt8VlvomxPLYW9Xg/lS24YMhV2CPAQrA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(44832011)(5660300002)(15650500001)(110136005)(2906002)(38100700002)(54906003)(6486002)(8936002)(86362001)(6512007)(31696002)(66556008)(26005)(83380400001)(316002)(66476007)(508600001)(6506007)(36756003)(186003)(31686004)(8676002)(4326008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJiWUk0SVl0ajRiSGpPSmJ5TFlpYjNyaTluZTgzZURueWc5UmpacXVHeW1s?=
 =?utf-8?B?ZzM0ckxRbmhzS3RBYXk5bEs3djdNek8xZHBOUWMyUWYvWGtzTktnYWdQU05Y?=
 =?utf-8?B?SEpHWlo1Q296Tkl3eFBaRktuUXZBY1ZEanRKQzl3dCtuWnpFaHRqU0QzbHdt?=
 =?utf-8?B?Tmh6c0VZQ1FwM20zd21hWVFKVjNrbmVOYXMxSzVGRFdpRlFaRDBOaXZ5K3Zl?=
 =?utf-8?B?OHdzejRtRmx5VUEyVTgzQkExNktoWlhZaUY2TzR2aUV1dnExenEyV0dwOWxB?=
 =?utf-8?B?b2NIMmJQekJZbWVJZERvUWFrR0ZUaGtEQS80NEJKK2o3Z3BrWXo3aTBIcm45?=
 =?utf-8?B?WElKelJwUmZhOVBBVnRqL2hFSlRwc2lTQ2N1ZjVBV3BsdXZsTDVvSmF3UTIz?=
 =?utf-8?B?bWFmUlFwamwydDJCSk5QaTcwV3g0aFhjeU4za0x5VFp1R0xoaXBzOUx0akVZ?=
 =?utf-8?B?ZHlaTDhwVjlyWXpJNTVMSzJXYUhWN2pRbitGZ2lacTdMYWxySzZuMG1PMXF1?=
 =?utf-8?B?R2dpTlBLS1F6VU4wcWlLWDVlSnFhQzJVdWFwdE91SlB4emRWeGZTYVNhYldy?=
 =?utf-8?B?OVlnYUlsY0xXa1dsem1lNDdKMzRXNmZIOEh4dms3NG5MVDFFNEIrUmJZTmpE?=
 =?utf-8?B?RVFlc0ZuUzFxdFJxRHR5OG1aT2srSG9VdXZwZ1FPSXhrZGFjR3dxaEIxVlFy?=
 =?utf-8?B?OUtIb1ZReXlBMURPdm94aS9TMlZiYzJKK2NDRCtkVnMxTHhIL1FkV25mTWNv?=
 =?utf-8?B?MWRvSEhvVWZnUjNNZW1wOXNFWVdMajM1MDFudGJ1cUEzUU1kaGU5MHM4NnM1?=
 =?utf-8?B?elo3Yzhib1Vrbms5YXlDd3JKdWFlUTlrU294ZTlFYm00VTBTa09sTm1EM0d4?=
 =?utf-8?B?S3hMdVlJODBHaVZDK1JkMDRvRzVmbFV4dEY4Ymd1SnhTdi9kVDRkVU5EVXF2?=
 =?utf-8?B?MktxYXhEbGZxNHdVUjZhNEV6cTJPNVFrY2t3VkJ0WWdleVVnRXBxUmxaMUhu?=
 =?utf-8?B?bE9PcUg0L3JxUzhQRFVGdTdNeisraElpRmxEU3labkU1eHM0MWxjcHNvZGtV?=
 =?utf-8?B?dUFFb1pkcVB4WlE4cjk2Q2kyUWtxejlHV1RmbTBrOUFLSkVFRUVHRzRMUXJ0?=
 =?utf-8?B?aC9sZGpLaEczd0g1enlQZExjczMzRlpJMlFjelp6aWZTTVkzbi9tbVlEWjcr?=
 =?utf-8?B?Q3JjNndQT1NEdmVDWEhqYUl4NE9zRmt6dkdOdWxtdU1ZT1dNVDh1VzFOTUpL?=
 =?utf-8?B?SHM0K0x3TmI0TkxWUEhEYkVEcS9sa3RUeFdwYUdPY2tEWklZVXJTb1d1ek1h?=
 =?utf-8?B?VUtURFljRlpGNXA0cnJCUnpxb0pseUcvRWZkVDJ4cEJicmdkMnYzRExhQVNS?=
 =?utf-8?B?ZDlxTEw4cXdGRCt5bithVjk2bzNNakdCS2x1eWxpRDYrYmpvdnlVb0k0ckZQ?=
 =?utf-8?B?bkZQakduU1F4T1dxbEFTU1cxTDNRbHk3VUd6alo5eWtzSGlHUUFCRDhIeDRK?=
 =?utf-8?B?VTlUTm1XVUljMEdKL2Zub0xnQzdFUFZ3dktrTTk3R0dXYUVPelhjd2lYWXM4?=
 =?utf-8?B?ZlFBMkE1UUtMMTl5TThvVy9oVXVCVENESzgrZXN4bWhXcXVESzdNaXlic09H?=
 =?utf-8?B?V3VKN0FaNFZEU21HSE9rVmV6L0Y4UncrUWw5VVg4WTdiVUx2ZzBKakt4RTlQ?=
 =?utf-8?B?QVdodkxrNHBZVjNmV1MwdXJzRmVmN0dDQzhYQ0k3MGxwc3NBa0laTlAxQjFx?=
 =?utf-8?B?RnlqdmtNbWJsMFBpalYwdlFyUkdNUkZxVjl5bDUrSFNHYitXSHN0OWlZdkx0?=
 =?utf-8?B?Y3BsUE8rYkdkaDhMYlFuUmk1dURMMVBKaDNsYU1pUlByUUNjSzdTZlZhKzJq?=
 =?utf-8?B?SGpka2hZaFJjcWIyU25GU3BtNHo3V0JWbWtybEwveVQxbkJOOHgyR3BOMGVt?=
 =?utf-8?B?S1FpZnhtZkE0S09uVXU3QXp3WHpkTlowRUpiVzI4YlNYTVQ4NEhGaXVPcENO?=
 =?utf-8?B?ZzFsV1ZIWGVaR3FONksrcnlrMWdaWFhiOXg2WDRMaUdOT0s0V1dzY2tjVWQ5?=
 =?utf-8?B?RStmRXFKendtT3orM3pjZ1cxbElzcmtTVVNjaHJuRnUwVU5ibjFFenVybTha?=
 =?utf-8?B?RDJYY2ltcW0rdm9YTjFGbnVUeVhscW5sWWZmN093YnovV1Q0c1Arc1BEQzJX?=
 =?utf-8?Q?9zpKjPAhBqJ+rlox0aX5aJ0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffdc5ec-37cf-47c7-5273-08d9e0dda5ec
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 15:08:02.9038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoM6M54kvrqKcCj4EIfPNzp3YeAmTlkjb8htjDmH0ByL4aDgZU/z2mvmnM3dl/IfD+qZXjmcK52iqwE4NIe77Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1920
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

My question is, why is this problem only seen during module unload? Why 
aren't we seeing HWS hangs due to GFX_OFF all the time in normal 
operations? For example when the GPU is idle and a new KFD process is 
started, creating a new runlist. Are we just getting lucky because the 
process first has to allocate some memory, which maybe makes some HW 
access (flushing TLBs etc.) that wakes up the GPU?


Regards,
   Felix



Am 2022-01-26 um 01:43 schrieb Yin, Tianci (Rico):
>
> [AMD Official Use Only]
>
>
> Thanks Kevin and Felix!
>
> In gfxoff state, the dequeue request(by cp register writing) can't 
> make gfxoff exit, actually the cp is powered off and the cp register 
> writing is invalid, doorbell registers writing(regluar way) or 
> directly request smu to disable gfx powergate(by invoking 
> amdgpu_gfx_off_ctrl) can trigger gfxoff exit.
>
> I have also tryed 
> amdgpu_dpm_switch_power_profile(adev,PP_SMC_POWER_PROFILE_COMPUTE,false), 
> but it has no effect.
>
> [10386.162273] amdgpu: cp queue pipe 4 queue 0 preemption failed
> [10671.225065] amdgpu: mmCP_HQD_ACTIVE : 0xffffffff
> [10386.162290] amdgpu: mmCP_HQD_HQ_STATUS0 : 0xffffffff
> [10386.162297] amdgpu: mmCP_STAT : 0xffffffff
> [10386.162303] amdgpu: mmCP_BUSY_STAT : 0xffffffff
> [10386.162308] amdgpu: mmRLC_STAT : 0xffffffff
> [10386.162314] amdgpu: mmGRBM_STATUS : 0xffffffff
> [10386.162320] amdgpu: mmGRBM_STATUS2: 0xffffffff
>
> Thanks again!
> Rico
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Tuesday, January 25, 2022 23:31
> *To:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yin, Tianci (Rico) 
> <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun 
> <Guchun.Chen@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
> I have no objection to the change. It restores the sequence that was
> used before e9669fb78262. But I don't understand why GFX_OFF is causing
> a preemption error during module unload, but not when KFD is in normal
> use. Maybe it's because of the compute power profile that's normally set
> by amdgpu_amdkfd_set_compute_idle before we interact with the HWS.
>
>
> Either way, the patch is
>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
>
> Am 2022-01-25 um 05:48 schrieb Wang, Yang(Kevin):
> >
> > [AMD Official Use Only]
> >
> >
> > [AMD Official Use Only]
> >
> >
> > the issue is introduced in following patch, so add following
> > information is better.
> > /fixes: (e9669fb78262) drm/amdgpu: Add early fini callback/
> > /
> > /
> > Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> > /
> > /
> > Best Regards,
> > Kevin
> >
> > ------------------------------------------------------------------------
> > *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > Tianci Yin <tianci.yin@amd.com>
> > *Sent:* Tuesday, January 25, 2022 6:03 PM
> > *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Yin, Tianci
> > (Rico) <Tianci.Yin@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> > *Subject:* [PATCH] drm/amdgpu: Fix an error message in rmmod
> > From: "Tianci.Yin" <tianci.yin@amd.com>
> >
> > [why]
> > In rmmod procedure, kfd sends cp a dequeue request, but the
> > request does not get response, then an error message "cp
> > queue pipe 4 queue 0 preemption failed" printed.
> >
> > [how]
> > Performing kfd suspending after disabling gfxoff can fix it.
> >
> > Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930
> > Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index b75d67f644e5..77e9837ba342 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_early(struct
> > amdgpu_device *adev)
> >                  }
> >          }
> >
> > -       amdgpu_amdkfd_suspend(adev, false);
> > -
> >          amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> >          amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> >
> > +       amdgpu_amdkfd_suspend(adev, false);
> > +
> >          /* Workaroud for ASICs need to disable SMC first */
> >          amdgpu_device_smu_fini_early(adev);
> >
> > --
> > 2.25.1
> >
