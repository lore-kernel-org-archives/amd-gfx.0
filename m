Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0E606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q9rBk51+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C46510E67E;
	Wed, 28 Oct 2026 21:36:20 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF99110E67E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 21:36:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfih2kmikAhvfsMy3felGSsKpqvthZkN3hvWQjQK5QQe3xTXt7I6xCbOB7Jo1eBgAWCLtubzoUpB4dzE7K/gx2svkWJrx3BVLCxmumIp7HQvs5IZw1/63FQHybMw4sTHBZ908riFpNeNKvN9HCiVccGESUb50NiUaehgCXjYx9v2Hp/DX25WZ2KktmquTw+E4ZvXH3eG04rR+1khCwqO+AJBPLBl8Fc9GfFiKkhRtw1S6QtzqHFKa96vn8P8SMotdP49wNLXSIIHtmbV8RGGMhAGg042XseKNhMrEgWkEnJP4Daw6qFBYh0hkvGNwtle27sTaYlCdEXFVAQc4E79Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agNR/IAzHDiOpDVANd/UbHcyOC7FaeZFOuWCrTlj1Uc=;
 b=v5L+xX0lhaQ3eoxqNa7w1IV6a6Z3PRnsxkXHOan+dqMgSyziP4G305HXbq2XCiPiB2lDa/yzC1FDEuJGtGrH7hskVsBJrekWWoSiTsYkEXBzk7HZPPe7ds31FYN7E3BhQdEgM6Al6lQoaVA9/QeIk0Eg1pc/qcdfPEmChf3rs5g2oG9QwmIwX9DRbG0FKw7ZVU281qIZVIc5cCeo6EE3YFr4acCFUjh+iju0/f7RK2zSTlbR8DybZlxQdYACzPwYho+684UXLeKyyoTf/qozD/4sZTvtJGON1Dm6yoQJ9+/BxFRRDj+Tx2oRl7bnIHsnCdbcK4PT++HGd6OE+FH8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agNR/IAzHDiOpDVANd/UbHcyOC7FaeZFOuWCrTlj1Uc=;
 b=q9rBk51+WkMrm2cFk7IRsKfhww5XApSIERiUdGj0ayWdXwNZZkG4qrBDd1fyCT7q71Doi5PgVLTpuVMLNQNZKeyH5zxVdH2G5RleYkJXj89JQBl6plPs2YOB/rOpwl7rcZs/eLpwi4bKFmHHVskPOd7T9iPDeMtpbJJrr2UV4KY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CY5PR12MB6346.namprd12.prod.outlook.com
 (2603:10b6:930:21::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 21:36:10 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 21:36:10 +0000
Message-ID: <7a63c005-8d95-497e-bf4f-00a80688e732@amd.com>
Date: Wed, 28 Oct 2026 17:36:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/amdgpu: UALink add debugfs selftest
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org, Mukul.Joshi@amd.com
References: <20261023203447.2075707-1-Philip.Yang@amd.com>
 <abbf170b-628b-455f-94b1-91e3ce540863@amd.com>
 <e0535f78-43ca-4d44-a93b-405de825ba65@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <e0535f78-43ca-4d44-a93b-405de825ba65@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::21) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb23f48-6b42-495d-9934-08df353b7b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|6133799003|261026135527099003|22082099003|261026140227099003|261028144727099003|261026130827099003|3023799007|261022075727099003|56012099006|261021123027099003|261021135927099003|4143699003|10067099003|261021133027099003|261021121427099003|261021130227099003|261022105027099003|261009223027099003|261022113327099003|261022115727099003|11063799006|261026121527099003;
X-Microsoft-Antispam-Message-Info: JjMKy93IxMDFefdZtI++xPnCdja/Ntm57rCY/7YzKo6L0/NjuB92h5oy2VVzLAVifrnlMttHeGp6QNuSvYLbsCRPYko/Iz6/WdjoIt8Ugkqf5Uf+pmtcXhfw0NQeC2MX0bCZKzN9bf4BnXDZaIdF9Z3oouK8+w87+IDaWy27IkAGfdvo3GDNN3UyK0fvCM5BG2KZkjAPQ4oUSkrd8/v4pXGEl0J6qMG7OLWUg3wIqrHI2mgbhV+08Yqj4XgodEOKZd1ZrzBHp9fSO3hBnfG32GfCacX9GkUcQO1yz4j6fPleBGA4l6bft47dRAgafVLMTebI8bHuKkajaYvqnDzNWcEx5xmPvBgby7hzGH4zxNnxF04SN+do3R5spsRuF3Q3qyDSy2oAb1R3Idoo/myvEtqgGGX+0mGaxHyYi/o/LiusUppKcMbq7kPKzg9mSCz2PCll0wO61J0BZ7jZSrgSmyUC158CyvOFEWlbhpEoASaktL1RJsFNgrVogYYz/e6bZ6KqIuX2eqGYkjm4vYWDa3sZ8zqwLLPayDmmLv07HdYP3W9iBUX+MkuCXEYNCSmjpfRbHrRlNJmMO4bZ/jQfFPJsjqCj3EndNEWKMIDr+l8nHVdLdHk3LGhAGTRyryIfmEvwgxsCgEhKl60d+TOKY68Ep5kZX8H/CPfxsht0K5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(6133799003)(261026135527099003)(22082099003)(261026140227099003)(261028144727099003)(261026130827099003)(3023799007)(261022075727099003)(56012099006)(261021123027099003)(261021135927099003)(4143699003)(10067099003)(261021133027099003)(261021121427099003)(261021130227099003)(261022105027099003)(261009223027099003)(261022113327099003)(261022115727099003)(11063799006)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHFYS2JQUVVTRjljd3cwVUxuMGM3OWQxMWgwYko3RTlnU1pqdURGUzhHREo0?=
 =?utf-8?B?SGgveXYvVnlLYzY3QkRqVDhGMlBxVncrUGExZWJyNUh0czYweGo4bGdGeUJw?=
 =?utf-8?B?SStTQ1JhUFM0Q0tuSithdWtEZmViVFJ4Qnl4YWV2UFlXbVc0b1l6enpDdytm?=
 =?utf-8?B?cW5ERVBXbUdBR1pBQ3RpeDBHdUZrR3pxSTJoUEpRSklIT1NiK25JZWFLdmZ0?=
 =?utf-8?B?dFFaYzk5Z1dYcTIvajhsQTMzOEFicHRsczlQeDFYTGxMSUd4NU5oNE05VEx5?=
 =?utf-8?B?aTFld1dlMzJWQUsvS2ViQVVjb2hJV0R4bzFoQWFza0FBVEN4YklML2tJdE5V?=
 =?utf-8?B?TWhLRkw2ZTR4OUFldkJxaWRaSXl2R0cyM3hZUlkyRHVGV0ZvU2UybXA0TDR6?=
 =?utf-8?B?Z0R5Q0djZXpOWEdVL0cvMTRaSktQOXQ5N3BnYVRsa3ZkcDgxQUc0c0g2N05r?=
 =?utf-8?B?Q1JMbEpkSUNHai9USlFQdHFzemd3T1Bkb28ydG1UT2VudmlUVXdUOFlPRnVk?=
 =?utf-8?B?Wjh6cktTL0YvcmIxZWJpMXFXVDNXczdGYmpzamVhM2E5d3Q2aUhmblZqVFds?=
 =?utf-8?B?V1BsTnY3WEtOdFUwVjBhaFdoK1paeVYxSWRsSnZjN0N4TE1KUEFaaUlsNVI3?=
 =?utf-8?B?RWkwTXkxWWlTVGhrMU41czVxbU5RejREcWdEbGozQUphZU5iZjJaZnhOWXlI?=
 =?utf-8?B?TDVSRWRUc1dwRWg4QzBXajRGK0ZPM0tqZXlrMXVwMjkyWmlkTnFFMTZoelQ4?=
 =?utf-8?B?Z1pmTnRLWmNJVUJ6aGxIRm15eXJzcDNNNFIwdHl5VkQwY1dCMVRod0FzeVF3?=
 =?utf-8?B?YjdrbzluZlkxOHhxRVUxWW11Qk5WeGd3UFlrUys1OGJ6dXR4V1lKMjBhbWxz?=
 =?utf-8?B?cC9oN3oyem02L3c4UHZ0QVBJd2t0T1RQUHdWazJWSTgvSTdHVCtrNkV0QTVV?=
 =?utf-8?B?ekVxenU0VW5rbkdZN2dLakhSdDBsUGFtUGhOeHJEZEt4N1JUbldFQlltb05s?=
 =?utf-8?B?eG41ZnJJVlMzd2d6bW5IaHgrNmp5TXhpMGVKbEU5RVh2MDFnZGQrbjkrUWc4?=
 =?utf-8?B?RU0rdldQVytsWmJLdE54QnhiZk43Yjg0NWp2Lzh4TkJHcHJoaWhZSnNWMlpL?=
 =?utf-8?B?eUhOZFlDQkxGZHlkSG9FVHNzYlllSTdBYThkZlp1M3VhNEpwNXFFS0c1c1lS?=
 =?utf-8?B?SnBaZGhkRGVQbXVWWk8vbEhjZzJCWG9obzhkZVlSVitZWWZOSlJQeXdtaFdC?=
 =?utf-8?B?MU1MV21Za2p4VTVtQldKZEFobUF3a0tnUFZRaTJLc2tKR3lFWERoZVE0dVY4?=
 =?utf-8?B?eElESUgrcHY5ME5WTjV5VFN3Vlh2MVpwaEdxa2oybEFMbVhmZUVOMko1YW1M?=
 =?utf-8?B?RHN2VEZRRkEzYWlwNUFqdzAwZjhZV01wV0xFTlhGdldsY0xCbWg2TGhNRmZK?=
 =?utf-8?B?blNRZHpicjk4d09UVHpVTU5CYWJpVzExZUVkVUxNSnQyWVcxNTMraVZ3bjN3?=
 =?utf-8?B?dTFtRkEzSGtSY1k5WlYwVjFrWXpONndsZXErWUt4SUFETE9WK0dlMkduMXZX?=
 =?utf-8?B?QTlUOTl6bnZETTJ4TEZ6YkdTNVNsNlNDMHg5V3dpazNTWUVvMSs1V2NSZ2Zy?=
 =?utf-8?B?RE1LWDBzVXhmVWtBQ055TzRjRk9qbTdxSXRBbGdTdWtIWnM0bWNRN0FuMUxY?=
 =?utf-8?B?NGJLQ3llZ1Z0OU1tK1NRU3dwUFVWTEFINUhEY1J2QjFLaWpSVEVyOFF5ME5x?=
 =?utf-8?B?OFErM1h0UW83ME9INTl1NDRaSnB5QTRTa2NBQTdoZVFuUUF5eURTNFFnY28v?=
 =?utf-8?B?YU5qVWpSS0xIQVV5Q1lOOC9MMnllMnNram15UkNZOFZ3UWxYaVk0czAvQy9N?=
 =?utf-8?B?eTNCcWJJdUZxbzJEeG9jWUVlcWQ4ZHBlWW9LS054ZXJ3MWVQZTIwM1VOUVJ0?=
 =?utf-8?B?Ym9sOC85YVBRT0N5OHB5Nng2SVBlYmNEZVFoTktRTy85bExKbldVbFBKU3Y0?=
 =?utf-8?B?b0tCKzAxVnNlTjlETTRNWjVMNUZMdVY2VjRUdnpQeHZza1ZFZGtkOUNqQXVD?=
 =?utf-8?B?a3pEK2ZIalNjd3Ria2x6M29xNDc3UVFrT21uTmNldU5Xekd5TTlqOENzZURV?=
 =?utf-8?B?aHNrQU5pY21BeUdIclpFNk5rNVYzQ1FSM1JValVyL3BXYndUZkhRTlVBa3pB?=
 =?utf-8?B?UEI5SzRBN2JpM1Y3dTdkR2lLZ3NEN1JnL1I1Y0F5NU9MV2hOSXN3UElUVy9z?=
 =?utf-8?B?YjJZaVJ3aEdGa3RlTTdKZHIvazY0U2wyUkkzVjU1cE9CN3ZiNkFBUjViREE3?=
 =?utf-8?B?N0NXN3ZhNlVkNytDUUNza0tiVk1iM0trWStNY3M2eGNTeXdUQjlDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb23f48-6b42-495d-9934-08df353b7b8d
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 21:36:10.3949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGR+DMV0MX/gzsYR/r8AdTEw+IrIN5vnSTPUw/Ldqohhk/zPBSEf/+cgIbwnZiQcifeeSH2dxAmdhaCv6ChDJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
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


On 2026-10-28 15:36, Philip Yang wrote:
>
>
> On 2026-10-28 14:24, Kuehling, Felix wrote:
>> On 2026-10-23 16:34, Philip Yang wrote:
>>> Driver-side selftests for UALink bring-up: exercise the nHT firmware,
>>> remote interrupts, remote TLB shootdown and remote VRAM access without
>>> any userspace application.
>>>
>>> Add debugfs directory "amdgpu_ualink_test" to trigger UALink selftests
>>> with these read/write entries:
>>>
>>>    command          write the test name to run it, read to list the
>>>                     valid test names
>>>    remote_accel_id  accel_id of the remote GPU used by the tests
>>>    test_size        test buffer size in bytes, from 4 to 4096
>>>    local_test_data  the local ring buffer the remote GPU accesses
>>>    remote_sdma      the remote GPU ring buffer, using sdma
>>>    remote_lsdma     the remote GPU ring buffer, using lsdma
>>>
>>> The data entries take and return binary data, a write shorter than
>>> test_size is repeated to fill it, so formatting is left to userspace
>>> tools like printf, xxd, od and cmp.
>>>
>>> Add helper functions: ualink_test_local_data() and
>>> ualink_test_remote_rw() for local and remote ring buffer R/W,
>>> ualink_test_remote_shootdown() for TLB shootdown,
>>> ualink_test_send_hello() for handshake,
>>> ualink_test_update_interrupt_wb() and
>>> ualink_test_update_shootdown_wb() to read writeback results.
>>>
>>> v6: ring buffer wptr for itself is used for wptr, don't init to 
>>> 0xdeadbeef
>>
>> I don't see this change. What exactly did you change? I only see the 
>> removal of deadbeef init. I don't see any change regarding which ring 
>> buffer is used to stage the data for remote read/write.
> The remote ring buffer was initialised to 0xdeadbeef for the selftest. 
> In address-aliasing mode the wptr for every remote uses that same ring 
> buffer page for itself accel_id, so the remote wptr resync read back 
> 0xdeadbeef and synced the wptr to that value, which left the remote 
> firmware in a bad state. I have removed the ring buffer 
> initialisation. ualink_test_resync_peer() also change to only resync 
> wptr for the first command or if peer rebooted.

OK. I was asking for an additional change in v5 that I thought you were 
addressing here, but didn't.

The remote write first writes data to local memory before copying it to 
remote. E.g. remote write from A to B overwrites local memory in A. A 
remote write from B to A writes the same memory in A. Now a tester 
reading local_test_data from debugfs doesn't know whether that was 
written by the remote GPU or by a previous local read/write to 
remote_sdma or remote_lsdma.

Therefore, I would like to keep those separate. A write from A to B 
should not overwrite the same memory on A as a write from B to A. 
Similar for remote reads. A remote read by A from B should not overwrite 
the same memory on A that is also accessed remotely by B.

I proposed using a different offset for the staging memory in 
ualink_test_remote_rw. Instead of using remote_accel_id in offset = 
ualink_test_local_rb_offset(remote_accel_id), use the GPU's own 
accelerator ID.

Does that make sense?

Regards,
   Felix


>
> Regards,
> Philip
>>
>> Regards,
>>   Felix
>>
>>
>>> v5: Replace the four remote access commands with local_test_data,
>>>      remote_sdma and remote_lsdma entries, to get the test data without
>>>      looking at debug logs or using xxd with physical addresses 
>>> (Felix).
>>>      Dump and accept binary data, no parser in the driver (Felix).
>>>      Stage the DMA in the local ring buffer instead of the IB, which is
>>>      freed before the data is read back.
>>> v4: Use a single "command" entry taking the test name, instead of one
>>>      entry per test (Felix).
>>>      Resync the remote wptr before sending a command, the peer may have
>>>      rebooted.
>>> v3: Replace the single entry taking a test number with a debugfs
>>>      directory and a named entry per command.
>>>      Take peer->lock to update the writeback address and selftest_mutex
>>>      to read the test parameters.
>>> v2: Fix typos and issues from copilot code review.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 346 
>>> ++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 +++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 219 ++++++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  24 +-
>>>   5 files changed, 628 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 3dc95d9accf2..2d786639d081 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -2133,9 +2133,336 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>   +enum amdgpu_ualink_test_cmd {
>>> +    UALINK_TEST_SW_INIT,
>>> +    UALINK_TEST_SEND_HELLO,
>>> +    UALINK_TEST_REMOTE_SHOOTDOWN,
>>> +    UALINK_TEST_FLUSH_TLB,
>>> +    UALINK_TEST_UPDATE_INTERRUPT_WB,
>>> +    UALINK_TEST_UPDATE_SHOOTDOWN_WB,
>>> +    UALINK_TEST_LSDMA_SELFTEST,
>>> +};
>>> +
>>> +/* commands talking to a remote accelerator, remote_accel_id must 
>>> be set */
>>> +#define UALINK_TEST_NEEDS_ACCEL_ID                    \
>>> +    (BIT(UALINK_TEST_SEND_HELLO) | 
>>> BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
>>> +     BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |                \
>>> +     BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
>>> +
>>> +static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device *adev,
>>> +                      enum amdgpu_ualink_test_cmd cmd)
>>> +{
>>> +    u32 remote_accel_id = adev->ualink.test_remote_accel_id;
>>> +    int r = 0;
>>> +
>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>> +
>>> +    if ((BIT(cmd) & UALINK_TEST_NEEDS_ACCEL_ID) &&
>>> +        remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
>>> +        dev_err(adev->dev, "set remote_accel_id first\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    adev->ualink.selftesting = true;
>>> +
>>> +    switch (cmd) {
>>> +    case UALINK_TEST_SW_INIT:
>>> +        if (adev->ualink.remote)
>>> +            amdgpu_ualink_sw_fini(adev);
>>> +
>>> +        dev_dbg(adev->dev, "load metadata init MPNHT firmware\n");
>>> +        r = amdgpu_ualink_sw_init(adev);
>>> +        break;
>>> +    case UALINK_TEST_SEND_HELLO:
>>> +        r = ualink_test_send_hello(adev, remote_accel_id);
>>> +        break;
>>> +    case UALINK_TEST_REMOTE_SHOOTDOWN:
>>> +        r = ualink_test_remote_shootdown(adev, remote_accel_id, 1UL 
>>> << 30,
>>> +                         1, TLB_FLUSH_HEAVYWEIGHT);
>>> +        break;
>>> +    case UALINK_TEST_FLUSH_TLB:
>>> +        amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
>>> +        break;
>>> +    case UALINK_TEST_UPDATE_INTERRUPT_WB:
>>> +        r = ualink_test_update_interrupt_wb(adev, remote_accel_id);
>>> +        break;
>>> +    case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
>>> +        r = ualink_test_update_shootdown_wb(adev, remote_accel_id);
>>> +        break;
>>> +    case UALINK_TEST_LSDMA_SELFTEST:
>>> +        r = adev->lsdma.funcs ? amdgpu_lsdma_selftest(adev) : 
>>> -EOPNOTSUPP;
>>> +        break;
>>> +    }
>>> +
>>> +    adev->ualink.selftesting = false;
>>> +
>>> +    dev_dbg(adev->dev, "ualink test cmd %d remote_accel_id %u ret 
>>> %d\n",
>>> +        cmd, remote_accel_id, r);
>>> +
>>> +    return r;
>>> +}
>>> +
>>> +#define UALINK_TEST_CMD_NAME_MAX    32
>>> +
>>> +static const char * const amdgpu_ualink_test_cmd_name[] = {
>>> +    [UALINK_TEST_SW_INIT]            = "sw_init",
>>> +    [UALINK_TEST_SEND_HELLO]        = "send_hello",
>>> +    [UALINK_TEST_REMOTE_SHOOTDOWN]        = "remote_shootdown",
>>> +    [UALINK_TEST_FLUSH_TLB]            = "flush_tlb",
>>> +    [UALINK_TEST_UPDATE_INTERRUPT_WB]    = "update_interrupt_wb",
>>> +    [UALINK_TEST_UPDATE_SHOOTDOWN_WB]    = "update_shootdown_wb",
>>> +    [UALINK_TEST_LSDMA_SELFTEST]        = "lsdma_selftest",
>>> +};
>>> +
>>> +static ssize_t amdgpu_debugfs_ualink_command_read(struct file *file,
>>> +                          char __user *ubuf,
>>> +                          size_t len, loff_t *offp)
>>> +{
>>> +    char buf[UALINK_TEST_CMD_NAME_MAX * 
>>> ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
>>> +    unsigned int i;
>>> +    int n = 0;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
>>> +        n += scnprintf(buf + n, sizeof(buf) - n, "%s\n",
>>> +                   amdgpu_ualink_test_cmd_name[i]);
>>> +
>>> +    return simple_read_from_buffer(ubuf, len, offp, buf, n);
>>> +}
>>> +
>>> +static ssize_t amdgpu_debugfs_ualink_command_write(struct file *file,
>>> +                           const char __user *ubuf,
>>> +                           size_t len, loff_t *offp)
>>> +{
>>> +    struct amdgpu_device *adev = file->private_data;
>>> +    char buf[UALINK_TEST_CMD_NAME_MAX];
>>> +    int cmd, r;
>>> +
>>> +    if (len >= sizeof(buf))
>>> +        return -EINVAL;
>>> +
>>> +    if (copy_from_user(buf, ubuf, len))
>>> +        return -EFAULT;
>>> +
>>> +    buf[len] = '\0';
>>> +    cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name, strim(buf));
>>> +    if (cmd < 0) {
>>> +        dev_err(adev->dev, "unknown ualink test command\n");
>>> +        return cmd;
>>> +    }
>>> +
>>> +    r = amdgpu_debugfs_ualink_test_run(adev, cmd);
>>> +    if (r)
>>> +        return r;
>>> +
>>> +    return len;
>>> +}
>>> +
>>> +static const struct file_operations amdgpu_ualink_command_fops = {
>>> +    .owner     = THIS_MODULE,
>>> +    .open     = simple_open,
>>> +    .read     = amdgpu_debugfs_ualink_command_read,
>>> +    .write     = amdgpu_debugfs_ualink_command_write,
>>> +    .llseek     = default_llseek,
>>> +};
>>> +
>>> +/* test data buffers, see amdgpu_debugfs_ualink_data_xfer() */
>>> +enum amdgpu_ualink_test_buf {
>>> +    UALINK_BUF_LOCAL,
>>> +    UALINK_BUF_REMOTE_SDMA,
>>> +    UALINK_BUF_REMOTE_LSDMA,
>>> +};
>>> +
>>> +static int amdgpu_debugfs_ualink_data_xfer(struct amdgpu_device *adev,
>>> +                       enum amdgpu_ualink_test_buf buf,
>>> +                       u32 *data, u32 size, bool read)
>>> +{
>>> +    u32 remote_accel_id = adev->ualink.test_remote_accel_id;
>>> +    int r;
>>> +
>>> +    if (remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
>>> +        dev_err(adev->dev, "set remote_accel_id first\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    adev->ualink.selftesting = true;
>>> +
>>> +    if (buf == UALINK_BUF_LOCAL)
>>> +        r = ualink_test_local_data(adev, remote_accel_id, data, 
>>> size, read);
>>> +    else
>>> +        r = ualink_test_remote_rw(adev, remote_accel_id, data, 
>>> size, read,
>>> +                      buf == UALINK_BUF_REMOTE_LSDMA);
>>> +
>>> +    adev->ualink.selftesting = false;
>>> +
>>> +    return r;
>>> +}
>>> +
>>> +static ssize_t amdgpu_debugfs_ualink_data_read(struct file *file,
>>> +                           char __user *ubuf, size_t len,
>>> +                           loff_t *offp,
>>> +                           enum amdgpu_ualink_test_buf buf)
>>> +{
>>> +    struct amdgpu_device *adev = file->private_data;
>>> +    ssize_t ret;
>>> +    u32 size;
>>> +    void *data;
>>> +    int r;
>>> +
>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>> +
>>> +    size = adev->ualink.test_size_dwords * 4;
>>> +
>>> +    data = kmalloc(size, GFP_KERNEL);
>>> +    if (!data)
>>> +        return -ENOMEM;
>>> +
>>> +    r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, true);
>>> +    ret = r ? r : simple_read_from_buffer(ubuf, len, offp, data, 
>>> size);
>>> +
>>> +    kfree(data);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static ssize_t amdgpu_debugfs_ualink_data_write(struct file *file,
>>> +                        const char __user *ubuf,
>>> +                        size_t len, loff_t *offp,
>>> +                        enum amdgpu_ualink_test_buf buf)
>>> +{
>>> +    struct amdgpu_device *adev = file->private_data;
>>> +    u32 i, size;
>>> +    void *data;
>>> +    int r;
>>> +
>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>> +
>>> +    size = adev->ualink.test_size_dwords * 4;
>>> +
>>> +    if (!len)
>>> +        return -EINVAL;
>>> +
>>> +    len = min_t(size_t, len, size);
>>> +
>>> +    data = kmalloc(size, GFP_KERNEL);
>>> +    if (!data)
>>> +        return -ENOMEM;
>>> +
>>> +    if (copy_from_user(data, ubuf, len)) {
>>> +        kfree(data);
>>> +        return -EFAULT;
>>> +    }
>>> +
>>> +    /* repeat a short pattern to fill the test size */
>>> +    for (i = len; i < size; i += len)
>>> +        memcpy(data + i, data, min_t(u32, len, size - i));
>>> +
>>> +    r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, false);
>>> +
>>> +    kfree(data);
>>> +
>>> +    return r ? r : len;
>>> +}
>>> +
>>> +#define UALINK_TEST_DATA_ATTR(name, buf)                \
>>> +static ssize_t amdgpu_debugfs_ualink_##name##_read(struct file 
>>> *file,    \
>>> +        char __user *ubuf, size_t len, loff_t *offp)        \
>>> +{                                    \
>>> +    return amdgpu_debugfs_ualink_data_read(file, ubuf, len, offp, 
>>> buf); \
>>> +}                                    \
>>> +static ssize_t amdgpu_debugfs_ualink_##name##_write(struct file 
>>> *file,    \
>>> +        const char __user *ubuf, size_t len, loff_t *offp) \
>>> +{                                    \
>>> +    return amdgpu_debugfs_ualink_data_write(file, ubuf, len, offp, 
>>> buf); \
>>> +}                                    \
>>> +static const struct file_operations amdgpu_ualink_##name##_fops = 
>>> {    \
>>> +    .owner     = THIS_MODULE,                        \
>>> +    .open     = simple_open,                        \
>>> +    .read     = amdgpu_debugfs_ualink_##name##_read,            \
>>> +    .write     = amdgpu_debugfs_ualink_##name##_write, \
>>> +    .llseek     = default_llseek,                    \
>>> +}
>>> +
>>> +UALINK_TEST_DATA_ATTR(local_test_data, UALINK_BUF_LOCAL);
>>> +UALINK_TEST_DATA_ATTR(remote_sdma, UALINK_BUF_REMOTE_SDMA);
>>> +UALINK_TEST_DATA_ATTR(remote_lsdma, UALINK_BUF_REMOTE_LSDMA);
>>> +
>>> +static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
>>> +{
>>> +    struct amdgpu_device *adev = data;
>>> +
>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>> +
>>> +    *val = adev->ualink.test_remote_accel_id;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
>>> +{
>>> +    struct amdgpu_device *adev = data;
>>> +
>>> +    if (!adev->ualink.info)
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>> +
>>> +    if (val >= AMDGPU_UALINK_ACCEL_MAX ||
>>> +        !test_bit(val, adev->ualink.info->vpod.active_accel_bits)) {
>>> +        dev_err(adev->dev, "invalid remote accel_id %llu\n", val);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (val == adev->ualink.info->ppod.accel_id) {
>>> +        dev_err(adev->dev, "remote accel_id equals to local 
>>> accel_id\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    adev->ualink.test_remote_accel_id = val;
>>> +    dev_info(adev->dev, "set remote accel_id to %llu, local 
>>> accel_id %u\n",
>>> +         val, adev->ualink.info->ppod.accel_id);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
>>> +             amdgpu_debugfs_ualink_accel_id_get,
>>> +             amdgpu_debugfs_ualink_accel_id_set, "%llu\n");
>>> +
>>> +static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
>>> +{
>>> +    struct amdgpu_device *adev = data;
>>> +
>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>> +
>>> +    *val = adev->ualink.test_size_dwords * 4;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
>>> +{
>>> +    struct amdgpu_device *adev = data;
>>> +
>>> +    if (val < 4 || val > AMDGPU_UALINK_RB_SIZE)
>>> +        return -EINVAL;
>>> +
>>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>>> +
>>> +    adev->ualink.test_size_dwords = val / 4;
>>> +    dev_dbg(adev->dev, "test buffer size %u bytes\n",
>>> +        adev->ualink.test_size_dwords * 4);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
>>> +             amdgpu_debugfs_ualink_test_size_get,
>>> +             amdgpu_debugfs_ualink_test_size_set, "%llu\n");
>>> +
>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>   {
>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>> +    struct dentry *ualink_test;
>>>       struct dentry *ent;
>>>       int r, i;
>>>   @@ -2246,6 +2573,25 @@ int amdgpu_debugfs_init(struct 
>>> amdgpu_device *adev)
>>>       debugfs_create_ulong("amdgpu_ualink_drop_msg_bitmap", 0600, root,
>>>                    &adev->ualink.drop_msg_bitmap);
>>>   +    mutex_init(&adev->ualink.selftest_mutex);
>>> +    /* 64 bytes test size by default */
>>> +    adev->ualink.test_size_dwords = 16;
>>> +    adev->ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
>>> +
>>> +    ualink_test = debugfs_create_dir("amdgpu_ualink_test", root);
>>> +    debugfs_create_file("command", 0600, ualink_test, adev,
>>> +                &amdgpu_ualink_command_fops);
>>> +    debugfs_create_file("remote_accel_id", 0600, ualink_test, adev,
>>> +                &amdgpu_ualink_accel_id_fops);
>>> +    debugfs_create_file("test_size", 0600, ualink_test, adev,
>>> +                &amdgpu_ualink_test_size_fops);
>>> +    debugfs_create_file("local_test_data", 0600, ualink_test, adev,
>>> +                &amdgpu_ualink_local_test_data_fops);
>>> +    debugfs_create_file("remote_sdma", 0600, ualink_test, adev,
>>> +                &amdgpu_ualink_remote_sdma_fops);
>>> +    debugfs_create_file("remote_lsdma", 0600, ualink_test, adev,
>>> +                &amdgpu_ualink_remote_lsdma_fops);
>>> +
>>>       adev->debugfs_vbios_blob.data = adev->bios;
>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>       debugfs_create_blob("amdgpu_vbios", 0444, root,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>> index 05bc281216bf..1f83d9b69135 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>> @@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device 
>>> *adev,
>>>       mutex_unlock(&adev->lsdma.lock);
>>>       return ret;
>>>   }
>>> +
>>> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
>>> +{
>>> +    struct amdgpu_ib ib;
>>> +    int i, r;
>>> +    u64 gpu_addr;
>>> +    char *p;
>>> +    u32 size = 128;
>>> +
>>> +    memset(&ib, 0, sizeof(ib));
>>> +    r = amdgpu_ib_get(adev, NULL, 2 * size, AMDGPU_IB_POOL_DIRECT, 
>>> &ib);
>>> +    if (r)
>>> +        return r;
>>> +
>>> +    gpu_addr = ib.gpu_addr;
>>> +    p = (char *)ib.ptr;
>>> +    memset(p, 0, 2 * size);
>>> +
>>> +    for (i = 0; i < size; i++)
>>> +        *(p + i) = i;
>>> +
>>> +    dev_dbg(adev->dev, "copy src 0x%llx dst 0x%llx size %d bytes\n",
>>> +        gpu_addr, gpu_addr + size, size);
>>> +
>>> +    r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, size);
>>> +    if (r)
>>> +        goto out;
>>> +
>>> +    p += size;
>>> +    for (i = 0; i < size; i++) {
>>> +        if (*(p + i) != i) {
>>> +            dev_dbg(adev->dev, "data mismatch expecting 0x%x but 
>>> read 0x%x\n",
>>> +                i, *(p + i));
>>> +            break;
>>> +        }
>>> +    }
>>> +    if (i != size)
>>> +        r = -EIO;
>>> +
>>> +out:
>>> +    amdgpu_ib_free(&ib, NULL);
>>> +
>>> +    if (r)
>>> +        dev_dbg(adev->dev, "lsdma selftest failed r=%d\n", r);
>>> +    else
>>> +        dev_dbg(adev->dev, "lsdma selftest passed\n");
>>> +
>>> +    return r;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>> index 34e92aaa4617..f0a5eeb3529f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>> @@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device 
>>> *adev, uint64_t dst_addr,
>>>                 uint32_t data, uint64_t mem_size);
>>>   int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t 
>>> reg_index,
>>>                 uint32_t reg_val, uint32_t mask);
>>> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
>>>     #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> index 339f639a450e..86e0dc8d728e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> @@ -39,8 +39,6 @@ static void deactivate_accelerator(struct 
>>> amdgpu_device *adev);
>>>   static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>>                   u32 remote_accel_id, u32 dw0, u32 dw1,
>>>                   u32 dw2, u32 dw3);
>>> -static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev,
>>> -                    u32 flush_type);
>>>   static int amdgpu_ualink_reserve_npa_vm_and_bos(struct 
>>> amdgpu_device *adev,
>>>                           struct amdgpu_bo *bos[], u32 n_bos,
>>>                           struct drm_exec *exec,
>>> @@ -4333,9 +4331,6 @@ void amdgpu_ualink_manager_stop(struct 
>>> amdgpu_device *adev)
>>>    * UALink remote interrupt and shootdown
>>>    */
>>>   -/* UALINK ring buffer size, same for both remote shootdown and 
>>> interrupt ring */
>>> -#define AMDGPU_UALINK_RB_SIZE    4096
>>> -
>>>   #define AMDGPU_UALINK_METADATA_HEADER    0x4E485446
>>>     /* 2MB NPA start address for 2MB page mapping */
>>> @@ -4582,7 +4577,7 @@ static inline u32 ualink_tlb_wb_offset(struct 
>>> amdgpu_device *adev, u32 accel_id)
>>>       return ualink_wb_offset(adev, accel_id) + sizeof(struct 
>>> amdgpu_ualink_wb);
>>>   }
>>>   -static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, 
>>> u32 flush_type)
>>> +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 
>>> flush_type)
>>>   {
>>>       u32 bit;
>>>   @@ -5281,7 +5276,8 @@ static int 
>>> amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>>       if (status != AMDGPU_NHT_FW_ST_PREINIT &&
>>>           status != AMDGPU_NHT_FW_ST_HALT) {
>>>           dev_dbg(adev->dev, "fw status 0x%x not preinit or halt\n", 
>>> status);
>>> -        return -ENODEV;
>>> +        if (!adev->ualink.selftesting)
>>> +            return -ENODEV;
>>>       }
>>>         dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
>>> @@ -5399,6 +5395,8 @@ static int amdgpu_ualink_metadata_init(struct 
>>> amdgpu_device *adev)
>>>       r = adev->ualink.msg_ctl->send_metadata(adev,
>>>                               remote->metadata_gpu_addr,
>>>                               AMDGPU_UALINK_ACCEL_MAX << 8);
>>> +    if (r && adev->ualink.selftesting)
>>> +        r = 0;
>>>     out:
>>>       if (r)
>>> @@ -6384,11 +6382,216 @@ void amdgpu_ualink_sw_fini(struct 
>>> amdgpu_device *adev)
>>>       adev->ualink.remote = NULL;
>>>   }
>>>   -int ualink_send_hello(struct amdgpu_device *adev, u32 
>>> remote_accel_id)
>>> +/* byte offset of the local interrupt ring a remote GPU writes to */
>>> +static u32 ualink_test_local_rb_offset(u32 remote_accel_id)
>>> +{
>>> +    u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>>> +
>>> +    /* remote shootdown ring is first, remote interrupt ring 
>>> follows it */
>>> +    return rb_size * remote_accel_id + AMDGPU_UALINK_RB_SIZE;
>>> +}
>>> +
>>> +/*
>>> + * ualink_test_local_data - read or write the local ring buffer of 
>>> a remote GPU
>>> + *
>>> + * The local ring buffer is partitioned per remote GPU, 
>>> @remote_accel_id selects
>>> + * the interrupt ring that remote GPU writes to through its NPA 
>>> mapping. Read it
>>> + * to see what the remote GPU wrote, write it to provide the data 
>>> it reads.
>>> + */
>>> +int ualink_test_local_data(struct amdgpu_device *adev, u32 
>>> remote_accel_id,
>>> +               void *data, u32 size, bool read)
>>>   {
>>> +    struct amdgpu_ualink_remote *remote = to_remote(adev);
>>> +    void *rb;
>>> +
>>> +    if (!remote || !remote->rb_cpu_addr)
>>> +        return -EINVAL;
>>> +
>>> +    if (size > AMDGPU_UALINK_RB_SIZE)
>>> +        return -EINVAL;
>>> +
>>> +    rb = remote->rb_cpu_addr + 
>>> ualink_test_local_rb_offset(remote_accel_id);
>>> +
>>> +    dev_dbg(adev->dev, "%s local rb of remote %u at 0x%p size 0x%x\n",
>>> +        read ? "read" : "write", remote_accel_id, rb, size);
>>> +
>>> +    if (read)
>>> +        memcpy(data, rb, size);
>>> +    else
>>> +        memcpy(rb, data, size);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/*
>>> + * ualink_test_remote_rw - read or write the remote GPU ring buffer
>>> + *
>>> + * Copy @size bytes between @data and the remote GPU ring buffer 
>>> NPA address
>>> + * using lsdma or sdma. The DMA engines cannot access @data, the 
>>> local ring
>>> + * buffer of the same remote GPU is used to stage it, so 
>>> local_test_data shows
>>> + * what was sent or received.
>>> + *
>>> + * Works with or without MPNHT FW running, the copy does not update 
>>> wptr and
>>> + * does not ring the doorbell.
>>> + */
>>> +int ualink_test_remote_rw(struct amdgpu_device *adev, u32 
>>> remote_accel_id,
>>> +              void *data, u32 size, bool read, bool use_lsdma)
>>> +{
>>> +    struct amdgpu_ualink_remote *remote = to_remote(adev);
>>> +    struct amdgpu_ualink_peer *peer;
>>> +    struct amdgpu_ualink_ring *ring;
>>> +    struct dma_fence *fence;
>>> +    struct amdgpu_job *job;
>>> +    struct amdgpu_ib *ib;
>>> +    u64 npa, local;
>>> +    u32 offset, ndw;
>>> +    int r;
>>> +
>>> +    if (!remote)
>>> +        return -EINVAL;
>>> +
>>> +    if (size > AMDGPU_UALINK_RB_SIZE)
>>> +        return -EINVAL;
>>> +
>>> +    peer = &remote->peer[remote_accel_id];
>>> +    ring = &peer->interrupt;
>>> +
>>> +    guard(mutex)(&peer->lock);
>>> +
>>> +    offset = ualink_test_local_rb_offset(remote_accel_id);
>>> +    local = remote->rb_gpu_addr + offset;
>>> +    npa = ring->rb_npa_gart;
>>> +
>>> +    if (!read)
>>> +        memcpy(remote->rb_cpu_addr + offset, data, size);
>>> +
>>> +    remote->use_lsdma = use_lsdma;
>>> +
>>> +    dev_dbg(adev->dev, "%s remote %u npa 0x%llx local 0x%llx size 
>>> 0x%x use %s\n",
>>> +        read ? "read" : "write", remote_accel_id, npa, local, size,
>>> +        use_lsdma ? "lsdma" : "sdma");
>>> +
>>> +    if (use_lsdma) {
>>> +        r = amdgpu_lsdma_copy_mem(adev, read ? npa : local,
>>> +                      read ? local : npa, size);
>>> +        if (r)
>>> +            return r;
>>> +
>>> +        goto done;
>>> +    }
>>> +
>>> +    /* sdma linear copy command, align to 8 dwords boundary */
>>> +    ndw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>>> +
>>> +    r = amdgpu_job_alloc_with_ib(adev, &peer->entity, 
>>> AMDGPU_FENCE_OWNER_VM,
>>> +                     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>> +                     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>>> +    if (r)
>>> +        return r;
>>> +
>>> +    ib = job->ibs;
>>> +    ib->length_dw = 0;
>>> +
>>> +    amdgpu_emit_copy_buffer(adev, ib, read ? npa : local,
>>> +                read ? local : npa, size, 0);
>>> +    amdgpu_ring_pad_ib(&adev->sdma.instance[0].ring, ib);
>>> +    WARN_ON(ib->length_dw > ndw);
>>> +
>>> +    fence = amdgpu_job_submit(job);
>>> +
>>> +    r = dma_fence_wait_timeout(fence, false, HZ * 10);
>>> +    dma_fence_put(fence);
>>> +    if (r <= 0) {
>>> +        dev_dbg(adev->dev, "remote sdma fence wait timeout %d\n", r);
>>> +        dev_dbg(adev->dev, "use lsdma for testing afterwards\n");
>>> +        remote->use_lsdma = true;
>>> +        return -ETIME;
>>> +    }
>>> +
>>> +done:
>>> +    if (read)
>>> +        memcpy(data, remote->rb_cpu_addr + offset, size);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/* The peer may have rebooted or the vpod was reconfigured, adopt 
>>> the remote
>>> + * wptr before sending a command, same as the handshake does.
>>> + */
>>> +static int ualink_test_resync_peer(struct amdgpu_device *adev, u32 
>>> remote_accel_id)
>>> +{
>>> +    int r;
>>> +
>>> +    if (!adev->ualink.remote)
>>> +        return -EINVAL;
>>> +
>>> +    r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
>>> +    if (r < 0)
>>> +        return r;
>>> +
>>> +    /* Peer moved, drop ready so the next command updates the wb 
>>> address */
>>> +    if (r)
>>> +        amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int ualink_test_send_hello(struct amdgpu_device *adev, u32 
>>> remote_accel_id)
>>> +{
>>> +    int r;
>>> +
>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>> +    if (r)
>>> +        return r;
>>> +
>>>       return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
>>>   }
>>>   +int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 
>>> remote_accel_id,
>>> +                 u64 addr, u32 size_in_pages, u32 flush_type)
>>> +{
>>> +    int r;
>>> +
>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>> +    if (r)
>>> +        return r;
>>> +
>>> +    return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, addr,
>>> +                          size_in_pages, flush_type);
>>> +}
>>> +
>>> +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, u32 
>>> remote_accel_id)
>>> +{
>>> +    int r;
>>> +
>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>> +    if (r)
>>> +        return r;
>>> +
>>> + guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
>>> +
>>> +    /* Update interrupt completion write back address */
>>> +    r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>> +                        RB_TYPE_REMOTE_INTERRUPT);
>>> +    return r;
>>> +}
>>> +
>>> +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, u32 
>>> remote_accel_id)
>>> +{
>>> +    int r;
>>> +
>>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>>> +    if (r)
>>> +        return r;
>>> +
>>> + guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
>>> +
>>> +    /* Update shootdown completion write back address */
>>> +    r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>> +                        RB_TYPE_TLB_INV);
>>> +    return r;
>>> +}
>>> +
>>>   /*
>>>    * The low bits of handle_lo carry the message-header field on the 
>>> wire.
>>>    * Strip those bits and splice in @acc_id to recover the
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>> index 85c9a9634a4b..90e90cd8b495 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>> @@ -310,6 +310,9 @@ struct amdgpu_ualink_connection {
>>>       enum amdgpu_ualink_conn_state state;
>>>   };
>>>   +/* UALINK ring buffer size, same for both remote shootdown and 
>>> interrupt ring */
>>> +#define AMDGPU_UALINK_RB_SIZE    4096
>>> +
>>>   struct amdgpu_ualink_remote;
>>>     struct amdgpu_ualink_msg_ctl {
>>> @@ -333,6 +336,13 @@ struct amdgpu_ualink_mgr {
>>>       /* For remote interrupt and shootdown */
>>>       struct amdgpu_ualink_remote *remote;
>>>   +    /* true for selftest driver path, ignore FW error */
>>> +    bool selftesting;
>>> +    /* serialize the selftest debugfs entries */
>>> +    struct mutex selftest_mutex;
>>> +    u32 test_size_dwords;
>>> +    u32 test_remote_accel_id;
>>> +
>>>       /* handle irq from ualink client of remote GPUs */
>>>       struct amdgpu_irq_src irq;
>>>   @@ -390,14 +400,22 @@ struct amdgpu_ualink_mgr {
>>>       unsigned long drop_msg_bitmap;
>>>   };
>>>   +int ualink_test_local_data(struct amdgpu_device *adev, u32 
>>> remote_accel_id,
>>> +               void *data, u32 size, bool read);
>>> +int ualink_test_remote_rw(struct amdgpu_device *adev, u32 
>>> remote_accel_id,
>>> +              void *data, u32 size, bool read, bool use_lsdma);
>>> +int ualink_test_send_hello(struct amdgpu_device *adev, u32 
>>> remote_accel_id);
>>> +int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 
>>> remote_accel_id,
>>> +                 u64 addr, u32 size_in_pages, u32 flush_type);
>>> +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, u32 
>>> remote_accel_id);
>>> +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, u32 
>>> remote_accel_id);
>>> +
>>>   int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
>>>                    unsigned int client_id, unsigned int src_id);
>>> -
>>> +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 
>>> flush_type);
>>>   int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
>>>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
>>>   -int ualink_send_hello(struct amdgpu_device *adev, u32 
>>> remote_accel_id);
>>> -
>>>   int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev);
>>>   int amdgpu_ualink_pause_handler(struct amdgpu_device *adev);
>>>   int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
>
