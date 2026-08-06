Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7F1C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 07:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD89710F0ED;
	Thu,  6 Aug 2026 07:45:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5d+Jp2/z";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3883C10F0ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 07:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHCBLqSbEg0umSi/TZxEKCt0xZreS0qIgi/ISeiDcIwdPKDci5dcMb723uvWReytyMDTdTiJaKZz38Wrtl8jSRM2cNIgQZSIchJg1GEEiJmWqZSkBj4jjhS0aiTZV7RZ7X0uPEVFzurmm9cYNCcMCFEJ2sWpb1IGFwVEvy1gz6zfYDSLGwOj/nIViVgZtlhJAuGl7rAEVSHY39gN4otbrxxE7cx0bryC9lXBsE996pYWGB/YPDMAVbSN4btIKpFMy4Gen1+mAJHF5Mwqhi5BO8dddixP5oPKNVFMKEowQIjxXqnyQ9uU8IFQrnrCB12ifJmcHdLJvO6UlWzd0A/gfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co3pPELHLXPybgIBDGUidDc86d8Fk1c+2ahR7aEKUaU=;
 b=FQiEBNQGmeevdU1Nj3CBlrmUZMru7KXoVcTtmBIsIgWvY+zUyoEKGnY971P/oKa8MGNy4CQ3tF58Qkb8PmTK+o+/raZ4uEIKTlstzcnaLW6yc5hntHtAk4yeEurom/dOrZVe8KCVl35CKAO3kh3THVH4hbdi0duMmpF8hCA8bN4geWnW7xeg5ao6CbGPHDYVMnSByLTOyZNJuOW801+436QfdJQBeh6I+RjAs5hS8IBrqyrVhRP/l8eRMvUeZdaXosnAS335OcObjGdRVchmjzrSZa85KlIfQ9RPM9n1IFBTTNDPZ80SXKRtgcIYGTyRt0HQdstS2BmQd+s38tiAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co3pPELHLXPybgIBDGUidDc86d8Fk1c+2ahR7aEKUaU=;
 b=5d+Jp2/z+LCh16bjYVeR+qy2svh1TFZKpk4QNFeDHFP54yu2uhK58ljAh1Y9UBckB5vjPtJCQLrlVjQc+ZjZbxrvWS5776qrOieZKPYRV82jrd7CWN5/M049VIG0rEb30/Pdd1dKkgPJJn6iM88fAE7GZGOoOieLCT0UbvTlt8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 07:45:06 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 07:45:05 +0000
Content-Type: multipart/alternative;
 boundary="------------dY0NZMvX3J0hjl8NK3PTzS91"
Message-ID: <8987dfbe-65f5-4652-adf6-710269d85a08@amd.com>
Date: Thu, 6 Aug 2026 15:44:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: ensure all userq VAs mapped before restore
To: "Khatri, Sunil" <sukhatri@amd.com>, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260723082334.606456-1-lingshan.zhu@amd.com>
 <c2a5fb47-d8b8-44c3-ab16-3538e7925fc8@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <c2a5fb47-d8b8-44c3-ab16-3538e7925fc8@amd.com>
X-ClientProxiedBy: TPYP295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::12) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 1716b1aa-3ec4-4b2a-d484-08def38ea173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|8096899003|4143699003|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bAcSaHBODPavfwoT1guztGE4ifrUVepJ1FTPUlKtITQxGdFv4qbZsEDzLCp7oBxCartkuemeNQnDgzdYAoV/uoq5nfhLZMKxm4PVlOKF5tqTP5oWw9QQrtNUzde2bg+8FwUADI/6poZ7+WMHBZ4DKmeB4hQhw2ipAMooGRvKSvPN7t+ePQ2Z3+eDLBD4hC1BZqqBVeof6GUsDQm485qZG+rI9FnBdMsEN3uyK5Nm8uQXPErABs0oT6QI0gKZ7yATdZRuej6Wz3ZbttAAL1Z+klhNcH29DCgDk/avKzSqWqTuqcRQQosaoH5uZlxbJqkaM+8FMx3OO1+2GnhLIVk7Mn2Swaed5IXTHOXM3OAYspcBqskE+k0D+bJMJZo/SYkC0Pl6zAieSAwhv8Z0nshJkHj4IvfWzX0vz/l8eHQMT7FD86CuohUnpW2xpyFVSLO25T03UVi6bNG10Npx0M8S9jYIUs6oDJ7TuBzHsTVJmPCOlAg2vi5TaUFeUI+Zvw064bHLLXwwTg+sAF2rLK4q1CnH0e0F+xBwsSrsBRBY7J/JLqG5j3hnOSn8i6/dT4VlGEjPj02QwVMySxb/8WwSyWWQrbOqWynt0vbiliOXSjnjq/kZ+4htRuumBKN+1vwDp7fQsHx7N9P3B/OkMvlijKemFu2FzexJ/cxv8ge8s4I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(8096899003)(4143699003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkJ3MW5CWmpNSCtISVBicFNDaGhTdnlmNllJdWU0SVJ0L3JGeDNOb2FlenZx?=
 =?utf-8?B?Q3RJdGt6cG93QU90aXZDQ3BHRnpBcmNvRXltalJHR3NheDZ4WUc4T1RBQWJO?=
 =?utf-8?B?V2ZGU3k0Uk9Id0NLZGR4cWxsVkNLektXblh6dHpJUi9jaXhYZTdxOG1vVWlu?=
 =?utf-8?B?d3JqaW9FVHdBQVU0NnNsVGZPMDlySWRkcXAzOVlmaStPajZ5bFg2b2x2NGI2?=
 =?utf-8?B?endBM012WlhxbmRSdnMrdXdYVnBpQjRIUmdjT2tseGo1OGJOdmJFQ29NYnRH?=
 =?utf-8?B?WHJWWlBkblZ4YVUvbE1pa3liclphMmZNOUVwV2g2MHFaVW1vNG43b0dlMlIz?=
 =?utf-8?B?aEhmYURKaGR5WXppUDdzUEtURVk1T2dra3RUK2JNSHVrM2FrbmtEd3pueWNu?=
 =?utf-8?B?b2pIYjVYM2dGTWhUU2pQcFlvRURaOE45SGRRNTNRSGFYRTJLTlEwRkFWV2M5?=
 =?utf-8?B?Yk1sclhEUXVkdUwzR0ZGazVaSk5YbDMxam0yVjFkak9jeG5pQmNCaUlSaGJ6?=
 =?utf-8?B?VlRiY1VPU1NwdDV1MzhVMnNJbXlqNnlYcHU0Q1lURUdpNXlxcWZvQWNhUVd3?=
 =?utf-8?B?Z2M3QzFXNHgyamVkU2VZd3dOV0pGTTZhemppaGUyc3JDWDkrbktXWVBvZFF1?=
 =?utf-8?B?VHZzUGkvUTA3Q3RCY2VkN0RKMDBKY2JLbENCL1JKNHViM2ZLam1TS2JURDZn?=
 =?utf-8?B?S1lTVW9VOVRUZENyenBEWS8zT2hiRVlvdjhPZE4xaXRsZENqOWgyTVRFdDNC?=
 =?utf-8?B?UWFWZjRmTVhCOTZkQkZvUFZSMUhaUnhTZ3A5QVlKVldrODNtQ25pZHluYnBo?=
 =?utf-8?B?RVhuTmllUks4OHNaZjBiREZibTVjMFEwZm5WMyswWHlZdllsUG8zaDlJRVF0?=
 =?utf-8?B?b3BWOUQzamVQSTdHeVplN0xTZlFnNVJhRDBhWnpnWXFjSzBqYUg3Y0RxRkVV?=
 =?utf-8?B?Qy9qaCtHbzkwYWZ3RnliZUFhVEh0TzFFTVJvKzV1cXpPdDAzT2Z6dUxGRzdT?=
 =?utf-8?B?ZFVad05kOG5tdXVRU3g3Yi9hZEh3STNadWRSbGY1V2RXV1pIc1UvVVp6V0FF?=
 =?utf-8?B?UEhuTDJNR0ZCck1JWjhGYkswdTVsZ3pGRVVUWWNlUm5VMFpzdEtwY1ozUWt5?=
 =?utf-8?B?ckdCM3diTDA1TWxYdE5aR2pBS3dKRms0cUFTeWMyY05jeTZiY2gyY0dSbVAz?=
 =?utf-8?B?bXllQnBHbFB6U1ZiZEJzai9jbmhub1AxbFdSSUlld3JoUG9ueDNscUpHUVgz?=
 =?utf-8?B?TTB4elZHUjNFcE9GckczYnZDQjM5Znh4cmk2ZEtrMDBmYmJoVmgvcVlXK01R?=
 =?utf-8?B?aGJjYzFGeEp6d2dHWUFQSS9aTy8zc2N0WElWb0ZSeWlQQUhBL0d6VzdMRU03?=
 =?utf-8?B?U2dOMXVEaXU4ekEzUFU4cmtnZGFzd3pNU1JtcWN5c01iWmlUTXFuVE9yck10?=
 =?utf-8?B?NlErS2cxbm0wV0ozOG5iVjdnVEQwS2tSTUZxZk5TbnlUWmNaa2ZkclBpWitp?=
 =?utf-8?B?RHlYbTBQY0swWWtEQzJETzQwKzBEWU5MUGt2Y2RETnBPalF5Nm1pTTlRTVho?=
 =?utf-8?B?V0c4dzdkbnVoY1I3Yi9nNnB5aHY5cFhnUkhWZkJQKzVrdnNFK3Erb0V2dWNC?=
 =?utf-8?B?UVRiYzZ0VkcwUThKRjNxWTF2UXAzdnNzYk9IbzlJNnMrTjlDZElSOC8rREx5?=
 =?utf-8?B?SmRPMnNrNFE1dkNpV05WclBhUUpCS0VlZzNaRXFhR0hXb0tVYnVHNmFvbG82?=
 =?utf-8?B?L2VKcit5MWg3K1c1ZVkrOGhURSt1VTNYSTE5R2syR2tHZVhLUnFTcFAxQUVS?=
 =?utf-8?B?c2NsY2FwK2hoa2dxSVg1L1RQUVNyb3ZmYWRLbTd0UjJiMFBHWC85SzBQbXRP?=
 =?utf-8?B?aDNQQTc5MzM1UEVSa0N1M3Bud3czM2hyYzY0YmZjMVhmaVRPMFdvcjNETndO?=
 =?utf-8?B?RGVGVnlzV0c1UStpempNemd4U2doN2g0QTVia1BxTzRSUWlDenlrVXFDc2ZG?=
 =?utf-8?B?VUJ4UUdhaDRuMzBLRGZvajlMd0VPN0d5SmNseTFza0ZsKy9yWmtoSTgvWk53?=
 =?utf-8?B?ekV5VjJtVU5qdFVDTVdBdkJnd1oxcFUwRXJVRmswSjJwSk5LK2lXZXlWK1l3?=
 =?utf-8?B?VTI4UGVRRFo4K2dGWlo0NmxYYTk2U2laV2ZZL0pSUGxtU1RUTENpYTZZQTcx?=
 =?utf-8?B?VWFoL1Roby93WkdJVWFEWW14UmNXYjBKcFQ5dkF2NzRjb1JlcFk2Y0NBWGRO?=
 =?utf-8?B?MnJjYVlZUWRTckNJMDhQUTVaYnIxK05BeEhHczF0ZlpWeVljYTlzdW5RZnoy?=
 =?utf-8?Q?NZo5UtQ5UR2EWiubdp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1716b1aa-3ec4-4b2a-d484-08def38ea173
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:45:05.5928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGQjK72vqsLgMVB17QZ70TUIfpenXcm4amUNkEzJkbbKc2yJK/Vp87zSjAH9Jsj42mRjBmJyeAhEQ4CELgTEkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213
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

--------------dY0NZMvX3J0hjl8NK3PTzS91
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ping Christian and Alex

I may still need the maintainer's comments to merge this patch.

Thanks
Lingshan

On 7/23/2026 7:17 PM, Khatri, Sunil wrote:

> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
>
> On 23-07-2026 01:53 pm, Zhu Lingshan wrote:
>> amdgpu_userq_buffer_vas_mapped() checks whether all VAs
>> of a queue are mapped before restoring it.
>> So that HW won't access any invalid addresses.
>>
>> Currently, this function assumes all VAs are mapped if
>> any VA of a queue has been mapped, which is wrong.
>>
>> This commit fixes this problem by examining all VAs of
>> a queue and reporting false if any of them is not mapped.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 3fe10d6af757..2b3cb4ec4835 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -280,22 +280,24 @@ static bool
>> amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>>     static bool amdgpu_userq_buffer_vas_mapped(struct
>> amdgpu_usermode_queue *queue)
>>   {
>> -    int i, r = 0;
>> +    int i;
>> +    bool mapped;
>>         for (i = 0; i < ARRAY_SIZE(queue->userq_vas.va_array); i++) {
>>           if (!queue->userq_vas.va_array[i])
>>               continue;
>> -        r += amdgpu_userq_buffer_va_mapped(queue->vm,
>> +
>> +        mapped = amdgpu_userq_buffer_va_mapped(queue->vm,
>>                              queue->userq_vas.va_array[i]);
>>           dev_dbg(queue->userq_mgr->adev->dev,
>>               "validate the userq mapping:%p va:%llx r:%d\n",
>> -            queue, queue->userq_vas.va_array[i], r);
>> -    }
>> +            queue, queue->userq_vas.va_array[i], mapped);
>>   -    if (r != 0)
>> -        return true;
>> +        if (!mapped)
>> +            return false;
>> +    }
>>   -    return false;
>> +    return true;
>>   }
>>     
--------------dY0NZMvX3J0hjl8NK3PTzS91
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>Ping Christian and Alex

I may still need the maintainer's comments to merge this patch.

Thanks
Lingshan

On 7/23/2026 7:17 PM, Khatri, Sunil wrote:
</pre>
    <blockquote type="cite" cite="mid:c2a5fb47-d8b8-44c3-ab16-3538e7925fc8@amd.com">Reviewed-by:
      Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
      <br>
      <br>
      On 23-07-2026 01:53 pm, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">amdgpu_userq_buffer_vas_mapped() checks
        whether all VAs
        <br>
        of a queue are mapped before restoring it.
        <br>
        So that HW won't access any invalid addresses.
        <br>
        <br>
        Currently, this function assumes all VAs are mapped if
        <br>
        any VA of a queue has been mapped, which is wrong.
        <br>
        <br>
        This commit fixes this problem by examining all VAs of
        <br>
        a queue and reporting false if any of them is not mapped.
        <br>
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16
        +++++++++-------
        <br>
        &nbsp; 1 file changed, 9 insertions(+), 7 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
        <br>
        index 3fe10d6af757..2b3cb4ec4835 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
        <br>
        @@ -280,22 +280,24 @@ static bool
        amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
        <br>
        &nbsp; &nbsp; static bool amdgpu_userq_buffer_vas_mapped(struct
        amdgpu_usermode_queue *queue)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; int i, r = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; int i;
        <br>
        +&nbsp;&nbsp;&nbsp; bool mapped;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
        ARRAY_SIZE(queue-&gt;userq_vas.va_array); i++) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!queue-&gt;userq_vas.va_array[i])
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r += amdgpu_userq_buffer_va_mapped(queue-&gt;vm,
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapped = amdgpu_userq_buffer_va_mapped(queue-&gt;vm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue-&gt;userq_vas.va_array[i]);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(queue-&gt;userq_mgr-&gt;adev-&gt;dev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;validate the userq mapping:%p va:%llx r:%d\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue, queue-&gt;userq_vas.va_array[i], r);
        <br>
        -&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue, queue-&gt;userq_vas.va_array[i], mapped);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (r != 0)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mapped)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; return false;
        <br>
        +&nbsp;&nbsp;&nbsp; return true;
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; </blockquote>
    </blockquote>
  </body>
</html>

--------------dY0NZMvX3J0hjl8NK3PTzS91--
