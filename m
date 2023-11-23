Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EE3C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 20:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79DE10E353;
	Thu, 23 Nov 2023 20:32:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C6310E353
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 20:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqNfrl0bC8dnPpc14ZxrXz2cZBoVoE7KdLmU0El/MDi1NmcerDzaMuhUKLMnpD/PMkb0XO+bqet3ezWu4KvOsFt+2eFY4wL9OdMrvgBvp9iZW7yHNcRvle3ahlC5mOCXEfDFC0ohGVAqZ1aW1qe9fBGYDu3FKnDYaUqlvMpzM6oYkS+QWr2PHa5QNOVCKDJ4bo5u+VsVMpGIOspZ+8lmsV9ZuXe+UsdlzaU3WG5qaZDz3CwrEvQpuVtwB3bUlPawK4UOhMv6U34vIQUT4pbjze6z0wME/F7J82hQMva4sxu3ipMSiQLfiJvHd5wi+qcMkcVNW1KUctvhbpa9jB0ZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9GxRuAafmYI5cZbGDMpkhBTVaXL4FSwTjWpxkKsfsk=;
 b=RYf2KeIZners+GLfU6n/Y/EbP1BOczwt5nUS0kqvU9WXFmVvoNCSOTNoTp8Av0nOiz9Mddd9ky69N3CO64hXQu9+vURZD/4bf6KJeIw6v6akBe72HMsfQuLV3fo32I+mpS6IwkFthcBwJ+EcEJGUxI+7+yq5HIu8XITrWInhyW1bZ1GtiDWeoc4Xo2/ObHVYL4Z96eLaTMfjV/hYD6+wFcpXmGZp3W55re+HcdoIk1sEeRHKByPR1S4h/5/O5B4PKdh73DWg9xoSTXYPNRkqUyIsGOmQ/qgdUuAqjkgcevHa6O17FePcEC/52P6yE/nhRNSThHLvYEZhgjPiWDTGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9GxRuAafmYI5cZbGDMpkhBTVaXL4FSwTjWpxkKsfsk=;
 b=0TK7bRotSHeCXhWWr0xKMbOyb84pwMNh7ObwrqikMrnNe9uugNeMkaUc3yEoI2OSq4F2A8/ozdmiusO0hJ0uW2nG8+2L5Xn0ZuHVIrfArTysRcnTNK1iAlPrqOsnAr2XFr9Fjf7A1FFWATfzwPXe0F2yXSwmDjnHQsoyjISDVSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 20:32:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 20:32:47 +0000
Message-ID: <fb7eb2e0-12f3-4a4b-b721-d68856568c02@amd.com>
Date: Thu, 23 Nov 2023 15:32:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] drm/amdkfd: check pcs_enrty valid
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-8-James.Zhu@amd.com>
 <8a4a1994-f92c-407d-8e12-4466b27ca53f@amd.com>
 <3fc881ee-06c5-4b67-bc0e-a19da4f1919c@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <3fc881ee-06c5-4b67-bc0e-a19da4f1919c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 874ca8bd-26ef-4058-da98-08dbec635af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4OhR4dbJbZIY+TA4P0rDZBQAj29xTjelhXrRTBldUCcpk2j9qCdTVHdnM5T2yn41/TNXRK1gw/Q9dgo6A1eUZy/oM53oUCQrtCsoOWP2HrhIyVpsjGZ2lL7zYXJoppD26cnKO+VnTnVx/yh9gxirQKsBBtvO3GHoZ9/uFEQL/KhMi4DenFS95Kp0QE0uqyArMgdJhnP+E0YAMKgVj6EWoBAZJEgixae8YU2Q5Md/iBQTo2EqWwswgWVWFKJwFhAx8Fna+/dyumt6H6rjllE/wUq91VdKCwEPnmjdeRvDk8lhTmF4M9gDy4/dHS49/wPPo/RmlSfND9Y3jQBngJICbJYCeOAhJxIQV1HAF0A8nm9wUqmAanwZI87zHdSz/mvYz+7ZsG1bJOQ7D/TQAYsjZMH9z3iObxiJk8fxqYE6DyBRnFjDBWyNvwaZBYeVQIuFH67OXzfvKHigPO7yOWuWUXH6+lEOtRN+Ie9hbVsM6kffWRE5l7O9T/nJW5HZQIybRHpbLs7Q7YUcZh10p0Im0WzV2Jeh8ZQyf8NsJnbCso6ok1sSjzbVJLFxkTnDFg7TuFHPThvFBrVO8ohvHO9jzqTfe2lYBCQbw2eZrwyUSA/i9qhKPiYKHF37GBOW03Yi7r5+Pl6K4f05a+7KbodfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(66946007)(66476007)(110136005)(36756003)(38100700002)(66556008)(31696002)(86362001)(6506007)(83380400001)(26005)(6512007)(53546011)(36916002)(2616005)(478600001)(41300700001)(4001150100001)(2906002)(6486002)(316002)(4326008)(8676002)(8936002)(5660300002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXRKZWxONm1sN3BvOGJnY1NINkd1bDRLZExMalFsVUllOVdhbUNJQndWUWIr?=
 =?utf-8?B?c3JYNHJ5SkNSaTkzWkxEdlVtdlA4bHFIS0xNdXR2MDV2Y3pyWEJISXREV0E0?=
 =?utf-8?B?TCttYzFlU1hISXpXS0pPeXBiNktwZGI2bkFqTlJ4c3ZmWFp6THFUUUFWK1Y2?=
 =?utf-8?B?NVhCbDBIV2IwbXhtMUYyZFd5TzNHbGVNRmU0YUtVS1RnTHByMGFQdi9BNnpn?=
 =?utf-8?B?TjRFNk8rb0dvbzlSYWtUdHlETmh6eFo5bjVxbCt4bWYwSHJIMnRLR2FRUm5O?=
 =?utf-8?B?NzRzdmRIeWxKbEpGRU11VkhlTVNLZmFTZytua0VPaGNqY056eVlMLzBMa1hk?=
 =?utf-8?B?WWdCclV0aXVUTkVRZm10VkF5WVlpei9vSytYak9yYUR0ZmdFUVZ5Q3JpVUpx?=
 =?utf-8?B?WVFiUUhqNmtkTGtCT1RpdEhWZWZGWGpsWmRHWFdQZ3RaUC9HMU5yNGxlcGFP?=
 =?utf-8?B?TXpWcDN3alJLWlhOMjVtVUUzSE91L2o4UHpFWlo4ZDBRWEd1Z1d4MXd3Rm9R?=
 =?utf-8?B?dXRYWmQ0TE1USUwxWDM0U0xEQjA0RVBkcmorR2x4dFBLUExmSHpTR1hFM2Zt?=
 =?utf-8?B?c1ZTWDJ0dWpPNTdJU3BzZm9ZMDJhc2N6THhRVk54SS95Qi9qb0lMMXlCRUZo?=
 =?utf-8?B?MnJaQWRhVEEyYWdzSm80WE9QYk53a0JJSmpzRnZFVjhSNnA4T1FpL1NPME50?=
 =?utf-8?B?NVdac28wa2dpL0gyVE9QbGN4MjduSHd2aURUeUdYVjhBWkEzQ0x3dklWeWFQ?=
 =?utf-8?B?N1JUbnFQTUt5UXV1aFFkKzBUVnZJWk5nOE9ja0dWUE4zaG1McVR4TGpaL1Q4?=
 =?utf-8?B?amNzSldXZHA5SUNQSWdpSFhHbTJuSW42UnRFeVJ5c29pTUhUNmI2NW1SUmxx?=
 =?utf-8?B?aEJ0WVdlRUhFN2lIU0pjYlVFQTA1NTFXUzFPamtlVWk0SkJmUzRTc25tN2hY?=
 =?utf-8?B?eGxRL1RGQlBEQ29GamVjbFRmWHI3cHhuaU1aM0pTdThiUEhvUkRnMGNtTEg1?=
 =?utf-8?B?K1lLWkZuRmdLVnpSOEdWSmZKY1U4dnhNY2U5WTdBODNQVGRnTnV2WjVJSG1o?=
 =?utf-8?B?YzgzbU9McDB3cmgzdGpvczNmeG00dmZwcGorT2s2U09FMGl1bGwyNlgzalMx?=
 =?utf-8?B?Zy9oaFZ0QUsydUo2ajA1eHAvcGVRZXdML1E3Y1pUUlZ4QnZjM0VQR2dXN1dO?=
 =?utf-8?B?WlUvQjhMcXBiM3BrT3lTOFBTMlg0ZWlOek1oSm1SRkhJTmNmS2JQQUdESENm?=
 =?utf-8?B?NFRpQnhxeWpJc3pJdytkRi9iRHVIQzc3SHE5VEwwWXFrT2t1VVJocFJJMzBK?=
 =?utf-8?B?NWNYSzJBd2o3V29GOUhBL1R5UWFDTnhsL1UveWtncHFMUmJBSEtBdE8wRG1w?=
 =?utf-8?B?dTVGOEtHQ0NYRHlqd04zeEgrM0g2MnNsVnpzUEZNdUJPSEtzcHJZbHRrSlNh?=
 =?utf-8?B?QmVkQmRKdVljaUVvSEtyaXRRN3U2QzJ3WHUrTEdrYnRneEJMb2d1RkcwMVBX?=
 =?utf-8?B?OXlySFJRcmhYVVUwVnAxalgyOUk3K3dBTFdYWWlZMCsxUGU1cXZXdFVIaTdL?=
 =?utf-8?B?M0NNUkZEdUdXY2VwNWxlNmJrNUw1QXNRNGZOemxiNDdvdnFHS3V3Nk9VbVdk?=
 =?utf-8?B?NUtiRTlWaXNVTXF5NWUzSS95SGljK3hQMW1WSHVYMXBQQXdab3Q1VGJZYjYw?=
 =?utf-8?B?T1lDaGVXdTBwYkgwZ2w3UU5VZGNSNk04NUFObUsrRE5Xa1dFb2hMWXprQlM3?=
 =?utf-8?B?ZWZOR3BIenVVR2thZlpDaVVpNjRicUw4dnRyNms4MnlBb09yeC9SRTI5Y0M3?=
 =?utf-8?B?WVdzalREMmFxUTM1Mll1OTdqY05Nc0g4MTNEU0V4Z0pvbVkyTGpjTHBTZVlR?=
 =?utf-8?B?Wno5NGRLUjBJN2t3UzcrMGxRK3IyOUw4RDdYL2M3dzFOTGN0MmZ0ZnovZUtt?=
 =?utf-8?B?aTMvVDJva2owRVBXTEtKQzNCRVZPMVljeUw4WncyVmFuaFBqUXdYWHpKZWtZ?=
 =?utf-8?B?WWRMS3VnY0J5RjhEaGw5V2xLd0JTSE9udTdlVVBzYnRKVnNHR0hteEUyTnR4?=
 =?utf-8?B?enJMY2pFTzJSVElIWGJpNjU0OTdFRG1ZTnY2TlJ2ZjBLdTRVSzNrZ2h0eFJu?=
 =?utf-8?Q?jr3AZ5Oik9fM7sDY35kPX/wa2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874ca8bd-26ef-4058-da98-08dbec635af9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 20:32:47.6663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkEMcKHe5SsjVrzfncrxVANwQAD/thftxL2VFK/54+oESWpcQ8bb17y3vM9R7Dx6NyRNd5xgWZaRIhxPPCHBUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
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
Cc: joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-23 15:18, James Zhu wrote:
>
> On 2023-11-22 17:15, Felix Kuehling wrote:
>>
>> On 2023-11-03 09:11, James Zhu wrote:
>>> Check pcs_enrty valid for pc sampling ioctl.
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 30 
>>> ++++++++++++++++++--
>>>   1 file changed, 27 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> index 4c9fc48e1a6a..36366c8847de 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>> @@ -179,6 +179,21 @@ static int kfd_pc_sample_destroy(struct 
>>> kfd_process_device *pdd, uint32_t trace_
>>>   int kfd_pc_sample(struct kfd_process_device *pdd,
>>>                       struct kfd_ioctl_pc_sample_args __user *args)
>>>   {
>>> +    struct pc_sampling_entry *pcs_entry;
>>> +
>>> +    if (args->op != KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES &&
>>> +        args->op != KFD_IOCTL_PCS_OP_CREATE) {
>>> +
>>> +        mutex_lock(&pdd->dev->pcs_data.mutex);
>>> +        pcs_entry = 
>>> idr_find(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
>>> +                args->trace_id);
>>> +        mutex_unlock(&pdd->dev->pcs_data.mutex);
>>
>> You need to keep holding the lock while the pcs_entry is still used. 
>> That includes any of the kfd_pc_sample_<op> functions below. 
>> Otherwise someone could free it concurrently. It would also simplify 
>> the ..._<op> functions, if they didn't have to worry about the 
>> locking themselves.
> [JZ] pcs_entry is only for this pc sampling process, which has 
> kfd_process->mutex protected here.

OK. That's not obvious. I'm also wary about depending too much on the 
big process lock. We will need to make that locking more granular soon, 
because it is causing performance issues with multi-threaded processes.

Regards,
   Felix


>>
>> Regards,
>>   Felix
>>
>>
>>> +
>>> +        if (!pcs_entry ||
>>> +            pcs_entry->pdd != pdd)
>>> +            return -EINVAL;
>>> +    }
>>> +
>>>       switch (args->op) {
>>>       case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
>>>           return kfd_pc_sample_query_cap(pdd, args);
>>> @@ -187,13 +202,22 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>>>           return kfd_pc_sample_create(pdd, args);
>>>         case KFD_IOCTL_PCS_OP_DESTROY:
>>> -        return kfd_pc_sample_destroy(pdd, args->trace_id);
>>> +        if (pcs_entry->enabled)
>>> +            return -EBUSY;
>>> +        else
>>> +            return kfd_pc_sample_destroy(pdd, args->trace_id);
>>>         case KFD_IOCTL_PCS_OP_START:
>>> -        return kfd_pc_sample_start(pdd);
>>> +        if (pcs_entry->enabled)
>>> +            return -EALREADY;
>>> +        else
>>> +            return kfd_pc_sample_start(pdd);
>>>         case KFD_IOCTL_PCS_OP_STOP:
>>> -        return kfd_pc_sample_stop(pdd);
>>> +        if (!pcs_entry->enabled)
>>> +            return -EALREADY;
>>> +        else
>>> +            return kfd_pc_sample_stop(pdd);
>>>       }
>>>         return -EINVAL;
