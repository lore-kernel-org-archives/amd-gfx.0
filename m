Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E257C2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 16:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D91611CA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 16:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D91611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C878C6E0D7;
	Fri, 28 May 2021 16:39:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7231F6E0D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 16:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ccf66ECy7VofB+kjkIf5f90HLrhayM0zmI1oUEQVkzgj8MfLl2x253HXA2QiqUYrnXxQ0FIlOyjyu3CKumE8L9ErgAxvdm/nqLp16gweyVND+Whz/WkCxdu1HuNyQYpj53VHMjLILxUvRljpaALmxiF1npJW2Lm9w+virOWFdfTIokH4/Re+/8Z+54FZdxUl8FI9Kp3Gba7AFywvpAMOyHIaGomBp9ZlXpFbmj7huPG4f3bHA52Ndg98MYhHge18+i9K2L6rWEF4/O/EnD5/1Ctb5UZox4XZfwjIq83pnB6T9sUmS0rXW6P/+eIi8XZpPEVmFISDFIp4TLdZacZ3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBx3g+wl/VIuKjY1FBLcUUU2NkI541EkmGUDMG7cJcw=;
 b=iKtgy8RBF8IHh1vR+WBkAqMqeMroBqq3xNcbQXA6aSA6sFyGO6AilXjkWsctHhMEwHSzCT/9YaW5nVbYg0F3lGJMYsKtIYS/Fj2pis0OKjj3YtHNWnRbosDWYyMOlnGFdeSle3GaTaELyM+eE5P+FqYQlxddclxEbzMAStwMmqT2v8WIYsjYrjX5wR9FbCSgl26Suqc/Wd/jzollbdtyRsM7yUX3UFEAxSsrqCkT29tTOB/8R4S8isLnxg1sKCkl+Iu3ALSenGUklP1zeLPD7CrWtWhiTNVNpibkgque2skAVEtyRIpt+y+DWiOkaXjx/Or30YurmWCQmVlfUZLvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBx3g+wl/VIuKjY1FBLcUUU2NkI541EkmGUDMG7cJcw=;
 b=o2r8vrYM4bxFHt1SHKdiKPHWm04NBC5tm4PYa6gYxBCjpPVXkAw60QBELX5YtfnZxBcmexGTZVwEZn3SeHE6JCIt02k78ZDLPzdIhWXg+w4oksYSIsc5vf3w5ST5FVmN5R5qXnG4VwmOQG+Yo4QqAhNGNgEOoBqPKe5ZPIyuno0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB2907.namprd12.prod.outlook.com (2603:10b6:5:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 16:39:33 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4173.021; Fri, 28 May 2021
 16:39:33 +0000
Subject: Re: [PATCH] drm/amdkfd: move flushing TLBs from map to unmap
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 philip yang <yangp@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <fab1b78c-d6a9-2c23-368c-9cb1999e3aa8@amd.com>
 <b19402db-5b60-2cc2-991b-87c6190ac630@amd.com>
 <236a115f-7209-37ea-277a-ec86ec57f9ce@amd.com>
 <80a52ee7-0a94-0861-128e-ab23d209987e@amd.com>
 <9a71e303-f582-f658-f62c-dcda29c182d3@amd.com>
 <58d8ea74-9e74-540e-4845-55ac88746693@gmail.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <053a6651-a469-1c8d-63c4-baa25ce7fd50@amd.com>
Date: Fri, 28 May 2021 12:39:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <58d8ea74-9e74-540e-4845-55ac88746693@gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:889c:5e2:3561:6b91]
X-ClientProxiedBy: YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::33) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:889c:5e2:3561:6b91]
 (2607:9880:2048:122:889c:5e2:3561:6b91) by
 YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.26 via Frontend Transport; Fri, 28 May 2021 16:39:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a3ee993-05f5-4897-8aa5-08d921f72c37
X-MS-TrafficTypeDiagnostic: DM6PR12MB2907:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB290769C281E4FB6278CBC79E82229@DM6PR12MB2907.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKOlwhgmzxhvOu5kYpxGBNvbkmeAu7Z3VwbiIuSh/ItQ2YoXhZS+Raqj9zghTpSuw6Ic3Wzb/4fplOH6V6NDPueFBfLHNplGCPVpzMNo9BJSc4jZIMjOIP0TTW++shPmK2FM46XIsHZwfb7mZW8c/Xdst8Nwj8BPWPHAiKHoQlaP2rRGOaE8OUZt9GFYwTcEMhrMTg2CycYgKrNVINPM0t8bTkggpfnzsixo3nVm1COqiulzOb/rubPMhA4X84VrqVgCuS19AO4QNqtECsyqb4wYd+7XiaUaLCxQvavRyQ1ofHCK6F/Zl76LE7UxUXngRAcsNTOyP099Izvx4iDYVyOB4vaMUauJIyxl7fjwQMTpxnAZDSOZlK5aTHuzh60TPqvLvhQ3hocZunUYmeq/d9nKfwouBxIs62VPPgnZvgHg4vrNPZ9tR657pR3JgTN8HDxzRmxaPdlqbE8oi8AlOoSYIso7tBaVat2OnsVEuPwueVqewEyUQNOaDx85DAb9bcSWCXwMGAAwDO8RlTJiRAgKSTA603pad3DVfCV4hD097LIup9HdrG9vFW4drQitxkZwQy7FySuM8EDPr77Ng6gwVZ3Wuf+3hPpBtcMKyQJNpMcDEVfvrTSvaowHIuhCK2i9gndsYUdrOYBMUgIoa8njUp+9hACtxBKgio9pWAtMgfjbuVjGZqo8r1DGyFgnlwvVRNm2JJGI3Md+lCrCqWh76/UNlFeoQOnSzOXUMro=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(966005)(2906002)(478600001)(86362001)(38100700002)(31696002)(45080400002)(66946007)(31686004)(66476007)(66556008)(316002)(8936002)(6486002)(110136005)(5660300002)(30864003)(2616005)(8676002)(166002)(16526019)(186003)(53546011)(66574015)(36756003)(33964004)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M0VJanlWalRrVkRIZDNvcXorZHR5bHZLOTlHc1pEZ3NYOXgvYzUxOTBGQ2dX?=
 =?utf-8?B?TWNVaE51Wnp6L3hVL0ZCL2dUR3RvTmE0VVZxNVdCbHV2elFLY3EyM2tiQnU5?=
 =?utf-8?B?M1ExUnAwOFl2ZDR6VjJMSnMrWEpERXNyM0N1b0dvNmdSc2VCVFNXM2tQRXFq?=
 =?utf-8?B?OEVQeDFOTVZLRHNEVjh2M2RlM0NtNzAwNlNUMmhBb3pzaWxJSEg4aEdEUnRQ?=
 =?utf-8?B?WDdxT1ljcE52cVV0THVwYlpnQTNheG5GZ2VJTEFxa1RhL2NZK3NrMTQ0My8w?=
 =?utf-8?B?OHAwKzRsa0JTcjVjNWV5S1JvaWt6V2tpVWRaQVdKalhGbDdIQWNUNnI1L3k5?=
 =?utf-8?B?b3hMMkhtMXpsRDFrRFhHeWFNTUtraGZGRFpGRDBMVHYwdWhWMTVtSXNzOFZG?=
 =?utf-8?B?T2tDWHNpWTFGQ0lCVGZzSGNVcldqTHp4dW1QL2N0SU5HTUQ0TSthZHdlZ0xB?=
 =?utf-8?B?eVB0dXkyRUxBdVU1MndNc2pwNk9WSlhiRkxZL000VXI4Qng3Q2ZzODZ2Wjh2?=
 =?utf-8?B?SHN0czR6NW1NRkQ4czU3a2JaU25pMlExNVNwbFRDR1JOMmdZUzBFSmN5eG92?=
 =?utf-8?B?K241RXhpT215aDhQNUpyMWdqTEJ1RHZwaGJhaFIwR0J0S3Y1MmlTeUowK2lm?=
 =?utf-8?B?MzhoczJod2tYajVFTmgyNSsxSEZraDdpczRTZERPbjJPdUluN2FUdU9LbHRN?=
 =?utf-8?B?MERuSGt0TGorVlFwOGNDV2ZZS3FteUlGUE5ycFIyTFVRakxuWWxDaFB6YzEz?=
 =?utf-8?B?VFhuUlBlQlBZeGJFY0VEOXFwemxqT2dETS8xVEVCZTJucVB5bnpEaVBCUC91?=
 =?utf-8?B?VW9MOFQvWktBUEl5T0pwbGhiVmhLNlpuU1BqekoxV0poVGhYcFg0Z2pZeThh?=
 =?utf-8?B?T1psaU1VMWoybUdGdUJmQ25zd2pEQkx3OW9uK3g5U29USVZBbzFZZ29RRmJK?=
 =?utf-8?B?UnN2Ky90cFhOQm9CRXp4QnR1VG05OGkwZ0Vuem9DdFZyWXJKZENNZXVITTZ1?=
 =?utf-8?B?Zjh2YVBVeSt1SjdIMUh4WVlFS2xydWQzRDdwSHcyNmZsbG9qZlNKQ1RtNjhh?=
 =?utf-8?B?bFNOL2h2QVRhbzQycXhjVnVLdjMzeW1XeU1HMHVxeU9uT2lVNTZCNG11aSts?=
 =?utf-8?B?ODlpajV4bndLRUthM0tQNkUwS0orcnRBQmtGMTh0K0FJN2FUREdVTFhQd3RF?=
 =?utf-8?B?VUVjS3NScUp0aWRoVFNBY2YvS05GcFYrcE1FdUlEYVM4SDh1WWFYSDN0MVpm?=
 =?utf-8?B?bHBBbHhZS3daTlR3Vm9LMlNzR0h3cGhOVzNTNDV5VGdnYkVqOVdTZHBtZXBE?=
 =?utf-8?B?VW4rWVpPYko1QzBUYjNDRC9qYTdMQ0hoNzg0Z3B2b3JnZVVuSXRod2MrdzJC?=
 =?utf-8?B?Z0FUWVVlQWM4UWtpbnE1UVZyOHpFZXgxTkNsZkZmNS9OaXBQb0tvU09iSjJC?=
 =?utf-8?B?TEhQam4rclR0cXRqSzVRNjlNR1BKdXdpQ1N3UDlybDl0WVFIa0JZc1JuU2JN?=
 =?utf-8?B?VXhsTE9GNmlJVWJUaGozR2V4VFJFRHVNc3JhOHhtQ3g4M0E1SUFDbS9XUHhC?=
 =?utf-8?B?YmIvcnM2cncvek5acFlzQWtQcXBNd0g0OWI3UmIyTGxIalZydGJiYnYzblp6?=
 =?utf-8?B?djRrOFVvRGg1eEcxdGRxVzQwS2I4VWtmMlQ2MXY1cUMrR1lBK2RtUDVyU0JQ?=
 =?utf-8?B?SU5WZFZtRTMvdkk4aUZ6K1MzYllNZ3A0MTlVQjdkeUtsQk13YU9iQjh3ZEkw?=
 =?utf-8?B?NFVrbUFVVjhWNDVUS0hiVDY2S3Z3bFhHUGdQVlRROUpQc3grUkkzN2hwUThz?=
 =?utf-8?B?ZktmZ0UrVzVjR3lSbzJZWC9oZHN4M2xFV1JYTEh5ZVZ3SXFkVis3U2tISlli?=
 =?utf-8?Q?9YkoKSXu6ME23?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3ee993-05f5-4897-8aa5-08d921f72c37
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 16:39:33.5310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr64LTj8rzNtE+0iQl+sxlYHrg2M5w1dTJsez3ky9Nftw3C6rn4vYOQfcYf5a1AR1jezJEYKTR+tK1UFDGRT7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
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
Content-Type: multipart/mixed; boundary="===============0752271360=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0752271360==
Content-Type: multipart/alternative;
 boundary="------------318D6B55FF464BC941DD785B"
Content-Language: en-US

--------------318D6B55FF464BC941DD785B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-05-28 11:23 a.m., Christian König wrote:
>
>
> Am 27.05.21 um 16:05 schrieb philip yang:
>>
>>
>> On 2021-05-26 5:25 p.m., Felix Kuehling wrote:
>>> Am 2021-05-26 um 3:21 p.m. schrieb Eric Huang:
>>>> On 2021-05-25 3:16 p.m., Felix Kuehling wrote:
>>>>> Similar to a recent fix by Philip Yang 76e08b37d0aa ("drm/amdgpu: flush
>>>>> TLB if valid PDE turns into PTE"), there needs to be a conditional TLB
>>>>> flush after map, if any PDEs were unmapped and turned into PTEs in the
>>>>> process. This is currently returned by amdgpu_vm_bo_update_mapping in
>>>>> the "table_freed" parameter. This needs to be also returned by
>>>>> amdgpu_vm_bo_update and reported back to KFD, so KFD can do the TLB
>>>>> flush after map, if needed.
>>>> I follow up your suggestion to create another patch (attached) and
>>>> test it. It seems it doesn't improve the latency when memory size is
>>>> bigger than huge page (2M), because table_freed parameter will always
>>>> be true when mapping page is huge page size. I think Philip's patch is
>>>> to fix the case of remapping memory from small page to huge page in
>>>> HMM, but it doesn't consider if the memory is remapped and arbitrarily
>>>> flushes TLBs when mapping huge page.
>>> That's unexpected. Turning an invalid PDE into a valid (huge) PTE should
>>> not trigger a TLB flush.
>>
>> table_freed will be true if PDE has been used by previous mapping, 
>> unmap the previous mapping will clear the PTEs, leave PDE unchanged 
>> as P=0, V=1 (in memory and TLB), then huge page mapping turns PDE to 
>> PTE (P=1, V=1) in memory, and free PTE page.
>>
>
> I think there might be a little bug in your patch. See we set 
> params.table_freed to true when we call amdgpu_vm_free_pts(), but 
> amdgpu_vm_free_pts() doesn't necessary frees anything.
>
> It can be that all subsequent page tables where never allocated before.
>
> Christian.

After I printed infos in function amdgpu_vm_update_ptes(), when we map a 
memory with size 2M(huge page), the function will allocate 9 ptes (2M == 
PAGE_SIZE << 9) , until check "if (frag >= parent_shift)", then cursor 
goes up one level to PDE0 and frees all 9 ptes. So that is why 
table_freed is always true when mapping memory which size is bigger than 2M.

I will add some codes to check if PDE entry is valid before 
amdgpu_vm_update_flags(), and set table_freed accordingly. That will fix 
exactly page fault in the corner case above Philip mentioned.

Regards,
Eric

>
>> For example, test map 0x7ffe37401000, unmap it, and then map 
>> 0x7ffe3740000 2MB huge page, table_freed will be true, means that 
>> flush TLB is needed after mapping huge page.
>>
>> You can change the test, don't unmap previous mapping, then 2MB huge 
>> page will get new GPU virtual address, or closeKFD, openKFD again to 
>> create new GPU vm.
>>
>> Regards,
>>
>> Philip
>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>>> kfd_flush_tlb probably needs a new parameter to determine the flush
>>>>> type. The flush after map can be a "legacy" flush (type 0). The flush
>>>>> after unmap must be a "heavy-weight" flush (type 2) to make sure we
>>>>> don't evict cache lines into pages that we no longer own.
>>>>>
>>>>> Finally, in the ticket I thought about possible optimizations using a
>>>>> worker to minimize the impact of TLB flushes on unmap latency. That
>>>>> could be a follow up commit.
>>>> It is a good idea to use worker, but how do we grantee it done before
>>>> memory is remapped? if remapping depends on it, then more latency will
>>>> be introduced in map.
>>>>
>>>> Regards,
>>>> Eric
>>>>> Regards,
>>>>>     Felix
>>>>>
>>>>>
>>>>> Am 2021-05-25 um 1:53 p.m. schrieb Eric Huang:
>>>>>> It it to optimize memory allocation latency.
>>>>>>
>>>>>> Signed-off-by: Eric Huang<jinhuieric.huang@amd.com>
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> index 960913a35ee4..ab73741edb97 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> @@ -1657,20 +1657,6 @@ static int kfd_ioctl_map_memory_to_gpu(struct
>>>>>> file *filep,
>>>>>>                   goto sync_memory_failed;
>>>>>>           }
>>>>>>
>>>>>> -       /* Flush TLBs after waiting for the page table updates to
>>>>>> complete */
>>>>>> -       for (i = 0; i < args->n_devices; i++) {
>>>>>> -               peer = kfd_device_by_id(devices_arr[i]);
>>>>>> -               if (WARN_ON_ONCE(!peer))
>>>>>> -                       continue;
>>>>>> -               peer_pdd = kfd_get_process_device_data(peer, p);
>>>>>> -               if (WARN_ON_ONCE(!peer_pdd))
>>>>>> -                       continue;
>>>>>> -               if (!amdgpu_read_lock(peer->ddev, true)) {
>>>>>> -                       kfd_flush_tlb(peer_pdd);
>>>>>> -                       amdgpu_read_unlock(peer->ddev);
>>>>>> -               }
>>>>>> -       }
>>>>>> -
>>>>>>           kfree(devices_arr);
>>>>>>
>>>>>>           trace_kfd_map_memory_to_gpu_end(p,
>>>>>> @@ -1766,6 +1752,7 @@ static int
>>>>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>>>>                           amdgpu_read_unlock(peer->ddev);
>>>>>>                           goto unmap_memory_from_gpu_failed;
>>>>>>                   }
>>>>>> +               kfd_flush_tlb(peer_pdd);
>>>>>>                   amdgpu_read_unlock(peer->ddev);
>>>>>>                   args->n_success = i+1;
>>>>>>           }
>>>>>> _______________________________________________
>>>>>> amd-gfx mailing list
>>>>>> amd-gfx@lists.freedesktop.org
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;reserved=0
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;reserved=0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------318D6B55FF464BC941DD785B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+DQo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD11dGYtOCI+CiAgPC9oZWFkPgogIDxib2R5PgogICAgPGJyPgogICAg
PGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAyMDIxLTA1LTI4IDExOjIzIGEubS4sIENo
cmlzdGlhbgogICAgICBLw7ZuaWcgd3JvdGU6PGJyPgogICAgPC9kaXY+CiAgICA8YmxvY2txdW90
ZSB0eXBlPSJjaXRlIiBjaXRlPSJtaWQ6NThkOGVhNzQtOWU3NC01NDBlLTQ4NDUtNTVhYzg4NzQ2
NjkzQGdtYWlsLmNvbSI+CiAgICAgIAogICAgICA8YnI+CiAgICAgIDxicj4KICAgICAgPGRpdiBj
bGFzcz0ibW96LWNpdGUtcHJlZml4Ij5BbSAyNy4wNS4yMSB1bSAxNjowNSBzY2hyaWViIHBoaWxp
cAogICAgICAgIHlhbmc6PGJyPgogICAgICA8L2Rpdj4KICAgICAgPGJsb2NrcXVvdGUgdHlwZT0i
Y2l0ZSIgY2l0ZT0ibWlkOjlhNzFlMzAzLWY1ODItZjY1OC1mNjJjLWRjZGEyOWMxODJkM0BhbWQu
Y29tIj4KICAgICAgICA8cD48YnI+CiAgICAgICAgPC9wPgogICAgICAgIDxkaXYgY2xhc3M9Im1v
ei1jaXRlLXByZWZpeCI+T24gMjAyMS0wNS0yNiA1OjI1IHAubS4sIEZlbGl4CiAgICAgICAgICBL
dWVobGluZyB3cm90ZTo8YnI+CiAgICAgICAgPC9kaXY+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSIgY2l0ZT0ibWlkOjgwYTUyZWU3LTBhOTQtMDg2MS0xMjhlLWFiMjNkMjA5OTg3ZUBh
bWQuY29tIj4KICAgICAgICAgIDxwcmUgY2xhc3M9Im1vei1xdW90ZS1wcmUiIHdyYXA9IiI+QW0g
MjAyMS0wNS0yNiB1bSAzOjIxIHAubS4gc2NocmllYiBFcmljIEh1YW5nOgo8L3ByZT4KICAgICAg
ICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICA8cHJlIGNsYXNzPSJtb3ot
cXVvdGUtcHJlIiB3cmFwPSIiPk9uIDIwMjEtMDUtMjUgMzoxNiBwLm0uLCBGZWxpeCBLdWVobGlu
ZyB3cm90ZToKPC9wcmU+CiAgICAgICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAg
ICAgICAgICAgIDxwcmUgY2xhc3M9Im1vei1xdW90ZS1wcmUiIHdyYXA9IiI+U2ltaWxhciB0byBh
IHJlY2VudCBmaXggYnkgUGhpbGlwIFlhbmcgNzZlMDhiMzdkMGFhICgmcXVvdDtkcm0vYW1kZ3B1
OiBmbHVzaApUTEIgaWYgdmFsaWQgUERFIHR1cm5zIGludG8gUFRFJnF1b3Q7KSwgdGhlcmUgbmVl
ZHMgdG8gYmUgYSBjb25kaXRpb25hbCBUTEIKZmx1c2ggYWZ0ZXIgbWFwLCBpZiBhbnkgUERFcyB3
ZXJlIHVubWFwcGVkIGFuZCB0dXJuZWQgaW50byBQVEVzIGluIHRoZQpwcm9jZXNzLiBUaGlzIGlz
IGN1cnJlbnRseSByZXR1cm5lZCBieSBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcgaW4KdGhl
ICZxdW90O3RhYmxlX2ZyZWVkJnF1b3Q7IHBhcmFtZXRlci4gVGhpcyBuZWVkcyB0byBiZSBhbHNv
IHJldHVybmVkIGJ5CmFtZGdwdV92bV9ib191cGRhdGUgYW5kIHJlcG9ydGVkIGJhY2sgdG8gS0ZE
LCBzbyBLRkQgY2FuIGRvIHRoZSBUTEIKZmx1c2ggYWZ0ZXIgbWFwLCBpZiBuZWVkZWQuCjwvcHJl
PgogICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgIDxwcmUgY2xhc3M9Im1vei1x
dW90ZS1wcmUiIHdyYXA9IiI+SSBmb2xsb3cgdXAgeW91ciBzdWdnZXN0aW9uIHRvIGNyZWF0ZSBh
bm90aGVyIHBhdGNoIChhdHRhY2hlZCkgYW5kCnRlc3QgaXQuIEl0IHNlZW1zIGl0IGRvZXNuJ3Qg
aW1wcm92ZSB0aGUgbGF0ZW5jeSB3aGVuIG1lbW9yeSBzaXplIGlzCmJpZ2dlciB0aGFuIGh1Z2Ug
cGFnZSAoMk0pLCBiZWNhdXNlIHRhYmxlX2ZyZWVkIHBhcmFtZXRlciB3aWxsIGFsd2F5cwpiZSB0
cnVlIHdoZW4gbWFwcGluZyBwYWdlIGlzIGh1Z2UgcGFnZSBzaXplLiBJIHRoaW5rIFBoaWxpcCdz
IHBhdGNoIGlzCnRvIGZpeCB0aGUgY2FzZSBvZiByZW1hcHBpbmcgbWVtb3J5IGZyb20gc21hbGwg
cGFnZSB0byBodWdlIHBhZ2UgaW4KSE1NLCBidXQgaXQgZG9lc24ndCBjb25zaWRlciBpZiB0aGUg
bWVtb3J5IGlzIHJlbWFwcGVkIGFuZCBhcmJpdHJhcmlseQpmbHVzaGVzIFRMQnMgd2hlbiBtYXBw
aW5nIGh1Z2UgcGFnZS4KPC9wcmU+CiAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICA8
cHJlIGNsYXNzPSJtb3otcXVvdGUtcHJlIiB3cmFwPSIiPlRoYXQncyB1bmV4cGVjdGVkLiBUdXJu
aW5nIGFuIGludmFsaWQgUERFIGludG8gYSB2YWxpZCAoaHVnZSkgUFRFIHNob3VsZApub3QgdHJp
Z2dlciBhIFRMQiBmbHVzaC48L3ByZT4KICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgPHA+
dGFibGVfZnJlZWQgd2lsbCBiZSB0cnVlIGlmIFBERSBoYXMgYmVlbiB1c2VkIGJ5IHByZXZpb3Vz
CiAgICAgICAgICBtYXBwaW5nLCB1bm1hcCB0aGUgcHJldmlvdXMgbWFwcGluZyB3aWxsIGNsZWFy
IHRoZSBQVEVzLCBsZWF2ZQogICAgICAgICAgUERFIHVuY2hhbmdlZCBhcyBQPTAsIFY9MSAoaW4g
bWVtb3J5IGFuZCBUTEIpLCB0aGVuIGh1Z2UgcGFnZQogICAgICAgICAgbWFwcGluZyB0dXJucyBQ
REUgdG8gUFRFIChQPTEsIFY9MSkgaW4gbWVtb3J5LCBhbmQgZnJlZSBQVEUKICAgICAgICAgIHBh
Z2UuPC9wPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxicj4KICAgICAgSSB0aGluayB0aGVy
ZSBtaWdodCBiZSBhIGxpdHRsZSBidWcgaW4geW91ciBwYXRjaC4gU2VlIHdlIHNldAogICAgICBw
YXJhbXMudGFibGVfZnJlZWQgdG8gdHJ1ZSB3aGVuIHdlIGNhbGwgYW1kZ3B1X3ZtX2ZyZWVfcHRz
KCksIGJ1dAogICAgICBhbWRncHVfdm1fZnJlZV9wdHMoKSBkb2Vzbid0IG5lY2Vzc2FyeSBmcmVl
cyBhbnl0aGluZy48YnI+CiAgICAgIDxicj4KICAgICAgSXQgY2FuIGJlIHRoYXQgYWxsIHN1YnNl
cXVlbnQgcGFnZSB0YWJsZXMgd2hlcmUgbmV2ZXIgYWxsb2NhdGVkCiAgICAgIGJlZm9yZS48YnI+
CiAgICAgIDxicj4KICAgICAgQ2hyaXN0aWFuLjxicj4KICAgIDwvYmxvY2txdW90ZT4KICAgIDxi
cj4KICAgIEFmdGVyIEkgcHJpbnRlZCBpbmZvcyBpbiBmdW5jdGlvbiBhbWRncHVfdm1fdXBkYXRl
X3B0ZXMoKSwgd2hlbiB3ZQogICAgbWFwIGEgbWVtb3J5IHdpdGggc2l6ZSAyTShodWdlIHBhZ2Up
LCB0aGUgZnVuY3Rpb24gd2lsbCBhbGxvY2F0ZSA5CiAgICBwdGVzICgyTSA9PSBQQUdFX1NJWkUg
Jmx0OyZsdDsgOSkgLCB1bnRpbCBjaGVjayAmcXVvdDtpZiAoZnJhZyAmZ3Q7PQogICAgcGFyZW50
X3NoaWZ0KSZxdW90OywgdGhlbiBjdXJzb3IgZ29lcyB1cCBvbmUgbGV2ZWwgdG8gUERFMCBhbmQg
ZnJlZXMgYWxsCiAgICA5IHB0ZXMuIFNvIHRoYXQgaXMgd2h5IHRhYmxlX2ZyZWVkIGlzIGFsd2F5
cyB0cnVlIHdoZW4gbWFwcGluZwogICAgbWVtb3J5IHdoaWNoIHNpemUgaXMgYmlnZ2VyIHRoYW4g
Mk0uPGJyPgogICAgPGJyPgogICAgSSB3aWxsIGFkZCBzb21lIGNvZGVzIHRvIGNoZWNrIGlmIFBE
RSBlbnRyeSBpcyB2YWxpZCBiZWZvcmUKICAgIGFtZGdwdV92bV91cGRhdGVfZmxhZ3MoKSwgYW5k
IHNldCB0YWJsZV9mcmVlZCBhY2NvcmRpbmdseS4gVGhhdCB3aWxsCiAgICBmaXggZXhhY3RseSBw
YWdlIGZhdWx0IGluIHRoZSBjb3JuZXIgY2FzZSBhYm92ZSBQaGlsaXAgbWVudGlvbmVkLjxicj4K
ICAgIDxicj4KICAgIFJlZ2FyZHMsPGJyPgogICAgRXJpYzxicj4KICAgIDxicj4KICAgIDxibG9j
a3F1b3RlIHR5cGU9ImNpdGUiIGNpdGU9Im1pZDo1OGQ4ZWE3NC05ZTc0LTU0MGUtNDg0NS01NWFj
ODg3NDY2OTNAZ21haWwuY29tIj4gPGJyPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBj
aXRlPSJtaWQ6OWE3MWUzMDMtZjU4Mi1mNjU4LWY2MmMtZGNkYTI5YzE4MmQzQGFtZC5jb20iPgog
ICAgICAgIDxwPkZvciBleGFtcGxlLCB0ZXN0IG1hcCAweDdmZmUzNzQwMTAwMCwgdW5tYXAgaXQs
IGFuZCB0aGVuIG1hcAogICAgICAgICAgMHg3ZmZlMzc0MDAwMCAyTUIgaHVnZSBwYWdlLCB0YWJs
ZV9mcmVlZCB3aWxsIGJlIHRydWUsIG1lYW5zCiAgICAgICAgICB0aGF0IGZsdXNoIFRMQiBpcyBu
ZWVkZWQgYWZ0ZXIgbWFwcGluZyBodWdlIHBhZ2UuPC9wPgogICAgICAgIDxwPllvdSBjYW4gY2hh
bmdlIHRoZSB0ZXN0LCBkb24ndCB1bm1hcCBwcmV2aW91cyBtYXBwaW5nLCB0aGVuCiAgICAgICAg
ICAyTUIgaHVnZSBwYWdlIHdpbGwgZ2V0IG5ldyBHUFUgdmlydHVhbCBhZGRyZXNzLCBvciBjbG9z
ZUtGRCwKICAgICAgICAgIG9wZW5LRkQgYWdhaW4gdG8gY3JlYXRlIG5ldyBHUFUgdm0uPC9wPgog
ICAgICAgIDxwPlJlZ2FyZHMsPC9wPgogICAgICAgIDxwPlBoaWxpcDxicj4KICAgICAgICA8L3A+
CiAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2l0ZT0ibWlkOjgwYTUyZWU3LTBhOTQt
MDg2MS0xMjhlLWFiMjNkMjA5OTg3ZUBhbWQuY29tIj4KICAgICAgICAgIDxwcmUgY2xhc3M9Im1v
ei1xdW90ZS1wcmUiIHdyYXA9IiI+UmVnYXJkcywKJm5ic3A7IEZlbGl4CgoKPC9wcmU+CiAgICAg
ICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSI+CiAgICAgICAgICAgICAgPHByZSBjbGFzcz0ibW96LXF1b3RlLXByZSIgd3JhcD0i
Ij5rZmRfZmx1c2hfdGxiIHByb2JhYmx5IG5lZWRzIGEgbmV3IHBhcmFtZXRlciB0byBkZXRlcm1p
bmUgdGhlIGZsdXNoCnR5cGUuIFRoZSBmbHVzaCBhZnRlciBtYXAgY2FuIGJlIGEgJnF1b3Q7bGVn
YWN5JnF1b3Q7IGZsdXNoICh0eXBlIDApLiBUaGUgZmx1c2gKYWZ0ZXIgdW5tYXAgbXVzdCBiZSBh
ICZxdW90O2hlYXZ5LXdlaWdodCZxdW90OyBmbHVzaCAodHlwZSAyKSB0byBtYWtlIHN1cmUgd2UK
ZG9uJ3QgZXZpY3QgY2FjaGUgbGluZXMgaW50byBwYWdlcyB0aGF0IHdlIG5vIGxvbmdlciBvd24u
CgpGaW5hbGx5LCBpbiB0aGUgdGlja2V0IEkgdGhvdWdodCBhYm91dCBwb3NzaWJsZSBvcHRpbWl6
YXRpb25zIHVzaW5nIGEKd29ya2VyIHRvIG1pbmltaXplIHRoZSBpbXBhY3Qgb2YgVExCIGZsdXNo
ZXMgb24gdW5tYXAgbGF0ZW5jeS4gVGhhdApjb3VsZCBiZSBhIGZvbGxvdyB1cCBjb21taXQuCjwv
cHJlPgogICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgIDxwcmUgY2xhc3M9Im1v
ei1xdW90ZS1wcmUiIHdyYXA9IiI+SXQgaXMgYSBnb29kIGlkZWEgdG8gdXNlIHdvcmtlciwgYnV0
IGhvdyBkbyB3ZSBncmFudGVlIGl0IGRvbmUgYmVmb3JlCm1lbW9yeSBpcyByZW1hcHBlZD8gaWYg
cmVtYXBwaW5nIGRlcGVuZHMgb24gaXQsIHRoZW4gbW9yZSBsYXRlbmN5IHdpbGwKYmUgaW50cm9k
dWNlZCBpbiBtYXAuCgpSZWdhcmRzLApFcmljCjwvcHJlPgogICAgICAgICAgICA8YmxvY2txdW90
ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgICA8cHJlIGNsYXNzPSJtb3otcXVvdGUtcHJlIiB3
cmFwPSIiPlJlZ2FyZHMsCiZuYnNwOyZuYnNwOyBGZWxpeAoKCkFtIDIwMjEtMDUtMjUgdW0gMTo1
MyBwLm0uIHNjaHJpZWIgRXJpYyBIdWFuZzoKPC9wcmU+CiAgICAgICAgICAgICAgPGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICAgICAgICA8cHJlIGNsYXNzPSJtb3otcXVvdGUtcHJl
IiB3cmFwPSIiPkl0IGl0IHRvIG9wdGltaXplIG1lbW9yeSBhbGxvY2F0aW9uIGxhdGVuY3kuCgpT
aWduZWQtb2ZmLWJ5OiBFcmljIEh1YW5nIDxhIGNsYXNzPSJtb3otdHh0LWxpbmstcmZjMjM5NkUi
IGhyZWY9Im1haWx0bzpqaW5odWllcmljLmh1YW5nQGFtZC5jb20iIG1vei1kby1ub3Qtc2VuZD0i
dHJ1ZSI+Jmx0O2ppbmh1aWVyaWMuaHVhbmdAYW1kLmNvbSZndDs8L2E+CgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwpiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKaW5kZXggOTYwOTEzYTM1ZWU0Li5hYjczNzQxZWRi
OTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwpAQCAtMTY1Nywy
MCArMTY1Nyw2IEBAIHN0YXRpYyBpbnQga2ZkX2lvY3RsX21hcF9tZW1vcnlfdG9fZ3B1KHN0cnVj
dApmaWxlICpmaWxlcCwKJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGdv
dG8gc3luY19tZW1vcnlfZmFpbGVkOwombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgfQoKLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAv
KiBGbHVzaCBUTEJzIGFmdGVyIHdhaXRpbmcgZm9yIHRoZSBwYWdlIHRhYmxlIHVwZGF0ZXMgdG8K
Y29tcGxldGUgKi8KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBmb3IgKGkg
PSAwOyBpICZsdDsgYXJncy0mZ3Q7bl9kZXZpY2VzOyBpKyspIHsKLSZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBwZWVyID0ga2ZkX2RldmljZV9ieV9pZChkZXZpY2VzX2FycltpXSk7Ci0mbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKFdBUk5fT05fT05DRSghcGVlcikpCi0mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgY29udGludWU7Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcGVlcl9w
ZGQgPSBrZmRfZ2V0X3Byb2Nlc3NfZGV2aWNlX2RhdGEocGVlciwgcCk7Ci0mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgaWYgKFdBUk5fT05fT05DRSghcGVlcl9wZGQpKQotJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IGNvbnRpbnVlOwotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmICghYW1kZ3B1
X3JlYWRfbG9jayhwZWVyLSZndDtkZGV2LCB0cnVlKSkgewotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGtm
ZF9mbHVzaF90bGIocGVlcl9wZGQpOwotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFtZGdwdV9yZWFkX3Vu
bG9jayhwZWVyLSZndDtkZGV2KTsKLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9Ci0mbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfQotCiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBrZnJlZShkZXZpY2VzX2Fycik7CgombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdHJhY2Vfa2ZkX21hcF9t
ZW1vcnlfdG9fZ3B1X2VuZChwLApAQCAtMTc2Niw2ICsxNzUyLDcgQEAgc3RhdGljIGludAprZmRf
aW9jdGxfdW5tYXBfbWVtb3J5X2Zyb21fZ3B1KHN0cnVjdCBmaWxlICpmaWxlcCwKJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFtZGdwdV9yZWFkX3VubG9jayhwZWVyLSZndDtkZGV2KTsK
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGdvdG8gdW5tYXBfbWVtb3J5X2Zyb21fZ3B1
X2ZhaWxlZDsKJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH0KKyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBrZmRfZmx1c2hfdGxiKHBlZXJfcGRkKTsKJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFtZGdwdV9yZWFkX3VubG9jayhwZWVyLSZn
dDtkZGV2KTsKJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFyZ3MtJmd0
O25fc3VjY2VzcyA9IGkrMTsKJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IH0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKPGEgY2xhc3M9Im1vei10eHQtbGluay1hYmJyZXZpYXRl
ZCIgaHJlZj0ibWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIiBtb3otZG8tbm90
LXNlbmQ9InRydWUiPmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPC9hPgo8YSBjbGFzcz0i
bW96LXR4dC1saW5rLWZyZWV0ZXh0IiBocmVmPSJodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5v
cmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NqaW5o
dWllcmljLmh1YW5nJTQwYW1kLmNvbSU3QzNlODNjYzYwZTI0ODQyMjEyMjIyMDhkOTIxZWM3Zjk0
JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzU3ODEyMTkx
MTkzNTc3MCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJ
am9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0
YT1qdjJrcmd0bWFOczhyb0k4ZFRCN2VadUQ3Y2picGJOOTklMkYlMkZKczhmYlFwTSUzRCZhbXA7
cmVzZXJ2ZWQ9MCIgb3JpZ2luYWxzcmM9Imh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeCIgc2hhc2g9Imh1TDgvb2ZRUVRwRXN5UVd6YUd4Zy9sOFdT
UzJYNnRMWDJ5TjNEZ0hlZjVYc1BCbUVkNE9ZZWFiN2FiSERaR2g3OCsyNVVNNWxENkkrYncrdFZx
Mk55TFVKbTMweHBwTDE0VmQ3NGE4VVJPOWRRS3YrdDJ0WUxFc2d6NVE0YlpicTZmb1NsMmhQOFNL
QkVHVHo1cEVYclVwZ0ZSVjhoYk5kM3pnbjcyanhaQT0iIG1vei1kby1ub3Qtc2VuZD0idHJ1ZSI+
aHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1k
LWdmeCZhbXA7YW1wO2RhdGE9MDQlN0MwMSU3Q3BoaWxpcC55YW5nJTQwYW1kLmNvbSU3QzkyYWMz
ZmJjZTkyNjRmYmNmNDA1MDhkOTIwOGNjNDc3JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0
ZTE4M2QlN0MwJTdDMCU3QzYzNzU3NjYxMTI0MTcwNTMwNSU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENK
WFZDSTZNbjAlM0QlN0MxMDAwJmFtcDthbXA7c2RhdGE9UzhOU1pSZFhxJTJCNzR0U1NMa20yVFlF
VkRyJTJGciUyQlclMkZFVDdDSmxuN3RiRVFvJTNEJmFtcDthbXA7cmVzZXJ2ZWQ9MDwvYT4KPC9w
cmU+CiAgICAgICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgICA8L2Jsb2NrcXVvdGU+
CiAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICA8cHJlIGNsYXNzPSJtb3otcXVvdGUt
cHJlIiB3cmFwPSIiPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CjxhIGNsYXNzPSJtb3otdHh0LWxpbmstYWJicmV2aWF0
ZWQiIGhyZWY9Im1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyIgbW96LWRvLW5v
dC1zZW5kPSJ0cnVlIj5hbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzwvYT4KPGEgY2xhc3M9
Im1vei10eHQtbGluay1mcmVldGV4dCIgaHJlZj0iaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Au
b3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDamlu
aHVpZXJpYy5odWFuZyU0MGFtZC5jb20lN0MzZTgzY2M2MGUyNDg0MjIxMjIyMjA4ZDkyMWVjN2Y5
NCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1NzgxMjE5
MTE5NDU3NjMlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pR
SWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2Rh
dGE9cVVOTzZJMm5XRFVHSHE1TXB4TTZTQUglMkZFVUl0d0kwbDl2WXNKTXJzZTVnJTNEJmFtcDty
ZXNlcnZlZD0wIiBvcmlnaW5hbHNyYz0iaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4IiBzaGFzaD0iWExua2ZnYU9PNUZKVm4xbTB1Vkl3b2ZDenVC
ek9WaGxTbFBLZGptVktQOGtkOXBaM0NlSWhLd2RDK0kzL043YmE1SkhnRkljNUIxcVhINlBhS2VN
Y3hhLzByUWF2VDNkN2p2MGNKWlphNmU2czVhV3ljbzhaemxDaWVSNmNIUXoxSDViWkZuNUh3ZTlQ
SWpYTVc3b3M5aTF3VkMxQzh6RUNyS0ZhQ1gzU2RRPSIgbW96LWRvLW5vdC1zZW5kPSJ0cnVlIj5o
dHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMl
M0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQt
Z2Z4JmFtcDthbXA7ZGF0YT0wNCU3QzAxJTdDcGhpbGlwLnlhbmclNDBhbWQuY29tJTdDOTJhYzNm
YmNlOTI2NGZiY2Y0MDUwOGQ5MjA4Y2M0NzclN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3NTc2NjExMjQxNzA1MzA1JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzEwMDAmYW1wO2FtcDtzZGF0YT1TOE5TWlJkWHElMkI3NHRTU0xrbTJUWUVW
RHIlMkZyJTJCVyUyRkVUN0NKbG43dGJFUW8lM0QmYW1wO2FtcDtyZXNlcnZlZD0wPC9hPgo8L3By
ZT4KICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgPGJyPgogICAgICAgIDxmaWVsZHNldCBj
bGFzcz0ibWltZUF0dGFjaG1lbnRIZWFkZXIiPjwvZmllbGRzZXQ+CiAgICAgICAgPHByZSBjbGFz
cz0ibW96LXF1b3RlLXByZSIgd3JhcD0iIj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAo8YSBjbGFzcz0ibW96LXR4dC1s
aW5rLWFiYnJldmlhdGVkIiBocmVmPSJtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmciIG1vei1kby1ub3Qtc2VuZD0idHJ1ZSI+YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8
L2E+CjxhIGNsYXNzPSJtb3otdHh0LWxpbmstZnJlZXRleHQiIGhyZWY9Imh0dHBzOi8vbmFtMTEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3Rz
LmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9
MDQlN0MwMSU3Q2ppbmh1aWVyaWMuaHVhbmclNDBhbWQuY29tJTdDM2U4M2NjNjBlMjQ4NDIyMTIy
MjIwOGQ5MjFlYzdmOTQlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0Mw
JTdDNjM3NTc4MTIxOTExOTU1NzYwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0
d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3
QzEwMDAmYW1wO3NkYXRhPXF4Z3RHMGhzNUxhaUpWN0lYcUtSS1B6OUczbWhyQjVqRjJxRG1BcDNU
MlklM0QmYW1wO3Jlc2VydmVkPTAiIG9yaWdpbmFsc3JjPSJodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngiIHNoYXNoPSJuSkxPTnFlK3JZSUF6cTRF
QkdUN2wya0FQSUdCQ0NuWXlIaEFUQTVRSW9xSmxEK2dQMG9FQVNmSkdYNzdQdm5CY1hmVTh3VVlK
ak10c1NsWEJwZnppcGZDZDVnMHpySWJUWXc1MGtWZ1V4QUVjSXUrTG5ycTB2Ym9qK1pVdjFHRjNi
aWNLcWtiUXZNN2QwSXlteEVqZjRhMmxZVXhLcWt1dTlLSC9sMTIxS0E9IiBtb3otZG8tbm90LXNl
bmQ9InRydWUiPmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeDwvYT4KPC9wcmU+CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPGJyPgogICAgPC9i
bG9ja3F1b3RlPgogICAgPGJyPgogIDwvYm9keT4KPC9odG1sPgo=

--------------318D6B55FF464BC941DD785B--

--===============0752271360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0752271360==--
