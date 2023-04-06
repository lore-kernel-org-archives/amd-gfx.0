Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4F4C76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 15:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1FE410E34F;
	Thu,  6 Apr 2023 15:06:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D90D10E34F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 15:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE/dL+PwVad2cQvkAXpJAIayLj6vbNLbz7BzyEyuVbwoQ/aCLvIHBV5qQo0yl4IXZB9RhvdP5f3pH2Ro44n2kxY3N07MpFzUVKszd0fcD1/F2xlMjnr515nYe7G3zzP5I96bsc60QH4QaJWy8km+ryPbH6VuD/AvDJDTk7C+vJVBODmhDdaMkY24HYGm5iiFMOZURNqULgmfjC/ImE2Z5AOABeot5bYdzFGcOg/tGcDrevU6gJ+zeVI0Jh0XPlm/ALGbZqGaMBTaxp7evSVIqWNSe8wQLiE/cfHvw9OChvZ14dSzXhMriyf9YqHDw97tTfH0wFMdayM1oJpiWqLatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTMn/YVGncXbKaVS0/sagX3C+jWF8UGvcIZnUPfFZ8I=;
 b=YmRGogCI9fCd6RETzHz6Bi2yVIuUZKIDZIN28qTHU87r0+HcDYBkkpBqEglqmG2EBrHxfENvaLn+jZHP20hcczI+JhTcp+rWOLUeHkYjWnFQpQl25/5FQmR4zl0euw9KeQudTO/iFMYTVR0IIKZoLUiBekSC9jqQx2nVGKx8TucbfBui+JWFgxUzFpQUwtxsK8zjjn+cuiuBXN/5DwULYLP1jfhXkOsGW9QXjyunGw55Ygr+BPoJr9KK+2XTkTYPfU1Ub3EMcjer75zr9c6GllHLP0YWcBpKitzdU/OtVoAB7WOEGpyZcxHcCpiZG94p588fW9Lc5MT2NvaE+RUQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTMn/YVGncXbKaVS0/sagX3C+jWF8UGvcIZnUPfFZ8I=;
 b=GKjYmdiypcF/whSnoq+YfUZMZFYeBhDN67vhMG53+CU0SNtc77HtwmqcnJ4ib6pg09QsOTlc0JHcjsbCVRF0VihYn94WOnt4UvNtyfiTK7er8NgYEnF3NwuqeUKwcCJvv84Pht+RFLXGZUE1n3Zk6+T/PtGdlzAslOSOu8tbZbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Thu, 6 Apr
 2023 15:06:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 15:06:19 +0000
Message-ID: <84094a50-ee27-fe46-b1fc-5739d1c79bdb@amd.com>
Date: Thu, 6 Apr 2023 17:06:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdgpu: Update invalid PTE flag setting
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230404215923.3739152-1-mukul.joshi@amd.com>
 <67923897-fef1-1b6b-75d6-0a33922e0132@amd.com>
 <9a9fb334-50c3-5a6b-8f58-486927c6cf58@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <9a9fb334-50c3-5a6b-8f58-486927c6cf58@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: fc012719-ab2f-43f2-f0d7-08db36b07a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoqA6t+OogwoIH3m2iORTZXP7xkXgSmXmllpNvNBlNr5m7UBvrOoQQLyh59F6AMxJP/W2ezBm6Ih4bWPoyyVgyAMzYIOIn2mRpPXMH3eaun/Arfaa2Pyp8j6R/NYSq1kPIYWKCXFeSLk6iXgTUcPc5mSbEmbYGkjdE3A3fFeCL/LAOx+jACTWwBzLzfSjNtx+gw00djXGp4a2AgbIxggDpmf5oiZwc7LxZUGs9A+9hc1bUPixdihIaeMm8uNf0oqREayxfDE5mHAtXCAoX1EkfNr6sGxJLvdQXec8sJ9vrHBVceqQ4e/e1481gMY+WnZYV6dPhoz1WT3O5XNU0WGRUVn0MLVBRQ2LmBh7UtUW+l4KSFa0VST2XcamVLBCjmIcgqNoN7sJKrpoeYjT0AXcrK6ToTZniYQiPJLTBp2stHs/rO/qfpt06Kc8qQN4nhjGhu8iq9GKwuuoOf/uXSiSWdWRfsdblaSqGuvVOepGbsJ682oHkIr2LcL9ICSvpgb9NbcLTWCSrcSIFSaKaGYnsRi+iAjl/y1WvsEvV3fLwx+A9Ir3Fw9yhajQ6oVWqWd4Okwe9h+n0A5xJUNr1LmtVrkpJu9CqJvIhbB0Pge+V30w8P2nO8QXIYZHToRsqvKYWxMLtZefbnaIiAud8vxMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(6506007)(6486002)(186003)(6512007)(83380400001)(66574015)(6666004)(5660300002)(2616005)(8936002)(8676002)(66476007)(4326008)(478600001)(66556008)(66946007)(41300700001)(15650500001)(110136005)(316002)(36756003)(2906002)(38100700002)(31696002)(31686004)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NSttNkw0R0lCZnNIYkZ6Rzd2ZG1USjlVMHBlMHRvNHgxQkZOOE1nUnUxWjJu?=
 =?utf-8?B?ZU9MejIzOHp5SUxOTmNhbFlxSzU2K1NxaW1WL3A0Q1UycWtWTGtIMEJUSkJH?=
 =?utf-8?B?TzZlRnBaV09uMXJrVnQ1Ukl0cUdTeWtqd2NPVFVDdjRXU0lVT0pQZkRiR2oy?=
 =?utf-8?B?ZDNSeDJvd2dTc1dsTkFyRXZVQjRtalAybTJXUTM0aHgyUS9hV0dzcVRzYVly?=
 =?utf-8?B?anorcUJEZEFGK094UDd4K3laNGg0TzZ0bU9ZYTEyQmV4ZTZ4cThSSzFoeVNz?=
 =?utf-8?B?dEwwdGVyWGlpamdGeDJyeUZpSFJXZ3R5MlZEb3J1M1JHeitydzFzOEl0cGFa?=
 =?utf-8?B?clpGbHJFbjhsRlFjbzE0cGNXaDhJNmxkcTgyVEgwSDV3cnlCOEF5aWE1NVlL?=
 =?utf-8?B?MlBuZ0xnWlNvMnBqa0JQY0pmaWlWYTZyenZocUdTRWFwSkoxVENFOUVLenR4?=
 =?utf-8?B?NlBIVS9NbUJiSkFHUU5vb0FCUno4aXkzUU1QQXVPTk1hRTVtRlhLTHBNNlFl?=
 =?utf-8?B?cldKcDBYNXk5aWdiSHo3OEhrakYxNUFrUmpVMjlwWG9lUENXdERMdlJYaFox?=
 =?utf-8?B?aWR2ZnN5cDQzWlN2UmxnVFV5NkYvb2JWb3dqQmtmRGNONXJMWC94R044NjFj?=
 =?utf-8?B?WWFDN2dkR1pWLzBYMXZZSEhPVVR3TDBYV0gzNjQvV2Ixb2Z0VVArNmpBSk1X?=
 =?utf-8?B?aTNNWVpuU1djcUpGUDZHKzdqUi93SzQ5UE14T0pGdkhvTmU2OTViejFPUVNI?=
 =?utf-8?B?ZlRsbWJ6L0lPYVlqRkpkR1Q2d2RTeENQM1RxUzh3UmN5RkcvK0J2SGNjSE1t?=
 =?utf-8?B?ZkFuUGpLaTQ3bzh0V3FHVk42S01sV2thbmxJckp6aGpwYU9QNDlBV2xQQ2Yz?=
 =?utf-8?B?K2UwbDNYQko1bitGUjZQTlpEd2dSRnVuNHMyRGhTWndqa2tGYzF2bFlqSGpF?=
 =?utf-8?B?eXZETVBDeDV0bmpER2pFZUdTWllHMDBROVMwSEp4NTlWMS9vTlVVRFFpRW1M?=
 =?utf-8?B?RGxxQ2JmazRrNDlvT3lKQ2FBUGhGeCtqeGNRQmpoVEFwTmppb3dhMEJOOHll?=
 =?utf-8?B?L1gzQ003aFVvaFdDeGJRNldpUGhUNFEyWDVtVDcxRVdSUUxNelpJMU5WZ3ls?=
 =?utf-8?B?Ymh6bGxWOWMwdHhvQ2pTZzdSTjliT290dDVKaUpnNFJJcEdCZm1qMnA1WXM3?=
 =?utf-8?B?a0V3TnVOOHFHdDg3UkU4QjFvdFA5cWJVTjcya1RxK25FZTMyUnBIcXFQNFpp?=
 =?utf-8?B?UlQ3TnJRUTZvVDJ3R3pBTnVLM1doRG1OMDhNQ1ZMWGhSWUdrV0JTYlB0cDhm?=
 =?utf-8?B?NTVEMHE0emYwWC9NRGVyNUN3MTVnSTYwV3ZRcGhYb2Y0SUpla0s1MUlITURz?=
 =?utf-8?B?VUx0aVgvMHkwOFpQczI1aElncEIrVFQzL0RZUHZXNzhkRmh3UHowN2VhN0xR?=
 =?utf-8?B?bDJEQktzU1YzTE42WmhTVXBPQy9kR0ErUDg5cFNqR1U3NC9EQlVRaUxMVGhy?=
 =?utf-8?B?L0dydkV0OUZDUnRxVXlsUUpPMDZtN1JaKzRybUptcVJHVUdHNG9aUlpkdG1k?=
 =?utf-8?B?YUdzMjlvK3BYckF6RnlRWDg4T1JhRTI4Slk1OTdmZWxxUUxXQm4yZW1wbUts?=
 =?utf-8?B?OVhvVHp4eUNTOEx4dEJNMXFEdlg2TGVwYWlLcDlBVVc1alVCSm1BTjl0KzY1?=
 =?utf-8?B?ME9lK0QvMC9sQUgyZVIyaVRCWmhvQzVBVU93SUV6OEpsUWw1SWYyYUhDaVdt?=
 =?utf-8?B?SDAwdTdQcndiQmtNa1o1UXU4NUZ6ekRidTI4WHJzUmxMSUNIeTJTY245TFJJ?=
 =?utf-8?B?enVhM1lvK0JCYUowR3BvcTJrR0E3dVNwd0hHQXlyczVxYjdOcFA0V213VmVp?=
 =?utf-8?B?amhPMC94SWQ4bzRoMWhCWjBvNU53eFMvS2w2cDJJelJiSTlkdXgyOWdhSTRL?=
 =?utf-8?B?RFE5d1JLeG1renk5eThVME9YMTR4cjRlbHgyZ3dsTk1YZXVORFRkcWlIT1Nq?=
 =?utf-8?B?OGc5VllWNVFWR0ZvNmExSmVjOTRabGo0ZzQ0WWh6SHlQUlAranlvZ3dmY3Ix?=
 =?utf-8?B?MUxyYXJ2RkFUZ1FBeGdrQkZlRk1KalpiUDdOR2pHdEZRbGYzTEFqY280TUh6?=
 =?utf-8?B?bHh0ekdhSkpzd3NEVXVMK25Sd0V0Ukx6QURoRGcrdThGUkd1aHZ2NFZxTm9i?=
 =?utf-8?Q?+Y1pjt4R+QIR6sH5FkKOX01xvVwMyveWcEbjSmTs+X/0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc012719-ab2f-43f2-f0d7-08db36b07a19
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 15:06:19.5803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5YazR9NONHH/nocVA5Q0rpqmpBDgNz8AWftx1a6v1tJwbEzcBN/eAeUZPkMDxvq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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
Cc: jay.cornwall@amd.com, laurent.morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.04.23 um 17:01 schrieb Felix Kuehling:
> Am 2023-04-06 um 10:36 schrieb Christian König:
>> Am 04.04.23 um 23:59 schrieb Mukul Joshi:
>>> Update the invalid PTE flag setting to ensure, in addition
>>> to transitioning the retry fault to a no-retry fault, it
>>> also causes the wavefront to enter the trap handler. With the
>>> current setting, it only transitions to a no-retry fault.
>>
>> Well that was actually the intended result. Why should it enter the 
>> trap handler here?
>
> We need the trap handler for reporting the fault to the debugger. The 
> VM fault interrupt itself doesn't provide sufficient information to 
> find the wave and the program counter that triggered the fault. It 
> also doesn't work well when several waves are faulting on the same 
> address.

Interesting. But then we still have the problem that VSP set is actually 
a valid combination when this is applied to a non PTB.

So that really doesn't look like a good idea to me.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>>>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index af6f26a97fc5..5df4f7bb241f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2488,7 +2488,7 @@ bool amdgpu_vm_handle_fault(struct 
>>> amdgpu_device *adev, u32 pasid,
>>>           /* Intentionally setting invalid PTE flag
>>>            * combination to force a no-retry-fault
>>>            */
>>> -        flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
>>> +        flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | AMDGPU_PTE_PRT;
>>
>> As far as I can see this is actually a valid combination and would 
>> not have the desired result.
>>
>> Regards,
>> Christian.
>>
>>>           value = 0;
>>>       } else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
>>>           /* Redirect the access to the dummy page */
>>

