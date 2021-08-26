Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83520C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D5160FC1
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40D5160FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFB66E5CA;
	Thu, 26 Aug 2021 10:51:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (unknown
 [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122596E5CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 10:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQM+m5II7Z52eMI2S/ww1g9qYkd/AmNs+lSZETEbTwJO0+ZZMfGP64Mx2KhwavqiEU6aplkrte1NZyyQUzdJpROrqMdq7tReJ0PAhZoBK9gN6KETzsVh5MeSUfeUM/Ys7PZkaP6zsj+is7QNMt1iV5r+v3HgKCrob/wbvPTBmTEUkA9RPFS+fnNS1/m30a4/PwZrdcceAVmapShwGUgRh91cYBsXzV54eCJ42OPo/E7M3qoA+ssP9V4UNDPneAI/ALIDGQSWBbkg1EaJSsSpa4i6V9AR0HcaAk19Q5XACveCVh4MlcnJyJKtQoawMzFd7aPSFF1f4Jq2xLhkPIT77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVeDRCWu7NANd6B7/aZYG9tVFFqTSoQ3Wo3B4pp3GgY=;
 b=aFQqhZbPNkqk5SUFe8mT+yWBO2+a1beIp2pgSLASoQ7cd9s4CxGdhc7ch5ruoM3FmjR3Q6WVSjlIrVULeTExLmkYgKdhMG8v6YSezpdO2CH6y3ezG9ssHktYTlK6UQEs31osNXWmp+xL5rBftItYe0L80mUYS6GpnTYnItbvkq9Q/4feRXNoKFSJuUtkABWhUZa8DW+QVxEx/O4X+aW7yRjvj0WlsUV/NJD/wCBjOLWpn+94sV5IDtZRXlD6/IBRFSmraLED/S2X1i2BTn3xXpQOk4fZ8sUWSy6gxopfjwwAmMJEazR0y8z2kKZeKdX4OsL9jnPQ+Xmrd7555U9gVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVeDRCWu7NANd6B7/aZYG9tVFFqTSoQ3Wo3B4pp3GgY=;
 b=UUzHXDkAHIo6bw4BP7L6POKTnM7yGRBJOMHN1KzuMJ8CeL03Uo6APuhQB3EWs8bt5PI74A55Q0S9qGsEUIJz6p7ODV/7mJoddLFlNz08Zd9brWvvNS/h9mIDUuH8A9rU0IeOvWBu/GgBk1rUZp69mSMzCqIlyZ+12pl6Jow/Il0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 10:51:52 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 10:51:52 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: detach ring priority from gfx priority
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com, satyajit.sahu@amd.com
References: <20210826100824.38041-1-nirmoy.das@amd.com>
 <0f3102bc-b5a4-b892-82a3-0e16f0bdcae6@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <45ccb8ab-f0fc-8807-28db-f2937eb509d1@amd.com>
Date: Thu, 26 Aug 2021 12:51:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <0f3102bc-b5a4-b892-82a3-0e16f0bdcae6@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0129.eurprd07.prod.outlook.com
 (2603:10a6:207:8::15) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f22:2800:79bc:ffe:47ba:625e]
 (2003:c5:8f22:2800:79bc:ffe:47ba:625e) by
 AM3PR07CA0129.eurprd07.prod.outlook.com (2603:10a6:207:8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.6 via Frontend Transport; Thu, 26 Aug 2021 10:51:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce8a32be-b31d-4551-190f-08d9687f831b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52145B32DFA5FB7057ABFBF78BC79@DM4PR12MB5214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Pn3NZcRL9Pg1fWVOBAobhq3pGCL0CBFbln2xhX87litkTSGw60PnrUIqPthSIBvcNbWhVfoxO2MCyFDdRsvu7NGA5wxelVN9u4tvGMrDhgTmSryxRS/TgoKX+OSO63IwQVoJ5eolIhml8Wr+ffDAxVc1BrC/tbir+bBBUIrZ+0DsKHylmbccWMRdWInmmtt/mSX5wzUdbKwf92U9o7PkKMksu4pFSvgYsn6kf8aMnB+KD73aK1ge71jAutAAtfCYM/+wDX9weQFZ4U/b3dybMyvZ+FtO2lraZm3wOdPCAR2hie2lSbqd1C+uXKjQEF6R1ZWBdyyXD7f8Y5sVXImL0m+kKpS0Xolay7Ifn7o/BCNoqDHc9ibmhcO6CgoeMj8BlI3JpcMIryW3uZOALrIsIUkEHSsWk5wyOTNgCHmyQ797L/pOY7CA0sr7lWmG8cSY94IZG4ikidvGt0fZoFTBtY4tfRjl7vEvpufmoT8L8jOl7jDYOhAhAId3P7Jd+YVFa+Gw5R+40UtLBFUucgWP3ftAjdydeIIRJVCXV/mdvTDfUEX56x6J90/RYbjf7h96UkJp9KTc7x4zLZ1mBzq/GCQI9V+iblNunc7AjHmqD+ntBqvZ6kQWNubRydBlVO9Z24XI106eStoDY1Tv2OvnB8cBS8KzrgutNkICXd9m7uxxAOH7pmOC1ZrwhCcTB+1XKMRFPGzIhiec0AiBT08YoyVhH+deEfYFs+BOGqrg0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(53546011)(6666004)(66476007)(66556008)(66946007)(186003)(66574015)(83380400001)(86362001)(316002)(31696002)(2906002)(4326008)(6486002)(36756003)(8676002)(52116002)(31686004)(2616005)(5660300002)(8936002)(38100700002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNwQmNtODNmcFU5emNDUDd1ZlFCc3gxMXJjeTMvbVhYc0IyckhiVjhpZHZl?=
 =?utf-8?B?MzJyejdoQ0kwUmM1SjZyRElSbDQzbG1CTENzbWxvOGhXaFBlOUp4cXVaM0xT?=
 =?utf-8?B?RStja2dmWmRMR2Q4dnJuZUVlWmdpS09aRy9QaVVsdUE5VDNBV2d6R3p2bjNw?=
 =?utf-8?B?di81WTJ0RDhnSlNBZU41YjlIVkpYd2VzOFhSOHRZYytIK1JzVTZKeGZFNUox?=
 =?utf-8?B?WFd3OUxyK05UY3VFWWRJMUhQbGhNb01sbmlLeWQyN2tqN01EYWsySDQyL2Q4?=
 =?utf-8?B?Y1BML2NtR1RGckNFVm9OMWJwUjdoQ3R1QzVRdThXQ0Q3UHBVdDRZUmt0VWJE?=
 =?utf-8?B?OHkrNUlKTS9oUEVHM1BPVDFuMFJkY1BhdURTOTBVTEJWVnVURk5rcTlBL0ds?=
 =?utf-8?B?dXVxVVYwZXJ5R2NCblJja296RkRMSmxzWTM2MnlLWGRaUmJtRHBQc05BT0tG?=
 =?utf-8?B?WXRPSTcyWTRVQS9NbmdxZStjNFFqZlNmWnc4K0twQm1wWnh5cUhrM0JHOHln?=
 =?utf-8?B?MGRlQnZJa041NlduR1pVMnRjcWh0VFAvTE9iUHVNZER6Smh3cGlBMitkVkZI?=
 =?utf-8?B?OTRGMTFiQU5idFE1N3dDcGFIQ1liUkxRWi9IcmdGZEEzWkZTbHI2dTVkTWkz?=
 =?utf-8?B?aGVISWxhZUZjRmpLck50UzFxMEtSRjZ2KzRCc291RU92ckxNQ3hSdjNpMHpM?=
 =?utf-8?B?Q1FmUmhEbDlhaFlEczVEWXRsdHVqbVlaMlVma3IvVmc2aHExNFNRMWlMK0Rm?=
 =?utf-8?B?bWdaVW4vM0FBbVZWbEdiNXVZaU9RNHdBdEo1VHpLNmhWM3FmUk4wQjV5TFND?=
 =?utf-8?B?dVpYWlR4VW50NUl0eTRHTmFCQjFvRVR2dHFGVHZRdDlGRURxVGZRcVA1VWR5?=
 =?utf-8?B?K2kvS21DT2VCR015Mm1FRWVDeFluZmRqL1NZMk83dFdzUlp0SmEwZ1N0VlVS?=
 =?utf-8?B?cmZkOEdkY3lrekJrd2hjRXQ0M2l5ZkhOMzBRLzVRK2dVTStzckI5RGNKZjR5?=
 =?utf-8?B?eTF6R2VPRmFYZnhjS0JqQksxZHFLanE5QmNxSGJIT0hMR3p2MGZKTUFPUGdp?=
 =?utf-8?B?WEtiSjNETU95SWZCQmtKRS9lN1BSRnVRNUZjN0crRGpwZkV1SlJvQ3luN2tQ?=
 =?utf-8?B?ZEdOblNQRWtiMHNDWDZKS1BnRmdRSU5ldTE4OHNXUlR5SStWeStxcERSalAw?=
 =?utf-8?B?Q1ZKOElFQXJWZFBCZEt5b2FudGU5NkN0TzJpWmpmWWtmUzJna1Ura2RudFkw?=
 =?utf-8?B?RWErWkRzcmJ4MTA0ZkZMMlg4ajN5aWtVdWZjMndBMUFtbG5XNC9BbkpFRjJX?=
 =?utf-8?B?SE4vK3NnemVKVUc4aFlzV2w5UVJBNGNrbk5ITVZxazRGamk5bkZqZkpBODNO?=
 =?utf-8?B?WHR5cDc0NCthc3c2SmFFRXlDSGtwUkxJZnRVVk5rRWZVQnV3WkVSeERWRHFH?=
 =?utf-8?B?azFsMStkd3p6ajRMMUduZGNPc0xsNlc1Vkc4MkI1WXNobEtoUGgzNEh1OU05?=
 =?utf-8?B?NmRZZzJOUWl3NzRJUTZHK1RjQUxzSkVxRDhXbSttT0Vnd0o2K2xwWVdTMTlk?=
 =?utf-8?B?RFQ3aWg5ZXdqbVE4a1E4OTlmVktIV09FaFF1eDhIWVZibGV5L2lVMFp5V3Nx?=
 =?utf-8?B?MVZCdk5BNWtqVEkvMTBLOFZST20zZ0g1QThRNDhyZHBKbGZXME1sU21OWG5v?=
 =?utf-8?B?a0pxK29ya01ROEdxSmJsSW9ZOGhkcTBTYW8xWVdKeWt5VENGbzFTVm9aNE1Z?=
 =?utf-8?B?djI1bjdhY1Y1d1FMSVAyODhJeU1wcHpaNHZ0VE11QzFiam5Za3dqQXJjVW5k?=
 =?utf-8?B?QzFxTlRKRU1tQy9rcXdhRG83OXk5amxzdkkrN3VuL093TjhGRlMwejVTTWZp?=
 =?utf-8?Q?3/UOv7W09iPCt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8a32be-b31d-4551-190f-08d9687f831b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 10:51:52.1204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFoZ7CLOfRgHKSc/nXGSLZnJVW0JBinnJ6jENPP8QWe7+Hc2VdFrXZUBeo3EX/IyXcM10LFQyVeScbRhwhl9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
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


On 8/26/2021 12:48 PM, Christian König wrote:
>
>
> Am 26.08.21 um 12:08 schrieb Nirmoy Das:
>> Currently AMDGPU_RING_PRIO_MAX is redefinition of a
>> max gfx hwip priority, this won't work well when we will
>> have a hwip with different set of priorities than gfx.
>> Also, HW ring priorities are different from ring priorities.
>>
>> Create a global enum for ring priority levels which each
>> HWIP can use to define its own priority levels.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 5 ++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 9 +++++++--
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index d43fe2ed8116..7f747a4291f3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -43,9 +43,8 @@
>>   #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
>>
>>   enum gfx_pipe_priority {
>
> While at it can you add an amdgpu_ prefix before the enum name?
>
> And if the enum isn't really used maybe even replace the enum with 
> defines?


Yes makes sense, I will resend with defines.

>
> Thanks,
> Christian.
>
>> -    AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
>> -    AMDGPU_GFX_PIPE_PRIO_HIGH,
>> -    AMDGPU_GFX_PIPE_PRIO_MAX
>> +    AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
>> +    AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2
>>   };
>>
>>   /* Argument for PPSMC_MSG_GpuChangeState */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index e713d31619fe..88d80eb3fea1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -36,8 +36,13 @@
>>   #define AMDGPU_MAX_VCE_RINGS        3
>>   #define AMDGPU_MAX_UVD_ENC_RINGS    2
>>
>> -#define AMDGPU_RING_PRIO_DEFAULT    1
>> -#define AMDGPU_RING_PRIO_MAX        AMDGPU_GFX_PIPE_PRIO_MAX
>> +enum amdgpu_ring_priority_level {
>> +    AMDGPU_RING_PRIO_0,
>> +    AMDGPU_RING_PRIO_1,
>> +    AMDGPU_RING_PRIO_DEFAULT = 1,
>> +    AMDGPU_RING_PRIO_2,
>> +    AMDGPU_RING_PRIO_MAX
>> +};
>>
>>   /* some special values for the owner field */
>>   #define AMDGPU_FENCE_OWNER_UNDEFINED    ((void *)0ul)
>> -- 
>> 2.32.0
>>
>
