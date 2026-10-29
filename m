Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D4606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=P63Og4KR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C333E11239B;
	Thu, 29 Oct 2026 15:16:12 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3283F11239B
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 15:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIKmGv2Jw4Li34nleyqgAY/QHcx7XN8aegVtD/flrSxec7R1bwCYA4duDAzXjN+Miz6lX4/QWJbcl/SpcYMBQyULpcmsiICjNbuDb+g9LTySqJDDqvGC+j6c/ywvlerPVbYKbDCI3m9HBwX+0ALhVMRpmC7057BgJouQqP0lYVPF52EY8MRI4JARND2vgwkD1PvuDAMbFxLLgyvd4khdPUc9ka7m95k5FQ6sLJ1alk9k9JIFvsMb4jZMk7tltqevJm9FRnwyvyq4imZfqsc9bdXgyTQXQPuvg4Sk6+uAmB/ASZXkAz1wjGSDqhZv6MXqincF+n6VlXnMPmgjKQHOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3S1GF2t5R/5+LAFSMHBwNTT+K8DBbXPBSEIjK+SynY=;
 b=ZLFFxffT7JUeEuVt6ObK6Jk2eqsgGmWCWUDrT9AvHqaUsfviG5HnQc/VVuudcpEUWNBkj3YoqJDQWFg3VI0BLNYJCMWU33niIdoYugcytam+KsnFGKlmZSdOO4EAr9F3UwHAMXvvBilGog3D3HQ/KElLgut6C8BpynpCm9HVgIbFSJchTmjFjBSGgRq6lfgb77yJMTGHrcgcq7vB0JEpGVlQknzODkO7UW3ez1Nuc5yCOwA9nc7cXUvLIN9c9LjL2uRD5HC8vFrgIG4sMPxTkY2bSHepSiY90o3RrlaHPpBWdnZ9ZZ6tgO4oMg/0UMzbe9nQIziPH5OEtqI0mL5N8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3S1GF2t5R/5+LAFSMHBwNTT+K8DBbXPBSEIjK+SynY=;
 b=P63Og4KRFtDEPe2ugqeGH+Aafd0FNl0qdJ2vz8e0DqhAUY2l7Hccx85itp7B5U2+yKIWJ1yke4fFcYRSQAh3cV2pY/bleNYfhEuIRXGFmxnAKgZA6jBIJ1T9R53x/Zfy0zDb2LZGqyIRbrHakzPtTVP6Q01Z1ary2lA5L5LLGWg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 15:15:58 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 15:15:58 +0000
Content-Type: multipart/alternative;
 boundary="------------sGCW5DCotGZfVPo0BNpIfDAR"
Message-ID: <ef6f1630-7af1-4366-a18b-f8cebf742378@amd.com>
Date: Thu, 29 Oct 2026 11:15:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/amdgpu: UALink add debugfs selftest
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Mukul.Joshi@amd.com
References: <20261023203447.2075707-1-Philip.Yang@amd.com>
 <abbf170b-628b-455f-94b1-91e3ce540863@amd.com>
 <e0535f78-43ca-4d44-a93b-405de825ba65@amd.com>
 <7a63c005-8d95-497e-bf4f-00a80688e732@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <7a63c005-8d95-497e-bf4f-00a80688e732@amd.com>
X-ClientProxiedBy: YT4PR01CA0283.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::8) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 89eaecab-39f6-40ec-0796-08df35cf88b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|5023799004|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|261026140227099003|261026130827099003|261026135527099003|261028144727099003|261021121427099003|261022115727099003|261022075727099003|10067099003|261022113327099003|261022105027099003|261021123027099003|261021135927099003|261021133027099003|261021130227099003|22082099003|18002099003|6133799003|3023799007|8096899003;
X-Microsoft-Antispam-Message-Info: ScaLJHureXGnU2pHymxnWnAQrsTPj+Pxa2hLEwoG3n5cbwV1+EkBow9Mixi/lHuG1jDb5D3NKRe3tG83a0TKdlg7CdFnHfL/Z4HB0Pk+a3Beq7RGDCZPS0BJw/8pvrvB6obpN0/uFDxDf63UxK+JgrtIyIVve9D+4ST7u7ZqbIQnkBLNmkx0wJOklmMGHXmaIeY76RUJhsNwqDoo0VAB51nohBDQV5ZJLphZIvfzQLmKlYdtuQgvfwfr99s72x0zNGirii9DtxHOmS24/fJtMmB6LrRhXVuBrqPmiEq7CbnSLZ7BNrjpYtxE/bqzPpSJgLaWA8K9x7e5pUQvxM4xILnpoPvD8Yp5Oz0VX82q2GmiGY+VEiBUNg2SEbaqv5FOXlgv6FS74P/86TTpcyp3pObSRDUET+K9eQPr3kpObfnGwIHQKSpArcAMGJJqSPMp1DrhBBHsGOtGvrpTND6lsTrzl1DrjSBnCRZerpUUtMRh9sze/2V/qxkrBq1P57fXORMTCwlv/jd0OV86Kq7OhUBCxv+Hux+LZ4SfVxiV3OBOVT6rowQPeIeMVd877huyOxXpUx5BrDrC5mi1DBmXSDiZjDDV4FjnhxCTQ3EqDp3NrqXQko79QrEB4v5i8kHKpbCnovSmqgxPj+ZCgwITL7GsqK6CRr1yNIgN12n5hgI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(5023799004)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261026130827099003)(261026135527099003)(261028144727099003)(261021121427099003)(261022115727099003)(261022075727099003)(10067099003)(261022113327099003)(261022105027099003)(261021123027099003)(261021135927099003)(261021133027099003)(261021130227099003)(22082099003)(18002099003)(6133799003)(3023799007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2xyaU9zWTFvUGp6YUdDRllZREdsM3N5LzBhSUV4bmU5eEUwTmwwemtkdUNM?=
 =?utf-8?B?MVZBUmRFY0poYmU4OU04MEdlMWJvdEdYbjRLdU1EbkRLMng4NWtKdWtqQVBY?=
 =?utf-8?B?UFpOUk5DalMzQzYvSFBtTG9aUGhiZXZiTmdvTU5zZHlKMTk0Z0toZDlPbUNC?=
 =?utf-8?B?b0o3ZnFBVnJlRXVLaXVMRjZZS1VPUDNOSTBUZEZyeXQzSlhEelVubXVQdU1i?=
 =?utf-8?B?L0thWmFCZlJjR2luMGZIUUsxbFhTL2dNeXZXSkYrTnI2UTFpV05rckRNMnRp?=
 =?utf-8?B?ZjBuRmtLRjl1RjhOMURnbmlaL0ZLYVg0Ujh0VmtOdElKSnhCd2lYRzZkak9m?=
 =?utf-8?B?bmFuTkoram9wcTVySktTU3B2M1FRWGtVQThrMGI4VDdSR1FzTFJObEN2R1JC?=
 =?utf-8?B?YnB5dDNRSFNnSWEwblVJNndLdjR0Q25ncG9IK1J1V1F0RXFqV1hsK1N1SEZR?=
 =?utf-8?B?aDhrSnhaaW11UUlublRMbVdmcHZML1hqRTNaSXVtTWVaK0graGNkTTR1eUNs?=
 =?utf-8?B?aFJkOENDbTd3cDFxbUVvZ01YdjkrTjNjV2RyTDRNTHZ0cHYxSTQ4a1J2K0hE?=
 =?utf-8?B?d1owNHVxejZvdjhKcGJ6czN1QjZ0TmQrL2t3cVFVWkNYNFpxb0xkV01Lem0x?=
 =?utf-8?B?aEhLdWlRb1ZnYWp0MHprdmVzcENRVUg5cDJWYTZUMGs3L2EwUS9nUE00MmZ6?=
 =?utf-8?B?czhRbnNKVWFpTWRwekFSbnB6ckk3YjF6MTBLV3p1R1FkeDNYa0ZKMndvNDJH?=
 =?utf-8?B?ZXVmMDRlQzVYRVhZenVqL1J2b2diQ3I5M2Z5VkMzc0ZCa1BoeU9YYTNaNXUx?=
 =?utf-8?B?YXFscDRtTXg5YVhtTHI1bjRyekFUUklmQngrdXlNbDNSbnE0aVZlbHFQd2Mx?=
 =?utf-8?B?ZmhTTFRPcUdEemhYNU9kdFFvbm1OS0lxellESVAvSWd0eEpnQ1VPT1RpZUtt?=
 =?utf-8?B?UmVnWVF0a0ZJT3VLL243WGNNd0F4QkJNYnNkVGRFY21tRzZQTnYzMm1RUWli?=
 =?utf-8?B?VXR3R202cUwrUlgxYmhIa3NpQm8zbG1oRlpIaHBnT1NJekJwbXJoSWcwUGZu?=
 =?utf-8?B?R1pDMi9tUjJqeFlsOEluNncvcUpSblpaYUd3Tk40YTJZT0pZdDVUVEhBMC9H?=
 =?utf-8?B?V2pSNFZWbGh4Tm8rUk5HaU5lMGd6bWFudXdoYVB2RXVUL3lBQVN3cjdaNk9x?=
 =?utf-8?B?a0N5Ly93bWxWNVRGZStlN0ExQUZPT0N3alFiQThqUitjSjZFT3BBMS9qb1Bo?=
 =?utf-8?B?RWNBSEhXUWhGelA1SDlKeXBYN3VxRXRYQzc3eUtIVm8zL2dkeWR5Uk5ScGlF?=
 =?utf-8?B?N1o3eW55OFpoNVJINEJJVGtpcFZjbFZqaUFLd1ZGVlZBajlua3lmNVZlOXpI?=
 =?utf-8?B?TGoxK2hMUUN1dEgzUXhQSDNCUUwrd3NGOGxPMXJmMjVtZWxyZXRpN2grVVRD?=
 =?utf-8?B?SkZJUnhjMFFWZ3F0SnVmZGdISmc1NjFlMisxVUM3ZWV3MVhMeWFydFdwOHIr?=
 =?utf-8?B?aS9NUnBrb0J2VEw2cHBnWCtyMnZTMmJLbnJZbmxZbHFLbUlSRnJvSHBiWE1t?=
 =?utf-8?B?OUFuRENYQkozbDlxdmpMM3FvdFhTdzdiYWhsZzF5RVlkdHI5cUhTeXdHQUNw?=
 =?utf-8?B?YXV2bjE4cEx5WWZEU2RRRnByUjg2WU1nZjIzQ1ZpQzNzRzdJOFNVWU1FUEw1?=
 =?utf-8?B?VHZTTld6QzNsQUhMVU9LNWdNdVZQQkszWnpXSUZFSjZ4RjJQY0tvZmpqemcx?=
 =?utf-8?B?MWlKcVdqbUV6aS9nT1d1NXBTbU5vQkVIR3p6Y3ZTeWE1TkI1T0ZNekRRY29y?=
 =?utf-8?B?Q0V2TTU5akM5WHJ5WENDejBYbUxTT0Z1TENnSWdFcHBBaFdxOXdPVEVCMEU2?=
 =?utf-8?B?RGdwUkk5RnVwNTdxR3B0dmZGWGxvV1ExUG0xT3Yxbk13b0NLekZ2LzVOTDVi?=
 =?utf-8?B?Wkd1ZURXUjlXcCtnbytWTW1JNDcyRzlTVmpXbWhzUWczcS9oUlJUdlZYZHR2?=
 =?utf-8?B?T1hmdllYQ2F2MWRSY0VoU25KQjJrZk03Q0xTM01paS92eDJvWGhUWGtLemQ5?=
 =?utf-8?B?RitTa0ViT3ZmaVdhWUhhd1hNalRmWU5PRzRIL1oyeC90Q3R1RjBwSHZ0czEz?=
 =?utf-8?B?bVZHM3ljTjUvdUE2eGhmMXFoeDd0QWFMRFZZQUg3MDQ5ODBQN280NGZtME5r?=
 =?utf-8?B?Q29SYk9DWGdObHFZL0ExdkI2KzhSdHA2a0lEdE1WdXQ2WFJGeFMrTTNRUjhC?=
 =?utf-8?B?QVlsdXBSNFBLYzlwYzRGRi9tTHJoRzZJMi9QZmtrT0pDQ0x5dmlLZGdlb2N5?=
 =?utf-8?Q?swop14UfXYJXwb5JWY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89eaecab-39f6-40ec-0796-08df35cf88b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:15:58.1298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SX5Vf1hziqxoHkJDEGiRCbBNAB0jcjtVHFbXYKQiQOSnY3xOdRLE9hiGkBejf/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------sGCW5DCotGZfVPo0BNpIfDAR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-10-28 17:36, Kuehling, Felix wrote:
>
> On 2026-10-28 15:36, Philip Yang wrote:
>>
>>
>> On 2026-10-28 14:24, Kuehling, Felix wrote:
>>> On 2026-10-23 16:34, Philip Yang wrote:
>>>> Driver-side selftests for UALink bring-up: exercise the nHT firmware,
>>>> remote interrupts, remote TLB shootdown and remote VRAM access without
>>>> any userspace application.
>>>>
>>>> Add debugfs directory "amdgpu_ualink_test" to trigger UALink selftests
>>>> with these read/write entries:
>>>>
>>>>    command          write the test name to run it, read to list the
>>>>                     valid test names
>>>>    remote_accel_id  accel_id of the remote GPU used by the tests
>>>>    test_size        test buffer size in bytes, from 4 to 4096
>>>>    local_test_data  the local ring buffer the remote GPU accesses
>>>>    remote_sdma      the remote GPU ring buffer, using sdma
>>>>    remote_lsdma     the remote GPU ring buffer, using lsdma
>>>>
>>>> The data entries take and return binary data, a write shorter than
>>>> test_size is repeated to fill it, so formatting is left to userspace
>>>> tools like printf, xxd, od and cmp.
>>>>
>>>> Add helper functions: ualink_test_local_data() and
>>>> ualink_test_remote_rw() for local and remote ring buffer R/W,
>>>> ualink_test_remote_shootdown() for TLB shootdown,
>>>> ualink_test_send_hello() for handshake,
>>>> ualink_test_update_interrupt_wb() and
>>>> ualink_test_update_shootdown_wb() to read writeback results.
>>>>
>>>> v6: ring buffer wptr for itself is used for wptr, don't init to 
>>>> 0xdeadbeef
>>>
>>> I don't see this change. What exactly did you change? I only see the 
>>> removal of deadbeef init. I don't see any change regarding which 
>>> ring buffer is used to stage the data for remote read/write.
>> The remote ring buffer was initialised to 0xdeadbeef for the 
>> selftest. In address-aliasing mode the wptr for every remote uses 
>> that same ring buffer page for itself accel_id, so the remote wptr 
>> resync read back 0xdeadbeef and synced the wptr to that value, which 
>> left the remote firmware in a bad state. I have removed the ring 
>> buffer initialisation. ualink_test_resync_peer() also change to only 
>> resync wptr for the first command or if peer rebooted.
>
> OK. I was asking for an additional change in v5 that I thought you 
> were addressing here, but didn't.
>
> The remote write first writes data to local memory before copying it 
> to remote. E.g. remote write from A to B overwrites local memory in A. 
> A remote write from B to A writes the same memory in A. Now a tester 
> reading local_test_data from debugfs doesn't know whether that was 
> written by the remote GPU or by a previous local read/write to 
> remote_sdma or remote_lsdma.
>
> Therefore, I would like to keep those separate. A write from A to B 
> should not overwrite the same memory on A as a write from B to A. 
> Similar for remote reads. A remote read by A from B should not 
> overwrite the same memory on A that is also accessed remotely by B.
>
> I proposed using a different offset for the staging memory in 
> ualink_test_remote_rw. Instead of using remote_accel_id in offset = 
> ualink_test_local_rb_offset(remote_accel_id), use the GPU's own 
> accelerator ID.
That won't work, unfortunately. The local accelerator's own slot in the 
ring buffer is where the remotes write their wptr — so every remote's 
wptr for this GPU lands in slot(local_accel_id). Using it for staging 
would corrupt the wptr resync and we'd read back garbage. This is the 
same aliasing that caused the 0xdeadbeef problem we just fixed.

On the ambiguity itself — you're right that A can't distinguish its own 
staging data from what B wrote. But the verification in these tests is 
always done on the opposite side, so it doesn't affect the intended flows:

A writes to B over lsdma, then B reads local_test_data to verify. A's 
own local_test_data happens to hold the same bytes, but nothing checks 
it there.
B writes to its local_test_data, then A reads it back over lsdma and 
verifies.
A writes to B and reads back from B, verifying the round trip.
So the data is always checked where it is unambiguous. I'll document 
this in the commit message so the intent is clear.

If you'd still prefer them physically separated, the clean way is to 
alloc sdma job with extra IB buffer, happy to do it  if you think it's 
worth the extra allocation.

Regards,
Philip
>
> Does that make sense?
>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Philip
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> v5: Replace the four remote access commands with local_test_data,
>>>>      remote_sdma and remote_lsdma entries, to get the test data 
>>>> without
>>>>      looking at debug logs or using xxd with physical addresses 
>>>> (Felix).
>>>>      Dump and accept binary data, no parser in the driver (Felix).
>>>>      Stage the DMA in the local ring buffer instead of the IB, 
>>>> which is
>>>>      freed before the data is read back.
>>>> v4: Use a single "command" entry taking the test name, instead of one
>>>>      entry per test (Felix).
>>>>      Resync the remote wptr before sending a command, the peer may 
>>>> have
>>>>      rebooted.
>>>> v3: Replace the single entry taking a test number with a debugfs
>>>>      directory and a named entry per command.
>>>>      Take peer->lock to update the writeback address and 
>>>> selftest_mutex
>>>>      to read the test parameters.
>>>> v2: Fix typos and issues from copilot code review.
>>>>
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 346 
>>>> ++++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 +++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 219 ++++++++++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  24 +-
>>>>   5 files changed, 628 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index 3dc95d9accf2..2d786639d081 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -2133,9 +2133,336 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, 
>>>> NULL,
>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>   +enum amdgpu_ualink_test_cmd {
>>>> +    UALINK_TEST_SW_INIT,
>>>> +    UALINK_TEST_SEND_HELLO,
>>>> +    UALINK_TEST_REMOTE_SHOOTDOWN,
>>>> +    UALINK_TEST_FLUSH_TLB,
>>>> +    UALINK_TEST_UPDATE_INTERRUPT_WB,
>>>> +    UALINK_TEST_UPDATE_SHOOTDOWN_WB,
>>>> +    UALINK_TEST_LSDMA_SELFTEST,
>>>> +};
>>>> +
>>>> +/* commands talking to a remote accelerator, remote_accel_id must 
>>>> be set */
>>>> +#define UALINK_TEST_NEEDS_ACCEL_ID                    \
>>>> +    (BIT(UALINK_TEST_SEND_HELLO) | 
>>>> BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
>>>> +     BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) | \
>>>> +     BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
>>>> +
>>>> +static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device *adev,
>>>> +                      enum amdgpu_ualink_test_cmd cmd)
>>>> +{
>>>> +    u32 remote_accel_id = adev->ualink.test_remote_accel_id;
>>>> +    int r = 0;
>>>> +
>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>> +
>>>> +    if ((BIT(cmd) & UALINK_TEST_NEEDS_ACCEL_ID) &&
>>>> +        remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
>>>> +        dev_err(adev->dev, "set remote_accel_id first\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    adev->ualink.selftesting = true;
>>>> +
>>>> +    switch (cmd) {
>>>> +    case UALINK_TEST_SW_INIT:
>>>> +        if (adev->ualink.remote)
>>>> +            amdgpu_ualink_sw_fini(adev);
>>>> +
>>>> +        dev_dbg(adev->dev, "load metadata init MPNHT firmware\n");
>>>> +        r = amdgpu_ualink_sw_init(adev);
>>>> +        break;
>>>> +    case UALINK_TEST_SEND_HELLO:
>>>> +        r = ualink_test_send_hello(adev, remote_accel_id);
>>>> +        break;
>>>> +    case UALINK_TEST_REMOTE_SHOOTDOWN:
>>>> +        r = ualink_test_remote_shootdown(adev, remote_accel_id, 
>>>> 1UL << 30,
>>>> +                         1, TLB_FLUSH_HEAVYWEIGHT);
>>>> +        break;
>>>> +    case UALINK_TEST_FLUSH_TLB:
>>>> +        amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
>>>> +        break;
>>>> +    case UALINK_TEST_UPDATE_INTERRUPT_WB:
>>>> +        r = ualink_test_update_interrupt_wb(adev, remote_accel_id);
>>>> +        break;
>>>> +    case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
>>>> +        r = ualink_test_update_shootdown_wb(adev, remote_accel_id);
>>>> +        break;
>>>> +    case UALINK_TEST_LSDMA_SELFTEST:
>>>> +        r = adev->lsdma.funcs ? amdgpu_lsdma_selftest(adev) : 
>>>> -EOPNOTSUPP;
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    adev->ualink.selftesting = false;
>>>> +
>>>> +    dev_dbg(adev->dev, "ualink test cmd %d remote_accel_id %u ret 
>>>> %d\n",
>>>> +        cmd, remote_accel_id, r);
>>>> +
>>>> +    return r;
>>>> +}
>>>> +
>>>> +#define UALINK_TEST_CMD_NAME_MAX    32
>>>> +
>>>> +static const char * const amdgpu_ualink_test_cmd_name[] = {
>>>> +    [UALINK_TEST_SW_INIT]            = "sw_init",
>>>> +    [UALINK_TEST_SEND_HELLO]        = "send_hello",
>>>> +    [UALINK_TEST_REMOTE_SHOOTDOWN]        = "remote_shootdown",
>>>> +    [UALINK_TEST_FLUSH_TLB]            = "flush_tlb",
>>>> +    [UALINK_TEST_UPDATE_INTERRUPT_WB]    = "update_interrupt_wb",
>>>> +    [UALINK_TEST_UPDATE_SHOOTDOWN_WB]    = "update_shootdown_wb",
>>>> +    [UALINK_TEST_LSDMA_SELFTEST]        = "lsdma_selftest",
>>>> +};
>>>> +
>>>> +static ssize_t amdgpu_debugfs_ualink_command_read(struct file *file,
>>>> +                          char __user *ubuf,
>>>> +                          size_t len, loff_t *offp)
>>>> +{
>>>> +    char buf[UALINK_TEST_CMD_NAME_MAX * 
>>>> ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
>>>> +    unsigned int i;
>>>> +    int n = 0;
>>>> +
>>>> +    for (i = 0; i < ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
>>>> +        n += scnprintf(buf + n, sizeof(buf) - n, "%s\n",
>>>> +                   amdgpu_ualink_test_cmd_name[i]);
>>>> +
>>>> +    return simple_read_from_buffer(ubuf, len, offp, buf, n);
>>>> +}
>>>> +
>>>> +static ssize_t amdgpu_debugfs_ualink_command_write(struct file *file,
>>>> +                           const char __user *ubuf,
>>>> +                           size_t len, loff_t *offp)
>>>> +{
>>>> +    struct amdgpu_device *adev = file->private_data;
>>>> +    char buf[UALINK_TEST_CMD_NAME_MAX];
>>>> +    int cmd, r;
>>>> +
>>>> +    if (len >= sizeof(buf))
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (copy_from_user(buf, ubuf, len))
>>>> +        return -EFAULT;
>>>> +
>>>> +    buf[len] = '\0';
>>>> +    cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name, 
>>>> strim(buf));
>>>> +    if (cmd < 0) {
>>>> +        dev_err(adev->dev, "unknown ualink test command\n");
>>>> +        return cmd;
>>>> +    }
>>>> +
>>>> +    r = amdgpu_debugfs_ualink_test_run(adev, cmd);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>> +    return len;
>>>> +}
>>>> +
>>>> +static const struct file_operations amdgpu_ualink_command_fops = {
>>>> +    .owner     = THIS_MODULE,
>>>> +    .open     = simple_open,
>>>> +    .read     = amdgpu_debugfs_ualink_command_read,
>>>> +    .write     = amdgpu_debugfs_ualink_command_write,
>>>> +    .llseek     = default_llseek,
>>>> +};
>>>> +
>>>> +/* test data buffers, see amdgpu_debugfs_ualink_data_xfer() */
>>>> +enum amdgpu_ualink_test_buf {
>>>> +    UALINK_BUF_LOCAL,
>>>> +    UALINK_BUF_REMOTE_SDMA,
>>>> +    UALINK_BUF_REMOTE_LSDMA,
>>>> +};
>>>> +
>>>> +static int amdgpu_debugfs_ualink_data_xfer(struct amdgpu_device 
>>>> *adev,
>>>> +                       enum amdgpu_ualink_test_buf buf,
>>>> +                       u32 *data, u32 size, bool read)
>>>> +{
>>>> +    u32 remote_accel_id = adev->ualink.test_remote_accel_id;
>>>> +    int r;
>>>> +
>>>> +    if (remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
>>>> +        dev_err(adev->dev, "set remote_accel_id first\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    adev->ualink.selftesting = true;
>>>> +
>>>> +    if (buf == UALINK_BUF_LOCAL)
>>>> +        r = ualink_test_local_data(adev, remote_accel_id, data, 
>>>> size, read);
>>>> +    else
>>>> +        r = ualink_test_remote_rw(adev, remote_accel_id, data, 
>>>> size, read,
>>>> +                      buf == UALINK_BUF_REMOTE_LSDMA);
>>>> +
>>>> +    adev->ualink.selftesting = false;
>>>> +
>>>> +    return r;
>>>> +}
>>>> +
>>>> +static ssize_t amdgpu_debugfs_ualink_data_read(struct file *file,
>>>> +                           char __user *ubuf, size_t len,
>>>> +                           loff_t *offp,
>>>> +                           enum amdgpu_ualink_test_buf buf)
>>>> +{
>>>> +    struct amdgpu_device *adev = file->private_data;
>>>> +    ssize_t ret;
>>>> +    u32 size;
>>>> +    void *data;
>>>> +    int r;
>>>> +
>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>> +
>>>> +    size = adev->ualink.test_size_dwords * 4;
>>>> +
>>>> +    data = kmalloc(size, GFP_KERNEL);
>>>> +    if (!data)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, true);
>>>> +    ret = r ? r : simple_read_from_buffer(ubuf, len, offp, data, 
>>>> size);
>>>> +
>>>> +    kfree(data);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static ssize_t amdgpu_debugfs_ualink_data_write(struct file *file,
>>>> +                        const char __user *ubuf,
>>>> +                        size_t len, loff_t *offp,
>>>> +                        enum amdgpu_ualink_test_buf buf)
>>>> +{
>>>> +    struct amdgpu_device *adev = file->private_data;
>>>> +    u32 i, size;
>>>> +    void *data;
>>>> +    int r;
>>>> +
>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>> +
>>>> +    size = adev->ualink.test_size_dwords * 4;
>>>> +
>>>> +    if (!len)
>>>> +        return -EINVAL;
>>>> +
>>>> +    len = min_t(size_t, len, size);
>>>> +
>>>> +    data = kmalloc(size, GFP_KERNEL);
>>>> +    if (!data)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    if (copy_from_user(data, ubuf, len)) {
>>>> +        kfree(data);
>>>> +        return -EFAULT;
>>>> +    }
>>>> +
>>>> +    /* repeat a short pattern to fill the test size */
>>>> +    for (i = len; i < size; i += len)
>>>> +        memcpy(data + i, data, min_t(u32, len, size - i));
>>>> +
>>>> +    r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, 
>>>> false);
>>>> +
>>>> +    kfree(data);
>>>> +
>>>> +    return r ? r : len;
>>>> +}
>>>> +
>>>> +#define UALINK_TEST_DATA_ATTR(name, buf)                \
>>>> +static ssize_t amdgpu_debugfs_ualink_##name##_read(struct file 
>>>> *file,    \
>>>> +        char __user *ubuf, size_t len, loff_t *offp) \
>>>> +{                                    \
>>>> +    return amdgpu_debugfs_ualink_data_read(file, ubuf, len, offp, 
>>>> buf); \
>>>> +}                                    \
>>>> +static ssize_t amdgpu_debugfs_ualink_##name##_write(struct file 
>>>> *file,    \
>>>> +        const char __user *ubuf, size_t len, loff_t *offp) \
>>>> +{                                    \
>>>> +    return amdgpu_debugfs_ualink_data_write(file, ubuf, len, offp, 
>>>> buf); \
>>>> +}                                    \
>>>> +static const struct file_operations amdgpu_ualink_##name##_fops = 
>>>> {    \
>>>> +    .owner     = THIS_MODULE,                        \
>>>> +    .open     = simple_open,                        \
>>>> +    .read     = amdgpu_debugfs_ualink_##name##_read,            \
>>>> +    .write     = amdgpu_debugfs_ualink_##name##_write, \
>>>> +    .llseek     = default_llseek,                    \
>>>> +}
>>>> +
>>>> +UALINK_TEST_DATA_ATTR(local_test_data, UALINK_BUF_LOCAL);
>>>> +UALINK_TEST_DATA_ATTR(remote_sdma, UALINK_BUF_REMOTE_SDMA);
>>>> +UALINK_TEST_DATA_ATTR(remote_lsdma, UALINK_BUF_REMOTE_LSDMA);
>>>> +
>>>> +static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
>>>> +{
>>>> +    struct amdgpu_device *adev = data;
>>>> +
>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>> +
>>>> +    *val = adev->ualink.test_remote_accel_id;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
>>>> +{
>>>> +    struct amdgpu_device *adev = data;
>>>> +
>>>> +    if (!adev->ualink.info)
>>>> +        return -EOPNOTSUPP;
>>>> +
>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>> +
>>>> +    if (val >= AMDGPU_UALINK_ACCEL_MAX ||
>>>> +        !test_bit(val, adev->ualink.info->vpod.active_accel_bits)) {
>>>> +        dev_err(adev->dev, "invalid remote accel_id %llu\n", val);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (val == adev->ualink.info->ppod.accel_id) {
>>>> +        dev_err(adev->dev, "remote accel_id equals to local 
>>>> accel_id\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    adev->ualink.test_remote_accel_id = val;
>>>> +    dev_info(adev->dev, "set remote accel_id to %llu, local 
>>>> accel_id %u\n",
>>>> +         val, adev->ualink.info->ppod.accel_id);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
>>>> +             amdgpu_debugfs_ualink_accel_id_get,
>>>> +             amdgpu_debugfs_ualink_accel_id_set, "%llu\n");
>>>> +
>>>> +static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
>>>> +{
>>>> +    struct amdgpu_device *adev = data;
>>>> +
>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>> +
>>>> +    *val = adev->ualink.test_size_dwords * 4;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
>>>> +{
>>>> +    struct amdgpu_device *adev = data;
>>>> +
>>>> +    if (val < 4 || val > AMDGPU_UALINK_RB_SIZE)
>>>> +        return -EINVAL;
>>>> +
>>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>>> +
>>>> +    adev->ualink.test_size_dwords = val / 4;
>>>> +    dev_dbg(adev->dev, "test buffer size %u bytes\n",
>>>> +        adev->ualink.test_size_dwords * 4);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
>>>> +             amdgpu_debugfs_ualink_test_size_get,
>>>> +             amdgpu_debugfs_ualink_test_size_set, "%llu\n");
>>>> +
>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>   {
>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>> +    struct dentry *ualink_test;
>>>>       struct dentry *ent;
>>>>       int r, i;
>>>>   @@ -2246,6 +2573,25 @@ int amdgpu_debugfs_init(struct 
>>>> amdgpu_device *adev)
>>>>       debugfs_create_ulong("amdgpu_ualink_drop_msg_bitmap", 0600, 
>>>> root,
>>>>                    &adev->ualink.drop_msg_bitmap);
>>>>   +    mutex_init(&adev->ualink.selftest_mutex);
>>>> +    /* 64 bytes test size by default */
>>>> +    adev->ualink.test_size_dwords = 16;
>>>> +    adev->ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
>>>> +
>>>> +    ualink_test = debugfs_create_dir("amdgpu_ualink_test", root);
>>>> +    debugfs_create_file("command", 0600, ualink_test, adev,
>>>> +                &amdgpu_ualink_command_fops);
>>>> +    debugfs_create_file("remote_accel_id", 0600, ualink_test, adev,
>>>> +                &amdgpu_ualink_accel_id_fops);
>>>> +    debugfs_create_file("test_size", 0600, ualink_test, adev,
>>>> +                &amdgpu_ualink_test_size_fops);
>>>> +    debugfs_create_file("local_test_data", 0600, ualink_test, adev,
>>>> +                &amdgpu_ualink_local_test_data_fops);
>>>> +    debugfs_create_file("remote_sdma", 0600, ualink_test, adev,
>>>> +                &amdgpu_ualink_remote_sdma_fops);
>>>> +    debugfs_create_file("remote_lsdma", 0600, ualink_test, adev,
>>>> +                &amdgpu_ualink_remote_lsdma_fops);
>>>> +
>>>>       adev->debugfs_vbios_blob.data = adev->bios;
>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>       debugfs_create_blob("amdgpu_vbios", 0444, root,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>>> index 05bc281216bf..1f83d9b69135 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>>> @@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device 
>>>> *adev,
>>>>       mutex_unlock(&adev->lsdma.lock);
>>>>       return ret;
>>>>   }
>>>> +
>>>> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
>>>> +{
>>>> +    struct amdgpu_ib ib;
>>>> +    int i, r;
>>>> +    u64 gpu_addr;
>>>> +    char *p;
>>>> +    u32 size = 128;
>>>> +
>>>> +    memset(&ib, 0, sizeof(ib));
>>>> +    r = amdgpu_ib_get(adev, NULL, 2 * size, AMDGPU_IB_POOL_DIRECT, 
>>>> &ib);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>> +    gpu_addr = ib.gpu_addr;
>>>> +    p = (char *)ib.ptr;
>>>> +    memset(p, 0, 2 * size);
>>>> +
>>>> +    for (i = 0; i < size; i++)
>>>> +        *(p + i) = i;
>>>> +
>>>> +    dev_dbg(adev->dev, "copy src 0x%llx dst 0x%llx size %d bytes\n",
>>>> +        gpu_addr, gpu_addr + size, size);
>>>> +
>>>> +    r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, size);
>>>> +    if (r)
>>>> +        goto out;
>>>> +
>>>> +    p += size;
>>>> +    for (i = 0; i < size; i++) {
>>>> +        if (*(p + i) != i) {
>>>> +            dev_dbg(adev->dev, "data mismatch expecting 0x%x but 
>>>> read 0x%x\n",
>>>> +                i, *(p + i));
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +    if (i != size)
>>>> +        r = -EIO;
>>>> +
>>>> +out:
>>>> +    amdgpu_ib_free(&ib, NULL);
>>>> +
>>>> +    if (r)
>>>> +        dev_dbg(adev->dev, "lsdma selftest failed r=%d\n", r);
>>>> +    else
>>>> +        dev_dbg(adev->dev, "lsdma selftest passed\n");
>>>> +
>>>> +    return r;
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>>> index 34e92aaa4617..f0a5eeb3529f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>>> @@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device 
>>>> *adev, uint64_t dst_addr,
>>>>                 uint32_t data, uint64_t mem_size);
>>>>   int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t 
>>>> reg_index,
>>>>                 uint32_t reg_val, uint32_t mask);
>>>> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
>>>>     #endif
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> index 339f639a450e..86e0dc8d728e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> @@ -39,8 +39,6 @@ static void deactivate_accelerator(struct 
>>>> amdgpu_device *adev);
>>>>   static int amdgpu_ualink_remote_interrupt(struct amdgpu_device 
>>>> *adev,
>>>>                   u32 remote_accel_id, u32 dw0, u32 dw1,
>>>>                   u32 dw2, u32 dw3);
>>>> -static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev,
>>>> -                    u32 flush_type);
>>>>   static int amdgpu_ualink_reserve_npa_vm_and_bos(struct 
>>>> amdgpu_device *adev,
>>>>                           struct amdgpu_bo *bos[], u32 n_bos,
>>>>                           struct drm_exec *exec,
>>>> @@ -4333,9 +4331,6 @@ void amdgpu_ualink_manager_stop(struct 
>>>> amdgpu_device *adev)
>>>>    * UALink remote interrupt and shootdown
>>>>    */
>>>>   -/* UALINK ring buffer size, same for both remote shootdown and 
>>>> interrupt ring */
>>>> -#define AMDGPU_UALINK_RB_SIZE    4096
>>>> -
>>>>   #define AMDGPU_UALINK_METADATA_HEADER    0x4E485446
>>>>     /* 2MB NPA start address for 2MB page mapping */
>>>> @@ -4582,7 +4577,7 @@ static inline u32 ualink_tlb_wb_offset(struct 
>>>> amdgpu_device *adev, u32 accel_id)
>>>>       return ualink_wb_offset(adev, accel_id) + sizeof(struct 
>>>> amdgpu_ualink_wb);
>>>>   }
>>>>   -static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, 
>>>> u32 flush_type)
>>>> +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 
>>>> flush_type)
>>>>   {
>>>>       u32 bit;
>>>>   @@ -5281,7 +5276,8 @@ static int 
>>>> amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>>>       if (status != AMDGPU_NHT_FW_ST_PREINIT &&
>>>>           status != AMDGPU_NHT_FW_ST_HALT) {
>>>>           dev_dbg(adev->dev, "fw status 0x%x not preinit or 
>>>> halt\n", status);
>>>> -        return -ENODEV;
>>>> +        if (!adev->ualink.selftesting)
>>>> +            return -ENODEV;
>>>>       }
>>>>         dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 
>>>> 0x%x\n",
>>>> @@ -5399,6 +5395,8 @@ static int amdgpu_ualink_metadata_init(struct 
>>>> amdgpu_device *adev)
>>>>       r = adev->ualink.msg_ctl->send_metadata(adev,
>>>>                               remote->metadata_gpu_addr,
>>>>                               AMDGPU_UALINK_ACCEL_MAX << 8);
>>>> +    if (r && adev->ualink.selftesting)
>>>> +        r = 0;
>>>>     out:
>>>>       if (r)
>>>> @@ -6384,11 +6382,216 @@ void amdgpu_ualink_sw_fini(struct 
>>>> amdgpu_device *adev)
>>>>       adev->ualink.remote = NULL;
>>>>   }
>>>>   -int ualink_send_hello(struct amdgpu_device *adev, u32 
>>>> remote_accel_id)
>>>> +/* byte offset of the local interrupt ring a remote GPU writes to */
>>>> +static u32 ualink_test_local_rb_offset(u32 remote_accel_id)
>>>> +{
>>>> +    u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>>>> +
>>>> +    /* remote shootdown ring is first, remote interrupt ring 
>>>> follows it */
>>>> +    return rb_size * remote_accel_id + AMDGPU_UALINK_RB_SIZE;
>>>> +}
>>>> +
>>>> +/*
>>>> + * ualink_test_local_data - read or write the local ring buffer of 
>>>> a remote GPU
>>>> + *
>>>> + * The local ring buffer is partitioned per remote GPU, 
>>>> @remote_accel_id selects
>>>> + * the interrupt ring that remote GPU writes to through its NPA 
>>>> mapping. Read it
>>>> + * to see what the remote GPU wrote, write it to provide the data 
>>>> it reads.
>>>> + */
>>>> +int ualink_test_local_data(struct amdgpu_device *adev, u32 
>>>> remote_accel_id,
>>>> +               void *data, u32 size, bool read)
>>>>   {
>>>> +    struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>> +    void *rb;
>>>> +
>>>> +    if (!remote || !remote->rb_cpu_addr)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (size > AMDGPU_UALINK_RB_SIZE)
>>>> +        return -EINVAL;
>>>> +
>>>> +    rb = remote->rb_cpu_addr + 
>>>> ualink_test_local_rb_offset(remote_accel_id);
>>>> +
>>>> +    dev_dbg(adev->dev, "%s local rb of remote %u at 0x%p size 
>>>> 0x%x\n",
>>>> +        read ? "read" : "write", remote_accel_id, rb, size);
>>>> +
>>>> +    if (read)
>>>> +        memcpy(data, rb, size);
>>>> +    else
>>>> +        memcpy(rb, data, size);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * ualink_test_remote_rw - read or write the remote GPU ring buffer
>>>> + *
>>>> + * Copy @size bytes between @data and the remote GPU ring buffer 
>>>> NPA address
>>>> + * using lsdma or sdma. The DMA engines cannot access @data, the 
>>>> local ring
>>>> + * buffer of the same remote GPU is used to stage it, so 
>>>> local_test_data shows
>>>> + * what was sent or received.
>>>> + *
>>>> + * Works with or without MPNHT FW running, the copy does not 
>>>> update wptr and
>>>> + * does not ring the doorbell.
>>>> + */
>>>> +int ualink_test_remote_rw(struct amdgpu_device *adev, u32 
>>>> remote_accel_id,
>>>> +              void *data, u32 size, bool read, bool use_lsdma)
>>>> +{
>>>> +    struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>> +    struct amdgpu_ualink_peer *peer;
>>>> +    struct amdgpu_ualink_ring *ring;
>>>> +    struct dma_fence *fence;
>>>> +    struct amdgpu_job *job;
>>>> +    struct amdgpu_ib *ib;
>>>> +    u64 npa, local;
>>>> +    u32 offset, ndw;
>>>> +    int r;
>>>> +
>>>> +    if (!remote)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (size > AMDGPU_UALINK_RB_SIZE)
>>>> +        return -EINVAL;
>>>> +
>>>> +    peer = &remote->peer[remote_accel_id];
>>>> +    ring = &peer->interrupt;
>>>> +
>>>> +    guard(mutex)(&peer->lock);
>>>> +
>>>> +    offset = ualink_test_local_rb_offset(remote_accel_id);
>>>> +    local = remote->rb_gpu_addr + offset;
>>>> +    npa = ring->rb_npa_gart;
>>>> +
>>>> +    if (!read)
>>>> +        memcpy(remote->rb_cpu_addr + offset, data, size);
>>>> +
>>>> +    remote->use_lsdma = use_lsdma;
>>>> +
>>>> +    dev_dbg(adev->dev, "%s remote %u npa 0x%llx local 0x%llx size 
>>>> 0x%x use %s\n",
>>>> +        read ? "read" : "write", remote_accel_id, npa, local, size,
>>>> +        use_lsdma ? "lsdma" : "sdma");
>>>> +
>>>> +    if (use_lsdma) {
>>>> +        r = amdgpu_lsdma_copy_mem(adev, read ? npa : local,
>>>> +                      read ? local : npa, size);
>>>> +        if (r)
>>>> +            return r;
>>>> +
>>>> +        goto done;
>>>> +    }
>>>> +
>>>> +    /* sdma linear copy command, align to 8 dwords boundary */
>>>> +    ndw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>>>> +
>>>> +    r = amdgpu_job_alloc_with_ib(adev, &peer->entity, 
>>>> AMDGPU_FENCE_OWNER_VM,
>>>> +                     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>>> +                     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>> +    ib = job->ibs;
>>>> +    ib->length_dw = 0;
>>>> +
>>>> +    amdgpu_emit_copy_buffer(adev, ib, read ? npa : local,
>>>> +                read ? local : npa, size, 0);
>>>> +    amdgpu_ring_pad_ib(&adev->sdma.instance[0].ring, ib);
>>>> +    WARN_ON(ib->length_dw > ndw);
>>>> +
>>>> +    fence = amdgpu_job_submit(job);
>>>> +
>>>> +    r = dma_fence_wait_timeout(fence, false, HZ * 10);
>>>> +    dma_fence_put(fence);
>>>> +    if (r <= 0) {
>>>> +        dev_dbg(adev->dev, "remote sdma fence wait timeout %d\n", r);
>>>> +        dev_dbg(adev->dev, "use lsdma for testing afterwards\n");
>>>> +        remote->use_lsdma = true;
>>>> +        return -ETIME;
>>>> +    }
>>>> +
>>>> +done:
>>>> +    if (read)
>>>> +        memcpy(data, remote->rb_cpu_addr + offset, size);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/* The peer may have rebooted or the vpod was reconfigured, adopt 
>>>> the remote
>>>> + * wptr before sending a command, same as the handshake does.
>>>> + */
>>>> +static int ualink_test_resync_peer(struct amdgpu_device *adev, u32 
>>>> remote_accel_id)
>>>> +{
>>>> +    int r;
>>>> +
>>>> +    if (!adev->ualink.remote)
>>>> +        return -EINVAL;
>>>> +
>>>> +    r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
>>>> +    if (r < 0)
>>>> +        return r;
>>>> +
>>>> +    /* Peer moved, drop ready so the next command updates the wb 
>>>> address */
>>>> +    if (r)
>>>> +        amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int ualink_test_send_hello(struct amdgpu_device *adev, u32 
>>>> remote_accel_id)
>>>> +{
>>>> +    int r;
>>>> +
>>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>>       return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
>>>>   }
>>>>   +int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 
>>>> remote_accel_id,
>>>> +                 u64 addr, u32 size_in_pages, u32 flush_type)
>>>> +{
>>>> +    int r;
>>>> +
>>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>> +    return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, 
>>>> addr,
>>>> +                          size_in_pages, flush_type);
>>>> +}
>>>> +
>>>> +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, 
>>>> u32 remote_accel_id)
>>>> +{
>>>> +    int r;
>>>> +
>>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>> + guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
>>>> +
>>>> +    /* Update interrupt completion write back address */
>>>> +    r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>>> +                        RB_TYPE_REMOTE_INTERRUPT);
>>>> +    return r;
>>>> +}
>>>> +
>>>> +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, 
>>>> u32 remote_accel_id)
>>>> +{
>>>> +    int r;
>>>> +
>>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>> + guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
>>>> +
>>>> +    /* Update shootdown completion write back address */
>>>> +    r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>>> +                        RB_TYPE_TLB_INV);
>>>> +    return r;
>>>> +}
>>>> +
>>>>   /*
>>>>    * The low bits of handle_lo carry the message-header field on 
>>>> the wire.
>>>>    * Strip those bits and splice in @acc_id to recover the
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>>> index 85c9a9634a4b..90e90cd8b495 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>>> @@ -310,6 +310,9 @@ struct amdgpu_ualink_connection {
>>>>       enum amdgpu_ualink_conn_state state;
>>>>   };
>>>>   +/* UALINK ring buffer size, same for both remote shootdown and 
>>>> interrupt ring */
>>>> +#define AMDGPU_UALINK_RB_SIZE    4096
>>>> +
>>>>   struct amdgpu_ualink_remote;
>>>>     struct amdgpu_ualink_msg_ctl {
>>>> @@ -333,6 +336,13 @@ struct amdgpu_ualink_mgr {
>>>>       /* For remote interrupt and shootdown */
>>>>       struct amdgpu_ualink_remote *remote;
>>>>   +    /* true for selftest driver path, ignore FW error */
>>>> +    bool selftesting;
>>>> +    /* serialize the selftest debugfs entries */
>>>> +    struct mutex selftest_mutex;
>>>> +    u32 test_size_dwords;
>>>> +    u32 test_remote_accel_id;
>>>> +
>>>>       /* handle irq from ualink client of remote GPUs */
>>>>       struct amdgpu_irq_src irq;
>>>>   @@ -390,14 +400,22 @@ struct amdgpu_ualink_mgr {
>>>>       unsigned long drop_msg_bitmap;
>>>>   };
>>>>   +int ualink_test_local_data(struct amdgpu_device *adev, u32 
>>>> remote_accel_id,
>>>> +               void *data, u32 size, bool read);
>>>> +int ualink_test_remote_rw(struct amdgpu_device *adev, u32 
>>>> remote_accel_id,
>>>> +              void *data, u32 size, bool read, bool use_lsdma);
>>>> +int ualink_test_send_hello(struct amdgpu_device *adev, u32 
>>>> remote_accel_id);
>>>> +int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 
>>>> remote_accel_id,
>>>> +                 u64 addr, u32 size_in_pages, u32 flush_type);
>>>> +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, 
>>>> u32 remote_accel_id);
>>>> +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, 
>>>> u32 remote_accel_id);
>>>> +
>>>>   int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
>>>>                    unsigned int client_id, unsigned int src_id);
>>>> -
>>>> +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 
>>>> flush_type);
>>>>   int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
>>>>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
>>>>   -int ualink_send_hello(struct amdgpu_device *adev, u32 
>>>> remote_accel_id);
>>>> -
>>>>   int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev);
>>>>   int amdgpu_ualink_pause_handler(struct amdgpu_device *adev);
>>>>   int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
>>

--------------sGCW5DCotGZfVPo0BNpIfDAR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-10-28 17:36, Kuehling, Felix
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:7a63c005-8d95-497e-bf4f-00a80688e732@amd.com">
      <br>
      On 2026-10-28 15:36, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2026-10-28 14:24, Kuehling, Felix wrote:
        <br>
        <blockquote type="cite">On 2026-10-23 16:34, Philip Yang wrote:
          <br>
          <blockquote type="cite">Driver-side selftests for UALink
            bring-up: exercise the nHT firmware,
            <br>
            remote interrupts, remote TLB shootdown and remote VRAM
            access without
            <br>
            any userspace application.
            <br>
            <br>
            Add debugfs directory &quot;amdgpu_ualink_test&quot; to trigger UALink
            selftests
            <br>
            with these read/write entries:
            <br>
            <br>
            &nbsp;&nbsp; command&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write the test name to run it, read to
            list the
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; valid test names
            <br>
            &nbsp;&nbsp; remote_accel_id&nbsp; accel_id of the remote GPU used by the
            tests
            <br>
            &nbsp;&nbsp; test_size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test buffer size in bytes, from 4 to
            4096
            <br>
            &nbsp;&nbsp; local_test_data&nbsp; the local ring buffer the remote GPU
            accesses
            <br>
            &nbsp;&nbsp; remote_sdma&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the remote GPU ring buffer, using sdma
            <br>
            &nbsp;&nbsp; remote_lsdma&nbsp;&nbsp;&nbsp;&nbsp; the remote GPU ring buffer, using lsdma
            <br>
            <br>
            The data entries take and return binary data, a write
            shorter than
            <br>
            test_size is repeated to fill it, so formatting is left to
            userspace
            <br>
            tools like printf, xxd, od and cmp.
            <br>
            <br>
            Add helper functions: ualink_test_local_data() and
            <br>
            ualink_test_remote_rw() for local and remote ring buffer
            R/W,
            <br>
            ualink_test_remote_shootdown() for TLB shootdown,
            <br>
            ualink_test_send_hello() for handshake,
            <br>
            ualink_test_update_interrupt_wb() and
            <br>
            ualink_test_update_shootdown_wb() to read writeback results.
            <br>
            <br>
            v6: ring buffer wptr for itself is used for wptr, don't init
            to 0xdeadbeef
            <br>
          </blockquote>
          <br>
          I don't see this change. What exactly did you change? I only
          see the removal of deadbeef init. I don't see any change
          regarding which ring buffer is used to stage the data for
          remote read/write.
          <br>
        </blockquote>
        The remote ring buffer was initialised to 0xdeadbeef for the
        selftest. In address-aliasing mode the wptr for every remote
        uses that same ring buffer page for itself accel_id, so the
        remote wptr resync read back 0xdeadbeef and synced the wptr to
        that value, which left the remote firmware in a bad state. I
        have removed the ring buffer initialisation.
        ualink_test_resync_peer() also change to only resync wptr for
        the first command or if peer rebooted.
        <br>
      </blockquote>
      <br>
      OK. I was asking for an additional change in v5 that I thought you
      were addressing here, but didn't.
      <br>
      <br>
      The remote write first writes data to local memory before copying
      it to remote. E.g. remote write from A to B overwrites local
      memory in A. A remote write from B to A writes the same memory in
      A. Now a tester reading local_test_data from debugfs doesn't know
      whether that was written by the remote GPU or by a previous local
      read/write to remote_sdma or remote_lsdma.
      <br>
      <br>
      Therefore, I would like to keep those separate. A write from A to
      B should not overwrite the same memory on A as a write from B to
      A. Similar for remote reads. A remote read by A from B should not
      overwrite the same memory on A that is also accessed remotely by
      B.
      <br>
      <br>
      I proposed using a different offset for the staging memory in
      ualink_test_remote_rw. Instead of using remote_accel_id in offset
      = ualink_test_local_rb_offset(remote_accel_id), use the GPU's own
      accelerator ID.&nbsp;<br>
    </blockquote>
    That won't work, unfortunately. The local accelerator's own slot in
    the ring buffer is where the remotes write their wptr — so every
    remote's wptr for this GPU lands in slot(local_accel_id). Using it
    for staging would corrupt the wptr resync and we'd read back
    garbage. This is the same aliasing that caused the 0xdeadbeef
    problem we just fixed.<br>
    <br>
    On the ambiguity itself — you're right that A can't distinguish its
    own staging data from what B wrote. But the verification in these
    tests is always done on the opposite side, so it doesn't affect the
    intended flows:<br>
    <br>
    A writes to B over lsdma, then B reads local_test_data to verify.
    A's own local_test_data happens to hold the same bytes, but nothing
    checks it there.<br>
    B writes to its local_test_data, then A reads it back over lsdma and
    verifies.<br>
    A writes to B and reads back from B, verifying the round trip.<br>
    So the data is always checked where it is unambiguous. I'll document
    this in the commit message so the intent is clear.<br>
    <br>
    If you'd still prefer them physically separated, the clean way is to
    alloc sdma job with extra IB buffer, happy to do it&nbsp; if you think
    it's worth the extra allocation.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:7a63c005-8d95-497e-bf4f-00a80688e732@amd.com"><br>
      Does that make sense?
      <br>
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        Philip
        <br>
        <blockquote type="cite">
          <br>
          Regards,
          <br>
          &nbsp; Felix
          <br>
          <br>
          <br>
          <blockquote type="cite">v5: Replace the four remote access
            commands with local_test_data,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; remote_sdma and remote_lsdma entries, to get the test
            data without
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; looking at debug logs or using xxd with physical
            addresses (Felix).
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; Dump and accept binary data, no parser in the driver
            (Felix).
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; Stage the DMA in the local ring buffer instead of the
            IB, which is
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; freed before the data is read back.
            <br>
            v4: Use a single &quot;command&quot; entry taking the test name,
            instead of one
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; entry per test (Felix).
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; Resync the remote wptr before sending a command, the
            peer may have
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; rebooted.
            <br>
            v3: Replace the single entry taking a test number with a
            debugfs
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; directory and a named entry per command.
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; Take peer-&gt;lock to update the writeback address and
            selftest_mutex
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; to read the test parameters.
            <br>
            v2: Fix typos and issues from copilot code review.
            <br>
            <br>
            Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 346
            ++++++++++++++++++++
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c&nbsp;&nbsp; |&nbsp; 49 +++
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h&nbsp;&nbsp; |&nbsp;&nbsp; 1 +
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c&nbsp; | 219
            ++++++++++++-
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h&nbsp; |&nbsp; 24 +-
            <br>
            &nbsp; 5 files changed, 628 insertions(+), 11 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
            <br>
            index 3dc95d9accf2..2d786639d081 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
            <br>
            @@ -2133,9 +2133,336 @@
            DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
            <br>
            &nbsp; DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_sclk_set, &quot;%llu\n&quot;);
            <br>
            &nbsp; +enum amdgpu_ualink_test_cmd {
            <br>
            +&nbsp;&nbsp;&nbsp; UALINK_TEST_SW_INIT,
            <br>
            +&nbsp;&nbsp;&nbsp; UALINK_TEST_SEND_HELLO,
            <br>
            +&nbsp;&nbsp;&nbsp; UALINK_TEST_REMOTE_SHOOTDOWN,
            <br>
            +&nbsp;&nbsp;&nbsp; UALINK_TEST_FLUSH_TLB,
            <br>
            +&nbsp;&nbsp;&nbsp; UALINK_TEST_UPDATE_INTERRUPT_WB,
            <br>
            +&nbsp;&nbsp;&nbsp; UALINK_TEST_UPDATE_SHOOTDOWN_WB,
            <br>
            +&nbsp;&nbsp;&nbsp; UALINK_TEST_LSDMA_SELFTEST,
            <br>
            +};
            <br>
            +
            <br>
            +/* commands talking to a remote accelerator,
            remote_accel_id must be set */
            <br>
            +#define UALINK_TEST_NEEDS_ACCEL_ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
            <br>
            +&nbsp;&nbsp;&nbsp; (BIT(UALINK_TEST_SEND_HELLO) |
            BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            \
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
            <br>
            +
            <br>
            +static int amdgpu_debugfs_ualink_test_run(struct
            amdgpu_device *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ualink_test_cmd cmd)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; u32 remote_accel_id =
            adev-&gt;ualink.test_remote_accel_id;
            <br>
            +&nbsp;&nbsp;&nbsp; int r = 0;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if ((BIT(cmd) &amp; UALINK_TEST_NEEDS_ACCEL_ID)
            &amp;&amp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id &gt;= AMDGPU_UALINK_ACCEL_MAX) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;set remote_accel_id
            first\n&quot;);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.selftesting = true;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; switch (cmd) {
            <br>
            +&nbsp;&nbsp;&nbsp; case UALINK_TEST_SW_INIT:
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ualink.remote)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_sw_fini(adev);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;load metadata init MPNHT
            firmware\n&quot;);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_sw_init(adev);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            +&nbsp;&nbsp;&nbsp; case UALINK_TEST_SEND_HELLO:
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_send_hello(adev, remote_accel_id);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            +&nbsp;&nbsp;&nbsp; case UALINK_TEST_REMOTE_SHOOTDOWN:
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_remote_shootdown(adev,
            remote_accel_id, 1UL &lt;&lt; 30,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1, TLB_FLUSH_HEAVYWEIGHT);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            +&nbsp;&nbsp;&nbsp; case UALINK_TEST_FLUSH_TLB:
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_flush_tlb(adev,
            TLB_FLUSH_HEAVYWEIGHT);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            +&nbsp;&nbsp;&nbsp; case UALINK_TEST_UPDATE_INTERRUPT_WB:
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_update_interrupt_wb(adev,
            remote_accel_id);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            +&nbsp;&nbsp;&nbsp; case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_update_shootdown_wb(adev,
            remote_accel_id);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            +&nbsp;&nbsp;&nbsp; case UALINK_TEST_LSDMA_SELFTEST:
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = adev-&gt;lsdma.funcs ?
            amdgpu_lsdma_selftest(adev) : -EOPNOTSUPP;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.selftesting = false;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;ualink test cmd %d
            remote_accel_id %u ret %d\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd, remote_accel_id, r);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return r;
            <br>
            +}
            <br>
            +
            <br>
            +#define UALINK_TEST_CMD_NAME_MAX&nbsp;&nbsp;&nbsp; 32
            <br>
            +
            <br>
            +static const char * const amdgpu_ualink_test_cmd_name[] = {
            <br>
            +&nbsp;&nbsp;&nbsp; [UALINK_TEST_SW_INIT]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;sw_init&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp; [UALINK_TEST_SEND_HELLO]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;send_hello&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp; [UALINK_TEST_REMOTE_SHOOTDOWN]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
            &quot;remote_shootdown&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp; [UALINK_TEST_FLUSH_TLB]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;flush_tlb&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp; [UALINK_TEST_UPDATE_INTERRUPT_WB]&nbsp;&nbsp;&nbsp; =
            &quot;update_interrupt_wb&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp; [UALINK_TEST_UPDATE_SHOOTDOWN_WB]&nbsp;&nbsp;&nbsp; =
            &quot;update_shootdown_wb&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp; [UALINK_TEST_LSDMA_SELFTEST]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;lsdma_selftest&quot;,
            <br>
            +};
            <br>
            +
            <br>
            +static ssize_t amdgpu_debugfs_ualink_command_read(struct
            file *file,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char __user *ubuf,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len, loff_t *offp)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; char buf[UALINK_TEST_CMD_NAME_MAX *
            ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
            <br>
            +&nbsp;&nbsp;&nbsp; unsigned int i;
            <br>
            +&nbsp;&nbsp;&nbsp; int n = 0;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
            ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n += scnprintf(buf + n, sizeof(buf) - n, &quot;%s\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_test_cmd_name[i]);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return simple_read_from_buffer(ubuf, len, offp, buf,
            n);
            <br>
            +}
            <br>
            +
            <br>
            +static ssize_t amdgpu_debugfs_ualink_command_write(struct
            file *file,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char __user *ubuf,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len, loff_t *offp)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = file-&gt;private_data;
            <br>
            +&nbsp;&nbsp;&nbsp; char buf[UALINK_TEST_CMD_NAME_MAX];
            <br>
            +&nbsp;&nbsp;&nbsp; int cmd, r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (len &gt;= sizeof(buf))
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (copy_from_user(buf, ubuf, len))
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; buf[len] = '\0';
            <br>
            +&nbsp;&nbsp;&nbsp; cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name,
            strim(buf));
            <br>
            +&nbsp;&nbsp;&nbsp; if (cmd &lt; 0) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;unknown ualink test
            command\n&quot;);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return cmd;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_debugfs_ualink_test_run(adev, cmd);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return len;
            <br>
            +}
            <br>
            +
            <br>
            +static const struct file_operations
            amdgpu_ualink_command_fops = {
            <br>
            +&nbsp;&nbsp;&nbsp; .owner&nbsp;&nbsp;&nbsp;&nbsp; = THIS_MODULE,
            <br>
            +&nbsp;&nbsp;&nbsp; .open&nbsp;&nbsp;&nbsp;&nbsp; = simple_open,
            <br>
            +&nbsp;&nbsp;&nbsp; .read&nbsp;&nbsp;&nbsp;&nbsp; = amdgpu_debugfs_ualink_command_read,
            <br>
            +&nbsp;&nbsp;&nbsp; .write&nbsp;&nbsp;&nbsp;&nbsp; = amdgpu_debugfs_ualink_command_write,
            <br>
            +&nbsp;&nbsp;&nbsp; .llseek&nbsp;&nbsp;&nbsp;&nbsp; = default_llseek,
            <br>
            +};
            <br>
            +
            <br>
            +/* test data buffers, see amdgpu_debugfs_ualink_data_xfer()
            */
            <br>
            +enum amdgpu_ualink_test_buf {
            <br>
            +&nbsp;&nbsp;&nbsp; UALINK_BUF_LOCAL,
            <br>
            +&nbsp;&nbsp;&nbsp; UALINK_BUF_REMOTE_SDMA,
            <br>
            +&nbsp;&nbsp;&nbsp; UALINK_BUF_REMOTE_LSDMA,
            <br>
            +};
            <br>
            +
            <br>
            +static int amdgpu_debugfs_ualink_data_xfer(struct
            amdgpu_device *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ualink_test_buf buf,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *data, u32 size, bool read)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; u32 remote_accel_id =
            adev-&gt;ualink.test_remote_accel_id;
            <br>
            +&nbsp;&nbsp;&nbsp; int r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (remote_accel_id &gt;= AMDGPU_UALINK_ACCEL_MAX) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;set remote_accel_id
            first\n&quot;);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.selftesting = true;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (buf == UALINK_BUF_LOCAL)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_local_data(adev, remote_accel_id,
            data, size, read);
            <br>
            +&nbsp;&nbsp;&nbsp; else
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_remote_rw(adev, remote_accel_id,
            data, size, read,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf == UALINK_BUF_REMOTE_LSDMA);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.selftesting = false;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return r;
            <br>
            +}
            <br>
            +
            <br>
            +static ssize_t amdgpu_debugfs_ualink_data_read(struct file
            *file,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char __user *ubuf, size_t len,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loff_t *offp,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ualink_test_buf buf)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = file-&gt;private_data;
            <br>
            +&nbsp;&nbsp;&nbsp; ssize_t ret;
            <br>
            +&nbsp;&nbsp;&nbsp; u32 size;
            <br>
            +&nbsp;&nbsp;&nbsp; void *data;
            <br>
            +&nbsp;&nbsp;&nbsp; int r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; size = adev-&gt;ualink.test_size_dwords * 4;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; data = kmalloc(size, GFP_KERNEL);
            <br>
            +&nbsp;&nbsp;&nbsp; if (!data)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data,
            size, true);
            <br>
            +&nbsp;&nbsp;&nbsp; ret = r ? r : simple_read_from_buffer(ubuf, len, offp,
            data, size);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; kfree(data);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return ret;
            <br>
            +}
            <br>
            +
            <br>
            +static ssize_t amdgpu_debugfs_ualink_data_write(struct file
            *file,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char __user *ubuf,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len, loff_t *offp,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ualink_test_buf buf)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = file-&gt;private_data;
            <br>
            +&nbsp;&nbsp;&nbsp; u32 i, size;
            <br>
            +&nbsp;&nbsp;&nbsp; void *data;
            <br>
            +&nbsp;&nbsp;&nbsp; int r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; size = adev-&gt;ualink.test_size_dwords * 4;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (!len)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; len = min_t(size_t, len, size);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; data = kmalloc(size, GFP_KERNEL);
            <br>
            +&nbsp;&nbsp;&nbsp; if (!data)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (copy_from_user(data, ubuf, len)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(data);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* repeat a short pattern to fill the test size */
            <br>
            +&nbsp;&nbsp;&nbsp; for (i = len; i &lt; size; i += len)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(data + i, data, min_t(u32, len, size - i));
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data,
            size, false);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; kfree(data);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return r ? r : len;
            <br>
            +}
            <br>
            +
            <br>
            +#define UALINK_TEST_DATA_ATTR(name, buf)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
            <br>
            +static ssize_t amdgpu_debugfs_ualink_##name##_read(struct
            file *file,&nbsp;&nbsp;&nbsp; \
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char __user *ubuf, size_t len, loff_t *offp)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            \
            <br>
            +{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
            <br>
            +&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_ualink_data_read(file, ubuf, len,
            offp, buf); \
            <br>
            +}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
            <br>
            +static ssize_t amdgpu_debugfs_ualink_##name##_write(struct
            file *file,&nbsp;&nbsp;&nbsp; \
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char __user *ubuf, size_t len, loff_t *offp)
            \
            <br>
            +{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
            <br>
            +&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_ualink_data_write(file, ubuf,
            len, offp, buf); \
            <br>
            +}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
            <br>
            +static const struct file_operations
            amdgpu_ualink_##name##_fops = {&nbsp;&nbsp;&nbsp; \
            <br>
            +&nbsp;&nbsp;&nbsp; .owner&nbsp;&nbsp;&nbsp;&nbsp; = THIS_MODULE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
            <br>
            +&nbsp;&nbsp;&nbsp; .open&nbsp;&nbsp;&nbsp;&nbsp; = simple_open,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
            <br>
            +&nbsp;&nbsp;&nbsp; .read&nbsp;&nbsp;&nbsp;&nbsp; =
            amdgpu_debugfs_ualink_##name##_read,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
            <br>
            +&nbsp;&nbsp;&nbsp; .write&nbsp;&nbsp;&nbsp;&nbsp; = amdgpu_debugfs_ualink_##name##_write, \
            <br>
            +&nbsp;&nbsp;&nbsp; .llseek&nbsp;&nbsp;&nbsp;&nbsp; = default_llseek,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
            <br>
            +}
            <br>
            +
            <br>
            +UALINK_TEST_DATA_ATTR(local_test_data, UALINK_BUF_LOCAL);
            <br>
            +UALINK_TEST_DATA_ATTR(remote_sdma, UALINK_BUF_REMOTE_SDMA);
            <br>
            +UALINK_TEST_DATA_ATTR(remote_lsdma,
            UALINK_BUF_REMOTE_LSDMA);
            <br>
            +
            <br>
            +static int amdgpu_debugfs_ualink_accel_id_get(void *data,
            u64 *val)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = data;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; *val = adev-&gt;ualink.test_remote_accel_id;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +}
            <br>
            +
            <br>
            +static int amdgpu_debugfs_ualink_accel_id_set(void *data,
            u64 val)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = data;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (!adev-&gt;ualink.info)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (val &gt;= AMDGPU_UALINK_ACCEL_MAX ||
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !test_bit(val,
            adev-&gt;ualink.info-&gt;vpod.active_accel_bits)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;invalid remote accel_id
            %llu\n&quot;, val);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (val == adev-&gt;ualink.info-&gt;ppod.accel_id) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;remote accel_id equals to
            local accel_id\n&quot;);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.test_remote_accel_id = val;
            <br>
            +&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;set remote accel_id to %llu,
            local accel_id %u\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val, adev-&gt;ualink.info-&gt;ppod.accel_id);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +}
            <br>
            +
            <br>
            +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_ualink_accel_id_get,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_ualink_accel_id_set, &quot;%llu\n&quot;);
            <br>
            +
            <br>
            +static int amdgpu_debugfs_ualink_test_size_get(void *data,
            u64 *val)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = data;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; *val = adev-&gt;ualink.test_size_dwords * 4;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +}
            <br>
            +
            <br>
            +static int amdgpu_debugfs_ualink_test_size_set(void *data,
            u64 val)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = data;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (val &lt; 4 || val &gt; AMDGPU_UALINK_RB_SIZE)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.test_size_dwords = val / 4;
            <br>
            +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;test buffer size %u bytes\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ualink.test_size_dwords * 4);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +}
            <br>
            +
            <br>
            +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_ualink_test_size_get,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_ualink_test_size_set,
            &quot;%llu\n&quot;);
            <br>
            +
            <br>
            &nbsp; int amdgpu_debugfs_init(struct amdgpu_device *adev)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *root =
            adev_to_drm(adev)-&gt;primary-&gt;debugfs_root;
            <br>
            +&nbsp;&nbsp;&nbsp; struct dentry *ualink_test;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *ent;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;
            <br>
            &nbsp; @@ -2246,6 +2573,25 @@ int amdgpu_debugfs_init(struct
            amdgpu_device *adev)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_ulong(&quot;amdgpu_ualink_drop_msg_bitmap&quot;,
            0600, root,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;ualink.drop_msg_bitmap);
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;ualink.selftest_mutex);
            <br>
            +&nbsp;&nbsp;&nbsp; /* 64 bytes test size by default */
            <br>
            +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.test_size_dwords = 16;
            <br>
            +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.test_remote_accel_id =
            AMDGPU_UALINK_ACCEL_MAX;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; ualink_test = debugfs_create_dir(&quot;amdgpu_ualink_test&quot;,
            root);
            <br>
            +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;command&quot;, 0600, ualink_test, adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_command_fops);
            <br>
            +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;remote_accel_id&quot;, 0600,
            ualink_test, adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_accel_id_fops);
            <br>
            +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;test_size&quot;, 0600, ualink_test,
            adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_test_size_fops);
            <br>
            +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;local_test_data&quot;, 0600,
            ualink_test, adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_local_test_data_fops);
            <br>
            +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;remote_sdma&quot;, 0600, ualink_test,
            adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_remote_sdma_fops);
            <br>
            +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;remote_lsdma&quot;, 0600, ualink_test,
            adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_remote_lsdma_fops);
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.data = adev-&gt;bios;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.size = adev-&gt;bios_size;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_blob(&quot;amdgpu_vbios&quot;, 0444, root,
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
            <br>
            index 05bc281216bf..1f83d9b69135 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
            <br>
            @@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;lsdma.lock);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
            <br>
            &nbsp; }
            <br>
            +
            <br>
            +int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ib ib;
            <br>
            +&nbsp;&nbsp;&nbsp; int i, r;
            <br>
            +&nbsp;&nbsp;&nbsp; u64 gpu_addr;
            <br>
            +&nbsp;&nbsp;&nbsp; char *p;
            <br>
            +&nbsp;&nbsp;&nbsp; u32 size = 128;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; memset(&amp;ib, 0, sizeof(ib));
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_ib_get(adev, NULL, 2 * size,
            AMDGPU_IB_POOL_DIRECT, &amp;ib);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; gpu_addr = ib.gpu_addr;
            <br>
            +&nbsp;&nbsp;&nbsp; p = (char *)ib.ptr;
            <br>
            +&nbsp;&nbsp;&nbsp; memset(p, 0, 2 * size);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; size; i++)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(p + i) = i;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;copy src 0x%llx dst 0x%llx size
            %d bytes\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_addr, gpu_addr + size, size);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr +
            size, size);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; p += size;
            <br>
            +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; size; i++) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*(p + i) != i) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;data mismatch expecting
            0x%x but read 0x%x\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i, *(p + i));
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; if (i != size)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EIO;
            <br>
            +
            <br>
            +out:
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_ib_free(&amp;ib, NULL);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;lsdma selftest failed
            r=%d\n&quot;, r);
            <br>
            +&nbsp;&nbsp;&nbsp; else
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;lsdma selftest passed\n&quot;);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return r;
            <br>
            +}
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
            <br>
            index 34e92aaa4617..f0a5eeb3529f 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
            <br>
            @@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct
            amdgpu_device *adev, uint64_t dst_addr,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data, uint64_t mem_size);
            <br>
            &nbsp; int amdgpu_lsdma_wait_for(struct amdgpu_device *adev,
            uint32_t reg_index,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_val, uint32_t mask);
            <br>
            +int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
            <br>
            &nbsp; &nbsp; #endif
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
            <br>
            index 339f639a450e..86e0dc8d728e 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
            <br>
            @@ -39,8 +39,6 @@ static void deactivate_accelerator(struct
            amdgpu_device *adev);
            <br>
            &nbsp; static int amdgpu_ualink_remote_interrupt(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remote_accel_id, u32 dw0, u32 dw1,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 dw2, u32 dw3);
            <br>
            -static void amdgpu_ualink_flush_tlb(struct amdgpu_device
            *adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 flush_type);
            <br>
            &nbsp; static int amdgpu_ualink_reserve_npa_vm_and_bos(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bos[], u32
            n_bos,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_exec *exec,
            <br>
            @@ -4333,9 +4331,6 @@ void amdgpu_ualink_manager_stop(struct
            amdgpu_device *adev)
            <br>
            &nbsp;&nbsp; * UALink remote interrupt and shootdown
            <br>
            &nbsp;&nbsp; */
            <br>
            &nbsp; -/* UALINK ring buffer size, same for both remote
            shootdown and interrupt ring */
            <br>
            -#define AMDGPU_UALINK_RB_SIZE&nbsp;&nbsp;&nbsp; 4096
            <br>
            -
            <br>
            &nbsp; #define AMDGPU_UALINK_METADATA_HEADER&nbsp;&nbsp;&nbsp; 0x4E485446
            <br>
            &nbsp; &nbsp; /* 2MB NPA start address for 2MB page mapping */
            <br>
            @@ -4582,7 +4577,7 @@ static inline u32
            ualink_tlb_wb_offset(struct amdgpu_device *adev, u32
            accel_id)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ualink_wb_offset(adev, accel_id) +
            sizeof(struct amdgpu_ualink_wb);
            <br>
            &nbsp; }
            <br>
            &nbsp; -static void amdgpu_ualink_flush_tlb(struct amdgpu_device
            *adev, u32 flush_type)
            <br>
            +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev,
            u32 flush_type)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 bit;
            <br>
            &nbsp; @@ -5281,7 +5276,8 @@ static int
            amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status != AMDGPU_NHT_FW_ST_PREINIT &amp;&amp;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status != AMDGPU_NHT_FW_ST_HALT) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;fw status 0x%x not preinit
            or halt\n&quot;, status);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ualink.selftesting)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;accel_id %u addr_mode %d fw
            status 0x%x\n&quot;,
            <br>
            @@ -5399,6 +5395,8 @@ static int
            amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = adev-&gt;ualink.msg_ctl-&gt;send_metadata(adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote-&gt;metadata_gpu_addr,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UALINK_ACCEL_MAX
            &lt;&lt; 8);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r &amp;&amp; adev-&gt;ualink.selftesting)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
            <br>
            &nbsp; &nbsp; out:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            @@ -6384,11 +6382,216 @@ void amdgpu_ualink_sw_fini(struct
            amdgpu_device *adev)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ualink.remote = NULL;
            <br>
            &nbsp; }
            <br>
            &nbsp; -int ualink_send_hello(struct amdgpu_device *adev, u32
            remote_accel_id)
            <br>
            +/* byte offset of the local interrupt ring a remote GPU
            writes to */
            <br>
            +static u32 ualink_test_local_rb_offset(u32 remote_accel_id)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 *
            AMDGPU_UALINK_RB_SIZE);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* remote shootdown ring is first, remote interrupt
            ring follows it */
            <br>
            +&nbsp;&nbsp;&nbsp; return rb_size * remote_accel_id +
            AMDGPU_UALINK_RB_SIZE;
            <br>
            +}
            <br>
            +
            <br>
            +/*
            <br>
            + * ualink_test_local_data - read or write the local ring
            buffer of a remote GPU
            <br>
            + *
            <br>
            + * The local ring buffer is partitioned per remote GPU,
            @remote_accel_id selects
            <br>
            + * the interrupt ring that remote GPU writes to through its
            NPA mapping. Read it
            <br>
            + * to see what the remote GPU wrote, write it to provide
            the data it reads.
            <br>
            + */
            <br>
            +int ualink_test_local_data(struct amdgpu_device *adev, u32
            remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, u32 size, bool read)
            <br>
            &nbsp; {
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_remote *remote = to_remote(adev);
            <br>
            +&nbsp;&nbsp;&nbsp; void *rb;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (!remote || !remote-&gt;rb_cpu_addr)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (size &gt; AMDGPU_UALINK_RB_SIZE)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; rb = remote-&gt;rb_cpu_addr +
            ualink_test_local_rb_offset(remote_accel_id);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;%s local rb of remote %u at 0x%p
            size 0x%x\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read ? &quot;read&quot; : &quot;write&quot;, remote_accel_id, rb,
            size);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (read)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(data, rb, size);
            <br>
            +&nbsp;&nbsp;&nbsp; else
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(rb, data, size);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +}
            <br>
            +
            <br>
            +/*
            <br>
            + * ualink_test_remote_rw - read or write the remote GPU
            ring buffer
            <br>
            + *
            <br>
            + * Copy @size bytes between @data and the remote GPU ring
            buffer NPA address
            <br>
            + * using lsdma or sdma. The DMA engines cannot access
            @data, the local ring
            <br>
            + * buffer of the same remote GPU is used to stage it, so
            local_test_data shows
            <br>
            + * what was sent or received.
            <br>
            + *
            <br>
            + * Works with or without MPNHT FW running, the copy does
            not update wptr and
            <br>
            + * does not ring the doorbell.
            <br>
            + */
            <br>
            +int ualink_test_remote_rw(struct amdgpu_device *adev, u32
            remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, u32 size, bool read, bool
            use_lsdma)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_remote *remote = to_remote(adev);
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_peer *peer;
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_ring *ring;
            <br>
            +&nbsp;&nbsp;&nbsp; struct dma_fence *fence;
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_job *job;
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib;
            <br>
            +&nbsp;&nbsp;&nbsp; u64 npa, local;
            <br>
            +&nbsp;&nbsp;&nbsp; u32 offset, ndw;
            <br>
            +&nbsp;&nbsp;&nbsp; int r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (!remote)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (size &gt; AMDGPU_UALINK_RB_SIZE)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; peer = &amp;remote-&gt;peer[remote_accel_id];
            <br>
            +&nbsp;&nbsp;&nbsp; ring = &amp;peer-&gt;interrupt;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;peer-&gt;lock);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; offset = ualink_test_local_rb_offset(remote_accel_id);
            <br>
            +&nbsp;&nbsp;&nbsp; local = remote-&gt;rb_gpu_addr + offset;
            <br>
            +&nbsp;&nbsp;&nbsp; npa = ring-&gt;rb_npa_gart;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (!read)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(remote-&gt;rb_cpu_addr + offset, data,
            size);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; remote-&gt;use_lsdma = use_lsdma;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;%s remote %u npa 0x%llx local
            0x%llx size 0x%x use %s\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read ? &quot;read&quot; : &quot;write&quot;, remote_accel_id, npa,
            local, size,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_lsdma ? &quot;lsdma&quot; : &quot;sdma&quot;);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (use_lsdma) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_lsdma_copy_mem(adev, read ? npa : local,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read ? local : npa, size);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto done;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* sdma linear copy command, align to 8 dwords boundary
            */
            <br>
            +&nbsp;&nbsp;&nbsp; ndw = ALIGN(adev-&gt;mman.buffer_funcs-&gt;copy_num_dw,
            8);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_job_alloc_with_ib(adev,
            &amp;peer-&gt;entity, AMDGPU_FENCE_OWNER_VM,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER,
            &amp;job);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; ib = job-&gt;ibs;
            <br>
            +&nbsp;&nbsp;&nbsp; ib-&gt;length_dw = 0;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_emit_copy_buffer(adev, ib, read ? npa : local,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read ? local : npa, size, 0);
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(&amp;adev-&gt;sdma.instance[0].ring,
            ib);
            <br>
            +&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw &gt; ndw);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; fence = amdgpu_job_submit(job);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = dma_fence_wait_timeout(fence, false, HZ * 10);
            <br>
            +&nbsp;&nbsp;&nbsp; dma_fence_put(fence);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r &lt;= 0) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;remote sdma fence wait
            timeout %d\n&quot;, r);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;use lsdma for testing
            afterwards\n&quot;);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote-&gt;use_lsdma = true;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIME;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +done:
            <br>
            +&nbsp;&nbsp;&nbsp; if (read)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(data, remote-&gt;rb_cpu_addr + offset,
            size);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +}
            <br>
            +
            <br>
            +/* The peer may have rebooted or the vpod was reconfigured,
            adopt the remote
            <br>
            + * wptr before sending a command, same as the handshake
            does.
            <br>
            + */
            <br>
            +static int ualink_test_resync_peer(struct amdgpu_device
            *adev, u32 remote_accel_id)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; int r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (!adev-&gt;ualink.remote)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_ring_resync_ptrs(adev,
            remote_accel_id);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r &lt; 0)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* Peer moved, drop ready so the next command updates
            the wb address */
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_reset_peer_rings(adev,
            remote_accel_id);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +}
            <br>
            +
            <br>
            +int ualink_test_send_hello(struct amdgpu_device *adev, u32
            remote_accel_id)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; int r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = ualink_test_resync_peer(adev, remote_accel_id);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_ualink_send_hello_msg(adev,
            remote_accel_id);
            <br>
            &nbsp; }
            <br>
            &nbsp; +int ualink_test_remote_shootdown(struct amdgpu_device
            *adev, u32 remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 addr, u32 size_in_pages, u32
            flush_type)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; int r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = ualink_test_resync_peer(adev, remote_accel_id);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return amdgpu_ualink_remote_shootdown(adev,
            remote_accel_id, addr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_in_pages, flush_type);
            <br>
            +}
            <br>
            +
            <br>
            +int ualink_test_update_interrupt_wb(struct amdgpu_device
            *adev, u32 remote_accel_id)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; int r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = ualink_test_resync_peer(adev, remote_accel_id);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +
            <br>
            +
guard(mutex)(&amp;adev-&gt;ualink.remote-&gt;peer[remote_accel_id].lock);<br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* Update interrupt completion write back address */
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_update_wb_address(adev,
            remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RB_TYPE_REMOTE_INTERRUPT);
            <br>
            +&nbsp;&nbsp;&nbsp; return r;
            <br>
            +}
            <br>
            +
            <br>
            +int ualink_test_update_shootdown_wb(struct amdgpu_device
            *adev, u32 remote_accel_id)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; int r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = ualink_test_resync_peer(adev, remote_accel_id);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +
            <br>
            +
guard(mutex)(&amp;adev-&gt;ualink.remote-&gt;peer[remote_accel_id].lock);<br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* Update shootdown completion write back address */
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_update_wb_address(adev,
            remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RB_TYPE_TLB_INV);
            <br>
            +&nbsp;&nbsp;&nbsp; return r;
            <br>
            +}
            <br>
            +
            <br>
            &nbsp; /*
            <br>
            &nbsp;&nbsp; * The low bits of handle_lo carry the message-header
            field on the wire.
            <br>
            &nbsp;&nbsp; * Strip those bits and splice in @acc_id to recover the
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
            <br>
            index 85c9a9634a4b..90e90cd8b495 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
            <br>
            @@ -310,6 +310,9 @@ struct amdgpu_ualink_connection {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ualink_conn_state state;
            <br>
            &nbsp; };
            <br>
            &nbsp; +/* UALINK ring buffer size, same for both remote
            shootdown and interrupt ring */
            <br>
            +#define AMDGPU_UALINK_RB_SIZE&nbsp;&nbsp;&nbsp; 4096
            <br>
            +
            <br>
            &nbsp; struct amdgpu_ualink_remote;
            <br>
            &nbsp; &nbsp; struct amdgpu_ualink_msg_ctl {
            <br>
            @@ -333,6 +336,13 @@ struct amdgpu_ualink_mgr {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For remote interrupt and shootdown */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_remote *remote;
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; /* true for selftest driver path, ignore FW error */
            <br>
            +&nbsp;&nbsp;&nbsp; bool selftesting;
            <br>
            +&nbsp;&nbsp;&nbsp; /* serialize the selftest debugfs entries */
            <br>
            +&nbsp;&nbsp;&nbsp; struct mutex selftest_mutex;
            <br>
            +&nbsp;&nbsp;&nbsp; u32 test_size_dwords;
            <br>
            +&nbsp;&nbsp;&nbsp; u32 test_remote_accel_id;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* handle irq from ualink client of remote GPUs */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src irq;
            <br>
            &nbsp; @@ -390,14 +400,22 @@ struct amdgpu_ualink_mgr {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long drop_msg_bitmap;
            <br>
            &nbsp; };
            <br>
            &nbsp; +int ualink_test_local_data(struct amdgpu_device *adev,
            u32 remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, u32 size, bool read);
            <br>
            +int ualink_test_remote_rw(struct amdgpu_device *adev, u32
            remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, u32 size, bool read, bool
            use_lsdma);
            <br>
            +int ualink_test_send_hello(struct amdgpu_device *adev, u32
            remote_accel_id);
            <br>
            +int ualink_test_remote_shootdown(struct amdgpu_device
            *adev, u32 remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 addr, u32 size_in_pages, u32
            flush_type);
            <br>
            +int ualink_test_update_interrupt_wb(struct amdgpu_device
            *adev, u32 remote_accel_id);
            <br>
            +int ualink_test_update_shootdown_wb(struct amdgpu_device
            *adev, u32 remote_accel_id);
            <br>
            +
            <br>
            &nbsp; int amdgpu_ualink_init_interrupt(struct amdgpu_device
            *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int client_id, unsigned int
            src_id);
            <br>
            -
            <br>
            +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev,
            u32 flush_type);
            <br>
            &nbsp; int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
            <br>
            &nbsp; void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
            <br>
            &nbsp; -int ualink_send_hello(struct amdgpu_device *adev, u32
            remote_accel_id);
            <br>
            -
            <br>
            &nbsp; int amdgpu_ualink_config_update_handler(struct
            amdgpu_device *adev);
            <br>
            &nbsp; int amdgpu_ualink_pause_handler(struct amdgpu_device
            *adev);
            <br>
            &nbsp; int amdgpu_ualink_resume_handler(struct amdgpu_device
            *adev);
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------sGCW5DCotGZfVPo0BNpIfDAR--
