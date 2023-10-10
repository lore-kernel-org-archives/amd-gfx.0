Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F042ECD68E5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 09:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EAF010E32F;
	Tue, 10 Oct 2023 09:07:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C965510E32F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 09:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1+D1DnkdONdFmwNU+kUzT71CbXJrf/av0p5iB2Xmtfz1jm1Bat86wpmmozNE+imKcrnUeel651YfjdHIIu7oujeaLVao4FVvmeKfsQAZQJXZg12W71mHF1HRYKy7jgx/PyH7vUJEsUS6f789xnMZbInUzZ9oKV6luFvSlnTsAUn4lVZ4hr0IP95+ySEnhxSsP+sgR5igtt2Z6wQpUznoGny/PALyNXoO6vXUyayDHaiHW3RHflHqBv2THqkU+z60RWR2IJfen3yfLC8FSpeOfzO64VvBSyWUAvpYqS5xPQ+fZJXIXV3Evqad57mqdwIAmkka2JZ4LZ9OrBNMAi0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a25Z6/ckDj+9PL5Ccn5FbGhjC1ojVRLdibPSKVmWfg=;
 b=OC8Pk2WL1zVBAbg8Ck0yR8tBd1G0QEv3sEbqi+OXTqNuGqbdWoNg7pogBbzSDRUQ89aheD3QkUTUMxM5yqsU2WCA4eKAulcUlRCG3rUntQPA3h+0s9T8ubm+hQNpfTQryhBgi9fFU5fUz3u+R8bILupLYkuhvZBRtGXcdOXxrfCwcNUrMxOyC0d6ZrC5Q8wKmCQkGP5L0C0SDljiNjETWnAEMGt2JOq3ZA1xRtcl0Y7FzIcRYpHjLAJxRuWpW6x8vWnI1jtxOUXgqypRViG4gIflR3X6RBJJ4NNk6j8aK0B+l/Nnp/UZcTvYsqhkk0r4Z8QnMWPnWHJv+REzUkDjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a25Z6/ckDj+9PL5Ccn5FbGhjC1ojVRLdibPSKVmWfg=;
 b=sI2w77GDqaHzjdLLryI6JTN12pjTX4dQz+6bQyRtBbMC4xkTuY40GxJla44Jq1CQmxv1ZnN0L/brm3dbqiqf7MVuuidwnc1vyD3VaTuW5CKCSGOt0d1DsKYSXrrCz2hOYuFPbZSqxMcagEICtEYeKvOm0jfUfKC7qs/ARoNMOts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 09:07:05 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::548e:3646:9594:2b3b]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::548e:3646:9594:2b3b%4]) with mapi id 15.20.6863.041; Tue, 10 Oct 2023
 09:07:05 +0000
Message-ID: <1378e5b0-08a2-482a-a1f5-0d7673ca156c@amd.com>
Date: Tue, 10 Oct 2023 11:06:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Content-Language: en-US
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231008100642.1915677-1-Feifei.Xu@amd.com>
 <PH7PR12MB59972CEAF0241F48E6B342CE82CFA@PH7PR12MB5997.namprd12.prod.outlook.com>
 <CH2PR12MB4152A458EC29B83672A600FCFECEA@CH2PR12MB4152.namprd12.prod.outlook.com>
 <BN9PR12MB5257442EEE0BB34C24F1A8F9FCCEA@BN9PR12MB5257.namprd12.prod.outlook.com>
 <CH2PR12MB415201DE77642C298438B4ABFECDA@CH2PR12MB4152.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CH2PR12MB415201DE77642C298438B4ABFECDA@CH2PR12MB4152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 67862eb5-2459-431e-8560-08dbc97045b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uE+IT4otkrpj8n3fUaFHZdHYXVBI5I4E5D8Elo458NR4YraXh15sHw5bQ8WuNbhia9dLtjERg5ziUMBOWHR1z37gAsThW0Z+tuG2ji8t2+D22GpWbYMhJVXmQ6lYFEQ1c3lapMDPtQPcLC+4rM5pwGqANu6OaGmF4qCGw+l7+YN4zdRaM961wjeXb/OH5Wga7ncT/9cNFOGAVJhMtAlEKd6J/mv/U4zHDD6cClsTo9ChtXmLt5Dmtd3+soKvBob7qzdlZHr+KXuteXt5m5TOGDrBH87K6jRq9gV5mPddExtdbmn2+9t8VBN9+zXSDGwL3yxF9oHSZ9vXR9+lyVdEujdmNg0IZmJ1k3k14pyS7rJhJ573sxtbuRmmHOGPsqL6dEIxb21xPTnyK81E5t4oIYqNwC6XTW+gZzb4jFYfU1wfAej0LE2Ubi/jNy5eSNz3WJ7SMwgH5Ql050KFhuL+QiPopDunLKamcfXgRCbxVLL6DNVlDdqrwTm8nuis45FZqE+ry4TSsWy/HIzQVX83Z6Ei/pascvqfCjvzqB4mC1mdDQmymQ02nPij2VJyykiyWFURksa+3H/cACMXTHrb/BQinLclx1PEvKfmMUdBwJxd3bDwoxA5W2xurVMPPft6P8iYETwUUu0TZ3ruNqfxVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31696002)(86362001)(38100700002)(36756003)(31686004)(6512007)(478600001)(6486002)(8936002)(53546011)(8676002)(41300700001)(2906002)(6506007)(5660300002)(6666004)(2616005)(83380400001)(316002)(66946007)(66476007)(66556008)(110136005)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm1UUzFTUlhXWlRPbHFLTENPeTZmSFZFY0FjTitGNWtwWlRnbUVJSFMyTEFt?=
 =?utf-8?B?aFJNaFR1dWVaMmRkaFV1ZUIvcXB4cEczWnVwZjRNVWdIajN3OEVPNGpzT3BJ?=
 =?utf-8?B?Q1NPUGhYL0UvbUpKeFRHRU5VMDJmRnoybkp1NTd3WjI3dElzellac0psRE9n?=
 =?utf-8?B?ZmVycnp4dTFLeTZNcTI2RE9MQWl2cldEa2lqL05rT3BvMFB1K09mSlNGQWI3?=
 =?utf-8?B?WkluUTBMSW9BQm5ZZHNCWW9LcVpoY0ZsQlp0KzRrMUhrc2tDbjlFUm9sbWdt?=
 =?utf-8?B?cjRrSTNuVnp0cm1EMFFNdmFSQ2Z4dHB0VlQrOVArcmhKa1dHNFFvTnNrNTlT?=
 =?utf-8?B?MmpZZElVY3Vtc0tKa1hVQ0Z2VjNBRzB0R2l6TjhPZEdWbERLSXJxNG5ZYXl0?=
 =?utf-8?B?NzB0K2dxeVpzNUFFUk9TMFc1eDl4S0toWXB2NXByOHcxelE4RUN5cHExaHJB?=
 =?utf-8?B?TE9YKzREOTBFaGFMcmZsbG43SDg2VXZKejNNN2R3cENoUmxlS0Q4QVgvZWo2?=
 =?utf-8?B?NDY1OHBGVGNYWWJGaDVBSGZkSzduaEtZYXpvQnZsRVNGOWFCQWxPNTRJQ1R2?=
 =?utf-8?B?Tkt4M1lwcHg1U0VlWlJ0S1VDZWlyeHRxQ0hUYkJYVTVBbS9JQlJxQjAwK3A2?=
 =?utf-8?B?eE9kSGZpWk9VeDA5b2hXdnJoMmNmVUc4ZjZWYnIwVTkzT2l6VElZZUlXZk44?=
 =?utf-8?B?dzBsNEZnVDhPOTExT3doVVFCWHFST3lkMmh3RDFML1RIeU1uYy9WamVMNGNn?=
 =?utf-8?B?eS9SMWdXYWExVmYwa2tDaVhIL3ljaHM2YTZoRG56b2pTWVJub3kyZmExYkJG?=
 =?utf-8?B?RmlUaFdnNjNadXJCajZMRU1IZGJxTm5aNVJrNXMzaVQydG0xNUxHVW5kVXVq?=
 =?utf-8?B?VFd3NkRhZ2c3UTRybEszYzI4ckMwWDF4YzBpSXFpZElUblpRVzB5d3MrZDZu?=
 =?utf-8?B?VHd5R1pYbzg0cm11bHlvZVBNckNuM1JDWFE5ZGpOS2k5TWViaXNUeHBjQmdy?=
 =?utf-8?B?ZFRHL0QrMkxFY1l4Qnl2VlhrV1J1dHg0cjNSYjQ1OHlGVHFOY1p0MHQ0WHJG?=
 =?utf-8?B?L3BCM3M2NkpNNmJWek1YQUN5V2gzbDYrVlRRSEVLLzhiWUZHcWZuQ3YrQkha?=
 =?utf-8?B?ZW56YURFVDhqczFUeE5BQmxPUldrYnpIZ1YvYnhaVUt4VnlxMjBiNHA1alRB?=
 =?utf-8?B?emhJK0M1L0RDWHBiVzdCUlU3bi8wMTZOa29XRHV2NU5NTFVDYis1ZEt3RDhC?=
 =?utf-8?B?UWpPUGJtSCtGMVRWNWN6QXM3eklKa05kSmdjY3FFaTFCeGFkWUhCQng3TjJ2?=
 =?utf-8?B?ZzBSRi8zODBwTnRha0pKNkVrSVhkMXgzZmJRanVvRHhhY1c1YThvZnNHOUhD?=
 =?utf-8?B?YUJCRDZDdVNaTkJPNDF2TDMyT1VTd0w5TkNLRnRvY0FoZjBSMEFSQmZIWE9D?=
 =?utf-8?B?RkFZU3FaamtSRURnYjNkYU9iM2NpYjBEVzBka1haQmt6bnZDLzh3YjBoR2pH?=
 =?utf-8?B?TnNIN0pFSHNMaXZPbGFVZldOYXFyOEFsUktjekdxRHNrcWNwd1JtVytXNWRp?=
 =?utf-8?B?Z1ZpYnUybmp2dTFyc2pBbGV2TG1vUytSK2E5RGRwci8vNkdrZ1dwUEZESTRL?=
 =?utf-8?B?dzBPbUZCTXdSNXdrUllzZUMvajVkbGFPL1V4QjROaGFBRzNDVGZYNHpJMnBD?=
 =?utf-8?B?MDVWbnljbmdJekZEbDJLM3VBQzk0a0ZZejBCNFhyVHRhVEVldGs1TXkxcEUz?=
 =?utf-8?B?OE1ENldNLysyenFxV3dUMHF3cVltZmVZUlNodzk5QlZwN2x3UEhVK0RyeWtQ?=
 =?utf-8?B?NHVweGhCUy9iTHo1dUhlOTQ0dGpyUloyNVhlMStsUWFsYUY0ZU83TXIvRUpv?=
 =?utf-8?B?Y25PdSs1YlFWL0tMamc3Q0JpcnU1bWU3K3JQZzEvTDNyQ3Q0cU94cFltTWxr?=
 =?utf-8?B?bnlSWUtwUzJIYlZqWWJMR0hwMnoyT3ZXYW5EMDFqa0lSUXhWalRnQ2t5NUMx?=
 =?utf-8?B?bG1ERFJ5QXp3eWVwbXIvaHZRWjQrS3R3Q1pmMkJzQXJGOE0xMTM2S1Zad0Ju?=
 =?utf-8?B?NG5CN2NFVFNaZFVjNmxLQlFCbVdxQXhCbXVMeENwQkZrMHhTMGRRUWtpdDZF?=
 =?utf-8?Q?vjVE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67862eb5-2459-431e-8560-08dbc97045b4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:07:04.8989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGoLi3C7wiKzrJqGqCXX8YH9gK+oPhbVP5fqedHss9v69uW9UbRuxjNnNnq1pxbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
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

Hi Feifei,

yeah, that is correct behavior. The GMC callback should *not* get called 
during resume in a reset, because the reset needs to take care of 
invalidating the TLB anyway.

If the later doesn't work any more we need to re-iterate the reset 
procedure and not mess with this here.

Regards,
Christian.

Am 10.10.23 um 04:27 schrieb Xu, Feifei:
> [AMD Official Use Only - General]
>
> Yes, adev->gfx.is_poweron check will be applied in gmc_v11 callback, which will be called after the generic gmc part: amdgpu_gmc_flush_gpu_tlb() function.
> But in commit: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tlb v2"), the flush is moved at a higher level amdgpu_gmc_flush_gpu_tlb() function.
>
> Thus the gmc_v11 callback will never be called in the resume because adev->reset_domain->sem not released and returned ahead. Adding a check of adev->gfx.is_poweron will let GFX11 not breaking ahead, like following:
>
> if (!down_read_trylock(&adev->reset_domain->sem) && //--> true in gfx11
> +!adev->gfx.is_poweron)         //-->false in gfx11, and the whole if statement will be false, not return ahead. The following gmc v11 callback will be executed later.
>
> Thanks,
> Feifei
>
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, October 9, 2023 4:58 PM
> To: Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>
> Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
>
> [AMD Official Use Only - General]
>
> adev->gfx.is_poweron check should already be applied in IP specific (gmc v11) callback. If gfx is not power on, it does nothing but just returns. I didn't see how it helps resolve the issue if we just move the check from one function to another.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Xu, Feifei <Feifei.Xu@amd.com>
> Sent: Monday, October 9, 2023 09:51
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
>
> [AMD Official Use Only - General]
>
> Hi,
>
>>> Based on your description, the above code should use "||" instead of
>>> "&&",
> && is to add more restriction here.  To avoid skipping necessary TLB flush by return.
> For Asics < GFX11, !adev->gfx.is_poweron is always true (this paremeter is intrudoced from GFX11), only depends on reset_domain->sem; For Asics = GFX11, !adev->gfx.is_poweron might be false (which gfx might already poweron in the reset), this will make the if () not ture, return will not be executed, thus flush TLB.
>
>>> And after merging code into one line may result in the lock not being released if the lock can be acquired success.
> If !adev->gfx.is_poweron is true, the reset_domin->sem will not be down_read_trylock, thus could avoid this deadlock.
>
> Thanks,
> Feifei
>
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Sunday, October 8, 2023 9:36 PM
> To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei Xu
> Sent: Sunday, October 8, 2023 6:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
>
> To fix the gpu recovery failed on GFX11 with gfxhub pagefault, flush gpu tlb after reset on GFX11.
> Gfxhub tlb flush need check if adev->gfx.is_poweron set.
>
> Fixes: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tlb v2")
>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 2f9bb86edd71..048d32edee88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -611,8 +611,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>                  /*
>                   * A GPU reset should flush all TLBs anyway, so no need to do
>                   * this while one is ongoing.
> +                * For GFX11, gfxhub flush check if adev->gfx.is_poweron is set.
>                   */
> -               if (!down_read_trylock(&adev->reset_domain->sem))
> +               if (!down_read_trylock(&adev->reset_domain->sem) &&
> +!adev->gfx.is_poweron)
>                          return;
>
> [Kevin]:
> Based on your description, the above code should use "||" instead of "&&", And after merging code into one line may result in the lock not being released if the lock can be acquired success.
>
> Best Regards,
> Kevin
>
>                  if (adev->gmc.flush_tlb_needs_extra_type_2)
> --
> 2.34.1
>
>
>

