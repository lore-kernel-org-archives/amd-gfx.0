Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5901C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 15:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E8810E33D;
	Wed, 28 Sep 2022 15:59:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8204B10E33D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 15:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iI3ceChGTOdwf/rw0DyBnA41JoJ2BY3eeXCKkBs0g0UFedZRLcldSq1DIxqXUWF75SMQoLNeu9Zmqq9JZVac/lhsXveyPIRz4/2uyfI67zR1Nf3cQL7TWKC97f5MmIByf0UWyXm7VmddXhRfNj7DASMrjGIoYBcVPGb02dp0cchEW6dsfiXcx8E9b8lDMtMr/mgIIDQpfzQMDr3VG0JO2XiS2HYYeFOCIgKTCSI01blD+zh2d+eJxcen2eNatuARE/z30h8q+TeSsPH6IVPIzNa3TBKMyS/lb2zuoua6i0F2U90EDwxhS8pYEsM4N+fydAbrEOGQNzQVcaS8xramLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntVaQ0QVhvT/fzUbB1G+pSBG68Dargkm3gsFDngwbsw=;
 b=B1RSonSy7urjFXRZQDZSRHGQ3QRbJFOtG+O3+HK8xqXo86gvvP4xOPBThymcSWWJODuEvKpZC2DYTHZ0e8Odl/32SAozwkdVN+erQ6yDcxMqvuVt81RIZOPKV9+YKoCY0cwNaIhp30SIbSj42WUTVkZxU3QGkdhL5NcBpA3cI3TEagoujVnZ0U5V2W0qf3o5p6Ju4VkpZIVv1GqkZzv43xclo97E0bcQ9RVszLU1QbaNFMRSWE7oj6SL1B7QbmSGssQFN6ouX7s0kSl26bwzI5sqjEiulTAlbpgE8JiORVn0VpebdlrYPVoAknzhAdjSpGQO3li9xADuPP1Y9wIfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntVaQ0QVhvT/fzUbB1G+pSBG68Dargkm3gsFDngwbsw=;
 b=nKdcP+kNE8rOU6JOFEBUXmTLxh/iJnyeE40ppZkzX02FLQ/0Ha6i5nAojFn+sYGG3WhUNWDRzMwtSWTFeJXe/7Ax0SR3A+FuCJhcDLjdHGsXk8qC0cbRSzpM37ZW54R+in6G3IsiAHruQjh8mFibVVKIBGu5bf35E+Aeu1IhaXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 15:59:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 15:59:44 +0000
Message-ID: <dd1094f9-439c-7ad0-4244-eff67774a4be@amd.com>
Date: Wed, 28 Sep 2022 11:59:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/1] drm/amdkfd: Track unified memory when switching
 xnack mode
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220927154348.20274-1-Philip.Yang@amd.com>
 <b3ad27b5-c101-3e73-cc30-fcb095587c62@amd.com>
 <a2efc2bd-59e9-2e15-40bc-4c0faadc9b01@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <a2efc2bd-59e9-2e15-40bc-4c0faadc9b01@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8e817b-704b-4858-bdf6-08daa16a7607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4rziZJczFJYaQvITu03wpvFo7i731qEc8CkjamMS7XFJAGUhLgDLaO/FKZ9CqUW8kzi0LjkOzf5zs48ptXZ+W0taERPITwZjP7u5SxrW//sifs1ojtUB9PkO93Bv6ARjY9exhiIEIz42XXm8JF4mz8Wi542kqE0Q2BEqO6Zjk/HJS5cMc49wZ7xQvN+5GAR2S/CPDUcaBzGDiO0nQ+j/BsXsVgaJ06ri6eQx8h892z6+5NZbM9kjry3zrIQpKo+CuN6yZZxznbfVgvyJs3JRy9mYDsTCVFSYpHdZEPO0JrZ3IjID/TaDlIMccFmL/w54DH6UICpLLePp/dKmUwqj5TSsqTizn91VaHbxKsa11PzqZ+oDbUlSUNWYLCl6vmO+JLpBnh8pwBnU4nZY9vgTENz1E3icGVtGXzyDdxoR9cNG0cqcGVZvWwYDPD9JuIQw1TNr/im6/LAnnG/zgKS8dOMT3ehdSJO3qClVPRlvH+l9O7CiYr+pfjmcaZQiKYmsGRAVUDHxdsu5AC4ijbQmFPfqQsHwjKSnaL+E/8MPbf2XlPHqxPMiu24jtcTG5r+z7mSJHXrhfFJHj221iyinSnDS7guxGHz8mJG5Hx731PD43bb8nmSxzWy/jVHw19aZ1Y36xdKR3A5myXocacsBPzCzRkyxLuRjP1tNI+tODVdSHlW42U7o8W2ZfOzecSyu/Dm0VzRMFwXvP+6J5z2IyiS2Up8FSsJGih8poxvWeB3nsKi3InOcJGpr6wDhFRi72kmT01bEbuhz9MIa+HfV0rxXAAAB7IlVKIOfqKX/MI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(83380400001)(8936002)(8676002)(66476007)(66556008)(66946007)(31686004)(6486002)(478600001)(186003)(110136005)(2616005)(316002)(6512007)(38100700002)(41300700001)(26005)(36756003)(2906002)(44832011)(31696002)(86362001)(5660300002)(53546011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVlLb0wvSVVzcHYzVHJkd293MkZuSFQ4bEprR2VrWVZMTjVmd3lzM0xwUm53?=
 =?utf-8?B?c3NvaDEvRDE3SUkwd0RQWngrSlR2bDVyaHJ3aGh2SVBhZ2F5L2VjMXBjdlNC?=
 =?utf-8?B?UFhraENzdk9HcTV4Q0g2MHJsU2IrVWUveERwenI4Y3FiRGFSalFlZ29TYUJO?=
 =?utf-8?B?SGtsNlArbExOblk4bWxIeTZGTm9MbjdoaTI5R2FLV0JGblV4eDVqb1l0cE5h?=
 =?utf-8?B?em5EZHZtWGJtV0tPdWptMHpaT25mOG93L2hWSEt0MythV1pKZXduSmFPRjgx?=
 =?utf-8?B?QXduNW9NMy9Kc0hBRnFWWW03dHhQM01veU5lcEI4M2dVZkVLcjNLazhpYWdX?=
 =?utf-8?B?UUJaK3RQSkJSSzBWVnZqbXlPOUNLdXhST29ycnh5TW92NFlySzhkdFljaFd3?=
 =?utf-8?B?ZUI3VURROGdyNmFrLy9rMkloeVh2eW1wWGJoM0NCaFp5a2ZjRGtUTFdLU3VT?=
 =?utf-8?B?eGlZcDU3OERSWHdtNmMwZCtkWFUwSHVtZ29CcXFVOUdrOWZDYmlSNUFNL0oz?=
 =?utf-8?B?cVNzY2lSY0ZkZXNIcVdUZnZOb3dJNm1menVHNUd0UnBwd2s5dW0xRE1kNEkw?=
 =?utf-8?B?WGhicysyYUZaWWxBV24yOW9LYVp4RzB5K0FMeEc3bjExWHRoSHBmMHdaYU5k?=
 =?utf-8?B?NThva3ZqSmY0cnA5V2pHeC9ucUdJemNQRnNja1BLZHA2MGFDY3dqNENwaGpz?=
 =?utf-8?B?NmZhVHpJcVdKOHRuWkNYTWZCbXdJaWRjdlVyZzkyUGY4TDY2SDlwQTh0UkVu?=
 =?utf-8?B?blhBbTZieDhqMGkvMnBrN0JaQ0lBTUxJYkM0Sk1VeG54ZGhORjR0b1lPOHRE?=
 =?utf-8?B?d1hFTGxCWmdGbytTMGJiSzl3Rk9NeU96NzVjR3hDZmZDaE9zTVV5eS9vVUFM?=
 =?utf-8?B?U1ErM1A3bWNzVkpGWWl0V1NPb2N6aVUrZUxNcUplNEU2NXBxcTAzMWN1SmJ0?=
 =?utf-8?B?cWRCOUpDWU93MUlEM3BhTTJ1NS8xTXExc1ZCWVZ4bnovNXp2bitEWEwwbG1Z?=
 =?utf-8?B?eVhIZSt2T0Q3M2kranYvUHM2T2FDNHR3QlJCa0g0S0pNcHpNMlNXQzR1WGky?=
 =?utf-8?B?YVQxNXgyYkU0QTg5ZEhZK3VOVDNVZ0t3ZFNpY2kxZHVxV25xVFl5ZnkxL2lW?=
 =?utf-8?B?TmhDTTJnb0JSdG9oMTk4bWhzd2YxOE05QXNVMnBkZThpSkJDeDlMaXFhQlZw?=
 =?utf-8?B?OXZMeVMzTHNsNXI3TDdqVlZRS0p2c05kUmwwUDI2WGFEam5oOGdiaThkZ2Rh?=
 =?utf-8?B?eWFPNGRlL0Ntc2tpUDJNVFU1dm93c0FDeWJFajZoOS95UXhiQkw5bGZkMjdL?=
 =?utf-8?B?WVlld1IveTN6cE10UU1zdVFwMFIrcDFwMEFQZ3pTbHRuYjNKSlFLelgrWUxV?=
 =?utf-8?B?WnY0MzBhUjBzNWdwdHVtdDRNaWwwQ3YydmJRbmFUcCsxWGJJTHc3RGMzL01z?=
 =?utf-8?B?clV5dTI3RWJPT0owSVJWS2YwTVlaRXpkaWdmaDRzKzJRTVlWMW1XbEZ4d0s1?=
 =?utf-8?B?L204cFZvTExJakF5bnE4Q1dKN3d6TUJiUG1SN3B1bWJ2NzcyUlg0RTRCc2Ez?=
 =?utf-8?B?RkoyM0gyQkFJeEJUT3REYVptUHlMOHF6blNxQmxqVk1qcHRrNDZpOWRmSkYv?=
 =?utf-8?B?UzhZcTg3NllDSjVjZU9BWkR1K2dreThrWFJ4L0kva3lTNVExSkhLWHZMRVFI?=
 =?utf-8?B?dm1PYnJvLzI0bXpZTXpIQS9GQmJNK2JsazNXZFl0eFFlNmhPa2JIN0hsZjhF?=
 =?utf-8?B?UEV2S3h1UmNOQ2k2cFQ2MGxROVg3eUZoUHVNemNreUpnU2hoZUN4MnAwd1l0?=
 =?utf-8?B?TjFlcGZsN0lwU3dlR1VPUjN1bXAvUzZYNkhyOU8vcWhzNVBrZE9KOGZhSDYw?=
 =?utf-8?B?dFFHMnIrWXROSlY3UkZFS3cwS2VOa2U0NFhQUDJMWm1GbnQxUGtWNnFSeUJO?=
 =?utf-8?B?c2FOSWhxbjR3OXBpSWxWRGJ3YzR3djYwbmJhQWhpc1REaldjYTBkODZjaWZC?=
 =?utf-8?B?cWZWSUhsRjRSZUlBNDE4Sm54SmpDdnl5cHlPOEVwcWpuUnVtUWZlTExsS2RB?=
 =?utf-8?B?Q3U0N0RSRStZdU5pU3ZjcmtaQy82bU1na1BLZ0o5ZUwrZ1p0N0pka2FKWENn?=
 =?utf-8?Q?DNUWPH8Np4uofWUnGL7fPBFre?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8e817b-704b-4858-bdf6-08daa16a7607
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 15:59:44.7045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uc3cmxQe401vdO+4H3BwDcH1qDKdVffJa39/wFcB7QtsJ1V/f/AcQG1Scs7fmGMnt0hV8tjsmREOMG76eYBcSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
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

Am 2022-09-28 um 11:55 schrieb Philip Yang:
>
> On 2022-09-27 14:58, Felix Kuehling wrote:
>> Am 2022-09-27 um 11:43 schrieb Philip Yang:
>>> Unified memory usage with xnack off is tracked to avoid oversubscribe
>>> system memory, with xnack on, we don't track unified memory usage to
>>> allow memory oversubscribe. When switching xnack mode from off to on,
>>> subsequent free ranges allocated with xnack off will not unreserve
>>> memory. When switching xnack mode from on to off, subsequent free 
>>> ranges
>>> allocated with xnack on will unreserve memory. Both cases cause memory
>>> accounting unbalanced.
>>>
>>> When switching xnack mode from on to off, need reserve already 
>>> allocated
>>> svm range memory. When switching xnack mode from off to on, need
>>> unreserve already allocated svm range memory.
>>>
>>> v4: Handle reservation memory failure
>>> v3: Handle switching xnack mode race with svm_range_deferred_list_work
>>> v2: Handle both switching xnack from on to off and from off to on cases
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 ++++++++++----
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 44 
>>> +++++++++++++++++++++++-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 +-
>>>   3 files changed, 64 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 56f7307c21d2..5feaba6a77de 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1584,6 +1584,8 @@ static int kfd_ioctl_smi_events(struct file 
>>> *filep,
>>>       return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>>>   }
>>>   +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>>> +
>>>   static int kfd_ioctl_set_xnack_mode(struct file *filep,
>>>                       struct kfd_process *p, void *data)
>>>   {
>>> @@ -1594,22 +1596,29 @@ static int kfd_ioctl_set_xnack_mode(struct 
>>> file *filep,
>>>       if (args->xnack_enabled >= 0) {
>>>           if (!list_empty(&p->pqm.queues)) {
>>>               pr_debug("Process has user queues running\n");
>>> -            mutex_unlock(&p->mutex);
>>> -            return -EBUSY;
>>> +            r = -EBUSY;
>>> +            goto out_unlock;
>>>           }
>>> -        if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
>>> +
>>> +        if (p->xnack_enabled == args->xnack_enabled)
>>> +            goto out_unlock;
>>> +
>>> +        if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
>>>               r = -EPERM;
>>> -        else
>>> -            p->xnack_enabled = args->xnack_enabled;
>>> +            goto out_unlock;
>>> +        }
>>> +
>>> +        r = svm_range_switch_xnack_reserve_mem(p, 
>>> args->xnack_enabled);
>>>       } else {
>>>           args->xnack_enabled = p->xnack_enabled;
>>>       }
>>> +
>>> +out_unlock:
>>>       mutex_unlock(&p->mutex);
>>>         return r;
>>>   }
>>>   -#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>>>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process 
>>> *p, void *data)
>>>   {
>>>       struct kfd_ioctl_svm_args *args = data;
>>> @@ -1629,6 +1638,11 @@ static int kfd_ioctl_svm(struct file *filep, 
>>> struct kfd_process *p, void *data)
>>>       return r;
>>>   }
>>>   #else
>>> +static int kfd_ioctl_set_xnack_mode(struct file *filep,
>>> +                    struct kfd_process *p, void *data)
>>> +{
>>> +    return -EPERM;
>>> +}
>>>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process 
>>> *p, void *data)
>>>   {
>>>       return -EPERM;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index cf5b4005534c..13d2867faa0c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -278,7 +278,7 @@ static void svm_range_free(struct svm_range 
>>> *prange, bool update_mem_usage)
>>>       svm_range_free_dma_mappings(prange);
>>>         if (update_mem_usage && !p->xnack_enabled) {
>>> -        pr_debug("unreserve mem limit: %lld\n", size);
>>> +        pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, 
>>> size);
>>>           amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>>>                       KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>>>       }
>>> @@ -2956,6 +2956,48 @@ svm_range_restore_pages(struct amdgpu_device 
>>> *adev, unsigned int pasid,
>>>       return r;
>>>   }
>>>   +int
>>> +svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool 
>>> xnack_enabled)
>>> +{
>>> +    struct svm_range *prange;
>>> +    uint64_t reserved_size = 0;
>>> +    uint64_t size;
>>> +    int r = 0;
>>> +
>>> +    pr_debug("switching xnack from %d to %d\n", p->xnack_enabled, 
>>> xnack_enabled);
>>> +
>>> +    mutex_lock(&p->svms.lock);
>>> +
>>> +    /* Change xnack mode must be inside svms lock, to avoid race with
>>> +     * svm_range_deferred_list_work unreserve memory in parallel.
>>> +     */
>>> +    p->xnack_enabled = xnack_enabled;
>>
>> This should only be set on a successful return.
>>
>>
>>> +
>>> +    list_for_each_entry(prange, &p->svms.list, list) {
>>> +        size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>>> +        pr_debug("svms 0x%p %s prange 0x%p size 0x%llx\n", &p->svms,
>>> +             xnack_enabled ? "unreserve" : "reserve", prange, size);
>>> +
>>> +        if (xnack_enabled) {
>>> +            amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>>> +        } else {
>>> +            r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
>>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>>> +            if (r)
>>> +                break;
>>> +            reserved_size += size;
>>> +        }
>>> +    }
>>> +
>>> +    if (r)
>>> +        amdgpu_amdkfd_unreserve_mem_limit(NULL, reserved_size,
>>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>>> +
>>> +    mutex_unlock(&p->svms.lock);
>>> +    return r;
>>> +}
>>> +
>>>   void svm_range_list_fini(struct kfd_process *p)
>>>   {
>>>       struct svm_range *prange;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> index 012c53729516..e58690376e17 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> @@ -203,11 +203,11 @@ void svm_range_list_lock_and_flush_work(struct 
>>> svm_range_list *svms, struct mm_s
>>>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>>>     void svm_range_set_max_pages(struct amdgpu_device *adev);
>>> +int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool 
>>> xnack_enabled);
>>>     #else
>>>     struct kfd_process;
>>> -
>> Unrelated whitespace change.
>>
>> With these two issues fixed, this patch is
>
> Thanks for the review. I realize we should handle prange->child_list 
> when switching xnack mode and reserve memory too

Alternatively, you could flush the deferred work before doing the memory 
accounting. Maybe that would be a more general solution.

Sounds like there are some more interesting changes happening to your 
patch. In that case I'd like to review the final version.

Thanks,
   Felix


> , as there is a small change in sys/kernel/debug/kfd/mem_limit after 
> overnight test. I will fix this and the two issues you pointed out, 
> then push the patch.
>
> Regards,
>
> Philip
>
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>>
>>>   static inline int svm_range_list_init(struct kfd_process *p)
>>>   {
>>>       return 0;
>>
