Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589C5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA75611C1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BA75611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6926E9AA;
	Mon,  8 Nov 2021 14:35:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B420A6E9AA
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 14:35:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0vSF5E+H7J0hpIGtTlrR6EPi97M+rzHu0YqHHNOH6xKWeAY1VwTDmGNxO5fn4wGBbe4pJ1EjGSTcazUHcpN0x3FIuyEOUZklqmYWiJs/rFZOrGzws9AOx9mx5TAz9zmHSnv8IApuPAePBCyP4TFTJrZTCfQxBdGLvyotlLp4h2LoTLn/Zs91otZZ8qnSxJPS6cJiXk6UsJ2Ei1pF6B4xnQW16BK16PEA1arn9iSG3ADzyMnRtoqmxdBa7eqM5+cxu90Ektq03eVbBk71O8KUS8SlGImC0SPZdLD+nTT2b5Uh3kuPLg477rcsIJLHbplHC69uxi6/WBg7z2B4ptG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De/0VRmCL3NDFkB7Wls50boa67JT5P3x/V+eF1MGn/M=;
 b=azed2ODIJJ58L/keNKZy1fnBhNhQpPcDDpnbVwi0/j0XH8ExqfTEWYSdJQIGXMdo8+5AmRWcVr/Oy6s4EYpMWYkxlozVVFNfnHgvA/cDvrzS8DhYANsnlAPhANtNn+g9TnJspKRjs0AclUBxWFHn1RkQ6AZjDikWYm6/Jz6P9wuDIu/KhAaUQieXuQEZIQ/fIta5td7O/alYDcMiWpnKNkcpim2W3s1r4AgycwYYGHJ2QfQuvgSfUX+M2PJ0+x24SHjUyQ114+CTpJ0U7ZTrTlWOf6wB7mvtH4noGSmpnIexaxEmyQCu44Y+czeVytImZHmLDu/3PCgN0532LIiWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De/0VRmCL3NDFkB7Wls50boa67JT5P3x/V+eF1MGn/M=;
 b=oAymFUbXRAGZNf4YAe3myRE46MowXjryBEklGJOkP5efpbJ3MSLjC+jVbhD1UpWgxRo1gSB7kl4po/1KiCXeZTNnNJMtxySrgPF2AKlne5i1yTalxQQU7w9I3xGxtsGhAMnMcC2PWkLlV6E9YX3s8+pHCJqLFUzizrT7rQfPOWE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Mon, 8 Nov
 2021 14:35:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5174:fe56:1dec:1342]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5174:fe56:1dec:1342%9]) with mapi id 15.20.4669.015; Mon, 8 Nov 2021
 14:35:14 +0000
Subject: Re: [PATCH] drm/amdkfd: lower the VAs base offset to 8KB
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211105192540.16241-1-alex.sierra@amd.com>
 <7b2d01fc-1058-e92b-e30f-98a72701f274@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f97e6a35-ac4c-2ef5-5fd4-e83fa8832fdc@amd.com>
Date: Mon, 8 Nov 2021 09:35:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <7b2d01fc-1058-e92b-e30f-98a72701f274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Mon, 8 Nov 2021 14:35:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c78fec3-5285-4907-5ee4-08d9a2c4f9ad
X-MS-TrafficTypeDiagnostic: BN9PR12MB5177:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51770BD2B8D76543D0FBD88F92919@BN9PR12MB5177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vh2yf8f6eq880n+UXKTBsmqB/yIXQElrA4qYWG16US3pW2pgZTQqc13RMMIpPjQbJt5rqd5x/TijiFu+Go1w1C33arzFHf7n5+N8euIF81LDpsi2Ad/Efgi9y9YJmbq8KfG3Y1McGz37jJUOruO8OwvqPT9ScJSCvp/QBJ7shrtf7fD4WXdl30zzJKbFN2CgBcx3yWlNQ1mIUMPVlVUaA47VLXI+kYwAffpwFZyKdGLr5ibgjT5z4TDu+0lt41LIWBHCRbjeUv2m8t3ISX0U0Zb+rPTnrNKnsCnc7JXU4Gc2AQr26P4zDcBGtapr78Es/BF7yh5Lh8FvPMneHrsOHIMImyczzckOAkEohUCkB38MhTIlSONQIiSHC0UYu6COjt9tg64ZD/iUAzsk1y6UAqadsrHIE2qXKg8PMXTk3ZykmvF43v5hK6Ph4zHmK5l8uTIwVFMD/nmUM5ZLwGLFUjkq3XSMM2TkFTxJDkEqwFmqiLzV4ZFLpUVObRDaYoAwpBDboB0hLND7yLP9dLhFKnOGvv6HYkw+D5gArlD3sK3KqpFDqw0BX1cntA4/kBqS7eB/qzqQUm4DaGVxF3iZym7CRE6NQFC5PG4seaQ0yGrb/GR3To3n0hID7L2xIo5P0RLuZM5LhsBBujmcJqmNtMG9ijCRdQFsLl2vGbwWEwKyX4Istiq5zYbMB34WHv67ECIzszLYDAUbQJa3DLCX1/YFxms8/UpRriIZKKZTHg7FwfegeI5TT9+KsosDVCTJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(36756003)(66574015)(86362001)(44832011)(6486002)(316002)(83380400001)(16576012)(2616005)(110136005)(66476007)(956004)(8936002)(2906002)(5660300002)(66946007)(508600001)(186003)(38100700002)(66556008)(26005)(31696002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHd1d2JRNy9YYk95L055dmZQZzJ6d1JZa0trTkV1RWxJWkE0YU9yRzZwLzhV?=
 =?utf-8?B?THFEQ3Y5NFlHRiswb0hVaFFGNlhIc2pUeXkyTkcvenZFT0tRY21GNHdkRk5C?=
 =?utf-8?B?K0lNU2lXZUJZdHZCaXE4b1ErcTlVODY4R2c0K0dDTlJsb1Vsd1ZXUnR1Tjdm?=
 =?utf-8?B?Z2oza0o4SXMxUy9WRGVFMFRiWTRiODlvcmdObDlaa3NVRnUydENZaWpvQ3l5?=
 =?utf-8?B?N0lzOGJFRjBYSlNwM2hhSWJkeHFCSjArUUh3NGE1NWZEYWN2OTdDUzIrWU5v?=
 =?utf-8?B?bzVPeTdDVG5NWkozN3gyQjJwZmtBY3A5ZU5zQjM1UVhzSWJ4a3hRL2F0bW9I?=
 =?utf-8?B?ck5HMmdBNE5hNVBEVlovT291VXV5U0NxNE5PTU10Yk0raXl2emZCZFY5blJW?=
 =?utf-8?B?eUtZcUxHekFRUjBybE5DMHVKV29GZG1ldjNLTWh3YllVL25lVnJ0blJIaHk4?=
 =?utf-8?B?eW5kOG8rREMzZjZGVEZZbVFrNzdaUGs4RGZiam10VWt4cllGYkNoOFdKcjJQ?=
 =?utf-8?B?RXJrdG5rTUJLOUVGT3pXbmloWVkvZzVjUWFNMWE0WWhQRWxVQkY3NTJSN1Ar?=
 =?utf-8?B?L1VLUW16bUc3V2k4SDV4bEtNMy9ieUVzYzhZS2N6K1lMbmoyYW5GNngxWVJB?=
 =?utf-8?B?Yk5OVDV1cys2WXhPbnVrdzAxMTR3Nmd5MURUWktKbjhjZWpkN014ZEhCWnV2?=
 =?utf-8?B?ODdKVEJaaWVsU3pSUkpjRkdDb0hxTjRlaS9WSXp6VksvaTEyTU8waitqZGRs?=
 =?utf-8?B?blgrYjk0MlRINGFBWjYyRW9ZLzRYQTBneXRUdncxWlZ1QWVZMHc3MTRtYWVm?=
 =?utf-8?B?dXFDelpwSStNM1RrMmJ4bjN6TVJSckVZVmRKbjJEWnVjUGlCdkxtdm14OEdR?=
 =?utf-8?B?ZXRHWDA0K2NEUW9TUlp1WDFjVEJtWnVSeVU4dkhvQm9OQW9JS1gyUmxmT3F2?=
 =?utf-8?B?OUp2ZVF5ZUsrcEFDcFMxT2ZpZ0JxZ2lPRWk0WkJPbmRTd2d3MVdoZU1CM0gw?=
 =?utf-8?B?OHFSOEF4dTdpUHk4bFl2VVdRcUFvR29DQkdwcWVPbjlGZERkK2szQjFSTnI0?=
 =?utf-8?B?SWRtRTArVFhoR1VvUVZPVUFsVmR4c3VPdUtLZ1A0UkVNc2QyRFN5bFhvblk5?=
 =?utf-8?B?WE0wVVNnUllFem54MXZyMXNqTHhWTXA0TG0vaVBCZzlMU0dtZzNGSEVHdTAw?=
 =?utf-8?B?ZEFKa1FtSzFWL0lKL2duZFpTVEpoNTZPUTZVQlp4aTVwdUQyTXE5SjdBendX?=
 =?utf-8?B?R3pSRDdpWTJVOGFZRDhyT2dsS215OGFtSFFWRnBTRXhQbUFWM24zR3ZRSXFF?=
 =?utf-8?B?WEVFdHJRc3EvQjFDNjNsMGFlc0QvTFV2d05kcXlzc1NCa25zWmhNY0lscnAw?=
 =?utf-8?B?Q04veUhOS21PSzF6Y2I4M1hBSnVyRWxxbVVMU2lBbnFDNXFlNjN0WUQ2QWZz?=
 =?utf-8?B?RE1RakZLdURIZ2FzdzZIS2R2RmM0Y0NXbzd1VFhoandYQlZPVXArKzYrdmFE?=
 =?utf-8?B?MTh3T25ubC93YUQ5L2ZhUE8yMXJzUVc3Q1BLUHRhSm9ueGQ2c3c2bG9TSDU2?=
 =?utf-8?B?WTUzblQwL1ZDdDh3cWlIWjRxZVd4Nis2cEZyMTV6QjJvNHd0LzdpR1JoYlVl?=
 =?utf-8?B?ZkZJdWVERkhQR2lqTnNKN05TbFc1c2d2b2tkNWRkVXl3eEJaMUdIbnpkWkdS?=
 =?utf-8?B?QXIwS0kzZi9CUFRlME85UkVjUlRtSGZzQ2VtbWlKZHdVaE44d2J3VTBObGRG?=
 =?utf-8?B?UTZlRG8zWFdvK1ZsN3U5VHlYNWgvUmZEbmRGZUFnNWJvRVpZQ3RXSithN1dY?=
 =?utf-8?B?M3RoRk51eUJtSmR3aTltV0JJbHRyS0ZuUVpuYkpGL2Q3dkRNaUxISEEzOENJ?=
 =?utf-8?B?WE9QY2YrYkQ0YmpoSEgvSlVTOHRYQUpoRTVadUY0U3lQK1pmUndVK2t3dVlU?=
 =?utf-8?B?Skk5QVk4NDB3dmdaREw1YS8wTk9jWG5BT0Y0ejZHSzVVUFVxU2VoZm14Wksz?=
 =?utf-8?B?QzVaMDBzRjJjQXdJZDdJSTNaYm9vOEVVTjdnbWpSRmVaR3J5Y3VsYXVtTlJX?=
 =?utf-8?B?KzNSQkFTNmhCci9TVUlHbE1xRi9SRk5YNFlJd29Gc1NmMTdHbFAvcnB1Zmha?=
 =?utf-8?B?SjJCek1kR2lDOTUrQjVQdGlXbGVVNjVRd0FwV2VEdjFLa1FQaE1WWDFUa1g1?=
 =?utf-8?Q?pN1/NGtb5auzvleznJM1aS4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c78fec3-5285-4907-5ee4-08d9a2c4f9ad
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:35:13.8094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVLeA4hEiG9p8pn5aCTG6n4rE2qiCyOONEudRLZccwCBs2L15BVsk0DfQFC1pl22YO2MWoO5uwFF8DImY8FvVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
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


Am 2021-11-08 um 5:22 a.m. schrieb Christian König:
> Am 05.11.21 um 20:25 schrieb Alex Sierra:
>> The low 16MB of virtual address space are currently reserved for kernel
>> mode allocations mapped into user virtual address space. This causes
>> conflicts with HMM/SVM mappings at low virtual addresses. We tried to
>> move those kernel mode allocations to the upper half of the 64-bit
>> virtual address space for GFX9, which is naturally reserved for kernel
>> use. However, TBA (trap handler code) has problems to access addresses
>> in the high virtual space. We have decided to set this to 8KB of the
>> lower address space as a temporary fix, while investigate TBA address
>> problem. It is very unlikely for user space to map memory at this low
>> region.
>
> Unfortunately that is not correct. IIRC every program run inside wine
> maps something at the 16-64KiB addresses.
>
> Don't ask me what that stuff is good for, but we already ran into
> problems because of exactly that.
It's only a problem if the application tries to map that memory on the
GPU through the HMM/SVM API. As long as there is no conflict with GPU
mappings created by the application, the GPU can safely use those
addresses for its purposes.

Regards,
  Felix


>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> index 2e86692def19..d1388896f9c1 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> @@ -308,7 +308,7 @@
>>    * 16MB are reserved for kernel use (CWSR trap handler and kernel IB
>>    * for now).
>>    */
>> -#define SVM_USER_BASE 0x1000000ull
>> +#define SVM_USER_BASE (u64)(KFD_CWSR_TBA_TMA_SIZE + 2*PAGE_SIZE)
>>   #define SVM_CWSR_BASE (SVM_USER_BASE - KFD_CWSR_TBA_TMA_SIZE)
>>   #define SVM_IB_BASE   (SVM_CWSR_BASE - PAGE_SIZE)
>>   
>
