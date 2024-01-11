Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA98C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 16:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6F010E046;
	Thu, 11 Jan 2024 16:03:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BFA10E046
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 16:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDLdjm/DyBZK6VT98zxkWP4RVwFu3j7MBfzO3Im8ilB9qAp4Ci0dtWtp5lbbMj8ZRuWlWTAqstTWrRRBsxmtYFRfu6LVk463t1NCMUoLWU5XOhTSuvtrEzVQnjNc2dveP5959aXAZ05t1UZv2F7FNM8vIl5IHk6vuxwZhrpjiwY6zPClJp5R60r24drl5Un4JRfiE54ANiaoeVq0inoV29WLbmC4pKm3caLJtf/aSV7sz3PWyAegACzby1vGl/eYg3Nsztb0tKALjDy4fO3a0gI6IkipPqtFZWAfZEr2sZbKN8dZ+KQ7KNWVsCzl0mhGJIHZgOT0Kx75yhGlrju4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFu4FXvqO7lDnldOGAwgNQ98jEKIaKEi17mN2QB5Ujw=;
 b=m0NPMJVcsIfixnPtvF6Ej8V0g0hgsOztMURSMWLtqETYBdrEDHH3F2hgaiHBV80gqI49Wgs8A9/as8TvO3VbEzoTh6fI4py6DhOKYAO/1315xnYP3wVAkgSHNAtC0ng6QfVzSr8nUyt7tEvon88mIAivZBoUUz9+pfTavDTtLLqVsBDMBtdAOm58rjACIuaFENulhk38bg4F4UbroNnAf78JFsUVuwbZCC57rC5ZkU7No6OyPfgUlEizDNXAARIf2eJcf/gUQV1GpWY1gB+fzGQ82gMtilHlTuGIVi+7CmfLJro5tGuCo1IeQxDDCr35TfVEnWC6sHjibVATfFEW0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFu4FXvqO7lDnldOGAwgNQ98jEKIaKEi17mN2QB5Ujw=;
 b=3rUT2326hx0dF45NZPouahb1n9rb6LT8Gbpj3H4kgZNUkM5MFwJCfcKWLNzDP8ZUBE2cD/EV21wxlx3eE0bCPhMrQ5HYEypsYzvb+sfOr6QnlJVFZ+Pk1a4JadzXG5TnJtT7wNFE2VzxlT6Wum33I2RSqSspFXYvtlpFN5+sJ3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 16:03:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 16:03:25 +0000
Message-ID: <a172267c-55b1-4abc-935d-fbc9f3a3838b@amd.com>
Date: Thu, 11 Jan 2024 11:03:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix the shift-out-of-bounds warning
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, "Kim, Jonathan" <Jonathan.Kim@amd.com>
References: <20240110093938.684930-1-Jun.Ma2@amd.com>
 <7fde053e-b120-4d80-82cf-0a104ed5653f@amd.com>
 <99264b52-4e47-4a2f-a930-a87feef3ac85@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <99264b52-4e47-4a2f-a930-a87feef3ac85@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: b2572c3b-c84f-456f-08f7-08dc12bed7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygMH2fYc0JxHyujvA1nk/oooaLfQa5JODe5C53yzKjnPi6XIy+E6EvEAHRTxf4mpAtkSr0RH49qH5XD+F3T8+HOcm/j631Sf1Avae7WjIaPxlJkYB9wrvtYQfhEGTwRlF4j0rnt+vqDT/5Jr1csStKM8FMQG+RO3EegJR8PD9RfWc0qHDjag7O+1U5U9+NevA6jLEGGVu+WElG2yeFxAovLEiyNAwJBd4BBmL78ziD83OeMnw3/I3T3GWf9oxZbImfmwgg/bX9wptZ/WJacZpzADC+SzyhSKUmt0DHAX5c0qDHimDwf051qWMN3tTmrluuH0E+VliNebRk/3H02+4y5Z6yNcA7iSQIWE4ZpOB5CCAaQWO+Im8VRyaPPbOFbRu0SHD6xBo5/CQO/Z5qIEvQin3Vd15wA0vlXrHV9xeE96DBeBw3oOob+sChY68IoOl2RHfLUltErpKzs24yE+zVuCQ/6jjDED9xCuQa1ldV1VlHisqFSktqPbbtXmC5tPuF4w0h5z2f/mgCLQXcnKrq0kQedccqCwsnfImAPVgy1b5hccLsOXl2gtYmRNlgos2fkPIrgXVp2jvSKcLeQ2YyXd29Ytkr+BYHXuCfztNKy223lzVMnYTns6Bar+al3/Dc16Nw3Ud0Aofs4FowHwnuV0a+YsXxdWikvNZGNoBGbv7RYZHeUclJubIPlfBEVK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(36756003)(8936002)(8676002)(316002)(83380400001)(110136005)(6636002)(53546011)(478600001)(44832011)(6506007)(36916002)(5660300002)(6512007)(66946007)(26005)(66476007)(66556008)(2616005)(6486002)(38100700002)(41300700001)(2906002)(31686004)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjFCVzkrU1ZzOTBqbGJwSjZDSU9iZXE3U0d0YURhek51eGpEQXB1ZUlUbUcy?=
 =?utf-8?B?UDJlYVNtU2FUTElXanNKZjJMZVMrR0IrdnB1UEhWUC9RdHZPK2RIZ0k5VEZD?=
 =?utf-8?B?MnJkVGRPcHB2Q1VoV3FqUE1HN0pOdmJaYnYxaDVUc0VNekFPbFkvRWREZmpC?=
 =?utf-8?B?MU9kSnE2ZzVqWndPRlRmZkFJZ3BaM0FqNlZyNnN0bW5qcE42NkxIVU1vQjhy?=
 =?utf-8?B?bkljanVUcE5CSCtjRTNlaW1jYkVpT1JuZEcwcW1LdWhTMk5WTUdBeWJNVWVN?=
 =?utf-8?B?YjVQUVMwY21WYWxoREFvNUlxMGhwRGtDSytFRStSQXpFU1daRE8yK01LWjMx?=
 =?utf-8?B?akVCWDhmaHIvNDNzS2FtY3VXWXg2T0pGblpVNXY1TEU5VThUYVNxV3hKUHl1?=
 =?utf-8?B?dExlVG4yam5oN0ZqSkhiUDV4RkU1U1V1NmJsK0hZWEFJSHBKdWUyaVZ1N3d1?=
 =?utf-8?B?cURXcTg5YUxYZTdBWUNqNVhWR1RDblBQQlhYWk84MEpxS01XSFAxNTd3TmpL?=
 =?utf-8?B?cGNnZG5FbHlzNHNnZkJ4eS9tbW81R3NJdkF4VDkrWGFRQS9MbGlINzR3YnFR?=
 =?utf-8?B?V1NoMmFhVzNOS3h2Z05OUlltbGhpNllsSnluTWMvVHV4V1NocEJjWVhGTmtR?=
 =?utf-8?B?ZG9CZXY2aW4wQ0ZzN0Q0RzNQUyswNEVieXA4R29LMWFCZXlkWlUya3R6NEIx?=
 =?utf-8?B?YXpZR1Jubm56d24zVTYzbHhRYzYzVUVsRDVZVVQ2TTZqb0I1RWxyNEpaWU8v?=
 =?utf-8?B?NUpKYW1UTjVHeVltQjJFYnkyZ3MyTFVhWmxBVURpMk9TRWZIcHJnUnpISlBM?=
 =?utf-8?B?UEE4WlhVRGxCMS9talJHcWg3elB3MWVWK3NWZG1lTVZnYi8vTGoxRWEzUDlo?=
 =?utf-8?B?RkFnaGNrd1lJL0tKUWtKM2ZWdXBWMWloOHM5TVpZbG1GTmJvT0pnTDAvbW9h?=
 =?utf-8?B?VC92eEpzUzlLcEg5aHEzblpxSlF0Q25oRXcyOGtOYWNwRFZ5NlZEQm1YZ2t6?=
 =?utf-8?B?bG5kUEJyVmZwYnkwMjl1dUV4ZTlndHQ2bUNSUW5Td3hIM0NvZUUrZ3Iyczdl?=
 =?utf-8?B?TEYxRFM4WldnVVNXWFMzVDRiQmZEaG56eUU3QVVPTzRYMExyQTY2dlNFSWtx?=
 =?utf-8?B?K0dOY3JUMjlHdUZEdU1sbFd0U1YrQzZXdHJ2YTJMQ09ObHAwZDUwbmRmSURk?=
 =?utf-8?B?bFhldDNIdmh0bnU4NlhjbHQwYzY3OFFId2d1ZlJXVHFiUmMxN0lMb0RkM3NO?=
 =?utf-8?B?cmVTeCsrNWVibTZnbHBtcVYxOWxybmZmczRXRWxuQkVjWmErTkszdUlLOFJa?=
 =?utf-8?B?SVJIaW1HN09ZdCtManVRVXJiMENaK3hiZVFnNEIxUmNHS2xXOWlESVVhOG1R?=
 =?utf-8?B?cXo5TitvVXU3ODhGdTBKZmRtVkxkZnBkOHRZSit2VjNrWXo5QjZPaUFGNk5K?=
 =?utf-8?B?Qi9pWmdsSG12YVFIcnhqcy9LbkVVa3JLM2ptWnovQjhSdG5KbHRGN25UZFQv?=
 =?utf-8?B?akg3WGtxZ0MwVW1vNUdjMDlsSjUrc2pneHg4cmtmOUZiV2FZWXFCVnBZSFgw?=
 =?utf-8?B?NGJKUE0vL3NVSGl2QU8vaEpsZHc1V3FJd3ZUcjNqTWdieDk4anNnOWE0eWZy?=
 =?utf-8?B?MVVQNlpYR1JoM3BDdjZRRTVxSldDSVVoR1lMVmR0dXBLNFk3aUdyYUtkS08x?=
 =?utf-8?B?K2VYT1NRd1pvTWZBaDBhc3RNM25QRzVNek56TUtMa0dlSUtmNUxXcXJ1dWZ1?=
 =?utf-8?B?QzNKRzZjL3ZMbk82R2ZVK25TbXl2a2QwYmtjMDFGdXVRM3dZd3JleHRKOFFI?=
 =?utf-8?B?eS9kRFh2emMrS0Z4TGZ3L1RZa1hzYmF5cENVOURrRnpDbkM1cFV3ZlFUZ2pF?=
 =?utf-8?B?M0cwUngwM2ZaekpPSU1HSWVESjAzdVFKMmMxVWY3Wm5kTlNNNjBWeEY3dG83?=
 =?utf-8?B?TFdQQkRRTFZ3N1ZWTkQ5NUhkWFp4MzVnRHg2WElLYngzek5ySHcxKzZOeHdW?=
 =?utf-8?B?Q1laZGRtZFdYbi9zWUxlcjl4UXMwdnMycFhTK1Badk5OdkRCNzNhQ01xRlBL?=
 =?utf-8?B?NVBoeGxkWER2YnJtS0tGeDFiK1pzeVlCbWxOWVdnSS9ZcldpVmtnR1NrU0Fx?=
 =?utf-8?Q?T4dxAbKJ5rs9k5boupEPFChVC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2572c3b-c84f-456f-08f7-08dc12bed7fe
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:03:25.8341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsjWiNXKL/aJGOaqX2FL6EyokbVK/2tu2bzNl6IZ2OSKh0cPgyoZkQ6vtvTgLQi0NN/BFatG0vPE6aKVmJTEZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
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

[+Jon]

On 2024-01-11 01:05, Ma, Jun wrote:

> Hi Felix,
>
> On 1/10/2024 11:57 PM, Felix Kuehling wrote:
>> On 2024-01-10 04:39, Ma Jun wrote:
>>> There is following shift-out-of-bounds warning if ecode=0.
>>> "shift exponent 4294967295 is too large for 64-bit type 'long long unsigned int'"
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>    include/uapi/linux/kfd_ioctl.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>>> index 2aa88afe305b..129325b02a91 100644
>>> --- a/include/uapi/linux/kfd_ioctl.h
>>> +++ b/include/uapi/linux/kfd_ioctl.h
>>> @@ -1004,7 +1004,7 @@ enum kfd_dbg_trap_exception_code {
>>>    };
>>>    
>>>    /* Mask generated by ecode in kfd_dbg_trap_exception_code */
>>> -#define KFD_EC_MASK(ecode)	(1ULL << (ecode - 1))
>>> +#define KFD_EC_MASK(ecode)	(BIT(ecode) - 1)
>> This is not the same thing. We want a bit mask with one bit set. And
>> ecode=1 should set bit 0. ecode=0 is not a valid code and doesn't have a
>> valid mask. You could use BIT((ecode) - 1), but I think that would give
>> you the same warning for ecode=0. I also don't see BIT defined anywhere
>> under include/uapi, so I think using this in the API header would break
>> the build in user mode.
>>
>> Where are you seeing the warning about the bad shift exponent? Looks
>> like someone is using the KFD_EC_MASK macro incorrectly. Or if there is
>> a legitimate use of it with ecode=0, then the correct fix would be
>>
> This warning is caused by following code in function event_interrupt_wq_v10()
> 		
> else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
> 	kfd_set_dbg_ev_from_interrupt(dev, pasid,
> 	KFD_DEBUG_DOORBELL_ID(context_id0),
> 	KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
> 	NULL,
> 	0);
> }

This looks OK. The compiler must be warning about a potential problem 
here, not a definite one.

Question for Jon, how does the firmware encode the error code in the 
context ID? I see these macros:

#define KFD_DEBUG_CP_BAD_OP_ECODE_MASK          0x3fffc00
#define KFD_DEBUG_CP_BAD_OP_ECODE_SHIFT         10
#define KFD_DEBUG_CP_BAD_OP_ECODE(ctxid0) (((ctxid0) &                  \
                                 KFD_DEBUG_CP_BAD_OP_ECODE_MASK)         \
                                 >> KFD_DEBUG_CP_BAD_OP_ECODE_SHIFT)

It looks like we have 16 bits for the ECODE. That's enough to have a bit 
mask. Do we really need KFD_EC_MASK to convert an error number into a 
bitmask here?


>
>
>> #define KFD_EC_MASK(ecode)	((ecode) ? 1ULL << (ecode - 1) : 0ULL)
> This can fix the warning.

In the code above, if ecode is 0, that would lead to calling 
kfd_set_dbg_ev_from_interrupt with a event mask of 0. Not sure if that 
even makes sense. Jon, so we need special handling of cases where the 
error code is 0 or out of range, so we can warn about buggy firmware 
rather than creating nonsensical events for the debugger?

Regards,
   Felix


>
> Regards
> Ma Jun
>> Regards,
>>     Felix
>>
>>
>>>    
>>>    /* Masks for exception code type checks below */
>>>    #define KFD_EC_MASK_QUEUE	(KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) |	\
