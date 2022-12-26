Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46283C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Dec 2022 10:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D1110E064;
	Mon, 26 Dec 2022 10:34:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E33010E056
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Dec 2022 10:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSU3t3lgrloTKEZ41x3nauFLFvzcdqkofyjiSDW6aENK5ktRRLnqXGvW8Cq+vQsN8in2txi1nftaSogayTjF2scyV0O0oNLvNhZ9JlrFr9smn50fbWvfI5sp/DZuABCA5Uv6ultm7rVJ7nMpL4Imq0fYrYu7kifTiNVvlQF+NnR7uKKJ+aqYADr+5aQO4lx3BMCTZnAy9Ywu0ozUSnRrykU3Q/s0pqJ/NkNMmrDskAi0F+dpnUiOBXX3fvILFMqSyYz7Lz2XJ8E1EcjpnTOpYwba8n3IUXMg9oP3C5MgH9vJg++p28K+I47KVptElLe65tUe3SfzLqWVL042iuF0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbrfNgIjPx7HR5MIq8RiSO1pAJPdA2bDaNFqelfUz7o=;
 b=HMpT6i7lbzDMAVb+BLTDqcQjB9zq+XOluBGz9akFCXh++iR4LKRIX/kZOYtNLAqHPOo63Uc2bIrYVKB09g2hazaS1++NITMAn+AP/UrpFACtdScDS2u6hVkiuE3rLe569vAhHgriKYTxadpH1rRXuZW20tGgUREmVrTKwjpdB50NkJct5Pnyv8thz5AozohuWfqA45vZxU5RSc8/JPXES3oOXXdllYqJnVTsNbw1WEOL25ewQXGXrzGcmu96l91CyFkEULFlSricgaWmY9F09KoCAmmfeP4dEvE/EMqkCgo9zs0pk9sewETxqiZ732G3H2cNvQvCvItT6N95BRnluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbrfNgIjPx7HR5MIq8RiSO1pAJPdA2bDaNFqelfUz7o=;
 b=Wmou62BVRqtJDKtFecDAKHLsSVch9AWrHCtO8iY5uEn0Fq5jDYM0Ds7iALVT8j+DzQTLzTrGpeA2VyAZl6voR4Ld3b+Bq4LgpfIZPdKk82zqC3MjXtYT+prb/KTHQrN27Jgi0woFZvsVGqF0f8cFCxA//7brcRD7qPVIDxYuDL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Mon, 26 Dec
 2022 10:34:42 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.012; Mon, 26 Dec 2022
 10:34:42 +0000
Message-ID: <684d284a-6f56-fabd-5cac-610440769451@amd.com>
Date: Mon, 26 Dec 2022 11:34:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-3-shashank.sharma@amd.com>
 <CAFCwf12zTZuQAYnxik26BaWtxJxgtB4wSuZNr7=NtU+KQetpiA@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CAFCwf12zTZuQAYnxik26BaWtxJxgtB4wSuZNr7=NtU+KQetpiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 870ba69e-eaa4-468e-fae9-08dae72ccc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6uPiBdiX5lm5dvicarY6wg8gEi/z0z39cOUCIbXIQ/MXU4IDnhBTs2om46v62hVAV5OKEhRM1a160+z3YIIo1Z1cJDGqeC8jgRLQSYb4QsFt10rID95+yNa+9B5qU+UEPTvqIBq9OZoXanZwZG2kEib4mVmwWHKrMx8edANmEe6JsU7L8oiJ39EY2q+n210RxEbYUx0NihTWb7JFT74Mk6dj/lVQKxIxlArQ+fVqHryiRfiJKWd8wJAWstPCQut4bOLQZQlgGlIWNy+9VIvTqKbnembaOBDcZ5vRGV/2SSfX1QSGvycmXJyA7Jnfy00zHgwyA8N1PF9bjcrO0p7PFcKHnEUIIYfAT4D7qTNaf/e4lZpNfaqJu+H97Q5LdCTJY76Vz3bB7psQkr8XYmH8kAgoGnxkpSnBSPpQUodipSVCM3AaTe9LyP+pPx7+IAg49psXFxnOrfzqjZuGDOKU8L2wXxZHN1UWhMywuHr4prVY3pVuv8GYpk70OwjetgBuzoKv4/F1yNbhcVI9GdPnBb6HdNgXvA3O0KtxQ4AKC9RNFWpn4Zs58ssCb30TlB5/J5RETZoaaN2BuiM+1zJwAY4q5HX9ItjSv8cu1lSPuov02v2XzEfkBDLtK02FILQkBY66ANNWik8AoWA6hecBVtVYVG/yhPCAK3m+ds0olutl/J5xN2MKgiRynMryTYLMWmjgg6ZQowxwGuzszXXBgoeO0TVIuCfThEIBKlK1ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(86362001)(31696002)(38100700002)(5660300002)(2906002)(8936002)(30864003)(41300700001)(44832011)(6666004)(6506007)(478600001)(26005)(2616005)(53546011)(6512007)(6486002)(186003)(4326008)(8676002)(66946007)(66556008)(316002)(54906003)(6916009)(66476007)(31686004)(66899015)(83380400001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkEyVnJFUFl6akUxMHNxWHowbHhjSFdQZEV4c0NWNlprSzAvV3dRVG5mQXR2?=
 =?utf-8?B?YlQrZkJoaW1WdFVLZEFCdGlLZnRyQnBEYWpBR016Q1ZFMFJ5TTRzS0FJcmRN?=
 =?utf-8?B?V2M2MWhqS0g4WUwvMzExSWpnYVcvelVDTnI1SmVpTGRGVzFoYjQ5Sm1yWlBG?=
 =?utf-8?B?SkxnNmkwQzExME1iSllkZ1o1RjlNdFhPZjVOaUdYdWRVZjRhY0tGOEJQQWtw?=
 =?utf-8?B?ZXJINFVyK29LM3hkdDJRSnQxenk5Y3EyTldqZnZDZjBYMTFyVXpNeUVOcm9n?=
 =?utf-8?B?NEZwVS9QdnJLUytWMC9HOExYQm50WG9vTlNOK2l6MVo2YnRMcmZDaU9nZS9h?=
 =?utf-8?B?b09kTXRtei9UcUxLdTlocmJ3V09qM21BLzE4Vy9JQTZBemtWVGhYclUvdnJU?=
 =?utf-8?B?VjNkOFlLK0pzakQ5Nlc1ZVpwQ1NoT1NCdDB1YWRoV3pwdDhtSUhnRXFZb3NY?=
 =?utf-8?B?NEVlcGdJVktSU1lOSVFXdlEyeitUUFZVMzZ1SFdnMkRyVWNVL0RNU3Q5L3Fn?=
 =?utf-8?B?K2M4Kzh3TGpSa0lZT3EvNnIrQTdZcnVBbldrdWlBd2w0UzVwWks0TlAvc1Fw?=
 =?utf-8?B?SnBYdEkzZjg3K2tnOTRxSlRUQzJlblZEWTVsQ3NzVGRwOTZHejhzYlVwYTUr?=
 =?utf-8?B?cVRtSXlmdElTdEZqRVFRRnkvNjh2NTFIZUsvUkUwZXRxd2EvNHBJbEN5VmN0?=
 =?utf-8?B?cHV3NXpCdkhIZWREWUNBcTZORDM4dk84ekV5UUVtbWk0WVh0S0lGNjJDZXZy?=
 =?utf-8?B?b3J5OEtKU1h0SGJvSVVscUcxSlRuc3E4RXM3UzJmM2xJOVlxUUVlMTZMbVRV?=
 =?utf-8?B?MzNjVEZCaGs3U2JoS3A4UWxTZUEyN2JyRlBidVBLTXdJKzZDUUl1dFEzZUtS?=
 =?utf-8?B?S1Y3cGFSR0ZsdkFyYUZKYjJkTkw4Uk9OajFwZzdNM2lsRHRJNnZKQ3lwUGdV?=
 =?utf-8?B?TlF3cVJXOWhvOEFidGVuTWtEYlhFbjRkK251TlZ5bmJnMHcwYlF4T2ZZelNp?=
 =?utf-8?B?WFd6NGhZa0xJMmpiYzR0QXRNdHAxS2JGZXE1K2NlY1NTemIzT0daR1ZxZHJn?=
 =?utf-8?B?YVFON1R2RnhDWFZDVXRFNjQ2ZkRsSzYrcEJLTUE3amxQYmUwSTIzWHFmNTQr?=
 =?utf-8?B?L3BtcG5hZWNySGpOeWExYVVyclNQdW1vVnRkUjlMUHRSWkl4YkVYcTkrWmZo?=
 =?utf-8?B?ZEV6akZyUDh3djVPSjF3QmxPWEdTcExSbm9XZUZyL29KYkFFd1Vmem14REs1?=
 =?utf-8?B?NElUMlg4b0NOR0xVaXlpZWZWUEo2QUVrK0dMeGhMOHludW52Mlp5ZG9hRnVJ?=
 =?utf-8?B?UlpJYS9RUlUrUDJmam1rQXByVzZxOEYxanBIUm1KUnplVXJ2UGhpVTF2dTVo?=
 =?utf-8?B?OGw2dENvYWwwK0daSmhDWlNHQzNpQXd6Ulp2bWtLZ3lwSnlmYVpJZSt4N0N0?=
 =?utf-8?B?ZWR4TmJBRE9NU09PdVJ6K3d0QmoxSXEzUzFmUnpEYkxBVm51d1RYeGd4Qk8r?=
 =?utf-8?B?MTh6eGZ6aWVSY3c0dTBYT1RDV25RT09ubnVaaXc0QUZoTEgwMmU5OG56bUg2?=
 =?utf-8?B?My9VdW5NVXpiZzdMd1NnZnJwSndEd1NTVFMxZHg1NE11WlNJQkJDSjNxRnp6?=
 =?utf-8?B?SHYyYWZkd1pTYldzd2ppMFBjeVNYclVlQ29FU1ZWQWFkQ2dPRDAzRERtSk9N?=
 =?utf-8?B?alNXZHdsR2NHK2VrYy9wYXkwQTdKZnpyRHBobUV5SVZ3dDhyaWpWOHJ1T3k3?=
 =?utf-8?B?aG5oVzdtTXNXTGNET25VZmJBN0NLaXZ3aHFxQm9MSW9uNURXMGRVcjlWNE1U?=
 =?utf-8?B?amgwa05FY3hsSURvYmEwZCtiR09maGlnbWpqWXg4TXNmQ055THc2V1VUTStq?=
 =?utf-8?B?NmFiTXpNS0tsZzlCZ25VRmt6ckZ4Vno1dWQrNHlKalc0dXQwWTRxSFBUVW9p?=
 =?utf-8?B?RmliMDZlencvcXowY1J5RmppVWdqbUZzZ3lQTnpmajRzZVRVZ0k3TUJHVFRl?=
 =?utf-8?B?bUpHdmtydlcyWEQyU2k3SjAySnpRU3p3UHFrRE9KOExlQnNmSTVNR21NWUtN?=
 =?utf-8?B?dEFIRDFKYmo3TFhKNndybERpVjBFUkRObWt2L0h4YlI5SW5vL3BkRlBaQ1Bz?=
 =?utf-8?Q?O5AXBbGP6zuhMJzjgz/tifRv4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870ba69e-eaa4-468e-fae9-08dae72ccc52
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 10:34:42.2194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ET6MKOd4rNfjXBojolD/unou5Eri/5j+p2nuJcd3VE1OSnlldBVIum8xqEkIJsCqCD9E3jbyzkvx2yb6jj2AXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Oded,

Thank you for your comments,

On 24/12/2022 19:19, Oded Gabbay wrote:
> On Fri, Dec 23, 2022 at 9:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> This patch adds skeleton code for usermode queue creation. It
>> typically contains:
>> - A new structure to keep all the user queue data in one place.
>> - An IOCTL function to create/free a usermode queue.
>> - A function to generate unique index for the queue.
>> - A global ptr in amdgpu_dev
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 187 ++++++++++++++++++
>>   .../drm/amd/include/amdgpu_usermode_queue.h   |  50 +++++
>>   5 files changed, 246 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 6ad39cf71bdd..e2a34ee57bfb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -209,6 +209,8 @@ amdgpu-y += \
>>   # add amdkfd interfaces
>>   amdgpu-y += amdgpu_amdkfd.o
>>
>> +# add usermode queue
>> +amdgpu-y += amdgpu_userqueue.o
>>
>>   ifneq ($(CONFIG_HSA_AMD),)
>>   AMDKFD_PATH := ../amdkfd
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 8639a4f9c6e8..4b566fcfca18 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -749,6 +749,11 @@ struct amdgpu_mqd {
>>                          struct amdgpu_mqd_prop *p);
>>   };
>>
>> +struct amdgpu_userq_globals {
>> +       struct ida ida;
>> +       struct mutex userq_mutex;
>> +};
>> +
>>   #define AMDGPU_RESET_MAGIC_NUM 64
>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>   #define AMDGPU_PRODUCT_NAME_LEN 64
>> @@ -955,6 +960,7 @@ struct amdgpu_device {
>>          bool                            enable_mes_kiq;
>>          struct amdgpu_mes               mes;
>>          struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>> +       struct amdgpu_userq_globals     userq;
>>
>>          /* df */
>>          struct amdgpu_df                df;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> index 0fa0e56daf67..f7413859b14f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>>          unsigned long                   ras_counter_ce;
>>          unsigned long                   ras_counter_ue;
>>          uint32_t                        stable_pstate;
>> +       struct amdgpu_usermode_queue    *userq;
>>   };
>>
>>   struct amdgpu_ctx_mgr {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> new file mode 100644
>> index 000000000000..3b6e8f75495c
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -0,0 +1,187 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_mes.h"
>> +#include "amdgpu_usermode_queue.h"
>> +#include "soc15_common.h"
>> +
>> +#define CHECK_ACCESS(a) (access_ok((const void __user *)a, sizeof(__u64)))
>> +
>> +static int
>> +amdgpu_userqueue_index(struct amdgpu_device *adev)
>> +{
>> +    int index;
>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>> +
>> +    index = ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ, GFP_KERNEL);
>> +    return index;
>> +}
>> +
>> +static void
>> +amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>> +
>> +    ida_simple_remove(&uqg->ida, queue->queue_id);
>> +}
>> +
>> +static int
>> +amdgpu_userqueue_validate_input(struct amdgpu_device *adev, struct drm_amdgpu_userq_mqd *mqd_in)
>> +{
>> +    if (mqd_in->queue_va == 0 || mqd_in->doorbell_handle == 0 || mqd_in->doorbell_offset == 0) {
>> +        DRM_ERROR("Invalid queue object address\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (mqd_in->queue_size == 0 || mqd_in->rptr_va == 0 || mqd_in->wptr_va == 0) {
>> +        DRM_ERROR("Invalid queue object value\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type >= AMDGPU_HW_IP_NUM) {
>> +        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!CHECK_ACCESS(mqd_in->queue_va) || !CHECK_ACCESS(mqd_in->rptr_va) ||
>> +        !CHECK_ACCESS(mqd_in->wptr_va)) {
>> +            DRM_ERROR("Invalid mapping of queue ptrs, access error\n");
>> +            return -EINVAL;
>> +    }
>> +
>> +    DRM_DEBUG_DRIVER("Input parameters to create queue are valid\n");
>> +    return 0;
>> +}
>> +
>> +int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
>> +                            union drm_amdgpu_userq *args)
>> +{
>> +    int r, pasid;
>> +    struct amdgpu_usermode_queue *queue;
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_vm *vm = &fpriv->vm;
>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>> +
>> +    if (!ctx) {
>> +        DRM_ERROR("Invalid GPU context\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (vm->pasid < 0) {
>> +        DRM_WARN("No PASID info found\n");
>> +        pasid = 0;
>> +    }
>> +
>> +    mutex_lock(&adev->userq.userq_mutex);
>> +
>> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>> +    if (!queue) {
>> +        DRM_ERROR("Failed to allocate memory for queue\n");
>> +        mutex_unlock(&adev->userq.userq_mutex);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    r = amdgpu_userqueue_validate_input(adev, mqd_in);
>> +    if (r < 0) {
>> +        DRM_ERROR("Invalid input to create queue\n");
>> +        goto free_queue;
>> +    }
>> +
>> +    queue->vm = vm;
>> +    queue->pasid = pasid;
>> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
>> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
>> +    queue->queue_size = mqd_in->queue_size;
>> +    queue->queue_type = mqd_in->ip_type;
>> +    queue->paging = false;
>> +    queue->flags = mqd_in->flags;
>> +    queue->queue_id = amdgpu_userqueue_index(adev);
>> +
>> +    ctx->userq = queue;
> It looks like you have a single userq per context, and here you simply
> override the userq pointer.
> Maybe I've missed it, but where do you protect against a user
> accidentally creating two user queues ? It will cause a memory leak as
> you don't release the previous q.
> I would imagine you should reject the user from creating another userq
> until it frees the current userq.

Noted, this is a valid expectation, will add a check here.

- Shashank

> Oded
>
>> +    args->out.q_id = queue->queue_id;
>> +    args->out.flags = 0;
>> +    mutex_unlock(&adev->userq.userq_mutex);
>> +    return 0;
>> +
>> +free_queue:
>> +    amdgpu_userqueue_remove_index(adev, queue);
>> +    mutex_unlock(&adev->userq.userq_mutex);
>> +    kfree(queue);
>> +    return r;
>> +}
>> +
>> +void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file *filp,
>> +                              union drm_amdgpu_userq *args)
>> +{
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>> +    struct amdgpu_usermode_queue *queue = ctx->userq;
>> +
>> +    mutex_lock(&adev->userq.userq_mutex);
>> +    amdgpu_userqueue_remove_index(adev, queue);
>> +    ctx->userq = NULL;
>> +    mutex_unlock(&adev->userq.userq_mutex);
>> +    kfree(queue);
>> +}
>> +
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>> +                      struct drm_file *filp)
>> +{
>> +    union drm_amdgpu_userq *args = data;
>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>> +    int r = 0;
>> +
>> +    switch (args->in.op) {
>> +    case AMDGPU_USERQ_OP_CREATE:
>> +        r = amdgpu_userqueue_create(adev, filp, args);
>> +        if (r)
>> +            DRM_ERROR("Failed to create usermode queue\n");
>> +        break;
>> +
>> +    case AMDGPU_USERQ_OP_FREE:
>> +        amdgpu_userqueue_destroy(adev, filp, args);
>> +        break;
>> +
>> +    default:
>> +        DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
>> +        return -EINVAL;
>> +    }
>> +
>> +    return r;
>> +}
>> +
>> +int amdgpu_userqueue_init(struct amdgpu_device *adev)
>> +{
>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>> +
>> +    mutex_init(&uqg->userq_mutex);
>> +    return 0;
>> +}
>> +
>> +void amdgpu_userqueue_fini(struct amdgpu_device *adev)
>> +{
>> +
>> +}
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>> new file mode 100644
>> index 000000000000..c1fe39ffaf72
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>> @@ -0,0 +1,50 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef AMDGPU_USERMODE_QUEUE_H_
>> +#define AMDGPU_USERMODE_QUEUE_H_
>> +
>> +#define AMDGPU_MAX_USERQ 512
>> +
>> +struct amdgpu_usermode_queue {
>> +       int             queue_id;
>> +       int             queue_type;
>> +       int             queue_size;
>> +       int             paging;
>> +       int             pasid;
>> +       int             use_doorbell;
>> +       int             doorbell_index;
>> +
>> +       uint64_t        mqd_gpu_addr;
>> +       uint64_t        wptr_gpu_addr;
>> +       uint64_t        rptr_gpu_addr;
>> +       uint64_t        queue_gpu_addr;
>> +       uint64_t        flags;
>> +       void            *mqd_cpu_ptr;
>> +
>> +       struct amdgpu_bo        *mqd_obj;
>> +       struct amdgpu_vm        *vm;
>> +       struct list_head        list;
>> +};
>> +
>> +#endif
>> --
>> 2.34.1
>>
