Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E5BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 16:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B496410E67B;
	Mon, 25 Apr 2022 16:23:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D6910E42C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 16:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkxm6J87sF98uU10GPTyoxJoFzqDJkjlbB9Z4nZ6APZphoKLX0MkCy6T5/nLZs24UudxIBv5Ub1hwyy1BsJfWQ1Rag4gX3HeKe6nW+gN2cgiwBNfXek9wU+jUdHnzY0PoEJHQ6J8WmP+WYTfdjr7rG/ClcGE0vTCOaXV7HKqS/YGbrZfqgx/mhrnoy9vaP/zoaVoQVvXqtMFVyvDNCz0szppIGsS0YmCluDq5GL4gyr5ZI/awo2+nsbkQr9r1QZH4IRr8iTiRVQNTC2KXXmp9HJukl/dXSMnUtFeg+y3QRMOwjXAN0c2atOJMQILfjm1Bxe2Fh0hotKQ5guZF+fHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqiQVu4Vz1NjkkbKHOJcFBgtSp/DqHbvnZNXWVyf3NE=;
 b=kQFIjo2n2ByQbG5vXXpZZluQzClkgnFu0tdZjxhLwYZrZK9sscDeN8XyK3b1js+nWY+ovU6EX6k0SKJFbvToTtHroZJy1V+sgey7RNDfXSuk9xhd0RbGL+3yn9eMzS+bc1ZxrkP/+BD4OVY9Y40cTk/MbKsIgKSTKT84H1YnW24BhBL7Kq5AU8lwzd2xm/fSr1GdjUXmvsgyOQkQq8+5zWsmLYIfldJxbiXBFSsNmJPqG+LOkjkOl+o/OPOxFgQqSGPSlX+yfekd7aek2ZEW9y5T7Hym7V/e4E+0LNd9/riyuRR/suaRi2iytlUIcYcbpYlS/YbaEXs0+aG/flQXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqiQVu4Vz1NjkkbKHOJcFBgtSp/DqHbvnZNXWVyf3NE=;
 b=yO4mBIym8MTQvnsu4QR2p/JHbDin4wmbUY+hG/LOdVDS8reiPcwAvYB/GLywx26P9ddCvkBsQQr+tlEIevut0P9l2HtSobSnrNnd7N+abO+ZTaYcuyUCe3OwMcxP1yKheGAxGO4gZJ9dOeIkSRIWPRtcF6FW4W6wAj75Au1YmU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 16:23:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 16:23:19 +0000
Message-ID: <52c4f609-4a7a-d1ef-6a82-178ba4358882@amd.com>
Date: Mon, 25 Apr 2022 12:23:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amdgpu: replace VM fault error by info logs
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220423022445.7238-1-alex.sierra@amd.com>
 <f0e62c2b-a715-932f-891d-b4c80b395911@gmail.com>
 <6c8a5640-363c-ed42-f261-740e38530e6c@amd.com>
In-Reply-To: <6c8a5640-363c-ed42-f261-740e38530e6c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fb4de1a-1e23-47b3-0049-08da26d7e8bc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4477:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4477C1E13BC6A8A84DC5B3BA92F89@SA0PR12MB4477.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEJnoKbXdvMeVtT3b0tIpmblns9pX1sU2zx+Drd5pYu3OIseUQLYfT/WMAbra2VTyIEHIpVjNk1Roc3JOhHXPbWPkxxuxhy0HAAGq6vFnlGoPyPP2u605SoBckbnzO+2f7bPkoMjhvS3RcgPuSZ2EC6w52/h2Hdw/SPHdfGU54f8T2InrabMhLtk+hoLhc+fK7jHJzImKgktnEw6LcHDwteTguEx+r7QwrrOxY+397JF0UzAf5mTCahFDJw8gpE/j3kZWZx3TMBEPpPcOaNhmPvsoPKGhBvOgfFBiAt93UzPjO0SpyOaclYD7Uc4tlwN95BndgCLC6D7fHwvvz+qpQm/gl7uasTUZQdW5D4CDDBoeuaTtnj6vRvS0rRSUrr7tnJdUyzZiwF9H7NGNJTpJidBY7Cpx290pCRM0ILOsn0c64ZTv/9fZihSOvxL4RZLtjbRZmFTlV6tiFg+nbD0oJUuVKuX4uydP2WXpK6RPyX4gAj0a5DHty8xpWxjlo4LIJX6syvT/FFGPBhPiejjxCoemjv+671KxQbsQkEdeWCm9RlbzKCnQyb7cjPrYQiR+ApBQOUkVkReokbDnCCrO+b+yLQvfCcAD+uzgsxO1Xmft7uIkF9i7PZYOJAQU3ZWCDe080QpCc5tJkx4RT2agImQTiwYQ32pAKhiz7atHWduRssNPlqKINCrO88pE8o1dPt0RUrakEUkzMvfgT0N5RDfK8DD/GsbH0puHEyFhhzFEaIVqb4Aj4m1SMJe9GzW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66946007)(8676002)(30864003)(31686004)(6512007)(6506007)(8936002)(6486002)(508600001)(26005)(186003)(86362001)(31696002)(83380400001)(38100700002)(36756003)(2906002)(5660300002)(44832011)(316002)(110136005)(2616005)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aldKYWw3QmU4THFEWEFtV0xNMk8rTW5IbHF6bUZzKzVoakc2VjBTRzlIdmFK?=
 =?utf-8?B?bXY2NVJtQnQ5NHdwZWdnSTd3alYzck1DTDBmMlZsU1A2L240bncrZHF2SlM3?=
 =?utf-8?B?UW9HYVhhd0xMZUtjSzZteWVzcDNkczhaOHdsYUJkR0w2c2MvNWJNbWE4emJr?=
 =?utf-8?B?MEhuSWs4UVUyK1gzdEZ3SVZndUxzVXJUQ1R2MWlrSmN3alVBQmZQVUZDRjVp?=
 =?utf-8?B?OFVoWFFyVzdFSUlUSUFmMGJibU5xdjFxL0N2bUFxS1UwVHhwMHNkb3FpM1pB?=
 =?utf-8?B?SlZWRFlSUysveTlGalRpVlk3K0RnQkNpejhrM1pJY2lwSmR2STVLZXNaTUJO?=
 =?utf-8?B?aHMzRFBibnJKVXp4b1JOZDhxK0tzaDBDUEY1Z1FpMnNCQktOUDJobldkY1Jq?=
 =?utf-8?B?M1lPVERtbm1WZ2Mxa1NkSWp3MmE2Yk1GSGhJbDU1WnhWZStuTjMzc202UlN0?=
 =?utf-8?B?ODBlVitJWHkvWUljVFhBMUJYU1hoZ3gzN1FsNVVLSVo5Ynp2UVFNRXpQYUta?=
 =?utf-8?B?b0ZXWm5ZZFlvOXNnYmFCN0lHWU40a0V6VGRiK0tNNzRON1NtMk9UNm01RFpr?=
 =?utf-8?B?MWU4eDdMampTbi9XbEh5dnFHQUYrL0x2QUVaeVJBZDFPMXByTFRlQ2VrOFp0?=
 =?utf-8?B?YkxZWko3cHYvQjNqcEV1RUt2dHBrYWsremczZWg3TmdPMS84Q2pVY3ZBS3FZ?=
 =?utf-8?B?dUxBYXEzUzA4cHMxS1U1dVM0TnNjbXR4ZEtXQ3JNQkQzbGhzSkRwOC9YYmxY?=
 =?utf-8?B?dTIvYUplOVFOekVMdkJod2s3cm1BSGg2NHEwNXdtcDhuT2JjTnFKMFhXZEQ5?=
 =?utf-8?B?Qkt2cWJlRy92bHhFTVhDWDhlNWk5Wkh4OFc5UnlrVGloakZBN2ZVWHVycDJX?=
 =?utf-8?B?dDhvNnUxeFh4VFcvSmRCdWVpVDZWTi9oSTg3eXpqVmlUSVJiTGQ3YjkxSXNE?=
 =?utf-8?B?cFNNN2U4Z3c0bTB2eU9NZ1Nhak5LZGdHZjVta2ZvMm5HQ0dtSUN5eVl1S0JL?=
 =?utf-8?B?N0NVWlVRdHJaVS9ydysrWXcwLzFqeFpLWUFMTU04Q2JqTWFmVkdZYTEwTWhq?=
 =?utf-8?B?L3dUd1B6V2RTckpLVkFHM3pKbXlrbDRrVllrRHR2b1BRNVBMWWpibnRrcEc1?=
 =?utf-8?B?a1NVZVhhMW5rbmZOUGFsd0tCaG1hV2xrL2M3RmRzbTJORGxORlJrWFQ5Q1pw?=
 =?utf-8?B?NUhZaTd4R1NYUC92cGgyT3YwTVFsU1NacmEzZlJJeW80U203Q1VsUWtENlp4?=
 =?utf-8?B?NnFqN2d4aXNOZXZ5ZG5ZaGRqdnZ4cUU1MEx3aUJRZ290YWJWazR3RFFuMVg1?=
 =?utf-8?B?eHJCaDhJNnZ6SWljYTUyL0RBQ1RrdnFlZktvSkNTTDBWN1NwczRpRm5XZjdO?=
 =?utf-8?B?ZkFvZkRoWkNJK2FjRTI3bW5MazZsZkg0cytwWXp5UDIwUUs4VjRkZlBlU2JM?=
 =?utf-8?B?d3EzNHZSUk9hYWowWXRkTUpzelMvUFdQQ0N2OWJsOWtXdnNMa3gwakJkMitv?=
 =?utf-8?B?NS9LWmh6UlhrLzNqV3oreWNBKzNGbXJGVHp4NGxLOG5LS0hTZnJvZ3RmRWVh?=
 =?utf-8?B?WFE1eVJGaTNIZDBhOXZ2VlZ3RnNtWlovcnBEWit4SUtHYkN5QzUwWTd4MXgv?=
 =?utf-8?B?QlE0TEY2elNhYVlJdVd1N2p1V0VyZkE3SUcyZ0drdEtTSWRCQUJJUXcraG1O?=
 =?utf-8?B?aVdDeVNLT1BBbXo4K2J0QW9MQVhWYzI4MUdXRU9yZXAxWlI5WDQvaWh4YUxz?=
 =?utf-8?B?czVCa1YrbTFVK1QwV2hFMXNQTkhqZ2JMd1dET3NISFBTWWJiVnJOUEVKYjBj?=
 =?utf-8?B?Yk0wNVNJWGdROXo1OEVDVlRtcFRqdllXa0d0Q1kyV3BFV2lIS1VzTHRRYlBG?=
 =?utf-8?B?WUZDYjl5QmI5dU10blJZR2ZZUjl3akZpWGlPbmJESXFOODRsdUE0dGZXSDE3?=
 =?utf-8?B?c3Q2TGJQRkYyWHRKcEZVNEZ1RUp6cnNVOHViSStPNktEQ0x4ZTJhc0dwS3J2?=
 =?utf-8?B?VnhGMHBmMXBqZ3NLSUl1S3V5ZWFKMU01NTJMdVpQcDNkc2RNOEJCQUNRR1ly?=
 =?utf-8?B?TnViNDJJemc4YzFMUDZ4NjByTDIzVzVQaUo0enZERjVjdGpsQTBIOXNJS2cw?=
 =?utf-8?B?TU9Oc1pORnhqTkRpN0x3SjV6S2M4RXlJbkxTMUM0aWxBdHFCS1Y2WWZrUHJo?=
 =?utf-8?B?WTcrRDNMTHpxVkl1RGVVUEhwUDliUnBpYUJJL3c0WGhnd3Y4OEl3OXVJeG5W?=
 =?utf-8?B?WElVMEJnM1VJN1F2dS9YSW5jaGhNaWpsaXRTOUNhcFpleFQ5YkxYcUdySHpM?=
 =?utf-8?B?YzladlIrZW9rY0ZZdk91OXZjMW1CTnl6a09zbE41MG5xc0RjS1dzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb4de1a-1e23-47b3-0049-08da26d7e8bc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 16:23:19.2211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8wl4MGOOBb7iyagn9tv1MPlBB4QBuAs5TN0SZbhfqqYMRvxmDJMrKqqregIMFdZVZCltcFkfEZKwidNHZ5FoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
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

Am 2022-04-25 um 11:29 schrieb Felix Kuehling:
> Am 2022-04-23 um 13:54 schrieb Christian König:
>> Am 23.04.22 um 04:24 schrieb Alex Sierra:
>>> This is not a kernel error. These logs are caused by VM faults that
>>> could not be handled. Typically, generated by user mode applications.
>>
>> Well it's still a hardware fault which should be logged as an error.
>
> At least in ROCm compute applications, a VM fault does not take down 
> the hardware. It only leads to termination of the process that caused 
> the fault. It's very similar to a segfault in an application, which is 
> not considered a HW fault either.

Turns out, a segfault also prints an error message in dmesg. So I guess 
the VM fault can remain an error message as well.

In a test that triggers VM faults on purpose, we can add some message to 
let users know to expect kernel error messages from the test.

Regards,
   Felix


> Other processes are completely unaffected. The cause of the error is 
> typically in user mode. I think the general policy is, that user mode 
> errors should not spam the kernel logs with error messages. The 
> messages are useful for debugging application issues, so it's good to 
> have them. But IMHO they should not be error messages. Such messages 
> often lead to spurious bug reports against the kernel for things that 
> aren't really kernel issues.
>
> Regards,
>   Felix
>
>
>>
>> So I'm absolutely not keen about reducing it to just an information.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 14 +++++++-------
>>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 14 +++++++-------
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c    |  8 ++++----
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c    |  8 ++++----
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c    |  8 ++++----
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 20 ++++++++++----------
>>>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 14 +++++++-------
>>>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c  | 14 +++++++-------
>>>   9 files changed, 52 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>>> index 6e0ace2fbfab..c226a4803086 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>>> @@ -79,25 +79,25 @@ 
>>> gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device 
>>> *adev,
>>>       u32 cid = REG_GET_FIELD(status,
>>>                   GCVM_L2_PROTECTION_FAULT_STATUS, CID);
>>>   -    dev_err(adev->dev,
>>> +    dev_info(adev->dev,
>>>           "GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>>           status);
>>> -    dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>> +    dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>>           cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : 
>>> gfxhub_client_ids[cid],
>>>           cid);
>>> -    dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
>>> -    dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
>>> -    dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
>>> -    dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
>>> -    dev_err(adev->dev, "\t RW: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t RW: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           GCVM_L2_PROTECTION_FAULT_STATUS, RW));
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>>> index ff738e9725ee..fdcca1477592 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>>> @@ -82,25 +82,25 @@ 
>>> gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device 
>>> *adev,
>>>       u32 cid = REG_GET_FIELD(status,
>>>                   GCVM_L2_PROTECTION_FAULT_STATUS, CID);
>>>   -    dev_err(adev->dev,
>>> +    dev_info(adev->dev,
>>>           "GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>>           status);
>>> -    dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>> +    dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>>           cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : 
>>> gfxhub_client_ids[cid],
>>>           cid);
>>> -    dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
>>> -    dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
>>> -    dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
>>> -    dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
>>> -    dev_err(adev->dev, "\t RW: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t RW: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           GCVM_L2_PROTECTION_FAULT_STATUS, RW));
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index a455e59f41f4..864fcc0edb90 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -148,14 +148,14 @@ static int gmc_v10_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>       memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>       amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>   -    dev_err(adev->dev,
>>> +    dev_info(adev->dev,
>>>           "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, "
>>>           "for process %s pid %d thread %s pid %d)\n",
>>>           entry->vmid_src ? "mmhub" : "gfxhub",
>>>           entry->src_id, entry->ring_id, entry->vmid,
>>>           entry->pasid, task_info.process_name, task_info.tgid,
>>>           task_info.task_name, task_info.pid);
>>> -    dev_err(adev->dev, "  in page starting at address 0x%016llx 
>>> from client 0x%x (%s)\n",
>>> +    dev_info(adev->dev, "  in page starting at address 0x%016llx 
>>> from client 0x%x (%s)\n",
>>>           addr, entry->client_id,
>>>           soc15_ih_clientid_name[entry->client_id]);
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> index ec291d28edff..3d830fd7706b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> @@ -620,7 +620,7 @@ static void gmc_v6_0_vm_decode_fault(struct 
>>> amdgpu_device *adev,
>>>       mc_id = REG_GET_FIELD(status, 
>>> VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>>                     MEMORY_CLIENT_ID);
>>>   -    dev_err(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s 
>>> from '%s' (0x%08x) (%d)\n",
>>> +    dev_info(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s 
>>> from '%s' (0x%08x) (%d)\n",
>>>              protections, vmid, addr,
>>>              REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>>                    MEMORY_CLIENT_RW) ?
>>> @@ -1083,11 +1083,11 @@ static int gmc_v6_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>           gmc_v6_0_set_fault_enable_default(adev, false);
>>>         if (printk_ratelimit()) {
>>> -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>> +        dev_info(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>>               entry->src_id, entry->src_data[0]);
>>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>>> 0x%08X\n",
>>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>>> 0x%08X\n",
>>>               addr);
>>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>>> 0x%08X\n",
>>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>>> 0x%08X\n",
>>>               status);
>>>           gmc_v6_0_vm_decode_fault(adev, status, addr, 0);
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> index 979da6f510e8..1f3ceb03b47b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> @@ -781,7 +781,7 @@ static void gmc_v7_0_vm_decode_fault(struct 
>>> amdgpu_device *adev, u32 status,
>>>       mc_id = REG_GET_FIELD(status, 
>>> VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>>                     MEMORY_CLIENT_ID);
>>>   -    dev_err(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at 
>>> page %u, %s from '%s' (0x%08x) (%d)\n",
>>> +    dev_info(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at 
>>> page %u, %s from '%s' (0x%08x) (%d)\n",
>>>              protections, vmid, pasid, addr,
>>>              REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>>                    MEMORY_CLIENT_RW) ?
>>> @@ -1286,11 +1286,11 @@ static int gmc_v7_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>           gmc_v7_0_set_fault_enable_default(adev, false);
>>>         if (printk_ratelimit()) {
>>> -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>> +        dev_info(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>>               entry->src_id, entry->src_data[0]);
>>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>>> 0x%08X\n",
>>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>>> 0x%08X\n",
>>>               addr);
>>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>>> 0x%08X\n",
>>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>>> 0x%08X\n",
>>>               status);
>>>           gmc_v7_0_vm_decode_fault(adev, status, addr, mc_client,
>>>                        entry->pasid);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index 382dde1ce74c..5be3f4f77c49 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -1021,7 +1021,7 @@ static void gmc_v8_0_vm_decode_fault(struct 
>>> amdgpu_device *adev, u32 status,
>>>       mc_id = REG_GET_FIELD(status, 
>>> VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>>                     MEMORY_CLIENT_ID);
>>>   -    dev_err(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at 
>>> page %u, %s from '%s' (0x%08x) (%d)\n",
>>> +    dev_info(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at 
>>> page %u, %s from '%s' (0x%08x) (%d)\n",
>>>              protections, vmid, pasid, addr,
>>>              REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>>                    MEMORY_CLIENT_RW) ?
>>> @@ -1466,12 +1466,12 @@ static int gmc_v8_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>           memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>           amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>   -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x for 
>>> process %s pid %d thread %s pid %d\n",
>>> +        dev_info(adev->dev, "GPU fault detected: %d 0x%08x for 
>>> process %s pid %d thread %s pid %d\n",
>>>               entry->src_id, entry->src_data[0], 
>>> task_info.process_name,
>>>               task_info.tgid, task_info.task_name, task_info.pid);
>>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>>> 0x%08X\n",
>>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>>> 0x%08X\n",
>>>               addr);
>>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>>> 0x%08X\n",
>>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>>> 0x%08X\n",
>>>               status);
>>>           gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
>>>                        entry->pasid);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 22761a3bb818..98c8de7307be 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -582,14 +582,14 @@ static int gmc_v9_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>       memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>       amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>   -    dev_err(adev->dev,
>>> +    dev_info(adev->dev,
>>>           "[%s] %s page fault (src_id:%u ring:%u vmid:%u "
>>>           "pasid:%u, for process %s pid %d thread %s pid %d)\n",
>>>           hub_name, retry_fault ? "retry" : "no-retry",
>>>           entry->src_id, entry->ring_id, entry->vmid,
>>>           entry->pasid, task_info.process_name, task_info.tgid,
>>>           task_info.task_name, task_info.pid);
>>> -    dev_err(adev->dev, "  in page starting at address 0x%016llx 
>>> from IH client 0x%x (%s)\n",
>>> +    dev_info(adev->dev, "  in page starting at address 0x%016llx 
>>> from IH client 0x%x (%s)\n",
>>>           addr, entry->client_id,
>>>           soc15_ih_clientid_name[entry->client_id]);
>>>   @@ -611,11 +611,11 @@ static int gmc_v9_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>       WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>>>     -    dev_err(adev->dev,
>>> +    dev_info(adev->dev,
>>>           "VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>>           status);
>>>       if (hub == &adev->vmhub[AMDGPU_GFXHUB_0]) {
>>> -        dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>> +        dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>>               cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
>>>               gfxhub_client_ids[cid],
>>>               cid);
>>> @@ -648,22 +648,22 @@ static int gmc_v9_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>               mmhub_cid = NULL;
>>>               break;
>>>           }
>>> -        dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>> +        dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>>               mmhub_cid ? mmhub_cid : "unknown", cid);
>>>       }
>>> -    dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
>>> -    dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           VM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
>>> -    dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           VM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
>>> -    dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           VM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
>>> -    dev_err(adev->dev, "\t RW: 0x%x\n", rw);
>>> +    dev_info(adev->dev, "\t RW: 0x%x\n", rw);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>>> index 636abd855686..ec8c8b2cab36 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>>> @@ -150,7 +150,7 @@ 
>>> mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
>>>       rw = REG_GET_FIELD(status,
>>>                  MMVM_L2_PROTECTION_FAULT_STATUS, RW);
>>>   -    dev_err(adev->dev,
>>> +    dev_info(adev->dev,
>>>           "MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>>           status);
>>>       switch (adev->ip_versions[MMHUB_HWIP][0]) {
>>> @@ -169,21 +169,21 @@ 
>>> mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
>>>           mmhub_cid = NULL;
>>>           break;
>>>       }
>>> -    dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>> +    dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>>           mmhub_cid ? mmhub_cid : "unknown", cid);
>>> -    dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
>>> -    dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
>>> -    dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
>>> -    dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
>>> -    dev_err(adev->dev, "\t RW: 0x%x\n", rw);
>>> +    dev_info(adev->dev, "\t RW: 0x%x\n", rw);
>>>   }
>>>     static void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device 
>>> *adev, uint32_t vmid,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c 
>>> b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
>>> index ff44c5364a8c..72dda850e7d3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
>>> @@ -87,7 +87,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct 
>>> amdgpu_device *adev,
>>>       rw = REG_GET_FIELD(status,
>>>                  MMVM_L2_PROTECTION_FAULT_STATUS, RW);
>>>   -    dev_err(adev->dev,
>>> +    dev_info(adev->dev,
>>>           "MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>>           status);
>>>       switch (adev->ip_versions[MMHUB_HWIP][0]) {
>>> @@ -100,21 +100,21 @@ 
>>> mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
>>>           mmhub_cid = NULL;
>>>           break;
>>>       }
>>> -    dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>> +    dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>>           mmhub_cid ? mmhub_cid : "unknown", cid);
>>> -    dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
>>> -    dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
>>> -    dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
>>> -    dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>> +    dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>>           REG_GET_FIELD(status,
>>>           MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
>>> -    dev_err(adev->dev, "\t RW: 0x%x\n", rw);
>>> +    dev_info(adev->dev, "\t RW: 0x%x\n", rw);
>>>   }
>>>     static void mmhub_v2_3_setup_vm_pt_regs(struct amdgpu_device *adev,
>>
