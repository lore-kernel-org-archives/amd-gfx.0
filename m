Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EB9C2BB3F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 16:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D13C10E089;
	Mon, 20 Nov 2023 16:21:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643FB10E089
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 16:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1keBssq+viYRQEEjl1cF1EKzNmR81/3Z66rJ8YgGL7/OmjFFXcy90ohGQILTOhuKKiY5glz2NAkMx9LsQzKtX2cyw7a7oGEQa6NQVYrxONVU+pgwUatwHQplgJIgnV+UFJigzNcRJFRvN7zB+D9tWxzdDDw8XTGKSXSg9U0g8PIK5qjJJs+9P3SDVhBYHMZd10ptrQg10TIUPlTYunK1HpC/+QTqEJt8gEvipVuOeK+RMVnAF2wEkjnM9RP46JimLoPTAfdyup9A7RFKWm4G/Zz0GHWBdKXdGJKaRSpDqBJYi1HfZn6QHsGluY1MrJY45uGpS9pETBQ2kJ0Fr3g2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2+vg33FbyisLSgGmigUHcQYozGy37N7E6J0ktl9xcI=;
 b=gjZ2pFZyPsrM/XO6djiNMtSOuJV0Ae0YFS9bXluoJmaEA5qTfhcm09nyg7VZpkhP53vqkR8VGuwnlLwv0s+bMzhGzQjJQFZLsCFfoeZrjj2zWyfYkujSK2TbgMvlYrYrUT0yDIvM7/GH0lVU2JB+UrBnmCgR9WRjKOALlunAT+IuW0qCgCxWUQAbI7SkKOXvAL7kU5JgxaBDqOft8A9lEyzfdAYkgJBOdDOej4nVoY7LTHDjUukx6tbR7cbezp2FCJbveT+qVBJ/3mL3Meh+4Ty0rrTNJaiDGJyId3da513cbQATy4ZGbgXbWqLYB4jAOSI7jOglcyQuvYb7U8H0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2+vg33FbyisLSgGmigUHcQYozGy37N7E6J0ktl9xcI=;
 b=oQ2Sd74z/Yvzh4TdUoYvRieqT1PonJnHc2N7PbTVGxpwx9pG9TyUoR1DzhjxIwocx7BrURGDnGztKn6rFuwwCestVlFSKzx44Jx5q2z8R7RCiSyAvMK9g6v7I/8+hvTA0jDy5pqekiDR6+FdtKqr3N73F2aXbIjgy1ehectACW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 16:21:07 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 16:21:07 +0000
Message-ID: <acdec25e-ecb1-4d3e-9f4f-1930f83ba5b6@amd.com>
Date: Mon, 20 Nov 2023 11:21:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] drm/amdkfd: use bit operation set debug trap
Content-Language: en-US
To: "Yat Sin, David" <David.YatSin@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-17-James.Zhu@amd.com>
 <DM6PR12MB5021F17F6D01763004219A4E95AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <DM6PR12MB5021F17F6D01763004219A4E95AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::24) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c9796d-faa9-4cef-f769-08dbe9e4b356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8bLaSEdTi68XoSoYqVAiJpW/ykSR2RLJKaWkRn1CKlA5no8kFT9H0h/bdBqWeUCQpTji7ajO9pdjjxWuBSnMnJmrFlRSi3GD+sIN1FgaUR1d1ebOGzfpO0eQ3VaRWEhNDkcb/0HyHNP3I5K0NfnM0zUV89jkIJGjzBz73pI6JGKQgEYN0esN4Pl6RqsaWWuouENf7RwiNtuN3PRJqAyvRukrgCPwR2ervDocYsTAzuEJtPBlTnPmZP+QICsE4mFbktB1Is40XDs1g0ypRvrepq7AUSjUMWYkoTXhDg3KJJt+mfb7NhtOz7TNUwL3koqE3m89GZOb3mwffdmCl9JMXdyQiWWUKOsIuWaQ25FObtJLCawv+BqapiFcGo6hJC1QAs7c88YmmZuiNRVW3V1eaBD0gJg/PLSz5hA3lSiX7pekL8IWOrT+6BdO2geRhA7/dBKlTpwXq4AtA/xtgvyDm030iBmp4FV7BSPPsis/HFPvTs1rJ9W4BxpuX6QKNQkB6hvbSb5krR5XH7SIaVz5ywauJJf9GDgXQ+m6yryTzJMuxDVe9/brOJCdt3GzmyEFaeyFEdD7CPgsQO83VVTgp6g/ChMu0lR6VxsPiVTbZ/ZHJbPw116RYtrelZm1OpESf1IglYoh4UTNo2+nLNmyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(316002)(110136005)(54906003)(66556008)(66476007)(36916002)(6506007)(53546011)(36756003)(6512007)(2616005)(26005)(6486002)(478600001)(38100700002)(31696002)(83380400001)(66946007)(4001150100001)(5660300002)(2906002)(31686004)(4326008)(8936002)(41300700001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVgxbmVSa1pyeVlGQW44SFM4Y0NWQTBqT0pVMWRVTHpEaW9XcURsQ00yZGZN?=
 =?utf-8?B?MTNMQ3pqczVHYkNVcEJVNlUrZHRyZE9QUXFtNmJCbWxWaCtOZnZaMUl3YXZi?=
 =?utf-8?B?NVMwM3o4N0ZDeTFvQUlEZitUaFpIU0RwTjZiN2R1ZGh2RXdnemRpb3RwNGIz?=
 =?utf-8?B?TW1ITkJFUHExT0ZGUEFsaWVFdTg2c3phQjBCTW9PbnJQVWx6aHA2T3laUUZK?=
 =?utf-8?B?c1dybk5IOG81VVlxSm1kWllXeG5zY29PTGFLd0FxU2JCNnJlY1pNb1N5emRJ?=
 =?utf-8?B?Mk1rajdiSS9YODdPZjBnN2EzeHRrVnZKRUZDaVdMM1J5K2lVQjBKb1o3ZDdx?=
 =?utf-8?B?Qis4MWs0ZE8yZEZxdjBJRWNSK2ltUzZTWHJCd0QyQk1TcGhyZC9aS3BVWW51?=
 =?utf-8?B?Q1BRdWFSS3ZoRDNnblY4ZGpITU9PVlMzcnNjTGNuOWFpNWI5ZmVVaTcyTXQ5?=
 =?utf-8?B?bjNYRmhMT0tndS8ycEtWbTN2M25ONUdYWDNKQnNCM081VjUvQ20zV0xmVUhD?=
 =?utf-8?B?V0hIK1V1bFY5V0NpS2kxeVQ2cWRKTDNyU1lEdkpXVmtmUlc2Ukd3aG95bGtJ?=
 =?utf-8?B?eFNuZWdQWDcyWjNnYTQrTlluQ0R5bTJJQ0JnZTFnYW5Oa1J0NnhnSFFTY2pR?=
 =?utf-8?B?eHRJSjVqN1IxMi93Mk13Tjc4bDlnT2pHTWxrQjFMbVNPU1N4VkRyc2xLSmFL?=
 =?utf-8?B?YXBZbnB2QnRRdXhuTmpvNmJscWFVUlI0Q3VScUFXWkp6aGdxZFI3UW1rZXNp?=
 =?utf-8?B?QS9XWXJIdWRpS1JxTXJ4OE4wLzRYMHFJdVUyaFNHNWw0UExnUElUL255aEda?=
 =?utf-8?B?U2VsM0o5UXdLb3RhUU5UREtuMEkxQW1WeUZkZ1NHZVdhRVZWa1hLTFB6c2hK?=
 =?utf-8?B?dFNpU1MzMURYeGJLc3JGU01aL0pwNllzcnVPOGxibUdtZWJFc2hFYzhhRVFN?=
 =?utf-8?B?TGwvWU1Pelphc1lNczYvcDNYOENsZXRPdm1nMkVDYWJFS1ZmWDhOeUhFQ1Fi?=
 =?utf-8?B?c2dObDNZL2RtMkprMnpBNzN2VTM0SnpycXdIWTNUR0lHN2J0WmtoZXgvT0Nw?=
 =?utf-8?B?TE1OdVpXc2NQZm12N0thT0VvYjZOeU1mYnVrVXY3U2VPMGtlaGNOVFRLV2x0?=
 =?utf-8?B?L1dzcFNyelIyQ0Y2RGlmQTZjaXhYcnJVL0RDR1FoK3dhamtSZmZnelpSdHRl?=
 =?utf-8?B?QlpwcGxDNnVUdVp0ZDEyRHcvMVpzazN2MW1ucFNBMjZZRk5QcnpRSi9VVldQ?=
 =?utf-8?B?c3VIeEcvaVdKb1JicUYvSzhvQTFkSmhTRGJ1ODBBdmVSenlicm9IZUVtN2o1?=
 =?utf-8?B?RDVORlJIY2JBOU5tWXdSeDRiL0szbFdMQko1MCswcjRDWFh6L3BwRmtjaXdJ?=
 =?utf-8?B?NnpkNW1nZE13M09OU00vZit0aWxzMFhGaDJhMjhiWkJ3dStEbWltZWNZZURC?=
 =?utf-8?B?dWFVdFBGRkMydHovTi9PTDhtZ1NIRGl5UEI1cUdHd09vRW1GeWkyRk1EZEJB?=
 =?utf-8?B?bCtxOHNPbXM0MDNhMk1HRStvdnZEVEpCbVdzNWJuR1FOR3JLbHZ1MmVDZWhL?=
 =?utf-8?B?QW4yNWJMKzJqbUl2OFdackRRcnh1U05BR24yTHBnOWpFM0xDVEJlbGFwTGhJ?=
 =?utf-8?B?MmZlWUc3RFBXbEVmYXVDQ2VIK2I2cUZlR1JERDFzaVRnZGttUVVKNllUVGMr?=
 =?utf-8?B?SnVKNVlVcmM1dEN1UXhSOHpBaE82SFFiVlhybWZreHNHOVJ2Z0JOUTc4MjQ4?=
 =?utf-8?B?S3ladm5aSFF5aVpvVW9kV0tVMWJabGxuQzR6ZGJMUjlyUm9VelZWQnRZbEh5?=
 =?utf-8?B?Z3BaWWcvekwvdmliam15Z2MvbU96ZVh1cHg1U3pSdHFqdWVNVGx1RDlrdlpt?=
 =?utf-8?B?dHZaOERFQjVNSzlUWXJ0NzVGSDhpZ0x4OU1GVGtQRmpjYWhCZlVmbUFlNWE4?=
 =?utf-8?B?cGFMUjRBbzRmTUxoeTYvUXZVT3FIRjF0Y21LWkZ1THVyTHdpZVdvTU9PbG1a?=
 =?utf-8?B?aDlKS0ZvSzZZaVpWQXBiYlVWVHpaL0hMRDFhRGx4QzA4ZUx3eVZIRkdEME1F?=
 =?utf-8?B?dk1TTmp3OEE1d2FZR29TZHJXd3FVRlNlTm1GU2VPSEFuSE1HWlpUemhFUmdF?=
 =?utf-8?Q?/oI0Iiig4zKK/nxQGtrnwfKbv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c9796d-faa9-4cef-f769-08dbe9e4b356
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 16:21:07.5062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doAQlFtrOBKT8NcVSjvlHa3cww8U6Q9LJUHJjYiDOj1Y1DNd3NaKToyjYBtIffxC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-10 14:08, Yat Sin, David wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Zhu, James <James.Zhu@amd.com>
>> Sent: Friday, November 3, 2023 9:12 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph
>> <Joseph.Greathouse@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Zhu,
>> James <James.Zhu@amd.com>
>> Subject: [PATCH 16/24] drm/amdkfd: use bit operation set debug trap
>>
>> 1st level TMA's 2nd byte which used for trap type setting, to use bit operation to
>> change selected bit only.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index fbf053001af9..a0b729c65a7c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1434,13 +1434,23 @@ bool kfd_process_xnack_mode(struct kfd_process
>> *p, bool supported)
>>        return true;
>>   }
>>
>> +/* bit offset in 1st-level TMA's 2nd byte which used for
>> +KFD_TRAP_TYPE_BIT */ enum KFD_TRAP_TYPE_BIT {
> Nit pick. New line after comment
[JZ] something wrong with your email. it is new line originally,
>> +     KFD_TRAP_TYPE_DEBUG = 0,                /* bit 0 for debug trap */
>> +     KFD_TRAP_TYPE_HOST,
>> +     KFD_TRAP_TYPE_STOCHASTIC,
>> +};
>> +
>>   void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
>>                                     bool enabled)
>>   {
>>        if (qpd->cwsr_kaddr) {
>> -             uint64_t *tma =
>> -                     (uint64_t *)(qpd->cwsr_kaddr +
>> KFD_CWSR_TMA_OFFSET);
>> -             tma[2] = enabled;
>> +             volatile unsigned long *tma =
>> +                     (volatile unsigned long *)(qpd->cwsr_kaddr +
>> KFD_CWSR_TMA_OFFSET);
>> +             if (enabled)
>> +                     set_bit(KFD_TRAP_TYPE_DEBUG, &tma[2]);
>> +             else
>> +                     clear_bit(KFD_TRAP_TYPE_DEBUG, &tma[2]);
>>        }
>>   }
>>
>> --
>> 2.25.1
