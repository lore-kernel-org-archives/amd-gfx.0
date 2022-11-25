Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD39C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 07:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A48DC10E23D;
	Fri, 25 Nov 2022 07:56:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A97A10E23D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 07:56:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WstX63M34E9MjGD0TIgXi++1IxOGTngEDVk+k4E8AGIhP2asecitQxtGPjMwAdR07Glkh0ir383UJq5WAYifqtMg3TH+DRU6WuwI211bTnS8ZcdAvxNKLE/tLX9O07uVcnSRTIvs+Uu9nwYkxn/sZzqBz+LuKKdxpDgtDgM9Y10yRteySGvng42H7KVLWKFufn7T5CeatJ5MVK+Bz6zOSNVXDFY0A8znA5NKyuM+8REQA/y8ZM1ujXdQA+Z6lwHPyzoCPLo3hWo4GfgF+QiByL3sU4Hc20ibCm4jTaUenGUYJz++bfLeGovEqEsuvMGg1477Xb59rn4TB86DnttN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOzzJzO1f5P8OHrA3oC/rPMr3P+UWsdRvuZg0vvWelM=;
 b=WFu0WkpEH7P/3uSh2I8RJI4wJqm5Y+MivQOdUJT2Z2ZPE2qDQQfuODCovxPWDUqlzlvPdyEDdxyHT4M4sYwB8S8K5dsFVz/jIJtfBvBRmNkDAd3SXByWOKEk8KENIuiMJVH6CCPzBfVeMzGjAClTLNs4p7FeT4HYqsx/JhfdCCA7Ih2vf3qTvWTfHSgTCxRhdLheyRAtwoCT2cSnieLgw7ZLpMt+cfpEivFBalltY3iqCmYrUP2YVUTl8ccBGJPWwf5SgjTGaVIk6BU7OXvXtlIL2VEaoqgeactaT8t6I7dINpUcrwlxyQIpscZiNndxNNmCakJnrIMK7xUWx7YT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOzzJzO1f5P8OHrA3oC/rPMr3P+UWsdRvuZg0vvWelM=;
 b=CjlN0ocmxtWZZ5luaw1Mji4k0ptJ2C5K/h23OqnbeUHKzMDIks/jWXEC4YE+bT+mTZOLpGjUeGeZEd/FsFXhPqpmooM1rgDW25j5XNEcjvB0T8Q0ksw9Id24OisUvD2RYOVvqj3e14mC/7alvHF7bCwkgnYOih6xffdcwcyGvnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 07:56:31 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5857.018; Fri, 25 Nov 2022
 07:56:31 +0000
Message-ID: <5319277f-5841-4051-2684-93b3a985197a@amd.com>
Date: Fri, 25 Nov 2022 02:56:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: Fix minmax error
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221124211956.264282-1-luben.tuikov@amd.com>
 <3333dfb6-cc7b-ff6b-e416-62c07cf62740@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <3333dfb6-cc7b-ff6b-e416-62c07cf62740@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::35) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e23e6b4-eda8-4d48-82da-08daceba90b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smlaZvp7zXTcGFcegTGU+wnxL6nwEpw9MiZBvPG8lTwRmTLLBH0sDk+0wAKHbMBcbtsBALJ+moFvddkbJ5dy2UF3HuS319ZrIn3tkSAXJUH7IaGz5LfRmH4tL6UpU24UPlL07sQJ/KUcPkccSCLQN9Yv6SMwpUJB6oijI8ekUI+b3S5ui5JPiKzzn3u1TBJRMdQwviQd0IC8f6Hqb+NAPPEOXor6eL9W9k0vBrMRRrT6QDwnqTZYUKkqS9Ug8Ax9Z9K457LAiMuQFmt2ywoF+CiMPieEt6TGpCd9pgWLBntBYNjOKyUVoRhTo/Bb5c5Gu1N1T/b+jDEY3dY0gXf+kkn1c5SYKvevj9xJKCPUm2MUaifHi6v9bICMPxF0iQIqHCulNMG05JsELDl205bjdJZK5t5gZvI8UhuX5IrXdT/ewwgQnc7ls7zkiWb2oLuPiCYMqgc+Bfiu3oIGt4Op6iQfzwl9HqdEJ5eG1kTXsnvhtS75azNDj5hvYn9tBF0Y/+Fqy5zj6Zp50RZrfSsO+uA6BelmTzBiHJh4/Zb7NWreD0LyVUsvk/zZowRPPLdI4kdu3x66GyWcZXilfr3v2ZmDGakHWzAahRydBmUXblHO02k1iTM+dfXg7gFsbwAYiDahjCHdYIb/UeATeBL3hpp+8/er/D6iCrkfBsi6+V7fOg/4M1V0ZY3O+knd8mSf6DGULweamDrC2wxlmj3vzRz6RxpVVXymtvVdR75cO2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(31686004)(2906002)(83380400001)(26005)(41300700001)(6512007)(6506007)(316002)(54906003)(110136005)(86362001)(31696002)(4001150100001)(186003)(2616005)(44832011)(36756003)(5660300002)(53546011)(8936002)(38100700002)(8676002)(66556008)(6486002)(66476007)(478600001)(66946007)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW1hT3loSG0rSTRFV0Z4UDBZcnMwdmdMbGNVcjMrVTN4Ynl0ZVBoMjhuZEo2?=
 =?utf-8?B?bDFCcnAwYm9rQWoxTE0rR1MvQWJFZnEzckJSMjZ1bzFKd0c3cWNycUltQUxo?=
 =?utf-8?B?VUdNUURRb1JaYUxZbmRUTzlXdGYvMkwyNDJPbmFuNTFnY0djbklwMFh0M1NX?=
 =?utf-8?B?cmtNY3lIeDZjZU0vYlYrMkxVOWp1WW9qYTJWaUp2a2k4Q2dMYjZURFAxbnJz?=
 =?utf-8?B?S2tWM09ibnBveU80RDJNcGIxeWFDV2I4OW9KdkpBSU14VUtDWVJxY1hZaUw5?=
 =?utf-8?B?UWpMOEpoTmlPU1k3T2wwbmFXVDhBZjFhUGxadVRzUFRBMHRiMEUzUFlzTGNr?=
 =?utf-8?B?dGRVWTFtZ0diNHVqcWQ1WkRGWTY1MkVtZE13R0xJYzhaYSs0VjFYOGZlQnU5?=
 =?utf-8?B?YkZQelRwMlNxck03KzBEVkVwR281T0lJb01IdGlROUVKQm1KbzFHMGtSa3o4?=
 =?utf-8?B?RjhNR3F1SWNlY0R5eldRWkJiRlRXeGlITlZLaW50ZlM5Q2dpb3hHeDlyRjlj?=
 =?utf-8?B?eGMveUNueFRyaHZEdWRKZksrdHgwRWtwZDRxY2J3cHRucEx4ZzZEK1NKTVRI?=
 =?utf-8?B?cURNMGZvZnU4cUN0cXpiWVFrRWhaN3luL21FSTVhNjg4M3hrZWtOSmNDRXJY?=
 =?utf-8?B?YjF1K3dNeVdGZXJnTkEybmpjVE43czdIKy9CR0ZIY005blBHRHBOaWVEY3lZ?=
 =?utf-8?B?WW1LWVdQVmNFcU5ITHhzTE82Qk4xYmMrL1dkUmdIdUtBK0E1V3FmK040Q0xZ?=
 =?utf-8?B?SjZpQ0k2SUJSZzNEVkgzb282RzlRZDZoUXc4a2R2bi9FcFI3MnR3c0RqVk5X?=
 =?utf-8?B?VjhiWC9FMENNQzZZbUFVM2ovNzFQdXFEZXgxZmhPRHlBRk0wVnYvSlkxa1RG?=
 =?utf-8?B?blNsVkZ5aWUrT2RPWUhKcmZZanY5U1JkUG1NemJremJMQ2diQUxnNVZRMjk4?=
 =?utf-8?B?WUo0Vk1WZEtQUFkwTGJGc2R4NVAvMmZ4WkZlMnBwUHpOcDBoYW9NcWZveHlO?=
 =?utf-8?B?Smt6VmIwWFhMSGVUQVVRdDdGVVBHUDBzbDRwMWRvVWF4OTRGK2ZvbTdDWmpU?=
 =?utf-8?B?eW5lck9UcXJ1NHJVZTdFdlFyWDd3eHY0dklKNUZtRnZadGxTZEFpdGdFZ200?=
 =?utf-8?B?TmdKTWJzNy9PSHZ6MGFyTk5HcEdoK0MyNXlHQ0hhMXYyTWZhMzFURFMxWjJQ?=
 =?utf-8?B?c0tKSDkvV3RqTEw3a1plbk01UHpCclRNVlF1aWp4WnA4b25YRTl0RWZ5eFJs?=
 =?utf-8?B?T0YwL290b25Va3hxcGJRamgxZTYwTGgyYzNYRk5wUHJWWW50Ym5HeHk5Ym4r?=
 =?utf-8?B?T2M1QUlvOTdKZ3NsNkN5NGxHNWJ1cHFLWHVwcTl4MEFqK200ald6UzlyZVBp?=
 =?utf-8?B?ZjgzL0kzaktVNVY5SmwxbkJXaWp3N2dXcWJFMXZrMDl6WCtMcXdxaDk5cmcx?=
 =?utf-8?B?cThpVHJicUdGdXp6aWdvZ3dPUlFuUWxMb2sxVVJSY0ZkS3dvOUxTU0dnQktO?=
 =?utf-8?B?UlM4YXJSckUvaTFJM1BDdktqem5rT09zN0tRcGJiWlduYS9JTkl1L2NLWngr?=
 =?utf-8?B?M082aTM1cWRHSFZ1UWpXNWptdHZBUGRTcGtwUm5ERDNLV1NKOGdHdk5zS1M0?=
 =?utf-8?B?NVpkQ0xPQTZhK3JiT1BHUmpaMjF6NXhFOGtLZXdINndISXFDajkrc1JHSC9h?=
 =?utf-8?B?Qkl1TUlCZGNVNjUwSjdnWmVIckhKU3hjN3pWUWV6S0Rqcy9ITmNYSGlmSXFO?=
 =?utf-8?B?dlg4MlZ4eGRlUktIbVJwTFl4NmtpUms4VWF5bDREMDR6RndKRDlVWWl3bVpl?=
 =?utf-8?B?aVUyRFRkbHltaVdUWWs4Q3JEN2g3QjhQU2NDL0NQbDNjS3VJRVVZdmR2UThi?=
 =?utf-8?B?NWYwYy91VTROMFhPcENxSmtuK3Z2bm56VkFTMHI2aVA2bUFRUmtERGljR1Rs?=
 =?utf-8?B?N3FNRERNYzdqZk1ENk5IQkNMUWJaUGdhYi82NFAxOE9UQjVqZlcrQ2JJemlz?=
 =?utf-8?B?dkV2SStmelpjb1FFODNEek5rRjVKMUdhZkh2bW5pM00weVN2TkdoQ3psYm9S?=
 =?utf-8?B?VkE5ZTJzRDd1di9MdzJxN1ZseHpTci9IZldxV3RXcmNtd2NuVkVNY29odWtz?=
 =?utf-8?Q?IMOVWUyxEwOyRoSjJo53JWxX/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e23e6b4-eda8-4d48-82da-08daceba90b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 07:56:31.4231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ltYpeso9hLuqMwFCpwseUhUqRc+KqEo7d71GX+h3lkiYHy7EqFREqHlSJse2GhZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-25 02:45, Christian König wrote:
> 
> 
> Am 24.11.22 um 22:19 schrieb Luben Tuikov:
>> Fix minmax compilation error by using min_t()/max_t(), of the assignment type.
>>
>> Cc: James Zhu <James.Zhu@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index 8a2e5716d8dba2..d22d14b0ef0c84 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -191,14 +191,18 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>   	hmm_range->dev_private_owner = owner;
>>   
>>   	do {
>> -		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
>> +		hmm_range->end = min_t(typeof(hmm_range->end),
>> +				       hmm_range->start + MAX_WALK_BYTE,
>> +				       end);
> 
> Since end is a local variable I would strongly prefer to just have it 
> use the correct type for it.
> 
> Otherwise we might end up using something which doesn't work on all 
> architectures.

They all appear to be "unsigned long". I thought, since we assign to
hmm_range->end, we use that type.

Would you prefer at the top of the function to define "timeout" and "end" as,
	typeof(hmm_range->end) end, timeout;

Regards,
Luben

