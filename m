Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A3BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 04:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC33B60F48
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 04:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC33B60F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D56D6E8B1;
	Wed, 15 Sep 2021 04:13:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF556E8B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 04:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUjj3nFMV/IsaVE7CyJb7pUstfL2+uKXkmH9JLiNkxHcH785w05TI4OPlcvDZSAo+GX9R5S9ZWK1QymByreUR26ct91yhR1O94Lzcl9g5I/piGhsKqY3EazNQNICoA+PdIjaEnsU81KEvLjXIZAQzZ9up/YLrXk2C53s2ZyNRvRBE/LCmSFSyi+f8Zs0671eo+1acniruGywIJpuhAmOdkFJejezALjurA2rfvD1skzYrTa9dVkYnOgTvmkiDgA2OkNGoWaybEIwnRMTBVn5zuq6dWZ/Ct0PEq/ZpGLy7f2N8kslQdqNlxGwBGP42kndTG81uExG2cnQ99k7puEwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=oZ/FWapkahfYrAYO8ZZPrPgT5ERV4CpTisPeWHLCBkI=;
 b=RwYMJWJgMp3cQD5neaEmh4HFhzD2BjBdfMmNZJvQkbNco9nBnyh+9DqcXxgYHzyc4o++E1RmsceFSLBJKJ302XkM+sjydxthIW7ZTY1dG0AiJjKKRkrRVhn/K4R+mT0qT7c/8L7yu6r5J8RzX2oYJfQ3uTIHitXgI7UhV3/HDUG7ZnuFYzHs/4l9zvtrBBV2PGp8K0aYRTJPEmyCAgWF3XSuJiw7aNpD20G0IYaJD6mJ1AyjN+29Z1Z4kwe034gQYfimx9tMrwWHm0AwnMHfRe5/RCMH67tPrjfspaXA4VXM9v065QVvj/5mcgDJlfn4RWn2oU2sYbhQpJyBgGAUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ/FWapkahfYrAYO8ZZPrPgT5ERV4CpTisPeWHLCBkI=;
 b=KTCYHzh3NeAIXyUctluCcmxpb4VyDVZmn60W00n+Zkw2LAnZS1/LTXKR3/VKcnbC6seZzJAx7x03+crGTsprr3tTbqSOYRKs3bjIQ43LlsFNBIIK0gzozJvGCsZ4h9eIUacwg+JETc5euhg3sieNAZHA/jZFM7RATm5dX9xK4sc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Wed, 15 Sep
 2021 04:13:36 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d%6]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 04:13:36 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBQdXQgZHJtX2Rl?=
 =?UTF-8?Q?v=5fenter/exit_outside_hot_codepath?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20210915014256.20404-1-xinhui.pan@amd.com>
 <e70ea465-93c1-842c-69b4-88f9d0aa5217@amd.com>
 <DM4PR12MB5165765C26B44904E030B1C587DB9@DM4PR12MB5165.namprd12.prod.outlook.com>
Cc: "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>,
 "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <d631ed4c-e3d5-e960-a243-a5842ab21b88@amd.com>
Date: Wed, 15 Sep 2021 00:13:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB5165765C26B44904E030B1C587DB9@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::26) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:b478:f3df:a528:4eef]
 (2607:fea8:3edf:49b0:b478:f3df:a528:4eef) by
 YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.15 via Frontend Transport; Wed, 15 Sep 2021 04:13:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04a7b059-fd2e-465c-0f3b-08d977ff3076
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44476BEF01AA9844875E9F45EADB9@SA0PR12MB4447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXuB6XBb469Foul829GJssPD67lqkJrmObBU+sSZAvvr5kApbtV4me+QLYOuscVkUUjt8plcT+AxGjlMTcGxnL1eZX4GJ/ujBOPCD8Q8VqG8CX937MtmXsugAzZGS2py5hiotVu7TxRUG8X5HuHkTNs98Q/mH2wsF2vKr/2LLsET2iKsxZh//m+RgBx5maeFo21xj0N2nTXgbEbYEQLDBsUTb8Q21iTL7Uzd98gI0aHKiXBY8Doeqgs0x04O5G/PrSCb2NjcglJbeE+MZA7kQmfFiajTOPH23QYYZCtQPiCOERGIZ6+47e0vdQOBO5QrXkOLEwE6mw3hU4BNtvxqdceKEFIGHWU1Fv2NAxxMcwU38UdBDloCzkbdHgPUSg0Rohhp2COSjA1Kw0Wpyx20E6A4MuBgEf0IgdiP/lQAixORSsZT94XCvZ5MAZXMUYQsKodmQ90LSsrvjQWm03SiSL+MVPVykE6aSxjg3PR28zcnyFmmtVNQQ2m2AXn2cRrlzIOnOWdOwlgeCRbI+jxbL/aKIotTiSrcNg5wZET3cOMQqgI+GFglOdZNVN8zmLXSJV8qjLK/zpIQKNEeX8F0+QFXElLRp1GkC9hGO62MinFjmwfidHS15KLwUXYIZ+8/xvA5k4F1jo1NEXS3cFQvIR5yaDGJWRYtllhvY4ySsuY0/fQsFOPp2ZoBa+kHQ7OMNuns2Q11P1glq8xOJRpbUodA/tUtXrPBiLFbvf/SCMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(5660300002)(66476007)(2616005)(86362001)(53546011)(83380400001)(54906003)(224303003)(478600001)(36756003)(6486002)(38100700002)(110136005)(44832011)(66556008)(4326008)(966005)(8936002)(66946007)(186003)(31686004)(31696002)(2906002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1F5QWZ6U015ZUpmUUdjVFNiNk94OTc0VlZacnJMSno3SDd4a2V5RDZSajJ1?=
 =?utf-8?B?VzlwMVJKa3VabjZCOG1kNHJycVNKaitBMWMvdkI4cEZSWDNGdkhvdS9JbW9h?=
 =?utf-8?B?TUh6TENDYnB2TXhGTHNDWnRKWTdBYWcvNERaaGxaWDk1WEluNEEzUnE4R2ZP?=
 =?utf-8?B?TXJBdjlNdVQ1MlZOSERGWVk2UGhXLytUQUR4VkhnYVRINDN0WGlRaElhSXNn?=
 =?utf-8?B?VnlObllqdTB5V3ZIbkFBTWl6ZUVjQ2tocWY2S0FtdmFkL2dQNEhscUhvZ1ZW?=
 =?utf-8?B?MXNJbzYyenVnZ3JsaWRDcGZ4Uyt6K3ljSkROSXNyTkltaWxZVXF1bFdaYmRD?=
 =?utf-8?B?ZEdKOEEwN2FwUVJRcEJLOEwzVnJCcFBiYlRxbndCUkpsYkJiRiswRDhrVmpQ?=
 =?utf-8?B?NXIvYUMzYThnOHhGS0NERzBVVnlwaXlyamNLZktWZ1Q2cUxneFBkN2owNjVa?=
 =?utf-8?B?RlhBQmx0VkhoWU5mVDMyc3RIT0pwRzFMYUNmMDZReVRrUnVLSEpBcmYwZzBZ?=
 =?utf-8?B?S2dKTzUzb2N1em14NzJDajc1dG9la1lubk5BVXZXU0dheVV4clV1SHJlWktJ?=
 =?utf-8?B?MG5acWlZRDNjclAreEZQZ0h1RUNsNERnYWg3QU5sQVpnbjUrQnl2ZWRSU2JM?=
 =?utf-8?B?UDc2MUlxWUNmblVXalM2dXRyZmJSZ0FqWGc5NVJBVnhEeXkyOXh3RkF5KzNj?=
 =?utf-8?B?RkRNb0NaS1lMWkJDbkxIUzVndzJkVFJDWkhmbDB4R2xaR3p0MElmVi9WUStY?=
 =?utf-8?B?YWQ2Um5scUJLNHQ1UlRmbDRxQmZCdDB6SGlPODhvdVRXazYxNkprZTB3UURq?=
 =?utf-8?B?SUpFRW9yNG9Ld0VYZVdlZ1VFM1VGelJMdzdNbDNFdmxYZnRyUHhmREtFYWl0?=
 =?utf-8?B?aG1MUHprM1JjakJINGttT0k5cHFqbzNyRkNDdkVnWktOeXVZcG9pbTRvajdM?=
 =?utf-8?B?bGZJS0hVSGh2eDdNVFFIa2NFZEFHY0RJdnNaZ2l6T2hzOWh3cDRvVk1xVXpx?=
 =?utf-8?B?TnpkYjJtbVBKNGhFVmF1VjZWMElpeGt3QXc3dnJEMFBXeThIU1NQVHc5WVJF?=
 =?utf-8?B?a2ZCZ1UxKzJxTHNpS3ZyM05acVRjaXFnWmRaWmQ4eTI5bDA2TFVUUytNdGRF?=
 =?utf-8?B?TGhWR1Q0UmtxeGNuVHQvWTd4Y25sYkp1dzk2WkpuWmZmQ1NjS0ZRTEV6YUh1?=
 =?utf-8?B?dTVqRDAyODBETTM3a1FYejZtWjdTRThqdW1YdkVXaTFRSWN1UGpCdjlPZVJt?=
 =?utf-8?B?djFJbUtKMnMzQmtQMW9rd08xaSt2US84RkdvK2xuREtaVWVTam9peXNhUk1J?=
 =?utf-8?B?WjFsdzhuYlZhWlphNUZtWlcxdjVERUd4dldIZ3kva1hMTzkrR3l6alNmbCtJ?=
 =?utf-8?B?anNRY3Z6VVN5SS90NEJSTTVkbW1vcGdXeWJXT3NvWFVoQ1dXRFdlK1ZhTVpG?=
 =?utf-8?B?Ym5DR0JtVUdGZDZRRTRmcStoOUV4YW91bkNaeUIrdmc2Vno5bFF3R2dJOG9s?=
 =?utf-8?B?dnA2WHovN1hkdzg3Ny81eXljU1RkbDgxOHhaOVEwTFlIQm56TWF1V3ZNK1dK?=
 =?utf-8?B?S3ZzRStCR0xLaHZJM1FaV3duY29KTXJORFBUS2JCdEV2WllJZVhwVFRYYnBU?=
 =?utf-8?B?L091MGowcGVLbTNNdUw2ZUQvNk5HdjU2SVFleklRSHR5Z09obUxOb3d4ZnNl?=
 =?utf-8?B?dXFVcXlnaGJDckFLYytLVG1sckpHUWlpT1ZIRU1MUnlrWXpZZHdpRWpjakhN?=
 =?utf-8?B?bHZVU1pNbDZUdnlrTmc1S09zNUlqUHJNbHhNaThMWURoaUJpZ2dkU1h2dDBZ?=
 =?utf-8?B?VlpHaldLaEFWdjhtMGVvM3lSY3A5aDc2NzFEVjhmVldFeGpKY0JSUXltdmRm?=
 =?utf-8?Q?3EI9iYKlIk/df?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a7b059-fd2e-465c-0f3b-08d977ff3076
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 04:13:36.4494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7t+LUmgPUcz2y4aIX+sQYCrDJeFiDXLxWdFgFO2aBm8Mtpa2Pl5s/mOJl0i59vi/7UOY1wDMbfCb7MDp/EAXfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
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

I think you missed 'reply all' so bringing  back to public

On 2021-09-14 11:40 p.m., Pan, Xinhui wrote:
> [AMD Official Use Only]
>
> perf says it is the lock   addl   $0x0,-0x4(%rsp)
> details is below. the contention is huge maybe.


Yes - that makes sense to me too as long as the lock here is some kind 
of busy wait (spinlock)
because for mutex you would sleep and hence not count toward CPU time 
spent here.


>
>         │    void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
>         │    {
>         │    → callq  __fentry__
>         │      push   %rbp
>    0.46 │      mov    %rsp,%rbp
>         │    smp_mb(); /* C */  /* Avoid leaking the critical section. */
>   99.10 │      lock   addl   $0x0,-0x4(%rsp)
>         │    this_cpu_inc(ssp->sda->srcu_unlock_count[idx]);
>    0.01 │      movslq %esi,%rsi
>         │      mov    0xc500(%rdi),%rax
>    0.22 │      incq   %gs:0x10(%rax,%rsi,8)
>         │    }
>         │      pop    %rbp
>    0.21 │    ← retq
>
>
>
> as for soft lockup, kfd ioctl would try lock process_info which is hold by kernel restrore thread and it runs for a long time. maybe some debug logs below helps.
>
> [  637.463063] XH: lock &process_info->lock for 24s
> [  637.463070] CPU: 42 PID: 450 Comm: kworker/42:1 Not tainted 5.13.0+ #5
> [  637.463072] Hardware name: Supermicro SYS-4028GR-TRT2/X10DRG-OT+-CPU, BIOS 2.0c 07/21/2017
> [  637.463074] Workqueue: events amdgpu_amdkfd_restore_userptr_worker [amdgpu]
> [  637.463416] Call Trace:
> [  637.463418]  dump_stack+0x7d/0x9c
> [  637.463422]  mutex_unlock_xh+0x7e/0xb0 [amdgpu]
> [  637.463652]  amdgpu_amdkfd_restore_userptr_worker+0x470/0x790 [amdgpu]
> [  637.463878]  process_one_work+0x236/0x420
> [  637.463882]  worker_thread+0x34/0x400
> [  637.463884]  ? process_one_work+0x420/0x420
> [  637.463887]  kthread+0x126/0x140
> [  637.463890]  ? kthread_park+0x90/0x90
> [  637.463892]  ret_from_fork+0x22/0x30
> [  637.463908]          mutex_lock_xh+0x32/0x60 [amdgpu]
> [  637.464134]          amdgpu_amdkfd_restore_userptr_worker+0xd1/0x790 [amdgpu]
> [  637.464360]          process_one_work+0x236/0x420
> [  637.464362]          worker_thread+0x34/0x400
> [  637.464364]          kthread+0x126/0x140
> [  637.464366]          ret_from_fork+0x22/0x30
> [  637.468717] XH: lock &p->mutex for 24s
> [  637.468722] CPU: 14 PID: 2104 Comm: kfdtest Not tainted 5.13.0+ #5
> [  637.468726] Hardware name: Supermicro SYS-4028GR-TRT2/X10DRG-OT+-CPU, BIOS 2.0c 07/21/2017
> [  637.468728] Call Trace:
> [  637.468730]  dump_stack+0x7d/0x9c
> [  637.468735]  mutex_unlock_xh+0x7e/0xb0 [amdgpu]
> [  637.469251]  kfd_ioctl_map_memory_to_gpu+0x38a/0x5a0 [amdgpu]
> [  637.469780]  kfd_ioctl+0x51f/0x6f0 [amdgpu]
> [  637.470308]  ? kfd_ioctl_unmap_memory_from_gpu+0x520/0x520 [amdgpu]
> [  637.470836]  ? __vm_munmap+0xa0/0x130
> [  637.470842]  __x64_sys_ioctl+0x96/0xd0
> [  637.470849]  ? exit_to_user_mode_prepare+0x32/0x1d0
> [  637.470858]  do_syscall_64+0x3c/0xb0
> [  637.470864]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  637.470869] RIP: 0033:0x7f3e6bac3317
> [  637.470875] Code: b3 66 90 48 8b 05 71 4b 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 4b 2d 00 f7 d8 64 89 01 48
> [  637.470879] RSP: 002b:00007ffcfea0f668 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> [  637.470884] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f3e6bac3317
> [  637.470887] RDX: 00007ffcfea0f6f0 RSI: 00000000c0184b18 RDI: 0000000000000003
> [  637.470889] RBP: 00007ffcfea0f6a0 R08: 0000000000000000 R09: 0000000000000000
> [  637.470892] R10: 000055afe3e7a010 R11: 0000000000000202 R12: 000055afe2e4f3ba
> [  637.470894] R13: 0000000000000000 R14: 0000000000000021 R15: 0000000000000000
> [  637.470919]          mutex_lock_xh+0x32/0x60 [amdgpu]
> [  637.471455]          kfd_ioctl_map_memory_to_gpu+0x1eb/0x5a0 [amdgpu]
> [  637.472006]          kfd_ioctl+0x51f/0x6f0 [amdgpu]
> [  637.472544]          __x64_sys_ioctl+0x96/0xd0
> [  637.472550]          do_syscall_64+0x3c/0xb0
> [  637.472554]          entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>
>
> vm_cpu_update is called by amdgpu_vm_bo_update_mapping which already calls drm_dev_enter/exit.


What about other callers of vm_cpu_update such as amdgpu_vm_update_pde and
amdgpu_vm_clear_bo ?

Also in general - I am not clear what code path that uses 
amdgpu_gmc_set_pte_pde
was the problematic one and this change fixed it ? Is it one of the two 
I mentioned above ?

Andrey


> yes, gmc_init_pdb0 could be called during s3, I will add the enter/exit there too.
> I will do the plug/unplug test to verfiy it.
>
> _______________________________________
> 发件人: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> 发送时间: 2021年9月15日 11:02
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander; Koenig, Christian
> 主题: Re: [PATCH] drm/amdgpu: Put drm_dev_enter/exit outside hot codepath
>
>
> On 2021-09-14 9:42 p.m., xinhui pan wrote:
>> We hit soft hang while doing memory pressure test on one numa system.
>> After a qucik look, this is because kfd invalid/valid userptr memory
>> frequently with process_info lock hold.
>>
>> perf top says below,
>> 75.81%  [kernel]       [k] __srcu_read_unlock
>
> Do you have any idea why most of CPU cycles would be spent in SRCU
> unlock ? It's
> not waiting on anything within this function and does some simple
> arithmetic inside
> as far as I see.
>
>>    6.19%  [amdgpu]       [k] amdgpu_gmc_set_pte_pde
>>    3.56%  [kernel]       [k] __srcu_read_lock
>>    2.20%  [amdgpu]       [k] amdgpu_vm_cpu_update
>>    2.20%  [kernel]       [k] __sg_page_iter_dma_next
>>    2.15%  [drm]          [k] drm_dev_enter
>>    1.70%  [drm]          [k] drm_prime_sg_to_dma_addr_array
>>    1.18%  [kernel]       [k] __sg_alloc_table_from_pages
>>    1.09%  [drm]          [k] drm_dev_exit
>>
>> So move drm_dev_enter/exit outside gmc code, instead let caller do it.
>
> Not clear from explanation here how the soft hang with process_info lock
> being hold
> is related to to SRCU lock of drm_dev_enter/exit.
>
>
>> They are gart_unbind, gart_map, vm_cpu_update(already hold in its
>> caller)
>
> Where in the caller ?
>
>
>> and gmc_init_pdb0(no need)
>
> Why no need ? Those guards protect from accessing MMIO ranges after
> device is hot removed and hence they don't belong to him anymore. The
> function above is also called during device resume from S3 and it's possible
> to hot unplug device during S3 so this might be called with extracted device
>
> Is it possible to run libdrm amdgpu test hot plug test suite on this
> change (before and after)
> to verify if this actually breaks hot unplug ? The suite is committed
> into latest libdrm but disabled
> until latest fixes from amd-staging-drm-next reach upstream drm-next. So
> to enable it this
> code
> https://gitlab.freedesktop.org/mesa/drm/-/blob/main/tests/amdgpu/hotunplug_tests.c#L65
> needs to be commented out.
>
> Andrey
>
>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 11 +++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  7 -------
>>    2 files changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> index 76efd5f8950f..d7e4f4660acf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> @@ -34,6 +34,7 @@
>>    #include <asm/set_memory.h>
>>    #endif
>>    #include "amdgpu.h"
>> +#include <drm/drm_drv.h>
>>
>>    /*
>>     * GART
>> @@ -230,12 +231,16 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>        u64 page_base;
>>        /* Starting from VEGA10, system bit must be 0 to mean invalid. */
>>        uint64_t flags = 0;
>> +     int idx;
>>
>>        if (!adev->gart.ready) {
>>                WARN(1, "trying to unbind memory from uninitialized GART !\n");
>>                return -EINVAL;
>>        }
>>
>> +     if (!drm_dev_enter(&adev->ddev, &idx))
>> +             return 0;
>> +
>>        t = offset / AMDGPU_GPU_PAGE_SIZE;
>>        p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>        for (i = 0; i < pages; i++, p++) {
>> @@ -254,6 +259,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>        for (i = 0; i < adev->num_vmhubs; i++)
>>                amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>>
>> +     drm_dev_exit(idx);
>>        return 0;
>>    }
>>
>> @@ -276,12 +282,16 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>    {
>>        uint64_t page_base;
>>        unsigned i, j, t;
>> +     int idx;
>>
>>        if (!adev->gart.ready) {
>>                WARN(1, "trying to bind memory to uninitialized GART !\n");
>>                return -EINVAL;
>>        }
>>
>> +     if (!drm_dev_enter(&adev->ddev, &idx))
>> +             return 0;
>> +
>>        t = offset / AMDGPU_GPU_PAGE_SIZE;
>>
>>        for (i = 0; i < pages; i++) {
>> @@ -291,6 +301,7 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>                        page_base += AMDGPU_GPU_PAGE_SIZE;
>>                }
>>        }
>> +     drm_dev_exit(idx);
>>        return 0;
>>    }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 54f059501a33..e973488250e8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -31,7 +31,6 @@
>>    #include "amdgpu_ras.h"
>>    #include "amdgpu_xgmi.h"
>>
>> -#include <drm/drm_drv.h>
>>
>>    /**
>>     * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
>> @@ -153,10 +152,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>>    {
>>        void __iomem *ptr = (void *)cpu_pt_addr;
>>        uint64_t value;
>> -     int idx;
>> -
>> -     if (!drm_dev_enter(&adev->ddev, &idx))
>> -             return 0;
>>
>>        /*
>>         * The following is for PTE only. GART does not have PDEs.
>> @@ -165,8 +160,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>>        value |= flags;
>>        writeq(value, ptr + (gpu_page_idx * 8));
>>
>> -     drm_dev_exit(idx);
>> -
>>        return 0;
>>    }
>>
