Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362D6C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 16:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08F310EF26;
	Wed,  1 Jun 2022 16:29:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6A710EF30
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 16:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJmN2721i0fhBiwKx8RyTJAlf4qwdbtH3ZkjCuD/Wy739RWchq4Morre577xBj/FFvp+S2wlerfnVKp4WF5mDYzJOt5LeYZLS0l8lOMXPlTsd/L+Hi5asneS8kPAVXz42wVdBtvqS8bErY/1kNRiZgAyVHSL6XPeLURdQOtn6gBr9xFAJbyqVSLIudB0w8nJa+lLFhw3EFpPGemfOQbd01P85zThHu9t0tVjDgeULdLoB8JjVtBmxilRTcd7btnexVkSU396eh7z5tlROmU+Mklj1SC3Wcu88K+KrbhV3KOq7hbjLh8d/XJKbmRrppryqwXRc4PddYBdiXmfDzzLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3Y4FTIXIE/U/KeyaZw14wUOkVOJG7Sxk6ZY1VMyTSg=;
 b=R9audB7dvrn/roSDwvvluCwEOB6HAJvh+SorBwYbAWZ3e2VZ78NhbNeYxGN4Pjb8KoHr5NYwWqGluKahSAv91S+bjU4+2W2bHntyWN6g7eGJSdH6qnlb0lF7yUrJ8A2lcjAJVE2Tv+TfE74cPRgUX5YHYb6DY94Ti+TWYHgjUqXQ7IzQs4I5T4DsKP4J3ELuTC4e1GFKWpf4xp5f4FTgkKcnvKeYZ+2nz7FpbeEkCEZSTuiugG9Gh9EFcn5V9VzwSZvpClHlfm6p5HDlkHidDhXB398nqGIlBGnbRajELjZoBEeKKblA0AsdVs1mQCIajwq3nXojTgrg/kyKsMB9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3Y4FTIXIE/U/KeyaZw14wUOkVOJG7Sxk6ZY1VMyTSg=;
 b=XNoqF3j+YLLMFu/ywtVGvQpSwQB48b6UKlDoJoTidlTgnFg9HMcH6Jb8OfP4dhJ1AfygDzJIV8OO9FTHGSh8roNsJsf2dnlfNVex4NdzKhMgneboY4U5j2/hN/XBpu345tCnmq+USmML3wvHwgH1aXly24d14YCd+3KYHi27X5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 16:29:42 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 16:29:42 +0000
Message-ID: <412a23fc-eb92-8f3c-e339-0bc3918c0f18@amd.com>
Date: Wed, 1 Jun 2022 18:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Explicit VM updates
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
References: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
 <022d86d0-6301-70da-f320-b17c4859443b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <022d86d0-6301-70da-f320-b17c4859443b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0236.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::27) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20b909d4-f5b7-4902-93cd-08da43ebee5e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4297:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB42977EDA4E1A91DA4582CC1183DF9@DM6PR12MB4297.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMpShuCa8Eas7p3HpOM+2Jop5JnPiBxBxj4JGRKeEKKrFgaWgomBVg7lW6CPMd8DorUU9QxwLwAo2VT++56JKZJiEcLNFvA//aLkkPjTnr+6W5iESfZmZrln97iTTrYY6kE8ZmbVygP1Y9YssOdekJidgTxhFyCxAe/n33ybNVSEDsoLL677kdbcUx/Xs/NM8wDZTJ6XUePJjnhva3tAVRjmWBRnvYjnGHMUDdha+K1Oa6YCEYY6J/eN0g2szqIvmNzPiIhNtECFU6O5rd+bF+UVmajCHMgjpNtNcDwxgdIEkCN4a6G2y0naiZpz8F8Y7MKG4ACjDI+0r1d7nBNAhdQLcF5KvTn5WeBE4kYUDhNDk3ceml01JwMdUS0bgDmwcpDfjj/KC1bceEPAyJ1IdOmH0uE4l0+amSzU+IgO8eV7sLow2ZSZyQfNjdZbGMPQxx6mJkLOkSnMuCxK7Nqwhd56HDnHw9ndO9iDdyDiOdqLia7moZha4wPh9lJQAZKsyPPGl3OJxkEiaOGh20PZ+aOjnsdez8NMnD+nEKg1S8+YRyKWYGOSEpChQvmDg5mBXUU75nEgmWwkjtxFSeJTEVIgBwA5pJqkJOWRZ8XNKxwkxP2i76TzI10JGeyts7VLJxZ6oIsh9nvh19T2iPdhmNF7UBoTSgi4EjUJ8PUiS0vI79mOQnqHwc+FLZKdzckbCSUDOxOkWwqWiCjdrSKr8Be83M+rF4e9Z2KFCLj1GZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(186003)(5660300002)(508600001)(6506007)(8676002)(66476007)(38100700002)(66556008)(36756003)(66946007)(4326008)(31686004)(2616005)(8936002)(15650500001)(2906002)(6666004)(31696002)(86362001)(6486002)(6636002)(66574015)(6512007)(7116003)(110136005)(3480700007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFgzdEdtVG9jR2dUTk0rK3djODUxOXM4YzIrYU1lRWdBemVMN2xMM3RyWndX?=
 =?utf-8?B?Z3ZFeFlVcmRhYTFBYWl2OWtCczBxWERGY1c0UlkwRW50WkU4VHZwNXMvY1dS?=
 =?utf-8?B?bU5JNHZ4SGVtaXJuUDlqV0R6Y2R0Y2VTM1NZZ0ZqaDZ6RTNzbWpiWXh3dUJH?=
 =?utf-8?B?VXJLbnVoaE1JYlNTUFAwbVNSRnBiZEpwRThjWmt2MS9VRHRXbzBrVnhIbklE?=
 =?utf-8?B?L0xDNTJoMWtESnFRd2JzclB5d1ErRnBSeEhsdUQ3eUZWMVMzdGYxamE4M25h?=
 =?utf-8?B?NWk0eTFFZVYwT212WTBnTmtiemNLUDVQVEU4TEpvY2IyY0lZRnRRUjMzdXFE?=
 =?utf-8?B?NktCTkdQSXN2VW1yeEtzN2VRM1c4VzZ2Lzl5QTBFMjBqczRBUm5WVVlZaHM1?=
 =?utf-8?B?ZnBxWHlmc0FiTW5ndjh2OVRsNFhRcXVJTDB6UDFkQy9Pb1lhemdvaGdOSWQ1?=
 =?utf-8?B?NXhDdHMzNitxV3NtbVhvY2hGakRZblNKdnVIQW9JS3I3THVXL0FHOFdOYkFQ?=
 =?utf-8?B?dWprUjdrOXNianFETkFqcWd1ZDdMQTFveVhUREhPMmc4eW9mMStXNlFJUklU?=
 =?utf-8?B?bmxHMk5jTmtOTVU2ZTdWR0RURmZYUG5lZzI2ak5ZVmFYS0hSb3F0cm1YQWlS?=
 =?utf-8?B?bk5RK2tRUWNBQjRHN3dJS0kxelBTSGdnb2UyUkhzVVZBUFV5OGVQZ29PV01Y?=
 =?utf-8?B?QlcxSnQ5WmpOeXorckV1RDE3NXM3NWFjQUJzd1EycGtYOVhpSXBKb1JCQ1Jz?=
 =?utf-8?B?N2g0N1ZpblVseVhBSkhCYWFsbm40dVQyeTJidHVSVDh1RHBTb1RBVzltZ1pr?=
 =?utf-8?B?Qm5mc0hHT3o5bno2blFna05Zb2plNjVVUzRTMTdocDAxWGNTNWIramoxblFx?=
 =?utf-8?B?bHJYSlVGQW5GY0pkeGNpV1kwNFpUcTYyMVhHZnJmd2cvNlNvNHhVQUFheWpB?=
 =?utf-8?B?SjhlaGdxQkE0OS9uU1hIeTBIN2tTRUkxU2NYekt0NzIvOStnRlhDSkVLUXBj?=
 =?utf-8?B?c3hOZkJkWHdlTUUxNlZaKzdkWG5FQ2R5bXpuN2RWczhZcFUxN2lDenVyajhJ?=
 =?utf-8?B?YzlxZUhYVWNpc2Q5RTRTbjgwYXg2YjQyVXNFR3dqRVVCbkVQMWM3Y3hMMDE2?=
 =?utf-8?B?K2xIUXZFRFFUaGk2VDNxV3VRcGZiSDBnMUs4OFYrT0U5VkFWZEVlTk5VZ2FM?=
 =?utf-8?B?Q1JsWUIvallqa09Yenp2ajF3QU13ZCtRT09USi9LTUNiZzNxMnEyYVJHVlYz?=
 =?utf-8?B?bzRIT0IvbldydlcwaTdacEplc2lMdkZhaHJpRHlQSlg3U0w3NFAwRm1seGsv?=
 =?utf-8?B?ZlA3c1JIYjZNQU96VmhLL1NpZHhWVW00QndneUttTTJnelNXelBpZlN5bXdZ?=
 =?utf-8?B?cWk0TUEva1JWa0pyMXNMRTZCcENGNHQ5T0ZTcFBJRVdGZDhON1dCTWIxQkpG?=
 =?utf-8?B?UUFDMHhNNXoyVWtEMjVGVmh0QjJPeGp2dS9PWGtUREJnbURSSHJyaGRuQzFT?=
 =?utf-8?B?V29mS0xLVW5lcTNHdThNcVV5cTNldDB1VElFa08rUnpMc0IrZEpZQU1hK0dY?=
 =?utf-8?B?L29zUE5jcWkvZEd2dDhhb29JRXFNcGwrb2RQOUtKVkdhRkVoNmppbWNFd05F?=
 =?utf-8?B?WHNMRTM5ZlFSYnhSVWMvNXRtRkpBblFuNHdVanpFeHE3QmdTYzRBWXh2a2dC?=
 =?utf-8?B?c0lMbmJRakJvaFV4cWc1S29NZytpRHY4UUkwQ205bGc3NkVwbTlHSTBwdkFn?=
 =?utf-8?B?Yjh6M1M3MnE1cDVCNG80VUVzTzZhdUwwQTZ1aTdJUU5yWWtFY3dKQW5HK21m?=
 =?utf-8?B?blhYeHZqanJTZGdhOWZRTysvRzlEVW5LVU10K2szMWo0QncxS1ZNT0N2MzRy?=
 =?utf-8?B?UEMwZVgxdDlET3ZVY0RzTmtuRkgvc3U4ZG1ZWkdrZFpOUE8xOTRITjNTNW1I?=
 =?utf-8?B?dkR0UjlIL3BYWTFsWm9yQlh0UkVuNkJhSFBNd3JxREdDODJSOVJkYnAra09Y?=
 =?utf-8?B?a0t0QTlZS1hxYk56MTMrdDB3L0IxekZUekRyTk5YSnZmSEIzb1JHOVJoVUlI?=
 =?utf-8?B?bC9KMUZmalBOME1hejRBSTJTRDJQTXZXNE9XRitpbzZ3RmVtZW5HRGdtOG55?=
 =?utf-8?B?WC9iczlrMVBGTlJzR0Y4ZU80OTJaeE1iK3AyNm1GN0M0MDc1U0ZocTB0WjZz?=
 =?utf-8?B?T01ZMlBRZ1B4b096c2RrUVVCSVFCTzFPQjUrVW4yUWI2VExiL0JtVU1sd1NE?=
 =?utf-8?B?ZkNvanl3SENVdmpXWlFDMjF5TnVMTmRuTzMvb2lURWJWczZORVYwMWFraUlk?=
 =?utf-8?B?cU5TSHFvZCtVbWszSG5TeWNTUzh5TFlVekxxQ3lSL24yMXVnYWt1VGsvRksw?=
 =?utf-8?Q?p4cQOqcYgvv+gt+dwNjEYOlEitDHDV69xk9oxgd9Vnb7C?=
X-MS-Exchange-AntiSpam-MessageData-1: 5FGeXbCHQp1WkA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b909d4-f5b7-4902-93cd-08da43ebee5e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 16:29:42.4553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/xMi4RiWQOWtsHin3aJg8DRrtzSapM3WjGZmfzj2514+VFhGcekULl4FFSfVHh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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

Am 01.06.22 um 17:05 schrieb Felix Kuehling:
>
> Am 2022-06-01 um 08:40 schrieb Christian König:
>> Hey guys,
>>
>> so today Bas came up with a new requirement regarding the explicit 
>> synchronization to VM updates and a bunch of prototype patches.
>>
>> I've been thinking about that stuff for quite some time before, but 
>> to be honest it's one of the most trickiest parts of the driver.
>>
>> So my current thinking is that we could potentially handle those 
>> requirements like this:
>>
>> 1. We add some new EXPLICIT flag to context (or CS?) and VM IOCTL. 
>> This way we either get the new behavior for the whole CS+VM or the 
>> old one, but never both mixed.
>>
>> 2. When memory is unmapped we keep around the last unmap operation 
>> inside the bo_va.
>>
>> 3. When memory is freed we add all the CS fences which could access 
>> that memory + the last unmap operation as BOOKKEEP fences to the BO 
>> and as mandatory sync fence to the VM.
>>
>> Memory freed either because of an eviction or because of userspace 
>> closing the handle will be seen as a combination of unmap+free.
>>
>>
>> The result is the following semantic for userspace to avoid implicit 
>> synchronization as much as possible:
>>
>> 1. When you allocate and map memory it is mandatory to either wait 
>> for the mapping operation to complete or to add it as dependency for 
>> your CS.
>>     If this isn't followed the application will run into CS faults 
>> (that's what we pretty much already implemented).
>
> This makes sense.
>
>
>>
>> 2. When memory is freed you must unmap that memory first and then 
>> wait for this unmap operation to complete before freeing the memory.
>>     If this isn't followed the kernel will add a forcefully wait to 
>> the next CS to block until the unmap is completed.
>
> This would work for now, but it won't work for user mode submission in 
> the future. I find it weird that user mode needs to wait for the 
> unmap. For user mode, unmap and free should always be asynchronous. I 
> can't think of any good reasons to make user mode wait for the driver 
> to clean up its stuff.
>
> Could the waiting be done in kernel mode instead? TTM already does 
> delayed freeing if there are fences outstanding on a BO being freed. 
> This should make it easy to delay freeing until the unmap is done 
> without blocking the user mode thread.

This is not about blocking, but synchronization dependencies.

In other words the free is not waiting for the unmap to complete, but 
causes command submissions through the kernel to depend on the unmap.

User mode submissions are completely unrelated to that.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> 3. All VM operations requested by userspace will still be executed in 
>> order, e.g. we can't run unmap + map in parallel or something like this.
>>
>> Is that something you guys can live with? As far as I can see it 
>> should give you the maximum freedom possible, but is still doable.
>>
>> Regards,
>> Christian.

