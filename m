Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF7EC46467
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 09:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7634910E506;
	Wed,  4 Jan 2023 09:13:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B7710E506
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 09:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5I1Z3rU8S0Y/2C1j81BKaiIpZD6baHvwOuW3F4bprYa3DlfyTVCyCPdWXjK+ejAT1oS9lQQytgBZkQ/uPKP2lA095cAMPjuzeadRqgbDguW03qodr3jxvRhUlVhSd94J4sRCL/7ELfdNIkk/Atz9FnJbZMuSuOsQQaILspqhd8YGAUzmYA5YS8c1g3sV5Bp4yNYuQYYqtiS0MBk/71MPCq16v5C7WRwQnVPxhNklDyW9mTZOMq0FJ3YHSWMwqkDxPRDmAUOjDH27HQayvuPQi92MmjpBtQvaPO1bdwuU6novD1AwlVREvYHKDmFEv0LcDdYYlMe8kyg55l3DCNevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2drBZgbvbuZtQ8Vo6f7HcRPm6L7fZ7xC+ynKP3mlpE0=;
 b=HV57mRBO1c1zc3P3bLInqQzHbV8Lb0SUM7kgz11GvCJ9v2i7O4vgmwZIdTJPcC6ADZRBGlCBkFda3svyj+JNhsAE3VIduwxyaYRsbeWDV/fPphKf+nlCqYH9iesB8hXn+Iz0TgZrNUBw1/GNPZnSz3+YO/Zu0hXhx5ZJiS38qEPQjuADF9EDzzs2ZWUqbckkgLFwZe2/FcsucQFmzk84v7PhP7zcSBbewHASSRv1Fqg2/LlUvZMqQCEbCJobvjQns+3j7tPzTJuclEyQf5N8GR7KzQJ2O7E1CKAFQVYG7rFZwqb6fXruXc9KpXfldLrinWHNj0lMU7T8cL3Vcx99Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2drBZgbvbuZtQ8Vo6f7HcRPm6L7fZ7xC+ynKP3mlpE0=;
 b=q2n3P1NyM8WoXuWUB/C4HoV8bjvPDIKZ5111xJWCDpZtt3/UJtCuGzd1vDUzo/jr/NJIpMstxQOVTx/y2/ui6wXERu/fKOvH0Onhax06wq8gp+VA6KxO8Rr2V4iCfo34tXUgJM6xAUD48TZaILpvcW3mefvKSytTQsVLJF5vLCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BL0PR12MB4851.namprd12.prod.outlook.com (2603:10b6:208:1c1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 09:13:14 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 09:13:14 +0000
Message-ID: <ced7bb3b-6de2-145c-ccfd-1143529f0990@amd.com>
Date: Wed, 4 Jan 2023 10:13:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 3/7] drm/amdgpu: Create MQD for userspace queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Yadav, Arvind" <arvyadav@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-4-shashank.sharma@amd.com>
 <CADnq5_NONiTu2oEEV1+epbuaH985QBbqMKuM9ZDYEn7Ar5a2pw@mail.gmail.com>
 <d19ada1d-86c1-7278-9bf2-a7571c2830e1@amd.com>
 <a71ce770-7e36-0589-2c47-b0381566541c@amd.com>
 <a75feb71-1121-63cd-5292-503588ee9c88@amd.com>
 <a168df59-8cd3-0262-473a-c4b5f63dc491@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <a168df59-8cd3-0262-473a-c4b5f63dc491@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BL0PR12MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: f04c66d3-6177-4691-0a03-08daee33e883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAIpSvKKp7p/oi1Ro1eMpm6fOa659RHzj7FU2aAYpVa3YIiCwGxYjP2tGvAVamyFVZJFkoy1RndDgmf4Kaokl/5ly3X1xyu7w8+Ou0RAhzRvwjNFoGORznGtPbZVol/LdC9rDL3r+RSn1Wy1uY/uwcjKHFhSlJhdwbCD2iJLWHs/AzjmJSHc4sgbrnPpo0JZCob7+gUFO+znK9eEuaOOMTibzyLFxAoERo7KTO5Q77W+26JllnhMMsIjpqOURFrHj8+xTjTKiNbbMZ5kk3pAh8Ks1qx5lQmPrkT8SDWp4pMk2Tqs+d0WxS5VA+3nQukTOIuaakPnG/eTIu4f6gMSflEQQVkUxVm2Vxab25oqK6WLoLNRFgxtU8EsQ8HiLGlPNCdw7R8pQG/9o+9EvqPfFUF0sbIkWe63SqIfZ0DIL7T4u72FYfrEoBLn3Dy1a883dKb/+ciYCThhkrfUkz/IaBuBOHo238vJQfZD0a6l5iu8hwIcNGzUZwWaAn1U51oMFV9YmCUpbwOobZGp6VV/Zd1cFUeRvMR8z1NRsbEDqtxMNQRi6/4RsOfdp54pH1wh3MBkemaQWCsFS11VFUay4zcTWUIWtsImGF2pxEC/v2X5YDUrJdJi5O2GsmNqVCQXHMcdEHjaBWOsTL7Q5IXgFW8ovuWEiODoIqU8rw6OF/3v85ssigqMMjRGcjx0CToULYP8JzpsFg1ibKUZLuPqiR64+arQ1nCDalpzNb2RmhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(2616005)(66574015)(83380400001)(31696002)(86362001)(38100700002)(36756003)(2906002)(44832011)(110136005)(41300700001)(4326008)(5660300002)(66556008)(66476007)(8676002)(66946007)(8936002)(316002)(26005)(53546011)(186003)(478600001)(6512007)(6486002)(31686004)(6506007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHZ2dG5MVU1KOVd1Mm9YVzdIdnpzaU5FQm0yVUowc2xuc0hJbU0yZXUzKytH?=
 =?utf-8?B?cmRFZG8rZ3RlSjVIYmxHTU5Mck9BWnUvcWZNci9GL0tCMTB1ZHV1VStZcC9a?=
 =?utf-8?B?N1NudXhuQ21RSkFmWEVVbm9HK0Zoczg0VjJVR1NERVlzVHM1TXZ2ZWhIQ0tK?=
 =?utf-8?B?ZGdNZ3NtSUtPNk14c1hncnVrbUlXMk1qNGFBa3JaTlZ6Z1dKbjNXRDJYemdi?=
 =?utf-8?B?enNNWFFJT3pHVk5CUXpZYUREcGlDZEkwYmtRb2JCbGxmeUhMMDR5ZElqWjd3?=
 =?utf-8?B?MDZVQnFOcTIwZFo5K2JDWHE1L2IzcWIzeWJKa0Fod3dxMktEQWo5VTNpUU5y?=
 =?utf-8?B?Y1VSQ1hta1dHUllTNWNHcExmbjdGVXoxVDJuWEg3dkxGbXFIREJsOUhJZnYr?=
 =?utf-8?B?MDhiVlNKdDREZkJ4TTF6SlZ3c0dOY0s2RXpXNFZTUG9jZFp0TGdJb0hMa3BX?=
 =?utf-8?B?VkVhekpodzdsK3lQSFhQTUQ1bW1vYzJsUFFtUEhqM240SkRDcDZkSVFPTTRr?=
 =?utf-8?B?UldXbFRMTVhiN2RwVTVsZXRCWnVYUFBudENuaXN4ZG9pcHFtMFBLSllvSXFV?=
 =?utf-8?B?V2lqeDdHY000US9YN2JncTlkcjZyV21ybzRNdE82cVhvN3JtZkw4djFiRTJn?=
 =?utf-8?B?OE5nRDlRRFdJbXowWFZuR3NVbjRXcWYvS21hT2RNV3hpRG9rUkxlazlSQmo2?=
 =?utf-8?B?ejJUWHY2SDlmY3lnVzc3QVV4blc3bjREQUxsMG5nY3h4eG9YMEV3Y1EvVmJE?=
 =?utf-8?B?UE1ZQzQ2eTI5cXVlcnpza3QyTjNXQktpblNJZ05DdWMwZVQ0Sit2Z3E2MzJW?=
 =?utf-8?B?aFdRclNkdUJ3UGRQUnJpVGVQQW9qT0FMc1dvMnh5VHk1OVlVT2tXRW9GZlRv?=
 =?utf-8?B?OXp0TVhKMXRRck5IcEdtUkduazZFc0RoWWs4UE1salh5bDZhNjBCdHJzRVhS?=
 =?utf-8?B?NndvRnRsdWp0MURlVncwOWNKSGFjeEVaZ0JISE56dnd3dklRV0NQZmRvbGxX?=
 =?utf-8?B?T0w4VVkxR1NXRFlZanZhd28zWktydHBKdUE1UU5RRVBydHcyTVh2Y1RiazBQ?=
 =?utf-8?B?MkR2RDlXQmgvazhIOFZQZkxaWFBYT3N3dDNMRWdad3plbEFnUVYyVk93MXZX?=
 =?utf-8?B?dXBCSURuams0UEZjUWUvLzRRZXo5UXQrcjN3ZVZwRmUxb0ZKTU9aWWlwNWRL?=
 =?utf-8?B?MTdyRFNDbGFlaEZ2b0tPVmRRZWtnak9jZGxZYlhOZEwwUndzRjdWQmhrVmN4?=
 =?utf-8?B?NmZ1RHVMMmtBZXlNTTE5TlY2WXVJZVNGQ1MyWmtmYlMvbW9lbk5NUEw0VDU2?=
 =?utf-8?B?U3cwYUJmOW9XcmFjZmRrZWNXRmpXVVlQeWFWeURkS1BobGxibkZDTGR4RkZ4?=
 =?utf-8?B?NURUNUlibWFhTmI0MFhlcVFVbmJENXhjSWh4eklZRm9HUWxKL1FIT01kLzV0?=
 =?utf-8?B?M3RpZ2NrQlRET0pLWmtDamJxOElaeG9oSW4xMitmYUxWNFFUTTVNZmlKaWJV?=
 =?utf-8?B?RHNnQlVmT0NSRjcyT0hmdXExS1NRa2dKR3dNd3h2YmwzZGxLY2tzV2NQdXcy?=
 =?utf-8?B?NWxIQnRhMFNlSGVCUmlNc2hrYlRPT0pCdjViaHJYK1FLV0FsRURBdzZTd2ov?=
 =?utf-8?B?OXU2K0lLV2lIVVlJNnNPN2JGOTdLdjh5TGNZTnN1dC9jRTJNMGtuZnZrYSt4?=
 =?utf-8?B?dmZ2c2doamVBK3NCczMrTmI1dXc0SmxBelV2MldRZXpFMkRjczhyWTJxeDA0?=
 =?utf-8?B?QUtaNm1nSGhaSCsvYkFCNjJKT0dQc0cvZUJtMEFZKzRDRnpvYkpVQXUzOHE1?=
 =?utf-8?B?akE1M0MzVk95UDV2YmV3RUh5VDUwRkUxTXhUdm9HbVpxRUw0b2lhOXZpTW9E?=
 =?utf-8?B?QkEwNXBDeWJ2Y3BjV2dYc0k1TTljTHFwVTV1NmNXajlyeUYrVlByTzJxelBQ?=
 =?utf-8?B?d2JBajJ1U2s5bzN6clNqZndWTjZ4NGUrYUtVbnNpdGRKQ1ZqNnRBY3JkZVJG?=
 =?utf-8?B?ZTNEOEpYVm5XZW1jcXZVTnZzcE8zRTY0Y3RXZWxtQkF4TlhCTVZORzlTVDN3?=
 =?utf-8?B?eWlrNmNDYlorbkVuSTZwNklvWTFIVHZSYXpZZ2pwVDRUQS9jSkwxWitsR0Ru?=
 =?utf-8?Q?t/mgVSmwDec83SRZc2Qd58YN7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04c66d3-6177-4691-0a03-08daee33e883
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 09:13:14.0490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVZiqWgYNwomrWGtJjFbeVEHe//9+uZmmmhA729x0T6CwG19KqORaIplBj6BMhC3p5ZI5k7WWSaMsIos6G70uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4851
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 arvind.yadav@amd.com, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 04/01/2023 10:10, Christian König wrote:
> Am 04.01.23 um 07:21 schrieb Yadav, Arvind:
>>
>> On 1/4/2023 12:07 AM, Felix Kuehling wrote:
>>> Am 2023-01-03 um 04:36 schrieb Shashank Sharma:
>>>>>> /*MQD struct for usermode Queue*/
>>>>>> +struct amdgpu_usermode_queue_mqd
>>>>> This is specific to GC 11.  Every IP and version will have its own 
>>>>> MQD
>>>>> format.  That should live in the IP specific code, not the generic
>>>>> code.  We already have the generic MQD parameters that we need from
>>>>> the userq IOCTL.
>>>>
>>>> Noted, we can separate out the generic parameters from gen specific 
>>>> parameter, and will try to wrap it around the generic structure.
>>>>
>>>> - Shashank
>>>
>>> Is there a reason why you can't use "struct v11_compute_mqd" from 
>>> v11_structs.h?
>>
>> Hi Felix,
>>
>> Yes,  V11_compute_mqd does not have these below member which is 
>> needed for usermode queue.
>>
>>     uint32_t shadow_base_lo; // offset: 0  (0x0)
>>     uint32_t shadow_base_hi; // offset: 1  (0x1)
>>     uint32_t gds_bkup_base_lo ; // offset: 2  (0x2)
>>     uint32_t gds_bkup_base_hi ; // offset: 3  (0x3)
>>     uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>>     uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>>     uint32_t shadow_initialized; // offset: 6  (0x6)
>>     uint32_t ib_vmid; // offset: 7  (0x7)
>>
>> So we had to add new MQD structs.
>
> Would it make more sense to update the existing MQD structures than 
> adding new ones?
>
Imo, It might be a bit complicated in the bring-up state, but we can 
take a note of converting this structure into a union of two, or may be 
renaming it into a superset structure.

- Shashank

> Regards,
> Christian.
>
>>
>> thanks
>>
>> ~arvind
>>
>>>
>>> Regards,
>>>   Felix
>>>
>
