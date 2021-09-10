Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF75C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 11:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E14611AD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 11:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0E14611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB906E9DF;
	Fri, 10 Sep 2021 11:11:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66EA6E9DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 11:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWHr/vjuG/SAHX/G0iWFiggcP92cfT2CXi+2LE+KLQTGKB3nQ/A6vPpsKfU/KI1Ma1iu3kQr4y+F15oUr2ifA7X8hJ+7eW294Ytx2RqaE34JAF/cuVr+tYJBvZCwh+kdEmfEQQwBwyT1TtZgnD15k5nAYK3O9dGccgyW2YcQQvMa0Io9u5QW2nWRIxgP8eGGwlAzav/YDkVHP0x83Wxr/0L2jRHgz25xLImJPq5w2G4TiEydv+KzGIGXB3ayjZ/MiJDyDDcK5g2xQeb7fSnFBndBB3jkDw/T1+vzI4EyUSWtjTRvvxnsMEOcUkhUK3B7hNQbE+99RUGWq9kdqvFPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=pRI3xLBabIVGFkYKe/Z1OQ3GW7HPhPNtZz6iii7cAlE=;
 b=Ek15kHT27DhmF1CzdZvV0bf3alzkZjsIfcV2plNTPXLN8tTg0CpTXNN3Rn421qL6iSF0E6acjolrsYinZofBKu3Ab8WT8eBrvd11Na9qiuoAULp3OUhOuiRRCmNmv51Eq/SbEmVsil1RYFeY6BUoS8iXV+Sj6/RQ82y3zqQK7R1EYXFPUFRgZmtcsgXUGcgTWqUFsmjJqZ3HtGcteYSqATvBAfqQXd7wHVKj/PMFXC7AbEYxiLKBC3jE3+lawAm7XbV8hrD0AejbTS8xiTExvop8v2L2cgCcC1v4owXgX5aP7z6Gf4c/DESlcaSvgsQd+Cct257HuD1snD8ccQ1ocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRI3xLBabIVGFkYKe/Z1OQ3GW7HPhPNtZz6iii7cAlE=;
 b=3aDPDYLVklyczCuldr8o+Ak/+1Uf8MzjXcVh+KkXujOxbshm6kDh9j/4E2DJD2SsUDp/d9ceDflAL/eCRI2bd1eniRIhUw81PPQXzL9j1w6rgd/n1VgLJ9hW4aKsS0KHskiXnumg224F0630r46nMhqqm1NwQGRkaq21SyYCoow=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3999.namprd12.prod.outlook.com (2603:10b6:208:158::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Fri, 10 Sep
 2021 11:10:57 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 11:10:57 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtQQVRDSCAyLzRdIGRy?=
 =?UTF-8?Q?m/amdgpu=3a_UVD_avoid_memory_allocation_during_IB_test?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210910003828.4013-1-xinhui.pan@amd.com>
 <20210910003828.4013-2-xinhui.pan@amd.com>
 <005bbb06-034d-6cdf-7c61-1d0339b2e54d@amd.com>
 <DM4PR12MB5165533F0F3EB7FE1F14CD6D87D69@DM4PR12MB5165.namprd12.prod.outlook.com>
 <9393c355-0d63-d4f5-1ecb-1ec9fa392a85@amd.com>
 <DM4PR12MB516591BAA84BA6798E40601E87D69@DM4PR12MB5165.namprd12.prod.outlook.com>
 <56bbddc3-2971-4f82-fce4-24cd773a8efc@amd.com>
 <DM4PR12MB5165DD166CF1CA57A579DD7087D69@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7ae47f89-08eb-2ef2-c203-86c265e9ae31@amd.com>
Date: Fri, 10 Sep 2021 13:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB5165DD166CF1CA57A579DD7087D69@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0110.eurprd04.prod.outlook.com
 (2603:10a6:208:55::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR04CA0110.eurprd04.prod.outlook.com (2603:10a6:208:55::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 11:10:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba55865c-600b-4c13-225c-08d9744ba9b5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3999:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3999CD1587D2798DBB6748DE83D69@MN2PR12MB3999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKPV4pniDE1uPPUYVF419DxkpPQypSqkVbKZlz9dfp81DdfrVtOh5XPDjsymTJo9NKSWIw+1czC/zheVn+ZVRIMYKR1F7NmlGmLyas/vHp1hCKITa4RtxeN/Za7KHyicQkYBR3HdFNdRrWDpvGyfaDFdyNJhmjICv4VnVQGAHi9Ox3CUvx5o+SalXWHBf36ZVYjt9yFqJ7vz4SFTcCDLn3SBFWdUk0yj/JTnR1kfAaALQIFwvof9HeEGTEufn16OjyOZX+RGvuUTYZH1KKBgKgHFGZ9KVMjA2QZnaLiXsiJNvhjCzQMHlYO5xoBCacIJA3D3dxb9JobU6HZCG/lrDEsxFBGJQ0vyX7yFcPYdVIltVf9TrIvYvrUtXmVAHAgjIWCd6RUf/JRmCVgmeWWkRnX+WFQ2LXn1ABJ1uI011YdXIJZ46AKu60Uv0ZPkTRcvncqn1nSzTWFLvkiqhzwRcILHVGR8Ru0NXBNjikUPBlGPNyOpllD8Y3T3YxunNM6WCTy+8rmoh9Fp0vCJ7JNimEfzb4YKJofKG/BgcRPqc/Nve/GxL4X+m1BO9yOVsWoXbRq6iUZfiGj4MEyoIUsD5aE70DKZBlbDnPAdVlQAQW7sAJepa8/gqrIbLJ0lnAMyABsPRvWPa3Ew0V07YyOw0wkWLGoTvQvip8pwSzQ+qO16ahNKqosCmG6BuuFC/N3ImSI9UQbrwBUj0Mh8twsXvkMhrfxkKLXbr2AJU15eJQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(956004)(6486002)(30864003)(2906002)(5660300002)(4326008)(2616005)(110136005)(6666004)(31686004)(38100700002)(66946007)(508600001)(316002)(26005)(66476007)(86362001)(31696002)(66556008)(8936002)(83380400001)(36756003)(186003)(224303003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?QUFHZGpQNHo4R0l2Y05qdmhUNUducW9PQmhuMUd4b1AvWjN2RlNrY0R2eHhB?=
 =?gb2312?B?N0h5TjRMV0dUU1ZMN1hHeEcyUjdqeDNhcGFKRDR2UVBFMHBLUVJkU1lKa0FF?=
 =?gb2312?B?VkYxUThZL25INGk5Uyt1QzR2NW9wVzJ1MDJoaEtPTVZZaFdMZU1SRU9mcjFG?=
 =?gb2312?B?czdNbnV0V1EyZ2lhWC9zc3h6NHpYRENtckRSOUdUYXJMSWcwRlRlLzIzVW41?=
 =?gb2312?B?cGs3NEpIMmt1MWFSaVdmV0VRdW1NZXFXYmNVLzJQcGlXOEw5M3JhdG1UMG5I?=
 =?gb2312?B?Mi9GZ05NR0Y4bjUrWC9oNFRlL0laRklTQitMRWJWK0ZGZ2JNaGxITUl2TTJi?=
 =?gb2312?B?akFiZFdOTzlXZndoazZ1UzlXRW5ROUJ2YTY4amNkaHhqOC9xWGdrLzZkV2F1?=
 =?gb2312?B?SzdHZWE0UkE3Rk1qVyt2elJLK2RER1FBVVp6bGt2bXpHZitxVzU5b01jZ29Q?=
 =?gb2312?B?THlZRTBjM3RPN245c0U1WkJBZ2pacnE0SG1sSnI4NzNSMHdreEUzOVp2akFZ?=
 =?gb2312?B?MElYa0svQkphM0ZsL3dnOW5qWEpuSWhicmUrQU9idHhieS81ajd3R1NFeWdS?=
 =?gb2312?B?bWJZL2Nzb1pzUGl3aEpDaHpoZk9VemZIZlVES0dLUWRwQk9BazdsNmViMEhz?=
 =?gb2312?B?dzZ3Sk9qNmxESlRWODZYamF0U0dFWnRNOGR5SWZNaUFpV2pBWUNRaWlIZ2JS?=
 =?gb2312?B?WEs2bDV6dGwvQ1dURThWRnFnTjJKbjJ1c1hkTEFyUnNXeXhQeUJCajNCSWpK?=
 =?gb2312?B?ZWJZdW5iQ25jbnl0dk44OStzeDg5MzlvMUtzV0prZXJ3K1huTy9NU0IrNEFV?=
 =?gb2312?B?QldacmI5VTlONFlzMmlPL1VXc2ttbjFmY1BlUGhsNmUwTSttcWpFNUxZdmxk?=
 =?gb2312?B?MWNaZUo2NTdnYjRnZ0pzN3pwWHdST1hsaWFKbGJwamRsUE1TVnl2N0tyQS82?=
 =?gb2312?B?aGhuTG1CcEFPeHYyYUVMMklLV29rQ3RiQVhWbkRETno4aGh1U0NMWWF6M2s2?=
 =?gb2312?B?VGdodGovSFZ6U3dQck9LajlpMmdDMjhRRFoxMnJSbE9JcDlYM1RDZkV6Nllq?=
 =?gb2312?B?Qkg1aklOVEN1MnVaZXpGNDVRclc3L0sveVBzNkxMaWtMaHEwVkliNkdVVWJh?=
 =?gb2312?B?L1JBUjF1bDdBMUZuSWZBVkFSdVluak9lTEY3R3VOWVVGNExKTHhZTENBdTRx?=
 =?gb2312?B?Q0NoMnZDV0tDcHUvM1U3NTdZYlczV2NFNUthMW1wb2FPdGY2cG55TmQrVkNO?=
 =?gb2312?B?S2JSRGpGUTNwODQxRzZ2NEFaTEZXTjhWQ1VsNVFGMHN0ZmRNSzNPZTh1cEdS?=
 =?gb2312?B?WElEaUYrVEZCWnVWcTB5SFJOZ1RCN2tMbHV5ZWRxdTNNRFJ6cTh6cDE2b3Jy?=
 =?gb2312?B?TzhPODFZNFprZWVZLzV6ZThjQVNjUUFxME1NSkNIaEh1NVp3bDh1T2JiTXNW?=
 =?gb2312?B?UGhBMHR0NVRCWndWdnZXTG8rcGxNWGV3RFI0TmxabzF4MEhUdDNqV0ZEQWpR?=
 =?gb2312?B?dGorUHBsSmVGM1gxUE5kNHl2cFQ4dDBBNnhXbkZ4Tm8yYzVtR2cwRkwrNk9x?=
 =?gb2312?B?ampWWEFIK3ZXNUpOaFBjS05mZzJSeFhCK1dHMlpaNnhzM0NsdXMyZ1lzdEEz?=
 =?gb2312?B?K1lBVFhDUldmZWh4bmtxbEtGamZ3TCtTa1hXc0FDdnVFd09QMFBqQjVkeVJV?=
 =?gb2312?B?U1BUNXZsbFJkL1RuNytyMDk5cXltRDlxTzJCTkM5Ri82R1hwaEVNOVZSb3Ax?=
 =?gb2312?Q?QPK9eyt8MvXQMUUPMS0cAWPowuFDX9yJVj+EYsE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba55865c-600b-4c13-225c-08d9744ba9b5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 11:10:57.2982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7QfT6jeVCX5A9J3v2n5KsymO8QYgj6k9V8TunvANusCJf/9IiKC5adiRV4sZR2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3999
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

Yeah, but that IB test should use the indirect submission through the 
scheduler as well.

Otherwise you have IB test and scheduler writing both to the ring buffer 
at the same time and potentially corrupting it.

Christian.

Am 10.09.21 um 12:10 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> we need take this lock.
> IB test can be triggered through debugfs. Recent days I usually test it by cat gpu recovery and amdgpu_test_ib in debugfs.
>
>
> ________________________________________
> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
> 发送时间: 2021年9月10日 18:02
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander
> 主题: Re: 回复: 回复: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
>
> *sigh* yeah, you are probably right. Wouldn't be to simple if this would
> be easy, doesn't it?
>
> In this case you can also skip taking the reservation lock for the
> pre-allocated BO, since there should absolutely be only one user at a time.
>
> Christian.
>
> Am 10.09.21 um 11:42 schrieb Pan, Xinhui:
>> [AMD Official Use Only]
>>
>> oh, god. uvd free handler submit delayed msg which depends on scheduler with reservation lock hold.
>> This is not allowed as commit c8e42d57859d "drm/amdgpu: implement more ib pools (v2)" says
>> Any jobs which schedule IBs without dependence on gpu scheduler should use DIRECT pool.
>>
>> Looks like we should only use reserved BO for direct IB submission.
>> As for delayed IB submission, we could alloc a new one dynamicly.
>> ________________________________________
>> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
>> 发送时间: 2021年9月10日 16:53
>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>> 抄送: Deucher, Alexander
>> 主题: Re: 回复: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
>>
>> It should not unless we are OOM which should not happen during driver
>> initialization.
>>
>> But there is another problem I'm thinking about: Do we still use UVD IB
>> submissions to forcefully tear down UVD sessions when a process crashes?
>>
>> If yes that stuff could easily deadlock with an IB test executed during
>> GPU reset.
>>
>> Christian.
>>
>> Am 10.09.21 um 10:18 schrieb Pan, Xinhui:
>>> [AMD Official Use Only]
>>>
>>> I am wondering if amdgpu_bo_pin would change BO's placement in the futrue.
>>> For now, the new placement is calculated by new = old ∩ new.
>>>
>>> ________________________________________
>>> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
>>> 发送时间: 2021年9月10日 14:24
>>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>>> 抄送: Deucher, Alexander
>>> 主题: Re: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
>>>
>>> Am 10.09.21 um 02:38 schrieb xinhui pan:
>>>> move BO allocation in sw_init.
>>>>
>>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>> ---
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 75 +++++++++++++++----------
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
>>>>      drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  8 +--
>>>>      drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  8 +--
>>>>      4 files changed, 49 insertions(+), 43 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>>> index d451c359606a..e2eaac941d37 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>>> @@ -141,6 +141,8 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>>          const char *fw_name;
>>>>          const struct common_firmware_header *hdr;
>>>>          unsigned family_id;
>>>> +     struct amdgpu_bo *bo = NULL;
>>>> +     void *addr;
>>>>          int i, j, r;
>>>>
>>>>          INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
>>>> @@ -298,9 +300,34 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>>                  adev->uvd.filp[i] = NULL;
>>>>          }
>>>>
>>>> +     r = amdgpu_bo_create_reserved(adev, 128 << 10, PAGE_SIZE,
>>>> +                     AMDGPU_GEM_DOMAIN_GTT,
>>>> +                     &bo, NULL, &addr);
>>>> +     if (r)
>>>> +             return r;
>>>> +
>>>>          /* from uvd v5.0 HW addressing capacity increased to 64 bits */
>>>> -     if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>>>> +     if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {
>>>>                  adev->uvd.address_64_bit = true;
>>>> +             amdgpu_bo_kunmap(bo);
>>>> +             amdgpu_bo_unpin(bo);
>>>> +             r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
>>>> +                             0, 256 << 20);
>>> Please keep using amdgpu_uvd_force_into_uvd_segment() and validate here,
>>> cause I want to remove amdgpu_bo_pin_restricted() sooner or later.
>>>
>>>> +             if (r) {
>>>> +                     amdgpu_bo_unreserve(bo);
>>>> +                     amdgpu_bo_unref(&bo);
>>>> +                     return r;
>>>> +             }
>>>> +             r = amdgpu_bo_kmap(bo, &addr);
>>>> +             if (r) {
>>>> +                     amdgpu_bo_unpin(bo);
>>>> +                     amdgpu_bo_unreserve(bo);
>>>> +                     amdgpu_bo_unref(&bo);
>>>> +                     return r;
>>>> +             }
>>>> +     }
>>>> +     adev->uvd.ib_bo = bo;
>>>> +     amdgpu_bo_unreserve(bo);
>>>>
>>>>          switch (adev->asic_type) {
>>>>          case CHIP_TONGA:
>>>> @@ -342,6 +369,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>>>>                  for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
>>>>                          amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
>>>>          }
>>>> +     amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, NULL);
>>>>          release_firmware(adev->uvd.fw);
>>>>
>>>>          return 0;
>>>> @@ -1080,23 +1108,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>>          unsigned offset_idx = 0;
>>>>          unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>>>>
>>>> -     amdgpu_bo_kunmap(bo);
>>>> -     amdgpu_bo_unpin(bo);
>>>> -
>>>> -     if (!ring->adev->uvd.address_64_bit) {
>>>> -             struct ttm_operation_ctx ctx = { true, false };
>>>> -
>>>> -             amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>>> -             amdgpu_uvd_force_into_uvd_segment(bo);
>>>> -             r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>> -             if (r)
>>>> -                     goto err;
>>>> -     }
>>>> -
>>>>          r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>>>>                                       AMDGPU_IB_POOL_DELAYED, &job);
>>>>          if (r)
>>>> -             goto err;
>>>> +             return r;
>>>>
>>>>          if (adev->asic_type >= CHIP_VEGA10) {
>>>>                  offset_idx = 1 + ring->me;
>>>> @@ -1148,8 +1163,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>>          }
>>>>
>>>>          amdgpu_bo_fence(bo, f, false);
>>>> -     amdgpu_bo_unreserve(bo);
>>>> -     amdgpu_bo_unref(&bo);
>>>>
>>>>          if (fence)
>>>>                  *fence = dma_fence_get(f);
>>>> @@ -1159,10 +1172,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>>
>>>>      err_free:
>>>>          amdgpu_job_free(job);
>>>> -
>>>> -err:
>>>> -     amdgpu_bo_unreserve(bo);
>>>> -     amdgpu_bo_unref(&bo);
>>>>          return r;
>>>>      }
>>>>
>>>> @@ -1173,16 +1182,15 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>>                                struct dma_fence **fence)
>>>>      {
>>>>          struct amdgpu_device *adev = ring->adev;
>>>> -     struct amdgpu_bo *bo = NULL;
>>>> +     struct amdgpu_bo *bo = adev->uvd.ib_bo;
>>>>          uint32_t *msg;
>>>>          int r, i;
>>>>
>>>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>>>> -                                   AMDGPU_GEM_DOMAIN_GTT,
>>>> -                                   &bo, NULL, (void **)&msg);
>>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>>>          if (r)
>>>>                  return r;
>>>>
>>>> +     msg = amdgpu_bo_kptr(bo);
>>>>          /* stitch together an UVD create msg */
>>>>          msg[0] = cpu_to_le32(0x00000de4);
>>>>          msg[1] = cpu_to_le32(0x00000000);
>>>> @@ -1198,23 +1206,25 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>>          for (i = 11; i < 1024; ++i)
>>>>                  msg[i] = cpu_to_le32(0x0);
>>>>
>>>> -     return amdgpu_uvd_send_msg(ring, bo, true, fence);
>>>> +     r = amdgpu_uvd_send_msg(ring, bo, true, fence);
>>>> +
>>>> +     amdgpu_bo_unreserve(bo);
>>>> +     return r;
>>>>      }
>>>>
>>>>      int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>>                                 bool direct, struct dma_fence **fence)
>>>>      {
>>>>          struct amdgpu_device *adev = ring->adev;
>>>> -     struct amdgpu_bo *bo = NULL;
>>>> +     struct amdgpu_bo *bo = adev->uvd.ib_bo;
>>>>          uint32_t *msg;
>>>>          int r, i;
>>>>
>>>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>>>> -                                   AMDGPU_GEM_DOMAIN_GTT,
>>>> -                                   &bo, NULL, (void **)&msg);
>>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>> Please use amdgpu_bo_reserve() here and elsewhere as well just to be on
>>> the clean side.
>>>
>>> Lockdep will sooner or later complain that we reserve a BO in the reset
>>> path, but that is mostly a theoretical problem and existed before. So
>>> I'm fine with sticking with that for now cause the problem was there
>>> before as well.
>>>
>>> It's just that trylock might not work because the BO is busy with
>>> indirect submission.
>>>
>>> Apart from those two minor issues the patch looks good to me.
>>>
>>> Thanks,
>>> Christian.
>>>
>>>>          if (r)
>>>>                  return r;
>>>>
>>>> +     msg = amdgpu_bo_kptr(bo);
>>>>          /* stitch together an UVD destroy msg */
>>>>          msg[0] = cpu_to_le32(0x00000de4);
>>>>          msg[1] = cpu_to_le32(0x00000002);
>>>> @@ -1223,7 +1233,10 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>>          for (i = 4; i < 1024; ++i)
>>>>                  msg[i] = cpu_to_le32(0x0);
>>>>
>>>> -     return amdgpu_uvd_send_msg(ring, bo, direct, fence);
>>>> +     r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
>>>> +
>>>> +     amdgpu_bo_unreserve(bo);
>>>> +     return r;
>>>>      }
>>>>
>>>>      static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>>> index edbb8194ee81..76ac9699885d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>>> @@ -68,6 +68,7 @@ struct amdgpu_uvd {
>>>>          /* store image width to adjust nb memory state */
>>>>          unsigned                decode_image_width;
>>>>          uint32_t                keyselect;
>>>> +     struct amdgpu_bo        *ib_bo;
>>>>      };
>>>>
>>>>      int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>> index bc571833632e..301c0cea7164 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>> @@ -332,12 +332,10 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
>>>>      static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>>      {
>>>>          struct dma_fence *fence = NULL;
>>>> -     struct amdgpu_bo *bo = NULL;
>>>> +     struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>>>>          long r;
>>>>
>>>> -     r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>>>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>>>> -                                   &bo, NULL, NULL);
>>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>>>          if (r)
>>>>                  return r;
>>>>
>>>> @@ -357,9 +355,7 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>>
>>>>      error:
>>>>          dma_fence_put(fence);
>>>> -     amdgpu_bo_unpin(bo);
>>>>          amdgpu_bo_unreserve(bo);
>>>> -     amdgpu_bo_unref(&bo);
>>>>          return r;
>>>>      }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>> index b6e82d75561f..efa270288029 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>> @@ -338,12 +338,10 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
>>>>      static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>>      {
>>>>          struct dma_fence *fence = NULL;
>>>> -     struct amdgpu_bo *bo = NULL;
>>>> +     struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>>>>          long r;
>>>>
>>>> -     r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>>>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>>>> -                                   &bo, NULL, NULL);
>>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>>>          if (r)
>>>>                  return r;
>>>>
>>>> @@ -363,9 +361,7 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>>
>>>>      error:
>>>>          dma_fence_put(fence);
>>>> -     amdgpu_bo_unpin(bo);
>>>>          amdgpu_bo_unreserve(bo);
>>>> -     amdgpu_bo_unref(&bo);
>>>>          return r;
>>>>      }
>>>>

