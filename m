Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217C606D814
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UBite/+Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D23D10E57C;
	Wed,  4 Nov 2026 18:54:14 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C3410E206
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 18:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7pqwYYnTbT9Tz8VUmsDxxghfwLMytW+b6N9lN6hrYnGGMcVpjX6Z2egq+j3RqKhVvhQEc9bqujmpHl7TXlZp/gKOienDaWGDgrSISAVjpMMj9RT/hAaukU38ehHnqrGiYYrDHn8e5Pnm/O2H0uU/4aB1FJI29gkr8NDB0m54lpjM0PPBhkTFIsEJyHQCXCfZDHyrDkY+UYKBIXciRN0W19QJK3syUePdB7DSoINxRD3aTSxJUh905BML7rQ5jVz7uMGKjMEPMMIc/jVaX3y5dzLQGbY69N7sn3M4UK7ClBwdpim03/hzO6uetKuQX2kSJ8Zfzzhe1EXPAqxeYDd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbpaKjBl/BJYoKEnYBzM6JQyVnjzsU3+Fc5dbRs6CeQ=;
 b=wIy7Swy6ZpLL785wkSfGZ7yLdYBx4e3W6jSXcoitHB4yztZzMO9nB5WLfchj0+xDZPwrQifHJFfgu1WplGgTL+i4lywqcNVcLr1F/PRArxCOHsxZEuDtA6xvCpJjwExlV9cy6dl7efDAvXQ4iazaD79af3CrqwQ736N4gdsPTS2kV314bP6w/UAkfpgBR7uyihHaNF44xuH6Cn/m0TOf+0wKMLA5O8PeZACasoMcmIAFVzUP0v3vQdBmgo8Xwie7IYlKgKYBAeZPSBXI6nCzMrWRU9kpX65rAUuHW0xhPKHtdNkf4c9k0qBlqxOz9Yok4b9KUhDJkAkGO/418nGyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbpaKjBl/BJYoKEnYBzM6JQyVnjzsU3+Fc5dbRs6CeQ=;
 b=UBite/+ZsiQzDaxbRrv2++EVNEvky+MBZvg3R6S1xeUhcr9Oxi/IyfNIVSdaYaCJDf48cVCEsJiAcyJu2t21dH0WjF+sQKJ2PFE/TI/hi4cQ+q+QQFiX3odj5PiP6lJRI9S+UN4vyoW70boZqo8WwZiUZOEoo7NwGAXSEV5jUXA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS0PR12MB999104.namprd12.prod.outlook.com
 (2603:10b6:8:2fe::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 18:54:02 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 18:54:02 +0000
Content-Type: multipart/alternative;
 boundary="------------AmHGHkiAuwN0uUpEDYP2qyiI"
Message-ID: <4751bd8c-91e8-4985-bdac-52e35ba7f513@amd.com>
Date: Wed, 4 Nov 2026 13:54:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdkfd: Add support for discontiguous and
 CPU-less NUMA topologies
To: Dhruv Bhogaonkar <dhruvb@linux.ibm.com>, Dhruv B <dhruv.b@linux.ibm.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com
References: <20261030083304.9767-1-dhruv.b@linux.ibm.com>
 <20261030083304.9767-3-dhruv.b@linux.ibm.com>
 <70018014-d952-4155-aa36-cf9b39ba8aea@amd.com>
 <1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com>
 <04ddca6d-3880-48e0-a64e-a4bbde32e67e@amd.com>
 <64a82e4a-2855-46f1-8942-3c1b6f8179f3@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <64a82e4a-2855-46f1-8942-3c1b6f8179f3@linux.ibm.com>
X-ClientProxiedBy: YQBPR0101CA0337.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::22) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS0PR12MB999104:EE_
X-MS-Office365-Filtering-Correlation-Id: d59a73ff-220a-492d-c454-08df3aa4fe1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|18002099003|22082099003|261102123227099003|8096899003|56012099006|4143699003|261022075727099003|5023799004|261022115727099003|261019150727099003|261019143827099003|11063799006|261026140227099003|261022113327099003|261026121527099003|261019132127099003|261022105027099003|261028144727099003|261009223027099003|261021121427099003|261019141927099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: Z05tWrD7XjbhdWFneiYr2n+tX4YnYWY6r+z+GMtlkEQZyFvlyJM0vd9WCS5dIxJ18hklOX2EOjLcWJ3Y/9ceEGCrboKOq4G0wdRB24OdN+LeLV9+LeKGmEp6JphJiMl7qGr3S5PaZuK0RD/MWTaGq9xCtqXDvBJF4zhnS+uj3x/R4by9UwlailadiroRAyUN5ywPB5VlFjueuUc6xfW10e9QxlomhwW0hqy9Cz/SEspZ/6Qo3vOAXudoIILq8j2qitM1cu8rFTmysy1tzZyjs4KuQGdzRS0nfnJRSRnzfnMjFQGZsY+5RXkSe+sbmu8n7aNLovqzxEZpY91TGw4PMfzQLOFjtLtkt9TRCrwWJvEgwhDen/5H471WjLQQiw2pp7P69yBPUi731Juoh0crA1DEzXspxwijUM5HbBekWveu3TU4Jq83r7v5UEEjHRfyHkSQiC+8UwR1WnBxYXj1qTzl79ty8RiIug7VnGMMcmW52iuOp80l0eZcNfwg9rsUKBC8VkdYR5iUDoUaK4ILIHiaWC9ndmfcLjlXZHQK+MzEU8YOncYQmxlNKXLdnkkj69Mx53ZQZdKo2eNP8GOaMRhOus6FfR8LTI5t2YG02L1TA+zhguVszOKBYFI1skH5CrezQuzZVyXEZwz7eMBWXqCjg7zyZDLFNJFg5GUdI5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(8096899003)(56012099006)(4143699003)(261022075727099003)(5023799004)(261022115727099003)(261019150727099003)(261019143827099003)(11063799006)(261026140227099003)(261022113327099003)(261026121527099003)(261019132127099003)(261022105027099003)(261028144727099003)(261009223027099003)(261021121427099003)(261019141927099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJ4Y2lzSm9NWGpERnk0NGFYVHN2ZzVVVnJyalZNZEtZRG1zMHJLdzZtMHpS?=
 =?utf-8?B?Y0lqb1I3akM3cmZvN3p5eCsrdHNzOFR5YitmY0N5YXRxK1ZBM3VxdVpOT09S?=
 =?utf-8?B?RXg2UjhqL2JqUzhWUHpub1dVY2oyOHc2OGdPK2MwQzRHZmY5VkJLSTljM1Jm?=
 =?utf-8?B?cXI2K2U4bERYWitBVnBIaFBFenRmU293TjZDSnR2WE5vOTNHNXVsczZLYVVJ?=
 =?utf-8?B?U3AvYWo2b1o0dGgvcnRhVXFvYms4TUlqdnpROWM2NkpadkNNbUQyQk54TVov?=
 =?utf-8?B?Ym5BVjlLZWVKOVhGTUhRbXVDa20rU0JlUDBPWVFVZHdSTnRsemtUbGhwV0ZL?=
 =?utf-8?B?RzcrU3NoZXVKQjhUTTQ2L3lUcDdDT3NTdDlaM1EwMW9LejJqMElRMHpZd3BY?=
 =?utf-8?B?RDB1Q0lXS2lxL0VpVk1GcTZSQm9DTXhpeHd0ZHQ2RXFQaThia0wvZEdiazFJ?=
 =?utf-8?B?eFZrTEN0bTRxMmZvakI3eFNvRndpME5KTEg0QmFqUTlrcVdpRWhmdG5ON1hR?=
 =?utf-8?B?NzlrWm5yZE8wM2hpSVdoZVdrTWN1aThBa3FaYUp6bW5CWVYxRnFteVBCNUVY?=
 =?utf-8?B?TDI3TVc1QXh4UjlFN2xob1d5K2orS1l3dlYxZS80eTVpU0M4VWdyNjlrb2Fo?=
 =?utf-8?B?c2NqUS81UWt3STRkQmJUUlpTNDZmOUU4L3FhSk9DbDk0SGcxeVdPWDVpUUtJ?=
 =?utf-8?B?ZkxsZk04eUhoOHFGWmdWQVk5eUxuSVdmclcvOWIxaVJwMTdGM21SQXNPK0tO?=
 =?utf-8?B?cXF3elY3Skovc1VBdjRzMG1aUkNrZ1RoYlN0RjhMaU9ocDNnWmZxbWV3TEtJ?=
 =?utf-8?B?aHRqNlAyRy9tMExpdlRCQ0FJdGN1bHhLUjVseGxxa0tPRDFCUDlxS2diNzYz?=
 =?utf-8?B?YWtiQktrZVdiRWVYdHp0TnlWU3BJUWk2TmQyaExFc28zSUNJSzh5WkRyZ0FJ?=
 =?utf-8?B?dDFsalR4RVZWWk04cHcrZjFKT2NKQWNMU0FvNFh5bWpJSTdrMGtNaFlLY3or?=
 =?utf-8?B?NVdmdzgyZjUxSkVFdDB6dHhiY092Ri9nZWtDZVV3VTZ1dWR6aVh0L3FVcFBn?=
 =?utf-8?B?VmxtWjB6NjNYVVVwL0VXTXlidTdqTmFxcWM1ZjJHdTFBbzFYS1J2OHlJdlpH?=
 =?utf-8?B?aWtaRHk2WUF2MVY1VDN5dzNGQ1pOYkJLWHhPNjBUY3g2TkQ1VUZJSzhDY01w?=
 =?utf-8?B?aU1zd3BVT1lwSG5mWHYzSkJkMjZIWGR3Vlo1Ky9wUms3S3Y3bDJGMGExb01u?=
 =?utf-8?B?RFF3azdEMFN6alRML3BVRlF6Rmw0TzE2NTgvQXdQdEJHN1lyQUdUd01ZZTVD?=
 =?utf-8?B?dWt3YjN2MFd3SzhZQVRhemdlMzhxejR1WWkxcmFLWmYxNDZtM0s5VHhSaFBQ?=
 =?utf-8?B?bFFrd2VnSkp4VGo2Z0ZPeFZCaTlKSm1tWDRhTU81b21WcHZNN3FwSWlHMHFQ?=
 =?utf-8?B?Uk9XMnNkblhoVER4SWVOZ2VRc21wK0c2YStkUWxmUWRsOERhVy85UnNjd055?=
 =?utf-8?B?aXlCeXNwMzJMMjFLeVc2THFneFlHbklwa0Rhd0c1eUw5QVlHczZRYlhsMlVC?=
 =?utf-8?B?VmcxQXZ2S0piaUluSkd2c0RqWmRUWG00ejVETDdONWJ3VTlqamZXMXlEOHZR?=
 =?utf-8?B?Y0tGMk14UGVvQzJOOWk3SlhnR1ozY1I3WVIvdUc4NUNKSTUzaDFHeEhqWThD?=
 =?utf-8?B?bEJnNUFqbXZtVldiZGZPK3AxUlNRMlUzbnJrZjVucE9Mc01lSzZTTTZkZGY3?=
 =?utf-8?B?UUVpRHVqRTFCaXNmTTN6QTRDc09OOHp0SWx5cE5aUmVaeGxIcERRMVpibFBE?=
 =?utf-8?B?ZHFWc3A2cFpVRk04L3JaVDdYZ3J0R3FPYmVhR1NERzVvMFJDYVdyL3d0cHFE?=
 =?utf-8?B?RGV5UlRQSWhDVEl3ZEx2eHlGOEVkM3JZVzZMZnQySFFJbkpDeE95cjVJRkdt?=
 =?utf-8?B?NXJUeG13KzZ6MXJyQnNsZzVWTmJ4MndFTUIzbHRBT2JwaHM4U0xxNkdtNjBG?=
 =?utf-8?B?VWVEWG9WYmd5eGpMLzRxd2pSdzZUVmpzWXZpUkxkWTNrRm9Rd0V1dU1QZGI2?=
 =?utf-8?B?ZEtsVFJqd3p6VEw5UjcyYitOWEJucVN0K1ZSWXdUcmVFa29tM3JaT1YzWnZ6?=
 =?utf-8?B?ZGZ6SGlRRDRDY29ZcVprTXNUSURVRXRFaHN5R1I5T045eWI3Z0JsUkc5UGZy?=
 =?utf-8?B?em9zd0hwZnZBYlBYNDFQTHpaZXRLaERCZXJlQk9BbWV0aWhoenZ2R1E2a2E2?=
 =?utf-8?B?cmNyRUUrdGg4UnlHV01UM0JZNG9UZnB1R1dWdXhUWW5lRDdKM01RdHhYbUZC?=
 =?utf-8?B?aXQzZHZBNkhzOHk3K2tORlladmxFamZJalVTb2ZlUk5hbURmZDM2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59a73ff-220a-492d-c454-08df3aa4fe1e
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:54:02.4243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMIqus6R4V4Tz69yQbSN2pRch6xcURKZbr2yD7qMRzhBoxA54o6z9bXv/OExLw8osmU56+EXl8SACd51gX2Abg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999104
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------AmHGHkiAuwN0uUpEDYP2qyiI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-11-04 12:00, Dhruv Bhogaonkar wrote:
>
>
> On 04/11/26 20:56, Kuehling, Felix wrote:
>> On 2026-11-04 08: 41, Dhruv Bhogaonkar wrote: On 03/11/26 05: 55, 
>> Felix Kuehling wrote: On 2026-10-30 04: 33, Dhruv B wrote: On systems 
>> with discontiguous NUMA node IDs, the GPU driver fails to load with 
>> the following errors: [ 5. 609767] amdgpu
>> On 2026-11-04 08:41, Dhruv Bhogaonkar wrote:
>>>
>>>
>>> On 03/11/26 05:55, Felix Kuehling wrote:
>>>> On 2026-10-30 04: 33, Dhruv B wrote: On systems with discontiguous 
>>>> NUMA node IDs, the GPU driver fails to load with the following 
>>>> errors: [ 5. 609767] amdgpu 0038: 12: 00. 0: Error parsing VCRAT [ 
>>>> 5. 609781] kfd kfd: Error adding device to topology
>>>> On 2026-10-30 04:33, Dhruv B wrote:
>>>>> On systems with discontiguous NUMA node IDs, the GPU driver fails to
>>>>> load with the following errors:
>>>>>
>>>>> [    5.609767] amdgpu 0038:12:00.0: Error parsing VCRAT
>>>>> [    5.609781] kfd kfd: Error adding device to topology
>>>>> [    5.609848] kfd kfd: Error initializing KFD node
>>>>>
>>>>> In the current KFD code, proximity domains are created contiguously
>>>>> when generating the VCRAT. With discontiguous NUMA node IDs, this
>>>>> creates a mismatch between the proximity domain ID and the NUMA node ID.
>>>>> For example, if NUMA nodes 0, 2 and 3 are online, the current code
>>>>> assigns proximity domains 0, 1 and 2 to these nodes respectively,
>>>>> instead of domains 0, 2 and 3.
>>>>>
>>>>> The KFD topology uses the NUMA node and proximity domain information to
>>>>> create topology devices representing the CPU and memory resources
>>>>> associated with each NUMA node. This topology is exposed to userspace
>>>>> through sysfs, where the NUMA node and proximity domain information are
>>>>> used to identify the topology devices. The mismatch between the NUMA
>>>>> node ID and proximity domain therefore results in an inconsistent KFD
>>>>> topology and causes topology parsing to fail.
>>>>>
>>>>> Make the proximity domain ID correspond directly to the NUMA node ID by
>>>>> iterating through the complete NUMA node ID range up to the last online
>>>>> node. Account for every node ID when assigning proximity domains, while
>>>>> skipping resource entry creation for offline nodes. This preserves the
>>>>> NUMA-node-to-proximity-domain mapping and allows the KFD topology and
>>>>> its sysfs representation to correctly reflect discontiguous NUMA
>>>>> topologies.
>>>>>
>>>>> A NUMA node may also be CPU-less, memory-less, or both. Only create a
>>>>> Compute Unit CRAT entry if the node has CPUs, and only create a Memory
>>>>> CRAT entry if the node has memory.
>>>>>
>>>>> Additionally, update kfd_parse_subtype_mem() to use simd_count instead
>>>>> of cpu_cores_count to distinguish host nodes from GPU nodes. This ensures
>>>>> that memory on CPU-less host NUMA nodes is correctly classified as
>>>>> system memory (HSA_MEM_HEAP_TYPE_SYSTEM) rather than private GPU
>>>>> framebuffer memory.
>>>>>
>>>>> The placeholder domains created for offline node IDs have no IO links,
>>>>> so skip offline and CPU-less nodes when building the indirect GPU to CPU
>>>>> links.
>>>>>
>>>>> Co-developed-by: Donet Tom<donettom@linux.ibm.com>
>>>>> Signed-off-by: Donet Tom<donettom@linux.ibm.com>
>>>>> Signed-off-by: Dhruv B<dhruv.b@linux.ibm.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 59 +++++++++++++----------
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 ++
>>>>>   2 files changed, 36 insertions(+), 26 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>> index 99b0c7f825fe..bebbc6715b2f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>> @@ -1103,8 +1103,10 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
>>>>>   			mem->proximity_domain);
>>>>>   	list_for_each_entry(dev, device_list, list) {
>>>>>   		if (mem->proximity_domain == dev->proximity_domain) {
>>>>> -			/* We're on GPU node */
>>>>> -			if (dev->node_props.cpu_cores_count == 0) {
>>>>> +			if (dev->node_props.simd_count == 0) {
>>>>> +				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
>>>>> +			} else {
>>>>> +				/* We're on GPU node */
>>>>>   				/* APU */
>>>>>   				if (mem->visibility_type == 0)
>>>>>   					heap_type =
>>>>> @@ -1112,8 +1114,7 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
>>>>>   				/* dGPU */
>>>>>   				else
>>>>>   					heap_type = mem->visibility_type;
>>>>> -			} else
>>>>> -				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
>>>>> +			}
>>>>>   
>>>>>   			if (mem->flags & CRAT_MEM_FLAGS_HOT_PLUGGABLE)
>>>>>   				flags |= HSA_MEM_FLAGS_HOT_PLUGGABLE;
>>>>> @@ -1899,7 +1900,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>>>>>   	acpi_status status;
>>>>>   	struct crat_subtype_generic *sub_type_hdr;
>>>>>   	int avail_size = *size;
>>>>> -	int numa_node_id;
>>>>> +	int numa_node_id, last_node;
>>>>>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>>>>>   	uint32_t entries = 0;
>>>>>   #endif
>>>>> @@ -1935,34 +1936,41 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>>>>>   	crat_table->num_domains = 0;
>>>>>   
>>>>>   	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
>>>>> +	last_node = find_last_bit(node_online_map.bits, MAX_NUMNODES);
>>>>>   
>>>>> -	for_each_online_node(numa_node_id) {
>>>>> -		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
>>>>> +	for (numa_node_id = 0; numa_node_id <= last_node; numa_node_id++) {
>>>>> +		if (!node_online(numa_node_id)) {
>>>>> +			crat_table->num_domains++;
>>>>>   			continue;
>>>>> +		}
>>>>>   
>>>>>   		/* Fill in Subtype: Compute Unit */
>>>>> -		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>>>> -			crat_table->num_domains,
>>>>> -			(struct crat_subtype_computeunit *)sub_type_hdr);
>>>>> -		if (ret < 0)
>>>>> -			return ret;
>>>>> -		crat_table->length += sub_type_hdr->length;
>>>>> -		crat_table->total_entries++;
>>>>> +		if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
>>>>> +			ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>>>> +						  crat_table->num_domains,
>>>>> +						  (struct crat_subtype_computeunit *)sub_type_hdr);
>>>>> +			if (ret < 0)
>>>>> +				return ret;
>>>>> +			crat_table->length += sub_type_hdr->length;
>>>>> +			crat_table->total_entries++;
>>>>>   
>>>>> -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>>>> -			sub_type_hdr->length);
>>>>> +			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>>>> +				sub_type_hdr->length);
>>>>> +		}
>>>>>   
>>>>>   		/* Fill in Subtype: Memory */
>>>>> -		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
>>>>> -			crat_table->num_domains,
>>>>> -			(struct crat_subtype_memory *)sub_type_hdr);
>>>>> -		if (ret < 0)
>>>>> -			return ret;
>>>>> -		crat_table->length += sub_type_hdr->length;
>>>>> -		crat_table->total_entries++;
>>>>> +		if (node_state(numa_node_id, N_MEMORY)) {
>>>>> +			ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
>>>>> +							crat_table->num_domains,
>>>>> +							(struct crat_subtype_memory *)sub_type_hdr);
>>>>> +			if (ret < 0)
>>>>> +				return ret;
>>>>> +			crat_table->length += sub_type_hdr->length;
>>>>> +			crat_table->total_entries++;
>>>>>   
>>>>> -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>>>> -			sub_type_hdr->length);
>>>>> +			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>>>> +				sub_type_hdr->length);
>>>>> +		}
>>>>>   
>>>>>   		/* Fill in Subtype: IO Link */
>>>>>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>>>>> @@ -1982,7 +1990,6 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>>>>>   #else
>>>>>   		pr_info("IO link not available for non x86 platforms\n");
>>>>>   #endif
>>>>> -
>>>>>   		crat_table->num_domains++;
>>>>>   	}
>>>>>   
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>>> index b38d12f3da84..d2fbe73e57ef 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>>> @@ -1419,6 +1419,9 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>>>>>   				    struct kfd_iolink_properties, list);
>>>>>   
>>>>>   	for (i = 0; i < num_cpu; i++) {
>>>>> +		if (!node_online(i) || !node_state(i, N_CPU))
>>>>
>>>> The N_CPU part skips indirect links through CPU-less NUMA nodes. Is 
>>>> that correct? For links from the GPU to that memory, I think we 
>>>> need the indirect links so the GPU knows that it can access such 
>>>> memory.
>>>>
>>>> Maybe further down we could enhance the large-bar condition to only 
>>>> create indirect CPU->GPU links if that node actually has a CPU:
>>>>
>>>>                  /* for small Bar or CPU-less NUMA nodes, no CPU --> GPU in-direct links */
>>>>                  if (kfd_dev_is_large_bar(kdev->gpu) && node_state(i, N_CPU)) {
>>>> 			...
>>>
>>>
>>> Hi Felix,
>>>
>>> Thanks a lot for the reply and the suggestion!
>>>
>>> Would the following change address your concern? I've removed the
>>> |N_CPU|check from the loop condition and moved it to the large-BAR
>>> check so that we retain the indirect links for CPU-less NUMA nodes
>>> while avoiding CPU → GPU indirect links for those nodes.
>>
>> Yes, this look good. I have one question inline.
>>
>>
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> index b38d12f3da84..8f908323d74b 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -1419,6 +1419,9 @@ static int 
>>> kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>>>                      struct kfd_iolink_properties, list);
>>>
>>>      for (i = 0; i < num_cpu; i++) {
>>> +        if (!node_online(i))
>>> +            continue;
>>> +
>>>          /* CPU <--> GPU */
>>>          if (gpu_link->node_to == i)
>>>              continue;
>>> @@ -1437,7 +1440,7 @@ static int 
>>> kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>>>          }
>>>
>>>          if (!cpu_link)
>>> -            return -ENOMEM;
>>> +            continue;
>>
>> I think I'm fine with this change. But the fact that you need this 
>> tells me that you have some weird topology where the CPUs (and 
>> CPU-less memory-only) NUMA nodes aren't fully connected. How does 
>> that happen? Does that point at some problem elsewhere?
>>
> Hi Felix,
> Thanks for the feedback!
>
> Actually the main reason for the change was:
>
> In|kfd_create_vcrat_image_cpu()|, CPU-to-CPU IO link
> generation is wrapped in|#if defined(CONFIG_X86_64)|.
> Consequently,|kfd_fill_iolink_info_for_cpu()|is not
> compiled on non-x86 platforms, leaving
> |cpu_dev->io_link_props|empty for all host nodes.
>
>  1. For example, on a multi-node non-x86 system where the
>     GPU is attached to node 2 and CPUs are present on node 0,
>     |cpu_link|will be NULL.
>     Returning|-ENOMEM|in this case causes
>     |kfd_dev_create_p2p_links()|to abort early, potentially
>     preventing subsequent GPU-to-GPU P2P links from being
>     created through|kfd_add_peer_prop()|.
>
> If you are okay with these changes, can I post the
> next version incorporating them?

Yes. Thanks for the clarification. If the lack of CPU-CPU links on 
non-x86 CPUs is a problem, I'd also be open to a fix for that. Up to you.

Thanks,
   Felix


>
> Thanks,
> Dhruv B
>
>
>> Regards,
>>   Felix
>>
>>
>>>
>>>          /* CPU <--> CPU <--> GPU, GPU node*/
>>>          props = kfd_alloc_struct(props);
>>> @@ -1459,8 +1462,8 @@ static int 
>>> kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>>>          if (ret < 0)
>>>              return ret;
>>>
>>> -        /* for small Bar, no CPU --> GPU in-direct links */
>>> -        if (kfd_dev_is_large_bar(kdev->gpu)) {
>>> +        /* for small Bar or CPU-less NUMA nodes, no CPU --> GPU 
>>> in-direct links */
>>> +        if (kfd_dev_is_large_bar(kdev->gpu) && node_state(i, N_CPU)) {
>>>              /* CPU <--> CPU <--> GPU, CPU node*/
>>>              props2 = kfd_alloc_struct(props2);
>>>              if (!props2)
>>> -- 
>>>
>>> Does this approach look good to you?
>>>
>>> Regards,
>>> Dhruv B
>>>
>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>> +			continue;
>>>>> +
>>>>>   		/* CPU <--> GPU */
>>>>>   		if (gpu_link->node_to == i)
>>>>>   			continue;
--------------AmHGHkiAuwN0uUpEDYP2qyiI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-11-04 12:00, Dhruv Bhogaonkar
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:64a82e4a-2855-46f1-8942-3c1b6f8179f3@linux.ibm.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 04/11/26 20:56, Kuehling, Felix
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:04ddca6d-3880-48e0-a64e-a4bbde32e67e@amd.com">
        <!-- BaNnErBlUrFlE-BoDy-start -->
        <!-- Preheader Text : BEGIN -->
        <div style="display:none !important;display:none;visibility:hidden;mso-hide:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;overflow:hidden;">
          On 2026-11-04 08: 41, Dhruv Bhogaonkar wrote: On 03/11/26
          05: 55, Felix Kuehling wrote: On 2026-10-30 04: 33, Dhruv B
          wrote: On systems with discontiguous NUMA node IDs, the GPU
          driver fails to load with the following errors: [ 5. 609767]
          amdgpu</div>
        <!-- Preheader Text : END -->
        <!-- Email Banner : BEGIN -->
        <!-- Email Banner : END -->
        <!-- BaNnErBlUrFlE-BoDy-end -->
        <!-- BaNnErBlUrFlE-HeAdEr-start -->
        <style>@scope {  }</style>
        <!-- BaNnErBlUrFlE-HeAdEr-end -->
        <div class="moz-cite-prefix">On 2026-11-04 08:41, Dhruv
          Bhogaonkar wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com">
          <p><br>
          </p>
          <div class="moz-cite-prefix">On 03/11/26 05:55, Felix Kuehling
            wrote:<br>
          </div>
          <blockquote type="cite" cite="mid:70018014-d952-4155-aa36-cf9b39ba8aea@amd.com">
            <!-- BaNnErBlUrFlE-BoDy-start -->
            <!-- Preheader Text : BEGIN -->
            <div style="display:none !important;display:none;visibility:hidden;mso-hide:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;overflow:hidden;">
              On 2026-10-30 04: 33, Dhruv B wrote: On systems with
              discontiguous NUMA node IDs, the GPU driver fails to load
              with the following errors: [ 5. 609767] amdgpu
              0038: 12: 00. 0: Error parsing VCRAT [ 5. 609781] kfd kfd:
              Error adding device to topology</div>
            <!-- Preheader Text : END -->
            <!-- Email Banner : BEGIN -->
            <!-- Email Banner : END -->
            <!-- BaNnErBlUrFlE-BoDy-end -->
            <!-- BaNnErBlUrFlE-HeAdEr-start -->
            <style>@scope {  }</style>
            <!-- BaNnErBlUrFlE-HeAdEr-end -->
            <div class="moz-cite-prefix">On 2026-10-30 04:33, Dhruv B
              wrote:<br>
            </div>
            <blockquote type="cite" cite="mid:20261030083304.9767-3-dhruv.b@linux.ibm.com">
              <pre wrap="" class="moz-quote-pre">On systems with discontiguous NUMA node IDs, the GPU driver fails to
load with the following errors:

[    5.609767] amdgpu 0038:12:00.0: Error parsing VCRAT
[    5.609781] kfd kfd: Error adding device to topology
[    5.609848] kfd kfd: Error initializing KFD node

In the current KFD code, proximity domains are created contiguously
when generating the VCRAT. With discontiguous NUMA node IDs, this
creates a mismatch between the proximity domain ID and the NUMA node ID.
For example, if NUMA nodes 0, 2 and 3 are online, the current code
assigns proximity domains 0, 1 and 2 to these nodes respectively,
instead of domains 0, 2 and 3.

The KFD topology uses the NUMA node and proximity domain information to
create topology devices representing the CPU and memory resources
associated with each NUMA node. This topology is exposed to userspace
through sysfs, where the NUMA node and proximity domain information are
used to identify the topology devices. The mismatch between the NUMA
node ID and proximity domain therefore results in an inconsistent KFD
topology and causes topology parsing to fail.

Make the proximity domain ID correspond directly to the NUMA node ID by
iterating through the complete NUMA node ID range up to the last online
node. Account for every node ID when assigning proximity domains, while
skipping resource entry creation for offline nodes. This preserves the
NUMA-node-to-proximity-domain mapping and allows the KFD topology and
its sysfs representation to correctly reflect discontiguous NUMA
topologies.

A NUMA node may also be CPU-less, memory-less, or both. Only create a
Compute Unit CRAT entry if the node has CPUs, and only create a Memory
CRAT entry if the node has memory.

Additionally, update kfd_parse_subtype_mem() to use simd_count instead
of cpu_cores_count to distinguish host nodes from GPU nodes. This ensures
that memory on CPU-less host NUMA nodes is correctly classified as
system memory (HSA_MEM_HEAP_TYPE_SYSTEM) rather than private GPU
framebuffer memory.

The placeholder domains created for offline node IDs have no IO links,
so skip offline and CPU-less nodes when building the indirect GPU to CPU
links.

Co-developed-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com" moz-do-not-send="true">&lt;donettom@linux.ibm.com&gt;</a>
Signed-off-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com" moz-do-not-send="true">&lt;donettom@linux.ibm.com&gt;</a>
Signed-off-by: Dhruv B <a class="moz-txt-link-rfc2396E" href="mailto:dhruv.b@linux.ibm.com" moz-do-not-send="true">&lt;dhruv.b@linux.ibm.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 59 +++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 ++
 2 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 99b0c7f825fe..bebbc6715b2f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1103,8 +1103,10 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
 			mem-&gt;proximity_domain);
 	list_for_each_entry(dev, device_list, list) {
 		if (mem-&gt;proximity_domain == dev-&gt;proximity_domain) {
-			/* We're on GPU node */
-			if (dev-&gt;node_props.cpu_cores_count == 0) {
+			if (dev-&gt;node_props.simd_count == 0) {
+				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
+			} else {
+				/* We're on GPU node */
 				/* APU */
 				if (mem-&gt;visibility_type == 0)
 					heap_type =
@@ -1112,8 +1114,7 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
 				/* dGPU */
 				else
 					heap_type = mem-&gt;visibility_type;
-			} else
-				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
+			}
 
 			if (mem-&gt;flags &amp; CRAT_MEM_FLAGS_HOT_PLUGGABLE)
 				flags |= HSA_MEM_FLAGS_HOT_PLUGGABLE;
@@ -1899,7 +1900,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	acpi_status status;
 	struct crat_subtype_generic *sub_type_hdr;
 	int avail_size = *size;
-	int numa_node_id;
+	int numa_node_id, last_node;
 #if defined(CONFIG_X86_64) &amp;&amp; !defined(CONFIG_UML)
 	uint32_t entries = 0;
 #endif
@@ -1935,34 +1936,41 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	crat_table-&gt;num_domains = 0;
 
 	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
+	last_node = find_last_bit(node_online_map.bits, MAX_NUMNODES);
 
-	for_each_online_node(numa_node_id) {
-		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
+	for (numa_node_id = 0; numa_node_id &lt;= last_node; numa_node_id++) {
+		if (!node_online(numa_node_id)) {
+			crat_table-&gt;num_domains++;
 			continue;
+		}
 
 		/* Fill in Subtype: Compute Unit */
-		ret = kfd_fill_cu_for_cpu(numa_node_id, &amp;avail_size,
-			crat_table-&gt;num_domains,
-			(struct crat_subtype_computeunit *)sub_type_hdr);
-		if (ret &lt; 0)
-			return ret;
-		crat_table-&gt;length += sub_type_hdr-&gt;length;
-		crat_table-&gt;total_entries++;
+		if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
+			ret = kfd_fill_cu_for_cpu(numa_node_id, &amp;avail_size,
+						  crat_table-&gt;num_domains,
+						  (struct crat_subtype_computeunit *)sub_type_hdr);
+			if (ret &lt; 0)
+				return ret;
+			crat_table-&gt;length += sub_type_hdr-&gt;length;
+			crat_table-&gt;total_entries++;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr-&gt;length);
+			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+				sub_type_hdr-&gt;length);
+		}
 
 		/* Fill in Subtype: Memory */
-		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &amp;avail_size,
-			crat_table-&gt;num_domains,
-			(struct crat_subtype_memory *)sub_type_hdr);
-		if (ret &lt; 0)
-			return ret;
-		crat_table-&gt;length += sub_type_hdr-&gt;length;
-		crat_table-&gt;total_entries++;
+		if (node_state(numa_node_id, N_MEMORY)) {
+			ret = kfd_fill_mem_info_for_cpu(numa_node_id, &amp;avail_size,
+							crat_table-&gt;num_domains,
+							(struct crat_subtype_memory *)sub_type_hdr);
+			if (ret &lt; 0)
+				return ret;
+			crat_table-&gt;length += sub_type_hdr-&gt;length;
+			crat_table-&gt;total_entries++;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr-&gt;length);
+			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+				sub_type_hdr-&gt;length);
+		}
 
 		/* Fill in Subtype: IO Link */
 #if defined(CONFIG_X86_64) &amp;&amp; !defined(CONFIG_UML)
@@ -1982,7 +1990,6 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 #else
 		pr_info(&quot;IO link not available for non x86 platforms\n&quot;);
 #endif
-
 		crat_table-&gt;num_domains++;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index b38d12f3da84..d2fbe73e57ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1419,6 +1419,9 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 				    struct kfd_iolink_properties, list);
 
 	for (i = 0; i &lt; num_cpu; i++) {
+		if (!node_online(i) || !node_state(i, N_CPU))</pre>
            </blockquote>
            <p>The N_CPU part skips indirect links through CPU-less NUMA
              nodes. Is that correct? For links from the GPU to that
              memory, I think we need the indirect links so the GPU
              knows that it can access such memory.</p>
            <p>Maybe further down we could enhance the large-bar
              condition to only create indirect CPU-&gt;GPU links if
              that node actually has a CPU:</p>
            <pre>                /* for small Bar or CPU-less NUMA nodes, no CPU --&gt; GPU in-direct links */
                if (kfd_dev_is_large_bar(kdev-&gt;gpu) &amp;&amp; node_state(i, N_CPU)) {
			...</pre>
          </blockquote>
          <p><br>
          </p>
          <font face="monospace"><span>Hi Felix,<br>
            </span><br>
            <span>Thanks a lot for the reply and the suggestion!<br>
            </span><br>
            <span>Would the following change address your concern? I've
              removed the</span><br>
            <code dir="ltr"><span>N_CPU</span></code><span><span class="Apple-converted-space">&nbsp;</span>check from the
              loop condition and moved it to the large-BAR</span><span><br>
              check so that we retain the indirect links for CPU-less
              NUMA nodes</span><br>
            <span>while avoiding CPU → GPU indirect links for those
              nodes.<br>
            </span></font></blockquote>
        <p>Yes, this look good. I have one question inline.</p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com"><font face="monospace"><br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
            index b38d12f3da84..8f908323d74b 100644<br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
            @@ -1419,6 +1419,9 @@ static int
            kfd_create_indirect_link_prop(struct kfd_topology_device
            *kdev, int g<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct kfd_iolink_properties, list);<br>
            &nbsp;<br>
            &nbsp; &nbsp; &nbsp;for (i = 0; i &lt; num_cpu; i++) {<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; if (!node_online(i))<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
            +<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* CPU &lt;--&gt; GPU */<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (gpu_link-&gt;node_to == i)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;continue;<br>
            @@ -1437,7 +1440,7 @@ static int
            kfd_create_indirect_link_prop(struct kfd_topology_device
            *kdev, int g<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
            &nbsp;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!cpu_link)<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENOMEM;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
          </font></blockquote>
        <p>I think I'm fine with this change. But the fact that you need
          this tells me that you have some weird topology where the CPUs
          (and CPU-less memory-only) NUMA nodes aren't fully connected.
          How does that happen? Does that point at some problem
          elsewhere?</p>
      </blockquote>
      <font face="monospace"><span>Hi Felix,</span><br>
        <span>Thanks for the feedback!<br>
          <br>
          Actually the main reason for the change was:<br>
          <br>
          In<span class="Apple-converted-space">&nbsp;</span></span><code dir="ltr"><span>kfd_create_vcrat_image_cpu()</span></code><span>,
          CPU-to-CPU IO link</span><br>
        <span>generation is wrapped in<span class="Apple-converted-space">&nbsp;</span></span><code dir="ltr"><span>#if
            defined(CONFIG_X86_64)</span></code><span>.</span><br>
        <span>Consequently,<span class="Apple-converted-space">&nbsp;</span></span><code dir="ltr"><span>kfd_fill_iolink_info_for_cpu()</span></code><span><span class="Apple-converted-space">&nbsp;</span>is not</span><br>
        <span>compiled on non-x86 platforms, leaving</span><br>
        <code dir="ltr"><span>cpu_dev-&gt;io_link_props</span></code><span><span class="Apple-converted-space">&nbsp;</span>empty for all host
          nodes.</span></font>
      <ol data-spread="false" start="1" style="caret-color: rgb(255, 255, 255); color: rgb(255, 255, 255); font-size: medium; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
        <li><font face="monospace"><span>For example, on a multi-node
              non-x86 system where the</span><br>
            <span>GPU is attached to node 2 and CPUs are present on node
              0,</span><br>
            <code dir="ltr"><span>cpu_link</span></code><span><span class="Apple-converted-space">&nbsp;</span>will be NULL.</span><br>
            <span>Returning<span class="Apple-converted-space">&nbsp;</span></span><code dir="ltr"><span>-ENOMEM</span></code><span><span class="Apple-converted-space">&nbsp;</span>in this case
              causes</span><br>
            <code dir="ltr"><span>kfd_dev_create_p2p_links()</span></code><span><span class="Apple-converted-space">&nbsp;</span>to abort early,
              potentially</span><br>
            <span>preventing subsequent GPU-to-GPU P2P links from being</span><br>
            <span>created through<span class="Apple-converted-space">&nbsp;</span></span><code dir="ltr"><span>kfd_add_peer_prop()</span></code><span>.</span></font></li>
      </ol>
      <font face="monospace"><span>If you are okay with these changes,
          can I post the</span><br>
        <span>next version incorporating them?<br>
        </span></font></blockquote>
    <p>Yes. Thanks for the clarification. If the lack of CPU-CPU links
      on non-x86 CPUs is a problem, I'd also be open to a fix for that.
      Up to you.</p>
    <p>Thanks,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:64a82e4a-2855-46f1-8942-3c1b6f8179f3@linux.ibm.com"><font face="monospace"><br>
        <span>Thanks,</span><br>
        <span>Dhruv B</span></font>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:04ddca6d-3880-48e0-a64e-a4bbde32e67e@amd.com">
        <p>Regards,<br>
          &nbsp; Felix</p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com"><font face="monospace">&nbsp;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* CPU &lt;--&gt; CPU &lt;--&gt; GPU, GPU node*/<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;props = kfd_alloc_struct(props);<br>
            @@ -1459,8 +1462,8 @@ static int
            kfd_create_indirect_link_prop(struct kfd_topology_device
            *kdev, int g<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ret &lt; 0)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
            &nbsp;<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; /* for small Bar, no CPU --&gt; GPU in-direct links
            */<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; if (kfd_dev_is_large_bar(kdev-&gt;gpu)) {<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; /* for small Bar or CPU-less NUMA nodes, no CPU
            --&gt; GPU in-direct links */<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; if (kfd_dev_is_large_bar(kdev-&gt;gpu) &amp;&amp;
            node_state(i, N_CPU)) {<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* CPU &lt;--&gt; CPU &lt;--&gt; GPU, CPU
            node*/<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;props2 = kfd_alloc_struct(props2);<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!props2)<br>
            --&nbsp;<br>
            <br>
            <span>Does this approach look good to you?<br>
            </span><br>
            <span>Regards,</span><br>
            <span>Dhruv B</span></font>
          <p><br>
          </p>
          <blockquote type="cite" cite="mid:70018014-d952-4155-aa36-cf9b39ba8aea@amd.com">
            <p>Regards,<br>
              &nbsp; Felix</p>
            <p><br>
            </p>
            <blockquote type="cite" cite="mid:20261030083304.9767-3-dhruv.b@linux.ibm.com">
              <pre wrap="" class="moz-quote-pre">+			continue;
+
 		/* CPU &lt;--&gt; GPU */
 		if (gpu_link-&gt;node_to == i)
 			continue;
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------AmHGHkiAuwN0uUpEDYP2qyiI--
