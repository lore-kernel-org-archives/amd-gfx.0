Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9F0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 13:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B67161058
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 13:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B67161058
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B91656E02C;
	Thu, 11 Nov 2021 13:57:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A90C6E02C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 13:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5Qiztt3u6dwnlj6BHW4tbTIbHEyT1+db+gxWd0t0Z9l21+uRRpl9Z3e4wdvlKJWCIa1k3DZSkBGV0zDKT2vCblAV2NeKYxpCD5Br5F+ColAuyQKk3KjPwDCkrkVWoxEZ9CHTm/IalUDwR8BGgBtxQgi3cgvBjWc4S9zETBnsa0rllSlo6iyuqmWY9iTnmIe0aIKNZdPY7EdEu3q8oO0IFA5mJPHyy58Zw6yRtmJAzkeJ8vWenzi//04QyqoKhpA73+krwIj0QxYtFZznuIL9Ae2WmD5CWKjiSdZqgJNBUwWs1ezjpXtRFB+ME/GTpG5nk0K9I1+UxPKHfOXuTnasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McUbR18fkjOHEVmbponxvzKpRde0lZ6dVS2HGoe/Dkk=;
 b=QFnCt+Irvv3iWeJNvcYdMkZ1rF97jA47D/fbWkYtUuu10ozSs8f3GIeit2kZc4zGfiEjy+b4clU/dJi5fNgJa4Z9pqascTwYABXtQTD8uSILmkqtQV8LcxD3RSGYbT70E5xhYxzx5T/9QJXr4DYAeT6uS0AqqFtKwUFISVjsoElJntRTx7EaDH/myruDzh8nv8v1wQsQH094wG2GykXBeUu+aHdQxl2GHmwhjpYKVIJqBWTv+jg4VQMwD2yUj369pGHZ1cL+LrR4xXo0blBsW+3kubdkhTstRygddor7l2c58bKkfh14sFxW1A/FupT0LO1Gqqj3Ph4aD4AHlKRd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McUbR18fkjOHEVmbponxvzKpRde0lZ6dVS2HGoe/Dkk=;
 b=jT7vTbFSlKqIQtLj7oLUsij+Q0hoI7ej0+neO5tVq2bE5Ro3OVUvsxUjtLpFOsjq05aUwF9gbWP410xIflz45xQiUeazyoOFN4tY1PKTRYlPvb+NjumAGm+NX3itChqmPYs+XoNky87W/LJCvQXcgfpV2029/eQE+V9VlNWkAwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 11 Nov
 2021 13:57:11 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 13:57:11 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
 <c5855126-de94-f2b4-c912-f386b6b47142@amd.com>
 <9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com>
 <5e646384-ce7a-9a80-f97c-ae9592e39bbc@amd.com>
 <6e566851-0372-b33b-011b-197d8321b875@gmail.com>
 <865585bf-84ac-ea2b-7e1d-a13aca7e4caf@amd.com>
 <f2005799-7371-9cfd-d3bb-7a531914175e@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8b830540-1360-be79-ee4c-1c7fa75e8d56@amd.com>
Date: Thu, 11 Nov 2021 08:57:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <f2005799-7371-9cfd-d3bb-7a531914175e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::17) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT3PR01CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Thu, 11 Nov 2021 13:57:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe031ef-82f8-4bbe-9a21-08d9a51b2842
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5096D7B5804F46F25E916A1592949@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: llr+b18CGGX1Fr54hyIS1GmYrNRiKXXOjWtmNys3PN6+/YBoql77UNc08H4wicP8Z6j3ROL4RKY27T+uiNbAmH977c4i7Ge7GhSX3ELbz0UKcakpfRlZH3GGwXFuBJABIomCMZGppHYCWOUw4veBnsMsFhqIFeCesPsxwQ/fX2ZB+BLtnWx9gk35J282j9MkLLEbMfiHO1x1LJntrX+1TNOxL6ujtqnd6x67GMOXv0z0cYrlVRBNzFHMw0ScOlxh2woVqgcevZDzDERQcEEk0vzy+cmdfRUbmiPnuEQcZW3O/3IkiREKs8ESHWvuEPkT+URsEPos9PSohXby0mAXIKA2+PF+o38PBkpuT/lI3mqhlnvZYMf7XC9ikI+vRp2//M3Gkfsd5bOQHFl4c9yndjuFsEwSTCrcDAo70NzLkRJysSCmpwxdYvwkv3df0XSwhdidwn5rdhGeBNRfTJg/dBmfKnpagqnYpNEfaQzP/UeG+AcM2uDNqe0j/VARDvRs901jA/DJJT9AcW8aFEHHkciXHEbXbz/IETiO5DfH5GKO96DQJtSDdOKWjjDhuZ5lknJDm0ZmJcmnXDffimsklYU1zwG7tn2MPEYK4X9r78LT6vsY8Y+4TdSAj7Oc5uSckVt/wZ+USYSoeLgK5B2RSxsn+Euc2g1D6kUulnlmj3f+4Me2PLr0v3oowkMkJB9m2HAYkeSP7qRqRgoiNq1lziUgn/x8ljGE5qTX22YkaeKoNRgQMcBJXq2kwfrTDZ4B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(53546011)(26005)(186003)(508600001)(66574015)(83380400001)(110136005)(4001150100001)(5660300002)(8676002)(316002)(38100700002)(2906002)(956004)(16576012)(8936002)(2616005)(44832011)(66946007)(66556008)(36756003)(66476007)(31686004)(6486002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG4vcVdlcmNEZUFERG5uSjM0SjZMbDgweFgrSFBQVGxVMXNobjREd0dYRGk2?=
 =?utf-8?B?a1NaZUFlcHFRSWg3N1lvV3FnQTdkaDhuc1ZVSjZlc0Zwa29pck5YMENvdmF0?=
 =?utf-8?B?OFlwcmdnWFpMeUtMSXV5ZUkxZGVycHJ0U2VJMWpSSzBjaWwzUmRzaHZPQWxr?=
 =?utf-8?B?amFQcWNYZFhiRG5GcTBmUkp6SHpkaGxlUGFvZlFkdm96UVdycVdyTlJhcFJi?=
 =?utf-8?B?Vld6MmovZkREYkpEeGI0d3VtS3cyS2Y1b3IzREZGcmhiT1BpcHFnbmUzN3k5?=
 =?utf-8?B?MWFFelRtU3VuVDRpWW9VaUJMMC9Ra3NsU1FMSXFWSTdqNVpTMVRMd3luVCtO?=
 =?utf-8?B?Z202LzFhLzVyMnppNTZzdHA1RXk3L0tYUC80OGZwemJwUitYcENmWXVQS2NI?=
 =?utf-8?B?U3Z0VzVBaEJKUllFQTV4dDN4a1NkMG55U1l2cmVpbzIyVENacVh1OWVPaEsy?=
 =?utf-8?B?MkhBL2hzMWFMWnFhYW1YREhUY1Y5eFpzcFJjLzhudTBVdkhiSXNEaVZPNTgz?=
 =?utf-8?B?aURFVDF4YU5BWW0wWU1yQ2p4UnNrZDRvUVFCeVRSRUlRc1NSTCtTSVloamhl?=
 =?utf-8?B?NmxPc1hyMWN4dkpmOEUyUnErVml4VURNcitLYzJ5OG1kZEdRY01GbmZlQVhE?=
 =?utf-8?B?Q2NBUkNLbnhHY1dmKzA2S0wrQjZheHh6QU1icGdqMVk5Qlc2ajhKdlZacDkz?=
 =?utf-8?B?b1dnZGE3MGVXekVYRjFaaUJlWk9GTmsvS1d3MjZIMXg2N2h2VmVtRG9RZWIw?=
 =?utf-8?B?Snp0eEJDTGE4SkJZT0lZbDRoSHZRMWNKSEsxZEV0R2k1enNMOW5IVnRjTUhC?=
 =?utf-8?B?Y1Q0NHBqL2pCOW1IQmZuQk9RaXQ0OUF1UDJLc2E0cU5ZbHBJN2huU1hvUjJy?=
 =?utf-8?B?ZFI5bG4rZ1BVSVlWNTd4eVpSTjY2NzE4eGJEcU90QStKNHlyd09DMXJTNFk3?=
 =?utf-8?B?cXFiWElPMDZ6L0pDTHFIbUowUEJNTXZ1MUZVUnJoZ203V0I3M29FME44L3BB?=
 =?utf-8?B?bmVjcE51L2YwVHZtZVdEV2dEN2k5dUtUUlJMVUFiRlRzaFRQQ0xmYUV6Nm1W?=
 =?utf-8?B?eXo1VzNTeWw0US9OM0daVStpQitzU09aN1JHZmdBRWJDYk1rc1lvTjc0VVgy?=
 =?utf-8?B?ZlBnODlCNzMzUFpZdDFENmZsdHVnUjc0Z1hLN2J2enFPR2lKSUxBSHQ5WVd1?=
 =?utf-8?B?b3N2WDlKSEJlblVKZmlnWGROem8zaGpKb3VvV001RTczUmNESXB1QXIxZXBm?=
 =?utf-8?B?ekpReFZhcVIveVowcEZuSzlIVEdnV2gxZ2FrUC9yZ2xETFlKM0RqZzBaZzha?=
 =?utf-8?B?YmdhWTR5enVEWU9WWnZXYlRLalROQUFLZFVhZ1N0M1dwNEVjYTBIN0t0SUNE?=
 =?utf-8?B?VnBIcXhLMTkwY2pPMXpBQ3duWjhSY3p3aStxMkZoTzBKY0h0VW5CQTBSVmdH?=
 =?utf-8?B?YVVhQWxGa1dOV2JLVko0SUpqdDdJcDhxM1B5QnUxbVpTMmFWSjZ0MlpZbEhH?=
 =?utf-8?B?aDRVa0JyUFpqTFRRQnJpK3NhYWNNSU10ZXBBMEhSTWtHdGxwUGh1VW5uNXg0?=
 =?utf-8?B?eDdPTTBmQ2o4VjVzMFRqM3dTSmJGVndaL1pJYnNlSG9SaDRMRGo1QVdMelQ1?=
 =?utf-8?B?cE5peVNOajlmMUZuWCtJY3UvNEkybUo5aC9JRTNHcW42WFMxSml4OVV0TWl5?=
 =?utf-8?B?NWVrU3Vsd3VrRURMRFJ5TWtUa1plTjBNZEVGVjlXOWltWWhxVW1ONFdkNkxL?=
 =?utf-8?B?bVBwSUJpb1dRcTN5TDVOTHJSTUZMWG5nSk1ueTdWdWRDVzBCWXI4akppTEF5?=
 =?utf-8?B?V2V4Y0ljNWYwK1B0UzVLb1VyY0dZdTVGZlMraDV1OFhGVVJxVXVDb0lydzdX?=
 =?utf-8?B?YkJQVmJLYWpYVk55N0I0Zi9LbUNWczVtNmtwcHgyYjZlbkduZnpxbGI4Uzhq?=
 =?utf-8?B?RDVmS25uRFdmaXhOajA4TldaTnVRTFdrMjB2c2cvNDdFamxabmlJbzluZkdm?=
 =?utf-8?B?R2xSM0VzN21JaENJL3c5MEFGKzgxZGZrNmt2MFZTZUkvWUtPdVFEL2JRbDZR?=
 =?utf-8?B?UkNJV0JUWm9DVjUxc29GMWx1WWpZUERUQzZBdjQzUWVvUzNGZi9HL1BkLzFj?=
 =?utf-8?B?SThwQ25qdnc1M2IrM2xCekQ2bExaVityV0xseTh6Sm52RVB1S2VTeDh5SzdO?=
 =?utf-8?Q?q892tobbbpU9gfsK1rUOzbg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe031ef-82f8-4bbe-9a21-08d9a51b2842
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 13:57:11.0228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqzNr9abvUlIyqCKOeDWiTxsAjkNfESPxntBE5gu/qtFwJjxm20+nAogh3uSy71fMon6SVCE9L/eDs5AXOB22w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
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

Am 2021-11-11 um 8:43 a.m. schrieb Christian König:
> Am 11.11.21 um 13:13 schrieb Felix Kuehling:
>> Am 2021-11-11 um 2:00 a.m. schrieb Christian König:
>>> Am 11.11.21 um 00:36 schrieb Felix Kuehling:
>>>> On 2021-11-10 9:31 a.m., Christian König wrote:
>>>> [SNIP]
>>>> Aren't we processing interrupts out-of-order in this case. We're
>>>> processing newer ones before older ones. Is that the root of the
>>>> problem because it confuses our interrupt draining function?
>>> Good point.
>>>
>>>> Maybe we need to detect overflows in the interrupt draining function
>>>> to make it wait longer in that case.
>>> Ideally we should use something which is completely separate from all
>>> those implementation details.
>>>
>>> Like for example using the timestamp or a separate indicator/counter
>>> instead.
>> Even a timestamp will be broken if the interrupt processing function
>> handles interrupts out of order.
>
> We can easily detect if the timestamp is going backwards and so filter
> out stale entries.
>
>> I think we need a different amdgpu_ih_process function for IH ring 1 the
>> way we set it up to handle overflows. Because IH is just overwriting
>> older entries, and we can't read entire IH entries atomically, we have
>> to use a watermark. If IH WPTR passes the watermark, we have to consider
>> the ring overflowed and reset our RPTR. We have to set RPTR far enough
>> "ahead" of the current WPTR to make sure WPTR is under the watermark.
>> And the watermark needs to be low enough to ensure amdgpu_irq_dispatch
>> can read out the next IH entry before the WPTR catches up with the RPTR.
>>
>> Since we don't read the WPTR on every iteration, and out page fault
>> handling code can take quite a while to process one fault, the watermark
>> needs to provide a lot of buffer. Maybe we also need to read the WPTR
>> register more frequently if the last read was more than a jiffy ago.
>
> I think trying to solve that with the IH code or hardware is the
> completely wrong approach.
>
> As I said before we need to something more robust and using the
> timestamp sounds like the most logical approach to me.
>
> The only alternative I can see would be to have a hardware assisted
> flag which tells you if you had an overflow or not like we have for IH
> ring 0.

The *_ih_get_wptr functions already do some overflow handling. I think
we'll need a function to read the overflow bit that amdgpu_ih_process
can call separately, after reading IH entries.


>
> E.g. something like the following:
> 1. Copy the next N IV from the RPTR location.
> 2. Get the current WPTR.
> 3. If the overflow bit in the WPTR is set update the RPTR to something
> like WPTR+window, clear the overflow bit and repeat at #1.
> 4. Process the valid IVs.

OK. Current amdgpu_irq_dispatch reads directly from the IH ring. I think
you're proposing to move reading of the ring into amdgpu_ih_process
where we can discard the entries if an overflow is detected.

Then let amdgpu_irq_dispatch use a copy that's guaranteed to be consistent.


>
> The down side is that we are loosing a lot of IVs with that. That is
> probably ok for the current approach, but most likely a bad idea if we
> enable the CAM.

Right. Once we use the CAM we cannot afford to lose faults. If we do, we
need to clear the CAM.

Regards,
  Felix


>
> Regards,
> Christian.
>
>>
>> Whenever an overflow (over the watermark) is detected, we can set a
>> sticky overflow bit that our page fault handling code can use to clean
>> up. E.g. once we start using the CAM filter, we'll have to invalidate
>> all CAM entries when this happens (although I'd expect overflows to
>> become impossible once we enable the CAM filter).
>>
>> Thanks,
>>    Felix
>>
>
