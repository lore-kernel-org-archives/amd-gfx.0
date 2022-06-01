Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4454FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 17:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3BE710E05E;
	Wed,  1 Jun 2022 17:22:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ADAE10E05E
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 17:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9J87TSMvbRfauDqH3eMv3zngZN1bwMz+D8G3NBTY1Ir9+TCmQqrhFqCSWRKRXcEYKbmmKJQPzOjl4avHpamNk8bpwzC4jABunQUmyoO/AWPjuP/KOWY3e+ovYqSJByNSHqlWzov/iEVwHcCeWPHhbitBWF5NWpqzIgi8wKF8z+Q83D9sqoyZwDDZhac/REeg2Uf4jq/HATW0iV1nyyqw+wgDRgfPQ3r+G9R80kaJt+4ClF5LhyWkWcZpPUbWrZyiHLGnTKcr/aPyg2ka7I+k4jvnxbA63/89x5W7N3WYItYKjwgbX5C2AVv/Mox/If+Ro4T+Qwoj+eftNPOSvB2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae4A6BIYkhb4Y44GASmeZjfw6sAao4Mm062a38BfWQI=;
 b=C9wwcp4MxPFSxhTDpri6Z7sKnDhdoUOaMu5CQrMg7LvP7ELan7zGgW14hjZpZWhZfvlP5Tq1srB+cBIIgaoTa40lA+lnId1Ks2OsfTTW8xyvY1/QAmMcxlZH9TcaM1dXoeWQ0xr2W3cxGL3ydkrZskDBavtLlbhLZov2d3lndkre3JVRsKVdMVRpIF8vnMrlRSNgHcniHKx+vXBbnZBtgs+GBW+cx5COqxU5chHsqNZ/X4+OZkR50gl5IVik0p7DY/uYaAChcwQOMkZzK/pnqUqAQlcDdKNjx3ukWG8GdQNn7G0ndmC7FuWfAP1g4IzAO5mgn96GqpeQORW+iuLYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae4A6BIYkhb4Y44GASmeZjfw6sAao4Mm062a38BfWQI=;
 b=0XSkabDYlfKcYBc6kEbk7AO3eUEKP35m9RMHL+BthRlX8CEsXff9khU+KnkDJy9nTTz1ksf0MCqJOXKUii7OsYzEYqJGxkzHQ3NnW6VyN+ziyOUoTnThYeWrdC6e0QmJC/sZpEIU6UYjNzlM4n/m05IDS40PnqvRdNmC1Rywa4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY4PR12MB1622.namprd12.prod.outlook.com (2603:10b6:910:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Wed, 1 Jun
 2022 17:22:36 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 17:22:36 +0000
Message-ID: <743af352-bdce-a69c-7ecc-2fc99441c82b@amd.com>
Date: Wed, 1 Jun 2022 19:22:30 +0200
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <4d563bf0-ade6-fc3e-9de1-cc2522c4a57f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::34) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7509d308-cccf-476b-be7f-08da43f3525a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1622:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16224D00F901B6818543F71983DF9@CY4PR12MB1622.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHNGBxdljut7LER+Do8BlIo4c4bFnZeBEhiYSvpETbzMwyA6LNNf8B52sgK/4WDL2sK/zFtHrFIMAh/TuPCJW6a/mfUivsB3YBeNJu3LjxFIIQDsAMtXdv6wN3rhWDXfYOzCXXpBVDOMEPlGquzDoOxPYytpPRwpAWQbgjdQd6oE+Pz6+ecfMbBy7rhhp3OLfGaFtE9dx7yti1ZIqJsGBwyakk3XRGOymO96m/RWSAhBJ1tV89iIXAwzFnQz65ATB+E4nD37L1zoPvvKEqV2AoUtVp90Vi83m3udFyXtjFP8b3CxXOvmXa2rcoU7QL5jlFq3gB4n+kuFdPk9pbiMSPz1EMDiX2lH17ZBDZ/uNr+Zh+r91FvrNyccGgfeyhaWETpRMc8dcZjit+yYWlGWoUxIqTXGN3f5IZ+UcRx2jTwTgFXutgujg/GdV8/2QRzMrS5fkBng+HhRx0F7jyyHpaIruNm5SGLRO7sPhlA6L32megV/yMxSaPVLKVnbn2uAmGwSW0Hd3zVsQ0Xk5Djg+e56tQ4kkeXhzsy+etLUCOFHiXifCkLtKJkJ1hGankv8XWdPoYPFOgtBNa3uerEHsotrFNbzXyuj+uU2AUoCsjgRqB3gD2ixjgYL4w8E61DVCw9vtASU6Yrxu0S35CL3t4L2R2Q+Q5+zJVvxv+EtcTV59mw8xAJKX5CZbY58YyNDj3TjYFcGw2bQbiWinzPuT9PYCMCfT/Q+v/aaBB6dBD7krqqNUE0DLW8Az11KmLqf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(6486002)(6506007)(110136005)(86362001)(2616005)(6512007)(66574015)(15650500001)(2906002)(6666004)(186003)(31696002)(83380400001)(38100700002)(6636002)(66946007)(8676002)(4326008)(66556008)(66476007)(316002)(508600001)(31686004)(36756003)(3480700007)(7116003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE42NHJSNFlnVFhMNndoc2MzUys4eGhPRFdlR29PQ3BQZzdjZkp6cUlXWHI4?=
 =?utf-8?B?WDdzTmkxcG4vdjBRb1NxQUxUbTVNVFpSYkcvTkI3bmZjKzNoWUNNNVZWVE9k?=
 =?utf-8?B?ekh0TW5CUlNRUnVrSzVyNDlVUXNSWHVnRUtrNUtrQXRWUkxZZHpuc1p0MDF6?=
 =?utf-8?B?b21JYXlEWVN5UXBGVUR6VGxEcDNZQlNWZGJNSHVacDBoYVdqRUVrMUdaaVhB?=
 =?utf-8?B?NlN1N3ozdm5kQ1RQa1VpWmVBemhNdllob0dDZXZOeGkxdHhJMmo2ZlJuWmVK?=
 =?utf-8?B?WWc1RFVzSmx5L09md202VlNVZjI2b2tKOW9abUVTaG1SUWwwNVoxWnk4S1k5?=
 =?utf-8?B?YVF5emwvSE1rcTNjVWJhTURWYVdFUzEyRjZhVEJDQzN2V0EraEpndUI5Vnp5?=
 =?utf-8?B?eEptWFpSb0szblU4bHZTV0gwWEk4b01QV09OTmJxYXJBOHFJQk56TE4yRmMr?=
 =?utf-8?B?dHhxcWJrQkFzaTV2U0FNTVBIRnRnR1YxQWxpN2ZLcGNWQittOEZ4REptTDUx?=
 =?utf-8?B?QUJiQkE0aVZnREkvMEFwK1RIaEhvL0svYWlFU080VjhFN1ZxODE5cGRhQ1p3?=
 =?utf-8?B?c1k0NU05WVNoVEVjcWtvVFdMQllNdDNNVWQzOWhJcVNKWXZ2dzJHOHdzVzFs?=
 =?utf-8?B?VjVDckRpc2p3bThob21Ec3hOS2dhcm1GUHBNaXQwOEVEZ1N1N2ZVZ2NTY1pE?=
 =?utf-8?B?UnlGNXhPNjNZUlhxS2hqcUVxaFFTejI4SEdGOXJWWExhcEx3azBQR1BWc285?=
 =?utf-8?B?YzgwNlAxQjE1LzlXL096WmZKbFNFdko3NTJud3lOcjRSUGpGY2pZazhRMnRm?=
 =?utf-8?B?SGJHRk5MdDgrYzJ2UlFObE9iY1B2OUNNOEgvUDRjelBsaGRFYWkvTExza0xr?=
 =?utf-8?B?TDdkLzdNTnlrTUwwVUNkK0o5M2JFMDN2bDZwcGlDeXRnTEl1QThwVTdHVUkz?=
 =?utf-8?B?V3k5MzZmc01CdVB5N1JyQzRBTXZXdDVFZXlLRkYrV3p3UWdVYjRHeFQzRHE2?=
 =?utf-8?B?RTZrd1Z2N0RvaFhLUUNrUkt6SGNpMzBaUzlCbXp3UjBCM1RTUHRCRjc0WGp3?=
 =?utf-8?B?OFdseGsySjFDc1NGK2hMR3MwaHczaE81ZG4wR25yS3BRVXJ1c3pEUGZ2a2R0?=
 =?utf-8?B?bzlOT3RxNnpaR0l5TVNNVUxXZnUvTWR4TGtNRGVUTDdtLzlYdC9IWFE2Umo4?=
 =?utf-8?B?T2pTbnkza3ZvMXZVZlRnWFNvQ3BOblA5NjJlbHAxMyt3aG1qQTBKUlREMkk3?=
 =?utf-8?B?cFZMVlFqWGYrUGtFYmVOeElDMzZOZk1RREZudy9adWQ0QWhaQTczRzFKNDBo?=
 =?utf-8?B?cFJwenhHcHExdVdvWVkzbFdTRDJkVTMwRllRWGEzdHB2WS9sUTRQeU85OGEx?=
 =?utf-8?B?amM5NHEvck9hKzBvR1dUNFJXcU1MazBXOWxHbXc1VGRUQmxGbmtPVEpQWUwx?=
 =?utf-8?B?NXpNM3J6aGUzbEhNVFFpMW9iVE5icFU2SjVPYlpPSmpxVDVkdU56SDg0aEwx?=
 =?utf-8?B?elE3TmZUdUxOa3Yxa2JNakpaRmNleVBpb3pIRUJLTGxmcklVOVZ4N1h0ZUYy?=
 =?utf-8?B?L2hJZXdFYzg4VjVMeVlicC90cGNGVUlPeU0zVi9teWNjdjVNaXZtcC9RQXh4?=
 =?utf-8?B?NFJqNVdPVkczYkhVbk5QQ1hEeWxWVFVRTkFWa1RhMkpiYlQ5QXlGaGZ2aFlE?=
 =?utf-8?B?SklPcjc3YXRYNjlmbGFSZVdtV0FCNldWUGRtYmp6TG1Bdm5JM2ZTMDhFSGta?=
 =?utf-8?B?dDZKRTZaME5xRUxXdHRtby9VaWYwOVpwQmZZakUyUjZFYmR6K09sMGtwSkVo?=
 =?utf-8?B?NUMyVE05UkRwVUMrcVZnK0JxakxlT2hNbWhsZ3JzWnUyQlpMRnQ1WDlya1JM?=
 =?utf-8?B?RUFycVozcHFEdWR2eDgrUUhwVUN3T1U5UnFFLzk5S1NPenhHYjNObzQ1SEha?=
 =?utf-8?B?aFQzOHVvVnJJRTN0SnQzMHlxdWl4Z0loNWgyUEI4dGNlbmZlMHVSbERxWTIy?=
 =?utf-8?B?Q0FPUmNGOXhMRHphNDFJeGF5cXhFMmJ6SmRpQTQ5SzBQeFFYWVhmOEZhZnZs?=
 =?utf-8?B?ZXlnRlYvbU8xd1VjTTkrUmRuSFpUTUdvSXhRUUZkV0R4Mkp3VnlQeElEMHBV?=
 =?utf-8?B?KysxWEJKek9sQTQwelBlc0xyM2RYZytYa1JMenJweWxIc040d0VZRktWeFEy?=
 =?utf-8?B?ZzZ0TllNekcrYVNHNmV1VXJpQkR5NG9NTGJ3bTVYZlduVFNmc1F6QXd4djQ5?=
 =?utf-8?B?R3Y4M3VQSkFjdTJkMm5md2l1RWpWUkJ4bWRDUm1PKzdqa043dmNSc2lxenlX?=
 =?utf-8?B?UW9CbUZqNjJXY2tiSVhRWXYxd3dudWRvNXErUGIzb0MxTS9LdDNOWDd5N0Q4?=
 =?utf-8?Q?U9N96tVrPjFaGAgz0UGI92elgxK1dL8hjKa2/xZ8nk0SE?=
X-MS-Exchange-AntiSpam-MessageData-1: lFAGTP5khXEjAw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7509d308-cccf-476b-be7f-08da43f3525a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 17:22:36.6795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ByDp3KHwe/qHS+8UDb5FIPR2QC2qKYiITV/l1utgJYxCOUwxuz47hSbNOa1t7q1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1622
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

Am 01.06.22 um 19:07 schrieb Felix Kuehling:
> Am 2022-06-01 um 12:29 schrieb Christian König:
>> Am 01.06.22 um 17:05 schrieb Felix Kuehling:
>>>
>>> Am 2022-06-01 um 08:40 schrieb Christian König:
>>>> Hey guys,
>>>>
>>>> so today Bas came up with a new requirement regarding the explicit 
>>>> synchronization to VM updates and a bunch of prototype patches.
>>>>
>>>> I've been thinking about that stuff for quite some time before, but 
>>>> to be honest it's one of the most trickiest parts of the driver.
>>>>
>>>> So my current thinking is that we could potentially handle those 
>>>> requirements like this:
>>>>
>>>> 1. We add some new EXPLICIT flag to context (or CS?) and VM IOCTL. 
>>>> This way we either get the new behavior for the whole CS+VM or the 
>>>> old one, but never both mixed.
>>>>
>>>> 2. When memory is unmapped we keep around the last unmap operation 
>>>> inside the bo_va.
>>>>
>>>> 3. When memory is freed we add all the CS fences which could access 
>>>> that memory + the last unmap operation as BOOKKEEP fences to the BO 
>>>> and as mandatory sync fence to the VM.
>>>>
>>>> Memory freed either because of an eviction or because of userspace 
>>>> closing the handle will be seen as a combination of unmap+free.
>>>>
>>>>
>>>> The result is the following semantic for userspace to avoid 
>>>> implicit synchronization as much as possible:
>>>>
>>>> 1. When you allocate and map memory it is mandatory to either wait 
>>>> for the mapping operation to complete or to add it as dependency 
>>>> for your CS.
>>>>     If this isn't followed the application will run into CS faults 
>>>> (that's what we pretty much already implemented).
>>>
>>> This makes sense.
>>>
>>>
>>>>
>>>> 2. When memory is freed you must unmap that memory first and then 
>>>> wait for this unmap operation to complete before freeing the memory.
>>>>     If this isn't followed the kernel will add a forcefully wait to 
>>>> the next CS to block until the unmap is completed.
>>>
>>> This would work for now, but it won't work for user mode submission 
>>> in the future. I find it weird that user mode needs to wait for the 
>>> unmap. For user mode, unmap and free should always be asynchronous. 
>>> I can't think of any good reasons to make user mode wait for the 
>>> driver to clean up its stuff.
>>>
>>> Could the waiting be done in kernel mode instead? TTM already does 
>>> delayed freeing if there are fences outstanding on a BO being freed. 
>>> This should make it easy to delay freeing until the unmap is done 
>>> without blocking the user mode thread.
>>
>> This is not about blocking, but synchronization dependencies.
>
> Then I must have misunderstood this sentence: "When memory is freed 
> you must unmap that memory first and then wait for this unmap 
> operation to complete before freeing the memory." If the pronoun "you" 
> is the user mode driver, it means user mode must wait for kernel mode 
> to finish unmapping memory before freeing it. Was that not what you 
> meant?

Ah, yes. The UMD must wait for the kernel to finish unmapping all the 
maps from the BO before it drops the handle of the BO and with that 
frees it.

>>
>> In other words the free is not waiting for the unmap to complete, but 
>> causes command submissions through the kernel to depend on the unmap.
>
> I guess I don't understand that dependency. The next command 
> submission obviously cannot use the memory that was unmapped. But why 
> does it need to synchronize with the unmap operation?

Because of the necessary TLB flush, only after that one is executed we 
can be sure that nobody has access to the memory any more and actually 
free it.

>>
>> User mode submissions are completely unrelated to that.
>
> I mention user mode command submission because there is no way to 
> enforce the synchronization you describe here on a user mode queue. So 
> this approach is not very future proof.

With user mode queues you need to wait for the work on the queue to 
finish anyway or otherwise you run into VM faults if you just unmap or 
free the memory.

The signal that TLB flush is completed comes from the MES in this case.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
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
>>>> 3. All VM operations requested by userspace will still be executed 
>>>> in order, e.g. we can't run unmap + map in parallel or something 
>>>> like this.
>>>>
>>>> Is that something you guys can live with? As far as I can see it 
>>>> should give you the maximum freedom possible, but is still doable.
>>>>
>>>> Regards,
>>>> Christian.
>>

