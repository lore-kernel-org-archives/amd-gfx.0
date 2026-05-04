Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83264FF885A
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 12:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099B210E3C4;
	Mon,  4 May 2026 12:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hXEPZn9M";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 268B110E3C4
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2026 12:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwLCu94gS2vR6XlagWJ3gqdD7NRtQNKz9MYJi2DjGk2xNPsVbmW7tf5ryc2tGqIKtIe5BFOYxvsosmc/gla2ir0A4z960FdHJJqx2QLbupGrIoidl8QUP/nQXg1aTiugrIkCLhzmdTBm58bH5eA2u0O/bx1H5RFWd4ri17/h3rbayS8Qx+n2VPDpRZOIawvDfu540I/9N1/FXKD6jl/OdFMEGyq8UCf78foxdjmHnUvdBgEGSbLxpVs8jnLfn6yACXdC9lu7z0zpj3kIgw6q5WkH0oj+Gfpq1pbK3jd1n2afQP1bFKhnspCR0TsCMQoYV+TAh2xlAVKH33qeAOTrzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tlTymuRzorUpHcFMsj+gE2lOoNXPYxiBxhYnFfORvQ=;
 b=NSyosk0abJQqGq5czQKMGP9zMbY2+f8KUr69CVe5UmtvWd9m6ZINvgF900l9+Rx/QEXO973lziu90b6DZWM0GjYlRgHMWeAHp7yq5ZSr48lqErXFNOrm6Wf7mlWaRfJl7pZNJseAkC8bDlZpOBisHgdz0KztpQcZNfBlyR9mupB7xU6YZEjqF/gW0cn8wTLBuNSsxC9XLgJpYk17d3J/KvEtuExOvmqRsvhX8Zc8sLogxvnScBXBcTQN/GZrmzorPKM2jh7I1zbNZo0hXl/nV1iJGiHqtfjp4ZEhqQibL9DbvaFU+BXhdPjk2jNiuI8E3KyO5Y4K9yx44yKv8ybGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tlTymuRzorUpHcFMsj+gE2lOoNXPYxiBxhYnFfORvQ=;
 b=hXEPZn9Mdo8ZkCblhLUGMj0sKsoYR7qr/oRitz9hqQ9pSQEWFDEHbsevqW+ev58aumrcwk8Q3BgzNqUqUjs/IPXjMxu8p8GMfOxG6L5hcJVwVoL+eREZmR91tNiN5lPypXgJXCTdUtBBgaF0CgSh4rZchznT6AImGX03IaFrI/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 12:37:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 12:37:19 +0000
Message-ID: <f19e0c75-2423-4231-85c8-f6716dac1712@amd.com>
Date: Mon, 4 May 2026 14:37:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/amdgpu: rework amdgpu_userq_signal_ioctl v2
To: "Khatri, Sunil" <sukhatri@amd.com>, alexander.deucher@amd.com,
 Prike.Liang@amd.com, jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <20260427182723.1715-3-christian.koenig@amd.com>
 <5e0a9edc-2225-4e02-a587-3f64d2b67e0a@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5e0a9edc-2225-4e02-a587-3f64d2b67e0a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0441.namprd03.prod.outlook.com
 (2603:10b6:408:113::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2a7a5f-7c1e-4d88-84de-08dea9d9e192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: XxohbtAQ0SU1ME6wjZHEi1TXixZLq0roRdqdF0a5nylmgT9vZJ0YJyjRZWT/+PSLMhOx54P0gPQ3JHIqMN1XWHJ+XXW9cBFn0Pbo885xrV2/lY0QTk2olhIxleqPwUP00BhbERr8MTg6l9V40mHmOu9vZadv+ibwv6DuD0qziwpX+OKvkZtTb4rAl7BviMrsOwBLFxJy3VPJWnWbYzfUEbuF0rDaFBIIKgd0tuvKKWS5ur8qCxvI/uzIklmUWFhZoDZdczTUloQYhGpj9cx70EKPNKa5dI+pZZshY6Xg+qsy6+qO/dgYOoGn6nQtatMwBXGqU1YAXjtYtPUH9N2uiECyNM+S0nKihvcl6KHJtT0IL9okkq5xQWND8v45yNjBmwFycdCAIL+PL6zklBOkomy8kR4Pv1G1fFW8cScMJuvCxNEnzGZEUHLpvBKFSSUo3GOYSB+aQB19J+aLYcMRg48M388mCsgxJy0xXJD9kKJE866MjzKqDcTntWyUHCZSi+AxIdopXmdaRjp7fixyFK9XojvtXbwG50tQr3zx++wFs/CnNf1bH8ie5StiRLQamM3kwG94F1A+cxE9YCuvt35yBW978sYZLIp2vJ3BXV1GAPmSDLkSUSepqwyreB/bv9hKoMhoeYtdWnTdwNg1ZCh1I184V/TcwYrIQhvVJ66xfykSkLYoc+We2otvyqjw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVPcFBkcGxOei8xZkZrVGVheDQ1MzVIOUp0V2RNeDRlN0lZeEgzMEl1cVZQ?=
 =?utf-8?B?cm1JTWNMYlJOSTBJcHdzTDhFK3pnb2lNeE9Bd1BzS29lQjJoNmRCekJNRlho?=
 =?utf-8?B?OW4zVXpjanIvRENIV1VWSTB3QllJRmNGR3I5R1ltMFd5d3FaV0lEMGc0cUJ0?=
 =?utf-8?B?SWw5ZUg4VXdkTWxJOXBUU2QrbEFjQWFuTXFSMnpaOTZpT29ySzBvK0U2cUds?=
 =?utf-8?B?bzQvaWlUb3pBZm1FRHo5YXlES1VrTkh4SmVwdW9vS3oxL0o5ZTZ3dzZmOE9u?=
 =?utf-8?B?b0U3Wld4bkp3MG9UbjYyNlBVcmRHQnd6ZXVXc1FIMnN5U3dQV1VNUHJNeUFG?=
 =?utf-8?B?ekQza0NMVnd6aWZYZ2dBd3R0dWFHYUNGcjVSL2dDM2JObFlaZVF2dmQwV1kv?=
 =?utf-8?B?WENPekxGUHFWRXJyK2ZReVdhVEZBb0FqeDRtWnBYaG1oZTRDbURGYjQ5VzhK?=
 =?utf-8?B?WGVCc1VVMS8xTy9ENFdjakVtMEVqVWlTOCtXemdVWi9lODZXaEh0eXZaWDhP?=
 =?utf-8?B?bFkxUHpJanhsQktDT0RnY3FlTU5KT2R6cXpCRGVkdXZTc0JNeUJ1eEJialdl?=
 =?utf-8?B?TWJXUmplYnhFYm9NY3N1Y291bUZzU0NOWktvM0oxUjNPblFWSFExcmh6TFZB?=
 =?utf-8?B?K21relIweHV3YmtiUlRsWXNZaU5ZZkNjNjE5RDhUNHNGQ0NReFk0YWtUL1hQ?=
 =?utf-8?B?ZS8vWmMyWUlBRHBucmp1RUYxK0tCcnUxL0VhWTQ3VUlQSHNQdjZnTWdRTTky?=
 =?utf-8?B?N3VqS2xBVHM0bEsrZzNTMTN1a1lQSm02cW5rT0xxZnE1N2Z4TkUvcUtPWmNt?=
 =?utf-8?B?V1VzblhFREZkY2RTTWplSk9pM1VwTlpvSElaaXkydU13YzVIUDJ5R1VTSkhE?=
 =?utf-8?B?bDNOMndkRU5KaVF5SGlBRXV3aUZodTRBQ1NCYU1hRTdoZzBEdlh3V1UzSHJU?=
 =?utf-8?B?SFp0OWxwNWQyUjFQU0hvVWc2Q1kxb2RtSnU5emQ1YXQ0R0VvcjNmak4zaFp3?=
 =?utf-8?B?Wm5XcnBZL0RTcFRyeGxQUkNvK2UzN05lcGg5OWpHRUhMWWdIaGhFVmI0U2U0?=
 =?utf-8?B?alR2NzBDV3krMFhsN3d6Y0ZxTE9sRGw0S1pTNzRmWmdoUTRIV0tBelRnclh0?=
 =?utf-8?B?djg0em03cTZIdEFyb1hUSVRxTTBhVi9WWTllR1c2aTcwa3VDcUhrZXovTnFZ?=
 =?utf-8?B?c1Z5OUdXN1RIV1QxcEI1TkhiK29CbkdyUWxvMGlIOUFRMjRZTk0yYnVUaUZM?=
 =?utf-8?B?MlRNS1VMbHExRkNTTVRLdk43WEpHY0dwZzdabzhvOURaMnBQM2ZqQUZUY1Vo?=
 =?utf-8?B?UE5sL3ZhcGRmbkFyOFRBRzU1Y2dlRXJiMzdzWVhqcG9XOVRHLytWYU1EMUJa?=
 =?utf-8?B?dlF2eEZ1MllhaFllTk1WOVNoOEVDOExGblA2VGo0anY1TUtHanRXc0NtOGR3?=
 =?utf-8?B?SjJsRXlsLzBranJFREdhMnVTbVQ0c0R4blBoRUpoS2FtYmNqOVRwUXBnRE5O?=
 =?utf-8?B?S0tEWExaV2F2RlBVcFZEeUFwWi9GbzhTNExIWnprSU0yOFVxVFlOaEtmR2ZQ?=
 =?utf-8?B?M3NqNlVNZ3ZhM28zUm1KdUNwdTNPcEZwNEJaVDJvTE84aDRKOFBCcTlxZ3oz?=
 =?utf-8?B?d1lNanlxMnIzRVFVYXV6dzFEbGl4OFE0dVdMZ1A5eTdHNTh4bktoS2hRZlBl?=
 =?utf-8?B?WXgyWVFPeGhOUjNCSFZOWnhoNVFKR09xbS94ak1kY2xhUGMvYWJ2UVB6d1Mw?=
 =?utf-8?B?RXZhaTNKdS9STlNia1YySDlWSUZLa1JIcGI2aFJldXpNd1dCdUQvWTY0eVhr?=
 =?utf-8?B?Mm1Gakg3NTdtRG8yU3ozY1haaW1JOVltVmJVTnJ0NHpRRTFwRWZycVRQTDZ1?=
 =?utf-8?B?WndKT1BHNW9wVlFhM1B1YVljQTQ3VXc3UDgyRVVhWVZ0L0Rwak91cFdSZGJQ?=
 =?utf-8?B?a1FzVGF3YjlFbkEwUDlTQngvSmlDcTd4Q0FyajFEMWNTbUJaNWR5UFdnWjNm?=
 =?utf-8?B?U0lzQ1JOeEgxSmMrKzBaTmpNNWpkaXIraEkzdjYvdGQzcU90WVpmcUdpcXMr?=
 =?utf-8?B?bEhxb0ZWN2V6RjJybFQrVHZQcVRwckxzZURHdCt2dEVjaGw0UGpqcjlKbmk0?=
 =?utf-8?B?bkNjTllSbU40MW0xQXJ4bXZTYVRBTU5BaWFkaXdpZ3F4dmI2cWFWM3IxYUQ3?=
 =?utf-8?B?YVVzcEd2Mno4TG96bWcybWZPRlBrTE1oQVVFZ0tsdUZhT1ViaVUyN2J6Sy9K?=
 =?utf-8?B?UlIvNnFiY1d4aEtsakYzaHNVdk9ORnhHK1V6N1FmZlhvNzNEQ2J2OEQvSUFK?=
 =?utf-8?Q?XrqSg2lAjm1heHL235?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2a7a5f-7c1e-4d88-84de-08dea9d9e192
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 12:37:19.3456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkHrhQmMUXVUmyu/5pmoGY7cLkEnwZGhc/8H4FiDFSARTAct9Z+WCukS4KH2eW7G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
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

On 4/28/26 11:35, Khatri, Sunil wrote:
> 
> On 27-04-2026 11:57 pm, Christian König wrote:
...
>>   -static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>> +static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
>> +                    struct amdgpu_userq_fence **pfence)
>>   {
>> -    *userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>> -    return *userq_fence ? 0 : -ENOMEM;
>> +    struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
>> +    struct amdgpu_userq_fence *userq_fence;
>> +    void * entry;
>> +
>> +    userq_fence = kmalloc(sizeof(*userq_fence), GFP_KERNEL);
>> +    if (!userq_fence)
>> +        return -ENOMEM;
>> +
>> +    /*
>> +     * Get the next unused entry, since we fill from the start this can be
>> +     * used as size to allocate the array.
>> +     */
>> +    mutex_lock(&userq->fence_drv_lock);
>> +    XA_STATE(xas, &userq->fence_drv_xa, 0);
>> +
>> +    rcu_read_lock();
>> +    do {
>> +        entry = xas_find_marked(&xas, ULONG_MAX, XA_FREE_MARK);
>> +    } while (xas_retry(&xas, entry));
>> +    rcu_read_unlock();
> Functionally its correct but Using xa_for_each to count the no of entries should suffice for what we need?  why doing more work or this approach is fixing something which xa_for_each does not ?

The xa is a radix tree, using xa_for_each to count the number of entries is just horrible inefficient.

>> +
>> +    userq_fence->fence_drv_array = kvmalloc_array(xas.xa_index,
>> +                              sizeof(fence_drv),
>> +                              GFP_KERNEL);
>> +    if (!userq_fence->fence_drv_array) {
>> +        mutex_unlock(&userq->fence_drv_lock);
>> +        kfree(userq_fence);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    userq_fence->fence_drv_array_count = xas.xa_index;
>> +    xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
>> +           0, ULONG_MAX, xas.xa_index, XA_PRESENT);
> same count could be used here also to copy, just open questions but the current code is good to go.
> Irrespective of the change the code is Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Thanks,
Christian.

> 
> Regards
> Sunil Khatri
>> +    xa_destroy(&userq->fence_drv_xa);
>> +
>> +    mutex_unlock(&userq->fence_drv_lock);
>> +
>> +    userq_fence->fence_drv = fence_drv;
>> +    amdgpu_userq_fence_driver_get(fence_drv);
>> +
>> +    *pfence = userq_fence;
>> +    return 0;
>>   }
>>   -static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>> -                     struct amdgpu_userq_fence *userq_fence,
>> -                     u64 seq, struct dma_fence **f)
>> +static void amdgpu_userq_fence_init(struct amdgpu_usermode_queue *userq,
>> +                    struct amdgpu_userq_fence *fence,
>> +                    u64 seq)
>>   {
>> -    struct amdgpu_userq_fence_driver *fence_drv;
>> -    struct dma_fence *fence;
>> +    struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
>>       unsigned long flags;
>>       bool signaled = false;
>>   -    fence_drv = userq->fence_drv;
>> -    if (!fence_drv)
>> -        return -EINVAL;
>> -
>> -    spin_lock_init(&userq_fence->lock);
>> -    INIT_LIST_HEAD(&userq_fence->link);
>> -    fence = &userq_fence->base;
>> -    userq_fence->fence_drv = fence_drv;
>> -
>> -    dma_fence_init64(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
>> +    spin_lock_init(&fence->lock);
>> +    dma_fence_init64(&fence->base, &amdgpu_userq_fence_ops, &fence->lock,
>>                fence_drv->context, seq);
>>   -    amdgpu_userq_fence_driver_get(fence_drv);
>> -    dma_fence_get(fence);
>> -
>> -    if (!xa_empty(&userq->fence_drv_xa)) {
>> -        struct amdgpu_userq_fence_driver *stored_fence_drv;
>> -        unsigned long index, count = 0;
>> -        int i = 0;
>> -
>> -        xa_lock(&userq->fence_drv_xa);
>> -        xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>> -            count++;
>> -
>> -        userq_fence->fence_drv_array =
>> -            kvmalloc_array(count,
>> -                       sizeof(struct amdgpu_userq_fence_driver *),
>> -                       GFP_ATOMIC);
>> -
>> -        if (userq_fence->fence_drv_array) {
>> -            xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
>> -                userq_fence->fence_drv_array[i] = stored_fence_drv;
>> -                __xa_erase(&userq->fence_drv_xa, index);
>> -                i++;
>> -            }
>> -        }
>> -
>> -        userq_fence->fence_drv_array_count = i;
>> -        xa_unlock(&userq->fence_drv_xa);
>> -    } else {
>> -        userq_fence->fence_drv_array = NULL;
>> -        userq_fence->fence_drv_array_count = 0;
>> -    }
>> +    /* Make sure the fence is visible to the hang detect worker */
>> +    dma_fence_put(userq->last_fence);
>> +    userq->last_fence = dma_fence_get(&fence->base);
>>   -    /* Check if hardware has already processed the job */
>> +    /* Check if hardware has already processed the fence */
>>       spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>> -    if (!dma_fence_is_signaled(fence)) {
>> -        list_add_tail(&userq_fence->link, &fence_drv->fences);
>> +    if (!dma_fence_is_signaled(&fence->base)) {
>> +        dma_fence_get(&fence->base);
>> +        list_add_tail(&fence->link, &fence_drv->fences);
>>       } else {
>> +        INIT_LIST_HEAD(&fence->link);
>>           signaled = true;
>> -        dma_fence_put(fence);
>>       }
>>       spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>>         if (signaled)
>> -        amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>> -
>> -    *f = fence;
>> -
>> -    return 0;
>> +        amdgpu_userq_fence_put_fence_drv_array(fence);
>> +    else
>> +        amdgpu_userq_start_hang_detect_work(userq);
>>   }
>>     static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
>> @@ -404,11 +408,6 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
>>       return r;
>>   }
>>   -static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
>> -{
>> -    dma_fence_put(fence);
>> -}
>> -
>>   static void
>>   amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
>>                       int error)
>> @@ -452,13 +451,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>       const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>       struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>> +
>>       struct drm_gem_object **gobj_write, **gobj_read;
>>       u32 *syncobj_handles, num_syncobj_handles;
>> -    struct amdgpu_userq_fence *userq_fence;
>> -    struct amdgpu_usermode_queue *queue = NULL;
>> -    struct drm_syncobj **syncobj = NULL;
>> -    struct dma_fence *fence;
>> +    struct amdgpu_usermode_queue *queue;
>> +    struct amdgpu_userq_fence *fence;
>> +    struct drm_syncobj **syncobj;
>>       struct drm_exec exec;
>> +    void __user *ptr;
>>       int r, i, entry;
>>       u64 wptr;
>>   @@ -470,13 +470,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>           return -EINVAL;
>>         num_syncobj_handles = args->num_syncobj_handles;
>> -    syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>> -                        num_syncobj_handles, sizeof(u32));
>> +    ptr = u64_to_user_ptr(args->syncobj_handles);
>> +    syncobj_handles = memdup_array_user(ptr, num_syncobj_handles,
>> +                        sizeof(u32));
>>       if (IS_ERR(syncobj_handles))
>>           return PTR_ERR(syncobj_handles);
>>   -    /* Array of pointers to the looked up syncobjs */
>> -    syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
>> +    syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
>> +                GFP_KERNEL);
>>       if (!syncobj) {
>>           r = -ENOMEM;
>>           goto free_syncobj_handles;
>> @@ -490,21 +491,17 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>           }
>>       }
>>   -    r = drm_gem_objects_lookup(filp,
>> -                   u64_to_user_ptr(args->bo_read_handles),
>> -                   num_read_bo_handles,
>> -                   &gobj_read);
>> +    ptr = u64_to_user_ptr(args->bo_read_handles);
>> +    r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
>>       if (r)
>>           goto free_syncobj;
>>   -    r = drm_gem_objects_lookup(filp,
>> -                   u64_to_user_ptr(args->bo_write_handles),
>> -                   num_write_bo_handles,
>> +    ptr = u64_to_user_ptr(args->bo_write_handles);
>> +    r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
>>                      &gobj_write);
>>       if (r)
>>           goto put_gobj_read;
>>   -    /* Retrieve the user queue */
>>       queue = amdgpu_userq_get(userq_mgr, args->queue_id);
>>       if (!queue) {
>>           r = -ENOENT;
>> @@ -513,73 +510,61 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>         r = amdgpu_userq_fence_read_wptr(adev, queue, &wptr);
>>       if (r)
>> -        goto put_gobj_write;
>> +        goto put_queue;
>>   -    r = amdgpu_userq_fence_alloc(&userq_fence);
>> +    r = amdgpu_userq_fence_alloc(queue, &fence);
>>       if (r)
>> -        goto put_gobj_write;
>> +        goto put_queue;
>>         /* We are here means UQ is active, make sure the eviction fence is valid */
>>       amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>   -    /* Create a new fence */
>> -    r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>> -    if (r) {
>> -        mutex_unlock(&userq_mgr->userq_mutex);
>> -        kfree(userq_fence);
>> -        goto put_gobj_write;
>> -    }
>> +    /* Create the new fence */
>> +    amdgpu_userq_fence_init(queue, fence, wptr);
>>   -    dma_fence_put(queue->last_fence);
>> -    queue->last_fence = dma_fence_get(fence);
>> -    amdgpu_userq_start_hang_detect_work(queue);
>>       mutex_unlock(&userq_mgr->userq_mutex);
>>   +    /*
>> +     * This needs to come after the fence is created since
>> +     * amdgpu_userq_ensure_ev_fence() can't be called while holding the resv
>> +     * locks.
>> +     */
>>       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>>                 (num_read_bo_handles + num_write_bo_handles));
>>   -    /* Lock all BOs with retry handling */
>>       drm_exec_until_all_locked(&exec) {
>> -        r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
>> +        r = drm_exec_prepare_array(&exec, gobj_read,
>> +                       num_read_bo_handles, 1);
>>           drm_exec_retry_on_contention(&exec);
>> -        if (r) {
>> -            amdgpu_userq_fence_cleanup(fence);
>> +        if (r)
>>               goto exec_fini;
>> -        }
>>   -        r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
>> +        r = drm_exec_prepare_array(&exec, gobj_write,
>> +                       num_write_bo_handles, 1);
>>           drm_exec_retry_on_contention(&exec);
>> -        if (r) {
>> -            amdgpu_userq_fence_cleanup(fence);
>> +        if (r)
>>               goto exec_fini;
>> -        }
>>       }
>>   -    for (i = 0; i < num_read_bo_handles; i++) {
>> -        if (!gobj_read || !gobj_read[i]->resv)
>> -            continue;
>> -
>> -        dma_resv_add_fence(gobj_read[i]->resv, fence,
>> +    /* And publish the new fence in the BOs and syncobj */
>> +    for (i = 0; i < num_read_bo_handles; i++)
>> +        dma_resv_add_fence(gobj_read[i]->resv, &fence->base,
>>                      DMA_RESV_USAGE_READ);
>> -    }
>>   -    for (i = 0; i < num_write_bo_handles; i++) {
>> -        if (!gobj_write || !gobj_write[i]->resv)
>> -            continue;
>> -
>> -        dma_resv_add_fence(gobj_write[i]->resv, fence,
>> +    for (i = 0; i < num_write_bo_handles; i++)
>> +        dma_resv_add_fence(gobj_write[i]->resv, &fence->base,
>>                      DMA_RESV_USAGE_WRITE);
>> -    }
>>   -    /* Add the created fence to syncobj/BO's */
>>       for (i = 0; i < num_syncobj_handles; i++)
>> -        drm_syncobj_replace_fence(syncobj[i], fence);
>> +        drm_syncobj_replace_fence(syncobj[i], &fence->base);
>>   +exec_fini:
>>       /* drop the reference acquired in fence creation function */
>> -    dma_fence_put(fence);
>> +    dma_fence_put(&fence->base);
>>   -exec_fini:
>>       drm_exec_fini(&exec);
>> +put_queue:
>> +    amdgpu_userq_put(queue);
>>   put_gobj_write:
>>       for (i = 0; i < num_write_bo_handles; i++)
>>           drm_gem_object_put(gobj_write[i]);
>> @@ -590,15 +575,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>       kvfree(gobj_read);
>>   free_syncobj:
>>       while (entry-- > 0)
>> -        if (syncobj[entry])
>> -            drm_syncobj_put(syncobj[entry]);
>> +        drm_syncobj_put(syncobj[entry]);
>>       kfree(syncobj);
>>   free_syncobj_handles:
>>       kfree(syncobj_handles);
>>   -    if (queue)
>> -        amdgpu_userq_put(queue);
>> -
>>       return r;
>>   }
>>   @@ -873,8 +854,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>            * Otherwise, we would gather those references until we don't
>>            * have any more space left and crash.
>>            */
>> +        mutex_lock(&waitq->fence_drv_lock);
>>           r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>>                    xa_limit_32b, GFP_KERNEL);
>> +        mutex_unlock(&waitq->fence_drv_lock);
>>           if (r)
>>               goto put_waitq;
>>   

