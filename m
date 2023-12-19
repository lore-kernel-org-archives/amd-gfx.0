Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EA6C41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 22:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3567910E05F;
	Tue, 19 Dec 2023 22:43:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04EF10E05F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 22:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npeoiA1o2GeL3Cg+Q7koXvCRpXhqf2lVtQxOBjgT8FRvna/1JqkHGNHv7W2tXENCtjhn5+osy9lICPiCzWAikjF/um78UMoxsBXzNX+uvo5T1AtUyKatWPWbGkcAgcHFYwaH6Jvo1XdniHfCaN2IwIygWowGRRuTHXlbfZTXBLXDt5IttxscT2A8VKwkE+m7haviJZr37HVvfTc/0MrRawkmL2qu85AKbJs6ums4VVS3kNPqNub9iZYUljBx773B8MbL1bc+/1obpjdioUKTz7pJ6KpSQGXqF35zyHAXPuXfpuZxbLq77C03JIU+ImF68rps8hYQIeuT+5dKc8PJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiS4VZqvgsU6TjgzBgpEyifOzTrVZhQla/gXIRgHAU4=;
 b=KTt0fsbHZCJN7IxCn6RXGrjgicfesVSNhp9T9E0xm9HbrfEdl7u7ciotbHCiwrrB0XdBbpE/PfQNYsaUGM6KK8iSH/Ms/9zvTogizL86kPrSP84+Ev306+54owaRHJLYrRRGjPy61B8KnFGVDXRD9nWQ7kg1IWS/Z/rBZ67404o/mHtFUIP65GfUbPBSkIs5xTGOMSpLIEL3pXoaW/BoLx/fm5LdD+17QgpsUMWdk4ZCrDNxuO0PXizntSnmPWlGwVmMvEiJpkyfyy5DPZvj9/T68bakk52XQdxMBZD+lPm/siEYsQLINle0OYhznKaKfbUoQcbbPkRwdjkVrZoYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiS4VZqvgsU6TjgzBgpEyifOzTrVZhQla/gXIRgHAU4=;
 b=ta23r1hmxzI2jeT9l4aPq0zLgs7C41CsZLubM/tdlWnbNiiJCa33wRX2pT88WVP47zw3Rel0qwoLSw44D2YGal1ny5ufWzn533/AlRy1mhgercE/q/5kCR3u8BPVhH95wNebGouMlhY7mROqFB15j+7ZaGsDWby1hXvpNJeHF7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 22:43:38 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::ee9b:7998:3d78:78b]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::ee9b:7998:3d78:78b%7]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 22:43:38 +0000
Content-Type: multipart/alternative;
 boundary="------------6n2UT0bKXXFcJCH8sS8Haacv"
Message-ID: <f37e19fe-4fc9-4580-9961-ccdcf7f9b35a@amd.com>
Date: Tue, 19 Dec 2023 17:43:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Auto-validate DMABuf imports in
 compute VMs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231214223001.218746-1-Felix.Kuehling@amd.com>
 <fe14d738-ab23-460f-ac44-2090ef9ab4c5@gmail.com>
 <3bce0db8-9da0-4f6e-a941-e5531518c908@amd.com>
 <346c1009-2930-4424-9cd4-589e5872877e@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <346c1009-2930-4424-9cd4-589e5872877e@amd.com>
X-ClientProxiedBy: YQBPR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ec1564-3e70-467f-cbe6-08dc00e3e92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hlDhoJhJvfuvj5IQLcn4KTpN6GLPHuSHi3bR/LylmRWzFF7jbytup7e7XSIgg0aVVz4wN+xyPSs9iYfYfCMftfsaMnF2vl3u16u+Ry1LcovHTDKaAW/zNpsH9PFJAUPNgBmgx+67tUvKsVup5L38IRdkzGEdjGZPSzmNZMYqvg741mGS2CEtYpGwPzFmj40r6xfwr7a279qVvtqOrlY//T3tH/tMxtC3eOXnVR/W4RhutlNMCUEPQnRAWbog7IbIBED94FWDcwTEfRPTdh6h8O2y3/gQo5NWR1WrcbgX7XNov2UfKM9F8sGbpq2nxBp1lMxRlJl4sNQaRnl8Tl1zm+Fv0OxGdsGNn4xrR9Wc0zTmD6a8dORORnMDw61VZLTTb4Ons3BycNBvV0rtorsguWyFJ1cYFwP28w2N7EgwfDpJE5tU6fn9IA1gJti1oQSPg9BqKFZD1G8BJWmB2hvUGjlD4Vpt0mNJXWzCP/ExyGJsN/sFmtiSrG5np83BVPdVp0/rucNli/ygwAE1RcoAV5+cFoKzDLUvSmFbdNyZMR4N5zk6lJ9v2XS4iBEumFmdxH92BuJm1ga40yuATI0cliVNRfbe859sXa0OfLeP5SE5T9GIeJp259OCtvYLXlmN9r861hzUBv8nxIxmHjYpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(44832011)(66574015)(41300700001)(83380400001)(86362001)(8676002)(38100700002)(478600001)(8936002)(31696002)(6486002)(2906002)(66476007)(66946007)(5660300002)(2616005)(66556008)(6666004)(110136005)(4001150100001)(6506007)(26005)(33964004)(36756003)(4326008)(6512007)(316002)(15650500001)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUg1QXRxak9qeXhuT3FXTVJiNFJTQkVLWjljb0poOVJjQnJuY3dkazRaSzIx?=
 =?utf-8?B?MWxhR2VlTER2TGVmTUJZUDE3M0ZrbXdzanBIbkRpaDhEbFpOdkNCNzk5Zlow?=
 =?utf-8?B?Q1VOUlZndGlyS0NPQVpOaVFaRHNlKzN0YlU3T2x3aE5mMmN2NVhXWC92UkI3?=
 =?utf-8?B?TVNJcHJYTkhCRVpBSWhmQzFsOGpaVWdWMGFUbVltdTZrRlk2OVpXLzBwV1Rl?=
 =?utf-8?B?WGx2NEg1dlV1enBSS1hVN3BTeEtSUHJlSzBVQWhxdVQrK3A5SnRQanZRSlNa?=
 =?utf-8?B?bExCd244ZXU3cllrZDlsMGZPR3RRZW40ZmtzanRwL2xoenY3bjM3VERhdkNk?=
 =?utf-8?B?QjE0MW0vQllWak1ZVi95VWMrVkV4K09jcU1PQk1YTnd4TnBsR0xBN2JPNGJk?=
 =?utf-8?B?Rk1qVkk2MFBnby8wV1RTMGNMQlhNUWU5MGZFMUVzdVZoYzVld2srVmNOMnZW?=
 =?utf-8?B?UEFzL25LdTUwS3V1N0h1OGovNmFXN0Y5QXAreWZCSGxBSXo0QlJkTXVuaFlE?=
 =?utf-8?B?b05GOFJpTHJzc1QxUmtVbFVLZWlxeERPZEg3anlSMk5FYVVPSHhOdG5SY2hU?=
 =?utf-8?B?bzJ2MUl6Z0U5bzRiT29tdnJhR3JBT1hSVHQ3TmFjS1VPVUhSOWt5WTdBT2Mw?=
 =?utf-8?B?aFlXWW95T1JNMTFpVEtxcDRvNzBNWE9NYVZBemUxRGh6MTdrTHM1K2tIY3ND?=
 =?utf-8?B?SlJ3ck93eFlYYWtXVmRsRGxCN29UZ096NlZKeDV3b0pPaldrQjVLbXB6eEor?=
 =?utf-8?B?QW1yelZMYzlFS2YxYzFyYkdKUXorOHhHVDZUeDhLQ05nK0s1K1ZpS0phamhT?=
 =?utf-8?B?MjVvTk11RU80TjNYb3Y2bW5Rd0ppbHZBUFZJRHBOaWRTMDd4TVZoWTVrci9O?=
 =?utf-8?B?VnNCOFpiNG5sU3FSTzZmRStyVjlLaXZSakJRZUxMMXBtSkx6OUwrY3g1QU5X?=
 =?utf-8?B?SXNqK2RtOXM3Q0k3STdrT1I5aFM4TE1kU1BscU9lenA0K200S3hISS8zdzJl?=
 =?utf-8?B?aTJENGY1YXRuMGhoQWpGWmlBRlBqeXZ5STJzbVkvUDFOUXhFN1ZMcEdDZUlC?=
 =?utf-8?B?NytlUHRxVUdkOW9nSkJIY2Via3RBbndkcDUzM3lHT2VpTk5IczY2ZSsySGVk?=
 =?utf-8?B?OXVqdnBCc2NYd3dRZzVEMzM0R0diNTNsS0JpY2dHOWFkK3o2NDYyb2dnNDFB?=
 =?utf-8?B?dG9HVWVGZmtoSCtWOEtpOTM3VTJ1dEhIbTd1bFp6cnRPYk1HUmJPY28xUldE?=
 =?utf-8?B?QXhJb1JqMTQ2Wk1hN3k1c3B6c1FtdEJMRkY5V1JQSUZwY3Z2RW1IN2F1OXAv?=
 =?utf-8?B?eVE0NERIZlVGQUhWTVMzNGFhd29peVpsZVk0T0FDbHhTV1BGTFBpdFF6bVY1?=
 =?utf-8?B?UW50aDZPVDFiNmgvOHhVM0hkTGR1MENHb1J1ZEZoOVRWbEtsSWZWbEEzSjEv?=
 =?utf-8?B?allTY2RlcVE3b2dEY05NOHR3aUJicnBRd0tnNXJmby9haWdlc2c5NFJidUFa?=
 =?utf-8?B?VnQzNk5kV0g0WVJ0R2JuYUFiYWg1QVg1VWt4WGhadkovK3dHWjNOdVF1cVhu?=
 =?utf-8?B?RHMvZGtaVkl1bUkyMmZoVmFSdzRyMmpKWnV3R1BuZ3ZTdnpCWWZ0L1BwMFNn?=
 =?utf-8?B?eEhQc2x2SHFIWW1ZellYdk9QUGwvT2ExRk01bW4yd2xDNStjd2hYanRSNDQ2?=
 =?utf-8?B?cUw5SUxCY1NlOFFQNEtERVFQQndiRTl6eHovY3MyTDVyOVVwclVBUWdNL21q?=
 =?utf-8?B?WUJTcVlyMll6MGM5SU91TTBWV1Bzdkc1WHEybVlIOVpPZzIvMWRNS25qaUtU?=
 =?utf-8?B?dHlNcU1QRVlsL210bm1wQXZZVWlUeTJwcUhtdUdsN0NiNlZtL0d2TlFDeHRV?=
 =?utf-8?B?bzZsQWVISFVuejRWWTRnNldDZHpkMTAyeWhTTHZGZ0pxVG5YNjFMNDNUc2ls?=
 =?utf-8?B?TithWmFJMUhCY3hmdDAyS1ZVZmhPTUVDR3pzck44Y1NpMTZsaUFyd3BGUDNL?=
 =?utf-8?B?VkVZbHNvUGhETlh5a1Q4WUpodmVYTWtBdnFFNkJydkRKTHRyYjA3L3pUcHl5?=
 =?utf-8?B?OHFxam1rM0NxOFV3ZG9XUjJ5VXRYaE1UMXZUZGcxZXQxZFEzQkh6R3pvVGho?=
 =?utf-8?Q?DHHiHeuWS5ZG0IAaUlhmravqO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ec1564-3e70-467f-cbe6-08dc00e3e92f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 22:43:38.2115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnweEM9LnPl80RlN0s/uLtScr2u38LanN+zODI1zAc1fXnapggmyaxDZjgqocPlLiLsRe0e+c5Xww5PXElDicw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------6n2UT0bKXXFcJCH8sS8Haacv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023-12-19 3:10, Christian König wrote:
> Am 15.12.23 um 16:19 schrieb Felix Kuehling:
>>
>> On 2023-12-15 07:30, Christian König wrote:
>>>> @@ -1425,11 +1451,21 @@ int amdgpu_vm_handle_moved(struct 
>>>> amdgpu_device *adev,
>>>>           }
>>>>             r = amdgpu_vm_bo_update(adev, bo_va, clear);
>>>> -        if (r)
>>>> -            return r;
>>>>             if (unlock)
>>>>               dma_resv_unlock(resv);
>>>> +        if (r)
>>>> +            return r;
>>>> +
>>>> +        /* Remember evicted DMABuf imports in compute VMs for later
>>>> +         * validation
>>>> +         */
>>>> +        if (vm->is_compute_context && bo_va->base.bo &&
>>>> +            bo_va->base.bo->tbo.base.import_attach &&
>>>> +            (!bo_va->base.bo->tbo.resource ||
>>>> + bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>>>> +            amdgpu_vm_bo_evicted(&bo_va->base);
>>>> +
>>>
>>> The change looks mostly good now. Just one thing which worries me is 
>>> that when GFX and compute is mixed in the same VM this here might 
>>> cause problems when we run into an error during command submission.
>>>
>>> E.g. GFX validates the VM BOs, but then the IOCTL fails before 
>>> calling amdgpu_vm_handle_moved().
>>>
>>> In this case the DMA-buf wouldn't be validated any more.
>>
>> This code path shouldn't be relevant for command submission, but for 
>> the amdgpu_vm_handle_moved call in amdgpu_dma_buf_move_notify. That's 
>> where the BO is first found to be evicted and its PTEs invalidated. 
>> That's where we need to remember it so it can be validated in the 
>> next call to amdgpu_vm_validate.
>>
>> Currently the amdgpu_cs code path calls amdgpu_vm_validate with 
>> ticket=NULL, so it won't validate these imports. The only place that 
>> auto-validates evicted imports is amdgpu_amdkfd_restore_process_bos. 
>> So none of this should affect amdgpu_cs command submission.
>
> Yeah, but ticket=NULL will result in removing those imports from the 
> validation list.

I have a comment for that in amdgpu_vm_validate:

                         if (!ticket) {
                                 /* We need to move the BO out of the evicted
                                  * list to avoid an infinite loop. It will be
                                  * moved back to evicted in the next
                                  * amdgpu_vm_handle_moved.
                                  */
                                 amdgpu_vm_bo_invalidated(bo_base);
                                 spin_lock(&vm->status_lock);
                                 continue;
                         }

The net result is that the BO is still tracked as evicted.


> This could potentially result in not validating them should we ever 
> mix GFX and Compute submissions in the same VM.

My eviction test does exactly this, and it's working just fine.

Regards,
   Felix


>
> For now that works, but we need to clean that up more thoughtfully I 
> think.
>
> Christian.
>
>>
>>
>> The flow for amdgpu_amdkfd_restore_process_bos is:
>>
>>  * amdgpu_vm_validate validates the evicted dmabuf imports (moves the
>>    bo_vas from "evicted" to "invalidated")
>>  * amdgpu_vm_handle_moved iterates over invalidated bo_vas and updates
>>    the PTEs with valid entries (moves the bo_vas to "done")
>>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Christian. 
>
--------------6n2UT0bKXXFcJCH8sS8Haacv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-12-19 3:10, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:346c1009-2930-4424-9cd4-589e5872877e@amd.com">Am
      15.12.23 um 16:19 schrieb Felix Kuehling:
      <br>
      <blockquote type="cite">
        <br>
        On 2023-12-15 07:30, Christian König wrote:
        <br>
        <blockquote type="cite">
          <blockquote type="cite">@@ -1425,11 +1451,21 @@ int
            amdgpu_vm_handle_moved(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update(adev, bo_va, clear);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlock)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_unlock(resv);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Remember evicted DMABuf imports in compute VMs
            for later
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * validation
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;is_compute_context &amp;&amp;
            bo_va-&gt;base.bo &amp;&amp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va-&gt;base.bo-&gt;tbo.base.import_attach
            &amp;&amp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!bo_va-&gt;base.bo-&gt;tbo.resource ||
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            bo_va-&gt;base.bo-&gt;tbo.resource-&gt;mem_type ==
            TTM_PL_SYSTEM))
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_evicted(&amp;bo_va-&gt;base);
            <br>
            +
            <br>
          </blockquote>
          <br>
          The change looks mostly good now. Just one thing which worries
          me is that when GFX and compute is mixed in the same VM this
          here might cause problems when we run into an error during
          command submission.
          <br>
          <br>
          E.g. GFX validates the VM BOs, but then the IOCTL fails before
          calling amdgpu_vm_handle_moved().
          <br>
          <br>
          In this case the DMA-buf wouldn't be validated any more.
          <br>
        </blockquote>
        <br>
        This code path shouldn't be relevant for command submission, but
        for the amdgpu_vm_handle_moved call in
        amdgpu_dma_buf_move_notify. That's where the BO is first found
        to be evicted and its PTEs invalidated. That's where we need to
        remember it so it can be validated in the next call to
        amdgpu_vm_validate.
        <br>
        <br>
        Currently the amdgpu_cs code path calls amdgpu_vm_validate with
        ticket=NULL, so it won't validate these imports. The only place
        that auto-validates evicted imports is
        amdgpu_amdkfd_restore_process_bos. So none of this should affect
        amdgpu_cs command submission.
        <br>
      </blockquote>
      <br>
      Yeah, but ticket=NULL will result in removing those imports from
      the validation list.</blockquote>
    <p>I have a comment for that in amdgpu_vm_validate:</p>
    <pre>                        if (!ticket) {
                                /* We need to move the BO out of the evicted
                                 * list to avoid an infinite loop. It will be
                                 * moved back to evicted in the next
                                 * amdgpu_vm_handle_moved.
                                 */
                                amdgpu_vm_bo_invalidated(bo_base);
                                spin_lock(&amp;vm-&gt;status_lock);
                                continue;
                        }
</pre>
    <p>The net result is that the BO is still tracked as evicted.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:346c1009-2930-4424-9cd4-589e5872877e@amd.com"> This
      could potentially result in not validating them should we ever mix
      GFX and Compute submissions in the same VM.
      <br>
    </blockquote>
    <p>My eviction test does exactly this, and it's working just fine.</p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:346c1009-2930-4424-9cd4-589e5872877e@amd.com">
      <br>
      For now that works, but we need to clean that up more thoughtfully
      I think.
      <br>
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        <br>
        The flow for amdgpu_amdkfd_restore_process_bos is:
        <br>
        <br>
        &nbsp;* amdgpu_vm_validate validates the evicted dmabuf imports
        (moves the
        <br>
        &nbsp;&nbsp; bo_vas from &quot;evicted&quot; to &quot;invalidated&quot;)
        <br>
        &nbsp;* amdgpu_vm_handle_moved iterates over invalidated bo_vas and
        updates
        <br>
        &nbsp;&nbsp; the PTEs with valid entries (moves the bo_vas to &quot;done&quot;)
        <br>
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
          Christian. </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------6n2UT0bKXXFcJCH8sS8Haacv--
