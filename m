Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283BAC433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  1 May 2022 19:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7068310E24E;
	Sun,  1 May 2022 19:45:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F15C10E255
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 May 2022 19:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdbHmHRcIbw60yQ+lvheRnAiEoEceW7pgNZU2xe//0leHNmIwJlo3Ee5SfSBk7skWweBz6rrzTyOrebFtaqgVM+OA1pDgECrPyQRT3DnHhkDqBUc4gZaGXG+TGAmY4K/6DeJ5TuPpR4iYxnppLX+mCh/i0L9+FvX3TT7ynvPwxDus5qgNx8rIg6/T0dkG0P/e2MYSv6XV3I/yqWIHWBC8gsyb5x5thMweYhlVi36Ba9xAzqnrZ/iQRB8/sFrsKs4PNT+sbnqAg4NhM58muyetalQNPVWQ1C/Jvam5VwXzdRb8KcoM0lxvqoThO/FL8zYvrKFM0MvZzhP7HQKmjz9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxJGppzF+mBDf1CN+/UH5aiy6MQo+BzNlWBWJw2BlbY=;
 b=ie2V1nAGlbY9JgFhHAlDk4Cr9rd4ui5dS9UW87XhxV1w0CZP4OVKR9Li7tgsjn/woNHWgqrxsIaThIQzY70nAGjBgfgJC4GWCEvfEMXQ7L/wjhLCGZXWyPEWl/pXGGUBpVr+TVSEPDcpifIK728NZwoHYasusYLiIJO3PMATWMM2/+/SSrZcebIj3M9szTZezrg3M63aWeGtZZTGN3CeB1y51lcSBkJaYJjyQEyU6UA0XFuLw0RW05jhJM2DwG+dCq1pwj9/W0uEUP3m8Wm+8o2Dsgl3Psi5Zo+1YAdSaLaIJivWnplYBdb1KhB9JxBjHfo2Las0O5qPjqw7DExQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxJGppzF+mBDf1CN+/UH5aiy6MQo+BzNlWBWJw2BlbY=;
 b=C17hSz6O3JYfIgJRga/2K804B/QjIdgD2rqLSaDxT4rjWlQ2dYGyMkk7a7kHel+MFLQUW7S3x8orJ/oeuQUXVDTjOJ15Hdg15iK8+KtvBebOerIFyKK1sq+73kaF8x98/4e3Ns1FB//DD63DejasQ94zE0LMGX1zyQBo4uwa1xA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sun, 1 May
 2022 19:45:13 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::812:88d6:77ae:1d87]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::812:88d6:77ae:1d87%8]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 19:45:11 +0000
Content-Type: multipart/alternative;
 boundary="------------MMhI0N5gEU8mMPAsoZYl0MmK"
Message-ID: <b42d6e3d-e646-8bcb-6166-bdb94ddd1d69@amd.com>
Date: Mon, 2 May 2022 01:15:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdgpu: Add out parameters to drm_amdgpu_sched
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220430151428.237089-1-Arunpravin.PaneerSelvam@amd.com>
 <85927512-377e-39b1-d812-ef9bddcc2f02@gmail.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <85927512-377e-39b1-d812-ef9bddcc2f02@gmail.com>
X-ClientProxiedBy: PN3PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::14) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f724d00-4372-4d63-e367-08da2bab1a6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4497:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4497F6B59AA700E009B99B95E4FE9@DM6PR12MB4497.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIUviVfjUBxMQ4yQitDvrMoJlcCG0UI7x0uCtE5ClRK40qFOW9Dv6j5WoUl8q+Vts93T0rP21wFMW7Bz+kOzQNgKyWJ2ZFvARchH48b+wnuw0dUEgmhz0fEczhZ0WRpzH7SK0x68Qke+5iCohe7F+9y2iyMN+aZk9J7BmFwQAZfALli3Fckekx/UlAS6xiZVBsSp3GByu6wQZvtp+Ws2fFfqQQVGKM1b74kxp+nFbqJChVW+0R7+JD/khaXkO3/rxItNywI7u0R76HBYr2UxzV2gOHs2WSfpRwuxUVM6YpIiQ6pljCiGivPmmtF2vUgfGZJioo5rlyCcGvWyd4xHHgkMb+giC2MwwJ10oho9JS99K2XLVbVFEWJ+q8VJRyRqW4BEdUzV+vXzhLijK0i1PjiR5/lQ8MVNkRh4VBab31laf9gf/khwUjKNl6fRCelFih0NJvMnA8eK6dTShGAQKAsVMCPWGDJWFizf4akXC/YHMLkRkGLoM+vQHzNgONIybKUiG2OK1cYTP9E9ABTeBou8VrzzlPyfSJZc7z72ROm/nTtXT264rm6P0Lsvcqh2UuAv318mqg0QBF82WHIY5S/4WiOL4lXj0AMlxJXm/66uKMy7NhWR1V9Ws7uJNjS0zZ9jLR88b8sVCR4uJ0bb6sRMVhubiZluuwdqPj2C50cZN8fa6BgxFeMCRXULCJD0uwfd9RNoWqDDr2asBtIwYUPIRqneGoQzq/bRKfBkCq0dtSA/SwTEQgACODDt0Rw7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(66946007)(4326008)(8676002)(66476007)(66556008)(86362001)(36756003)(6666004)(508600001)(45080400002)(38100700002)(6486002)(966005)(166002)(316002)(26005)(2616005)(33964004)(53546011)(6512007)(6506007)(31686004)(186003)(66574015)(2906002)(5660300002)(30864003)(83380400001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXBNaENKRE5HaEdvRE1jMTNlcXlST1N6Z21LY0xtbk56MnJHdFU1Q2JwNWtO?=
 =?utf-8?B?NnQ0T0NXUXl1RTZjbnlpK0lJdU54QTErbCtyVE8rOTU0U1djRUFheFFZckVT?=
 =?utf-8?B?ZjdZeDBQdWhBY2ttWi9Fczl1eUtvc1dUZjlRTm5xTTFYZGhEd1JkWDhIWWtP?=
 =?utf-8?B?Q25rM0NZY2NpbGsyS0pnWlVob2srVDBnRVUrTC8rUW8vc3FjQS9nRitrejh1?=
 =?utf-8?B?eUtBd0JNQ1ZWM2xpZUlUZkJFdlduNjBGM2pQaTdWalVQVHFuNm5KNjRGUW9J?=
 =?utf-8?B?WENROGxFRDBWMktYU0Y5MmQ4SFd2WFRCcFpIT3hoT0MrSlVTbUsyV3FmdWlL?=
 =?utf-8?B?cXE0dW1qVEMzN2p0cG1Cb1NWeHFHM3BDYWtFb2RXNlpaRTgwZTZoODh0T1VE?=
 =?utf-8?B?UDlaRi9nd1VqVTJ2bmgxbnl0TC9TQ1NjU1c2WS9RS1AvdUJjYjBJejFLM2dh?=
 =?utf-8?B?aEpMbURNeVJ0cks2MzI3aGN6WFVDdlErMWxSMWt2M2ZpY0lLSmEwUUlTaTkw?=
 =?utf-8?B?UTJCQmVmYy82T2x3NGVPeEtzZ2txYlhyU2wyV0pYTkZaS0xDZ3FEZnpxK3BL?=
 =?utf-8?B?M0p4L2VIejZtdEg4VUFRb1NLQ1RxZng1NG92OUdENjN5d0Q2TDhHWnoySXN2?=
 =?utf-8?B?dnVQb3JGaVRsMFNiT2ZQcGE4TENoY25sR2VzREZ3RzV6ZENwOWl6Z2YxVmFZ?=
 =?utf-8?B?QjdEU0JQcEJiV2U0YlR0NEx5Y0xCeEhTaUxJSy9qN3lhYko4LzAxdHladjBX?=
 =?utf-8?B?dzNPNVhGMXlEZFpUSFpWTFFYcHd5ZGxGeVMvdDhJS25XOGEwNVZFUG5WV09J?=
 =?utf-8?B?a3lUYU1xa1kxeWg1QkJ4ZWlTUEhZeXRma3JnQzV1TlYrOVJHek94VUJPL0lX?=
 =?utf-8?B?TS9xdjZVcW8yRnNxbEhwT3dEMUdyNzBSM0FraE9qVjhteWRpSStOY2N0Zzh0?=
 =?utf-8?B?MTVKQmlmM3NoaEcrU1VDVTBCeUozWlduOFRTSFo4MHdhQVdVWDZhcW96dHZa?=
 =?utf-8?B?TWVmMjZ3YnJ5OWlMdUlRRk4wYWRGZC93bXJ0S3JXU2xSR0lZT3EwSEptUmY5?=
 =?utf-8?B?MlJPLzVJMzcvWG9qSmlncEFMU2c4eVhsTlZoaVFkZHlaVXoyb2pkK3Q3U1lk?=
 =?utf-8?B?VC9BTm5CaVhqWVhSRlZ0ODJUcE9lZEtSWGJwZzA0WjVqcjlaSWl6aTBGbSs5?=
 =?utf-8?B?cWFON2oyWmVNdzhUOEwvTGNGT0FWMXR6bXVVK0hHajcwSUZ4cERkN1pmN3BO?=
 =?utf-8?B?d1duRktCa3NkczhlRkwxaXlKRUFOalQ2RFNIbWF5RG1hYVZIYlJHQVhlenl6?=
 =?utf-8?B?U0tJdE1PZ2Y5NUxJWlNIZG43SUxXQklReVZ0MU5VMGdJbUpCaXZoaC8xT0ZY?=
 =?utf-8?B?VyswYjM1dXdrYjZ5NVk4SVc2WithSHhZVWVXQmZ0cEErbFlJV0tSV2Z5U1dM?=
 =?utf-8?B?eHJFMGZETCtTenFkQ01OelJFUXNyYU0xVTI3aXJ1R0t0RFR1U2F3VllESVFi?=
 =?utf-8?B?V1kvNXlQSzV3clc4OTRrMWhhWjhrSXdwWVZzNk1SYWtQWm5sZzhSRVBVV1Fp?=
 =?utf-8?B?K1N6RHNybzlXSmdOQWtSM2lmcHMzcHpBUGUvRjQxUHBoSklKOXhHeHBrRHRP?=
 =?utf-8?B?NURMczc3VXpDMkhvVmt3ZC92UUtiRzYrTHYvQ0p0akd3L2IwSm5wMWZqUGY1?=
 =?utf-8?B?cXFHREtPejFDRVUrM0p4MG5FU3I3WWNwekJYUXZNRWdSdDFWV21NNmZPZXps?=
 =?utf-8?B?ZUR2dzRUYzF3WThIbURzSHlWdi9ReDdhNVFSSW9MU2pWQWdoS3RmVDlQMmRz?=
 =?utf-8?B?MDgvVU1QUWpJUmxuWGE2eUlKUGVzeVhYNHYrWWdLV0JuU3ZmQ3RyR2JzTEFu?=
 =?utf-8?B?Q2V3R1BySnZNL1dIeENTYlFUZDM4QmltUnBJZzhWT2tPMXlzY1BBa1pESlBm?=
 =?utf-8?B?ejZnNGNwTHNubHJJNU4wcE53RTBHMVBYRDJWMFk3VDA3OW9MTnc2S0EvVGRE?=
 =?utf-8?B?VTFhc01na3Foc05aZmRiRGoxVFBnak9JUFo0RFFpYTJtSXF6RGplNXUrMlBN?=
 =?utf-8?B?WGZTRDBwNytueHJTeFp4TzlmRlB3dEJqanZENnF1eXhqUk9KYmp2SC8wUHRs?=
 =?utf-8?B?RE9VTXRUc0xDMXFLYzJBWk9ZTStyZXEya0VCMHZ5YVVCWEVZbkYxODZwemx0?=
 =?utf-8?B?c293aElTR3B3VlpTWjVMUTdJQU5KMkF6a3d5NzdGM3FZSkZzamlUcmdzMVFZ?=
 =?utf-8?B?WlFxQXMxczI3dEdNTGk5bEtsYlA4WjBBb2FTNk1ENjZwd3NXbVlTdTVXWnNF?=
 =?utf-8?B?WVB6RnpkRE5WdmpwOG9jT3M1WTBjRnZ1Qk5aNFVseTE3Smd0eEp4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f724d00-4372-4d63-e367-08da2bab1a6d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 19:45:11.2594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0cJoXy8KtM5G8FJrKaZUzTkOxHcbwmVtUUyKYztzMsD6Lwfp+5J36btWfuvyaJcSY4i845+SVai3MH4PBTRww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------MMhI0N5gEU8mMPAsoZYl0MmK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/1/2022 12:59 AM, Christian König wrote:
> Am 30.04.22 um 17:14 schrieb Arunpravin Paneer Selvam:
>> - Add pipe and queue as out parameters to support high priority
>>    queue test enabled in libdrm basic test suite.
>>
>> - Fetch amdgpu_ring pointer and pass sched info to userspace
>>
>> - Improve amdgpu_sched_ioctl() function
>>
>> The related merge request for enabling high priority test case are
>> libdrm - 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fdrm%2F-%2Fmerge_requests%2F235&amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=jXIBtdA4seXl%2BYKsY2SDu%2B9tPoH6tfvUUXIRl4IosJc%3D&amp;reserved=0
>> mesa - 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fmesa%2F-%2Fmerge_requests%2F16262&amp;data=05%7C01%7CArunpravin.PaneerSelvam%40amd.com%7Ce7a876029be4439b742808da2adfb82a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637869437601696844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2F%2FwMJ86SXxP7K9STA%2B1x5rox1F5CPEy3JIhFMCjqwiY%3D&amp;reserved=0
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>
> Well that is certainly a NAK since as far as I can see this breaks the 
> UAPI in a not backward compatible way.
>
> Then we absolutely should not pass scheduler info to userspace. That 
> should be completely transparent to userspace.
>
> So can you summarize once more why that should be necessary?
I added a new test case named high priority queue test in libdrm basic 
test suite to validate the kernel feature patch named
high priority gfx pipe. In the test case, we are creating a context and 
overriding the priority as HIGH, submitting a simple NOP
command to test the job scheduled on high priority pipe / queue. This we 
have manually verified using the sysfs entry
amdgpu_fence_info where fence signaled on gfx high priority pipe 
(gfx_0.1.0). To ensure this in a unit test case, we require
pipe and queue info.

Thanks,
Arun
>
> Regards,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 114 ++++++++--------------
>>   include/uapi/drm/amdgpu_drm.h             |  14 ++-
>>   2 files changed, 53 insertions(+), 75 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> index e9b45089a28a..fc2864b612d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> @@ -32,106 +32,72 @@
>>   #include "amdgpu_sched.h"
>>   #include "amdgpu_vm.h"
>>   -static int amdgpu_sched_process_priority_override(struct 
>> amdgpu_device *adev,
>> -                          int fd,
>> -                          int32_t priority)
>> +int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>> +               struct drm_file *filp)
>>   {
>> -    struct fd f = fdget(fd);
>> +    union drm_amdgpu_sched *args = data;
>> +    struct amdgpu_ctx *ctx, *ctx_ptr;
>> +    struct drm_sched_entity *entity;
>>       struct amdgpu_fpriv *fpriv;
>> -    struct amdgpu_ctx *ctx;
>> -    uint32_t id;
>> -    int r;
>> -
>> -    if (!f.file)
>> -        return -EINVAL;
>> -
>> -    r = amdgpu_file_to_fpriv(f.file, &fpriv);
>> -    if (r) {
>> -        fdput(f);
>> -        return r;
>> -    }
>> -
>> -    idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
>> -        amdgpu_ctx_priority_override(ctx, priority);
>> -
>> -    fdput(f);
>> -    return 0;
>> -}
>> -
>> -static int amdgpu_sched_context_priority_override(struct 
>> amdgpu_device *adev,
>> -                          int fd,
>> -                          unsigned ctx_id,
>> -                          int32_t priority)
>> -{
>> +    struct amdgpu_ring *ring;
>> +    u32 fd = args->in.fd;
>>       struct fd f = fdget(fd);
>> -    struct amdgpu_fpriv *fpriv;
>> -    struct amdgpu_ctx *ctx;
>> +    u32 id;
>>       int r;
>>         if (!f.file)
>>           return -EINVAL;
>>         r = amdgpu_file_to_fpriv(f.file, &fpriv);
>> -    if (r) {
>> -        fdput(f);
>> -        return r;
>> -    }
>> +    if (r)
>> +        goto out_fd;
>>   -    ctx = amdgpu_ctx_get(fpriv, ctx_id);
>> +    ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>>         if (!ctx) {
>> -        fdput(f);
>> -        return -EINVAL;
>> -    }
>> -
>> -    amdgpu_ctx_priority_override(ctx, priority);
>> -    amdgpu_ctx_put(ctx);
>> -    fdput(f);
>> -
>> -    return 0;
>> -}
>> -
>> -int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>> -               struct drm_file *filp)
>> -{
>> -    union drm_amdgpu_sched *args = data;
>> -    struct amdgpu_device *adev = drm_to_adev(dev);
>> -    int r;
>> -
>> -    /* First check the op, then the op's argument.
>> -     */
>> -    switch (args->in.op) {
>> -    case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
>> -    case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
>> -        break;
>> -    default:
>> -        DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
>> -        return -EINVAL;
>> +        r = -EINVAL;
>> +        goto out_fd;
>>       }
>>         if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
>>           WARN(1, "Invalid context priority %d\n", args->in.priority);
>> -        return -EINVAL;
>> +        r = -EINVAL;
>> +        goto out_ctx;
>>       }
>>         switch (args->in.op) {
>>       case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
>> -        r = amdgpu_sched_process_priority_override(adev,
>> -                               args->in.fd,
>> -                               args->in.priority);
>> +        /* Retrieve all ctx handles and override priority  */
>> +        idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx_ptr, id)
>> +            amdgpu_ctx_priority_override(ctx_ptr, args->in.priority);
>>           break;
>>       case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
>> -        r = amdgpu_sched_context_priority_override(adev,
>> -                               args->in.fd,
>> -                               args->in.ctx_id,
>> -                               args->in.priority);
>> +        /* Override priority for a given context */
>> +        amdgpu_ctx_priority_override(ctx, args->in.priority);
>>           break;
>>       default:
>> -        /* Impossible.
>> -         */
>> +        DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
>>           r = -EINVAL;
>> -        break;
>> +        goto out_ctx;
>>       }
>>   +    r = amdgpu_ctx_get_entity(ctx, args->in.ip_type, 0, 
>> args->in.ring,
>> +                  &entity);
>> +    if (r)
>> +        goto out_ctx;
>> +
>> +    /* Fetch amdgpu_ring pointer */
>> +    ring = to_amdgpu_ring(entity->rq->sched);
>> +
>> +    /* Pass sched info to userspace */
>> +    memset(args, 0, sizeof(*args));
>> +    args->out.info.pipe = ring->pipe;
>> +    args->out.info.queue = ring->queue;
>> +
>> +out_ctx:
>> +    amdgpu_ctx_put(ctx);
>> +out_fd:
>> +    fdput(f);
>> +
>>       return r;
>>   }
>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>> b/include/uapi/drm/amdgpu_drm.h
>> index 1d65c1fbc4ec..e93f1b6c4561 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -70,7 +70,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_WAIT_FENCES DRM_IOWR(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_WAIT_FENCES, union drm_amdgpu_wait_fences)
>>   #define DRM_IOCTL_AMDGPU_VM        DRM_IOWR(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE 
>> + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>> -#define DRM_IOCTL_AMDGPU_SCHED        DRM_IOW(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>> +#define DRM_IOCTL_AMDGPU_SCHED        DRM_IOWR(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>     /**
>>    * DOC: memory domains
>> @@ -308,6 +308,11 @@ union drm_amdgpu_vm {
>>   #define AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE    1
>>   #define AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE    2
>>   +struct drm_amdgpu_sched_info {
>> +    __u32 pipe;
>> +    __u32 queue;
>> +};
>> +
>>   struct drm_amdgpu_sched_in {
>>       /* AMDGPU_SCHED_OP_* */
>>       __u32    op;
>> @@ -315,10 +320,17 @@ struct drm_amdgpu_sched_in {
>>       /** AMDGPU_CTX_PRIORITY_* */
>>       __s32    priority;
>>       __u32   ctx_id;
>> +    __u32   ip_type;
>> +    __u32   ring;
>> +};
>> +
>> +struct drm_amdgpu_sched_out {
>> +    struct drm_amdgpu_sched_info info;
>>   };
>>     union drm_amdgpu_sched {
>>       struct drm_amdgpu_sched_in in;
>> +    struct drm_amdgpu_sched_out out;
>>   };
>>     /*
>

--------------MMhI0N5gEU8mMPAsoZYl0MmK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+DQo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD11dGYtOCI+DQogIDwvaGVhZD4NCiAgPGJvZHk+DQogICAgPGJyPg0K
ICAgIDxicj4NCiAgICA8ZGl2IGNsYXNzPSJtb3otY2l0ZS1wcmVmaXgiPk9uIDUvMS8yMDIyIDEy
OjU5IEFNLCBDaHJpc3RpYW4gS8O2bmlnDQogICAgICB3cm90ZTo8YnI+DQogICAgPC9kaXY+DQog
ICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2l0ZT0ibWlkOjg1OTI3NTEyLTM3N2UtMzliMS1k
ODEyLWVmOWJkZGNjMmYwMkBnbWFpbC5jb20iPkFtDQogICAgICAzMC4wNC4yMiB1bSAxNzoxNCBz
Y2hyaWViIEFydW5wcmF2aW4gUGFuZWVyIFNlbHZhbToNCiAgICAgIDxicj4NCiAgICAgIDxibG9j
a3F1b3RlIHR5cGU9ImNpdGUiPi0gQWRkIHBpcGUgYW5kIHF1ZXVlIGFzIG91dCBwYXJhbWV0ZXJz
IHRvDQogICAgICAgIHN1cHBvcnQgaGlnaCBwcmlvcml0eQ0KICAgICAgICA8YnI+DQogICAgICAg
ICZuYnNwOyZuYnNwOyBxdWV1ZSB0ZXN0IGVuYWJsZWQgaW4gbGliZHJtIGJhc2ljIHRlc3Qgc3Vp
dGUuDQogICAgICAgIDxicj4NCiAgICAgICAgPGJyPg0KICAgICAgICAtIEZldGNoIGFtZGdwdV9y
aW5nIHBvaW50ZXIgYW5kIHBhc3Mgc2NoZWQgaW5mbyB0byB1c2Vyc3BhY2UNCiAgICAgICAgPGJy
Pg0KICAgICAgICA8YnI+DQogICAgICAgIC0gSW1wcm92ZSBhbWRncHVfc2NoZWRfaW9jdGwoKSBm
dW5jdGlvbg0KICAgICAgICA8YnI+DQogICAgICAgIDxicj4NCiAgICAgICAgVGhlIHJlbGF0ZWQg
bWVyZ2UgcmVxdWVzdCBmb3IgZW5hYmxpbmcgaGlnaCBwcmlvcml0eSB0ZXN0IGNhc2UNCiAgICAg
ICAgYXJlDQogICAgICAgIDxicj4NCiAgICAgICAgbGliZHJtIC0NCjxhIGNsYXNzPSJtb3otdHh0
LWxpbmstZnJlZXRleHQiIGhyZWY9Imh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGxhYi5mcmVlZGVza3RvcC5vcmclMkZt
ZXNhJTJGZHJtJTJGLSUyRm1lcmdlX3JlcXVlc3RzJTJGMjM1JmFtcDthbXA7ZGF0YT0wNSU3QzAx
JTdDQXJ1bnByYXZpbi5QYW5lZXJTZWx2YW0lNDBhbWQuY29tJTdDZTdhODc2MDI5YmU0NDM5Yjc0
MjgwOGRhMmFkZmI4MmElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0Mw
JTdDNjM3ODY5NDM3NjAxNjk2ODQ0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0
d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3
QzMwMDAlN0MlN0MlN0MmYW1wO2FtcDtzZGF0YT1qWElCdGRBNHNlWGwlMkJZS3NZMlNEdSUyQjl0
UG9INnRmdlVVWElSbDRJb3NKYyUzRCZhbXA7YW1wO3Jlc2VydmVkPTAiPmh0dHBzOi8vbmFtMTEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGxh
Yi5mcmVlZGVza3RvcC5vcmclMkZtZXNhJTJGZHJtJTJGLSUyRm1lcmdlX3JlcXVlc3RzJTJGMjM1
JmFtcDthbXA7ZGF0YT0wNSU3QzAxJTdDQXJ1bnByYXZpbi5QYW5lZXJTZWx2YW0lNDBhbWQuY29t
JTdDZTdhODc2MDI5YmU0NDM5Yjc0MjgwOGRhMmFkZmI4MmElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUx
MWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3ODY5NDM3NjAxNjk2ODQ0JTdDVW5rbm93biU3Q1RX
RnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsx
aGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO2FtcDtzZGF0YT1qWElCdGRB
NHNlWGwlMkJZS3NZMlNEdSUyQjl0UG9INnRmdlVVWElSbDRJb3NKYyUzRCZhbXA7YW1wO3Jlc2Vy
dmVkPTA8L2E+PGJyPg0KICAgICAgICBtZXNhIC0NCjxhIGNsYXNzPSJtb3otdHh0LWxpbmstZnJl
ZXRleHQiIGhyZWY9Imh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGxhYi5mcmVlZGVza3RvcC5vcmclMkZtZXNhJTJGbWVz
YSUyRi0lMkZtZXJnZV9yZXF1ZXN0cyUyRjE2MjYyJmFtcDthbXA7ZGF0YT0wNSU3QzAxJTdDQXJ1
bnByYXZpbi5QYW5lZXJTZWx2YW0lNDBhbWQuY29tJTdDZTdhODc2MDI5YmU0NDM5Yjc0MjgwOGRh
MmFkZmI4MmElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3
ODY5NDM3NjAxNjk2ODQ0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdN
REFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAl
N0MlN0MlN0MmYW1wO2FtcDtzZGF0YT0lMkYlMkZ3TUo4NlNYeFA3SzlTVEElMkIxeDVyb3gxRjVD
UEV5M0pJaEZNQ2pxd2lZJTNEJmFtcDthbXA7cmVzZXJ2ZWQ9MCI+aHR0cHM6Ly9uYW0xMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0bGFiLmZy
ZWVkZXNrdG9wLm9yZyUyRm1lc2ElMkZtZXNhJTJGLSUyRm1lcmdlX3JlcXVlc3RzJTJGMTYyNjIm
YW1wO2FtcDtkYXRhPTA1JTdDMDElN0NBcnVucHJhdmluLlBhbmVlclNlbHZhbSU0MGFtZC5jb20l
N0NlN2E4NzYwMjliZTQ0MzliNzQyODA4ZGEyYWRmYjgyYSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTEx
YTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc4Njk0Mzc2MDE2OTY4NDQlN0NVbmtub3duJTdDVFdG
cGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFo
YVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7YW1wO3NkYXRhPSUyRiUyRndN
Sjg2U1h4UDdLOVNUQSUyQjF4NXJveDFGNUNQRXkzSkloRk1DanF3aVklM0QmYW1wO2FtcDtyZXNl
cnZlZD0wPC9hPjxicj4NCiAgICAgICAgPGJyPg0KICAgICAgICBTaWduZWQtb2ZmLWJ5OiBBcnVu
cHJhdmluIFBhbmVlciBTZWx2YW0NCiAgICAgICAgPGEgY2xhc3M9Im1vei10eHQtbGluay1yZmMy
Mzk2RSIgaHJlZj0ibWFpbHRvOkFydW5wcmF2aW4uUGFuZWVyU2VsdmFtQGFtZC5jb20iPiZsdDtB
cnVucHJhdmluLlBhbmVlclNlbHZhbUBhbWQuY29tJmd0OzwvYT4NCiAgICAgICAgPGJyPg0KICAg
ICAgPC9ibG9ja3F1b3RlPg0KICAgICAgPGJyPg0KICAgICAgV2VsbCB0aGF0IGlzIGNlcnRhaW5s
eSBhIE5BSyBzaW5jZSBhcyBmYXIgYXMgSSBjYW4gc2VlIHRoaXMgYnJlYWtzDQogICAgICB0aGUg
VUFQSSBpbiBhIG5vdCBiYWNrd2FyZCBjb21wYXRpYmxlIHdheS4NCiAgICAgIDxicj4NCiAgICAg
IDxicj4NCiAgICAgIFRoZW4gd2UgYWJzb2x1dGVseSBzaG91bGQgbm90IHBhc3Mgc2NoZWR1bGVy
IGluZm8gdG8gdXNlcnNwYWNlLg0KICAgICAgVGhhdCBzaG91bGQgYmUgY29tcGxldGVseSB0cmFu
c3BhcmVudCB0byB1c2Vyc3BhY2UuDQogICAgICA8YnI+DQogICAgICA8YnI+DQogICAgICBTbyBj
YW4geW91IHN1bW1hcml6ZSBvbmNlIG1vcmUgd2h5IHRoYXQgc2hvdWxkIGJlIG5lY2Vzc2FyeT88
YnI+DQogICAgPC9ibG9ja3F1b3RlPg0KICAgIEkgYWRkZWQgYSBuZXcgdGVzdCBjYXNlIG5hbWVk
IGhpZ2ggcHJpb3JpdHkgcXVldWUgdGVzdCBpbiBsaWJkcm0NCiAgICBiYXNpYyB0ZXN0IHN1aXRl
IHRvIHZhbGlkYXRlIHRoZSBrZXJuZWwgZmVhdHVyZSBwYXRjaCBuYW1lZDxicj4NCiAgICA8c3Bh
biBzdHlsZT0ibXNvLXNwYWNlcnVuOnllcyI+PC9zcGFuPmhpZ2ggcHJpb3JpdHkgZ2Z4IHBpcGUu
IEluIHRoZQ0KICAgIHRlc3QgY2FzZSwgd2UNCiAgICBhcmUgY3JlYXRpbmcgYSBjb250ZXh0IGFu
ZCBvdmVycmlkaW5nIHRoZQ0KICAgIHByaW9yaXR5IGFzIEhJR0gsIHN1Ym1pdHRpbmcgYSBzaW1w
bGUgTk9QPGJyPg0KICAgIGNvbW1hbmQgdG8gdGVzdCB0aGUgam9iIHNjaGVkdWxlZCBvbiBoaWdo
IHByaW9yaXR5IHBpcGUgLw0KICAgIHF1ZXVlLiBUaGlzIHdlIGhhdmUgbWFudWFsbHkgdmVyaWZp
ZWQgdXNpbmcgdGhlIHN5c2ZzIGVudHJ5PGJyPg0KICAgIGFtZGdwdV9mZW5jZV9pbmZvDQogICAg
d2hlcmUgZmVuY2Ugc2lnbmFsZWQgb24NCiAgICBnZnggaGlnaCBwcmlvcml0eSBwaXBlIChnZnhf
MC4xLjApLiBUbyBlbnN1cmUgdGhpcyBpbiBhIHVuaXQgdGVzdA0KICAgIGNhc2UsIHdlDQogICAg
cmVxdWlyZTxicj4NCiAgICBwaXBlIGFuZCBxdWV1ZSBpbmZvLjxicj4NCiAgICA8YnI+DQogICAg
VGhhbmtzLDxicj4NCiAgICBBcnVuPGJyPg0KICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNp
dGU9Im1pZDo4NTkyNzUxMi0zNzdlLTM5YjEtZDgxMi1lZjliZGRjYzJmMDJAZ21haWwuY29tIj4N
CiAgICAgIDxicj4NCiAgICAgIFJlZ2FyZHMsDQogICAgICA8YnI+DQogICAgICBDaHJpc3RpYW4u
DQogICAgICA8YnI+DQogICAgICA8YnI+DQogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4t
LS0NCiAgICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3NjaGVkLmMgfCAxMTQNCiAgICAgICAgKysrKysrKystLS0tLS0tLS0tLS0tLQ0K
ICAgICAgICA8YnI+DQogICAgICAgICZuYnNwOyBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0u
aCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyB8Jm5ic3A7IDE0ICsrLQ0KICAgICAgICA8YnI+DQogICAgICAgICZu
YnNwOyAyIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDc1IGRlbGV0aW9ucygtKQ0K
ICAgICAgICA8YnI+DQogICAgICAgIDxicj4NCiAgICAgICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zY2hlZC5jDQogICAgICAgIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3NjaGVkLmMNCiAgICAgICAgPGJyPg0KICAgICAgICBpbmRl
eCBlOWI0NTA4OWEyOGEuLmZjMjg2NGI2MTJkOSAxMDA2NDQNCiAgICAgICAgPGJyPg0KICAgICAg
ICAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2NoZWQuYw0KICAgICAg
ICA8YnI+DQogICAgICAgICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9z
Y2hlZC5jDQogICAgICAgIDxicj4NCiAgICAgICAgQEAgLTMyLDEwNiArMzIsNzIgQEANCiAgICAg
ICAgPGJyPg0KICAgICAgICAmbmJzcDsgI2luY2x1ZGUgJnF1b3Q7YW1kZ3B1X3NjaGVkLmgmcXVv
dDsNCiAgICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsgI2luY2x1ZGUgJnF1b3Q7YW1kZ3B1X3Zt
LmgmcXVvdDsNCiAgICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsgLXN0YXRpYyBpbnQgYW1kZ3B1
X3NjaGVkX3Byb2Nlc3NfcHJpb3JpdHlfb3ZlcnJpZGUoc3RydWN0DQogICAgICAgIGFtZGdwdV9k
ZXZpY2UgKmFkZXYsDQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBpbnQgZmQsDQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpbnQzMl90IHByaW9yaXR5KQ0KICAgICAgICA8
YnI+DQogICAgICAgICtpbnQgYW1kZ3B1X3NjaGVkX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsIHZvaWQgKmRhdGEsDQogICAgICAgIDxicj4NCiAgICAgICAgKyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHApDQogICAgICAgIDxicj4NCiAgICAgICAg
Jm5ic3A7IHsNCiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7IHN0cnVj
dCBmZCBmID0gZmRnZXQoZmQpOw0KICAgICAgICA8YnI+DQogICAgICAgICsmbmJzcDsmbmJzcDsm
bmJzcDsgdW5pb24gZHJtX2FtZGdwdV9zY2hlZCAqYXJncyA9IGRhdGE7DQogICAgICAgIDxicj4N
CiAgICAgICAgKyZuYnNwOyZuYnNwOyZuYnNwOyBzdHJ1Y3QgYW1kZ3B1X2N0eCAqY3R4LCAqY3R4
X3B0cjsNCiAgICAgICAgPGJyPg0KICAgICAgICArJm5ic3A7Jm5ic3A7Jm5ic3A7IHN0cnVjdCBk
cm1fc2NoZWRfZW50aXR5ICplbnRpdHk7DQogICAgICAgIDxicj4NCiAgICAgICAgJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHN0cnVjdCBhbWRncHVfZnByaXYgKmZwcml2Ow0KICAgICAg
ICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsgc3RydWN0IGFtZGdwdV9jdHggKmN0
eDsNCiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7IHVpbnQzMl90IGlk
Ow0KICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsgaW50IHI7DQogICAg
ICAgIDxicj4NCiAgICAgICAgLQ0KICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsm
bmJzcDsgaWYgKCFmLmZpbGUpDQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyByZXR1cm4gLUVJTlZBTDsNCiAgICAgICAgPGJy
Pg0KICAgICAgICAtDQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZuYnNwOyBy
ID0gYW1kZ3B1X2ZpbGVfdG9fZnByaXYoZi5maWxlLCAmYW1wO2Zwcml2KTsNCiAgICAgICAgPGJy
Pg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChyKSB7DQogICAgICAgIDxicj4NCiAg
ICAgICAgLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBmZHB1dChm
KTsNCiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IHJldHVybiByOw0KICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJz
cDsmbmJzcDsgfQ0KICAgICAgICA8YnI+DQogICAgICAgIC0NCiAgICAgICAgPGJyPg0KICAgICAg
ICAtJm5ic3A7Jm5ic3A7Jm5ic3A7IGlkcl9mb3JfZWFjaF9lbnRyeSgmYW1wO2Zwcml2LSZndDtj
dHhfbWdyLmN0eF9oYW5kbGVzLCBjdHgsDQogICAgICAgIGlkKQ0KICAgICAgICA8YnI+DQogICAg
ICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYW1kZ3B1X2N0
eF9wcmlvcml0eV9vdmVycmlkZShjdHgsIHByaW9yaXR5KTsNCiAgICAgICAgPGJyPg0KICAgICAg
ICAtDQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZuYnNwOyBmZHB1dChmKTsN
CiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVybiAwOw0KICAg
ICAgICA8YnI+DQogICAgICAgIC19DQogICAgICAgIDxicj4NCiAgICAgICAgLQ0KICAgICAgICA8
YnI+DQogICAgICAgIC1zdGF0aWMgaW50IGFtZGdwdV9zY2hlZF9jb250ZXh0X3ByaW9yaXR5X292
ZXJyaWRlKHN0cnVjdA0KICAgICAgICBhbWRncHVfZGV2aWNlICphZGV2LA0KICAgICAgICA8YnI+
DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaW50IGZkLA0K
ICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgdW5zaWduZWQgY3R4X2lkLA0KICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaW50MzJfdCBwcmlvcml0eSkNCiAgICAgICAgPGJyPg0K
ICAgICAgICAtew0KICAgICAgICA8YnI+DQogICAgICAgICsmbmJzcDsmbmJzcDsmbmJzcDsgc3Ry
dWN0IGFtZGdwdV9yaW5nICpyaW5nOw0KICAgICAgICA8YnI+DQogICAgICAgICsmbmJzcDsmbmJz
cDsmbmJzcDsgdTMyIGZkID0gYXJncy0mZ3Q7aW4uZmQ7DQogICAgICAgIDxicj4NCiAgICAgICAg
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHN0cnVjdCBmZCBmID0gZmRnZXQoZmQpOw0K
ICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsgc3RydWN0IGFtZGdwdV9m
cHJpdiAqZnByaXY7DQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZuYnNwOyBz
dHJ1Y3QgYW1kZ3B1X2N0eCAqY3R4Ow0KICAgICAgICA8YnI+DQogICAgICAgICsmbmJzcDsmbmJz
cDsmbmJzcDsgdTMyIGlkOw0KICAgICAgICA8YnI+DQogICAgICAgICZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBpbnQgcjsNCiAgICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsgJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmICghZi5maWxlKQ0KICAgICAgICA8YnI+DQogICAg
ICAgICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyByZXR1cm4gLUVJTlZBTDsNCiAgICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsgJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHIgPSBhbWRncHVfZmlsZV90b19mcHJpdihmLmZpbGUsICZh
bXA7ZnByaXYpOw0KICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsgaWYg
KHIpIHsNCiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IGZkcHV0KGYpOw0KICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIHI7DQogICAgICAgIDxi
cj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZuYnNwOyB9DQogICAgICAgIDxicj4NCiAgICAgICAg
KyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAocikNCiAgICAgICAgPGJyPg0KICAgICAgICArJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGdvdG8gb3V0X2ZkOw0KICAgICAg
ICA8YnI+DQogICAgICAgICZuYnNwOyAtJm5ic3A7Jm5ic3A7Jm5ic3A7IGN0eCA9IGFtZGdwdV9j
dHhfZ2V0KGZwcml2LCBjdHhfaWQpOw0KICAgICAgICA8YnI+DQogICAgICAgICsmbmJzcDsmbmJz
cDsmbmJzcDsgY3R4ID0gYW1kZ3B1X2N0eF9nZXQoZnByaXYsIGFyZ3MtJmd0O2luLmN0eF9pZCk7
DQogICAgICAgIDxicj4NCiAgICAgICAgJm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBpZiAoIWN0eCkgew0KICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZmRwdXQoZik7DQogICAgICAgIDxicj4NCiAgICAg
ICAgLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyByZXR1cm4gLUVJ
TlZBTDsNCiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7IH0NCiAgICAg
ICAgPGJyPg0KICAgICAgICAtDQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZu
YnNwOyBhbWRncHVfY3R4X3ByaW9yaXR5X292ZXJyaWRlKGN0eCwgcHJpb3JpdHkpOw0KICAgICAg
ICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsgYW1kZ3B1X2N0eF9wdXQoY3R4KTsN
CiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7IGZkcHV0KGYpOw0KICAg
ICAgICA8YnI+DQogICAgICAgIC0NCiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7
Jm5ic3A7IHJldHVybiAwOw0KICAgICAgICA8YnI+DQogICAgICAgIC19DQogICAgICAgIDxicj4N
CiAgICAgICAgLQ0KICAgICAgICA8YnI+DQogICAgICAgIC1pbnQgYW1kZ3B1X3NjaGVkX2lvY3Rs
KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsDQogICAgICAgIDxicj4NCiAgICAg
ICAgLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHApDQog
ICAgICAgIDxicj4NCiAgICAgICAgLXsNCiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5i
c3A7Jm5ic3A7IHVuaW9uIGRybV9hbWRncHVfc2NoZWQgKmFyZ3MgPSBkYXRhOw0KICAgICAgICA8
YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYgPSBkcm1fdG9fYWRldihkZXYpOw0KICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJz
cDsmbmJzcDsgaW50IHI7DQogICAgICAgIDxicj4NCiAgICAgICAgLQ0KICAgICAgICA8YnI+DQog
ICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsgLyogRmlyc3QgY2hlY2sgdGhlIG9wLCB0aGVuIHRo
ZSBvcCdzIGFyZ3VtZW50Lg0KICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgKi8NCiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7IHN3
aXRjaCAoYXJncy0mZ3Q7aW4ub3ApIHsNCiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5i
c3A7Jm5ic3A7IGNhc2UgQU1ER1BVX1NDSEVEX09QX1BST0NFU1NfUFJJT1JJVFlfT1ZFUlJJREU6
DQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZuYnNwOyBjYXNlIEFNREdQVV9T
Q0hFRF9PUF9DT05URVhUX1BSSU9SSVRZX09WRVJSSURFOg0KICAgICAgICA8YnI+DQogICAgICAg
IC0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYnJlYWs7DQogICAg
ICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZuYnNwOyBkZWZhdWx0Og0KICAgICAgICA8
YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
RFJNX0VSUk9SKCZxdW90O0ludmFsaWQgc2NoZWQgb3Agc3BlY2lmaWVkOiAlZFxuJnF1b3Q7LA0K
ICAgICAgICBhcmdzLSZndDtpbi5vcCk7DQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyByZXR1cm4gLUVJTlZBTDsNCiAgICAg
ICAgPGJyPg0KICAgICAgICArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IHIgPSAtRUlOVkFMOw0KICAgICAgICA8YnI+DQogICAgICAgICsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZ290byBvdXRfZmQ7DQogICAgICAgIDxicj4NCiAg
ICAgICAgJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH0NCiAgICAgICAgPGJyPg0KICAg
ICAgICAmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmICghYW1kZ3B1X2N0
eF9wcmlvcml0eV9pc192YWxpZChhcmdzLSZndDtpbi5wcmlvcml0eSkpDQogICAgICAgIHsNCiAg
ICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgV0FSTigxLCAmcXVvdDtJbnZhbGlkIGNvbnRleHQgcHJpb3JpdHkg
JWRcbiZxdW90OywNCiAgICAgICAgYXJncy0mZ3Q7aW4ucHJpb3JpdHkpOw0KICAgICAgICA8YnI+
DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0
dXJuIC1FSU5WQUw7DQogICAgICAgIDxicj4NCiAgICAgICAgKyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyByID0gLUVJTlZBTDsNCiAgICAgICAgPGJyPg0KICAgICAg
ICArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGdvdG8gb3V0X2N0
eDsNCiAgICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
fQ0KICAgICAgICA8YnI+DQogICAgICAgICZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgc3dpdGNoIChhcmdzLSZndDtpbi5vcCkgew0KICAgICAgICA8YnI+DQogICAgICAgICZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBjYXNlIEFNREdQVV9TQ0hFRF9PUF9QUk9DRVNT
X1BSSU9SSVRZX09WRVJSSURFOg0KICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgciA9IGFtZGdwdV9zY2hlZF9wcm9jZXNzX3By
aW9yaXR5X292ZXJyaWRlKGFkZXYsDQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBh
cmdzLSZndDtpbi5mZCwNCiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFyZ3MtJmd0
O2luLnByaW9yaXR5KTsNCiAgICAgICAgPGJyPg0KICAgICAgICArJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIFJldHJpZXZlIGFsbCBjdHggaGFuZGxlcyBhbmQg
b3ZlcnJpZGUgcHJpb3JpdHkmbmJzcDsgKi8NCiAgICAgICAgPGJyPg0KICAgICAgICArJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlkcl9mb3JfZWFjaF9lbnRyeSgm
YW1wO2Zwcml2LSZndDtjdHhfbWdyLmN0eF9oYW5kbGVzLA0KICAgICAgICBjdHhfcHRyLCBpZCkN
CiAgICAgICAgPGJyPg0KICAgICAgICArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFtZGdwdV9jdHhfcHJpb3JpdHlfb3Zl
cnJpZGUoY3R4X3B0ciwNCiAgICAgICAgYXJncy0mZ3Q7aW4ucHJpb3JpdHkpOw0KICAgICAgICA8
YnI+DQogICAgICAgICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBicmVhazsNCiAgICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgY2FzZSBBTURHUFVfU0NIRURfT1BfQ09OVEVYVF9QUklPUklUWV9PVkVS
UklERToNCiAgICAgICAgPGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IHIgPSBhbWRncHVfc2NoZWRfY29udGV4dF9wcmlvcml0eV9vdmVycmlk
ZShhZGV2LA0KICAgICAgICA8YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYXJncy0mZ3Q7aW4uZmQs
DQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhcmdzLSZndDtpbi5jdHhfaWQsDQog
ICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhcmdzLSZndDtpbi5wcmlvcml0eSk7DQog
ICAgICAgIDxicj4NCiAgICAgICAgKyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyAvKiBPdmVycmlkZSBwcmlvcml0eSBmb3IgYSBnaXZlbiBjb250ZXh0ICovDQogICAg
ICAgIDxicj4NCiAgICAgICAgKyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBhbWRncHVfY3R4X3ByaW9yaXR5X292ZXJyaWRlKGN0eCwNCiAgICAgICAgYXJncy0mZ3Q7
aW4ucHJpb3JpdHkpOw0KICAgICAgICA8YnI+DQogICAgICAgICZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBicmVhazsNCiAgICAgICAgPGJyPg0K
ICAgICAgICAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZGVmYXVsdDoNCiAgICAgICAg
PGJyPg0KICAgICAgICAtJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IC8qIEltcG9zc2libGUuDQogICAgICAgIDxicj4NCiAgICAgICAgLSZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqLw0KICAgICAgICA8YnI+DQogICAgICAg
ICsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRFJNX0VSUk9SKCZx
dW90O0ludmFsaWQgc2NoZWQgb3Agc3BlY2lmaWVkOiAlZFxuJnF1b3Q7LA0KICAgICAgICBhcmdz
LSZndDtpbi5vcCk7DQogICAgICAgIDxicj4NCiAgICAgICAgJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHIgPSAtRUlOVkFMOw0KICAgICAgICA8
YnI+DQogICAgICAgIC0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
YnJlYWs7DQogICAgICAgIDxicj4NCiAgICAgICAgKyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBnb3RvIG91dF9jdHg7DQogICAgICAgIDxicj4NCiAgICAgICAgJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH0NCiAgICAgICAgPGJyPg0KICAgICAgICAmbmJz
cDsgKyZuYnNwOyZuYnNwOyZuYnNwOyByID0gYW1kZ3B1X2N0eF9nZXRfZW50aXR5KGN0eCwgYXJn
cy0mZ3Q7aW4uaXBfdHlwZSwgMCwNCiAgICAgICAgYXJncy0mZ3Q7aW4ucmluZywNCiAgICAgICAg
PGJyPg0KICAgICAgICArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7ICZhbXA7ZW50aXR5KTsNCiAgICAgICAgPGJyPg0KICAgICAgICArJm5ic3A7Jm5ic3A7Jm5i
c3A7IGlmIChyKQ0KICAgICAgICA8YnI+DQogICAgICAgICsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgZ290byBvdXRfY3R4Ow0KICAgICAgICA8YnI+DQogICAgICAg
ICsNCiAgICAgICAgPGJyPg0KICAgICAgICArJm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIEZldGNoIGFt
ZGdwdV9yaW5nIHBvaW50ZXIgKi8NCiAgICAgICAgPGJyPg0KICAgICAgICArJm5ic3A7Jm5ic3A7
Jm5ic3A7IHJpbmcgPSB0b19hbWRncHVfcmluZyhlbnRpdHktJmd0O3JxLSZndDtzY2hlZCk7DQog
ICAgICAgIDxicj4NCiAgICAgICAgKw0KICAgICAgICA8YnI+DQogICAgICAgICsmbmJzcDsmbmJz
cDsmbmJzcDsgLyogUGFzcyBzY2hlZCBpbmZvIHRvIHVzZXJzcGFjZSAqLw0KICAgICAgICA8YnI+
DQogICAgICAgICsmbmJzcDsmbmJzcDsmbmJzcDsgbWVtc2V0KGFyZ3MsIDAsIHNpemVvZigqYXJn
cykpOw0KICAgICAgICA8YnI+DQogICAgICAgICsmbmJzcDsmbmJzcDsmbmJzcDsgYXJncy0mZ3Q7
b3V0LmluZm8ucGlwZSA9IHJpbmctJmd0O3BpcGU7DQogICAgICAgIDxicj4NCiAgICAgICAgKyZu
YnNwOyZuYnNwOyZuYnNwOyBhcmdzLSZndDtvdXQuaW5mby5xdWV1ZSA9IHJpbmctJmd0O3F1ZXVl
Ow0KICAgICAgICA8YnI+DQogICAgICAgICsNCiAgICAgICAgPGJyPg0KICAgICAgICArb3V0X2N0
eDoNCiAgICAgICAgPGJyPg0KICAgICAgICArJm5ic3A7Jm5ic3A7Jm5ic3A7IGFtZGdwdV9jdHhf
cHV0KGN0eCk7DQogICAgICAgIDxicj4NCiAgICAgICAgK291dF9mZDoNCiAgICAgICAgPGJyPg0K
ICAgICAgICArJm5ic3A7Jm5ic3A7Jm5ic3A7IGZkcHV0KGYpOw0KICAgICAgICA8YnI+DQogICAg
ICAgICsNCiAgICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgcmV0dXJuIHI7DQogICAgICAgIDxicj4NCiAgICAgICAgJm5ic3A7IH0NCiAgICAgICAgPGJy
Pg0KICAgICAgICBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCiAg
ICAgICAgYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaA0KICAgICAgICA8YnI+DQogICAg
ICAgIGluZGV4IDFkNjVjMWZiYzRlYy4uZTkzZjFiNmM0NTYxIDEwMDY0NA0KICAgICAgICA8YnI+
DQogICAgICAgIC0tLSBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQogICAgICAgIDxi
cj4NCiAgICAgICAgKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCiAgICAgICAg
PGJyPg0KICAgICAgICBAQCAtNzAsNyArNzAsNyBAQCBleHRlcm4gJnF1b3Q7QyZxdW90OyB7DQog
ICAgICAgIDxicj4NCiAgICAgICAgJm5ic3A7ICNkZWZpbmUgRFJNX0lPQ1RMX0FNREdQVV9XQUlU
X0ZFTkNFUyZuYnNwOyZuYnNwOyZuYnNwOw0KICAgICAgICBEUk1fSU9XUihEUk1fQ09NTUFORF9C
QVNFICsgRFJNX0FNREdQVV9XQUlUX0ZFTkNFUywgdW5pb24NCiAgICAgICAgZHJtX2FtZGdwdV93
YWl0X2ZlbmNlcykNCiAgICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsgI2RlZmluZSBEUk1fSU9D
VExfQU1ER1BVX1ZNJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IERS
TV9JT1dSKERSTV9DT01NQU5EX0JBU0UgKw0KICAgICAgICBEUk1fQU1ER1BVX1ZNLCB1bmlvbiBk
cm1fYW1kZ3B1X3ZtKQ0KICAgICAgICA8YnI+DQogICAgICAgICZuYnNwOyAjZGVmaW5lIERSTV9J
T0NUTF9BTURHUFVfRkVOQ0VfVE9fSEFORExFDQogICAgICAgIERSTV9JT1dSKERSTV9DT01NQU5E
X0JBU0UgKyBEUk1fQU1ER1BVX0ZFTkNFX1RPX0hBTkRMRSwgdW5pb24NCiAgICAgICAgZHJtX2Ft
ZGdwdV9mZW5jZV90b19oYW5kbGUpDQogICAgICAgIDxicj4NCiAgICAgICAgLSNkZWZpbmUgRFJN
X0lPQ1RMX0FNREdQVV9TQ0hFRCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBEUk1fSU9XKERSTV9DT01NQU5EX0JBU0UNCiAgICAgICAgKyBEUk1fQU1ER1BVX1NDSEVE
LCB1bmlvbiBkcm1fYW1kZ3B1X3NjaGVkKQ0KICAgICAgICA8YnI+DQogICAgICAgICsjZGVmaW5l
IERSTV9JT0NUTF9BTURHUFVfU0NIRUQmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgRFJNX0lPV1IoRFJNX0NPTU1BTkRfQkFTRQ0KICAgICAgICArIERSTV9BTURHUFVf
U0NIRUQsIHVuaW9uIGRybV9hbWRncHVfc2NoZWQpDQogICAgICAgIDxicj4NCiAgICAgICAgJm5i
c3A7ICZuYnNwOyAvKioNCiAgICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsmbmJzcDsgKiBET0M6
IG1lbW9yeSBkb21haW5zDQogICAgICAgIDxicj4NCiAgICAgICAgQEAgLTMwOCw2ICszMDgsMTEg
QEAgdW5pb24gZHJtX2FtZGdwdV92bSB7DQogICAgICAgIDxicj4NCiAgICAgICAgJm5ic3A7ICNk
ZWZpbmUgQU1ER1BVX1NDSEVEX09QX1BST0NFU1NfUFJJT1JJVFlfT1ZFUlJJREUmbmJzcDsmbmJz
cDsmbmJzcDsgMQ0KICAgICAgICA8YnI+DQogICAgICAgICZuYnNwOyAjZGVmaW5lIEFNREdQVV9T
Q0hFRF9PUF9DT05URVhUX1BSSU9SSVRZX09WRVJSSURFJm5ic3A7Jm5ic3A7Jm5ic3A7IDINCiAg
ICAgICAgPGJyPg0KICAgICAgICAmbmJzcDsgK3N0cnVjdCBkcm1fYW1kZ3B1X3NjaGVkX2luZm8g
ew0KICAgICAgICA8YnI+DQogICAgICAgICsmbmJzcDsmbmJzcDsmbmJzcDsgX191MzIgcGlwZTsN
CiAgICAgICAgPGJyPg0KICAgICAgICArJm5ic3A7Jm5ic3A7Jm5ic3A7IF9fdTMyIHF1ZXVlOw0K
ICAgICAgICA8YnI+DQogICAgICAgICt9Ow0KICAgICAgICA8YnI+DQogICAgICAgICsNCiAgICAg
ICAgPGJyPg0KICAgICAgICAmbmJzcDsgc3RydWN0IGRybV9hbWRncHVfc2NoZWRfaW4gew0KICAg
ICAgICA8YnI+DQogICAgICAgICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAvKiBBTURH
UFVfU0NIRURfT1BfKiAqLw0KICAgICAgICA8YnI+DQogICAgICAgICZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBfX3UzMiZuYnNwOyZuYnNwOyZuYnNwOyBvcDsNCiAgICAgICAgPGJyPg0K
ICAgICAgICBAQCAtMzE1LDEwICszMjAsMTcgQEAgc3RydWN0IGRybV9hbWRncHVfc2NoZWRfaW4g
ew0KICAgICAgICA8YnI+DQogICAgICAgICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAv
KiogQU1ER1BVX0NUWF9QUklPUklUWV8qICovDQogICAgICAgIDxicj4NCiAgICAgICAgJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IF9fczMyJm5ic3A7Jm5ic3A7Jm5ic3A7IHByaW9yaXR5
Ow0KICAgICAgICA8YnI+DQogICAgICAgICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBf
X3UzMiZuYnNwOyZuYnNwOyBjdHhfaWQ7DQogICAgICAgIDxicj4NCiAgICAgICAgKyZuYnNwOyZu
YnNwOyZuYnNwOyBfX3UzMiZuYnNwOyZuYnNwOyBpcF90eXBlOw0KICAgICAgICA8YnI+DQogICAg
ICAgICsmbmJzcDsmbmJzcDsmbmJzcDsgX191MzImbmJzcDsmbmJzcDsgcmluZzsNCiAgICAgICAg
PGJyPg0KICAgICAgICArfTsNCiAgICAgICAgPGJyPg0KICAgICAgICArDQogICAgICAgIDxicj4N
CiAgICAgICAgK3N0cnVjdCBkcm1fYW1kZ3B1X3NjaGVkX291dCB7DQogICAgICAgIDxicj4NCiAg
ICAgICAgKyZuYnNwOyZuYnNwOyZuYnNwOyBzdHJ1Y3QgZHJtX2FtZGdwdV9zY2hlZF9pbmZvIGlu
Zm87DQogICAgICAgIDxicj4NCiAgICAgICAgJm5ic3A7IH07DQogICAgICAgIDxicj4NCiAgICAg
ICAgJm5ic3A7ICZuYnNwOyB1bmlvbiBkcm1fYW1kZ3B1X3NjaGVkIHsNCiAgICAgICAgPGJyPg0K
ICAgICAgICAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RydWN0IGRybV9hbWRncHVf
c2NoZWRfaW4gaW47DQogICAgICAgIDxicj4NCiAgICAgICAgKyZuYnNwOyZuYnNwOyZuYnNwOyBz
dHJ1Y3QgZHJtX2FtZGdwdV9zY2hlZF9vdXQgb3V0Ow0KICAgICAgICA8YnI+DQogICAgICAgICZu
YnNwOyB9Ow0KICAgICAgICA8YnI+DQogICAgICAgICZuYnNwOyAmbmJzcDsgLyoNCiAgICAgICAg
PGJyPg0KICAgICAgPC9ibG9ja3F1b3RlPg0KICAgICAgPGJyPg0KICAgIDwvYmxvY2txdW90ZT4N
CiAgICA8YnI+DQogIDwvYm9keT4NCjwvaHRtbD4NCg==

--------------MMhI0N5gEU8mMPAsoZYl0MmK--
