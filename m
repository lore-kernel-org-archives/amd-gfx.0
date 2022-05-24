Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BA7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 09:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6143A10F34B;
	Tue, 24 May 2022 09:54:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC4110F336
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 09:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNmQXhpqkaUQAubPrJlJLkYpolZnM4e2WMhEv0JjAroPn2BDUpWDpL/LEFOkV+wByc4PxvbmvPhjoRE5PUQ+nAL33dnqp3+29mdJJHINsPhhdzc3IOaPoHsEpHEBEupZMQ3CG2HUPslLrohOkXAMiWmgdDkNxUZnVosmmNW/EOLPpduoLDEqEwLroFyubnxTvkx5JVQ6Kqt3d7M+OSRZ1k+x6k5xtYYQnCD9omu1Brf8eJzhW0w0gaWZ9QjWT6WtJKYOLZq2xcgEAIFmiCTN++IzufIGxY2O67xQJpJ9V9u4UlZjTG5pgtJUH/5XAzDw6wQNBNB2Mw3x1ie9VQVxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CB1CLpfN7p5SnuEoc8ZFIDlKtpd2A8STgF/DqGuUIY=;
 b=FxrKR4b8jlfBZqSU5DERzMKb6TxZpfoZ4jIsnLJVGS1yPVXfGFfrMmDeYwX/k4hkry/2ILVN/T1lSB6eQ81uFzkzjqpayB5MiPF0uvIqIxP1yo3LVujduEFGjLA5snkpFny4oC/neUR34U3BJqNANZgDdEA9OmgzAkpzaWomdsL6rm4wqw4GVf3EAWY5GI7Y8+L6Ab1XJd1UG89Vxf7dBkYPGYw869iVQuakV8c39kPkCbBbxxfaH8UUMODTo81zkFZqCP3uJUkvOcuNC25gzI+hIuVlJvx98QRfMaemRpnEnYZtpCfYI/bifoqHRnThWx5F3vhs3oq2x4PP8G5Pyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CB1CLpfN7p5SnuEoc8ZFIDlKtpd2A8STgF/DqGuUIY=;
 b=iHvGINoYwO9aO3MtLRV0Kd1/ZHtB+Ti+D2oXrtQCwPF7MsDv6yeAZmBRzuDKQjZ07EQmrrcqllOVWhm9wVO4/8kwAg8gXboVrmMJGxL5eHulqTQ1kEXPI6vqB9oZLByAu2LivR/fDr2uSgYvbOSEP+kyQV5U4pejLjAwqLIs7WE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB3599.namprd12.prod.outlook.com (2603:10b6:208:d2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 09:54:02 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3%2]) with mapi id 15.20.5227.023; Tue, 24 May 2022
 09:54:02 +0000
Message-ID: <2e8b9ebe-3d1f-40e5-73e3-54607a8045cb@amd.com>
Date: Tue, 24 May 2022 11:53:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 2/2] drm/amdgpu: adding device coredump support
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <20220520134909.92781-2-Amaranath.Somalapuram@amd.com>
 <588a0599-7d0c-0041-9877-4429b416e7ed@amd.com>
 <18da952a-25d7-1d52-5d1b-016432066211@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <18da952a-25d7-1d52-5d1b-016432066211@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0252.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::27) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68d6bfc2-2eb6-4a36-456b-08da3d6b5512
X-MS-TrafficTypeDiagnostic: MN2PR12MB3599:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3599FF83EF8AB0F6607CE4A1F2D79@MN2PR12MB3599.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUFjs9E9JaFFMUqteekTrU3zxf4yUDbPXrLEwA+mSEgjKYQG+TzcyYAKHSv+nn6IN5lbWIyr+ELLW59bKwrahViz2s+d966O3zwIxDR/822sA1wyWcQjHuxZYWON3Aud2kngGJcfuNbQBz9jVgvbYrhUrU7I6m3uP3OQPfCMPZ5HDUd0+uhNlFH15lrzkJyV8cPSpFV22qUVGLlVv11fyi9gk6m41nmPoPXil3bjkwpNG4Wlq8Pkf+L22ilZICaRG6MhpIyzq/mei/W5BHaTiqSkA3oRPTahe+4fFUVwJtR7qaFcpR9d8TwF3HmJk2k57eQ+e542qcTagX+853VTf+/8QfEffOqWwcYaptIKn0CMHoMCsyT0zlScUKXkMI2oQcRpHJzYqbeDaRONovQ1OUuX+SYVyV0KgATH0Y7PlARb0GCUJnndMEDkP9xkQ1JxC5oHUJZTHfzaoZgnlhpIHEIuOH+sCVMD0uSxZqvzvyK8JCWiad9PkmVa+ATmSsmC4Ktt9xmBOKmKBUr1WXnEz732tjmfOopO5WPBH6R9xbe55LtfVKOPQPaOvgZ91BPoGVBoTIKTz0YPpKys4dTbU7zvIknZLY30AhFXEXEhhOvnHX01bEp6ygh1ht9g1yxCF+fBNPDjv2YDSY/Vhs6rDMooUCTbdPF0VthJtKDfoD5UvMD/bwLbGZz7eOJT40VCLhucxcE7uYbh+P3RTDOvwiWHvfstki8NnmgOqR6NCEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(53546011)(38100700002)(6506007)(6666004)(66946007)(66476007)(110136005)(508600001)(6486002)(316002)(2906002)(6512007)(2616005)(8676002)(26005)(4326008)(5660300002)(31686004)(8936002)(66556008)(86362001)(36756003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1ZlZGFjU28wMDNaZDVpOUpyeG5FeUNEZFNlNWJBZU1aOVhTdE5tSys2eUxK?=
 =?utf-8?B?T2VhOGxnd1Q2MFlBQUp3TU9LamxGQ3BOV3JMSDgvTnMrN2hqaFc5ZDNyNjU2?=
 =?utf-8?B?REdKbzVqNXRFWjU3Z1hnSGcxSm1PZkgxdU9vSEhIeXdHRkRBOXdIY08wYzY1?=
 =?utf-8?B?aHdXcWlZQlkxM1R3Zy9yckhWZDZTZk5mUVpwWHByWHpzWmNFK2dYQzFzc1c3?=
 =?utf-8?B?SnI5NFV4enc0SnY2SEVNY3ZXWW1uczNGYTJ4bVBjdVZWK1I3Ky9VSW1FbjFn?=
 =?utf-8?B?eEN5eHdkYkVjMlFteWRLbVhTd045alZHbFc3QVJOcWt3cnh2ZTl0NnByeXBJ?=
 =?utf-8?B?ZmltT042d1BzSkNBdGFUa3BhSDVxOStXTnMzSzNUM3BMVlJOTWNWT0tzQWNT?=
 =?utf-8?B?aVBVbjFVaFU5NWpPRU0vZDkxMVhtNUk1Q290T3hrUzJJZEJqdXFkcG9pN000?=
 =?utf-8?B?ditBSlhCUXpIUFFBd2dHS2lOaGs1cnZITTJsaVlnSjczbW55RDdTYmtCbER6?=
 =?utf-8?B?MGt5MW1PY0RqMmJmeThjVTJDR3JGWXJWZTMvcWttZ1JoR2RLbk9SVk9wbUhl?=
 =?utf-8?B?TjRGVWxva09FN2JHbVVVYmtDS0ZDYjZjQzVOYUFZcE9NTHNhdGdRSzFyeXRp?=
 =?utf-8?B?VEtjczdDNDBEMm92VHZrOHR3RFBNSmcydk4xMVNWTkkreXNPUlliSWE2bTlE?=
 =?utf-8?B?RnptRUZsVVBwWW1sUzFnTUFoNXViREFNVktzdkNwQ3o3dnRyWDhLUkVDNm0v?=
 =?utf-8?B?UTI3dzN1MStKSklNYmlRUjdJRzl5TWo3WlFrMXVYTzljZ1daVWtyODAzR2Q0?=
 =?utf-8?B?SXlmZm5NRlNwL1dBaU5xdEpiSHVYalMzOHZCaHNjNFF5Y0xpcUpIRGZwT2U1?=
 =?utf-8?B?Umd6Ukh0TlFFSkZBZ0NXYzc0Z09Bdy9xVi9hNys4NVlGVExldHo2RFlGRFlV?=
 =?utf-8?B?cW5rZ2RJVmlBU1kzQkVmdGVjRzZjWXVBNnlmZS9RbzFJUSt4eWNoMjFnVVpW?=
 =?utf-8?B?eVNIWlU3MTFoek5GM0ZTQy8ybjJaTEVpQTZmRkpHWk10VjdveVNZVzF6cUVQ?=
 =?utf-8?B?aVM4TW1ud2NpamlUR2ZsVGVQanRHNU03WFFrcUFMZU5HQ1hmYmRxNHNFVm5B?=
 =?utf-8?B?OUhkY21ld1ErejM5akF5ZEZ5SVEybGJTeUF5bGZGakZobjRybnVrV3BxWDhZ?=
 =?utf-8?B?a0UxSHQvMklkY0p6emtJK09MK2NRRCtQY09tRk40UWxwMHd1N0hoR3BSNDBy?=
 =?utf-8?B?Z3VSRkQwRFhHVU5aZHNRZW1hUHhiRUhTVy9WTktCWTIwcFpaNTkrbENlVzdH?=
 =?utf-8?B?UWd3WlJ6aVZ5U3RVMVdsVTgrQWVpOFh1ajNCNnZMczRXYzdaaEhiZGtCbkZJ?=
 =?utf-8?B?RGZLbnJERVVNQ0trZlFvTE9nbzJNSEpvVTJiKys5aGIzS1BmWEViR1EvUHhu?=
 =?utf-8?B?QkVYTTJZVitJb3FkZU1TdVY4NzIvK3QzNWpKUjNZbTQ3RzNWVUhYNWd0Q2cw?=
 =?utf-8?B?ZFpiQW8xdmx1Y1JqRVR1RlEwTHhhbXVyeU5wRlFNNzZZZXZ1akVCU1RLYm0x?=
 =?utf-8?B?UFUyVExnNFZQdzhsTFp4UnJMeVJiNjlzSmFMQ2Y0a0IxeUZzcmdTa1ZQUjRt?=
 =?utf-8?B?K21BSTBtb1JrUEZQbmlRSFdETGZycnVIZXhoZmFlaXZ3cFk5bEo0RXdFL01H?=
 =?utf-8?B?bFJYNVA5MStGOUZ4VlFNYVNEQkxyRTdraWtrRTFUV0hpVFJjUGRESnYrUzE0?=
 =?utf-8?B?NjArdGdsY2lMcmpXd296UXl0dVdwa2h1RFI5c3JQRk03QVRsTkwrdzhyVXFC?=
 =?utf-8?B?QWxjd1BmZytTRWt6RHY1RUJSZFJIZ2VZaEVxcXFSYnlyd2lMdm4rRTV2eWt6?=
 =?utf-8?B?SXMydjRsVFF1UVVFRWJVd09BVmZaMG1xRkJuVWZXaXRkZW0xRE9UMlV0WHB2?=
 =?utf-8?B?TEhXNE5ueDdvRUtQWkQvVU92dW8vcHVYQW5ESitPM2VpRW9CTFVFMVAwWjNy?=
 =?utf-8?B?RUlRUjhNU3N0VklnYWxmSDU4L0g4MWx5UXQ1TlcwTkdISmhWajdkWkgxWVRl?=
 =?utf-8?B?emI5cUJJRks0SEFaL1pFRU4vQm83cE9KZ2lPUzQyK0o5TXhyejZVeGU0VVhW?=
 =?utf-8?B?SkFFN0xkMUJ5N3k3UCtRWmdVUDhOcVFRNzF4Q3IvZGlyRWhmMXhmNE9NRGhu?=
 =?utf-8?B?QnA4VnBMUVpXWUxPOEJsaFUySVFRSnlBeE94ZW8vVlJJV2JVa21FMHVUYlBa?=
 =?utf-8?B?Z3BiRGZQL1RVT2NUbStvMDdkaDdCMmVDTWVQdi9SclZkNk55eDB3V3ZZOGhB?=
 =?utf-8?B?SFRuWWY2SllJamg1dUFwOE9NM1I5YjJaK0F1UEpiUlJ0WStYSnNwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d6bfc2-2eb6-4a36-456b-08da3d6b5512
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 09:54:02.7370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfbBr8KZO2ZA8MswbF1IEoQuFSJCDg207ATU6LWo7QD2EOP8ZuLm1KOEpDIFGD+71YaMW3gsLYvcIhXul/LJzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3599
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



On 5/24/2022 8:42 AM, Somalapuram, Amaranath wrote:
> 
> On 5/20/2022 7:52 PM, Sharma, Shashank wrote:
>>
>>
>> On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
>>> Added device coredump information:
>>> - Kernel version
>>> - Module
>>> - Time
>>> - VRAM status
>>> - Guilty process name and PID
>>> - GPU register dumps
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59 ++++++++++++++++++++++
>>>   2 files changed, 62 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index c79d9992b113..f28d9c563f74 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1044,6 +1044,9 @@ struct amdgpu_device {
>>>       uint32_t                        *reset_dump_reg_list;
>>>       uint32_t            *reset_dump_reg_value;
>>>       int                             num_regs;
>>> +    struct amdgpu_task_info         reset_context_task_info;
>>> +    bool                            reset_context_vram_lost;
>>
>> How about drop the 'context' from name and just reset_task_info and 
>> reset_vram_lost ?
> OK.
>>
>>> +    struct timespec64 reset_time;
>>>         struct amdgpu_reset_domain    *reset_domain;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 963c897a76e6..f9b710e741a7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -32,6 +32,8 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/iommu.h>
>>>   #include <linux/pci.h>
>>> +#include <linux/devcoredump.h>
>>> +#include <generated/utsrelease.h>
>>>     #include <drm/drm_atomic_helper.h>
>>>   #include <drm/drm_probe_helper.h>
>>> @@ -4733,6 +4735,55 @@ static int amdgpu_reset_reg_dumps(struct 
>>> amdgpu_device *adev)
>>>       return 0;
>>>   }
>>>   +#ifdef CONFIG_DEV_COREDUMP
>>> +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
>>> +        size_t count, void *data, size_t datalen)
>>> +{
>>> +    struct drm_printer p;
>>> +    struct amdgpu_device *adev = data;
>>> +    struct drm_print_iterator iter;
>>> +    int i;
>>> +
>>
>> A NULL check for 'buffer' here could prevent a segfault later.
>>
> Agreed.
>>> +    iter.data = buffer;
>>> +    iter.offset = 0;
>>> +    iter.start = offset;
>>> +    iter.remain = count;
>>> +
>>> +    p = drm_coredump_printer(&iter);
>>> +
>>> +    drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
>>> +    drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>>> +    drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>>> +    drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, 
>>> adev->reset_time.tv_nsec);
>>> +    if (adev->reset_context_task_info.pid)
>>> +        drm_printf(&p, "process_name: %s PID: %d\n",
>>> + adev->reset_context_task_info.process_name,
>>> + adev->reset_context_task_info.pid);
>> Please fix the alignment of print variables.
>>
> I will cross check this.
>>> +
>>> +    if (adev->reset_context_vram_lost)
>>> +        drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>>> +    if (adev->num_regs) {
>>> +        drm_printf(&p, "AMDGPU register dumps:\nOffset: Value:\n");
>>> +
>>> +        for (i = 0; i < adev->num_regs; i++)
>>> +            drm_printf(&p, "0x%08x: 0x%08x\n",
>>> +                    adev->reset_dump_reg_list[i],
>>> +                    adev->reset_dump_reg_value[i]);
>>> +    }
>>> +
>>> +    return count - iter.remain;
>>> +}
>>> +
>>> +static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
>>> +{
>>> +    struct drm_device *dev = adev_to_drm(adev);
>>> +
>>> +    ktime_get_ts64(&adev->reset_time);
>>> +    dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
>>> +            amdgpu_devcoredump_read, NULL);
>> instead of registering NULL as free function, I would prefer you to 
>> have a dummy no_op free function registered, which we can consume if 
>> something changes.
> you mean something like this (function without any code):
> staticvoidamdgpu_devcoredump_free(void*data)
> {
> }

Yes, precisely.

>>> +}
>>> +#endif
>>> +
>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>                struct amdgpu_reset_context *reset_context)
>>>   {
>>> @@ -4817,6 +4868,14 @@ int amdgpu_do_asic_reset(struct list_head 
>>> *device_list_handle,
>>>                       goto out;
>>>                     vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>>> +#ifdef CONFIG_DEV_COREDUMP
>>> +                tmp_adev->reset_context_vram_lost = vram_lost;
>>> +                tmp_adev->reset_context_task_info.pid = 0;
>> why is the PID hardcoded to 0 ?
> in case of reset context reset_context->job->vm  is null (possibility 
> that reset can be non VM related).
> If we don't set tmp_adev->reset_context_task_info.pid = 0, it will show 
> previous reset valid PID.
> 

But when the VM is not NULL, are we updating this PID somewhere ? I did 
not see that happening in this series.

- Shashank

> 
> Regards,
> S.Amarnath
>>> +                if (reset_context->job && reset_context->job->vm)
>>> +                    tmp_adev->reset_context_task_info =
>>> + reset_context->job->vm->task_info;
>>> +                amdgpu_reset_capture_coredumpm(tmp_adev);
>>> +#endif
>>>                   if (vram_lost) {
>>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>>>
>> - Shashank
>>                      amdgpu_inc_vram_lost(tmp_adev);
