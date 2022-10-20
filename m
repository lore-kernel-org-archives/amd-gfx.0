Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96613C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 14:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C393410E145;
	Thu, 20 Oct 2022 14:59:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E79E10E145
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 14:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DULpKKbyGcKTnj2UDbDDlv0KkyLYQfGeFMxgzdNKLhp3qiK609KhvsKdE/vxZYNLrx3qp5hlrBo1WG4YzsPRbiqJlS1baNsm1u7nelKn6QremHrEWEg01DaPZiN96xrHjMg4FGMpi78ITQ8qUlPP6y9lHScM0wCBo/im8dA7XDM/92c+nRdCbjgAoSJRpL2hiYHb92+nKYF7WXZCYmn/pzM7wDMTQgpG+FB4OOQap/DyZNnCXC/rfc1sXaxP1NreTyIb5OtM50EY6PMqGO7K9sXNsHxNTtDm/t1aeB8jQN74kB9jRZ5nJP+tu20HjIykBFjW1N/lk5/RLHt7FF9w3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCwyOhebHQPKV4CYVCxoDGPCsFWlqB2ixz9uzxCZIj0=;
 b=LGkT1sHH0jMapeSPHa4u6sIBIepvdAQBnJSy8fV3tDakTxpjf1UZV62top2l+2AkDVRoa3hYVRtyuXCMAesD2FMbYYkz6KOF/UN5aciIR1zrZAjmNbXUvM3JY/2aHZrD+PufauT+u6SzZCWd9Juppa9srPP9qeOqco2t9ZcI2AfqtRNuo4+k6bznXzDSwifVrGhcgD/gL2nu4dfDhN1jAAa8h6QuACK02ZNAzwEPoctYsF597/ljG5lPjmE7KYjQZaUj8KuDaNQpg0a3gpLWPaCq3ag5oZiwDxlCnOtvfNU3GXFYBXgz7HB717iQb3tY55q6Nh/RF4D286q0348YLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCwyOhebHQPKV4CYVCxoDGPCsFWlqB2ixz9uzxCZIj0=;
 b=KmV2id7GkGzMxxVhirgdRyifylA9lvv05ZijjD0jJQv5CI7A4WIlLBN0KWQXbIyraKAQ/moGwmfYJxYywbGXUxsso0OpGXbXAG3nNeAyPqNo5oZE1B1/Nlk1mXLk+SDCN/RR140ktwKuCASzowZiFtMyw5VOqDkiWh6ftZ0oxII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 14:59:09 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e6a5:94b4:d855:14b3]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e6a5:94b4:d855:14b3%7]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 14:59:09 +0000
Message-ID: <a4e05017-ac7d-9872-dfad-257be85d1572@amd.com>
Date: Thu, 20 Oct 2022 16:59:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] drm/amdgpu: Introduce gfx software ring (v8)
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, jiadong.zhu@amd.com, 
 amd-gfx@lists.freedesktop.org
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <4046cec7-88a1-d91d-9553-678d5165d308@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <4046cec7-88a1-d91d-9553-678d5165d308@daenzer.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0161.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::11) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: fbed32d8-5114-4776-1a5a-08dab2aba45c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcy2HPeV9CoFgiq5AKfaUVc5zb0ds1lqOPSqR4UcokA4chu3iZS1hkDTy7ZkG5itgXmMFei8eIWcoRnv56kgP8KMlUcLofjkX2NKYSATbmrZiKBa8IZK9qT78i1bOXHvBGpzm/ypctgzLU7u0cKpv7NrV+PvMz9eLD9+hL9LxZGdfGiCbGnvVnrxIRgSUxbphlTTs0FjH00x5y75lAI4R79amb+vJHVHorPLkAMwkMj28RPnN1pWOrAjEzlAaxyjOegaNNjEdzORza5WAoFYJ99tNtUhQlwUbLZUz0GsWPSMOIKUIICwMob6gcIGB1P4KEG2sDGBWF2Y8eNfAREd4HhMBr8/8o5SM4GkdYcoVyff3eCJai+0+3xgZu+5UfO5Xn81GX9xMQTfOhq6yih4k0ZDP3MYVwuPcOGrlebjngHHeIipj/d9mwPDHcNs1FPyh2h2Kzw5KJ1zEdnhqRQUvPic+G+JeilGgQYC0fahZi6E5e3m+YcmVO8svcGAQ4Vvzgh0y/gk4wY9byjE5DNGnMHv7NX7Gty+zaIFz4cfjShrJ2QVt9fxOiJFZsU15mY/fjeouqYZrQDno/WdiJCBTbbIxx0J1pPx7YY0cOLFoL9m1StFxSwM0ZVy8cPLf7rZdI/QnG+9/BaPkKGRGEBqBVq7fI17DAQ8Zg78romO54JhFHx8Qa+urST9z6OE8S4H8tgDbn9rfzURrP3KCRsHGh0cDFrtTuVo2y9u+8zGcP4IVSJBZw7Qw9Cq2vCU8e3+noA1I1epXXMEDjG0m9XkqlMKWyPSJRnRZ+kXqqulD/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(86362001)(31696002)(36756003)(31686004)(38100700002)(4001150100001)(83380400001)(2906002)(66574015)(5660300002)(53546011)(6666004)(2616005)(186003)(6512007)(6506007)(316002)(6486002)(478600001)(66556008)(66946007)(66476007)(4326008)(54906003)(8936002)(8676002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFkyNUNvV3FhSG5PUG5BNjJST0NWajFFTFBjSnNqZTBqYmQyaE8wOHRkK2wv?=
 =?utf-8?B?d1dETWQ3OHl3UFpQREFLZlZmeCtLdW0xVVJGM245YWcvN1RDa0lHdHVWZ0lR?=
 =?utf-8?B?RjEvRUNZL1JBbUl6TkU5aHlkREdLY081V2JobGxsZ0JCNS9CL1lvbWRpMU1D?=
 =?utf-8?B?VTYvWUJQNGNSQ2VMN1lvK0pQRlFnTXlYSUJmNFBWZVhqUys0UFN5RXFVR2M3?=
 =?utf-8?B?N1Y1cEFDTzZrMTVTWFdiejFQU01PZFFoMHdMMWI5QVRyaEc0d3NhblFXVnlo?=
 =?utf-8?B?VUhHUStHRmd1RHVnWXNhNWhUZEFMbXN6TE1HNFVwMG9ISlZYQy9nVyt4MlFZ?=
 =?utf-8?B?Y1liM0lmanFkYTIxd21HYVd6SDZhSDVycXlORUw4em9TbDdCaVQ4QngwUjFI?=
 =?utf-8?B?Y0ZLeTZtVFNxd0dHc0dYR2l6cmxyZ1FOMmZJSEFGWDB1U2ZKenVFZy9BTlpn?=
 =?utf-8?B?Z0JJeGQ0WC9MaTcrWGJNS2dJY3ZpbzJLK2hwK3hvdkJnT0ZncWhBYWNqdE4v?=
 =?utf-8?B?aGhPTnd3aTNrQjcyazVaMk5CdUZOUERjeGVrRnlwbmVUTG16V3lqbm9reVVL?=
 =?utf-8?B?dWZVelhhck5UazE3MFlkQVpCcHpPMkNFQ1Z0bEVMV2xqZHBRQzY4R0M3YWFo?=
 =?utf-8?B?NGRVaHVGKzR6ZDVwRVE5MWdoekkyYUpMeDhHSHgzQmRNWkEwTHlKR0h1TlNU?=
 =?utf-8?B?OU56VGwxdTZhOGRvN0ZFSXdCanJ1RlZvaTZvY3V1QTJNZWp3b21mS0daeGNP?=
 =?utf-8?B?MEhidWlFQzhpMHFLZTRxREZjTXVLNHVCN2N0b296Uk1jRnhmeUxjWWRCRzJC?=
 =?utf-8?B?VWcrTUd6OUdUOUFrQm9VMmp4b3ptSGd6ZVZBS0ZHZS8zYkVBbi9iOW5PRVNO?=
 =?utf-8?B?WTFVZ2VnczY2RGtqa0dESkNjN290SzdJZC9oZ1Y0MnR5dklTYmRlbW5yZGFO?=
 =?utf-8?B?NmdIU0RwZEpHR2pucjUyVUZ6UW5zZHBuODB6bzR2UjlSR2VJTm5Od3k1Y3pZ?=
 =?utf-8?B?OUNTQUdOblZYMkZqb0NOMmxheTY2c1ZGb1Q2Q3hCclROTHdmaWxnWFY5RjlE?=
 =?utf-8?B?MEg1bkxOOTdyellIb1UxdjBEbU4xWFU4TE1lQ0lHUXBJR3JIcFlLd3RDZldZ?=
 =?utf-8?B?aUtqOEMwVEhVWTBaWVN6V3pLb2VXYWRSZG51YjQ5NnhQVkp2U3kwZWJPanBG?=
 =?utf-8?B?QW5zYjlxMzhVaytWbVJubjlqQlk5YmFPeGtxd1VBc0doRWhsbWUxL1ozTnpp?=
 =?utf-8?B?cFR2RVI3ajUvbFBHVWUvS3pjamdhd1lLNG81Z2JmTHlXMHJ1bUJQaWgxMHcv?=
 =?utf-8?B?TCtYTkhaNER6eTE2bzZ6TGh2cjdHQ0F5akpTdVlheDFTZFlVT3NPRWk1cWVo?=
 =?utf-8?B?V0ZsMjlnMUFRRTFUSFFJM3FONTlBRVhjOWgzWk1kaHVrdDJ4NDZSSnUwc1Bq?=
 =?utf-8?B?QmMxUmxkNlMwRGpwTFNINVdoKzZnZUVYYTdzRFMwR1BVcEdZeXhHUUl2cld2?=
 =?utf-8?B?TW1SS243MFdROUZXc3MvUmpNdFlrUnF5bnlha3lDN3FCME5FcjRxTERlTEVu?=
 =?utf-8?B?RXNCdVNDMFpBS2tjUjFSdnhQYU1WUUdsK0w1VzJaY1UydEtyVnJ4SkZ3NGRI?=
 =?utf-8?B?UXRUclluM2hZWWZ5UkxncVhBd1U0RWtoTWJ5YmkvSDQwdDZJbm9KeXNOUkE3?=
 =?utf-8?B?MzF1REpSamJwOCtBdHRqVVkvT2tScXJ1aUtIYnVYN3JPV1RCQS9zdURQRUpp?=
 =?utf-8?B?UTdNZDJXcE12dW5TRUJFSkFzQkpoUWErNjJmaFlXRG1ZbTJZQzUzak1NQVNx?=
 =?utf-8?B?VUpSb3hmYkhTYXQvejh6VklqUzVqcXdjZmVCN1Awa1FKUVhsR2hQaEEyVGNs?=
 =?utf-8?B?ZTUwUEo2anpHZEJqc0FFNHY3L25UQnlFS1YrSW1lN3ArVHIyTjBjZEo5M0ty?=
 =?utf-8?B?YmVnZW9ZbjZGb09QeHlvUGxvM3c2RG5rSUlPbEdTVlU5cXZybmZYdDBNS3dO?=
 =?utf-8?B?SU5vanVBNlFUYkRaNUFyU2pmK1dYM0RFbmEzYVBLUitMNkZxenphdnhkbzdZ?=
 =?utf-8?B?UlU2MzhObno5UTVXNXVBSDF6elZlTFl3VEFzOU5XZ2oreWd4RG54YWNJY0da?=
 =?utf-8?B?eU83RjUwaVhsNFpmUkxiZDAyV3JORmFCVlNPYm9FQkRXUHNLMkIwVjhVSktW?=
 =?utf-8?Q?5GnsTmQko/5MHO3VCWN48wnIA2d0vHiiBE+X3v+bAjaO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbed32d8-5114-4776-1a5a-08dab2aba45c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 14:59:09.5653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMEk8P8DWMVDfyLDbAWuShmi4itm4shDksz44Ff60KkX/vVKifRugmO0158tJwg5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Huang Rui <ray.huang@amd.com>, Luben Tuikov <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.10.22 um 16:49 schrieb Michel Dänzer:
> On 2022-10-18 11:08, jiadong.zhu@amd.com wrote:
>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>
>> The software ring is created to support priority context while there is only
>> one hardware queue for gfx.
>>
>> Every software ring has its fence driver and could be used as an ordinary ring
>> for the GPU scheduler.
>> Multiple software rings are bound to a real ring with the ring muxer. The
>> packages committed on the software ring are copied to the real ring.
>>
>> v2: Use array to store software ring entry.
>> v3: Remove unnecessary prints.
>> v4: Remove amdgpu_ring_sw_init/fini functions,
>> using gtt for sw ring buffer for later dma copy
>> optimization.
>> v5: Allocate ring entry dynamically in the muxer.
>> v6: Update comments for the ring muxer.
>> v7: Modify for function naming.
>> v8: Combine software ring functions into amdgpu_ring_mux.c
> I tested patches 1-4 of this series (since Christian clearly nacked patch 5). I hit the oops below.

As long as you don't try to reset the GPU you can also test patch 5. 
It's just that we can't upstream the stuff like this or that would break 
immediately.

Regards,
Christian.

>
> amdgpu_sw_ring_ib_begin+0x70/0x80 is in amdgpu_mcbp_trigger_preempt according to scripts/faddr2line, specifically line 376:
>
> 	spin_unlock(&mux->lock);
>
> though I'm not sure why that would crash.
>
>
> Are you not able to reproduce this with a GNOME Wayland session?
>
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0010) - not-present page
> PGD 0 P4D 0
> Oops: 0010 [#1] PREEMPT SMP NOPTI
> CPU: 7 PID: 281 Comm: gfx_high Tainted: G            E      6.0.2+ #1
> Hardware name: LENOVO 20NF0000GE/20NF0000GE, BIOS R11ET36W (1.16 ) 03/30/2020
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> RSP: 0018:ffffbd594073bdc8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff993c4a620000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff993c4a62a350
> RBP: ffff993c4a62d530 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000114
> R13: ffff993c4a620000 R14: 0000000000000000 R15: ffff993c4a62d128
> FS:  0000000000000000(0000) GS:ffff993ef0bc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 00000001959fc000 CR4: 00000000003506e0
> Call Trace:
>   <TASK>
>   amdgpu_sw_ring_ib_begin+0x70/0x80 [amdgpu]
>   amdgpu_ib_schedule+0x15f/0x5d0 [amdgpu]
>   amdgpu_job_run+0x102/0x1c0 [amdgpu]
>   drm_sched_main+0x19a/0x440 [gpu_sched]
>   ? dequeue_task_stop+0x70/0x70
>   ? drm_sched_resubmit_jobs+0x10/0x10 [gpu_sched]
>   kthread+0xe9/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x22/0x30
>   </TASK>
> [...]
> note: gfx_high[281] exited with preempt_count 1
> [...]
> [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx_low timeout, signaled seq=14864, emitted seq=14865
> [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process firefox.dpkg-di pid 3540 thread firefox:cs0 pid 4666
> amdgpu 0000:05:00.0: amdgpu: GPU reset begin!
>
>

