Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BB6C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 06:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEE210ED46;
	Thu,  2 Jun 2022 06:47:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D4D10ED46
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 06:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0EvHMfbBUSZTNtdpjylFZ57xBk4/Rrt5vw/k1iRIA1k87xusc2/ftHYhf8ETZNTeebOo02v9FzzcEP34l+R4+DQCwBDtN7Ckn/luG9UURuP+kwNoQMY+/L5crH/jUEc3JkasxDebc0oFxXS0TEtBNWsoprnH+ZGkOygZsdykjs/q2hnq5Vprfu63PU3EJ31OIiF0Zrc4BPQ25Niuvdx7ftC2k36/ImGuofJdloGbaI1WqJ2eIS+zdoIV30QgGxlJGWB9mUMG9jHV1R4bGhNlKA0SoqgPq/5KzdrJ2AllBb9H35yQ/kvLCcHUxkTxQFuITa8S3uz/e8jG/on/qhHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSZxswKykJIt639djQ/wqVKtf3EBz8L89USedPjRUYs=;
 b=CP+M4V7QNVlsKGX5yn21H4cVfYk1YidxFIdmteiInnibi/DhIx6PM1gi22N6JoVNCvQMh13C9Yjlg91hB3hqgMAtN9cZsOt3NeFHP7CYNlKT6iHvEjo1YtrX9f03NPbAQNZ1k6GHlCs5mA7gEn/W09/NWRww9pdIj64iVHnHGWgItBmFU4gHsQaq59MziWG9knPI9fCLKAs1J/lCPoofJKao0tln3siml7MuMHchM3u6W7sWgOdBzLz9LyRa3+rQa9j2iDL2+PW7CoXaVYA44aflSMOPNFHbE4eqqYKCDy5+pjSZqFtExacTkSLTuqQSCdK53jWPnuQ85XfHmXLXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSZxswKykJIt639djQ/wqVKtf3EBz8L89USedPjRUYs=;
 b=D/MXf1mXnxA6xrgFZ6MsBr2PxTLeUYZxOlGNgUVjDbjRih/IqPgF7j5JtQxk5snB5vA9dCiUVdG7w/iA9olZLygQD9va29ZjHj5Wom/t4tS2ZteSTb+3FIu5Q/mhIqZJBQdJsy4OdQCW9uTPIqiwoaxUWEKwFq7G+1jVhiUtzj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Thu, 2 Jun
 2022 06:47:42 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 06:47:42 +0000
Message-ID: <14a39f90-4ba9-3dea-bc38-324d0ee34193@amd.com>
Date: Thu, 2 Jun 2022 08:47:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Explicit VM updates
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
References: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
 <022d86d0-6301-70da-f320-b17c4859443b@amd.com>
 <412a23fc-eb92-8f3c-e339-0bc3918c0f18@amd.com>
 <4d563bf0-ade6-fc3e-9de1-cc2522c4a57f@amd.com>
 <743af352-bdce-a69c-7ecc-2fc99441c82b@amd.com>
 <58b622db-3a30-f6c5-cdda-0136d85b531a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <58b622db-3a30-f6c5-cdda-0136d85b531a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0168.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32d20dc8-17da-403e-bac0-08da4463ca78
X-MS-TrafficTypeDiagnostic: MN0PR12MB6246:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6246BECEE7A6AE643F390B7483DE9@MN0PR12MB6246.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPsRHfqpDQ46ZhkbS6EKmOEGBfRF/0j7wrNoGehJ9kqR0WUMhmGjn6UT5urHmXjvoW3/qvetaqFQiU9lRAtgvAcRqpouC1Usd8bB8uDcy4dLyjxT7IaN4lzc/t4dsDuWoRN1oG1Cvw0Pm0SyQqGv0i7bqj/4PhKXmfFPrqS8FOAGNSOEXwIliQLpnX7gWrSnQFEaFF1ZFb5w/c4Qd5jyeYT2Is1OFwInmHBZe0lLalO/KmgatvLQk+1FtVEKf3St3PTmQQFGCh8J6a/OZizO3gKkmIeXStbPYqWZmQjW07Ic2srNhA9pRq/hAfahXioUtmTrSAaFQughkm0yIYN4+ktn2NEHJmFbxZW7Kxp1+9PYdALt7dGF8a61mu9i1eCh/nCNesdJ6SjO00N/rDq6jRAqnngYVQUGIK4cnQSeLcm44TQHJ8db8Nz1CDJLltvhnarpbBDpffhMjJ9eZ/mF0epWj2kgO2iDZv33pwa80ttc1Q1aQtmBSbeTYQwGwJqoSykGAV4SbjVtC1op48/X7zifXf71fES6pewA1yDiSy2+jH2ng2Uj0Imdj/bSqZcz2aG8P5pypzrQrtcDVClgr2bhZpu2p2KvxUtlgpImkita7Fpy0kGacld/Notec11TIsaYR0WWcPi1fyO5bFoNe0YsXYnNMR8x/Ehj+va/n7AsMUHa8EAlEEmiJB6UDod+vS+nlQ+8Ds5AoTizGCwb5KEmtJZaEurhjXlat8V1yH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(6512007)(186003)(5660300002)(2616005)(8676002)(38100700002)(6486002)(4326008)(8936002)(66476007)(508600001)(3480700007)(66556008)(7116003)(66946007)(110136005)(31696002)(86362001)(316002)(6636002)(66574015)(83380400001)(26005)(15650500001)(2906002)(6666004)(36756003)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2RNTzNKUXJveXhrZHhFSzdlaVByMnZwaVVyRUFkTnlPdmRiSi9jTW5JMWQx?=
 =?utf-8?B?ZXBHeEFNNjRIeVBzRnEzZUR2L25xTDR3TGIvUlVUeFNxeWRpSmhXRThMbVEv?=
 =?utf-8?B?WG5NZHJqMlJaTUt0STlVV2JLbnlIMFR5eitsM1JvTFFpb3RtZUhLbWE2RnVD?=
 =?utf-8?B?WnN4dkRHaWFqeVlNbGhTTmlXOU9zNkRnT3loNmxxaEFUczRZazhGTTFLamhw?=
 =?utf-8?B?NjZiemRyZUFHWkwxcy93MHBQcURKeXBvRG5PTjlNMGtIWTNHcXdxbThtYlFU?=
 =?utf-8?B?WWxUdnl1Nm16RHVVUzZiWVNwdEFveFJ3bUtzdDNNOGpxclFtdnpXeU5DSmZj?=
 =?utf-8?B?a1N3UVRoSmxHQWdWMWlicmdMejNESUszaU1teTdEbG9jSDV3U3NXZWN1Y2Nm?=
 =?utf-8?B?Q1Y2NzcrNzNqWlBWNVN1bVRiM293UnlMT2crV3pWeDkzMVRtbWlBTkdubWk0?=
 =?utf-8?B?RVNVWUcwRWVNbVBKV0w0R2IyQkk5NnoyRkJzbGFVWGdCVkRmNnBVRTFFMUJr?=
 =?utf-8?B?eFk3RzE3Qmpmak9wcTNsaTZQbks1ZUpWTFR2TzR0UXJZb1pWUmdJM0tHQ0h2?=
 =?utf-8?B?WFp5RGl1VTI1VTNEM2RDaHRhMnduZDNwNVNLYlZKczB5cXpnbC9xaTJYQnUw?=
 =?utf-8?B?ZXRia0lId3E4WHppYnlrUStXS3R0TkFVZDRLdmhUeFBqRlBYNytIdnFZUG96?=
 =?utf-8?B?bVJFVjdMdXV1TGJqZDRRcDBDZkEwNFk1cURKdmlKa2R5bUxzYWprTG9XWmEx?=
 =?utf-8?B?aXMwanl2cCs2UmJVTHpXZDU1YVZSRkRYTVRsUjUvcHBtaTFId0JZZ2lBMEVI?=
 =?utf-8?B?cG5XWTc0NDNSUjFSOHBDVnlUNlpqaHhWK3d1S1hkb1dKUEhlclBmc0ZEMkZI?=
 =?utf-8?B?eVNzWVFhalpLT2s3dFlXMGdqaFlLNTVGWnV6Z0pKSkVFRk4wQXllN291Sysv?=
 =?utf-8?B?aVlOL0xuSjFyaTFvYzNtbzFHbXBDWUdrczJGaUpHZFl3ZldNeG8rMmZ0NUt5?=
 =?utf-8?B?MElPajh1T3F4LzhoenN3SlNwTzlRTTNTT0F0M0lPSmd2QVFOa3p4V21GWVl4?=
 =?utf-8?B?WUhhTElKbmNjZWFDQzk1YUJISFpxektObEs3ZzFDUkhTMHE2R2VWaXpodE1N?=
 =?utf-8?B?Mi9VamwrRCtYV1pWdG16aFZ4M01Xa1psclJmTzZXa3l6SEsvZUhBN21iQmFG?=
 =?utf-8?B?SnBZREpoNFhrL3R5akNIek9Qemp3VGpPWEN4VmF0c2tmUnZ1Q0ZvTFptUGhT?=
 =?utf-8?B?cXBER3M3aWNrdHBqbE4vdEpqYkxrdHJVU01tS3EwcEErZXRYM1ZPQ012VzdQ?=
 =?utf-8?B?bU55ejBsTVVCS0hiUjMrWXFBNkFIUzlYRkdXQzAyNEw2Ync0ZVFuSFppMkw4?=
 =?utf-8?B?b3JBd1o2TFNHRjF5UG5QbkhLc0RsZ2NFSzArbGZEa0dQbUdRakphbU5MYThp?=
 =?utf-8?B?N0VxOTZJN09MRTM3TWtReXlYUWNBVDErb3J2OWxxdTlvZG1hYXpzUGJvMFQ5?=
 =?utf-8?B?SlFmNUEyU2krTFl6TmFnaDdwOVE3eGlXWkY2RjhJdXNnMFdzZElNeGt4Q0pE?=
 =?utf-8?B?VkhkNlBNdVMxd3IrcUV4NXNZQ3JlZEhQblBYemNNRk4zNG05YzBiZVUzZGUv?=
 =?utf-8?B?cS9TSmFHOFRQZlN4bE1abXptbjZGSUg0dHJybStZSktBeUJwbURLaUVYM3No?=
 =?utf-8?B?Z1Y5VmZNZ1UxSUxCZUYrTnppampKT21aMEFQMlFMNUxyZzFnQzQ1RFhTVXhY?=
 =?utf-8?B?MmRhUFBHQ1RWTmZ5U0hDTUFWVzNwekVCMTBpZFp6czRWWi9hM0tmSEx0UEhI?=
 =?utf-8?B?U2NkcGFWdjJTU0lTckRTT2J0UFRIZ0RROHVSeWtMUVZFTU4vWlA0UnRmVnIw?=
 =?utf-8?B?V0FRRU1xVUFoOFFpVHczcUQ5RXhIUEpFNnhhSm8yQlVsd0doMTQ0eU5hd0Rl?=
 =?utf-8?B?ZnZ3ZUUwb2Foby8vS2tmZGRXMmRneXF0UWErSWwxbUM2a3lCbVBlRlJ2WGNL?=
 =?utf-8?B?dHRtYUgvbGZycnpVekhYc0tZcE5SSDNLSHhCWDV5cDN1N3ZoRXk5MUJyeGdN?=
 =?utf-8?B?cHRRbUFmR1hCL3hKZXN6azJwM0Y4dyt6ZTFjbE1QbVMwTVE5ZC9JSjd4NzFv?=
 =?utf-8?B?RDBFY0FxbW1ETjhuSGpVSVZIZkMyTkxhblFacDhjRVF3Nkd4T0k4a1dLRmhu?=
 =?utf-8?B?UWRFRU1aZ1Ardm0xeGo5MS9rZnFQRStpSWxUdlNnQkJRbU1MUTcvd2dZaS8r?=
 =?utf-8?B?ay9mZTZqS0x3VmhrdllZbG9OQ09NaWVmVFRRUFlqWXdtZmdPRHFKTUltUnFn?=
 =?utf-8?B?RDB5Y24rTHpqbjREMlZ4bzNWa0U2Mlg2c2NBT1lIYjR3ZGMxYnVhUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d20dc8-17da-403e-bac0-08da4463ca78
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 06:47:41.8363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yf9jjjGCw/lcA6bPv+HbRsF0TbLybljAxlgX/76LFPPf6EjxNjUs6I+TI/ktT0yF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
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



Am 01.06.22 um 19:39 schrieb Felix Kuehling:
>
> Am 2022-06-01 um 13:22 schrieb Christian König:
>> Am 01.06.22 um 19:07 schrieb Felix Kuehling:
>>> Am 2022-06-01 um 12:29 schrieb Christian König:
>>>> Am 01.06.22 um 17:05 schrieb Felix Kuehling:
>>>>>
>>>>> Am 2022-06-01 um 08:40 schrieb Christian König:
>>>>>> Hey guys,
>>>>>>
>>>>>> so today Bas came up with a new requirement regarding the 
>>>>>> explicit synchronization to VM updates and a bunch of prototype 
>>>>>> patches.
>>>>>>
>>>>>> I've been thinking about that stuff for quite some time before, 
>>>>>> but to be honest it's one of the most trickiest parts of the driver.
>>>>>>
>>>>>> So my current thinking is that we could potentially handle those 
>>>>>> requirements like this:
>>>>>>
>>>>>> 1. We add some new EXPLICIT flag to context (or CS?) and VM 
>>>>>> IOCTL. This way we either get the new behavior for the whole 
>>>>>> CS+VM or the old one, but never both mixed.
>>>>>>
>>>>>> 2. When memory is unmapped we keep around the last unmap 
>>>>>> operation inside the bo_va.
>>>>>>
>>>>>> 3. When memory is freed we add all the CS fences which could 
>>>>>> access that memory + the last unmap operation as BOOKKEEP fences 
>>>>>> to the BO and as mandatory sync fence to the VM.
>>>>>>
>>>>>> Memory freed either because of an eviction or because of 
>>>>>> userspace closing the handle will be seen as a combination of 
>>>>>> unmap+free.
>>>>>>
>>>>>>
>>>>>> The result is the following semantic for userspace to avoid 
>>>>>> implicit synchronization as much as possible:
>>>>>>
>>>>>> 1. When you allocate and map memory it is mandatory to either 
>>>>>> wait for the mapping operation to complete or to add it as 
>>>>>> dependency for your CS.
>>>>>>     If this isn't followed the application will run into CS 
>>>>>> faults (that's what we pretty much already implemented).
>>>>>
>>>>> This makes sense.
>>>>>
>>>>>
>>>>>>
>>>>>> 2. When memory is freed you must unmap that memory first and then 
>>>>>> wait for this unmap operation to complete before freeing the memory.
>>>>>>     If this isn't followed the kernel will add a forcefully wait 
>>>>>> to the next CS to block until the unmap is completed.
>>>>>
>>>>> This would work for now, but it won't work for user mode 
>>>>> submission in the future. I find it weird that user mode needs to 
>>>>> wait for the unmap. For user mode, unmap and free should always be 
>>>>> asynchronous. I can't think of any good reasons to make user mode 
>>>>> wait for the driver to clean up its stuff.
>>>>>
>>>>> Could the waiting be done in kernel mode instead? TTM already does 
>>>>> delayed freeing if there are fences outstanding on a BO being 
>>>>> freed. This should make it easy to delay freeing until the unmap 
>>>>> is done without blocking the user mode thread.
>>>>
>>>> This is not about blocking, but synchronization dependencies.
>>>
>>> Then I must have misunderstood this sentence: "When memory is freed 
>>> you must unmap that memory first and then wait for this unmap 
>>> operation to complete before freeing the memory." If the pronoun 
>>> "you" is the user mode driver, it means user mode must wait for 
>>> kernel mode to finish unmapping memory before freeing it. Was that 
>>> not what you meant?
>>
>> Ah, yes. The UMD must wait for the kernel to finish unmapping all the 
>> maps from the BO before it drops the handle of the BO and with that 
>> frees it.
>>
>>>>
>>>> In other words the free is not waiting for the unmap to complete, 
>>>> but causes command submissions through the kernel to depend on the 
>>>> unmap.
>>>
>>> I guess I don't understand that dependency. The next command 
>>> submission obviously cannot use the memory that was unmapped. But 
>>> why does it need to synchronize with the unmap operation?
>>
>> Because of the necessary TLB flush, only after that one is executed 
>> we can be sure that nobody has access to the memory any more and 
>> actually free it.
>
> So freeing the memory has to wait for the TLB flush. Why does the next 
> command submission need to wait?

Because that's the one triggering the TLB flush. The issue is that 
flushing the TLB while the VMID is in use is really unreliable on most 
hardware generations.

>>>>
>>>> User mode submissions are completely unrelated to that.
>>>
>>> I mention user mode command submission because there is no way to 
>>> enforce the synchronization you describe here on a user mode queue. 
>>> So this approach is not very future proof.
>>
>> With user mode queues you need to wait for the work on the queue to 
>> finish anyway or otherwise you run into VM faults if you just unmap 
>> or free the memory.
>
> If the next command submission doesn't use the unmapped/freed memory, 
> why does it need to wait for the TLB flush?

Because it could potentially use it. When userspace lies to the kernel 
and still accesses the mapping we would allow access to freed up memory 
and create a major security problem.

>
> If it is using the unmapped/freed memory, that's a user mode bug. But 
> waiting for the TLB flush won't fix that. It will only turn a likely 
> VM fault into a certain VM fault.

Yeah, exactly that's the intention here.

>
> The guarantee you need to give is, that the memory is not freed and 
> reused by anyone else until the TLB flush is done. This dependency 
> requires synchronization of the "free" operation with the TLB flush. 
> It does not require synchronization with any future command 
> submissions in the context that freed the memory.

See above, the future command submission is what triggers the TLB flush 
because only then we can easily execute it without to much hassle.

For Vega and Navi 2x we could use async TLB flushes and on gfx6, gfx7 
and gfx8 we could use double TLB flushes with grace time, but Navi 1x is 
so horrible broken regarding this that I don't see how else we could do 
that.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> The signal that TLB flush is completed comes from the MES in this case.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>>
>>>>>> 3. All VM operations requested by userspace will still be 
>>>>>> executed in order, e.g. we can't run unmap + map in parallel or 
>>>>>> something like this.
>>>>>>
>>>>>> Is that something you guys can live with? As far as I can see it 
>>>>>> should give you the maximum freedom possible, but is still doable.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>
>>

