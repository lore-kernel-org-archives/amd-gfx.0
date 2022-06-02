Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00C7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 14:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66447112DD6;
	Thu,  2 Jun 2022 14:21:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03177112DD8
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 14:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLAMtuODNAMXI8oTqcvWTsEzLkhwUYvZe2Rv4Hdl1t0VNkpgQoysgmCshy2Sb5jdV7HB5Wi2ZAX3DzaA8K4yM4ARBGnKJc2mQjfHwgpzrKXxf3uqBRstoYbDHBM0WYr/DXWGalk5QFaeHJBqn3Sgs0DdXPXe/oWKWe6WdcAFhLLt8AWLKyNXUGvJpj2prFYb0Ae72zcISWlZf9vqckNR7siwmtwssdkv54+baXWFl50hfVS7Les5imuFZYLcBwNcD8fg5eEs+TEcMX3aeDiyHSDOwnpkhxR4hWVs18ZMqLUOSOEKb7krk2euuVDGs0epJKvwz81h/u7FmqdN6WwvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTfVqvWZZw8OgI0Yno+7pVRLfIPwTqjfJ/fJZbMhutY=;
 b=QmTOPDZ1e6Mci51Ifh4yVP3WfJzwUEv/DyBYAARjem0/I1qtiEZMQN63asL4A/Op/5+K08gu7t3sjhBw/xI/l/IFFi+8QU7LcPDVe7HYTzlrUjWNyUjIAhBiv1TTh6ZeSFtUNv0Etv96aimzAZKTinABmaxeMXUIX+hXrWbIOGmxXaLdOhD+3UWxXP3lgAUTwzUfuUI7de0S9CmsD6FuJUyM4iOZnAQTbwwbfnWfEV9Q9WF/YrVpOJoOi3yvXoI7IzoRUxNWUlcxM8SOrbKQiHuM9Z4hK1tjopW+LQ78mZkWw24nIFRY11vBXumoa+FrhnVbvLOWctwwnMP/JLXwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTfVqvWZZw8OgI0Yno+7pVRLfIPwTqjfJ/fJZbMhutY=;
 b=3nNX4wZyvOV7pG+Smn3a6hH9nOjw0iAZUj+/mrwWF/+tvAMSiTGVDA4YYwqj868aVEq9k9+XKam2/wBAG/zORjFfMRIwGiUa6Uw4cCqMzO0upT4BBvTsRBWofey7f2Zl5Ha2zvSvxBjNkUNnaJtABEwDQz4NSRyyZQT2pz/A49s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by DM6PR12MB2666.namprd12.prod.outlook.com (2603:10b6:5:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Thu, 2 Jun
 2022 14:21:47 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::2d9d:f26a:77a4:c19]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::2d9d:f26a:77a4:c19%5]) with mapi id 15.20.5314.012; Thu, 2 Jun 2022
 14:21:45 +0000
Message-ID: <337ce13f-b852-f02b-b6e1-53c0b3bbff80@amd.com>
Date: Thu, 2 Jun 2022 10:21:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Explicit VM updates
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
References: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
 <022d86d0-6301-70da-f320-b17c4859443b@amd.com>
 <412a23fc-eb92-8f3c-e339-0bc3918c0f18@amd.com>
 <4d563bf0-ade6-fc3e-9de1-cc2522c4a57f@amd.com>
 <743af352-bdce-a69c-7ecc-2fc99441c82b@amd.com>
 <58b622db-3a30-f6c5-cdda-0136d85b531a@amd.com>
 <14a39f90-4ba9-3dea-bc38-324d0ee34193@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <14a39f90-4ba9-3dea-bc38-324d0ee34193@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::22) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ed62a4d-8025-43ab-925e-08da44a338e4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2666:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB266661E5C0C8C0E5C6E4655492DE9@DM6PR12MB2666.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1fJpQWyU/DN812xYFInmCi/kMiAtsyMDB0OFtCZ7BJKI0RcN1cSUznHEGEHwQi5VdqNFtBR46JVHLRqVmQkt6GUWt4SQz5eyfT5hS0B8A0WPx+82tN5lhdjHWrlOnnVu5El+ZQ7lw1/gVKJuqFJ9yRlSmpA2zDisdj3yINm9hzRsdBYivnjChu+8Kw6jWrQNDPz26eNvkqqA1W5Jbl7uTuRY6m0Z/b0BhnSmpI4GNbyRMCisLJ7nJptAyY3fCRI5pWM4Ljcz3yACYXwujefcvidFjYJNYA43YXLzDY6GKy5EC7DO/v6dU5bNKX5yeQtbXJFECwBcHSxebs1+kNoE8oSxzUIRhp6QT58xcWOtxDfzCzWLzX71Y0R51JihfWRH4oFPuvojUOVFb5Zqh8GHqeTrV8CykRJLzcgOXTMtEBk/pePXey6HX6ZGIaPfvf3psVWy1+cR1zVk/qmbInPXV3RSWH5Y/uKGv5/9BEHAClE3o8Gw+cm9Ejtj4wbNdZ2lwssn+y5bIFwlgJKiCrYx8ZjeV0QSFpUX4DQNmkhF/sCQcCMA9XXKHMnC1PufpYGXMv0CRLc3gnMydunjULS4mQH9gxSOjEZ9dxyexCLOXGPP5b6Zz1gz+e/jNE4MS7Isa/vNTXXWcX76AQ+KKNf5EiAjmVDgaarjBpVdtRsK0XroqO0zXFI70io+TkcKLMZghvIXzF+4RykjiunKdLiOhtR+P03pyoPmm+/e50m/jKbdQhpPg55Th1LKwu5rT4l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(4326008)(8676002)(66556008)(66476007)(316002)(6506007)(86362001)(7116003)(31696002)(508600001)(15650500001)(6486002)(66574015)(83380400001)(8936002)(186003)(44832011)(5660300002)(2906002)(6636002)(38100700002)(31686004)(2616005)(26005)(6512007)(3480700007)(110136005)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZQMExKV0FPVmlxQXBlcUFYY2ZhaDd0cUFvd0VPNW9EaUpOUGVsQTYzbmVE?=
 =?utf-8?B?alZKZUtiZnl2ck5kUHJlK3BSanlyS0RQT2Ntem8xbndvcmtUcmt0K0lQOGww?=
 =?utf-8?B?NVZ3YmYydXVUNXViallxZERWQkRKZ0I1RmVtT3VpWlNZaUVNanZtay9udFRW?=
 =?utf-8?B?MW12TituWm4wNktRL2hyWG9zRXZJdDcvOVdCL3IvZ3VXZjIzMlFEdzFjUVJS?=
 =?utf-8?B?cHlwSzhQODQvbTNyUU1QMFRRaDB5NFVubmpNUkdpcElsMi9sS1VaWlNsT3Vv?=
 =?utf-8?B?Q0hiaEMwaWdsUEZIb1pXMjRrYUxQSzVNN25vb2xzeE5ucFlnM0hGaUhqU1Vu?=
 =?utf-8?B?UElJOThIcTRReHNKTTNsTHAzcndmNHBMc29hMXZ5TDVydzIyMkNsNVZYUjVm?=
 =?utf-8?B?S09RUUFiNTVLK2tLUmJ1a3RMaU53ZFVtUCtaR05mNGpTZStMei9WSzNhKzFD?=
 =?utf-8?B?RjhBbEtPYm0yL1pVQzFGWGd2VlkxV3M4VlZFZVNWWklSZFl6aWFCaS9jRnBu?=
 =?utf-8?B?UDYvekdReWQrY2h0akdVT2Vic1RvRGtiQUpFQW80c3dHNzh3YThIQVNnaFJH?=
 =?utf-8?B?NWZKOGF2cDRJVS8vOFlOQlFCSkFOLzNjK3Vkd1hwd2llS2k0NDd4S01vNFhy?=
 =?utf-8?B?bHlzTXpJeEE3TE90SnJFU2VEc21LS0RTQmd3REYrNWQxTnVubVVnRGhwSFVO?=
 =?utf-8?B?SDMwSkFSYkpOb2ZrdjFCZVBYQmpwM2xaekxiRFFyWU1TK0RhdE9PdVJLL1Rx?=
 =?utf-8?B?UjU2dE54c0VxRnFkZ1QyWnBBdWtXMTFnQmlEeWN2K2p1V2tlcnJmdEE2R2pV?=
 =?utf-8?B?Vk9OMmFCY1pnd3Z4Y1gyVVRLQkMzTGVtYzBIQmdHZTlURGRYQ0YwRE0wekdw?=
 =?utf-8?B?VVJleEtMeWZKdmlhbGtVOHpFWWhYelJFNGFNRklGclZOL3BxTWxHNjRHWUU5?=
 =?utf-8?B?VzVIOTZwbm80bzMzdWJONUlLWFdQTUdkeDU3aUE0dXI5bWtkWXB2VWNoa2lG?=
 =?utf-8?B?cnI4NGxlV003YlpOWUZwYnpWeENNcFlOQ2FFZG11SnJjYVdDUUxIWFZVMFgw?=
 =?utf-8?B?UEUvaXNmSXdyMDdCbkxMK3pVOGI2U1dEckRUUEJPRnhoKzdaTVhpZlorayt6?=
 =?utf-8?B?UUZUMENtc2UwVG5acmhQSlZrR0QrR3kxT2YvdCs0UUhRZG95MjJYQWFPODdF?=
 =?utf-8?B?eEgwUURrb0RRRTEvaUwxNWZjVld2aCtlUmJCaFloSzJIS1AyQ1FRWW5EN0x1?=
 =?utf-8?B?UldqdnJFa1podkZld2c5ZjRLWnNZWnlBUzViS1ZUSXBzUSt3WmExWjFFVGNT?=
 =?utf-8?B?cXN0NmZTY1dnV3cxVkFCQnJDSkNDTDFRL0drNjZtNUx6NjhPblVXTGlBdU1Y?=
 =?utf-8?B?aFJhVVdFR1dxdStXR2IrMjJVZUF6VlowRS94c0RCV2JVS0lvL2ZVeUVENEFv?=
 =?utf-8?B?MGZ1MnJRYU53YU5RU0R1Vzg3WTdxL1lIWENXakE4ZVgwMWZoK2ZxcHlqYTV3?=
 =?utf-8?B?d3VKQXNkcEI0a3lxK3VRa3NObWl4RE82NXZmemM5MUNDMk9TYXZ4SGFJOWZI?=
 =?utf-8?B?aE1SUlJFbms2Y1d6dGljRkg3djFUSE41T0tkMzZxNDhPekJOY2hZVHZocE5R?=
 =?utf-8?B?ckNwbjJObnpGaTdqWjVXQjBZQlNJVmZPcGNncGp3Q0JBaXd6bEJ2Z3o3Sm52?=
 =?utf-8?B?L3V6SjAxb3FEYVFqNlp2dVNNY0ZnUG9uaG1nQXNWNk96TEJvbmtGOUovSURi?=
 =?utf-8?B?aDVKTUVGSU9jRTA4MFI5eDRoSkNmN2VaWWllaURWM0xlbVRNL2h1Ui9TcXNI?=
 =?utf-8?B?YnB5ejdUaXBRdldQck9nMzJRRmJtZ1hxclluVEFLUWcxV0tESXJjbDgrT0hS?=
 =?utf-8?B?NXAvTmxzd0U0QmdFQXA2K1hWMldHd2lPMEE3bVBHQkhoZG4wWGZyTDdlVDN0?=
 =?utf-8?B?WUxNNkJMRUo1NTFrMUNhZ3ZtRWJ6dmhqM0k4RDNIZUg5OWtTaHdHV2FDU203?=
 =?utf-8?B?bmxidzZLNzd4cnZoUjRCY0xMdjEwc1YxUzBZOFFTRUJmNVRWVEJQVHhraFNV?=
 =?utf-8?B?RHN6MnJWUlo3UEpicUFPbytxcklYNWtsb1J2WEpUdnVMZVV4Sk1GakdkYXlo?=
 =?utf-8?B?L1JpczdqdEZwT1RvV3hKaDZ3MnE0NWcrZ2UycCtkREtUUDgvdS9xbnRsU0Zs?=
 =?utf-8?B?b1g5eVI4UFB4d3Fvdm51NStyUUNBQTRpWDhvRk5FazV2T3pRQlowejltYmxs?=
 =?utf-8?B?eHJWbWZQY2RsV1lMUnI5Y1NjYzlxTDVRNmZtK3VJL09TUEh3REtpeTNudjR0?=
 =?utf-8?B?blgxaTBmekNHSEF4Q25hMXJZNUxOWHpWYVFqeFpybUNKR2kzZ1dCZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed62a4d-8025-43ab-925e-08da44a338e4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 14:21:45.2458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysnJFgIpLYzDvPDnRdDk3spRG7JfLiXvOgcMxg5eectZ9diiFyZVG5iFQm8OoXscMPp7KL8+blySLjiDQEEZ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2666
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-06-02 um 02:47 schrieb Christian König:
>
>
> Am 01.06.22 um 19:39 schrieb Felix Kuehling:
>>
>> Am 2022-06-01 um 13:22 schrieb Christian König:
>>> Am 01.06.22 um 19:07 schrieb Felix Kuehling:
>>>> Am 2022-06-01 um 12:29 schrieb Christian König:
>>>>> Am 01.06.22 um 17:05 schrieb Felix Kuehling:
>>>>>>
>>>>>> Am 2022-06-01 um 08:40 schrieb Christian König:
>>>>>>> Hey guys,
>>>>>>>
>>>>>>> so today Bas came up with a new requirement regarding the 
>>>>>>> explicit synchronization to VM updates and a bunch of prototype 
>>>>>>> patches.
>>>>>>>
>>>>>>> I've been thinking about that stuff for quite some time before, 
>>>>>>> but to be honest it's one of the most trickiest parts of the 
>>>>>>> driver.
>>>>>>>
>>>>>>> So my current thinking is that we could potentially handle those 
>>>>>>> requirements like this:
>>>>>>>
>>>>>>> 1. We add some new EXPLICIT flag to context (or CS?) and VM 
>>>>>>> IOCTL. This way we either get the new behavior for the whole 
>>>>>>> CS+VM or the old one, but never both mixed.
>>>>>>>
>>>>>>> 2. When memory is unmapped we keep around the last unmap 
>>>>>>> operation inside the bo_va.
>>>>>>>
>>>>>>> 3. When memory is freed we add all the CS fences which could 
>>>>>>> access that memory + the last unmap operation as BOOKKEEP fences 
>>>>>>> to the BO and as mandatory sync fence to the VM.
>>>>>>>
>>>>>>> Memory freed either because of an eviction or because of 
>>>>>>> userspace closing the handle will be seen as a combination of 
>>>>>>> unmap+free.
>>>>>>>
>>>>>>>
>>>>>>> The result is the following semantic for userspace to avoid 
>>>>>>> implicit synchronization as much as possible:
>>>>>>>
>>>>>>> 1. When you allocate and map memory it is mandatory to either 
>>>>>>> wait for the mapping operation to complete or to add it as 
>>>>>>> dependency for your CS.
>>>>>>>     If this isn't followed the application will run into CS 
>>>>>>> faults (that's what we pretty much already implemented).
>>>>>>
>>>>>> This makes sense.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> 2. When memory is freed you must unmap that memory first and 
>>>>>>> then wait for this unmap operation to complete before freeing 
>>>>>>> the memory.
>>>>>>>     If this isn't followed the kernel will add a forcefully wait 
>>>>>>> to the next CS to block until the unmap is completed.
>>>>>>
>>>>>> This would work for now, but it won't work for user mode 
>>>>>> submission in the future. I find it weird that user mode needs to 
>>>>>> wait for the unmap. For user mode, unmap and free should always 
>>>>>> be asynchronous. I can't think of any good reasons to make user 
>>>>>> mode wait for the driver to clean up its stuff.
>>>>>>
>>>>>> Could the waiting be done in kernel mode instead? TTM already 
>>>>>> does delayed freeing if there are fences outstanding on a BO 
>>>>>> being freed. This should make it easy to delay freeing until the 
>>>>>> unmap is done without blocking the user mode thread.
>>>>>
>>>>> This is not about blocking, but synchronization dependencies.
>>>>
>>>> Then I must have misunderstood this sentence: "When memory is freed 
>>>> you must unmap that memory first and then wait for this unmap 
>>>> operation to complete before freeing the memory." If the pronoun 
>>>> "you" is the user mode driver, it means user mode must wait for 
>>>> kernel mode to finish unmapping memory before freeing it. Was that 
>>>> not what you meant?
>>>
>>> Ah, yes. The UMD must wait for the kernel to finish unmapping all 
>>> the maps from the BO before it drops the handle of the BO and with 
>>> that frees it.
>>>
>>>>>
>>>>> In other words the free is not waiting for the unmap to complete, 
>>>>> but causes command submissions through the kernel to depend on the 
>>>>> unmap.
>>>>
>>>> I guess I don't understand that dependency. The next command 
>>>> submission obviously cannot use the memory that was unmapped. But 
>>>> why does it need to synchronize with the unmap operation?
>>>
>>> Because of the necessary TLB flush, only after that one is executed 
>>> we can be sure that nobody has access to the memory any more and 
>>> actually free it.
>>
>> So freeing the memory has to wait for the TLB flush. Why does the 
>> next command submission need to wait?
>
> Because that's the one triggering the TLB flush. The issue is that 
> flushing the TLB while the VMID is in use is really unreliable on most 
> hardware generations.

It's been working well enough with ROCm. With user mode command 
submission there is no way to block GPU work while a TLB flush is in 
progress.


>
>>>>>
>>>>> User mode submissions are completely unrelated to that.
>>>>
>>>> I mention user mode command submission because there is no way to 
>>>> enforce the synchronization you describe here on a user mode queue. 
>>>> So this approach is not very future proof.
>>>
>>> With user mode queues you need to wait for the work on the queue to 
>>> finish anyway or otherwise you run into VM faults if you just unmap 
>>> or free the memory.
>>
>> If the next command submission doesn't use the unmapped/freed memory, 
>> why does it need to wait for the TLB flush?
>
> Because it could potentially use it. When userspace lies to the kernel 
> and still accesses the mapping we would allow access to freed up 
> memory and create a major security problem.

I'm aware of the potential security problem. That's why I'm recommending 
you don't actually free the memory until the TLB flush is done. So a 
bogus access will either harmlessly access memory that's not freed yet, 
or it will VM fault. It will never access memory that's already freed 
and potentially allocated by someone else.


>
>>
>> If it is using the unmapped/freed memory, that's a user mode bug. But 
>> waiting for the TLB flush won't fix that. It will only turn a likely 
>> VM fault into a certain VM fault.
>
> Yeah, exactly that's the intention here.
>
>>
>> The guarantee you need to give is, that the memory is not freed and 
>> reused by anyone else until the TLB flush is done. This dependency 
>> requires synchronization of the "free" operation with the TLB flush. 
>> It does not require synchronization with any future command 
>> submissions in the context that freed the memory.
>
> See above, the future command submission is what triggers the TLB 
> flush because only then we can easily execute it without to much hassle.

That seems to be a limitation of your current command submission model. 
User mode command submission will not be able to trigger a TLB flush. 
Unmapping or freeing memory should be the trigger in that case.

That's how it works with KFD. That said, our TLB flushes aren't as well 
pipelined (which could probably be improved), and your strategy can 
probably batch more TLB flushes, so I see where you're coming from.


>
>
> For Vega and Navi 2x we could use async TLB flushes and on gfx6, gfx7 
> and gfx8 we could use double TLB flushes with grace time, but Navi 1x 
> is so horrible broken regarding this that I don't see how else we 
> could do that.

We're using heavy-weight TLB flushes on SOC15 GPUs. On Vega20 with XGMI 
we need double flushes to be safe.

I'm raising my concerns because I don't think making user mode wait is a 
good strategy long-term. And I believe this explicit sync and explicit 
VM update should be designed with an eye for future user-mode command 
submission models. If you need short-term workarounds for broken 
hardware, that's another issue. But it would be good if that could be 
kept out of the API.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> The signal that TLB flush is completed comes from the MES in this case.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>   Felix
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> 3. All VM operations requested by userspace will still be 
>>>>>>> executed in order, e.g. we can't run unmap + map in parallel or 
>>>>>>> something like this.
>>>>>>>
>>>>>>> Is that something you guys can live with? As far as I can see it 
>>>>>>> should give you the maximum freedom possible, but is still doable.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>
>>>
>
