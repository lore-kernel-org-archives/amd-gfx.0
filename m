Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC9606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MmTtQwd/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE5210E823;
	Thu, 29 Oct 2026 19:03:19 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D9210E823
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 19:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htQg5sxfevIkiVz6purOp1xl2als+IOOWRc7iXbAIiRPzpKsZ6DU2qQBs3UAvubT+5/5oigxaf56WcHtrZhB+QSa8MmlOnaxBcrFRJ7WUYF8QXkKyKfkYNLC7UAXBG9fu231fgtYqV/VmZrLn/TorHK4+WFCMR4rN5BHYVNGUVFtWS3pfkWyASegqOOwRvuqrl473ATCz7P6+Jnh7Q4pTb/RFYig6Uctr2S0bKdP9YI1fQllC7RUpycCQioKF2IM252XJF9OBYF+CswgFMt3pwF98KXsjLT2LrHzD8SixUkxkUexdH8DgKlJnlfNJCPEp/nULd2ZVJxhX6G2o5elpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bZm46B2UkpXT0CeylqtaCJ3EMoRetyTYRY/UkmH17M=;
 b=KdSOYff3dWQ97ZRW8XNnHp9qLlAJLZTVo/8NDYR6E5N9dj+yGHRXm9hhhFzFARYPTkbIaXbjt09pnE0iUeKNuo7g5jK/JNLMuzJ01lJSrlYx+4xkI0QvzUq9I+n25GwMAajntZJCqSIgh/cH+Besrodm5Zro1TtvNU5vDrUl8rI5J99axfBcExLn5/d6k6BXPfluoaAoKZfJ2GHVav70dtClOKZ6AyRiNCp9fDSBPIVuwS6eHXqoZZy2aWtcOlfc3Qm6McMGG7e3baS5fsqtXUfp+phoCglCsFHag1kscDQJqq5nJ+VnRWPoi18O2qnBJ6wT2UllhFkdw1tNc2iJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bZm46B2UkpXT0CeylqtaCJ3EMoRetyTYRY/UkmH17M=;
 b=MmTtQwd/C4DZwYza5p2G63ZLfZgUocOBtgTtfCbC9JSnPivTL6WMrH30GdwxbW75+QhUCfwuAVV1xvk4yqWDSAVNryJx2l1/+y/d/Xw74Fu0fNEVzsU8ow+YTFtxw7aNf6TgfrEyC8KiGBf3FFsQwfftiwdCzAvXS2pjsct401g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH8PR12MB7229.namprd12.prod.outlook.com
 (2603:10b6:510:227::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 19:03:02 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 19:03:02 +0000
Message-ID: <1dbbed96-d49b-4123-9828-06c1042dd0ad@amd.com>
Date: Thu, 29 Oct 2026 15:03:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/amdgpu: UALink add debugfs selftest
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org, Mukul.Joshi@amd.com
References: <20261023203447.2075707-1-Philip.Yang@amd.com>
 <abbf170b-628b-455f-94b1-91e3ce540863@amd.com>
 <e0535f78-43ca-4d44-a93b-405de825ba65@amd.com>
 <7a63c005-8d95-497e-bf4f-00a80688e732@amd.com>
 <ef6f1630-7af1-4366-a18b-f8cebf742378@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <ef6f1630-7af1-4366-a18b-f8cebf742378@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::33) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: c46b6df3-6f4d-44da-6b11-08df35ef417e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|5023799004|4143699003|11063799006|56012099006|261009223027099003|261026135527099003|261026121527099003|261026130827099003|261026140227099003|261022075727099003|261028144727099003|10067099003|261022115727099003|261021130227099003|261021135927099003|261022113327099003|261021121427099003|261021123027099003|261022105027099003|261021133027099003|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: xiB5qg30CEBKFKyu61975aCiwqOOkG06IwnxE8N9bQfcQuxhQYWlV+sxNWwfYPzb89FZMFpmf57VVYmnFfOKUX6QAoCY6ZjLQlZz+HVFyPIkrHaGMrwjeaQIHBciffYqzv8bwbhHVQo9yPfVWH6x5M+Hg+uQyNrpypm7m1GsJ7HxiG9/QAWjelcc+y3qE+Yadgdr9GU9LmHEXVEotmVQ/MlMp68aA2QQWUbnu94W2jw95u4ol2Sop2BfBKja6mgO/sCzBnmK+EIwKbxZM6nc9iR9Hs1OmHd/bOPSlMWySpXJ+W8y0x6Z9fcDLEoqBHrSQB0t68TeD+FTi39B9QQ8CQ0zhJrfZRXd5y927Z9cHfLgjbK4sqP14mt+7S7iPV5Si9LN6VheRqcZ8K2Qwb4TiSwLNrXDAE5AiBO87LWC+zpVzbbwGRfnIwmM+oblXvYZsyPBKr8tCQmyNKSiN8WuKaSCtf7q/A89lgdSWvnvgZC7MI0FV0tSn+x9L13qrd4c1y5gH2CmyYxA9NDK0iYsh3koBx+6ig7v2+D4m125hI3L/Gch8fM8M1gB+q6ZQS57EOjJVCylR/I/MJhC2GXMowHEfXuZvvfzACrZldhrMryLSZQZnX1yJXuGP1p9PS6a/swGnygp+wGa6Kiy+PMtYWzzc5+svm3NA1YZTefuk5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(5023799004)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026135527099003)(261026121527099003)(261026130827099003)(261026140227099003)(261022075727099003)(261028144727099003)(10067099003)(261022115727099003)(261021130227099003)(261021135927099003)(261022113327099003)(261021121427099003)(261021123027099003)(261022105027099003)(261021133027099003)(18002099003)(22082099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHlEdU5iNnc4T3VUbGVZT2drYSs1KzhrdmlCeXloSnhhektTSk9xVFNrVjRq?=
 =?utf-8?B?QXorNEc2ZmdBVWR5cHFyb0N5Z0NCbG9QQmNTVHVibTNCUURUZmZTTUxMYVE4?=
 =?utf-8?B?Q2xzT3l3NlcycjQ1R2doZURwaWdsSFA0bzlVVk0xMEdvcGVwelRtTEp0WUZs?=
 =?utf-8?B?WFF4NWpZN08vdkJoVTVKeXFKekVRWWFDUUE2Z3B5bTNoWVJoY0FiTkJLUGQx?=
 =?utf-8?B?TzlWaDljaVY1eDdjRjN6WTRmWklVYTk1blJNWG5OS2o4SVBjbjIvR1lxM3hM?=
 =?utf-8?B?NlNpSEd0YW5aZURaTzVTWEZBdCt3anhWWHdiT0JXUVl5ME5LbTFUZ0JFUVlQ?=
 =?utf-8?B?OEdZY00vaVJPODFzR2R0bGw1bGFlZkFSVy8vQlROWG9scmZxQ1R3L1hST1Q0?=
 =?utf-8?B?UTlWaEpMVWpJRGtPZjdwdFF2ck9LVGkyM0lPamorajhyQ3BkUnVWa01KT3dL?=
 =?utf-8?B?SlprSGs0ekdJUlNSbkxRM3lMaTBUN2ZGZ1N0d1BvVWkvQU8wSGpTN0tXZkpI?=
 =?utf-8?B?aHlIenpzekVHWTVjVW56YkRhM1MvT0NrdnRINGhLMzVDYmRSeXp1bnRlQWtr?=
 =?utf-8?B?SnlLQ1VUZE0vQXc1QVhDelg4amFqdmdhSW40dkxnWDZzV2crZEIxazFqWUNF?=
 =?utf-8?B?eDduVjRBRkRmWk9CL2FEMEkyMUh0cnUwS282c3M4Vm1NcDZYaHRCU3VNTXQy?=
 =?utf-8?B?VVNZUXdFNy9nYXdtTzV1bTJoekpwTWhIQ05LQTM2Wi9HdnkwbG5RbVRkRDdP?=
 =?utf-8?B?aHgrTTN2WnBEV2EzaEZwMk9tT3Z3L2R0UzJzcWdxRGVPTm9rRDlEMG9NSnZV?=
 =?utf-8?B?cHJ4ajdvTjdzZm94eFZQUFJuelpLUFpLNHdCcDdxY2p0cHljQS8ya0RlcWRR?=
 =?utf-8?B?MWJSVGRJQ0s3UmU3aXZuMTRKbkF4a2lpYmIxSi96TWUvWTNIbWthcWhsUHpB?=
 =?utf-8?B?eGIxZmtUZFV5eVZKOGVZV0NwQzFqYytRb0NyaXRqVmgwanVVUEpiQ0Nkc0JX?=
 =?utf-8?B?U0JKa1g2dW5nSUNuUkU4Ris3OTZQamY3aERDSjdha1E5NU1jYzh4TXRFVHlt?=
 =?utf-8?B?dkdRZy9MRjlSUm9SeHdGcVpyNnEyMGRJSVluVU16MW8vcldOMVBWZjNiRjg0?=
 =?utf-8?B?UHFFOXFIL2RlUmRCemZ4a3ROTEVkV2s0U3FJRXZGNmxwUjN0UFNGZk5DeWRI?=
 =?utf-8?B?OWUxcVRPdGx1SERmNGdSV2hucjg2QVlmODd6ZHpEa0YwZlBGNkMveW5NcTN2?=
 =?utf-8?B?eHZnbkxMbjBnL1RySytndjNKUFRaUzVtVnIzcko2dVdMQm9uUmhMSitRTC82?=
 =?utf-8?B?bE1vaGRjdkxoM2xuNktSZldGUlVwdDFwTlNoQU5oZm9UbituY1RNT1A2Y1I0?=
 =?utf-8?B?M1MzZ3hUdDBMc0lHbTR5dDRXUlhEOWJBM2JrZjNIRU1DZUFSNTRyYkV2NWZL?=
 =?utf-8?B?a045eHV6QkUvSmFrT1ZKU0dNK053OXdLbDRRRzFtSzc4ZGVEWTlibTlnOXV1?=
 =?utf-8?B?UmNPQjNBRWtvZWMwelM4NnE3L1hkT0xqOG9xUnVBb0FsSHpFRGhNZEQ5U0FL?=
 =?utf-8?B?eWVvQXB4Z2p6YVhKeW9pYUt5SmcxQWlIcU5TOTBBQjZlQWhFM1JYM0FrN1pz?=
 =?utf-8?B?ZzJCWFVWVHJUanpCSlZRS1RnUGRFd1BuWXAwRmkvZnNLY2k4bm05U0tWSHBX?=
 =?utf-8?B?RmtyZzkzRml3RUd5cENiNnF6T0ZCU29xM0JkcUFjNG9GRXRrTDVpSW1pd0gw?=
 =?utf-8?B?ZTI5ckMzYkx6SGlpcGJjOGpIQlNFbXdWZWVheGVvakM3MTJncitYL1Izekdo?=
 =?utf-8?B?ekdiajRiRWZ0d28vOTBKN2ptQUtiNzJ5eW95Z1JNWUI4RFVMWElXK3c3VXlj?=
 =?utf-8?B?SU81OTVKWEtmdGtlbkV6S1UvQmIzRStYeDJjbmZPZEMyVnFRR2gvaUZGNFk0?=
 =?utf-8?B?WitkRWhGY0pPSTRheVhTZjJqenNvbmx0SkVESU1sdW1vY0Z3Sm1sYUlicVpi?=
 =?utf-8?B?TXBLYU5MODBMNnBVWktGS085QU5idVNseERHUUl0QnNTTFFORUM4YlBqbmlr?=
 =?utf-8?B?N1RBbVM0R09CU3FGdDZwTmhHekNmOWFOSmhidkZ1ZUR3aTZTc3RFTVFiaUNJ?=
 =?utf-8?B?NDZ2S2hxU3NiQWZwUjJNQmE1ZlF5Y0psMmJ6VDMwOE5ZSUhtLzlFRG5NTU5u?=
 =?utf-8?B?ZkpFejZLM0pvNVl4VVZ6QnQxQmx3c1RtM2xUTDFyczNKUi9saVFqanJETWUw?=
 =?utf-8?B?WDYyTW1vbjJ1MTA1dmdrV0NEVmJBL0hBbWF4R3JZWXFYVmhacWErOUZXTHZx?=
 =?utf-8?B?SzNNMTJXNjVxdCtWSlBRUmNEZlBPZHd4Zy9xKyt6VWM2M2QxeVBSdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46b6df3-6f4d-44da-6b11-08df35ef417e
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:03:02.3763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHduPrNhYbRjxbGFviWjWDm10simCp6pPx0xPpzz76R4HK8nUVMGlZe7gkZTv9mHBza/vvPcFC6JIFEYkpVe1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29 11:15, Philip Yang wrote:
>
>
> On 2026-10-28 17:36, Kuehling, Felix wrote:
>>
>> On 2026-10-28 15:36, Philip Yang wrote:
>>>
>>>
>>> On 2026-10-28 14:24, Kuehling, Felix wrote:
>>>> On 2026-10-23 16:34, Philip Yang wrote:
>>>>> Driver-side selftests for UALink bring-up: exercise the nHT firmware,
>>>>> remote interrupts, remote TLB shootdown and remote VRAM access 
>>>>> without
>>>>> any userspace application.
>>>>>
>>>>> Add debugfs directory "amdgpu_ualink_test" to trigger UALink 
>>>>> selftests
>>>>> with these read/write entries:
>>>>>
>>>>>    command          write the test name to run it, read to list the
>>>>>                     valid test names
>>>>>    remote_accel_id  accel_id of the remote GPU used by the tests
>>>>>    test_size        test buffer size in bytes, from 4 to 4096
>>>>>    local_test_data  the local ring buffer the remote GPU accesses
>>>>>    remote_sdma      the remote GPU ring buffer, using sdma
>>>>>    remote_lsdma     the remote GPU ring buffer, using lsdma
>>>>>
>>>>> The data entries take and return binary data, a write shorter than
>>>>> test_size is repeated to fill it, so formatting is left to userspace
>>>>> tools like printf, xxd, od and cmp.
>>>>>
>>>>> Add helper functions: ualink_test_local_data() and
>>>>> ualink_test_remote_rw() for local and remote ring buffer R/W,
>>>>> ualink_test_remote_shootdown() for TLB shootdown,
>>>>> ualink_test_send_hello() for handshake,
>>>>> ualink_test_update_interrupt_wb() and
>>>>> ualink_test_update_shootdown_wb() to read writeback results.
>>>>>
>>>>> v6: ring buffer wptr for itself is used for wptr, don't init to 
>>>>> 0xdeadbeef
>>>>
>>>> I don't see this change. What exactly did you change? I only see 
>>>> the removal of deadbeef init. I don't see any change regarding 
>>>> which ring buffer is used to stage the data for remote read/write.
>>> The remote ring buffer was initialised to 0xdeadbeef for the 
>>> selftest. In address-aliasing mode the wptr for every remote uses 
>>> that same ring buffer page for itself accel_id, so the remote wptr 
>>> resync read back 0xdeadbeef and synced the wptr to that value, which 
>>> left the remote firmware in a bad state. I have removed the ring 
>>> buffer initialisation. ualink_test_resync_peer() also change to only 
>>> resync wptr for the first command or if peer rebooted.
>>
>> OK. I was asking for an additional change in v5 that I thought you 
>> were addressing here, but didn't.
>>
>> The remote write first writes data to local memory before copying it 
>> to remote. E.g. remote write from A to B overwrites local memory in 
>> A. A remote write from B to A writes the same memory in A. Now a 
>> tester reading local_test_data from debugfs doesn't know whether that 
>> was written by the remote GPU or by a previous local read/write to 
>> remote_sdma or remote_lsdma.
>>
>> Therefore, I would like to keep those separate. A write from A to B 
>> should not overwrite the same memory on A as a write from B to A. 
>> Similar for remote reads. A remote read by A from B should not 
>> overwrite the same memory on A that is also accessed remotely by B.
>>
>> I proposed using a different offset for the staging memory in 
>> ualink_test_remote_rw. Instead of using remote_accel_id in offset = 
>> ualink_test_local_rb_offset(remote_accel_id), use the GPU's own 
>> accelerator ID.
> That won't work, unfortunately. The local accelerator's own slot in 
> the ring buffer is where the remotes write their wptr — so every 
> remote's wptr for this GPU lands in slot(local_accel_id). Using it for 
> staging would corrupt the wptr resync and we'd read back garbage. This 
> is the same aliasing that caused the 0xdeadbeef problem we just fixed.
>
> On the ambiguity itself — you're right that A can't distinguish its 
> own staging data from what B wrote. But the verification in these 
> tests is always done on the opposite side, so it doesn't affect the 
> intended flows:
>
> A writes to B over lsdma, then B reads local_test_data to verify. A's 
> own local_test_data happens to hold the same bytes, but nothing checks 
> it there.
> B writes to its local_test_data, then A reads it back over lsdma and 
> verifies.
> A writes to B and reads back from B, verifying the round trip.
> So the data is always checked where it is unambiguous. I'll document 
> this in the commit message so the intent is clear.
>
> If you'd still prefer them physically separated, the clean way is to 
> alloc sdma job with extra IB buffer, happy to do it  if you think it's 
> worth the extra allocation.

Yeah, I think it's worth it to minimize unexpected side effects and 
confusion.

Thanks,
   Felix


>
> Regards,
> Philip
>>
>> Does that make sense?
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Philip
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>> v5: Replace the four remote access commands with local_test_data,
>>>>>      remote_sdma and remote_lsdma entries, to get the test data 
>>>>> without
>>>>>      looking at debug logs or using xxd with physical addresses 
>>>>> (Felix).
>>>>>      Dump and accept binary data, no parser in the driver (Felix).
>>>>>      Stage the DMA in the local ring buffer instead of the IB, 
>>>>> which is
>>>>>      freed before the data is read back.
>>>>> v4: Use a single "command" entry taking the test name, instead of one
>>>>>      entry per test (Felix).
>>>>>      Resync the remote wptr before sending a command, the peer may 
>>>>> have
>>>>>      rebooted.
>>>>> v3: Replace the single entry taking a test number with a debugfs
>>>>>      directory and a named entry per command.
>>>>>      Take peer->lock to update the writeback address and 
>>>>> selftest_mutex
>>>>>      to read the test parameters.
>>>>> v2: Fix typos and issues from copilot code review.
>>>>>
>>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 346 
>>>>> ++++++++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 +++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 219 ++++++++++++-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  24 +-
>>>>>   5 files changed, 628 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> index 3dc95d9accf2..2d786639d081 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> @@ -2133,9 +2133,336 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, 
>>>>> NULL,
>>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>   +enum amdgpu_ualink_test_cmd {
>>>>> +    UALINK_TEST_SW_INIT,
>>>>> +    UALINK_TEST_SEND_HELLO,
>>>>> +    UALINK_TEST_REMOTE_SHOOTDOWN,
>>>>> +    UALINK_TEST_FLUSH_TLB,
>>>>> +    UALINK_TEST_UPDATE_INTERRUPT_WB,
>>>>> +    UALINK_TEST_UPDATE_SHOOTDOWN_WB,
>>>>> +    UALINK_TEST_LSDMA_SELFTEST,
>>>>> +};
>>>>> +
>>>>> +/* commands talking to a remote accelerator, remote_accel_id must 
>>>>> be set */
>>>>> +#define UALINK_TEST_NEEDS_ACCEL_ID                    \
>>>>> +    (BIT(UALINK_TEST_SEND_HELLO) | 
>>>>> BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
>>>>> +     BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |                \
>>>>> +     BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
>>>>> +
>>>>> +static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device 
>>>>> *adev,
>>>>> +                      enum amdgpu_ualink_test_cmd cmd)
>>>>> +{
>>>>> +    u32 remote_accel_id = adev->ualink.test_remote_accel_id;
>>>>> +    int r = 0;
>>>>> +
>>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>>> +
>>>>> +    if ((BIT(cmd) & UALINK_TEST_NEEDS_ACCEL_ID) &&
>>>>> +        remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
>>>>> +        dev_err(adev->dev, "set remote_accel_id first\n");
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    adev->ualink.selftesting = true;
>>>>> +
>>>>> +    switch (cmd) {
>>>>> +    case UALINK_TEST_SW_INIT:
>>>>> +        if (adev->ualink.remote)
>>>>> +            amdgpu_ualink_sw_fini(adev);
>>>>> +
>>>>> +        dev_dbg(adev->dev, "load metadata init MPNHT firmware\n");
>>>>> +        r = amdgpu_ualink_sw_init(adev);
>>>>> +        break;
>>>>> +    case UALINK_TEST_SEND_HELLO:
>>>>> +        r = ualink_test_send_hello(adev, remote_accel_id);
>>>>> +        break;
>>>>> +    case UALINK_TEST_REMOTE_SHOOTDOWN:
>>>>> +        r = ualink_test_remote_shootdown(adev, remote_accel_id, 
>>>>> 1UL << 30,
>>>>> +                         1, TLB_FLUSH_HEAVYWEIGHT);
>>>>> +        break;
>>>>> +    case UALINK_TEST_FLUSH_TLB:
>>>>> +        amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
>>>>> +        break;
>>>>> +    case UALINK_TEST_UPDATE_INTERRUPT_WB:
>>>>> +        r = ualink_test_update_interrupt_wb(adev, remote_accel_id);
>>>>> +        break;
>>>>> +    case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
>>>>> +        r = ualink_test_update_shootdown_wb(adev, remote_accel_id);
>>>>> +        break;
>>>>> +    case UALINK_TEST_LSDMA_SELFTEST:
>>>>> +        r = adev->lsdma.funcs ? amdgpu_lsdma_selftest(adev) : 
>>>>> -EOPNOTSUPP;
>>>>> +        break;
>>>>> +    }
>>>>> +
>>>>> +    adev->ualink.selftesting = false;
>>>>> +
>>>>> +    dev_dbg(adev->dev, "ualink test cmd %d remote_accel_id %u ret 
>>>>> %d\n",
>>>>> +        cmd, remote_accel_id, r);
>>>>> +
>>>>> +    return r;
>>>>> +}
>>>>> +
>>>>> +#define UALINK_TEST_CMD_NAME_MAX    32
>>>>> +
>>>>> +static const char * const amdgpu_ualink_test_cmd_name[] = {
>>>>> +    [UALINK_TEST_SW_INIT]            = "sw_init",
>>>>> +    [UALINK_TEST_SEND_HELLO]        = "send_hello",
>>>>> +    [UALINK_TEST_REMOTE_SHOOTDOWN]        = "remote_shootdown",
>>>>> +    [UALINK_TEST_FLUSH_TLB]            = "flush_tlb",
>>>>> +    [UALINK_TEST_UPDATE_INTERRUPT_WB]    = "update_interrupt_wb",
>>>>> +    [UALINK_TEST_UPDATE_SHOOTDOWN_WB]    = "update_shootdown_wb",
>>>>> +    [UALINK_TEST_LSDMA_SELFTEST]        = "lsdma_selftest",
>>>>> +};
>>>>> +
>>>>> +static ssize_t amdgpu_debugfs_ualink_command_read(struct file *file,
>>>>> +                          char __user *ubuf,
>>>>> +                          size_t len, loff_t *offp)
>>>>> +{
>>>>> +    char buf[UALINK_TEST_CMD_NAME_MAX * 
>>>>> ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
>>>>> +    unsigned int i;
>>>>> +    int n = 0;
>>>>> +
>>>>> +    for (i = 0; i < ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
>>>>> +        n += scnprintf(buf + n, sizeof(buf) - n, "%s\n",
>>>>> +                   amdgpu_ualink_test_cmd_name[i]);
>>>>> +
>>>>> +    return simple_read_from_buffer(ubuf, len, offp, buf, n);
>>>>> +}
>>>>> +
>>>>> +static ssize_t amdgpu_debugfs_ualink_command_write(struct file 
>>>>> *file,
>>>>> +                           const char __user *ubuf,
>>>>> +                           size_t len, loff_t *offp)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = file->private_data;
>>>>> +    char buf[UALINK_TEST_CMD_NAME_MAX];
>>>>> +    int cmd, r;
>>>>> +
>>>>> +    if (len >= sizeof(buf))
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (copy_from_user(buf, ubuf, len))
>>>>> +        return -EFAULT;
>>>>> +
>>>>> +    buf[len] = '\0';
>>>>> +    cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name, 
>>>>> strim(buf));
>>>>> +    if (cmd < 0) {
>>>>> +        dev_err(adev->dev, "unknown ualink test command\n");
>>>>> +        return cmd;
>>>>> +    }
>>>>> +
>>>>> +    r = amdgpu_debugfs_ualink_test_run(adev, cmd);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>> +    return len;
>>>>> +}
>>>>> +
>>>>> +static const struct file_operations amdgpu_ualink_command_fops = {
>>>>> +    .owner     = THIS_MODULE,
>>>>> +    .open     = simple_open,
>>>>> +    .read     = amdgpu_debugfs_ualink_command_read,
>>>>> +    .write     = amdgpu_debugfs_ualink_command_write,
>>>>> +    .llseek     = default_llseek,
>>>>> +};
>>>>> +
>>>>> +/* test data buffers, see amdgpu_debugfs_ualink_data_xfer() */
>>>>> +enum amdgpu_ualink_test_buf {
>>>>> +    UALINK_BUF_LOCAL,
>>>>> +    UALINK_BUF_REMOTE_SDMA,
>>>>> +    UALINK_BUF_REMOTE_LSDMA,
>>>>> +};
>>>>> +
>>>>> +static int amdgpu_debugfs_ualink_data_xfer(struct amdgpu_device 
>>>>> *adev,
>>>>> +                       enum amdgpu_ualink_test_buf buf,
>>>>> +                       u32 *data, u32 size, bool read)
>>>>> +{
>>>>> +    u32 remote_accel_id = adev->ualink.test_remote_accel_id;
>>>>> +    int r;
>>>>> +
>>>>> +    if (remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
>>>>> +        dev_err(adev->dev, "set remote_accel_id first\n");
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    adev->ualink.selftesting = true;
>>>>> +
>>>>> +    if (buf == UALINK_BUF_LOCAL)
>>>>> +        r = ualink_test_local_data(adev, remote_accel_id, data, 
>>>>> size, read);
>>>>> +    else
>>>>> +        r = ualink_test_remote_rw(adev, remote_accel_id, data, 
>>>>> size, read,
>>>>> +                      buf == UALINK_BUF_REMOTE_LSDMA);
>>>>> +
>>>>> +    adev->ualink.selftesting = false;
>>>>> +
>>>>> +    return r;
>>>>> +}
>>>>> +
>>>>> +static ssize_t amdgpu_debugfs_ualink_data_read(struct file *file,
>>>>> +                           char __user *ubuf, size_t len,
>>>>> +                           loff_t *offp,
>>>>> +                           enum amdgpu_ualink_test_buf buf)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = file->private_data;
>>>>> +    ssize_t ret;
>>>>> +    u32 size;
>>>>> +    void *data;
>>>>> +    int r;
>>>>> +
>>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>>> +
>>>>> +    size = adev->ualink.test_size_dwords * 4;
>>>>> +
>>>>> +    data = kmalloc(size, GFP_KERNEL);
>>>>> +    if (!data)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, 
>>>>> true);
>>>>> +    ret = r ? r : simple_read_from_buffer(ubuf, len, offp, data, 
>>>>> size);
>>>>> +
>>>>> +    kfree(data);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +static ssize_t amdgpu_debugfs_ualink_data_write(struct file *file,
>>>>> +                        const char __user *ubuf,
>>>>> +                        size_t len, loff_t *offp,
>>>>> +                        enum amdgpu_ualink_test_buf buf)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = file->private_data;
>>>>> +    u32 i, size;
>>>>> +    void *data;
>>>>> +    int r;
>>>>> +
>>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>>> +
>>>>> +    size = adev->ualink.test_size_dwords * 4;
>>>>> +
>>>>> +    if (!len)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    len = min_t(size_t, len, size);
>>>>> +
>>>>> +    data = kmalloc(size, GFP_KERNEL);
>>>>> +    if (!data)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    if (copy_from_user(data, ubuf, len)) {
>>>>> +        kfree(data);
>>>>> +        return -EFAULT;
>>>>> +    }
>>>>> +
>>>>> +    /* repeat a short pattern to fill the test size */
>>>>> +    for (i = len; i < size; i += len)
>>>>> +        memcpy(data + i, data, min_t(u32, len, size - i));
>>>>> +
>>>>> +    r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, 
>>>>> false);
>>>>> +
>>>>> +    kfree(data);
>>>>> +
>>>>> +    return r ? r : len;
>>>>> +}
>>>>> +
>>>>> +#define UALINK_TEST_DATA_ATTR(name, buf)                \
>>>>> +static ssize_t amdgpu_debugfs_ualink_##name##_read(struct file 
>>>>> *file,    \
>>>>> +        char __user *ubuf, size_t len, loff_t *offp)        \
>>>>> +{                                    \
>>>>> +    return amdgpu_debugfs_ualink_data_read(file, ubuf, len, offp, 
>>>>> buf); \
>>>>> +}                                    \
>>>>> +static ssize_t amdgpu_debugfs_ualink_##name##_write(struct file 
>>>>> *file, \
>>>>> +        const char __user *ubuf, size_t len, loff_t *offp) \
>>>>> +{                                    \
>>>>> +    return amdgpu_debugfs_ualink_data_write(file, ubuf, len, 
>>>>> offp, buf); \
>>>>> +}                                    \
>>>>> +static const struct file_operations amdgpu_ualink_##name##_fops = 
>>>>> {    \
>>>>> +    .owner     = THIS_MODULE,                        \
>>>>> +    .open     = simple_open,                        \
>>>>> +    .read     = amdgpu_debugfs_ualink_##name##_read,            \
>>>>> +    .write     = amdgpu_debugfs_ualink_##name##_write, \
>>>>> +    .llseek     = default_llseek,                    \
>>>>> +}
>>>>> +
>>>>> +UALINK_TEST_DATA_ATTR(local_test_data, UALINK_BUF_LOCAL);
>>>>> +UALINK_TEST_DATA_ATTR(remote_sdma, UALINK_BUF_REMOTE_SDMA);
>>>>> +UALINK_TEST_DATA_ATTR(remote_lsdma, UALINK_BUF_REMOTE_LSDMA);
>>>>> +
>>>>> +static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = data;
>>>>> +
>>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>>> +
>>>>> +    *val = adev->ualink.test_remote_accel_id;
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = data;
>>>>> +
>>>>> +    if (!adev->ualink.info)
>>>>> +        return -EOPNOTSUPP;
>>>>> +
>>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>>> +
>>>>> +    if (val >= AMDGPU_UALINK_ACCEL_MAX ||
>>>>> +        !test_bit(val, adev->ualink.info->vpod.active_accel_bits)) {
>>>>> +        dev_err(adev->dev, "invalid remote accel_id %llu\n", val);
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    if (val == adev->ualink.info->ppod.accel_id) {
>>>>> +        dev_err(adev->dev, "remote accel_id equals to local 
>>>>> accel_id\n");
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    adev->ualink.test_remote_accel_id = val;
>>>>> +    dev_info(adev->dev, "set remote accel_id to %llu, local 
>>>>> accel_id %u\n",
>>>>> +         val, adev->ualink.info->ppod.accel_id);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
>>>>> +             amdgpu_debugfs_ualink_accel_id_get,
>>>>> +             amdgpu_debugfs_ualink_accel_id_set, "%llu\n");
>>>>> +
>>>>> +static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = data;
>>>>> +
>>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>>> +
>>>>> +    *val = adev->ualink.test_size_dwords * 4;
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = data;
>>>>> +
>>>>> +    if (val < 4 || val > AMDGPU_UALINK_RB_SIZE)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>>> +
>>>>> +    adev->ualink.test_size_dwords = val / 4;
>>>>> +    dev_dbg(adev->dev, "test buffer size %u bytes\n",
>>>>> +        adev->ualink.test_size_dwords * 4);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
>>>>> +             amdgpu_debugfs_ualink_test_size_get,
>>>>> +             amdgpu_debugfs_ualink_test_size_set, "%llu\n");
>>>>> +
>>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>   {
>>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>>> +    struct dentry *ualink_test;
>>>>>       struct dentry *ent;
>>>>>       int r, i;
>>>>>   @@ -2246,6 +2573,25 @@ int amdgpu_debugfs_init(struct 
>>>>> amdgpu_device *adev)
>>>>> debugfs_create_ulong("amdgpu_ualink_drop_msg_bitmap", 0600, root,
>>>>>                    &adev->ualink.drop_msg_bitmap);
>>>>>   +    mutex_init(&adev->ualink.selftest_mutex);
>>>>> +    /* 64 bytes test size by default */
>>>>> +    adev->ualink.test_size_dwords = 16;
>>>>> +    adev->ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
>>>>> +
>>>>> +    ualink_test = debugfs_create_dir("amdgpu_ualink_test", root);
>>>>> +    debugfs_create_file("command", 0600, ualink_test, adev,
>>>>> +                &amdgpu_ualink_command_fops);
>>>>> +    debugfs_create_file("remote_accel_id", 0600, ualink_test, adev,
>>>>> +                &amdgpu_ualink_accel_id_fops);
>>>>> +    debugfs_create_file("test_size", 0600, ualink_test, adev,
>>>>> +                &amdgpu_ualink_test_size_fops);
>>>>> +    debugfs_create_file("local_test_data", 0600, ualink_test, adev,
>>>>> +                &amdgpu_ualink_local_test_data_fops);
>>>>> +    debugfs_create_file("remote_sdma", 0600, ualink_test, adev,
>>>>> +                &amdgpu_ualink_remote_sdma_fops);
>>>>> +    debugfs_create_file("remote_lsdma", 0600, ualink_test, adev,
>>>>> +                &amdgpu_ualink_remote_lsdma_fops);
>>>>> +
>>>>>       adev->debugfs_vbios_blob.data = adev->bios;
>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>>       debugfs_create_blob("amdgpu_vbios", 0444, root,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>>>> index 05bc281216bf..1f83d9b69135 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>>>> @@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device 
>>>>> *adev,
>>>>>       mutex_unlock(&adev->lsdma.lock);
>>>>>       return ret;
>>>>>   }
>>>>> +
>>>>> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
>>>>> +{
>>>>> +    struct amdgpu_ib ib;
>>>>> +    int i, r;
>>>>> +    u64 gpu_addr;
>>>>> +    char *p;
>>>>> +    u32 size = 128;
>>>>> +
>>>>> +    memset(&ib, 0, sizeof(ib));
>>>>> +    r = amdgpu_ib_get(adev, NULL, 2 * size, 
>>>>> AMDGPU_IB_POOL_DIRECT, &ib);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>> +    gpu_addr = ib.gpu_addr;
>>>>> +    p = (char *)ib.ptr;
>>>>> +    memset(p, 0, 2 * size);
>>>>> +
>>>>> +    for (i = 0; i < size; i++)
>>>>> +        *(p + i) = i;
>>>>> +
>>>>> +    dev_dbg(adev->dev, "copy src 0x%llx dst 0x%llx size %d bytes\n",
>>>>> +        gpu_addr, gpu_addr + size, size);
>>>>> +
>>>>> +    r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, 
>>>>> size);
>>>>> +    if (r)
>>>>> +        goto out;
>>>>> +
>>>>> +    p += size;
>>>>> +    for (i = 0; i < size; i++) {
>>>>> +        if (*(p + i) != i) {
>>>>> +            dev_dbg(adev->dev, "data mismatch expecting 0x%x but 
>>>>> read 0x%x\n",
>>>>> +                i, *(p + i));
>>>>> +            break;
>>>>> +        }
>>>>> +    }
>>>>> +    if (i != size)
>>>>> +        r = -EIO;
>>>>> +
>>>>> +out:
>>>>> +    amdgpu_ib_free(&ib, NULL);
>>>>> +
>>>>> +    if (r)
>>>>> +        dev_dbg(adev->dev, "lsdma selftest failed r=%d\n", r);
>>>>> +    else
>>>>> +        dev_dbg(adev->dev, "lsdma selftest passed\n");
>>>>> +
>>>>> +    return r;
>>>>> +}
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>>>> index 34e92aaa4617..f0a5eeb3529f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>>>> @@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device 
>>>>> *adev, uint64_t dst_addr,
>>>>>                 uint32_t data, uint64_t mem_size);
>>>>>   int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t 
>>>>> reg_index,
>>>>>                 uint32_t reg_val, uint32_t mask);
>>>>> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
>>>>>     #endif
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>>> index 339f639a450e..86e0dc8d728e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>>> @@ -39,8 +39,6 @@ static void deactivate_accelerator(struct 
>>>>> amdgpu_device *adev);
>>>>>   static int amdgpu_ualink_remote_interrupt(struct amdgpu_device 
>>>>> *adev,
>>>>>                   u32 remote_accel_id, u32 dw0, u32 dw1,
>>>>>                   u32 dw2, u32 dw3);
>>>>> -static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev,
>>>>> -                    u32 flush_type);
>>>>>   static int amdgpu_ualink_reserve_npa_vm_and_bos(struct 
>>>>> amdgpu_device *adev,
>>>>>                           struct amdgpu_bo *bos[], u32 n_bos,
>>>>>                           struct drm_exec *exec,
>>>>> @@ -4333,9 +4331,6 @@ void amdgpu_ualink_manager_stop(struct 
>>>>> amdgpu_device *adev)
>>>>>    * UALink remote interrupt and shootdown
>>>>>    */
>>>>>   -/* UALINK ring buffer size, same for both remote shootdown and 
>>>>> interrupt ring */
>>>>> -#define AMDGPU_UALINK_RB_SIZE    4096
>>>>> -
>>>>>   #define AMDGPU_UALINK_METADATA_HEADER    0x4E485446
>>>>>     /* 2MB NPA start address for 2MB page mapping */
>>>>> @@ -4582,7 +4577,7 @@ static inline u32 
>>>>> ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
>>>>>       return ualink_wb_offset(adev, accel_id) + sizeof(struct 
>>>>> amdgpu_ualink_wb);
>>>>>   }
>>>>>   -static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, 
>>>>> u32 flush_type)
>>>>> +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 
>>>>> flush_type)
>>>>>   {
>>>>>       u32 bit;
>>>>>   @@ -5281,7 +5276,8 @@ static int 
>>>>> amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>>>>       if (status != AMDGPU_NHT_FW_ST_PREINIT &&
>>>>>           status != AMDGPU_NHT_FW_ST_HALT) {
>>>>>           dev_dbg(adev->dev, "fw status 0x%x not preinit or 
>>>>> halt\n", status);
>>>>> -        return -ENODEV;
>>>>> +        if (!adev->ualink.selftesting)
>>>>> +            return -ENODEV;
>>>>>       }
>>>>>         dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 
>>>>> 0x%x\n",
>>>>> @@ -5399,6 +5395,8 @@ static int 
>>>>> amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>>>>       r = adev->ualink.msg_ctl->send_metadata(adev,
>>>>> remote->metadata_gpu_addr,
>>>>>                               AMDGPU_UALINK_ACCEL_MAX << 8);
>>>>> +    if (r && adev->ualink.selftesting)
>>>>> +        r = 0;
>>>>>     out:
>>>>>       if (r)
>>>>> @@ -6384,11 +6382,216 @@ void amdgpu_ualink_sw_fini(struct 
>>>>> amdgpu_device *adev)
>>>>>       adev->ualink.remote = NULL;
>>>>>   }
>>>>>   -int ualink_send_hello(struct amdgpu_device *adev, u32 
>>>>> remote_accel_id)
>>>>> +/* byte offset of the local interrupt ring a remote GPU writes to */
>>>>> +static u32 ualink_test_local_rb_offset(u32 remote_accel_id)
>>>>> +{
>>>>> +    u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>>>>> +
>>>>> +    /* remote shootdown ring is first, remote interrupt ring 
>>>>> follows it */
>>>>> +    return rb_size * remote_accel_id + AMDGPU_UALINK_RB_SIZE;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * ualink_test_local_data - read or write the local ring buffer 
>>>>> of a remote GPU
>>>>> + *
>>>>> + * The local ring buffer is partitioned per remote GPU, 
>>>>> @remote_accel_id selects
>>>>> + * the interrupt ring that remote GPU writes to through its NPA 
>>>>> mapping. Read it
>>>>> + * to see what the remote GPU wrote, write it to provide the data 
>>>>> it reads.
>>>>> + */
>>>>> +int ualink_test_local_data(struct amdgpu_device *adev, u32 
>>>>> remote_accel_id,
>>>>> +               void *data, u32 size, bool read)
>>>>>   {
>>>>> +    struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>>> +    void *rb;
>>>>> +
>>>>> +    if (!remote || !remote->rb_cpu_addr)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (size > AMDGPU_UALINK_RB_SIZE)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    rb = remote->rb_cpu_addr + 
>>>>> ualink_test_local_rb_offset(remote_accel_id);
>>>>> +
>>>>> +    dev_dbg(adev->dev, "%s local rb of remote %u at 0x%p size 
>>>>> 0x%x\n",
>>>>> +        read ? "read" : "write", remote_accel_id, rb, size);
>>>>> +
>>>>> +    if (read)
>>>>> +        memcpy(data, rb, size);
>>>>> +    else
>>>>> +        memcpy(rb, data, size);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * ualink_test_remote_rw - read or write the remote GPU ring buffer
>>>>> + *
>>>>> + * Copy @size bytes between @data and the remote GPU ring buffer 
>>>>> NPA address
>>>>> + * using lsdma or sdma. The DMA engines cannot access @data, the 
>>>>> local ring
>>>>> + * buffer of the same remote GPU is used to stage it, so 
>>>>> local_test_data shows
>>>>> + * what was sent or received.
>>>>> + *
>>>>> + * Works with or without MPNHT FW running, the copy does not 
>>>>> update wptr and
>>>>> + * does not ring the doorbell.
>>>>> + */
>>>>> +int ualink_test_remote_rw(struct amdgpu_device *adev, u32 
>>>>> remote_accel_id,
>>>>> +              void *data, u32 size, bool read, bool use_lsdma)
>>>>> +{
>>>>> +    struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>>> +    struct amdgpu_ualink_peer *peer;
>>>>> +    struct amdgpu_ualink_ring *ring;
>>>>> +    struct dma_fence *fence;
>>>>> +    struct amdgpu_job *job;
>>>>> +    struct amdgpu_ib *ib;
>>>>> +    u64 npa, local;
>>>>> +    u32 offset, ndw;
>>>>> +    int r;
>>>>> +
>>>>> +    if (!remote)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (size > AMDGPU_UALINK_RB_SIZE)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    peer = &remote->peer[remote_accel_id];
>>>>> +    ring = &peer->interrupt;
>>>>> +
>>>>> +    guard(mutex)(&peer->lock);
>>>>> +
>>>>> +    offset = ualink_test_local_rb_offset(remote_accel_id);
>>>>> +    local = remote->rb_gpu_addr + offset;
>>>>> +    npa = ring->rb_npa_gart;
>>>>> +
>>>>> +    if (!read)
>>>>> +        memcpy(remote->rb_cpu_addr + offset, data, size);
>>>>> +
>>>>> +    remote->use_lsdma = use_lsdma;
>>>>> +
>>>>> +    dev_dbg(adev->dev, "%s remote %u npa 0x%llx local 0x%llx size 
>>>>> 0x%x use %s\n",
>>>>> +        read ? "read" : "write", remote_accel_id, npa, local, size,
>>>>> +        use_lsdma ? "lsdma" : "sdma");
>>>>> +
>>>>> +    if (use_lsdma) {
>>>>> +        r = amdgpu_lsdma_copy_mem(adev, read ? npa : local,
>>>>> +                      read ? local : npa, size);
>>>>> +        if (r)
>>>>> +            return r;
>>>>> +
>>>>> +        goto done;
>>>>> +    }
>>>>> +
>>>>> +    /* sdma linear copy command, align to 8 dwords boundary */
>>>>> +    ndw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>>>>> +
>>>>> +    r = amdgpu_job_alloc_with_ib(adev, &peer->entity, 
>>>>> AMDGPU_FENCE_OWNER_VM,
>>>>> +                     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>>>> + AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>> +    ib = job->ibs;
>>>>> +    ib->length_dw = 0;
>>>>> +
>>>>> +    amdgpu_emit_copy_buffer(adev, ib, read ? npa : local,
>>>>> +                read ? local : npa, size, 0);
>>>>> + amdgpu_ring_pad_ib(&adev->sdma.instance[0].ring, ib);
>>>>> +    WARN_ON(ib->length_dw > ndw);
>>>>> +
>>>>> +    fence = amdgpu_job_submit(job);
>>>>> +
>>>>> +    r = dma_fence_wait_timeout(fence, false, HZ * 10);
>>>>> +    dma_fence_put(fence);
>>>>> +    if (r <= 0) {
>>>>> +        dev_dbg(adev->dev, "remote sdma fence wait timeout %d\n", 
>>>>> r);
>>>>> +        dev_dbg(adev->dev, "use lsdma for testing afterwards\n");
>>>>> +        remote->use_lsdma = true;
>>>>> +        return -ETIME;
>>>>> +    }
>>>>> +
>>>>> +done:
>>>>> +    if (read)
>>>>> +        memcpy(data, remote->rb_cpu_addr + offset, size);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +/* The peer may have rebooted or the vpod was reconfigured, adopt 
>>>>> the remote
>>>>> + * wptr before sending a command, same as the handshake does.
>>>>> + */
>>>>> +static int ualink_test_resync_peer(struct amdgpu_device *adev, 
>>>>> u32 remote_accel_id)
>>>>> +{
>>>>> +    int r;
>>>>> +
>>>>> +    if (!adev->ualink.remote)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
>>>>> +    if (r < 0)
>>>>> +        return r;
>>>>> +
>>>>> +    /* Peer moved, drop ready so the next command updates the wb 
>>>>> address */
>>>>> +    if (r)
>>>>> +        amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +int ualink_test_send_hello(struct amdgpu_device *adev, u32 
>>>>> remote_accel_id)
>>>>> +{
>>>>> +    int r;
>>>>> +
>>>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>>       return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
>>>>>   }
>>>>>   +int ualink_test_remote_shootdown(struct amdgpu_device *adev, 
>>>>> u32 remote_accel_id,
>>>>> +                 u64 addr, u32 size_in_pages, u32 flush_type)
>>>>> +{
>>>>> +    int r;
>>>>> +
>>>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>> +    return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, 
>>>>> addr,
>>>>> +                          size_in_pages, flush_type);
>>>>> +}
>>>>> +
>>>>> +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, 
>>>>> u32 remote_accel_id)
>>>>> +{
>>>>> +    int r;
>>>>> +
>>>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>> + guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
>>>>> +
>>>>> +    /* Update interrupt completion write back address */
>>>>> +    r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>>>> +                        RB_TYPE_REMOTE_INTERRUPT);
>>>>> +    return r;
>>>>> +}
>>>>> +
>>>>> +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, 
>>>>> u32 remote_accel_id)
>>>>> +{
>>>>> +    int r;
>>>>> +
>>>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>> + guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
>>>>> +
>>>>> +    /* Update shootdown completion write back address */
>>>>> +    r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>>>> +                        RB_TYPE_TLB_INV);
>>>>> +    return r;
>>>>> +}
>>>>> +
>>>>>   /*
>>>>>    * The low bits of handle_lo carry the message-header field on 
>>>>> the wire.
>>>>>    * Strip those bits and splice in @acc_id to recover the
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>>>> index 85c9a9634a4b..90e90cd8b495 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>>>> @@ -310,6 +310,9 @@ struct amdgpu_ualink_connection {
>>>>>       enum amdgpu_ualink_conn_state state;
>>>>>   };
>>>>>   +/* UALINK ring buffer size, same for both remote shootdown and 
>>>>> interrupt ring */
>>>>> +#define AMDGPU_UALINK_RB_SIZE    4096
>>>>> +
>>>>>   struct amdgpu_ualink_remote;
>>>>>     struct amdgpu_ualink_msg_ctl {
>>>>> @@ -333,6 +336,13 @@ struct amdgpu_ualink_mgr {
>>>>>       /* For remote interrupt and shootdown */
>>>>>       struct amdgpu_ualink_remote *remote;
>>>>>   +    /* true for selftest driver path, ignore FW error */
>>>>> +    bool selftesting;
>>>>> +    /* serialize the selftest debugfs entries */
>>>>> +    struct mutex selftest_mutex;
>>>>> +    u32 test_size_dwords;
>>>>> +    u32 test_remote_accel_id;
>>>>> +
>>>>>       /* handle irq from ualink client of remote GPUs */
>>>>>       struct amdgpu_irq_src irq;
>>>>>   @@ -390,14 +400,22 @@ struct amdgpu_ualink_mgr {
>>>>>       unsigned long drop_msg_bitmap;
>>>>>   };
>>>>>   +int ualink_test_local_data(struct amdgpu_device *adev, u32 
>>>>> remote_accel_id,
>>>>> +               void *data, u32 size, bool read);
>>>>> +int ualink_test_remote_rw(struct amdgpu_device *adev, u32 
>>>>> remote_accel_id,
>>>>> +              void *data, u32 size, bool read, bool use_lsdma);
>>>>> +int ualink_test_send_hello(struct amdgpu_device *adev, u32 
>>>>> remote_accel_id);
>>>>> +int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 
>>>>> remote_accel_id,
>>>>> +                 u64 addr, u32 size_in_pages, u32 flush_type);
>>>>> +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, 
>>>>> u32 remote_accel_id);
>>>>> +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, 
>>>>> u32 remote_accel_id);
>>>>> +
>>>>>   int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
>>>>>                    unsigned int client_id, unsigned int src_id);
>>>>> -
>>>>> +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 
>>>>> flush_type);
>>>>>   int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
>>>>>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
>>>>>   -int ualink_send_hello(struct amdgpu_device *adev, u32 
>>>>> remote_accel_id);
>>>>> -
>>>>>   int amdgpu_ualink_config_update_handler(struct amdgpu_device 
>>>>> *adev);
>>>>>   int amdgpu_ualink_pause_handler(struct amdgpu_device *adev);
>>>>>   int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
>>>
>
